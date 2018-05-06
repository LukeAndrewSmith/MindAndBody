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
    
    //
    // All sessions are stored in schedule week, if schedule is viewed as full week, temporary array is made to stor them in the correct order to present, saves having extra array in schedule
    func createTemporaryWeekViewArray() {
        
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        // Ensure empty
        TemporaryWeekArray.shared.weekArray = []
        
        // Create array ordered, by first finding and adding all instances of workout, then of yoga, then of meditation etc...
        let orderedGroupArray = ["workout", "yoga", "meditation", "endurance", "flexibility"]
        
        // Loop groups
        for i in 0..<orderedGroupArray.count {
            // Loop week
            for j in 0...6 {
                // If day not empty
                if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j].count != 0 {
                    // Loop day
                    for k in 0..<schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j].count {
                        // If correct group
                        if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j][k]["group"] as! String == orderedGroupArray[i] {
                            // Create group dict that references this one
                            let groupDict: [String: Any] = [
                                "group": orderedGroupArray[i],
                                "day": j,
                                "index": k,
                                ]
                            // Append
                            TemporaryWeekArray.shared.weekArray.append(groupDict)
                        }
                    }
                }
            }
        }
    }
}

extension Int {
    func groupFromInt() -> String {
        let groupIntAsString: [Int: String] = [
            0: "workout",
            1: "yoga",
            2: "meditation",
            3: "endurance",
            4: "flexibility"]
        return groupIntAsString[self]!
    }
}

extension String {
    func groupFromString() -> Int {
        let groupStringAsInt: [String: Int] = [
            "workout": 0,
            "yoga": 1,
            "meditation": 2,
            "endurance": 3,
            "flexibility": 4]
        return groupStringAsInt[self]!
    }
}

enum scheduleDataStructures {
    
    // MARK: Profile Data
    //
    // Questions & Answers
    static let profileQA: [String: [String: [String]]] =
        [
            // Age - GOOD
            "age": ["Q": ["profileQAge"],
                    "A": [""],
                    "image": [""]],
            
            // Gender - GOOD
            "gender": ["Q": ["profileQGender"],
                       "A": ["profileAGender1", "profileAGender2", "profileAGender3"],
                       "image": [""]],
            
            // Strength
            "workoutExperience": ["Q": ["profileQWorkoutExperience"],
                                  "A": ["profileAWorkoutExperience1", "profileAWorkoutExperience2", "profileAWorkoutExperience3"],
                                  "image": [""]],
            "workoutPushup": ["Q": ["profileQWorkoutPushup"],
                              "A": ["profileAWorkoutPushup1", "profileAWorkoutPushup2", "profileAWorkoutPushup3"],
                              "image": ["pushUp"]],
            "workoutPullup": ["Q": ["profileQWorkoutPullup"],
                              "A": ["profileAWorkoutPullup1", "profileAWorkoutPullup2", "profileAWorkoutPullup3"],
                              "image": ["pullUp"]],
            "workoutSquat": ["Q": ["profileQWorkoutSquat"],
                             "A": ["profileAWorkoutSquat1", "profileAWorkoutSquat2", "profileAWorkoutSquat3"],
                             "image": ["bodyweightSquat"]],
            "workoutWeights": ["Q": ["profileQWorkoutWeights"],
                               "A": ["profileAWorkoutWeights1", "profileAWorkoutWeights2", "profileAWorkoutWeights3"],
                               "image": [""]],
            "workoutOpinion": ["Q": ["profileQWorkoutOpinion"],
                               "A": ["profileAWorkoutOpinion1", "profileAWorkoutOpinion2", "profileAWorkoutOpinion3"],
                               "image": [""]],
            
            // Endurance - GOOD
            "enduranceExperience": ["Q": ["profileQEnduranceExperience"], // How much
                                    "A": ["profileAEnduranceExperience1", "profileAEnduranceExperience2", "profileAEnduranceExperience3"],
                                    "image": [""]],
            "enduranceStairs": ["Q": ["profileQEnduranceStairs"], // Flight of staris
                                 "A": ["profileAEnduranceStairs1", "profileAEnduranceStairs2", "profileAEnduranceStairs3"],
                                 "image": [""]],
            "enduranceAbility": ["Q": ["profileQEnduranceAbility"], // 30 min cardio
                                 "A": ["profileAEnduranceAbility1", "profileAEnduranceAbility2", "profileAEnduranceAbility3"],
                                 "image": [""]],
            
            
            "enduranceOpinion": ["Q": ["profileQEnduranceOpinion"],
                                 "A": ["profileAEnduranceOpinion1", "profileAEnduranceOpinion2", "profileAEnduranceOpinion3"],
                                 "image": [""]],
            
            // Yoga - TODO
            "yogaExperience": ["Q": ["profileQYogaExperience"],
                               "A": ["profileAYogaExperience1", "profileAYogaExperience2", "profileAYogaExperience3"],
                               "image": [""]],
            
            // Flexibility - GOOD
            "flexibilityHamstrings": ["Q": ["profileQFlexibilityHamstrings"],
                            "A": ["profileAFlexibilityHamstrings1", "profileAFlexibilityHamstrings2", "profileAFlexibilityHamstrings3"],
                            "image": ["standingHamstring"]],
            "flexibilityHips": ["Q": ["profileQFlexibilityHips"],
                            "A": ["profileAFlexibilityHips1", "profileAFlexibilityHips2", "profileAFlexibilityHips3"],
                            "image": ["butterfly"]],
            "flexibilityHipsAnkles": ["Q": ["profileQFlexibilityHipsAnkles"],
                            "A": ["profileAFlexibilityHipsAnkles1", "profileAFlexibilityHipsAnkles2", "profileAFlexibilityHipsAnkles3"],
                            "image": ["deepSquat"]],
            "flexibilityKnees": ["Q": ["profileQFlexibilityKnees"],
                            "A": ["profileAFlexibilityKnees1", "profileAFlexibilityKnees2", "profileAFlexibilityKnees3"],
                            "image": ["hero"]],
            "flexibilityBackBackward": ["Q": ["profileQFlexibilityBackBackward"],
                            "A": ["profileAFlexibilityBackBackward1", "profileAFlexibilityBackBackward2", "profileAFlexibilityBackBackward3"],
                            "image": ["upwardDog"]],
            "flexibilityBackSideways": ["Q": ["profileQFlexibilityBackSideways"],
                            "A": ["profileAFlexibilityBackSideways1", "profileAFlexibilityBackSideways2", "profileAFlexibilityBackSideways3"],
                            "image": ["legDrop"]],
            "flexibilityNeck": ["Q": ["profileQFlexibilityNeck"],
                            "A": ["profileAFlexibilityNeck1", "profileAFlexibilityNeck2", "profileAFlexibilityNeck3"],
                            "image": ["neckRotatorStretch"]],
            // Balance - GOOD
            "flexibilityBalance": ["Q": ["profileQFlexibilityBalance"],
                                   "A": ["profileAFlexibilityBalance1", "profileAFlexibilityBalance2", "profileAFlexibilityBalance3"],
                                   "image": ["tree"]],
        ]
    
    static let profileQASorted: [String] =
        ["age", "gender",
         "workoutExperience", "workoutPushup", "workoutPullup", "workoutSquat", "workoutWeights", "workoutOpinion",
         "enduranceExperience", "enduranceStairs", "enduranceAbility", "enduranceOpinion",
         "yogaExperience",
         "flexibilityHamstrings", "flexibilityHips", "flexibilityHipsAnkles", "flexibilityKnees", "flexibilityBackBackward", "flexibilityBackSideways", "flexibilityNeck", "flexibilityBalance",
         ]
    
    
    static let groupNames =
        [
            "workout",
            "yoga",
            "meditation",
            "endurance",
            "flexibility",
        ]
    
    static let shortenedGroupNames =
        [
            // Workout
            "workoutS",
            // Yoga
            "yogaS",
            // Meditation
            "meditationS",
            // Endurance
            "enduranceS",
            // Flexibility
            "flexibilityS",
            ]
    
    //
    // Data
    // Note: All scales 0,1,2
    // Note: All scales default to 1
    // Layer 1, Questions
    // sees profileQASorted above for indexing
    //static let defaultProfileAnswers: [Int] =
    //    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
    static let defaultProfileAnswers: [String: Int] =
        [
            // Age - GOOD
            "age": -1, // Age - 0
            
            // Gender - GOOD
            "gender": -1, // Gender - 1
            
            // Strength
            "workoutExperience": -1, // Workout - 3 - 2
            "workoutPushup": -1, // Pushup - 7 - 4
            "workoutPullup": -1, // Pullup - 8 - 5
            "workoutSquat": -1, // Squat - 9 - 6
            "workoutWeights": -1, // Squat - 9 - 6
            "workoutOpinion": -1, // Strength (Opinion) - 10 - 7
            
            // Endurance - GOOD
            "enduranceExperience": -1, // Cardio (Endurance) (Amount) - 4 - 8
            "enduranceStairs": -1, // Endurance (Ability) - 5 - 9
            "enduranceAbility": -1, // Endurance (Ability) - 5 - 9
            "enduranceOpinion": -1, // Endurance (Opinion) - 6 - 10
            
            // Yoga - TODO
            "yogaExperience": -1, // Yoga - 2 - 11
            
            // Flexibility - GOOD
            "flexibilityHamstrings": -1, // Hamstrings - 11
            "flexibilityHips": -1, // Hips - 12
            "flexibilityHipsAnkles": -1, // Hips/Ankles - 13
            "flexibilityKnees": -1, // Knees - 14
            "flexibilityBackBackward": -1, // Back (Backward) - 15
            "flexibilityBackSideways":-1, // Back (Lower - sideways) - 16
            "flexibilityNeck": -1, // Neck - 17
            // Balance - GOOD
            "flexibilityBalance": -1, // Balance - 18
            
            // Meditation - TODO
            // EXTRA
    ]
    //
    static let registerScheduleHelpArray: [[[Int]]] =
        []
    //
    static let defaultScheduleHelpAnswers: [[Int]] =
        []
    
    // Schedule lessons, stores date of first open of app
        // [0] == timeinteravalsince1970 of first date of app opening
        // [1] : 0 == lessons have not been present, 1 == lessons have been presented (i.e is after a week from first monday)
    static let defaultScheduleLessons: [Int] = [0, 0]

    
    // Layer 4: Final
        // Every session has an average difficulty, and those with only one difficulty call it average, so having the default at 1 (average) should never crash
    // Difficulty:
        // 0 - Easy
        // 1 - Average
        // 2 - Hard
    static let defaultDifficultyLevels: [String: [String: Int]] =
        [
            // Scale of 0 to 3
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
    
    static let difficultyArray =
        [
            "easy",
            "average",
            "hard"
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
            ],
            // [1] Information about schedule ------------------
            "scheduleInformation": [
                // Note in array for nesting
                [[
                    "title": "",
                    // Schedule style: day [0] or full week [1], - 1
                    "scheduleStyle": 0,
                    // Schedule type: app helps create scheudle [0], custom schedule [1] - 2
                    "customSchedule": 0,
                    // Session choice style: app [0] or user chooses [1] - 3
                    "customSessionChoice": 0,
                    //
                    // Equipment to use - 4
                        // 0 == don't use, 1 == use
                    // Foam Roller
                    "foamRoller": 0,
                    // Pullup Bar
                    "pullupBar": 0,
                ]],
            ],
            // [2] Schedule creation help data --------------------
            "scheduleCreationHelp": [
                // Note: in array for nesting
                [
                    // Goals
                    [
                        "workoutG": 0,
                        "yogaG": 0,
                        "meditationG": 0,
                        "enduranceG": 0,
                        "flexibilityG": 0,
                    ],
                    // Question answers
                    
                    // Time & Commitment
                    ["scheduleQTime": -1,
                     "scheduleQPriority": -1],
                ]
            ]
    ]
    
    // Schedule creation help
    // ENSURE IF CHANGING THAT NAMES OF QUESTIONS ETC ARE THE SAME AS THE INDEXING IN Schedules[..]["ScheduleCreationHelp"]
    static let scheduleCreationHelpSorted: [[[String]]] =
        [
            // Goals - 0
            [
                ["workoutG"], // - 0
                ["yogaG"], // - 1
                ["meditationG"], // - 2
                ["enduranceG"], // - 3
                ["flexibilityG"], // - 4
            ],
            // Schedule creation questions - 1
            [
                // gender
                // Time/Commitment
                ["scheduleQTime", "scheduleATime1", "scheduleATime2", "scheduleATime3", "scheduleATime4"], // // Time - 0
                ["scheduleQPriority", "scheduleAPriority1", "scheduleAPriority2", "scheduleAPriority3"], // Priority - 1
            ],
    ]
    
    //
    // MARK: Schedule Tracking, tracking what youve done each week, putting a tick next to what you've done in schedule if true
    static let scheduleGroups: [Int: [String: Any]] =
        [
            // MARK: Workout
            0: ["group": "workout",
                "isGroupCompleted": false,
                "0": false, // Warmup
                "1": false, // Session
                "2": false], // Stretching
            
            // MARK: Yoga
            1: ["group": "yoga",
                "isGroupCompleted": false,
                "0": false, // Warmup
                "1": false], // Practice
            
            // MARK: Meditation
            // NOTE MIND HAS CHOICE OF GOING FOR A WALK, IF SELECTED WONT GO GREEN, WILL JUST TAKE BACK TO INITIAL SCREEN AND SET TO TRUE
            2: ["group": "meditation",
                 "isGroupCompleted": false,
                 "0": false, // Warmup
                 "1": false], // Session
            
            // MARK: Endurance
            3: ["group": "endurance",
                "isGroupCompleted": false,
                "0": false, // Warmup
                "1": false, // Session
                "2": false], // Stretching
            
            // Note: Choice = ["title","contents","contents"...]
            // MARK: Flexibility
            4: ["group": "flexibility",
                "isGroupCompleted": false,
                "0": false, // Warmup
                "1": false], // Session
        ]
}

