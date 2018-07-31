//
//  TabBar.swift
//  MindAndBody
//
//  Created by Luke Smith on 29.07.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class tabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = Colors.dark
        self.tabBar.tintColor = Colors.light
        
        setTabBarItems()
    }
    
    
    func setTabBarItems(){
        
        //        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        //        myTabBarItem2.image = UIImage(named: "Unselected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        //        myTabBarItem2.selectedImage = UIImage(named: "Selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        //        myTabBarItem2.title = ""
        //        myTabBarItem2.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let schedule = (self.tabBar.items?[0])! as UITabBarItem
        schedule.image = #imageLiteral(resourceName: "Calendar")
        schedule.title = NSLocalizedString("schedule", comment: "")
        
        let tracking = (self.tabBar.items?[1])! as UITabBarItem
        tracking.image = #imageLiteral(resourceName: "Graph")
        tracking.title = NSLocalizedString("tracking", comment: "")
        
        let sessions = (self.tabBar.items?[2])! as UITabBarItem
        sessions.image = #imageLiteral(resourceName: "Mind&Body")
        sessions.title = NSLocalizedString("sessions", comment: "")
        
        let lessons = (self.tabBar.items?[3])! as UITabBarItem
        lessons.image = #imageLiteral(resourceName: "QuestionMarkMenu")
        lessons.title = NSLocalizedString("lessons", comment: "")
        
        let settings = (self.tabBar.items?[4])! as UITabBarItem
        settings.image = #imageLiteral(resourceName: "Settings")
        settings.title = NSLocalizedString("settings", comment: "")
    }
    
}
