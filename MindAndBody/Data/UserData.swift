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

enum customSectionEmptySessions {
    
    // Empty Session, Warmup, Workout, Workout - circuit - [string],[int],[int],[int]
    static let emptySessionFour: [[Any]] =
        [
            // Name - String
            [""],
            // Movements - Int
            [],
            // Sets - Int || Rounds - Int ([nRounds, -1], -1 indicates that its a circuit workout)
            [],
            // Reps - String?
            []
    ]
    
    // Empty Session, Cardio, Stretching, Yoga, - [string],[int],[int]
    static let emptySessionThree: [[Any]] =
        [
            // Name - String
            [""],
            // Movements - Int
            [],
            // Reps - Int
            []
    ]
    
    //
    static let emptySessionMeditation: [[[Any]]] =
        [
            // Name - String
            [[]],
            // Duration - Int
            [[]],
            // Bells, starting and ending bells go at first and last, interval bells in the middle
            // [Bell, Time] - [Int]
            [[-1,0],[-1,0]],
            // Background Sound - Int
            [[-1]]
    ]
    
    
    //
    // MARK: Schedule Tracking, tracking what youve done each week, putting a tick next to what you've done in schedule if true
    //
    static let scheduleTrackingArrays: [Int:[[Any]]] =
        [
            // MARK: Mind
            0:
                [
                    // 0
                    [false],
                    // Choice progress state
                    // Indicates which session was selected, i.e which selection was made to obtain the warmup/session/stretching choice
                    [0,0],
                    // Yoga, Meditation Walk
                    [
                        false,
                        false,
                        false
                    ],
                    // 4 | To Do Yoga - Warmup, Practice
                    [
                        false,
                        false
                    ]
            ],
            
            // Note: Choice = ["title","contents","contents"...]
            // MARK: Flexibility
            1:
                [
                    // 0
                    [false],
                    // Choice progress state
                    // Indicates which session was selected, i.e which selection was made to obtain the warmup/session/stretching choice
                    [0,0],
                    // 4 | To Do Flexibility - Warmup, Session
                    [
                        false,
                        false
                    ]
            ],
            
            // MARK: Endurance
            2:
                [
                    // 0
                    [false],
                    // Choice progress state
                    // Indicates which session was selected, i.e which selection was made to obtain the warmup/session/stretching choice
                    [0,0],
                    // Type - High Intesnsity, Steady State
                    [
                        false,
                        false
                    ],
                    // --------------
                    // 4 | High Intensity To Do - warmup, cardio, stretching
                    // or  ------------
                    // Steady State
                    // 5 | Steady State To Do 2 - 2 - To Do
                    [
                        false,
                        false,
                        false
                    ]
            ],
            
            // MARK: Toning
            3:
                [
                    // 0
                    [false],
                    // Choice progress state
                    // Indicates which session was selected, i.e which selection was made to obtain the warmup/session/stretching choice
                    [0,0],
                    // 3 | Toning To Do, warmup, session, stretching
                    [
                        false,
                        false,
                        false
                    ]
            ],
            
            // MARK: Muscle Gain
            4:
                [
                    // 0
                    [false],
                    // Choice progress state
                    // Indicates which session was selected, i.e which selection was made to obtain the warmup/session/stretching choice
                    [0,0],
                    // 4 | Muscle Gain To Do - Warmup, session, stretching
                    [
                        false,
                        false,
                        false
                    ]
            ],
            
            // MARK: Strength
            5:
                [
                    // 0
                    [false],
                    // Choice progress state
                    // Indicates which session was selected, i.e which selection was made to obtain the warmup/session/stretching choice
                    [0,0],
                    // 4 | Strength To Do, Warmup, Session, Stretching
                    [
                        false,
                        false,
                        false
                    ]
            ]
    ]
    
}

// Settings
enum Register {
    // --------------------------------------------------------
    // Settings
    static let defaultSettings: [String: [Int]] = [
        // Background image index - 0
        "BackgroundImage": [2],
        // Home Screen - 1 (Defaults to schedule)
        "HomeScreen": [1],
        // Time Based Sessions - 2
        "TimeBasedSessions": [0], // 0 == Off, 1 = on
        // Yoga Automatic - 3
        "AutomaticYoga": [0, 30, 6, 1], // [0], 0 == off, 1 == on  // Defaults: 5.0s breaths, 7s indicator transition, tibet singing bowl transition // Note numbers are indexes to array
        // Rest times - 4
        "RestTimes": [0, 45, 10],
        // Metric/Imperial - 6
        "Units": [0], // == "kg" (0), "lb" (1)
        // Notifications
        "ReminderNotifications": [1], // 0 == disabled, 1 == enabled
        // Is icloud enabled, 0 == false, 1 == true
        "iCloud": [0],
    ]
    
    // --------------------------------------------------------
    // Walkthroughs
    //
    // Walkthrough
    static let registerWalkthroughDictionary: [String: Bool] =
        [
            // Final Choice
            "FinalChoice": false,
            // Session
            "Sessions": false,
            // Session 2
            "Session2": false,
            // Schedule
            "Schedule": false,
            // Tracking
            "Tracking": false,
            // Profile
            "Profile": false,
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
            "Name": [[]],
            // Duration - Int
            "Duration": [[]],
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
    static let customSessionsRegister: [String: [[[Any]]]] =
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
    static let emptySessionFour: [[Any]] =
        [
            // Name - String - 0
            [""],
            // Movements - Int - 1
            [],
            // Sets - Int - 2
            [],
            // Reps - String? - 3
            []
    ]
    // Empty Session, Cardio, Stretching, Yoga, - [string],[int][int]
    static let emptySessionThree: [[Any]] =
        [
            // Name - String - 0
            [""],
            // Movements - Int - 1
            [],
            // Breaths/Time - Int
            []
    ]
    
    // --------------------------------------------------------
    // Tracking
    static let registertrackingProgressDictionary: [String: Any] =
        // Update progress (first monday of last week completed (lastResetWeek) is used to check if progress needs to be reset to 0 for first entry of new week)
        [
            "WeekProgress": 0,
            "WeekGoal": 1,
            "LastResetWeek": Date().firstMondayInCurrentWeek
        ]
    
    // Tracking percentages
        // % = completed / planned
                // Note kept as array not dictionary as nicer to convert to and fro Date: String
    static let registerTrackingDictionaries: [[String: Int]] =
    [
        // Week Tracking
            // Tracks % during each week
                // -> Reset every week
                    // Stores 7 values, 1 for each day
        [:],
        // Tracking
            // Tracks % associated with monday of every week from beginning of using the app
        [:]
    ]
}
