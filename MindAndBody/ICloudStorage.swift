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
// MARK: Check internet/celular connection
public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
}

//
// MARK: ICloud related functions

class ICloudFunctions {
    static var shared = ICloudFunctions()
    private init() {}
    
    static let keyArray = ["userSettings", "selectedSchedule", "schedules", "scheduleTracking", "difficultyLevels", "profileAnswers", "trackingArrays", "trackingProgress", "customSessions", "meditationTimer", "walkthroughs"]
    // Note: timestamp set after looping array
    
    //
    // Sync icloud and defaults
    // Function
        // Checks internet connection
        // Checks wether to pull or push
        // Pull or pushes
    // Input:
        // Array of the keys to be updated, passed to push/pull functions
            // "" = update all
    func sync(toSync: [String]) {
        // Check connection
        if Reachability.isConnectedToNetwork() && ICloudEnabled() {
            //
            if userDefaultsMoreUpToDateThanICloud() {
                pushToICloud(toSync: toSync)
            } else {
                pullIToDefaults(toSync: toSync)
            }
        }
    }
    // TODO: EDGE CASE NOT HANDLED
        // Current functionality
            // User changes defaults on ipad app with connection -> pushes to icloud
            // User opens iphone app with no connection -> icloud not pulled
            // User gain connection and changes default -> pushes to icloud
                // This replaces whatever was done on ipad
    
            // Push default with connection after not having connection
    
    //
    // MARK: Compare
    // Return:
        // true = userdefaults more up to date
        // false = icloud more up to date
    func userDefaultsMoreUpToDateThanICloud() -> Bool {
        let defaultsTimestamp = UserDefaults.standard.object(forKey: "iCloudTimestamp")
        let iCloudTimestamp = NSUbiquitousKeyValueStore.default.object(forKey: "iCloudTimestamp")
        //
        if defaultsTimestamp > iCloudTimestamp {
            return true
        } else {
            return false
        }
    }
    
    //
    // Check if user wants to use icloud
    // Return:
        // true
        // false
    func ICloudEnabled() -> Bool {
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        if settings[7][0] == 0 {
            return true
        } else {
            return false
        }
    }
    
    //
    // MARK: Update ICloud (NSUbiquitousKeys)
        // Pushes user defaults to icloud
    func pushToICloud(toSync: [String]) {
        var endCount = 0
        // Sync all
        if toSync[0] == "" {
            endCount = keyArray.count - 1
        // Sync specific
        } else {
            endCount = toSync.count - 1
        }
        //
        for i in 0...endCount {
            let defaultToPush = UserDefaults.standard.object(forKey: toSync[i])
            NSUbiquitousKeyValueStore.default.setValue(defaultToPush, forKeyPath: toSync[i])
        }
        //
        setTimeStamps()
    }
    
    //
    // MARK: Pull iCloud to user defaults
    // Mutates user defaults
    func pullIToDefaults(toSync: [String]) {
        var endCount = 0
        // Sync all
        if toSync[0] == "" {
            endCount = keyArray.count - 1
            // Sync specific
        } else {
            endCount = toSync.count - 1
        }
        //
        for i in 0...endCount {
            let defaultToPull = NSUbiquitousKeyValueStore.default.object(forKey: toSync[i])
            UserDefaults.standard.set(defaultToPull, forKey: toSync[i])
        }
        //
        setTimeStamps()
    }
    
    //
    func setTimeStamps() {
        let timeStamp = Date().timeIntervalSince1970
        UserDefaults.standard.set(timeStamp, forKey: "iCloudTimestamp")
        NSUbiquitousKeyValueStore.default.setValue(timeStamp, forKeyPath: "iCloudTimestamp")
    }
}

