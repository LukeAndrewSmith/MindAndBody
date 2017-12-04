//
//  Sessions.swift
//  MindAndBody
//
//  Created by Luke Smith on 04.12.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation

extension sessionData {
    //
    //    static let presets: [[[]]]] =
    //    [
    //        "warmup":
    //            [
    //            "fullBody": ,
    //            "upperBody": ,
    //            "lowerBody": ,
    //            "cardio": ,
    //            ],
    //        "workout":
    //            [
    //            // Classic
    //            "classicGym": ,
    //            "classicGymUpper": ,
    //            "classicGymLower": ,
    //            "classicGymLegs": ,
    //            "classicGymPull": ,
    //            "classicGymPush": ,
    //            "classicGym5x5": ,
    //            // Circuit
    //            "circuitGymFull": ,
    //            "circuitGymUpper": ,
    //            "circuitGymLower": ,
    //            // BodyWeight Classic
    //            "classicBodyweightFull": ,
    //            "classicBodyweightUpper": ,
    //            "classicBodyweightLower": ,
    //            // Bodyweight circuit
    //            "circuitBodyweightFull": ,
    //            "circuitBodyweightUpper": ,
    //            "circuitBodyweightLower": ,
    //            ],
    //        "cardio":
    //            [
    //            "rowing": ,
    //            "biking": ,
    //            "running": ,
    //            ],
    //        "stretching": ,
    //            [
    //            "general": ,
    //            "postWorkout": ,
    //            "postCardio": ,
    //            ],
    //        "yoga":
    //            [
    //            "practices": ,
    //            ]
    //    ]
    
    // MARK:- Presets
    static let sessions: [String: [String: [String: [Int: [String: [String]]]]]] =
        [
            // MARK:- Warmup
            "warmup": [
                    // MARK: Full
                    "fullBody": [
                            "allPoses": [
                                    0: ["movement": "",
                                        "sets": "",
                                        "reps": ""],
                            ],
                            
                    ],
                    // MARK: Upper
                    "upperBody": ,
                    // MARK: Lower
                    "lowerBody": ,
                    // MARK: Cardio
                    "cardio": ,
            ],
            // MARK:- Workouts
            "workout": [
                    //MARK: Classic Gym
                    // MARK: Full
                    "classicGymFull": ,
                    // MARK: Upper
                    "classicGymUpper": ,
                    // MARK: Lower
                    "classicGymLower": ,
                    // MARK: Legs
                    "classicGymLegs": ,
                    // MARK: Pull
                    "classicGymPull": ,
                    // MARK: Push
                    "classicGymPush": ,
                    // MARK: 5 x 5
                    "classicGym5x5": ,
                    // MARK: Circuit Gym
                    // MARK: Full
                    "circuitGymFull": ,
                    // MARK: Upper
                    "circuitGymUpper": ,
                    // MARK: Lower
                    "circuitGymLower": ,
                    // MARK: Classic Bodyweight
                    // MARK: Full
                    "classicBodyweightFull": ,
                    // MARK: Upper
                    "classicBodyweightUpper": ,
                    // MARK: Lower
                    "classicBodyweightLower": ,
                    // MARK: Circuit Bodyweight
                    // MARK: Full
                    "circuitBodyweightFull": ,
                    // MARK: Upper
                    "circuitBodyweightUpper": ,
                    // MARK: Lower
                    "circuitBodyweightLower": ,
            ],
            // MARK:- Cardio
            "cardio": [
                    // MARK: Rowing
                    "rowing": ,
                    // MARK: Biking
                    "biking": ,
                    // MARK: Running
                    "running": ,
            ],
            // MARK:- Stretching
            "stretching": [
                // MARK: !!!!!!!!!!!!!
                "hamstring": ,
                // MARK: Post Workout
                "postWorkout": ,
                // MARK: Post Cardio
                "postCardio": ,
            ],
            // MARK:- Yoga
            "yoga": [
                    // MARK: Focus
                    "practices": ,
            ]
    ]
}
