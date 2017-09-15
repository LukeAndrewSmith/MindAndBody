//
//  YogaChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Yoga choice class ---------------------------------------------------------------------------------------------------
//
class YogaChoice: UIViewController, UIScrollViewDelegate  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var custom: UIButton!
    //
    @IBOutlet weak var practices: UIButton!
    
    
//
// View did load -----------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colours
        view.backgroundColor = colour1
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("yoga", comment: ""))
        
        // Button Titles
        //
        practices.setTitle(NSLocalizedString("practices", comment: ""), for: UIControlState.normal)
        practices.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        practices.setTitleColor(colour2, for: .normal)
        practices.layer.borderWidth = 5
        practices.layer.borderColor = colour2.cgColor
        practices.titleLabel?.adjustsFontSizeToFitWidth = true
        practices.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        practices.titleLabel?.textAlignment = .center
        //
        custom.setTitle("C", for: UIControlState.normal)
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        custom.setTitleColor(colour2, for: .normal)
        custom.layer.borderWidth = 5
        custom.layer.borderColor = colour2.cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        custom.titleLabel?.textAlignment = .center
        custom.layer.cornerRadius = 49/2
        custom.layer.masksToBounds = true
        custom.titleLabel?.numberOfLines = 0
        //

    }
    

//
// View did layout subviews ----------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        //
        super.viewDidLayoutSubviews()
        //
        practices.layer.cornerRadius = practices.frame.size.height / 2
        practices.layer.masksToBounds = true
        practices.titleLabel?.adjustsFontSizeToFitWidth = true
        practices.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        practices.titleLabel?.numberOfLines = 0
        practices.titleLabel?.textAlignment = .center
    }
  
    
//
// Segues
//
    //
    @IBAction func practicesAction(_ sender: Any) {
        performSegue(withIdentifier: "yogaSegue", sender: nil)
    }
    
    
//
// Remove Back Bar Text
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Data
        if (segue.identifier == "yogaSegue") {
            //
            let destinationVC = segue.destination as! YogaChoiceFinal
            // Indicate to next screen which button was pressed
        }
        // Remove back bar text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
     

}
