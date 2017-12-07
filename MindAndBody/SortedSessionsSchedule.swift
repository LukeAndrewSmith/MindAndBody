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
    static let sortedSessions: [String: [String: [String: [String: [[String]]]]]] = [
        // TODO: CORRECT INDEXING OF SCHEDULE SCREEN
        // Note: choice path in schedule leads to a session, the session is found nested here, as an index to the sessions dictionary
        // MARK:- Mind ------------------------------- -------------------------------
        "mind": [
            // MARK: Warmup -------------------------------
            "warmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Focuses -------------------------------
            // Focuses
            "calm": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "stressReduction": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "strength": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "energising": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "focusing": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ]
        ],
        // MARK:- Flexibility ------------------------------- -------------------------------
        "flexibility": [
            // MARK: Warmups (different focuses) -------------------------------
            "generalWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "hamstringWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "hipsWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "backNeckWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Stretching Sessions -------------------------------
            "generalStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "hamstringStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "hipsStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "backNeckStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Yoga Sessions -------------------------------
            "generalYoga": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "hamstringYoga": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "hipsYoga": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "backNeckYoga": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ]
        ],
        // MARK:- Endurance ------------------------------- -------------------------------
        "endurance": [
            // MARK: Warmups -------------------------------
            "runningWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "bikingWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "rowingWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "workoutWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Sessions -------------------------------
            "runningSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "bikingSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "rowingSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "workoutSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Stretching -------------------------------
            "runningStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "bikingStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "rowingStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "workoutStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ]
        ],
        // MARK:- Toning ------------------------------- -------------------------------
        "toning": [
            // MARK: Warmups -------------------------------
            "cardioWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "fullWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "upperWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "lowerWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Sessions -------------------------------
            // MARK: Cardio
            "cardioSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Classic Workout
            "fullSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "upperSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "lowerSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Circuit Workout
            "fullSessionCircuit": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "upperSessionCircuit": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "lowerSessionCircuit": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Stretchings -------------------------------
            "cardioStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "fullStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "upperStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "lowerStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ]
        ],
        // MARK:- Muscle Gain ------------------------------- -------------------------------
        "muscleGain": [
            // MARK: Warmups -------------------------------
            // MARK: Gym
            "gymWarmupFull": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "gymWarmupUpper": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "gymWarmupLower": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Bodyweight
            "bodyweightWarmupFull": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "bodyweightWarmupUpper": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "bodyweightWarmupLower": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Sessions -------------------------------
            // MARK: Classic Gym
            "gymSessionFullClassic": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "gymSessionUpperClassic": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "gymSessionLowerClassic": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Circuit Gym
            "gymSessionFullCircuit": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "gymSessionUpperCircuit": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "gymSessionLowerCircuit": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Classic Bodyweight
            "bodyweightSessionFullClassic": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "bodyweightSessionUpperClassic": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "bodyweightSessionLowerClassic": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Circuit Bodyweight
            "bodyweightSessionFullCircuit": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "bodyweightSessionUpperCircuit": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "bodyweightSessionLowerCircuit": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Stretchings -------------------------------
            // MARK: Gym
            "gymStretchingFull": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "gymStretchingUpper": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "gymStretchingLower": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Bodyweight
            "bodyweightStretchingFull": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "bodyweightStretchingUpper": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "bodyweightStretchingLower": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ]
        ],
        // MARK:- Strength ------------------------------- -------------------------------
        "strength": [
            // -------------------------------
            // MARK: Gym Warmups -------------------------------
            // MARK: 5x5 Warmups
            "5x5-1GymWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "5x5-2GymWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Accessory Warmups
            "accessory-1GymWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "accessory-2GymWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Bodyweight Warmups -------------------------------
            // MARK: 5x5 Warmups
            "5x5-1BodyweightWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "5x5-2BodyweightWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Accessory Warmups
            "accessory-1BodyweightWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "accessory-2BodyweightWarmup": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // -------------------------------
            // MARK: Gym Sessions -------------------------------
            // MARK: 5x5 Warmups
            "5x5-1GymSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "5x5-2GymSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Accessory Warmups
            "accessory-1GymSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "accessory-2GymSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Bodyweight Sessions -------------------------------
            // MARK: 5x5 Warmups
            "5x5-1BodyweightSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "5x5-2BodyweightSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Accessory Warmups
            "accessory-1BodyweightSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "accessory-2BodyweightSession": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // -------------------------------
            // MARK: Stretching -------------------------------
            // MARK: 5x5 Warmups
            "5x5-1GymStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "5x5-2GymStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Accessory Warmups
            "accessory-1GymStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "accessory-2GymStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Stretching -------------------------------
            // MARK: 5x5 Warmups
            "5x5-1BodyweightStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "5x5-2BodyweightStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            // MARK: Accessory Warmups
            "accessory-1BodyweightStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ],
            "accessory-2BodyweightStretching": [
                // Short
                "short": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Medium
                "medium": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
                // Long
                "long": [
                    // Easy
                    "easy": [["warmup", "fullBody", "testSession"]],
                    // Medium
                    "medium": [["warmup", "fullBody", "testSession"]],
                    // Hard
                    "hard": [["warmup", "fullBody", "testSession"]],
                ],
            ]
        ]
    ]
    
    // Overview of sortedSessions
    static let sortedSessionsWithoutAnyEntries: [String: [String: [String]]] = [
        // BodyweightStretching- Mind ------------------------------- -------------------------------
        "mind": [
            // BodyweightStretching Warmup -------------------------------
            "warmup": [
            ],
            // BodyweightStretching Focuses -------------------------------
            // Focuses
            "calm": [
            ],
            "stressReduction": [
            ],
            "strength": [
            ],
            "energising": [
            ],
            "focusing": [
            ]
        ],
        // BodyweightStretching- Flexibility ------------------------------- -------------------------------
        "flexibility": [
            // BodyweightStretching Warmups (different focuses) -------------------------------
            "generalWarmup": [
            ],
            "hamstringWarmup": [
            ],
            "hipsWarmup": [
            ],
            "backNeckWarmup": [
            ],
            // BodyweightStretching Stretching Sessions -------------------------------
            "generalStretching": [
            ],
            "hamstringStretching": [
            ],
            "hipsStretching": [
            ],
            "backNeckStretching": [
            ],
            // BodyweightStretching Yoga Sessions -------------------------------
            "generalYoga": [
            ],
            "hamstringYoga": [
            ],
            "hipsYoga": [
            ],
            "backNeckYoga": [
            ]
        ],
        // BodyweightStretching- Endurance ------------------------------- -------------------------------
        "endurance": [
            // BodyweightStretching Warmups -------------------------------
            "runningWarmup": [
            ],
            "bikingWarmup": [
            ],
            "rowingWarmup": [
            ],
            "workoutWarmup": [
            ],
            // BodyweightStretching Sessions -------------------------------
            "runningSession": [
            ],
            "bikingSession": [
            ],
            "rowingSession": [
            ],
            "workoutSession": [
            ],
            // BodyweightStretching Stretching -------------------------------
            "runningStretching": [
            ],
            "bikingStretching": [
            ],
            "rowingStretching": [
            ],
            "workoutStretching": [
            ]
        ],
        // BodyweightStretching- Toning ------------------------------- -------------------------------
        "toning": [
            // BodyweightStretching Warmups -------------------------------
            "cardioWarmup": [
            ],
            "fullWarmup": [
            ],
            "upperWarmup": [
            ],
            "lowerWarmup": [
            ],
            // BodyweightStretching Sessions -------------------------------
            // BodyweightStretching Cardio
            "cardioSession": [
            ],
            // BodyweightStretching Circuit Workout
            "fullSessionCircuit": [
            ],
            "upperSessionCircuit": [
            ],
            "lowerSessionCircuit": [
            ],
            // BodyweightStretching Stretchings -------------------------------
            "cardioStretching": [
            ],
            "fullStretching": [
            ],
            "upperStretching": [
            ],
            "lowerStretching": [
            ],
        ],
        // BodyweightStretching- Muscle Gain ------------------------------- -------------------------------
        "muscleGain": [
            // BodyweightStretching Warmups -------------------------------
            // BodyweightStretching Gym
            "gymWarmupFull": [
            ],
            "gymWarmupUpper": [
            ],
            "gymWarmupLower": [
            ],
            // BodyweightStretching Bodyweight
            "bodyweightWarmupFull": [
            ],
            "bodyweightWarmupUpper": [
            ],
            "bodyweightWarmupLower": [
            ],
            // BodyweightStretching Sessions -------------------------------
            // BodyweightStretching Classic Gym
            "gymSessionFullClassic": [
            ],
            "gymSessionUpperClassic": [
            ],
            "gymSessionLowerClassic": [
            ],
            // BodyweightStretching Circuit Gym
            "gymSessionFullCircuit": [
            ],
            "gymSessionUpperCircuit": [
            ],
            "gymSessionLowerCircuit": [
            ],
            // BodyweightStretching Classic Bodyweight
            "bodyweightSessionFullClassic": [
            ],
            "bodyweightSessionUpperClassic": [
            ],
            "bodyweightSessionLowerClassic": [
            ],
            // BodyweightStretching Circuit Bodyweight
            "bodyweightSessionFullCircuit": [
            ],
            "bodyweightSessionUpperCircuit": [
            ],
            "bodyweightSessionLowerCircuit": [
            ],
            // BodyweightStretching Stretchings -------------------------------
            // BodyweightStretching Gym
            "gymStretchingFull": [
            ],
            "gymStretchingUpper": [
            ],
            "gymStretchingLower": [
            ],
            // BodyweightStretching Bodyweight
            "bodyweightStretchingFull": [
            ],
            "bodyweightStretchingUpper": [
            ],
            "bodyweightStretchingLower": [
            ],
        ],
        // BodyweightStretching- Strength ------------------------------- -------------------------------
        "strength": [
            // -------------------------------
            // BodyweightStretching Gym Warmups -------------------------------
            // BodyweightStretching 5x5 Warmups
            "5x5-1GymWarmup": [
            ],
            "5x5-2GymWarmup": [
            ],
            // BodyweightStretching Accessory Warmups
            "accessory-1GymWarmup": [
            ],
            "accessory-2GymWarmup": [
            ],
            // BodyweightStretching Bodyweight Warmups -------------------------------
            // BodyweightStretching 5x5 Warmups
            "5x5-1BodyweightWarmup": [
            ],
            "5x5-2BodyweightWarmup": [
            ],
            // BodyweightStretching Accessory Warmups
            "accessory-1BodyweightWarmup": [
            ],
            "accessory-2BodyweightWarmup": [
            ],
            // -------------------------------
            // BodyweightStretching Gym Sessions -------------------------------
            // BodyweightStretching 5x5 Warmups
            "5x5-1GymSession": [
            ],
            "5x5-1GymSession": [
            ],
            // BodyweightStretching Accessory Warmups
            "accessory-1GymSession": [
            ],
            "accessory-2GymSession": [
            ],
            // BodyweightStretching Bodyweight Sessions -------------------------------
            // BodyweightStretching 5x5 Warmups
            "5x5-1BodyweightSession": [
            ],
            "5x5-2BodyweightSession": [
            ],
            // BodyweightStretching Accessory Warmups
            "accessory-1BodyweightSession": [
            ],
            "accessory-2BodyweightSession": [
            ],
            // -------------------------------
            // BodyweightStretching Stretching -------------------------------
            // BodyweightStretching 5x5 Warmups
            "5x5-1GymStretching": [
            ],
            "5x5-2GymStretching": [
            ],
            // BodyweightStretching Accessory Warmups
            "accessory-1GymStretching": [
            ],
            "accessory-2GymStretching": [
            ],
            // BodyweightStretching Stretching -------------------------------
            // BodyweightStretching 5x5 Warmups
            "5x5-1BodyweightStretching": [
            ],
            "5x5-2BodyweightStretching": [
            ],
            // BodyweightStretching Accessory Warmups
            "accessory-1BodyweightStretching": [
            ],
            "accessory-2BodyweightStretching": [
            ],
        ]
    ]
    
}
