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
    // Full Body
    @IBOutlet weak var fullBody: UIButton!
    // Upper Lower
    @IBOutlet weak var upperBody: UIButton!
    // Legs Pull Push
    @IBOutlet weak var lowerBody: UIButton!
    // Cardio
    @IBOutlet weak var cardio: UIButton!
    //
    @IBOutlet weak var custom: UIButton!
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    // Constraints
    @IBOutlet weak var stackTop: NSLayoutConstraint!
    //
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var stack2: UIStackView!
    //
    @IBOutlet weak var connectionLabelWidth: NSLayoutConstraint!
    //
    @IBOutlet weak var connectionLabelTrailing: NSLayoutConstraint!
    
    
   
//
// View Did Load ---------------------------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colours
        view.backgroundColor = colour1
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("warmup", comment: ""))
        
        // Button Titles
        //
        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
        fullBody.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        fullBody.layer.borderWidth = 5
        fullBody.layer.borderColor = colour2.cgColor
        fullBody.titleLabel?.adjustsFontSizeToFitWidth = true
        fullBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        fullBody.titleLabel?.textAlignment = .center
        fullBody.setTitleColor(colour2, for: .normal)
        //
        upperBody.setTitle(NSLocalizedString("upperBody", comment: ""), for: UIControlState.normal)
        upperBody.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        upperBody.layer.borderWidth = 5
        upperBody.layer.borderColor = colour2.cgColor
        upperBody.titleLabel?.adjustsFontSizeToFitWidth = true
        upperBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        upperBody.titleLabel?.textAlignment = .center
        upperBody.setTitleColor(colour2, for: .normal)
        //
        lowerBody.setTitle(NSLocalizedString("lowerBody", comment: ""), for: UIControlState.normal)
        lowerBody.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        lowerBody.layer.borderWidth = 5
        lowerBody.layer.borderColor = colour2.cgColor
        lowerBody.titleLabel?.adjustsFontSizeToFitWidth = true
        lowerBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        lowerBody.titleLabel?.textAlignment = .center
        lowerBody.setTitleColor(colour2, for: .normal)
        //
        cardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        cardio.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        cardio.layer.borderWidth = 5
        cardio.layer.borderColor = colour2.cgColor
        cardio.titleLabel?.adjustsFontSizeToFitWidth = true
        cardio.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        cardio.titleLabel?.textAlignment = .center
        cardio.setTitleColor(colour2, for: .normal)
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
            stackTop.constant = 30
            stackBottom.constant = 30
            //
            stack2.spacing = 15
            connectionLabelTrailing.constant = 15
            connectionLabelWidth.constant = 15
        }
        
        
    }
    
//
// View Did Layout Subviews -----------------------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        cardio.layer.cornerRadius = (self.stackView.frame.size.height - 49) / 6
        cardio.layer.masksToBounds = true
        cardio.titleLabel?.adjustsFontSizeToFitWidth = true
        cardio.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        cardio.titleLabel?.numberOfLines = 0
        cardio.titleLabel?.textAlignment = .center
        //
        lowerBody.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 6
        lowerBody.layer.masksToBounds = true
        lowerBody.titleLabel?.adjustsFontSizeToFitWidth = true
        lowerBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        lowerBody.titleLabel?.numberOfLines = 0
        lowerBody.titleLabel?.textAlignment = .center
        //
        upperBody.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 6
        upperBody.layer.masksToBounds = true
        upperBody.titleLabel?.adjustsFontSizeToFitWidth = true
        upperBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        upperBody.titleLabel?.numberOfLines = 0
        upperBody.titleLabel?.textAlignment = .center
        //
        fullBody.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 6
        fullBody.layer.masksToBounds = true
        fullBody.titleLabel?.adjustsFontSizeToFitWidth = true
        fullBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        fullBody.titleLabel?.numberOfLines = 0
        fullBody.titleLabel?.textAlignment = .center
    }
    
//
// Button Segues ----------------------------------------------------------------------------------------------------------------
//
    // Indicate to next screen which button was pressed
    var warmupType = Int()
    // Full Body
    @IBAction func fullBody(_ sender: UIButton) {
        selectedSession[1] = 0
        selectedSession[2] = -1
        //
        performSegue(withIdentifier: "warmupSegue", sender: nil)
    }
    // Upper Body
    @IBAction func upperBody(_ sender: Any) {
        selectedSession[1] = 1
        selectedSession[2] = -1
        //
        performSegue(withIdentifier: "warmupSegue", sender: nil)
    }
    // Lower Body
    @IBAction func lowerBody(_ sender: Any) {
        selectedSession[1] = 2
        selectedSession[2] = -1
        //
        performSegue(withIdentifier: "warmupSegue", sender: nil)
    }
    // Cardio
    @IBAction func cardio(_ sender: Any) {
        selectedSession[1] = 3
        selectedSession[2] = -1
        //
        performSegue(withIdentifier: "warmupSegue", sender: nil)
    }
    
    // Pass data and remove back bar text on next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Data
        if (segue.identifier == "customSegueWarmup") {
            let destinationVC = segue.destination as! FinalChoiceCustom
            destinationVC.selectedType = 0
        }
        
        // Remove back bar text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
//
}
