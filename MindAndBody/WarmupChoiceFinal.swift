//
//  WarmupChoiceFinal.swift
//  MindAndBody
//
//  Created by Luke Smith on 16.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Warmup Choice Class -------------------------------------------------------------------------------------------------------------
//
class WarmupChoiceFinal: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Selected Warmup Type
    //
    var warmupType = Int()
    
    // Selected Preset
    //
    var selectedPreset: [Int] = [0, 0]
    
    // Section Numbers (representing tableview section arrray, used to remove arrays with the arrays of arrays of keys, and to determine which sections are left)
    //
    var sectionNumbers: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    
//
// Arrays ------------------------------------------------------------------------------------------------------------------------------
//
    // 
    var overviewArray: [[Int]] = []
    
    //    
    // Picker View Array
    var presetsArray: [[String]] = []
    //
    var presetsArrays: [[[Int]]] = []
    //
    var presetSetsArray: [[[Int]]] = []
    //
    var presetRepsArray: [[[String]]] = []

    
    // Arrays to be set and used (Screen arrays)
    // Movements Array
    var warmupArray: [String] = []
    
    // Sets Array
    var setsArray: [Int] = []
    
    // Reps Array
    var repsArray: [String] = []
    
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
// Warmup Arrays --------------------------------------------------------------------------------------------------------------
    // TableView Section Array
    var tableViewSectionArray: [String] =
        [
            "cardio",
            "jointRotation",
            "foamRoll",
            "glutes",
            "lowerBack",
            "upperBack",
            "shoulder",
            "bandAssisted",
            "generalMobility",
            "dynamicWarmupDrills",
            "accessory"
    ]
    
    // Full Key Array
    var fullKeyArray: [[Int]] =
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
             18,
             19,
             20],
            // Glutes
            [21,
             22,
             23,
             24],
            // Lower Back
            [25,
             26,
             27,
             28,
             29,
             30],
            // Upper Back
            [31,
             32,
             33],
            // Shoulder
            [34,
             35,
             36,
             37,
             38,
             39],
            // Band/Bar/Machine Assisted
            [40,
             41,
             42,
             43,
             44],
            // General Mobility
            [45,
             46,
             47,
             48,
             49,
             50,
             51,
             52,
             53,
             54,
             55],
            // Dynamic Warmup Drills
            [56,
             57,
             58,
             59,
             60,
             61,
             62,
             63,
             64,
             65],
            // Accessory
            [66,
             67]
    ]
    
    // Warmup Movements Dictionary
    var warmupMovementsDictionary: [Int : String] =
        [
            // Cardio
            0: "5minCardio",
            // Joint Rotations
            1: "wrist",
            2: "elbow",
            3: "shoulderR",
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
            19: "itBand",
            20: "standOnBall",
            // Glutes
            21: "gluteBridgewW", ///
            22: "kneelingKickBackW", ///
            23: "legsToSideSquat", ///
            24: "standingGluteKickback", ///
            // Lower Back
            25: "sideLegDrop",
            26: "sideLegKick",
            27: "scorpionKick",
            28: "sideBend",
            29: "catCow",
            30: "legsToSideTwist", ///
            // Upper Back
            31: "upperBackRotation", ///
            32: "latStretch", ///
            33: "lyingSideWindmill", ///
            // Shoulder
            34: "wallSlides",
            35: "wallReaches",
            36: "shoulderRotationW",
            37: "forearmWallSlides135",
            38: "superManShoulder",
            39: "scapulaPushup",
            // Band/Bar/Machine Assisted
            40: "facePull",
            41: "externalRotation",
            42: "internalRotation",
            43: "shoulderDislocation",
            44: "latPullover",
            // General Mobility
            45: "seatedKneeDrop", ///
            46: "mountainClimber",
            47: "groinStretch",
            48: "threadTheNeedle",
            49: "butterflyPose",
            50: "cossakSquat",
            51: "hipHinges",
            52: "lungeTwist",
            53: "sideLegSwings",
            54: "frontLegSwings",
            55: "spiderManHipLiftOverheadReach",
            // Dynamic Warmup Drills
            56: "forefootBounces",
            57: "jumpSquat",
            58: "lunge",
            59: "gluteKicks",
            60: "aSkips",
            61: "bSkips",
            62: "grapeVines",
            63: "lateralBound",
            64: "straightLegBound",
            65: "sprints",
            // Accessory
            66: "pushUp",
            67: "pullUp"
    ]
    
    
    var demonstrationDictionary: [Int : [String]] =
        [
            // Cardio
            0: ["cardioWarmup"],
            // Joint Rotations
            1: ["wristRotations", "wristRotations1", "wristRotations2", "wristRotations1", "wristRotations2", "wristRotations3", "wristRotations4", "wristRotations3", "wristRotations4"],
            2: ["elbowRotations", "elbowRotations1", "elbowRotations2", "elbowRotations3", "elbowRotations4", "elbowRotations3", "elbowRotations2", "elbowRotations1"],
            3: ["shoulderRotations", "shoulderRotations1", "shoulderRotations2", "shoulderRotations3", "shoulderRotations4", "shoulderRotations5", "shoulderRotations6", "shoulderRotations1"],
            4: ["neckRotations", "neckRotations1", "neckRotations2", "neckRotations1", "neckRotations2", "neckRotations3", "neckRotations4", "neckRotations3", "neckRotations4"],
            5: ["waistRotations", "waistRotations1", "waistRotations2", "waistRotations3", "waistRotations4", "waistRotations5", "waistRotations6", "waistRotations1"],
            6: ["hipRotations", "hipRotations", "hipRotations2", "hipRotations3", "hipRotations4", "hipRotations5", "hipRotations6", "hipRotations7", "hipRotations1"],
            7: ["kneeRotations", "kneeRotations1", "kneeRotations2", "kneeRotations3", "kneeRotations2", "kneeRotations1", "kneeRotations4", "kneeRotations5", "kneeRotations4", "kneeRotations1"],
            8: ["ankleRotations", "ankleRotations1", "ankleRotations2", "ankleRotations1", "ankleRotations2", "ankleRotations3", "ankleRotations4", "ankleRotations3", "ankleRotations4"],
            // Foam/Ball Roll
            9: ["backFoam", "backFoam1", "backFoam2", "backFoam3", "backFoam4", "backFoam3", "backFoam2", "backFoam1"],
            10: ["thoracicSpineFoam", "thoracicSpineFoam1", "thoracicSpineFoam2", "thoracicSpineFoam3", "thoracicSpineFoam2", "thoracicSpineFoam1", "thoracicSpineFoam4", "thoracicSpineFoam5", "thoracicSpineFoam4", "thoracicSpineFoam1"],
            11: ["latFoam", "latFoam1", "latFoam2", "latFoam3", "latFoam4", "latFoam3", "latFoam2", "latFoam1"],
            12: ["pecDeltFoam"],
            13: ["rearDeltFoam"],
            14: ["quadFoam", "quadFoam1", "quadFoam2", "quadFoam3", "quadFoam4", "quadFoam3", "quadFoam2", "quadFoam1", "quadFoam5", "quadFoam6", "quadFoam5"],
            15: ["adductorFoam", "adductorFoam1", "adductorFoam2", "adductorFoam3", "adductorFoam2", "adductorFoam1"],
            16: ["hamstringFoam", "hamstringFoam1", "hamstringFoam2", "hamstringFoam3", "hamstringFoam4", "hamstringFoam3", "hamstringFoam2", "hamstringFoam1"],
            17: ["gluteFoam", "gluteFoam1", "gluteFoam2", "gluteFoam3", "gluteFoam4", "gluteFoam3", "gluteFoam2", "gluteFoam1"],
            18: ["calveFoam", "calveFoam1", "calveFoam2", "calveFoam3", "calveFoam2", "calveFoam1", "calveFoam2", "calveFoam3", "calveFoam4", "calveFoam5", "calveFoam4", "calveFoam3", "calveFoam2", "calveFoam1"],
            19: ["itBandFoam", "itBandFoam1", "itBandFoam2", "itBandFoam3", "itBandFoam2", "itBandFoam1"],
            20: ["standingOnBall"],
            // Glutes
            21: ["gluteBridgeW", "gluteBridgeW1", "gluteBridgeW2", "gluteBridgeW3", "gluteBridgeW3", "gluteBridgeW2", "gluteBridgeW1", "gluteBridgeW2", "gluteBridgeW3", "gluteBridgeW3", "gluteBridgeW2", "gluteBridgeW1"],
            22: ["kneelingHipRotations", "kneelingHipRotations1", "kneelingHipRotations2", "kneelingHipRotations3", "kneelingHipRotations2", "kneelingHipRotations1", "kneelingHipRotations4", "kneelingHipRotations5", "kneelingHipRotations6", "kneelingHipRotations7", "kneelingHipRotations1", "kneelingHipRotations8", "kneelingHipRotations9", "kneelingHipRotations10", "kneelingHipRotations9", "kneelingHipRotations8", "kneelingHipRotations1", "kneelingHipRotations7", "kneelingHipRotations6", "kneelingHipRotations5", "kneelingHipRotations4", "kneelingHipRotations1", "kneelingHipRotations2", "kneelingHipRotations3", "kneelingHipRotations2", "kneelingHipRotations1"],
            23: ["legsToSideSquat", "legsToSideSquat1", "legsToSideSquat2", "legsToSideSquat3", "legsToSideSquat4", "legsToSideSquat3", "legsToSideSquat2", "legsToSideSquat1"],
            24: ["standingGluteKickback", "standingGluteKickback1", "standingGluteKickback2", "standingGluteKickback3", "standingGluteKickback3", "standingGluteKickback2", "standingGluteKickback1"],
            // Lower Back
            25: ["legDrop", "legDrop1", "legDrop2", "legDrop1", "legDrop", "legDrop1", "legDrop2", "legDrop1"],
            26: ["sideLegKick", "sideLegKick1", "sideLegKick2", "sideLegKick1", "sideLegKick", "sideLegKick1", "sideLegKick2", "sideLegKick1"],
            27: ["scorpionKick", "scorpionKick1", "scorpionKick2", "scorpionKick1", "scorpionKick", "scorpionKick1", "scorpionKick2", "scorpionKick1"],
            28: ["sideBend", "sideBend1", "sideBend2", "sideBend1", "sideBend", "sideBend1", "sideBend2", "sideBend1"],
            29: ["catCowS", "catCowS1", "catCowS2", "catCowS1", "catCowS3", "catCowS1", "catCowS2", "catCowS1"],
            30: ["legsToSideTwist", "legsToSideTwist1", "legsToSideTwist2", "legsToSideTwist3", "legsToSideTwist4", "legsToSideTwist4", "legsToSideTwist3", "legsToSideTwist2", "legsToSideTwist1", "legsToSideTwist1"],
            // Upper Back
            31: ["upperBackRotation", "upperBackRotation1", "upperBackRotation2", "upperBackRotation1", "upperBackRotation", "upperBackRotation1", "upperBackRotation2", "upperBackRotation1"],
            32: ["latStretch"],
            33: ["lyingSideWindmill", "lyingSideWindmill1", "lyingSideWindmill2", "lyingSideWindmill3", "lyingSideWindmill4", "lyingSideWindmill1", "lyingSideWindmill2", "lyingSideWindmill3", "lyingSideWindmill4"],
            // Shoulder
            34: ["wallSlides", "wallSlides1", "wallSlides2", "wallSlides1", "wallSlides", "wallSlides1", "wallSlides2", "wallSlides1"],
            35: ["wallReaches", "wallReaches1", "wallReaches2", "wallReaches1", "wallReaches", "wallReaches1", "wallReaches2", "wallReaches1"],
            36: ["shoulderRotationW", "shoulderRotationW1", "shoulderRotationW2", "shoulderRotationW1", "shoulderRotationW", "shoulderRotationW1", "shoulderRotationW2", "shoulderRotationW1"],
            37: ["forearmWallSlides135", "forearmWallSlides1351", "forearmWallSlides1352", "forearmWallSlides1351", "forearmWallSlides135", "forearmWallSlides1351", "forearmWallSlides1352", "forearmWallSlides1351"],
            38: ["superManShoulder", "superManShoulder1", "superManShoulder2", "superManShoulder3", "superManShoulder4", "superManShoulder4", "superManShoulder3", "superManShoulder2", "superManShoulder1", "superManShoulder1"],
            39: ["scapulaPushup", "scapulaPushup1", "scapulaPushup", "scapulaPushup1", "scapulaPushup", "scapulaPushup1"],
            // Band/Bar/Machine Assisted
            40: ["facePull", "facePull1", "facePull2", "facePull3", "facePull4", "facePull5", "facePull5", "facePull4", "facePull3", "facePull2", "facePull1"],
            41: ["externalRotation", "externalRotation1", "externalRotation2", "externalRotation3", "externalRotation4", "externalRotation4", "externalRotation3", "externalRotation2", "externalRotation1"],
            42: ["internalRotation", "internalRotation1", "internalRotation2", "internalRotation3", "internalRotation4", "internalRotation4", "internalRotation3", "internalRotation2", "internalRotation1"],
            43: ["shoulderDislocation", "shoulderDislocation1", "shoulderDislocation2", "shoulderDislocation1", "shoulderDislocation", "shoulderDislocation3", "shoulderDislocation", "shoulderDislocation1", "shoulderDislocation2", "shoulderDislocation1", "shoulderDislocation", "shoulderDislocation3"],
            44: ["latPullover", "latPullover1", "latPullover2", "latPullover3", "latPullover2", "latPullover1"],
            // General Mobility
            45: ["seatedKneeDrop", "seatedKneeDrop1", "seatedKneeDrop2", "seatedKneeDrop3", "seatedKneeDrop4", "seatedKneeDrop3", "seatedKneeDrop2", "seatedKneeDrop1"],
            46: ["mountainClimber", "mountainClimber3", "mountainClimber2", "mountainClimber1", "mountainClimber2", "mountainClimber3", "mountainClimber4", "mountainClimber5", "mountainClimber4", "mountainClimber3"],
            47: ["groinStretch"],
            48: ["threadTheNeedleS"],
            49: ["butterflyPoseS"],
            50: ["cossakSquat", "cossakSquat4", "cossakSquat1", "cossakSquat2", "cossakSquat3", "cossakSquat2", "cossakSquat1", "cossakSquat4", "cossakSquat5", "cossakSquat6", "cossakSquat7", "cossakSquat6", "cossakSquat5", "cossakSquat4"],
            51: ["hipHinges", "hipHinges1", "hipHinges2", "hipHinges3", "hipHinges4", "hipHinges4", "hipHinges3", "hipHinges2", "hipHinges1", "hipHinges1"],
            52: ["lungeTwist", "lungeTwist1", "lungeTwist2", "lungeTwist3", "lungeTwist4", "lungeTwist5", "lungeTwist6", "lungeTwist5", "lungeTwist4", "lungeTwist7", "lungeTwist8", "lungeTwist9", "lungeTwist10", "lungeTwist11", "lungeTwist12", "lungeTwist13", "lungeTwist12", "lungeTwist11", "lungeTwist14", "lungeTwist15"],
            53: ["sideLegSwings", "sideLegSwings1", "sideLegSwings2", "sideLegSwings3", "sideLegSwings4", "sideLegSwings3", "sideLegSwings2", "sideLegSwings1", "sideLegSwings5", "sideLegSwings1", "sideLegSwings2", "sideLegSwings3", "sideLegSwings4"],
            54: ["frontLegSwings", "frontLegSwings1", "frontLegSwings2", "frontLegSwings3", "frontLegSwings4", "frontLegSwings3", "frontLegSwings2", "frontLegSwings1", "frontLegSwings5", "frontLegSwings1", "frontLegSwings2", "frontLegSwings3", "frontLegSwings4"],
            55: ["spiderManOverheadReach", "spiderManOverheadReach1", "spiderManOverheadReach2", "spiderManOverheadReach3", "spiderManOverheadReach4", "spiderManOverheadReach5", "spiderManOverheadReach4", "spiderManOverheadReach3", "spiderManOverheadReach6", "spiderManOverheadReach7", "spiderManOverheadReach6", "spiderManOverheadReach3", "spiderManOverheadReach2", "spiderManOverheadReach1"],
            // Dynamic Warmup Drills
            56: ["forefootBounces", "forefootBounces1", "forefootBounces2", "forefootBounces3", "forefootBounces2", "forefootBounces1", "forefootBounces1", "forefootBounces3", "forefootBounces2", "forefootBounces1"],
            57: ["jumpSquat", "jumpSquat1", "jumpSquat2", "jumpSquat3", "jumpSquat4", "jumpSquat5", "jumpSquat4", "jumpSquat3", "jumpSquat2", "jumpSquat1"],
            58: ["lunge", "lunge1", "lunge2", "lunge3", "lunge4", "lunge3", "lunge2", "lunge1", "lunge5", "lunge6", "lunge7", "lunge6", "lunge5", "lunge1"],
            59: ["bumKicks", "bumKicks1", "bumKicks2", "bumKicks3", "bumKicks4", "bumKicks3", "bumKicks2", "bumKicks1"],
            60: ["aSkips", "aSkips1", "aSkips2", "aSkips3", "aSkips2", "aSkips1", "aSkips4", "aSkips5", "aSkips4", "aSkips1"],
            61: ["bSkips", "bSkips1", "bSkips2", "bSkips3", "bSkips4", "bSkips5", "bSkips6", "bSkips7", "bSkips8", "bSkips9", "bSkips10", "bSkips11"],
            62: ["grapeVines"],
            63: ["lateralBound", "lateralBound1", "lateralBound2", "lateralBound3", "lateralBound4", "lateralBound5", "lateralBound", "lateralBound6", "lateralBound7", "lateralBound8", "lateralBound9"],
            64: ["straightLegBound", "straightLegBound1", "straightLegBound2", "straightLegBound3", "straightLegBound4", "straightLegBound", "straightLegBound5", "straightLegBound6", "straightLegBound7", "straightLegBound8"],
            65: ["sprints"],
            // Accessory
            66: ["pushUp", "pushUp1", "pushUp2", "pushUp3", "pushUp4", "pushUp4", "pushUp3", "pushUp2", "pushUp1"],
            67: ["pullUp", "pullUp1", "pullUp2", "pullUp3", "pullUp4", "pullUp4", "pullUp3", "pullUp2", "pullUp1"]
    ]
    
    
    // Target Area Array
    var targetAreaDictionary: [Int: String] =
        [
            // Cardio
            0: "heart",
            // Joint Rotations
            1: "wrist",
            2: "elbow",
            3: "shoulder",
            4: "neckJoint",
            5: "waist",
            6: "hip",
            7: "knee",
            8: "ankle",
            // Foam/Ball Roll
            9: "thoracic",
            10: "thoracic",
            11: "latDelt",
            12: "pecFrontDelt",
            13: "rearDelt",
            14: "quad",
            15: "adductor",
            16: "hamstring",
            17: "glute",
            18: "calf",
            19: "calf",
            20: "calf",
            // Glutes
            21: "glute",
            22: "glute",
            23: "glute",
            24: "glute",
            // Lower Back
            25: "core",
            26: "core",
            27: "core",
            28: "core",
            29: "spine",
            30: "core",
            // Upper Back
            31: "upperBackShoulder",
            32: "lat",
            33: "upperBackShoulder",
            // Shoulder
            34: "shouler",
            35: "shouler",
            36: "shouler",
            37: "shouler",
            38: "backShoulder",
            39: "serratus",
            // Band/Bar/Machine Assisted
            40: "upperBackShoulder",
            41: "rearDelt",
            42: "rearDelt",
            43: "shoulder",
            44: "back",
            // General Mobility
            45: "hipArea",
            46: "hipArea",
            47: "quadHamstringGluteStretch",
            48: "adductor",
            49: "hamstringLowerBack",
            50: "piriformis",
            51: "adductor",
            52: "quadHamstringGluteStretch",
            53: "hamstringGlute",
            54: "quadHamstringGluteStretch",
            55: "quadHamstringGluteStretch",
            // Dynamic Warm Up Drills
            56: "calf",
            57: "squatBody",
            58: "squatBody",
            59: "squatBody",
            60: "squatBody",
            61: "squatBody",
            62: "squatBody",
            63: "squatBody",
            64: "squatBody",
            65: "squatBody",
            // Accessory
            66: "chestFrontDeltTricep",
            67: "backBicep"
    ]
    
    // Explanation Array
    var explanationDictionary: [Int : String] =
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
            19: "itBandE",
            20: "standOnBallE",
            // Glutes
            21: "gluteBridgewWE", ///
            22: "kneelingKickBackWE", ///
            23: "legsToSideSquatE", ///
            24: "standingGluteKickbackE", ///
            // Lower Back
            25: "sideLegDropE",
            26: "sideLegKickE",
            27: "scorpionKickE",
            28: "sideBendE",
            29: "catCowE",
            30: "legsToSideTwistE", ///
            // Upper Back
            31: "upperBackRotationE", ///
            32: "latStretchE", ///
            33: "lyingSideWindmillE", ///
            // Shoulder
            34: "wallSlidesE",
            35: "wallReachesE",
            36: "shoulderRotationWE",
            37: "forearmWallSlides135E",
            38: "superManShoulderE",
            39: "scapulaPushupE",
            // Band/Bar/Machine Assisted
            40: "facePullE",
            41: "externalRotationE",
            42: "internalRotationE",
            43: "shoulderDislocationE",
            44: "latPulloverE",
            // General Mobility
            45: "seatedKneeDropE", ///
            46: "mountainClimberE",
            47: "groinStretchE",
            48: "threadTheNeedleE",
            49: "butterflyPoseE",
            50: "cossakSquatE",
            51: "hipHingesE",
            52: "lungeTwistE",
            53: "sideLegSwingsE",
            54: "frontLegSwingsE",
            55: "spiderManHipLiftOverheadReachE",
            // Dynamic Warmup Drills
            56: "forefootBouncesE",
            57: "jumpSquatE",
            58: "lungeE",
            59: "gluteKicksE",
            60: "aSkipsE",
            61: "bSkipsE",
            62: "grapeVinesE",
            63: "lateralBoundE",
            64: "straightLegBoundE",
            65: "sprintsE",
            // Accessory
            66: "pushUpE",
            67: "pullUpE"
    ]

    
//
//
// Full ----------------------------------------------------------------------------------------------------------------------------
//
    // Presets Arrys
    //
    // Picker View Array
    var presetsArrayFull: [[String]] =
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
    var presetsArraysFull: [[[Int]]] =
        [
            [
                [],
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
    var presetSetsArrayFull: [[[Int]]] =
        [
            [
                [],
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
    var presetRepsArrayFull: [[[String]]] =
        [
            [
                [],
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
// Upper ----------------------------------------------------------------------------------------------------------------------------
//
    // Picker View Array
    var presetsArrayUpper: [[String]] =
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
    var presetsArraysUpper: [[[Int]]] =
        [
            [
                // Default
                [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67],
                // Beginner
                [0, 15, 18, 20, 23, 27, 30, 31]
            ],
            [
                // BodyWeight
                [0, 15, 16, 17, 19, 20, 22, 23, 30, 31, 32],
                // Bodybuilding
                [0, 10, 12, 14, 15, 16, 17, 20, 23, 24, 25, 29, 30, 31, 32],
                // Strength
                [0, 11, 12, 14, 15, 17, 19, 20, 22, 23,24, 25, 27, 29,30, 31, 32]
            ],
            [
                // High Intensity
                [1, 10, 12, 15, 16, 17, 19, 20, 23, 24, 25, 28, 29, 30, 31, 32],
                // Quick
                [0, 10, 15, 19, 20, 23, 24, 27, 30]
            ]
        ]
    
    // Sets Arrays
    var presetSetsArrayUpper: [[[Int]]] =
        [
            [
                // Default
                [1,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2],
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
    var presetRepsArrayUpper: [[[String]]] =
        [
            [
                // Default
                ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"],
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
// Lower --------------------------------------------------------------------------------------------------------------------------
//
        // Picker View Array
    var presetsArrayLower: [[String]] =
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
    var presetsArraysLower: [[[Int]]] =
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
    var presetSetsArrayLower: [[[Int]]] =
        [
            [
                [],
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
    var presetRepsArrayLower: [[[String]]] =
        [
            [
                [],
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
// Cardio ----------------------------------------------------------------------------------------------------------------------------
//
    // Picker View Array
    var presetsArrayCardio: [[String]] =
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
    var presetsArraysCardio: [[[Int]]] =
        [
            [
                [],
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
    var presetSetsArrayCardio: [[[Int]]] =
        [
            [
                [],
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
    var presetRepsArrayCardio: [[[String]]] =
        [
            [
                [],
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
    

    
    
    // Set Arrays Function
    func setArrays() {
        //
        switch warmupType {
        //
        case 0:
            // Choice Screen Arrays
            presetsArray = presetsArrayFull
            presetsArrays = presetsArraysFull
            presetSetsArray = presetSetsArrayFull
            presetRepsArray = presetRepsArrayFull
        //
        case 1:
            // Choice Screen Arrays
            presetsArray = presetsArrayUpper
            presetsArrays = presetsArraysUpper
            presetSetsArray = presetSetsArrayUpper
            presetRepsArray = presetRepsArrayUpper
        //
        case 2:
            // Choice Screen Arrays
            presetsArray = presetsArrayLower
            presetsArrays = presetsArraysLower
            presetSetsArray = presetSetsArrayLower
            presetRepsArray = presetRepsArrayLower
        //
        case 3:
            // Choice Screen Arrays
            presetsArray = presetsArrayCardio
            presetsArrays = presetsArraysCardio
            presetSetsArray = presetSetsArrayCardio
            presetRepsArray = presetRepsArrayCardio
        //
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
    
    
//
// View Will Appear
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presetsButton.setTitle(NSLocalizedString("selectWarmup", comment: ""), for: .normal)
        
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
        
        //
        // Set Arrays
        setArrays()
        
        // Colour
        view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString(navigationTitles[warmupType], comment: ""))
        
        //
        presetsButton.backgroundColor = colour2
        presetsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //
        movementsTableView.tableFooterView = UIView()
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = colour3
        beginButton.setTitleColor(colour2, for: .normal)
        //
        
        
        
        
        
        
        // Initial Element Positions
        //
        presetsConstraint.constant = 0
        //
        tableConstraint1.constant = view.frame.size.height
        tableConstraint.constant = -49
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
        tableViewBackground2.backgroundColor = colour1
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        
        presetsTableView.tableFooterView = UIView()
        
            
        // Presets TableView
        //
        // Movement tabl
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
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Select
        self.presetsButton.sendActions(for: .touchUpInside)

        //
        // Automatic Selection
        if automaticSelectionIsHappening == true {
            automaticSelectionProgress = 2
            //
            let sessions: [[Int]] =
                [[0,0], [0,1],
                 [1,0], [1,1],
                 [2,0], [2,1]]
            //
            presetsButton.sendActions(for: .touchUpInside)
            let test = automaticSelectionProgress
            //
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + AnimationTimes.animationTime1) {
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
            return overviewArray.count
        case presetsTableView:
            return 3
        default: break
        }
    return 0
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case movementsTableView:
            return NSLocalizedString(tableViewSectionArray[sectionNumbers[section]], comment: "")
        case presetsTableView:
            return "   " + "Test"
        default: break
        }
    return ""
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        switch tableView {
        case movementsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        case presetsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
            header.textLabel?.textAlignment = .left
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        default: break
    }
    }

    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case movementsTableView:
            return overviewArray[section].count
        case presetsTableView:
            return 2
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
            cell.textLabel?.text = NSLocalizedString(warmupMovementsDictionary[overviewArray[indexPath.section][indexPath.row]]!, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            // Get index of element
            let indexSetsReps = presetsArrays[selectedPreset[0]][selectedPreset[1]].index(of: overviewArray[indexPath.section][indexPath.row])
            // Sets x Reps
            cell.detailTextLabel?.text = String(presetSetsArray[selectedPreset[0]][selectedPreset[1]][indexSetsReps!]) + " x " + presetRepsArray[selectedPreset[0]][selectedPreset[1]][indexSetsReps!]
            //
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 18)
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.textAlignment = .left
            cell.detailTextLabel?.textColor = colour2
            //
            // Cell Image
            cell.imageView?.image = getUncachedImage(named: (demonstrationDictionary[overviewArray[indexPath.section][indexPath.row]]?[0])!)
            
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
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 20)
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
            sectionNumbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
            
            
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
            
            presetsButton.setTitle("- " + NSLocalizedString(presetsArray[indexPath.section][indexPath.row], comment: "") + " -", for: .normal)
            presetsTableView.deselectRow(at: indexPath, animated: true)
            
            //
            let tableHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            let tableWidth = UIScreen.main.bounds.width - 20
            
            //
            // Dismiss Action Sheet
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: tableWidth, height: tableHeight)
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
            // Animate new elements into page
            UIView.animate(withDuration: AnimationTimes.animationTime3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
            })

        default: break
        }
        
        //
        // MARK: Walkthrough
        if UserDefaults.standard.bool(forKey: "finalChoiceWalkthrough") == false {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + AnimationTimes.animationTime3, execute: {
                self.walkthroughFinalChoice()
            })
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
        if (segue.identifier == "warmupSessionSegue") {
            //
            let destinationVC = segue.destination as! SessionScreen
            
            // Ensure array in ascending order
            // Compress Arrays
            for i in presetsArrays[selectedPreset[0]][selectedPreset[1]] {
                //
                warmupArray.append(warmupMovementsDictionary[i]!)
                //
                demonstrationArray.append(demonstrationDictionary[i]!)
                //
                targetAreaArray.append(targetAreaDictionary[i]!)
                //
                explanationArray.append(explanationDictionary[i]!)
            }
            //
            destinationVC.sessionArray = warmupArray
            destinationVC.setsArray = presetSetsArray[selectedPreset[0]][selectedPreset[1]]
            destinationVC.repsArray = presetRepsArray[selectedPreset[0]][selectedPreset[1]]
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = 0
            //
            destinationVC.sessionTitle = presetsArray[selectedPreset[0]][selectedPreset[1]]
        }
    }

    
    
    //
    // MARK: Walkthrough ------------------------------------------------------------------------------------------------------------------
    //
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabel = UILabel()
    var nextButton = UIButton()
    
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["finalChoice0", "finalChoice1", "finalChoice2"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    var highlightColor = UIColor()
    
    // Walkthrough
    func walkthroughFinalChoice() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughFinalChoice), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
        // First has to be done differently
        // Preset Session
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = colour1
            walkthroughLabel.backgroundColor = colour2
            walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width / 2, height: 36)
            walkthroughHighlight.center = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.combinedHeight + (73.5 / 2))
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Overview
        case 1:
            //
            highlightSize = CGSize(width: view.bounds.width, height: (view.bounds.height - 73.5 - 49))
            highlightCenter = CGPoint(x: (view.bounds.width / 2), y: TopBarHeights.combinedHeight + 73.5 + ((view.bounds.height - 73.5 - 49) / 2))
            highlightCornerRadius = 3
            //
            labelFrame = 1
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour2
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
            
        // Begin
        case 2:
            //
            highlightSize = CGSize(width: view.bounds.width / 3, height: 36)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y:  view.frame.maxY - 24.5)
            highlightCornerRadius = 0
            //
            labelFrame = 1
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour2
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
           
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                UserDefaults.standard.set(true, forKey: "finalChoiceWalkthrough")
            })
        }
    }
    
    
//
}
