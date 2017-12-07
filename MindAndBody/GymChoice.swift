//
//  classicChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Gym Choice Class ----------------------------------------------------------------------------------------------------------
//
class GymChoice: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // classic
    @IBOutlet weak var classic: UIButton!
    // circuit
    @IBOutlet weak var circuit: UIButton!
    //
    @IBOutlet weak var fiveByFive: UIButton!
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    // Constraints
    @IBOutlet weak var classicTop: NSLayoutConstraint!
    
    @IBOutlet weak var classicBottom: NSLayoutConstraint!
    
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    
    
    //
    // Remove back button text on subsequent screens
    //
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
        navigationBar.title = (NSLocalizedString("gym", comment: ""))
        
        // Button Titles
        classic.setTitle(NSLocalizedString("classic", comment: ""), for: UIControlState.normal)
        classic.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        classic.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        classic.layer.borderWidth = 5
        classic.layer.borderColor = Colors.dark.cgColor
        classic.setTitleColor(Colors.dark, for: .normal)
        //
        circuit.setTitle(NSLocalizedString("circuit", comment: ""), for: UIControlState.normal)
        circuit.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        circuit.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        circuit.layer.borderWidth = 5
        circuit.layer.borderColor = Colors.dark.cgColor
        circuit.setTitleColor(Colors.dark, for: .normal)
        //
        fiveByFive.setTitle(NSLocalizedString("5x5", comment: ""), for: UIControlState.normal)
        fiveByFive.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        fiveByFive.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        fiveByFive.layer.borderWidth = 5
        fiveByFive.layer.borderColor = Colors.dark.cgColor
        fiveByFive.setTitleColor(Colors.dark, for: .normal)
        //
        
        // Iphone 5/SE
        if IPhoneType.shared.iPhoneType() == 0 {
            //
            classicTop.constant = 52
            classicBottom.constant = 52
            stackBottom.constant = 52
            //
            stackView.spacing = 15
        } else if IPhoneType.shared.iPhoneType() == 2 {
            //
            classicTop.constant = 102
            classicBottom.constant = 102
            stackBottom.constant = 102
            //
        }
    }
    
    //
    // View did layout subview -----------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        classic.layer.cornerRadius = ((self.stackView.frame.size.height) * 3/2) / 2
        classic.layer.masksToBounds = true
        classic.titleLabel?.adjustsFontSizeToFitWidth = true
        classic.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        classic.titleLabel?.numberOfLines = 0
        classic.titleLabel?.textAlignment = .center
        //
        circuit.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        circuit.layer.masksToBounds = true
        circuit.titleLabel?.adjustsFontSizeToFitWidth = true
        circuit.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        circuit.titleLabel?.numberOfLines = 0
        circuit.titleLabel?.textAlignment = .center
        //
        fiveByFive.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        fiveByFive.layer.masksToBounds = true
        fiveByFive.titleLabel?.adjustsFontSizeToFitWidth = true
        fiveByFive.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        fiveByFive.titleLabel?.numberOfLines = 0
        fiveByFive.titleLabel?.textAlignment = .center
    }
    
    
    //
    // MARK: Selected Session
    @IBAction func fivebyfiveAction(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = "classicGym5x5"
        SelectedSession.shared.selectedSession[2] = ""
    }
    
    
}

