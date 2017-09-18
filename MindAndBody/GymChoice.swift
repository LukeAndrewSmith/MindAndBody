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
        // Pass Data 5x5
        if (segue.identifier == "fiveSegue") {
            //
            let destinationVC = segue.destination as! FinalChoice
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
        
        // Colours
        view.backgroundColor = colour1
        
        // Titles
        navigationBar.title = (NSLocalizedString("gym", comment: ""))
        
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
        fiveByFive.setTitle(NSLocalizedString("5x5", comment: ""), for: UIControlState.normal)
        fiveByFive.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        fiveByFive.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        fiveByFive.layer.borderWidth = 5
        fiveByFive.layer.borderColor = colour2.cgColor
        fiveByFive.setTitleColor(colour2, for: .normal)
        //
        
        // Iphone 5/SE
        if UIScreen.main.nativeBounds.height < 1334 {
            //
            classicTop.constant = 52
            classicBottom.constant = 52
            stackBottom.constant = 52
            //
            stackView.spacing = 15
        }
    }
    

    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Automatic Selection
        if automaticSelectionIsHappening == true {
            automaticSelectionProgress = 2
            //
            var buttonArray = [classic, circuit, fiveByFive]
            //
            let buttonToSelect = buttonArray[automaticSelectionArray[automaticSelectionProgress]]
            //
            let flashView = UIView(frame: (buttonToSelect?.bounds)!)
            flashView.alpha = 0
            flashView.backgroundColor = colour2
            buttonToSelect?.addSubview(flashView)
            UIView.animate(withDuration: AnimationTimes.animationTime4, animations: {
                flashView.alpha = 1
            }, completion: { finished in
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    flashView.alpha = 0
                }, completion: { finished in
                    flashView.removeFromSuperview( )
                })
            })
            buttonToSelect?.sendActions(for: .touchUpInside)
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
        selectedSession[1] = 6
        selectedSession[2] = -1
    }
    
    
}
