//
//  AppDelegate.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import UIKit
import StoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        /// Initial register
        UserData.shared.registerDefaults()
        
        /// Check that the saved defaults are in the same format as the register defaults
            /// This is incase defaults are changed in an update
        UserData.shared.checkDefaults()
        
        /// Retreives the current schedule
        ScheduleManager.shared.setSchedules()
                
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// Subscriptions Monitoring
        InAppManager.shared.startMonitoring()
        InAppManager.shared.loadProducts()

        /// Check if the user has a valid subscription
/// Testing: FOR TESTING ON SIMULATOR AS SUBS DON'T WORK
// {
//        Loading.shared.shouldPresentLoading = false
//        hasValidSubscription = true
// }
        InAppManager.shared.checkSubscription()

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
        
        /// Ensure session timers invalidated (cardio, automatic session)
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
}
