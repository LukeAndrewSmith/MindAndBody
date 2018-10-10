//
//  SuggestedWeights.swift
//  MindAndBody
//
//  Created by Luke Smith on 05.05.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation


extension Register {
    // Note saved as index for weight array, weight array goes from 0 to 300kg, in steps of 2.5
    // Conversion of index to weight is index * 2.5
    // This means no conversion necessary for pounds, simply same in array
    // --------------------------------------------------------
    // MARK:- Weighted Movements
    // MARK: Women
    // Level 1
    // W - weight, R - register, M - Metric, W - Women, L - Lower, 1 - level 1
    static let WRWL1: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 12,
            "frontSquat": 12,
            "legPress": 16,
            "dumbellFrontSquat": 4,
            "legExtensions": 6,
            // Legs (Hamstrings/Glutes)
            "deadlift": 12,
            "romanianDeadlift": 2,
            "weightedHipThrust": 8,
            "legCurl": 6,
            "oneLeggedDeadlift": 2,
            // Legs (General)
            "lungeDumbell": 2,
            "bulgarianSplitSquat": 2,
            "weightedStepUp": 2,
            // Legs (calves)
            "standingCalfRaise": 8,
            "seatedCalfRaise": 8,
        ]
    static let WRWU1: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 6,
            "kneelingPullDown": 3,
            "bentOverRowDumbell": 2,
            "tBarRow": 3,
            "rowMachine": 8,
            "latPullover": 2,
            // Pull (Upper Back)
            "facePull": 2,
            "leaningBackPullDown": 3,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 3,
            // Pull (Traps)
            "shrugDumbell": 4,
            // Pull (Biceps)
            "hammerCurl": 1,
            "hammerCurlCable": 1,
            "curl": 1,
            // Pull (Forearms)
            "farmersCarry": 2,
            "reverseBarbellCurl": 4,
            // Push (Chest) ---------
            "benchPress": 4,
            "benchPressDumbell": 1,
            "semiInclineDumbellPress": 1,
            "platePress": 2,
            "barbellKneelingPress": 2,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 2,
            "standingShoulderPressDumbell": 1,
            "lateralRaise": 1,
            "frontRaise": 1,
            // Push (Triceps) //
            "closeGripBench": 4,
            "cableExtension": 1,
            "ropeExtension": 3,
            // Full Body ---------
            "cleanPress": 4,
        ]
    // Level 2
    static let WRWL2: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 16,
            "frontSquat": 14,
            "legPress": 20,
            "dumbellFrontSquat": 6,
            "legExtensions": 8,
            // Legs (Hamstrings/Glutes)
            "deadlift": 16,
            "romanianDeadlift": 4,
            "weightedHipThrust": 12,
            "legCurl": 6,
            "oneLeggedDeadlift": 3,
            // Legs (General)
            "lungeDumbell": 3,
            "bulgarianSplitSquat": 3,
            "weightedStepUp": 3,
            // Legs (calves)
            "standingCalfRaise": 12,
            "seatedCalfRaise": 12,
        ]
    static let WRWU2: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 8,
            "kneelingPullDown": 4,
            "bentOverRowDumbell": 3,
            "tBarRow": 4,
            "rowMachine": 10,
            "latPullover": 3,
            // Pull (Upper Back)
            "facePull": 3,
            "leaningBackPullDown": 4,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 5,
            // Pull (Traps)
            "shrugDumbell": 5,
            // Pull (Biceps)
            "hammerCurl": 2,
            "hammerCurlCable": 2,
            "curl": 2,
            // Pull (Forearms)
            "farmersCarry": 3,
            "reverseBarbellCurl": 5,
            // Push (Chest) ---------
            "benchPress": 6,
            "benchPressDumbell": 2,
            "semiInclineDumbellPress": 2,
            "platePress": 2,
            "barbellKneelingPress": 3,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 4,
            "standingShoulderPressDumbell": 2,
            "lateralRaise": 2,
            "frontRaise": 2,
            // Push (Triceps) //
            "closeGripBench": 5,
            "cableExtension": 2,
            "ropeExtension": 4,
            // Full Body ---------
            "cleanPress": 6,
        ]
    // Level 3
    static let WRWL3: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 20,
            "frontSquat": 16,
            "legPress": 24,
            "dumbellFrontSquat": 8,
            "legExtensions": 10,
            // Legs (Hamstrings/Glutes)
            "deadlift": 20,
            "romanianDeadlift": 6,
            "weightedHipThrust": 16,
            "legCurl": 8,
            "oneLeggedDeadlift": 4,
            // Legs (General)
            "lungeDumbell": 4,
            "bulgarianSplitSquat": 4,
            "weightedStepUp": 4,
            // Legs (calves)
            "standingCalfRaise": 16,
            "seatedCalfRaise": 16,
        ]
    static let WRWU3: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 10,
            "kneelingPullDown": 6,
            "bentOverRowDumbell": 4,
            "tBarRow": 5,
            "rowMachine": 12,
            "latPullover": 4,
            // Pull (Upper Back)
            "facePull": 3,
            "leaningBackPullDown": 6,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 6,
            // Pull (Traps)
            "shrugDumbell": 6,
            // Pull (Biceps)
            "hammerCurl": 3,
            "hammerCurlCable": 3,
            "curl": 3,
            // Pull (Forearms)
            "farmersCarry": 4,
            "reverseBarbellCurl": 6,
            // Push (Chest) ---------
            "benchPress": 8,
            "benchPressDumbell": 3,
            "semiInclineDumbellPress": 3,
            "platePress": 4,
            "barbellKneelingPress": 4,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 6,
            "standingShoulderPressDumbell": 3,
            "lateralRaise": 3,
            "frontRaise": 3,
            // Push (Triceps) //
            "closeGripBench": 6,
            "cableExtension": 3,
            "ropeExtension": 6,
            // Full Body ---------
            "cleanPress": 8,
        ]
    // MARK: Men
    // Level 1
    static let WRML1: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 12,
            "frontSquat": 12,
            "legPress": 16,
            "dumbellFrontSquat": 4,
            "legExtensions": 6,
            // Legs (Hamstrings/Glutes)
            "deadlift": 12,
            "romanianDeadlift": 2,
            "weightedHipThrust": 8,
            "legCurl": 6,
            "oneLeggedDeadlift": 2,
            // Legs (General)
            "lungeDumbell": 2,
            "bulgarianSplitSquat": 2,
            "weightedStepUp": 2,
            // Legs (calves)
            "standingCalfRaise": 8,
            "seatedCalfRaise": 8,
            ]
    static let WRMU1: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 8,
            "kneelingPullDown": 4,
            "bentOverRowDumbell": 3,
            "tBarRow": 4,
            "rowMachine": 10,
            "latPullover": 3,
            // Pull (Upper Back)
            "facePull": 3,
            "leaningBackPullDown": 4,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 5,
            // Pull (Traps)
            "shrugDumbell": 5,
            // Pull (Biceps)
            "hammerCurl": 2,
            "hammerCurlCable": 2,
            "curl": 2,
            // Pull (Forearms)
            "farmersCarry": 3,
            "reverseBarbellCurl": 5,
            // Push (Chest) ---------
            "benchPress": 6,
            "benchPressDumbell": 2,
            "semiInclineDumbellPress": 2,
            "platePress": 2,
            "barbellKneelingPress": 3,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 4,
            "standingShoulderPressDumbell": 2,
            "lateralRaise": 2,
            "frontRaise": 2,
            // Push (Triceps) //
            "closeGripBench": 5,
            "cableExtension": 2,
            "ropeExtension": 4,
            // Full Body ---------
            "cleanPress": 6,
        ]
    // Level 2
    static let WRML2: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 16,
            "frontSquat": 14,
            "legPress": 20,
            "dumbellFrontSquat": 6,
            "legExtensions": 6,
            // Legs (Hamstrings/Glutes)
            "deadlift": 16,
            "romanianDeadlift": 4,
            "weightedHipThrust": 12,
            "legCurl": 6,
            "oneLeggedDeadlift": 3,
            // Legs (General)
            "lungeDumbell": 4,
            "bulgarianSplitSquat": 4,
            "weightedStepUp": 4,
            // Legs (calves)
            "standingCalfRaise": 12,
            "seatedCalfRaise": 12,
        ]
    static let WRMU2: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 12,
            "kneelingPullDown": 8,
            "bentOverRowDumbell": 5,
            "tBarRow": 6,
            "rowMachine": 16,
            "latPullover": 4,
            // Pull (Upper Back)
            "facePull": 4,
            "leaningBackPullDown": 6,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 6,
            // Pull (Traps)
            "shrugDumbell": 6,
            // Pull (Biceps)
            "hammerCurl": 3,
            "hammerCurlCable": 3,
            "curl": 3,
            // Pull (Forearms)
            "farmersCarry": 4,
            "reverseBarbellCurl": 6,
            // Push (Chest) ---------
            "benchPress": 12,
            "benchPressDumbell": 4,
            "semiInclineDumbellPress": 4,
            "platePress": 4,
            "barbellKneelingPress": 4,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 6,
            "standingShoulderPressDumbell": 3,
            "lateralRaise": 3,
            "frontRaise": 3,
            // Push (Triceps) //
            "closeGripBench": 8,
            "cableExtension": 3,
            "ropeExtension": 6,
            // Full Body ---------
            "cleanPress": 8,
        ]
    // Level 3
    static let WRML3: [String: Int] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            "squat": 20,
            "frontSquat": 16,
            "legPress": 24,
            "dumbellFrontSquat": 6,
            "legExtensions": 8,
            // Legs (Hamstrings/Glutes)
            "deadlift": 20,
            "romanianDeadlift": 6,
            "weightedHipThrust": 16,
            "legCurl": 8,
            "oneLeggedDeadlift": 4,
            // Legs (General)
            "lungeDumbell": 6,
            "bulgarianSplitSquat": 6,
            "weightedStepUp": 6,
            // Legs (calves)
            "standingCalfRaise": 16,
            "seatedCalfRaise": 16,
            ]
    static let WRMU3: [String: Int] =
        [
            // Pull (Back) ---------
            "pullDown": 16,
            "kneelingPullDown": 10,
            "bentOverRowDumbell": 6,
            "tBarRow": 10,
            "rowMachine": 20,
            "latPullover": 6,
            // Pull (Upper Back)
            "facePull": 5,
            "leaningBackPullDown": 8,
            // Pull (Rear Delts)
            "bentOverBarbellRow": 8,
            // Pull (Traps)
            "shrugDumbell": 8,
            // Pull (Biceps)
            "hammerCurl": 4,
            "hammerCurlCable": 4,
            "curl": 4,
            // Pull (Forearms)
            "farmersCarry": 6,
            "reverseBarbellCurl": 8,
            // Push (Chest) ---------
            "benchPress": 16,
            "benchPressDumbell": 6,
            "semiInclineDumbellPress": 6,
            "platePress": 6,
            "barbellKneelingPress": 6,
            // Push (Shoulders)
            "standingShoulderPressBarbell": 8,
            "standingShoulderPressDumbell": 4,
            "lateralRaise": 4,
            "frontRaise": 4,
            // Push (Triceps) //
            "closeGripBench": 12,
            "cableExtension": 4,
            "ropeExtension": 8,
            // Full Body ---------
            "cleanPress": 12,
        ]
    
    static let weightRegister = { () -> [String : Int] in
        let weightDictUpper = Register.WRWL1
        let weightDict = weightDictUpper.merging(Register.WRWU1) { (current, _) in current }
        return weightDict
    }
}
