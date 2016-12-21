//
//  MyWarmupOverview.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 28/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class WarmupChoice: UIViewController  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Full Body
    @IBOutlet weak var fullBody: UIButton!
    
    // Upper Lower
    @IBOutlet weak var upperLower: UIButton!
    
    // Legs Pull Push
    @IBOutlet weak var legsPullPush: UIButton!
    
    // Cardio
    @IBOutlet weak var cardio: UIButton!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        // Titles
        navigationBar.title = (NSLocalizedString("warmup", comment: ""))
        
        // Button Titles
        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
        fullBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        fullBody.titleLabel!.textColor = .white
        fullBody.layer.borderWidth = 10
        fullBody.layer.borderColor = UIColor.white.cgColor
        fullBody.layer.cornerRadius = self.fullBody.frame.size.height / 2
        
        
        upperLower.setTitle(NSLocalizedString("upperLower", comment: ""), for: UIControlState.normal)
        upperLower.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        upperLower.titleLabel!.textColor = .white
        upperLower.layer.borderWidth = 10
        upperLower.layer.borderColor = UIColor.white.cgColor
        upperLower.layer.cornerRadius = self.upperLower.frame.size.height / 2
       
        
        legsPullPush.setTitle(NSLocalizedString("legsPullPush", comment: ""), for: UIControlState.normal)
        legsPullPush.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        legsPullPush.titleLabel!.textColor = .white
        legsPullPush.layer.borderWidth = 10
        legsPullPush.layer.borderColor = UIColor.white.cgColor
        legsPullPush.layer.cornerRadius = self.legsPullPush.frame.size.height / 2
        
        
        cardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        cardio.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        cardio.titleLabel!.textColor = .white
        cardio.layer.borderWidth = 10
        cardio.layer.borderColor = UIColor.white.cgColor
        cardio.layer.cornerRadius = self.cardio.frame.size.height / 2
    }
    
    
    
    
    
}
