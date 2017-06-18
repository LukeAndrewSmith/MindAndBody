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
             55,
             56],
            // Dynamic Warmup Drills
            [57,
             58,
             59,
             60,
             61,
             62,
             63,
             64,
             65,
             66],
            // Accessory
            [67,
             68]
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
            45: "rollBack",
            46: "seatedKneeDrop", ///
            47: "mountainClimber",
            48: "groinStretch",
            49: "threadTheNeedle",
            50: "butterflyPose",
            51: "cossakSquat",
            52: "hipHinges",
            53: "lungeTwist",
            54: "sideLegSwings",
            55: "frontLegSwings",
            56: "spiderManHipLiftOverheadReach",
            // Dynamic Warmup Drills
            57: "forefootBounces",
            58: "jumpSquat",
            59: "lunge",
            60: "gluteKicks",
            61: "aSkips",
            62: "bSkips",
            63: "grapeVines",
            64: "lateralBound",
            65: "straightLegBound",
            66: "sprints",
            // Accessory
            67: "pushUp",
            68: "pullUp"
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
            21: [#imageLiteral(resourceName: "Test")],
            22: [#imageLiteral(resourceName: "Test")],
            23: [#imageLiteral(resourceName: "Test")],
            24: [#imageLiteral(resourceName: "Test")],
            // Lower Back
            25: [#imageLiteral(resourceName: "legDrop"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop2"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop3"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop2"), #imageLiteral(resourceName: "legDrop1")],
            26: [#imageLiteral(resourceName: "Test")],
            27: [#imageLiteral(resourceName: "Test")],
            28: [#imageLiteral(resourceName: "Test")],
            29: [#imageLiteral(resourceName: "catCowS"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS2"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS3"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS2"), #imageLiteral(resourceName: "catCowS1")],
            30: [#imageLiteral(resourceName: "Test")],
            // Upper Back
            31: [#imageLiteral(resourceName: "Test")],
            32: [#imageLiteral(resourceName: "Test")],
            33: [#imageLiteral(resourceName: "Test")],
            // Shoulder
            34: [#imageLiteral(resourceName: "Test")],
            35: [#imageLiteral(resourceName: "Test")],
            36: [#imageLiteral(resourceName: "Test")],
            37: [#imageLiteral(resourceName: "Test")],
            38: [#imageLiteral(resourceName: "Test")],
            39: [#imageLiteral(resourceName: "Test")],
            // Band/Bar/Machine Assisted
            40: [#imageLiteral(resourceName: "Test")],
            41: [#imageLiteral(resourceName: "Test")],
            42: [#imageLiteral(resourceName: "Test")],
            43: [#imageLiteral(resourceName: "Test")],
            44: [#imageLiteral(resourceName: "Test")],
            // General Mobility
            45: [#imageLiteral(resourceName: "Test")],
            46: [#imageLiteral(resourceName: "Test")],
            47: [#imageLiteral(resourceName: "Test")],
            48: [#imageLiteral(resourceName: "groinStretch")],
            49: [#imageLiteral(resourceName: "threadTheNeedleS")],
            50: [#imageLiteral(resourceName: "butterflyPoseS")],
            51: [#imageLiteral(resourceName: "Test")],
            52: [#imageLiteral(resourceName: "Test")],
            53: [#imageLiteral(resourceName: "Test")],
            54: [#imageLiteral(resourceName: "Test")],
            55: [#imageLiteral(resourceName: "Test")],
            56: [#imageLiteral(resourceName: "Test")],
            // Dynamic Warmup Drills
            57: [#imageLiteral(resourceName: "Test")],
            58: [#imageLiteral(resourceName: "Test")],
            59: [#imageLiteral(resourceName: "Test")],
            60: [#imageLiteral(resourceName: "Test")],
            61: [#imageLiteral(resourceName: "Test")],
            62: [#imageLiteral(resourceName: "Test")],
            63: [#imageLiteral(resourceName: "Test")],
            64: [#imageLiteral(resourceName: "Test")],
            65: [#imageLiteral(resourceName: "Test")],
            66: [#imageLiteral(resourceName: "Test")],
            // Accessory
            67: [#imageLiteral(resourceName: "Test")],
            68: [#imageLiteral(resourceName: "Test")]
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
            45: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            46: #imageLiteral(resourceName: "Hip Area"),
            47: #imageLiteral(resourceName: "Hip Area"),
            48: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            49: #imageLiteral(resourceName: "Adductor"),
            50: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            51: #imageLiteral(resourceName: "Piriformis"),
            52: #imageLiteral(resourceName: "Adductor"),
            53: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            54: #imageLiteral(resourceName: "Hamstring and Glute"),
            55: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            56: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            // Dynamic Warm Up Drills
            57: #imageLiteral(resourceName: "Calf"),
            58: #imageLiteral(resourceName: "Squat"),
            59: #imageLiteral(resourceName: "Squat"),
            60: #imageLiteral(resourceName: "Squat"),
            61: #imageLiteral(resourceName: "Squat"),
            62: #imageLiteral(resourceName: "Squat"),
            63: #imageLiteral(resourceName: "Squat"),
            64: #imageLiteral(resourceName: "Squat"),
            65: #imageLiteral(resourceName: "Squat"),
            66: #imageLiteral(resourceName: "Squat"),
            // Accessory
            67: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            68: #imageLiteral(resourceName: "Back and Bicep")
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
            45: "rollBackE",
            46: "seatedKneeDropE", ///
            47: "mountainClimberE",
            48: "groinStretchE",
            49: "threadTheNeedleE",
            50: "butterflyPoseE",
            51: "cossakSquatE",
            52: "hipHingesE",
            53: "lungeTwistE",
            54: "sideLegSwingsE",
            55: "frontLegSwingsE",
            56: "spiderManHipLiftOverheadReachE",
            // Dynamic Warmup Drills
            57: "forefootBouncesE",
            58: "jumpSquatE",
            59: "lungeE",
            60: "gluteKicksE",
            61: "aSkipsE",
            62: "bSkipsE",
            63: "grapeVinesE",
            64: "lateralBoundE",
            65: "straightLegBoundE",
            66: "sprintsE",
            // Accessory
            67: "pushUpE",
            68: "pullUpE"
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
                [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68],
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
                [ 2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1],
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
        
            
        // TableView Cell action items
        //
        // Movement table
        presetsTableView.backgroundColor = colour1
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
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: tableWidth, height: tableHeight)
                self.backgroundViewExpanded.alpha = 0
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
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
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
        let tableHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
        let tableWidth = UIScreen.main.bounds.width - 20
        self.presetsTableView.frame = CGRect(x: 10, y: view.frame.maxY, width: tableWidth, height: tableHeight)
        //
        //
        backgroundViewExpanded.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: presetsTableView)
        backgroundViewExpanded.frame = UIScreen.main.bounds
        // Animate table fade and size
        // Position
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY - tableHeight - 10, width: tableWidth, height: tableHeight)
            self.presetsTableView.reloadData()
            //
            self.backgroundViewExpanded.alpha = 0.5
        }, completion: nil)
        //
    }
    
    
    // Dismiss presets table
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        let tableHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
        let tableWidth = UIScreen.main.bounds.width - 20
        //
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: tableWidth, height: tableHeight)
            self.backgroundViewExpanded.alpha = 0
        }, completion: { finished in
        //
            self.presetsTableView.removeFromSuperview()
            self.backgroundViewExpanded.removeFromSuperview()
        })
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
        // Get Image
        // let index = demonstrationImage.indexWhere
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        // Expanded Image
        //
        expandedImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: height/2)
        expandedImage.center.x = self.view.frame.size.width/2
        expandedImage.center.y = (height/2) * 2.5
        //
        expandedImage.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        expandedImage.contentMode = .scaleAspectFit
        expandedImage.isUserInteractionEnabled = true
        //
        expandedImage.image = image
        
        // Background View
        //
        backgroundViewImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: height)
        backgroundViewImage.backgroundColor = .black
        backgroundViewImage.alpha = 0
        backgroundViewImage.addTarget(self, action: #selector(retractImage(_:)), for: .touchUpInside)
        //
        self.navigationItem.setHidesBackButton(true, animated: true)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewImage, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(expandedImage, aboveSubview: backgroundViewImage)
        //
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandedImage.center.y = (height/2) * 1.5
            self.backgroundViewImage.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract image
    @IBAction func retractImage(_ sender: Any) {
        //
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        //
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandedImage.center.y = (height/2) * 2.5
            self.backgroundViewImage.alpha = 0
        }, completion: { finished in
            //
            self.expandedImage.removeFromSuperview()
            self.backgroundViewImage.removeFromSuperview()
            self.navigationItem.setHidesBackButton(false, animated: true)
        })
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
