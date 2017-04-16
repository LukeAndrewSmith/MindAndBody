//
//  WarmupChoiceFinal.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 15.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Warmup Choice Class -------------------------------------------------------------------------------------------------------------
//
class WarmupChoiceFinal: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Selected Warmup Type
    //
    var warmupType = Int()
    
    // Custom
    //
    var emptyArrayofArrays: [[Int]] = []

    
//
// Arrays ------------------------------------------------------------------------------------------------------------------------------
//
    //
    var warmupKeyArray: [[Int]] = []
    // Selected Array
    var warmupSelectedArray: [Int] = []
    
    // Picker View Array
    var pickerViewArray: [String] = []
    // TableView Section Array
    var tableViewSectionArray: [String] = []
    //
    var presetsArrays: [[Int]] = []
    
    // Arrays to be set and used (Screen arrays)
    // Movements Array
    var warmupMovementsDictionary: [Int : String] = [:]
    var warmupArray: [String] = []
    
    // Sets Array
    var setsDictionary: [Int : Int] = [:]
    var setsArray: [Int] = []
    
    // Reps Array
    var repsDictionary: [Int : String] = [:]
    var repsArray: [String] = []
    
    // Demonstration Array
    var demonstrationDictionary: [Int : UIImage] = [:]
    var demonstrationArray: [UIImage] = []
    
    // Target Area Array
    var targetAreaDictionary: [Int : UIImage] = [:]
    var targetAreaArray: [UIImage] = []
    
    // Explanation Array
    var explanationDictionary: [Int : String] = [:]
    var explanationArray: [String] = []
    
    // Static Arrays
    // Initial Custom Preset Texts
    var presetTexts: [String] = []
    
    // Navigation Titles
    let navigationTitles: [String] =
        ["fullBody",
         "upperBody",
         "lowerBody",
         "cardio"]
    
    // Custom Preset Keys
    // Preset Array
    let warmupPresets: [String] =
        ["warmupPresetsFull",
         "warmupPresetsUpper",
         "warmupPresetsLower",
         "warmupPresetsCardio"]
    // Preset Text
    let warmupPresetTexts: [String] =
        ["warmupPresetTextsFull",
         "warmupPresetTextsUpper",
         "warmupPresetTextsLower",
         "warmupPresetTextsCardio"]
    
    
//
// Warmup Type Arrays --------------------------------------------------------------------------------------------------------------
//
//
// Full ----------------------------------------------------------------------------------------------------------------------------
//
    
    // Table View Section Title Array
    var tableViewSectionArrayFull: [String] =
        [
            "mandatory",
            "jointRotation",
            "foamRoll",
            "lowerBack",
            "shoulder",
            "bandAssisted",
            "generalMobility",
            "accessory"
    ]
    
    // Warmup Key Array
    var warmupKeyArrayFull: [[Int]] =
        [
            // Mandatory
            [0,
             1],
            // Joint Rotations
            [2,
             3,
             4,
             5,
             6,
             7,
             8,
             9],
            // Foam/Ball Roll
            [10,
             11,
             12,
             13,
             14,
             15,
             16,
             17,
             18,
             19],
            // Lower Back
            [20,
             21,
             22,
             23,
             24],
            // Shoulder
            [25,
             26,
             27,
             28],
            // Band/Bar/Machine Assisted
            [29,
             30,
             31,
             32,
             33,
             34],
            // General Mobility
            [35,
             36,
             37,
             38,
             39,
             40,
             41,
             42,
             43,
             44,
             45,
             46,
             47],
            // Accessory
            [48,
             49,
             50,
             51]
        ]
    
    // Warmup Movements
    var warmupDictionaryFull: [Int : String] =
        [
            // Mandatory
            0: "5minCardioL",
            1: "5minCardioI",
            // Joint Rotations
            2: "wrist",
            3: "elbow",
            4: "shoulder",
            5: "neckR",
            6: "waist",
            7: "hip",
            8: "knees",
            9: "ankles",
            // Foam/Ball Roll
            10: "backf",
            11: "thoracicSpine",
            12: "lat",
            13: "pecDelt",
            14: "rearDelt",
            15: "quadf",
            16: "adductorf",
            17: "hamstringf",
            18: "glutef",
            19: "calvef",
            // Lower Back
            20: "sideLegDrop",
            21: "sideLegKick",
            22: "scorpionKick",
            23: "sideBend",
            24: "catCow",
            // Shoulder
            25: "wallSlides",
            26: "superManShoulder",
            27: "scapula",
            28: "shoulderRotation",
            // Band/Bar/Machine Assisted
            29: "facePull",
            30: "externalRotation",
            31: "internalRotation",
            32: "shoulderDislocation",
            33: "rearDeltFly",
            34: "latPullover",
            // General Mobility
            35: "rollBack",
            36: "hipCircles",
            37: "mountainClimber",
            38: "groinStretch",
            39: "gluteBridge",
            40: "threadTheNeedle",
            41: "butterflyPose",
            42: "cossakSquat",
            43: "hipHinges",
            44: "sideLegSwings",
            45: "frontLegSwings",
            46: "jumpSquat",
            47: "lunge",
            // Accessory
            48: "latStretch",
            49: "calveStretch",
            50: "pushUp",
            51: "pullUp"
        ]
    
    // Screen Arrays
    //
    var setsDictionaryFull: [Int : Int] =
        [
            // Mandatory
            0: 1,
            1: 1,
            // Joint Rotations
            2: 1,
            3: 1,
            4: 1,
            5: 1,
            6: 1,
            7: 1,
            8: 1,
            9: 1,
            // Foam/Ball Roll
            10: 1,
            11: 3,
            12: 1,
            13: 1,
            14: 1,
            15: 1,
            16: 1,
            17: 1,
            18: 1,
            19: 1,
            // Lower Back
            20: 1,
            21: 1,
            22: 1,
            23: 1,
            24: 1,
            // Shoulder
            25: 2,
            26: 1,
            27: 1,
            28: 1,
            // Band/Bar/Machine Assisted
            29: 2,
            30: 1,
            31: 1,
            32: 1,
            33: 1,
            34: 1,
            // General Mobility
            35: 1,
            36: 1,
            37: 1,
            38: 1,
            39: 1,
            40: 2,
            41: 1,
            42: 1,
            43: 2,
            44: 1,
            45: 1,
            46: 2,
            47: 2,
            // Accessory
            48: 1,
            49: 1,
            50: 1,
            51: 1
        ]
    
    // Reps Array
    var repsDictionaryFull: [Int : String] =
        [
            // Mandatory
            0: "5min",
            1: "5min",
            // Joint Rotations
            2: "10-30s",
            3: "10-30s",
            4: "10-30s",
            5: "10-30s",
            6: "10-30s",
            7: "10-30s",
            8: "10-30s",
            9: "10-30s",
            // Foam/Ball Roll
            10: "2-7 reps",
            11: "5-10 reps",
            12: "2-7 reps",
            13: "15-30s",
            14: "15-30s",
            15: "2-7 reps",
            16: "2-7 reps",
            17: "2-7 reps",
            18: "2-7 reps",
            19: "2-7 reps",
            // Lower Back
            20: "5-10 reps",
            21: "5-10 reps",
            22: "5-10 reps",
            23: "5-10 reps",
            24: "15-20 reps",
            // Shoulder
            25: "10-20 reps",
            26: "5-10 reps",
            27: "15 reps",
            28: "10 reps",
            // Band/Bar/Machine Assisted
            29: "10-15 reps",
            30: "5-15 reps",
            31: "5-10 reps",
            32: "5-10 reps",
            33: "10-15 reps",
            34: "10-20 reps",
            // General Mobility
            35: "10-15 reps",
            36: "5-10 reps",
            37: "5-10 reps",
            38: "5-10 reps",
            39: "10-15 reps",
            40: "15-30s",
            41: "15-30s",
            42: "5-10 reps",
            43: "10-20 reps",
            44: "10-20 reps",
            45: "10-20 reps",
            46: "5-15 reps",
            47: "10-15 reps",
            // Accessory
            48 :"15-30s",
            49: "15-30s",
            50: NSLocalizedString("asNecessary", comment: ""),
            51: NSLocalizedString("asNecessary", comment: "")
    ]
    
    // Demonstration Array
    var demonstrationDictionaryFull: [Int : UIImage] =
        [
            // Mandatory
            0: #imageLiteral(resourceName: "Test 2"),
            1: #imageLiteral(resourceName: "Test 2"),
            // Joint Rotations
            2: #imageLiteral(resourceName: "Test 2"),
            3: #imageLiteral(resourceName: "Test 2"),
            4: #imageLiteral(resourceName: "Test 2"),
            5: #imageLiteral(resourceName: "Test 2"),
            6: #imageLiteral(resourceName: "Test 2"),
            7: #imageLiteral(resourceName: "Test 2"),
            8: #imageLiteral(resourceName: "Test 2"),
            9: #imageLiteral(resourceName: "Test 2"),
            // Foam/Ball Roll
            10: #imageLiteral(resourceName: "Test 2"),
            11: #imageLiteral(resourceName: "Test 2"),
            12: #imageLiteral(resourceName: "Test 2"),
            13: #imageLiteral(resourceName: "Test 2"),
            14: #imageLiteral(resourceName: "Test 2"),
            15: #imageLiteral(resourceName: "Test 2"),
            16: #imageLiteral(resourceName: "Test 2"),
            17: #imageLiteral(resourceName: "Test 2"),
            18: #imageLiteral(resourceName: "Test 2"),
            19: #imageLiteral(resourceName: "Test 2"),
            // Lower Back
            20: #imageLiteral(resourceName: "Test 2"),
            21: #imageLiteral(resourceName: "Test 2"),
            22: #imageLiteral(resourceName: "Test 2"),
            23: #imageLiteral(resourceName: "Test 2"),
            24: #imageLiteral(resourceName: "Test 2"),
            // Shoulder
            25: #imageLiteral(resourceName: "Test 2"),
            26: #imageLiteral(resourceName: "Test 2"),
            27: #imageLiteral(resourceName: "Test 2"),
            28: #imageLiteral(resourceName: "Test 2"),
            // Band/Bar/Machine Assisted
            29: #imageLiteral(resourceName: "Test 2"),
            30: #imageLiteral(resourceName: "Test 2"),
            31: #imageLiteral(resourceName: "Test 2"),
            32: #imageLiteral(resourceName: "Test 2"),
            33: #imageLiteral(resourceName: "Test 2"),
            34: #imageLiteral(resourceName: "Test 2"),
            // General Mobility
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
            45: #imageLiteral(resourceName: "Test 2"),
            46: #imageLiteral(resourceName: "Test 2"),
            47: #imageLiteral(resourceName: "Test 2"),
            // Accessory
            48: #imageLiteral(resourceName: "Test 2"),
            49: #imageLiteral(resourceName: "Test 2"),
            50: #imageLiteral(resourceName: "Test 2"),
            51: #imageLiteral(resourceName: "Test 2")
        ]
    
    // Target Area Array
    var targetAreaDictionaryFull: [Int : UIImage] =
        [
            // Mandatory
            0: #imageLiteral(resourceName: "Heart"),
            1: #imageLiteral(resourceName: "Heart"),
            // Joint Rotations
            2: #imageLiteral(resourceName: "Wrist Joint"),
            3: #imageLiteral(resourceName: "Elbow Joint"),
            4: #imageLiteral(resourceName: "Shoulder Joint"),
            5: #imageLiteral(resourceName: "Neck Joint"),
            6: #imageLiteral(resourceName: "Waist Joint"),
            7: #imageLiteral(resourceName: "Hip Joint"),
            8: #imageLiteral(resourceName: "Knee Joint"),
            9: #imageLiteral(resourceName: "Ankle Joint"),
            // Foam/Ball Roll
            10: #imageLiteral(resourceName: "Thoracic"),
            11: #imageLiteral(resourceName: "Thoracic"),
            12: #imageLiteral(resourceName: "Lat and Delt"),
            13: #imageLiteral(resourceName: "Pec and Front Delt"),
            14: #imageLiteral(resourceName: "Rear Delt"),
            15: #imageLiteral(resourceName: "Quad"),
            16: #imageLiteral(resourceName: "Adductor"),
            17: #imageLiteral(resourceName: "Hamstring"),
            18: #imageLiteral(resourceName: "Glute"),
            19: #imageLiteral(resourceName: "Calf"),
            // Lower Back
            20: #imageLiteral(resourceName: "Core"),
            21: #imageLiteral(resourceName: "Core"),
            22: #imageLiteral(resourceName: "Core"),
            23: #imageLiteral(resourceName: "Core"),
            24: #imageLiteral(resourceName: "Spine"),
            // Shoulder
            25: #imageLiteral(resourceName: "Shoulder"),
            26: #imageLiteral(resourceName: "Back and Shoulder"),
            27: #imageLiteral(resourceName: "Serratus"),
            28: #imageLiteral(resourceName: "Shoulder"),
            // Band/Bar/Machine Assisted
            29: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            30: #imageLiteral(resourceName: "Rear Delt"),
            31: #imageLiteral(resourceName: "Rear Delt"),
            32: #imageLiteral(resourceName: "Shoulder"),
            33: #imageLiteral(resourceName: "Rear Delt"),
            34: #imageLiteral(resourceName: "Back"),
            // General Mobility
            35: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            36: #imageLiteral(resourceName: "Hip Area"),
            37: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            38: #imageLiteral(resourceName: "Adductor"),
            39: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            40: #imageLiteral(resourceName: "Piriformis"),
            41: #imageLiteral(resourceName: "Adductor"),
            42: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            43: #imageLiteral(resourceName: "Hamstring and Glute"),
            44: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            45: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            46: #imageLiteral(resourceName: "Squat"),
            47: #imageLiteral(resourceName: "Squat"),
            // Accessory
            48: #imageLiteral(resourceName: "Lat"),
            49: #imageLiteral(resourceName: "Calf"),
            50: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            51: #imageLiteral(resourceName: "Back and Bicep")
        ]
    
    // Explanation Array
    var explanationDictionaryFull: [Int: String] =
        [
            // Mandatory
            0: "5minCardioLE",
            1: "5minCardioIE",
            // Joint Rotations
            2: "wristE",
            3: "elbowE",
            4: "shoulderE",
            5: "neckE",
            6: "waistE",
            7: "hipE",
            8: "kneesE",
            9: "anklesE",
            // Foam/Ball Roll
            10: "backfE",
            11: "thoracicSpineE",
            12: "latE",
            13: "pecDeltE",
            14: "rearDeltE",
            15: "quadfE",
            16: "adductorfE",
            17: "hamstringfE",
            18: "glutefE",
            19: "calvefE",
            // Back
            20: "sideLegDropE",
            21: "sideLegKickE",
            22: "scorpionKickE",
            23: "sideBendE",
            24: "catCowE",
            // Shoulder
            25: "wallSlidesE",
            26: "superManShoulderE",
            27: "scapulaE",
            28: "shoulderRotationE",
            // Band/Bar/Machine Assisted
            29: "facePullE",
            30: "externalRotationE",
            31: "internalRotationE",
            32: "shoulderDislocationE",
            33: "rearDeltFlyE",
            34: "latPulloverE",
            // General Mobility
            35: "rollBackE",
            36: "hipCirclesE",
            37: "mountainClimberE",
            38: "groinStretchE",
            39: "gluteBridgeE",
            40: "threadTheNeedleE",
            41: "butterflyPoseE",
            42: "cossakSquatE",
            43: "hipHingesE",
            44: "sideLegSwingsE",
            45: "frontLegSwingsE",
            46: "jumpSquatE",
            47: "lungeE",
            // Accessory
            48: "latStretchE",
            49: "calveStretchE",
            50: "pushUpE",
            51: "pullUpE"
        ]
    
    // Presets Arrys
    //
    // Picker View Array
    var pickerViewArrayFull: [String] =
        [
            "default",
            "beginner",
            "bodyWeight",
            "bodybuilding",
            "strength",
            "highIntensity",
            "quick"
        ]
    
    // Preseys Arrays
    var presetsArraysFull: [[Int]] =
        [
            [],
            [],
            [],
            [],
            [],
            [],
            []
        ]

    
//
// Upper ----------------------------------------------------------------------------------------------------------------------------
//
    // Table View Section Title Array
    var tableViewSectionArrayUpper: [String] =
        [
            "mandatory",
            "jointRotation",
            "foamRoll",
            "lowerBack",
            "shoulder",
            "bandAssisted",
            "accessory"
        ]
    
    // Warmup Key Array Upper
    var warmupKeyArrayUpper: [[Int]] =
        [
            // Mandatory
            [0,
             1],
            // Joint Rotations
            [2,
             3,
             4,
             5,
             6,
             7,
             8,
             9],
            // Foam/Ball Roll
            [10,
             11,
             12,
             13,
             14],
            // Lower Back
            [15,
             16,
             17,
             18,
             19],
            // Shoulder
            [20,
             21,
             22,
             23],
            // Band/Bar/Machine Assisted
            [24,
             25,
             26,
             27,
             28,
             29],
            // Accessory
            [30,
             31,
             32]
    ]
    // Warmup Dictionary Upper
    var warmupDictionaryUpper: [Int : String] =
        [
            // Mandatory
            0: "5minCardioL",
            1: "5minCardioI",
            // Joint Rotations
            2: "wrist",
            3: "elbow",
            4: "shoulderR",
            5: "neckR",
            6: "waist",
            7: "hip",
            8: "knees",
            9: "ankles",
            // Foam/Ball Roll
            10: "backf",
            11: "thoracicSpine",
            12: "lat",
            13: "pecDelt",
            14: "rearDelt",
            // Lower Back
            15: "sideLegDrop",
            16: "sideLegKick",
            17: "scorpionKick",
            18: "sideBend",
            19: "catCow",
            // Shoulder
            20: "wallSlides",
            21: "superManShoulder",
            22: "scapula",
            23: "shoulderRotation",
            // Band/Bar/Machine Assisted
            24: "facePull",
            25: "externalRotation",
            26: "internalRotation",
            27: "shoulderDislocation",
            28: "rearDeltFly",
            29: "latPullover",
            // Accessory
            30: "latStretch",
            31: "pushUp",
            32: "pullUp"
        ]
    
    
    // Screen Arrays
    var setsDictionaryUpper: [Int : Int] =
        [
            // Mandatory
            0: 1,
            1: 1,
            // Joint Rotations
            2: 1,
            3: 1,
            4: 1,
            5: 1,
            6: 1,
            7: 1,
            8: 1,
            9: 1,
            // Foam/Ball Roll
            10: 1,
            11: 3,
            12: 1,
            13: 1,
            14: 1,
            // Lower Back
            15: 1,
            16: 1,
            17: 1,
            18: 1,
            19: 1,
            // Shoulder
            20: 2,
            21: 1,
            22: 1,
            23: 1,
            // Band/Bar/Machine Assisted
            24: 2,
            25: 1,
            26: 1,
            27: 1,
            28: 1,
            29: 1,
            // Accessory
            30: 1,
            31: 1,
            32: 1,
        ]
    
    // Reps Array
    var repsDictionaryUpper: [Int : String] =
        [
            // Mandatory
            0: "5min",
            1: "5min",
            // Joint Rotations
            2: "10-30s",
            3: "10-30s",
            4: "10-30s",
            5: "10-30s",
            6: "10-30s",
            7: "10-30s",
            8: "10-30s",
            9: "10-30s",
            // Foam/Ball Roll
            10: "2-7 reps",
            11: "5-10 reps",
            12: "2-7 reps",
            13: "15-30s",
            14: "15-30s",
            // Lower Back
            15: "5-10 reps",
            16: "5-10 reps",
            17: "5-10 reps",
            18: "5-10 reps",
            19: "15-20 reps",
            // Shoulder
            20: "10-20 reps",
            21: "5-10 reps",
            22: "15 reps",
            23: "10 reps",
            // Band/Bar/Machine Assisted
            24: "10-15 reps",
            25: "5-15 reps",
            26: "5-10 reps",
            27: "5-10 reps",
            28: "10-15 reps",
            29: "10-20 reps",
            // Accessory
            30: "15-30s",
            31: NSLocalizedString("asNecessary", comment: ""),
            32: NSLocalizedString("asNecessary", comment: "")
        ]
    
    // Demonstration Array
    var demonstrationDictionaryUpper: [Int : UIImage] =
        [
            // Mandatory
            0: #imageLiteral(resourceName: "Test 2"),
            1: #imageLiteral(resourceName: "Test 2"),
            // Joint Rotations
            2: #imageLiteral(resourceName: "Test 2"),
            3: #imageLiteral(resourceName: "Test 2"),
            4: #imageLiteral(resourceName: "Test 2"),
            5: #imageLiteral(resourceName: "Test 2"),
            6: #imageLiteral(resourceName: "Test 2"),
            7: #imageLiteral(resourceName: "Test 2"),
            8: #imageLiteral(resourceName: "Test 2"),
            9: #imageLiteral(resourceName: "Test 2"),
            // Foam/Ball Roll
            10: #imageLiteral(resourceName: "Test 2"),
            11: #imageLiteral(resourceName: "Test 2"),
            12: #imageLiteral(resourceName: "Test 2"),
            13: #imageLiteral(resourceName: "Test 2"),
            14: #imageLiteral(resourceName: "Test 2"),
            // Lower Back
            15: #imageLiteral(resourceName: "Test 2"),
            16: #imageLiteral(resourceName: "Test 2"),
            17: #imageLiteral(resourceName: "Test 2"),
            18: #imageLiteral(resourceName: "Test 2"),
            19: #imageLiteral(resourceName: "Test 2"),
            // Shoulder
            20: #imageLiteral(resourceName: "Test 2"),
            21: #imageLiteral(resourceName: "Test 2"),
            22: #imageLiteral(resourceName: "Test 2"),
            23: #imageLiteral(resourceName: "Test 2"),
            // Band/Bar/Machine Assisted
            24: #imageLiteral(resourceName: "Test 2"),
            25: #imageLiteral(resourceName: "Test 2"),
            26: #imageLiteral(resourceName: "Test 2"),
            27: #imageLiteral(resourceName: "Test 2"),
            28: #imageLiteral(resourceName: "Test 2"),
            29: #imageLiteral(resourceName: "Test 2"),
            // Accessory
            30: #imageLiteral(resourceName: "Test 2"),
            31: #imageLiteral(resourceName: "Test 2"),
            32: #imageLiteral(resourceName: "Test 2")
        ]
    
    // Target Area Array
    var targetAreaDictionaryUpper: [Int : UIImage] =
        [
            // Mandatory
            0: #imageLiteral(resourceName: "Heart"),
            1: #imageLiteral(resourceName: "Heart"),
            // Joint Rotations
            2: #imageLiteral(resourceName: "Wrist Joint"),
            3: #imageLiteral(resourceName: "Elbow Joint"),
            4: #imageLiteral(resourceName: "Shoulder Joint"),
            5: #imageLiteral(resourceName: "Neck Joint"),
            6: #imageLiteral(resourceName: "Waist Joint"),
            7: #imageLiteral(resourceName: "Hip Joint"),
            8: #imageLiteral(resourceName: "Knee Joint"),
            9: #imageLiteral(resourceName: "Ankle Joint"),
            // Foam/Ball Roll
            10: #imageLiteral(resourceName: "Thoracic"),
            11: #imageLiteral(resourceName: "Thoracic"),
            12: #imageLiteral(resourceName: "Lat and Delt"),
            13: #imageLiteral(resourceName: "Pec and Front Delt"),
            14: #imageLiteral(resourceName: "Rear Delt"),
            // Lower Back
            15: #imageLiteral(resourceName: "Core"),
            16: #imageLiteral(resourceName: "Core"),
            17: #imageLiteral(resourceName: "Core"),
            18: #imageLiteral(resourceName: "Core"),
            19: #imageLiteral(resourceName: "Spine"),
            // Shoulder
            20: #imageLiteral(resourceName: "Shoulder"),
            21: #imageLiteral(resourceName: "Back and Shoulder"),
            22: #imageLiteral(resourceName: "Serratus"),
            23: #imageLiteral(resourceName: "Shoulder"),
            // Band/Bar/Machine Assisted
            24: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            25: #imageLiteral(resourceName: "Rear Delt"),
            26: #imageLiteral(resourceName: "Rear Delt"),
            27: #imageLiteral(resourceName: "Shoulder"),
            28: #imageLiteral(resourceName: "Rear Delt"),
            29: #imageLiteral(resourceName: "Back"),
            // Accessory
            30: #imageLiteral(resourceName: "Lat"),
            31: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            32: #imageLiteral(resourceName: "Back and Bicep")
        ]
    
    // Explanation Array
    var explanationDictionaryUpper: [Int : String] =
        [
            // Mandatory
            0: "5minCardioLE",
            1: "5minCardioIE",
            // Joint Rotations
            2: "wristE",
            3: "elbowE",
            4: "shoulderRE",
            5: "neckRE",
            6: "waistE",
            7: "hipE",
            8: "kneesE",
            9: "anklesE",
            // Foam/Ball Roll
            10: "backfE",
            11: "thoracicSpineE",
            12: "latE",
            13: "pecDeltE",
            14: "rearDeltE",
            // Lower Back
            15: "sideLegDropE",
            16: "sideLegKickE",
            17: "scorpionKickE",
            18: "sideBendE",
            19: "catCowE",
            // Shoulder
            20: "wallSlidesE",
            21: "superManShoulderE",
            22: "scapulaE",
            23: "shoulderRotationE",
            // Band/Bar/Machine Assisted
            24: "facePullE",
            25: "externalRotationE",
            26: "internalRotationE",
            27: "shoulderDislocationE",
            28: "rearDeltFlyE",
            29: "latPulloverE",
            // Accessory
            30: "latStretchE",
            31: "pushUpE",
            32: "pullUpE"
    ]
    
    // Picker View Array
    var pickerViewArrayUpper: [String] =
        [
            "default",
            "beginner",
            "bodyWeight",
            "bodybuilding",
            "strength",
            "highIntensity",
            "quick"
        ]
    
    // Preseys Arrays
    var presetsArraysUpper: [[Int]] =
    [
        // Default
        [0, 10, 15, 19, 24, 25, 27, 30, 31, 32],
        // Beginner
        [0, 15, 18, 20, 23, 27, 30, 31],
        // BodyWeight
        [0, 15, 16, 17, 19, 20, 22, 23, 30, 31, 32],
        // Bodybuilding
        [0, 10, 12, 14, 15, 16, 17, 20, 23, 24, 25, 29, 30, 31, 32],
        // Strength
        [0, 11, 12, 14, 15, 17, 19, 20, 22, 23,24, 25, 27, 29,30, 31, 32],
        // High Intensity
        [1, 10, 12, 15, 16, 17, 19, 20, 23, 24, 25, 28, 29, 30, 31, 32],
        // Quick
        [0, 10, 15, 19, 20, 23, 24, 27, 30],
    ]
    
    
//
// Lower --------------------------------------------------------------------------------------------------------------------------
//
    // Table View Section Title Array
    var tableViewSectionArrayLower: [String] =
        [
            "mandatory",
            "jointRotation",
            "foamRoll",
            "lowerBack",
            "generalMobility",
            "accessory"
    ]
    
    // Warmup Key Dictionary Lower
    var warmupKeyArrayLower: [[Int]] =
        [
            // Mandatory
            [0,
             1],
            // Joint Rotations
            [2,
             3,
             4,
             5,
             6,
             7,
             8,
             9],
            // Foam/Ball Roll
            [10,
             11,
             12,
             13,
             14,
             15,
             16],
            // Lower Back
            [17,
             18,
             19,
             20,
             21],
            // General Mobility
            [22,
             23,
             24,
             25,
             26,
             27,
             28,
             29,
             30,
             31,
             32,
             33,
             34],
            // Accessory
            [35,
             36]
        ]
    
    // Warmup Lower Array
    var warmupDictionaryLower: [Int : String] =
        [
            // Mandatory
            0: "5minCardioL",
            1: "5minCardioI",
            // Joint Rotations
            2:"wrist",
            3: "elbow",
            4: "shoulderR",
            5: "neckR",
            6: "waist",
            7: "hip",
            8: "knees",
            9: "ankles",
            // Foam/Ball Roll
            10: "backf",
            11: "thoracicSpine",
            12: "quadf",
            13: "adductorf",
            14: "hamstringf",
            15: "glutef",
            16: "calvef",
            // Lower Back
            17: "sideLegDrop",
            18: "sideLegKick",
            19: "scorpionKick",
            20: "sideBend",
            21: "catCow",
            // General Mobility
            22: "rollBack",
            23: "hipCircles",
            24: "mountainClimber",
            25: "groinStretch",
            26: "gluteBridge",
            27: "threadTheNeedle",
            28: "butterflyPose",
            29: "cossakSquat",
            30: "hipHinges",
            31: "sideLegSwings",
            32: "frontLegSwings",
            33: "jumpSquat",
            34: "lunge",
            // Accessory
            35: "wallSlides",
            36: "calveStretch"
        ]
    
    // Screen Arrays
    var setsDictionaryLower: [Int : Int] =
        [
            // Mandatory
            0: 1,
            1: 1,
            // Joint Rotations
            2: 1,
            3: 1,
            4: 1,
            5: 1,
            6: 1,
            7: 1,
            8: 1,
            9: 1,
            // Foam/Ball Roll
            10: 1,
            11: 3,
            12: 1,
            13: 1,
            14: 1,
            15: 1,
            16: 1,
            // Lower Back
            17: 1,
            18: 1,
            19: 1,
            20: 1,
            21: 1,
            // General Mobility
            22: 1,
            23: 1,
            24: 1,
            25: 1,
            26: 1,
            27: 1,
            28: 1,
            29: 1,
            30: 2,
            31: 1,
            32: 1,
            33: 2,
            34: 2,
            // Accessory
            35: 2,
            36: 1
        ]

    // Reps Array
    var repsDictionaryLower: [Int : String] =
        [
            // Mandatory
            0: "5min",
            1: "5min",
            // Joint Rotations
            2: "10-30s",
            3: "10-30s",
            4: "10-30s",
            5: "10-30s",
            6: "10-30s",
            7: "10-30s",
            8: "10-30s",
            9: "10-30s",
            // Foam/Ball Roll
            10: "2-7 reps",
            11: "5-10 reps",
            12: "2-7 reps",
            13: "2-7 reps",
            14: "2-7 reps",
            15: "2-7 reps",
            16: "2-7 reps",
            // Lower Back
            17: "5-10 reps",
            18: "5-10 reps",
            19: "5-10 reps",
            20: "5-10 reps",
            21: "15-20 reps",
            // General Mobility
            22: "10-15 reps",
            23: "5-10 reps",
            24: "5-10 reps",
            25: "5-10 reps",
            26: "10-15 reps",
            27: "15-30s",
            28: "15-30s",
            29: "5-10 reps",
            30: "10-20 reps",
            31: "10-20 reps",
            32: "10-20 reps",
            33: "5-15 reps",
            34: "10-15 reps",
            // Accessory
            35: "10-20 reps",
            36: "15-30s"
        ]

    // Demonstration Array
    var demonstrationDictionaryLower: [Int: UIImage] =
        [
            // Mandatory
            0: #imageLiteral(resourceName: "Test 2"),
            1: #imageLiteral(resourceName: "Test 2"),
            // Joint Rotations
            2: #imageLiteral(resourceName: "Test 2"),
            3: #imageLiteral(resourceName: "Test 2"),
            4: #imageLiteral(resourceName: "Test 2"),
            5: #imageLiteral(resourceName: "Test 2"),
            6: #imageLiteral(resourceName: "Test 2"),
            7: #imageLiteral(resourceName: "Test 2"),
            8: #imageLiteral(resourceName: "Test 2"),
            9: #imageLiteral(resourceName: "Test 2"),
            // Foam/Ball Roll
            10: #imageLiteral(resourceName: "Test 2"),
            11: #imageLiteral(resourceName: "Test 2"),
            12: #imageLiteral(resourceName: "Test 2"),
            13: #imageLiteral(resourceName: "Test 2"),
            14: #imageLiteral(resourceName: "Test 2"),
            15: #imageLiteral(resourceName: "Test 2"),
            16: #imageLiteral(resourceName: "Test 2"),
            // Lower Back
            17: #imageLiteral(resourceName: "Test 2"),
            18: #imageLiteral(resourceName: "Test 2"),
            19: #imageLiteral(resourceName: "Test 2"),
            20: #imageLiteral(resourceName: "Test 2"),
            21: #imageLiteral(resourceName: "Test 2"),
            // General Mobility
            22: #imageLiteral(resourceName: "Test 2"),
            23: #imageLiteral(resourceName: "Test 2"),
            24: #imageLiteral(resourceName: "Test 2"),
            25: #imageLiteral(resourceName: "Test 2"),
            26: #imageLiteral(resourceName: "Test 2"),
            27: #imageLiteral(resourceName: "Test 2"),
            28: #imageLiteral(resourceName: "Test 2"),
            29: #imageLiteral(resourceName: "Test 2"),
            30: #imageLiteral(resourceName: "Test 2"),
            31: #imageLiteral(resourceName: "Test 2"),
            32: #imageLiteral(resourceName: "Test 2"),
            33: #imageLiteral(resourceName: "Test 2"),
            34: #imageLiteral(resourceName: "Test 2"),
            // Accessory
            35: #imageLiteral(resourceName: "Test 2"),
            36: #imageLiteral(resourceName: "Test 2")
        ]

    // Target Area Array
    var targetAreaDictionaryLower: [Int : UIImage] =
        [
            // Mandatory
            0: #imageLiteral(resourceName: "Heart"),
            1: #imageLiteral(resourceName: "Heart"),
            // Joint Rotations
            2: #imageLiteral(resourceName: "Wrist Joint"),
            3: #imageLiteral(resourceName: "Elbow Joint"),
            4: #imageLiteral(resourceName: "Shoulder Joint"),
            5: #imageLiteral(resourceName: "Neck Joint"),
            6: #imageLiteral(resourceName: "Waist Joint"),
            7: #imageLiteral(resourceName: "Hip Joint"),
            8: #imageLiteral(resourceName: "Knee Joint"),
            9: #imageLiteral(resourceName: "Ankle Joint"),
            // Foam/Ball Roll
            10: #imageLiteral(resourceName: "Thoracic"),
            11: #imageLiteral(resourceName: "Thoracic"),
            12: #imageLiteral(resourceName: "Quad"),
            13: #imageLiteral(resourceName: "Adductor"),
            14: #imageLiteral(resourceName: "Hamstring"),
            15: #imageLiteral(resourceName: "Glute"),
            16: #imageLiteral(resourceName: "Calf"),
            // Lower Back
            17: #imageLiteral(resourceName: "Core"),
            18: #imageLiteral(resourceName: "Core"),
            19: #imageLiteral(resourceName: "Core"),
            20: #imageLiteral(resourceName: "Core"),
            21: #imageLiteral(resourceName: "Spine"),
            // General Mobility
            22: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            23: #imageLiteral(resourceName: "Hip Area"),
            24: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            25: #imageLiteral(resourceName: "Adductor"),
            26: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            27: #imageLiteral(resourceName: "Piriformis"),
            28: #imageLiteral(resourceName: "Adductor"),
            29: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            30: #imageLiteral(resourceName: "Hamstring and Glute"),
            31: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            32: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            33: #imageLiteral(resourceName: "Squat"),
            34: #imageLiteral(resourceName: "Squat"),
            // Accessory
            35: #imageLiteral(resourceName: "Shoulder"),
            36: #imageLiteral(resourceName: "Calf")
        ]
    
    // Explanation Array
    var explanationDictionaryLower: [Int : String] =
        [
            // Mandatory
            0: "5minCardioLE",
            1: "5minCardioIE",
            // Joint Rotations
            2: "wristE",
            3: "elbowE",
            4: "shoulderE",
            5: "neckE",
            6: "waistE",
            7: "hipE",
            8: "kneesE",
            9: "anklesE",
            // Foam/Ball Roll
            10: "backfE",
            11: "thoracicSpineE",
            12: "quadfE",
            13: "adductorfE",
            14: "hamstringfE",
            15: "glutefE",
            16: "calvefE",
            // Lower Back
            17: "sideLegDropE",
            18: "sideLegKickE",
            19: "scorpionKickE",
            20: "sideBendE",
            21: "catCowE",
            // General Mobility
            22: "rollBackE",
            23: "hipCirclesE",
            24: "mountainClimberE",
            25: "groinStretchE",
            26: "gluteBridgeE",
            27: "threadTheNeedleE",
            28: "butterflyPoseE",
            29: "cossakSquatE",
            30: "hipHingesE",
            31: "sideLegSwingsE",
            32: "frontLegSwingsE",
            33: "jumpSquatE",
            34: "lungeE",
            // Accessory
            35: "wallSlidesE",
            36: "calveStretchE"
        ]
    
    // Picker View Array
    var pickerViewArrayLower: [String] =
        [
            "default",
            "beginner",
            "bodyWeight",
            "bodybuilding",
            "strength",
            "highIntensity",
            "quick"
    ]
    
    // Preseys Arrays
    var presetsArraysLower: [[Int]] =
        [
            [0, 11, 12, 14, 17, 19, 21, 23, 26, 31, 32, 33, 35, 36],
            [],
            [],
            [],
            [],
            [],
            []
        ]
    
    
//
// Cardio ----------------------------------------------------------------------------------------------------------------------------
//
    // Table View Section Title Array
    var tableViewSectionArrayCardio: [String] =
        [
            "jointRotation",
            "foamRoll",
            "lowerBack",
            "generalMobility",
            "dynamicWarmupDrills",
            "accessory"
    ]
    
    // Warmup Cardio Array
    var warmupKeyArrayCardio: [[Int]] =
        [
            // Joint Rotations
            [0,
             1,
             2,
             3,
             4,
             5,
             6,
             7],
            // Foam/Ball Roll
            [8,
             9,
             10,
             11,
             12,
             13,
             14],
            // Lower Back
            [15,
             16,
             17,
             18,
             19],
            // General Mobility
            [20,
             21,
             22,
             23,
             24,
             25,
             26,
             27,
             28,
             29],
            // Dynamic Warm Up Drills
            [30,
             31,
             32,
             33,
             34,
             35,
             36,
             37,
             38],
            // Accessory
            [39,
             40,
             41]
    ]
    
    // Warmup Cardio Array
    var warmupDictionaryCardio: [Int : String] =
        [
            // Joint Rotations
            0: "wrist",
            1: "elbow",
            2: "shoulderR",
            3: "neckR",
            4: "waist",
            5: "hip",
            6: "knees",
            7: "ankles",
            // Foam/Ball Roll
            8: "thoracicSpine",
            9: "lat",
            10: "quadf",
            11: "adductorf",
            12: "hamstringf",
            13: "glutef",
            14: "calvef",
            // Lower Back
            15: "sideLegDrop",
            16: "sideLegKick",
            17: "scorpionKick",
            18: "sideBend",
            19: "catCow",
            // General Mobility
            20: "hipCircles",
            21: "mountainClimber",
            22: "groinStretch",
            23: "gluteBridge",
            24: "threadTheNeedle",
            25: "butterflyPose",
            26: "cossakSquat",
            27: "hipHinges",
            28: "sideLegSwings",
            29: "frontLegSwings",
            // Dynamic Warm Up Drills
            30: "jumpSquat",
            31: "lunge",
            32: "gluteKicks",
            33: "aSkips",
            34: "bSkips",
            35: "grapeVines",
            36: "lateralBound",
            37: "straightLegBound",
            38: "sprints",
            // Accessory
            39: "wallSlides",
            40: "latStretch",
            41: "calveStretch"
        ]
    
    // Screen Arrays
    var setsDictionaryCardio: [Int : Int] =
        [
            // Joint Rotations
            0: 1,
            1: 1,
            2: 1,
            3: 1,
            4: 1,
            5: 1,
            6: 1,
            7: 1,
            // Foam/Ball Roll
            8: 3,
            9: 1,
            10: 1,
            11: 1,
            12: 1,
            13: 1,
            14: 1,
            // Lower Back
            15: 1,
            16: 1,
            17: 1,
            18: 1,
            19: 1,
            // General Mobility
            20: 1,
            21: 1,
            22: 1,
            23: 1,
            24: 2,
            25: 1,
            26: 1,
            27: 2,
            28: 1,
            29: 1,
            // Dynamic Warm Up Drills
            30: 2,
            31: 2,
            32: 3,
            33: 3,
            34: 3,
            35: 2,
            36: 2,
            37: 2,
            38: 4,
            // Accessory
            39: 2,
            40: 1,
            41: 1
        ]
    
    // Reps Array
    var repsDictionaryCardio: [Int : String] =
        [
            // Joint Rotations
            0: "10-30s",
            1: "10-30s",
            2: "10-30s",
            3: "10-30s",
            4: "10-30s",
            5: "10-30s",
            6: "10-30s",
            7: "10-30s",
            // Foam/Ball Roll
            8: "2-7 reps",
            9: "5-10 reps",
            10: "2-7 reps",
            11: "2-7 reps",
            12: "2-7 reps",
            13: "2-7 reps",
            14: "2-7 reps",
            // Lower Back
            15: "5-10 reps",
            16: "5-10 reps",
            17: "5-10 reps",
            18: "5-10 reps",
            19: "15-20 reps",
            // General Mobility
            20: "5-10 reps",
            21: "5-10 reps",
            22: "5-10 reps",
            23: "10-15 reps",
            24: "15-30s",
            25: "15-30s",
            26: "5-10 reps",
            27: "15-30s",
            28: "10-20 reps",
            29: "10-20 reps",
            // Dynamic Warm Up Drills
            30: "5-15 reps",
            31: "10-15 reps",
            32: "15-30s",
            33: "15-30s",
            34: "15-30s",
            35: "50m",
            36: "50m",
            37: "50m",
            38: "5-20 reps",
            // Accessory
            39: "10-15 reps",
            40: "15-30s",
            41: "15-30s",
        ]
  
    // Demonstration Array
    var demonstrationDictionaryCardio: [Int : UIImage] =
        [
            // Joint Rotations
            0: #imageLiteral(resourceName: "Test 2"),
            1: #imageLiteral(resourceName: "Test 2"),
            2: #imageLiteral(resourceName: "Test 2"),
            3: #imageLiteral(resourceName: "Test 2"),
            4: #imageLiteral(resourceName: "Test 2"),
            5: #imageLiteral(resourceName: "Test 2"),
            6: #imageLiteral(resourceName: "Test 2"),
            7: #imageLiteral(resourceName: "Test 2"),
            // Foam/Ball Roll
            8: #imageLiteral(resourceName: "Test 2"),
            9: #imageLiteral(resourceName: "Test 2"),
            10: #imageLiteral(resourceName: "Test 2"),
            11: #imageLiteral(resourceName: "Test 2"),
            12: #imageLiteral(resourceName: "Test 2"),
            13: #imageLiteral(resourceName: "Test 2"),
            14: #imageLiteral(resourceName: "Test 2"),
            // Lower Back
            15: #imageLiteral(resourceName: "Test 2"),
            16: #imageLiteral(resourceName: "Test 2"),
            17: #imageLiteral(resourceName: "Test 2"),
            18: #imageLiteral(resourceName: "Test 2"),
            19: #imageLiteral(resourceName: "Test 2"),
            // General Mobility
            20: #imageLiteral(resourceName: "Test 2"),
            21: #imageLiteral(resourceName: "Test 2"),
            22: #imageLiteral(resourceName: "Test 2"),
            23: #imageLiteral(resourceName: "Test 2"),
            24: #imageLiteral(resourceName: "Test 2"),
            25: #imageLiteral(resourceName: "Test 2"),
            26: #imageLiteral(resourceName: "Test 2"),
            27: #imageLiteral(resourceName: "Test 2"),
            28: #imageLiteral(resourceName: "Test 2"),
            29: #imageLiteral(resourceName: "Test 2"),
            // Dynamic Warm Up Drills
            30: #imageLiteral(resourceName: "Test 2"),
            31: #imageLiteral(resourceName: "Test 2"),
            32: #imageLiteral(resourceName: "Test 2"),
            33: #imageLiteral(resourceName: "Test 2"),
            34: #imageLiteral(resourceName: "Test 2"),
            35: #imageLiteral(resourceName: "Test 2"),
            36: #imageLiteral(resourceName: "Test 2"),
            37: #imageLiteral(resourceName: "Test 2"),
            38: #imageLiteral(resourceName: "Test 2"),
            // Accessory
            39: #imageLiteral(resourceName: "Test 2"),
            40: #imageLiteral(resourceName: "Test 2"),
            41: #imageLiteral(resourceName: "Test 2")
        ]

    // Target Area Array
    var targetAreaDictionaryCardio: [Int : UIImage] =
        [
            // Joint Rotations
            0: #imageLiteral(resourceName: "Wrist Joint"),
            1: #imageLiteral(resourceName: "Elbow Joint"),
            2: #imageLiteral(resourceName: "Shoulder Joint"),
            3: #imageLiteral(resourceName: "Neck Joint"),
            4: #imageLiteral(resourceName: "Waist Joint"),
            5: #imageLiteral(resourceName: "Hip Joint"),
            6: #imageLiteral(resourceName: "Knee Joint"),
            7: #imageLiteral(resourceName: "Ankle Joint"),
            // Foam/Ball Roll
            8: #imageLiteral(resourceName: "Thoracic"),
            9: #imageLiteral(resourceName: "Lat and Delt"),
            10: #imageLiteral(resourceName: "Quad"),
            11: #imageLiteral(resourceName: "Adductor"),
            12: #imageLiteral(resourceName: "Hamstring"),
            13: #imageLiteral(resourceName: "Glute"),
            14: #imageLiteral(resourceName: "Calf"),
            // Lower Back
            15: #imageLiteral(resourceName: "Core"),
            16: #imageLiteral(resourceName: "Core"),
            17: #imageLiteral(resourceName: "Core"),
            18: #imageLiteral(resourceName: "Core"),
            19: #imageLiteral(resourceName: "Spine"),
            // General Mobility
            20: #imageLiteral(resourceName: "Hip Area"),
            21: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            22: #imageLiteral(resourceName: "Adductor"),
            23: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            24: #imageLiteral(resourceName: "Piriformis"),
            25: #imageLiteral(resourceName: "Adductor"),
            26: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            27: #imageLiteral(resourceName: "Hamstring and Glute"),
            28: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            29: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            // Dynamic Warm Up Drills
            30: #imageLiteral(resourceName: "Squat"),
            31: #imageLiteral(resourceName: "Squat"),
            32: #imageLiteral(resourceName: "Squat"),
            33: #imageLiteral(resourceName: "Squat"),
            34: #imageLiteral(resourceName: "Squat"),
            35: #imageLiteral(resourceName: "Squat"),
            36: #imageLiteral(resourceName: "Squat"),
            37: #imageLiteral(resourceName: "Squat"),
            38: #imageLiteral(resourceName: "Squat"),
            // Accessory
            39: #imageLiteral(resourceName: "Shoulder"),
            40: #imageLiteral(resourceName: "Lat"),
            41: #imageLiteral(resourceName: "Calf")
        ]
    
    // Explanation Array
    var explanationDictionaryCardio: [Int : String] =
        [
            // Joint Rotations
            0: "wristE",
            1: "elbowE",
            2: "shoulderRE",
            3: "neckRE",
            4: "waistE",
            5: "hipE",
            6: "kneesE",
            7: "anklesE",
            // Foam/Ball Roll
            8: "thoracicSpineE",
            9: "latE",
            10: "quadfE",
            11: "adductorfE",
            12: "hamstringfE",
            13: "glutefE",
            14: "calvefE",
            // Lower Back
            15: "sideLegDropE",
            16: "sideLegKickE",
            17: "scorpionKickE",
            18: "sideBendE",
            19: "catCowE",
            // General Mobility
            20: "hipCirclesE",
            21: "mountainClimberE",
            22: "groinStretchE",
            23: "gluteBridgeE",
            24: "threadTheNeedleE",
            25: "butterflyPoseE",
            26: "cossakSquatE",
            27: "hipHingesE",
            28: "sideLegSwingsE",
            29: "frontLegSwingsE",
            // Dynamic Warm Up Drills
            30: "jumpSquatE",
            31: "lungeE",
            32: "gluteKicksE",
            33: "aSkipsE",
            34: "bSkipsE",
            35: "grapeVinesE",
            36: "lateralBoundE",
            37: "straightLegBoundE",
            38: "sprintsE",
            // Accessory
            39: "wallSlidesE",
            40: "latStretchE",
            41: "calveStretchE"
        ]
    
    // Picker View Array
    var pickerViewArrayCardio: [String] =
        [
            "default",
            "beginner",
            "bodyWeight",
            "bodybuilding",
            "strength",
            "highIntensity",
            "quick"
            
    ]
    
    // Preseys Arrays
    var presetsArraysCardio: [[Int]] =
        [
            [],
            [],
            [],
            [],
            [],
            [],
            []
        ]
    
    
    // Set Arrays Function
    func setArrays() {
        //
        switch warmupType {
        //
        case 0:
            // Choice Screen Arrays
                warmupKeyArray = warmupKeyArrayFull
                warmupMovementsDictionary = warmupDictionaryFull
                warmupSelectedArray = presetsArraysFull[0]
                pickerViewArray = pickerViewArrayFull
                tableViewSectionArray = tableViewSectionArrayFull
                presetsArrays = presetsArraysFull
            // Screen Arrays
                setsDictionary = setsDictionaryFull
                repsDictionary = repsDictionaryFull
                demonstrationDictionary = demonstrationDictionaryFull
                targetAreaDictionary = targetAreaDictionaryFull
                explanationDictionary = explanationDictionaryFull
        //
        case 1:
            // Choice Screen Arrays
                warmupKeyArray = warmupKeyArrayUpper
                warmupMovementsDictionary = warmupDictionaryUpper
                warmupSelectedArray = presetsArraysUpper[0]
                pickerViewArray = pickerViewArrayUpper
                tableViewSectionArray = tableViewSectionArrayUpper
                presetsArrays = presetsArraysUpper
            // Screen Arrays
                setsDictionary = setsDictionaryUpper
                repsDictionary = repsDictionaryUpper
                demonstrationDictionary = demonstrationDictionaryUpper
                targetAreaDictionary = targetAreaDictionaryUpper
                explanationDictionary = explanationDictionaryUpper
        //
        case 2:
            // Choice Screen Arrays
                warmupKeyArray = warmupKeyArrayLower
                warmupMovementsDictionary = warmupDictionaryLower
                warmupSelectedArray = presetsArraysLower[0]
                pickerViewArray = pickerViewArrayLower
                tableViewSectionArray = tableViewSectionArrayLower
                presetsArrays = presetsArraysLower
            // Screen Arrays
                setsDictionary = setsDictionaryLower
                repsDictionary = repsDictionaryLower
                demonstrationDictionary = demonstrationDictionaryLower
                targetAreaDictionary = targetAreaDictionaryLower
                explanationDictionary = explanationDictionaryLower
        //
        case 3:
            // Choice Screen Arrays
                warmupKeyArray = warmupKeyArrayCardio
                warmupMovementsDictionary = warmupDictionaryCardio
                warmupSelectedArray = presetsArraysCardio[0]
                pickerViewArray = pickerViewArrayCardio
                tableViewSectionArray = tableViewSectionArrayCardio
                presetsArrays = presetsArraysCardio
            // Screen Arrays
                setsDictionary = setsDictionaryCardio
                repsDictionary = repsDictionaryCardio
                demonstrationDictionary = demonstrationDictionaryCardio
                targetAreaDictionary = targetAreaDictionaryCardio
                explanationDictionary = explanationDictionaryCardio
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
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Information View
    let informationView = UIScrollView()
    // Information Title Label
    let informationTitle = UILabel()
    
    // PickerViews
    @IBOutlet weak var pickerView: UIPickerView!
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    // Add Preset
    @IBOutlet weak var addPreset: UIButton!
    @IBOutlet weak var removePreset: UIButton!
    
    let emptyString = ""
    
    
    // Flash Screen
    func flashScreen() {
        //
        let flash = UIView()
        //
        flash.frame = CGRect(x: 0, y: pickerView.frame.maxY, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        //
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
            flash.alpha = 0
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
    }
    
    
//
// View did load ------------------------------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Arrays
        //
        setArrays()
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2")
        }
        
        // Colour
        self.view.applyGradient(colours: [colour1, colour1])
        questionMark.tintColor = colour1
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString(navigationTitles[warmupType], comment: ""))
        
        // Picker View
        pickerView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        // Plus Button Colour
        let origImage1 = UIImage(named: "Plus")
        let tintedImage1 = origImage1?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        addPreset.setImage(tintedImage1, for: .normal)
        //Image Tint
        addPreset.tintColor = colour2
        
        // Minus Button Colour
        let origImage2 = UIImage(named: "Minus")
        let tintedImage2 = origImage2?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        removePreset.setImage(tintedImage2, for: .normal)
        //Image Tint
        removePreset.tintColor = colour2
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.setTitleColor(colour2, for: .normal)
        
        
        // Information
        // Scroll View Frame
        self.informationView.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        informationView.backgroundColor = colour1
        // Information Text
        //
        // Information Text Frame
        let informationText = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationView.frame.size.width - 40, height: 0))
        // Information Text Frame
        self.informationTitle.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 49)
        informationTitle.text = (NSLocalizedString("information", comment: ""))
        informationTitle.textAlignment = .center
        informationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitle.textColor = colour1
        informationTitle.backgroundColor = colour2
        //
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationTitle.addGestureRecognizer(downSwipe)
        informationTitle.isUserInteractionEnabled = true
        // Information Text and Attributes
        //
        // String
        let informationLabelString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("warmupChoiceText", comment: "")))
        // Range of String
        let textRangeString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("warmupChoiceText", comment: "")))
        let textRange = (informationLabelString as NSString).range(of: textRangeString)
        // Range of Titles
        let titleRangeString = (NSLocalizedString("movements", comment: ""))
        let titleRange1 = (informationLabelString as NSString).range(of: titleRangeString)
        // Line Spacing
        let lineSpacing = NSMutableParagraphStyle()
        lineSpacing.lineSpacing = 1.6
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-thin", size: 21)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 21)!, range: titleRange1)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        // Final Text Editing
        informationText.attributedText = informationLabelText
        informationText.textAlignment = .natural
        informationText.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationText.numberOfLines = 0
        informationText.sizeToFit()
        self.informationView.addSubview(informationText)
        //
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationText.frame.size.height + informationTitle.frame.size.height + 20)
        // TableView Background
        if String(describing: colour2) == String(describing: UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)) {
            //
            let tableViewBackground = UIView()
            //
            tableViewBackground.backgroundColor = colour2
            tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
            //
            tableView.backgroundView = tableViewBackground
        }
        
        //
        // Preset Warmups
        //
        let defaults = UserDefaults.standard
        // Full Body
        defaults.register(defaults: ["warmupPresetsFull" : emptyArrayofArrays])
        defaults.register(defaults: ["warmupPresetTextsFull" : presetTexts])
        // Upper Body
        defaults.register(defaults: ["warmupPresetsUpper" : emptyArrayofArrays])
        defaults.register(defaults: ["warmupPresetTextsUpper" : presetTexts])
        // Lower Body
        defaults.register(defaults: ["warmupPresetsLower" : emptyArrayofArrays])
        defaults.register(defaults: ["warmupPresetTextsLower" : presetTexts])
        // Cardio
        defaults.register(defaults: ["warmupPresetsCardio" : emptyArrayofArrays])
        defaults.register(defaults: ["warmupPresetTextsCardio" : presetTexts])
        //
        defaults.synchronize()
        
        //
        beginButtonEnabled()
    }
   
//
// Begin button check if should be enabled func
//
    // Button Enabled
    func beginButtonEnabled() {
        // Begin Button
        if warmupSelectedArray.count != 0 {
            beginButton.isEnabled = true
        } else {
            beginButton.isEnabled = false
        }
    }
    
    
//
// Custom Warmups --------------------------------------------------------------------------------------------------------------
//
    //
    var okAction = UIAlertAction()
    // Add
    @IBAction func addPreset(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        var warmupPreset = defaults.object(forKey: warmupPresets[warmupType]) as! [[Int]]
        var presetTextArray = defaults.object(forKey: warmupPresetTexts[warmupType]) as! [String]
        
        // Set Preset
            // Alert and Functions
            //
            let inputTitle = NSLocalizedString("warmupInputTitle", comment: "")
            //
            let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
            alert.view.tintColor = colour2
            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.text = " "
                textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
            }
            // 3. Get the value from the text field, and perform actions when OK clicked.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                //
                let textField = alert?.textFields![0]
                // Update Preset Text Arrays
                presetTextArray.append((textField?.text)!)
                defaults.set(presetTextArray, forKey: self.warmupPresetTexts[self.warmupType])
                defaults.synchronize()
                // Set new Preset Array
                //
                warmupPreset.append(self.warmupSelectedArray)
                defaults.set(warmupPreset, forKey: self.warmupPresets[self.warmupType])
                //
                defaults.synchronize()
                // Flash Screen
                self.flashScreen()
                self.pickerView.reloadAllComponents()
                self.tableView.reloadData()
                
            }))
            // Cancel reset action
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alert.addAction(cancelAction)
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
    }

    // Remove
    @IBAction func removePreset(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        var warmupPreset = defaults.object(forKey: warmupPresets[warmupType]) as! [[Int]]
        var presetTextArray = defaults.object(forKey: warmupPresetTexts[warmupType]) as! [String]
        //
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let index = (selectedRow) - (pickerViewArray.count + 1)
        //
        //
        let inputTitle = NSLocalizedString("warmupRemoveTitle", comment: "")
        //
        let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
        alert.view.tintColor = colour2
        alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            // 3. Get the value from the text field, and perform actions upon OK press
            okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                //
                warmupPreset.remove(at: index)
                defaults.set(warmupPreset, forKey: self.warmupPresets[self.warmupType])
                //
                presetTextArray.remove(at: index)
                defaults.set(presetTextArray, forKey: self.warmupPresetTexts[self.warmupType])
                //
                defaults.synchronize()
                // Flash Screen
                self.flashScreen()
                self.pickerView.reloadAllComponents()
                self.tableView.reloadData()
            })
        //
        if index > -1 {
            alert.addAction(okAction)
        } else {
        }
        // Cancel reset action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alert.addAction(cancelAction)
        //
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
//
// Picker View ------------------------------------------------------------------------------------------------------------------------------
//
    // Number of components
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
   
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let titleDataArray = UserDefaults.standard.object(forKey: warmupPresetTexts[warmupType]) as! [String]
        return pickerViewArray.count + 1 + titleDataArray.count
        
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        if row < pickerViewArray.count {
            let rowLabel = UILabel()
            let titleData = NSLocalizedString(pickerViewArray[row], comment: "")
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
        //
        } else if row == pickerViewArray.count {
            let line = UILabel()
            line.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * (2/3), height: 1)
            line.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            line.isEnabled = false
            return line
        //
        } else if row > pickerViewArray.count {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: warmupPresetTexts[warmupType]) as! [String]
            let titleData = titleDataArray[row - (pickerViewArray.count + 1)]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
        //
        }
        return UIView()
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Did select
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
        let defaults = UserDefaults.standard
        //
        switch row {
        //
        case 0,1,2,3,4,5,6:
            warmupSelectedArray = presetsArrays[row]
            self.tableView.reloadData()
            flashScreen()
        case 7:
            break
        //
        case _ where row > 7:
            let presetsArrayCustom = defaults.object(forKey: warmupPresets[warmupType]) as! [[Int]]
            var presetsArray = [Int]()
            if presetsArrayCustom.count != 0 {
                presetsArray = presetsArrayCustom[row - (pickerViewArray.count + 1)]
            } else {
                 presetsArray = []
            }
            warmupSelectedArray = presetsArray
            self.tableView.reloadData()
            flashScreen()
            
        //
        default:
            break
        }
        beginButtonEnabled()
    }
    
    
//
// TableView -----------------------------------------------------------------------------------------------------------------------
//
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSectionArray.count
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(tableViewSectionArray[section], comment: "")
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 18)!
        header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        header.contentView.tintColor = colour1
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return warmupKeyArray[section].count
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        //
        cell.textLabel?.text = NSLocalizedString(warmupMovementsDictionary[warmupKeyArray[indexPath.section][indexPath.row]]!, comment: "")
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        cell.textLabel?.textColor = .black
        cell.tintColor = .black
        //
        let key = warmupKeyArray[indexPath.section][indexPath.row]
        if warmupSelectedArray.contains(key) {
            cell.layer.borderColor = colour2.cgColor
            cell.layer.borderWidth = 2
            
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        // Cell Image
        cell.imageView?.image = demonstrationDictionary[warmupKeyArray[indexPath.section][indexPath.row]]
        cell.imageView?.isUserInteractionEnabled = true
        // Image Tap
        let imageTap = UITapGestureRecognizer()
        imageTap.numberOfTapsRequired = 1
        imageTap.addTarget(self, action: #selector(handleTap))
        cell.imageView?.addGestureRecognizer(imageTap)
        //
        return cell
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        //
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            let keyToRemove = warmupKeyArray[indexPath.section][indexPath.row]
            warmupSelectedArray = warmupSelectedArray.filter() {$0 != keyToRemove}
            tableView.reloadData()
        } else {
            cell?.accessoryType = .checkmark
            let keyToAdd = warmupKeyArray[indexPath.section][indexPath.row]
            warmupSelectedArray.append(keyToAdd)
            tableView.reloadData()
        }
        //
        beginButtonEnabled()
    }
    
    
//
// Information Actions ---------------------------------------------------------------------------------------------------------------------------
//
    // QuestionMark Button Action
    @IBAction func informationButtonAction(_ sender: Any) {
        // Slide information down
        if self.informationView.frame.minY < self.view.frame.maxY {
            // Animate slide
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            //
            self.informationView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            // Remove after animation
            let delayInSeconds = 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.informationView.removeFromSuperview()
                self.informationTitle.removeFromSuperview()
            }
            // Navigation buttons
            questionMark.image = #imageLiteral(resourceName: "QuestionMarkN")
            navigationBar.setHidesBackButton(false, animated: true)
            
            // Slide information up
        } else {
            //
            view.addSubview(informationView)
            view.addSubview(informationTitle)
            //
            view.bringSubview(toFront: informationView)
            view.bringSubview(toFront: informationTitle)
            // Animate slide
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.informationView.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
            }, completion: nil)
            //
            self.informationView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            // Navigation buttons
            questionMark.image = #imageLiteral(resourceName: "Down")
            navigationBar.setHidesBackButton(true, animated: true)
        }
    }
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        // Information Swipe Down
        if (extraSwipe.direction == .down){
            // Animate slide
            if self.informationView.frame.minY < self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
                // Navigation buttons
                questionMark.image = #imageLiteral(resourceName: "QuestionMarkN")
                navigationBar.setHidesBackButton(false, animated: true)
            }
        }
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
        self.questionMark.isEnabled = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewImage, aboveSubview: view)
            UIApplication.shared.keyWindow?.insertSubview(expandedImage, aboveSubview: backgroundViewImage)
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.expandedImage.center.y = (height/2) * 1.5
            self.backgroundViewImage.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract image
    @IBAction func retractImage(_ sender: Any) {
        //
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.expandedImage.center.y = (height/2) * 2.5
            self.backgroundViewImage.alpha = 0
        }, completion: nil)
        //
        let delayInSeconds = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            //
            self.expandedImage.removeFromSuperview()
            self.backgroundViewImage.removeFromSuperview()
            self.questionMark.isEnabled = true
            self.navigationItem.setHidesBackButton(false, animated: true)
        }
    }
    
    
//
// Begin Button ---------------------------------------------------------------------------------------------------------------------------
//
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        //
        if UserDefaults.standard.string(forKey: "presentationStyle") == "detailed" {
            performSegue(withIdentifier: "warmupSessionSegue1", sender: nil)
        } else {
            performSegue(withIdentifier: "warmupSessionSegue2", sender: nil)
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
        if (segue.identifier == "warmupSessionSegue1") {
            //
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.viewControllers.first as! SessionScreen
            
            // Ensure array in ascending order
            warmupSelectedArray.sort()
            // Compress Arrays
            warmupSelectedArray.sort()
            for i in warmupSelectedArray {
                //
                warmupArray.append(warmupMovementsDictionary[i]!)
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
            destinationVC.sessionArray = warmupArray
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = 0
        //
        } else if (segue.identifier == "warmupSessionSegue2") {
            //
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.viewControllers.first as! SessionScreenOverview
            
            // Ensure array in ascending order
            warmupSelectedArray.sort()
            // Compress Arrays
            for i in warmupSelectedArray {
                //
                warmupArray.append(warmupMovementsDictionary[i]!)
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
            destinationVC.sessionArray = warmupArray
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = 0
            //
            let pickerIndex = pickerView.selectedRow(inComponent: 0)
            if pickerIndex < pickerViewArray.count {
                destinationVC.sessionTitle = pickerViewArray[pickerIndex]
            } else if pickerIndex > pickerViewArray.count {
                let pickerArray = UserDefaults.standard.object(forKey: warmupPresetTexts[warmupType]) as! [String]
                destinationVC.sessionTitle = pickerArray[pickerIndex - (pickerViewArray.count + 1)]
            }
        }
    }
    
    
//
// Walkthrough ----------------------------------------------------------------------------------------------------------
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
        
        
        
        
        switch viewNumber {
        case 0:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight, width: self.view.frame.size.width, height: pickerView.frame.size.height))
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
            
            
            label.text = NSLocalizedString("choiceScreen21", comment: "")
            walkthroughView.addSubview(label)
            
            
            nextButton.isEnabled = false
            let delayInSeconds2 = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds2) {
                self.pickerView.selectRow(self.pickerViewArray.count, inComponent: 0, animated: true)
                self.nextButton.isEnabled = true
            }
            //
            // Picker View
            let delayInSeconds = 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.pickerView.selectRow(self.pickerViewArray.count, inComponent: 0, animated: true)
                self.nextButton.isEnabled = true
            }
            
            
            
            
            
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            
            
        //
        case 1:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + pickerView.frame.size.height, width: self.view.frame.size.width, height: tableView.frame.size.height))
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
            
            label.center = pickerView.center
            label.center.y = (UIApplication.shared.statusBarFrame.height/2) + pickerView.frame.size.height
            label.text = NSLocalizedString("choiceScreen22", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
        //
        case 2:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y:   UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + pickerView.frame.size.height + 24.5, width: 72 + 5, height: 72))
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
            
            label.center = pickerView.center
            label.center.y = (UIApplication.shared.statusBarFrame.height/2) + pickerView.frame.size.height
            label.text = NSLocalizedString("choiceScreen23", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
  
        //
        case 3:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: self.view.frame.size.width - 98, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + pickerView.frame.size.height, width: 98, height: 49))
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
             label.text = NSLocalizedString("choiceScreen24", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
        //
        case 4:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + pickerView.frame.size.height + tableView.frame.size.height, width: self.view.frame.size.height, height: 49))
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
            
            
            label.text = NSLocalizedString("choiceScreen25", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            // Picker
            self.pickerView.selectRow(0, inComponent: 0, animated: true)

            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        case 5:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width * 0.917, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
            
            
            label.text = NSLocalizedString("choiceScreen26", comment: "")
            walkthroughView.addSubview(label)
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
        //
        default: break
        }
    }
    

    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    
    
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
    }
    
//
}
