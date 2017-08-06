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
    // Gym (0), Gym Circuit (1), Bodyweight (2), Bodyweight Circtui (3)
    var workoutType = Int()
    // Full body, upper, lower etc.
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
    // Picker View Array
    var presetsArray: [[String]] = []
    //
    var presetsArrays: [[[Int]]] = []
    
    
    // Arrays to Use
    //
    // Section Array
    var tableViewSectionArray: [String] = []
    
    // Key Array
    var fullKeyArray: [[Int]] = []
    
    // Movements Dictionary
    var workoutMovementsDictionary: [Int : String] = [:]
    
    // Demonstration Dictionary
    var demonstrationDictionary: [Int : [UIImage]] = [:]

    // Target Area Dictionary
    var targetAreaDictionary: [Int: UIImage] = [:]
    
    // Explanation Dictionary
    var explanationDictionary: [Int : String] = [:]

    // Sets Dictionary
    var setsDictionary: [Int : Int] = [:]

    // Reps Dictionary
    var repsDictionary: [Int : String] = [:]
    
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
    var tableViewSectionArrayGym: [String] =
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
            "pullRD",
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
    var fullKeyArrayGym: [[Int]] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            [0,
            1,
            2,
            3,
            4,
            5],
            // Legs (Hamstrings/Glutes)
            [6,
            7,
            8,
            9,
            10,
            11],
            // Legs (General)
            [12,
            13,
            14],
            // Legs (Calves)
            [15,
            16],
            // Pull (Back) ---------
            [17,
            18,
            19,
            20,
            21,
            22,
            23,
            24,
            25,
            26,
            27],
            // Pull (Upper Back)
            [28,
            29,
            30,
            31],
            // Pull (Rear Delts)
            [32],
            // Pull (Traps)
            [33],
            // Pull (Biceps)
            [34,
            35,
            36,
            37],
            // Pull (Forearms)
            [38,
            39,
            40],
            // Push (Chest) ---------
            [41,
            42,
            43,
            44,
            45,
            46,
            47,
            48,
            49,
            50],
            // Push (Shoulders)
            [51,
            52,
            53,
            54],
            // Push (Triceps)
            [55,
            56,
            57,
            58,
            59],
            // Full Body ---------
            [60],
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            [61,
            62,
            63,
            64,
            65,
            66,
            67,
            68,
            69],
            // Legs (Hamstrings)
            [70,
            71],
            // Legs (Glutes)
            [72,
            73,
            74,
            75,
            76],
            // Legs (Calves)
            [77],
            // Pull (Back) ---------
            [78,
            79,
            80,
            81,
            82,
            83,
            84,
            85],
            // Pull (Traps)
            [86,
            87,
            88],
            // Pull (Rear Delts)
            [89],
            // Push (Chest) ---------
            [90],
            // Push (Tricep)
            [91,
            92,
            93],
            // Push (Chest & Tricep)
            [94],
            // Push (Shoulder)
            [95,
            96,
            97,
            98],
            // Core ---------
            [99,
            100,
            101,
            102,
            103,
            104,
            105,
            106,
            107],
            // General (Core) ---------
            [108],
            // General (Full Body)
            [109,
            110],
            // General (Upper Body)
            [111,
            112],
            // General (Cardio)
            [113,
            114,
            115,
            116],
            // Isometric (Legs) ---------
            [117,
            118,
            119,
            120,
            121],
            // Isometric (Upper Body)
            [122,
            123,
            124],
            // Equiptment (Ball) ---------
            [125],
            // Equiptment (Bar)
            [126,
            127,
            128],
            // Equiptment (Bench/Step)
            [129,
            130,
            131,
            132,
            133]
    ]
    
    // Workout Movements Dictionary
    var workoutMovementsDictionaryGym: [Int : String] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            0: "squat",
            1: "frontSquat",
            2: "hackSquat",
            3: "legPress",
            4: "dumbellFrontSquat",
            5: "legExtensions",
            // Legs (Hamstrings/Glutes)
            6: "deadlift",
            7: "romanianDeadlift",
            8: "weightedHipThrust",
            9: "legCurl",
            10: "oneLeggedDeadlift",
            11: "gluteIsolationMachine",
            // Legs (General)
            12: "lungeDumbell",
            13: "bulgarianSplitSquat",
            14: "stepUp",
            // Legs (Calves)
            15: "standingCalfRaise",
            16: "seatedCalfRaise",
            // Pull (Back) ---------
            17: "pullUp",
            18: "pullDown",
            19: "kneelingPullDown",
            20: "pullDownMachine",
            21: "hammerStrengthPullDown",
            22: "bentOverRowBarbell",
            23: "bentOverRowDumbell",
            24: "tBarRow",
            25: "rowMachine",
            26: "hammerStrengthRow",
            27: "latPullover",
            // Pull (Upper Back)
            28: "facePull",
            29: "smithMachinePullUp",
            30: "leaningBackPullDown",
            31: "seatedMachineRow",
            // Pull (Rear Delts)
            32: "bentOverBarbellRow",
            // Pull (Traps)
            33: "shrugDumbell",
            // Pull (Biceps)
            34: "hamerCurl",
            35: "hammerCurlCable",
            36: "cableCurl",
            37: "curl",
            // Pull (Forearms)
            38: "farmersCarry",
            39: "reverseBarbellCurl",
            40: "forearmCurl",
            // Push (Chest) ---------
            41: "pushUp",
            42: "benchPress",
            43: "benchPressDumbell",
            44: "semiInclineDumbellPress",
            45: "hammerStrengthPress",
            46: "chestPress",
            47: "platePress",
            48: "barbellKneelingPress",
            49: "cableFly",
            50: "dips",
            // Push (Shoulders)
            51: "standingShoulderPressBarbell",
            52: "standingShoulderPressDumbell",
            53: "lateralRaise",
            54: "frontRaise",
            // Push (Triceps)
            55: "ballPushUp",
            56: "trianglePushUp",
            57: "closeGripBench",
            58: "cableExtension",
            59: "ropeExtension",
            // Full Body
            60: "cleanPress",
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            61: "bodyweightSquat",
            62: "pistolSquat",
            63: "skaterSquat",
            64: "squatJump",
            65: "sumoSquat",
            66: "sumoSquatJump",
            67: "lunge",
            68: "lungeJump",
            69: "stepUp",
            // Legs (Hamstrings)
            70: "deadlift",
            71: "singleLegDeadlift",
            // Legs (Glutes)
            72: "gluteBridge",
            73: "singleLegGluteBridge",
            74: "kickBack",
            75: "standingKickBack",
            76: "standingSideKick",
            // Legs (Calves)
            77: "calfRaise",
            // Pull (Back) ---------
            78: "contralateralLimbRaises",
            79: "superMan",
            80: "backHyperextension",
            81: "doorFrameRow",
            82: "reverseSnowAngels",
            83: "elbowTorsoLift",
            84: "backBridge",
            85: "scapulaPushup",
            // Pull (Traps)
            86: "handStandTrap",
            87: "handStandShoulderTap",
            88: "handStandWaistTap",
            // Pull (Rear Delts)
            89: "bentOverArmCircles",
            // Push (Chest) ---------
            90: "pushup",
            // Push (Tricep)
            91: "trianglePushup",
            92: "dolphinPushup",
            93: "tricepExtensionsBodyweight",
            // Push (Chest & Tricep)
            94: "walkingPushup",
            // Push (Shoulder)
            95: "downwardDogPushup",
            96: "wallPushup",
            97: "boxer",
            98: "armCircles",
            // Core ---------
            99: "plank",
            100: "dynamicPlank",
            101: "sidePlank",
            102: "pushupPlank",
            103: "lSit",
            104: "bicycleCrunch",
            105: "divingHold",
            106: "hipRaise",
            107: "legHold",
            // General (Core) ---------
            108: "mountainClimbers",
            // General (Full Body)
            109: "burpee",
            110: "kickThroughBurpee",
            // General (Upper Body)
            111: "spiderPushup",
            112: "crabWalk",
            // General (Cardio)
            113: "jumpingJacks",
            114: "tuckJump",
            115: "bumKicks",
            116: "kneeRaises",
            // Isometric (Legs) ---------
            117: "wallSit",
            118: "chairHold",
            119: "toePress",
            120: "staticLunge",
            121: "calfRaise",
            // Isometric (Upper Body)
            122: "chestSqueeze",
            123: "dolphinPlank",
            124: "pullupHold",
            // Equiptment (Ball) ---------
            125: "ballPushup",
            // Equiptment (Bar)
            126: "bodweightRow",
            127: "pullup",
            128: "hangingLegRaise",
            // Equiptment (Bench/Step)
            129: "tricepDip",
            130: "bulgarianSplitSquat",
            131: "boxJump",
            132: "hipThrusts",
            133: "stepUp"
    ]
    
    // Demonstration Array
    var demonstrationDictionaryGym: [Int : [UIImage]] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            0: [#imageLiteral(resourceName: "Test")],
            1: [#imageLiteral(resourceName: "Test")],
            2: [#imageLiteral(resourceName: "Test")],
            3: [#imageLiteral(resourceName: "Test")],
            4: [#imageLiteral(resourceName: "Test")],
            5: [#imageLiteral(resourceName: "Test")],
            // Legs (Hamstrings/Glutes)
            6: [#imageLiteral(resourceName: "Test")],
            7: [#imageLiteral(resourceName: "Test")],
            8: [#imageLiteral(resourceName: "Test")],
            9: [#imageLiteral(resourceName: "Test")],
            10: [#imageLiteral(resourceName: "Test")],
            11: [#imageLiteral(resourceName: "Test")],
            // Legs (General)
            12: [#imageLiteral(resourceName: "Test")],
            13: [#imageLiteral(resourceName: "Test")],
            14: [#imageLiteral(resourceName: "Test")],
            // Legs (Calves)
            15: [#imageLiteral(resourceName: "Test")],
            16: [#imageLiteral(resourceName: "Test")],
            // Pull (Back) ---------
            17: [#imageLiteral(resourceName: "Test")],
            18: [#imageLiteral(resourceName: "Test")],
            19: [#imageLiteral(resourceName: "Test")],
            20: [#imageLiteral(resourceName: "Test")],
            21: [#imageLiteral(resourceName: "Test")],
            22: [#imageLiteral(resourceName: "Test")],
            23: [#imageLiteral(resourceName: "Test")],
            24: [#imageLiteral(resourceName: "Test")],
            25: [#imageLiteral(resourceName: "Test")],
            26: [#imageLiteral(resourceName: "Test")],
            27: [#imageLiteral(resourceName: "Test")],
            // Pull (Upper Back)
            28: [#imageLiteral(resourceName: "Test")],
            29: [#imageLiteral(resourceName: "Test")],
            30: [#imageLiteral(resourceName: "Test")],
            31: [#imageLiteral(resourceName: "Test")],
            // Pull (Rear Delts)
            32: [#imageLiteral(resourceName: "Test")],
            // Pull (Traps)
            33: [#imageLiteral(resourceName: "Test")],
            // Pull (Biceps)
            34: [#imageLiteral(resourceName: "Test")],
            35: [#imageLiteral(resourceName: "Test")],
            36: [#imageLiteral(resourceName: "Test")],
            37: [#imageLiteral(resourceName: "Test")],
            // Pull (Forearms)
            38: [#imageLiteral(resourceName: "Test")],
            39: [#imageLiteral(resourceName: "Test")],
            40: [#imageLiteral(resourceName: "Test")],
            // Push (Chest) ---------
            41: [#imageLiteral(resourceName: "Test")],
            42: [#imageLiteral(resourceName: "Test")],
            43: [#imageLiteral(resourceName: "Test")],
            44: [#imageLiteral(resourceName: "Test")],
            45: [#imageLiteral(resourceName: "Test")],
            46: [#imageLiteral(resourceName: "Test")],
            47: [#imageLiteral(resourceName: "Test")],
            48: [#imageLiteral(resourceName: "Test")],
            49: [#imageLiteral(resourceName: "Test")],
            50: [#imageLiteral(resourceName: "Test")],
            // Push (Shoulders)
            51: [#imageLiteral(resourceName: "Test")],
            52: [#imageLiteral(resourceName: "Test")],
            53: [#imageLiteral(resourceName: "Test")],
            54: [#imageLiteral(resourceName: "Test")],
            // Push (Triceps)
            55: [#imageLiteral(resourceName: "Test")],
            56: [#imageLiteral(resourceName: "Test")],
            57: [#imageLiteral(resourceName: "Test")],
            58: [#imageLiteral(resourceName: "Test")],
            59: [#imageLiteral(resourceName: "Test")],
            // Full Body
            60: [#imageLiteral(resourceName: "Test")],
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            61: [#imageLiteral(resourceName: "Test")],
            62: [#imageLiteral(resourceName: "Test")],
            63: [#imageLiteral(resourceName: "Test")],
            64: [#imageLiteral(resourceName: "Test")],
            65: [#imageLiteral(resourceName: "Test")],
            66: [#imageLiteral(resourceName: "Test")],
            67: [#imageLiteral(resourceName: "Test")],
            68: [#imageLiteral(resourceName: "Test")],
            69: [#imageLiteral(resourceName: "Test")],
            // Legs (Hamstrings)
            70: [#imageLiteral(resourceName: "Test")],
            71: [#imageLiteral(resourceName: "Test")],
            // Legs (Glutes)
            72: [#imageLiteral(resourceName: "Test")],
            73: [#imageLiteral(resourceName: "Test")],
            74: [#imageLiteral(resourceName: "Test")],
            75: [#imageLiteral(resourceName: "Test")],
            76: [#imageLiteral(resourceName: "Test")],
            // Legs (Calves)
            77: [#imageLiteral(resourceName: "Test")],
            // Pull (Back) ---------
            78: [#imageLiteral(resourceName: "Test")],
            79: [#imageLiteral(resourceName: "Test")],
            80: [#imageLiteral(resourceName: "Test")],
            81: [#imageLiteral(resourceName: "Test")],
            82: [#imageLiteral(resourceName: "Test")],
            83: [#imageLiteral(resourceName: "Test")],
            84: [#imageLiteral(resourceName: "Test")],
            85: [#imageLiteral(resourceName: "Test")],
            // Pull (Traps)
            86: [#imageLiteral(resourceName: "Test")],
            87: [#imageLiteral(resourceName: "Test")],
            88: [#imageLiteral(resourceName: "Test")],
            // Pull (Rear Delts)
            89: [#imageLiteral(resourceName: "Test")],
            // Push (Chest) ---------
            90: [#imageLiteral(resourceName: "Test")],
            // Push (Tricep)
            91: [#imageLiteral(resourceName: "Test")],
            92: [#imageLiteral(resourceName: "Test")],
            93: [#imageLiteral(resourceName: "Test")],
            // Push (Chest & Tricep)
            94: [#imageLiteral(resourceName: "Test")],
            // Push (Shoulder)
            95: [#imageLiteral(resourceName: "Test")],
            96: [#imageLiteral(resourceName: "Test")],
            97: [#imageLiteral(resourceName: "Test")],
            98: [#imageLiteral(resourceName: "Test")],
            // Core ---------
            99: [#imageLiteral(resourceName: "Test")],
            100: [#imageLiteral(resourceName: "Test")],
            101: [#imageLiteral(resourceName: "Test")],
            102: [#imageLiteral(resourceName: "Test")],
            103: [#imageLiteral(resourceName: "Test")],
            104: [#imageLiteral(resourceName: "Test")],
            105: [#imageLiteral(resourceName: "Test")],
            106: [#imageLiteral(resourceName: "Test")],
            107: [#imageLiteral(resourceName: "Test")],
            // General (Core) ---------
            108: [#imageLiteral(resourceName: "Test")],
            // General (Full Body)
            109: [#imageLiteral(resourceName: "Test")],
            110: [#imageLiteral(resourceName: "Test")],
            // General (Upper Body)
            111: [#imageLiteral(resourceName: "Test")],
            112: [#imageLiteral(resourceName: "Test")],
            // General (Cardio)
            113: [#imageLiteral(resourceName: "Test")],
            114: [#imageLiteral(resourceName: "Test")],
            115: [#imageLiteral(resourceName: "Test")],
            116: [#imageLiteral(resourceName: "Test")],
            // Isometric (Legs) ---------
            117: [#imageLiteral(resourceName: "Test")],
            118: [#imageLiteral(resourceName: "Test")],
            119: [#imageLiteral(resourceName: "Test")],
            120: [#imageLiteral(resourceName: "Test")],
            121: [#imageLiteral(resourceName: "Test")],
            // Isometric (Upper Body)
            122: [#imageLiteral(resourceName: "Test")],
            123: [#imageLiteral(resourceName: "Test")],
            124: [#imageLiteral(resourceName: "Test")],
            // Equiptment (Ball) ---------
            125: [#imageLiteral(resourceName: "Test")],
            // Equiptment (Bar)
            126: [#imageLiteral(resourceName: "Test")],
            127: [#imageLiteral(resourceName: "Test")],
            128: [#imageLiteral(resourceName: "Test")],
            // Equiptment (Bench/Step)
            129: [#imageLiteral(resourceName: "Test")],
            130: [#imageLiteral(resourceName: "Test")],
            131: [#imageLiteral(resourceName: "Test")],
            132: [#imageLiteral(resourceName: "Test")],
            133: [#imageLiteral(resourceName: "Test")]
    ]
    
    // Target Area Array
    var targetAreaDictionaryGym: [Int: UIImage] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            0: #imageLiteral(resourceName: "Squat"),
            1: #imageLiteral(resourceName: "Squat"),
            2: #imageLiteral(resourceName: "Squat"),
            3: #imageLiteral(resourceName: "Squat"),
            4: #imageLiteral(resourceName: "Squat"),
            5: #imageLiteral(resourceName: "Squat"),
            // Legs (Hamstrings/Glutes)
            6: #imageLiteral(resourceName: "Deadlift"),
            7: #imageLiteral(resourceName: "Deadlift"),
            8: #imageLiteral(resourceName: "Deadlift"),
            9: #imageLiteral(resourceName: "Deadlift"),
            10: #imageLiteral(resourceName: "Rear Thigh"),
            11: #imageLiteral(resourceName: "Glute"),
            // Legs (General)
            12: #imageLiteral(resourceName: "Squat"),
            13: #imageLiteral(resourceName: "Squat"),
            14: #imageLiteral(resourceName: "Squat"),
            // Legs (Calves)
            15: #imageLiteral(resourceName: "Calf"),
            16: #imageLiteral(resourceName: "Calf"),
            // Pull (Back) ---------
            17: #imageLiteral(resourceName: "Test"),
            18: #imageLiteral(resourceName: "Back and Bicep"),
            19: #imageLiteral(resourceName: "Back and Bicep"),
            20: #imageLiteral(resourceName: "Back and Bicep"),
            21: #imageLiteral(resourceName: "Back and Bicep"),
            22: #imageLiteral(resourceName: "Back and Bicep"),
            23: #imageLiteral(resourceName: "Back, Bicep and Erector"),
            24: #imageLiteral(resourceName: "Back, Bicep and Erector"),
            25: #imageLiteral(resourceName: "Back, Bicep and Erector"),
            26: #imageLiteral(resourceName: "Back and Bicep"),
            27: #imageLiteral(resourceName: "Back and Bicep"),
            // Pull (Upper Back)
            28: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            29: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            30: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            31: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            // Pull (Rear Delts)
            32: #imageLiteral(resourceName: "Rear Delt"),
            // Pull (Traps)
            33: #imageLiteral(resourceName: "Trap"),
            // Pull (Biceps)
            34: #imageLiteral(resourceName: "Bicep"),
            35: #imageLiteral(resourceName: "Bicep"),
            36: #imageLiteral(resourceName: "Bicep"),
            37: #imageLiteral(resourceName: "Bicep"),
            // Pull (Forearms)
            38: #imageLiteral(resourceName: "Forearm"),
            39: #imageLiteral(resourceName: "Forearm"),
            40: #imageLiteral(resourceName: "Forearm"),
            // Push (Chest) ---------
            41: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            42: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            43: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            44: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            45: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            46: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            47: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            48: #imageLiteral(resourceName: "Pec and Front Delt"),
            49: #imageLiteral(resourceName: "Pec and Front Delt"),
            50: #imageLiteral(resourceName: "Pec and Front Delt"),
            // Push (Shoulders)
            51: #imageLiteral(resourceName: "Shoulder"),
            52: #imageLiteral(resourceName: "Shoulder"),
            53: #imageLiteral(resourceName: "Shoulder"),
            54: #imageLiteral(resourceName: "Shoulder"),
            // Push (Triceps)
            55: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            56: #imageLiteral(resourceName: "Tricep"),
            57: #imageLiteral(resourceName: "Tricep"),
            58: #imageLiteral(resourceName: "Tricep"),
            59: #imageLiteral(resourceName: "Tricep"),
            // Full Body
            60: #imageLiteral(resourceName: "Squat"),
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            61: #imageLiteral(resourceName: "Test"),
            62: #imageLiteral(resourceName: "Test"),
            63: #imageLiteral(resourceName: "Test"),
            64: #imageLiteral(resourceName: "Test"),
            65: #imageLiteral(resourceName: "Test"),
            66: #imageLiteral(resourceName: "Test"),
            68: #imageLiteral(resourceName: "Test"),
            69: #imageLiteral(resourceName: "Test"),
            70: #imageLiteral(resourceName: "Test"),
            // Legs (Hamstrings)
            71: #imageLiteral(resourceName: "Test"),
            72: #imageLiteral(resourceName: "Test"),
            // Legs (Glutes)
            73: #imageLiteral(resourceName: "Test"),
            74: #imageLiteral(resourceName: "Test"),
            75: #imageLiteral(resourceName: "Test"),
            76: #imageLiteral(resourceName: "Test"),
            77: #imageLiteral(resourceName: "Test"),
            // Legs (Calves)
            78: #imageLiteral(resourceName: "Test"),
            // Pull (Back) ---------
            79: #imageLiteral(resourceName: "Test"),
            80: #imageLiteral(resourceName: "Test"),
            81: #imageLiteral(resourceName: "Test"),
            82: #imageLiteral(resourceName: "Test"),
            83: #imageLiteral(resourceName: "Test"),
            84: #imageLiteral(resourceName: "Test"),
            85: #imageLiteral(resourceName: "Test"),
            86: #imageLiteral(resourceName: "Test"),
            // Pull (Traps)
            87: #imageLiteral(resourceName: "Test"),
            88: #imageLiteral(resourceName: "Test"),
            89: #imageLiteral(resourceName: "Test"),
            // Pull (Rear Delts)
            90: #imageLiteral(resourceName: "Test"),
            // Push (Chest) ---------
            91: #imageLiteral(resourceName: "Test"),
            // Push (Tricep)
            91: #imageLiteral(resourceName: "Test"),
            92: #imageLiteral(resourceName: "Test"),
            93: #imageLiteral(resourceName: "Test"),
            // Push (Chest & Tricep)
            94: #imageLiteral(resourceName: "Test"),
            // Push (Shoulder)
            95: #imageLiteral(resourceName: "Test"),
            96: #imageLiteral(resourceName: "Test"),
            97: #imageLiteral(resourceName: "Test"),
            98: #imageLiteral(resourceName: "Test"),
            // Core ---------
            99: #imageLiteral(resourceName: "Test"),
            100: #imageLiteral(resourceName: "Test"),
            101: #imageLiteral(resourceName: "Test"),
            102: #imageLiteral(resourceName: "Test"),
            103: #imageLiteral(resourceName: "Test"),
            104: #imageLiteral(resourceName: "Test"),
            105: #imageLiteral(resourceName: "Test"),
            106: #imageLiteral(resourceName: "Test"),
            107: #imageLiteral(resourceName: "Test"),
            // General (Core) ---------
            108: #imageLiteral(resourceName: "Test"),
            // General (Full Body)
            109: #imageLiteral(resourceName: "Test"),
            110: #imageLiteral(resourceName: "Test"),
            // General (Upper Body)
            111: #imageLiteral(resourceName: "Test"),
            112: #imageLiteral(resourceName: "Test"),
            // General (Cardio)
            113: #imageLiteral(resourceName: "Test"),
            114: #imageLiteral(resourceName: "Test"),
            115: #imageLiteral(resourceName: "Test"),
            116: #imageLiteral(resourceName: "Test"),
            // Isometric (Legs) ---------
            117: #imageLiteral(resourceName: "Test"),
            118: #imageLiteral(resourceName: "Test"),
            119: #imageLiteral(resourceName: "Test"),
            120: #imageLiteral(resourceName: "Test"),
            121: #imageLiteral(resourceName: "Test"),
            // Isometric (Upper Body)
            122: #imageLiteral(resourceName: "Test"),
            123: #imageLiteral(resourceName: "Test"),
            124: #imageLiteral(resourceName: "Test"),
            // Equiptment (Ball) ---------
            125: #imageLiteral(resourceName: "Test"),
            // Equiptment (Bar)
            126: #imageLiteral(resourceName: "Test"),
            127: #imageLiteral(resourceName: "Test"),
            128: #imageLiteral(resourceName: "Test"),
            // Equiptment (Bench/Step)
            129: #imageLiteral(resourceName: "Test"),
            130: #imageLiteral(resourceName: "Test"),
            131: #imageLiteral(resourceName: "Test"),
            132: #imageLiteral(resourceName: "Test"),
            133: #imageLiteral(resourceName: "Test")
        ]
    
    // Explanation Array
    var explanationDictionaryGym: [Int : String] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            0: "squatE",
            1: "frontSquatE",
            2: "hackSquatE",
            3: "legPressE",
            4: "dumbellFrontSquatE",
            5: "legExtensionsE",
            // Legs (Hamstrings/Glutes)
            6: "deadliftE",
            7: "romanianDeadliftE",
            8: "weightedHipThrustE",
            9: "legCurlE",
            10: "oneLeggedDeadliftE",
            11: "gluteIsolationMachineE",
            // Legs (General)
            12: "lungeDumbellE",
            13: "bulgarianSplitSquatE",
            14: "stepUpE",
            // Legs (Calves)
            15: "standingCalfRaiseE",
            16: "seatedCalfRaiseE",
            // Pull (Back) ---------
            17: "pullUpE",
            18: "pullDownE",
            19: "kneelingPullDownE",
            20: "pullDownMachineE",
            21: "hammerStrengthPullDownE",
            22: "bentOverRowBarbellE",
            23: "bentOverRowDumbellE",
            24: "tBarRowE",
            25: "rowMachineE",
            26: "hammerStrengthRowE",
            27: "latPulloverE",
            // Pull (Upper Back)
            28: "facePullE",
            29: "smithMachinePullUpE",
            30: "leaningBackPullDownE",
            31: "seatedMachineRowE",
            // Pull (Rear Delts)
            32: "bentOverBarbellRowE",
            // Pull (Traps)
            33: "shrugDumbellE",
            // Pull (Biceps)
            34: "hamerCurlE",
            35: "hammerCurlCableE",
            36: "cableCurlE",
            37: "curlE",
            // Pull (Forearms)
            38: "farmersCarryE",
            39: "reverseBarbellCurlE",
            40: "forearmCurlE",
            // Push (Chest) ---------
            41: "pushUpE",
            42: "benchPressE",
            43: "benchPressDumbellE",
            44: "semiInclineDumbellPressE",
            45: "hammerStrengthPressE",
            46: "chestPressE",
            47: "platePressE",
            48: "barbellKneelingPressE",
            49: "cableFlyE",
            50: "dipsE",
            // Push (Shoulders)
            51: "standingShoulderPressBarbellE",
            52: "standingShoulderPressDumbellE",
            53: "lateralRaiseE",
            54: "frontRaiseE",
            // Push (Triceps)
            55: "ballPushUpE",
            56: "trianglePushUpE",
            57: "closeGripBenchE",
            58: "cableExtensionE",
            59: "ropeExtensionE",
            // Full Body
            60: "cleanPressE",
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            61: "bodyweightSquatE",
            62: "pistolSquatE",
            63: "skaterSquatE",
            64: "squatJumpE",
            65: "sumoSquatE",
            66: "sumoSquatJumpE",
            67: "lungeE",
            68: "lungeJumpE",
            69: "stepUpE",
            // Legs (Hamstrings)
            70: "deadliftE",
            71: "singleLegDeadliftE",
            // Legs (Glutes)
            72: "gluteBridgeE",
            73: "singleLegGluteBridgeE",
            74: "kickBackE",
            75: "standingKickBackE",
            76: "standingSideKickE",
            // Legs (Calves)
            77: "calfRaiseE",
            // Pull (Back) ---------
            78: "contralateralLimbRaisesE",
            79: "superManE",
            80: "backHyperextensionE",
            81: "doorFrameRowE",
            82: "reverseSnowAngelsE",
            83: "elbowTorsoLiftE",
            84: "backBridgeE",
            85: "scapulaPushupE",
            // Pull (Traps)
            86: "handStandTrapE",
            87: "handStandShoulderTapE",
            88: "handStandWaistTapE",
            // Pull (Rear Delts)
            89: "bentOverArmCirclesE",
            // Push (Chest) ---------
            90: "pushupE",
            // Push (Tricep)
            91: "trianglePushupE",
            92: "dolphinPushupE",
            93: "tricepExtensionsBodyweightE",
            // Push (Chest & Tricep)
            94: "walkingPushupE",
            // Push (Shoulder)
            95: "downwardDogPushupE",
            96: "wallPushupE",
            97: "boxerE",
            98: "armCirclesE",
            // Core ---------
            99: "plankE",
            100: "dynamicPlankE",
            101: "sidePlankE",
            102: "pushupPlankE",
            103: "lSitE",
            104: "bicycleCrunchE",
            105: "divingHoldE",
            106: "hipRaiseE",
            107: "legHoldE",
            // General (Core) ---------
            108: "mountainClimbersE",
            // General (Full Body)
            109: "burpeeE",
            110: "kickThroughBurpeeE",
            // General (Upper Body)
            111: "spiderPushupE",
            112: "crabWalkE",
            // General (Cardio)
            113: "jumpingJacksE",
            114: "tuckJumpE",
            115: "bumKicksE",
            116: "kneeRaisesE",
            // Isometric (Legs) ---------
            117: "wallSitE",
            118: "chairHoldE",
            119: "toePressE",
            120: "staticLungeE",
            121: "calfRaiseE",
            // Isometric (Upper Body)
            122: "chestSqueezeE",
            123: "dolphinPlankE",
            124: "pullupHoldE",
            // Equiptment (Ball) ---------
            125: "ballPushupE",
            // Equiptment (Bar)
            126: "bodweightRowE",
            127: "pullupE",
            128: "hangingLegRaiseE",
            // Equiptment (Bench/Step)
            129: "tricepDipE",
            130: "bulgarianSplitSquatE",
            131: "boxJumpE",
            132: "hipThrustsE",
            133: "stepUpE"
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
    
    //
    // Push Body --------------------------------------------------------------------------------------------------------------------------
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
  
    var numberOfRoundsArrayGym: [[Int]] = []

    
    
    
//
// Gym Circuit -------------------------------------------------------------------------------------------------------------------------
//
    //
    // Full Body --------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    var presetsArrayCircuitFull: [[String]] =
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
    var presetsArraysCircuitFull: [[[Int]]] =
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
    var numberOfRoundsArrayCircuitFull: [[Int]] =
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
    var repsArrayCircuitFull: [[[[String]]]] =
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
    var presetsArrayCircuitUpper: [[String]] =
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
    var presetsArraysCircuitUpper: [[[Int]]] =
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
    var numberOfRoundsArrayCircuitUpper: [[Int]] =
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
    var repsArrayCircuitUpper: [[[[String]]]] =
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
    var presetsArrayCircuitLower: [[String]] =
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
    var presetsArraysCircuitLower: [[[Int]]] =
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
    var numberOfRoundsArrayCircuitLower: [[Int]] =
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
    var repsArrayCircuitLower: [[[[String]]]] =
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
// BodyWeight -------------------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------------------------
    // TableView Section Array
    var tableViewSectionArrayBodyweight: [String] =
        [
            "legsG",
            "hamstrings",
            "glutesW",
            "calves",
            "pullBa",
            "pullT",
            "pullRD",
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
            // Equiptment
            "equiptmentB",
            "equiptmentBa",
            "equiptmentBe"
    ]
    
    // Full Key Array
    var fullKeyArrayBodyweight: [[Int]] =
        [
            // Cardio
            [0],
            // Joint Rotations
            [1,
             2,
             3,
             4,
             5,
             6,
             7,
             8],
            // Foam/Ball Roll
            [9,
             10,
             11,
             12,
             13,
             14,
             15,
             16,
             17,
             18],
            // Lower Back
            [19,
             20,
             21,
             22,
             23],
            // Shoulder
            [24,
             25,
             26,
             27],
            // Band/Bar/Machine Assisted
            [28,
             29,
             30,
             31,
             32,
             33],
            // General Mobility
            [34,
             35,
             36,
             37,
             38,
             39,
             40,
             41,
             42,
             43,
             44],
            // Dynamic Warmup Drills
            [45,
             46,
             47,
             48,
             49,
             50,
             51,
             52,
             53],
            // Accessory
            [54,
             55,
             56,
             57]
    ]
    
    // Warmup Movements Dictionary
    var workoutMovementsDictionaryBodyweight: [Int : String] =
        [
            // Cardio
            0: "5minCardio",
            // Joint Rotations
            1: "wrist",
            2: "elbow",
            3: "shoulder",
            4: "neckR",
            5: "waist",
            6: "hip",
            7: "knees",
            8: "ankles",
            // Foam/Ball Roll
            9: "backf",
            10: "thoracicSpine",
            11: "lat",
            12: "pecDelt",
            13: "rearDelt",
            14: "quadf",
            15: "adductorf",
            16: "hamstringf",
            17: "glutef",
            18: "calvef",
            // Lower Back
            19: "sideLegDrop",
            20: "sideLegKick",
            21: "scorpionKick",
            22: "sideBend",
            23: "catCow",
            // Shoulder
            24: "wallSlides",
            25: "superManShoulder",
            26: "scapula",
            27: "shoulderRotation",
            // Band/Bar/Machine Assisted
            28: "facePull",
            29: "externalRotation",
            30: "internalRotation",
            31: "shoulderDislocation",
            32: "rearDeltFly",
            33: "latPullover",
            // General Mobility
            34: "rollBack",
            35: "hipCircles",
            36: "mountainClimber",
            37: "groinStretch",
            38: "gluteBridge",
            39: "threadTheNeedle",
            40: "butterflyPose",
            41: "cossakSquat",
            42: "hipHinges",
            43: "sideLegSwings",
            44: "frontLegSwings",
            // Dynamic Warmup Drills
            45: "jumpSquat",
            46: "lunge",
            47: "gluteKicks",
            48: "aSkips",
            49: "bSkips",
            50: "grapeVines",
            51: "lateralBound",
            52: "straightLegBound",
            53: "sprints",
            // Accessory
            54: "latStretch",
            55: "calveStretch",
            56: "pushUp",
            57: "pullUp"
    ]
    
    // Demonstration Array
    var demonstrationDictionaryBodyweight: [Int : UIImage] =
        [
            // Cardio
            0: #imageLiteral(resourceName: "Test 2"),
            // Joint Rotations
            1: #imageLiteral(resourceName: "Test 2"),
            2: #imageLiteral(resourceName: "Test 2"),
            3: #imageLiteral(resourceName: "Test 2"),
            4: #imageLiteral(resourceName: "Test 2"),
            5: #imageLiteral(resourceName: "Test 2"),
            6: #imageLiteral(resourceName: "Test 2"),
            7: #imageLiteral(resourceName: "Test 2"),
            8: #imageLiteral(resourceName: "Test 2"),
            // Foam/Ball Roll
            9: #imageLiteral(resourceName: "Test 2"),
            10: #imageLiteral(resourceName: "Test 2"),
            11: #imageLiteral(resourceName: "Test 2"),
            12: #imageLiteral(resourceName: "Test 2"),
            13: #imageLiteral(resourceName: "Test 2"),
            14: #imageLiteral(resourceName: "Test 2"),
            15: #imageLiteral(resourceName: "Test 2"),
            16: #imageLiteral(resourceName: "Test 2"),
            17: #imageLiteral(resourceName: "Test 2"),
            18: #imageLiteral(resourceName: "Test 2"),
            // Lower Back
            19: #imageLiteral(resourceName: "Test 2"),
            20: #imageLiteral(resourceName: "Test 2"),
            21: #imageLiteral(resourceName: "Test 2"),
            22: #imageLiteral(resourceName: "Test 2"),
            23: #imageLiteral(resourceName: "Test 2"),
            // Shoulder
            24: #imageLiteral(resourceName: "Test 2"),
            25: #imageLiteral(resourceName: "Test 2"),
            26: #imageLiteral(resourceName: "Test 2"),
            27: #imageLiteral(resourceName: "Test 2"),
            // Band/Bar/Machine Assisted
            28: #imageLiteral(resourceName: "Test 2"),
            29: #imageLiteral(resourceName: "Test 2"),
            30: #imageLiteral(resourceName: "Test 2"),
            31: #imageLiteral(resourceName: "Test 2"),
            32: #imageLiteral(resourceName: "Test 2"),
            33: #imageLiteral(resourceName: "Test 2"),
            // General Mobility
            34: #imageLiteral(resourceName: "Test 2"),
            35: #imageLiteral(resourceName: "Test 2"),
            36: #imageLiteral(resourceName: "Test 2"),
            37: #imageLiteral(resourceName: "Test 2"),
            38: #imageLiteral(resourceName: "Test 2"),
            39: #imageLiteral(resourceName: "Test 2"),
            40: #imageLiteral(resourceName: "Test 2"),
            41: #imageLiteral(resourceName: "Test 2"),
            42: #imageLiteral(resourceName: "Test 2"),
            43: #imageLiteral(resourceName: "Test 2"),
            44: #imageLiteral(resourceName: "Test 2"),
            // Dynamic Warm Up Drills
            45: #imageLiteral(resourceName: "Test 2"),
            46: #imageLiteral(resourceName: "Test 2"),
            47: #imageLiteral(resourceName: "Test 2"),
            48: #imageLiteral(resourceName: "Test 2"),
            49: #imageLiteral(resourceName: "Test 2"),
            50: #imageLiteral(resourceName: "Test 2"),
            51: #imageLiteral(resourceName: "Test 2"),
            52: #imageLiteral(resourceName: "Test 2"),
            53: #imageLiteral(resourceName: "Test 2"),
            // Accessory
            54: #imageLiteral(resourceName: "Test 2"),
            55: #imageLiteral(resourceName: "Test 2"),
            56: #imageLiteral(resourceName: "Test 2"),
            57: #imageLiteral(resourceName: "Test 2")
    ]
    
    // Target Area Array
    var targetAreaDictionaryBodyweight: [Int: UIImage] =
        [
            // Cardio
            0: #imageLiteral(resourceName: "Heart"),
            // Joint Rotations
            1: #imageLiteral(resourceName: "Wrist Joint"),
            2: #imageLiteral(resourceName: "Elbow Joint"),
            3: #imageLiteral(resourceName: "Shoulder Joint"),
            4: #imageLiteral(resourceName: "Neck Joint"),
            5: #imageLiteral(resourceName: "Waist Joint"),
            6: #imageLiteral(resourceName: "Hip Joint"),
            7: #imageLiteral(resourceName: "Knee Joint"),
            8: #imageLiteral(resourceName: "Ankle Joint"),
            // Foam/Ball Roll
            9: #imageLiteral(resourceName: "Thoracic"),
            10: #imageLiteral(resourceName: "Thoracic"),
            11: #imageLiteral(resourceName: "Lat and Delt"),
            12: #imageLiteral(resourceName: "Pec and Front Delt"),
            13: #imageLiteral(resourceName: "Rear Delt"),
            14: #imageLiteral(resourceName: "Quad"),
            15: #imageLiteral(resourceName: "Adductor"),
            16: #imageLiteral(resourceName: "Hamstring"),
            17: #imageLiteral(resourceName: "Glute"),
            18: #imageLiteral(resourceName: "Calf"),
            // Lower Back
            19: #imageLiteral(resourceName: "Core"),
            20: #imageLiteral(resourceName: "Core"),
            21: #imageLiteral(resourceName: "Core"),
            22: #imageLiteral(resourceName: "Core"),
            23: #imageLiteral(resourceName: "Spine"),
            // Shoulder
            24: #imageLiteral(resourceName: "Shoulder"),
            25: #imageLiteral(resourceName: "Back and Shoulder"),
            26: #imageLiteral(resourceName: "Serratus"),
            27: #imageLiteral(resourceName: "Shoulder"),
            // Band/Bar/Machine Assisted
            28: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            29: #imageLiteral(resourceName: "Rear Delt"),
            30: #imageLiteral(resourceName: "Rear Delt"),
            31: #imageLiteral(resourceName: "Shoulder"),
            32: #imageLiteral(resourceName: "Rear Delt"),
            33: #imageLiteral(resourceName: "Back"),
            // General Mobility
            34: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            35: #imageLiteral(resourceName: "Hip Area"),
            36: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            37: #imageLiteral(resourceName: "Adductor"),
            38: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            39: #imageLiteral(resourceName: "Piriformis"),
            40: #imageLiteral(resourceName: "Adductor"),
            41: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            42: #imageLiteral(resourceName: "Hamstring and Glute"),
            43: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            44: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            // Dynamic Warm Up Drills
            45: #imageLiteral(resourceName: "Squat"),
            46: #imageLiteral(resourceName: "Squat"),
            47: #imageLiteral(resourceName: "Squat"),
            48: #imageLiteral(resourceName: "Squat"),
            49: #imageLiteral(resourceName: "Squat"),
            50: #imageLiteral(resourceName: "Squat"),
            51: #imageLiteral(resourceName: "Squat"),
            52: #imageLiteral(resourceName: "Squat"),
            53: #imageLiteral(resourceName: "Squat"),
            // Accessory
            54: #imageLiteral(resourceName: "Lat"),
            55: #imageLiteral(resourceName: "Calf"),
            56: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            57: #imageLiteral(resourceName: "Back and Bicep")
    ]
    
    // Explanation Array
    var explanationDictionaryBodyweight: [Int : String] =
        [
            // Cardio
            0: "5minCardioL",
            // Joint Rotations
            1: "wristE",
            2: "elbowE",
            3: "shoulderE",
            4: "neckE",
            5: "waistE",
            6: "hipE",
            7: "kneesE",
            8: "anklesE",
            // Foam/Ball Roll
            9: "backfE",
            10: "thoracicSpineE",
            11: "latE",
            12: "pecDeltE",
            13: "rearDeltE",
            14: "quadfE",
            15: "adductorfE",
            16: "hamstringfE",
            17: "glutefE",
            18: "calvefE",
            // Back
            19: "sideLegDropE",
            20: "sideLegKickE",
            21: "scorpionKickE",
            22: "sideBendE",
            23: "catCowE",
            // Shoulder
            24: "wallSlidesE",
            25: "superManShoulderE",
            26: "scapulaE",
            27: "shoulderRotationE",
            // Band/Bar/Machine Assisted
            28: "facePullE",
            29: "externalRotationE",
            30: "internalRotationE",
            31: "shoulderDislocationE",
            32: "rearDeltFlyE",
            33: "latPulloverE",
            // General Mobility
            34: "rollBackE",
            35: "hipCirclesE",
            36: "mountainClimberE",
            37: "groinStretchE",
            38: "gluteBridgeE",
            39: "threadTheNeedleE",
            40: "butterflyPoseE",
            41: "cossakSquatE",
            42: "hipHingesE",
            43: "sideLegSwingsE",
            44: "frontLegSwingsE",
            // Dynamic Warm Up Drills
            45: "jumpSquatE",
            46: "lungeE",
            47: "gluteKicksE",
            48: "aSkipsE",
            49: "bSkipsE",
            50: "grapeVinesE",
            51: "lateralBoundE",
            52: "straightLegBoundE",
            53: "sprintsE",
            // Accessory
            54: "latStretchE",
            55: "calveStretchE",
            56: "pushUpE",
            57: "pullUpE"
    ]
    
    // Sets Dictionary
    var setsDictionaryBodyweight: [Int : Int] =
        [
            // Cardio
            0: 1,
            // Joint Rotations
            1: 1,
            2: 1,
            3: 1,
            4: 1,
            5: 1,
            6: 1,
            7: 1,
            8: 1,
            // Foam/Ball Roll
            9: 1,
            10: 3,
            11: 1,
            12: 1,
            13: 1,
            14: 1,
            15: 1,
            16: 1,
            17: 1,
            18: 1,
            // Lower Back
            19: 1,
            20: 1,
            21: 1,
            22: 1,
            23: 1,
            // Shoulder
            24: 2,
            25: 1,
            26: 1,
            27: 1,
            // Band/Bar/Machine Assisted
            28: 2,
            29: 1,
            30: 1,
            31: 1,
            32: 1,
            33: 1,
            // General Mobility
            34: 1,
            35: 1,
            36: 1,
            37: 1,
            38: 1,
            39: 2,
            40: 1,
            41: 1,
            42: 2,
            43: 1,
            44: 1,
            // Dynamic Warm Up Drills
            45: 2,
            46: 2,
            47: 3,
            48: 3,
            49: 3,
            50: 2,
            51: 2,
            52: 2,
            53: 4,
            // Accessory
            54: 1,
            55: 1,
            56: 1,
            57: 1
    ]
    
    // Reps Array
    var repsDictionaryBodyweight: [Int : String] =
        [
            // Mandatory
            0: "5min",
            // Joint Rotations
            1: "10-30s",
            2: "10-30s",
            3: "10-30s",
            4: "10-30s",
            5: "10-30s",
            6: "10-30s",
            7: "10-30s",
            8: "10-30s",
            // Foam/Ball Roll
            9: "2-7 reps",
            10: "5-10 reps",
            11: "2-7 reps",
            12: "15-30s",
            13: "15-30s",
            14: "2-7 reps",
            15: "2-7 reps",
            16: "2-7 reps",
            17: "2-7 reps",
            18: "2-7 reps",
            // Lower Back
            19: "5-10 reps",
            20: "5-10 reps",
            21: "5-10 reps",
            22: "5-10 reps",
            23: "15-20 reps",
            // Shoulder
            24: "10-20 reps",
            25: "5-10 reps",
            26: "15 reps",
            27: "10 reps",
            // Band/Bar/Machine Assisted
            28: "10-15 reps",
            29: "5-15 reps",
            30: "5-10 reps",
            31: "5-10 reps",
            32: "10-15 reps",
            33: "10-20 reps",
            // General Mobility
            34: "10-15 reps",
            35: "5-10 reps",
            36: "5-10 reps",
            37: "5-10 reps",
            38: "10-15 reps",
            39: "15-30s",
            40: "15-30s",
            41: "5-10 reps",
            42: "10-20 reps",
            43: "10-20 reps",
            44: "10-20 reps",
            // Dynamic Warm Up Drills
            45: "5-15 reps",
            46: "10-15 reps",
            47: "15-30s",
            48: "15-30s",
            49: "15-30s",
            50: "50m",
            51: "50m",
            52: "50m",
            53: "5-20 reps",
            // Accessory
            54 :"15-30s",
            55: "15-30s",
            56: NSLocalizedString("asNecessary", comment: ""),
            57: NSLocalizedString("asNecessary", comment: "")
        ]
    
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
    
    //
    var numberOfRoundsArrayBodyweightFull: [[Int]] =
        [
            [2,
             3],
            [4,
             3,
             5],
            [2,
             3]
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
    
    //
    var numberOfRoundsArrayBodyweightUpper: [[Int]] =
        [
            [2,
             3],
            [4,
             3,
             5],
            [2,
             3]
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
    
    //
    var numberOfRoundsArrayBodyweightLower: [[Int]] =
        [
            [2,
            3],
            [4,
            3,
            5],
            [2,
            3]
        ]
    
    
    
    
  
//
// Set Arrays --------------------------------------------------------------------------------------------------------------------------
//
    // Set Arrays Function
    func setArrays() {
        //
        // Set Dictionaries
//        switch workoutType {
//        //
//        case 0:
//            // Choice Screen Arrays
//            tableViewSectionArray = tableViewSectionArrayGym
//            fullKeyArray = fullKeyArrayGym
//            workoutMovementsDictionary = workoutMovementsDictionaryGym
//            demonstrationDictionary = demonstrationDictionaryGym
//            targetAreaDictionary = targetAreaDictionaryGym
//            explanationDictionary = explanationDictionaryGym
//            setsDictionary = setsDictionaryGym
//            repsDictionary = repsDictionaryGym
//            numberOfRoundsArray = numberOfRoundsArrayGym
//            //
//            // Set Presets
//            switch workoutType2 {
//            case 0:
//                presetsArray = presetsArrayGymFull
//                presetsArrays = presetsArraysGymFull
//            case 1:
//                presetsArray = presetsArrayGymUpper
//                presetsArrays = presetsArraysGymUpper
//            case 2:
//                presetsArray = presetsArrayGymLower
//                presetsArrays = presetsArraysGymLower
//            case 3:
//                presetsArray = presetsArrayGymLegs
//                presetsArrays = presetsArraysGymLegs
//            case 4:
//                presetsArray = presetsArrayGymPull
//                presetsArrays = presetsArraysGymPull
//            case 5:
//                presetsArray = presetsArrayGymPush
//                presetsArrays = presetsArraysGymPush
//            case 6:
//                presetsArray = presetsArrayGym5x5
//                presetsArrays = presetsArraysGym5x5
//            default: break
//            }
//        //
//        case 1:
//            // Choice Screen Arrays
//            tableViewSectionArray = tableViewSectionArrayCircuit
//            fullKeyArray = fullKeyArrayCircuit
//            workoutMovementsDictionary = workoutMovementsDictionaryCircuit
//            demonstrationDictionary = demonstrationDictionaryCircuit
//            targetAreaDictionary = targetAreaDictionaryCircuit
//            explanationDictionary = explanationDictionaryCircuit
//            setsDictionary = setsDictionaryCircuit
//            //
//            // Set Presets
//            switch workoutType2 {
//            case 0:
//                presetsArray = presetsArrayCircuitFull
//                presetsArrays = presetsArraysCircuitFull
//                numberOfRoundsArray = numberOfRoundsArrayCircuitFull
//            case 1:
//                presetsArray = presetsArrayCircuitUpper
//                presetsArrays = presetsArraysCircuitUpper
//                numberOfRoundsArray = numberOfRoundsArrayCircuitUpper
//            case 2:
//                presetsArray = presetsArrayCircuitLower
//                presetsArrays = presetsArraysCircuitLower
//                numberOfRoundsArray = numberOfRoundsArrayCircuitLower
//            default: break
//            }
//        //
//        case 2:
//            // Choice Screen Arrays
//            tableViewSectionArray = tableViewSectionArrayBodyweight
//            fullKeyArray = fullKeyArrayBodyweight
//            workoutMovementsDictionary = workoutMovementsDictionaryBodyweight
//            demonstrationDictionary = demonstrationDictionaryBodyweight
//            targetAreaDictionary = targetAreaDictionaryBodyweight
//            explanationDictionary = explanationDictionaryBodyweight
//            setsDictionary = setsDictionaryBodyweight
//            repsDictionary = repsDictionaryBodyweight
//            //
//            // Set Presets
//            switch workoutType2 {
//            case 0:
//                presetsArray = presetsArrayBodyweightFull
//                presetsArrays = presetsArraysBodyweightFull
//                numberOfRoundsArray = numberOfRoundsArrayBodyweightFull
//            case 1:
//                presetsArray = presetsArrayBodyweightUpper
//                presetsArrays = presetsArraysBodyweightUpper
//                numberOfRoundsArray = numberOfRoundsArrayBodyweightUpper
//            case 2:
//                presetsArray = presetsArrayBodyweightLower
//                presetsArrays = presetsArraysBodyweightLower
//                numberOfRoundsArray = numberOfRoundsArrayBodyweightLower
//            default: break
//            }
//        //
//        case 3:
//            //
//            // TO DO !!!!!!!!!!!
//            //
//            // Choice Screen Arrays
//            tableViewSectionArray = tableViewSectionArrayBodyweight
//            fullKeyArray = fullKeyArrayBodyweight
//            workoutMovementsDictionary = workoutMovementsDictionaryBodyweight
//            demonstrationDictionary = demonstrationDictionaryBodyweight
//            targetAreaDictionary = targetAreaDictionaryBodyweight
//            explanationDictionary = explanationDictionaryBodyweight
//            setsDictionary = setsDictionaryBodyweight
//            repsDictionary = repsDictionaryBodyweight
//            //
//            // Set Presets
//            switch workoutType2 {
//            case 0:
//                presetsArray = presetsArrayBodyweightFull
//                presetsArrays = presetsArraysBodyweightFull
//                numberOfRoundsArray = numberOfRoundsArrayBodyweightFull
//            case 1:
//                presetsArray = presetsArrayBodyweightUpper
//                presetsArrays = presetsArraysBodyweightUpper
//                numberOfRoundsArray = numberOfRoundsArrayBodyweightUpper
//            case 2:
//                presetsArray = presetsArrayBodyweightLower
//                presetsArrays = presetsArraysBodyweightLower
//                numberOfRoundsArray = numberOfRoundsArrayBodyweightLower
//            default: break
//            }
//        default: break
//        }
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
            if numberOfRoundsArray.count == 0 {
                //
                cell.textLabel?.text = NSLocalizedString(workoutMovementsDictionary[overviewArray[indexPath.section][indexPath.row]]!, comment: "")
                cell.detailTextLabel?.text = repsDictionary[overviewArray[indexPath.section][indexPath.row]]
                //
                cell.imageView?.image = demonstrationDictionary[overviewArray[indexPath.section][indexPath.row]]?[0]
            } else {
                cell.textLabel?.text = NSLocalizedString(workoutMovementsDictionary[roundArray[indexPath.row]]!, comment: "")
                cell.detailTextLabel?.text = repsDictionary[roundArray[indexPath.row]]
                //
                cell.imageView?.image = demonstrationDictionary[roundArray[indexPath.row]]?[0]
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
            sectionNumbers = [0, 1, 2, 3, 4, 5, 6, 7, 8]
            
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
        case 0: performSegue(withIdentifier: "workoutSessionSegue0", sender: nil)
        case 1,2: performSegue(withIdentifier: "workoutSessionSegue1", sender: nil)
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
                setsArray.append(setsDictionary[i]!)
                //
                repsArray.append(repsDictionary[i]!)
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
            //destinationVC.demonstrationArray = demonstrationArray
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
            destinationVC.repsArray = repsArrayCircuitFull[selectedPreset[0]][selectedPreset[1]]
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
