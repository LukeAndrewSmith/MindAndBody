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



class MyFitnessPlan: UIViewController {

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
    @IBOutlet weak var Mindfulness: UIButton!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = (NSLocalizedString("mind&body", comment: ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        // Alert
        let defaults = UserDefaults.standard
        defaults.register(defaults: ["alertInfo1" : false])
        
        if UserDefaults.standard.bool(forKey: "alertInfo1") == false {
            
            UserDefaults.standard.set(true, forKey: "alertInfo1")
            
            let alertInformation = UIAlertController(title: (NSLocalizedString("alertTitle1", comment: "")), message: (NSLocalizedString("alertMessage1", comment: "")), preferredStyle: UIAlertControllerStyle.alert)
            
            alertInformation.view.tintColor = .black
            
            alertInformation.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertInformation, animated: true, completion: nil)
            
            
//            self.tabBarController?.appearance().shadowImage = UIImage.colorForNavBar(UIColor(red:0.34, green:0.69, blue:0.88, alpha:1.0))
            UITabBar.appearance().shadowImage = UIImage(named: "ShadowImageN")
            
        }

        
        
       // Title
        
       
        // Button Titles
        Warmup.setTitle(NSLocalizedString("warmup", comment: ""), for: UIControlState.normal)
        Warmup.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Warmup.titleLabel!.textColor = .white
        Warmup.layer.borderWidth = 10
        Warmup.layer.borderColor = UIColor.white.cgColor
        Warmup.layer.cornerRadius = self.Warmup.frame.size.height / 2
            //(view.frame.size.width * 0.4) / 2
        
        Workout.setTitle(NSLocalizedString("workout", comment: ""), for: UIControlState.normal)
        Workout.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Workout.titleLabel!.textColor = .white
        Workout.layer.borderWidth = 10
        Workout.layer.borderColor = UIColor.white.cgColor
        Workout.layer.cornerRadius = (view.frame.size.width * 0.4) / 2

        
        Stretching.setTitle(NSLocalizedString("stretching", comment: ""), for: UIControlState.normal)
        Stretching.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Stretching.titleLabel!.textColor = .white
        Stretching.layer.borderWidth = 10
        Stretching.layer.borderColor = UIColor.white.cgColor
        Stretching.layer.cornerRadius = (view.frame.size.width * 0.4) / 2

        
        
        Cardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        Cardio.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Cardio.titleLabel!.textColor = .white
        Cardio.layer.borderWidth = 10
        Cardio.layer.borderColor = UIColor.white.cgColor
        Cardio.layer.cornerRadius = (view.frame.size.width * 0.4) / 2

       
        
        Yoga.setTitle(NSLocalizedString("yoga", comment: ""), for: UIControlState.normal)
        Yoga.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Yoga.titleLabel!.textColor = .white
        Yoga.layer.borderWidth = 10
        Yoga.layer.borderColor = UIColor.white.cgColor
        Yoga.layer.cornerRadius = ((view.frame.size.width * 0.8) / 8)

        
        Mindfulness.setTitle(NSLocalizedString("mindfulness", comment: ""), for: UIControlState.normal)
        Mindfulness.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Mindfulness.titleLabel!.textColor = .white
        Mindfulness.layer.borderWidth = 10
        Mindfulness.layer.borderColor = UIColor.white.cgColor
        Mindfulness.layer.cornerRadius = ((view.frame.size.width * 0.8) / 8)
        
        
        
        
        
    }

    // Default workout test
    var fullBodyMale: [String : Int] =
    [
        // Compound
        "Legs": 3,
        "Pull": 2,
        "Push": 2,
        // Isolation
        //Legs
        "Quadriceps": 0,
        "Hamstrings": 0,
        "Glutes": 0,
        // Pull
        "Biceps": 1,
        //Push
        "Triceps": 1,
        "Deltoids": 1,
        // Other
        "Calves": 1,
        "Abs": 1
    ]
    
    
    // Workout func test
    func fullBodyWorkout() {
        
    }
    
    

    
}

