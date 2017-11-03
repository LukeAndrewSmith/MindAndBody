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
    
    
    // MARK: Profile Data
    //
    // Questions & Answers
    static let profileQA: [[[String]]] =
        [
            // Me
            [
                // Age - GOOD
                ["profileQ1"], // Age - 0
                // Gender - GOOD
                ["profileQ2", "profileA21", "profileA22", "profileA23"], // Gender - 1
                // Experience - GOOD
                ["profileQ3", "profileA31", "profileA32", "profileA33"], // Yoga - 2
                ["profileQ4", "profileA41", "profileA42", "profileA43"], // Workout - 3
                ["profileQ5", "profileA51", "profileA52", "profileA53"], // Cardio (Endurance) (Amount) - 4
                // Endurance - GOOD
                ["profileQ6", "profileA61", "profileA62", "profileA63"], // Endurance (Ability) - 5
                ["profileQ7", "profileA71", "profileA72", "profileA73"], // Endurance (Opinion) - 6
                // Strength
                ["profileQ8", "profileA81", "profileA82", "profileA83"], // Pushup - 7
                ["profileQ9", "profileA91", "profileA92", "profileA93"], // Pullup - 8
                ["profileQ10", "profileA101", "profileA102", "profileA103"], // Squat - 9
                ["profileQ11", "profileA111", "profileA112", "profileA113"], // Strength (Opinion) - 10
                // Flexibility - GOOD
                ["profileQ12", "profileA121", "profileA122", "profileA123"], // Hamstrings - 11
                ["profileQ13", "profileA131", "profileA132", "profileA133"], // Hips - 12
                ["profileQ14", "profileA141", "profileA142", "profileA143"], // Hips/Ankles - 13
                ["profileQ15", "profileA151", "profileA152", "profileA153"], // Knees - 14
                ["profileQ16", "profileA161", "profileA162", "profileA163"], // Back (Backward) - 15
                ["profileQ17", "profileA171", "profileA172", "profileA173"], // Back (Lower - sideways) - 16
                ["profileQ18", "profileA181", "profileA182", "profileA183"], // Neck - 17
                // Balance - GOOD
                ["profileQ19", "profileA191", "profileA192", "profileA193"], // Balance - 18
                // Time/Commitment
                ["profileQ20", "profileA201", "profileA202", "profileA203"], // // Time - 19
                ["profileQ21", "profileA211", "profileA212", "profileA213"], // // Commitment - 20
            ],
            // Goals
            [
                // Mindfulness
                ["mindII"],
                // Yoga
                ["yogaII"],
                // Flexibility
                ["flexibilityI"],
                // Endurance
                ["enduranceI"],
                // Toning
                ["toningI"],
                // Muscle Gain
                ["muscleGainI"],
                // Strength
                ["strengthI"],
                ],
            // Groups
            [
                // Mind
                ["mindI"],
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
    
    static let groupNames =
        [
            "mind",
            "flexibility",
            "endurance",
            "toning",
            "muscleGain",
            "strength",
            ]
    
    static let shortenedGroupNames =
        [
            // Mind
            "mindS",
            // Flexibility
            "flexibilityS",
            // Endurance
            "enduranceS",
            // Toning
            "toningS",
            // Muscle Gain
            "muscleGainS",
            // Strength
            "strengthS",
            ]
    
    //
    static let answerImageArray = ["", "", "", "", "", "", "", "pushUp", "pullUp", "bodyweightSquat", "", "standingHamstring", "butterfly", "deepSquat", "hero", "upwardDog", "legDrop", "neckRotatorStretch", "tree", "", "", "", "", "", ""]
    
    
    //
    // Data
    // Note: All scales 0,1,2
    // Note: All scales default to 1
    // Layer 1, Questions
    // sees profileQA above for indexing
    static let defaultProfileAnswers: [[Int]] =
        [
            //            [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
            // Me
            [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
            // Goals
            [0,0,0,0,0,0,0],
            //0,1,2,3,4,5,6
            // Sessions
            // 0 = total, 1 - 6 = mind - strength
            [0,0,0,0,0,0,0],
            // Ranges (could be put in seperate array with arrays for each range but not in the mood to do so)
            // note no range for total sessions
            [0,0,  0,0,  0,0,  0,0,  0,0,  0,0]
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
                // Workout Level Upper
                1,
                // Workout Level Lower
                1
            ]
    ]
    
    
    // Schedules
    static let registerSchedules: [[[Any]]] =
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
                [],
                // Full week as list - 7
                [],
                // Title - 8
                ["appSchedule"],
                // Schedule style: day(0) or full week (1) - 9
                [0]
            ],
            ]
    
    // Custom schedules insert this into schedules array
    static let emptyWeek: [[Any]] =
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
            [],
            // Full week list - 7
            [],
            // Title - 8
            [""], // String
            // Schedule style: day(0) or full week (1) - 9
            [0]
    ]
    
    // Tracking
    static let registerTracking: [[[[[Bool]]]]] =
        [
            // Tracking App Schedule
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
                [],
                // Full week as list - 7
                []
            ],
            // Tracking Custom Schedule
    ]
    
    // Empty Tracking Week
    static let emptyTrackingWeek: [[[[Bool]]]] =
        // Tracking App Schedule
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
            [],
            // Full week as list - 7
            []
    ]
    
    //
    // MARK: Schedule Tracking, tracking what youve done each week, putting a tick next to what you've done in schedule if true
    static let scheduleTrackingArrays: [Int:[[Bool]]] =
        [
            // MARK: Mind
            // NOTE MIND HAS CHOICE OF GOING FOR A WALK, IF SELECTED WONT GO GREEN, WILL JUST TAKE BACK TO INITIAL SCREEN AND SET TO TRUE
            0:
                [
                    // 0
                    [false],
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
                    // --------------
                    // 4,5 , High intensity and steady state, both use same array of bool
                    [
                        false,
                        false,
                        false
                    ],
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



