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
                    // Equiptment
                    "equiptmentB",
                    "equiptmentBa",
                    "equiptmentBe"
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
                "flexibility": "flexibility"],
            // Workout
            "workout": [
                // Classic Gym
                "classicGymFull": "fullBody",
                "classicGymUpper": "upperBody",
                "classicGymLower": "lowerBody",
                "classicGymLegs": "legs",
                "classicGymPull": "pull",
                "classicGymPush": "push",
                "classicGym5x5": "5x5",
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
                "practices": "practices" // Not schedule so not separated into focuses
            ]
    ]
    
    // MARK:- Group Choices
    // Note
    // (0: - 5:) = choiceProgress[0] in schedule
    // (0-4/5) = choiceProgress[1] in schedule
    static let sortedGroups: [Int: [[String]]] =
        [
            // MARK: Mind
            0: [
                    // 0
                    ["mind"],
                    // 1 | Choice 1 - Type
                    [
                        "mindType",
                        //
                        "yoga",
                        "meditation", // Goes to Choice 5
                        "walk" // popup, go for a walk
                    ],
                    // 2 | Choice 2 - Focus
                    [
                        "focus",
                        //
                        "calm",
                        "stressReduction",
                        "strength",
                        "energising",
                        "focusing"
                    ],
                    // 3 | Choice 3 - Yoga Length
                    [
                        "practiceLength",
                        //
                        "10-20 min",
                        "20-40 min",
                        "40+ min"
                    ],
                    // 4 | Final - To Do
                    [
                        "mindToDo",
                        //
                        "1. warmup",
                        "2. practice"
                    ],
                    // 5 | Choice 5 - Type
                    [
                        "meditationType",
                        //
                        "meditationTimer",
                        "guidedMeditation", // Goes to Choice 5
                    ],
            ],
            
            // Note: Choice = ["title","contents","contents"...]
            // MARK: Flexibility
            1: [
                    // 0
                    ["flexibility"],
                    // 1 | Choice 1 - Type
                    [
                        "flexibilityType",
                        //
                        "stretching",
                        "yoga",
                        ],
                    // 2 | Choice 2 - Focus
                    [
                        "focus",
                        //
                        "general",
                        "hamstrings",
                        "hips",
                        "back/neck",
                        ],
                    // 3 | Choice 3 - Length
                    [
                        "sessionLength",
                        //
                        "10-20 min",
                        "20-40 min",
                        "40+ min"
                    ],
                    // 4 | Final - To Do
                    [
                        "flexibilityToDo",
                        //
                        "1. warmup",
                        "2. session"
                    ]
            ],
            
            // MARK: Endurance
            2: [
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
                    // --------------
                    // High Intensity, workout skips to here
                    // 3 | Chioce 1 - 3 - Length
                    [
                        "sessionLength",
                        //
                        "10-20 min",
                        "20-40 min",
                        "40+ min"
                    ],
                    // 4 | Final - to do
                    [
                        "enduranceToDo",
                        //
                        "1. warmup",
                        "2. cardio/bodyweight workout",
                        "3. stretching",
                    ],
                    // ------------
                    // Steady State
                    // Type
                    // 5 | Choice 3 - 2 - Type
                    [
                        "enduranceType2",
                        //
                        "running",
                        "biking",
                        "rowing"
                    ],
                    // 6 | Choice 3 - 3 - To Do
                    [
                        "enduranceToDo",
                        //
                        "1. warmup",
                        "2. cardio",
                        "3. stretching",
                        ],
                    // 7 | Choice 4 - 4 - Warmup/Stretching Length,
                    [
                        "sessionLength",
                        //
                        "5 min",
                        "5-10 min",
                        "10+ min"
                    ]
            ],
            // MARK: Toning
            3: [
                    // 0
                    ["toning"],
                    // 1 | Choice 1 - Type
                    [
                        "toningType",
                        //
                        "bodyWeightWorkout",
                        "highIntensityCardio",
                        ],
                    // -------------------------------
                    // 2 | Choice 2 - Focus
                    [
                        "focus",
                        //
                        "fullBody",
                        "upperBodyCore",
                        "lowerBodyCore",
                        ],
                    // 3 | Choice 3 - length
                    [
                        "sessionLength",
                        //
                        "10-20 min",
                        "20-50 min",
                        "40+ min",
                        ],
                    // 4 | Final - To Do
                    [
                        "toningToDo",
                        //
                        "1. warmup",
                        "2. session",
                        "3. stretching",
                        ],
                    // -------------------------------
                    // 5 | Choice 5 - length
                    [
                        "sessionLength",
                        //
                        "10-20 min",
                        "20-50 min",
                        "40+ min",
                        ],
                    // 6 | Final - To Do
                    [
                        "toningToDo",
                        //
                        "1. warmup",
                        "2. session",
                        "3. stretching",
                        ],
            ],
            
            // MARK: Muscle Gain
            4: [
                    // 0
                    ["muscleGain"],
                    // 1 | Choice 1 - Type
                    [
                        "muscleGainType",
                        //
                        "gym",
                        "bodyweight"
                    ],
                    // 2 | Choice 2 - Style
                    [
                        "workoutStyle",
                        //
                        "circuit",
                        "classic"
                    ],
                    // 3 | Choice 3 - Focus
                    [
                        "focus",
                        //
                        "fullBody",
                        "upperBody",
                        "lowerBody"
                    ],
                    // 4 | Choice 4 - Length
                    [
                        "sessionLength",
                        //
                        "10-20 min",
                        "20-50 min",
                        "40+ min",
                        ],
                    // 5 | Final - To Do
                    [
                        "muscleGainToDo",
                        //
                        "1. warmup",
                        "2. session",
                        "3. stretching",
                        ],
            ],
            
            // MARK: Strength
            5: [
                    // 0
                    [ "strength"],
                    // 1 | Choice 1 - type
                    [
                        "strengthType",
                        //
                        "gym",
                        "bodyweight"
                    ],
                    // 2 | Choice 2 - Session
                    [
                        "session",
                        //
                        "5x51",
                        "5x52",
                        "accessory1",
                        "accessory2"
                    ],
                    // 3 | Choice 3 - Length
                    [
                        "sessionLength",
                        //
                        "short",
                        "normal"
                    ],
                    // 4 | Final - To Do
                    [
                        "strengthToDo",
                        //
                        "1. warmup",
                        "2. session",
                        "3. stretching"
                    ],
            ]
    ]
}
