//
//  CardioChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Cardio Choice Class ---------------------------------------------------------------------------------------------------------
//
class CardioChoice: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Hiit
    @IBOutlet weak var hiit: UIButton!
    // Custom
    @IBOutlet weak var custom: UIButton!
    
//
// View did load -----------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Colours
        view.backgroundColor = colour1
        
        // Titles
        navigationBar.title = (NSLocalizedString("cardio", comment: ""))
        
        // Button Titles
        hiit.setTitle(NSLocalizedString("hiit", comment: ""), for: UIControlState.normal)
        hiit.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        hiit.setTitleColor(colour2, for: .normal)
        hiit.layer.borderWidth = 5
        hiit.layer.borderColor = colour2.cgColor
        hiit.titleLabel?.adjustsFontSizeToFitWidth = true
        hiit.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        hiit.titleLabel?.textAlignment = .center
        //
        custom.setTitle("C", for: .normal)
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        custom.layer.borderWidth = 5
        custom.layer.borderColor = colour2.cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        custom.titleLabel?.textAlignment = .center
        custom.setTitleColor(colour2, for: .normal)
        custom.layer.cornerRadius = 49/2
        custom.layer.masksToBounds = true
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        custom.titleLabel?.numberOfLines = 0
        custom.titleLabel?.textAlignment = .center
        //
        
            }
    
    
//
// View did layout subviews  ---------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        hiit.layer.cornerRadius = self.hiit.frame.size.height / 2
        hiit.layer.masksToBounds = true
        hiit.titleLabel?.adjustsFontSizeToFitWidth = true
        hiit.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        hiit.titleLabel?.numberOfLines = 0
        hiit.titleLabel?.textAlignment = .center
        //
    }
    
    
//
// Remove back bar text
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
