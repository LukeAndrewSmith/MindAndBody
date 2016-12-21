//
//  StretchingChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class StretchingChoice: UIViewController  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        // Titles
        navigationBar.title = (NSLocalizedString("stretching", comment: ""))
        
        // Button Titles
//        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
//        fullBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
//        fullBody.titleLabel!.textColor = .white
//        fullBody.layer.borderWidth = 10
//        fullBody.layer.borderColor = UIColor.white.cgColor
//        fullBody.layer.cornerRadius = self.fullBody.frame.size.height / 2
        
        
    }
    
    
    
    
    
}
