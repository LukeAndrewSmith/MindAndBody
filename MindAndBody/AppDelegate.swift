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
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        SubscriptionService.shared.loadSubscriptionOptions()
        
        
//        ICloudFunctions.shared.removeAll()
        //
        // Icloud
//        NotificationCenter.default.addObserver(self, selector: #selector(), name:  NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: NSUbiquitousKeyValueStore.default)
        
        NotificationCenter.default.addObserver(
            forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: NSUbiquitousKeyValueStore.default,
            queue: OperationQueue.main) { notification in
//                let ubiquitousKeyValueStore = notification.object as? NSUbiquitousKeyValueStore
//                ubiquitousKeyValueStore?.synchronize()
                //
                ICloudFunctions.shared.pullToDefaults()
        }

        
        //
        // Register Defaults --------------------------------------------------------------------------------
        //
        // Settings
        UserDefaults.standard.register(defaults: ["userSettings" : Register.defaultSettings])
        //
        // Profile/Schedules
        // Selected Schedule
        UserDefaults.standard.register(defaults: ["selectedSchedule" : 0])
        // Schedules
        UserDefaults.standard.register(defaults: ["schedules" : scheduleDataStructures.registerSchedules])
        // Tracking
        UserDefaults.standard.register(defaults: ["scheduleTracking" : scheduleDataStructures.registerTracking])
        // Difficulty Levels
        UserDefaults.standard.register(defaults: ["difficultyLevels" : scheduleDataStructures.defaultDifficultyLevels])
        // Profile Answers
        UserDefaults.standard.register(defaults: ["profileAnswers" : scheduleDataStructures.defaultProfileAnswers])
        //
        // Tracking
        // Tracking arrays [weekTracking, tracking]
        UserDefaults.standard.register(defaults: ["trackingDictionaries" : Register.registerTrackingDictionaries])
        // Progress, [currentProgress, lastResetWeek/Month]
        UserDefaults.standard.register(defaults: ["trackingProgress" : Register.registerTrackingProgressArray])
        //
        // Custom
        // Custom Sessions
        UserDefaults.standard.register(defaults: ["customSessions" : Register.customSessionsRegister])
        // Meditation Array
        UserDefaults.standard.register(defaults: ["meditationTimer" : Register.meditationArrayRegister])
        //
        // Walkthroughs
        UserDefaults.standard.register(defaults: ["walkthroughs" : Register.registerWalkthroughArray])
        
        // Push everything to iCloud
        let check = NSUbiquitousKeyValueStore.default.object(forKey: "walkthroughs")
        if check == nil {
            ICloudFunctions.shared.pushToICloud(toSync: [""])
        }
        
//        // Sync all
//        ICloudFunctions.shared.pullToDefaults()
        
        //
        // Set Home Screen
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let homeScreen = settings[1][0]
        
        switch homeScreen {
        case 0,2:
            let mindBody = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "view0") as! MindBodyNavigation
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = mindBody
            self.window?.makeKeyAndVisible()
            //
            MenuVariables.shared.menuIndex = 0
        case 1:
            let schedule = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "view1") as! ScheduleNavigation
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = schedule
            self.window?.makeKeyAndVisible()
            //
            MenuVariables.shared.menuIndex = 1
        default:
            break
        }
        
        //
        return true
    }
    
    //
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        timerCountDown.invalidate()
        timerCountDown2.invalidate()
        
        //
        // For rare case where use quits app after turning automatic yoga on without changing breath/transition times -> automatic yoga is on but breath/transition time == -1 => crash
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        // Turn automatic yoga off
        if settings[3][1] == -1 || settings[3][2] == -1 {
            settings[3][0] = 0
        }
        UserDefaults.standard.set(settings, forKey: "userSettings")
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
        
        // Reset weekTracking/scheduleTracking (called a few times too many throughout but better safe than sorry)
        ScheduleVariables.shared.resetWeekTracking()
        
        
//        // Sync all
//        ICloudFunctions.shared.pullToDefaults()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
        
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print("help")
    }
    
    //
}

