//
//  TabBarController.swift
//  MindAndBody
//
//  Created by Luke Smith on 12.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    //
    // Outlets
    
    override func viewDidLoad() {
        tabBar.backgroundColor = colour2
        tabBar.barTintColor = colour2
        tabBar.tintColor = colour1
        tabBar.isTranslucent = false
    }
    
}
