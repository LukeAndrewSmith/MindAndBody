//
//  StretchingChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Stretching choice class -----------------------------------------------------------------------------------------------------
//
class StretchingChoice: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var postWorkout: UIButton!
    //
    @IBOutlet weak var postCardio: UIButton!
    //
    @IBOutlet weak var general: UIButton!
    //
    @IBOutlet weak var custom: UIButton!
    
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    
    // Constraints
    @IBOutlet weak var generalTop: NSLayoutConstraint!
    //
    @IBOutlet weak var generalBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var connectionWidth: NSLayoutConstraint!
    //
    @IBOutlet weak var connectionTrailing: NSLayoutConstraint!
    
    
//
// View did load -------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Colours
        view.backgroundColor = colour1
        
        // Titles
        navigationBar.title = (NSLocalizedString("stretching", comment: ""))
        
        // Button Titles
        general.setTitle(NSLocalizedString("general", comment: ""), for: UIControlState.normal)
        general.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        general.setTitleColor(colour2, for: .normal)
        general.layer.borderWidth = 5
        general.layer.borderColor = colour2.cgColor
        //
        postWorkout.setTitle(NSLocalizedString("postWorkout", comment: ""), for: UIControlState.normal)
        postWorkout.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        postWorkout.setTitleColor(colour2, for: .normal)
        postWorkout.layer.borderWidth = 5
        postWorkout.layer.borderColor = colour2.cgColor
        //
        postCardio.setTitle(NSLocalizedString("postCardio", comment: ""), for: UIControlState.normal)
        postCardio.setTitleColor(colour2, for: .normal)
        postCardio.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        postCardio.layer.borderWidth = 5
        postCardio.layer.borderColor = colour2.cgColor
        //
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        custom.layer.borderWidth = 5
        custom.layer.borderColor = colour2.cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,7,0,7)
        custom.titleLabel?.textAlignment = .center
        custom.setTitleColor(colour2, for: .normal)
        custom.layer.cornerRadius = 49/2
        custom.layer.masksToBounds = true
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleLabel?.numberOfLines = 0
        custom.titleLabel?.textAlignment = .center
        //
        
        // Iphone 5/SE
        if UIScreen.main.nativeBounds.height < 1334 {
            //
            generalTop.constant = 52
            generalBottom.constant = 52
            stackBottom.constant = 52
            //
            stackView.spacing = 15
            connectionWidth.constant = 15
            connectionTrailing.constant = 15
        }
    }
    
    // Layout Subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        general.layer.cornerRadius = ((self.stackView.frame.size.height) * 3/2) / 2
        general.layer.masksToBounds = true
        general.titleLabel?.adjustsFontSizeToFitWidth = true
        general.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        general.titleLabel?.numberOfLines = 0
        general.titleLabel?.textAlignment = .center
        //
        postWorkout.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        postWorkout.layer.masksToBounds = true
        postWorkout.titleLabel?.adjustsFontSizeToFitWidth = true
        postWorkout.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        postWorkout.titleLabel?.numberOfLines = 0
        postWorkout.titleLabel?.textAlignment = .center
        //
        postCardio.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        postCardio.layer.masksToBounds = true
        postCardio.titleLabel?.adjustsFontSizeToFitWidth = true
        postCardio.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        postCardio.titleLabel?.numberOfLines = 0
        postCardio.titleLabel?.textAlignment = .center
    }

    
//
// Stretching type segues ---------------------------------------------------------------------------------------------------------
//
    // Indicate to next screen which button pressed
    var stretchingType = Int()
    // General
    @IBAction func general(_ sender: Any) {
        selectedSession[1] = 0
        selectedSession[2] = -1
        //
        performSegue(withIdentifier: "stretchingSegue", sender: nil)
    }
    // Post-Workout
    @IBAction func postWorkout(_ sender: Any) {
        selectedSession[1] = 1
        selectedSession[2] = -1
        //
        performSegue(withIdentifier: "stretchingSegue", sender: nil)
    }
    // Post-Cardio
    @IBAction func postCardio(_ sender: Any) {
        selectedSession[1] = 2
        selectedSession[2] = -1
        //
        performSegue(withIdentifier: "stretchingSegue", sender: nil)
    }
    
    
//
// Remove Back Bar Text
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if (segue.identifier == "customSegueWarmup") {
            let destinationVC = segue.destination as! FinalChoiceCustom
            destinationVC.selectedType = 0
        }
        
        // Remove Back Bar Text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
}
    
