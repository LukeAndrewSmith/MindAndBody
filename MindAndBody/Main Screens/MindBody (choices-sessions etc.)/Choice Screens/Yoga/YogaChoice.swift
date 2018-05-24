//
//  YogaChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Yoga choice class ---------------------------------------------------------------------------------------------------
//
class YogaChoice: UIViewController, UIScrollViewDelegate  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var custom: UIButton!
    //
    @IBOutlet weak var relaxing: UIButton!
    //
    @IBOutlet weak var neutral: UIButton!
    //
    @IBOutlet weak var stimulating: UIButton!
    //
    @IBOutlet weak var stackView: UIStackView!
    
    // Constraints
    @IBOutlet weak var relaxingTop: NSLayoutConstraint!
    @IBOutlet weak var relaxingBottom: NSLayoutConstraint!
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    
    
    //
    // View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        CustomWalkthrough.shared.beginWalkthrough(viewController: self, customButton: custom)
        
        // Colours
        view.backgroundColor = Colors.light
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("yoga", comment: ""))
        
        // Button Titles
        //
        relaxing.setTitle(NSLocalizedString("relaxing", comment: ""), for: UIControlState.normal)
        relaxing.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        relaxing.setTitleColor(Colors.dark, for: .normal)
        relaxing.layer.borderWidth = 5
        relaxing.layer.borderColor = Colors.dark.cgColor
        //
        neutral.setTitle(NSLocalizedString("neutral", comment: ""), for: UIControlState.normal)
        neutral.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        neutral.setTitleColor(Colors.dark, for: .normal)
        neutral.layer.borderWidth = 5
        neutral.layer.borderColor = Colors.dark.cgColor
        //
        stimulating.setTitle(NSLocalizedString("stimulating", comment: ""), for: UIControlState.normal)
        stimulating.setTitleColor(Colors.dark, for: .normal)
        stimulating.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        stimulating.layer.borderWidth = 5
        stimulating.layer.borderColor = Colors.dark.cgColor
        //
        custom.setTitle("C", for: UIControlState.normal)
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        custom.setTitleColor(Colors.dark, for: .normal)
        custom.layer.borderWidth = 5
        custom.layer.borderColor = Colors.dark.cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        custom.titleLabel?.textAlignment = .center
        custom.layer.cornerRadius = 49/2
        custom.layer.masksToBounds = true
        custom.titleLabel?.numberOfLines = 0
        //
        // Iphone 5/SE
        if IPhoneType.shared.iPhoneType() == 0 {
            //
            relaxingTop.constant = 52
            relaxingBottom.constant = 52
            stackBottom.constant = 52
            //
            stackView.spacing = 15
        } else if IPhoneType.shared.iPhoneType() == 2 {
            //
            relaxingTop.constant = 102
            relaxingBottom.constant = 102
            stackBottom.constant = 102
            //
        }
    }
    
    
    //
    // View did layout subviews ----------------------------------------------------------------------------------------
    override func viewDidLayoutSubviews() {
        //
        super.viewDidLayoutSubviews()
        //
        relaxing.layer.cornerRadius = ((self.stackView.frame.size.height) * 3/2) / 2
        relaxing.layer.masksToBounds = true
        relaxing.titleLabel?.adjustsFontSizeToFitWidth = true
        relaxing.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        relaxing.titleLabel?.numberOfLines = 0
        relaxing.titleLabel?.textAlignment = .center
        //
        neutral.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        neutral.layer.masksToBounds = true
        neutral.titleLabel?.adjustsFontSizeToFitWidth = true
        neutral.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        neutral.titleLabel?.numberOfLines = 0
        neutral.titleLabel?.textAlignment = .center
        //
        stimulating.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        stimulating.layer.masksToBounds = true
        stimulating.titleLabel?.adjustsFontSizeToFitWidth = true
        stimulating.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        stimulating.titleLabel?.numberOfLines = 0
        stimulating.titleLabel?.textAlignment = .center
    }
    
    
    //
    // Segues
    //
    //
    @IBAction func relaxing(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "relaxing"
        SelectedSession.shared.selectedSession[2] = ""
        //
        performSegue(withIdentifier: "yogaSegue", sender: nil)
    }
    
    @IBAction func neutral(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "neutral"
        SelectedSession.shared.selectedSession[2] = ""
        //
        performSegue(withIdentifier: "yogaSegue", sender: nil)
    }
    
    @IBAction func stimulating(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "stimulating"
        SelectedSession.shared.selectedSession[2] = ""
        //
        performSegue(withIdentifier: "yogaSegue", sender: nil)
    }
    
    //
    // Remove Back Bar Text
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Remove back bar text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
}

