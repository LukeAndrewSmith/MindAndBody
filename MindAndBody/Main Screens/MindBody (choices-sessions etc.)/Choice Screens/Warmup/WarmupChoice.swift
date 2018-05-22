//
//  MyWarmupOverview.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 28/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Warmup Choice Class ------------------------------------------------------------------------------------------------------------------------
//
class WarmupChoice: UIViewController, UIScrollViewDelegate  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // Workout
    @IBOutlet weak var workout: UIButton!
    // Cardio
    @IBOutlet weak var cardio: UIButton!
    // Flexibility
    @IBOutlet weak var flexibility: UIButton!
    //
    //
    @IBOutlet weak var custom: UIButton!
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    // Constraints
    @IBOutlet weak var workoutTop: NSLayoutConstraint!
    //
    @IBOutlet weak var workoutBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var connectionLabelWidth: NSLayoutConstraint!
    //
    @IBOutlet weak var connectionLabelTrailing: NSLayoutConstraint!
    
    
    
    //
    // View Did Load ---------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        CustomWalkthrough.shared.beginWalkthrough(viewController: self, customButton: custom)
        
        // Colours
        view.backgroundColor = Colors.light
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("warmup", comment: ""))
        
        // Button Titles
        workout.setTitle(NSLocalizedString("workout", comment: ""), for: UIControlState.normal)
        workout.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        workout.setTitleColor(Colors.dark, for: .normal)
        workout.layer.borderWidth = 5
        workout.layer.borderColor = Colors.dark.cgColor
        //
        cardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        cardio.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        cardio.setTitleColor(Colors.dark, for: .normal)
        cardio.layer.borderWidth = 5
        cardio.layer.borderColor = Colors.dark.cgColor
        //
        flexibility.setTitle(NSLocalizedString("stretchingYoga", comment: ""), for: UIControlState.normal)
        flexibility.setTitleColor(Colors.dark, for: .normal)
        flexibility.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        flexibility.layer.borderWidth = 5
        flexibility.layer.borderColor = Colors.dark.cgColor
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
        //
        
        // Iphone 5/SE
        if IPhoneType.shared.iPhoneType() == 0 {
            //
            workoutTop.constant = 52
            workoutBottom.constant = 52
            stackBottom.constant = 52
            //
            stackView.spacing = 15
            connectionLabelWidth.constant = 15
            connectionLabelTrailing.constant = 15
        } else if IPhoneType.shared.iPhoneType() == 2 {
            //
            workoutTop.constant = 102
            workoutBottom.constant = 102
            stackBottom.constant = 102
            //
        }
    }
    
    //
    // View Did Layout Subviews -----------------------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        workout.layer.cornerRadius = ((self.stackView.frame.size.height) * 3/2) / 2
        workout.layer.masksToBounds = true
        workout.titleLabel?.adjustsFontSizeToFitWidth = true
        workout.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        workout.titleLabel?.numberOfLines = 0
        workout.titleLabel?.textAlignment = .center
        //
        cardio.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        cardio.layer.masksToBounds = true
        cardio.titleLabel?.adjustsFontSizeToFitWidth = true
        cardio.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        cardio.titleLabel?.numberOfLines = 0
        cardio.titleLabel?.textAlignment = .center
        //
        flexibility.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        flexibility.layer.masksToBounds = true
        flexibility.titleLabel?.adjustsFontSizeToFitWidth = true
        flexibility.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        flexibility.titleLabel?.numberOfLines = 0
        flexibility.titleLabel?.textAlignment = .center
    }
    
    //
    // Button Segues ----------------------------------------------------------------------------------------------------------------
    //
    // Indicate to next screen which button was pressed
    var warmupType = Int()
    // Wamrup
    @IBAction func workout(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "workout"
        SelectedSession.shared.selectedSession[2] = ""
        //
        performSegue(withIdentifier: "warmupSegue", sender: nil)
    }
    // Cardio
    @IBAction func cardio(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "cardio"
        SelectedSession.shared.selectedSession[2] = ""
        //
        performSegue(withIdentifier: "warmupSegue", sender: nil)
    }
    // Flexibility
    @IBAction func flexibility(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "stretching"
        SelectedSession.shared.selectedSession[2] = ""
        //
        performSegue(withIdentifier: "warmupSegue", sender: nil)
    }
    
    // Pass data and remove back bar text on next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Remove back bar text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    //
}

