//
//  PreferencesNavigation.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 06/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class PreferencesNaviagtion: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    class navigationBar: UINavigationBar{
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let newSize :CGSize = CGSize(width: self.frame.size.width, height: 54)
        return newSize
    }
    }
}
