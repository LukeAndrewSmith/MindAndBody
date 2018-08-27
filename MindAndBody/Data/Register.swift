//
//  UserData.swift
//  MindAndBody
//
//  Created by Luke Smith on 25.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation


//
// MARK: User Data

// Register to user defaults
enum Register {
    // --------------------------------------------------------
    // Settings
    static let defaultSettings: [String: [Int]] = [
        // Background image index - 0
        "BackgroundImage": [1],
        // Metric/Imperial - 6
        "Units": [0], // == "kg" (0), "lb" (1)
        // Time Based Sessions - 2
        "TimeBasedSessions": [0], // 0 == Off, 1 = on
        // Yoga Automatic - 3
        "AutomaticYoga": [0, 50, 5, 1], // [0], 0 == off, 1 == on, [1] = breath length, [2] = transition time, [3] = transition indicator
            // Defaults: 5.0s breaths, 5.0s transition, tibet singing bowl transition
            // Note numbers for breaths is stored as an int but represent a double with 1 decimal place, therefore stored is *10 the desired value
            // NOT THE BEST WAY TO STORE BREATH LENGTH!!!!
        // Rest times - 4
        "RestTimes": [0, 45, 10],
        // Notifications
        "ReminderNotifications": [420,-1,1], // [0]: morning, [1]: evening, [2]: motivational comments
        // [0]: -1 == off, 420 == 7:00 am (number of minutes), [1]: same, [3]: 0 == off, 1 == on (motivating comments)
        "CustomWarmupStretching": [0], // 0 == off (app chooses), 1 == on (custom)
        // Is icloud enabled, 0 == false, 1 == true
        "iCloud": [0],
    ]
    
    // --------------------------------------------------------
    // Walkthroughs
    //
    // Walkthrough
    static let registerWalkthroughDictionary: [String: Bool] =
        [
            // Session -- Workout (if workout walkthrough seen first, this is good enough for all other session screens, so sets session2 to true as well)
            "Sessions": false,
            // Session 2 -- Circuit, Stratching, Yoga - Workout -- (session2 not quite good enough for sessions, and workout screen has extra important note on weights not seen on other screens)
            "Session2": false,
            // Schedule
            "Schedule": false,
            // Tracking
            "Tracking": false,
            // Settings
            "Settings": false,
            // Automatic Yoga
            "AutomaticYoga": false,
            // Custom Session (i.e on sessions screen, first choice is where you access custom workouts etc)
            "CustomSessions": false,
    ]
    
    // --------------------------------------------------------
    // Meditation array Register
        // Array because order matters
    static let meditationArrayRegister: [[String: [[Any]]]] = []
    //
    static let meditationEmptySession: [String: [[Any]]] =
        [
            // Name - String
            "Name": [[""]],
            // Duration - Int
            "Duration": [[0]],
            // Bells, starting and ending bells go at first and last, interval bells in the middle
            // [Bell, Time] - [Int]
            "Bells": [[-1,0],[-1,0]],
            // Background Sound - Int
            "BackgroundSound": [[-1]]
    ]
    
    // --------------------------------------------------------
    // Custom Sessions
    // Warmup, Workout, Cardio, Stretching, Yoga
        // Array because indexe with ints
    static let customSessionsRegister: [String: [[String: [Any]]]] =
        [
            // Warmup -
            // [name] - string, [movements] - int, [sets] - int, [reps] - string
            "warmup": [],
            // Workout - 1
            // [name] - string, [movements] - int, [sets] - int, [reps] - string
            "workout": [],
            // Workout - Circuit - stored in workout
            // [name] - string, [movements] - int, [rounds] - int, [reps] - string
            // Cardio -
            // [name] - string, [movements] - int, [time/distance] - int
            "cardio": [],
            // Stretching -
            // [name] - string, [stretches] - int, [breaths] - int
            "stretching": [],
            // Yoga -
            // [name] - string, [stretches] - int, [poses] - int
            "yoga": []
    ]
    // Empty Session, Warmup, Workout, Workout - circuit - [string],[int],[int],[int]
    static let emptySessionFour: [String: [Any]] =
        [
            // Name - String - 0
            "name": [""],
            // Movements - Int - 1
            "movements": [],
            // Sets - Int - 2
            "setsBreathsTime": [],
            // Reps - String? - 3
            "reps": []
    ]
    // Empty Session, Cardio, Stretching, Yoga, - [string],[int][int]
    static let emptySessionThree: [String: [Any]] =
        [
            // Name - String - 0
            "name": [""],
            // Movements - Int - 1
            "movements": [],
            // Breaths/Time - Int  (called sets for simplicity in code)
            "setsBreathsTime": []
    ]
    
    // --------------------------------------------------------
    // Tracking
    static let registertrackingProgressDictionary: [String: Any] =
        // Update progress (first monday of last week completed (lastResetWeek) is used to check if progress needs to be reset to 0 for first entry of new week)
        [
            "WeekProgress": 0,
            "WeekGoal": 1,
            "ExtraSessions": 0,
            "LastResetWeek": Date().firstMondayInCurrentWeek
        ]
    
    // Tracking percentages
        // % = completed / planned
                // Note kept as array not dictionary as nicer to convert to and fro Date: String
    static let registerTrackingDictionary: [String: Int] = [:]
}
