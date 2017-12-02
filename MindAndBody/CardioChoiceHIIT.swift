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
    @IBOutlet weak var running: UIButton!
    //
    @IBOutlet weak var biking: UIButton!
    //
    @IBOutlet weak var rowing: UIButton!
    //
    
    //
    var cardioType = Int()
    //
    // View did load ----------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Colours
        view.backgroundColor = Colors.light
        
        // Titles
        navigationBar.title = (NSLocalizedString("hiit", comment: ""))
        
        // Button Titles
        rowing.setTitle(NSLocalizedString("rowing", comment: ""), for: UIControlState.normal)
        rowing.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        rowing.setTitleColor(Colors.dark, for: .normal)
        rowing.layer.borderWidth = 5
        rowing.layer.borderColor = Colors.dark.cgColor
        //
        biking.setTitle(NSLocalizedString("biking", comment: ""), for: UIControlState.normal)
        biking.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        biking.setTitleColor(Colors.dark, for: .normal)
        biking.layer.borderWidth = 5
        biking.layer.borderColor = Colors.dark.cgColor
        //
        running.setTitle(NSLocalizedString("running", comment: ""), for: UIControlState.normal)
        running.setTitleColor(Colors.dark, for: .normal)
        running.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        running.layer.borderWidth = 5
        running.layer.borderColor = Colors.dark.cgColor
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
        SelectedSession.shared.selectedSession[1] = 0
        SelectedSession.shared.selectedSession[2] = -1
        performSegue(withIdentifier: "cardioSegue", sender: nil)
    }
    
    // Biking
    @IBAction func upper(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = 1
        SelectedSession.shared.selectedSession[2] = -1
        performSegue(withIdentifier: "cardioSegue", sender: nil)
    }
    
    // Running
    @IBAction func lower(_ sender: Any) {
        SelectedSession.shared.selectedSession[1] = 2
        SelectedSession.shared.selectedSession[2] = -1
        performSegue(withIdentifier: "cardioSegue", sender: nil)
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

