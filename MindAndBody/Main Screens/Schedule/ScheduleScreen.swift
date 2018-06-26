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

    
    // MARK: - Variables/Outlets
    // Schedule Animation Helpers
    let mask = CAGradientLayer()
    let maskView1 = UIButton() // top
    let maskView2 = UIButton() // bottom
    let maskView3 = UIView() // Middle (rounded corners
    let maskViewBackButton = UIImageView()
    let maskViewBackToBeginningButton = UIButton()
    
    // TableView
    var daySwipeLeft = UISwipeGestureRecognizer()
    var daySwipeRight = UISwipeGestureRecognizer()
    let separator = UIView()
    var separatorY: CGFloat {
        return ((UIScreen.main.bounds.height - CGFloat(TopBarHeights.combinedHeight) - 24.5) / 4) - 1
    }
    let headerLabel = UILabel()
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
    //
    @IBOutlet weak var dayIndicator: UIView!
    @IBOutlet weak var dayIndicatorLeading: NSLayoutConstraint!
    
    // Slide menu interactor
    let interactor = Interactor()
    
    // Variables
    // Days array
    let dayArray: [String] =
        ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday",]
    let dayArrayChar = ["mondayLetter","tuesdayLetter","wednesdayLetter","thursdayLetter","fridayLetter","saturdayLetter","sundayLetter"]
    // StackView
    var stackArray: [UILabel] = []
    var stackFontUnselected = UIFont(name: "SFUIDisplay-thin", size: 17)
    var stackFontSelected = UIFont(name: "SFUIDisplay-medium", size: 17)

    // Schedule creation and choices ACTION SHEET
    let scheduleChoiceTable = UITableView()
    let scheduleView = UIView()
    let createScheduleButton = UIButton()
    let editScheduleButton = UIButton()
    let editProfileButton = UIButton()

    //
    // Very silly variable used in choices of 'endurance' group - steady state, as there is a 'time choice' after 'warmup/stretching' choice, variable indicating which one was selected
        // 'warmup/stretching' choice usually last choice
    var steadyStateChoice = Int()
    
    // IMPORTANT VARIABLE
    // Variable saying which presentation style is wanted by the user, either
    // 0 - presenting each day on the day
    // 1 - presenting the whole week at once
    var scheduleStyle = Int()
    
    // Should watch for walkthrough when coming back
    var goingToSubscriptionsScreen = false

    //
    // Walkthrough
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabel = UILabel()
    var nextButton = UIButton()
    var didSetWalkthrough = false
    //
    // Components
    var walkthroughTexts = ["schedule0", "schedule1", "schedule2", "schedule3", "schedule4", "schedule5", "schedule6", "schedule7", "schedule8", "schedule9"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    //
    var lessonsView = UIView()
    var lessonsBackground = UIButton()
    var isLessonsShowing = false // indicates if lessons view is presented
    
    
    // -----------------------------------------------------------------------------------------------
    
    //
    // MARK: - Functions
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload to be sure
        setScheduleStyle()
        //
        // Check if necessary to go to current day
        checkSelectedDay()
        //
        // Ensure dayIndicator in correct position / not visible && if week view, update temporary full week array
        if scheduleStyle == 0 {
            self.view.layoutIfNeeded()
        // Week view
        } else {
            dayIndicator.alpha = 0
            TemporaryWeekArray.shared.createTemporaryWeekViewArray()
        }
        // Reload the view if requested by previous view
        reloadView()
    }
    
    
    //
    // MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // If coming back to schedule from having done a session, mark session as completed and, if the entire group has been completed, animate from final choice back to main schedule screen
            // At end of session, updateScheduleTracking() gets called, this updates the final choice (session) tracking, then indicates the scheduleShouldReload
            // This function that means the function does something, it reloads the relevant rows and animated back to the home schedule screen if necessary
        markAsCompletedAndAnimate()
        
        // Walkthrough for note on long press to mark group/session as complete, the function check if there is a session on the screen and if so presents a quick note explaining the long press
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["Schedule"] == true && walkthroughs["LongPressScheduleNote"] == false {
            self.walkthroughScheduleLongPressNote()
        }
    }
    
    //
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough (for after subscriptions, normal handled by subscriptionCheckComplete)
        NotificationCenter.default.addObserver(self, selector: #selector(beginWalkthrough), name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
        
        // Check if reset necessary
        ScheduleVariables.shared.resetWeekTracking()
        
        // Subscriptions
        // Checking subscription is valid, (present loading during check)
        if Loading.shared.shouldPresentLoading {
            // Subscription Check 2
            Loading.shared.beginLoading()
        }
        // Check subscription -> Present Subscription Screen (if not valid)
        NotificationCenter.default.addObserver(self, selector: #selector(subscriptionCheckCompleted), name: SubscriptionNotifiations.didCheckSubscription, object: nil)
        
        // Ensure week goal correct
        updateWeekGoal()
        
        // Setup
        setScheduleStyle()
        // If week view, crete temporary week array
        if scheduleStyle == 1 {
            TemporaryWeekArray.shared.createTemporaryWeekViewArray()
        }
        setupViews()
        layoutViews()
        reloadView()
        
        // Register for receiving did enter foreground notifications
        // check selected day
        NotificationCenter.default.addObserver(self, selector: #selector(checkSelectedDay), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        // reload view
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        //
        // Long press for cheating groups; ability to mark session as complete
        let markAsCompletedGesture = UILongPressGestureRecognizer()
        markAsCompletedGesture.addTarget(self, action: #selector(markAsCompleted))
        scheduleTable.addGestureRecognizer(markAsCompletedGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        NotificationCenter.default.removeObserver(self)
        if goingToSubscriptionsScreen {
            NotificationCenter.default.addObserver(self, selector: #selector(beginWalkthrough), name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
        }
    }

    // MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        //
        if scheduleStyle == 0 {
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
        //
        scheduleTable.addSubview(topView)
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

    // TableView in seperate file
    
    //
    // Schedule Selection (Bar Button Item (Top Right))
    // Edit Schedule
    @objc func editScheduleAction() {
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // There is a schedule to edit
        if schedules.count != 0 {
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
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
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
    
    // Edit Profile
    @objc func editProfileAction() {
        //
        ActionSheet.shared.animateActionSheetDown()
        //
        // AND indicate to profile segue that coming from schedule so that the 'skip to goals section' button can be presented
        self.performSegue(withIdentifier: "EditProfileSegue", sender: self)
        
    }
    
    // Schedule Button (Bar button item)
    @IBAction func scheduleButton(_ sender: Any) {
        // Local
        let actionSheet = UIView()
        //
        let height = scheduleChoiceTable.bounds.height + createScheduleButton.bounds.height + editScheduleButton.bounds.height + 10 + editProfileButton.bounds.height
            //+ 10
        actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionWidth, height: height)
        actionSheet.layer.cornerRadius = editScheduleButton.bounds.height / 2
        actionSheet.addSubview(scheduleView)
        actionSheet.addSubview(editProfileButton)

        //
        ActionSheet.shared.setupActionSheet()
        ActionSheet.shared.actionSheet.addSubview(actionSheet)
        let heightToAdd = height
        ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
        ActionSheet.shared.resetCancelFrame()
        //
        ActionSheet.shared.animateActionSheetUp()
    }
    
    //
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "openMenu" {
            // Remove Mask View
            if let destinationViewController = segue.destination as? SlideMenuView {
                destinationViewController.transitioningDelegate = self
            }
            // Handle changing colour of status bar if button pressed
            if MenuVariables.shared.menuInteractionType == 0 {
                UIApplication.shared.statusBarStyle = .default
            }
        //
        } else if segue.identifier == "scheduleSegueOverview" {
            let destinationVC = segue.destination as? FinalChoice
            // Only say from schedule if app chooses sessions for the user
            destinationVC?.comingFromSchedule = true
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        //
        } else if segue.identifier == "EditProfileSegue" {
            let destinationVC = segue.destination as! Profile
            destinationVC.comingFromSchedule = true
        //
        } else if segue.identifier == "EditScheduleSegue" {
            ScheduleVariables.shared.shouldReloadSchedule = true
        //
        } else if segue.identifier == "scheduleMeditationSegueTimer" {
            let destinationVC = segue.destination as? MeditationTimer
            destinationVC?.comingFromSchedule = true
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        //
        } else if segue.identifier == "scheduleMeditationSegueGuided" {
            let destinationVC = segue.destination as? MeditationChoiceGuided
            destinationVC?.comingFromSchedule = true
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        // Create Schedule
        } else if segue.identifier == "ScheduleCreationSegue" {
            ScheduleVariables.shared.didCreateNewSchedule = false
            ScheduleVariables.shared.shouldReloadSchedule = true
            let destinationNC = segue.destination as? ScheduleTypeQuestionNavigation
            let destinationVC = destinationNC?.viewControllers.first as? ScheduleTypeQuestion
            destinationVC?.comingFromSchedule = true
        } else if segue.identifier == "SubscriptionsSegue" {
            goingToSubscriptionsScreen = true
        }
    }
    
    // Slide menu
    @IBAction func slideMenuButtonAction(_ sender: Any) {
        MenuVariables.shared.menuInteractionType = 0
    }
    
}

//
// Slide Menu Extension
extension ScheduleScreen: UIViewControllerTransitioningDelegate {
    
    // Interactive pan
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    //
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    // Button
    // Present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    // Dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
}

//
class ScheduleNavigation: UINavigationController {
}