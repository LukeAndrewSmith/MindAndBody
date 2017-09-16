//
//  AppDelegate.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import UIKit
import UserNotifications

//
// App Delegate Class --------------------------------------------------------------------------------------------------------
//
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

//
// Did finish launching ----------------------------------------------------------------------------------------------
//
    
    //
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //
        // Register Defaults --------------------------------------------------------------------------------
        //
        let defaults = UserDefaults.standard
            
        //
        // Tracking
        // Progress
        defaults.register(defaults: ["weekProgress" : 0])
        defaults.register(defaults: ["monthProgress" : 0])
        // Update progress (first monday of last week/month completed, used to check if progress needs to be reset to 0 for first entry of new week/month)
        defaults.register(defaults: ["lastResetWeek" : firstMondayInCurrentWeek()])
        defaults.register(defaults: ["lastResetWeek" : firstMondayInCurrentMonth()])
        
        //
        // Settings
        // Background image index
        UserDefaults.standard.register(defaults: ["backgroundImage" : 2])
        // Home Screen
        UserDefaults.standard.register(defaults: ["homeScreen" : "home"])
        // Default Image
        UserDefaults.standard.register(defaults: ["defaultImage" : "demonstration"])
        // Weight
        UserDefaults.standard.register(defaults: ["units" : "kg"])
        // Rest times
        UserDefaults.standard.register(defaults: ["restTimes" : [15, 45, 10]])
        // Yoga Automatic
        UserDefaults.standard.register(defaults: ["automaticYoga" : [0, -1, -1, -1]])
        
        //
        // Notifications popup
        UserDefaults.standard.register(defaults: ["notificationsPopup" : false])
        
        //
        // Register Walkthroughs
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough" : false])
        //
        UserDefaults.standard.register(defaults: ["finalChoiceWalkthrough" : false])
        UserDefaults.standard.register(defaults: ["sessionWalkthrough" : false])
        UserDefaults.standard.register(defaults: ["sessionWalkthrough2" : false])
        UserDefaults.standard.register(defaults: ["yogaSessionWalkthrough" : false])
        //
        UserDefaults.standard.register(defaults: ["scheduleWalkthrough" : false])
        //
        UserDefaults.standard.register(defaults: ["trackingWalkthrough" : false])
        //
        UserDefaults.standard.register(defaults: ["profileWalkthrough" : false])
        //
        UserDefaults.standard.register(defaults: ["settingsWalkthrough" : false])
        UserDefaults.standard.register(defaults: ["automaticYogaWalkthrough" : false])

        //
        // Home Screen
        let homeScreen = UserDefaults.standard.string(forKey: "homeScreen")
        //
        if homeScreen == "home" {
            let mindBody = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "view0") as! MindBodyNavigation
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = mindBody
            self.window?.makeKeyAndVisible()
            //
            tabBarIndex = 0
        } else {
            let schedule = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "view1") as! ScheduleNavigation
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = schedule
            self.window?.makeKeyAndVisible()
            //
            tabBarIndex = 1
        }
        
        //
        return true
    }
    
    // First monday in month
    func firstMondayInCurrentWeek() -> String? {
        //
        // Get first monday in week
        let dfDay = DateFormatter()
        dfDay.dateFormat = "dd.MM.yyyy"
        // Get Monday
        var mondaysDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let currentMondayDate = dfDay.string(from: mondaysDate)
        return currentMondayDate
    }
    // First monday in month
    func firstMondayInCurrentMonth() -> String? {
        // Get month and year
        // Get Month
        let dfMonth = DateFormatter()
        dfMonth.dateFormat = "MM"
        // Get Month
        var monthsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let month = Int(dfMonth.string(from: monthsDate))
        // Get Year
        let dfYear = DateFormatter()
        dfYear.dateFormat = "yyyy"
        // Get Year
        var yearsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let year = Int(dfYear.string(from: yearsDate))
        
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2 // 2 == Monday
        
        // First monday in month:
        var comps = DateComponents(year: year, month: month,
                                   weekday: calendar.firstWeekday, weekdayOrdinal: 1)
        guard let first = calendar.date(from: comps)  else {
            return nil
        }
        
        // Format Day
        let dfDay = DateFormatter()
        dfDay.dateFormat = "dd.MM.yyyy"
        // Get Monday
        let firstMonday = dfDay.string(from: first)
        
        return firstMonday
    }
    
    
    
    //
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        timerCountDown.invalidate()
        timerCountDown2.invalidate()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:

    }

    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print("help")
    }
    
//
}
