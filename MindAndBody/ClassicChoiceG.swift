//
//  WorkoutChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Classic Choice Class -------------------------------------------------------------------------------------------------------
//
class ClassicChoiceG: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Full Body
    @IBOutlet weak var fullBody: UIButton!
    
    // Upper Lower
    @IBOutlet weak var upperBody: UIButton!
    @IBOutlet weak var lowerBody: UIButton!
    
    
    // Stack Views
    //
    @IBOutlet weak var stackView: UIStackView!
    
    // Constraints
    @IBOutlet weak var fullTop: NSLayoutConstraint!
    //
    @IBOutlet weak var fullBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    
    @IBOutlet weak var connectionWidth: NSLayoutConstraint!
    //
    var workoutType2 = Int()
    //
    // View did load ----------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colours
        view.backgroundColor = Colors.light
        
        // Titles
        navigationBar.title = (NSLocalizedString("classic", comment: ""))
        
        // Button Titles
        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
        fullBody.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        fullBody.setTitleColor(Colors.dark, for: .normal)
        fullBody.layer.borderWidth = 5
        fullBody.layer.borderColor = Colors.dark.cgColor
        //
        upperBody.setTitle(NSLocalizedString("upperBody", comment: ""), for: UIControlState.normal)
        upperBody.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        upperBody.setTitleColor(Colors.dark, for: .normal)
        upperBody.layer.borderWidth = 5
        upperBody.layer.borderColor = Colors.dark.cgColor
        //
        lowerBody.setTitle(NSLocalizedString("lowerBody", comment: ""), for: UIControlState.normal)
        lowerBody.setTitleColor(Colors.dark, for: .normal)
        lowerBody.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        lowerBody.layer.borderWidth = 5
        lowerBody.layer.borderColor = Colors.dark.cgColor
        //
        
        
        // Iphone 5/SE
        if IPhoneType.shared.iPhoneType() == 0 {
            //
            fullTop.constant = 52
            fullBottom.constant = 52
            stackBottom.constant = 52
            //
            stackView.spacing = 15
            connectionWidth.constant = 15
        } else if IPhoneType.shared.iPhoneType() == 2 {
            //
            fullTop.constant = 102
            fullBottom.constant = 102
            stackBottom.constant = 102
            //
        }
    }
    
    //
    // View did layout subviews ---------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        fullBody.layer.cornerRadius = ((self.stackView.frame.size.height) * 3/2) / 2
        fullBody.layer.masksToBounds = true
        fullBody.titleLabel?.adjustsFontSizeToFitWidth = true
        fullBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        fullBody.titleLabel?.numberOfLines = 0
        fullBody.titleLabel?.textAlignment = .center
        //
        upperBody.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        upperBody.layer.masksToBounds = true
        upperBody.titleLabel?.adjustsFontSizeToFitWidth = true
        upperBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        upperBody.titleLabel?.numberOfLines = 0
        upperBody.titleLabel?.textAlignment = .center
        //
        lowerBody.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        lowerBody.layer.masksToBounds = true
        lowerBody.titleLabel?.adjustsFontSizeToFitWidth = true
        lowerBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        lowerBody.titleLabel?.numberOfLines = 0
        lowerBody.titleLabel?.textAlignment = .center
    }
    
    
    // Full
    @IBAction func full(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "classicGymFull"
        SelectedSession.shared.selectedSession[2] = ""
        //
        self.performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Upper
    @IBAction func upper(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "classicGymUpper"
        SelectedSession.shared.selectedSession[2] = ""
        //
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Lower
    @IBAction func lower(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "classicGymLower"
        SelectedSession.shared.selectedSession[2] = ""
        //
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
  
    // Remove back button text
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    //
}

