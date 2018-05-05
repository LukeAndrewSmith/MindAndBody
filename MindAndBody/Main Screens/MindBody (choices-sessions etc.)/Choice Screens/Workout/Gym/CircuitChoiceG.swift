//
//  CircuitChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Circuit Choice Class -------------------------------------------------------------------------------------------------------
//
class CircuitChoiceG: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var fullBody: UIButton!
    //
    @IBOutlet weak var upperBody: UIButton!
    //
    @IBOutlet weak var lowerBody: UIButton!
    
    
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
    var workoutType2 = Int()
    //
    // View did load -------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colours
        view.backgroundColor = Colors.light
        
        // Titles
        navigationBar.title = (NSLocalizedString("circuit", comment: ""))
        
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
    // View did layout subviews -------------------------------------------------------------------------------------------------------
    //
    // Layout Subviews
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
        SelectedSession.shared.selectedSession[1] = "circuitGymFull"
        SelectedSession.shared.selectedSession[2] = ""
        //
        performSegue(withIdentifier: "circuitSegue", sender: nil)
    }
    
    // Upper
    @IBAction func upper(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "circuitGymUpper"
        SelectedSession.shared.selectedSession[2] = ""
        //
        performSegue(withIdentifier: "circuitSegue", sender: nil)
    }
    
    // Lower
    @IBAction func lower(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "circuitGymLower"
        SelectedSession.shared.selectedSession[2] = ""
        //
        performSegue(withIdentifier: "circuitSegue", sender: nil)
    }
    
    
    //
    // Remove Back Bar Text
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    //
}

