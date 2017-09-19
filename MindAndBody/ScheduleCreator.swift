//
//  ScheduleCreator.swift
//  MindAndBody
//
//  Created by Luke Smith on 11.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class ScheduleCreator: UIViewController {
    
    //
    let backgroundIndex = UserDefaults.standard.integer(forKey: "backgroundImage")
    let backgroundImageView = UIImageView()
    let backgroundBlur = UIVisualEffectView()
    
    //
    // Arrays
    
    //
    // View did load --------------------------------------------------------------------------------------------------------
    //
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // Background Image
        backgroundImageView.frame = UIScreen.main.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        //
        if backgroundIndex < backgroundImageArray.count {
            backgroundImageView.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = colour1
        }
        //
        self.view.addSubview(backgroundImageView)
        self.view.sendSubview(toBack: backgroundImageView)
        //
        // BackgroundBlur/Vibrancy
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        //
        backgroundBlur.frame = backgroundImageView.bounds
        //
        view.insertSubview(backgroundBlur, aboveSubview: backgroundImageView)        
    }
    

    
    
}