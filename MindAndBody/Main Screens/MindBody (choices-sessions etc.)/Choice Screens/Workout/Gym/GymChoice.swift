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
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    
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
    }
    
    //
    // View did layout subview -----------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        classic.layer.cornerRadius = ((self.stackView.frame.size.height) - 40) / 4
        classic.layer.masksToBounds = true
        classic.titleLabel?.adjustsFontSizeToFitWidth = true
        classic.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        classic.titleLabel?.numberOfLines = 0
        classic.titleLabel?.textAlignment = .center
        //
        circuit.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        circuit.layer.masksToBounds = true
        circuit.titleLabel?.adjustsFontSizeToFitWidth = true
        circuit.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        circuit.titleLabel?.numberOfLines = 0
        circuit.titleLabel?.textAlignment = .center
    }
    
    
}
