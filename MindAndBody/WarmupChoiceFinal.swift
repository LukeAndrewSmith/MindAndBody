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
    
//
// Arrays ------------------------------------------------------------------------------------------------------------------------------
//
    
    // Changeable Arrays to be used
    //
    // Movements Array
    var warmupMovementsArray: [[String]] = [[]]
    var warmupArray: [String] = []
    
    // Selected Array
    var warmupSelectedArray: [[Int]] = [[]]
    
    // Picker View Array
    var pickerViewArray: [String] = []
    
    // TableView Section Array
    var tableViewSectionArray: [String] = []
    
    // Presets
    var presetsArrays: [[[Int]]] = [[[]]]
    
    // Custom Presets
        // Empty Array
        var emptyArray: [[Int]] = [[]]
    
    // Screen Arrays
    // Sets Array
    var setsArrayF: [[Int]] = [[]]
    var setsArray: [Int] = []
    
    // Reps Array
    var repsArrayF: [[String]] = [[]]
    var repsArray: [String] = []
    
    // Demonstration Array
    var demonstrationArrayF: [[UIImage]] = [[]]
    var demonstrationArray: [UIImage] = []
    
    // Target Area Array
    var targetAreaArrayF: [[UIImage]] = [[]]
    var targetAreaArray: [UIImage] = []
    
    // Explanation Array
    var explanationArrayF: [[String]] = [[]]
    var explanationArray: [String] = []
    
    // Static Arrays
    // Initial Custom Preset Texts
    var presetTexts: [String] = ["", "", ""]
    
    // Navigation Titles
    let navigationTitles: [String] =
        ["fullBody",
         "upperBody",
         "lowerBody",
         "cardio"]
    
    // Custom Preset Keys
    // Preset Number
    let warmupPresetNumbers: [String] =
        ["warmupFullPresetNumber",
        "warmupUpperPresetNumber",
        "warmupLowerPresetNumber",
        "warmupCardioPresetNumber"]
    // Preset Array
    let warmupPresets: [String] =
        ["warmupFullPresets",
         "warmupUpperPresets",
        "warmupLowerPresets",
        "warmupCardioPresets"]
    // Preset Text
    let warmupPresetTexts: [String] =
        ["warmupFullPresetTexts",
         "warmupUpperPresetTexts",
         "warmupLowerPresetTexts",
         "warmupCardioPresetTexts"]
    
    
//
// Warmup Type Arrays --------------------------------------------------------------------------------------------------------------
//
//
// Full ----------------------------------------------------------------------------------------------------------------------------
//
    
    // Warmup Full Movements Array
    var warmupFullArray: [[String]] =
        [
            // Mandatory
            ["5minCardioL",
             "5minCardioI"],
            // Joint Rotations
            ["wrist",
             "elbow",
             "shoulder",
             "neckR",
             "waist",
             "hip",
             "knees",
             "ankles"],
            // Foam/Ball Roll
            ["backf",
             "thoracicSpine",
             "lat",
             "pecDelt",
             "rearDelt",
             "quadf",
             "adductorf",
             "hamstringf",
             "glutef",
             "calvef"],
            // Lower Back
            ["sideLegDrop",
             "sideLegKick",
             "scorpionKick",
             "sideBend",
             "catCow"],
            // Shoulder
            ["wallSlides",
             "superManShoulder",
             "scapula",
             "shoulderRotation"],
            // Band/Bar/Machine Assisted
            ["facePull",
             "externalRotation",
             "internalRotation",
             "shoulderDislocation",
             "rearDeltFly",
             "latPullover"],
            // General Mobility
            ["rollBack",
             "hipCircles",
             "mountainClimber",
             "groinStretch",
             "gluteBridge",
             "threadTheNeedle",
             "butterflyPose",
             "cossakSquat",
             "hipHinges",
             "sideLegSwings",
             "frontLegSwings",
             "jumpSquat",
             "lunge"],
            // Accessory
            ["latStretch",
             "calveStretch",
             "pushUp",
             "pullUp"]
        ]
    
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
    
    // Custom Preset Full
    let emptyArrayFull: [[Int]] =
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // Shoulder
                    [0, 0, 0, 0],
                    // Band/Bar/Machine Assisted
                    [0, 0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0, 0, 0]
                ]
            //
    var warmupFullPresets: [[[Int]]] =
            [
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // Shoulder
                    [0, 0, 0, 0],
                    // Band/Bar/Machine Assisted
                    [0, 0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0, 0, 0]
                ],
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // Shoulder
                    [0, 0, 0, 0],
                    // Band/Bar/Machine Assisted
                    [0, 0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0, 0, 0]
                ],
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // Shoulder
                    [0, 0, 0, 0],
                    // Band/Bar/Machine Assisted
                    [0, 0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0, 0, 0]
                ]
            ]
    
    // Screen Arrays
    //
    var setsArrayFull: [[Int]] =
        [
            // Mandatory
            [1, 1],
            // Joint Rotations
            [1, 1, 1, 1, 1, 1, 1, 1],
            // Foam/Ball Roll
            [1, 3, 1, 1, 1, 1, 1, 1, 1, 1],
            // Lower Back
            [1, 1, 1, 1, 1],
            // Shoulder
            [2, 1, 1, 1],
            // Band/Bar/Machine Assisted
            [2, 1, 1, 1, 1, 1],
            // General Mobility
            [1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 2, 2],
            // Accessory
            [1, 1, 1, 1]
        ]
    
    // Reps Array
    var repsArrayFull: [[String]] =
        [
            // Mandatory
            ["5min",
             "5min"],
            // Joint Rotations
            ["10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s"],
            // Foam/Ball Roll
            ["2-7 reps",
             "5-10 reps",
             "2-7 reps",
             "15-30s",
             "15-30s",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps"],
            // Lower Back
            ["5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "15-20 reps"],
            // Shoulder
            ["10-20 reps",
             "5-10 reps",
             "15 reps",
             "10 reps"],
            // Band/Bar/Machine Assisted
            ["10-15 reps",
             "5-15 reps",
             "5-10 reps",
             "5-10 reps",
             "10-15 reps",
             "10-20 reps"],
            // General Mobility
            ["10-15 reps",
             "5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "10-15 reps",
             "15-30s",
             "15-30s",
             "5-10 reps",
             "10-20 reps",
             "10-20 reps",
             "10-20 reps",
             "5-15 reps",
             "10-15 reps"],
            // Accessory
            ["15-30s",
             "15-30s",
             NSLocalizedString("asNecessary", comment: ""),
             NSLocalizedString("asNecessary", comment: "")]
    ]
    
    // Demonstration Array
    var demonstrationArrayFull: [[UIImage]] = [[]]
    
    // Target Area Array
    var targetAreaArrayFull: [[UIImage]] =
        [
            // Mandatory
            [#imageLiteral(resourceName: "Heart"),
             #imageLiteral(resourceName: "Heart")],
            // Joint Rotations
            [#imageLiteral(resourceName: "Wrist Joint"),
             #imageLiteral(resourceName: "Elbow Joint"),
             #imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Neck Joint"),
             #imageLiteral(resourceName: "Waist Joint"),
             #imageLiteral(resourceName: "Hip Joint"),
             #imageLiteral(resourceName: "Knee Joint"),
             #imageLiteral(resourceName: "Ankle Joint")],
            // Foam/Ball Roll
            [#imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Lat and Delt"),
             #imageLiteral(resourceName: "Pec and Front Delt"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Quad"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Glute"),
             #imageLiteral(resourceName: "Calf")],
            // Lower Back
            [#imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Spine")],
            // Shoulder
            [#imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Back and Shoulder"),
             #imageLiteral(resourceName: "Serratus"),
             #imageLiteral(resourceName: "Shoulder")],
            // Band/Bar/Machine Assisted
            [#imageLiteral(resourceName: "Upper Back and Shoulder"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Back")],
            // General Mobility
            [#imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Hip Area"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Piriformis"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Hamstring and Glute"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat")],
            // Accessory
            [#imageLiteral(resourceName: "Lat"),
             #imageLiteral(resourceName: "Calf"),
             #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
             #imageLiteral(resourceName: "Back and Bicep")]
    ]
    
    // Explanation Array
    var explanationArrayFull: [[String]] =
        [
            // Mandatory
            ["5minCardioLE",
             "5minCardioIE"],
            // Joint Rotations
            ["wristE",
             "elbowE",
             "shoulderE",
             "neckE",
             "waistE",
             "hipE",
             "kneesE",
             "anklesE"],
            // Foam/Ball Roll
            ["backfE",
             "thoracicSpineE",
             "latE",
             "pecDeltE",
             "rearDeltE",
             "quadfE",
             "adductorfE",
             "hamstringfE",
             "glutefE",
             "calvefE"],
            // Back
            ["sideLegDropE",
             "sideLegKickE",
             "scorpionKickE",
             "sideBendE",
             "catCowE"],
            // Shoulder
            ["wallSlidesE",
             "superManShoulderE",
             "scapulaE",
             "shoulderRotationE"],
            // Band/Bar/Machine Assisted
            ["facePullE",
             "externalRotationE",
             "internalRotationE",
             "shoulderDislocationE",
             "rearDeltFlyE",
             "latPulloverE"],
            // General Mobility
            ["rollBackE",
             "hipCirclesE",
             "mountainClimberE",
             "groinStretchE",
             "gluteBridgeE",
             "threadTheNeedleE",
             "butterflyPoseE",
             "cossakSquatE",
             "hipHingesE",
             "sideLegSwingsE",
             "frontLegSwingsE",
             "jumpSquatE",
             "lungeE"],
            // Accessory
            ["latStretchE",
             "calveStretchE",
             "pushUpE",
             "pullUpE"]
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
    var presetsArraysFull: [[[Int]]] =
        [
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // Shoulder
                [0, 0, 0, 0],
                // Band/Bar/Machine Assisted
                [0, 0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0, 0]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // Shoulder
                [0, 0, 0, 0],
                // Band/Bar/Machine Assisted
                [0, 0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0, 0]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // Shoulder
                [0, 0, 0, 0],
                // Band/Bar/Machine Assisted
                [0, 0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0, 0]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // Shoulder
                [0, 0, 0, 0],
                // Band/Bar/Machine Assisted
                [0, 0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0, 0]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // Shoulder
                [0, 0, 0, 0],
                // Band/Bar/Machine Assisted
                [0, 0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0, 0]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // Shoulder
                [0, 0, 0, 0],
                // Band/Bar/Machine Assisted
                [0, 0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0, 0]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // Shoulder
                [0, 0, 0, 0],
                // Band/Bar/Machine Assisted
                [0, 0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0, 0]
            ]
    ]

    
//
// Upper ----------------------------------------------------------------------------------------------------------------------------
//
    // Warmup Upper Array
    var warmupUpperArray: [[String]] =
        [
            // Mandatory
            ["5minCardioL",
             "5minCardioI"],
            // Joint Rotations
            ["wrist",
             "elbow",
             "shoulderR",
             "neckR",
             "waist",
             "hip",
             "knees",
             "ankles"],
            // Foam/Ball Roll
            ["backf",
             "thoracicSpine",
             "lat",
             "pecDelt",
             "rearDelt"],
            // Lower Back
            ["sideLegDrop",
             "sideLegKick",
             "scorpionKick",
             "sideBend",
             "catCow"],
            // Shoulder
            ["wallSlides",
             "superManShoulder",
             "scapula",
             "shoulderRotation"],
            // Band/Bar/Machine Assisted
            ["facePull",
             "externalRotation",
             "internalRotation",
             "shoulderDislocation",
             "rearDeltFly",
             "latPullover"],
            // Accessory
            ["latStretch",
             "pushUp",
             "pullUp"]
        ]
    
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
    
    // Custom Presets Upper
    let emptyArrayUpper: [[Int]] =
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // Shoulders
                    [0, 0, 0, 0],
                    // Band Assisted
                    [0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0, 0]
                ]
            //
    var warmupUpperPresets: [[[Int]]] =
            [
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // Shoulders
                    [0, 0, 0, 0],
                    // Band Assisted
                    [0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0, 0]
                ],
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // Shoulders
                    [0, 0, 0, 0],
                    // Band Assisted
                    [0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0, 0]
                ],
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // Shoulders
                    [0, 0, 0, 0],
                    // Band Assisted
                    [0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0, 0]
                ]
            ]
    
    // Screen Arrays
    var setsArrayUpper: [[Int]] =
        [
            // Mandatory
            [1, 1],
            // Joint Rotations
            [1, 1, 1, 1, 1, 1, 1, 1],
            // Foam/Ball Roll
            [1, 3, 1, 1, 1],
            // Lower Back
            [1, 1, 1, 1, 1],
            // Shoulder
            [2, 1, 1, 1],
            // Band/Bar/Machine Assisted
            [2, 1, 1, 1, 1, 1],
            // Accessory
            [1, 1, 1]
        ]
    
    // Reps Array
    var repsArrayUpper: [[String]] =
        [
            // Mandatory
            ["5min",
             "5min"],
            // Joint Rotations
            ["10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s"],
            // Foam/Ball Roll
            ["2-7 reps",
             "5-10 reps",
             "2-7 reps",
             "15-30s",
             "15-30s"],
            // Lower Back
            ["5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "15-20 reps"],
            // Shoulder
            ["10-20 reps",
             "5-10 reps",
             "15 reps",
             "10 reps"],
            // Band/Bar/Machine Assisted
            ["10-15 reps",
             "5-15 reps",
             "5-10 reps",
             "5-10 reps",
             "10-15 reps",
             "10-20 reps",],
            // Accessory
            ["15-30s",
             NSLocalizedString("asNecessary", comment: ""),
             NSLocalizedString("asNecessary", comment: "")
            ]
        ]
    
    // Demonstration Array
    var demonstrationArrayUpper: [[UIImage]] = [[]]
    
    // Target Area Array
    var targetAreaArrayUpper: [[UIImage]] =
        [
            // Mandatory
            [#imageLiteral(resourceName: "Heart"),
             #imageLiteral(resourceName: "Heart")],
            // Joint Rotations
            [#imageLiteral(resourceName: "Wrist Joint"),
             #imageLiteral(resourceName: "Elbow Joint"),
             #imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Neck Joint"),
             #imageLiteral(resourceName: "Waist Joint"),
             #imageLiteral(resourceName: "Hip Joint"),
             #imageLiteral(resourceName: "Knee Joint"),
             #imageLiteral(resourceName: "Ankle Joint")],
            // Foam/Ball Roll
            [#imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Lat and Delt"),
             #imageLiteral(resourceName: "Pec and Front Delt"),
             #imageLiteral(resourceName: "Rear Delt")],
            // Lower Back
            [#imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Spine")],
            // Shoulder
            [#imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Back and Shoulder"),
             #imageLiteral(resourceName: "Serratus"),
             #imageLiteral(resourceName: "Shoulder")],
            // Band/Bar/Machine Assisted
            [#imageLiteral(resourceName: "Upper Back and Shoulder"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Back")],
            // Accessory
            [#imageLiteral(resourceName: "Lat"),
             #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
             #imageLiteral(resourceName: "Back and Bicep")]
        ]
    
    // Explanation Array
    var explanationArrayUpper: [[String]] =
        [
            // Mandatory
            ["5minCardioLE",
             "5minCardioIE"],
            // Joint Rotations
            ["wristE",
             "elbowE",
             "shoulderE",
             "neckE",
             "waistE",
             "hipE",
             "kneesE",
             "anklesE"],
            // Foam/Ball Roll
            ["backfE",
             "thoracicSpineE",
             "latE",
             "pecDeltE",
             "rearDeltE"],
            // Lower Back
            ["sideLegDropE",
             "sideLegKickE",
             "scorpionKickE",
             "sideBendE",
             "catCowE"],
            // Shoulder
            ["wallSlidesE",
             "superManShoulderE",
             "scapulaE",
             "shoulderRotationE"],
            // Band/Bar/Machine Assisted
            ["facePullE",
             "externalRotationE",
             "internalRotationE",
             "shoulderDislocationE",
             "rearDeltFlyE",
             "latPulloverE"],
            // Accessory
            ["latStretchE",
             "pushUpE",
             "pullUpE"]
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
    var presetsArraysUpper: [[[Int]]] =
    [
        [
            // Mandatory
            [1, 0],
            // Joint Rotations
            [0, 0, 0, 0, 0, 0, 0, 0],
            // Foam/Ball Roll
            [1, 0, 0, 0, 0],
            // Lower Back
            [1, 0, 0, 0, 1],
            // Shoulders
            [1, 0, 0, 1],
            // Band Assisted
            [1, 1, 0, 1, 0, 0],
            // Accessory
            [1, 1, 1]
        ],
        [
            // Mandatory
            [1,
             0],
            // Joint Rotations
            [0, 0, 0, 0, 0, 0, 0, 0],
            // Foam/Ball Roll
            [0, 0, 0, 0, 0],
            // Lower Back
            [1, 0, 0, 1, 0],
            // Shoulders
            [1, 0, 0, 1],
            // Band Assisted
            [0, 0, 0, 1, 0, 0],
            // Accessory
            [1, 1, 0]
        ],
        [
            // Mandatory
            [1, 0],
            // Joint Rotations
            [0, 0, 0, 0, 0, 0, 0, 0],
            // Foam/Ball Roll
            [0, 0, 0, 0, 0],
            // Lower Back
            [1, 1, 1, 0, 1],
            // Shoulders
            [1, 0, 1, 1],
            // Band Assisted
            [0, 0, 0, 0, 0, 0],
            // Accessory
            [1, 1, 1]
        ],
        [
            // Mandatory
            [1, 0],
            // Joint Rotations
            [0, 0, 0, 0, 0, 0, 0, 0],
            // Foam/Ball Roll
            [1, 0, 1, 0, 1],
            // Lower Back
            [1, 1, 1, 0, 0],
            // Shoulders
            [1, 0, 0, 1],
            // Band Assisted
            [1, 1, 0, 0, 0, 1],
            // Accessory
            [1, 1, 1]
        ],
        [
            // Mandatory
            [1, 0],
            // Joint Rotations
            [0, 0, 0, 0, 0, 0, 0, 0],
            // Foam/Ball Roll
            [0, 1, 1, 0, 1],
            // Lower Back
            [1, 0, 1, 0, 1],
            // Shoulders
            [1, 0, 1, 1],
            // Band Assisted
            [1, 1, 0, 1, 0, 1],
            // Accessory
            [1, 1, 1]
        ],
        [
            // Mandatory
            [0, 1],
            // Joint Rotations
            [0, 0, 0, 0, 0, 0, 0, 0],
            // Foam/Ball Roll
            [1, 0, 1, 0, 0],
            // Lower Back
            [1, 1, 1, 0, 1],
            // Shoulders
            [1, 0, 0, 1],
            // Band Assisted
            [1, 1, 0, 0, 1, 1],
            // Accessory
            [1, 1, 1]
        ],
        [
            // Mandatory
            [1, 0],
            // Joint Rotations
            [0, 0, 0, 0, 0, 0, 0, 0],
            // Foam/Ball Roll
            [1, 0, 0, 0, 0],
            // Lower Back
            [1, 0, 0, 0, 1],
            // Shoulders
            [1, 0, 0, 1],
            // Band Assisted
            [1, 0, 0, 1, 0, 0],
            // Accessory
            [1, 0, 0]
        ]
    ]
    
    
//
// Lower --------------------------------------------------------------------------------------------------------------------------
//
    // Warmup Lower Array
    var warmupLowerArray: [[String]] =
        [
            // Mandatory
            ["5minCardioL",
             "5minCardioI"],
            // Joint Rotations
            ["wrist",
             "elbow",
             "shoulderR",
             "neckR",
             "waist",
             "hip",
             "knees",
             "ankles"],
            // Foam/Ball Roll
            ["backf",
             "thoracicSpine",
             "quadf",
             "adductorf",
             "hamstringf",
             "glutef",
             "calvef"],
            // Lower Back
            ["sideLegDrop",
             "sideLegKick",
             "scorpionKick",
             "sideBend",
             "catCow"],
            // General Mobility
            ["rollBack",
             "hipCircles",
             "mountainClimber",
             "groinStretch",
             "gluteBridge",
             "threadTheNeedle",
             "butterflyPose",
             "cossakSquat",
             "hipHinges",
             "sideLegSwings",
             "frontLegSwings",
             "jumpSquat",
             "lunge"],
            // Accessory
            ["wallSlides",
             "calveStretch"]
        ]
    
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
    
    // Custom Presets Lower
    let emptyArrayLower: [[Int]] =
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0]
                ]
            //
    var warmupLowerPresets: [[[Int]]] =
            [
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0]
                ],
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0],
                ],
                [
                    // Mandatory
                    [0, 0],
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0]
                ]
            ]
    
    // Screen Arrays
    var setsArrayLower: [[Int]] =
        [
            // Mandatory
            [1, 1],
            // Joint Rotations
            [1, 1, 1, 1, 1, 1, 1, 1],
            // Foam/Ball Roll
            [1, 3, 1, 1, 1, 1, 1],
            // Lower Back
            [1, 1, 1, 1, 1],
            // General Mobility
            [1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 2, 2],
            // Accessory
            [2, 1]
        ]

    // Reps Array
    var repsArrayLower: [[String]] =
        [
            // Mandatory
            ["5min",
             "5min"],
            // Joint Rotations
            ["10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s"],
            // Foam/Ball Roll
            ["2-7 reps",
             "5-10 reps",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps"],
            // Lower Back
            ["5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "15-20 reps"],
            // General Mobility
            ["10-15 reps",
             "5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "10-15 reps",
             "15-30s",
             "15-30s",
             "5-10 reps",
             "10-20 reps",
             "10-20 reps",
             "10-20 reps",
             "5-15 reps",
             "10-15 reps"],
            // Accessory
            ["10-20 reps",
             "15-30s"]
        ]

    // Demonstration Array
    var demonstrationArrayLower: [[UIImage]] = [[]]

    // Target Area Array
    var targetAreaArrayLower: [[UIImage]] =
        [
            // Mandatory
            [#imageLiteral(resourceName: "Heart"),
             #imageLiteral(resourceName: "Heart")],
            // Joint Rotations
            [#imageLiteral(resourceName: "Wrist Joint"),
             #imageLiteral(resourceName: "Elbow Joint"),
             #imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Neck Joint"),
             #imageLiteral(resourceName: "Waist Joint"),
             #imageLiteral(resourceName: "Hip Joint"),
             #imageLiteral(resourceName: "Knee Joint"),
             #imageLiteral(resourceName: "Ankle Joint")],
            // Foam/Ball Roll
            [#imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Quad"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Glute"),
             #imageLiteral(resourceName: "Calf")],
            // Lower Back
            [#imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Spine")],
            // General Mobility
            [#imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Hip Area"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Piriformis"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Hamstring and Glute"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat")],
            // Accessory
            [#imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Calf")]
        ]
    
    // Explanation Array
    var explanationArrayLower: [[String]] =
        [
            // Mandatory
            ["5minCardioLE",
             "5minCardioIE"],
            // Joint Rotations
            ["wristE",
             "elbowE",
             "shoulderE",
             "neckE",
             "waistE",
             "hipE",
             "kneesE",
             "anklesE"],
            // Foam/Ball Roll
            ["backfE",
             "thoracicSpineE",
             "quadfE",
             "adductorfE",
             "hamstringfE",
             "glutefE",
             "calvefE"],
            // Lower Back
            ["sideLegDropE",
             "sideLegKickE",
             "scorpionKickE",
             "sideBendE",
             "catCowE"],
            // General Mobility
            ["rollBackE",
             "hipCirclesE",
             "mountainClimberE",
             "groinStretchE",
             "gluteBridgeE",
             "threadTheNeedleE",
             "butterflyPoseE",
             "cossakSquatE",
             "hipHingesE",
             "sideLegSwingsE",
             "frontLegSwingsE",
             "jumpSquatE",
             "lungeE",],
            // Accessory
            ["wallSlidesE",
             "calveStretchE"]
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
    var presetsArraysLower: [[[Int]]] =
        [
            [
                // Mandatory
                [1, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 1, 1, 0, 1, 0, 0],
                // Lower Back
                [1, 0, 1, 0, 1],
                // General Mobility
                [0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0],
                // Accessory
                [1, 1]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0]
            ],
            [
                // Mandatory
                [0, 0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0]
            ]
        ]
    
    
//
// Cardio ----------------------------------------------------------------------------------------------------------------------------
//
    // Warmup Cardio Array
    var warmupCardioArray: [[String]] =
        [
            // Joint Rotations
            ["wrist",
             "elbow",
             "shoulderR",
             "neckR",
             "waist",
             "hip",
             "knees",
             "ankles"],
            // Foam/Ball Roll
            ["thoracicSpine",
             "lat",
             "quadf",
             "adductorf",
             "hamstringf",
             "glutef",
             "calvef"],
            // Lower Back
            ["sideLegDrop",
             "sideLegKick",
             "scorpionKick",
             "sideBend",
             "catCow"],
            // General Mobility
            ["hipCircles",
             "mountainClimber",
             "groinStretch",
             "gluteBridge",
             "threadTheNeedle",
             "butterflyPose",
             "cossakSquat",
             "hipHinges",
             "sideLegSwings",
             "frontLegSwings"],
            // Dynamic Warm Up Drills
            ["jumpSquat",
             "lunge",
             "gluteKicks",
             "aSkips",
             "bSkips",
             "grapeVines",
             "lateralBound",
             "straightLegBound",
             "sprints"],
            // Accessory
            ["wallSlides",
             "latStretch",
             "calveStretch"]
        ]
    
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
    
    // Warmup Presets Cardio
    let emptyArrayCardio: [[Int]] =
                [
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Dynamic Warm Up Drills
                    [0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0, 0]
                ]
            //
    var warmupCardioPresets: [[[Int]]] =
            [
                [
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Dynamic Warm Up Drills
                    [0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0, 0]
                ],
                [
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,],
                    // Dynamic Warm Up Drills
                    [0, 0, 0, 0, 0, 0, 0, 0, 0,],
                    // Accessory
                    [0, 0, 0]
                ],
                [
                    // Joint Rotations
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    // Foam/Ball Roll
                    [0, 0, 0, 0, 0, 0, 0],
                    // Lower Back
                    [0, 0, 0, 0, 0],
                    // General Mobility
                    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Dynamic Warm Up Drills
                    [0, 0, 0, 0, 0, 0, 0, 0, 0],
                    // Accessory
                    [0, 0, 0]
                ]
            ]
    
    // Screen Arrays
    var setsArrayCardio: [[Int]] =
        [
            // Joint Rotations
            [1, 1, 1, 1, 1, 1, 1, 1],
            // Foam/Ball Roll
            [3, 1, 1, 1, 1, 1, 1],
            // Lower Back
            [1, 1, 1, 1, 1],
            // General Mobility
            [1, 1, 1, 1, 2, 1, 1, 2, 1, 1,],
            // Dynamic Warm Up Drills
            [2, 2, 3, 3, 3, 2, 2, 2, 4],
            // Accessory
            [2, 1, 1]
        ]
    
    // Reps Array
    var repsArrayCardio: [[String]] =
        [
            // Joint Rotations
            ["10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s"],
            // Foam/Ball Roll
            ["2-7 reps",
             "5-10 reps",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps"],
            // Lower Back
            ["5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "15-20 reps"],
            // General Mobility
            ["5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "10-15 reps",
             "15-30s",
             "15-30s",
             "5-10 reps",
             "15-30s",
             "10-20 reps",
             "10-20 reps"],
            // Dynamic Warm Up Drills
            ["5-15 reps",
             "10-15 reps",
             "15-30s",
             "15-30s",
             "15-30s",
             "50m",
             "50m",
             "50m",
             "5-20 reps"],
            // Accessory
            ["10-15 reps",
             "15-30s",
             "15-30s",
             "15-30s"]
        ]
    
    // Demonstration Array
    var demonstrationArrayCardio: [[UIImage]] = [[]]

    // Target Area Array
    var targetAreaArrayCardio: [[UIImage]] =
        [
            // Joint Rotations
            [#imageLiteral(resourceName: "Wrist Joint"),
             #imageLiteral(resourceName: "Elbow Joint"),
             #imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Neck Joint"),
             #imageLiteral(resourceName: "Waist Joint"),
             #imageLiteral(resourceName: "Hip Joint"),
             #imageLiteral(resourceName: "Knee Joint"),
             #imageLiteral(resourceName: "Ankle Joint")],
            // Foam/Ball Roll
            [#imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Lat and Delt"),
             #imageLiteral(resourceName: "Quad"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Glute"),
             #imageLiteral(resourceName: "Calf")],
            // Lower Back
            [#imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Spine")],
            // General Mobility
            [#imageLiteral(resourceName: "Hip Area"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Piriformis"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Hamstring and Glute"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch")],
            // Dynamic Warm Up Drills
            [#imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat")],
            // Accessory
            [#imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Lat"),
             #imageLiteral(resourceName: "Calf")]
    ]
    
    // Explanation Array
    var explanationArrayCardio: [[String]] =
        [
            // Joint Rotations
            ["wristE",
             "elbowE",
             "shoulderE",
             "neckE",
             "waistE",
             "hipE",
             "kneesE",
             "anklesE"],
            // Foam/Ball Roll
            ["thoracicSpineE",
             "latE",
             "quadfE",
             "adductorfE",
             "hamstringfE",
             "glutefE",
             "calvefE"],
            // Lower Back
            ["sideLegDropE",
             "sideLegKickE",
             "scorpionKickE",
             "sideBendE",
             "catCowE"],
            // General Mobility
            ["hipCirclesE",
             "mountainClimberE",
             "groinStretchE",
             "gluteBridgeE",
             "threadTheNeedleE",
             "butterflyPoseE",
             "cossakSquatE",
             "hipHingesE",
             "sideLegSwingsE",
             "frontLegSwingsE"],
            // Dynamic Warm Up Drills
            ["jumpSquatE",
             "lungeE",
             "gluteKicksE",
             "aSkipsE",
             "bSkipsE",
             "grapeVinesE",
             "lateralBoundE",
             "straightLegBoundE",
             "sprintsE"],
            // Accessory
            ["wallSlidesE",
             "latStretchE",
             "calveStretchE"]
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
    var presetsArraysCardio: [[[Int]]] =
        [
            [
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Dynamic Warm Up Drills
                [0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0]
            ],
            [
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 1, 1, 1, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Dynamic Warm Up Drills
                [0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0]
            ],
            [
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Dynamic Warm Up Drills
                [0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0]
            ],
            [
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Dynamic Warm Up Drills
                [0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0]
            ],
            [
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Dynamic Warm Up Drills
                [0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0]
            ],
            [
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Dynamic Warm Up Drills
                [0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0]
            ],
            [
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0],
                // Lower Back
                [0, 0, 0, 0, 0],
                // General Mobility
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Dynamic Warm Up Drills
                [0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Accessory
                [0, 0, 0]
            ]
        ]
    
    
    // Set Arrays Function
    func setArrays() {
        //
        switch warmupType {
        //
        case 0:
            // Choice Screen Arrays
                warmupMovementsArray = warmupFullArray
                warmupSelectedArray = presetsArraysFull[0]
                pickerViewArray = pickerViewArrayFull
                tableViewSectionArray = tableViewSectionArrayFull
                presetsArrays = presetsArraysFull
                emptyArray = emptyArrayFull
            // Screen Arrays
                setsArrayF = setsArrayFull
                repsArrayF = repsArrayFull
                demonstrationArrayF = demonstrationArrayFull
                targetAreaArrayF = targetAreaArrayFull
                explanationArrayF = explanationArrayFull
        //
        case 1:
            // Choice Screen Arrays
                warmupMovementsArray = warmupUpperArray
                warmupSelectedArray = presetsArraysUpper[0]
                pickerViewArray = pickerViewArrayUpper
                tableViewSectionArray = tableViewSectionArrayUpper
                presetsArrays = presetsArraysUpper
                emptyArray = emptyArrayUpper
            // Screen Arrays
                setsArrayF = setsArrayUpper
                repsArrayF = repsArrayUpper
                demonstrationArrayF = demonstrationArrayUpper
                targetAreaArrayF = targetAreaArrayUpper
                explanationArrayF = explanationArrayUpper
        //
        case 2:
            // Choice Screen Arrays
                warmupMovementsArray = warmupLowerArray
                warmupSelectedArray = presetsArraysLower[0]
                pickerViewArray = pickerViewArrayLower
                tableViewSectionArray = tableViewSectionArrayLower
                presetsArrays = presetsArraysLower
                emptyArray = emptyArrayLower
            // Screen Arrays
                setsArrayF = setsArrayLower
                repsArrayF = repsArrayLower
                demonstrationArrayF = demonstrationArrayLower
                targetAreaArrayF = targetAreaArrayLower
                explanationArrayF = explanationArrayLower
        //
        case 3:
            // Choice Screen Arrays
                warmupMovementsArray = warmupCardioArray
                warmupSelectedArray = presetsArraysCardio[0]
                pickerViewArray = pickerViewArrayCardio
                tableViewSectionArray = tableViewSectionArrayCardio
                presetsArrays = presetsArraysCardio
                emptyArray = emptyArrayCardio
            // Screen Arrays
                setsArrayF = setsArrayCardio
                repsArrayF = repsArrayCardio
                demonstrationArrayF = demonstrationArrayCardio
                targetAreaArrayF = targetAreaArrayCardio
                explanationArrayF = explanationArrayCardio
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
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
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
        lineSpacing.hyphenationFactor = 1
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-thin", size: 21)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 21)!, range: titleRange1)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        // Final Text Editing
        informationText.attributedText = informationLabelText
        informationText.textAlignment = .justified
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
        defaults.register(defaults: ["warmupFullPresets" : warmupFullPresets])
        defaults.register(defaults: ["warmupFullPresetTexts" : presetTexts])
        defaults.register(defaults: ["warmupFullPresetNumber" : 0])
        // Upper Body
        defaults.register(defaults: ["warmupUpperPresets" : warmupUpperPresets])
        defaults.register(defaults: ["warmupUpperPresetTexts" : presetTexts])
        defaults.register(defaults: ["warmupUpperPresetNumber" : 0])
        // Lower Body
        defaults.register(defaults: ["warmupLowerPresets" : warmupLowerPresets])
        defaults.register(defaults: ["warmupLowerPresetTexts" : presetTexts])
        defaults.register(defaults: ["warmupLowerPresetNumber" : 0])
        // Cardio
        defaults.register(defaults: ["warmupCardioPresets" : warmupCardioPresets])
        defaults.register(defaults: ["warmupCardioPresetTexts" : presetTexts])
        defaults.register(defaults: ["warmupCardioPresetNumber" : 0])
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
        for item in warmupSelectedArray {
            if item.contains(1) {
                beginButton.isEnabled = true
                break
            } else {
                beginButton.isEnabled = false
            }
        }
    }
    
    
//
// Custom Warmups --------------------------------------------------------------------------------------------------------------
//
    // Add
    @IBAction func addPreset(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        let number = defaults.integer(forKey: warmupPresetNumbers[warmupType])
        var warmupPreset = defaults.object(forKey: warmupPresets[warmupType]) as! [Array<Array<Int>>]
        var presetTextArray = defaults.object(forKey: warmupPresetTexts[warmupType]) as! [String]
        
        // Set Preset
        if number < 3 {
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
                presetTextArray[number] = (textField?.text)!
                defaults.set(presetTextArray, forKey: self.warmupPresetTexts[self.warmupType])
                defaults.synchronize()
                // Set new Preset Array
                //
                warmupPreset[number] = self.warmupSelectedArray
                defaults.set(warmupPreset, forKey: self.warmupPresets[self.warmupType])
                //
                defaults.synchronize()
                // Increase Preset Counter
                //
                let newNumber = number + 1
                //
                defaults.set(newNumber, forKey: self.warmupPresetNumbers[self.warmupType])
                defaults.synchronize()
                // Flash Screen
                self.flashScreen()
                self.pickerView.reloadAllComponents()
                self.tableView.reloadData()
                
            }))
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        } else {
        }
    }

    // Remove
    @IBAction func removePreset(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        let number = defaults.integer(forKey: warmupPresetNumbers[warmupType])
        var warmupPreset = defaults.object(forKey: warmupPresets[warmupType]) as! [Array<Array<Int>>]
        var presetTextArray = defaults.object(forKey: warmupPresetTexts[warmupType]) as! [String]
        //
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let index = (selectedRow) - (pickerViewArray.count + 1)
        //
        if index > -1 {
            //
            warmupPreset.remove(at: index)
            warmupPreset.append(emptyArray)
            defaults.set(warmupPreset, forKey: warmupPresets[warmupType])
            //
            presetTextArray.remove(at: index)
            presetTextArray.append(emptyString)
            defaults.set(presetTextArray, forKey: warmupPresetTexts[warmupType])
            //
            if number > 0 {
                let newNumber = number - 1
                defaults.set(newNumber, forKey: warmupPresetNumbers[warmupType])
            } else {
            }
            //
            defaults.synchronize()
            // Flash Screen
            self.flashScreen()
            self.pickerView.reloadAllComponents()
            self.tableView.reloadData()
        } else {
        }
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
        
        return pickerViewArray.count + 4
        
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
        } else if row == pickerViewArray.count + 1 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: warmupPresetTexts[warmupType]) as! [String]
            let titleData = titleDataArray[0]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
        //
        } else if row == pickerViewArray.count + 2 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: warmupPresetTexts[warmupType]) as! [String]
            let titleData = titleDataArray[1]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
        //
        } else if row == pickerViewArray.count + 3 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: warmupPresetTexts[warmupType]) as! [String]
            let titleData = titleDataArray[2]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
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
        case 0:
            warmupSelectedArray = presetsArrays[row]
            self.tableView.reloadData()
            flashScreen()
        //
        case 1:
            warmupSelectedArray = presetsArrays[row]
            self.tableView.reloadData()
            flashScreen()
        //
        case 2:
            warmupSelectedArray = presetsArrays[row]
            self.tableView.reloadData()
            flashScreen()
        //
        case 3:
            warmupSelectedArray = presetsArrays[row]
            self.tableView.reloadData()
            flashScreen()
        //
        case 4:
            warmupSelectedArray = presetsArrays[row]
            self.tableView.reloadData()
            flashScreen()
        //
        case 5:
            warmupSelectedArray = presetsArrays[row]
            self.tableView.reloadData()
            flashScreen()
        //
        case 6:
            warmupSelectedArray = presetsArrays[row]
            self.tableView.reloadData()
            flashScreen()
        //
        case 7:
            break
        //
        case 8:
            let fullArray = defaults.object(forKey: warmupPresets[warmupType]) as! [Array<Array<Int>>]
            let array = fullArray[0]
            warmupSelectedArray = array
            self.tableView.reloadData()
            flashScreen()
        //
        case 9:
            let fullArray = defaults.object(forKey: warmupPresets[warmupType]) as! [Array<Array<Int>>]
            let array = fullArray[1]
            warmupSelectedArray = array
            self.tableView.reloadData()
            flashScreen()
        //
        case 10:
            let fullArray = defaults.object(forKey: warmupPresets[warmupType]) as! [Array<Array<Int>>]
            let array = fullArray[2]
            warmupSelectedArray = array
            self.tableView.reloadData()
            flashScreen()
        //
        default:
            break
        }
    }
    
    
//
// TableView -----------------------------------------------------------------------------------------------------------------------
//
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return warmupMovementsArray.count
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
        return warmupMovementsArray[section].count
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        //
        cell.textLabel?.text = NSLocalizedString(warmupMovementsArray[indexPath.section][indexPath.row], comment: "")
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        cell.textLabel?.textColor = .black
        cell.tintColor = .black
        //
        if warmupSelectedArray[indexPath.section][indexPath.row] == 1 {
            cell.layer.borderColor = colour2.cgColor
            cell.layer.borderWidth = 2
            
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        // Cell Image
        cell.imageView?.image = #imageLiteral(resourceName: "Test")
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
            warmupSelectedArray[indexPath.section][indexPath.row] = 0
            tableView.reloadData()
        } else {
            cell?.accessoryType = .checkmark
            warmupSelectedArray[indexPath.section][indexPath.row] = 1
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
        
        //expandedImage.image = demonstrationArrayF[section][row]
        expandedImage.image = #imageLiteral(resourceName: "Test 2")
        
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
// Information Actions ---------------------------------------------------------------------------------------------------------------------------
//
    // Pass Array to next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "warmupSessionSegue1") {
            //
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.viewControllers.first as! SessionScreen
            
            // Compress Arrays
            warmupArray = zip(warmupMovementsArray.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            setsArray = zip(setsArrayF.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            repsArray = zip(repsArrayF.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            demonstrationArray = zip(demonstrationArrayF.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            targetAreaArray = zip(targetAreaArrayF.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            explanationArray = zip(explanationArrayF.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            destinationVC.sessionArray = warmupArray
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
        //
        } else if (segue.identifier == "warmupSessionSegue2") {
            //
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.viewControllers.first as! SessionScreenOverview
            
            // Compress Arrays
            warmupArray = zip(warmupMovementsArray.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            setsArray = zip(setsArrayF.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            repsArray = zip(repsArrayF.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            demonstrationArray = zip(demonstrationArrayF.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            targetAreaArray = zip(targetAreaArrayF.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            explanationArray = zip(explanationArrayF.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            destinationVC.sessionArray = warmupArray
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            let pickerIndex = pickerView.selectedRow(inComponent: 0)
            if pickerIndex < pickerViewArray.count - 1 {
                destinationVC.sessionTitle = pickerViewArray[pickerIndex]
            } else if pickerIndex > pickerViewArray.count - 1 {
                let pickerArray = UserDefaults.standard.object(forKey: warmupPresetTexts[warmupType]) as! [String]
                destinationVC.sessionTitle = pickerArray[pickerIndex - pickerViewArray.count]
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
