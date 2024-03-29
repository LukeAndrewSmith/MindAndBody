//
//  LittleThings.swift
//  MindAndBody
//
//  Created by Luke Smith on 04.12.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation

extension sessionData {
    
    // MARK: Circuit
    // Contains  SelectedSession.shared.selectedSession[1]  keys of circuit workout
    static let circuitChoices: Set = ["circuitGymFull", "circuitGymUpper", "circuitGymLower", "circuitBodyweightFull", "circuitBodyweightUpper", "circuitBodyweightLower", "bodyweight"]
    
    // MARK:- TableView Section Arrays
    static let tableViewSectionArrays: [String: [String]] = [
            // Warmup
            "warmup": [
                    "endurance",
                    "jointRotation",
                    "foamRoll",
                    "glutes",
                    "lowerBack",
                    "upperBack",
                    "shoulder",
                    "bandAssisted",
                    "generalMobility",
                    "dynamicWarmupDrills",
                    "accessory"
            ],
            // Workout
            "workout": [
                    // Gym -----
                    "legsQ",
                    "legsHG",
                    "legsG",
                    "calves",
                    "pullBa",
                    "pullUB",
                    "pullRD",
                    "pullT",
                    "pullB",
                    "pullF",
                    "pushC",
                    "pushS",
                    "pushT",
                    "fullBody",
                    // Bodyweight -----
                    "legsG",
                    "hamstrings",
                    "glutesW",
                    "calves",
                    "pullBa",
                    "pullT",
                    "pushC",
                    "pushT",
                    "pushCT", //!!!!!!!!!
                    "pushS",
                    "coreAbs",
                    // General
                    "generalC",
                    "generalF",
                    "generalU",
                    "endurance",
                    // Isometric
                    "isometricL",
                    "isometricU", //!!!!!!!!!
                    // Equipment
                    "equipmentB",
                    "equipmentBa",
                    "equipmentBe"
            ],
            // Cardio
            "endurance": [
                    "intensity",
                    "running",
                    "biking",
                    "rowing"
            ],
            // Stretching
            "stretching": [
                    "endurance",
                    "jointRotation",
                    "foamRoll",
                    "backStretch",
                    "sides",
                    "neck",
                    "arms",
                    "pecs",
                    "shoulders",
                    "hipsGlutes",
                    "calves",
                    "hamstrings",
                    "quads",
                    "fullBody"
            ],
            // Yoga
            "yoga": [
                    "standing",
                    "handElbowsfeetKnees",
                    "seated",
                    "lying",
                    "handStands"
            ]
    ]
    
    // MARK:- Final Choice Navigation Titles
    static let navigationTitles: [String: [String: String]] =
        [
            // Warmup
            "warmup": [
                "workout": "workout",
                "endurance": "endurance",
                "stretching": "stretchingYoga2"],
            // Workout
            "workout": [
                // Classic Gym
                "classicGymFull": "fullBody",
                "classicGymUpper": "upperBody",
                "classicGymLower": "lowerBody",
                // Circuit Gym
                "circuitGymFull": "fullBody",
                "circuitGymUpper": "upperBody",
                "circuitGymLower": "lowerBody",
                // Classic Bodyweight
                "classicBodyweightFull": "fullBody",
                "classicBodyweightUpper": "upperBody",
                "classicBodyweightLower": "lowerBody",
                // Circuit Bodyweight
                "circuitBodyweightFull": "fullBody",
                "circuitBodyweightUpper": "upperBody",
                "circuitBodyweightLower": "lowerBody"
            ],
            // Cardio
            "endurance": [
                "bodyweight": "bodyweightCardio2",
                "hiit": "HIIT",
                "rowing": "rowing",
                "biking": "biking",
                "running": "running"],
            // Stretching
            "stretching": [
                "general": "general", // Not schedule so not separated into focuses
                "postWorkout": "postWorkout",
                "postCardio": "postCardio"],
            // Yoga
            "yoga": [
                "relaxing": "relaxing",
                "neutral": "neutral",
                "stimulating": "stimulating",
            ]
    ]
    
    static let headerTitles: [String: [String: [String]]] =
        [
            // Warmup
            "warmup": [
                "workout": ["fullBody", "upperBody", "lowerBody"],
                "endurance": [""],
                "stretching": [""]],
            // Workout
            "workout": [
                // Classic Gym
                "classicGymFull": ["level1", "level2", "level3"],
                "classicGymUpper": ["level1", "level2", "level3"],
                "classicGymLower": ["level1", "level2", "level3"],
                // Circuit Gym
                "circuitGymFull": ["level1", "level2", "level3"],
                "circuitGymUpper": ["level1", "level2", "level3"],
                "circuitGymLower": ["level1", "level2", "level3"],
                // Classic Bodyweight
                "classicBodyweightFull": ["level1", "level2", "level3"],
                "classicBodyweightUpper": ["level1", "level2", "level3"],
                "classicBodyweightLower": ["level1", "level2", "level3"],
                // Circuit Bodyweight
                "circuitBodyweightFull": ["level1", "level2", "level3"],
                "circuitBodyweightUpper": ["level1", "level2", "level3"],
                "circuitBodyweightLower": ["level1", "level2", "level3"]
            ],
            // Cardio
            "endurance": [
                "bodyweight": ["level1", "level2", "level3"],
                "hiit": ["shortSession", "mediumSession", "longSession"],
                "rowing": [""],
                "biking": [""],
                "running": [""]],
            // Stretching
            "stretching": [
                "general": ["fullBody", "hamstrings", "hips", "backNeck", "foamRolling"], // Not schedule so not separated into focuses
                "postWorkout": ["fullBody", "upperBody", "lowerBody"],
                "postCardio": [""]],
            // Yoga
            "yoga": [
                "relaxing": ["veryShort", "short", "medium", "long"],
                "neutral": ["short", "medium", "long"],
                "stimulating": ["short", "medium"],
            ],
    ]
    
    // MARK:- Group Choices
    // Note
    // dict keys = choiceProgress[0] in schedule
    // arrays = choiceProgress[1] in schedule
    static let sortedGroups: [Groups: [[String]]] =
        [
            // MARK: Workout
            Groups.workout: [
                // 0
                ["workout"],
                // 1 | Choice 1 - Type
                [
                    "workoutType",
                    //
                    "gym",
                    "bodyweight",
                    "custom",
                ],
                // 2 | Choice 2 - Style
                [
                    "workoutStyle",
                    //
                    "classic",
                    "circuit"
                ],
                // 3 | Choice 3 - Focus
                [
                    "focus",
                    //
                    "fullBody",
                    "upperBody",
                    "lowerBody"
                ],
                // --------------
                // 4 | Choice 4 - Length 1 - classic gym
                [
                    "sessionLength",
                    //
                    "Short: 20-40 min",
                    "Medium: 40-60 min",
                    "Long: 60+ min",
                    ],
                // --------------
                // 5 | Choice 5 - Length 2 - others
                [
                    "sessionLength",
                    //
                    "Short: 20-30 min",
                    "Normal: 30-50 min",
                    ],
                // 6 | Final - To Do
                [
                    "workoutToDo",
                    //
                    "1. warmup",
                    "2. session",
                    "3. stretching",
                ],
                // ---------
                // Custom
                // 7 | Final - To Do
                [
                    "workoutToDo",
                    //
                    "1. warmup",
                    "2. session",
                    "3. stretching",
                ],
            ],
            
            // MARK: Yoga
            Groups.yoga: [
                // 0
                [ "yoga"],
                // 1 | Choice 1 - type
                [
                    "yogaType",
                    //
                    "relaxing",
                    "neutral",
                    "stimulating",
                    "custom",
                ],
                // --------------
                // 2 | Choice 2 - Length 1 - relaxing
                [
                    "practiceLength",
                    //
                    "Very Short: 10-15 min",
                    "Short: 15-20 min",
                    "Medium: 20-30 min",
                    "Long: 30+ min"
                ],
                // --------------
                // 3 | Choice 3 - Length 1 - neutral
                [
                    "practiceLength",
                    //
                    "Short: 10-15 min",
                    "Medium: 15-25 min",
                    "Long: 25+ min"
                ],
                // --------------
                // 4 | Choice 4 - Length 1 - stimulating
                [
                    "practiceLength",
                    //
                    "Short: 5 min",
                    "Normal: 10 min"
                ],
                // 5 | Final - To Do
                [
                    "yogaToDo",
                    //
                    "1. warmup (optional)",
                    "2. practice"
                ],
                // ---------
                // Custom
                // 6 | To Do
                [
                    "yogaToDo",
                    //
                    "1. warmup (optional)",
                    "2. practice"
                ],
            ],
            
            // MARK: Meditation
            Groups.meditation: [
                    // 0
                    ["meditation"],
                    // 1 | Final - Type
                    [
                        "meditationType",
                        //
                        "meditationTimer",
                        "guidedMeditation",
                    ],
            ],
            
            // MARK: Endurance
            Groups.endurance: [
                    // 0
                    ["endurance"],
                    // 1 | Choice 1 - Type
                    [
                        "enduranceType",
                        //
                        "highIntensityCardio",
                        "highIntensityWorkout",
                        "steadyState",
                        "custom",
                        ],
                    // --------------
                    // High Intensity
                    // 2 | Choice 1 - 2 - Type
                    [
                        "enduranceType2",
                        //
                        "running",
                        "biking",
                        "rowing"
                    ],
                    // High Intensity,
                    // 3 | Choice 1 - 3 - Length
                    [
                        "sessionLength",
                        //
                        "Short: 10-20 min",
                        "Medium: 20-40 min",
                        "Long: 40+ min"
                    ],
                    // High Intensity,
                    // 4 | Choice 1 - 4 - Length
                    [
                        "intervalLength",
                        //
                        "Short: 10-20s",
                        "Medium: 20-40s",
                        "Long: 40+ s"
                    ],
                    // --------------
                    // High Intensity Bodyweight workout
                    // 5 | Chioce 2 - 2 - Length
                    [
                        "sessionLength",
                        //
                        "Short: 10-20 min",
                        "Normal: 20-40 min"
                    ],
                    // 6 | Final - to do
                    [
                        "enduranceToDo",
                        //
                        "1. Warmup",
                        "2. Session",
                        "3. Stretching",
                    ],
                    // ------------
                    // Steady State
                    // Type
                    // 7 | Choice 3 - 3 - To Do
                    [
                        "enduranceToDo",
                        //
                        "1. warmup",
                        "2. session",
                        "3. stretching",
                    ],
                    // 8 | Choice 3 - 4 - Warmup/Stretching Length,
                    [
                        "length",
                        //
                        "Short: 5 min",
                        "Normal: 5-10 min"
                    ],
                    // ------------
                    // Custom
                    // 9 | Choice 4 - 1 - To Do
                    [
                        "enduranceToDo",
                        //
                        "1. warmup",
                        "2. session",
                        "3. stretching",
                    ],
            ],
            
            // Note: Choice = ["title","contents","contents"...]
            // MARK: Flexibility
            Groups.flexibility: [
                // 0
                ["flexibility"],
                // 1 | Choice 1 - Focus
                [
                    "focus",
                    //
                    "general",
                    "hamstrings",
                    "hips",
                    "back/neck",
                    "foamRoll",
                    "custom",
                    ],
                // 2 | Choice 2 - Length
                [
                    "sessionLength",
                    //
                    "Short: 10-20 min",
                    "Normal: 20-40 min"
                ],
                // 3 | Final - To Do
                [
                    "flexibilityToDo",
                    //
                    "1. warmup",
                    "2. session"
                ],
                // ---------
                // Custom
                // 4 | To Do
                [
                    "flexibilityToDo",
                    //
                    "1. warmup",
                    "2. session"
                ]
            ],
            
            // Extra Session
            Groups.extra: [
                // 0
                ["extraSession"],
                // 1 | Choice 1 - Focus
                [
                    "extraSession",
                    //
                    "workout",
                    "yoga",
                    "meditation",
                    "endurance",
                    "flexibility",
                ],
            ]
    ]
    
    // MARK:- Session explanations
    // dict keys = choiceProgress[0] in schedule
    // dict 2 keys = choiceProgress[1] in schedule
    static let sessionChoiceExplanations: [Groups: [Int: String]] = [
        // Workout
        Groups.workout: [2: "workoutStyleE"],
        // Yoga
        Groups.yoga: [1: "yogaTypeE"],
        // Meditation
        Groups.meditation: [:],
        // Endurance
        Groups.endurance: [1: "enduranceTypeE",
            4: "intervalLengthE",],
        // Flexibility
        Groups.flexibility: [:],
        // Extra Sessions
        Groups.extra: [1: "extraSessionE"],
    ]
}
