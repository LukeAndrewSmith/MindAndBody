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
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // CheckMark
    @IBOutlet weak var checkMark: UIBarButtonItem!
    
    
    
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Background Gradient and Colour
        self.view.applyGradient(colours: [colour1, colour2])
        
        checkMark.tintColor = colour1
        
        self.navigationController?.navigationBar.tintColor = colour1
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colour1, NSFontAttributeName: UIFont(name: "SFUIDisplay-heavy", size: 23)!]
        
        
        // Navigation Title
        navigationBar.title = NSLocalizedString("calendar", comment: "")
        
        
        
    }
    
    
    @IBAction func checkMarkAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        
    }
    
    
    
}
