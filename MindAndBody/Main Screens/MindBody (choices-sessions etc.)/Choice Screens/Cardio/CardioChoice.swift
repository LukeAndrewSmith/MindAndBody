//
//  CardioChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Cardio Choice Class ---------------------------------------------------------------------------------------------------------
//
class CardioChoice: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Hiit
    @IBOutlet weak var hiit: UIButton!
    // Bodyweight workout
    @IBOutlet weak var bodyweight: UIButton!
    // Custom
    @IBOutlet weak var custom: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    //
    // View did load -----------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colours
        view.backgroundColor = Colors.light
        
        // Titles
        navigationBar.title = (NSLocalizedString("cardio", comment: ""))
        
        // Button Titles
        hiit.setTitle(NSLocalizedString("hiit", comment: ""), for: UIControlState.normal)
        hiit.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        hiit.setTitleColor(Colors.dark, for: .normal)
        hiit.layer.borderWidth = 5
        hiit.layer.borderColor = Colors.dark.cgColor
        hiit.titleLabel?.adjustsFontSizeToFitWidth = true
        hiit.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        hiit.titleLabel?.textAlignment = .center
        //
        bodyweight.setTitle(NSLocalizedString("bodyweightCardio", comment: ""), for: UIControlState.normal)
        bodyweight.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        bodyweight.setTitleColor(Colors.dark, for: .normal)
        bodyweight.layer.borderWidth = 5
        bodyweight.layer.borderColor = Colors.dark.cgColor
        bodyweight.titleLabel?.adjustsFontSizeToFitWidth = true
        bodyweight.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        bodyweight.titleLabel?.textAlignment = .center
        //
        custom.setTitle("C", for: .normal)
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        custom.layer.borderWidth = 5
        custom.layer.borderColor = Colors.dark.cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        custom.titleLabel?.textAlignment = .center
        custom.setTitleColor(Colors.dark, for: .normal)
        custom.layer.cornerRadius = 49/2
        custom.layer.masksToBounds = true
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        custom.titleLabel?.numberOfLines = 0
        custom.titleLabel?.textAlignment = .center
        //
        
    }
    
    
    //
    // View did layout subviews  ---------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        hiit.layer.cornerRadius = ((self.stackView.frame.size.height) - 40) / 4
        hiit.layer.masksToBounds = true
        hiit.titleLabel?.adjustsFontSizeToFitWidth = true
        hiit.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        hiit.titleLabel?.numberOfLines = 0
        hiit.titleLabel?.textAlignment = .center
        //
        bodyweight.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        bodyweight.layer.masksToBounds = true
        bodyweight.titleLabel?.adjustsFontSizeToFitWidth = true
        bodyweight.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        bodyweight.titleLabel?.numberOfLines = 0
        bodyweight.titleLabel?.textAlignment = .center
        
        // Walkthrough
        CustomWalkthrough.shared.beginWalkthrough(viewController: self, customButton: custom)
    }
    
    // Hiit action handled in storyboard, only segues to next choice
    
    // Bodyweight Workout Action
    @IBAction func bodyweight(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "bodyweight"
        SelectedSession.shared.selectedSession[2] = ""
        //
    }
    
    
    //
    // Remove back bar text
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
}

