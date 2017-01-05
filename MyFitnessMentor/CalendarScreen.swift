//
//  Calendar.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class CalendarScreen: UIViewController {
    
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        // Navigation Title
        navigationBar.title = NSLocalizedString("calendar", comment: "")
        
        
        
    }
    
    
    @IBAction func checkMarkAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        
    }
    
    
    
}
