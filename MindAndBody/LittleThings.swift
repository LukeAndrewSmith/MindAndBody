//
//  LittleThings.swift
//  MindAndBody
//
//  Created by Luke Smith on 04.12.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation

extension sessionData {
    
    // MARK:- TableView Section Arrays
    static let tableViewSectionArrays: [String: [String]] = [
            // Warmup
            "warmup": [
                    "cardio",
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
                    "cardio",
                    // Isometric
                    "isometricL",
                    "isometricU", //!!!!!!!!!
                    // Equipment
                    "equipmentB",
                    "equipmentBa",
                    "equipmentBe"
            ],
            // Cardio
            "cardio": [
                    "running",
                    "biking",
                    "rowing"
            ],
            // Stretching
            "stretching": [
                    "cardio",
                    "jointRotation",
                    "foamRoll",
                    "backStretch",
                    "sides",
                    "neck",
                    "arms",
                    "pecs",
                    "shoulders",
                    "hipsaGlutes",
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
                "cardio": "cardio",
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
            "cardio": [
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
                "cardio": [""],
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
            "cardio": [
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
    // (0: - 5:) = choiceProgress[0] in schedule
    // (0-4/5) = choiceProgress[1] in schedule
    static let sortedGroups: [Int: [[String]]] =
        [
            // MARK: Workout
            0: [
                // 0
                ["workout"],
                // 1 | Choice 1 - Type
                [
                    "workoutType",
                    //
                    "gym",
                    "bodyweight"
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
                    "Short: 10-20 min",
                    "Medium: 20-50 min",
                    "Long: 40+ min",
                    ],
                // --------------
                // 5 | Choice 5 - Length 2 - others
                [
                    "sessionLength",
                    //
                    "Short: 10-20 min",
                    "Normal: 20-50 min",
                    ],
                // 6 | Final - To Do
                [
                    "workoutToDo",
                    //
                    "1. warmup",
                    "2. session",
                    "3. stretching",
                    ],
            ],
            
            // MARK: Yoga
            1: [
                // 0
                [ "yoga"],
                // 1 | Choice 1 - type
                [
                    "yogaType",
                    //
                    "relaxing",
                    "neutral",
                    "stimulating",
                ],
                // --------------
                // 2 | Choice 2 - Length 1 - relaxing
                [
                    "practiceLength",
                    //
                    "Very Short: 10-20 min",
                    "Short: 10-20 min",
                    "Medium: 20-40 min",
                    "Long: 40+ min"
                ],
                // --------------
                // 3 | Choice 3 - Length 1 - neutral
                [
                    "practiceLength",
                    //
                    "Short: 10-20 min",
                    "Medium: 20-40 min",
                    "Long: 40+ min"
                ],
                // --------------
                // 4 | Choice 4 - Length 1 - stimulating
                [
                    "practiceLength",
                    //
                    "Short: 10-20 min",
                    "Normal: 20-40 min"
                ],
                // 5 | Final - To Do
                [
                    "yogaToDo",
                    //
                    "1. warmup",
                    "2. practice"
                ],
            ],
            
            // MARK: Meditation
            2: [
                    // 0
                    ["meditation"],
                    // 1 | Choice 1 - Type
                    [
                        "type",
                        //
                        "meditation", // Goes to Choice 5
                        "walk", // popup, go for a walk
                    ],
                    // 2 | Final - Type
                    [
                        "meditationType",
                        //
                        "meditationTimer",
                        "guidedMeditation", // Goes to Choice 5
                    ],
            ],
            
            // MARK: Endurance
            3: [
                    // 0
                    ["endurance"],
                    // 1 | Choice 1 - Type
                    [
                        "enduranceType",
                        //
                        "highIntensityCardio",
                        "highIntensityWorkout",
                        "steadyState",
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
                    ]
            ],
            
            // Note: Choice = ["title","contents","contents"...]
            // MARK: Flexibility
            4: [
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
                ]
            ],
    ]
}
