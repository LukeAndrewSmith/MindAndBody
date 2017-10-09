//
//  CardioChoiceHIIT.swift
//  MindAndBody
//
//  Created by Luke Smith on 31.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// HIIT Choice Class -------------------------------------------------------------------------------------------------------
//
class CardioChoiceHIIT: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var rowing: UIButton!
    //
    @IBOutlet weak var biking: UIButton!
    //
    @IBOutlet weak var running: UIButton!
    //
    
    //
    var cardioType = Int()
    //
    // View did load ----------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Colours
        view.backgroundColor = colour1
        
        // Titles
        navigationBar.title = (NSLocalizedString("hiit", comment: ""))
        
        // Button Titles
        rowing.setTitle(NSLocalizedString("rowing", comment: ""), for: UIControlState.normal)
        rowing.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        rowing.setTitleColor(colour2, for: .normal)
        rowing.layer.borderWidth = 5
        rowing.layer.borderColor = colour2.cgColor
        //
        biking.setTitle(NSLocalizedString("biking", comment: ""), for: UIControlState.normal)
        biking.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        biking.setTitleColor(colour2, for: .normal)
        biking.layer.borderWidth = 5
        biking.layer.borderColor = colour2.cgColor
        //
        running.setTitle(NSLocalizedString("running", comment: ""), for: UIControlState.normal)
        running.setTitleColor(colour2, for: .normal)
        running.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        running.layer.borderWidth = 5
        running.layer.borderColor = colour2.cgColor
        //
    }
    
    
    //
    // View did layout subviews ----------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        rowing.layer.cornerRadius = rowing.frame.size.height / 2
        rowing.layer.masksToBounds = true
        rowing.titleLabel?.adjustsFontSizeToFitWidth = true
        rowing.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        rowing.titleLabel?.numberOfLines = 0
        rowing.titleLabel?.textAlignment = .center
        //
        biking.layer.cornerRadius = biking.frame.size.height / 2
        biking.layer.masksToBounds = true
        biking.titleLabel?.adjustsFontSizeToFitWidth = true
        biking.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        biking.titleLabel?.numberOfLines = 0
        biking.titleLabel?.textAlignment = .center
        //
        running.layer.cornerRadius = running.frame.size.height / 2
        running.layer.masksToBounds = true
        running.titleLabel?.adjustsFontSizeToFitWidth = true
        running.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        running.titleLabel?.numberOfLines = 0
        running.titleLabel?.textAlignment = .center
    }
    
    
    //
    // MARK: Selected Session
    // Rowing
    @IBAction func full(_ sender: Any) {
        selectedSession[1] = 0
        selectedSession[2] = -1
        performSegue(withIdentifier: "cardioSegue", sender: nil)
    }
    
    // Biking
    @IBAction func upper(_ sender: Any) {
        selectedSession[1] = 1
        selectedSession[2] = -1
        performSegue(withIdentifier: "cardioSegue", sender: nil)
    }
    
    // Running
    @IBAction func lower(_ sender: Any) {
        selectedSession[1] = 2
        selectedSession[2] = -1
        performSegue(withIdentifier: "cardioSegue", sender: nil)
    }
    
    
    //
    // Remove back bar text
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Data
        if (segue.identifier == "cardioSegue") {
            //
            let destinationVC = segue.destination as! FinalChoice
        }
        //
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
}
