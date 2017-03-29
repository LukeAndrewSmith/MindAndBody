//
//  SecondViewController.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



//---------------------------------------------------------------------------------------------------------------


extension UIView {

    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}


//---------------------------------------------------------------------------------------------------------------



class MindBody: UIViewController {

    
    
    
    // Background Array
    let backgroundImageArray = [#imageLiteral(resourceName: "Background 0"), #imageLiteral(resourceName: "Background 1"), #imageLiteral(resourceName: "Background 2"), #imageLiteral(resourceName: "Background 3"), #imageLiteral(resourceName: "Background 4")]
    
    
    
    
    //
    // Outlets
    //
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!

    
    // Button Outlets
    
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
    
    
    
    // Calendar
    @IBOutlet weak var calendar: UIBarButtonItem!
    
    // Tracking
    @IBOutlet weak var tracking: UIBarButtonItem!
    
    
    
    // Stack Views
    @IBOutlet weak var stackView1: UIStackView!
    
    @IBOutlet weak var stackView2: UIStackView!
    
    @IBOutlet weak var stackView3: UIStackView!
    
    
    
    // Mind Connection Label
    @IBOutlet weak var connectionLabel: UILabel!
    
    // StackView 1 bottom Constraint
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // Mind Body Constraints
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var positionConstraint: NSLayoutConstraint!
    
    // Body Constraints
    @IBOutlet weak var bodyTop: NSLayoutConstraint!
    
    @IBOutlet weak var bodyBottom: NSLayoutConstraint!
    
    // Mind Constraints
    @IBOutlet weak var mindTop: NSLayoutConstraint!
    
    @IBOutlet weak var mindBottom: NSLayoutConstraint!
    
    
    // Bottom StackView 3 Bottom Constraint
    @IBOutlet weak var stack3Bottom: NSLayoutConstraint!
    
    
    // Background Image
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    // Mind
    @IBOutlet weak var body: UILabel!
    
    // Body
    @IBOutlet weak var mind: UILabel!
    
    
    
    
    // Blurs
    let blur = UIVisualEffectView()
    let blur1 = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur3 = UIVisualEffectView()
    let blur4 = UIVisualEffectView()
    let blur5 = UIVisualEffectView()
    let blur6 = UIVisualEffectView()
    let blur7 = UIVisualEffectView()


    
    
//---------------------------------------------------------------------------------------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Status Bar
//        UserDefaults.standard.register(defaults: ["blacknWhite" : false])
//        if UserDefaults.standard.bool(forKey: "blacknWhite") == true {
//                UIApplication.shared.statusBarStyle = .lightContent
//            } else {
//                UIApplication.shared.statusBarStyle = .default
//            }
        
        UIApplication.shared.statusBarStyle = .lightContent

        
        
        // Walkthrough
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough" : false])

        
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough") == false {
        walkthroughMindBody()
        UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough")
        }
        
        
        // Register Walkthroughs
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
        
        // Register Weight
        UserDefaults.standard.register(defaults: ["units" : "kg"])
        
        // Register Presentation Style
        UserDefaults.standard.register(defaults: ["presentationStyle" : "detailed"])
        
        
        
        
        
        //
        // Background
        //
        // Register 
        UserDefaults.standard.register(defaults: ["homeScreenBackground" : 0])
        
                
        
        
        
        
        // Retrieve Colours
        let colour1 = UserDefaults.standard.color(forKey: "colour1")!
        let colour2 = UserDefaults.standard.color(forKey: "colour2")!
        let colour3 = UserDefaults.standard.color(forKey: "colour3")!
        let colour5 = UserDefaults.standard.color(forKey: "colour5")!
        
        

        self.view.applyGradient(colours: [colour1, colour2])
        
        
        
        
        
        
        // Navigation Bar
        navigationBar.title = "Mind & Body"
        
        
        self.navigationController?.navigationBar.tintColor = colour1
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colour1, NSFontAttributeName: UIFont(name: "SFUIDisplay-heavy", size: 23)!]
        self.navigationController?.navigationBar.barTintColor = colour5
        self.tabBarController?.tabBar.barTintColor = colour5
        UITabBar.appearance().barTintColor = colour5
        tabBarController?.tabBar.barStyle = .default
        self.tabBarController?.tabBar.barTintColor = colour5
        
        
        
        
        calendar.tintColor = colour1
        tracking.tintColor = colour1
        
        self.tabBarController?.tabBar.tintColor = colour2
        
        
        
        
      
        // Title
        
        
        // Button Titles
        Warmup.setTitle(NSLocalizedString("warmup", comment: ""), for: UIControlState.normal)
        Warmup.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 20)
        Warmup.layer.borderWidth = 8
        Warmup.layer.borderColor = colour3.cgColor
        Warmup.titleLabel?.adjustsFontSizeToFitWidth = true
        Warmup.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Warmup.titleLabel?.textAlignment = .center
        Warmup.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
        
        
        Workout.setTitle(NSLocalizedString("workout", comment: ""), for: UIControlState.normal)
        Workout.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 20)
        Workout.layer.borderWidth = 8
        Workout.layer.borderColor = colour3.cgColor
        Workout.titleLabel?.adjustsFontSizeToFitWidth = true
        Workout.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Workout.titleLabel?.textAlignment = .center
        Workout.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)


        
        Stretching.setTitle(NSLocalizedString("stretching", comment: ""), for: UIControlState.normal)
        Stretching.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 20)
        Stretching.layer.borderWidth = 8
        Stretching.layer.borderColor = colour3.cgColor
        Stretching.titleLabel?.adjustsFontSizeToFitWidth = true
        Stretching.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Stretching.titleLabel?.textAlignment = .center
        Stretching.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)

        
        
        
        Cardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        Cardio.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 20)
        Cardio.layer.borderWidth = 8
        Cardio.layer.borderColor = colour3.cgColor
        Cardio.titleLabel?.adjustsFontSizeToFitWidth = true
        Cardio.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Cardio.titleLabel?.textAlignment = .center
        Cardio.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)

        
        
        
        Yoga.setTitle(NSLocalizedString("yoga", comment: ""), for: UIControlState.normal)
        Yoga.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 20)
        Yoga.titleLabel!.adjustsFontSizeToFitWidth = true
        Yoga.layer.borderWidth = 8
        Yoga.layer.borderColor = colour3.cgColor
        Yoga.titleLabel?.adjustsFontSizeToFitWidth = true
        Yoga.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Yoga.titleLabel?.textAlignment = .center
        Yoga.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)

        
        
        
        Meditation.setTitle(NSLocalizedString("meditation", comment: ""), for: UIControlState.normal)
        Meditation.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 20)
        Meditation.layer.borderWidth = 8
        Meditation.layer.borderColor = colour3.cgColor
        Meditation.titleLabel?.adjustsFontSizeToFitWidth = true
        Meditation.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Meditation.titleLabel?.textAlignment = .center
        Meditation.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)

        

        // Blur and Vibranct
        let blurE = UIBlurEffect(style: .dark)
        blur.effect = blurE
        let vibrancyE = UIVibrancyEffect(blurEffect: blurE)
        blur.effect = vibrancyE
        blur.frame = Warmup.bounds
        blur.isUserInteractionEnabled = false
        Warmup.insertSubview(blur, belowSubview: Warmup.titleLabel!)
        //
        let blurE1 = UIBlurEffect(style: .dark)
        blur1.effect = blurE1
        let vibrancyE1 = UIVibrancyEffect(blurEffect: blurE1)
        blur1.effect = vibrancyE1
        blur1.frame = Workout.bounds
        blur1.isUserInteractionEnabled = false
        Workout.insertSubview(blur1, belowSubview: Workout.titleLabel!)
        //
        let blurE2 = UIBlurEffect(style: .dark)
        blur2.effect = blurE2
        let vibrancyE2 = UIVibrancyEffect(blurEffect: blurE2)
        blur2.effect = vibrancyE2
        blur2.frame = Cardio.bounds
        blur2.isUserInteractionEnabled = false
        Cardio.insertSubview(blur2, belowSubview: Cardio.titleLabel!)
        //
        let blurE3 = UIBlurEffect(style: .dark)
        blur3.effect = blurE3
        let vibrancyE3 = UIVibrancyEffect(blurEffect: blurE3)
        blur3.effect = vibrancyE3
        blur3.frame = Stretching.bounds
        blur3.isUserInteractionEnabled = false
        Stretching.insertSubview(blur3, belowSubview: Stretching.titleLabel!)
        //
        let blurE4 = UIBlurEffect(style: .dark)
        blur4.effect = blurE4
        let vibrancyE4 = UIVibrancyEffect(blurEffect: blurE4)
        blur4.effect = vibrancyE4
        blur4.frame = Yoga.bounds
        blur4.isUserInteractionEnabled = false
        Yoga.insertSubview(blur4, belowSubview: Yoga.titleLabel!)
        //
        let blurE5 = UIBlurEffect(style: .dark)
        blur5.effect = blurE5
        let vibrancyE5 = UIVibrancyEffect(blurEffect: blurE5)
        blur5.effect = vibrancyE5
        blur5.frame = Meditation.bounds
        blur5.isUserInteractionEnabled = false
        Meditation.insertSubview(blur5, belowSubview: Meditation.titleLabel!)
        
        
        // Test
        body.layer.cornerRadius = body.frame.size.height / 2
        body.layer.masksToBounds = true
        let blurE6 = UIBlurEffect(style: .dark)
        blur6.effect = blurE6
        let vibrancyE6 = UIVibrancyEffect(blurEffect: blurE6)
        blur6.effect = vibrancyE6
        blur6.frame = body.bounds
        blur6.center = body.center
        blur6.isUserInteractionEnabled = false
        blur6.layer.cornerRadius = body.frame.size.height / 2
        blur6.layer.masksToBounds = true
        view.insertSubview(blur6, belowSubview: body)
        
        //
        mind.layer.cornerRadius = mind.frame.size.height / 2
        mind.layer.masksToBounds = true
        let blurE7 = UIBlurEffect(style: .dark)
        blur7.effect = blurE7
        let vibrancyE7 = UIVibrancyEffect(blurEffect: blurE7)
        blur7.effect = vibrancyE7
        blur7.frame = mind.bounds
        blur7.center = mind.center
        blur7.isUserInteractionEnabled = false
        blur7.layer.cornerRadius = mind.frame.size.height / 2
        blur7.layer.masksToBounds = true
        view.insertSubview(blur7, belowSubview: mind)
        
        
        // Iphone 5/SE
        
        if UIScreen.main.nativeBounds.height < 1334 {
            bottomConstraint.constant = 15
            stackView3.spacing = 15
            
            heightConstraint.constant = 15
            positionConstraint.constant = -15
            
            
            bodyTop.constant = 5
            bodyBottom.constant = 2
            mindTop.constant = 5
            mindBottom.constant = 3
            
            stack3Bottom.constant = 15
            
            
           

        }
        
        if colour1 == UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0) {
            backgroundImage.image = nil
        }
        
        
        
        viewDidLayoutSubviews()
        
    }
        
        override func viewDidLayoutSubviews() {
            
            super.viewDidLayoutSubviews()
            
            
           
            
            // Button Rounded Edges
            
            Warmup.layer.cornerRadius = stackView1.frame.size.height / 2
            Warmup.layer.masksToBounds = true
            
            Workout.layer.cornerRadius = stackView1.frame.size.height / 2
            Workout.layer.masksToBounds = true
            
            Stretching.layer.cornerRadius = stackView2.frame.size.height / 2
            Stretching.layer.masksToBounds = true
            
            Cardio.layer.cornerRadius = stackView2.frame.size.height / 2
            Cardio.layer.masksToBounds = true
            
            Yoga.layer.cornerRadius =
                (stackView3.frame.size.height - 20) / 4
            Yoga.layer.masksToBounds = true
            
            Meditation.layer.cornerRadius = (stackView3.frame.size.height - 20) / 4
            Meditation.layer.masksToBounds = true
            
            
        }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")

        
        //
        // Background Image/Colour
        //
        if backgroundIndex < backgroundImageArray.count {
            //
            backgroundImage.image = backgroundImageArray[backgroundIndex]
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImage.image = nil
            backgroundImage.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        } else if backgroundIndex == backgroundImageArray.count + 1 {
            backgroundImage.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        }
        
        
        
        //
        // Title Colours and Blurs
        //
        switch backgroundIndex {
// Black
        // All Black with no blur
        case backgroundImageArray.count:
            Warmup.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            Workout.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            Cardio.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            Stretching.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            Yoga.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            Meditation.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            body.textColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            mind.textColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            
            blur.removeFromSuperview()
            blur1.removeFromSuperview()
            blur2.removeFromSuperview()
            blur3.removeFromSuperview()
            blur4.removeFromSuperview()
            blur5.removeFromSuperview()
            blur6.removeFromSuperview()
            blur7.removeFromSuperview()
            
        // All Black
        case 1,3:
            Warmup.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            Workout.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            Cardio.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            Stretching.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            Yoga.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            Meditation.setTitleColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), for: .normal)
            body.textColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            mind.textColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            
            Warmup.insertSubview(blur, belowSubview: Warmup.titleLabel!)
            Workout.insertSubview(blur1, belowSubview: Workout.titleLabel!)
            Cardio.insertSubview(blur2, belowSubview: Cardio.titleLabel!)
            Stretching.insertSubview(blur3, belowSubview: Stretching.titleLabel!)
            Yoga.insertSubview(blur4, belowSubview: Yoga.titleLabel!)
            Meditation.insertSubview(blur5, belowSubview: Meditation.titleLabel!)
            view.insertSubview(blur6, belowSubview: body)
            view.insertSubview(blur7, belowSubview: mind)
            
// White
        // All White
        case 4:
            Warmup.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Workout.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Cardio.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Stretching.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Yoga.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Meditation.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            body.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            mind.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            
            
            Warmup.insertSubview(blur, belowSubview: Warmup.titleLabel!)
            Workout.insertSubview(blur1, belowSubview: Workout.titleLabel!)
            Cardio.insertSubview(blur2, belowSubview: Cardio.titleLabel!)
            Stretching.insertSubview(blur3, belowSubview: Stretching.titleLabel!)
            Yoga.insertSubview(blur4, belowSubview: Yoga.titleLabel!)
            Meditation.insertSubview(blur5, belowSubview: Meditation.titleLabel!)
            view.insertSubview(blur6, belowSubview: body)
            view.insertSubview(blur7, belowSubview: mind)
            
        // White Text with white mind and body and no blur
        case backgroundImageArray.count + 1:
            Warmup.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Workout.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Cardio.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Stretching.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Yoga.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Meditation.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            body.textColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            mind.textColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            
            blur.removeFromSuperview()
            blur1.removeFromSuperview()
            blur2.removeFromSuperview()
            blur3.removeFromSuperview()
            blur4.removeFromSuperview()
            blur5.removeFromSuperview()
            blur6.removeFromSuperview()
            blur7.removeFromSuperview()

            
        // White Text, Black body, White mind
        case 0:
            Warmup.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Workout.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Cardio.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Stretching.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Yoga.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Meditation.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            body.textColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            mind.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            
            Warmup.insertSubview(blur, belowSubview: Warmup.titleLabel!)
            Workout.insertSubview(blur1, belowSubview: Workout.titleLabel!)
            Cardio.insertSubview(blur2, belowSubview: Cardio.titleLabel!)
            Stretching.insertSubview(blur3, belowSubview: Stretching.titleLabel!)
            Yoga.insertSubview(blur4, belowSubview: Yoga.titleLabel!)
            Meditation.insertSubview(blur5, belowSubview: Meditation.titleLabel!)
            view.insertSubview(blur6, belowSubview: body)
            view.insertSubview(blur7, belowSubview: mind)
           
            
        // White Text, Black mind, White body
        case 2:
            Warmup.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Workout.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Cardio.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Stretching.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Yoga.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            Meditation.setTitleColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), for: .normal)
            body.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            mind.textColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
            
            Warmup.insertSubview(blur, belowSubview: Warmup.titleLabel!)
            Workout.insertSubview(blur1, belowSubview: Workout.titleLabel!)
            Cardio.insertSubview(blur2, belowSubview: Cardio.titleLabel!)
            Stretching.insertSubview(blur3, belowSubview: Stretching.titleLabel!)
            Yoga.insertSubview(blur4, belowSubview: Yoga.titleLabel!)
            Meditation.insertSubview(blur5, belowSubview: Meditation.titleLabel!)
            view.insertSubview(blur6, belowSubview: body)
            view.insertSubview(blur7, belowSubview: mind)
            
        //
        default: break
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")

        if backgroundIndex == backgroundImageArray.count + 1 {
            for i in backgroundImage.layer.sublayers! {
                i.removeFromSuperlayer()
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
    }

    
    
    
    
    
    
    
//---------------------------------------------------------------------------------------------------------------
    
    // Countdown
    var time = 7
    let countdownLabel = UILabel()
    
    //
    // Update Timer
    func updateTimer() {
        if time == 0 {
            
            countdownLabel.text = "0"
            
        } else {
            
            time -= 1
            countdownLabel.text = String(time)
            
        }
    }
    
    
    
    var  viewNumber = 0
    let walkthroughView = UIView()
    let label = UILabel()
    let nextButton = UIButton()
    let backButton = UIButton()


    
    // Walkthrough
    func walkthroughMindBody() {
       
        //
        let screenSize = UIScreen.main.bounds
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height

        //
        walkthroughView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        walkthroughView.backgroundColor = .black
        walkthroughView.alpha = 0.72
        walkthroughView.clipsToBounds = true
        //
        
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        label.center = view.center
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "SFUIDisplay-light", size: 22)
        label.textColor = .white
        
        //
        nextButton.frame = screenSize
        nextButton.backgroundColor = .clear
        nextButton.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)

        //
        backButton.frame = CGRect(x: 3, y: UIApplication.shared.statusBarFrame.height, width: 50, height: navigationBarHeight)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.textAlignment = .left
        backButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        backButton.titleLabel?.textColor = .white
        backButton.addTarget(self, action: #selector(backWalkthroughView(_:)), for: .touchUpInside)
        
        
        switch viewNumber {
        case 0:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: view.frame.size.width/2 - 80, y: UIApplication.shared.statusBarFrame.height, width: 160, height: 40))
            path.addRect(walkthroughView.frame)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("mindBody0", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)


            
//
        
        case 1:
            //
            
            nextButton.isEnabled = false
            backButton.isEnabled = false
            
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: view.frame.size.width/2 - 80, y: UIApplication.shared.statusBarFrame.height, width: 160, height: 40))
            path.addRect(walkthroughView.frame)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("mindBody1", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
            // CountDown
            //
            time = 7
            //
            countdownLabel.frame = CGRect(x: 0, y: 0, width: 49, height: 49)
            countdownLabel.text = String(time)
            countdownLabel.center.x = self.view.frame.size.width - 24.5
            countdownLabel.center.y = self.view.frame.size.height - 24.5 + navigationBarHeight + UIApplication.shared.statusBarFrame.height + tabBarHeight!
            countdownLabel.textAlignment = .center
            countdownLabel.numberOfLines = 0
            countdownLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            countdownLabel.font = UIFont(name: "SFUIDisplay-light", size: 22)
            countdownLabel.textColor = .white
            
            walkthroughView.addSubview(countdownLabel)

            
            
            let countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
            
        
            
            
            let delayInSeconds = 7.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.nextButton.isEnabled = true
                self.backButton.isEnabled = true
                countdownTimer.invalidate()
                self.countdownLabel.removeFromSuperview()
                
            }
            
        //
        case 2:
            //
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width * 0.917, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            //
            
            label.text = NSLocalizedString("mindBody2", comment: "")
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)

            
            
//
        case 3:
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: stackView1.center.x - 10 - (Warmup.frame.size.width / 2), y: stackView1.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.height), radius: Warmup.frame.width / 2, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(walkthroughView.frame)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            //
            
            label.text = NSLocalizedString("mindBody3", comment: "")
            
            label.center = stackView3.center
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)

            
  
            
//
        case 4:
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: (view.frame.width / 4) - ((view.frame.width / 4) * 1/3 ), y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + view.frame.size.height + (tabBarHeight! / 2)), radius: 23, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(walkthroughView.frame)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            //
            
            label.text = NSLocalizedString("mindBody4", comment: "")
            
            label.center = view.center
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)

            
            
            
//
        case 5:
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.center.x, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + view.frame.size.height + (tabBarHeight! / 2)), radius: 23, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(walkthroughView.frame)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            //
            
            label.text = NSLocalizedString("mindBody5", comment: "")
            
            label.center = view.center
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            

            
            
            
        //
        case 6:
          
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: ((view.frame.width / 4) * 3) + ((view.frame.width / 4) * 1/3 ), y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + view.frame.size.height + (tabBarHeight! / 2)), radius: 23, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(walkthroughView.frame)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            //
            
            label.text = NSLocalizedString("mindBody6", comment: "")
            
            label.center = view.center
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
        //
        default: break
            
            
        }
        
        
    }
    
    
    
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    
    
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber - 1
        walkthroughMindBody()
        }
        
    }
    
    
}
