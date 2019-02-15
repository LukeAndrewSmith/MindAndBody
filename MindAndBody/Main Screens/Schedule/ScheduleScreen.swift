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


//
// Schedule Class -----------------------------------------------------------------------------------------------------------------------------
//
class ScheduleScreen: UIViewController, UNUserNotificationCenterDelegate {
    
    ///---------------------------------------------------------------------------------
    /// MARK: Outlets
    @IBOutlet weak var navigationBar: UINavigationItem!
    /// TableView
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var scheduleTableBottom: NSLayoutConstraint!
    @IBOutlet weak var pageStack: UIStackView!
    @IBOutlet weak var navigationSeparatorTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var scheduleTableTopConstraint: NSLayoutConstraint!
    ///
    @IBOutlet weak var dayIndicator: UIView!
    @IBOutlet weak var dayIndicatorLeading: NSLayoutConstraint!
    
    @IBOutlet weak var pageStackHeight: NSLayoutConstraint!
    
    ///---------------------------------------------------------------------------------
    /// MARK: Variables

    ///------------------------------------
    /// Week stack (letters at top of screen)
    /// Day arrays
    let dayArray: [String] =
        ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday",]
    let dayArrayChar = ["mondayLetter","tuesdayLetter","wednesdayLetter","thursdayLetter","fridayLetter","saturdayLetter","sundayLetter"]
    /// StackView
    var stackArray: [UILabel] = []
    var stackFontUnselected = UIFont(name: "SFUIDisplay-regular", size: 17)
    var stackFontSelected = UIFont(name: "SFUIDisplay-bold", size: 17)

    ///------------------------------------
    /// Schedule Creation and choices
    /// Schedule creation and choices ACTION SHEET
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
    
    // Variable that is set to current day, if app is opened and current day is different to this variabe then the schedule goes to the current day, if not then stays on whatever day it was on
        // Ensures that upon opening the app for the first time on a day, the schedule presents the current day
    var currentDay = 0
    
    ///------------------------------------
    /// Session variables
    
    /// Passed to finalChoiceChoice
    // 0 == warmup, 1 == session, 2 == stretching
    var selectedComponent = 0
    
    // TODO: ???
    // Important variables selected choices in other class - ScheduleVariables
    
    ///---------------------------------------------------------------------------------
    /// Layout
    
    /// Color
    let foregroundColor = Colors.dark // Used when testing colours, as can easily change

    /// Padding
    let tableSpacing: CGFloat = 27
    let headerSpacing: CGFloat = 0
    
    ///---------------------------------------------------------------------------------
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
    @IBOutlet weak var separatorTop: NSLayoutConstraint!
    @IBOutlet weak var separator: UIView!
    var separatorY: CGFloat {
        /// (Size of schedule screen / 4)
        return headerHeight
    }
    
    ///---------------------------------------------------------------------------------
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
    
    ///---------------------------------------------------------------------------------
    /// MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Observe willEnterForeground
            /// Upon entering foreground, various checks are performed (reset, selected day etc..)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        /// Observe Walkthrough
            /// When subscriptions screen is dismissed, walkthrough can be presented
        NotificationCenter.default.addObserver(self, selector: #selector(beginWalkthrough), name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
        
        /// Subscriptions
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

        /// Ensure week goal correct
        Tracking.shared.updateWeekGoal()
        
        // Setup
        ScheduleManager.shared.setScheduleStyle()
        // If week view, crete temporary week array
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.week.rawValue {
            ScheduleManager.shared.createTemporaryWeekViewArray()
        }
        setupViews()
        layoutViews()
        reloadView()
        
        // Register for receiving did enter foreground notifications
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        willAppear()
    }
    
    @objc func willEnterForeground() {
        willAppear()
    }
    
    func willAppear() {
        
        // Check if reset necessary
        ScheduleManager.shared.resetScheduleTracking()

        // Check if necessary to go to current day
        checkSelectedDay()
        
        // Ensure dayIndicator in correct position / not visible && if week view, update temporary full week array
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            self.view.layoutIfNeeded()
            // Week view
        } else {
            dayIndicator.alpha = 0
            ScheduleManager.shared.createTemporaryWeekViewArray()
        }
        
        // Reload the view if requested by previous view
        reloadView()
        
        scheduleTableScrollCheck()
        
        // Check if alert reminding to update profile (Once a month) should be presented
        UpdateProfile.shared.checkUpdateProfile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadCompletedRow()
        // Reset session choice indicators
        ScheduleManager.shared.resetChoice()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Hide navigation bar
        if goingToSessionChoice {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            goingToSessionChoice = false
        }
    }

    // MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        //
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            pageStack.layoutSubviews()
            dayIndicatorLeading.constant = self.stackArray[ScheduleManager.shared.selectedDay].frame.minX
        }
        //
        // Schedule Tableview top view (set here so it's layed out correctly)
        let topView = UIVisualEffectView()
        let topViewE = UIBlurEffect(style: .dark)
        topView.effect = topViewE
        topView.isUserInteractionEnabled = false
        //
        topView.frame = CGRect(x: 0, y: scheduleTable.frame.minY - scheduleTable.bounds.height, width: scheduleTable.bounds.width, height: scheduleTable.bounds.height)
        //
        scheduleTableScrollCheck()
    }
    
    // Begin walkthrough
    @objc func beginWalkthrough() {
        // If walkthrough hasn't already been called
        if walkthroughProgress == 0 {
            // Register for notifications
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                // Enable or disable features based on authorization.
            }
            // Present schedule walkthrough
            let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
            if walkthroughs["Schedule"] == false {
                self.walkthroughSchedule()
            }
        }
    }
    
    //
    // Schedule Selection (Bar Button Item (Top Right))
    // Edit Schedule
    @objc func editScheduleAction() {
        
        // There is a schedule to edit
        if ScheduleManager.shared.schedules.count > 0 {
            self.performSegue(withIdentifier: "EditScheduleSegue", sender: self)
            ActionSheet.shared.animateActionSheetDown()
        // There is no schedule to edit - popup indicating so
        } else {
            ActionSheet.shared.actionSheet.alpha = 0
            ActionSheet.shared.actionSheetBackgroundView.alpha = 0
            ActionSheet.shared.actionSheetBackgroundView.isEnabled = false
            //
            // Alert View
            let title = NSLocalizedString("scheduleEditTitle", comment: "")
            let message = NSLocalizedString("scheduleEditMessage", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = Colors.dark
            alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
            
            //
            // Action
            let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
                ActionSheet.shared.actionSheet.alpha = 1
                ActionSheet.shared.actionSheetBackgroundView.alpha = 1
                ActionSheet.shared.actionSheetBackgroundView.isEnabled = true
            }
            //
            alert.addAction(okAction)
            //
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            //self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func createScheduleAction()  {
        // Dismiss action sheet
        ActionSheet.shared.animateActionSheetDown()
        //
        self.performSegue(withIdentifier: "ScheduleCreationSegue", sender: self)
    }
    
    // Schedule Button (Bar button item)
    @IBAction func scheduleButton(_ sender: Any) {
        // Local
        let actionSheet = UIView()
        //
        let height = scheduleChoiceTable.bounds.height + createScheduleButton.bounds.height
            //+ 10
        actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionWidth, height: height)
        actionSheet.layer.cornerRadius = createScheduleButton.bounds.height / 2
        actionSheet.addSubview(scheduleView)
        //
        ActionSheet.shared.setupActionSheet()
        ActionSheet.shared.actionSheet.addSubview(actionSheet)
        let heightToAdd = height
        ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
        ActionSheet.shared.resetCancelFrame()
        // Cancel button is a done button for this case
        ActionSheet.shared.cancelButton.setTitleColor(Colors.green, for: .normal)
        ActionSheet.shared.cancelButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
        //
        ActionSheet.shared.animateActionSheetUp()
        //
    }
    
    //
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       //
        switch segue.identifier {
            
        case "EditScheduleSegue":
            ScheduleManager.shared.shouldReloadSchedule = true
            
        // Create Schedule
        case "ScheduleCreationSegue":
            ScheduleManager.shared.didCreateNewSchedule = false
            ScheduleManager.shared.shouldReloadSchedule = true
            let destinationNC = segue.destination as? ScheduleTypeQuestionNavigation
            let destinationVC = destinationNC?.viewControllers.first as? ScheduleTypeQuestion
            destinationVC?.comingFromSchedule = true
            
        case "SubscriptionsSegue":
            break
            
        case "SessionChoiceSegue":
            // Hide shadow otherwise animation is strange
            self.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor

            
        default:
            let backItem = UIBarButtonItem()
            backItem.title = ""
            backItem.tintColor = Colors.light
            navigationItem.backBarButtonItem = backItem
        }
    }
}

//
class ScheduleNavigation: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
