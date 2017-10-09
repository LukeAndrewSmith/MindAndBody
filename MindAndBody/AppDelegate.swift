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
        let defaults = UserDefaults.standard
        
        
        //
        // Tracking
        // Progress
        defaults.register(defaults: ["weekProgress" : 0])
        defaults.register(defaults: ["monthProgress" : 0])
        // Update progress (first monday of last week/month completed, used to check if progress needs to be reset to 0 for first entry of new week/month)
        defaults.register(defaults: ["lastResetWeek" : Date().firstMondayInCurrentWeek])
        defaults.register(defaults: ["lastResetMonth" : Date().firstDateInCurrentMonth])
        
        
        //
        // Settings
        UserDefaults.standard.register(defaults: ["userSettings" : Register.defaultSettings])
        
        
        //
        // Profile/Schedules
        // Schedules
        UserDefaults.standard.register(defaults: ["schedules" : scheduleDataStructures.schedules])
        // Difficulty Levels
        UserDefaults.standard.register(defaults: ["difficultyLevels" : scheduleDataStructures.defaultDifficultyLevels])
        // Profile Answers
        UserDefaults.standard.register(defaults: ["profileAnswers" : scheduleDataStructures.defaultProfileAnswers])

        
        //
        // Walkthrough
        let walkthroughArray: [Bool] =
            [
                // Notifications popup - 0
                false,
                // Mind Body, homescreen, - 1
                false,
                // Final Choice, - 2
                false,
                // Session - 3
                false,
                // Session 2 - 4
                false,
                // Schedule - 5
                false,
                // Tracking - 6
                false,
                // Profile - 7
                false,
                // Profile 'Me' - 8
                false,
                // Profile 'Goals' - 9
                false,
                // Profile 'Nº Session' - 10
                false,
                // Settings - 11
                false,
                // Automatic Yoga - 12
                false
        ]
        
        
        UserDefaults.standard.register(defaults: ["walkthroughs" : walkthroughArray])

        
        // Walkthroughs
        UserDefaults.standard.register(defaults: ["trackingWalkthrough" : false])
        //
        UserDefaults.standard.register(defaults: ["profileWalkthrough" : false])
        UserDefaults.standard.register(defaults: ["meWalkthrough" : false])
        UserDefaults.standard.register(defaults: ["goalsWalkthrough" : false])
        UserDefaults.standard.register(defaults: ["nSessionsWalkthrough" : false])
        //
        UserDefaults.standard.register(defaults: ["settingsWalkthrough" : false])
        UserDefaults.standard.register(defaults: ["automaticYogaWalkthrough" : false])

        
        
        
        //
        // Set Home Screen
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let homeScreen = settings[1][0]
        //
        switch homeScreen {
        case 0,2:
            let mindBody = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "view0") as! MindBodyNavigation
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = mindBody
            self.window?.makeKeyAndVisible()
//            if homeScreen == 2 {
//                let mindBodyScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mindBody") as! MindBody
//                mindBodyScreen.performSegue(withIdentifier: "openMenu", sender: self)
//            }
            //
            tabBarIndex = 0
        case 1:
            let schedule = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "view1") as! ScheduleNavigation
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = schedule
            self.window?.makeKeyAndVisible()
            //
            tabBarIndex = 1
        default:
            break
        }
        
        //
        //
        return true
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
