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
            25,
            26],
            // Pull (Rear Delts)
            [28],
            // Pull (Traps)
            [29],
            // Pull (Biceps)
            [30,
            31,
            32],
            // Pull (Forearms)
            [33,
            34,
            35],
            // Push (Chest) ---------
            [36,
            37,
            38,
            39,
            40,
            41,
            42,
            43],
            // Push (Shoulders)
            [44,
            45,
            46,
            47],
            // Push (Triceps)
            [49,                //!!!!!!!!
            50,
            51],
            // Full Body ---------
            [52],
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            [53,
            54,
            55,
            56,
            57,
            58,
            59],
            // Legs (Hamstrings)
            [60,
            61],
            // Legs (Glutes)
            [62,
            63,
            64,
            65],
            // Legs (Calves)
            [66],
            // Pull (Back) ---------
            [67,
            68,
            69,
            70,
            71,
            72],
            // Pull (Traps)
            [73],
            // Push (Chest) ---------
            [74],
            // Push (Tricep)
            [75,
            76,
            77],
            // Push (Chest & Tricep)
            [78],
            // Push (Shoulder)
            [79,
            80,
            81,
            82],
            // Core ---------
            [83,
            84,
            85,
            86,
            87,
            88,
            89,
            90,
            91],
            // General (Core) ---------
            [92],
            // General (Full Body)
            [93,
            94],
            // General (Upper Body)
            [95,
            96],
            // General (Cardio)
            [97,
            98,
            99,
            100],
            // Isometric (Legs) ---------
            [101,
            102,
            103],
            // Isometric (Upper Body)
            [104,
            105,
            106],
            // Equiptment (Ball) ---------
            [107],
            // Equiptment (Bar)
            [108,
            109,
            110],
            // Equiptment (Bench/Step)
            [111,
            112,
            113,
            114,
            115]
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
            25: "smithMachinePullUp",
            26: "leaningBackPullDown",
            // Pull (Rear Delts)
            28: "bentOverBarbellRow",
            // Pull (Traps)
            29: "shrugDumbell",
            // Pull (Biceps)
            30: "hammerCurl",
            31: "hammerCurlCable",
            32: "curl",
            // Pull (Forearms)
            33: "farmersCarry",
            34: "reverseBarbellCurl",
            35: "forearmCurl",
            // Push (Chest) ---------
            36: "benchPress",
            37: "benchPressDumbell",
            38: "semiInclineDumbellPress",
            39: "chestPress",
            40: "platePress",
            41: "barbellKneelingPress",
            42: "cableFly",
            43: "dips",
            // Push (Shoulders)
            44: "standingShoulderPressBarbell",
            45: "standingShoulderPressDumbell",
            46: "lateralRaise",
            47: "frontRaise",
            // Push (Triceps)
            49: "closeGripBench",
            50: "cableExtension",
            51: "ropeExtension",
            // Full Body
            52: "cleanPress",
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            53: "bodyweightSquat",
            54: "pistolSquat",
            55: "skaterSquat",
            56: "squatJump",
            57: "sumoSquat",
            58: "lunge",
            59: "lungeJump",
            // Legs (Hamstrings)
            60: "deadlift",
            61: "singleLegDeadlift",
            // Legs (Glutes)
            62: "gluteBridge",
            63: "singleLegGluteBridge",
            64: "kickBack",
            65: "standingKickBack",
            // Legs (Calves)
            66: "calfRaise",
            // Pull (Back) ---------
            67: "contralateralLimbRaises",
            68: "superMan",
            69: "backHyperextension",
            70: "doorFrameRow",
            71: "reverseSnowAngels",
            72: "scapulaPushup",
            // Pull (Traps)
            73: "handStandTrap",
            // Push (Chest) ---------
            74: "pushup",
            // Push (Tricep)
            75: "trianglePushup",
            76: "dolphinPushup",
            77: "tricepExtensionsBodyweight",
            // Push (Chest & Tricep)
            78: "walkingPushup",
            // Push (Shoulder)
            79: "downwardDogPushup",
            80: "wallPushup",
            81: "boxer",
            82: "armCircles",
            // Core ---------
            83: "plank",
            84: "dynamicPlank",
            85: "sidePlank",
            86: "pushupPlank",
            87: "lSit",
            88: "bicycleCrunch",
            89: "divingHold",
            90: "hipRaise",
            91: "legHold",
            // General (Core) ---------
            92: "mountainClimbers",
            // General (Full Body)
            93: "burpee",
            94: "kickThroughBurpee",
            // General (Upper Body)
            95: "spiderPushup",
            96: "crabWalk",
            // General (Cardio)
            97: "jumpingJacks",
            98: "tuckJump",
            99: "bumKicks",
            100: "kneeRaises",
            // Isometric (Legs) ---------
            101: "wallSit",
            102: "toePress",
            103: "staticLunge",
            // Isometric (Upper Body)
            104: "chestSqueeze",
            105: "pushupHold",
            106: "pullupHold",
            // Equiptment (Ball) ---------
            107: "ballPushup",
            // Equiptment (Bar)
            108: "bodweightRow",
            109: "pullup",
            110: "hangingLegRaise",
            // Equiptment (Bench/Step)
            111: "tricepDip",
            112: "bulgarianSplitSquat",
            113: "boxJump",
            114: "hipThrusts",
            115: "stepUp"
    ]
    
    // Demonstration Array
    var demonstrationDictionary: [Int : [UIImage]] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            0: [#imageLiteral(resourceName: "Test")],
            1: [#imageLiteral(resourceName: "Test")],
            2: [#imageLiteral(resourceName: "Test")],
            3: [#imageLiteral(resourceName: "Test")],
            4: [#imageLiteral(resourceName: "Test")],
            // Legs (Hamstrings/Glutes)
            5: [#imageLiteral(resourceName: "Test")],
            6: [#imageLiteral(resourceName: "Test")],
            7: [#imageLiteral(resourceName: "Test")],
            8: [#imageLiteral(resourceName: "Test")],
            9: [#imageLiteral(resourceName: "Test")],
            10: [#imageLiteral(resourceName: "Test")],
            // Legs (General)
            11: [#imageLiteral(resourceName: "Test")],
            12: [#imageLiteral(resourceName: "Test")],
            13: [#imageLiteral(resourceName: "Test")],
            // Legs (Calves)
            14: [#imageLiteral(resourceName: "Test")],
            15: [#imageLiteral(resourceName: "Test")],
            // Pull (Back) ---------
            16: [#imageLiteral(resourceName: "Test")],
            17: [#imageLiteral(resourceName: "Test")],
            18: [#imageLiteral(resourceName: "Test")],
            19: [#imageLiteral(resourceName: "Test")],
            20: [#imageLiteral(resourceName: "Test")],
            21: [#imageLiteral(resourceName: "Test")],
            22: [#imageLiteral(resourceName: "Test")],
            23: [#imageLiteral(resourceName: "Test")],
            // Pull (Upper Back)
            24: [#imageLiteral(resourceName: "Test")],
            25: [#imageLiteral(resourceName: "Test")],
            26: [#imageLiteral(resourceName: "Test")],
            // Pull (Rear Delts)
            28: [#imageLiteral(resourceName: "Test")],
            // Pull (Traps)
            29: [#imageLiteral(resourceName: "Test")],
            // Pull (Biceps)
            30: [#imageLiteral(resourceName: "Test")],
            31: [#imageLiteral(resourceName: "Test")],
            32: [#imageLiteral(resourceName: "Test")],
            // Pull (Forearms)
            33: [#imageLiteral(resourceName: "Test")],
            34: [#imageLiteral(resourceName: "Test")],
            35: [#imageLiteral(resourceName: "Test")],
            // Push (Chest) ---------
            36: [#imageLiteral(resourceName: "Test")],
            37: [#imageLiteral(resourceName: "Test")],
            38: [#imageLiteral(resourceName: "Test")],
            39: [#imageLiteral(resourceName: "Test")],
            40: [#imageLiteral(resourceName: "Test")],
            41: [#imageLiteral(resourceName: "Test")],
            42: [#imageLiteral(resourceName: "Test")],
            43: [#imageLiteral(resourceName: "Test")],
            // Push (Shoulders)
            44: [#imageLiteral(resourceName: "Test")],
            45: [#imageLiteral(resourceName: "Test")],
            46: [#imageLiteral(resourceName: "Test")],
            47: [#imageLiteral(resourceName: "Test")],
            // Push (Triceps)
            49: [#imageLiteral(resourceName: "Test")],
            50: [#imageLiteral(resourceName: "Test")],
            51: [#imageLiteral(resourceName: "Test")],
            // Full Body
            52: [#imageLiteral(resourceName: "Test")],
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            53: [#imageLiteral(resourceName: "Test")],
            54: [#imageLiteral(resourceName: "Test")],
            55: [#imageLiteral(resourceName: "Test")],
            56: [#imageLiteral(resourceName: "Test")],
            57: [#imageLiteral(resourceName: "Test")],
            58: [#imageLiteral(resourceName: "Test")],
            59: [#imageLiteral(resourceName: "Test")],
            // Legs (Hamstrings)
            60: [#imageLiteral(resourceName: "Test")],
            61: [#imageLiteral(resourceName: "Test")],
            // Legs (Glutes)
            62: [#imageLiteral(resourceName: "Test")],
            63: [#imageLiteral(resourceName: "Test")],
            64: [#imageLiteral(resourceName: "Test")],
            65: [#imageLiteral(resourceName: "Test")],
            // Legs (Calves)
            66: [#imageLiteral(resourceName: "Test")],
            // Pull (Back) ---------
            67: [#imageLiteral(resourceName: "Test")],
            68: [#imageLiteral(resourceName: "Test")],
            69: [#imageLiteral(resourceName: "Test")],
            70: [#imageLiteral(resourceName: "Test")],
            71: [#imageLiteral(resourceName: "Test")],
            72: [#imageLiteral(resourceName: "Test")],
            // Pull (Traps)
            73: [#imageLiteral(resourceName: "Test")],
            // Push (Chest) ---------
            74: [#imageLiteral(resourceName: "Test")],
            // Push (Tricep)
            75: [#imageLiteral(resourceName: "Test")],
            76: [#imageLiteral(resourceName: "Test")],
            77: [#imageLiteral(resourceName: "Test")],
            // Push (Chest & Tricep)
            78: [#imageLiteral(resourceName: "Test")],
            // Push (Shoulder)
            79: [#imageLiteral(resourceName: "Test")],
            80: [#imageLiteral(resourceName: "Test")],
            81: [#imageLiteral(resourceName: "Test")],
            82: [#imageLiteral(resourceName: "Test")],
            // Core ---------
            83: [#imageLiteral(resourceName: "Test")],
            84: [#imageLiteral(resourceName: "Test")],
            85: [#imageLiteral(resourceName: "Test")],
            86: [#imageLiteral(resourceName: "Test")],
            87: [#imageLiteral(resourceName: "Test")],
            88: [#imageLiteral(resourceName: "Test")],
            89: [#imageLiteral(resourceName: "Test")],
            90: [#imageLiteral(resourceName: "Test")],
            91: [#imageLiteral(resourceName: "Test")],
            // General (Core) ---------
            92: [#imageLiteral(resourceName: "Test")],
            // General (Full Body)
            93: [#imageLiteral(resourceName: "Test")],
            94: [#imageLiteral(resourceName: "Test")],
            // General (Upper Body)
            95: [#imageLiteral(resourceName: "Test")],
            96: [#imageLiteral(resourceName: "Test")],
            // General (Cardio)
            97: [#imageLiteral(resourceName: "Test")],
            98: [#imageLiteral(resourceName: "Test")],
            99: [#imageLiteral(resourceName: "Test")],
            100: [#imageLiteral(resourceName: "Test")],
            // Isometric (Legs) ---------
            101: [#imageLiteral(resourceName: "Test")],
            102: [#imageLiteral(resourceName: "Test")],
            103: [#imageLiteral(resourceName: "Test")],
            // Isometric (Upper Body)
            104: [#imageLiteral(resourceName: "Test")],
            105: [#imageLiteral(resourceName: "Test")],
            106: [#imageLiteral(resourceName: "Test")],
            // Equiptment (Ball) ---------
            107: [#imageLiteral(resourceName: "Test")],
            // Equiptment (Bar)
            108: [#imageLiteral(resourceName: "Test")],
            109: [#imageLiteral(resourceName: "Test")],
            110: [#imageLiteral(resourceName: "Test")],
            // Equiptment (Bench/Step)
            111: [#imageLiteral(resourceName: "Test")],
            112: [#imageLiteral(resourceName: "Test")],
            113: [#imageLiteral(resourceName: "Test")],
            114: [#imageLiteral(resourceName: "Test")],
            115: [#imageLiteral(resourceName: "Test")]
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
            26: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            // Pull (Rear Delts)
            28: #imageLiteral(resourceName: "Rear Delt"),
            // Pull (Traps)
            29: #imageLiteral(resourceName: "Trap"),
            // Pull (Biceps)
            30: #imageLiteral(resourceName: "Bicep"),
            31: #imageLiteral(resourceName: "Bicep"),
            32: #imageLiteral(resourceName: "Bicep"),
            // Pull (Forearms)
            33: #imageLiteral(resourceName: "Forearm"),
            34: #imageLiteral(resourceName: "Forearm"),
            35: #imageLiteral(resourceName: "Forearm"),
            // Push (Chest) ---------
            36: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            37: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            38: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            39: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            40: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            41: #imageLiteral(resourceName: "Pec and Front Delt"),
            42: #imageLiteral(resourceName: "Pec and Front Delt"),
            43: #imageLiteral(resourceName: "Pec and Front Delt"),
            // Push (Shoulders)
            44: #imageLiteral(resourceName: "Shoulder"),
            45: #imageLiteral(resourceName: "Shoulder"),
            46: #imageLiteral(resourceName: "Shoulder"),
            47: #imageLiteral(resourceName: "Shoulder"),
            // Push (Triceps)
            49: #imageLiteral(resourceName: "Tricep"),
            50: #imageLiteral(resourceName: "Tricep"),
            51: #imageLiteral(resourceName: "Tricep"),
            // Full Body
            52: #imageLiteral(resourceName: "Squat"),
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            53: #imageLiteral(resourceName: "Test"),
            54: #imageLiteral(resourceName: "Test"),
            55: #imageLiteral(resourceName: "Test"),
            56: #imageLiteral(resourceName: "Test"),
            57: #imageLiteral(resourceName: "Test"),
            58: #imageLiteral(resourceName: "Test"),
            59: #imageLiteral(resourceName: "Test"),
            // Legs (Hamstrings)
            60: #imageLiteral(resourceName: "Test"),
            61: #imageLiteral(resourceName: "Test"),
            // Legs (Glutes)
            62: #imageLiteral(resourceName: "Test"),
            63: #imageLiteral(resourceName: "Test"),
            64: #imageLiteral(resourceName: "Test"),
            65: #imageLiteral(resourceName: "Test"),
            // Legs (Calves)
            66: #imageLiteral(resourceName: "Test"),
            // Pull (Back) ---------
            67: #imageLiteral(resourceName: "Test"),
            68: #imageLiteral(resourceName: "Test"),
            69: #imageLiteral(resourceName: "Test"),
            70: #imageLiteral(resourceName: "Test"),
            71: #imageLiteral(resourceName: "Test"),
            72: #imageLiteral(resourceName: "Test"),
            // Pull (Traps)
            73: #imageLiteral(resourceName: "Test"),
            // Push (Chest) ---------
            74: #imageLiteral(resourceName: "Test"),
            // Push (Tricep)
            75: #imageLiteral(resourceName: "Test"),
            76: #imageLiteral(resourceName: "Test"),
            77: #imageLiteral(resourceName: "Test"),
            // Push (Chest & Tricep)
            78: #imageLiteral(resourceName: "Test"),
            // Push (Shoulder)
            79: #imageLiteral(resourceName: "Test"),
            80: #imageLiteral(resourceName: "Test"),
            81: #imageLiteral(resourceName: "Test"),
            82: #imageLiteral(resourceName: "Test"),
            // Core ---------
            83: #imageLiteral(resourceName: "Test"),
            84: #imageLiteral(resourceName: "Test"),
            85: #imageLiteral(resourceName: "Test"),
            86: #imageLiteral(resourceName: "Test"),
            87: #imageLiteral(resourceName: "Test"),
            88: #imageLiteral(resourceName: "Test"),
            89: #imageLiteral(resourceName: "Test"),
            90: #imageLiteral(resourceName: "Test"),
            91: #imageLiteral(resourceName: "Test"),
            // General (Core) ---------
            92: #imageLiteral(resourceName: "Test"),
            // General (Full Body)
            93: #imageLiteral(resourceName: "Test"),
            94: #imageLiteral(resourceName: "Test"),
            // General (Upper Body)
            95: #imageLiteral(resourceName: "Test"),
            96: #imageLiteral(resourceName: "Test"),
            // General (Cardio)
            97: #imageLiteral(resourceName: "Test"),
            98: #imageLiteral(resourceName: "Test"),
            99: #imageLiteral(resourceName: "Test"),
            100: #imageLiteral(resourceName: "Test"),
            // Isometric (Legs) ---------
            101: #imageLiteral(resourceName: "Test"),
            102: #imageLiteral(resourceName: "Test"),
            103: #imageLiteral(resourceName: "Test"),
            // Isometric (Upper Body)
            104: #imageLiteral(resourceName: "Test"),
            105: #imageLiteral(resourceName: "Test"),
            106: #imageLiteral(resourceName: "Test"),
            // Equiptment (Ball) ---------
            107: #imageLiteral(resourceName: "Test"),
            // Equiptment (Bar)
            108: #imageLiteral(resourceName: "Test"),
            109: #imageLiteral(resourceName: "Test"),
            110: #imageLiteral(resourceName: "Test"),
            // Equiptment (Bench/Step)
            111: #imageLiteral(resourceName: "Test"),
            112: #imageLiteral(resourceName: "Test"),
            113: #imageLiteral(resourceName: "Test"),
            114: #imageLiteral(resourceName: "Test"),
            115: #imageLiteral(resourceName: "Test")
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
            25: "smithMachinePullUpE",
            26: "leaningBackPullDownE",
            // Pull (Rear Delts)
            28: "bentOverBarbellRowE",
            // Pull (Traps)
            29: "shrugDumbellE",
            // Pull (Biceps)
            30: "hammerCurlE",
            31: "hammerCurlCableE",
            32: "curlE",
            // Pull (Forearms)
            33: "farmersCarryE",
            34: "reverseBarbellCurlE",
            35: "forearmCurlE",
            // Push (Chest) ---------
            36: "benchPressE",
            37: "benchPressDumbellE",
            38: "semiInclineDumbellPressE",
            39: "chestPressE",
            40: "platePressE",
            41: "barbellKneelingPressE",
            42: "cableFlyE",
            43: "dipsE",
            // Push (Shoulders)
            44: "standingShoulderPressBarbellE",
            45: "standingShoulderPressDumbellE",
            46: "lateralRaiseE",
            47: "frontRaiseE",
            // Push (Triceps)
            49: "closeGripBenchE",
            50: "cableExtensionE",
            51: "ropeExtensionE",
            // Full Body
            52: "cleanPressE",
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            53: "bodyweightSquatE",
            54: "pistolSquatE",
            55: "skaterSquatE",
            56: "squatJumpE",
            57: "sumoSquatE",
            58: "lungeE",
            59: "lungeJumpE",
            // Legs (Hamstrings)
            60: "deadliftE",
            61: "singleLegDeadliftE",
            // Legs (Glutes)
            62: "gluteBridgeE",
            63: "singleLegGluteBridgeE",
            64: "kickBackE",
            65: "standingKickBackE",
            // Legs (Calves)
            66: "calfRaiseE",
            // Pull (Back) ---------
            67: "contralateralLimbRaisesE",
            68: "superManE",
            69: "backHyperextensionE",
            70: "doorFrameRowE",
            71: "reverseSnowAngelsE",
            72: "scapulaPushupE",
            // Pull (Traps)
            73: "handStandTrapE",
            // Push (Chest) ---------
            74: "pushupE",
            // Push (Tricep)
            75: "trianglePushupE",
            76: "dolphinPushupE",
            77: "tricepExtensionsBodyweightE",
            // Push (Chest & Tricep)
            78: "walkingPushupE",
            // Push (Shoulder)
            79: "downwardDogPushupE",
            80: "wallPushupE",
            81: "boxerE",
            82: "armCirclesE",
            // Core ---------
            83: "plankE",
            84: "dynamicPlankE",
            85: "sidePlankE",
            86: "pushupPlankE",
            87: "lSitE",
            88: "bicycleCrunchE",
            89: "divingHoldE",
            90: "hipRaiseE",
            91: "legHoldE",
            // General (Core) ---------
            92: "mountainClimbersE",
            // General (Full Body)
            93: "burpeeE",
            94: "kickThroughBurpeeE",
            // General (Upper Body)
            95: "spiderPushupE",
            96: "crabWalkE",
            // General (Cardio)
            97: "jumpingJacksE",
            98: "tuckJumpE",
            99: "bumKicksE",
            100: "kneeRaisesE",
            // Isometric (Legs) ---------
            101: "wallSitE",
            102: "toePressE",
            103: "staticLungeE",
            // Isometric (Upper Body)
            104: "chestSqueezeE",
            105: "pushupHoldE",
            106: "pullupHoldE",
            // Equiptment (Ball) ---------
            107: "ballPushupE",
            // Equiptment (Bar)
            108: "bodweightRowE",
            109: "pullupE",
            110: "hangingLegRaiseE",
            // Equiptment (Bench/Step)
            111: "tricepDipE",
            112: "bulgarianSplitSquatE",
            113: "boxJumpE",
            114: "hipThrustsE",
            115: "stepUpE"
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
