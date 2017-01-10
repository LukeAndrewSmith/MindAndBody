//
//  WarmupChoiceFull.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 03.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


class WarmupChoiceFull: UIViewController {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    
    // Full
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("fullBody", comment: ""))
        
        
        

        
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        
        
      
    }
    
    
    @IBAction func beginButtonAction(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        //content.title = NSString.localizedUserNotificationString(forKey: "Rest over: Begin next set", arguments: nil)
        //content.body = NSString.localizedUserNotificationString(forKey: "", arguments: nil)
        content.title = "Rest over: Begin next set"
        content.body = ""
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "restTimer"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "restTimer", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    
    
    
    
}
