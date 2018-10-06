//
//  AppDelegate.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import UIKit
import StoreKit

//
// App Delegate Class --------------------------------------------------------------------------------------------------------
//
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        //
        // Subscriptions
        InAppManager.shared.startMonitoring()
        
        // MARK: TEST!! REMOVE
        // ICloud/UserDefaults Reset
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        ReminderNotifications.shared.cancelNotifications()

        
//        //
//        // MARK: Sessions check
//        // Compares sessions dictionaries and sorted sessions dictionaries to see if anything missing
//        var sessionsArray: Set<String> = []
//        // warmup, workout...
//        for key1 in sessionData.sessions.keys {
//            // classic, upper ,lower...
//            for key2 in (sessionData.sessions[key1]?.keys)! {
//                // Append Sessions
//                for key3 in (sessionData.sessions[key1]![key2]?.keys)! {
//                    sessionsArray.insert(key3)
//                }
//            }
//        }
//        var sortedSessionsArray: Set<String> = []
//        // warmup, workout...
//        for key1 in sessionData.sortedSessions.keys {
//            // classic, upper ,lower...
//            for key2 in (sessionData.sortedSessions[key1]?.keys)! {
//                for key3 in (sessionData.sortedSessions[key1]?[key2]?.keys)! {
//                    for key4 in (sessionData.sortedSessions[key1]?[key2]?[key3]?.keys)! {
//                        // Append Sessions
//                        for key5 in (sessionData.sortedSessions[key1]?[key2]?[key3]?[key4])! {
//                            sortedSessionsArray.insert(key5)
//                        }
//                    }
//                }
//            }
//        }
//        let notInSortedSessions = sortedSessionsArray.subtracting(sessionsArray)
//        let notInSessions = sessionsArray.subtracting(sortedSessionsArray)
//        // Duplicates
//        let duplicates = Array(Set(sortedSessionsArray.filter({ (i) in sortedSessionsArray.filter({ $0 == i }).count > 1})))
        
        //
        // Register Defaults --------------------------------------------------------------------------------
        //
        // Subscriptions
        UserDefaults.standard.register(defaults: ["userHasValidSubscription" : false])
        // Settings
        UserDefaults.standard.register(defaults: ["userSettings" : Register.defaultSettings])

        // Profile/Schedules
        // Selected Schedule
        UserDefaults.standard.register(defaults: ["selectedScheduleIndex" : 0])
        // Schedules
        UserDefaults.standard.register(defaults: ["schedules" : scheduleDataStructures.registerSchedules])
        // Difficulty Levels
        UserDefaults.standard.register(defaults: ["difficultyLevels" : scheduleDataStructures.defaultDifficultyLevels])
        // Profile Answers
        UserDefaults.standard.register(defaults: ["profileAnswers" : scheduleDataStructures.defaultProfileAnswers])
        UserDefaults.standard.register(defaults: ["lastProfileUpdateAlert" : Date().setToMidnightUTC()])
        // Lessons
        UserDefaults.standard.register(defaults: ["scheduleLessons" : scheduleDataStructures.defaultScheduleLessons])

        // Tracking
        // Tracking arrays [weekTracking, tracking]
        UserDefaults.standard.register(defaults: ["trackingDictionary" : Register.registerTrackingDictionary])
        // Progress, [currentProgress, lastResetWeek/Month]
        UserDefaults.standard.register(defaults: ["trackingProgress" : Register.registertrackingProgressDictionary])

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
        
        ScheduleVariables.shared.setSchedules()
        
        // Check if the user has a valid subscription
        // Subscription Check 1
//        SubscriptionsCheck.shared.checkSubscription()
        
        return true
    }

    //
    // Did finish launching ----------------------------------------------------------------------------------------------
    //
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
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
        
        rowTimer.invalidate()
        sessionTimer.invalidate()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
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
