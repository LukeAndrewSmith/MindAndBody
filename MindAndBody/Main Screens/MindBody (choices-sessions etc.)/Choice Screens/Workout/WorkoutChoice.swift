//
//  WorkoutChoice1.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Workout Choice Class -----------------------------------------------------------------------------------------------------------
//
class WorkoutChoice: UIViewController  {
    
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // Gym
    @IBOutlet weak var gym: UIButton!
    // Home
    @IBOutlet weak var home: UIButton!
    
    //
    @IBOutlet weak var custom: UIButton!
    
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    
    //
    // Prepare for segue ----------------------------------------------------------------------------------------------------------------
    //
    // Remove back bar text from next views
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
    //
    // View did load ----------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Colours
        view.backgroundColor = Colors.light
        
        // Titles
        navigationBar.title = (NSLocalizedString("workout", comment: ""))
        
        //
        
        // Button Titles
        //
        gym.setTitle(NSLocalizedString("gym", comment: ""), for: UIControlState.normal)
        gym.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        gym.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        gym.layer.borderWidth = 5
        gym.layer.borderColor = Colors.dark.cgColor
        gym.setTitleColor(Colors.dark, for: .normal)
        //
        home.setTitle(NSLocalizedString("bodyweight", comment: ""), for: UIControlState.normal)
        home.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        home.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        home.layer.borderWidth = 5
        home.layer.borderColor = Colors.dark.cgColor
        home.setTitleColor(Colors.dark, for: .normal)
        
        //
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        custom.layer.borderWidth = 5
        custom.layer.borderColor = Colors.dark.cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,7,0,7)
        custom.titleLabel?.textAlignment = .center
        custom.setTitleColor(Colors.dark, for: .normal)
        custom.layer.cornerRadius = 49/2
        custom.layer.masksToBounds = true
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleLabel?.numberOfLines = 0
        custom.titleLabel?.textAlignment = .center
    }
    
    //
    // View did layout subview ------------------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        gym.layer.cornerRadius = ((self.stackView.frame.size.height) - 40) / 4
        gym.layer.masksToBounds = true
        gym.titleLabel?.adjustsFontSizeToFitWidth = true
        gym.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        gym.titleLabel?.numberOfLines = 0
        gym.titleLabel?.textAlignment = .center
        //
        home.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        home.layer.masksToBounds = true
        home.titleLabel?.adjustsFontSizeToFitWidth = true
        home.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        home.titleLabel?.numberOfLines = 0
        home.titleLabel?.textAlignment = .center
    }
    
    //
}

