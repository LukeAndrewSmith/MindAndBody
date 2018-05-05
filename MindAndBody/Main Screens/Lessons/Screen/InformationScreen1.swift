//
//  InformationScreen1.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 27.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Information Screen 1 Class -----------------------------------------------------------------------------
//
class LessonsScreen1: UIViewController {
    
    // Navigation
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Title Array
    let titleArray: [[String]] =
        [
            ["breathing", "coreActivation", "mindMuscle", "anatomy", "equipment", "posture", "commonTerms", "routineBuilding", "trainingPhilosophy", "nutrition"],
            ["suggestions"],
            ["vision", "usage"]
        ]
    
    //
    var selectedTopic = [0,0]
    
//
// View did load ------------------------------------------------------------------------------------
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
