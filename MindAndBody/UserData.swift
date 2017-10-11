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
    static let scheduleTrackingArrays: [Int:[[Bool]]] =
        [
            // MARK: Mind
            0:
                [
                    // 0
                    [false],
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
                    // Type - High Intesnsity, Steady State
                    [
                        false,
                        false
                    ],
                    // --------------
                    // 4 | High Intensity To Do - warmup, cardio, stretching
                    [
                        false,
                        false,
                        false
                    ],
                    // ------------
                    // Steady State
                    // 5 | Steady State To Do 2 - 2 - To Do
                    [
                        false,
                        false,
                        false,
                        ]
            ],
            // MARK: Toning
            3:
                [
                    // 0
                    [false],
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
        // Background image index
        [2],
        // Home Screen
        [0],
        // Time Based Sessions
        [0], // == Off
        // Yoga Automatic
        [0, -1, -1, -1],
        // Rest times
        [15, 45, 10],
        // Default Image
        [0],   // 0 == "demonstration", 1 == "targetArea"
        // Metric/
        [0], // == "kg"
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
    static let registerTrackingArray: [[Any]] =
    // Update progress (first monday of last week/month completed (lastResetWeek/Month) is used to check if progress needs to be reset to 0 for first entry of new week/month)
        [
            // Week - [weekProgress, lastResetWeek]
            [0, Date().firstMondayInCurrentWeek],
            // Month - [monthProgress, lastResetMonth]
            [0, Date().firstMondayInMonth]
    ]
}

