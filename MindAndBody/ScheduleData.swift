//
//  ScheduleData.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation

//
// Custom Section
struct scheduleData {
    
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


enum scheduleDataStructures {
    
    //
    // MARK: Schedule Tracking, tracking what youve done each week, putting a tick next to what you've done in schedule if true
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
    
    
    // MARK: Profile Data
    //
    // Questions & Answers
    static let profileQA: [[[String]]] =
    [
        // Me
        [
            // Age
            ["profileQ1"], // Age
            // Gender
            ["profileQ2", "profileA21", "profileA22", "profileA23"], // Gender
            // Flexibility
            ["profileQ3", "profileA31", "profileA32", "profileA33"], // Hamstrings
            ["profileQ4", "profileA41", "profileA42", "profileA43"], // Hips
            ["profileQ5", "profileA51", "profileA52", "profileA53"], // Hips/Ankles
            ["profileQ6", "profileA61", "profileA62", "profileA63"], // Knees
            ["profileQ7", "profileA71", "profileA72", "profileA73"], // Back
            ["profileQ8", "profileA81", "profileA82", "profileA83"], // Neck
            // Balance
            ["profileQ9", "profileA91", "profileA92", "profileA93"], // Answer 1 and 2 hold same value
                // , "profileA94" - yes with eyes closed looking up, currently unused but would be good to use
            // Experience
            ["profileQ10", "profileA101", "profileA102", "profileA103"], // Yoga
            ["profileQ11", "profileA111", "profileA112", "profileA113"], // Workout
            ["profileQ12", "profileA121", "profileA122", "profileA123"], // Cardio (Endurance)
            // Strength
            ["profileQ13", "profileA131", "profileA132", "profileA133"], // Pushup
            ["profileQ14", "profileA141", "profileA142", "profileA143"], // Pullup
            ["profileQ15", "profileA151", "profileA152", "profileA153"], // // Used for presenting weights
            // Endurance
            ["profileQ16", "profileA161", "profileA162", "profileA163"], // Endurance
            // Mind
            ["profileQ17", "profileA171", "profileA172", "profileA173"], // // Calm
            ["profileQ18", "profileA181", "profileA182", "profileA183"], // // Contentedness
            // General
            ["profileQ19", "profileA191", "profileA192", "profileA193"], // // Body Contentedness
            ["profileQ20", "profileA201", "profileA202", "profileA203"], // // Time
            ["profileQ21", "profileA211", "profileA212", "profileA213"], // // Commitment
        ],
        // Goals
        [
            // Mind
            ["mind"],
            // Flexibility
            ["flexibility"],
            // Endurance
            ["endurance"],
            // Toning
            ["toning"],
            // Muscle Gain
            ["muscleGain"],
            // Strength
            ["strength"],
        ],
        // Groups
        [
            // Total
            ["totalNumberSession"],
            // Mind
            ["mind"],
            // Flexibility
            ["flexibility"],
            // Endurance
            ["endurance"],
            // Toning
            ["toning"],
            // Muscle Gain
            ["muscleGain"],
            // Strength
            ["strength"],
        ]
    ]
    
    //
    // Data
    // Note: All scales 0,1,2
    // Note: All scales default to 1
    // Layer 1, Questions
    static let defaultProfileAnswers: [[Int]] =
        [
//            [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            [0,0,0,0,0,0],
            [0,0,0,0,0,0,0],
            // Did complete, checks if all sections have actually been pressed
            [0,0,0]
        ]
    
    // Layer 4: Final
    static let defaultDifficultyLevels: [[Int]] =
        [
            // Flexibility - 0
            [
                // Overall
                1,
                // Hamstrings
                1,
                // Hips
                1,
                // Back/Neck
                1
            ],
            // Yoga - 1
            [
                // Yoga Level
                1,
                // Strength Yoga Level
                1
            ],
            // Endurance - 2
            [
                // Endurance Level
                1
            ],
            // Toning/Muscle/Strength - 3
            [
                // Workout Level
                1,
                // Workout Level Lower
                1
            ]
        ]
    
    
    // Schedules
    static let schedules: [[[Int]]] =
    [
        // App Schedule
        [
            // Monday
            [],
            // Tuesday
            [],
            // Wednesday
            [],
            // Thursday
            [],
            // Friday
            [],
            // Saturday
            [],
            // Sunday
            []
        ]
    ]
    
    // Custom schedules insert this into schedules array
    static let emptyWeek: [[Int]] =
        [
            // Monday
            [],
            // Tuesday
            [],
            // Wednesday
            [],
            // Thursday
            [],
            // Friday
            [],
            // Saturday
            [],
            // Sunday
            []
    ]
    
}



