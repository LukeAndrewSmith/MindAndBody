//
//  TrackingScreen.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 03.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class TrackingScreen: UIViewController {
    
    
    
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    
    // Retreive Colours
    let colour7 = UserDefaults.standard.color(forKey: "colour7")!
    
    
    // View Did Load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.barTintColor = colour7
        
        
        
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 22)!]
        
        
        
        // Navigation Title
        navigationBar.title = NSLocalizedString("tracking", comment: "")
        
        
        
    }
    
    
    
    
    
    
    
    @IBAction func checkMarkAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        
    }
    
    
    
}
