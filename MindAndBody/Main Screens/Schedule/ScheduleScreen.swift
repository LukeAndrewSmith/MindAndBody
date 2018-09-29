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
    
    static var shared = ScheduleScreen()
    
    
    // Currently testing which values are best
    let foregroundColor = Colors.dark
    let tableSpacing: CGFloat = 27
    let headerSpacing: CGFloat = 0 // 16
    
    // Set by heightForRow, as cellForRow uses height but height isn't updated yet
    // Could move all code to cell.didlayoutsubviews but prefer not to
    var presetCellHeight: CGFloat = 88
    var cellHeight: CGFloat = 72
    
    
    
    // MARK: - Variables/Outlets
    // Schedule Animation Helpers
    let mask = CAGradientLayer()
    let maskView1 = UIButton() // top
    let maskView2 = UIButton() // bottom
    let maskView3 = UIView() // Middle (rounded corners
    let maskViewBackButton = UIImageView()
    let maskViewBackToBeginningButton = UIButton()
    
    // TableView
    let headerLabel = UILabel()
    var headerHeight: CGFloat {
        return (UIScreen.main.bounds.height - ControlBarHeights.combinedHeight - ControlBarHeights.tabBarHeight - pageStackHeight.constant) / 4
    }
//    var headerHeight: CGFloat {
//        return 88 * 1.5
//    }
    var daySwipeLeft = UISwipeGestureRecognizer()
    var daySwipeRight = UISwipeGestureRecognizer()
    let separator = UIView()
    var separatorY: CGFloat {
        // (Size of schedule screen / 4) + height of pageStack
        return pageStackHeight.constant + headerHeight
    }
    //
    var okAction = UIAlertAction()
 
    // Important variables selected choices in other class - ScheduleVariables
        
    //
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // TableView
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var scheduleTableBottom: NSLayoutConstraint!
    @IBOutlet weak var pageStack: UIStackView!
    @IBOutlet weak var navigationSeparatorTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var scheduleTableTopConstraint: NSLayoutConstraint!
    //
    @IBOutlet weak var dayIndicator: UIView!
    @IBOutlet weak var dayIndicatorLeading: NSLayoutConstraint!
    
    @IBOutlet weak var pageStackHeight: NSLayoutConstraint!
    
    // Variables
    // Days array
    let dayArray: [String] =
        ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday",]
    let dayArrayChar = ["mondayLetter","tuesdayLetter","wednesdayLetter","thursdayLetter","fridayLetter","saturdayLetter","sundayLetter"]
    // StackView
    var stackArray: [UILabel] = []
    var stackFontUnselected = UIFont(name: "SFUIDisplay-regular", size: 17)
    var stackFontSelected = UIFont(name: "SFUIDisplay-bold", size: 17)

    // Schedule creation and choices ACTION SHEET
    let scheduleChoiceTable = UITableView()
    let scheduleView = UIView()
    let createScheduleButton = UIButton()
    
    // Should watch for walkthrough when coming back
    var goingToSubscriptionsScreen = false
    
    var goingToSessionChoice = false
    
    // Passed to finalChoiceChoice
        // 0 == warmup, 1 == session, 2 == stretching
    var selectedComponent = 0

    // Session choice explanation
    var explanationView = UIView()
    var explanationHighlight = UIView()
    var explanationLabel = UILabel()
    var nextButtonExplanation = UIButton()
    
    // Variable that is set to current day, if app is opened and current day is different to this variabe then the schedule goes to the current day, if not then stays on whatever day it was on
        // Ensures that upon opening the app for the first time on a day, the schedule presents the current day
    var currentDay = 0
    
    //
    // Walkthrough
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
    //
    // Components
    var walkthroughTexts = ["schedule0", "schedule1", "schedule2", "schedule3", "schedule4", "schedule5", "schedule6"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()

    
    // -----------------------------------------------------------------------------------------------
    
    //
    // MARK: - Functions
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
        ScheduleVariables.shared.resetScheduleTracking()

        // Check if necessary to go to current day
        checkSelectedDay()
        
        // Ensure dayIndicator in correct position / not visible && if week view, update temporary full week array
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            self.view.layoutIfNeeded()
            // Week view
        } else {
            dayIndicator.alpha = 0
            ScheduleVariables.shared.createTemporaryWeekViewArray()
        }
        
        // Reload the view if requested by previous view
        reloadView()
        
        scheduleTableScrollCheck()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadCompletedRow()
    }
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set observer for UIApplicationWillEnterForeground
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
        
        // Walkthrough (for after subscriptions, normal handled by subscriptionCheckComplete)
        NotificationCenter.default.addObserver(self, selector: #selector(beginWalkthrough), name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
        
        // Subscriptions
        // Checking subscription is valid, (present loading during check)
        if Loading.shared.shouldPresentLoading {
            // Subscription Check 2
//            Loading.shared.beginLoading()
        }
        // Check subscription -> Present Subscription Screen (if not valid)
        NotificationCenter.default.addObserver(self, selector: #selector(subscriptionCheckCompleted), name: SubscriptionNotifiations.didCheckSubscription, object: nil)
        
        // Ensure week goal correct
        Tracking.shared.updateWeekGoal()
        
        // Setup
        ScheduleVariables.shared.setScheduleStyle()
        // If week view, crete temporary week array
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.week.rawValue {
            ScheduleVariables.shared.createTemporaryWeekViewArray()
        }
        setupViews()
        layoutViews()
        reloadView()
        
        // Register for receiving did enter foreground notifications
        // check selected day
        NotificationCenter.default.addObserver(self, selector: #selector(checkSelectedDay), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        // reload view
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Hide navigation bar
        if goingToSessionChoice {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            goingToSessionChoice = false
        }
        //
        NotificationCenter.default.removeObserver(self)
        if goingToSubscriptionsScreen {
            NotificationCenter.default.addObserver(self, selector: #selector(beginWalkthrough), name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
        }
    }

    // MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        //
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            pageStack.layoutSubviews()
            dayIndicatorLeading.constant = self.stackArray[ScheduleVariables.shared.selectedDay].frame.minX
        }
        //
        // Schedule Tableview top view (set here so it's layed out correctly)
        let topView = UIVisualEffectView()
        let topViewE = UIBlurEffect(style: .dark)
        topView.effect = topViewE
        topView.isUserInteractionEnabled = false
        //
        topView.frame = CGRect(x: 0, y: scheduleTable.frame.minY - scheduleTable.bounds.height, width: scheduleTable.bounds.width, height: scheduleTable.bounds.height)
    }
    
    // Begin walkthrough
    @objc func beginWalkthrough() {
        // Valid subscription and walkthrough hasn't already been called
        if SubscriptionsCheck.shared.isValid && walkthroughProgress == 0 {
            // Register for notifications
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                // Enable or disable features based on authorization.
            }
            //
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
        if ScheduleVariables.shared.schedules.count > 0 {
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
            alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
            
            //
            // Action
            let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertActionStyle.default) {
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
            ScheduleVariables.shared.shouldReloadSchedule = true
            
        // Create Schedule
        case "ScheduleCreationSegue":
            ScheduleVariables.shared.didCreateNewSchedule = false
            ScheduleVariables.shared.shouldReloadSchedule = true
            let destinationNC = segue.destination as? ScheduleTypeQuestionNavigation
            let destinationVC = destinationNC?.viewControllers.first as? ScheduleTypeQuestion
            destinationVC?.comingFromSchedule = true
            
        case "SubscriptionsSegue":
            goingToSubscriptionsScreen = true
            
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
