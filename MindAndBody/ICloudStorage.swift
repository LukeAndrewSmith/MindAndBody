//
//  ICloudStorage.swift
//  MindAndBody
//
//  Created by Luke Smith on 12.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import SystemConfiguration

//
// MARK: ICloud related functions

class ICloudFunctions {
    static var shared = ICloudFunctions()
    private init() {}
    
    static let keyArray = ["userSettings", "selectedSchedule", "schedules", "scheduleTracking", "difficultyLevels", "profileAnswers", "trackingDictionaries", "trackingProgress", "customSessions", "meditationTimer", "walkthroughs"]

    //
    // Check if user wants to use icloud
    func ICloudEnabled() -> Bool {
        // Test is very silly, seems to force it to update and find something in i
//        let test = NSUbiquitousKeyValueStore.default.object(forKey: "userSettings") as! [[Int]]
        //
        // Check iCloud if exists incase first opening on new device
        if let iCloudSettings = NSUbiquitousKeyValueStore.default.object(forKey: "userSettings") {
//        if NSUbiquitousKeyValueStore.default.object(forKey: "userSettings") != nil {
//            let iCloudSettings = NSUbiquitousKeyValueStore.default.object(forKey: "userSettings") as! [[Int]]
            if (iCloudSettings as! [[Int]])[7][0] == 0 {
                return true
            } else {
                return false
            }
        // Fall back on userdefaults
        } else {
            if UserDefaults.standard.array(forKey: "userSettings") != nil {
                let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                if settings[7][0] == 0 {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        }
    }
    
    //
    // MARK: Update ICloud (NSUbiquitousKeys)
    // Pushes user defaults to icloud
    func pushToICloud(toSync: [String]) {
        if ICloudEnabled() {
            var endCount = 0
            var toSync = toSync
            // Sync all
            if toSync[0] == "" {
                endCount = ICloudFunctions.keyArray.count - 1
                toSync = ICloudFunctions.keyArray
            // Sync specific
            } else {
                endCount = toSync.count - 1
            }
            //
            for i in 0...endCount {
                let defaultToPush = UserDefaults.standard.object(forKey: toSync[i])
                NSUbiquitousKeyValueStore.default.set(defaultToPush, forKey: toSync[i])
            }
        }
    }
    
    //
    // MARK: Pull iCloud to user defaults
    // Mutates user defaults
    @objc func pullToDefaults() {
        //
        if ICloudEnabled() {
            //
            NSUbiquitousKeyValueStore.default.synchronize()
            //
            for i in 0...ICloudFunctions.keyArray.count - 1 {
                let defaultToPull = NSUbiquitousKeyValueStore.default.object(forKey: ICloudFunctions.keyArray[i])
                if defaultToPull != nil {
                    UserDefaults.standard.set(defaultToPull, forKey: ICloudFunctions.keyArray[i])
                }
            }
        }
    }
    
    func removeAll() {
        for i in 0...ICloudFunctions.keyArray.count - 1 {
            NSUbiquitousKeyValueStore.default.removeObject(forKey: ICloudFunctions.keyArray[i])
        }
        NSUbiquitousKeyValueStore.default.synchronize()
    }
}

