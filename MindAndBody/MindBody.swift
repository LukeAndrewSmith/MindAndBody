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
import CoreGraphics


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
        let backgroundIndex = UserDefaults.standard.integer(forKey: "backgroundImage")
        
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
    // View Did Load ------------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
    
        
        //
        // Notifications Popup
        //
        // Alert View notifications
        let title = NSLocalizedString("notificationsPopup", comment: "")
        let message = NSLocalizedString("notificationsPopupMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
        // Ok Action
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            }
            //
            UserDefaults.standard.set(true, forKey: "notificationsPopup")
            self.walkthroughMindBody()
        }
        //
        alert.addAction(okAction)
        
        // Notifications Popup
        if UserDefaults.standard.bool(forKey: "notificationsPopup") == false {
            self.present(alert, animated: true, completion: nil)
        }
        
        //
        // Walkthroughs
        // Walkthrough app overview
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough") == false && UserDefaults.standard.bool(forKey: "notificationsPopup") == true {
            self.walkthroughMindBody()
        }
        
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
        
        // Iphone 5/SE layout
        if UIScreen.main.nativeBounds.height < 1334 {
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
        }
        
    }
    //
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Home Screen
        if isInitialAppOpen == true {
            let homeScreen = UserDefaults.standard.integer(forKey: "homeScreen")
            if homeScreen == 2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.performSegue(withIdentifier: "openMenu", sender: self)
                })
            }
            isInitialAppOpen = false
        }
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
        
        
       
        
        let backgroundIndex = UserDefaults.standard.integer(forKey: "backgroundImage")
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
    // MARK: Selected Session
    @IBAction func warmupAction(_ sender: Any) {
        selectedSession[0] = 0
        selectedSession[2] = -1
    }
    @IBAction func workoutAction(_ sender: Any) {
        selectedSession[0] = 1
        selectedSession[2] = -1
    }
    @IBAction func cardioAction(_ sender: Any) {
        selectedSession[0] = 2
        selectedSession[2] = -1
    }
    @IBAction func stretchingAction(_ sender: Any) {
        selectedSession[0] = 3
        selectedSession[2] = -1
    }
    @IBAction func yogaAction(_ sender: Any) {
        selectedSession[0] = 4
        selectedSession[2] = -1
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
        func walkthroughMindBody() {
            
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
                walkthroughLabel.textColor = colour2
                walkthroughLabel.backgroundColor = colour1
                walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                walkthroughHighlight.layer.borderColor = colour1.cgColor
                // Highlight
                walkthroughHighlight.frame.size = CGSize(width: 172, height: 33)
                walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: 40)
                walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
                
                //
                // Flash
                //
                UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                        //
                        self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
                    }, completion: {(finished: Bool) -> Void in
                        UIView.animate(withDuration: 0.2, animations: {
                            //
                            self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
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
                walkthroughBackgroundColor = colour1
                walkthroughTextColor = colour2
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
                walkthroughBackgroundColor = colour1
                walkthroughTextColor = colour2
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
                walkthroughBackgroundColor = colour2
                walkthroughTextColor = colour1
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
                walkthroughBackgroundColor = colour2
                walkthroughTextColor = colour1
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
                walkthroughBackgroundColor = colour2
                walkthroughTextColor = colour1
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
                walkthroughBackgroundColor = colour2
                walkthroughTextColor = colour1
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
                walkthroughBackgroundColor = colour2
                walkthroughTextColor = colour1
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
                walkthroughBackgroundColor = colour2
                walkthroughTextColor = colour1
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
                walkthroughBackgroundColor = colour2
                walkthroughTextColor = colour1
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
                walkthroughBackgroundColor = colour2
                walkthroughTextColor = colour1
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
                    UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough")
                    UserDefaults.standard.set(1, forKey: "homeScreen")
                })
            }
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
