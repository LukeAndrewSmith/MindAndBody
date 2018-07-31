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
    
    //
    // View Will Appear ---------------------------------------------------------------------------------------------------------------------
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Checking subscription, present loading
        if Loading.shared.shouldPresentLoading {
//            Loading.shared.beginLoading()
        }
    
        // Background Index
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let backgroundIndex = settings["BackgroundImage"]![0]
        //
        // BackgroundImage
        addBackgroundImage(withBlur: false, fullScreen: false)
        
        //
        // Title Colours and Blurs
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
        // Blur
        if backgroundIndex != BackgroundImages.backgroundImageArray.count {
            Warmup.backgroundColor = Colors.dark.withAlphaComponent(0.72)
            Workout.backgroundColor = Colors.dark.withAlphaComponent(0.72)
            Cardio.backgroundColor = Colors.dark.withAlphaComponent(0.72)
            Stretching.backgroundColor = Colors.dark.withAlphaComponent(0.72)
            Yoga.backgroundColor = Colors.dark.withAlphaComponent(0.72)
            Meditation.backgroundColor = Colors.dark.withAlphaComponent(0.72)
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
        navigationBar.title = NSLocalizedString("sessions", comment: "")
        // Appearance
        self.navigationController?.navigationBar.tintColor = Colors.light
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBar]
        self.navigationController?.navigationBar.barTintColor = Colors.dark
        self.tabBarController?.tabBar.barTintColor = Colors.dark
        UITabBar.appearance().barTintColor = Colors.dark
        tabBarController?.tabBar.barStyle = .default
        self.tabBarController?.tabBar.barTintColor = Colors.dark
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
        
        // iPhone 5/SE layout
        if IPhoneType.shared.iPhoneType() == 0 {
            //
            wamupBottom.constant = 8
            //
            bodyTop.constant = 4
            bodyBottom.constant = 2
            mindTop.constant = 2
            mindBottom.constant = 4
            //
            yogaBottom.constant = 13
            meditationBottom.constant = 15
        // iPhoneX Layout
        } else if IPhoneType.shared.iPhoneType() == 2 {
            //
            wamupBottom.constant = 30
            //
            bodyTop.constant = 15
            bodyBottom.constant = 10
            mindTop.constant = 10
            mindBottom.constant = 13
            //
            yogaBottom.constant = 35
            meditationBottom.constant = 35
        // iPad Layout
        } else if IPhoneType.shared.iPhoneType() == 3 {
            //
            //
            bodyTop.constant = 15
            bodyBottom.constant = 10
            mindTop.constant = 10
            mindBottom.constant = 13
            //
            yogaBottom.constant = 35
            meditationBottom.constant = 35
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Remove back button text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}

class MindBodyNavigation: UINavigationController {
}

