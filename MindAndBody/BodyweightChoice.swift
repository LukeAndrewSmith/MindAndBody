//
//  BodyweightChoice.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Bodyweight Choice Class -------------------------------------------------------------------------------------------------------
//
class BodyweightChoice: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var fullBody: UIButton!
    //
    @IBOutlet weak var upperBody: UIButton!
    //
    @IBOutlet weak var lowerBody: UIButton!
    //
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    // Constraints
    @IBOutlet weak var fullBodyTop: NSLayoutConstraint!
    //
    @IBOutlet weak var fullBodyBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var connectionWidth: NSLayoutConstraint!
    //
    @IBOutlet weak var connectionTrailing: NSLayoutConstraint!
    
    
    //
    var workoutType = Int()
    //
    // View did load ----------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colours
        view.backgroundColor = Colours.colour1
        
        // Titles
        if workoutType == 0 {
            navigationBar.title = (NSLocalizedString("classic", comment: ""))
        } else if workoutType == 1 {
            navigationBar.title = (NSLocalizedString("circuit", comment: ""))
        }
        
        // Button Titles
        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
        fullBody.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        fullBody.setTitleColor(Colours.colour2, for: .normal)
        fullBody.layer.borderWidth = 5
        fullBody.layer.borderColor = Colours.colour2.cgColor
        //
        upperBody.setTitle(NSLocalizedString("upperBody", comment: ""), for: UIControlState.normal)
        upperBody.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        upperBody.setTitleColor(Colours.colour2, for: .normal)
        upperBody.layer.borderWidth = 5
        upperBody.layer.borderColor = Colours.colour2.cgColor
        //
        lowerBody.setTitle(NSLocalizedString("lowerBody", comment: ""), for: UIControlState.normal)
        lowerBody.setTitleColor(Colours.colour2, for: .normal)
        lowerBody.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        lowerBody.layer.borderWidth = 5
        lowerBody.layer.borderColor = Colours.colour2.cgColor
        //
        
        
        // Iphone 5/SE
        if IPhoneType.shared.iPhoneType() == 0 {
            //
            fullBodyTop.constant = 52
            fullBodyBottom.constant = 52
            stackBottom.constant = 52
            //
            stackView.spacing = 15
            connectionWidth.constant = 15
            connectionTrailing.constant = 15
        } else if IPhoneType.shared.iPhoneType() == 2 {
            //
            fullBodyTop.constant = 102
            fullBodyBottom.constant = 102
            stackBottom.constant = 102
            //
        }
    }
    
    
    //
    // View did layout subviews ----------------------------------------------------------------------------------------------------------------
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
        if workoutType == 0 {
            SelectedSession.shared.selectedSession[1] = 10
            SelectedSession.shared.selectedSession[2] = -1
        } else {
            SelectedSession.shared.selectedSession[1] = 13
            SelectedSession.shared.selectedSession[2] = -1
        }
        //
        performSegue(withIdentifier: "bodyweightSegue", sender: nil)
    }
    
    // Upper
    @IBAction func upper(_ sender: Any) {
        if workoutType == 0 {
            SelectedSession.shared.selectedSession[1] = 11
            SelectedSession.shared.selectedSession[2] = -1
        } else {
            SelectedSession.shared.selectedSession[1] = 14
            SelectedSession.shared.selectedSession[2] = -1
        }
        //
        performSegue(withIdentifier: "bodyweightSegue", sender: nil)
    }
    
    // Lower
    @IBAction func lower(_ sender: Any) {
        if workoutType == 0 {
            SelectedSession.shared.selectedSession[1] = 12
            SelectedSession.shared.selectedSession[2] = -1
        } else {
            SelectedSession.shared.selectedSession[1] = 15
            SelectedSession.shared.selectedSession[2] = -1
        }
        //
        performSegue(withIdentifier: "bodyweightSegue", sender: nil)
    }
    
    
    //
    // Remove back bar text
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
}

