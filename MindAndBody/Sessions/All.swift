//
//  All.swift
//  MindAndBody
//
//  Created by Luke Smith on 24.02.19.
//  Copyright © 2019 Luke Smith. All rights reserved.
//

import Foundation

class sessionData {
    
    // MARK: Sessions
    // Set arrays like this as doesn't compile otherwise, dictionary too large, would be good to find a new way of storing it
    static var sessions: [String: [String: [String: [[String: Any]]]]] =
                [
                    "warmup": ["workout": sessionData.WaW,
                               "endurance": sessionData.WaE, // E = endurance
                               "stretching": sessionData.WaF], // F = flexibility
                    "workout": ["classicGymFull": sessionData.WoCsGF,
                                "classicGymUpper": sessionData.WoCsGU,
                                "classicGymLower": sessionData.WoCsGL,
                                "circuitGymFull": sessionData.WoCcGF,
                                "circuitGymUpper": sessionData.WoCcGU,
                                "circuitGymLower": sessionData.WoCcGL,
                                "classicBodyweightFull": sessionData.WoCsBF,
                                "classicBodyweightUpper": sessionData.WoCsBU,
                                "classicBodyweightLower": sessionData.WoCsBL,
                                "circuitBodyweightFull": sessionData.WoCcBF,
                                "circuitBodyweightUpper": sessionData.WoCcBU,
                                "circuitBodyweightLower": sessionData.WoCcBL,
                    ],
                    "endurance": ["hiit": sessionData.CH,
                               "bodyweight": sessionData.CB,],
                    "stretching": ["general": sessionData.SG,
                                   "postWorkout": sessionData.SPw,
                                   "postCardio": sessionData.SPc,],
                    "yoga": ["relaxing": sessionData.YR,
                             "neutral": sessionData.YN,
                             "stimulating": sessionData.YS,],
                ]
//        [
//            "warmup": ["workout": [:],
//                       "endurance": [:], // E = endurance
//                "stretching": [:]], // F = flexibility
//            "workout": ["classicGymFull": [:],
//                        "classicGymUpper": [:],
//                        "classicGymLower": [:],
//                        "circuitGymFull": [:],
//                        "circuitGymUpper": [:],
//                        "circuitGymLower": [:],
//                        "classicBodyweightFull": [:],
//                        "classicBodyweightUpper": [:],
//                        "classicBodyweightLower": [:],
//                        "circuitBodyweightFull": [:],
//                        "circuitBodyweightUpper": [:],
//                        "circuitBodyweightLower": [:],
//            ],
//            "endurance": ["hiit": [:],
//                          "bodyweight": [:],],
//            "stretching": ["general": [:],
//                           "postWorkout": [:],
//                           "postCardio": [:],],
//            "yoga": ["relaxing": [:],
//                     "neutral": [:],
//                     "stimulating": [:],],
//    ]
}
