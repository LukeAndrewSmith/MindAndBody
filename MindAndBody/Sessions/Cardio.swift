//
//  Cardio.swift
//  MindAndBody
//
//  Created by Luke Smith on 24.02.19.
//  Copyright © 2019 Luke Smith. All rights reserved.
//

import Foundation

extension sessionData {
    // MARK:-
    // MARK:-
    // MARK:-
    // MARK:-
    // MARK:- Cardio
    // MARK: -
    // MARK: -
    // MARK: HIIT
    static let CH: [String: [[String: Any]]] = [
        // MARK: -
        // MARK: Session Time: Short
        // MARK: -
        // MARK: Interval Time: Short
        // MARK: Style 1: Steady
        // Cardio, HIIT, Short (session time), Short (interval time), - 1 (= style 1 as Int, see spreadsheet)
        "CHSS-1": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
        ],
        // MARK: Style 2: High Steady
        "CHSS-2": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
        ],
        // MARK: Style 3: Peak
        "CHSS-3": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
        ],
        // MARK: Style 4: Double Peak
        "CHSS-4": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        // MARK: Style 5: Increase
        "CHSS-5": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        
        // MARK: -
        // MARK: Interval Time: Medium
        // Short, Short, Style 1
        "CHSM-1": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        // MARK: Style 2: High Steady
        "CHSM-2": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
        ],
        // MARK: Style 3: Peak
        "CHSM-3": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        // MARK: Style 4: Double Peak
        "CHSM-4": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        // MARK: Style 5: Increase
        "CHSM-5": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        
        // MARK: -
        // MARK: Interval Time: Long
        // Short, Short, Style 1
        "CHSL-1": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        // MARK: Style 2: High Steady
        "CHSL-2": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
        ],
        // MARK: Style 3: Peak
        "CHSL-3": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        // MARK: Style 4: Double Peak
        "CHSL-4": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
        ],
        // MARK: Style 5: Increase
        "CHSL-5": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
        ],
        
        
        
        // MARK: -
        // MARK: Session Time: Medium
        // MARK: -
        // MARK: Interval Time: Short
        // MARK: Style 1: Steady
        // Short, Short, Style 1
        "CHMS-1": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
        ],
        // MARK: Style 2: High Steady
        "CHMS-2": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
        ],
        // MARK: Style 3: Peak
        "CHMS-3": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
        ],
        // MARK: Style 4: Double Peak
        "CHMS-4": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
        ],
        // MARK: Style 5: Increase
        "CHMS-5": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        
        // MARK: -
        // MARK: Interval Time: Medium
        // Short, Short, Style 1
        "CHMM-1": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        // MARK: Style 2: High Steady
        "CHMM-2": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
        ],
        // MARK: Style 3: Peak
        "CHMM-3": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        // MARK: Style 4: Double Peak
        "CHMM-4": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        // MARK: Style 5: Increase
        "CHMM-5": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        
        // MARK: -
        // MARK: Interval Time: Long
        // Short, Short, Style 1
        "CHML-1": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        // MARK: Style 2: High Steady
        "CHML-2": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
        ],
        // MARK: Style 3: Peak
        "CHML-3": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        // MARK: Style 4: Double Peak
        "CHML-4": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        // MARK: Style 5: Increase
        "CHML-5": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
        ],
        
        
        // MARK: -
        // MARK: Session Time: Long
        // MARK: -
        // MARK: Interval Time: Short
        // MARK: Style 1: Steady
        "CHLS-1": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
        ],
        // MARK: Style 2: High Steady
        "CHLS-2": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
        ],
        // MARK: Style 3: Peak
        "CHLS-3": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
        ],
        // MARK: Style 4: Double Peak
        "CHLS-4": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
        ],
        // MARK: Style 5: Increase
        "CHLS-5": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 10 as Int],
            ["movement": "lowIntensity" as String,
             "time": 30 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 20 as Int],
            ["movement": "lowIntensity" as String,
             "time": 60 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        
        // MARK: -
        // MARK: Interval Time: Medium
        // Short, Short, Style 1
        "CHLM-1": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        // MARK: Style 2: High Steady
        "CHLM-2": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
        ],
        // MARK: Style 3: Peak
        "CHLM-3": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        // MARK: Style 4: Double Peak
        "CHLM-4": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
        ],
        // MARK: Style 5: Increase
        "CHLM-5": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 30 as Int],
            ["movement": "lowIntensity" as String,
             "time": 90 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 45 as Int],
            ["movement": "lowIntensity" as String,
             "time": 135 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        
        // MARK: -
        // MARK: Interval Time: Long
        // Short, Short, Style 1
        "CHLL-1": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        // MARK: Style 2: High Steady
        "CHLL-2": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
        ],
        // MARK: Style 3: Peak
        "CHLL-3": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        // MARK: Style 4: Double Peak
        "CHLL-4": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
        ],
        // MARK: Style 5: Increase
        "CHLL-5": [
            // 1
            ["timeBased": true as Bool,
             "movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 2
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 3
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 4
            ["movement": "highIntensity" as String,
             "time": 60 as Int],
            ["movement": "lowIntensity" as String,
             "time": 180 as Int],
            // 5
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 6
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 7
            ["movement": "highIntensity" as String,
             "time": 90 as Int],
            ["movement": "lowIntensity" as String,
             "time": 270 as Int],
            // 8
            ["movement": "highIntensity" as String,
             "time": 120 as Int],
            ["movement": "lowIntensity" as String,
             "time": 360 as Int],
        ],
        ] as [String: [[String: Any]]]
    // MARK: -
    // MARK: -
    // MARK: HIIT Bodyweight Workout
    static let CB: [String: [[String: Any]]] = [
        // MARK:-
        // MARK: Easy
        // MARK: Short
        // Cardio, bodyweight, easy, short, 1
        "CBES-1": [
            // Round 1
            ["rounds": 3 as Int,
             "movement": "burpee" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpingJacks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            // Round 2
            ["movement": "burpee" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpingJacks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            // Round 3
            ["movement": "burpee" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "jumpingJacks" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
        ],
        "CBES-2": [
            // Round 1
            ["rounds": 3 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "lungeJump" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "lungeJump" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "lungeJump" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "bumKicks" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
        ],
        "CBES-3": [
            // Round 1
            ["rounds": 3 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "bumKicks" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
        ],
        // MARK: Normal
        "CBEN-1": [
            // Round 1
            ["rounds": 5 as Int,
             "movement": "burpee" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpingJacks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            // Round 2
            ["movement": "burpee" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpingJacks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            // Round 3
            ["movement": "burpee" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpingJacks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            // Round 4
            ["movement": "burpee" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "jumpingJacks" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            // Round 5
            ["movement": "burpee" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "jumpingJacks" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
        ],
        "CBEN-2": [
            // Round 1
            ["rounds": 5 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "lungeJump" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "lungeJump" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "lungeJump" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 4
            ["movement": "mountainClimbers" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "lungeJump" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "bumKicks" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            // Round 5
            ["movement": "mountainClimbers" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "lungeJump" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "bumKicks" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
        ],
        "CBEN-3": [
            // Round 1
            ["rounds": 5 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 4
            ["movement": "mountainClimbers" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "bumKicks" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            // Round 5
            ["movement": "mountainClimbers" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "15s" as String,
             "time": 15 as Int],
            ["movement": "bumKicks" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
        ],
        
        // MARK: -
        // MARK: Average
        // MARK: Short
        "CBAS-1": [
            // Round 1
            ["rounds": 3 as Int,
             "movement": "kickThroughBurpee" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 2
            ["movement": "kickThroughBurpee" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 3
            ["movement": "kickThroughBurpee" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
        ],
        "CBAS-2": [
            // Round 1
            ["rounds": 3 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "lungeJump" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "bumKicks" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "lungeJump" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "bumKicks" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "20" as String,
             "time": 20 as Int],
            ["movement": "lungeJump" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
        ],
        "CBAS-3": [
            // Round 1
            ["rounds": 3 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "bumKicks" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "bumKicks" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
        ],
        // MARK: Normal
        "CBAN-1": [
            // Round 1
            ["rounds": 5 as Int,
             "movement": "kickThroughBurpee" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 2
            ["movement": "kickThroughBurpee" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 3
            ["movement": "kickThroughBurpee" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 4
            ["movement": "kickThroughBurpee" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "20" as String,
             "time": 20 as Int],
            // Round 5
            ["movement": "kickThroughBurpee" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "20" as String,
             "time": 20 as Int],
        ],
        "CBAN-2": [
            // Round 1
            ["rounds": 5 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "lungeJump" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "bumKicks" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "lungeJump" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "bumKicks" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "lungeJump" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "bumKicks" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 4
            ["movement": "mountainClimbers" as String,
             "reps": "20" as String,
             "time": 20 as Int],
            ["movement": "lungeJump" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 5
            ["movement": "mountainClimbers" as String,
             "reps": "20" as String,
             "time": 20 as Int],
            ["movement": "lungeJump" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
        ],
        "CBAN-3": [
            // Round 1
            ["rounds": 5 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "bumKicks" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "bumKicks" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "bumKicks" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 4
            ["movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 5
            ["movement": "mountainClimbers" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "20s" as String,
             "time": 20 as Int],
            ["movement": "bumKicks" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
        ],
        
        // MARK: -
        // MARK: Hard
        // MARK: Short
        "CBHS-1": [
            // Round 1
            ["rounds": 3 as Int,
             "movement": "kickThroughBurpee" as String,
             "reps": "60s" as String,
             "time": 60 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 2
            ["movement": "kickThroughBurpee" as String,
             "reps": "60s" as String,
             "time": 60 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 3
            ["movement": "kickThroughBurpee" as String,
             "reps": "50s" as String,
             "time": 50 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30" as String,
             "time": 30 as Int],
        ],
        "CBHS-2": [
            // Round 1
            ["rounds": 3 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "lungeJump" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "lungeJump" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "30" as String,
             "time": 30 as Int],
            ["movement": "lungeJump" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
        ],
        "CBHS-3": [
            // Round 1
            ["rounds": 3 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
        ],
        // MARK: Normal
        "CBHN-1": [
            // Round 1
            ["rounds": 5 as Int,
             "movement": "kickThroughBurpee" as String,
             "reps": "60s" as String,
             "time": 60 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 2
            ["movement": "kickThroughBurpee" as String,
             "reps": "60s" as String,
             "time": 60 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 3
            ["movement": "kickThroughBurpee" as String,
             "reps": "60s" as String,
             "time": 60 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 4
            ["movement": "kickThroughBurpee" as String,
             "reps": "50s" as String,
             "time": 50 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30" as String,
             "time": 30 as Int],
            // Round 5
            ["movement": "kickThroughBurpee" as String,
             "reps": "50s" as String,
             "time": 50 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30" as String,
             "time": 30 as Int],
        ],
        "CBHN-2": [
            // Round 1
            ["rounds": 5 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "lungeJump" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "lungeJump" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "lungeJump" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 4
            ["movement": "mountainClimbers" as String,
             "reps": "30" as String,
             "time": 30 as Int],
            ["movement": "lungeJump" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 5
            ["movement": "mountainClimbers" as String,
             "reps": "30" as String,
             "time": 30 as Int],
            ["movement": "lungeJump" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
        ],
        "CBHN-3": [
            // Round 1
            ["rounds": 5 as Int,
             "movement": "mountainClimbers" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 2
            ["movement": "mountainClimbers" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 3
            ["movement": "mountainClimbers" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "40s" as String,
             "time": 40 as Int],
            // Round 4
            ["movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            // Round 5
            ["movement": "mountainClimbers" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "jumpSquat" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
            ["movement": "kneeRaises" as String,
             "reps": "30s" as String,
             "time": 30 as Int],
        ],
        ] as [String: [[String: Any]]]
}
