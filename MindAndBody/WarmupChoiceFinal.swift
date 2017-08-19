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
    
    // Demonstration Array
    var demonstrationDictionary: [Int : [UIImage]] =
        [
            // Cardio
            0: [#imageLiteral(resourceName: "Test 2")],
            // Joint Rotations
            1: [#imageLiteral(resourceName: "wristRotations"), #imageLiteral(resourceName: "wristRotations1"), #imageLiteral(resourceName: "wristRotations2"), #imageLiteral(resourceName: "wristRotations1"), #imageLiteral(resourceName: "wristRotations2"), #imageLiteral(resourceName: "wristRotations3"), #imageLiteral(resourceName: "wristRotations4"), #imageLiteral(resourceName: "wristRotations3"), #imageLiteral(resourceName: "wristRotations4")],
            2: [#imageLiteral(resourceName: "elbowRotations"), #imageLiteral(resourceName: "elbowRotations1"), #imageLiteral(resourceName: "elbowRotations2"), #imageLiteral(resourceName: "elbowRotations3"), #imageLiteral(resourceName: "elbowRotations4"), #imageLiteral(resourceName: "elbowRotations3"), #imageLiteral(resourceName: "elbowRotations2"), #imageLiteral(resourceName: "elbowRotations1")],
            3: [#imageLiteral(resourceName: "shoulderRotations"), #imageLiteral(resourceName: "shoulderRotations1"), #imageLiteral(resourceName: "shoulderRotations2"), #imageLiteral(resourceName: "shoulderRotations3"), #imageLiteral(resourceName: "shoulderRotations4"), #imageLiteral(resourceName: "shoulderRotations5"), #imageLiteral(resourceName: "shoulderRotations6"), #imageLiteral(resourceName: "shoulderRotations1")],
            4: [#imageLiteral(resourceName: "neckRotations"), #imageLiteral(resourceName: "neckRotations1"), #imageLiteral(resourceName: "neckRotations2"), #imageLiteral(resourceName: "neckRotations1"), #imageLiteral(resourceName: "neckRotations2"), #imageLiteral(resourceName: "neckRotations3"), #imageLiteral(resourceName: "neckRotations4"), #imageLiteral(resourceName: "neckRotations3"), #imageLiteral(resourceName: "neckRotations4")],
            5: [#imageLiteral(resourceName: "waistRotations"), #imageLiteral(resourceName: "waistRotations1"), #imageLiteral(resourceName: "waistRotations2"), #imageLiteral(resourceName: "waistRotations3"), #imageLiteral(resourceName: "waistRotations4"), #imageLiteral(resourceName: "waistRotations5"), #imageLiteral(resourceName: "waistRotations6"), #imageLiteral(resourceName: "waistRotations1")],
            6: [#imageLiteral(resourceName: "hipRotations"), #imageLiteral(resourceName: "hipRotations1"), #imageLiteral(resourceName: "hipRotations2"), #imageLiteral(resourceName: "hipRotations3"), #imageLiteral(resourceName: "hipRotations4"), #imageLiteral(resourceName: "hipRotations5"), #imageLiteral(resourceName: "hipRotations6"), #imageLiteral(resourceName: "hipRotations7"), #imageLiteral(resourceName: "hipRotations1")],
            7: [#imageLiteral(resourceName: "kneeRotations"), #imageLiteral(resourceName: "kneeRotations1"), #imageLiteral(resourceName: "kneeRotations2"), #imageLiteral(resourceName: "kneeRotations3"), #imageLiteral(resourceName: "kneeRotations2"), #imageLiteral(resourceName: "kneeRotations1"), #imageLiteral(resourceName: "kneeRotations4"), #imageLiteral(resourceName: "kneeRotations5"), #imageLiteral(resourceName: "kneeRotations4"), #imageLiteral(resourceName: "kneeRotations1")],
            8: [#imageLiteral(resourceName: "ankleRotations"), #imageLiteral(resourceName: "ankleRotations1"), #imageLiteral(resourceName: "ankleRotations2"), #imageLiteral(resourceName: "ankleRotations1"), #imageLiteral(resourceName: "ankleRotations2"), #imageLiteral(resourceName: "ankleRotations3"), #imageLiteral(resourceName: "ankleRotations4"), #imageLiteral(resourceName: "ankleRotations3"), #imageLiteral(resourceName: "ankleRotations4")],
            // Foam/Ball Roll
            9: [#imageLiteral(resourceName: "backFoam"), #imageLiteral(resourceName: "backFoam1"), #imageLiteral(resourceName: "backFoam2"), #imageLiteral(resourceName: "backFoam3"), #imageLiteral(resourceName: "backFoam4"), #imageLiteral(resourceName: "backFoam3"), #imageLiteral(resourceName: "backFoam2"), #imageLiteral(resourceName: "backFoam1")],
            10: [#imageLiteral(resourceName: "thoracicSpineFoam"), #imageLiteral(resourceName: "thoracicSpineFoam1"), #imageLiteral(resourceName: "thoracicSpineFoam2"), #imageLiteral(resourceName: "thoracicSpineFoam3"), #imageLiteral(resourceName: "thoracicSpineFoam2"), #imageLiteral(resourceName: "thoracicSpineFoam1"), #imageLiteral(resourceName: "thoracicSpineFoam4"), #imageLiteral(resourceName: "thoracicSpineFoam5"), #imageLiteral(resourceName: "thoracicSpineFoam4"), #imageLiteral(resourceName: "thoracicSpineFoam1")],
            11: [#imageLiteral(resourceName: "latFoam"), #imageLiteral(resourceName: "latFoam1"), #imageLiteral(resourceName: "latFoam2"), #imageLiteral(resourceName: "latFoam3"), #imageLiteral(resourceName: "latFoam4"), #imageLiteral(resourceName: "latFoam3"), #imageLiteral(resourceName: "latFoam2"), #imageLiteral(resourceName: "latFoam1")],
            12: [#imageLiteral(resourceName: "pecDeltFoam")],
            13: [#imageLiteral(resourceName: "rearDeltFoam")],
            14: [#imageLiteral(resourceName: "quadFoam"), #imageLiteral(resourceName: "quadFoam1"), #imageLiteral(resourceName: "quadFoam2"), #imageLiteral(resourceName: "quadFoam3"), #imageLiteral(resourceName: "quadFoam4"), #imageLiteral(resourceName: "quadFoam3"), #imageLiteral(resourceName: "quadFoam2"), #imageLiteral(resourceName: "quadFoam1"), #imageLiteral(resourceName: "quadFoam5"), #imageLiteral(resourceName: "quadFoam6"), #imageLiteral(resourceName: "quadFoam5")],
            15: [#imageLiteral(resourceName: "adductorFoam"), #imageLiteral(resourceName: "adductorFoam1"), #imageLiteral(resourceName: "adductorFoam2"), #imageLiteral(resourceName: "adductorFoam3"), #imageLiteral(resourceName: "adductorFoam2"), #imageLiteral(resourceName: "adductorFoam1")],
            16: [#imageLiteral(resourceName: "hamstringFoam"), #imageLiteral(resourceName: "hamstringFoam1"), #imageLiteral(resourceName: "hamstringFoam2"), #imageLiteral(resourceName: "hamstringFoam3"), #imageLiteral(resourceName: "hamstringFoam4"), #imageLiteral(resourceName: "hamstringFoam3"), #imageLiteral(resourceName: "hamstringFoam2"), #imageLiteral(resourceName: "hamstringFoam1")],
            17: [#imageLiteral(resourceName: "gluteFoam"), #imageLiteral(resourceName: "gluteFoam1"), #imageLiteral(resourceName: "gluteFoam2"), #imageLiteral(resourceName: "gluteFoam3"), #imageLiteral(resourceName: "gluteFoam4"), #imageLiteral(resourceName: "gluteFoam3"), #imageLiteral(resourceName: "gluteFoam2"), #imageLiteral(resourceName: "gluteFoam1")],
            18: [#imageLiteral(resourceName: "calveFoam"), #imageLiteral(resourceName: "calveFoam1"), #imageLiteral(resourceName: "calveFoam2"), #imageLiteral(resourceName: "calveFoam3"), #imageLiteral(resourceName: "calveFoam2"), #imageLiteral(resourceName: "calveFoam1"), #imageLiteral(resourceName: "calveFoam2"), #imageLiteral(resourceName: "calveFoam3"), #imageLiteral(resourceName: "calveFoam4"), #imageLiteral(resourceName: "calveFoam5"), #imageLiteral(resourceName: "calveFoam4"), #imageLiteral(resourceName: "calveFoam3"), #imageLiteral(resourceName: "calveFoam2"), #imageLiteral(resourceName: "calveFoam1")],
            19: [#imageLiteral(resourceName: "itBandFoam"), #imageLiteral(resourceName: "itBandFoam1"), #imageLiteral(resourceName: "itBandFoam2"), #imageLiteral(resourceName: "itBandFoam3"), #imageLiteral(resourceName: "itBandFoam2"), #imageLiteral(resourceName: "itBandFoam1")],
            20: [#imageLiteral(resourceName: "standingOnBall")],
            // Glutes
            21: [#imageLiteral(resourceName: "gluteBridgeW"), #imageLiteral(resourceName: "gluteBridgeW1"), #imageLiteral(resourceName: "gluteBridgeW2"), #imageLiteral(resourceName: "gluteBridgeW3"), #imageLiteral(resourceName: "gluteBridgeW3"), #imageLiteral(resourceName: "gluteBridgeW2"), #imageLiteral(resourceName: "gluteBridgeW1"), #imageLiteral(resourceName: "gluteBridgeW2"), #imageLiteral(resourceName: "gluteBridgeW3"), #imageLiteral(resourceName: "gluteBridgeW3"), #imageLiteral(resourceName: "gluteBridgeW2"), #imageLiteral(resourceName: "gluteBridgeW1")],
            22: [#imageLiteral(resourceName: "kneelingHipRotations"), #imageLiteral(resourceName: "kneelingHipRotations1"), #imageLiteral(resourceName: "kneelingHipRotations2"), #imageLiteral(resourceName: "kneelingHipRotations3"), #imageLiteral(resourceName: "kneelingHipRotations2"), #imageLiteral(resourceName: "kneelingHipRotations1"), #imageLiteral(resourceName: "kneelingHipRotations4"), #imageLiteral(resourceName: "kneelingHipRotations5"), #imageLiteral(resourceName: "kneelingHipRotations6"), #imageLiteral(resourceName: "kneelingHipRotations7"), #imageLiteral(resourceName: "kneelingHipRotations1"), #imageLiteral(resourceName: "kneelingHipRotations8"), #imageLiteral(resourceName: "kneelingHipRotations9"), #imageLiteral(resourceName: "kneelingHipRotations10"), #imageLiteral(resourceName: "kneelingHipRotations9"), #imageLiteral(resourceName: "kneelingHipRotations8"), #imageLiteral(resourceName: "kneelingHipRotations1"), #imageLiteral(resourceName: "kneelingHipRotations7"), #imageLiteral(resourceName: "kneelingHipRotations6"), #imageLiteral(resourceName: "kneelingHipRotations5"), #imageLiteral(resourceName: "kneelingHipRotations4"), #imageLiteral(resourceName: "kneelingHipRotations1"), #imageLiteral(resourceName: "kneelingHipRotations2"), #imageLiteral(resourceName: "kneelingHipRotations3"), #imageLiteral(resourceName: "kneelingHipRotations2"), #imageLiteral(resourceName: "kneelingHipRotations1")],
            23: [#imageLiteral(resourceName: "legsToSideSquat"), #imageLiteral(resourceName: "legsToSideSquat1"), #imageLiteral(resourceName: "legsToSideSquat2"), #imageLiteral(resourceName: "legsToSideSquat3"), #imageLiteral(resourceName: "legsToSideSquat4"), #imageLiteral(resourceName: "legsToSideSquat3"), #imageLiteral(resourceName: "legsToSideSquat2"), #imageLiteral(resourceName: "legsToSideSquat1")],
            24: [#imageLiteral(resourceName: "standingGluteKickback"), #imageLiteral(resourceName: "standingGluteKickback1"), #imageLiteral(resourceName: "standingGluteKickback2"), #imageLiteral(resourceName: "standingGluteKickback3"), #imageLiteral(resourceName: "standingGluteKickback3"), #imageLiteral(resourceName: "standingGluteKickback2"), #imageLiteral(resourceName: "standingGluteKickback1")],
            // Lower Back
            25: [#imageLiteral(resourceName: "legDrop"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop2"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop3"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop2"), #imageLiteral(resourceName: "legDrop1")],
            26: [#imageLiteral(resourceName: "sideLegKick"), #imageLiteral(resourceName: "sideLegKick1"), #imageLiteral(resourceName: "sideLegKick2"), #imageLiteral(resourceName: "sideLegKick1"), #imageLiteral(resourceName: "sideLegKick"), #imageLiteral(resourceName: "sideLegKick1"), #imageLiteral(resourceName: "sideLegKick2"), #imageLiteral(resourceName: "sideLegKick1")],
            27: [#imageLiteral(resourceName: "scorpionKick"), #imageLiteral(resourceName: "scorpionKick1"), #imageLiteral(resourceName: "scorpionKick2"), #imageLiteral(resourceName: "scorpionKick1"), #imageLiteral(resourceName: "scorpionKick"), #imageLiteral(resourceName: "scorpionKick1"), #imageLiteral(resourceName: "scorpionKick2"), #imageLiteral(resourceName: "scorpionKick1")],
            28: [#imageLiteral(resourceName: "sideBend"), #imageLiteral(resourceName: "sideBend1"), #imageLiteral(resourceName: "sideBend2"), #imageLiteral(resourceName: "sideBend1"), #imageLiteral(resourceName: "sideBend"), #imageLiteral(resourceName: "sideBend1"), #imageLiteral(resourceName: "sideBend2"), #imageLiteral(resourceName: "sideBend1")],
            29: [#imageLiteral(resourceName: "catCowS"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS2"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS3"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS2"), #imageLiteral(resourceName: "catCowS1")],
            30: [#imageLiteral(resourceName: "legsToSideTwist"), #imageLiteral(resourceName: "legsToSideTwist1"), #imageLiteral(resourceName: "legsToSideTwist2"), #imageLiteral(resourceName: "legsToSideTwist3"), #imageLiteral(resourceName: "legsToSideTwist4"), #imageLiteral(resourceName: "legsToSideTwist4"), #imageLiteral(resourceName: "legsToSideTwist3"), #imageLiteral(resourceName: "legsToSideTwist2"), #imageLiteral(resourceName: "legsToSideTwist1"), #imageLiteral(resourceName: "legsToSideTwist1")],
            // Upper Back
            31: [#imageLiteral(resourceName: "upperBackRotation"), #imageLiteral(resourceName: "upperBackRotation1"), #imageLiteral(resourceName: "upperBackRotation2"), #imageLiteral(resourceName: "upperBackRotation1"), #imageLiteral(resourceName: "upperBackRotation"), #imageLiteral(resourceName: "upperBackRotation1"), #imageLiteral(resourceName: "upperBackRotation2"), #imageLiteral(resourceName: "upperBackRotation1")],
            32: [#imageLiteral(resourceName: "latStretch")],
            33: [#imageLiteral(resourceName: "lyingSideWindmill"), #imageLiteral(resourceName: "lyingSideWindmill1"), #imageLiteral(resourceName: "lyingSideWindmill2"), #imageLiteral(resourceName: "lyingSideWindmill3"), #imageLiteral(resourceName: "lyingSideWindmill4"), #imageLiteral(resourceName: "lyingSideWindmill1"), #imageLiteral(resourceName: "lyingSideWindmill2"), #imageLiteral(resourceName: "lyingSideWindmill3"), #imageLiteral(resourceName: "lyingSideWindmill4")],
            // Shoulder
            34: [#imageLiteral(resourceName: "wallSlides"), #imageLiteral(resourceName: "wallSlides1"), #imageLiteral(resourceName: "wallSlides2"), #imageLiteral(resourceName: "wallSlides1"), #imageLiteral(resourceName: "wallSlides"), #imageLiteral(resourceName: "wallSlides1"), #imageLiteral(resourceName: "wallSlides2"), #imageLiteral(resourceName: "wallSlides1")],
            35: [#imageLiteral(resourceName: "wallReaches"), #imageLiteral(resourceName: "wallReaches1"), #imageLiteral(resourceName: "wallReaches2"), #imageLiteral(resourceName: "wallReaches1"), #imageLiteral(resourceName: "wallReaches"), #imageLiteral(resourceName: "wallReaches1"), #imageLiteral(resourceName: "wallReaches2"), #imageLiteral(resourceName: "wallReaches1")],
            36: [#imageLiteral(resourceName: "shoulderRotationW"), #imageLiteral(resourceName: "shoulderRotationW1"), #imageLiteral(resourceName: "shoulderRotationW2"), #imageLiteral(resourceName: "shoulderRotationW1"), #imageLiteral(resourceName: "shoulderRotationW"), #imageLiteral(resourceName: "shoulderRotationW1"), #imageLiteral(resourceName: "shoulderRotationW2"), #imageLiteral(resourceName: "shoulderRotationW1")],
            37: [#imageLiteral(resourceName: "forearmWallSlides135"), #imageLiteral(resourceName: "forearmWallSlides1351"), #imageLiteral(resourceName: "forearmWallSlides1352"), #imageLiteral(resourceName: "forearmWallSlides1351"), #imageLiteral(resourceName: "forearmWallSlides135"), #imageLiteral(resourceName: "forearmWallSlides1351"), #imageLiteral(resourceName: "forearmWallSlides1352"), #imageLiteral(resourceName: "forearmWallSlides1351")],
            38: [#imageLiteral(resourceName: "superManShoulder"), #imageLiteral(resourceName: "superManShoulder1"), #imageLiteral(resourceName: "superManShoulder2"), #imageLiteral(resourceName: "superManShoulder3"), #imageLiteral(resourceName: "superManShoulder4"), #imageLiteral(resourceName: "superManShoulder4"), #imageLiteral(resourceName: "superManShoulder3"), #imageLiteral(resourceName: "superManShoulder2"), #imageLiteral(resourceName: "superManShoulder1"), #imageLiteral(resourceName: "superManShoulder1")],
            39: [#imageLiteral(resourceName: "scapulaPushup"), #imageLiteral(resourceName: "scapulaPushup1"), #imageLiteral(resourceName: "scapulaPushup"), #imageLiteral(resourceName: "scapulaPushup1"), #imageLiteral(resourceName: "scapulaPushup"), #imageLiteral(resourceName: "scapulaPushup1")],
            // Band/Bar/Machine Assisted
            40: [#imageLiteral(resourceName: "facePull"), #imageLiteral(resourceName: "facePull1"), #imageLiteral(resourceName: "facePull2"), #imageLiteral(resourceName: "facePull3"), #imageLiteral(resourceName: "facePull4"), #imageLiteral(resourceName: "facePull5"), #imageLiteral(resourceName: "facePull5"), #imageLiteral(resourceName: "facePull4"), #imageLiteral(resourceName: "facePull3"), #imageLiteral(resourceName: "facePull2"), #imageLiteral(resourceName: "facePull1")],
            41: [#imageLiteral(resourceName: "externalRotation"), #imageLiteral(resourceName: "externalRotation1"), #imageLiteral(resourceName: "externalRotation2"), #imageLiteral(resourceName: "externalRotation3"), #imageLiteral(resourceName: "externalRotation4"), #imageLiteral(resourceName: "externalRotation4"), #imageLiteral(resourceName: "externalRotation3"), #imageLiteral(resourceName: "externalRotation2"), #imageLiteral(resourceName: "externalRotation1")],
            42: [#imageLiteral(resourceName: "internalRotation"), #imageLiteral(resourceName: "internalRotation1"), #imageLiteral(resourceName: "internalRotation2"), #imageLiteral(resourceName: "internalRotation3"), #imageLiteral(resourceName: "internalRotation4"), #imageLiteral(resourceName: "internalRotation4"), #imageLiteral(resourceName: "internalRotation3"), #imageLiteral(resourceName: "internalRotation2"), #imageLiteral(resourceName: "internalRotation1")],
            43: [#imageLiteral(resourceName: "shoulderDislocation"), #imageLiteral(resourceName: "shoulderDislocation1"), #imageLiteral(resourceName: "shoulderDislocation2"), #imageLiteral(resourceName: "shoulderDislocation1"), #imageLiteral(resourceName: "shoulderDislocation"), #imageLiteral(resourceName: "shoulderDislocation3"), #imageLiteral(resourceName: "shoulderDislocation"), #imageLiteral(resourceName: "shoulderDislocation1"), #imageLiteral(resourceName: "shoulderDislocation2"), #imageLiteral(resourceName: "shoulderDislocation1"), #imageLiteral(resourceName: "shoulderDislocation"), #imageLiteral(resourceName: "shoulderDislocation3")],
            44: [#imageLiteral(resourceName: "latPullover"), #imageLiteral(resourceName: "latPullover1"), #imageLiteral(resourceName: "latPullover2"), #imageLiteral(resourceName: "latPullover3"), #imageLiteral(resourceName: "latPullover3"), #imageLiteral(resourceName: "latPullover2"), #imageLiteral(resourceName: "latPullover1")],
            // General Mobility
            45: [#imageLiteral(resourceName: "seatedKneeDrop"), #imageLiteral(resourceName: "seatedKneeDrop1"), #imageLiteral(resourceName: "seatedKneeDrop2"), #imageLiteral(resourceName: "seatedKneeDrop3"), #imageLiteral(resourceName: "seatedKneeDrop4"), #imageLiteral(resourceName: "seatedKneeDrop3"), #imageLiteral(resourceName: "seatedKneeDrop2"), #imageLiteral(resourceName: "seatedKneeDrop1")],
            46: [#imageLiteral(resourceName: "mountainClimber"), #imageLiteral(resourceName: "mountainClimber3"), #imageLiteral(resourceName: "mountainClimber2"), #imageLiteral(resourceName: "mountainClimber1"), #imageLiteral(resourceName: "mountainClimber2"), #imageLiteral(resourceName: "mountainClimber3"), #imageLiteral(resourceName: "mountainClimber4"), #imageLiteral(resourceName: "mountainClimber5"), #imageLiteral(resourceName: "mountainClimber4"), #imageLiteral(resourceName: "mountainClimber3")],
            47: [#imageLiteral(resourceName: "groinStretch")],
            48: [#imageLiteral(resourceName: "threadTheNeedleS")],
            49: [#imageLiteral(resourceName: "butterflyPoseS")],
            50: [#imageLiteral(resourceName: "cossakSquat"), #imageLiteral(resourceName: "cossakSquat4"), #imageLiteral(resourceName: "cossakSquat1"), #imageLiteral(resourceName: "cossakSquat2"), #imageLiteral(resourceName: "cossakSquat3"), #imageLiteral(resourceName: "cossakSquat2"), #imageLiteral(resourceName: "cossakSquat1"), #imageLiteral(resourceName: "cossakSquat4"), #imageLiteral(resourceName: "cossakSquat5"), #imageLiteral(resourceName: "cossakSquat6"), #imageLiteral(resourceName: "cossakSquat7"), #imageLiteral(resourceName: "cossakSquat6"), #imageLiteral(resourceName: "cossakSquat5"), #imageLiteral(resourceName: "cossakSquat4")],
            51: [#imageLiteral(resourceName: "hipHinges"), #imageLiteral(resourceName: "hipHinges1"), #imageLiteral(resourceName: "hipHinges2"), #imageLiteral(resourceName: "hipHinges3"), #imageLiteral(resourceName: "hipHinges4"), #imageLiteral(resourceName: "hipHinges4"), #imageLiteral(resourceName: "hipHinges3"), #imageLiteral(resourceName: "hipHinges2"), #imageLiteral(resourceName: "hipHinges1"), #imageLiteral(resourceName: "hipHinges1")],
            52: [#imageLiteral(resourceName: "lungeTwist"), #imageLiteral(resourceName: "lungeTwist1"), #imageLiteral(resourceName: "lungeTwist2"), #imageLiteral(resourceName: "lungeTwist3"), #imageLiteral(resourceName: "lungeTwist4"), #imageLiteral(resourceName: "lungeTwist5"), #imageLiteral(resourceName: "lungeTwist6"), #imageLiteral(resourceName: "lungeTwist5"), #imageLiteral(resourceName: "lungeTwist4"), #imageLiteral(resourceName: "lungeTwist7"), #imageLiteral(resourceName: "lungeTwist8"), #imageLiteral(resourceName: "lungeTwist9"), #imageLiteral(resourceName: "lungeTwist10"), #imageLiteral(resourceName: "lungeTwist11"), #imageLiteral(resourceName: "lungeTwist12"), #imageLiteral(resourceName: "lungeTwist13"), #imageLiteral(resourceName: "lungeTwist12"), #imageLiteral(resourceName: "lungeTwist11"), #imageLiteral(resourceName: "lungeTwist14"), #imageLiteral(resourceName: "lungeTwist15")],
            53: [#imageLiteral(resourceName: "sideLegSwings"), #imageLiteral(resourceName: "sideLegSwings1"), #imageLiteral(resourceName: "sideLegSwings2"), #imageLiteral(resourceName: "sideLegSwings3"), #imageLiteral(resourceName: "sideLegSwings4"), #imageLiteral(resourceName: "sideLegSwings3"), #imageLiteral(resourceName: "sideLegSwings2"), #imageLiteral(resourceName: "sideLegSwings1"), #imageLiteral(resourceName: "sideLegSwings5"), #imageLiteral(resourceName: "sideLegSwings1"), #imageLiteral(resourceName: "sideLegSwings2"), #imageLiteral(resourceName: "sideLegSwings3"), #imageLiteral(resourceName: "sideLegSwings4")],
            54: [#imageLiteral(resourceName: "frontLegSwings"), #imageLiteral(resourceName: "frontLegSwings1"), #imageLiteral(resourceName: "frontLegSwings2"), #imageLiteral(resourceName: "frontLegSwings3"), #imageLiteral(resourceName: "frontLegSwings4"), #imageLiteral(resourceName: "frontLegSwings3"), #imageLiteral(resourceName: "frontLegSwings2"), #imageLiteral(resourceName: "frontLegSwings1"), #imageLiteral(resourceName: "frontLegSwings5"), #imageLiteral(resourceName: "frontLegSwings1"), #imageLiteral(resourceName: "frontLegSwings2"), #imageLiteral(resourceName: "frontLegSwings3"), #imageLiteral(resourceName: "frontLegSwings4")],
            55: [#imageLiteral(resourceName: "spiderManOverheadReach"), #imageLiteral(resourceName: "spiderManOverheadReach1"), #imageLiteral(resourceName: "spiderManOverheadReach2"), #imageLiteral(resourceName: "spiderManOverheadReach3"), #imageLiteral(resourceName: "spiderManOverheadReach4"), #imageLiteral(resourceName: "spiderManOverheadReach5"), #imageLiteral(resourceName: "spiderManOverheadReach4"), #imageLiteral(resourceName: "spiderManOverheadReach3"), #imageLiteral(resourceName: "spiderManOverheadReach6"), #imageLiteral(resourceName: "spiderManOverheadReach7"), #imageLiteral(resourceName: "spiderManOverheadReach6"), #imageLiteral(resourceName: "spiderManOverheadReach3"), #imageLiteral(resourceName: "spiderManOverheadReach2"), #imageLiteral(resourceName: "spiderManOverheadReach1")],
            // Dynamic Warmup Drills
            56: [#imageLiteral(resourceName: "forefootBounces"), #imageLiteral(resourceName: "forefootBounces1"), #imageLiteral(resourceName: "forefootBounces2"), #imageLiteral(resourceName: "forefootBounces3"), #imageLiteral(resourceName: "forefootBounces2"), #imageLiteral(resourceName: "forefootBounces1"), #imageLiteral(resourceName: "forefootBounces2"), #imageLiteral(resourceName: "forefootBounces3"), #imageLiteral(resourceName: "forefootBounces2"), #imageLiteral(resourceName: "forefootBounces1")],
            57: [#imageLiteral(resourceName: "jumpSquat"), #imageLiteral(resourceName: "jumpSquat1"), #imageLiteral(resourceName: "jumpSquat2"), #imageLiteral(resourceName: "jumpSquat3"), #imageLiteral(resourceName: "jumpSquat4"), #imageLiteral(resourceName: "jumpSquat5"), #imageLiteral(resourceName: "jumpSquat4"), #imageLiteral(resourceName: "jumpSquat3"), #imageLiteral(resourceName: "jumpSquat2"), #imageLiteral(resourceName: "jumpSquat1")],
            58: [#imageLiteral(resourceName: "lunge"), #imageLiteral(resourceName: "lunge1"), #imageLiteral(resourceName: "lunge2"), #imageLiteral(resourceName: "lunge3"), #imageLiteral(resourceName: "lunge4"), #imageLiteral(resourceName: "lunge3"), #imageLiteral(resourceName: "lunge2"), #imageLiteral(resourceName: "lunge1"), #imageLiteral(resourceName: "lunge5"), #imageLiteral(resourceName: "lunge6"), #imageLiteral(resourceName: "lunge7"), #imageLiteral(resourceName: "lunge6"), #imageLiteral(resourceName: "lunge5"), #imageLiteral(resourceName: "lunge1")],
            59: [#imageLiteral(resourceName: "bumKicks"), #imageLiteral(resourceName: "bumKicks1"), #imageLiteral(resourceName: "bumKicks2"), #imageLiteral(resourceName: "bumKicks3"), #imageLiteral(resourceName: "bumKicks4"), #imageLiteral(resourceName: "bumKicks3"), #imageLiteral(resourceName: "bumKicks2"), #imageLiteral(resourceName: "bumKicks1")],
            60: [#imageLiteral(resourceName: "aSkips"), #imageLiteral(resourceName: "aSkips1"), #imageLiteral(resourceName: "aSkips2"), #imageLiteral(resourceName: "aSkips3"), #imageLiteral(resourceName: "aSkips2"), #imageLiteral(resourceName: "aSkips1"), #imageLiteral(resourceName: "aSkips4"), #imageLiteral(resourceName: "aSkips5"), #imageLiteral(resourceName: "aSkips4"), #imageLiteral(resourceName: "aSkips1")],
            61: [#imageLiteral(resourceName: "bSkips"), #imageLiteral(resourceName: "bSkips1"), #imageLiteral(resourceName: "bSkips2"), #imageLiteral(resourceName: "bSkips3"), #imageLiteral(resourceName: "bSkips4"), #imageLiteral(resourceName: "bSkips5"), #imageLiteral(resourceName: "bSkips6"), #imageLiteral(resourceName: "bSkips7"), #imageLiteral(resourceName: "bSkips8"), #imageLiteral(resourceName: "bSkips9"), #imageLiteral(resourceName: "bSkips10"), #imageLiteral(resourceName: "bSkips11")],
            62: [#imageLiteral(resourceName: "grapeVines")],
            63: [#imageLiteral(resourceName: "lateralBound"), #imageLiteral(resourceName: "lateralBound1"), #imageLiteral(resourceName: "lateralBound2"), #imageLiteral(resourceName: "lateralBound3"), #imageLiteral(resourceName: "lateralBound4"), #imageLiteral(resourceName: "lateralBound5"), #imageLiteral(resourceName: "lateralBound"), #imageLiteral(resourceName: "lateralBound6"), #imageLiteral(resourceName: "lateralBound7"), #imageLiteral(resourceName: "lateralBound8"), #imageLiteral(resourceName: "lateralBound9")],
            64: [#imageLiteral(resourceName: "straightLegBound"), #imageLiteral(resourceName: "straightLegBound1"), #imageLiteral(resourceName: "straightLegBound2"), #imageLiteral(resourceName: "straightLegBound3"), #imageLiteral(resourceName: "straightLegBound4"), #imageLiteral(resourceName: "straightLegBound"), #imageLiteral(resourceName: "straightLegBound5"), #imageLiteral(resourceName: "straightLegBound6"), #imageLiteral(resourceName: "straightLegBound7"), #imageLiteral(resourceName: "straightLegBound8")],
            65: [#imageLiteral(resourceName: "sprints")],
            // Accessory
            66: [#imageLiteral(resourceName: "pushUp"), #imageLiteral(resourceName: "pushUp1"), #imageLiteral(resourceName: "pushUp2"), #imageLiteral(resourceName: "pushUp3"), #imageLiteral(resourceName: "pushUp4"), #imageLiteral(resourceName: "pushUp4"), #imageLiteral(resourceName: "pushUp3"), #imageLiteral(resourceName: "pushUp2"), #imageLiteral(resourceName: "pushUp1")],
            67: [#imageLiteral(resourceName: "pullUp"), #imageLiteral(resourceName: "pullUp1"), #imageLiteral(resourceName: "pullUp2"), #imageLiteral(resourceName: "pullUp3"), #imageLiteral(resourceName: "pullUp4"), #imageLiteral(resourceName: "pullUp4"), #imageLiteral(resourceName: "pullUp3"), #imageLiteral(resourceName: "pullUp2"), #imageLiteral(resourceName: "pullUp1")]
    ]
    
    // Target Area Array
    var targetAreaDictionary: [Int: UIImage] =
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
            19: #imageLiteral(resourceName: "Calf"),
            20: #imageLiteral(resourceName: "Calf"),
            // Glutes
            21: #imageLiteral(resourceName: "Glute"),
            22: #imageLiteral(resourceName: "Glute"),
            23: #imageLiteral(resourceName: "Glute"),
            24: #imageLiteral(resourceName: "Glute"),
            // Lower Back
            25: #imageLiteral(resourceName: "Core"),
            26: #imageLiteral(resourceName: "Core"),
            27: #imageLiteral(resourceName: "Core"),
            28: #imageLiteral(resourceName: "Core"),
            29: #imageLiteral(resourceName: "Spine"),
            30: #imageLiteral(resourceName: "Core"),
            // Upper Back
            31: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            32: #imageLiteral(resourceName: "Lat"),
            33: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            // Shoulder
            34: #imageLiteral(resourceName: "Shoulder"),
            35: #imageLiteral(resourceName: "Shoulder"),
            36: #imageLiteral(resourceName: "Shoulder"),
            37: #imageLiteral(resourceName: "Shoulder"),
            38: #imageLiteral(resourceName: "Back and Shoulder"),
            39: #imageLiteral(resourceName: "Serratus"),
            // Band/Bar/Machine Assisted
            40: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            41: #imageLiteral(resourceName: "Rear Delt"),
            42: #imageLiteral(resourceName: "Rear Delt"),
            43: #imageLiteral(resourceName: "Shoulder"),
            44: #imageLiteral(resourceName: "Back"),
            // General Mobility
            45: #imageLiteral(resourceName: "Hip Area"),
            46: #imageLiteral(resourceName: "Hip Area"),
            47: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            48: #imageLiteral(resourceName: "Adductor"),
            49: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            50: #imageLiteral(resourceName: "Piriformis"),
            51: #imageLiteral(resourceName: "Adductor"),
            52: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            53: #imageLiteral(resourceName: "Hamstring and Glute"),
            54: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            55: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            // Dynamic Warm Up Drills
            56: #imageLiteral(resourceName: "Calf"),
            57: #imageLiteral(resourceName: "Squat"),
            58: #imageLiteral(resourceName: "Squat"),
            59: #imageLiteral(resourceName: "Squat"),
            60: #imageLiteral(resourceName: "Squat"),
            61: #imageLiteral(resourceName: "Squat"),
            62: #imageLiteral(resourceName: "Squat"),
            63: #imageLiteral(resourceName: "Squat"),
            64: #imageLiteral(resourceName: "Squat"),
            65: #imageLiteral(resourceName: "Squat"),
            // Accessory
            66: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            67: #imageLiteral(resourceName: "Back and Bicep")
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
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
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
            cell.imageView?.image = demonstrationDictionary[overviewArray[indexPath.section][indexPath.row]]?[0]
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
            UIView.animate(withDuration: animationTime2, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: tableWidth, height: tableHeight)
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
            // Animate new elements into page
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
