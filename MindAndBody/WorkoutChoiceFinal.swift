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
    var demonstrationArray: [[String]] = []
    
    // Target Area Array
    var targetAreaArray: [String] = []
    
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
            "pushCT", //!!!!!!!!!
            "pushS",
            "coreAbs",
            // General
            "generalC",
            "generalF",
            "generalU",
            "cardio",
            // Isometric
            "isometricL",
            "isometricU", //!!!!!!!!!
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
    var demonstrationDictionary: [Int : [String]] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            0: ["squat", "squat1", "squat2", "squat3", "squat2", "squat1"],
            1: ["frontSquat", "frontSquat1", "frontSquat2", "frontSquat3", "frontSquat2", "frontSquat1"],
            2: ["legPress", "legPress4", "legPress3", "legPress2", "legPress1", "legPress2", "legPress3", "legPress4"],
            3: ["dumbellFrontSquat", "dumbellFrontSquat1", "dumbellFrontSquat", "dumbellFrontSquat1"],
            4: ["legExtensions", "legExtensions1", "legExtensions2", "legExtensions3", "legExtensions2", "legExtensions1"],
            // Legs (Hamstrings/Glutes)
            5: ["deadlift", "deadlift1", "deadlift2", "deadlift3", "deadlift4", "deadlift5", "deadlift6", "deadlift7", "deadlift4", "deadlift2"],
            6: ["romanianDeadlift", "romanianDeadlift1", "romanianDeadlift2", "romanianDeadlift3", "romanianDeadlift2", "romanianDeadlift1"],
            7: ["weightedHipThrust", "weightedHipThrust1", "weightedHipThrust", "weightedHipThrust1"],
            8: ["legCurl", "legCurl1", "legCurl2", "legCurl3", "legCurl2", "legCurl1"],
            9: ["oneLeggedDeadlift", "oneLeggedDeadlift1", "oneLeggedDeadlift2", "oneLeggedDeadlift3", "oneLeggedDeadlift4", "oneLeggedDeadlift3", "oneLeggedDeadlift2", "oneLeggedDeadlift1"],
            10: ["gluteIsolationMachine", "gluteIsolationMachine1", "gluteIsolationMachine", "gluteIsolationMachine1"],
            // Legs (General)
            11: ["lungeDumbell", "lungeDumbell1", "lungeDumbell2", "lungeDumbell3", "lungeDumbell4", "lungeDumbell5", "lungeDumbell6", "lungeDumbell7", "lungeDumbell1", "lungeDumbell8", "lungeDumbell9", "lungeDumbell10", "lungeDumbell11", "lungeDumbell12", "lungeDumbell13", "lungeDumbell1"],
            12: ["bulgarianSplitSquat", "bulgarianSplitSquat1", "bulgarianSplitSquat", "bulgarianSplitSquat1"],
            13: ["stepUp", "stepUp1", "stepUp2", "stepUp3", "stepUp2", "stepUp1"],
            // Legs (Calves)
            14: ["standingCalfRaise", "standingCalfRaise1", "standingCalfRaise", "standingCalfRaise1"],
            15: ["seatedCalfRaise", "seatedCalfRaise1", "seatedCalfRaise", "seatedCalfRaise1"],
            // Pull (Back) ---------
            16: ["pullDown", "pullDown1", "pullDown2", "pullDown3", "pullDown4", "pullDown5", "pullDown5", "pullDown4", "pullDown3", "pullDown2", "pullDown1"],
            17: ["kneelingPullDown", "kneelingPullDown1", "kneelingPullDown2", "kneelingPullDown3", "kneelingPullDown4", "kneelingPullDown4", "kneelingPullDown3", "kneelingPullDown2", "kneelingPullDown1"],
            18: ["pullDownMachine", "pullDownMachine1", "pullDownMachine", "pullDownMachine1"],
            19: ["bentOverRowBarbell", "bentOverRowBarbell1", "bentOverRowBarbell2", "bentOverRowBarbell3", "bentOverRowBarbell4", "bentOverRowBarbell5", "bentOverRowBarbell5", "bentOverRowBarbell4", "bentOverRowBarbell3", "bentOverRowBarbell2"],
            20: ["bentOverRowDumbell", "bentOverRowDumbell1", "bentOverRowDumbell2", "bentOverRowDumbell3", "bentOverRowDumbell4", "bentOverRowDumbell5", "bentOverRowDumbell5", "bentOverRowDumbell4", "bentOverRowDumbell3", "bentOverRowDumbell2"],
            21: ["tBarRow", "tBarRow1", "tBarRow2", "tBarRow3", "tBarRow4", "tBarRow4", "tBarRow3", "tBarRow2", "tBarRow1"],
            22: ["rowMachine", "rowMachine1", "rowMachine2", "rowMachine3", "rowMachine4", "rowMachine4", "rowMachine3", "rowMachine2", "rowMachine1"],
            23: ["latPullover", "latPullover1", "latPullover2", "latPullover3", "latPullover2", "latPullover1"],
            // Pull (Upper Back)
            24: ["facePull", "facePull1", "facePull2", "facePull3", "facePull4", "facePull5", "facePull5", "facePull4", "facePull3", "facePull2", "facePull1"],
            25: ["leaningBackPullDown", "leaningBackPullDown1", "leaningBackPullDown2", "leaningBackPullDown3", "leaningBackPullDown4", "leaningBackPullDown4", "leaningBackPullDown3", "leaningBackPullDown2", "leaningBackPullDown1"],
            // Pull (Rear Delts)
            26: ["bentOverBarbellRow", "bentOverBarbellRow1", "bentOverBarbellRow", "bentOverBarbellRow1"],
            // Pull (Traps)
            27: ["shrugDumbell", "shrugDumbell1", "shrugDumbell", "shrugDumbell1"],
            // Pull (Biceps)
            28: ["hammerCurl", "hammerCurl1", "hammerCurl2", "hammerCurl3", "hammerCurl3", "hammerCurl2", "hammerCurl1", "hammerCurl4", "hammerCurl5", "hammerCurl5", "hammerCurl4", "hammerCurl1"],
            29: ["hammerCurlCable", "hammerCurlCable1", "hammerCurlCable2", "hammerCurlCable3", "hammerCurlCable3", "hammerCurlCable2", "hammerCurlCable1"],
            30: ["curl", "curl1", "curl2", "curl3", "curl3", "curl2", "curl1", "curl4", "curl5", "curl5", "curl4", "curl1"],
            // Pull (Forearms)
            31: ["farmersCarry"],
            32: ["reverseBarbellCurl", "reverseBarbellCurl1", "reverseBarbellCurl", "reverseBarbellCurl1"],
            33: ["forearmCurl", "forearmCurl1", "forearmCurl2", "forearmCurl1", "forearmCurl", "forearmCurl", "forearmCurl1", "forearmCurl2", "forearmCurl1"],
            // Push (Chest) ---------
            34: ["benchPress", "benchPress1", "benchPress2", "benchPress3", "benchPress4", "benchPress5", "benchPress5", "benchPress4", "benchPress3", "benchPress2"],
            35: ["benchPressDumbell", "benchPressDumbell4", "benchPressDumbell3", "benchPressDumbell2", "benchPressDumbell1", "benchPressDumbell1", "benchPressDumbell2", "benchPressDumbell3", "benchPressDumbell4"],
            36: ["semiInclineDumbellPress", "semiInclineDumbellPress4", "semiInclineDumbellPress3", "semiInclineDumbellPress2", "semiInclineDumbellPress1", "semiInclineDumbellPress1", "semiInclineDumbellPress2", "semiInclineDumbellPress3", "semiInclineDumbellPress4"],
            37: ["chestPress", "chestPress1", "chestPress", "chestPress1"],
            38: ["platePress", "platePress1", "platePress", "platePress1"],
            39: ["barbellKneelingPress", "barbellKneelingPress1", "barbellKneelingPress", "barbellKneelingPress1"],
            40: ["cableFly", "cableFly1", "cableFly2", "cableFly3", "cableFly4", "cableFly3", "cableFly2", "cableFly1", "cableFly1"],
            41: ["dips", "dips1", "dips", "dips1"],
            // Push (Shoulders)
            42: ["standingShoulderPressBarbell", "standingShoulderPressBarbell1", "standingShoulderPressBarbell2", "standingShoulderPressBarbell2", "standingShoulderPressBarbell1"],
            43: ["standingShoulderPressDumbell", "standingShoulderPressDumbell1", "standingShoulderPressDumbell2", "standingShoulderPressDumbell2", "standingShoulderPressDumbell1"],
            44: ["lateralRaise", "lateralRaise1", "lateralRaise2", "lateralRaise3", "lateralRaise4", "lateralRaise4", "lateralRaise3", "lateralRaise2", "lateralRaise1"],
            45: ["frontRaise", "frontRaise1", "frontRaise2", "frontRaise3", "frontRaise4", "frontRaise4", "frontRaise3", "frontRaise2", "frontRaise1"],
            // Push (Triceps)
            46: ["closeGripBench", "closeGripBench1", "closeGripBench2", "closeGripBench3", "closeGripBench4", "closeGripBench5", "closeGripBench5", "closeGripBench4", "closeGripBench3", "closeGripBench2"],
            47: ["cableExtension", "cableExtension1", "cableExtension2", "cableExtension3", "cableExtension3", "cableExtension2", "cableExtension1"],
            48: ["ropeExtensions", "ropeExtensions1", "ropeExtensions2", "ropeExtensions3", "ropeExtensions3", "ropeExtensions2", "ropeExtensions1"],
            // Full Body
            49: ["cleanPress", "cleanPress1", "cleanPress2", "cleanPress3", "cleanPress4", "cleanPress5", "cleanPress6", "cleanPress5", "cleanPress4", "cleanPress3", "cleanPress2", "cleanPress1"],
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            50: ["bodyweightSquat", "bodyweightSquat1", "bodyweightSquat2", "bodyweightSquat3", "bodyweightSquat4", "bodyweightSquat5", "bodyweightSquat5", "bodyweightSquat4", "bodyweightSquat3", "bodyweightSquat2", "bodyweightSquat3", "bodyweightSquat4", "bodyweightSquat5", "bodyweightSquat5", "bodyweightSquat4", "bodyweightSquat3", "bodyweightSquat2",],
            51: ["pistolSquat", "pistolSquat1", "pistolSquat2", "pistolSquat3", "pistolSquat4", "pistolSquat5", "pistolSquat5", "pistolSquat4", "pistolSquat3", "pistolSquat2", "pistolSquat1"],
            52: ["skaterSquat", "skaterSquat1", "skaterSquat2", "skaterSquat3", "skaterSquat4", "skaterSquat4", "skaterSquat3", "skaterSquat2", "skaterSquat1"],
            53: ["jumpSquat", "jumpSquat1", "jumpSquat2", "jumpSquat3", "jumpSquat4", "jumpSquat5", "jumpSquat4", "jumpSquat3", "jumpSquat2", "jumpSquat1"],
            54: ["sumoSquat", "sumoSquat1", "sumoSquat2", "sumoSquat3", "sumoSquat4", "sumoSquat4", "sumoSquat3", "sumoSquat2"],
            55: ["lunge", "lunge1", "lunge2", "lunge3", "lunge4", "lunge3", "lunge2", "lunge1", "lunge5", "lunge6", "lunge7", "lunge6", "lunge5", "lunge1"],
            56: ["lungeJump", "lungeJump1", "lungeJump2", "lungeJump3", "lungeJump4", "lungeJump5", "lungeJump6", "lungeJump7", "lungeJump6", "lungeJump5", "lungeJump4", "lungeJump3", "lungeJump2", "lungeJump1"],
            // Legs (Hamstrings)
            57: ["bodyweightDeadlift", "bodyweightDeadlift1", "bodyweightDeadlift2", "bodyweightDeadlift3", "bodyweightDeadlift4", "bodyweightDeadlift3", "bodyweightDeadlift2", "bodyweightDeadlift1", "bodyweightDeadlift1"],
            58: ["singleLegDeadlift", "singleLegDeadlift1", "singleLegDeadlift2", "singleLegDeadlift3", "singleLegDeadlift4", "singleLegDeadlift3", "singleLegDeadlift2", "singleLegDeadlift1"],
            // Legs (Glutes)
            59: ["gluteBridgeW", "gluteBridgeW1", "gluteBridgeW2", "gluteBridgeW3", "gluteBridgeW3", "gluteBridgeW2", "gluteBridgeW1", "gluteBridgeW2", "gluteBridgeW3", "gluteBridgeW3", "gluteBridgeW2", "gluteBridgeW1"],
            60: ["singleLegGluteBridge", "singleLegGluteBridge1", "singleLegGluteBridge2", "singleLegGluteBridge3", "singleLegGluteBridge3", "singleLegGluteBridge2", "singleLegGluteBridge1"],
            61: ["kneelingHipRotations", "kneelingHipRotations8", "kneelingHipRotations9", "kneelingHipRotations10", "kneelingHipRotations10", "kneelingHipRotations9", "kneelingHipRotations8"],
            62: ["standingGluteKickback", "standingGluteKickback1", "standingGluteKickback2", "standingGluteKickback3", "standingGluteKickback3", "standingGluteKickback2", "standingGluteKickback1"],
            // Legs (Calves)
            63: ["calfRaise", "calfRaise1", "calfRaise", "calfRaise1"],
            // Pull (Back) ---------
            64: ["contralateralLimbRaises", "contralateralLimbRaises1", "contralateralLimbRaises2", "contralateralLimbRaises3", "contralateralLimbRaises3", "contralateralLimbRaises2", "contralateralLimbRaises1", "contralateralLimbRaises4", "contralateralLimbRaises5", "contralateralLimbRaises5", "contralateralLimbRaises4", "contralateralLimbRaises1"],
            65: ["superMan"],
            66: ["backHyperextension", "backHyperextension1", "backHyperextension2", "backHyperextension3", "backHyperextension4", "backHyperextension4", "backHyperextension3", "backHyperextension2", "backHyperextension1"],
            67: ["doorFrameRow", "doorFrameRow1", "doorFrameRow2", "doorFrameRow2", "doorFrameRow1"],
            68: ["reverseSnowAngels", "reverseSnowAngels1", "reverseSnowAngels2", "reverseSnowAngels3", "reverseSnowAngels4", "reverseSnowAngels4", "reverseSnowAngels3", "reverseSnowAngels2", "reverseSnowAngels1"],
            69: ["scapulaPushup", "scapulaPushup1", "scapulaPushup", "scapulaPushup1", "scapulaPushup", "scapulaPushup1"],
            // Pull (Traps)
            70: ["handStandTrap", "handStandTrap1", "handStandTrap", "handStandTrap1"],
            // Push (Chest) ---------
            71: ["pushUp", "pushUp1", "pushUp2", "pushUp3", "pushUp4", "pushUp4", "pushUp3", "pushUp2", "pushUp1"],
            // Push (Tricep)
            72: ["trianglePushup", "trianglePushup1", "trianglePushup2", "trianglePushup3", "trianglePushup4", "trianglePushup4", "trianglePushup3", "trianglePushup2", "trianglePushup1"],
            73: ["dolphinPushup", "dolphinPushup1", "dolphinPushup2", "dolphinPushup3", "dolphinPushup4", "dolphinPushup3", "dolphinPushup2", "dolphinPushup1"],
            74: ["tricepExtensionsBodyweight", "tricepExtensionsBodyweight1", "tricepExtensionsBodyweight", "tricepExtensionsBodyweight1"],
            // Push (Chest & Tricep)
            75: ["walkingPushup", "walkingPushup1", "walkingPushup2", "walkingPushup1", "walkingPushup3", "walkingPushup4", "walkingPushup5", "walkingPushup4", "walkingPushup3", "walkingPushup1", "walkingPushup2", "walkingPushup1", "walkingPushup6", "walkingPushup7", "walkingPushup8", "walkingPushup7", "walkingPushup6", "walkingPushup1", "walkingPushup2", "walkingPushup1"],
            // Push (Shoulder)
            76: ["downwardDogPushup", "downwardDogPushup1", "downwardDogPushup2", "downwardDogPushup3", "downwardDogPushup4", "downwardDogPushup5", "downwardDogPushup6", "downwardDogPushup7", "downwardDogPushup8", "downwardDogPushup1"],
            77: ["handStandTrap1"],
            78: ["boxer2", "boxer", "boxer1", "boxer2", "boxer1", "boxer", "boxer3", "boxer4", "boxer3", "boxer1"],
            79: ["armCircles"],
            // Core ---------
            80: ["plank"],
            81: ["dynamicPlank", "dynamicPlank1", "dynamicPlank", "dynamicPlank1"],
            82: ["sidePlank"],
            83: ["pushupPlank"],
            84: ["lSit"],
            85: ["bicycleCrunch", "bicycleCrunch1", "bicycleCrunch2", "bicycleCrunch3", "bicycleCrunch4", "bicycleCrunch3", "bicycleCrunch2", "bicycleCrunch1"],
            86: ["divingHold"],
            87: ["hipRaise", "hipRaise1", "hipRaise", "hipRaise1"],
            88: ["legHold"],
            // General (Core) ---------
            89: ["mountainClimber", "mountainClimber3", "mountainClimber2", "mountainClimber1", "mountainClimber2", "mountainClimber3", "mountainClimber4", "mountainClimber5", "mountainClimber4", "mountainClimber3"],
            // General (Full Body)
            90: ["burpee3", "burpee2", "burpee1", "burpee", "burpee1", "burpee2", "burpee3", "burpee4", "burpee5", "burpee6", "burpee5", "burpee4", "burpee3", "burpee2"],
            91: ["kickThroughBurpee7", "kickThroughBurpee2", "kickThroughBurpee1", "kickThroughBurpee", "kickThroughBurpee1", "kickThroughBurpee2", "kickThroughBurpee3", "kickThroughBurpee4", "kickThroughBurpee5", "kickThroughBurpee4", "kickThroughBurpee6", "kickThroughBurpee7", "kickThroughBurpee6", "kickThroughBurpee4", "kickThroughBurpee8", "kickThroughBurpee9", "kickThroughBurpee8", "kickThroughBurpee4", "kickThroughBurpee3", "kickThroughBurpee2"],
            // General (Upper Body)
            92: ["spiderPushup4", "spiderPushup", "spiderPushup1", "spiderPushup2", "spiderPushup3", "spiderPushup4", "spiderPushup3", "spiderPushup2", "spiderPushup1", "spiderPushup", "spiderPushup1", "spiderPushup2", "spiderPushup5", "spiderPushup6", "spiderPushup5", "spiderPushup2", "spiderPushup1", "spiderPushup"],
            93: ["crabWalk", "crabWalk1", "crabWalk2", "crabWalk3", "crabWalk4", "crabWalk5", "crabWalk6"],
            // General (Cardio)
            94: ["jumpingJacks3", "jumpingJacks", "jumpingJacks1", "jumpingJacks2", "jumpingJacks3", "jumpingJacks4", "jumpingJacks3", "jumpingJacks2", "jumpingJacks1", "jumpingJacks"],
            95: ["tuckJump3", "tuckJump", "tuckJump1", "tuckJump2", "tuckJump3", "tuckJump2", "tuckJump1", "tuckJump"],
            96: ["bumKicks", "bumKicks1", "bumKicks2", "bumKicks3", "bumKicks4", "bumKicks3", "bumKicks2", "bumKicks1"],
            97: ["kneeRaises", "kneeRaises1", "kneeRaises2", "kneeRaises3", "kneeRaises4", "kneeRaises3", "kneeRaises2", "kneeRaises1"],
            // Isometric (Legs) ---------
            98: ["wallSit"],
            99: ["toePress"],
            100: ["lungeJump"],
            // Isometric (Upper Body)
            101: ["chestSqueeze"],
            102: ["pushupHold"],
            103: ["pullUp"],
            // Equiptment (Ball) ---------
            104: ["ballPushup", "ballPushup1", "ballPushup", "ballPushup1"],
            // Equiptment (Bar)
            105: ["bodyweightRow", "bodyweightRow1", "bodyweightRow", "bodyweightRow1"],
            106: ["pullUp", "pullUp1", "pullUp2", "pullUp3", "pullUp4", "pullUp4", "pullUp3", "pullUp2", "pullUp1"],
            107: ["hangingLegRaises", "hangingLegRaises1", "hangingLegRaises2", "hangingLegRaises3", "hangingLegRaises4", "hangingLegRaises3", "hangingLegRaises2", "hangingLegRaises1"],
            // Equiptment (Bench/Step)
            108: ["tricepDip", "tricepDip1", "tricepDip2", "tricepDip3", "tricepDip4", "tricepDip3", "tricepDip2", "tricepDip1"],
            109: ["bulgarianSplitSquat", "bulgarianSplitSquat1", "bulgarianSplitSquat", "bulgarianSplitSquat1"],
            110: ["boxJump"],
            111: ["hipThrusts", "hipThrusts1", "hipThrusts", "hipThrusts1"],
            112: ["stepUp", "stepUp1", "stepUp2", "stepUp3", "stepUp2", "stepUp1"]
    ]
    
    // Demonstration Array
    var targetAreaDictionary: [Int : String] =
        [
            // Gym ------------------------------------
            // Legs (Quads) ---------
            0: "squatBody",
            1: "squatBody",
            2: "squatBody",
            3: "squatBody",
            4: "squatBody",
            // Legs (Hamstrings/Glutes)
            5: "deadlift",
            6: "deadlift",
            7: "deadlift",
            8: "deadlift",
            9: "rearThigh",
            10: "glute",
            // Legs (General)
            11: "squatBody",
            12: "squatBody",
            13: "squatBody",
            // Legs (Calves)
            14: "calf",
            15: "calf",
            // Pull (Back) ---------
            16: "backBicep",
            17: "backBicep",
            18: "backBicep",
            19: "backBicep",
            20: "backBicepErector",
            21: "backBicepErector",
            22: "backBicepErector",
            23: "backBicep",
            // Pull (Upper Back)
            24: "upperBackShoulder",
            25: "upperBackShoulder",
            // Pull (Rear Delts)
            26: "rearDelt",
            // Pull (Traps)
            27: "trap",
            // Pull (Biceps)
            28: "bicep",
            29: "bicep",
            30: "bicep",
            // Pull (Forearms)
            31: "forearm",
            32: "forearm",
            33: "forearm",
            // Push (Chest) ---------
            34: "chestFrontDeltTricep",
            35: "chestFrontDeltTricep",
            36: "chestFrontDeltTricep",
            37: "chestFrontDeltTricep",
            38: "chestFrontDeltTricep",
            39: "pecFrontDelt",
            40: "pecFrontDelt",
            41: "pecFrontDelt",
            // Push (Shoulders)
            42: "shoulder",
            43: "shoulder",
            44: "shoulder",
            45: "shoulder",
            // Push (Triceps)
            46: "tricep",
            47: "tricep",
            48: "tricep",
            // Full Body
            49: "squatBody",
            // BodyWeight ------------------------------------
            // Legs (General) ---------
            50: "squatBody",
            51: "squatBody",
            52: "squatBody",
            53: "squatBody",
            54: "squatBody",
            55: "squatBody",
            56: "squatBody",
            // Legs (Hamstrings)
            57: "squatBody",
            58: "squatBody",
            // Legs (Glutes)
            59: "squatBody",
            60: "squatBody",
            61: "squatBody",
            62: "squatBody",
            // Legs (Calves)
            63: "squatBody",
            // Pull (Back) ---------
            64: "squatBody",
            65: "squatBody",
            66: "squatBody",
            67: "squatBody",
            68: "squatBody",
            69: "squatBody",
            // Pull (Traps)
            70: "squatBody",
            // Push (Chest) ---------
            71: "squatBody",
            // Push (Tricep)
            72: "squatBody",
            73: "squatBody",
            74: "squatBody",
            // Push (Chest & Tricep)
            75: "squatBody",
            // Push (Shoulder)
            76: "squatBody",
            77: "squatBody",
            78: "squatBody",
            79: "squatBody",
            // Core ---------
            80: "squatBody",
            81: "squatBody",
            82: "squatBody",
            83: "squatBody",
            84: "squatBody",
            85: "squatBody",
            86: "squatBody",
            87: "squatBody",
            88: "squatBody",
            // General (Core) ---------
            89: "squatBody",
            // General (Full Body)
            90: "squatBody",
            91: "squatBody",
            // General (Upper Body)
            92: "squatBody",
            93: "squatBody",
            // General (Cardio)
            94: "squatBody",
            95: "squatBody",
            96: "squatBody",
            97: "squatBody",
            // Isometric (Legs) ---------
            98: "squatBody",
            99: "squatBody",
            100: "squatBody",
            // Isometric (Upper Body)
            101: "squatBody",
            102: "squatBody",
            103: "squatBody",
            // Equiptment (Ball) ---------
            104: "squatBody",
            // Equiptment (Bar)
            105: "squatBody",
            106: "squatBody",
            107: "squatBody",
            // Equiptment (Bench/Step)
            108: "squatBody",
            109: "squatBody",
            110: "squatBody",
            111: "squatBody",
            112: "squatBody"
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
                [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,112],
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
                [1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1],
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
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"],
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
        
        // Device Scale for @2x and @3x of Target Area Images
        switch UIScreen.main.scale {
        case 1,2:
            for i in 0...targetAreaDictionary.count - 1 {
                targetAreaDictionary[i] = targetAreaDictionary[i]! + "@2x"
            }
        case 3:
            for i in 0...targetAreaDictionary.count - 1 {
                targetAreaDictionary[i] = targetAreaDictionary[i]! + "@3x"
            }
        default: break
        }
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Automatic Selection
        if automaticSelectionIsHappening == true {
            automaticSelectionProgress = 4
            //
            let sessions: [[Int]] =
                [[0,0], [0,1],
                 [1,0], [1,1],
                 [2,0], [2,1]]
            //
            presetsButton.sendActions(for: .touchUpInside)
            let test = automaticSelectionProgress
            //
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationTime1) {
                let selectedSession = automaticSelectionArray[automaticSelectionProgress]
                let indexPath = NSIndexPath(row: sessions[selectedSession][0], section: sessions[selectedSession][1])
                self.presetsTableView.selectRow(at: indexPath as IndexPath, animated: true, scrollPosition: .top)
                self.presetsTableView.delegate?.tableView!(self.presetsTableView, didSelectRowAt: indexPath as IndexPath)
                
                automaticSelectionIsHappening = false
                noInteractionView.removeFromSuperview()
            }
        }
        
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
                cell.imageView?.image = getUncachedImage(named: (demonstrationDictionary[overviewArray[indexPath.section][indexPath.row]]?[0])!)
            case 1,2:
                cell.textLabel?.text = NSLocalizedString(workoutMovementsDictionary[roundArray[indexPath.row]]!, comment: "")
                cell.detailTextLabel?.text = repsArrayCircuit[indexPath.section][indexPath.row]
                //
                cell.imageView?.image = getUncachedImage(named: (demonstrationDictionary[roundArray[indexPath.row]]?[0])!)
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
