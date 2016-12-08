//
//  SecondViewController.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class MyFitnessPlan: UIViewController {

    // Button Outlets
    
    // MyWarmup
    @IBOutlet weak var myWarmup: UIButton!
    
    // MyWorkout
    @IBOutlet weak var myWorkout: UIButton!
    
    // MyStretching
    @IBOutlet weak var myStretching: UIButton!
    
    // MyCardio
    @IBOutlet weak var myCardio: UIButton!
    
    // Workout Number
    @IBOutlet weak var workoutNumber: UILabel!
    
    // Arrow Label
    @IBOutlet weak var arrowLabel: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = (NSLocalizedString("myGymGuide", comment: ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
        myWarmup.setTitle(NSLocalizedString("warmup", comment: ""), for: UIControlState.normal)
        myWarmup.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 18)
        
        
        myWorkout.setTitle(NSLocalizedString("workout", comment: ""), for: UIControlState.normal)
        myWorkout.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 18)
        
        myStretching.setTitle(NSLocalizedString("stretching", comment: ""), for: UIControlState.normal)
        myStretching.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 18)
        
        myCardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        myCardio.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 18)
       
        // Workout Number
        workoutNumber.text = NSLocalizedString("workoutNumber", comment: "")
        workoutNumber.font = UIFont(name: "SFUIText-Italic", size: 15)
        workoutNumber.sizeToFit()
        
        
        
        
        
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

