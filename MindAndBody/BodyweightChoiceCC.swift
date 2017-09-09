//
//  BodyweightChoiceCC.swift
//  MindAndBody
//
//  Created by Luke Smith on 23.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Gym Choice Class ----------------------------------------------------------------------------------------------------------
//
class BodyweightChoiceCC: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // classic
    @IBOutlet weak var classic: UIButton!
    // circuit
    @IBOutlet weak var circuit: UIButton!
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    //
    // Remove back button text on subsequent screens
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Data 5x5
        if (segue.identifier == "bodyweightCircuit") {
            //
            let destinationVC = segue.destination as! BodyweightChoice
            // Indicate to next screen which button was pressed
            destinationVC.workoutType = 3
        } else if (segue.identifier == "bodyweightClassic") {
            //
            let destinationVC = segue.destination as! BodyweightChoice
            // Indicate to next screen which button was pressed
            destinationVC.workoutType = 2
        }
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
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthroughc") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthroughc")
        }
        
        // Colours
        view.backgroundColor = colour1
        
        // Titles
        navigationBar.title = (NSLocalizedString("bodyweight", comment: ""))
        
        // Button Titles
        classic.setTitle(NSLocalizedString("classic", comment: ""), for: UIControlState.normal)
        classic.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        classic.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        classic.layer.borderWidth = 5
        classic.layer.borderColor = colour2.cgColor
        classic.setTitleColor(colour2, for: .normal)
        //
        circuit.setTitle(NSLocalizedString("circuit", comment: ""), for: UIControlState.normal)
        circuit.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        circuit.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        circuit.layer.borderWidth = 5
        circuit.layer.borderColor = colour2.cgColor
        circuit.setTitleColor(colour2, for: .normal)
        //
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
    

//
// Walkthrough ----------------------------------------------------------------------------------------------------------------
//




}
