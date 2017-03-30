//
//  InformationScreen1.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 27.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit




class InformationScreen1: UIViewController {
    
    
    
    // Navigation
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    // Title Array
    let titleArray =
        [
            ["breathing", "coreActivation", "mindMuscle", "anatomy", "equipment", "posture", "commonTerms", "routineBuilding", "trainingPhilosophy", "nutrition"],
            ["suggestions"],
            ["vision", "usage"]
            
        ]
    
    
    //
    var selectedTopic = [0,0]
    
    
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
    

    
    
    
    
    // View Did Load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Title
        //
        navigationBar.title = (NSLocalizedString(titleArray[selectedTopic[0]][selectedTopic[1]], comment: ""))
        
        //self.navigationController?.navigationBar.barTintColor = colour2
        //self.navigationController?.navigationBar.tintColor = .white
        
        
        
        
    }
    
    
    //
    
    
    
    
    
    
}
