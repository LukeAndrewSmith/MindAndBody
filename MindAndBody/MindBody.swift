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
    // View Indicator
    @IBOutlet weak var viewIndicator: UIBarButtonItem!
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
            // All Black
            //        case 1:   // 3
            //            Warmup.setTitleColor(Colors.dark, for: .normal)
            //            Workout.setTitleColor(Colors.dark, for: .normal)
            //            Cardio.setTitleColor(Colors.dark, for: .normal)
            //            Stretching.setTitleColor(Colors.dark, for: .normal)
            //            Yoga.setTitleColor(Colors.dark, for: .normal)
            //            Meditation.setTitleColor(Colors.dark, for: .normal)
            //            body.textColor = Colors.dark
            //            mind.textColor = Colors.dark
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
            // White text, black body and mind
            //        case 5:
            //            Warmup.setTitleColor(Colors.light, for: .normal)
            //            Workout.setTitleColor(Colors.light, for: .normal)
            //            Cardio.setTitleColor(Colors.light, for: .normal)
            //            Stretching.setTitleColor(Colors.light, for: .normal)
            //            Yoga.setTitleColor(Colors.light, for: .normal)
            //            Meditation.setTitleColor(Colors.light, for: .normal)
            //            body.textColor = Colors.dark
            //            mind.textColor = Colors.dark
            //        // Black text, black body, white mind
            //        case 6:
            //            Warmup.setTitleColor(Colors.dark, for: .normal)
            //            Workout.setTitleColor(Colors.dark, for: .normal)
            //            Cardio.setTitleColor(Colors.dark, for: .normal)
            //            Stretching.setTitleColor(Colors.dark, for: .normal)
            //            Yoga.setTitleColor(Colors.dark, for: .normal)
            //            Meditation.setTitleColor(Colors.dark, for: .normal)
            //            body.textColor = Colors.dark
            //            mind.textColor = Colors.light
            // White Text, Black body, White mind
            //        case 6: // 0
            //            Warmup.setTitleColor(Colors.light, for: .normal)
            //            Workout.setTitleColor(Colors.light, for: .normal)
            //            Cardio.setTitleColor(Colors.light, for: .normal)
            //            Stretching.setTitleColor(Colors.light, for: .normal)
            //            Yoga.setTitleColor(Colors.light, for: .normal)
            //            Meditation.setTitleColor(Colors.light, for: .normal)
            //            body.textColor = Colors.dark
            //            mind.textColor = Colors.light
            // White Text, Black mind, White body
            //        case 2:
            //            Warmup.setTitleColor(Colors.light, for: .normal)
            //            Workout.setTitleColor(Colors.light, for: .normal)
            //            Cardio.setTitleColor(Colors.light, for: .normal)
            //            Stretching.setTitleColor(Colors.light, for: .normal)
            //            Yoga.setTitleColor(Colors.light, for: .normal)
            //            Meditation.setTitleColor(Colors.light, for: .normal)
            //            body.textColor = Colors.light
            //            mind.textColor = Colors.dark
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
        
        
        //
        // Walkthroughs
        // Walkthrough app overview
        // mindBody walkthrough == false
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["HomeScreen"] == false {
            self.walkthroughMindBody()
        }
        
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
        //viewIndicator.tintColor = Colors.light
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
        
        // Iphone 5/SE layout
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
    
    
    
    
    
    
    
    
    
    
    
    
    //
    // MARK: Walkthrough ------------------------------------------------------------------------------------------------------------------
    //
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabel = UILabel()
    var nextButton = UIButton()
    
    var value1 = 31
    var value2 = 30
    
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["mindBody0", "mindBody1", "mindBody2", "mindBody3", "mindBody4", "mindBody5", "mindBody6", "mindBody7", "mindBody8", "mindBody9", "mindBody10"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    // Walkthrough
    @objc func walkthroughMindBody() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughMindBody), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
            //
            // Iphone 5/SE layout
            if UIScreen.main.nativeBounds.height > 1334 {
                //
                value1 = 35
                value2 = 35
            }
        }
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Walkthrough explanation
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = Colors.dark
            walkthroughLabel.backgroundColor = Colors.light
            walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.light.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: 172, height: 33)
            walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: 40)
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Menu
        case 1:
            //
            highlightSize = CGSize(width: 172, height: 33)
            highlightCenter = CGPoint(x: view.frame.size.width / 2, y: 40)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
            
        // Menu
        case 2:
            //
            highlightSize = CGSize(width: 36, height: 36)
            highlightCenter = CGPoint(x: self.value1, y: 41)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Main App Screens
        case 3:
            //
            self.performSegue(withIdentifier: "openMenu", sender: nil)
            //
            // (72 is row height for slide menu)
            highlightSize = CGSize(width: 44, height: 72 * 6)
            highlightCenter = CGPoint(x: CGFloat(self.value2), y: TopBarHeights.combinedHeight + 216)
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.6, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Profile
        case 4:
            //
            highlightSize = CGSize(width: 44, height: 44)
            highlightCenter = CGPoint(x: CGFloat(self.value2), y: TopBarHeights.combinedHeight + (72 * 4.5))
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Schedule
        case 5:
            //
            highlightSize = CGSize(width: 44, height: 44)
            highlightCenter = CGPoint(x: CGFloat(self.value2), y: TopBarHeights.combinedHeight + (72 * 1.5))
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.6, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Home
        case 6:
            //
            highlightSize = CGSize(width: 44, height: 44)
            highlightCenter = CGPoint(x: CGFloat(self.value2), y: TopBarHeights.combinedHeight + (72 / 2))
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.6, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Tracking
        case 7:
            //
            highlightSize = CGSize(width: 44, height: 44)
            highlightCenter = CGPoint(x: CGFloat(self.value2), y: TopBarHeights.combinedHeight + (72 * 2.5))
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.6, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Lessons
        case 8:
            //
            highlightSize = CGSize(width: 44, height: 44)
            highlightCenter = CGPoint(x: CGFloat(self.value2), y: TopBarHeights.combinedHeight + (72 * 3.5))
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.6, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Settings
        case 9:
            //
            highlightSize = CGSize(width: 44, height: 44)
            highlightCenter = CGPoint(x: CGFloat(self.value2), y: TopBarHeights.combinedHeight + (72 * 5.5))
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.6, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        // Recap
        case 10:
            //
            highlightSize = CGSize(width: 44, height: 432)
            highlightCenter = CGPoint(x: CGFloat(self.value2), y: 216 + TopBarHeights.combinedHeight)
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.6, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                // Walkthrough
                var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                walkthroughs["HomeScreen"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                // Settings
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                settings["HomeScreen"]![0] = 1
                UserDefaults.standard.set(settings, forKey: "userSettings")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["walkthroughs", "userSettings"])
            })
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

