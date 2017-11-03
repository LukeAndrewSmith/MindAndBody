//
//  MindfulnessChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Meditation Choice Class --------------------------------------------------------------------------------------------------
//
class MeditationChoice: UIViewController, UIScrollViewDelegate  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var guided: UIButton!
    @IBOutlet weak var meditationTimer: UIButton!
    
    // Stack
    @IBOutlet weak var stackView: UIStackView!
    
    
    //
    // View did load -------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colours
        view.backgroundColor = Colours.colour1
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("meditation", comment: ""))
        
        // Button Titles
        //
        guided.setTitle(NSLocalizedString("guided", comment: ""), for: UIControlState.normal)
        guided.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        guided.setTitleColor(Colours.colour2, for: .normal)
        guided.layer.borderWidth = 5
        guided.layer.borderColor = Colours.colour2.cgColor
        guided.titleLabel?.adjustsFontSizeToFitWidth = true
        guided.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        guided.titleLabel?.textAlignment = .center
        //
        meditationTimer.setTitle(NSLocalizedString("meditationTimer", comment: ""), for: UIControlState.normal)
        meditationTimer.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        meditationTimer.setTitleColor(Colours.colour2, for: .normal)
        meditationTimer.layer.borderWidth = 5
        meditationTimer.layer.borderColor = Colours.colour2.cgColor
        meditationTimer.titleLabel?.adjustsFontSizeToFitWidth = true
        meditationTimer.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        meditationTimer.titleLabel?.textAlignment = .center
        
        
    }
    
    
    //
    // View did layout subviews -------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        meditationTimer.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        meditationTimer.layer.masksToBounds = true
        //
        guided.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        guided.layer.masksToBounds = true
        //
        
    }
    
    
    //
    // Remove Back Bar Text
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
    }
    
}


