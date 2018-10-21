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

        let schedule = (self.tabBar.items?[0])! as UITabBarItem
        schedule.image = #imageLiteral(resourceName: "Calendar")
        schedule.title = NSLocalizedString("schedule", comment: "")
        
        let tracking = (self.tabBar.items?[1])! as UITabBarItem
        tracking.image = #imageLiteral(resourceName: "Graph")
        tracking.title = NSLocalizedString("tracking", comment: "")

        let lessons = (self.tabBar.items?[2])! as UITabBarItem
        lessons.image = #imageLiteral(resourceName: "Mind&Body")
        lessons.title = NSLocalizedString("lessons", comment: "")
        
        let settings = (self.tabBar.items?[3])! as UITabBarItem
        settings.image = #imageLiteral(resourceName: "Settings")
        settings.title = NSLocalizedString("settings", comment: "")
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if self.tabBar.items?.firstIndex(of: item) == 0 {
            TabBarChanged.shared.returningToSchedule = true

        }
    }
}
