//
//  TrackingScreen.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 03.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
// Tracking Screen Class --------------------------------------------------------------------------------------------------------
//
class TrackingScreen: UIViewController {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
//
// View did load --------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.navigationController?.navigationBar.barTintColor = colour2
        
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 22)!]
        
        // Navigation Title
        navigationBar.title = NSLocalizedString("tracking", comment: "")
    }
    
    
//
// Dismiss view --------------------------------------------------------------------------------------------------------
//
    @IBAction func checkMarkAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
//
}
