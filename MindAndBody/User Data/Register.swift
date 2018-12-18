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
        "AutomaticYoga": [1, 40, 5, 0], // [0], 0 == off, 1 == on, [1] = breath length, [2] = transition time, [3] = transition indicator
            // Defaults: 5.0s breaths, 5.0s transition, tibet singing bowl transition
            // Note numbers for breaths is stored as an int but represent a double with 1 decimal place, therefore stored is *10 the desired value
            // NOT THE BEST WAY TO STORE BREATH LENGTH!!!!
        // Rest times - 4
        "RestTimes": [0, 45, 0],
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
            "Session": false,
            // Session 2 -- Circuit, Stratching, Yoga - Workout -- (session2 not quite good enough for sessions, and workout screen has extra important note on weights not seen on other screens)
            "Session2": false,
            // Schedule
            "Schedule": false,
            // Settings
            "Settings": false,
            // Automatic Yoga
            "AutomaticYoga": false,
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
            "endurance": [],
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


// MARK: Suggested Weights
extension Register {
    // Note saved as index for weight array, weight array goes from 0 to 300kg, in steps of 2.5
    // Conversion of index to weight is index * 2.5
    // This means no conversion necessary for pounds, simply same in array
    // --------------------------------------------------------
    // MARK:- Weighted Movements
    // MARK: Women
    // Level 1
    // W - weight, R - register, M - Metric, W - Women, L - Lower, 1 - level 1
    static let WRWL1: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 12,
            "frontSquat": 12,
            "legPress": 16,
            "dumbellFrontSquat": 4,
            "legExtensions": 6,
            // Legs (Hamstrings/Glutes)
            "deadlift": 12,
            "romanianDeadlift": 2,
            "weightedHipThrust": 8,
            "legCurl": 6,
            "oneLeggedDeadlift": 2,
            // Legs (General)
            "lungeDumbell": 2,
            "bulgarianSplitSquat": 2,
            "weightedStepUp": 2,
            // Legs (calves)
            "standingCalfRaise": 8,
            "seatedCalfRaise": 8,
            ]
    static let WRWU1: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 6,
            "kneelingPullDown": 3,
            "bentOverRowDumbell": 2,
            "tBarRow": 3,
            "rowMachine": 8,
            "latPullover": 2,
            // Pull (Upper Back)
            "facePull": 2,
            "leaningBackPullDown": 3,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 3,
            // Pull (Traps)
            "shrugDumbell": 4,
            // Pull (Biceps)
            "hammerCurl": 1,
            "hammerCurlCable": 1,
            "curl": 1,
            // Pull (Forearms)
            "forearmCurl": 4,
            "farmersCarry": 2,
            "reverseBarbellCurl": 4,
            // Push (Chest) ---------
            "benchPress": 4,
            "benchPressDumbell": 1,
            "semiInclineDumbellPress": 1,
            "platePress": 2,
            "barbellKneelingPress": 2,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 2,
            "standingShoulderPressDumbell": 1,
            "lateralRaise": 1,
            "frontRaise": 1,
            // Push (Triceps) //
            "closeGripBench": 4,
            "cableExtension": 1,
            "ropeExtension": 3,
            // Full Body ---------
            "cleanPress": 4,
            ]
    // Level 2
    static let WRWL2: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 16,
            "frontSquat": 14,
            "legPress": 20,
            "dumbellFrontSquat": 6,
            "legExtensions": 8,
            // Legs (Hamstrings/Glutes)
            "deadlift": 16,
            "romanianDeadlift": 4,
            "weightedHipThrust": 12,
            "legCurl": 6,
            "oneLeggedDeadlift": 3,
            // Legs (General)
            "lungeDumbell": 3,
            "bulgarianSplitSquat": 3,
            "weightedStepUp": 3,
            // Legs (calves)
            "standingCalfRaise": 12,
            "seatedCalfRaise": 12,
            ]
    static let WRWU2: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 8,
            "kneelingPullDown": 4,
            "bentOverRowDumbell": 3,
            "tBarRow": 4,
            "rowMachine": 10,
            "latPullover": 3,
            // Pull (Upper Back)
            "facePull": 3,
            "leaningBackPullDown": 4,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 5,
            // Pull (Traps)
            "shrugDumbell": 5,
            // Pull (Biceps)
            "hammerCurl": 2,
            "hammerCurlCable": 2,
            "curl": 2,
            // Pull (Forearms)
            "forearmCurl": 5,
            "farmersCarry": 3,
            "reverseBarbellCurl": 5,
            // Push (Chest) ---------
            "benchPress": 6,
            "benchPressDumbell": 2,
            "semiInclineDumbellPress": 2,
            "platePress": 2,
            "barbellKneelingPress": 3,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 4,
            "standingShoulderPressDumbell": 2,
            "lateralRaise": 2,
            "frontRaise": 2,
            // Push (Triceps) //
            "closeGripBench": 5,
            "cableExtension": 2,
            "ropeExtension": 4,
            // Full Body ---------
            "cleanPress": 6,
            ]
    // Level 3
    static let WRWL3: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 20,
            "frontSquat": 16,
            "legPress": 24,
            "dumbellFrontSquat": 8,
            "legExtensions": 10,
            // Legs (Hamstrings/Glutes)
            "deadlift": 20,
            "romanianDeadlift": 6,
            "weightedHipThrust": 16,
            "legCurl": 8,
            "oneLeggedDeadlift": 4,
            // Legs (General)
            "lungeDumbell": 4,
            "bulgarianSplitSquat": 4,
            "weightedStepUp": 4,
            // Legs (calves)
            "standingCalfRaise": 16,
            "seatedCalfRaise": 16,
            ]
    static let WRWU3: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 10,
            "kneelingPullDown": 6,
            "bentOverRowDumbell": 4,
            "tBarRow": 5,
            "rowMachine": 12,
            "latPullover": 4,
            // Pull (Upper Back)
            "facePull": 3,
            "leaningBackPullDown": 6,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 6,
            // Pull (Traps)
            "shrugDumbell": 6,
            // Pull (Biceps)
            "hammerCurl": 3,
            "hammerCurlCable": 3,
            "curl": 3,
            // Pull (Forearms)
            "forearmCurl": 7,
            "farmersCarry": 4,
            "reverseBarbellCurl": 6,
            // Push (Chest) ---------
            "benchPress": 8,
            "benchPressDumbell": 3,
            "semiInclineDumbellPress": 3,
            "platePress": 4,
            "barbellKneelingPress": 4,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 6,
            "standingShoulderPressDumbell": 3,
            "lateralRaise": 3,
            "frontRaise": 3,
            // Push (Triceps) //
            "closeGripBench": 6,
            "cableExtension": 3,
            "ropeExtension": 6,
            // Full Body ---------
            "cleanPress": 8,
            ]
    // MARK: Men
    // Level 1
    static let WRML1: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 12,
            "frontSquat": 12,
            "legPress": 16,
            "dumbellFrontSquat": 4,
            "legExtensions": 6,
            // Legs (Hamstrings/Glutes)
            "deadlift": 12,
            "romanianDeadlift": 2,
            "weightedHipThrust": 8,
            "legCurl": 6,
            "oneLeggedDeadlift": 2,
            // Legs (General)
            "lungeDumbell": 2,
            "bulgarianSplitSquat": 2,
            "weightedStepUp": 2,
            // Legs (calves)
            "standingCalfRaise": 8,
            "seatedCalfRaise": 8,
            ]
    static let WRMU1: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 8,
            "kneelingPullDown": 4,
            "bentOverRowDumbell": 3,
            "tBarRow": 4,
            "rowMachine": 10,
            "latPullover": 3,
            // Pull (Upper Back)
            "facePull": 3,
            "leaningBackPullDown": 4,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 5,
            // Pull (Traps)
            "shrugDumbell": 5,
            // Pull (Biceps)
            "hammerCurl": 2,
            "hammerCurlCable": 2,
            "curl": 2,
            // Pull (Forearms)
            "forearmCurl": 5,
            "farmersCarry": 3,
            "reverseBarbellCurl": 5,
            // Push (Chest) ---------
            "benchPress": 6,
            "benchPressDumbell": 2,
            "semiInclineDumbellPress": 2,
            "platePress": 2,
            "barbellKneelingPress": 3,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 4,
            "standingShoulderPressDumbell": 2,
            "lateralRaise": 2,
            "frontRaise": 2,
            // Push (Triceps) //
            "closeGripBench": 5,
            "cableExtension": 2,
            "ropeExtension": 4,
            // Full Body ---------
            "cleanPress": 6,
            ]
    // Level 2
    static let WRML2: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 16,
            "frontSquat": 14,
            "legPress": 20,
            "dumbellFrontSquat": 6,
            "legExtensions": 6,
            // Legs (Hamstrings/Glutes)
            "deadlift": 16,
            "romanianDeadlift": 4,
            "weightedHipThrust": 12,
            "legCurl": 6,
            "oneLeggedDeadlift": 3,
            // Legs (General)
            "lungeDumbell": 4,
            "bulgarianSplitSquat": 4,
            "weightedStepUp": 4,
            // Legs (calves)
            "standingCalfRaise": 12,
            "seatedCalfRaise": 12,
            ]
    static let WRMU2: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 12,
            "kneelingPullDown": 8,
            "bentOverRowDumbell": 5,
            "tBarRow": 6,
            "rowMachine": 16,
            "latPullover": 4,
            // Pull (Upper Back)
            "facePull": 4,
            "leaningBackPullDown": 6,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 6,
            // Pull (Traps)
            "shrugDumbell": 6,
            // Pull (Biceps)
            "hammerCurl": 3,
            "hammerCurlCable": 3,
            "curl": 3,
            // Pull (Forearms)
            "forearmCurl": 6,
            "farmersCarry": 4,
            "reverseBarbellCurl": 6,
            // Push (Chest) ---------
            "benchPress": 12,
            "benchPressDumbell": 4,
            "semiInclineDumbellPress": 4,
            "platePress": 4,
            "barbellKneelingPress": 4,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 6,
            "standingShoulderPressDumbell": 3,
            "lateralRaise": 3,
            "frontRaise": 3,
            // Push (Triceps) //
            "closeGripBench": 8,
            "cableExtension": 3,
            "ropeExtension": 6,
            // Full Body ---------
            "cleanPress": 8,
            ]
    // Level 3
    static let WRML3: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 20,
            "frontSquat": 16,
            "legPress": 24,
            "dumbellFrontSquat": 6,
            "legExtensions": 8,
            // Legs (Hamstrings/Glutes)
            "deadlift": 20,
            "romanianDeadlift": 6,
            "weightedHipThrust": 16,
            "legCurl": 8,
            "oneLeggedDeadlift": 4,
            // Legs (General)
            "lungeDumbell": 6,
            "bulgarianSplitSquat": 6,
            "weightedStepUp": 6,
            // Legs (calves)
            "standingCalfRaise": 16,
            "seatedCalfRaise": 16,
            ]
    static let WRMU3: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 16,
            "kneelingPullDown": 10,
            "bentOverRowDumbell": 6,
            "tBarRow": 10,
            "rowMachine": 20,
            "latPullover": 6,
            // Pull (Upper Back)
            "facePull": 5,
            "leaningBackPullDown": 8,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 8,
            // Pull (Traps)
            "shrugDumbell": 8,
            // Pull (Biceps)
            "hammerCurl": 4,
            "hammerCurlCable": 4,
            "curl": 4,
            // Pull (Forearms)
            "forearmCurl": 8,
            "farmersCarry": 6,
            "reverseBarbellCurl": 8,
            // Push (Chest) ---------
            "benchPress": 16,
            "benchPressDumbell": 6,
            "semiInclineDumbellPress": 6,
            "platePress": 6,
            "barbellKneelingPress": 6,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 8,
            "standingShoulderPressDumbell": 4,
            "lateralRaise": 4,
            "frontRaise": 4,
            // Push (Triceps) //
            "closeGripBench": 12,
            "cableExtension": 4,
            "ropeExtension": 8,
            // Full Body ---------
            "cleanPress": 12,
            ]
    
    static let weightRegister = { () -> [String : Int] in
        let weightDictUpper = Register.WRWL1
        let weightDict = weightDictUpper.merging(Register.WRWU1) { (current, _) in current }
        return weightDict
    }
}
