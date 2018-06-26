//
//  SortedSessionsSchedule.swift
//  MindAndBody
//
//  Created by Luke Smith on 05.12.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation

extension sessionData {

    // MARK:- Sorted Sessions for Schedule
    static let sortedSessions: [String: [String: [String: [String: [String]]]]] = [
        // TODO: CORRECT INDEXING OF SCHEDULE SCREEN
        // Note: choice path in schedule leads to a session, the session is found nested here, as an index to the sessions dictionary
        
        // NOTE: Naming should be obvious, e.g
            // Warmup, Full body == WaF
            // Workout, Gym, Classic, FullBody == GCsU  (Cs == classic, Cc == circuit)

        
        // MARK:- Workout ------------------------------- -------------------------------
        "workout": [
            // MARK: Warmups -------------------------------
            // NOTE, bodyweight and gym use the same warmup, i.e warmups currently do not include the use of equipment
            "WaF": [
                // Short
                "short": [
                    // Average
                    "average": ["WaWS-F-1",
                                "WaWS-F-2",
                                "WaWS-F-3",
                                "WaWS-F-4",],
                ],
                // Normal
                "normal": [
                    // Average
                    "average": ["WaWN-F-1",
                                "WaWN-F-2",
                                "WaWN-F-3",
                                "WaWN-F-4",],
                ],
            ],
            "WaU": [
                // Short
                "short": [
                    // Average
                    "average": ["WaWS-U-1",
                                "WaWS-U-2",],
                ],
                // Normal
                "normal": [
                    // Average
                    "average": ["WaWN-U-1",
                                "WaWN-U-2",],
                ],
            ],
            "WaL": [
                // Short
                "short": [
                    // Average
                    "average": ["WaWS-L-1",
                                "WaWS-L-2",
                                "WaWS-L-3",
                                "WaWS-L-4",],
                ],
                // Normal
                "normal": [
                    // Average
                    "average": ["WaWN-L-1",
                                "WaWN-L-2",
                                "WaWN-L-3",
                                "WaWN-L-4",],
                ],
            ],
            // MARK: Sessions -------------------------------
            // MARK: Classic Gym
            "classicGymFull": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WGES-CsF-1-W",
                             "WGES-CsF-2-W",
                             "WGES-CsF-3-W",
                             "WGES-CsF-4-W",
                             "WGES-CsF-1",
                             "WGES-CsF-2",
                             "WGES-CsF-3",
                             "WGES-CsF-4",
                             "WGES-CsF-1-M",
                             "WGES-CsF-2-M",
                             "WGES-CsF-3-M",
                             "WGES-CsF-4-M",
                             "WGES-CsF-5-M",
                             "WGES-CsF-6-M",],
                    // average
                    "average": ["WGAS-CsF-1-W",
                                "WGAS-CsF-2-W",
                                "WGAS-CsF-3-W",
                                "WGAS-CsF-4-W",
                                "WGAS-CsF-1",
                                "WGAS-CsF-2",
                                "WGAS-CsF-3",
                                "WGAS-CsF-4",
                                "WGAS-CsF-1-M",
                                "WGAS-CsF-2-M",
                                "WGAS-CsF-3-M",
                                "WGAS-CsF-4-M",
                                "WGAS-CsF-5-M",
                                "WGAS-CsF-6-M",],
                    // Hard
                    "hard": ["WGHS-CsF-1-W",
                             "WGHS-CsF-2-W",
                             "WGHS-CsF-3-W",
                             "WGHS-CsF-4-W",
                             "WGHS-CsF-1",
                             "WGHS-CsF-2",
                             "WGHS-CsF-3",
                             "WGHS-CsF-4",
                             "WGHS-CsF-5",
                             "WGHS-CsF-1-M",
                             "WGHS-CsF-2-M",
                             "WGHS-CsF-3-M",
                             "WGHS-CsF-4-M",
                             "WGHS-CsF-5-M",
                             "WGHS-CsF-6-M",
                             "WGHS-CsF-7-M",],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": ["WGEM-CsF-1-W",
                             "WGEM-CsF-2-W",
                             "WGEM-CsF-3-W",
                             "WGEM-CsF-4-W",
                             "WGEM-CsF-1",
                             "WGEM-CsF-2",
                             "WGEM-CsF-3",
                             "WGEM-CsF-4",
                             "WGEM-CsF-1-M",
                             "WGEM-CsF-2-M",
                             "WGEM-CsF-3-M",
                             "WGEM-CsF-4-M",
                             "WGEM-CsF-5-M",
                             "WGEM-CsF-6-M",],
                    // Average
                    "average": ["WGAM-CsF-1-W",
                                "WGAM-CsF-2-W",
                                "WGAM-CsF-3-W",
                                "WGAM-CsF-4-W",
                                "WGAM-CsF-1",
                                "WGAM-CsF-2",
                                "WGAM-CsF-3",
                                "WGAM-CsF-4",
                                "WGAM-CsF-1-M",
                                "WGAM-CsF-2-M",
                                "WGAM-CsF-3-M",
                                "WGAM-CsF-4-M",
                                "WGAM-CsF-5-M",
                                "WGAM-CsF-6-M",],
                    // Hard
                    "hard": ["WGHM-CsF-1-W",
                             "WGHM-CsF-2-W",
                             "WGHM-CsF-3-W",
                             "WGHM-CsF-4-W",
                             "WGHM-CsF-1",
                             "WGHM-CsF-2",
                             "WGHM-CsF-3",
                             "WGHM-CsF-4",
                             "WGHM-CsF-5",
                             "WGHM-CsF-1-M",
                             "WGHM-CsF-2-M",
                             "WGHM-CsF-3-M",
                             "WGHM-CsF-4-M",
                             "WGHM-CsF-5-M",
                             "WGHM-CsF-6-M",
                             "WGHM-CsF-7-M",],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": ["WGEL-CsF-1-W",
                             "WGEL-CsF-2-W",
                             "WGEL-CsF-3-W",
                             "WGEL-CsF-4-W",
                             "WGEL-CsF-1",
                             "WGEL-CsF-2",
                             "WGEL-CsF-3",
                             "WGEL-CsF-4",
                             "WGEL-CsF-1-M",
                             "WGEL-CsF-2-M",
                             "WGEL-CsF-3-M",
                             "WGEL-CsF-4-M",
                             "WGEL-CsF-5-M",
                             "WGEL-CsF-6-M",],
                    // Average
                    "average": ["WGAL-CsF-1-W",
                               "WGAL-CsF-2-W",
                               "WGAL-CsF-3-W",
                               "WGAL-CsF-4-W",
                               "WGAL-CsF-1",
                               "WGAL-CsF-2",
                               "WGAL-CsF-3",
                               "WGAL-CsF-4",
                               "WGAL-CsF-1-M",
                               "WGAL-CsF-2-M",
                               "WGAL-CsF-3-M",
                               "WGAL-CsF-4-M",
                               "WGAL-CsF-5-M",
                               "WGAL-CsF-6-M",],
                    // Hard
                    "hard": ["WGHL-CsF-1-W",
                             "WGHL-CsF-2-W",
                             "WGHL-CsF-3-W",
                             "WGHL-CsF-4-W",
                             "WGHL-CsF-1",
                             "WGHL-CsF-2",
                             "WGHL-CsF-3",
                             "WGHL-CsF-4",
                             "WGHL-CsF-5",
                             "WGHL-CsF-1-M",
                             "WGHL-CsF-2-M",
                             "WGHL-CsF-3-M",
                             "WGHL-CsF-4-M",
                             "WGHL-CsF-5-M",
                             "WGHL-CsF-6-M",
                             "WGHL-CsF-7-M",],
                ],
            ],
            "classicGymUpper": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WGES-CsU-1-W",
                             "WGES-CsU-2-W",
                             "WGES-CsU-1",
                             "WGES-CsU-2",
                             "WGES-CsU-3",
                             "WGES-CsU-4",
                             "WGES-CsU-1-M",
                             "WGES-CsU-2-M",
                             "WGES-CsU-3-M",
                             "WGES-CsU-4-M",
                             "WGES-CsU-5-M",],
                    // Average
                    "average": ["WGAS-CsU-1-W",
                                "WGAS-CsU-2-W",
                                "WGAS-CsU-1",
                                "WGAS-CsU-2",
                                "WGAS-CsU-3",
                                "WGAS-CsU-4",
                                "WGAS-CsU-1-M",
                                "WGAS-CsU-2-M",
                                "WGAS-CsU-3-M",
                                "WGAS-CsU-4-M",
                                "WGAS-CsU-5-M",],
                    // Hard
                    "hard": ["WGHS-CsU-1-W",
                             "WGHS-CsU-2-W",
                             "WGHS-CsU-1",
                             "WGHS-CsU-2",
                             "WGHS-CsU-3",
                             "WGHS-CsU-4",
                             "WGHS-CsU-1-M",
                             "WGHS-CsU-2-M",
                             "WGHS-CsU-3-M",
                             "WGHS-CsU-4-M",
                             "WGHS-CsU-5-M",],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": ["WGEM-CsU-1-W",
                             "WGEM-CsU-2-W",
                             "WGEM-CsU-1",
                             "WGEM-CsU-2",
                             "WGEM-CsU-3",
                             "WGEM-CsU-4",
                             "WGEM-CsU-1-M",
                             "WGEM-CsU-2-M",
                             "WGEM-CsU-3-M",
                             "WGEM-CsU-4-M",
                             "WGEM-CsU-5-M",],
                    // Average
                    "average": ["WGAM-CsU-1-W",
                                "WGAM-CsU-2-W",
                                "WGAM-CsU-1",
                                "WGAM-CsU-2",
                                "WGAM-CsU-3",
                                "WGAM-CsU-4",
                                "WGAM-CsU-1-M",
                                "WGAM-CsU-2-M",
                                "WGAM-CsU-3-M",
                                "WGAM-CsU-4-M",
                                "WGAM-CsU-5-M",],
                    // Hard
                    "hard": ["WGHM-CsU-1-W",
                             "WGHM-CsU-2-W",
                             "WGHM-CsU-1",
                             "WGHM-CsU-2",
                             "WGHM-CsU-3",
                             "WGHM-CsU-4",
                             "WGHM-CsU-1-M",
                             "WGHM-CsU-2-M",
                             "WGHM-CsU-3-M",
                             "WGHM-CsU-4-M",
                             "WGHM-CsU-5-M",],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": ["WGEL-CsU-1-W",
                             "WGEL-CsU-2-W",
                             "WGEL-CsU-1",
                             "WGEL-CsU-2",
                             "WGEL-CsU-3",
                             "WGEL-CsU-4",
                             "WGEL-CsU-1-M",
                             "WGEL-CsU-2-M",
                             "WGEL-CsU-3-M",
                             "WGEL-CsU-4-M",
                             "WGEL-CsU-5-M",],
                    // Average
                    "average": ["WGAL-CsU-1-W",
                                "WGAL-CsU-2-W",
                                "WGAL-CsU-1",
                                "WGAL-CsU-2",
                                "WGAL-CsU-3",
                                "WGAL-CsU-4",
                                "WGAL-CsU-1-M",
                                "WGAL-CsU-2-M",
                                "WGAL-CsU-3-M",
                                "WGAL-CsU-4-M",
                                "WGAL-CsU-5-M",],
                    // Hard
                    "hard": ["WGHL-CsU-1-W",
                             "WGHL-CsU-2-W",
                             "WGHL-CsU-1",
                             "WGHL-CsU-2",
                             "WGHL-CsU-3",
                             "WGHL-CsU-4",
                             "WGHL-CsU-1-M",
                             "WGHL-CsU-2-M",
                             "WGHL-CsU-3-M",
                             "WGHL-CsU-4-M",
                             "WGHL-CsU-5-M",],
                ],
            ],
            "classicGymLower": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WGES-CsL-1",
                             "WGES-CsL-2",
                             "WGES-CsL-3",
                             "WGES-CsL-4",
                             "WGES-CsL-5",
                             "WGES-CsL-6",
                             "WGES-CsL-7",
                             "WGES-CsL-8",
                             "WGES-CsL-9",
                             "WGES-CsL-10",],
                    // Average
                    "average": ["WGAS-CsL-1",
                                "WGAS-CsL-2",
                                "WGAS-CsL-3",
                                "WGAS-CsL-4",
                                "WGAS-CsL-5",
                                "WGAS-CsL-6",
                                "WGAS-CsL-7",
                                "WGAS-CsL-8",
                                "WGAS-CsL-9",
                                "WGAS-CsL-10",],
                    // Hard
                    "hard": ["WGHS-CsL-1",
                             "WGHS-CsL-2",
                             "WGHS-CsL-3",
                             "WGHS-CsL-4",
                             "WGHS-CsL-5",
                             "WGHS-CsL-6",
                             "WGHS-CsL-7",
                             "WGHS-CsL-8",
                             "WGHS-CsL-9",
                             "WGHS-CsL-10",],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": ["WGEM-CsL-1",
                             "WGEM-CsL-2",
                             "WGEM-CsL-3",
                             "WGEM-CsL-4",
                             "WGEM-CsL-5",
                             "WGEM-CsL-6",
                             "WGEM-CsL-7",
                             "WGEM-CsL-8",
                             "WGEM-CsL-9",
                             "WGEM-CsL-10",],
                    // Average
                    "average": ["WGAM-CsL-1",
                                "WGAM-CsL-2",
                                "WGAM-CsL-3",
                                "WGAM-CsL-4",
                                "WGAM-CsL-5",
                                "WGAM-CsL-6",
                                "WGAM-CsL-7",
                                "WGAM-CsL-8",
                                "WGAM-CsL-9",
                                "WGAM-CsL-10",],
                    // Hard
                    "hard": ["WGHM-CsL-1",
                             "WGHM-CsL-2",
                             "WGHM-CsL-3",
                             "WGHM-CsL-4",
                             "WGHM-CsL-5",
                             "WGHM-CsL-6",
                             "WGHM-CsL-7",
                             "WGHM-CsL-8",
                             "WGHM-CsL-9",
                             "WGHM-CsL-10",],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": ["WGEL-CsL-1",
                             "WGEL-CsL-2",
                             "WGEL-CsL-3",
                             "WGEL-CsL-4",
                             "WGEL-CsL-5",
                             "WGEL-CsL-6",
                             "WGEL-CsL-7",
                             "WGEL-CsL-8",
                             "WGEL-CsL-9",
                             "WGEL-CsL-10",],
                    // Average
                    "average": ["WGAL-CsL-1",
                                "WGAL-CsL-2",
                                "WGAL-CsL-3",
                                "WGAL-CsL-4",
                                "WGAL-CsL-5",
                                "WGAL-CsL-6",
                                "WGAL-CsL-7",
                                "WGAL-CsL-8",
                                "WGAL-CsL-9",
                                "WGAL-CsL-10",],
                    // Hard
                    "hard": ["WGHL-CsL-1",
                             "WGHL-CsL-2",
                             "WGHL-CsL-3",
                             "WGHL-CsL-4",
                             "WGHL-CsL-5",
                             "WGHL-CsL-6",
                             "WGHL-CsL-7",
                             "WGHL-CsL-8",
                             "WGHL-CsL-9",
                             "WGHL-CsL-10",],
                ],
            ],
            // MARK: Circuit Gym
            "circuitGymFull": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WGES-CcF-1",
                             "WGES-CcF-2",
                             "WGES-CcF-3",
                             "WGES-CcF-4",
                             "WGES-CcF-5",],
                    // Average
                    "average": ["WGAS-CcF-1",
                                "WGAS-CcF-2",
                                "WGAS-CcF-3",
                                "WGAS-CcF-4",
                                "WGAS-CcF-5",],
                    // Hard
                    "hard": ["WGHS-CcF-1",
                             "WGHS-CcF-2",
                             "WGHS-CcF-3",
                             "WGHS-CcF-4",
                             "WGHS-CcF-5",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["WGEN-CcF-1",
                             "WGEN-CcF-2",
                             "WGEN-CcF-3",
                             "WGEN-CcF-4",
                             "WGEN-CcF-5",],
                    // Average
                    "average": ["WGAN-CcF-1",
                                "WGAN-CcF-2",
                                "WGAN-CcF-3",
                                "WGAN-CcF-4",
                                "WGAN-CcF-5",],
                    // Hard
                    "hard": ["WGHN-CcF-1",
                             "WGHN-CcF-2",
                             "WGHN-CcF-3",
                             "WGHN-CcF-4",
                             "WGHN-CcF-5",],
                ],
            ],
            "circuitGymUpper": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WGES-CcU-1",
                             "WGES-CcU-2",
                             "WGES-CcU-1-M",
                             "WGES-CcU-2-M",
                             "WGES-CcU-3-M",],
                    // Average
                    "average": ["WGAS-CcU-1",
                                "WGAS-CcU-2",
                                "WGAS-CcU-3",
                                "WGAS-CcU-1-M",
                                "WGAS-CcU-2-M",],
                    // Hard
                    "hard": ["WGHS-CcU-1",
                             "WGHS-CcU-2",
                             "WGHS-CcU-3",
                             "WGHS-CcU-1-M",
                             "WGHS-CcU-2-M",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["WGEN-CcU-1",
                             "WGEN-CcU-2",
                             "WGEN-CcU-1-M",
                             "WGEN-CcU-2-M",
                             "WGEN-CcU-3-M",],
                    // Average
                    "average": ["WGAN-CcU-1",
                                "WGAN-CcU-2",
                                "WGAN-CcU-3",
                                "WGAN-CcU-1-M",
                                "WGAN-CcU-2-M",],
                    // Hard
                    "hard": ["WGHN-CcU-1",
                             "WGHN-CcU-2",
                             "WGHN-CcU-3",
                             "WGHN-CcU-1-M",
                             "WGHN-CcU-2-M",],
                ],
            ],
            "circuitGymLower": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WGES-CcL-1",
                             "WGES-CcL-2",
                             "WGES-CcL-3",
                             "WGES-CcL-4",
                             "WGES-CcL-5",],
                    // Average
                    "average": ["WGAS-CcL-1",
                                "WGAS-CcL-2",
                                "WGAS-CcL-3",
                                "WGAS-CcL-4",
                                "WGAS-CcL-5",],
                    // Hard
                    "hard": ["WGHS-CcL-1",
                             "WGHS-CcL-2",
                             "WGHS-CcL-3",
                             "WGHS-CcL-4",
                             "WGHS-CcL-5",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["WGEN-CcL-1",
                             "WGEN-CcL-2",
                             "WGEN-CcL-3",
                             "WGEN-CcL-4",
                             "WGEN-CcL-5",],
                    // Average
                    "average": ["WGAN-CcL-1",
                                "WGAN-CcL-2",
                                "WGAN-CcL-3",
                                "WGAN-CcL-4",
                                "WGAN-CcL-5",],
                    // Hard
                    "hard": ["WGHN-CcL-1",
                             "WGHN-CcL-2",
                             "WGHN-CcL-3",
                             "WGHN-CcL-4",
                             "WGHN-CcL-5",],
                ],
            ],
            // MARK: Classic Bodyweight
            "classicBodyweightFull": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WBES-CsF-1",
                             "WBES-CsF-2",
                             "WBES-CsF-3",
                             "WBES-CsF-4",
                             "WBES-CsF-5",
                             "WBES-CsF-6",
                             "WBES-CsF-7",
                             "WBES-CsF-8",],
                    // Average
                    "average": ["WBAS-CsF-1",
                                "WBAS-CsF-2",
                                "WBAS-CsF-3",
                                "WBAS-CsF-4",
                                "WBAS-CsF-5",
                                "WBAS-CsF-6",
                                "WBAS-CsF-1-E",
                                "WBAS-CsF-2-E",
                                "WBAS-CsF-3-E",
                                "WBAS-CsF-4-E",
                                "WBAS-CsF-5-E",],
                    // Hard
                    "hard": ["WBHS-CsF-1",
                             "WBHS-CsF-2",
                             "WBHS-CsF-3",
                             "WBHS-CsF-4",
                             "WBHS-CsF-1-E",
                             "WBHS-CsF-2-E",
                             "WBHS-CsF-3-E",
                             "WBHS-CsF-4-E",
                             "WBHS-CsF-5-E",
                             "WBHS-CsF-6-E",
                             "WBHS-CsF-7-E",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["WBEN-CsF-1",
                             "WBEN-CsF-2",
                             "WBEN-CsF-3",
                             "WBEN-CsF-4",
                             "WBEN-CsF-5",
                             "WBEN-CsF-6",
                             "WBEN-CsF-7",
                             "WBEN-CsF-8",],
                    // Average
                    "average": ["WBAN-CsF-1",
                                "WBAN-CsF-2",
                                "WBAN-CsF-3",
                                "WBAN-CsF-4",
                                "WBAN-CsF-5",
                                "WBAN-CsF-6",
                                "WBAN-CsF-1-E",
                                "WBAN-CsF-2-E",
                                "WBAN-CsF-3-E",
                                "WBAN-CsF-4-E",
                                "WBAN-CsF-5-E",],
                    // Hard
                    "hard": ["WBHN-CsF-1",
                             "WBHN-CsF-2",
                             "WBHN-CsF-3",
                             "WBHN-CsF-4",
                             "WBHN-CsF-1-E",
                             "WBHN-CsF-2-E",
                             "WBHN-CsF-3-E",
                             "WBHN-CsF-4-E",
                             "WBHN-CsF-5-E",
                             "WBHN-CsF-6-E",
                             "WBHN-CsF-7-E",],
                ],
            ],
            "classicBodyweightUpper": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WBES-CsU-1",
                             "WBES-CsU-2",
                             "WBES-CsU-3",
                             "WBES-CsU-4",],
                    // Average
                    "average": ["WBAS-CsU-1",
                                "WBAS-CsU-2",
                                "WBAS-CsU-3",
                                "WBAS-CsU-1-E",
                                "WBAS-CsU-2-E",
                                "WBAS-CsU-3-E",],
                    // Hard
                    "hard": ["WBHS-CsU-1",
                             "WBHS-CsU-2",
                             "WBHS-CsU-1-E",
                             "WBHS-CsU-2-E",
                             "WBHS-CsU-3-E",
                             "WBHS-CsU-4-E",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["WBEN-CsU-1",
                             "WBEN-CsU-2",
                             "WBEN-CsU-3",
                             "WBEN-CsU-4",],
                    // Average
                    "average": ["WBAN-CsU-1",
                                "WBAN-CsU-2",
                                "WBAN-CsU-3",
                                "WBAN-CsU-1-E",
                                "WBAN-CsU-2-E",
                                "WBAN-CsU-3-E",],
                    // Hard
                    "hard": ["WBHN-CsU-1",
                             "WBHN-CsU-2",
                             "WBHN-CsU-1-E",
                             "WBHN-CsU-2-E",
                             "WBHN-CsU-3-E",
                             "WBHN-CsU-4-E",],
                ],
            ],
            "classicBodyweightLower": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WBES-CsL-1",
                             "WBES-CsL-2",
                             "WBES-CsL-3",
                             "WBES-CsL-4",
                             "WBES-CsL-5",
                             "WBES-CsL-6",],
                    // Average
                    "average": ["WBAS-CsL-1",
                                "WBAS-CsL-2",
                                "WBAS-CsL-3",
                                "WBAS-CsL-4",
                                "WBAS-CsL-5",
                                "WBAS-CsL-6",],
                    // Hard
                    "hard": ["WBHS-CsL-1",
                             "WBHS-CsL-2",
                             "WBHS-CsL-3",
                             "WBHS-CsL-4",
                             "WBHS-CsL-5",
                             "WBHS-CsL-6",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["WBEN-CsL-1",
                             "WBEN-CsL-2",
                             "WBEN-CsL-3",
                             "WBEN-CsL-4",
                             "WBEN-CsL-5",
                             "WBEN-CsL-6",],
                    // Average
                    "average": ["WBAN-CsL-1",
                                "WBAN-CsL-2",
                                "WBAN-CsL-3",
                                "WBAN-CsL-4",
                                "WBAN-CsL-5",
                                "WBAN-CsL-6",],
                    // Hard
                    "hard": ["WBHN-CsL-1",
                             "WBHN-CsL-2",
                             "WBHN-CsL-3",
                             "WBHN-CsL-4",
                             "WBHN-CsL-5",
                             "WBHN-CsL-6",],
                ],
            ],
            // MARK: Circuit Bodyweight
            "circuitBodyweightFull": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WBES-CcF-1",
                             "WBES-CcF-2",
                             "WBES-CcF-3",
                             "WBES-CcF-4",
                             "WBES-CcF-5",
                             "WBES-CcF-6",
                             "WBES-CcF-7",
                             "WBES-CcF-8",],
                    // Average
                    "average": ["WBAS-CcF-1",
                                "WBAS-CcF-2",
                                "WBAS-CcF-3",
                                "WBAS-CcF-4",
                                "WBAS-CcF-5",
                                "WBAS-CcF-6",
                                "WBAS-CcF-1-E",
                                "WBAS-CcF-2-E",
                                "WBAS-CcF-3-E",
                                "WBAS-CcF-4-E",
                                "WBAS-CcF-5-E",],
                    // Hard
                    "hard": ["WBHS-CcF-1",
                             "WBHS-CcF-2",
                             "WBHS-CcF-3",
                             "WBHS-CcF-4",
                             "WBHS-CcF-1-E",
                             "WBHS-CcF-2-E",
                             "WBHS-CcF-3-E",
                             "WBHS-CcF-4-E",
                             "WBHS-CcF-5-E",
                             "WBHS-CcF-6-E",
                             "WBHS-CcF-7-E",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["WBEN-CcF-1",
                             "WBEN-CcF-2",
                             "WBEN-CcF-3",
                             "WBEN-CcF-4",
                             "WBEN-CcF-5",
                             "WBEN-CcF-6",
                             "WBEN-CcF-7",
                             "WBEN-CcF-8",],
                    // Average
                    "average": ["WBAN-CcF-1",
                                "WBAN-CcF-2",
                                "WBAN-CcF-3",
                                "WBAN-CcF-4",
                                "WBAN-CcF-5",
                                "WBAN-CcF-6",
                                "WBAN-CcF-1-E",
                                "WBAN-CcF-2-E",
                                "WBAN-CcF-3-E",
                                "WBAN-CcF-4-E",
                                "WBAN-CcF-5-E",],
                    // Hard
                    "hard": ["WBHN-CcF-1",
                             "WBHN-CcF-2",
                             "WBHN-CcF-3",
                             "WBHN-CcF-4",
                             "WBHN-CcF-1-E",
                             "WBHN-CcF-2-E",
                             "WBHN-CcF-3-E",
                             "WBHN-CcF-4-E",
                             "WBHN-CcF-5-E",
                             "WBHN-CcF-6-E",
                             "WBHN-CcF-7-E",],
                ],
            ],
            "circuitBodyweightUpper": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WBES-CcU-1",
                             "WBES-CcU-2",
                             "WBES-CcU-3",
                             "WBES-CcU-4",],
                    // Average
                    "average": ["WBAS-CcU-1",
                                "WBAS-CcU-2",
                                "WBAS-CcU-3",
                                "WBAS-CcU-1-E",
                                "WBAS-CcU-2-E",
                                "WBAS-CcU-3-E",],
                    // Hard
                    "hard": ["WBHS-CcU-1",
                             "WBHS-CcU-2",
                             "WBHS-CcU-1-E",
                             "WBHS-CcU-2-E",
                             "WBHS-CcU-3-E",
                             "WBHS-CcU-4-E",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["WBEN-CcU-1",
                             "WBEN-CcU-2",
                             "WBEN-CcU-3",
                             "WBEN-CcU-4",],
                    // Average
                    "average": ["WBAN-CcU-1",
                                "WBAN-CcU-2",
                                "WBAN-CcU-3",
                                "WBAN-CcU-1-E",
                                "WBAN-CcU-2-E",
                                "WBAN-CcU-3-E",],
                    // Hard
                    "hard": ["WBHN-CcU-1",
                             "WBHN-CcU-2",
                             "WBHN-CcU-1-E",
                             "WBHN-CcU-2-E",
                             "WBHN-CcU-3-E",
                             "WBHN-CcU-4-E",],
                ],
            ],
            "circuitBodyweightLower": [
                // Short
                "short": [
                    // Easy
                    "easy": ["WBES-CcL-1",
                             "WBES-CcL-2",
                             "WBES-CcL-3",
                             "WBES-CcL-4",
                             "WBES-CcL-5",
                             "WBES-CcL-6",],
                    // Average
                    "average": ["WBAS-CcL-1",
                                "WBAS-CcL-2",
                                "WBAS-CcL-3",
                                "WBAS-CcL-4",
                                "WBAS-CcL-5",
                                "WBAS-CcL-6",],
                    // Hard
                    "hard": ["WBHS-CcL-1",
                             "WBHS-CcL-2",
                             "WBHS-CcL-3",
                             "WBHS-CcL-4",
                             "WBHS-CcL-5",
                             "WBHS-CcL-6",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["WBEN-CcL-1",
                             "WBEN-CcL-2",
                             "WBEN-CcL-3",
                             "WBEN-CcL-4",
                             "WBEN-CcL-5",
                             "WBEN-CcL-6",],
                    // Average
                    "average": ["WBAN-CcL-1",
                                "WBAN-CcL-2",
                                "WBAN-CcL-3",
                                "WBAN-CcL-4",
                                "WBAN-CcL-5",
                                "WBAN-CcL-6",],
                    // Hard
                    "hard": ["WBHN-CcL-1",
                             "WBHN-CcL-2",
                             "WBHN-CcL-3",
                             "WBHN-CcL-4",
                             "WBHN-CcL-5",
                             "WBHN-CcL-6",],
                ],
            ],
            // MARK: Stretching -------------------------------
            "SF": [
                // Short
                "short": [
                    // Average
                    "average": ["SWS-F-1",
                                "SWS-F-2",
                                "SWS-F-3",
                                "SWS-F-1-F",
                                "SWS-F-2-F",
                                "SWS-F-3-F",],
                ],
                // Normal
                "normal": [
                    // Average
                    "average": ["SWN-F-1",
                                "SWN-F-2",
                                "SWN-F-3",
                                "SWN-F-1-F",
                                "SWN-F-2-F",
                                "SWN-F-3-F",],
                ],
            ],
            "SU": [
                // Short
                "short": [
                    // Average
                    "average": ["SWS-U-1",
                                "SWS-U-2",
                                "SWS-U-3",
                                "SWS-U-1-F",
                                "SWS-U-2-F",
                                "SWS-U-3-F",],
                ],
                // Normal
                "normal": [
                    // Average
                    "average": ["SWN-U-1",
                                "SWN-U-2",
                                "SWN-U-3",
                                "SWN-U-1-F",
                                "SWN-U-2-F",
                                "SWN-U-3-F",],
                ],
            ],
            "SL": [
                // Short
                "short": [
                    // Average
                    "average": ["SWS-L-1",
                                "SWS-L-2",
                                "SWS-L-3",
                                "SWS-L-1-F",
                                "SWS-L-2-F",
                                "SWS-L-3-F",],
                ],
                // Normal
                "normal": [
                    // Average
                    "average": ["SWN-L-1",
                                "SWN-L-2",
                                "SWN-L-3",
                                "SWN-L-1-F",
                                "SWN-L-2-F",
                                "SWN-L-3-F",],
                ],
            ],
        ],
        // MARK:- Yoga ------------------------------- -------------------------------
        "yoga": [
            // MARK: Warmups -------------------------------
            "warmup": [
                // Short
                "short": [
                    // Average
                    "average": ["WaFS-1",
                                "WaFS-2",
                                "WaFS-3",],
                ],
                // Normal
                "normal": [
                    // Average
                    "average": ["WaFN-1",
                                "WaFN-2",
                                "WaFN-3",],
                ],
            ],
            // MARK: Practices -------------------------------
            // MARK: Relaxing
            "relaxing": [
                // Very Short
                "veryShort": [
                    // Easy
                    "easy": ["YREVs-1",
                             "YREVs-2",
                             "YREVs-3",
                             "YREVs-4",
                             "YREVs-5",
                             "YREVs-6",],
                    // Average
                    "average": [// Easy
                                "YREVs-1",
                                "YREVs-2",
                                "YREVs-3",
                                "YREVs-4",
                                "YREVs-5",
                                "YREVs-6",
                                // Average
                                "YRAVs-1",
                                "YRAVs-2",],
                    // Hard
                    "hard": [// Easy
                            "YREVs-1",
                            "YREVs-2",
                            "YREVs-3",
                            "YREVs-4",
                            "YREVs-5",
                            "YREVs-6",
                            // Average
                            "YRAVs-1",
                            "YRAVs-2",
                            // Hard
                            ],
                ],
                // Short
                "short": [
                    // Easy
                    "easy": ["YRES-1",
                             "YRES-2",
                             "YRES-3",
                             "YRES-4",
                             "YRES-5",],
                    // Average
                    "average": [// Easy
                                "YRES-1",
                                "YRES-2",
                                "YRES-3",
                                "YRES-4",
                                "YRES-5",
                                // Average
                                "YRAS-1",
                                "YRAS-2",
                                // Hard
                                ],
                    // Hard
                    "hard": ["YRES-1",
                             "YRES-2",
                             "YRES-3",
                             "YRES-4",
                             "YRES-5",
                             // Average
                            "YRAS-1",
                            "YRAS-2",
                            // Hard, Short
                            "YRHS-1",],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": ["YREM-1",
                             "YREM-2",
                             "YREM-3",
                             "YREM-4",
                             "YREM-5",],
                    // Average
                    "average": [// Easy
                                "YREM-1",
                                "YREM-2",
                                "YREM-3",
                                "YREM-4",
                                "YREM-5",
                                // Average
                                "YRAM-1",
                                "YRAM-2",
                                "YRAM-3",
                                // Hard
                                ],
                    // Hard
                    "hard": [// Easy
                            "YREM-1",
                             "YREM-2",
                             "YREM-3",
                             "YREM-4",
                             "YREM-5",
                             // Average
                            "YRAM-1",
                            "YRAM-2",
                            "YRAM-3",
                            // Hard
                            ],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": ["YREL-1",
                             "YREL-2",
                             "YREL-3",
                             "YREL-4",
                             "YREL-5",],
                    // Average
                    "average": [// Easy
                                "YREL-1",
                                "YREL-2",
                                "YREL-3",
                                "YREL-4",
                                "YREL-5",
                                // Average, Long
                                "YRAL-1",
                                "YRAL-2",
                                "YRAL-3",
                                // Hard
                                ],
                    // Hard
                    "hard": [// Easy
                            "YREL-1",
                             "YREL-2",
                             "YREL-3",
                             "YREL-4",
                             "YREL-5",
                             // Average, Long
                            "YRAL-1",
                            "YRAL-2",
                            "YRAL-3",
                            // Hard
                            ],
                ],
            ],
            // MARK: Neutral
            "neutral": [
                // Short
                "short": [
                    // Easy
                    "easy": ["YNES-1",
                             "YNES-2",
                             "YNES-3",
                             "YNES-4",],
                    // Average
                    "average": [// Easy
                                "YNES-1",
                                "YNES-2",
                                "YNES-3",
                                "YNES-4",
                                // Average, Short
                                "YNAS-1",
                                "YNAS-2",
                                // Hard
                                ],
                    "hard": [// Easy
                                "YNES-1",
                                "YNES-2",
                                "YNES-3",
                                "YNES-4",
                                // Average, Short
                                "YNAS-1",
                                "YNAS-2",
                                // Hard
                                ],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": ["YNEM-1",
                             "YNEM-2",
                             "YNEM-3",
                             "YNEM-4",],
                    // Average
                    "average": [// Easy
                                "YNEM-1",
                                "YNEM-2",
                                "YNEM-3",
                                "YNEM-4",
                                // Average, Medium
                                "YNAM-1",
                                "YNAM-2",],
                    // Hard
                    "hard": [// Easy
                            "YNEM-1",
                            "YNEM-2",
                            "YNEM-3",
                            "YNEM-4",
                            // Average, Medium
                            "YNAM-1",
                            "YNAM-2",
                            // Hard
                            ],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": ["YNEL-1",
                             "YNEL-2",
                             "YNEL-3",
                             "YNEL-4",],
                    // Average
                    "average": [// Easy
                                "YNEL-1",
                                "YNEL-2",
                                "YNEL-3",
                                "YNEL-4",
                                // Average, Long
                                "YNAL-1",
                                "YNAL-2",],
                    // Hard
                    "hard": [// Easy
                            "YNEL-1",
                            "YNEL-2",
                            "YNEL-3",
                            "YNEL-4",
                            // Average, Long
                            "YNAL-1",
                            "YNAL-2",
                            // Hard
                            ],
                ],
            ],
            // MARK: Stimulating
            "stimulating": [
                // Short
                "short": [
                    // Easy
                    "easy": ["YSES-1",
                             "YSES-2",
                             "YSES-3",
                             "YSES-4",
                             "YSES-5",],
                    // Average
                    "average": [// Easy
                                "YSES-1",
                                "YSES-2",
                                "YSES-3",
                                "YSES-4",
                                "YSES-5",
                                // Average
                                ],
                    // Hard
                    "hard": [// Easy
                            "YSES-1",
                             "YSES-2",
                             "YSES-3",
                             "YSES-4",
                             "YSES-5",
                            // Average
                            // Hard
                            ],
                ],
                // Medium
                "normal": [
                    // Easy
                    "easy": ["YSEM-1",
                             "YSEM-2",
                             "YSEM-3",
                             "YSEM-4",
                             "YSEM-5",],
                    // Average
                    "average": [// Easy
                                "YSEM-1",
                                "YSEM-2",
                                "YSEM-3",
                                "YSEM-4",
                                "YSEM-5",
                                // Average
                                ],
                    // Hard
                    "hard": [// Easy
                            "YSEM-1",
                             "YSEM-2",
                             "YSEM-3",
                             "YSEM-4",
                             "YSEM-5",
                             // Average
                             // Hard
                            ],
                ],
            ],
        ],
        // MARK:- Mind ------------------------------- -------------------------------
        "mind": [:],
        // MARK:- Endurance ------------------------------- -------------------------------
        "endurance": [
            // MARK: Warmups -------------------------------
            "warmup": [
                // Short
                "short": [
                    // Average
                    "average": ["WaES-1",
                                "WaES-2",
                                "WaES-3",
                                "WaES-4",],
                ],
                // Normal
                "normal": [
                    // Average
                    "average": ["WaEN-1",
                                "WaEN-2",
                                "WaEN-3",],
                ],
            ],
            // MARK: Sessions -------------------------------
            // MARK: HIIT
            "hiit": [
                // Short (Session)
                "short": [
                    // Short (Intervals)
                    "short": ["CHSS-1",
                              "CHSS-2",
                              "CHSS-3",
                              "CHSS-4",
                              "CHSS-5",],
                    // Medium
                    "medium": ["CHSM-1",
                               "CHSM-2",
                               "CHSM-3",
                               "CHSM-4",
                               "CHSM-5",],
                    // Long
                    "long": ["CHSL-1",
                             "CHSL-2",
                             "CHSL-3",
                             "CHSL-4",
                             "CHSL-5",],
                ],
                // Medium
                "medium": [
                    // Short
                    "short": ["CHMS-1",
                              "CHMS-2",
                              "CHMS-3",
                              "CHMS-4",
                              "CHMS-5",],
                    // Medium
                    "medium": ["CHMM-1",
                               "CHMM-2",
                               "CHMM-3",
                               "CHMM-4",
                               "CHMM-5",],
                    // Long
                    "long": ["CHML-1",
                             "CHML-2",
                             "CHML-3",
                             "CHML-4",
                             "CHML-5",],
                ],
                // Long
                "long": [
                    // Short
                    "short": ["CHLS-1",
                              "CHLS-2",
                              "CHLS-3",
                              "CHLS-4",
                              "CHLS-5",],
                    // Medium
                    "medium": ["CHLM-1",
                               "CHLM-2",
                               "CHLM-3",
                               "CHLM-4",
                               "CHLM-5",],
                    // Long
                    "long": ["CHLL-1",
                             "CHLL-2",
                             "CHLL-3",
                             "CHLL-4",
                             "CHLL-5",],
                ],
            ],
            // MARK: Bodyweight
            "bodyweight": [
                // Short
                "short": [
                    // Easy
                    "easy": ["CBES-1",
                             "CBES-2",
                             "CBES-3",],
                    // Average
                    "average": ["CBAS-1",
                                "CBAS-2",
                                "CBAS-3",],
                    // Hard
                    "hard": ["CBHS-1",
                             "CBHS-2",
                             "CBHS-3",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["CBEN-1",
                             "CBEN-2",
                             "CBEN-3",],
                    // Average
                    "average": ["CBAN-1",
                                "CBAN-2",
                                "CBAN-3",],
                    // Hard
                    "hard": ["CBHN-1",
                             "CBHN-2",
                             "CBHN-3",],
                ],
            ],
            // MARK: Stretching -------------------------------
            "stretching": [
                // Short
                "short": [
                    // Average
                    "average": ["SES-1",
                                "SES-2",
                                "SES-3",
                                "SES-1-F",
                                "SES-2-F",
                                "SES-3-F",],
                ],
                // Normal
                "normal": [
                    // Average
                    "average": ["SEN-1",
                                "SEN-2",
                                "SEN-3",
                                "SEN-1-F",
                                "SEN-2-F",
                                "SEN-3-F",],
                ],
            ]
        ],
        // MARK:- Flexibility ------------------------------- -------------------------------
        "flexibility": [
            // MARK: Warmup -------------------------------
            "warmup": [
                // Short
                "short": [
                    // Average
                    "average": ["WaFS-1",
                                "WaFS-2",
                                "WaFS-3",],
                ],
                // Normal
                "normal": [
                    // Average
                    "average": ["WaFN-1",
                                "WaFN-2",
                                "WaFN-3",],
                ],
            ],
            // MARK: Stretching Sessions -------------------------------
                // Note average and hard difficulties are the same
            // MARK: Full
            "full": [
                // Short
                "short": [
                    // Easy
                    "easy": ["SGES-1",
                             "SGES-2",
                             "SGES-3",],
                    // Average
                    "average": [// Easy
                                "SGES-1",
                                "SGES-2",
                                "SGES-3",
                                // Average
                                "SGAS-1",
                                "SGAS-2",
                                ],
                    // Hard
                    "hard": [// Easy
                        "SGES-1",
                        "SGES-2",
                        "SGES-3",
                        // Average
                        "SGAS-1",
                        "SGAS-2",
                    ],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["SGEN-1",
                             "SGEN-2",
                             "SGEN-3",],
                    // Average
                    "average": [// Easy
                                "SGEN-1",
                                "SGEN-2",
                                "SGEN-3",
                                // Average
                                "SGAN-1",
                                "SGAN-2",],
                    // Hard
                    "hard": [// Easy
                        "SGEN-1",
                        "SGEN-2",
                        "SGEN-3",
                        // Average
                        "SGAN-1",
                        "SGAN-2",],
                ],
            ],
            // MARK: Hamstrings
            "hamstrings": [
                // Short
                "short": [
                    // Easy
                    "easy": ["SHES-1",
                             "SHES-2",],
                    // Average
                    "average": [// Easy
                                "SHES-1",
                                "SHES-2",
                                // Average
                                "SHAS-1",],
                    // Hard
                    "hard": [// Easy
                        "SHES-1",
                        "SHES-2",
                        // Average
                        "SHAS-1",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["SHEN-1",
                             "SHEN-2",],
                    // Average
                    "average": [// Easy
                                "SHEN-1",
                                "SHEN-2",
                                // Average
                                "SHAN-1",],
                    // Hard
                    "hard": [// Easy
                        "SHEN-1",
                        "SHEN-2",
                        // Average
                        "SHAN-1",],
                ],
            ],
            // MARK: Hips
            "hips": [
                // Short
                "short": [
                    // Easy
                    "easy": ["SHiES-1",
                             "SHiES-2",],
                    // Average
                    "average": [// Easy
                                "SHiES-1",
                                "SHiES-2",
                                // Average
                                "SHiAS-1",],
                    // Hard
                    "hard": [// Easy
                        "SHiES-1",
                        "SHiES-2",
                        // Average
                        "SHiAS-1",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["SHiEN-1",
                             "SHiEN-2",],
                    // Average
                    "average": [// Easy
                                "SHiEN-1",
                                "SHiEN-2",
                                // Average
                                "SHiAN-1",],
                    // Hard
                    "hard": [// Easy
                        "SHiEN-1",
                        "SHiEN-2",
                        // Average
                        "SHiAN-1",],
                ],
            ],
            // MARK: BackNeck
            "backNeck": [
                // Short
                "short": [
                    // Easy
                    "easy": ["SBES-1",
                             "SBES-2",],
                    // Average
                    "average": [// Easy
                                "SBES-1",
                                "SBES-2",
                                // Average
                                "SBAS-1",],
                    // Hard
                    "hard": [// Easy
                        "SBES-1",
                        "SBES-2",
                        // Average
                        "SBAS-1",],
                ],
                // Normal
                "normal": [
                    // Easy
                    "easy": ["SBEN-1",
                             "SBEN-2",],
                    // Average
                    "average": [// Easy
                                "SBEN-1",
                                "SBEN-2",
                                // Average
                                "SBAN-1",],
                    // Hard
                    "hard": [// Easy
                        "SBEN-1",
                        "SBEN-2",
                        // Average
                        "SBAN-1",],
                ],
            ],
            // MARK: Foam Rolling
                // Note all difficulties are the same
            "foamRoll": [
                // Short
                "short": [
                    "easy": ["SFS-1",],
                    "average": ["SFS-1",],
                    "hard": ["SFS-1",],
                ],
                // Normal
                "normal": [
                    "easy": ["SFN-1",],
                    "average": ["SFN-1",],
                    "hard": ["SFN-1",],
                ],
            ],
        ],
    ]
    
}
