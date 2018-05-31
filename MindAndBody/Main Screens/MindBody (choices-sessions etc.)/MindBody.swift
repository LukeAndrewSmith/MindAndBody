//
//  MindBody.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics


//
// Mind & Body Class ------------------------------------------------------------------------------------------------------------------------
//
class MindBody: UIViewController {
    
    //
    // Outlets ----------------------------------------------------------------------------------------------------------------------------------
    //
    // Navigation bar outlets
    //
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // Tracking
    @IBOutlet weak var slideMenu: UIBarButtonItem!
    
    
    // Button Outlets
    //
    // Warmup
    @IBOutlet weak var Warmup: UIButton!
    // Workout
    @IBOutlet weak var Workout: UIButton!
    // Stretching
    @IBOutlet weak var Stretching: UIButton!
    // Cardio
    @IBOutlet weak var Cardio: UIButton!
    // Yoga
    @IBOutlet weak var Yoga: UIButton!
    // Mindfullness
    @IBOutlet weak var Meditation: UIButton!
    
    // Constraints
    
    // Mind & Body section titles
    // Mind
    @IBOutlet weak var body: UILabel!
    // Body
    @IBOutlet weak var mind: UILabel!
    
    // Constraints
    @IBOutlet weak var bodyTop: NSLayoutConstraint!
    @IBOutlet weak var bodyBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var wamupBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var mindTop: NSLayoutConstraint!
    @IBOutlet weak var mindBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var yogaBottom: NSLayoutConstraint!
    @IBOutlet weak var meditationBottom: NSLayoutConstraint!
    
    //
    @IBOutlet weak var warmupLeft: NSLayoutConstraint!
    @IBOutlet weak var workoutLeft: NSLayoutConstraint!
    @IBOutlet weak var workoutRight: NSLayoutConstraint!
    @IBOutlet weak var cardioLeft: NSLayoutConstraint!
    @IBOutlet weak var stretchingRight: NSLayoutConstraint!
    @IBOutlet weak var yogaLeft: NSLayoutConstraint!
    @IBOutlet weak var yogaRight: NSLayoutConstraint!
    @IBOutlet weak var meditationLeft: NSLayoutConstraint!
    @IBOutlet weak var meditationRight: NSLayoutConstraint!
    // Separators
    @IBOutlet weak var topLeft: NSLayoutConstraint!
    @IBOutlet weak var topRight: NSLayoutConstraint!
    @IBOutlet weak var bottomLeft: NSLayoutConstraint!
    @IBOutlet weak var bottomRight: NSLayoutConstraint!
    
    
    
    // Blurs
    let blur0 = UIVisualEffectView()
    let blur1 = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur3 = UIVisualEffectView()
    let blur4 = UIVisualEffectView()
    let blur5 = UIVisualEffectView()
    let blur6 = UIVisualEffectView()
    let blur7 = UIVisualEffectView()
    
    //
    // View Will Appear ---------------------------------------------------------------------------------------------------------------------
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Checking subscription, present loading
        if Loading.shared.shouldPresentLoading {
//            Loading.shared.beginLoading()
        }
        
        //
        blur0.removeFromSuperview()
        blur1.removeFromSuperview()
        blur2.removeFromSuperview()
        blur3.removeFromSuperview()
        blur4.removeFromSuperview()
        blur5.removeFromSuperview()
        blur6.removeFromSuperview()
        blur7.removeFromSuperview()
        
        // Background Index
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let backgroundIndex = settings["BackgroundImage"]![0]
        //
        // BackgroundImage
        addBackgroundImage(withBlur: false, fullScreen: false)
        //
        // Title Colours and Blurs
        //
        switch backgroundIndex {
            // Black
        // All Black with no blur
        case BackgroundImages.backgroundImageArray.count:
            Warmup.setTitleColor(Colors.dark, for: .normal)
            Workout.setTitleColor(Colors.dark, for: .normal)
            Cardio.setTitleColor(Colors.dark, for: .normal)
            Stretching.setTitleColor(Colors.dark, for: .normal)
            Yoga.setTitleColor(Colors.dark, for: .normal)
            Meditation.setTitleColor(Colors.dark, for: .normal)
            body.textColor = Colors.dark
            mind.textColor = Colors.dark
        // All White
        case 4,3,0,1,2,5,6:
            Warmup.setTitleColor(Colors.light, for: .normal)
            Workout.setTitleColor(Colors.light, for: .normal)
            Cardio.setTitleColor(Colors.light, for: .normal)
            Stretching.setTitleColor(Colors.light, for: .normal)
            Yoga.setTitleColor(Colors.light, for: .normal)
            Meditation.setTitleColor(Colors.light, for: .normal)
            body.textColor = Colors.light
            mind.textColor = Colors.light
        //
        default: break
        }
    }
    
    //
    // View Did Load ------------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Navigation Bar
        //
        // Title
        navigationBar.title = "Mind & Body"
        // Appearance
        self.navigationController?.navigationBar.tintColor = Colors.light
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        self.navigationController?.navigationBar.barTintColor = Colors.dark
        self.tabBarController?.tabBar.barTintColor = Colors.dark
        UITabBar.appearance().barTintColor = Colors.dark
        tabBarController?.tabBar.barStyle = .default
        self.tabBarController?.tabBar.barTintColor = Colors.dark
        //
        // Navigation Items
        slideMenu.tintColor = Colors.light
        //
        
        self.tabBarController?.tabBar.tintColor = Colors.light
        
        
        // Button Customization
        //
        // Warmup
        Warmup.setTitle(NSLocalizedString("warmup", comment: ""), for: UIControlState.normal)
        Warmup.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Warmup.layer.borderWidth = 5
        Warmup.layer.borderColor = Colors.dark.cgColor
        Warmup.titleLabel?.adjustsFontSizeToFitWidth = true
        Warmup.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Warmup.titleLabel?.textAlignment = .center
        Warmup.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        // Workout
        Workout.setTitle(NSLocalizedString("workout", comment: ""), for: UIControlState.normal)
        Workout.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Workout.layer.borderWidth = 5
        Workout.layer.borderColor = Colors.dark.cgColor
        Workout.titleLabel?.adjustsFontSizeToFitWidth = true
        Workout.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Workout.titleLabel?.textAlignment = .center
        Workout.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        // Stretching
        Stretching.setTitle(NSLocalizedString("stretching", comment: ""), for: UIControlState.normal)
        Stretching.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Stretching.layer.borderWidth = 5
        Stretching.layer.borderColor = Colors.dark.cgColor
        Stretching.titleLabel?.adjustsFontSizeToFitWidth = true
        Stretching.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Stretching.titleLabel?.textAlignment = .center
        Stretching.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        // Cardio
        Cardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        Cardio.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Cardio.layer.borderWidth = 5
        Cardio.layer.borderColor = Colors.dark.cgColor
        Cardio.titleLabel?.adjustsFontSizeToFitWidth = true
        Cardio.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Cardio.titleLabel?.textAlignment = .center
        Cardio.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        // Yoga
        Yoga.setTitle(NSLocalizedString("yoga", comment: ""), for: UIControlState.normal)
        Yoga.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Yoga.titleLabel!.adjustsFontSizeToFitWidth = true
        Yoga.layer.borderWidth = 5
        Yoga.layer.borderColor = Colors.dark.cgColor
        Yoga.titleLabel?.adjustsFontSizeToFitWidth = true
        Yoga.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Yoga.titleLabel?.textAlignment = .center
        Yoga.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        // Meditation
        Meditation.setTitle(NSLocalizedString("meditation", comment: ""), for: UIControlState.normal)
        Meditation.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Meditation.layer.borderWidth = 5
        Meditation.layer.borderColor = Colors.dark.cgColor
        Meditation.titleLabel?.adjustsFontSizeToFitWidth = true
        Meditation.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Meditation.titleLabel?.textAlignment = .center
        Meditation.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let backgroundIndex = settings["BackgroundImage"]![0]
        if backgroundIndex != BackgroundImages.backgroundImageArray.count {
            Warmup.backgroundColor = Colors.dark.withAlphaComponent(0.72)
            Workout.backgroundColor = Colors.dark.withAlphaComponent(0.72)
            Cardio.backgroundColor = Colors.dark.withAlphaComponent(0.72)
            Stretching.backgroundColor = Colors.dark.withAlphaComponent(0.72)
            Yoga.backgroundColor = Colors.dark.withAlphaComponent(0.72)
            Meditation.backgroundColor = Colors.dark.withAlphaComponent(0.72)
        }
        
        // iPhone 5/SE layout
        if IPhoneType.shared.iPhoneType() == 0 {
            //
            wamupBottom.constant = 15
            //
            bodyTop.constant = 5
            bodyBottom.constant = 2
            mindTop.constant = 5
            mindBottom.constant = 3
            //
            yogaBottom.constant = 15
            meditationBottom.constant = 15
        // iPhoneX Layout
        } else if IPhoneType.shared.iPhoneType() == 2 {
            //
            wamupBottom.constant = 35
            //
            bodyTop.constant = 15
            bodyBottom.constant = 10
            mindTop.constant = 15
            mindBottom.constant = 13
            //
            yogaBottom.constant = 40
            meditationBottom.constant = 40
        // iPad Layout
        } else if IPhoneType.shared.iPhoneType() == 3 {
            //
            //
            bodyTop.constant = 20
            bodyBottom.constant = 15
            mindTop.constant = 15
            mindBottom.constant = 13
            //
            yogaBottom.constant = 40
            meditationBottom.constant = 40
            //
            wamupBottom.constant = 30
            workoutLeft.constant = 72
            //
            let const: CGFloat = 72
            warmupLeft.constant = const
            workoutRight.constant = const
            cardioLeft.constant = const
            stretchingRight.constant = const
            yogaLeft.constant = const
            yogaRight.constant = const
            meditationLeft.constant = const
            meditationRight.constant = const
            //
            topLeft.constant = const
            topRight.constant = const
            bottomLeft.constant = const
            bottomRight.constant = const
        }
        
    }
    //
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Home Screen
        if MenuVariables.shared.isInitialAppOpen {
            //        if isInitialAppOpen {
            // Deselect previous selection
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let homeScreen = settings["HomeScreen"]![0]
            if homeScreen == 2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.performSegue(withIdentifier: "openMenu", sender: self)
                })
            }
            MenuVariables.shared.isInitialAppOpen = false
        }
    }
    
    // Upon completion of check subscription, perform action
    @objc func subscriptionCheckCompleted() {
        Loading.shared.shouldPresentLoading = false
        Loading.shared.endLoading()
        if !SubscriptionsCheck.shared.isValid {
            self.performSegue(withIdentifier: "SubscriptionsSegue", sender: self)
        }
    }
    
    //
    // View Did Layout Subview ---------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Check subscription -> Present Subscription Screen
        NotificationCenter.default.addObserver(self, selector: #selector(subscriptionCheckCompleted), name: SubscriptionNotifiations.didCheckSubscription, object: nil)
        
        // Button Rounded Edges
        //
        Warmup.layer.cornerRadius = Warmup.frame.size.height / 2
        Warmup.clipsToBounds = true
        //
        Workout.layer.cornerRadius = Workout.frame.size.height / 2
        Workout.clipsToBounds = true
        //
        Stretching.layer.cornerRadius = Stretching.frame.size.height / 2
        Stretching.clipsToBounds = true
        //
        Cardio.layer.cornerRadius = Cardio.frame.size.height / 2
        Cardio.clipsToBounds = true
        //
        Yoga.layer.cornerRadius = Yoga.frame.size.height / 2
        Yoga.clipsToBounds = true
        //
        Meditation.layer.cornerRadius = Meditation.frame.size.height / 2
        Meditation.clipsToBounds = true
        
        //
        body.layer.cornerRadius = body.frame.size.height / 2
        body.clipsToBounds = true
        
        mind.layer.cornerRadius = mind.frame.size.height / 2
        mind.clipsToBounds = true
        
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let backgroundIndex = settings["BackgroundImage"]![0]
        if backgroundIndex != BackgroundImages.backgroundImageArray.count {
            body.backgroundColor = Colors.dark.withAlphaComponent(0.72)
            mind.backgroundColor = Colors.dark.withAlphaComponent(0.72)
        }
    }
    
    
    //
    // MARK: Selected Session
    @IBAction func warmupAction(_ sender: Any) {
        SelectedSession.shared.selectedSession[0] = "warmup"
        SelectedSession.shared.selectedSession[2] = ""
    }
    @IBAction func workoutAction(_ sender: Any) {
        SelectedSession.shared.selectedSession[0] = "workout"
        SelectedSession.shared.selectedSession[2] = ""
    }
    @IBAction func cardioAction(_ sender: Any) {
        SelectedSession.shared.selectedSession[0] = "cardio"
        SelectedSession.shared.selectedSession[2] = ""
    }
    @IBAction func stretchingAction(_ sender: Any) {
        SelectedSession.shared.selectedSession[0] = "stretching"
        SelectedSession.shared.selectedSession[2] = ""
    }
    @IBAction func yogaAction(_ sender: Any) {
        SelectedSession.shared.selectedSession[0] = "yoga"
        SelectedSession.shared.selectedSession[2] = ""
    }
    
    
    //
    // Slide Menu ---------------------------------------------------------------------------------------------------------------------
    //
    let interactor = Interactor()
    // Edge pan
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        
        //
        MenuVariables.shared.menuInteractionType = 1
        
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .Right)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.performSegue(withIdentifier: "openMenu", sender: nil)
        }
    }
    // Button
    @IBAction func slideMenuButtonAction(_ sender: Any) {
        MenuVariables.shared.menuInteractionType = 0
    }
    
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "openMenu" {
            //
            if let destinationViewController = segue.destination as? SlideMenuView {
                destinationViewController.transitioningDelegate = self
            }
            // Handle changing colour of status bar if button pressed
            if MenuVariables.shared.menuInteractionType == 0 {
                UIApplication.shared.statusBarStyle = .default
            }
        } else {
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
}






//
// Slide Menu Extension
extension MindBody: UIViewControllerTransitioningDelegate {
    
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






class MindBodyNavigation: UINavigationController {
}

