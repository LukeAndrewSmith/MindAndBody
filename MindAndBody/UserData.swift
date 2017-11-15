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




//
// Custom Section
struct customData {
    
    // Warmup, Workout, Cardio, Stretching, Yoga
    var customSession: [[[Any]]] =
        [
            // Warmup
            // [name] - string, [movements] - int, [sets] - int, [reps] - string
            [],
            // Workout
            // [name] - string, [movements] - int, [sets] - int, [reps] - string
            [],
            // Workout - Circuit
            // [name] - string, [movements] - int, [rounds] - int, [reps] - string
            [],
            // Cardio
            // [name] - string, [movements] - int, [time/distance] - int
            [],
            // Stretching
            // [name] - string, [stretches] - int, [breaths] - int
            [],
            // Yoga
            // [name] - string, [stretches] - int, [poses] - int
            []
    ]
    
    // Meditation
    var meditationArray: [[[[Any]]]] = []
    
}


enum customSectionEmtpySessions {
    
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
    static let defaultSettings: [[Int]] = [
        // Background image index - 0
        [2],
        // Home Screen - 1 (Defaults to schedule)
        [1],
        // Time Based Sessions - 2
        [0], // 0 == Off, 1 = on
        // Yoga Automatic - 3
        [0, -1, -1, -1], // [0], 0 == off, 1 == on
        // Rest times - 4
        [5, 45, 10],
        // Default Image - 5
        [0],   // 0 == "demonstration", 1 == "targetArea"
        // Metric/Imperial - 6
        [0], // == "kg" (0), "lb" (1)
        // Is icloud enabled, 0 == true, 1 == false
        [1],
    ]
    
    // --------------------------------------------------------
    // Walkthroughs
    //
    // Walkthrough
    static let registerWalkthroughArray: [Bool] =
        [
            // Notifications popup - 0
            false,
            // Mind Body, homescreen, - 1
            false,
            // Final Choice, - 2
            false,
            // Session - 3
            false,
            // Session 2 - 4
            false,
            // Schedule - 5
            false,
            // Tracking - 6
            false,
            // Profile - 7
            false,
            // Profile 'Me' - 8
            false,
            // Profile 'Goals' - 9
            false,
            // Profile 'Nº Session' - 10
            false,
            // Settings - 11
            false,
            // Automatic Yoga - 12
            false
    ]
    
    // --------------------------------------------------------
    // Meditation array Register
    static let meditationArrayRegister: [[[[Any]]]] = []
    //
    static let meditationEmptySession: [[[Any]]] =
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
    
    // --------------------------------------------------------
    // Custom Sessions
    // Warmup, Workout, Cardio, Stretching, Yoga
    static let customSessionsRegister: [[[[Any]]]] =
        [
            // Warmup - 0
            // [name] - string, [movements] - int, [sets] - int, [reps] - string
            [],
            // Workout - 1
            // [name] - string, [movements] - int, [sets] - int, [reps] - string
            [],
            // Workout - Circuit - 2
            // [name] - string, [movements] - int, [rounds] - int, [reps] - string
            [],
            // Cardio - 3
            // [name] - string, [movements] - int, [time/distance] - int
            [],
            // Stretching - 4
            // [name] - string, [stretches] - int, [breaths] - int
            [],
            // Yoga - 5
            // [name] - string, [stretches] - int, [poses] - int
            []
    ]
    // Empty Session, Warmup, Workout, Workout - circuit - [string],[int],[int],[int]
    static let emptySessionFour: [[Any]] =
        [
            // Name - String - 0
            [],
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
            [],
            // Movements - Int - 1
            [],
            // Breaths/Time - Int
            []
    ]
    
    // --------------------------------------------------------
    // Tracking
    static let registerTrackingProgressArray: [Any] =
        // Update progress (first monday of last week completed (lastResetWeek) is used to check if progress needs to be reset to 0 for first entry of new week)
            // Week - [weekProgress, weekGoal, lastResetWeek]
        [0, 1, Date().firstMondayInCurrentWeek]
    
    // Tracking percentages
        // % = completed / planned
    static let registerTrackingDictionaries: [[Date: Int]] =
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
