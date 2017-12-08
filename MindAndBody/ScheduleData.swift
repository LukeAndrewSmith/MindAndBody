//
//  ScheduleData.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation

class TemporaryWeekArray {
    static let shared = TemporaryWeekArray()
    private init() {}

    // Temporary week array
    // If viewed as week, then creates a temporary array of the full week from the schedules sotred to user defaults
    // This array contains dictionaries with fields, group, day, index, so that the relevant group in the schedulesTracking array can be found and updated
    // This avoids the need to store two seperate arrays for week view and day view
    var weekArray: [[String: Any]] = []
    // "group": ""
    // "index0": Int // for indexing in week
    // "index1": Int
}

extension Int {
    func groupFromInt() -> String {
        let groupIntAsString: [Int: String] = [
            0: "mind",
            1: "flexibility",
            2: "endurance",
            3: "toning",
            4: "muscleGain",
            5: "strength"]
        return groupIntAsString[self]!
    }
}

extension String {
    func groupFromString() -> Int {
        let groupStringAsInt: [String: Int] = [
            "mind": 0,
            "flexibility": 1,
            "endurance": 2,
            "toning": 3,
            "muscleGain": 4,
            "strength": 5]
        return groupStringAsInt[self]!
    }
}

enum scheduleDataStructures {
    
    // MARK: Profile Data
    //
    // Questions & Answers
    static let profileQA: [[String]] =
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
        ]
    
    // Schedule creation help
    // ENSURE IF CHANGING THAT NAMES OF QUESTIONS ETC ARE THE SAME AS THE INDEXING IN Schedules[..]["ScheduleCreationHelp"]
    static let scheduleCreationHelp: [[[String]]] =
        [
            // Schedule creation questions - 0
            [
                // gender
                // Time/Commitment
                ["scheduleQTime", "scheduleATime1", "scheduleATime2", "scheduleATime3"], // // Time - 0
                ["scheduleQPriority", "scheduleAPriority1", "scheduleAPriority2", "scheduleAPriority3"], // Priority - 1
            ],
            // Goals - 1
            [
                // Mindfulness
                ["mindG"],
                // Yoga
                ["yogaG"],
                // Flexibility
                ["flexibilityG"],
                // Endurance
                ["enduranceG"],
                // Toning
                ["toningG"],
                // Muscle Gain
                ["muscleGainG"],
                // Strength
                ["strengthG"],
            ],
            // Groups - 2
            [
                // Mind
                ["mindG2"],
                // Flexibility
                ["flexibilityG"],
                // Endurance
                ["enduranceG"],
                // Toning
                ["toningG"],
                // Muscle Gain
                ["muscleGainG"],
                // Strength
                ["strengthG"],
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
    static let defaultProfileAnswers: [Int] =
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
    
    
    //
    static let registerScheduleHelpArray: [[[Int]]] =
        []
    //
    static let defaultScheduleHelpAnswers: [[Int]] =
        [
            
    ]
    
    // Layer 4: Final
    static let defaultDifficultyLevels: [String: [String: Int]] =
        [
            // Flexibility
            "flexibility": [
                "overall": 1,
                "hamstrings": 1,
                "hips": 1,
                "backNeck": 1
            ],
            // Yoga
            "yoga": [
                "yoga": 1,
                "yogaStrength": 1
            ],
            // Endurance
            "endurance": [
                "endurance": 1
            ],
            // Toning/Muscle/Strength
            "workout": [
                "workout": 1,
                "workoutUpper": 1,
                "workoutLower": 1
            ]
    ]
    
    // Custom schedules insert this into schedules array
    static let emptyWeekOLD: [String: [[Any]]] =
        [
            // [0] Schedule --------------------
            "schedule": [
                // CHANGE
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
                // Full week list - [0][7]
//                [] // GET RID OF
            ],
            // [1] Information about schedule ------------------
            "scheduleInformation": [
                // Title - 0
                [""], // String
                // Schedule style: day [0] or full week [1], -- day plan [2], full week plan [3] - 1
                [0],
                // Session choice style: app [0] or user chooses [1] - 2
                    // Always 0 for plans
                [0],
                // Schedule type: app helps create scheudle [0], custom schedule [1] - 3
                    // Always 0 for plans
                [0]
            ],
            // [2] Schedule creation help data --------------------
            "scheduleCreationHelp": [
                // Question Answers [2][0]
                [-1, -1, -1],
                // Goals [2][1]
                [0,0,0,0,0,0,0],
                //0,1,2,3,4,5,6
                // Sessions
                // 0 = total, 1 - 6 = mind - strength [2][2]
                [0,0,0,0,0,0,0],
                // Ranges (could be put in seperate array with arrays for each range but not in the mood to do so) [2][2]
                // note no range for total sessions
                [0,0,  0,0,  0,0,  0,0,  0,0,  0,0],
            ]
    ]
    
    
    // Schedules
    static let registerSchedules: [[String: [[[String: Any]]]]] =
        [
    ]
    
    
    // Custom schedules insert this into schedules array
    static let emptyWeek: [String: [[[String: Any]]]] =
        [
            // [0] Schedule --------------------
            "schedule": [
                // CHANGE
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
                // Full week list - [0][7]
                //                [] // GET RID OF
            ],
            // [1] Information about schedule ------------------
            "scheduleInformation": [
                [[
                    "title": "",
                    // Schedule style: day [0] or full week [1], -- day plan [2], full week plan [3] - 1
                    "scheduleStyle": 0,
                    // Schedule type: app helps create scheudle [0], custom schedule [1] - 3
                    "customSchedule": 0,
                    // Session choice style: app [0] or user chooses [1] - 2
                    "customSessionChoice": 0,
                ]],
            ],
            // [2] Schedule creation help data --------------------
            "scheduleCreationHelp": [
                // Note: in array for nesting
                [
                    // Question answers
                    ["scheduleQTime": -1,
                    "scheduleQPriority": -1],
                    // Goals
                    ["mindG2": 0,
                     "yogaG": 0,
                     "flexibilityG": 0,
                     "enduranceG": 0,
                     "toningG": 0,
                     "muscleGainG": 0,
                     "strengthG": 0,
                     "total": 0],
                    // N Sessions
                    ["mindG": 0,
                     "yogaG": 0,
                     "flexibilityG": 0,
                     "enduranceG": 0,
                     "toningG": 0,
                     "muscleGainG": 0,
                     "strengthG": 0,
                     "total": 0],
                    // Ranges
                    ["mindLower": 0,
                     "mindUpper": 0,
                     "yoga": 0,
                     "mindUpper": 0,
                     "flexibility": 0,
                     "mindUpper": 0,
                     "endurance": 0,
                     "mindUpper": 0,
                     "toning": 0,
                     "mindUpper": 0,
                     "muscleGain": 0,
                     "mindUpper": 0,
                     "strength": 0,
                     "mindUpper": 0
                    ]
                ]
            ]
    ]
    
    //
    // MARK: Schedule Tracking, tracking what youve done each week, putting a tick next to what you've done in schedule if true
    static let scheduleGroups: [Int:[String :Any]] =
        [
            // MARK: Mind
            // NOTE MIND HAS CHOICE OF GOING FOR A WALK, IF SELECTED WONT GO GREEN, WILL JUST TAKE BACK TO INITIAL SCREEN AND SET TO TRUE
            0: ["group": "mind",
                 "isGroupCompleted": false,
                 "0": false, // Warmup
                 "1": false], // Session
            
            // Note: Choice = ["title","contents","contents"...]
            // MARK: Flexibility
            1: ["group": "mind",
               "isGroupCompleted": false,
               "0": false, // Warmup
               "1": false], // Session
            
            // MARK: Endurance
            2: ["group": "mind",
                "isGroupCompleted": false,
                "0": false, // Warmup
                "1": false, // Session
                "2": false], // Stretching
            // MARK: Toning
            3: ["group": "mind",
               "isGroupCompleted": false,
               "0": false, // Warmup
                "1": false, // Session
                "2": false], // Stretching
            
            // MARK: Muscle Gain
            4: ["group": "mind",
                "isGroupCompleted": false,
                "0": false, // Warmup
                "1": false, // Session
                "2": false], // Stretching
            // MARK: Strength
            5: ["group": "mind",
                "isGroupCompleted": false,
                "0": false, // Warmup
                "1": false, // Session
                "2": false], // Stretching
        ]
    
}

