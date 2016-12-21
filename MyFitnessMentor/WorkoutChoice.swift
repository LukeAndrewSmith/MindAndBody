//
//  WorkoutChoice1.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class WorkoutChoice: UIViewController  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Gym
    @IBOutlet weak var gym: UIButton!
    
    // Home
    @IBOutlet weak var home: UIButton!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        // Titles
        navigationBar.title = (NSLocalizedString("workout", comment: ""))
        
        // Button Titles
        gym.setTitle(NSLocalizedString("gym", comment: ""), for: UIControlState.normal)
        gym.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        gym.titleLabel!.textColor = .white
        gym.layer.borderWidth = 10
        gym.layer.borderColor = UIColor.white.cgColor
        gym.layer.cornerRadius = self.gym.frame.size.height / 2
        
        home.setTitle(NSLocalizedString("home", comment: ""), for: UIControlState.normal)
        home.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        home.titleLabel!.textColor = .white
        home.layer.borderWidth = 10
        home.layer.borderColor = UIColor.white.cgColor
        home.layer.cornerRadius = self.home.frame.size.height / 2
        
     
        
       
    }
    
    
    
    
    
}
