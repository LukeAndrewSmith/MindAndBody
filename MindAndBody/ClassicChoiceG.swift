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
    
    // Legs Pull Push
    @IBOutlet weak var legs: UIButton!
    @IBOutlet weak var pull: UIButton!
    @IBOutlet weak var push: UIButton!
    
    // Stack Views
    @IBOutlet weak var stackView1: UIStackView!
    //
    @IBOutlet weak var stackView2: UIStackView!
    
    // Constraints
    @IBOutlet weak var fullTop: NSLayoutConstraint!
    //
    @IBOutlet weak var fullBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var stack1Bottom: NSLayoutConstraint!
    //
    @IBOutlet weak var stack2Bottom: NSLayoutConstraint!
    //
    @IBOutlet weak var connection1Width: NSLayoutConstraint!
    //
    @IBOutlet weak var connection2Width: NSLayoutConstraint!
    //
    @IBOutlet weak var connection2Trailing: NSLayoutConstraint!
    //
    @IBOutlet weak var connection3Width: NSLayoutConstraint!
    //
    @IBOutlet weak var connection3Trailing: NSLayoutConstraint!
    
    //
    var workoutType2 = Int()
    //
    // View did load ----------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colours
        view.backgroundColor = Colours.colour1
        
        // Titles
        navigationBar.title = (NSLocalizedString("classic", comment: ""))
        
        // Button Titles
        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
        fullBody.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        fullBody.setTitleColor(Colours.colour2, for: .normal)
        fullBody.layer.borderWidth = 5
        fullBody.layer.borderColor = Colours.colour2.cgColor
        fullBody.titleLabel?.adjustsFontSizeToFitWidth = true
        fullBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        fullBody.titleLabel?.textAlignment = .center
        // Change title if iPhone SE/5
        if IPhoneType.shared.iPhoneType() == 0 {
            upperBody.setTitle(NSLocalizedString("upper", comment: ""), for: UIControlState.normal)
            lowerBody.setTitle(NSLocalizedString("lower", comment: ""), for: UIControlState.normal)
        } else {
            upperBody.setTitle(NSLocalizedString("upperBody", comment: ""), for: UIControlState.normal)
            lowerBody.setTitle(NSLocalizedString("lowerBody", comment: ""), for: UIControlState.normal)
        }
        //
        upperBody.setTitle(NSLocalizedString("upper", comment: ""), for: UIControlState.normal)
        upperBody.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        upperBody.setTitleColor(Colours.colour2, for: .normal)
        upperBody.layer.borderWidth = 5
        upperBody.layer.borderColor = Colours.colour2.cgColor
        upperBody.titleLabel?.adjustsFontSizeToFitWidth = true
        upperBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        upperBody.titleLabel?.textAlignment = .center
        //
        lowerBody.setTitle(NSLocalizedString("lower", comment: ""), for: UIControlState.normal)
        lowerBody.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        lowerBody.setTitleColor(Colours.colour2, for: .normal)
        lowerBody.layer.borderWidth = 5
        lowerBody.layer.borderColor = Colours.colour2.cgColor
        lowerBody.titleLabel?.adjustsFontSizeToFitWidth = true
        lowerBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        lowerBody.titleLabel?.textAlignment = .center
        //
        legs.setTitle(NSLocalizedString("legs", comment: ""), for: UIControlState.normal)
        legs.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        legs.setTitleColor(Colours.colour2, for: .normal)
        legs.layer.borderWidth = 5
        legs.layer.borderColor = Colours.colour2.cgColor
        legs.titleLabel?.adjustsFontSizeToFitWidth = true
        legs.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        legs.titleLabel?.textAlignment = .center
        //
        pull.setTitle(NSLocalizedString("pull", comment: ""), for: UIControlState.normal)
        pull.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        pull.setTitleColor(Colours.colour2, for: .normal)
        pull.layer.borderWidth = 5
        pull.layer.borderColor = Colours.colour2.cgColor
        pull.titleLabel?.adjustsFontSizeToFitWidth = true
        pull.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        pull.titleLabel?.textAlignment = .center
        //
        push.setTitle(NSLocalizedString("push", comment: ""), for: UIControlState.normal)
        push.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        push.setTitleColor(Colours.colour2, for: .normal)
        push.layer.borderWidth = 5
        push.layer.borderColor = Colours.colour2.cgColor
        push.titleLabel?.adjustsFontSizeToFitWidth = true
        push.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        push.titleLabel?.textAlignment = .center
        
        
        // Iphone 5/SE
        if IPhoneType.shared.iPhoneType() == 0 {
            //
            fullTop.constant = 20
            fullBottom.constant = 20
            stack1Bottom.constant = 20
            stack2Bottom.constant = 20
            //
            stackView1.spacing = 15
            connection1Width.constant = 15
            //
            stackView2.spacing = 10
            connection2Width.constant = 10
            connection2Trailing.constant = 10
            connection3Width.constant = 10
            connection3Trailing.constant = 10
        } else if IPhoneType.shared.iPhoneType() == 2 {
            //
            //
            fullTop.constant = 60
            fullBottom.constant = 60
            stack1Bottom.constant = 60
            stack2Bottom.constant = 60
            //
        }
    }
    
    //
    // View did layout subviews ---------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        fullBody.layer.cornerRadius = fullBody.frame.size.height / 2
        fullBody.layer.masksToBounds = true
        //
        upperBody.layer.cornerRadius = stackView1.frame.size.height / 2
        upperBody.layer.masksToBounds = true
        //
        lowerBody.layer.cornerRadius = stackView1.frame.size.height / 2
        lowerBody.layer.masksToBounds = true
        //
        legs.layer.cornerRadius = stackView2.frame.size.height / 2
        legs.layer.masksToBounds = true
        //
        pull.layer.cornerRadius = stackView2.frame.size.height / 2
        pull.layer.masksToBounds = true
        //
        push.layer.cornerRadius = stackView2.frame.size.height / 2
        push.layer.masksToBounds = true
    }
    
    
    // Full
    @IBAction func full(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = 0
        SelectedSession.shared.selectedSession[2] = -1
        //
        self.performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Upper
    @IBAction func upper(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = 1
        SelectedSession.shared.selectedSession[2] = -1
        //
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Lower
    @IBAction func lower(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = 2
        SelectedSession.shared.selectedSession[2] = -1
        //
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Legs
    @IBAction func legs(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = 3
        SelectedSession.shared.selectedSession[2] = -1
        //
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Pull
    @IBAction func pull(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = 4
        SelectedSession.shared.selectedSession[2] = -1
        //
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Push
    @IBAction func push(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = 5
        SelectedSession.shared.selectedSession[2] = -1
        //
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    
    //
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

