//
//  TabBarController.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 27/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


extension UserDefaults {
    
    func setColor(_ color: UIColor?, forKey key: String) {
        //set(NSKeyedArchiver.archivedData(withRootObject: color), forKey: key)
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
        }
        set(colorData, forKey: key)
    }
    
    func color(forKey key: String) -> UIColor? {
        //        guard let data = data(forKey: key)? else { return nil }
        //        return NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor
        var color: UIColor?
        if let colorData = data(forKey: key) {
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }
        return color
    }
}


class tabBarContoller: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Background Colour Default
        //
        
        UserDefaults.standard.register(defaults: ["didSetColour" : false])
        //UserDefaults.standard.set(false, forKey: "didSetColour")
        
        if UserDefaults.standard.bool(forKey: "didSetColour") == false {
            // Did set
            UserDefaults.standard.set(true, forKey: "didSetColour")
            // Set Colour
//            UserDefaults.standard.setColor(UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), forKey: "colour1")
//            UserDefaults.standard.setColor(UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0), forKey: "colour2")
//            UserDefaults.standard.setColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour3")
//            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour4")
//            UserDefaults.standard.setColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), forKey: "colour5")
//            UserDefaults.standard.setColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour6")
//            UserDefaults.standard.setColor(UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), forKey: "colour7")
//            UserDefaults.standard.setColor(UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0), forKey: "colour8")
            
            UserDefaults.standard.setColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour1")
            UserDefaults.standard.setColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour2")
            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour3")
            UserDefaults.standard.setColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour4")
            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour5")
            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour6")
            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour7")
            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour8")
            
            
            UserDefaults.standard.synchronize()
            
        }
        

        
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }

}
