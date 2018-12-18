//
//  UserData.swift
//  MindAndBody
//
//  Created by Luke Smith on 21.11.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation

//
//
class UserData {
    static var shared = UserData()
    private init() {}
    
    var userDefaults = ["userSubscriptionExpiryDate",
                        "userHasSub",
                        "userSettings",
                        "selectedScheduleIndex",
                        "schedules",
                        "difficultyLevels",
                        "profileAnswers",
                        "lastProfileUpdateAlert",
                        "trackingDictionary",
                        "trackingProgress",
                        "customSessions",
                        "meditationTimer",
                        "movementWeights",
                        "walkthroughs"
    ]
    
    // Updates if necessary
    func checkStoredDefaults() {
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let keys = settings.keys.sorted()
        for i in 0..<settings.keys.count {
            let key = keys[i]
            if settings[key] != Register.defaultSettings[key] {
                settings[key] = Register.defaultSettings[key]
            }
        }
        UserDefaults.standard.set(settings, forKey: "userSettings")
    }
    
    func registerDefaults() {
        // Register Defaults --------------------------------------------------------------------------------
        
        // Rating
        UserDefaults.standard.register(defaults: ["lastRatingsPrompt" : Date().setToMidnightUTC()])

        // Subscriptions
        UserDefaults.standard.register(defaults: ["userSubscriptionExpiryDate" : "0"])
        
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
    }
    
    /// Compares the userDefaults to the Register to check that UserDefaults contains all the necessary values, updating if needed (incase change version and update something in register that needs to be updated in userDefaults)
    func checkDefaults() {
        
        if (UserDefaults.standard.object(forKey: "userSubscriptionExpiryDate") as? String) != nil {
            UserDefaults.standard.register(defaults: ["userSubscriptionExpiryDate" : "0"])
        }
        
        if var settings = UserDefaults.standard.object(forKey: "userSettings") as? [String: [Int]] {
            let keys = Register.defaultSettings.keys.sorted()
            for key in keys {
                /// Entry does exists
                if let valueArray = settings[key] {
                    /// Entry isn't correct
                    if valueArray.count != Register.defaultSettings[key]?.count {
                        settings[key] = Register.defaultSettings[key]
                    }
                /// Entry doesn't exist
                } else {
                    settings.updateValue(Register.defaultSettings[key]!, forKey: key)
                }
            }
            /// Update
            UserDefaults.standard.set(settings, forKey: "userSettings")
        } else {
            UserDefaults.standard.register(defaults: ["userSettings" : Register.defaultSettings])
        }
        
        if (UserDefaults.standard.object(forKey: "selectedScheduleIndex") as? Int) != nil {
            UserDefaults.standard.register(defaults: ["selectedScheduleIndex" : 0])
        }

        if var schedules = UserDefaults.standard.object(forKey: "schedules") as? [[String: [[[String: Any]]]]] {
            for i in 0..<schedules.count {
                let scheduleContentKeys = scheduleDataStructures.emptySchedule.keys.sorted()
                for scheduleContentKey in scheduleContentKeys {
                    /// Entry does exists
                    if let contentArray = schedules[i][scheduleContentKey] {
                        switch scheduleContentKey {
                        case "schedule":
                            for j in 0..<contentArray.count { // Loop Week days
                                guard contentArray[j].count != 0 else { continue }
                                for k in 0..<contentArray[j].count { // Loop content of day
                                    if let group = contentArray[j][k]["group"] as? String { // Get group
                                        if contentArray[j][k].keys.sorted() != scheduleDataStructures.scheduleGroups[group.groupFromString()]?.keys.sorted() { // Group wrong format
                                            schedules[i][scheduleContentKey]?[j][k] = scheduleDataStructures.scheduleGroups[group.groupFromString()] ?? scheduleDataStructures.scheduleGroups[0]! // Update
                                        }
                                    } else { // No group, remove as error, should always have group
                                        schedules[i][scheduleContentKey]?[j].remove(at: k)
                                    }
                                }
                            }
                        case "scheduleInformation":
                            for key in scheduleDataStructures.emptySchedule[scheduleContentKey]?[0][0].keys.sorted() ?? [] {
                                if contentArray[0][0][key] == nil {
                                    schedules[i][scheduleContentKey]?[0][0].updateValue(scheduleDataStructures.emptySchedule[scheduleContentKey]?[0][0][key] as Any, forKey: key)
                                }
                            }
                        case "scheduleCreationHelp":
                            /// Only used once each time the schedule is created so no harm just resetting in
                            schedules[i][scheduleContentKey] = scheduleDataStructures.emptySchedule[scheduleContentKey]
                        default: break
                        }
                    /// Entry doesn't exist
                    } else {
                        schedules[i].updateValue(scheduleDataStructures.emptySchedule[scheduleContentKey]!, forKey: scheduleContentKey)
                    }
                }
            }
            /// Update
            UserDefaults.standard.set(schedules, forKey: "schedules")
        } else {
            UserDefaults.standard.register(defaults: ["schedules" : scheduleDataStructures.registerSchedules])
        }
        
//        "difficultyLevels"
//        "profileAnswers"
//        "lastProfileUpdateAlert"
//        "trackingDictionary"
//        "trackingProgress"
//        "customSessions"
//        "meditationTimer"
        
        if var weights = UserDefaults.standard.object(forKey: "movementWeights") as? [String : Int] {
            let registerWeights = Register.weightRegister()
            let weightKeys = weights.keys.sorted()
            for registerKey in registerWeights.keys.sorted() {
                if !weightKeys.contains(registerKey) {
                    weights.updateValue(registerWeights[registerKey]!, forKey: registerKey)
                }
            }
            UserDefaults.standard.set(weights, forKey: "movementWeights")
        }
        
//        "walkthroughs"
    }
    
}



class Tests {
    static var shared = Tests()
    private init() {}

    func sessionsCheck() {
        // MARK: Sessions check
        // Compares sessions dictionaries and sorted sessions dictionaries to see if anything missing
        var sessionsArray: Set<String> = []
        // warmup, workout...
        for key1 in sessionData.sessions.keys {
            // classic, upper ,lower...
            for key2 in (sessionData.sessions[key1]?.keys)! {
                // Append Sessions
                for key3 in (sessionData.sessions[key1]![key2]?.keys)! {
                    sessionsArray.insert(key3)
                }
            }
        }
        var sortedSessionsArray: Set<String> = []
        // warmup, workout...
        for key1 in sessionData.sortedSessions.keys {
            // classic, upper ,lower...
            for key2 in (sessionData.sortedSessions[key1]?.keys)! {
                for key3 in (sessionData.sortedSessions[key1]?[key2]?.keys)! {
                    for key4 in (sessionData.sortedSessions[key1]?[key2]?[key3]?.keys)! {
                        // Append Sessions
                        for key5 in (sessionData.sortedSessions[key1]?[key2]?[key3]?[key4])! {
                            sortedSessionsArray.insert(key5)
                        }
                    }
                }
            }
        }
        let notInSortedSessions = sortedSessionsArray.subtracting(sessionsArray)
        let notInSessions = sessionsArray.subtracting(sortedSessionsArray)
        // Duplicates
        let duplicates = Array(Set(sortedSessionsArray.filter({ (i) in sortedSessionsArray.filter({ $0 == i }).count > 1})))
        print("notInSortedSessions")
        print(notInSortedSessions)
        print("notInSessions")
        print(notInSessions)
        print("duplicates")
        print(duplicates)
    }
    
}

