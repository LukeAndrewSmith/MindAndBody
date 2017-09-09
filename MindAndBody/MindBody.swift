//
//  MindBody.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


//
// Mind & Body Class ------------------------------------------------------------------------------------------------------------------------
//
class MindBody: UIViewController, UNUserNotificationCenterDelegate {
    
    // Previous Colours
    //            UserDefaults.standard.setColor(UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), forKey: "colour1")
    //            UserDefaults.standard.setColor(UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0), forKey: "colour2")
    //  (UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour2")
    //  (UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour3")
    
    
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
    //
    
    // Background Image
    @IBOutlet weak var backgroundImage: UIImageView!
    
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
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
        
        //
        // Background Image/Colour
        //
        if backgroundIndex < backgroundImageArray.count {
            //
            backgroundImage.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImage.image = nil
            backgroundImage.backgroundColor = colour1
        }
        //
        // Title Colours and Blurs
        //
        switch backgroundIndex {
            // Black
        // All Black with no blur
        case backgroundImageArray.count:
            Warmup.setTitleColor(colour2, for: .normal)
            Workout.setTitleColor(colour2, for: .normal)
            Cardio.setTitleColor(colour2, for: .normal)
            Stretching.setTitleColor(colour2, for: .normal)
            Yoga.setTitleColor(colour2, for: .normal)
            Meditation.setTitleColor(colour2, for: .normal)
            body.textColor = colour2
            mind.textColor = colour2
        // All Black
        case 1,3:
            Warmup.setTitleColor(colour2, for: .normal)
            Workout.setTitleColor(colour2, for: .normal)
            Cardio.setTitleColor(colour2, for: .normal)
            Stretching.setTitleColor(colour2, for: .normal)
            Yoga.setTitleColor(colour2, for: .normal)
            Meditation.setTitleColor(colour2, for: .normal)
            body.textColor = colour2
            mind.textColor = colour2
        // All White
        case 4:
            Warmup.setTitleColor(colour1, for: .normal)
            Workout.setTitleColor(colour1, for: .normal)
            Cardio.setTitleColor(colour1, for: .normal)
            Stretching.setTitleColor(colour1, for: .normal)
            Yoga.setTitleColor(colour1, for: .normal)
            Meditation.setTitleColor(colour1, for: .normal)
            body.textColor = colour1
            mind.textColor = colour1
        // White text, black body and mind
        case 5:
            Warmup.setTitleColor(colour1, for: .normal)
            Workout.setTitleColor(colour1, for: .normal)
            Cardio.setTitleColor(colour1, for: .normal)
            Stretching.setTitleColor(colour1, for: .normal)
            Yoga.setTitleColor(colour1, for: .normal)
            Meditation.setTitleColor(colour1, for: .normal)
            body.textColor = colour2
            mind.textColor = colour2
        // Black text, black body, white mind
        case 6:
            Warmup.setTitleColor(colour2, for: .normal)
            Workout.setTitleColor(colour2, for: .normal)
            Cardio.setTitleColor(colour2, for: .normal)
            Stretching.setTitleColor(colour2, for: .normal)
            Yoga.setTitleColor(colour2, for: .normal)
            Meditation.setTitleColor(colour2, for: .normal)
            body.textColor = colour2
            mind.textColor = colour1
        // White Text, Black body, White mind
        case 0:
            Warmup.setTitleColor(colour1, for: .normal)
            Workout.setTitleColor(colour1, for: .normal)
            Cardio.setTitleColor(colour1, for: .normal)
            Stretching.setTitleColor(colour1, for: .normal)
            Yoga.setTitleColor(colour1, for: .normal)
            Meditation.setTitleColor(colour1, for: .normal)
            body.textColor = colour2
            mind.textColor = colour1
        // White Text, Black mind, White body
        case 2:
            Warmup.setTitleColor(colour1, for: .normal)
            Workout.setTitleColor(colour1, for: .normal)
            Cardio.setTitleColor(colour1, for: .normal)
            Stretching.setTitleColor(colour1, for: .normal)
            Yoga.setTitleColor(colour1, for: .normal)
            Meditation.setTitleColor(colour1, for: .normal)
            body.textColor = colour1
            mind.textColor = colour2
        //
        default: break
        }
    }

    
    //
    // Register Defaults --------------------------------------------------------------------------------
    //
    func registerDefaults() {
        let defaults = UserDefaults.standard
        
        
        
        //
        // Tracking
        // Progress
        defaults.register(defaults: ["weekProgress" : 0])
        defaults.register(defaults: ["monthProgress" : 0])
        // Update progress (first monday of last week/month completed, used to check if progress needs to be reset to 0 for first entry of new week/month)
        defaults.register(defaults: ["lastResetWeek" : firstMondayInCurrentWeek()])
        defaults.register(defaults: ["lastResetWeek" : firstMondayInCurrentMonth()])

        
        
        //
        // Settings
        // Background image index
        UserDefaults.standard.register(defaults: ["homeScreenBackground" : 2])
        // Default Image
        UserDefaults.standard.register(defaults: ["defaultImage" : "demonstration"])
        // Weight
        UserDefaults.standard.register(defaults: ["units" : "kg"])
        // Rest times
        UserDefaults.standard.register(defaults: ["restTimes" : [15, 45, 10]])
        // Yoga Automatic
        UserDefaults.standard.register(defaults: ["automaticYoga" : [0, -1, -1, -1]])
        
        
        
        //
        // Register Walkthroughs
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough" : false])
        //
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough1" : false])
        //
        UserDefaults.standard.register(defaults: ["mindBodyWalkthroughc" : false])
        //
        UserDefaults.standard.register(defaults: ["mindBodyWalkthroughw" : false])
        //
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough2" : false])
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough2y" : false])
        //
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough3" : false])
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough3y" : false])
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough4y" : false])
        //
        UserDefaults.standard.register(defaults: ["profileWalkthrough" : false])
        //
        UserDefaults.standard.register(defaults: ["informationWalkthrough" : false])
        //
        UserDefaults.standard.register(defaults: ["informationWalkthroughI" : false])
        //
        UserDefaults.standard.register(defaults: ["informationWalkthroughm" : false])
        
        
    }
    
    //
    // View Did Load ------------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
    
        
        
        
        //
        // Alert View indicating meaning of resetting the app
        let title = NSLocalizedString("notificationsPopup", comment: "")
        let message = NSLocalizedString("notificationsPopupMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
        
        // Reset app action
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            }
            //
            self.walkthroughMindBody()
        }
        //
        alert.addAction(okAction)
        
        // Present Alert
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough") == false {
            self.present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough")
        }
        
        
        //
        registerDefaults()
        
        
        
        
        // Navigation Bar
        //
        // Title
        navigationBar.title = "Mind & Body"
        // Appearance
        self.navigationController?.navigationBar.tintColor = colour1
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colour1, NSFontAttributeName: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        self.navigationController?.navigationBar.barTintColor = colour2
        self.tabBarController?.tabBar.barTintColor = colour2
        UITabBar.appearance().barTintColor = colour2
        tabBarController?.tabBar.barStyle = .default
        self.tabBarController?.tabBar.barTintColor = colour2
        //
        // Navigation Items
        slideMenu.tintColor = colour1
        //viewIndicator.tintColor = colour1
        //
        
        self.tabBarController?.tabBar.tintColor = colour1
        
        
        // Button Customization
        //
        // Warmup
        Warmup.setTitle(NSLocalizedString("warmup", comment: ""), for: UIControlState.normal)
        Warmup.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Warmup.layer.borderWidth = 5
        Warmup.layer.borderColor = colour2.cgColor
        Warmup.titleLabel?.adjustsFontSizeToFitWidth = true
        Warmup.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Warmup.titleLabel?.textAlignment = .center
        Warmup.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        // Workout
        Workout.setTitle(NSLocalizedString("workout", comment: ""), for: UIControlState.normal)
        Workout.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Workout.layer.borderWidth = 5
        Workout.layer.borderColor = colour2.cgColor
        Workout.titleLabel?.adjustsFontSizeToFitWidth = true
        Workout.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Workout.titleLabel?.textAlignment = .center
        Workout.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        // Stretching
        Stretching.setTitle(NSLocalizedString("stretching", comment: ""), for: UIControlState.normal)
        Stretching.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Stretching.layer.borderWidth = 5
        Stretching.layer.borderColor = colour2.cgColor
        Stretching.titleLabel?.adjustsFontSizeToFitWidth = true
        Stretching.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Stretching.titleLabel?.textAlignment = .center
        Stretching.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        // Cardio
        Cardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        Cardio.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Cardio.layer.borderWidth = 5
        Cardio.layer.borderColor = colour2.cgColor
        Cardio.titleLabel?.adjustsFontSizeToFitWidth = true
        Cardio.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Cardio.titleLabel?.textAlignment = .center
        Cardio.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        // Yoga
        Yoga.setTitle(NSLocalizedString("yoga", comment: ""), for: UIControlState.normal)
        Yoga.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Yoga.titleLabel!.adjustsFontSizeToFitWidth = true
        Yoga.layer.borderWidth = 5
        Yoga.layer.borderColor = colour2.cgColor
        Yoga.titleLabel?.adjustsFontSizeToFitWidth = true
        Yoga.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Yoga.titleLabel?.textAlignment = .center
        Yoga.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        // Meditation
        Meditation.setTitle(NSLocalizedString("meditation", comment: ""), for: UIControlState.normal)
        Meditation.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        Meditation.layer.borderWidth = 5
        Meditation.layer.borderColor = colour2.cgColor
        Meditation.titleLabel?.adjustsFontSizeToFitWidth = true
        Meditation.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Meditation.titleLabel?.textAlignment = .center
        Meditation.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        
//        // Iphone 5/SE layout
//        if UIScreen.main.nativeBounds.height < 1334 {
//            //
//            wamupBottom.constant = 15
//            //
//            bodyTop.constant = 5
//            bodyBottom.constant = 2
//            mindTop.constant = 5
//            mindBottom.constant = 3
//            //
//            yogaBottom.constant = 15
//            meditationBottom.constant = 15
//        }
    }
    
    
    //
    // View Did Layout Subview ---------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        let blur = UIBlurEffect(style: .dark)
        let vibrancy = UIVibrancyEffect(blurEffect: blur)
        //
        blur0.effect = blur
        blur0.effect = vibrancy
        //
        blur1.effect = blur
        blur1.effect = vibrancy
        
        //
        blur2.effect = blur
        blur2.effect = vibrancy
        //
        blur3.effect = blur
        blur3.effect = vibrancy
        
        //
        blur4.effect = blur
        blur4.effect = vibrancy
        //
        blur5.effect = blur
        blur5.effect = vibrancy
        
        //
        blur6.effect = blur
        blur6.effect = vibrancy
        //
        blur7.effect = blur
        blur7.effect = vibrancy
        
        
        // Blur Positioning and frame
        blur0.bounds = Warmup.bounds
        blur0.layer.cornerRadius = Warmup.frame.size.height / 2
        blur0.clipsToBounds = true
        blur0.center = Warmup.center
        //
        blur1.bounds = Workout.bounds
        blur1.layer.cornerRadius = Workout.frame.size.height / 2
        blur1.clipsToBounds = true
        blur1.center = Workout.center

        //
        blur2.bounds = Cardio.bounds
        blur2.layer.cornerRadius = Cardio.frame.size.height / 2
        blur2.clipsToBounds = true
        blur2.center = Cardio.center
        //
        blur3.bounds = Stretching.bounds
        blur3.layer.cornerRadius = Stretching.frame.size.height / 2
        blur3.clipsToBounds = true
        blur3.center = Stretching.center
        
        //
        blur4.bounds = Yoga.bounds
        blur4.layer.cornerRadius = Yoga.frame.size.height / 2
        blur4.clipsToBounds = true
        blur4.center = Yoga.center
        //
        blur5.bounds = Meditation.bounds
        blur5.layer.cornerRadius = Yoga.frame.size.height / 2
            //Meditation.frame.size.height / 2
        blur5.clipsToBounds = true
        blur5.center = Meditation.center
        
        //
        body.layer.cornerRadius = body.frame.size.height / 2
        blur6.frame = CGRect(x: 0, y: 0, width: body.bounds.width + 2, height: body.bounds.height + 1)
            //body.bounds
        blur6.center = body.center
        blur6.layer.cornerRadius = blur6.frame.size.height / 2
        blur6.clipsToBounds = true
        //
        mind.layer.cornerRadius = mind.frame.size.height / 2
        blur7.frame = CGRect(x: 0, y: 0, width: mind.bounds.width + 2, height: mind.bounds.height + 1)
            //mind.bounds
        blur7.center = mind.center
        blur7.layer.cornerRadius = mind.frame.size.height / 2
        blur7.clipsToBounds = true
        
        
       
        
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
        if backgroundIndex == backgroundImageArray.count {
        } else {
            //
            view.insertSubview(blur0, belowSubview: Warmup)
            view.insertSubview(blur1, belowSubview: Workout)
            view.insertSubview(blur2, belowSubview: Cardio)
            view.insertSubview(blur3, belowSubview: Stretching)
            view.insertSubview(blur4, belowSubview: Yoga)
            view.insertSubview(blur5, belowSubview: Meditation)
            //
            view.insertSubview(blur6, belowSubview: body)
            view.insertSubview(blur7, belowSubview: mind)
        }
    }
    
    
    //
    // Slide Menu ---------------------------------------------------------------------------------------------------------------------
    //
    
    // Elements
    //
    @IBAction func swipeGesture(sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    
    //let transitionManager = TransitionManager()
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "openMenu" {
            //
            UIApplication.shared.statusBarStyle = .default
            
//            //
            //
//            let toViewController = segue.destination as UIViewController
//            
//            toViewController.transitioningDelegate = self.transitionManager
            
           // self.transitioningDelegate = transitionManager
            
            if let destinationViewController = segue.destination as? SlideMenuView {
                destinationViewController.transitioningDelegate = self
            }
        } else {
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
//    
// Walkthrough ------------------------------------------------------------------------------------------------------------------
//
        //
        var walkthroughProgress = 0
        let walkthroughView = UIView()
        let walkthroughHighlight = UIView()
        let walkthroughLabel = UILabel()
        let nextButton = UIButton()
    
        var value1 = 31
        var value2 = 30
    
        var time1 = 0.4
    
        var didSetWalkthrough = false
        // Set Initial States
        func setWalkthrough() {
            
            //
            let screenSize = UIScreen.main.bounds
            let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
            
            // View
            walkthroughView.frame = screenSize
            walkthroughView.backgroundColor = .clear
            
            // Highlight
            walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = colour1.cgColor
            walkthroughHighlight.layer.borderWidth = 1
            
            // Label
            walkthroughLabel.frame = CGRect(x: 13, y: 0, width: view.frame.size.width - 26, height: 0)
            walkthroughLabel.center = view.center
            walkthroughLabel.textAlignment = .center
            walkthroughLabel.numberOfLines = 0
            walkthroughLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            walkthroughLabel.layer.cornerRadius = 13
            walkthroughLabel.clipsToBounds = true
            walkthroughLabel.backgroundColor = colour1
            walkthroughLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
            walkthroughLabel.textColor = colour2
            walkthroughLabel.alpha = 0.93
            
            // Button
            nextButton.frame = screenSize
            nextButton.backgroundColor = .clear
            nextButton.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
            
            
            //
            // Iphone 5/SE layout
            if UIScreen.main.nativeBounds.height > 1334 {
                //
                value1 = 35
                value2 = 35
            }
        }
    
    
        // Walkthrough
        func walkthroughMindBody() {
    
            if didSetWalkthrough == false {
                setWalkthrough()
                didSetWalkthrough = true
            }
            
            //
            let screenSize = UIScreen.main.bounds
            let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
    
           
            //
            switch walkthroughProgress {
            //
            case 0:
                //
                walkthroughHighlight.frame.size = CGSize(width: 172, height: 33)
                walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: 40)
                walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.frame.size.height / 2
                walkthroughHighlight.clipsToBounds = true
                
                //
                walkthroughLabel.text = NSLocalizedString("mindBody0", comment: "")
                walkthroughLabel.sizeToFit()
                walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
                
                //
                walkthroughView.addSubview(walkthroughLabel)
                walkthroughView.addSubview(walkthroughHighlight)
                walkthroughView.addSubview(nextButton)
                UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
                walkthroughView.bringSubview(toFront: nextButton)
                walkthroughView.bringSubview(toFront: walkthroughLabel)
    
                //
                let delayInSeconds = 0.2
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                //
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
                }, completion: {(finished: Bool) -> Void in
                    UIView.animate(withDuration: 0.2, animations: {
                        //
                        self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                    }, completion: nil)
                })
               }
                
            //
            case 1:
                //
                UIView.animate(withDuration: 0.4, animations: {
                    self.walkthroughHighlight.frame.size = CGSize(width: 36, height: 36)
                    self.walkthroughHighlight.center = CGPoint(x: self.value1, y: 41)
                    self.walkthroughHighlight.layer.cornerRadius = self.walkthroughHighlight.frame.size.height / 2
                    self.walkthroughHighlight.clipsToBounds = true
                }, completion: nil)
                
                //
                walkthroughLabel.text = NSLocalizedString("mindBody1", comment: "")
                walkthroughLabel.sizeToFit()
                walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
                
                //
                walkthroughView.addSubview(walkthroughLabel)
                walkthroughView.addSubview(walkthroughHighlight)
                walkthroughView.addSubview(nextButton)
                UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
                walkthroughView.bringSubview(toFront: nextButton)
                walkthroughView.bringSubview(toFront: walkthroughLabel)
                
                //
                let delayInSeconds = 0.4
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    //
                    UIView.animate(withDuration: 0.2, animations: {
                        //
                        self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
                    }, completion: {(finished: Bool) -> Void in
                        UIView.animate(withDuration: 0.2, animations: {
                            //
                            self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                        }, completion: nil)
                    })
                }
                
            //
            case 2:
                
                self.performSegue(withIdentifier: "openMenu", sender: nil)

                //
                UIView.animate(withDuration: 0.6, animations: {
                    self.walkthroughHighlight.frame.size = CGSize(width: 44, height: 432)
                    self.walkthroughHighlight.center = CGPoint(x: self.value2, y: 280)
                    self.walkthroughHighlight.layer.cornerRadius = self.walkthroughHighlight.frame.size.width / 2
                    self.walkthroughHighlight.clipsToBounds = true
                    //
                    self.walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(0.5)
                    self.walkthroughHighlight.layer.borderColor = colour2.cgColor
                    //
                    self.walkthroughLabel.textColor = colour1
                    self.walkthroughLabel.backgroundColor = colour2
                    //
                    
                }, completion: nil)
                
                //
                walkthroughLabel.text = NSLocalizedString("mindBody2", comment: "")
                walkthroughLabel.sizeToFit()
                walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
                
                //
                time1 = 0.6
                
                //
                walkthroughView.addSubview(walkthroughLabel)
                walkthroughView.addSubview(walkthroughHighlight)
                walkthroughView.addSubview(nextButton)
                UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
                walkthroughView.bringSubview(toFront: nextButton)
                walkthroughView.bringSubview(toFront: walkthroughLabel)
                
                //
                let delayInSeconds = 0.6
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    //
                    UIView.animate(withDuration: 0.2, animations: {
                        //
                        self.walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(1)
                    }, completion: {(finished: Bool) -> Void in
                        UIView.animate(withDuration: 0.2, animations: {
                            //
                            self.walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(0.5)
                        }, completion: nil)
                    })
                }
                
//            //
            case 3:
                //
                UIView.animate(withDuration: 0.4, animations: {
                    self.walkthroughHighlight.frame.size = CGSize(width: 172, height: 33)
                    self.walkthroughHighlight.center = CGPoint(x: self.view.frame.size.width / 2, y: 40)
                    self.walkthroughHighlight.layer.cornerRadius = self.walkthroughHighlight.frame.size.height / 2
                    self.walkthroughHighlight.clipsToBounds = true
                    //
                    self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                    self.walkthroughHighlight.layer.borderColor = colour1.cgColor
                    //
                    self.walkthroughLabel.textColor = colour2
                    self.walkthroughLabel.backgroundColor = colour1
                    //
                }, completion: nil)
                
                //
                walkthroughLabel.text = NSLocalizedString("mindBody3", comment: "")
                walkthroughLabel.sizeToFit()
                walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
                
                //
                walkthroughView.addSubview(walkthroughLabel)
                walkthroughView.addSubview(walkthroughHighlight)
                walkthroughView.addSubview(nextButton)
                UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
                walkthroughView.bringSubview(toFront: nextButton)
                walkthroughView.bringSubview(toFront: walkthroughLabel)
                
                var time1 = 0.4
                
                //
                let delayInSeconds = 0.4
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    //
                    UIView.animate(withDuration: 0.2, animations: {
                        //
                        self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
                    }, completion: {(finished: Bool) -> Void in
                        UIView.animate(withDuration: 0.2, animations: {
                            //
                            self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                        }, completion: nil)
                    })
                }
                
                //
               
                self.dismiss(animated: true)
                UIApplication.shared.statusBarStyle = .lightContent

                
    
//            //
            case 4:
                
                walkthroughLabel.text = NSLocalizedString("mindBody4", comment: "")

                
                
//            //
//            case 5:
//                // Clear Section
//                let path = CGMutablePath()
//                path.addArc(center: CGPoint(x: (view.frame.width / 4) - ((view.frame.width / 4) * 1/3 ), y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + view.frame.size.height + (tabBarHeight / 2)), radius: 23, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
//                path.addRect(walkthroughView.frame)
//                //
//                let maskLayer = CAShapeLayer()
//                maskLayer.backgroundColor = UIColor.black.cgColor
//                maskLayer.path = path
//                maskLayer.fillRule = kCAFillRuleEvenOdd
//                //
//                walkthroughView.layer.mask = maskLayer
//                walkthroughView.clipsToBounds = true
//                //
//                walkthroughView.addSubview(backButton)
//                walkthroughView.addSubview(nextButton)
//                self.view.addSubview(walkthroughView)
//                UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
//                walkthroughView.bringSubview(toFront: nextButton)
//                walkthroughView.bringSubview(toFront: backButton)
//    
//                //
//                label.text = NSLocalizedString("mindBody5", comment: "")
//                UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
//                label.center = view.center
//    
//            //
//            case 6:
//                // Clear Section
//                let path = CGMutablePath()
//                path.addArc(center: CGPoint(x: view.center.x, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + view.frame.size.height + (tabBarHeight / 2)), radius: 23, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
//                path.addRect(walkthroughView.frame)
//                //
//                let maskLayer = CAShapeLayer()
//                maskLayer.backgroundColor = UIColor.black.cgColor
//                maskLayer.path = path
//                maskLayer.fillRule = kCAFillRuleEvenOdd
//                //
//                walkthroughView.layer.mask = maskLayer
//                walkthroughView.clipsToBounds = true
//                //
//                walkthroughView.addSubview(backButton)
//                walkthroughView.addSubview(nextButton)
//                self.view.addSubview(walkthroughView)
//                UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
//                walkthroughView.bringSubview(toFront: nextButton)
//                walkthroughView.bringSubview(toFront: backButton)
//    
//                //
//                label.text = NSLocalizedString("mindBody6", comment: "")
//                UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
//    
//            //
//            case 7:
//                // Clear Section
//                let path = CGMutablePath()
//                path.addArc(center: CGPoint(x: ((view.frame.width / 4) * 3) + ((view.frame.width / 4) * 1/3 ), y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + view.frame.size.height + (tabBarHeight / 2)), radius: 23, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
//                path.addRect(walkthroughView.frame)
//                //
//                let maskLayer = CAShapeLayer()
//                maskLayer.backgroundColor = UIColor.black.cgColor
//                maskLayer.path = path
//                maskLayer.fillRule = kCAFillRuleEvenOdd
//                //
//                walkthroughView.layer.mask = maskLayer
//                walkthroughView.clipsToBounds = true
//                //
//                walkthroughView.addSubview(backButton)
//                walkthroughView.addSubview(nextButton)
//                self.view.addSubview(walkthroughView)
//                UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
//                walkthroughView.bringSubview(toFront: nextButton)
//                walkthroughView.bringSubview(toFront: backButton)
//                
//                //
//                label.text = NSLocalizedString("mindBody7", comment: "")
//                UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
//            //
            default: break
            }
        }
        
        //
        func nextWalkthroughView(_ sender: Any) {
            
            // Snapshot 1
            let walkthroughSnapshot1 = self.walkthroughLabel.snapshotView(afterScreenUpdates: false)
            walkthroughSnapshot1?.center = walkthroughLabel.center
            // Next Walkthrough
            self.walkthroughView.removeFromSuperview()
            //self.walkthroughHighlight.removeFromSuperview()
            self.walkthroughLabel.removeFromSuperview()
            self.nextButton.removeFromSuperview()
            self.walkthroughProgress = self.walkthroughProgress + 1
            self.walkthroughMindBody()
            
            // Snapshot 2
            let walkthroughSnapshot2 = self.walkthroughLabel.snapshotView(afterScreenUpdates: true)
            walkthroughSnapshot2?.center = walkthroughLabel.center
            walkthroughSnapshot2?.center.x += view.frame.size.width
            
            self.walkthroughLabel.alpha = 0
            
            // Add Snapshots
            UIApplication.shared.keyWindow?.insertSubview(walkthroughSnapshot1!, aboveSubview: walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughSnapshot2!, aboveSubview: walkthroughView)
            
            // Animate
            UIView.animate(withDuration: time1, animations: {
                walkthroughSnapshot1?.center.x -= self.view.frame.size.width * 1
                walkthroughSnapshot2?.center.x = self.view.center.x
            }, completion: {(finished: Bool) -> Void in
                self.walkthroughLabel.alpha = 0.93
                walkthroughSnapshot1?.removeFromSuperview()
                walkthroughSnapshot2?.removeFromSuperview()
            })
        }
    
}










//
// Slide Menu Extension
extension MindBody: UIViewControllerTransitioningDelegate {
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
