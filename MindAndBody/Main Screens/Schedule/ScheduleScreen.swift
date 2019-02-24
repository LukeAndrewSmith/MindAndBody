//
//  CalendarScreen.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 27.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class ScheduleScreen: UIViewController, UNUserNotificationCenterDelegate {
    
    ///---------------------------------------------------------------------------------
    /// MARK: Outlets
    @IBOutlet weak var navigationBar: UINavigationItem!
    /// TableView
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var scheduleTableBottom: NSLayoutConstraint!
    /// TableView header separator
    @IBOutlet weak var separatorTop: NSLayoutConstraint!
    @IBOutlet weak var separator: UIView! // TODO: RENAME to headerSeparator
    /// Constraints
    @IBOutlet weak var navigationSeparatorTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var scheduleTableTopConstraint: NSLayoutConstraint!
    /// Week stack (at top of screen)
    @IBOutlet weak var pageStack: UIStackView!
    @IBOutlet weak var pageStackHeight: NSLayoutConstraint!
    @IBOutlet weak var dayIndicator: UIView!
    @IBOutlet weak var dayIndicatorLeading: NSLayoutConstraint!
    
    ///---------------------------------------------------------------------------------
    /// MARK: Variables etc...
    
    ///------------------------------------
    /// Week stack (letters at top of screen)
    /// Day arrays
    let dayArray: [String] =
        ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday",]
    let dayArrayChar = ["mondayLetter","tuesdayLetter","wednesdayLetter","thursdayLetter","fridayLetter","saturdayLetter","sundayLetter"]
    /// StackView
    var stackArray: [UILabel] = [] // TODO: Rename to weekStackArray
    var stackFontUnselected = UIFont(name: "SFUIDisplay-regular", size: 17)
    var stackFontSelected = UIFont(name: "SFUIDisplay-bold", size: 17)

    ///------------------------------------
    /// Schedule Creation and choices
        /// Action sheet elements
    let scheduleChoiceTable = UITableView()
    let scheduleView = UIView()
    let createScheduleButton = UIButton()

    ///------------------------------------
    /// Session choice explanation
    var explanationView = UIView()
    var explanationHighlight = UIView()
    var explanationLabel = UILabel()
    var nextButtonExplanation = UIButton()
    
    ///------------------------------------
    /// Watcher variables
    
    /// Indicates if next screen is a session choice
        /// If so - hide navigation bar
    var goingToSessionChoice = false
    
    ///------------------------------------
    /// Session variables
    
    /// Passed to finalChoiceChoice
    // 0 == warmup, 1 == session, 2 == stretching
    var selectedComponent = 0
    
    // TODO: ???
    // Important variables selected choices in other class - ScheduleVariables
    
    ///------------------------------------
    /// Layout
    
    /// Color
    let foregroundColor = Colors.dark // Used when testing colours, as can easily change

    /// Padding
    let tableSpacing: CGFloat = 27
    let headerSpacing: CGFloat = 0
    
    ///------------------------------------
    /// TableView
    
    /// Cell heights
        /// Set by heightForRow
            /// cellForRow uses cell heights cell.height isn't updated yet so need these variables so that cellForRow can access the actual heights
            /// Could move cellForRow code to cell.didlayoutsubviews but prefer not
    var presetCellHeight: CGFloat = 88
    var cellHeight: CGFloat = 88
    
    let headerLabel = UILabel()
    var headerHeight: CGFloat { /// 1/4 of the table
        return (UIScreen.main.bounds.height - ElementHeights.combinedHeight - ElementHeights.tabBarHeight - pageStackHeight.constant - ElementHeights.bottomSafeAreaInset) / 4
    }
    
    /// Day navigation
    var daySwipeLeft = UISwipeGestureRecognizer()
    var daySwipeRight = UISwipeGestureRecognizer()
    
    /// Header separator
    var separatorY: CGFloat {
        /// (Size of schedule screen / 4)
        return headerHeight
    }
    
    ///------------------------------------
    /// Walkthrough
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabelView = UIView()
    var walkthroughLabelTitle = UILabel()
    var walkthroughLabelSeparator = UIView()
    var walkthroughLabel = UILabel()
    var walkthroughNextButton = UIButton()
    var walkthroughBackButton = UIButton()
    var didSetWalkthrough = false
    /// Components
    var walkthroughTexts = ["schedule0", "schedule1", "schedule2", "schedule3", "schedule4", "schedule5", "schedule6"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    /// Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    ///
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    ///------------------------------------
    /// MARK: Testing
    var subscriptionButton = UIButton()
    @objc func subs() {
        self.performSegue(withIdentifier: "SubscriptionSegue", sender: Any?)
    }
    
    ///---------------------------------------------------------------------------------
    /// MARK: View lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///------------------------------------
        /// MARK: Testing
        subscriptionButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        subscriptionButton.titleLabel?.text = "Subscriptions"
        subscriptionButton.addTarget(self, action: #selector(subs), for: .touchUpInside)
        view.addSubview(subscriptionButton)
        
        /// Observe willEnterForeground
            /// Upon entering foreground, various checks are performed (reset, selected day etc..)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        /// Observe Walkthrough
            /// When subscriptions screen is dismissed, walkthrough can be presented
        NotificationCenter.default.addObserver(self, selector: #selector(beginWalkthrough), name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
        
        /// Subscriptions Check
            /// Checking for valid subscription --> present loading during check
            /// Check initiated in app delegate
        if Loading.shared.shouldPresentLoading {
            Loading.shared.beginLoading(type: 0)
            /// Let user in whatever if the loading is taking too long
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 30, execute: {
                if Loading.shared.isLoading {
                    print("Loading too long")
                    Loading.shared.endLoading()
                }
            })
        }
        
        /// Observe checkSubscription outcome
            /// End Loading
            /// Present Subscription Screen (no valid sub)
        NotificationCenter.default.addObserver(self, selector: #selector(subscriptionCheckCompleted), name: SubscriptionNotifiations.didCheckSubscription, object: nil)

        // TODO: ??? not sure it's necessary
        /// Ensure week goal correct
        Tracking.shared.updateWeekGoal()
        
        /// Setup
        ScheduleManager.shared.setScheduleStyle()
        setupView() /// Setups up tables, actions sheets, navigation bar etc...
        layoutViews() /// Lays out the week stack
        reloadView() /// Ensure schedule table presenting the correct information
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// Ensure the navigation controller is visible
            /// Not visible in session choice
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        /// To do whenever view appears - checks etc...
        willAppear()
    }
    
    @objc func willEnterForeground() {
        willAppear()
    }
    
    func willAppear() {
        
        /// Check if reset necessary
        ScheduleManager.shared.resetScheduleTracking()

        /// Check if necessary to go to current day
        checkSelectedDay()
        
        /// Ensure dayIndicator in correct position / not visible && if week view, update temporary full week array
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            self.view.layoutIfNeeded()
        } else {
            dayIndicator.alpha = 0
            ScheduleManager.shared.createTemporaryWeekViewArray()
        }
        
        /// Reload the view if requested by previous view
        reloadView()
        
        /// Check if scrolling should be enabled
        scheduleTableScrollCheck()
        
        /// Check if alert reminding to update profile (Once a month) should be presented
        UpdateProfile.shared.checkUpdateProfile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// Reloads row if necessary marking as completed
        reloadCompletedRow()
        
        /// Reset session choice indicators && extra session completion
        ScheduleManager.shared.resetChoice()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /// Hide navigation bar
        if goingToSessionChoice {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            goingToSessionChoice = false
        }
    }

    override func viewDidLayoutSubviews() {
        
        /// Ensure that the week stack day indicator is in the correct position
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            pageStack.layoutSubviews()
            dayIndicatorLeading.constant = self.stackArray[ScheduleManager.shared.selectedDay].frame.minX
        }
        
        /// Check if scrolling should be enabled
            /// This is the case if the are more sessions planned than can be displayed on the screen
        scheduleTableScrollCheck()
    }
    
    
    ///---------------------------------------------------------------------------------
    /// MARK: Main functions
    
    ///------------------
    /// Begin walkthrough
    @objc func beginWalkthrough() {
        /// If walkthrough hasn't already been called
        if walkthroughProgress == 0 {
            /// Request notification authorization
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in }
            /// Present schedule walkthrough
            let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
            if walkthroughs["Schedule"] == false {
                self.walkthroughSchedule()
            }
        }
    }
    
    ///------------------------------------
    /// Schedule Selection functions (Bar Button Item (Top Right))
    ///------------------
    /// Schedule Button (Bar button item)
        /// Present schedule choice action sheet
    @IBAction func scheduleButton(_ sender: Any) {

        /// Setup
        ActionSheet.shared.setupActionSheet()
        ActionSheet.shared.actionSheet.addSubview(scheduleView)
        ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + scheduleView.bounds.height)
        ActionSheet.shared.resetCancelFrame()
        /// Cancel button is a done button for this case
        ActionSheet.shared.cancelButton.setTitleColor(Colors.green, for: .normal)
        ActionSheet.shared.cancelButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)

        /// Present
        ActionSheet.shared.animateActionSheetUp()
    }
    ///------------------
    /// Edit
    @objc func editScheduleAction() {
        ActionSheet.shared.animateActionSheetDown()
        self.performSegue(withIdentifier: "EditScheduleSegue", sender: self)
    }
    ///------------------
    /// Create
    @objc func createScheduleAction()  {
        ActionSheet.shared.animateActionSheetDown()
        self.performSegue(withIdentifier: "ScheduleCreationSegue", sender: self)
    }
    
    
    ///---------------------------------------------------------------------------------
    /// MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
            
        case "EditScheduleSegue":
            /// Reloads the schedule when returning in case changes made
            ScheduleManager.shared.shouldReloadSchedule = true
            
        case "ScheduleCreationSegue":
            ScheduleManager.shared.didCreateNewSchedule = false
            ScheduleManager.shared.shouldReloadSchedule = true
            /// Indicate source
            let destinationNC = segue.destination as? ScheduleTypeQuestionNavigation
            let destinationVC = destinationNC?.viewControllers.first as? ScheduleTypeQuestion
            destinationVC?.comingFromSchedule = true
            
        case "SubscriptionsSegue":
            break
            
        case "SessionChoiceSegue":
            /// Hide shadow otherwise animation is strange
            self.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
            
        default:
            let backItem = UIBarButtonItem()
            backItem.title = ""
            backItem.tintColor = Colors.light
            navigationItem.backBarButtonItem = backItem
        }
    }
}

///---------------------------------------------------------------------------------
/// MARK:- Schedule navigation
class ScheduleNavigation: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
