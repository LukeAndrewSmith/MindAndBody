//
//  SecondViewController.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UserDefaults {
    func color(forKey defaultName: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: defaultName) {
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }
        return color
    }
    
    func setColor(_ value: UIColor?, forKey defaultName: String) {
        var colorData: NSData?
        if let color = value {
            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
        }
        set(colorData, forKey: defaultName)
    }
}



class MindBody: UIViewController {

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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = (NSLocalizedString("mind&body", comment: ""))


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Background Colour Default
        //
        
        UserDefaults.standard.register(defaults: ["didSetColour" : false])
        
        if UserDefaults.standard.bool(forKey: "didSetColour") == false {
            // Did set
            UserDefaults.standard.set(true, forKey: "didSetColour")
            // Set Colour
            UserDefaults.standard.setColor(UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), forKey: "colour1")
            UserDefaults.standard.setColor(UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0), forKey: "colour2")
            
            UserDefaults.standard.synchronize()
            
        }
        
        // Set Colours
        
        let colour1 = UserDefaults.standard.color(forKey: "colour1")!
        let colour2 = UserDefaults.standard.color(forKey: "colour2")!

        self.view.applyGradient(colours: [colour1, colour2])
        
        
        self.navigationController?.navigationBar.tintColor = colour1
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colour1, NSFontAttributeName: UIFont(name: "SFUIDisplay-heavy", size: 23)!]
        
        calendar.tintColor = colour1
        
        self.tabBarController?.tabBar.tintColor = colour2
        
        
        
        
      
       // Title
        
        // Button Titles
        Warmup.setTitle(NSLocalizedString("warmup", comment: ""), for: UIControlState.normal)
        Warmup.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Warmup.titleLabel!.textColor = .white
        Warmup.layer.borderWidth = 10
        Warmup.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        Warmup.titleLabel?.adjustsFontSizeToFitWidth = true
        Warmup.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        Warmup.titleLabel?.numberOfLines = 0
        Warmup.titleLabel?.textAlignment = .center
        
        
        Workout.setTitle(NSLocalizedString("workout", comment: ""), for: UIControlState.normal)
        Workout.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Workout.titleLabel!.textColor = .white
        Workout.layer.borderWidth = 10
        Workout.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        Workout.titleLabel?.adjustsFontSizeToFitWidth = true
        Workout.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        Workout.titleLabel?.numberOfLines = 0
        Workout.titleLabel?.textAlignment = .center
        
        
        Stretching.setTitle(NSLocalizedString("stretching", comment: ""), for: UIControlState.normal)
        Stretching.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Stretching.titleLabel!.textColor = .white
        Stretching.layer.borderWidth = 10
        Stretching.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        Stretching.titleLabel?.adjustsFontSizeToFitWidth = true
        Stretching.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        Stretching.titleLabel?.numberOfLines = 0
        Stretching.titleLabel?.textAlignment = .center
        
        
        
        Cardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        Cardio.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Cardio.titleLabel!.textColor = .white
        Cardio.layer.borderWidth = 10
        Cardio.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        Cardio.titleLabel?.adjustsFontSizeToFitWidth = true
        Cardio.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        Cardio.titleLabel?.numberOfLines = 0
        Cardio.titleLabel?.textAlignment = .center
        
        
        
        Yoga.setTitle(NSLocalizedString("yoga", comment: ""), for: UIControlState.normal)
        Yoga.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Yoga.titleLabel!.textColor = .white
        Yoga.titleLabel!.adjustsFontSizeToFitWidth = true
        Yoga.layer.borderWidth = 10
        Yoga.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        Yoga.titleLabel?.adjustsFontSizeToFitWidth = true
        Yoga.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        Yoga.titleLabel?.numberOfLines = 0
        Yoga.titleLabel?.textAlignment = .center
        
        
        
        Meditation.setTitle(NSLocalizedString("meditation", comment: ""), for: UIControlState.normal)
        Meditation.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Meditation.titleLabel!.textColor = .white
        Meditation.layer.borderWidth = 10
        Meditation.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        Meditation.titleLabel?.adjustsFontSizeToFitWidth = true
        Meditation.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        Meditation.titleLabel?.numberOfLines = 0
        Meditation.titleLabel?.textAlignment = .center
        
        
        
        
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
        
        
        //
        // Instructions Popup View
        //
//        let defaults = UserDefaults.standard
//        defaults.register(defaults: ["alertInfo1" : false])
//        
//        if UserDefaults.standard.bool(forKey: "alertInfo1") == false {
//            
//            UserDefaults.standard.set(true, forKey: "alertInfo1")
//            
//            let alertInformation = UIAlertController(title: (NSLocalizedString("alertTitle1", comment: "")), message: (NSLocalizedString("alertMessage1", comment: "")), preferredStyle: UIAlertControllerStyle.alert)
//            
//            alertInformation.view.tintColor = .black
//            
//            alertInformation.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
//            
//            self.present(alertInformation, animated: true, completion: nil)
//            
//            
//            UITabBar.appearance().shadowImage = UIImage(named: "ShadowImageN")
//            
//        }
        
        
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
    
    
    
        
        
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }

    
}

