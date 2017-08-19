//
//  WorkoutChoieFinal.swift
//  MindAndBody
//
//  Created by Luke Smith on 19.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Workout Choice Class -------------------------------------------------------------------------------------------------------------
//
class WorkoutChoiceFinal: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Selected Workout Type
    //
    // Gym (0), Gym Circuit (1), Bodyweight (2), Bodyweight Circuit (3)
    var workoutType = Int()
    // Full Body (0), Upper (1), Lower (2), Legs (3), Pull (4), Push (5)
    var workoutType2 = Int()
    
    // Selected Preset
    //
    var selectedPreset: [Int] = [0, 0]
    
    // Section Numbers
    //
    var sectionNumbers: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    
    //
    // Arrays ------------------------------------------------------------------------------------------------------------------------------
    //
    //
    var overviewArray: [[Int]] = []
    
    var roundArray: [Int] = []
    
    
    //
    // Set depending on which choices chosen (e.g gym - classic - full body)
    //
    // Picker View Array
    var presetsArray: [[String]] = []
    //
    var presetsArrays: [[[Int]]] = []
    
    
    // Arrays to Use
    //
    // Sets Array
    var presetSetsArray: [[[Int]]] = []

    // Reps Array
    var presetRepsArray: [[[String]]] = []
    
    //
    var presetRepsArrayCircuit: [[[[String]]]] = []
    
    //
    var numberOfRoundsArray: [[Int]] = []


    
    
    // Arrays to be set and used (Screen arrays)
    //
    // Movements Array
    var workoutArray: [String] = []
    
    // Sets Array
    var setsArray: [Int] = []
    
    // Reps Array
    var repsArray: [String] = []
    var repsArrayCircuit: [[String]] = []
    
    // Demonstration Array
    var demonstrationArray: [[UIImage]] = []
    
    // Target Area Array
    var targetAreaArray: [UIImage] = []
    
    // Explanation Array
    var explanationArray: [String] = []
    
    //
    // Navigation Titles
    let navigationTitles: [String] =
        ["fullBody",
         "upperBody",
         "lowerBody",
         "cardio"]
    
    
//
// Gym Classic + 5x5 --------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------------------------
    // TableView Section Array
    var tableViewSectionArray: [String] =
        [
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
            "pushS",
            "coreAbs",
            // General
            "generalC",
            "generalF",
            "generalU",
            "cardio",
            // Isometric
            "isometricL",
            "isometricC",
            // Equiptment
            "equiptmentB",
            "equiptmentBa",
            "equiptmentBe"
    ]
    
    // Full Key Array
    var fullKeyArray: [[Int]] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            [0,
            1,
            2,
            3,
            4],
            // Legs (Hamstrings/Glutes)
            [5,
            6,
            7,
            8,
            9,
            10],
            // Legs (General)
            [11,
            12,
            13],
            // Legs (Calves)
            [14,
            15],
            // Pull (Back) ---------
            [16,
            17,
            18,
            19,
            20,
            21,
            22,
            23],
            // Pull (Upper Back)
            [24,
            25],
            // Pull (Rear Delts)
            [26],
            // Pull (Traps)
            [27],
            // Pull (Biceps)
            [28,
            29,
            30],
            // Pull (Forearms)
            [31,
            32,
            33],
            // Push (Chest) ---------
            [34,
            35,
            36,
            37,
            38,
            39,
            40,
            41],
            // Push (Shoulders)
            [42,
            43,
            44,
            45],
            // Push (Triceps)
            [46,                //!!!!!!!!
            47,
            48],
            // Full Body ---------
            [49],
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            [50,
            51,
            52,
            53,
            54,
            55,
            56],
            // Legs (Hamstrings)
            [57,
            58],
            // Legs (Glutes)
            [59,
            60,
            61,
            62],
            // Legs (Calves)
            [63],
            // Pull (Back) ---------
            [64,
            65,
            66,
            67,
            68,
            69],
            // Pull (Traps)
            [70],
            // Push (Chest) ---------
            [71],
            // Push (Tricep)
            [72,
            73,
            74],
            // Push (Chest & Tricep)
            [75],
            // Push (Shoulder)
            [76,
            77,
            78,
            79],
            // Core ---------
            [80,
            81,
            82,
            83,
            84,
            85,
            86,
            87,
            88],
            // General (Core) ---------
            [89],
            // General (Full Body)
            [90,
            91],
            // General (Upper Body)
            [92,
            93],
            // General (Cardio)
            [94,
            95,
            96,
            97],
            // Isometric (Legs) ---------
            [98,
            99,
            100],
            // Isometric (Upper Body)
            [101,
            102,
            103],
            // Equiptment (Ball) ---------
            [104],
            // Equiptment (Bar)
            [105,
            106,
            107],
            // Equiptment (Bench/Step)
            [108,
            109,
            110,
            111,
            112]
    ]
    
    // Workout Movements Dictionary
    var workoutMovementsDictionary: [Int : String] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            0: "squat",
            1: "frontSquat",
            2: "legPress",
            3: "dumbellFrontSquat",
            4: "legExtensions",
            // Legs (Hamstrings/Glutes)
            5: "deadlift",
            6: "romanianDeadlift",
            7: "weightedHipThrust",
            8: "legCurl",
            9: "oneLeggedDeadlift",
            10: "gluteIsolationMachine",
            // Legs (General)
            11: "lungeDumbell",
            12: "bulgarianSplitSquat",
            13: "weightedStepUp",
            // Legs (Calves)
            14: "standingCalfRaise",
            15: "seatedCalfRaise",
            // Pull (Back) ---------
            16: "pullDown",
            17: "kneelingPullDown",
            18: "pullDownMachine",
            19: "bentOverRowBarbell",
            20: "bentOverRowDumbell",
            21: "tBarRow",
            22: "rowMachine",
            23: "latPullover",
            // Pull (Upper Back)
            24: "facePull",
            25: "leaningBackPullDown",
            // Pull (Rear Delts)
            26: "bentOverBarbellRow",
            // Pull (Traps)
            27: "shrugDumbell",
            // Pull (Biceps)
            28: "hammerCurl",
            29: "hammerCurlCable",
            30: "curl",
            // Pull (Forearms)
            31: "farmersCarry",
            32: "reverseBarbellCurl",
            33: "forearmCurl",
            // Push (Chest) ---------
            34: "benchPress",
            35: "benchPressDumbell",
            36: "semiInclineDumbellPress",
            37: "chestPress",
            38: "platePress",
            39: "barbellKneelingPress",
            40: "cableFly",
            41: "dips",
            // Push (Shoulders)
            42: "standingShoulderPressBarbell",
            43: "standingShoulderPressDumbell",
            44: "lateralRaise",
            45: "frontRaise",
            // Push (Triceps)
            46: "closeGripBench",
            47: "cableExtension",
            48: "ropeExtension",
            // Full Body
            49: "cleanPress",
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            50: "bodyweightSquat",
            51: "pistolSquat",
            52: "skaterSquat",
            53: "squatJump",
            54: "sumoSquat",
            55: "lunge",
            56: "lungeJump",
            // Legs (Hamstrings)
            57: "deadlift",
            58: "singleLegDeadlift",
            // Legs (Glutes)
            59: "gluteBridge",
            60: "singleLegGluteBridge",
            61: "kickBack",
            62: "standingKickBack",
            // Legs (Calves)
            63: "calfRaise",
            // Pull (Back) ---------
            64: "contralateralLimbRaises",
            65: "superMan",
            66: "backHyperextension",
            67: "doorFrameRow",
            68: "reverseSnowAngels",
            69: "scapulaPushup",
            // Pull (Traps)
            70: "handStandTrap",
            // Push (Chest) ---------
            71: "pushup",
            // Push (Tricep)
            72: "trianglePushup",
            73: "dolphinPushup",
            74: "tricepExtensionsBodyweight",
            // Push (Chest & Tricep)
            75: "walkingPushup",
            // Push (Shoulder)
            76: "downwardDogPushup",
            77: "wallPushup",
            78: "boxer",
            79: "armCircles",
            // Core ---------
            80: "plank",
            81: "dynamicPlank",
            82: "sidePlank",
            83: "pushupPlank",
            84: "lSit",
            85: "bicycleCrunch",
            86: "divingHold",
            87: "hipRaise",
            88: "legHold",
            // General (Core) ---------
            89: "mountainClimbers",
            // General (Full Body)
            90: "burpee",
            91: "kickThroughBurpee",
            // General (Upper Body)
            92: "spiderPushup",
            93: "crabWalk",
            // General (Cardio)
            94: "jumpingJacks",
            95: "tuckJump",
            96: "bumKicks",
            97: "kneeRaises",
            // Isometric (Legs) ---------
            98: "wallSit",
            99: "toePress",
            100: "staticLunge",
            // Isometric (Upper Body)
            101: "chestSqueeze",
            102: "pushupHold",
            103: "pullupHold",
            // Equiptment (Ball) ---------
            104: "ballPushup",
            // Equiptment (Bar)
            105: "bodweightRow",
            106: "pullup",
            107: "hangingLegRaise",
            // Equiptment (Bench/Step)
            108: "tricepDip",
            109: "bulgarianSplitSquat",
            110: "boxJump",
            111: "hipThrusts",
            112: "stepUp"
    ]
    
    // Demonstration Array
    var demonstrationDictionary: [Int : [UIImage]] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            0: [#imageLiteral(resourceName: "squat"), #imageLiteral(resourceName: "squat1"), #imageLiteral(resourceName: "squat2"), #imageLiteral(resourceName: "squat3"), #imageLiteral(resourceName: "squat2"), #imageLiteral(resourceName: "squat1")],
            1: [#imageLiteral(resourceName: "frontSquat"), #imageLiteral(resourceName: "frontSquat1"), #imageLiteral(resourceName: "frontSquat2"), #imageLiteral(resourceName: "frontSquat3"), #imageLiteral(resourceName: "frontSquat2"), #imageLiteral(resourceName: "frontSquat1")],
            2: [#imageLiteral(resourceName: "legPress"), #imageLiteral(resourceName: "legPress4"), #imageLiteral(resourceName: "legPress3"), #imageLiteral(resourceName: "legPress2"), #imageLiteral(resourceName: "legPress1"), #imageLiteral(resourceName: "legPress2"), #imageLiteral(resourceName: "legPress3"), #imageLiteral(resourceName: "legPress4")],
            3: [#imageLiteral(resourceName: "dumbellFrontSquat"), #imageLiteral(resourceName: "dumbellFrontSquat1"), #imageLiteral(resourceName: "dumbellFrontSquat"), #imageLiteral(resourceName: "dumbellFrontSquat1")],
            4: [#imageLiteral(resourceName: "legExtensions"), #imageLiteral(resourceName: "legExtensions1"), #imageLiteral(resourceName: "legExtensions2"), #imageLiteral(resourceName: "legExtensions3"), #imageLiteral(resourceName: "legExtensions2"), #imageLiteral(resourceName: "legExtensions1")],
            // Legs (Hamstrings/Glutes)
            5: [#imageLiteral(resourceName: "deadlift"), #imageLiteral(resourceName: "deadlift1"), #imageLiteral(resourceName: "deadlift2"), #imageLiteral(resourceName: "deadlift3"), #imageLiteral(resourceName: "deadlift4"), #imageLiteral(resourceName: "deadlift5"), #imageLiteral(resourceName: "deadlift6"), #imageLiteral(resourceName: "deadlift7"), #imageLiteral(resourceName: "deadlift4"), #imageLiteral(resourceName: "deadlift2")],
            6: [#imageLiteral(resourceName: "romanianDeadlift"), #imageLiteral(resourceName: "romanianDeadlift1"), #imageLiteral(resourceName: "romanianDeadlift2"), #imageLiteral(resourceName: "romanianDeadlift3"), #imageLiteral(resourceName: "romanianDeadlift2"), #imageLiteral(resourceName: "romanianDeadlift1")],
            7: [#imageLiteral(resourceName: "weightedHipThrust"), #imageLiteral(resourceName: "weightedHipThrust1"), #imageLiteral(resourceName: "weightedHipThrust"), #imageLiteral(resourceName: "weightedHipThrust1")],
            8: [#imageLiteral(resourceName: "legCurl"), #imageLiteral(resourceName: "legCurl1"), #imageLiteral(resourceName: "legCurl2"), #imageLiteral(resourceName: "legCurl3"), #imageLiteral(resourceName: "legCurl2"), #imageLiteral(resourceName: "legCurl1")],
            9: [#imageLiteral(resourceName: "oneLeggedDeadlift"), #imageLiteral(resourceName: "oneLeggedDeadlift1"), #imageLiteral(resourceName: "oneLeggedDeadlift2"), #imageLiteral(resourceName: "oneLeggedDeadlift3"), #imageLiteral(resourceName: "oneLeggedDeadlift4"), #imageLiteral(resourceName: "oneLeggedDeadlift3"), #imageLiteral(resourceName: "oneLeggedDeadlift2"), #imageLiteral(resourceName: "oneLeggedDeadlift1")],
            10: [#imageLiteral(resourceName: "gluteIsolationMachine"), #imageLiteral(resourceName: "gluteIsolationMachine1"), #imageLiteral(resourceName: "gluteIsolationMachine"), #imageLiteral(resourceName: "gluteIsolationMachine1")],
            // Legs (General)
            11: [#imageLiteral(resourceName: "lungeDumbell"), #imageLiteral(resourceName: "lungeDumbell1"), #imageLiteral(resourceName: "lungeDumbell2"), #imageLiteral(resourceName: "lungeDumbell3"), #imageLiteral(resourceName: "lungeDumbell4"), #imageLiteral(resourceName: "lungeDumbell5"), #imageLiteral(resourceName: "lungeDumbell6"), #imageLiteral(resourceName: "lungeDumbell7"), #imageLiteral(resourceName: "lungeDumbell1"), #imageLiteral(resourceName: "lungeDumbell8"), #imageLiteral(resourceName: "lungeDumbell9"), #imageLiteral(resourceName: "lungeDumbell10"), #imageLiteral(resourceName: "lungeDumbell11"), #imageLiteral(resourceName: "lungeDumbell12"), #imageLiteral(resourceName: "lungeDumbell13"), #imageLiteral(resourceName: "lungeDumbell1")],
            12: [#imageLiteral(resourceName: "bulgarianSplitSquat"), #imageLiteral(resourceName: "bulgarianSplitSquat1"), #imageLiteral(resourceName: "bulgarianSplitSquat"), #imageLiteral(resourceName: "bulgarianSplitSquat1")],
            13: [#imageLiteral(resourceName: "stepUp"), #imageLiteral(resourceName: "stepUp1"), #imageLiteral(resourceName: "stepUp2"), #imageLiteral(resourceName: "stepUp3"), #imageLiteral(resourceName: "stepUp2"), #imageLiteral(resourceName: "stepUp1")],
            // Legs (Calves)
            14: [#imageLiteral(resourceName: "standingCalfRaise"), #imageLiteral(resourceName: "standingCalfRaise1"), #imageLiteral(resourceName: "standingCalfRaise"), #imageLiteral(resourceName: "standingCalfRaise1")],
            15: [#imageLiteral(resourceName: "seatedCalfRaise"), #imageLiteral(resourceName: "seatedCalfRaise1"), #imageLiteral(resourceName: "seatedCalfRaise"), #imageLiteral(resourceName: "seatedCalfRaise1")],
            // Pull (Back) ---------
            16: [#imageLiteral(resourceName: "pullDown"), #imageLiteral(resourceName: "pullDown1"), #imageLiteral(resourceName: "pullDown2"), #imageLiteral(resourceName: "pullDown3"), #imageLiteral(resourceName: "pullDown4"), #imageLiteral(resourceName: "pullDown5"), #imageLiteral(resourceName: "pullDown5"), #imageLiteral(resourceName: "pullDown4"), #imageLiteral(resourceName: "pullDown3"), #imageLiteral(resourceName: "pullDown2"), #imageLiteral(resourceName: "pullDown1")],
            17: [#imageLiteral(resourceName: "kneelingPullDown"), #imageLiteral(resourceName: "kneelingPullDown1"), #imageLiteral(resourceName: "kneelingPullDown2"), #imageLiteral(resourceName: "kneelingPullDown3"), #imageLiteral(resourceName: "kneelingPullDown4"), #imageLiteral(resourceName: "kneelingPullDown4"), #imageLiteral(resourceName: "kneelingPullDown3"), #imageLiteral(resourceName: "kneelingPullDown2"), #imageLiteral(resourceName: "kneelingPullDown1")],
            18: [#imageLiteral(resourceName: "pullDownMachine"), #imageLiteral(resourceName: "pullDownMachine1"), #imageLiteral(resourceName: "pullDownMachine"), #imageLiteral(resourceName: "pullDownMachine1")],
            19: [#imageLiteral(resourceName: "bentOverBarbellRow"), #imageLiteral(resourceName: "bentOverBarbellRow1"), #imageLiteral(resourceName: "bentOverBarbellRow"), #imageLiteral(resourceName: "bentOverBarbellRow1")],
            20: [#imageLiteral(resourceName: "bentOverRowDumbell"), #imageLiteral(resourceName: "bentOverRowDumbell1"), #imageLiteral(resourceName: "bentOverRowDumbell2"), #imageLiteral(resourceName: "bentOverRowDumbell3"), #imageLiteral(resourceName: "bentOverRowDumbell4"), #imageLiteral(resourceName: "bentOverRowDumbell5"), #imageLiteral(resourceName: "bentOverRowDumbell5"), #imageLiteral(resourceName: "bentOverRowDumbell4"), #imageLiteral(resourceName: "bentOverRowDumbell3"), #imageLiteral(resourceName: "bentOverRowDumbell2")],
            21: [#imageLiteral(resourceName: "tBarRow"), #imageLiteral(resourceName: "tBarRow1"), #imageLiteral(resourceName: "tBarRow2"), #imageLiteral(resourceName: "tBarRow3"), #imageLiteral(resourceName: "tBarRow4"), #imageLiteral(resourceName: "tBarRow4"), #imageLiteral(resourceName: "tBarRow3"), #imageLiteral(resourceName: "tBarRow2"), #imageLiteral(resourceName: "tBarRow1")],
            22: [#imageLiteral(resourceName: "rowMachine"), #imageLiteral(resourceName: "rowMachine1"), #imageLiteral(resourceName: "rowMachine2"), #imageLiteral(resourceName: "rowMachine3"), #imageLiteral(resourceName: "rowMachine4"), #imageLiteral(resourceName: "rowMachine4"), #imageLiteral(resourceName: "rowMachine3"), #imageLiteral(resourceName: "rowMachine2"), #imageLiteral(resourceName: "rowMachine1")],
            23: [#imageLiteral(resourceName: "latPullover"), #imageLiteral(resourceName: "latPullover1"), #imageLiteral(resourceName: "latPullover2"), #imageLiteral(resourceName: "latPullover3"), #imageLiteral(resourceName: "latPullover3"), #imageLiteral(resourceName: "latPullover2"), #imageLiteral(resourceName: "latPullover1")],
            // Pull (Upper Back)
            24: [#imageLiteral(resourceName: "facePull"), #imageLiteral(resourceName: "facePull1"), #imageLiteral(resourceName: "facePull2"), #imageLiteral(resourceName: "facePull3"), #imageLiteral(resourceName: "facePull4"), #imageLiteral(resourceName: "facePull5"), #imageLiteral(resourceName: "facePull5"), #imageLiteral(resourceName: "facePull4"), #imageLiteral(resourceName: "facePull3"), #imageLiteral(resourceName: "facePull2"), #imageLiteral(resourceName: "facePull1")],
            25: [#imageLiteral(resourceName: "leaningBackPullDown"), #imageLiteral(resourceName: "leaningBackPullDown1"), #imageLiteral(resourceName: "leaningBackPullDown2"), #imageLiteral(resourceName: "leaningBackPullDown3"), #imageLiteral(resourceName: "leaningBackPullDown4"), #imageLiteral(resourceName: "leaningBackPullDown4"), #imageLiteral(resourceName: "leaningBackPullDown3"), #imageLiteral(resourceName: "leaningBackPullDown2"), #imageLiteral(resourceName: "leaningBackPullDown1")],
            // Pull (Rear Delts)
            26: [#imageLiteral(resourceName: "bentOverBarbellRow"), #imageLiteral(resourceName: "bentOverBarbellRow1"), #imageLiteral(resourceName: "bentOverBarbellRow"), #imageLiteral(resourceName: "bentOverBarbellRow1")],
            // Pull (Traps)
            27: [#imageLiteral(resourceName: "shrugDumbell"), #imageLiteral(resourceName: "shrugDumbell1"), #imageLiteral(resourceName: "shrugDumbell"), #imageLiteral(resourceName: "shrugDumbell1")],
            // Pull (Biceps)
            28: [#imageLiteral(resourceName: "hammerCurl"), #imageLiteral(resourceName: "hammerCurl1"), #imageLiteral(resourceName: "hammerCurl2"), #imageLiteral(resourceName: "hammerCurl3"), #imageLiteral(resourceName: "hammerCurl3"), #imageLiteral(resourceName: "hammerCurl2"), #imageLiteral(resourceName: "hammerCurl1"), #imageLiteral(resourceName: "hammerCurl4"), #imageLiteral(resourceName: "hammerCurl5"), #imageLiteral(resourceName: "hammerCurl5"), #imageLiteral(resourceName: "hammerCurl4"), #imageLiteral(resourceName: "hammerCurl1")],
            29: [#imageLiteral(resourceName: "hammerCurlCable"), #imageLiteral(resourceName: "hammerCurlCable1"), #imageLiteral(resourceName: "hammerCurlCable2"), #imageLiteral(resourceName: "hammerCurlCable3"), #imageLiteral(resourceName: "hammerCurlCable3"), #imageLiteral(resourceName: "hammerCurlCable2"), #imageLiteral(resourceName: "hammerCurlCable1")],
            30: [#imageLiteral(resourceName: "curl"), #imageLiteral(resourceName: "curl1"), #imageLiteral(resourceName: "curl2"), #imageLiteral(resourceName: "curl3"), #imageLiteral(resourceName: "curl3"), #imageLiteral(resourceName: "curl2"), #imageLiteral(resourceName: "curl1"), #imageLiteral(resourceName: "curl4"), #imageLiteral(resourceName: "curl5"), #imageLiteral(resourceName: "curl5"), #imageLiteral(resourceName: "curl4"), #imageLiteral(resourceName: "curl1")],
            // Pull (Forearms)
            31: [#imageLiteral(resourceName: "farmersCarry")],
            32: [#imageLiteral(resourceName: "reverseBarbellCurl"), #imageLiteral(resourceName: "reverseBarbellCurl1"), #imageLiteral(resourceName: "reverseBarbellCurl"), #imageLiteral(resourceName: "reverseBarbellCurl1")],
            33: [#imageLiteral(resourceName: "forearmCurl"), #imageLiteral(resourceName: "forearmCurl1"), #imageLiteral(resourceName: "forearmCurl2"), #imageLiteral(resourceName: "forearmCurl1"), #imageLiteral(resourceName: "forearmCurl"), #imageLiteral(resourceName: "forearmCurl"), #imageLiteral(resourceName: "forearmCurl1"), #imageLiteral(resourceName: "forearmCurl2"), #imageLiteral(resourceName: "forearmCurl1")],
            // Push (Chest) ---------
            34: [#imageLiteral(resourceName: "benchPress"), #imageLiteral(resourceName: "benchPress1"), #imageLiteral(resourceName: "benchPress2"), #imageLiteral(resourceName: "benchPress3"), #imageLiteral(resourceName: "benchPress4"), #imageLiteral(resourceName: "benchPress5"), #imageLiteral(resourceName: "benchPress5"), #imageLiteral(resourceName: "benchPress4"), #imageLiteral(resourceName: "benchPress3"), #imageLiteral(resourceName: "benchPress2")],
            35: [#imageLiteral(resourceName: "benchPressDumbell"), #imageLiteral(resourceName: "benchPressDumbell4"), #imageLiteral(resourceName: "benchPressDumbell3"), #imageLiteral(resourceName: "benchPressDumbell2"), #imageLiteral(resourceName: "benchPressDumbell1"), #imageLiteral(resourceName: "benchPressDumbell1"), #imageLiteral(resourceName: "benchPressDumbell2"), #imageLiteral(resourceName: "benchPressDumbell3"), #imageLiteral(resourceName: "benchPressDumbell4")],
            36: [#imageLiteral(resourceName: "semiInclineDumbellPress"), #imageLiteral(resourceName: "semiInclineDumbellPress4"), #imageLiteral(resourceName: "semiInclineDumbellPress3"), #imageLiteral(resourceName: "semiInclineDumbellPress2"), #imageLiteral(resourceName: "semiInclineDumbellPress1"), #imageLiteral(resourceName: "semiInclineDumbellPress1"), #imageLiteral(resourceName: "semiInclineDumbellPress2"), #imageLiteral(resourceName: "semiInclineDumbellPress3"), #imageLiteral(resourceName: "semiInclineDumbellPress4")],
            37: [#imageLiteral(resourceName: "chestPress"), #imageLiteral(resourceName: "chestPress1"), #imageLiteral(resourceName: "chestPress"), #imageLiteral(resourceName: "chestPress1")],
            38: [#imageLiteral(resourceName: "platePress"), #imageLiteral(resourceName: "platePress1"), #imageLiteral(resourceName: "platePress"), #imageLiteral(resourceName: "platePress1")],
            39: [#imageLiteral(resourceName: "barbellKneelingPress"), #imageLiteral(resourceName: "barbellKneelingPress1"), #imageLiteral(resourceName: "barbellKneelingPress"), #imageLiteral(resourceName: "barbellKneelingPress1")],
            40: [#imageLiteral(resourceName: "cableFly"), #imageLiteral(resourceName: "cableFly1"), #imageLiteral(resourceName: "cableFly2"), #imageLiteral(resourceName: "cableFly3"), #imageLiteral(resourceName: "cableFly4"), #imageLiteral(resourceName: "cableFly3"), #imageLiteral(resourceName: "cableFly2"), #imageLiteral(resourceName: "cableFly1"), #imageLiteral(resourceName: "cableFly1")],
            41: [#imageLiteral(resourceName: "dips"), #imageLiteral(resourceName: "dips1"), #imageLiteral(resourceName: "dips"), #imageLiteral(resourceName: "dips1")],
            // Push (Shoulders)
            42: [#imageLiteral(resourceName: "standingShoulderPressBarbell"), #imageLiteral(resourceName: "standingShoulderPressBarbell1"), #imageLiteral(resourceName: "standingShoulderPressBarbell2"), #imageLiteral(resourceName: "standingShoulderPressBarbell2"), #imageLiteral(resourceName: "standingShoulderPressBarbell1")],
            43: [#imageLiteral(resourceName: "standingShoulderPressDumbell"), #imageLiteral(resourceName: "standingShoulderPressDumbell1"), #imageLiteral(resourceName: "standingShoulderPressDumbell2"), #imageLiteral(resourceName: "standingShoulderPressDumbell2"), #imageLiteral(resourceName: "standingShoulderPressDumbell1")],
            44: [#imageLiteral(resourceName: "lateralRaise"), #imageLiteral(resourceName: "lateralRaise1"), #imageLiteral(resourceName: "lateralRaise2"), #imageLiteral(resourceName: "lateralRaise3"), #imageLiteral(resourceName: "lateralRaise4"), #imageLiteral(resourceName: "lateralRaise4"), #imageLiteral(resourceName: "lateralRaise3"), #imageLiteral(resourceName: "lateralRaise2"), #imageLiteral(resourceName: "lateralRaise1")],
            45: [#imageLiteral(resourceName: "frontRaise"), #imageLiteral(resourceName: "frontRaise1"), #imageLiteral(resourceName: "frontRaise2"), #imageLiteral(resourceName: "frontRaise3"), #imageLiteral(resourceName: "frontRaise4"), #imageLiteral(resourceName: "frontRaise4"), #imageLiteral(resourceName: "frontRaise3"), #imageLiteral(resourceName: "frontRaise2"), #imageLiteral(resourceName: "frontRaise1")],
            // Push (Triceps)
            46: [#imageLiteral(resourceName: "closeGripBench"), #imageLiteral(resourceName: "closeGripBench1"), #imageLiteral(resourceName: "closeGripBench2"), #imageLiteral(resourceName: "closeGripBench3"), #imageLiteral(resourceName: "closeGripBench4"), #imageLiteral(resourceName: "closeGripBench5"), #imageLiteral(resourceName: "closeGripBench5"), #imageLiteral(resourceName: "closeGripBench4"), #imageLiteral(resourceName: "closeGripBench3"), #imageLiteral(resourceName: "closeGripBench2")],
            47: [#imageLiteral(resourceName: "cableExtension"), #imageLiteral(resourceName: "cableExtension1"), #imageLiteral(resourceName: "cableExtension2"), #imageLiteral(resourceName: "cableExtension3"), #imageLiteral(resourceName: "cableExtension3"), #imageLiteral(resourceName: "cableExtension2"), #imageLiteral(resourceName: "cableExtension1")],
            48: [#imageLiteral(resourceName: "ropeExtension"), #imageLiteral(resourceName: "ropeExtension1"), #imageLiteral(resourceName: "ropeExtension2"), #imageLiteral(resourceName: "ropeExtension3"), #imageLiteral(resourceName: "ropeExtension3"), #imageLiteral(resourceName: "ropeExtension2"), #imageLiteral(resourceName: "ropeExtension1")],
            // Full Body
            49: [#imageLiteral(resourceName: "cleanPress"), #imageLiteral(resourceName: "cleanPress1"), #imageLiteral(resourceName: "cleanPress2"), #imageLiteral(resourceName: "cleanPress3"), #imageLiteral(resourceName: "cleanPress4"), #imageLiteral(resourceName: "cleanPress5"), #imageLiteral(resourceName: "cleanPress6"), #imageLiteral(resourceName: "cleanPress5"), #imageLiteral(resourceName: "cleanPress4"), #imageLiteral(resourceName: "cleanPress3"), #imageLiteral(resourceName: "cleanPress2"), #imageLiteral(resourceName: "cleanPress1")],
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            50: [#imageLiteral(resourceName: "bodyweightSquat"), #imageLiteral(resourceName: "bodyweightSquat1"), #imageLiteral(resourceName: "bodyweightSquat2"), #imageLiteral(resourceName: "bodyweightSquat3"), #imageLiteral(resourceName: "bodyweightSquat4"), #imageLiteral(resourceName: "bodyweightSquat5"), #imageLiteral(resourceName: "bodyweightSquat5"), #imageLiteral(resourceName: "bodyweightSquat4"), #imageLiteral(resourceName: "bodyweightSquat3"), #imageLiteral(resourceName: "bodyweightSquat2"), #imageLiteral(resourceName: "bodyweightSquat1")],
            51: [#imageLiteral(resourceName: "pistolSquat"), #imageLiteral(resourceName: "pistolSquat1"), #imageLiteral(resourceName: "pistolSquat2"), #imageLiteral(resourceName: "pistolSquat3"), #imageLiteral(resourceName: "pistolSquat4"), #imageLiteral(resourceName: "pistolSquat5"), #imageLiteral(resourceName: "pistolSquat5"), #imageLiteral(resourceName: "pistolSquat4"), #imageLiteral(resourceName: "pistolSquat3"), #imageLiteral(resourceName: "pistolSquat2"), #imageLiteral(resourceName: "pistolSquat1")],
            52: [#imageLiteral(resourceName: "skaterSquat"), #imageLiteral(resourceName: "skaterSquat1"), #imageLiteral(resourceName: "skaterSquat2"), #imageLiteral(resourceName: "skaterSquat3"), #imageLiteral(resourceName: "skaterSquat4"), #imageLiteral(resourceName: "skaterSquat4"), #imageLiteral(resourceName: "skaterSquat3"), #imageLiteral(resourceName: "skaterSquat2"), #imageLiteral(resourceName: "skaterSquat1")],
            53: [#imageLiteral(resourceName: "jumpSquat"), #imageLiteral(resourceName: "jumpSquat1"), #imageLiteral(resourceName: "jumpSquat2"), #imageLiteral(resourceName: "jumpSquat3"), #imageLiteral(resourceName: "jumpSquat4"), #imageLiteral(resourceName: "jumpSquat5"), #imageLiteral(resourceName: "jumpSquat4"), #imageLiteral(resourceName: "jumpSquat3"), #imageLiteral(resourceName: "jumpSquat2"), #imageLiteral(resourceName: "jumpSquat1")],
            54: [#imageLiteral(resourceName: "sumoSquat"), #imageLiteral(resourceName: "sumoSquat1"), #imageLiteral(resourceName: "sumoSquat2"), #imageLiteral(resourceName: "sumoSquat3") , #imageLiteral(resourceName: "sumoSquat4"), #imageLiteral(resourceName: "sumoSquat4"), #imageLiteral(resourceName: "sumoSquat3"), #imageLiteral(resourceName: "sumoSquat2"), #imageLiteral(resourceName: "sumoSquat1")],
            55: [#imageLiteral(resourceName: "lunge"), #imageLiteral(resourceName: "lunge1"), #imageLiteral(resourceName: "lunge2"), #imageLiteral(resourceName: "lunge3"), #imageLiteral(resourceName: "lunge4"), #imageLiteral(resourceName: "lunge3"), #imageLiteral(resourceName: "lunge2"), #imageLiteral(resourceName: "lunge1"), #imageLiteral(resourceName: "lunge5"), #imageLiteral(resourceName: "lunge6"), #imageLiteral(resourceName: "lunge7"), #imageLiteral(resourceName: "lunge6"), #imageLiteral(resourceName: "lunge5"), #imageLiteral(resourceName: "lunge1")],
            56: [#imageLiteral(resourceName: "lungeJump"), #imageLiteral(resourceName: "lungeJump1"), #imageLiteral(resourceName: "lungeJump2"), #imageLiteral(resourceName: "lungeJump3"), #imageLiteral(resourceName: "lungeJump4"), #imageLiteral(resourceName: "lungeJump5"), #imageLiteral(resourceName: "lungeJump6"), #imageLiteral(resourceName: "lungeJump5"), #imageLiteral(resourceName: "lungeJump4"), #imageLiteral(resourceName: "lungeJump3"), #imageLiteral(resourceName: "lungeJump2"), #imageLiteral(resourceName: "lungeJump1")],
            // Legs (Hamstrings)
            57: [#imageLiteral(resourceName: "bodyweightDeadlift"), #imageLiteral(resourceName: "bodyweightDeadlift1"), #imageLiteral(resourceName: "bodyweightDeadlift2"), #imageLiteral(resourceName: "bodyweightDeadlift3"), #imageLiteral(resourceName: "bodyweightDeadlift4"), #imageLiteral(resourceName: "bodyweightDeadlift3"), #imageLiteral(resourceName: "bodyweightDeadlift2"), #imageLiteral(resourceName: "bodyweightDeadlift1"), #imageLiteral(resourceName: "bodyweightDeadlift1")],
            58: [#imageLiteral(resourceName: "singleLegDeadlift"), #imageLiteral(resourceName: "singleLegDeadlift1"), #imageLiteral(resourceName: "singleLegDeadlift2"), #imageLiteral(resourceName: "singleLegDeadlift3"), #imageLiteral(resourceName: "singleLegDeadlift4"), #imageLiteral(resourceName: "singleLegDeadlift3"), #imageLiteral(resourceName: "singleLegDeadlift2"), #imageLiteral(resourceName: "singleLegDeadlift1")],
            // Legs (Glutes)
            59: [#imageLiteral(resourceName: "gluteBridgeW"), #imageLiteral(resourceName: "gluteBridgeW1"), #imageLiteral(resourceName: "gluteBridgeW2"), #imageLiteral(resourceName: "gluteBridgeW3"), #imageLiteral(resourceName: "gluteBridgeW3"), #imageLiteral(resourceName: "gluteBridgeW2"), #imageLiteral(resourceName: "gluteBridgeW1")],
            60: [#imageLiteral(resourceName: "singleLegGluteBridge"), #imageLiteral(resourceName: "singleLegGluteBridge1"), #imageLiteral(resourceName: "singleLegGluteBridge2"), #imageLiteral(resourceName: "singleLegGluteBridge3"), #imageLiteral(resourceName: "singleLegGluteBridge3"), #imageLiteral(resourceName: "singleLegGluteBridge2"), #imageLiteral(resourceName: "singleLegGluteBridge1")],
            61: [#imageLiteral(resourceName: "kneelingHipRotations"), #imageLiteral(resourceName: "kneelingHipRotations7"), #imageLiteral(resourceName: "kneelingHipRotations8"), #imageLiteral(resourceName: "kneelingHipRotations9"), #imageLiteral(resourceName: "kneelingHipRotations10"), #imageLiteral(resourceName: "kneelingHipRotations10"), #imageLiteral(resourceName: "kneelingHipRotations9"), #imageLiteral(resourceName: "kneelingHipRotations8"), #imageLiteral(resourceName: "kneelingHipRotations7")],
            62: [#imageLiteral(resourceName: "standingGluteKickback"), #imageLiteral(resourceName: "standingGluteKickback1"), #imageLiteral(resourceName: "standingGluteKickback2"), #imageLiteral(resourceName: "standingGluteKickback3"), #imageLiteral(resourceName: "standingGluteKickback3"), #imageLiteral(resourceName: "standingGluteKickback2"), #imageLiteral(resourceName: "standingGluteKickback1")],
            // Legs (Calves)
            63: [#imageLiteral(resourceName: "calfRaise"), #imageLiteral(resourceName: "calfRaise1"), #imageLiteral(resourceName: "calfRaise"), #imageLiteral(resourceName: "calfRaise1")],
            // Pull (Back) ---------
            64: [#imageLiteral(resourceName: "contralateralLimbRaises"), #imageLiteral(resourceName: "contralateralLimbRaises1"), #imageLiteral(resourceName: "contralateralLimbRaises2"), #imageLiteral(resourceName: "contralateralLimbRaises3"), #imageLiteral(resourceName: "contralateralLimbRaises3"), #imageLiteral(resourceName: "contralateralLimbRaises2"), #imageLiteral(resourceName: "contralateralLimbRaises1"), #imageLiteral(resourceName: "contralateralLimbRaises4"), #imageLiteral(resourceName: "contralateralLimbRaises5"), #imageLiteral(resourceName: "contralateralLimbRaises5"), #imageLiteral(resourceName: "contralateralLimbRaises4"), #imageLiteral(resourceName: "contralateralLimbRaises1")],
            65: [#imageLiteral(resourceName: "superMan")],
            66: [#imageLiteral(resourceName: "backHyperextension"), #imageLiteral(resourceName: "backHyperextension1"), #imageLiteral(resourceName: "backHyperextension2"), #imageLiteral(resourceName: "backHyperextension3"), #imageLiteral(resourceName: "backHyperextension4"), #imageLiteral(resourceName: "backHyperextension4"), #imageLiteral(resourceName: "backHyperextension3"), #imageLiteral(resourceName: "backHyperextension2"), #imageLiteral(resourceName: "backHyperextension1")],
            67: [#imageLiteral(resourceName: "doorFrameRow"), #imageLiteral(resourceName: "doorFrameRow1"), #imageLiteral(resourceName: "doorFrameRow2"), #imageLiteral(resourceName: "doorFrameRow2"), #imageLiteral(resourceName: "doorFrameRow1"), #imageLiteral(resourceName: "doorFrameRow")],
            68: [#imageLiteral(resourceName: "reverseSnowAngels"), #imageLiteral(resourceName: "reverseSnowAngels1"), #imageLiteral(resourceName: "reverseSnowAngels2"), #imageLiteral(resourceName: "reverseSnowAngels3"), #imageLiteral(resourceName: "reverseSnowAngels4"), #imageLiteral(resourceName: "reverseSnowAngels4"), #imageLiteral(resourceName: "reverseSnowAngels3"), #imageLiteral(resourceName: "reverseSnowAngels2"), #imageLiteral(resourceName: "reverseSnowAngels1")],
            69: [#imageLiteral(resourceName: "scapulaPushup"), #imageLiteral(resourceName: "scapulaPushup1"), #imageLiteral(resourceName: "scapulaPushup"), #imageLiteral(resourceName: "scapulaPushup1")],
            // Pull (Traps)
            70: [#imageLiteral(resourceName: "handStandTrap"), #imageLiteral(resourceName: "handStandTrap1"), #imageLiteral(resourceName: "handStandTrap"), #imageLiteral(resourceName: "handStandTrap1")],
            // Push (Chest) ---------
            71: [#imageLiteral(resourceName: "Test")], //!!!!!!!!!!
            // Push (Tricep)
            72: [#imageLiteral(resourceName: "trianglePushup"), #imageLiteral(resourceName: "trianglePushup1"), #imageLiteral(resourceName: "trianglePushup2"), #imageLiteral(resourceName: "trianglePushup3"), #imageLiteral(resourceName: "trianglePushup4"), #imageLiteral(resourceName: "trianglePushup4"), #imageLiteral(resourceName: "trianglePushup3"), #imageLiteral(resourceName: "trianglePushup2"), #imageLiteral(resourceName: "trianglePushup1")],
            73: [#imageLiteral(resourceName: "dolphinPushup"), #imageLiteral(resourceName: "dolphinPushup1"), #imageLiteral(resourceName: "dolphinPushup2"), #imageLiteral(resourceName: "dolphinPushup3"), #imageLiteral(resourceName: "dolphinPushup4"), #imageLiteral(resourceName: "dolphinPushup3"), #imageLiteral(resourceName: "dolphinPushup2"), #imageLiteral(resourceName: "dolphinPushup1")],
            74: [#imageLiteral(resourceName: "tricepExtensionsBodyweight"), #imageLiteral(resourceName: "tricepExtensionsBodyweight1"), #imageLiteral(resourceName: "tricepExtensionsBodyweight"), #imageLiteral(resourceName: "tricepExtensionsBodyweight1")],
            // Push (Chest & Tricep)
            75: [#imageLiteral(resourceName: "walkingPushup"), #imageLiteral(resourceName: "walkingPushup1"), #imageLiteral(resourceName: "walkingPushup2"), #imageLiteral(resourceName: "walkingPushup1"), #imageLiteral(resourceName: "walkingPushup3"), #imageLiteral(resourceName: "walkingPushup4"), #imageLiteral(resourceName: "walkingPushup5"), #imageLiteral(resourceName: "walkingPushup4"), #imageLiteral(resourceName: "walkingPushup3"), #imageLiteral(resourceName: "walkingPushup1"), #imageLiteral(resourceName: "walkingPushup2"), #imageLiteral(resourceName: "walkingPushup1"), #imageLiteral(resourceName: "walkingPushup6"), #imageLiteral(resourceName: "walkingPushup7"), #imageLiteral(resourceName: "walkingPushup8"), #imageLiteral(resourceName: "walkingPushup7"), #imageLiteral(resourceName: "walkingPushup6"), #imageLiteral(resourceName: "walkingPushup1"), #imageLiteral(resourceName: "walkingPushup2"), #imageLiteral(resourceName: "walkingPushup1")],
            // Push (Shoulder)
            76: [#imageLiteral(resourceName: "downwardDogPushup"), #imageLiteral(resourceName: "downwardDogPushup1"), #imageLiteral(resourceName: "downwardDogPushup2"), #imageLiteral(resourceName: "downwardDogPushup3"), #imageLiteral(resourceName: "downwardDogPushup4"), #imageLiteral(resourceName: "downwardDogPushup5"), #imageLiteral(resourceName: "downwardDogPushup6"), #imageLiteral(resourceName: "downwardDogPushup7"), #imageLiteral(resourceName: "downwardDogPushup8"), #imageLiteral(resourceName: "downwardDogPushup1")],
            77: [#imageLiteral(resourceName: "handStandTrap1")],
            78: [#imageLiteral(resourceName: "boxer2"), #imageLiteral(resourceName: "boxer"), #imageLiteral(resourceName: "boxer1"), #imageLiteral(resourceName: "boxer2"), #imageLiteral(resourceName: "boxer1"), #imageLiteral(resourceName: "boxer"), #imageLiteral(resourceName: "boxer3"), #imageLiteral(resourceName: "boxer4"), #imageLiteral(resourceName: "boxer3"), #imageLiteral(resourceName: "boxer1")],
            79: [#imageLiteral(resourceName: "armCircles")],
            // Core ---------
            80: [#imageLiteral(resourceName: "plank")],
            81: [#imageLiteral(resourceName: "dynamicPlank"), #imageLiteral(resourceName: "dynamicPlank1"), #imageLiteral(resourceName: "dynamicPlank"), #imageLiteral(resourceName: "dynamicPlank1")],
            82: [#imageLiteral(resourceName: "sidePlank")],
            83: [#imageLiteral(resourceName: "pushupPlank")],
            84: [#imageLiteral(resourceName: "lSit")],
            85: [#imageLiteral(resourceName: "bicycleCrunch"), #imageLiteral(resourceName: "bicycleCrunch1"), #imageLiteral(resourceName: "bicycleCrunch2"), #imageLiteral(resourceName: "bicycleCrunch3"), #imageLiteral(resourceName: "bicycleCrunch4"), #imageLiteral(resourceName: "bicycleCrunch3"), #imageLiteral(resourceName: "bicycleCrunch2"), #imageLiteral(resourceName: "bicycleCrunch1")],
            86: [#imageLiteral(resourceName: "divingHold")],
            87: [#imageLiteral(resourceName: "hipRaise"), #imageLiteral(resourceName: "hipRaise1"), #imageLiteral(resourceName: "hipRaise"), #imageLiteral(resourceName: "hipRaise1")],
            88: [#imageLiteral(resourceName: "legHold")],
            // General (Core) ---------
            89: [#imageLiteral(resourceName: "mountainClimber"), #imageLiteral(resourceName: "mountainClimber1"), #imageLiteral(resourceName: "mountainClimber2"), #imageLiteral(resourceName: "mountainClimber3"), #imageLiteral(resourceName: "mountainClimber4"), #imageLiteral(resourceName: "mountainClimber5"), #imageLiteral(resourceName: "mountainClimber4"), #imageLiteral(resourceName: "mountainClimber3"), #imageLiteral(resourceName: "mountainClimber2"), #imageLiteral(resourceName: "mountainClimber1")],
            // General (Full Body)
            90: [#imageLiteral(resourceName: "burpee3"), #imageLiteral(resourceName: "burpee2"), #imageLiteral(resourceName: "burpee1"), #imageLiteral(resourceName: "burpee"), #imageLiteral(resourceName: "burpee1"), #imageLiteral(resourceName: "burpee2"), #imageLiteral(resourceName: "burpee3"), #imageLiteral(resourceName: "burpee4"), #imageLiteral(resourceName: "burpee5"), #imageLiteral(resourceName: "burpee6"), #imageLiteral(resourceName: "burpee5"), #imageLiteral(resourceName: "burpee4"), #imageLiteral(resourceName: "burpee3"), #imageLiteral(resourceName: "burpee2")],
            91: [#imageLiteral(resourceName: "kickThroughBurpee7"), #imageLiteral(resourceName: "kickThroughBurpee2"), #imageLiteral(resourceName: "kickThroughBurpee1"), #imageLiteral(resourceName: "kickThroughBurpee"), #imageLiteral(resourceName: "kickThroughBurpee1"), #imageLiteral(resourceName: "kickThroughBurpee2"), #imageLiteral(resourceName: "kickThroughBurpee3"), #imageLiteral(resourceName: "kickThroughBurpee4"), #imageLiteral(resourceName: "kickThroughBurpee5"), #imageLiteral(resourceName: "kickThroughBurpee4"), #imageLiteral(resourceName: "kickThroughBurpee6"), #imageLiteral(resourceName: "kickThroughBurpee7"), #imageLiteral(resourceName: "kickThroughBurpee6"), #imageLiteral(resourceName: "kickThroughBurpee4"), #imageLiteral(resourceName: "kickThroughBurpee8"), #imageLiteral(resourceName: "kickThroughBurpee9"), #imageLiteral(resourceName: "kickThroughBurpee8"), #imageLiteral(resourceName: "kickThroughBurpee4"), #imageLiteral(resourceName: "kickThroughBurpee3"), #imageLiteral(resourceName: "kickThroughBurpee2")],
            // General (Upper Body)
            92: [#imageLiteral(resourceName: "spiderPushup4"), #imageLiteral(resourceName: "spiderPushup"), #imageLiteral(resourceName: "spiderPushup1"), #imageLiteral(resourceName: "spiderPushup2"), #imageLiteral(resourceName: "spiderPushup3"), #imageLiteral(resourceName: "spiderPushup4"), #imageLiteral(resourceName: "spiderPushup3"), #imageLiteral(resourceName: "spiderPushup2"), #imageLiteral(resourceName: "spiderPushup1"), #imageLiteral(resourceName: "spiderPushup"), #imageLiteral(resourceName: "spiderPushup1"), #imageLiteral(resourceName: "spiderPushup2"), #imageLiteral(resourceName: "spiderPushup5"), #imageLiteral(resourceName: "spiderPushup6"), #imageLiteral(resourceName: "spiderPushup5"), #imageLiteral(resourceName: "spiderPushup2"), #imageLiteral(resourceName: "spiderPushup1"), #imageLiteral(resourceName: "spiderPushup")],
            93: [#imageLiteral(resourceName: "crabWalk"), #imageLiteral(resourceName: "crabWalk1"), #imageLiteral(resourceName: "crabWalk2"), #imageLiteral(resourceName: "crabWalk3"), #imageLiteral(resourceName: "crabWalk4"), #imageLiteral(resourceName: "crabWalk5"), #imageLiteral(resourceName: "crabWalk6")],
            // General (Cardio)
            94: [#imageLiteral(resourceName: "jumpingJacks3"), #imageLiteral(resourceName: "jumpingJacks"), #imageLiteral(resourceName: "jumpingJacks1"), #imageLiteral(resourceName: "jumpingJacks2"), #imageLiteral(resourceName: "jumpingJacks3"), #imageLiteral(resourceName: "jumpingJacks4"), #imageLiteral(resourceName: "jumpingJacks3"), #imageLiteral(resourceName: "jumpingJacks2"), #imageLiteral(resourceName: "jumpingJacks1"), #imageLiteral(resourceName: "jumpingJacks")],
            95: [#imageLiteral(resourceName: "tuckJump3"), #imageLiteral(resourceName: "tuckJump"), #imageLiteral(resourceName: "tuckJump1"), #imageLiteral(resourceName: "tuckJump2"), #imageLiteral(resourceName: "tuckJump3"), #imageLiteral(resourceName: "tuckJump2"), #imageLiteral(resourceName: "tuckJump1"), #imageLiteral(resourceName: "tuckJump")],
            96: [#imageLiteral(resourceName: "bumKicks4"), #imageLiteral(resourceName: "bumKicks3"), #imageLiteral(resourceName: "bumKicks2"), #imageLiteral(resourceName: "bumKicks1"), #imageLiteral(resourceName: "bumKicks"), #imageLiteral(resourceName: "bumKicks1"), #imageLiteral(resourceName: "bumKicks2"), #imageLiteral(resourceName: "bumKicks3")],
            97: [#imageLiteral(resourceName: "kneeRaises"), #imageLiteral(resourceName: "kneeRaises1"), #imageLiteral(resourceName: "kneeRaises2"), #imageLiteral(resourceName: "kneeRaises3"), #imageLiteral(resourceName: "kneeRaises4"), #imageLiteral(resourceName: "kneeRaises3"), #imageLiteral(resourceName: "kneeRaises2"), #imageLiteral(resourceName: "kneeRaises1")],
            // Isometric (Legs) ---------
            98: [#imageLiteral(resourceName: "wallSit")],
            99: [#imageLiteral(resourceName: "toePress")],
            100: [#imageLiteral(resourceName: "lungeJump")],
            // Isometric (Upper Body)
            101: [#imageLiteral(resourceName: "chestSqueeze")],
            102: [#imageLiteral(resourceName: "pushupHold")],
            103: [#imageLiteral(resourceName: "Test")], //!!!!!!!
            // Equiptment (Ball) ---------
            104: [#imageLiteral(resourceName: "ballPushup"), #imageLiteral(resourceName: "ballPushup1"), #imageLiteral(resourceName: "ballPushup"), #imageLiteral(resourceName: "ballPushup1")],
            // Equiptment (Bar)
            105: [#imageLiteral(resourceName: "Test")], //!!!!!!!
            106: [#imageLiteral(resourceName: "Test")], //!!!!!!!
            107: [#imageLiteral(resourceName: "hangingLegRaises"), #imageLiteral(resourceName: "hangingLegRaises1"), #imageLiteral(resourceName: "hangingLegRaises2"), #imageLiteral(resourceName: "hangingLegRaises3"), #imageLiteral(resourceName: "hangingLegRaises4"), #imageLiteral(resourceName: "hangingLegRaises3"), #imageLiteral(resourceName: "hangingLegRaises2"), #imageLiteral(resourceName: "hangingLegRaises1")],
            // Equiptment (Bench/Step)
            108: [#imageLiteral(resourceName: "tricepDip"), #imageLiteral(resourceName: "tricepDip1"), #imageLiteral(resourceName: "tricepDip2"), #imageLiteral(resourceName: "tricepDip3"), #imageLiteral(resourceName: "tricepDip4"), #imageLiteral(resourceName: "tricepDip3"), #imageLiteral(resourceName: "tricepDip2"), #imageLiteral(resourceName: "tricepDip1")],
            109: [#imageLiteral(resourceName: "bulgarianSplitSquat"), #imageLiteral(resourceName: "bulgarianSplitSquat1"), #imageLiteral(resourceName: "bulgarianSplitSquat"), #imageLiteral(resourceName: "bulgarianSplitSquat1")],
            110: [#imageLiteral(resourceName: "boxJump")],
            111: [#imageLiteral(resourceName: "hipThrusts"), #imageLiteral(resourceName: "hipThrusts1"), #imageLiteral(resourceName: "hipThrusts"), #imageLiteral(resourceName: "hipThrusts1")],
            112: [#imageLiteral(resourceName: "stepUp"), #imageLiteral(resourceName: "stepUp1"), #imageLiteral(resourceName: "stepUp2"), #imageLiteral(resourceName: "stepUp3"), #imageLiteral(resourceName: "stepUp2"), #imageLiteral(resourceName: "stepUp1")]
    ]
    
    // Demonstration Array
    var targetAreaDictionary: [Int : UIImage] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            0: #imageLiteral(resourceName: "Squat"),
            1: #imageLiteral(resourceName: "Squat"),
            2: #imageLiteral(resourceName: "Squat"),
            3: #imageLiteral(resourceName: "Squat"),
            4: #imageLiteral(resourceName: "Squat"),
            // Legs (Hamstrings/Glutes)
            5: #imageLiteral(resourceName: "Deadlift"),
            6: #imageLiteral(resourceName: "Deadlift"),
            7: #imageLiteral(resourceName: "Deadlift"),
            8: #imageLiteral(resourceName: "Deadlift"),
            9: #imageLiteral(resourceName: "Rear Thigh"),
            10: #imageLiteral(resourceName: "Glute"),
            // Legs (General)
            11: #imageLiteral(resourceName: "Squat"),
            12: #imageLiteral(resourceName: "Squat"),
            13: #imageLiteral(resourceName: "Squat"),
            // Legs (Calves)
            14: #imageLiteral(resourceName: "Calf"),
            15: #imageLiteral(resourceName: "Calf"),
            // Pull (Back) ---------
            16: #imageLiteral(resourceName: "Back and Bicep"),
            17: #imageLiteral(resourceName: "Back and Bicep"),
            18: #imageLiteral(resourceName: "Back and Bicep"),
            19: #imageLiteral(resourceName: "Back and Bicep"),
            20: #imageLiteral(resourceName: "Back, Bicep and Erector"),
            21: #imageLiteral(resourceName: "Back, Bicep and Erector"),
            22: #imageLiteral(resourceName: "Back, Bicep and Erector"),
            23: #imageLiteral(resourceName: "Back and Bicep"),
            // Pull (Upper Back)
            24: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            25: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            // Pull (Rear Delts)
            26: #imageLiteral(resourceName: "Rear Delt"),
            // Pull (Traps)
            27: #imageLiteral(resourceName: "Trap"),
            // Pull (Biceps)
            28: #imageLiteral(resourceName: "Bicep"),
            29: #imageLiteral(resourceName: "Bicep"),
            30: #imageLiteral(resourceName: "Bicep"),
            // Pull (Forearms)
            31: #imageLiteral(resourceName: "Forearm"),
            32: #imageLiteral(resourceName: "Forearm"),
            33: #imageLiteral(resourceName: "Forearm"),
            // Push (Chest) ---------
            34: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            35: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            36: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            37: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            38: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            39: #imageLiteral(resourceName: "Pec and Front Delt"),
            40: #imageLiteral(resourceName: "Pec and Front Delt"),
            41: #imageLiteral(resourceName: "Pec and Front Delt"),
            // Push (Shoulders)
            42: #imageLiteral(resourceName: "Shoulder"),
            43: #imageLiteral(resourceName: "Shoulder"),
            44: #imageLiteral(resourceName: "Shoulder"),
            45: #imageLiteral(resourceName: "Shoulder"),
            // Push (Triceps)
            46: #imageLiteral(resourceName: "Tricep"),
            47: #imageLiteral(resourceName: "Tricep"),
            48: #imageLiteral(resourceName: "Tricep"),
            // Full Body
            49: #imageLiteral(resourceName: "Squat"),
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            50: #imageLiteral(resourceName: "Test"),
            51: #imageLiteral(resourceName: "Test"),
            52: #imageLiteral(resourceName: "Test"),
            53: #imageLiteral(resourceName: "Test"),
            54: #imageLiteral(resourceName: "Test"),
            55: #imageLiteral(resourceName: "Test"),
            56: #imageLiteral(resourceName: "Test"),
            // Legs (Hamstrings)
            57: #imageLiteral(resourceName: "Test"),
            58: #imageLiteral(resourceName: "Test"),
            // Legs (Glutes)
            59: #imageLiteral(resourceName: "Test"),
            60: #imageLiteral(resourceName: "Test"),
            61: #imageLiteral(resourceName: "Test"),
            62: #imageLiteral(resourceName: "Test"),
            // Legs (Calves)
            63: #imageLiteral(resourceName: "Test"),
            // Pull (Back) ---------
            64: #imageLiteral(resourceName: "Test"),
            65: #imageLiteral(resourceName: "Test"),
            66: #imageLiteral(resourceName: "Test"),
            67: #imageLiteral(resourceName: "Test"),
            68: #imageLiteral(resourceName: "Test"),
            69: #imageLiteral(resourceName: "Test"),
            // Pull (Traps)
            70: #imageLiteral(resourceName: "Test"),
            // Push (Chest) ---------
            71: #imageLiteral(resourceName: "Test"),
            // Push (Tricep)
            72: #imageLiteral(resourceName: "Test"),
            73: #imageLiteral(resourceName: "Test"),
            74: #imageLiteral(resourceName: "Test"),
            // Push (Chest & Tricep)
            75: #imageLiteral(resourceName: "Test"),
            // Push (Shoulder)
            76: #imageLiteral(resourceName: "Test"),
            77: #imageLiteral(resourceName: "Test"),
            78: #imageLiteral(resourceName: "Test"),
            79: #imageLiteral(resourceName: "Test"),
            // Core ---------
            80: #imageLiteral(resourceName: "Test"),
            81: #imageLiteral(resourceName: "Test"),
            82: #imageLiteral(resourceName: "Test"),
            83: #imageLiteral(resourceName: "Test"),
            84: #imageLiteral(resourceName: "Test"),
            85: #imageLiteral(resourceName: "Test"),
            86: #imageLiteral(resourceName: "Test"),
            87: #imageLiteral(resourceName: "Test"),
            88: #imageLiteral(resourceName: "Test"),
            // General (Core) ---------
            89: #imageLiteral(resourceName: "Test"),
            // General (Full Body)
            90: #imageLiteral(resourceName: "Test"),
            91: #imageLiteral(resourceName: "Test"),
            // General (Upper Body)
            92: #imageLiteral(resourceName: "Test"),
            93: #imageLiteral(resourceName: "Test"),
            // General (Cardio)
            94: #imageLiteral(resourceName: "Test"),
            95: #imageLiteral(resourceName: "Test"),
            96: #imageLiteral(resourceName: "Test"),
            97: #imageLiteral(resourceName: "Test"),
            // Isometric (Legs) ---------
            98: #imageLiteral(resourceName: "Test"),
            99: #imageLiteral(resourceName: "Test"),
            100: #imageLiteral(resourceName: "Test"),
            // Isometric (Upper Body)
            101: #imageLiteral(resourceName: "Test"),
            102: #imageLiteral(resourceName: "Test"),
            103: #imageLiteral(resourceName: "Test"),
            // Equiptment (Ball) ---------
            104: #imageLiteral(resourceName: "Test"),
            // Equiptment (Bar)
            105: #imageLiteral(resourceName: "Test"),
            106: #imageLiteral(resourceName: "Test"),
            107: #imageLiteral(resourceName: "Test"),
            // Equiptment (Bench/Step)
            108: #imageLiteral(resourceName: "Test"),
            109: #imageLiteral(resourceName: "Test"),
            110: #imageLiteral(resourceName: "Test"),
            111: #imageLiteral(resourceName: "Test"),
            112: #imageLiteral(resourceName: "Test")
    ]
    
    // Explanation Array
    var explanationDictionary: [Int : String] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            0: "squatE",
            1: "frontSquatE",
            2: "legPressE",
            3: "dumbellFrontSquatE",
            4: "legExtensionsE",
            // Legs (Hamstrings/Glutes)
            5: "deadliftE",
            6: "romanianDeadliftE",
            7: "weightedHipThrustE",
            8: "legCurlE",
            9: "oneLeggedDeadliftE",
            10: "gluteIsolationMachineE",
            // Legs (General)
            11: "lungeDumbellE",
            12: "bulgarianSplitSquatE",
            13: "weightedStepUpE",
            // Legs (Calves)
            14: "standingCalfRaiseE",
            15: "seatedCalfRaiseE",
            // Pull (Back) ---------
            16: "pullDownE",
            17: "kneelingPullDownE",
            18: "pullDownMachineE",
            19: "bentOverRowBarbellE",
            20: "bentOverRowDumbellE",
            21: "tBarRowE",
            22: "rowMachineE",
            23: "latPulloverE",
            // Pull (Upper Back)
            24: "facePullE",
            25: "leaningBackPullDownE",
            // Pull (Rear Delts)
            26: "bentOverBarbellRowE",
            // Pull (Traps)
            27: "shrugDumbellE",
            // Pull (Biceps)
            28: "hammerCurlE",
            29: "hammerCurlCableE",
            30: "curlE",
            // Pull (Forearms)
            31: "farmersCarryE",
            32: "reverseBarbellCurlE",
            33: "forearmCurlE",
            // Push (Chest) ---------
            34: "benchPressE",
            35: "benchPressDumbellE",
            36: "semiInclineDumbellPressE",
            37: "chestPressE",
            38: "platePressE",
            39: "barbellKneelingPressE",
            40: "cableFlyE",
            41: "dipsE",
            // Push (Shoulders)
            42: "standingShoulderPressBarbellE",
            43: "standingShoulderPressDumbellE",
            44: "lateralRaiseE",
            45: "frontRaiseE",
            // Push (Triceps)
            46: "closeGripBenchE",
            47: "cableExtensionE",
            48: "ropeExtensionE",
            // Full Body
            49: "cleanPressE",
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            50: "bodyweightSquatE",
            51: "pistolSquatE",
            52: "skaterSquatE",
            53: "squatJumpE",
            54: "sumoSquatE",
            55: "lungeE",
            56: "lungeJumpE",
            // Legs (Hamstrings)
            57: "deadliftE",
            58: "singleLegDeadliftE",
            // Legs (Glutes)
            59: "gluteBridgeE",
            60: "singleLegGluteBridgeE",
            61: "kickBackE",
            62: "standingKickBackE",
            // Legs (Calves)
            63: "calfRaiseE",
            // Pull (Back) ---------
            64: "contralateralLimbRaisesE",
            65: "superManE",
            66: "backHyperextensionE",
            67: "doorFrameRowE",
            68: "reverseSnowAngelsE",
            69: "scapulaPushupE",
            // Pull (Traps)
            70: "handStandTrapE",
            // Push (Chest) ---------
            71: "pushupE",
            // Push (Tricep)
            72: "trianglePushupE",
            73: "dolphinPushupE",
            74: "tricepExtensionsBodyweightE",
            // Push (Chest & Tricep)
            75: "walkingPushupE",
            // Push (Shoulder)
            76: "downwardDogPushupE",
            77: "wallPushupE",
            78: "boxerE",
            79: "armCirclesE",
            // Core ---------
            80: "plankE",
            81: "dynamicPlankE",
            82: "sidePlankE",
            83: "pushupPlankE",
            84: "lSitE",
            85: "bicycleCrunchE",
            86: "divingHoldE",
            87: "hipRaiseE",
            88: "legHoldE",
            // General (Core) ---------
            89: "mountainClimbersE",
            // General (Full Body)
            90: "burpeeE",
            91: "kickThroughBurpeeE",
            // General (Upper Body)
            92: "spiderPushupE",
            93: "crabWalkE",
            // General (Cardio)
            94: "jumpingJacksE",
            95: "tuckJumpE",
            96: "bumKicksE",
            97: "kneeRaisesE",
            // Isometric (Legs) ---------
            98: "wallSitE",
            99: "toePressE",
            100: "staticLungeE",
            // Isometric (Upper Body)
            101: "chestSqueezeE",
            102: "pushupHoldE",
            103: "pullupHoldE",
            // Equiptment (Ball) ---------
            104: "ballPushupE",
            // Equiptment (Bar)
            105: "bodweightRowE",
            106: "pullupE",
            107: "hangingLegRaiseE",
            // Equiptment (Bench/Step)
            108: "tricepDipE",
            109: "bulgarianSplitSquatE",
            110: "boxJumpE",
            111: "hipThrustsE",
            112: "stepUpE"
    ]
    
    
    //
    // Full Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayGymFull: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysGymFull: [[[Int]]] =
        [
            [
                [0, 11, 12, 14, 17, 19, 21, 23, 26, 31, 32, 33, 35, 36],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Sets Arrays
    var presetSetsArrayGymFull: [[[Int]]] =
        [
            [
                // Default
                [2,1,2,1,2,1,2,1,1,2,2,1,2,1],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Reps Arrays
    var presetRepsArrayGymFull: [[[String]]] =
        [
            [
                // Default
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps"],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    //
    // Upper Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayGymUpper: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysGymUpper: [[[Int]]] =
        [
            [
                [0, 11, 12, 14, 17, 19, 21, 23, 26, 31, 32, 33, 35, 36],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Sets Arrays
    var presetSetsArrayGymUpper: [[[Int]]] =
        [
            [
                // Default
                [2,1,2,1,2,1,2,1,1,2,2,1,2,1],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Reps Arrays
    var presetRepsArrayGymUpper: [[[String]]] =
        [
            [
                // Default
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps"],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    //
    // Lower Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayGymLower: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysGymLower: [[[Int]]] =
        [
            [
                [0, 11, 12, 14, 17, 19, 21, 23, 26, 31, 32, 33, 35, 36],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Sets Arrays
    var presetSetsArrayGymLower: [[[Int]]] =
        [
            [
                // Default
                [2,1,2,1,2,1,2,1,1,2,2,1,2,1],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Reps Arrays
    var presetRepsArrayGymLower: [[[String]]] =
        [
            [
                // Default
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps"],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    //
    // Legs Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayGymLegs: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysGymLegs: [[[Int]]] =
        [
            [
                [0, 11, 12, 14, 17, 19, 21, 23, 26, 31, 32, 33, 35, 36],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Sets Arrays
    var presetSetsArrayGymLegs: [[[Int]]] =
        [
            [
                // Default
                [2,1,2,1,2,1,2,1,1,2,2,1,2,1],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Reps Arrays
    var presetRepsArrayGymLegs: [[[String]]] =
        [
            [
                // Default
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps"],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    //
    // Pull Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayGymPull: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysGymPull: [[[Int]]] =
        [
            [
                [0, 11, 12, 14, 17, 19, 21, 23, 26, 31, 32, 33, 35, 36],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Sets Arrays
    var presetSetsArrayGymPull: [[[Int]]] =
        [
            [
                // Default
                [2,1,2,1,2,1,2,1,1,2,2,1,2,1],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Reps Arrays
    var presetRepsArrayGymPull: [[[String]]] =
        [
            [
                // Default
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps"],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    //
    // Push Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayGymPush: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysGymPush: [[[Int]]] =
        [
            [
                [0, 11, 12, 14, 17, 19, 21, 23, 26, 31, 32, 33, 35, 36],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Sets Arrays
    var presetSetsArrayGymPush: [[[Int]]] =
        [
            [
                // Default
                [2,1,2,1,2,1,2,1,1,2,2,1,2,1],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Reps Arrays
    var presetRepsArrayGymPush: [[[String]]] =
        [
            [
                // Default
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps"],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    //
    // 5x5 --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayGym5x5: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysGym5x5: [[[Int]]] =
        [
            [
                [0, 11, 12, 14, 17, 19, 21, 23, 26, 31, 32, 33, 35, 36],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Sets Arrays
    var presetSetsArrayGym5x5: [[[Int]]] =
        [
            [
                // Default
                [2,1,2,1,2,1,2,1,1,2,2,1,2,1],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Reps Arrays
    var presetRepsArrayGym5x5: [[[String]]] =
        [
            [
                // Default
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps"],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
//
// Gym Circuit -------------------------------------------------------------------------------------------------------------------------
//
    //
    // Full Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayGymCircuitFull: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysGymCircuitFull: [[[Int]]] =
        [
            // Sections in presets table
            [
                //
                [0, 11, 12],
                [0, 23, 30]
            ],
            [
                [3, 12, 34],
                [5, 0, 12],
                [1, 1, 4]
            ],
            [
                [],
                []
            ]
        ]
    
    //
    var numberOfRoundsArrayGymCircuitFull: [[Int]] =
        [
            // Sections in presets table
            [2,         // Rounds
             3],
            //
            [4,
             3,
             5],
            [2,
             3]
        ]
    
   
    // Reps Array
    var repsArrayGymCircuitFull: [[[[String]]]] =
        [
            // Sections in presets table
            [
                // Preset
                [
                    // Rounds
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"]
                ],
                //
                [
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"],
                    ["20 reps", "20 reps", "20 reps"]
                ],
            ],
            //
            [
                //
                [
                    [],
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    [],
                    [],
                    []
                ]
            ],
            [
                //
                [
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ]
            ]
        ]
    
    
    //
    // Upper Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayGymCircuitUpper: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysGymCircuitUpper: [[[Int]]] =
        [
            [
                [0, 11, 12],
                [0, 23, 30]
            ],
            [
                [3, 12, 34],
                [5, 0, 12],
                [1, 1, 4]
            ],
            [
                [],
                []
            ]
    ]
    
    //
    var numberOfRoundsArrayGymCircuitUpper: [[Int]] =
        [
            [2,
            3],
            [4,
            3,
            5],
            [2,
            3]
        ]
    
    // Reps Array
    var repsArrayGymCircuitUpper: [[[[String]]]] =
        [
            // Sections in presets table
            [
                // Preset
                [
                    // Rounds
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"]
                ],
                //
                [
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"],
                    ["20 reps", "20 reps", "20 reps"]
                ],
                ],
            //
            [
                //
                [
                    [],
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    [],
                    [],
                    []
                ]
            ],
            [
                //
                [
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ]
            ]
    ]
    
    //
    // Lower Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayGymCircuitLower: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysGymCircuitLower: [[[Int]]] =
        [
            [
                [0, 11, 12],
                [0, 23, 30, 12]
            ],
            [
                [3, 12, 34],
                [5, 0, 12],
                [1, 1, 4]
            ],
            [
                [],
                []
            ]
    ]
    
    //
    var numberOfRoundsArrayGymCircuitLower: [[Int]] =
        [
            [2,
             3],
            [4,
             3,
             5],
            [2,
             3]
        ]
    
    
    // Reps Array
    var repsArrayGymCircuitLower: [[[[String]]]] =
        [
            // Sections in presets table
            [
                // Preset
                [
                    // Rounds
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"]
                ],
                //
                [
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"],
                    ["20 reps", "20 reps", "20 reps"]
                ],
                ],
            //
            [
                //
                [
                    [],
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    [],
                    [],
                    []
                ]
            ],
            [
                //
                [
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ]
            ]
    ]
    
    
//
// BodyWeight --------------------------------------------------------------------------------------------------------------------------
//
    //
    // Full Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayBodyweightFull: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
        ]
    
    // Preseys Arrays
    var presetsArraysBodyweightFull: [[[Int]]] =
        [
            [
                [0, 11, 12, 14, 17, 19, 21, 23, 26, 31, 32, 33, 35, 36],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
        ]
    
    // Sets Arrays
    var presetSetsArrayBodyweightFull: [[[Int]]] =
        [
            [
                // Default
                [2,1,2,1,2,1,2,1,1,2,2,1,2,1],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Reps Arrays
    var presetRepsArrayBodyweightFull: [[[String]]] =
        [
            [
                // Default
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps"],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    
    //
    // Upper Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayBodyweightUpper: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
        ]
    
    // Preseys Arrays
    var presetsArraysBodyweightUpper: [[[Int]]] =
        [
            [
                [0, 11, 12, 14, 17, 19, 21, 23, 26, 31, 32, 33, 35, 36],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
        ]
    
    // Sets Arrays
    var presetSetsArrayBodyweightUpper: [[[Int]]] =
        [
            [
                // Default
                [2,1,2,1,2,1,2,1,1,2,2,1,2,1],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Reps Arrays
    var presetRepsArrayBodyweightUpper: [[[String]]] =
        [
            [
                // Default
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps"],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    
    //
    // Lower Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayBodyweightLower: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
        ]
    
    // Preseys Arrays
    var presetsArraysBodyweightLower: [[[Int]]] =
        [
            [
                [0, 11, 12, 14, 17, 19, 21, 23, 26, 31, 32, 33, 35, 36],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
        ]
    
    // Sets Arrays
    var presetSetsArrayBodyweightLower: [[[Int]]] =
        [
            [
                // Default
                [2,1,2,1,2,1,2,1,1,2,2,1,2,1],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
    // Reps Arrays
    var presetRepsArrayBodyweightLower: [[[String]]] =
        [
            [
                // Default
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps"],
                []
            ],
            [
                [],
                [],
                []
            ],
            [
                [],
                []
            ]
    ]
    
//
// BodyWeight Circuit --------------------------------------------------------------------------------------------------------------------------
//
    //
    // Full Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayBodyweightCircuitFull: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysBodyweightCircuitFull: [[[Int]]] =
        [
            [
                [0, 11, 12],
                [0, 23, 30]
            ],
            [
                [3, 12, 34],
                [5, 0, 12],
                [1, 1, 4]
            ],
            [
                [],
                []
            ]
    ]
    
    //
    var numberOfRoundsArrayBodyweightCircuitFull: [[Int]] =
        [
            [2,
             3],
            [4,
             3,
             5],
            [2,
             3]
    ]
    
    // Reps Array
    var repsArrayBodyweightCircuitFull: [[[[String]]]] =
        [
            // Sections in presets table
            [
                // Preset
                [
                    // Rounds
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"]
                ],
                //
                [
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"],
                    ["20 reps", "20 reps", "20 reps"]
                ],
                ],
            //
            [
                //
                [
                    [],
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    [],
                    [],
                    []
                ]
            ],
            [
                //
                [
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ]
            ]
    ]
    
    
    //
    // Upper Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayBodyweightCircuitUpper: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysBodyweightCircuitUpper: [[[Int]]] =
        [
            [
                [0, 11, 12],
                [0, 23, 30]
            ],
            [
                [3, 12, 34],
                [5, 0, 12],
                [1, 1, 4]
            ],
            [
                [],
                []
            ]
    ]
    
    //
    var numberOfRoundsArrayBodyweightCircuitUpper: [[Int]] =
        [
            [2,
             3],
            [4,
             3,
             5],
            [2,
             3]
    ]
    
    // Reps Array
    var repsArrayBodyweightCircuitUpper: [[[[String]]]] =
        [
            // Sections in presets table
            [
                // Preset
                [
                    // Rounds
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"]
                ],
                //
                [
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"],
                    ["20 reps", "20 reps", "20 reps"]
                ],
                ],
            //
            [
                //
                [
                    [],
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    [],
                    [],
                    []
                ]
            ],
            [
                //
                [
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ]
            ]
    ]
    
    
    //
    // Lower Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayBodyweightCircuitLower: [[String]] =
        [
            ["default",
             "beginner"],
            ["bodyWeight",
             "bodybuilding",
             "strength"],
            ["highIntensity",
             "quick"]
    ]
    
    // Preseys Arrays
    var presetsArraysBodyweightCircuitLower: [[[Int]]] =
        [
            [
                [0, 11, 12],
                [0, 23, 30]
            ],
            [
                [3, 12, 34],
                [5, 0, 12],
                [1, 1, 4]
            ],
            [
                [],
                []
            ]
    ]
    
    //
    var numberOfRoundsArrayBodyweightCircuitLower: [[Int]] =
        [
            [2,
             3],
            [4,
             3,
             5],
            [2,
             3]
    ]
    
    // Reps Array
    var repsArrayBodyweightCircuitLower: [[[[String]]]] =
        [
            // Sections in presets table
            [
                // Preset
                [
                    // Rounds
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"]
                ],
                //
                [
                    ["50 reps", "50 reps", "50 reps"],
                    ["30 reps", "30 reps", "30 reps"],
                    ["20 reps", "20 reps", "20 reps"]
                ],
                ],
            //
            [
                //
                [
                    [],
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    [],
                    [],
                    []
                ]
            ],
            [
                //
                [
                    [],
                    []
                ],
                //
                [
                    [],
                    [],
                    []
                ]
            ]
    ]

    
    
    
  
//
// Set Arrays --------------------------------------------------------------------------------------------------------------------------
//
    // Set Arrays Function
    func setArrays() {
        //
        // Set Dictionaries
        switch workoutType {
        //
        // Gym
        case 0:
            //
            // Set Presets
            switch workoutType2 {
            // Full
            case 0:
                presetsArray = presetsArrayGymFull
                presetsArrays = presetsArraysGymFull
                presetSetsArray = presetSetsArrayGymFull
                presetRepsArray = presetRepsArrayGymFull
            // Upper
            case 1:
                presetsArray = presetsArrayGymUpper
                presetsArrays = presetsArraysGymUpper
                presetSetsArray = presetSetsArrayGymUpper
                presetRepsArray = presetRepsArrayGymUpper
            // Lower
            case 2:
                presetsArray = presetsArrayGymLower
                presetsArrays = presetsArraysGymLower
                presetSetsArray = presetSetsArrayGymLower
                presetRepsArray = presetRepsArrayGymLower
            // Legs
            case 3:
                presetsArray = presetsArrayGymLegs
                presetsArrays = presetsArraysGymLegs
                presetSetsArray = presetSetsArrayGymLegs
                presetRepsArray = presetRepsArrayGymLegs
            // Pull
            case 4:
                presetsArray = presetsArrayGymPull
                presetsArrays = presetsArraysGymPull
                presetSetsArray = presetSetsArrayGymPull
                presetRepsArray = presetRepsArrayGymPull
            // Push
            case 5:
                presetsArray = presetsArrayGymPush
                presetsArrays = presetsArraysGymPush
                presetSetsArray = presetSetsArrayGymPush
                presetRepsArray = presetRepsArrayGymPush
            //
            default: break
            }
        //
        // Gym Circuit
        case 1:
            //
            // Set Presets
            switch workoutType2 {
            // Full
            case 0:
                presetsArray = presetsArrayGymCircuitFull
                presetsArrays = presetsArraysGymCircuitFull
                numberOfRoundsArray = numberOfRoundsArrayGymCircuitFull
                presetRepsArrayCircuit = repsArrayGymCircuitFull
            // Upper
            case 1:
                presetsArray = presetsArrayGymCircuitUpper
                presetsArrays = presetsArraysGymCircuitUpper
                numberOfRoundsArray = numberOfRoundsArrayGymCircuitUpper
                presetRepsArrayCircuit = repsArrayGymCircuitUpper
            // Lower
            case 2:
                presetsArray = presetsArrayGymCircuitLower
                presetsArrays = presetsArraysGymCircuitLower
                numberOfRoundsArray = numberOfRoundsArrayGymCircuitLower
                presetRepsArrayCircuit = repsArrayGymCircuitLower
            //
            default: break
            }
        //
        // Bodyweight
        case 2:
            //
            // Set Presets
            switch workoutType2 {
            // Full
            case 0:
                presetsArray = presetsArrayBodyweightFull
                presetsArrays = presetsArraysBodyweightFull
                presetSetsArray = presetSetsArrayBodyweightFull
                presetRepsArray = presetRepsArrayBodyweightFull
            // Upper
            case 1:
                presetsArray = presetsArrayBodyweightUpper
                presetsArrays = presetsArraysBodyweightUpper
                presetSetsArray = presetSetsArrayBodyweightUpper
                presetRepsArray = presetRepsArrayBodyweightUpper
            // Lower
            case 2:
                presetsArray = presetsArrayBodyweightLower
                presetsArrays = presetsArraysBodyweightLower
                presetSetsArray = presetSetsArrayBodyweightLower
                presetRepsArray = presetRepsArrayBodyweightLower
            //
            default: break
            }
        //
        // Bodyweight Circuit
        case 3:
            //
            // Set Presets
            switch workoutType2 {
            // Full
            case 0:
                presetsArray = presetsArrayBodyweightCircuitFull
                presetsArrays = presetsArraysBodyweightCircuitFull
                numberOfRoundsArray = numberOfRoundsArrayBodyweightCircuitFull
                presetRepsArrayCircuit = repsArrayBodyweightCircuitFull
            // Upper
            case 1:
                presetsArray = presetsArrayBodyweightCircuitUpper
                presetsArrays = presetsArraysBodyweightCircuitUpper
                numberOfRoundsArray = numberOfRoundsArrayBodyweightCircuitUpper
                presetRepsArrayCircuit = repsArrayBodyweightCircuitUpper
            // Lower
            case 2:
                presetsArray = presetsArrayBodyweightCircuitLower
                presetsArrays = presetsArraysBodyweightCircuitLower
                numberOfRoundsArray = numberOfRoundsArrayBodyweightCircuitLower
                presetRepsArrayCircuit = repsArrayBodyweightCircuitLower
            //
            default: break
            }
        default: break
        }
    }
    
    
    //
    // Outlets ------------------------------------------------------------------------------------------------------------------------------
    //
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    // Movements Table View
    @IBOutlet weak var movementsTableView: UITableView!
   
    // Presets Button
    @IBOutlet weak var presetsButton: UIButton!
    
    
    //
    @IBOutlet weak var presetsConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableConstraint1: NSLayoutConstraint!
    
    @IBOutlet weak var tableConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var beginConstraint: NSLayoutConstraint!
    
    
    
    let emptyString = ""
    
    // Presets Table
    //
    // Select Prest
    var presetsTableView = UITableView()
    var backgroundViewExpanded = UIButton()
    
    
    // Flash Screen
    func flashScreen() {
        //
        let flash = UIView()
        //
        flash.frame = CGRect(x: 0, y: presetsButton.frame.maxY, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        //
        UIView.animate(withDuration: 0.4, animations: {
            flash.alpha = 0
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
    }
    
    //
    // View will appear
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presetsButton.setTitle(NSLocalizedString("selectWorkout", comment: ""), for: .normal)
    }
    
    //
    // View did load ------------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Arrays
        //
        setArrays()
        
        // Colour
        view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString(navigationTitles[workoutType], comment: ""))
        
        //
        presetsButton.backgroundColor = colour2
        presetsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = colour3
        beginButton.setTitleColor(colour2, for: .normal)
        
        
        
        
        // Initial Element Positions
        //
        presetsConstraint.constant = 0
        //
        tableConstraint1.constant = view.frame.size.height
        tableConstraint.constant = -49.25
        //
        beginConstraint.constant = -49
        
        
        
        
        //
        // TableView Backgrounds
        //
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.movementsTableView.frame.size.width, height: self.movementsTableView.frame.size.height)
        //
        movementsTableView.backgroundView = tableViewBackground
        
        //
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = colour2
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        
        presetsTableView.tableFooterView = UIView()
        
        
        // TableView Cell action items
        //
        // Movement table
        presetsTableView.backgroundColor = colour2
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        presetsTableView.layer.cornerRadius = 15
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        presetsTableView.layer.borderColor = colour1.cgColor
        presetsTableView.layer.borderWidth = 1
        //
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        movementsTableView.tableFooterView = UIView()
    }
    
    //
    // TableView -----------------------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case movementsTableView:
            if numberOfRoundsArray.count == 0 {
                return overviewArray.count
            } else {
                if overviewArray.count != 0 {
                    return numberOfRoundsArray[selectedPreset[0]][selectedPreset[1]]
                }
            }
        case presetsTableView:
            return presetsArray.count
        default: break
        }
        return 0
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case movementsTableView:
            if numberOfRoundsArray.count == 0 {
                return NSLocalizedString(tableViewSectionArray[sectionNumbers[section]], comment: "")
            } else {
                return NSLocalizedString("round", comment: "") + String(section + 1)  + NSLocalizedString("of", comment: "") + String(numberOfRoundsArray[selectedPreset[0]][selectedPreset[1]])
            }
        case presetsTableView:
            return " "
        default: break
        }
        return ""
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case movementsTableView:
            if numberOfRoundsArray.count == 0 {
                return overviewArray[section].count
            } else {
                return roundArray.count
            }
        case presetsTableView:
            return presetsArray[section].count
        default: break
        }
        return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        //
        case movementsTableView:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            cell.selectionStyle = .none
            //
            // Cell contents
            switch workoutType {
            case 0,2:
                //
                cell.textLabel?.text = NSLocalizedString(workoutMovementsDictionary[overviewArray[indexPath.section][indexPath.row]]!, comment: "")
                // Compress overview array to find index as int of movement as repsArray = [] and overviewArray = [[]]
                let flatArray = overviewArray.flatMap { $0 }
                cell.detailTextLabel?.text = repsArray[flatArray.index(of: overviewArray[indexPath.section][indexPath.row])!]
                //
                cell.imageView?.image = demonstrationDictionary[overviewArray[indexPath.section][indexPath.row]]?[0]
            case 1,2:
                cell.textLabel?.text = NSLocalizedString(workoutMovementsDictionary[roundArray[indexPath.row]]!, comment: "")
                cell.detailTextLabel?.text = repsArrayCircuit[indexPath.section][indexPath.row]
                //
                cell.imageView?.image = demonstrationDictionary[roundArray[indexPath.row]]?[0]
            default: break
            }
            //
            // Text Label
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            // Detail Text Label - reps
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.textAlignment = .right
            cell.detailTextLabel?.textColor = colour2
            //
            // Cell Image
            cell.imageView?.isUserInteractionEnabled = true
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleTap))
            cell.imageView?.addGestureRecognizer(imageTap)
            //
            return cell
        //
        case presetsTableView:
            //
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            cell.textLabel?.text = "- " + NSLocalizedString(presetsArray[indexPath.section][indexPath.row], comment: "") + " -"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.backgroundColor = colour1
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            return cell
        default: break
        }
        return UITableViewCell()
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case movementsTableView:
            return 72
        case presetsTableView:
            return 44
        default: break
        }
        return 0
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        //
        case movementsTableView:
            break
        //
        case presetsTableView:
            //
            selectedPreset[0] = indexPath.section
            selectedPreset[1] = indexPath.row
            //
            sectionNumbers = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33]
            
            // Compress to new array
            overviewArray = fullKeyArray
            
            //
            for i in (0...(overviewArray.count - 1)).reversed() {
                // Reduce Array to session
                for j in (0...(overviewArray[i].count - 1)).reversed() {
                    if presetsArrays[selectedPreset[0]][selectedPreset[1]].contains(overviewArray[i][j]) == false {
                        overviewArray[i].remove(at: j)
                    }
                }
                // Remove empty arrays
                if overviewArray[i] == [] {
                    overviewArray.remove(at: i)
                    sectionNumbers.remove(at: i)
                }
            }
            
            // Rounds
            if numberOfRoundsArray.count != 0 {
                roundArray = overviewArray.flatMap { $0 }
            }
            
            // Sets and Reps
            switch workoutType {
            case 0,2:
                setsArray = presetSetsArray[selectedPreset[0]][selectedPreset[1]]
                repsArray = presetRepsArray[selectedPreset[0]][selectedPreset[1]]
            case 1,3:
                repsArrayCircuit = presetRepsArrayCircuit[selectedPreset[0]][selectedPreset[1]]
            default: break
            }
            
            //
            movementsTableView.contentOffset.y = 0
            
            presetsButton.setTitle("- " + NSLocalizedString(presetsArray[indexPath.section][indexPath.row], comment: "") + " -", for: .normal)
            presetsTableView.deselectRow(at: indexPath, animated: true)
            
            //
            let tableHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            let tableWidth = UIScreen.main.bounds.width - 20
            //
            // Dismiss Presets Table
            //
            UIView.animate(withDuration: animationTime2, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: tableWidth, height: tableHeight)
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
            // Animate new elements up
            UIView.animate(withDuration: animationTime3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.movementsTableView.reloadData()
                let indexPath2 = NSIndexPath(row: 0, section: 0)
                self.movementsTableView.scrollToRow(at: indexPath2 as IndexPath, at: .top, animated: true)
                //
                self.tableConstraint1.constant = 73.75
                self.tableConstraint.constant = 49.75
                //
                self.presetsConstraint.constant = self.view.frame.size.height - 73.25
                //
                self.beginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }, completion: { finished in
                //
                if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2") == false {
                    self.walkthroughMindBody()
                    UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2")
                }
            })
            
        default: break
        }
        
    }
    
    
    //
    // Presets Button Action -----------------------------------------------------------------------------------------------------------------
    //
    @IBAction func presetsButtonAction(_ sender: Any) {
        //
        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: presetsTableView)
        //
        animateActionSheetUp(actionSheet: presetsTableView, actionSheetHeight: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88, backgroundView: backgroundViewExpanded)
    }
    
    
    // Dismiss presets table
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        animateActionSheetDown(actionSheet: presetsTableView, actionSheetHeight: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88, backgroundView: backgroundViewExpanded)
    }
    
    
    //
    // Expand image actions ----------------------------------------------------------------------------------------------------------------
    //
    // Handle Tap
    let expandedImage = UIImageView()
    let backgroundViewImage = UIButton()
    //
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        // Get Image
        let sender = extraTap.view as! UIImageView
        let image = sender.image
        expandedImage.image = image
        //
        backgroundViewImage.addTarget(self, action: #selector(retractImage(_:)), for: .touchUpInside)
        //
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewImage, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(expandedImage, aboveSubview: backgroundViewImage)
        //
        animateViewUp(animationView: expandedImage, backgroundView: backgroundViewImage)
    }
    
    // Retract image
    @IBAction func retractImage(_ sender: Any) {
        //
        animateViewDown(animationView: expandedImage, backgroundView: backgroundViewImage)
    }
    
    
    //
    // Begin Button ---------------------------------------------------------------------------------------------------------------------------
    //
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        //
        switch workoutType {
        case 0,2: performSegue(withIdentifier: "workoutSessionSegue0", sender: nil)
        case 1,3: performSegue(withIdentifier: "workoutSessionSegue1", sender: nil)
        default: break
        }
        // Return background to homescreen
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            _ = self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    
    //
    // Pass Arrays ---------------------------------------------------------------------------------------------------------------------------
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        //
        case "workoutSessionSegue0":
            //
            let destinationVC = segue.destination as! SessionScreen
            
            // Ensure array in ascending order
            // Compress Arrays
            for i in presetsArrays[selectedPreset[0]][selectedPreset[1]] {
                //
                workoutArray.append(workoutMovementsDictionary[i]!)
                //
                demonstrationArray.append(demonstrationDictionary[i]!)
                //
                targetAreaArray.append(targetAreaDictionary[i]!)
                //
                explanationArray.append(explanationDictionary[i]!)
            }
            //
            destinationVC.sessionArray = workoutArray
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = 1
            //
            destinationVC.sessionTitle = presetsArray[selectedPreset[0]][selectedPreset[1]]
        //
        case "workoutSessionSegue1":
            //
            let destinationVC = segue.destination as! CircuitWorkoutScreen
            
            // Ensure array in ascending order
            // Compress Arrays
            for i in presetsArrays[selectedPreset[0]][selectedPreset[1]] {
                //
                workoutArray.append(workoutMovementsDictionary[i]!)
                //

                demonstrationArray.append(demonstrationDictionary[i]!)
                //
                targetAreaArray.append(targetAreaDictionary[i]!)
                //
                explanationArray.append(explanationDictionary[i]!)
            }
            //
            destinationVC.sessionArray = workoutArray
            destinationVC.repsArray = repsArrayCircuit
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.numberOfRounds = numberOfRoundsArray[selectedPreset[0]][selectedPreset[1]]
            //
            destinationVC.sessionType = 1
            //
        default: break
        }
    }
    
    
    //
    // Walkthrough --------------------------------------------------------------------------------------------------------
    //
    var  viewNumber = 0
    let walkthroughView = UIView()
    let label = UILabel()
    let nextButton = UIButton()
    let backButton = UIButton()
    
    // Walkthrough
    func walkthroughMindBody() {
        //
        let screenSize = UIScreen.main.bounds
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        //
        walkthroughView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        walkthroughView.backgroundColor = .black
        walkthroughView.alpha = 0.72
        walkthroughView.clipsToBounds = true
        //
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        label.center = view.center
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "SFUIDisplay-light", size: 22)
        label.textColor = .white
        //
        nextButton.frame = screenSize
        nextButton.backgroundColor = .clear
        nextButton.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
        //
        backButton.frame = CGRect(x: 3, y: UIApplication.shared.statusBarFrame.height, width: 50, height: navigationBarHeight)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.textAlignment = .left
        backButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        backButton.titleLabel?.textColor = .white
        backButton.addTarget(self, action: #selector(backWalkthroughView(_:)), for: .touchUpInside)
        
        //
        switch viewNumber {
        case 0:
            //
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight, width: self.view.frame.size.width, height: 73.5))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            //
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            //
            label.text = NSLocalizedString("choiceScreen2W", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
        //
        case 1:
            //
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 73.5, width: self.view.frame.size.width, height: movementsTableView.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            //
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            //
            label.center.y = presetsButton.center.y + UIApplication.shared.statusBarFrame.height + navigationBarHeight
            label.text = NSLocalizedString("choiceScreen21", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
            //
        //
        case 2:
            //
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 73.5 + movementsTableView.frame.size.height, width: self.view.frame.size.width, height: 49))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            //
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            //
            label.center = movementsTableView.center
            label.text = NSLocalizedString("choiceScreen22", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
        //
        default: break
        }
    }
    
    //
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        label.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    
    //
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            label.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
    }
    //
    //
}
