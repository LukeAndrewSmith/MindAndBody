//
//  AppDelegate.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import UIKit
import UserNotifications
import StoreKit

//
// App Delegate Class --------------------------------------------------------------------------------------------------------
//
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    //
    //
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        //
        // Subscriptions
        InAppManager.shared.startMonitoring()
        
        // MARK: TEST!! REMOVE
        // ICloud/UserDefaults Reset
        ICloudFunctions.shared.removeAll()
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        
        
        //
        // iCloud Oberver
        NotificationCenter.default.addObserver(
            forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: NSUbiquitousKeyValueStore.default,
            queue: OperationQueue.main) { notification in
                //
                NSUbiquitousKeyValueStore.default.synchronize()
                ICloudFunctions.shared.pullToDefaults()
        }
        
        //
        // Sync all, only does something if new device but existing data on iCloud
        if UserDefaults.standard.object(forKey: "userSettings") == nil {
            NSUbiquitousKeyValueStore.default.synchronize()
            ICloudFunctions.shared.pullToDefaults()
        }
        
        //
        // Register Defaults --------------------------------------------------------------------------------
        //
        // Subscriptions
        UserDefaults.standard.register(defaults: ["userHasValidSubscription" : false])
        // Settings
        UserDefaults.standard.register(defaults: ["userSettings" : Register.defaultSettings])
        //
        // Profile/Schedules
        // Selected Schedule
        UserDefaults.standard.register(defaults: ["selectedSchedule" : 0])
        // Schedules
        UserDefaults.standard.register(defaults: ["schedules" : scheduleDataStructures.registerSchedules])
        // Difficulty Levels
        UserDefaults.standard.register(defaults: ["difficultyLevels" : scheduleDataStructures.defaultDifficultyLevels])
        // Profile Answers
        UserDefaults.standard.register(defaults: ["profileAnswers" : scheduleDataStructures.defaultProfileAnswers])
        // Lessons
        UserDefaults.standard.register(defaults: ["scheduleLessons" : scheduleDataStructures.defaultScheduleLessons])
        //
        // Tracking
        // Tracking arrays [weekTracking, tracking]
        UserDefaults.standard.register(defaults: ["trackingDictionaries" : Register.registerTrackingDictionaries])
        // Progress, [currentProgress, lastResetWeek/Month]
        UserDefaults.standard.register(defaults: ["trackingProgress" : Register.registertrackingProgressDictionary])
        //
        // Custom
        // Custom Sessions
        UserDefaults.standard.register(defaults: ["customSessions" : Register.customSessionsRegister])
        // Meditation Array
        UserDefaults.standard.register(defaults: ["meditationTimer" : Register.meditationArrayRegister])
        // Weights
        UserDefaults.standard.register(defaults: ["movementWeights" : Register.weightRegister()])

        //
        // Walkthroughs
        UserDefaults.standard.register(defaults: ["walkthroughs" : Register.registerWalkthroughDictionary])
        
        
        // Push everything to iCloud
        ICloudFunctions.shared.pushToICloud(toSync: [""])
        
        //
        // Check if the user has a valid subscription
        // Subscription Check 1
//        SubscriptionsCheck.shared.checkSubscription()
        
        //
        // Set Home Screen
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let homeScreen = settings["HomeScreen"]![0]
        
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
    // Did finish launching ----------------------------------------------------------------------------------------------
    //
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        application.registerForRemoteNotifications()
        
        //
        NSSetUncaughtExceptionHandler { exception in
            print(exception)
            print(exception.callStackSymbols)
        }
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
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        // Turn automatic yoga off
        if settings["AutomaticYoga"]![1] == -1 || settings["AutomaticYoga"]![2] == -1 {
            settings["AutomaticYoga"]![0] = 0
        }
        UserDefaults.standard.set(settings, forKey: "userSettings")
        
        
        // Indicate to the schedule the date of last opening
        // This is no persisted, if the app isn't quit, and the last day opened is not today, the schedule selects the correct day
        ScheduleVariables.shared.lastDayOpened = Date().setToMidnightUTC()
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
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
        InAppManager.shared.stopMonitoring()
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print("Memory Warning")
    }
    
    //
}
