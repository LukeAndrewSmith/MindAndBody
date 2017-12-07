//
//  SessionsData.swift
//  MindAndBody
//
//  Created by Luke Smith on 04.12.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation

extension sessionData {
    
    // MARK:- Presets Sorted
        // For displaying in final choice presets table
    static let sortedSessionsForFinalChoice: [String: [String: [[String]]]] = [
        // MARK:- Warmup
        "warmup": [
            // MARK: Full
            "fullBody": [
                ["allMovements",
                 "testSession"],
            ],
            // MARK: Upper
            "upperBody": [
                ["testSession"],
            ],
            // MARK: Lower
            "lowerBody": [
                ["testSession"],
            ],
            // MARK: Cardio
            "cardio": [
                ["testSession"],
            ],
        ],
        // MARK:- Workout
        "workout": [
            // MARK: Classic
            // MARK: Full
            "classicGymFull": [
                ["allMovements",
                 "testSession"],
            ],
            // MARK: Upper
            "classicGymUpper": [
                ["testSession"],
            ],
            // MARK: Lower
            "classicGymLower": [
                ["testSession"],
            ],
            // MARK: Legs
            "classicGymLegs": [
                ["testSession"],
            ],
            // MARK: Pull
            "classicGymPull": [
                ["testSession"],
            ],
            // MARK: Push
            "classicGymPush": [
                ["testSession"],
            ],
            // MARK: 5x5
            "classicGym5x5": [
                ["testSession"],
            ],
            // MARK: Circuit
            // MARK: Full 7
            "circuitGymFull": [
                ["testSession"],
            ],
            // MARK: Upper 8
            "circuitGymUpper": [
                ["testSession"],
            ],
            // MARK: Lower 9
            "circuitGymLower": [
                ["testSession"],
            ],
            // MARK: BodyWeight Classic
            // MARK: Full 10
            "classicBodyweightFull": [
                ["testSession"],
            ],
            // MARK: Upper 11
            "classicBodyweightUpper": [
                ["testSession"],
            ],
            // MARK: Lower 12
            "classicBodyweightLower": [
                ["testSession"],
            ],
            // MARK: Bodyweight circuit
            // MARK: Full 13
            "circuitBodyweightFull": [
                ["testSession"],
            ],
            // MARK: Upper 14
            "circuitBodyweightUpper": [
                ["testSession"],
            ],
            // MARK: Lower 15
            "circuitBodyweightLower": [
                ["testSession"],
            ],
        ],
        // MARK:- Cardio
        "cardio": [
            // MARK: Rowing
            "rowing": [
                ["allMovements",
                 "testSession"],
            ],
            // MARK: Biking
            "biking": [
                ["testSession"],
            ],
            // MARK: Running
            "running": [
                ["testSession"],
            ],
        ],
        // MARK:- Stretching
        "stretching": [
            // MARK: !!!!!!!
            "general": [
                ["allMovements",
                 "testSession"],
            ],
            // MARK: Post Workout
            "postWorkout": [
                ["testSession"],
            ],
            // MARK: Post Cardio
            "postCardio": [
                ["testSession"],
            ],
        ],
        // MARK:- Yoga
        "yoga": [
            // MARK: Focus!!!!!
            "practices": [
                ["allMovements",
                 "testSession"],
            ],
        ]
    ]
}
