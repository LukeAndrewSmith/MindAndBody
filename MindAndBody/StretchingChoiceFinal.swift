//
//  StretchingChoiceFinal.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 28.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class StretchingChoiceFinal: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //
    // Stretching Type
    //
    
    // Selected Stretching Type
    //
    var stretchingType = Int()
    
    
    
    // Arrays -------------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // Changeable Arrays to be used
    //
    // Movements Array
    var stretchingMovementsArray: [[String]] = [[]]
    var stretchingArray: [String] = []

    
    // Selected Array
    var stretchingSelectedArray: [[Int]] = [[]]
    
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
        ["general",
         "postWorkout",
         "postCardio"]
    
    
    // Custom Preset Keys
    // Preset Number
    let stretchingPresetNumbers: [String] =
        ["stretchingPresetNumberGeneral",
         "stretchingPresetNumberWorkout",
         "stretchingPresetNumberCardio"]
    // Preset Array
    let stretchingPresets: [String] =
        ["stretchingPresetsGeneral",
         "stretchingPresetsWorkout",
         "stretchingPresetsCardio"]
    // Preset Text
    let stretchingPresetTexts: [String] =
        ["stretchingPresetTextsGeneral",
         "stretchingPresetTextsWorkout",
         "stretchingPresetTextsCardio"]
    
    
    //
    // Stretching Type Arrays -------------------------------------------------------------------------------------------------------------------------------------------------------
    //
    
    
    //
    // General -----------------------------------------------------------------------------------------------------------------------------------------------
    //
    
    // Stretching General Movements Array
    var stretchingGeneralArray: [[String]] =
        [
            // Recommended
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
             "rearDelt",
             "quadf",
             "adductorf",
             "hamstringf",
             "glutef",
             "calvef"],
            // Back
            ["catCow",
             "upwardsDog",
             "extendedPuppy",
             "childPose",
             "staffPose",
             "pelvicTilt",
             "kneeToChest",
             "legDrop",
             "seatedTwist",
             "legsWall"],
            // Obliques(Sides)
            ["sideLean",
             "extendedSideAngle",
             "seatedSide"],
            // Neck
            ["rearNeck",
             "rearNeckHand",
             "seatedLateral",
             "neckRotator",
             "scalene",
             "headRoll"],
            // Arms
            ["forearmStretch",
             "tricepStretch",
             "bicepStretch"],
            // Pecs
            ["pecStretch"],
            // Shoulders
            ["shoulderRoll",
             "behindBackTouch",
             "frontDelt",
             "lateralDelt",
             "rearDelt",
             "rotatorCuff"],
            // Hips and Glutes
            ["squatHold",
             "groinStretch",
             "butterflyPose",
             "lungeStretch",
             "threadTheNeedle",
             "pigeonPose",
             "seatedGlute"],
            // Calves
            ["calveStretch"],
            // Hamstrings
            ["standingHamstring",
             "standingOneLegHamstring",
             "singleLegStanding",
             "downWardsDog",
             "singleLegHamstring",
             "twoLegHamstring"],
            // Quads
            ["lungeStretchWall",
             "QuadStretch"]
    ]
    
    
    // Table View Section Title Array
    var tableViewSectionArrayGeneral: [String] =
        [
            "recommended",
            "jointRotation",
            "foamRoll",
            "backStretch",
            "sides",
            "neck",
            "arms",
            "pecs",
            "shoulders",
            "hipsaGlutes",
            "calves",
            "hamstrings",
            "quads"
    ]
    
    // Custom Preset General
    //
    let emptyArrayGeneral: [[Int]] =
        [
            // Recommended
            [0,0],
            // Joint Rotations
            [0, 0, 0, 0, 0, 0, 0, 0],
            // Foam/Ball Roll
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            // Back
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            // Obliques(Sides)
            [0, 0, 0],
            // Neck
            [0, 0, 0, 0, 0, 0],
            // Arms
            [0, 0, 0],
            // Pecs
            [0],
            // Shoulders
            [0, 0, 0, 0, 0, 0],
            // Hips and Glutes
            [0, 0, 0, 0, 0, 0, 0],
            // Calves
            [0],
            // Hamstrings
            [0, 0, 0, 0, 0, 0],
            // Quads
            [0, 0]
    ]
    //
    var stretchingGeneralPresets: [[[Int]]] =
        [
            [
                // Recommended
                [0,0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0,0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0,0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ]
    ]
    
    //
    // Stretching Screen Arrays
    //
    var setsArrayGeneral: [[Int]] =
        [
            // Recommended
            [1, 1],
            // Joint Rotations
            [1,
             1, 1, 1, 1, 1, 1, 1],
            // Foam/Ball Roll
            [1, 3, 1, 1, 1, 1, 1, 1, 1, 1],
            // Back
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Obliques(Sides)
            [1, 1, 1],
            // Neck
            [1, 2, 1, 1, 1, 1],
            // Arms
            [1, 1, 1],
            // Pecs
            [1],
            // Shoulders
            [1, 1, 1, 1, 1, 1],
            // Hips and Glutes
            [2, 1, 1, 1, 1, 1, 1],
            // Calves
            [1],
            // Hamstrings
            [3, 3, 1, 1, 1, 1],
            // Quads
            [1, 1]
    ]
    
    // Reps Array
    var repsArrayGeneral: [[String]] =
        [
            // Recommended
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
            // Back
            ["15-20 reps",
             "15-30s",
             "30-60s",
             "30-180s",
             "30-90s",
             "10-30 reps",
             "30-60s",
             "25-45s",
             "30-60s",
             "30-180s"],
            // Obliques(Sides)
            ["10-20s",
             "15-30s",
             "15-30s"],
            // Neck
            ["15-30s",
             "5-10s",
             "15-30s",
             "15-30s",
             "15-30s",
             "20-40s"],
            // Arms
            ["15-30s",
             "15-30s",
             "15-30s"],
            // Pecs
            ["15-30s"],
            // Shoulders
            ["20-40s",
             "10-20s",
             "15-30s",
             "15-30s",
             "15-30s",
             "15-30s"],
            // Hips and Glutes
            ["1-5min",
             "5-10 reps",
             "15-30s",
             "15-30s",
             "15-30s",
             "15-45s",
             "15-45s"],
            // Calves
            ["15-30s"],
            // Hamstrings
            ["10s",
             "10s",
             "15-30s",
             "15-45s",
             "15-60s",
             "15-60s"],
            // Quads
            ["15-30s",
             "15-30s"]
    ]
    
    
    
    
    
    
    
    
    
    // Demonstration Array
    var demonstrationArrayGeneral: [[UIImage]] =
    [
    // Mandatory
    [#imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test")],
    // Joint Rotations
    [#imageLiteral(resourceName: "Wrist Rotations"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test")],
    // Foam/Ball Roll
    [#imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test")],
    // Back
    [#imageLiteral(resourceName: "Cow"),
    #imageLiteral(resourceName: "Upwards Dog"),
    #imageLiteral(resourceName: "Extended Puppy"),
    #imageLiteral(resourceName: "Childs Pose"),
    #imageLiteral(resourceName: "Staff Pose"),
    #imageLiteral(resourceName: "Pelvic Tilt"),
    #imageLiteral(resourceName: "Knee Chest"),
    #imageLiteral(resourceName: "Knee Drop"),
    #imageLiteral(resourceName: "Marichis Pose"),
    #imageLiteral(resourceName: "Legs Wall")],
    // Obliques(Sides)
    [#imageLiteral(resourceName: "Side Bend"),
    #imageLiteral(resourceName: "Extended Side Angle"),
    #imageLiteral(resourceName: "Half Straddle Side Bend")],
    // Neck
    [#imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test")],
    // Arms
    [#imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test")],
    // Pecs
    [#imageLiteral(resourceName: "Test")],
    // Shoulders
    [#imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test")],
    // Hips and Glutes
    [#imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test")],
    // Calves
    [#imageLiteral(resourceName: "Test")],
    // Hamstrings
    [#imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test")],
    // Quads
    [#imageLiteral(resourceName: "Test"),
    #imageLiteral(resourceName: "Test")]
    
    ]
    
    // Target Area Array
    var targetAreaArrayGeneral: [[UIImage]] =
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
            // Back
            [#imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Spine and Core"),
             #imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Hamstring and Lower Back")],
            // Obliques(Sides)
            [#imageLiteral(resourceName: "Oblique"),
             #imageLiteral(resourceName: "Oblique"),
             #imageLiteral(resourceName: "Oblique")],
            // Neck
            [#imageLiteral(resourceName: "Rear Neck"),
             #imageLiteral(resourceName: "Rear Neck"),
             #imageLiteral(resourceName: "Lateral Neck"),
             #imageLiteral(resourceName: "Neck Rotator"),
             #imageLiteral(resourceName: "Neck Rotator"),
             #imageLiteral(resourceName: "Neck")],
            // Arms
            [#imageLiteral(resourceName: "Forearm"),
             #imageLiteral(resourceName: "Tricep"),
             #imageLiteral(resourceName: "Bicep")],
            // Pecs
            [#imageLiteral(resourceName: "Pec")],
            // Shoulders
            [#imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Front Delt"),
             #imageLiteral(resourceName: "Lateral Neck"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Rear Delt")],
            // Hips and Glutes
            [#imageLiteral(resourceName: "Hip Joint"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hip Area"),
             #imageLiteral(resourceName: "Piriformis"),
             #imageLiteral(resourceName: "Glute"),
             #imageLiteral(resourceName: "Glute")],
            // Calves
            [#imageLiteral(resourceName: "Calf")],
            // Hamstrings
            [#imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring")],
            // Quads
            [#imageLiteral(resourceName: "Quad"),
             #imageLiteral(resourceName: "Quad")]
            
    ]
    
    // Explanation Array
    var explanationArrayGeneral: [[String]] =
        [
            // Recommended
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
            ["catCowE",
             "upwardsDogE",
             "extendedPuppyE",
             "childPoseE",
             "staffPoseE",
             "pelvicTiltE",
             "kneeToChestE",
             "legDropE",
             "seatedTwistE",
             "legsWallE"],
            // Obliques(Sides)
            ["sideLeanE",
             "extendedSideAngleE",
             "seatedSideE"],
            // Neck
            ["rearNeckE",
             "rearNeckHandE",
             "seatedLateralE",
             "neckRotatorE",
             "scaleneE",
             "headRollE"],
            // Arms
            ["forearmStretchE",
             "tricepStretchE",
             "bicepStretchE"],
            // Pecs
            ["pecStretchE"],
            // Shoulders
            ["shoulderRollE",
             "behindBackTouchE",
             "frontDeltE",
             "lateralDeltE",
             "rearDeltE",
             "rotatorCuffE"],
            // Hips and Glutes
            ["squatHoldE",
             "groinStretchE",
             "butterflyPoseE",
             "lungeStretchE",
             "threadTheNeedleE",
             "pigeonPoseE",
             "seatedGluteE"],
            // Calves
            ["calveStretchE"],
            // Hamstrings
            ["standingHamstringE",
             "standingOneLegHamstringE",
             "singleLegStandingE",
             "downWardsDogE",
             "singleLegHamstringE",
             "twoLegHamstringE"],
            // Quads
            ["lungeStretchWallE",
             "QuadStretchE"]
    ]
    
    
    // Presets Arrys
    //
    // Picker View Array
    var pickerViewArrayGeneral: [String] =
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
    var presetsArraysGeneral: [[[Int]]] =
        [
            [
                // Recommended
                [0,0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0,0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0,0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0,0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0,0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0,0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0,0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ]
    ]
    
    
    
    //
    // Post Workout -----------------------------------------------------------------------------------------------------------------------------------------------
    //
    
    
    // Stretching Post Workout Array
    var stretchingWorkoutArray: [[String]] =
        [
            // Recommended
            ["5minCardioL"],
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
             "rearDelt",
             "quadf",
             "adductorf",
             "hamstringf",
             "glutef",
             "calvef"],
            // Back
            ["catCow",
             "upwardsDog",
             "extendedPuppy",
             "childPose",
             "staffPose",
             "pelvicTilt",
             "kneeToChest",
             "legDrop",
             "seatedTwist",
             "legsWall"],
            // Obliques(Sides)
            ["sideLean",
             "extendedSideAngle",
             "seatedSide"],
            // Neck
            ["rearNeck",
             "rearNeckHand",
             "seatedLateral",
             "neckRotator",
             "scalene",
             "headRoll"],
            // Arms
            ["forearmStretch",
             "tricepStretch",
             "bicepStretch"],
            // Pecs
            ["pecStretch"],
            // Shoulders
            ["shoulderRoll",
             "behindBackTouch",
             "frontDelt",
             "lateralDelt",
             "rearDelt",
             "rotatorCuff"],
            // Hips and Glutes
            ["squatHold",
             "groinStretch",
             "butterflyPose",
             "lungeStretch",
             "threadTheNeedle",
             "pigeonPose",
             "seatedGlute"],
            // Calves
            ["calveStretch"],
            // Hamstrings
            ["standingHamstring",
             "standingOneLegHamstring",
             "singleLegStanding",
             "downWardsDog",
             "singleLegHamstring",
             "twoLegHamstring"],
            // Quads
            ["lungeStretchWall",
             "QuadStretch"]
    ]
    
    
    // Table View Section Title Array
    var tableViewSectionArrayWorkout: [String] =
        [
            "recommended",
            "jointRotation",
            "foamRoll",
            "backStretch",
            "sides",
            "neck",
            "arms",
            "pecs",
            "shoulders",
            "hipsaGlutes",
            "calves",
            "hamstrings",
            "quads"
    ]
    
    // Custom Presets Post Workout
    //
    let emptyArrayWorkout: [[Int]] =
        [
            // Recommended
            [0],
            // Joint Rotations
            [0, 0, 0, 0, 0, 0, 0, 0],
            // Foam/Ball Roll
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            // Back
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            // Obliques(Sides)
            [0, 0, 0],
            // Neck
            [0, 0, 0, 0, 0, 0],
            // Arms
            [0, 0, 0],
            // Pecs
            [0],
            // Shoulders
            [0, 0, 0, 0, 0, 0],
            // Hips and Glutes
            [0, 0, 0, 0, 0, 0, 0],
            // Calves
            [0],
            // Hamstrings
            [0, 0, 0, 0, 0, 0],
            // Quads
            [0, 0]
    ]
    //
    var stretchingWorkoutPresets: [[[Int]]] =
        [
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ]
    ]
    
    
    // Screen Arrays
    //
    var setsArrayWorkout: [[Int]] =
        [
            // Recommended
            [1],
            // Joint Rotations
            [1, 1, 1, 1, 1, 1, 1, 1],
            // Foam/Ball Roll
            [1, 3, 1, 1, 1, 1, 1, 1, 1, 1],
            // Back
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Obliques(Sides)
            [1, 1, 1],
            // Neck
            [1, 2, 1, 1, 1, 1],
            // Arms
            [1, 1, 1],
            // Pecs
            [1],
            // Shoulders
            [1, 1, 1, 1, 1, 1],
            // Hips and Glutes
            [2, 1, 1, 1, 1, 1, 1],
            // Calves
            [1],
            // Hamstrings
            [3, 3, 1, 1, 1, 1],
            // Quads
            [1, 1]
    ]
    
    // Reps Array
    var repsArrayWorkout: [[String]] =
        [
            // Recommended
            ["5min"],
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
            // Back
            ["15-20 reps",
             "15-30s",
             "30-60s",
             "30-180s",
             "30-90s",
             "10-30 reps",
             "30-60s",
             "25-45s",
             "30-60s",
             "30-180s"],
            // Obliques(Sides)
            ["10-20s",
             "15-30s",
             "15-30s"],
            // Neck
            ["15-30s",
             "5-10s",
             "15-30s",
             "15-30s",
             "15-30s",
             "20-40s"],
            // Arms
            ["15-30s",
             "15-30s",
             "15-30s"],
            // Pecs
            ["15-30s"],
            // Shoulders
            ["20-40s",
             "10-20s",
             "15-30s",
             "15-30s",
             "15-30s",
             "15-30s"],
            // Hips and Glutes
            ["1-5min",
             "5-10 reps",
             "15-30s",
             "15-30s",
             "15-30s",
             "15-45s",
             "15-45s"],
            // Calves
            ["15-30s"],
            // Hamstrings
            ["10s",
             "10s",
             "15-30s",
             "15-45s",
             "15-60s",
             "15-60s"],
            // Quads
            ["15-30s",
             "15-30s"]
    ]
    
    
    // Demonstration Array
    var demonstrationArrayWorkout: [[UIImage]] = [[]]
    
    // Target Area Array
    var targetAreaArrayWorkout: [[UIImage]] =
        [
            // Mandatory
            [#imageLiteral(resourceName: "Heart")],
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
            // Back
            [#imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Spine and Core"),
             #imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Hamstring and Lower Back")],
            // Obliques(Sides)
            [#imageLiteral(resourceName: "Oblique"),
             #imageLiteral(resourceName: "Oblique"),
             #imageLiteral(resourceName: "Oblique")],
            // Neck
            [#imageLiteral(resourceName: "Rear Neck"),
             #imageLiteral(resourceName: "Rear Neck"),
             #imageLiteral(resourceName: "Lateral Neck"),
             #imageLiteral(resourceName: "Neck Rotator"),
             #imageLiteral(resourceName: "Neck Rotator"),
             #imageLiteral(resourceName: "Neck")],
            // Arms
            [#imageLiteral(resourceName: "Forearm"),
             #imageLiteral(resourceName: "Tricep"),
             #imageLiteral(resourceName: "Bicep")],
            // Pecs
            [#imageLiteral(resourceName: "Pec")],
            // Shoulders
            [#imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Front Delt"),
             #imageLiteral(resourceName: "Lateral Neck"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Rear Delt")],
            // Hips and Glutes
            [#imageLiteral(resourceName: "Hip Joint"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hip Area"),
             #imageLiteral(resourceName: "Piriformis"),
             #imageLiteral(resourceName: "Glute"),
             #imageLiteral(resourceName: "Glute")],
            // Calves
            [#imageLiteral(resourceName: "Calf")],
            // Hamstrings
            [#imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring")],
            // Quads
            [#imageLiteral(resourceName: "Quad"),
             #imageLiteral(resourceName: "Quad")]
    ]
    
    // Explanation Array
    var explanationArrayWorkout: [[String]] =
        [
            // Recommended
            ["5minCardioLCE"],
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
            ["catCowE",
             "upwardsDogE",
             "extendedPuppyE",
             "childPoseE",
             "staffPoseE",
             "pelvicTiltE",
             "kneeToChestE",
             "legDropE",
             "seatedTwistE",
             "legsWallE"],
            // Obliques(Sides)
            ["sideLeanE",
             "extendedSideAngleE",
             "seatedSideE"],
            // Neck
            ["rearNeckE",
             "rearNeckHandE",
             "seatedLateralE",
             "neckRotatorE",
             "scaleneE",
             "headRollE"],
            // Arms
            ["forearmStretchE",
             "tricepStretchE",
             "bicepStretchE"],
            // Pecs
            ["pecStretchE"],
            // Shoulders
            ["shoulderRollE",
             "behindBackTouchE",
             "frontDeltE",
             "lateralDeltE",
             "rearDeltE",
             "rotatorCuffE"],
            // Hips and Glutes
            ["squatHoldE",
             "groinStretchE",
             "butterflyPoseE",
             "lungeStretchE",
             "threadTheNeedleE",
             "pigeonPoseE",
             "seatedGluteE"],
            // Calves
            ["calveStretchE"],
            // Hamstrings
            ["standingHamstringE",
             "standingOneLegHamstringE",
             "singleLegStandingE",
             "downWardsDogE",
             "singleLegHamstringE",
             "twoLegHamstringE"],
            // Quads
            ["lungeStretchWallE",
             "QuadStretchE"]
    ]
    
    
    
    
    
    
    
    
    // Post Workout Presets Arrays
    //
    // Picker View Array
    var pickerViewArrayWorkout: [String] =
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
    var presetsArraysWorkout: [[[Int]]] =
        [
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ]
    ]
    
    
    //
    // Post Cardio -----------------------------------------------------------------------------------------------------------------------------------------------
    //
    
    
    // Stretching Post Cardio Array
    var stretchingCardioArray: [[String]] =
        [
            // Recommended
            ["5minCardioL"],
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
             "rearDelt",
             "quadf",
             "adductorf",
             "hamstringf",
             "glutef",
             "calvef"],
            // Back
            ["catCow",
             "upwardsDog",
             "extendedPuppy",
             "childPose",
             "staffPose",
             "pelvicTilt",
             "kneeToChest",
             "legDrop",
             "seatedTwist",
             "legsWall"],
            // Obliques(Sides)
            ["sideLean",
             "extendedSideAngle",
             "seatedSide"],
            // Neck
            ["rearNeck",
             "rearNeckHand",
             "seatedLateral",
             "neckRotator",
             "scalene",
             "headRoll"],
            // Arms
            ["forearmStretch",
             "tricepStretch",
             "bicepStretch"],
            // Pecs
            ["pecStretch"],
            // Shoulders
            ["shoulderRoll",
             "behindBackTouch",
             "frontDelt",
             "lateralDelt",
             "rearDelt",
             "rotatorCuff"],
            // Hips and Glutes
            ["squatHold",
             "groinStretch",
             "butterflyPose",
             "lungeStretch",
             "threadTheNeedle",
             "pigeonPose",
             "seatedGlute"],
            // Calves
            ["calveStretch"],
            // Hamstrings
            ["standingHamstring",
             "standingOneLegHamstring",
             "singleLegStanding",
             "downWardsDog",
             "singleLegHamstring",
             "twoLegHamstring"],
            // Quads
            ["lungeStretchWall",
             "QuadStretch"]
    ]
    
    
    // Table View Section Title Array
    var tableViewSectionArrayCardio: [String] =
        [
            "recommended",
            "jointRotation",
            "foamRoll",
            "backStretch",
            "sides",
            "neck",
            "arms",
            "pecs",
            "shoulders",
            "hipsaGlutes",
            "calves",
            "hamstrings",
            "quads"
    ]
    
    // Custom Presets Post Cardio
    //
    let emptyArrayCardio: [[Int]] =
        [
            // Recommended
            [0],
            // Joint Rotations
            [0, 0, 0, 0, 0, 0, 0, 0],
            // Foam/Ball Roll
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            // Back
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            // Obliques(Sides)
            [0, 0, 0],
            // Neck
            [0, 0, 0, 0, 0, 0],
            // Arms
            [0, 0, 0],
            // Pecs
            [0],
            // Shoulders
            [0, 0, 0, 0, 0, 0],
            // Hips and Glutes
            [0, 0, 0, 0, 0, 0, 0],
            // Calves
            [0],
            // Hamstrings
            [0, 0, 0, 0, 0, 0],
            // Quads
            [0, 0]
        ]
    //
    var stretchingCardioPresets: [[[Int]]] =
        [
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ]
    ]
    
    
    
    // Screen Arrays
    //
    var setsArrayCardio: [[Int]] =
        [
            // Recommended
            [1],
            // Joint Rotations
            [1, 1, 1, 1, 1, 1, 1, 1],
            // Foam/Ball Roll
            [1, 3, 1, 1, 1, 1, 1, 1, 1, 1],
            // Back
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Obliques(Sides)
            [1, 1, 1],
            // Neck
            [1, 2, 1, 1, 1, 1],
            // Arms
            [1, 1, 1],
            // Pecs
            [1],
            // Shoulders
            [1, 1, 1, 1, 1, 1],
            // Hips and Glutes
            [2, 1, 1, 1, 1, 1, 1],
            // Calves
            [1],
            // Hamstrings
            [3, 3, 1, 1, 1, 1],
            // Quads
            [1, 1]
        ]
    
    // Reps Array
    var repsArrayCardio: [[String]] =
        [
            // Recommended
            ["5min"],
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
            // Back
            ["15-20 reps",
             "15-30s",
             "30-60s",
             "30-180s",
             "30-90s",
             "10-30 reps",
             "30-60s",
             "25-45s",
             "30-60s",
             "30-180s"],
            // Obliques(Sides)
            ["10-20s",
             "15-30s",
             "15-30s"],
            // Neck
            ["15-30s",
             "5-10s",
             "15-30s",
             "15-30s",
             "15-30s",
             "20-40s"],
            // Arms
            ["15-30s",
             "15-30s",
             "15-30s"],
            // Pecs
            ["15-30s"],
            // Shoulders
            ["20-40s",
             "10-20s",
             "15-30s",
             "15-30s",
             "15-30s",
             "15-30s"],
            // Hips and Glutes
            ["1-5min",
             "5-10 reps",
             "15-30s",
             "15-30s",
             "15-30s",
             "15-45s",
             "15-45s"],
            // Calves
            ["15-30s"],
            // Hamstrings
            ["10s",
             "10s",
             "15-30s",
             "15-45s",
             "15-60s",
             "15-60s"],
            // Quads
            ["15-30s",
             "15-30s"]
    ]
    
    
    // Demonstration Array
    var demonstrationArrayCardio: [[UIImage]] = [[]]
    
    // Target Area Array
    var targetAreaArrayCardio: [[UIImage]] =
        [
            // Mandatory
            [#imageLiteral(resourceName: "Heart")],
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
            // Back
            [#imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Spine and Core"),
             #imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Spine"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Hamstring and Lower Back")],
            // Obliques(Sides)
            [#imageLiteral(resourceName: "Oblique"),
             #imageLiteral(resourceName: "Oblique"),
             #imageLiteral(resourceName: "Oblique")],
            // Neck
            [#imageLiteral(resourceName: "Rear Neck"),
             #imageLiteral(resourceName: "Rear Neck"),
             #imageLiteral(resourceName: "Lateral Neck"),
             #imageLiteral(resourceName: "Neck Rotator"),
             #imageLiteral(resourceName: "Neck Rotator"),
             #imageLiteral(resourceName: "Neck")],
            // Arms
            [#imageLiteral(resourceName: "Forearm"),
             #imageLiteral(resourceName: "Tricep"),
             #imageLiteral(resourceName: "Bicep")],
            // Pecs
            [#imageLiteral(resourceName: "Pec")],
            // Shoulders
            [#imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Front Delt"),
             #imageLiteral(resourceName: "Lateral Neck"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Rear Delt")],
            // Hips and Glutes
            [#imageLiteral(resourceName: "Hip Joint"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hip Area"),
             #imageLiteral(resourceName: "Piriformis"),
             #imageLiteral(resourceName: "Glute"),
             #imageLiteral(resourceName: "Glute")],
            // Calves
            [#imageLiteral(resourceName: "Calf")],
            // Hamstrings
            [#imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Hamstring")],
            // Quads
            [#imageLiteral(resourceName: "Quad"),
             #imageLiteral(resourceName: "Quad")]
    ]
    
    // Explanation Array
    var explanationArrayCardio: [[String]] =
        [
            // Recommended
            ["5minCardioLCE"],
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
            ["catCowE",
             "upwardsDogE",
             "extendedPuppyE",
             "childPoseE",
             "staffPoseE",
             "pelvicTiltE",
             "kneeToChestE",
             "legDropE",
             "seatedTwistE",
             "legsWallE"],
            // Obliques(Sides)
            ["sideLeanE",
             "extendedSideAngleE",
             "seatedSideE"],
            // Neck
            ["rearNeckE",
             "rearNeckHandE",
             "seatedLateralE",
             "neckRotatorE",
             "scaleneE",
             "headRollE"],
            // Arms
            ["forearmStretchE",
             "tricepStretchE",
             "bicepStretchE"],
            // Pecs
            ["pecStretchE"],
            // Shoulders
            ["shoulderRollE",
             "behindBackTouchE",
             "frontDeltE",
             "lateralDeltE",
             "rearDeltE",
             "rotatorCuffE"],
            // Hips and Glutes
            ["squatHoldE",
             "groinStretchE",
             "butterflyPoseE",
             "lungeStretchE",
             "threadTheNeedleE",
             "pigeonPoseE",
             "seatedGluteE"],
            // Calves
            ["calveStretchE"],
            // Hamstrings
            ["standingHamstringE",
             "standingOneLegHamstringE",
             "singleLegStandingE",
             "downWardsDogE",
             "singleLegHamstringE",
             "twoLegHamstringE"],
            // Quads
            ["lungeStretchWallE",
             "QuadStretchE"]
    ]
    
    
    // Presets Sessions Arrays
    //
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
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ],
            [
                // Recommended
                [0],
                // Joint Rotations
                [0, 0, 0, 0, 0, 0, 0, 0],
                // Foam/Ball Roll
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Back
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                // Obliques(Sides)
                [0, 0, 0],
                // Neck
                [0, 0, 0, 0, 0, 0],
                // Arms
                [0, 0, 0],
                // Pecs
                [0],
                // Shoulders
                [0, 0, 0, 0, 0, 0],
                // Hips and Glutes
                [0, 0, 0, 0, 0, 0, 0],
                // Calves
                [0],
                // Hamstrings
                [0, 0, 0, 0, 0, 0],
                // Quads
                [0, 0]
            ]
    ]
    
    
    
    
    
    
    
    
    
    // Set Arrays Function
    //
    func setArrays() {
        
        switch stretchingType {
            
        case 0:
            // Choice Screen Arrays
            //
            stretchingMovementsArray = stretchingGeneralArray
            stretchingSelectedArray = presetsArraysGeneral[0]
            pickerViewArray = pickerViewArrayGeneral
            tableViewSectionArray = tableViewSectionArrayGeneral
            presetsArrays = presetsArraysGeneral
            emptyArray = emptyArrayGeneral
            
            // Screen Arrays
            //
            setsArrayF = setsArrayGeneral
            repsArrayF = repsArrayGeneral
            demonstrationArrayF = demonstrationArrayGeneral
            targetAreaArrayF = targetAreaArrayGeneral
            explanationArrayF = explanationArrayGeneral
            
        //
        case 1:
            // Choice Screen Arrays
            //
            stretchingMovementsArray = stretchingWorkoutArray
            stretchingSelectedArray = presetsArraysWorkout[0]
            pickerViewArray = pickerViewArrayWorkout
            tableViewSectionArray = tableViewSectionArrayWorkout
            presetsArrays = presetsArraysWorkout
            emptyArray = emptyArrayWorkout
            
            // Screen Arrays
            //
            setsArrayF = setsArrayWorkout
            repsArrayF = repsArrayWorkout
            demonstrationArrayF = demonstrationArrayWorkout
            targetAreaArrayF = targetAreaArrayWorkout
            explanationArrayF = explanationArrayWorkout
            
        //
        case 2:
            // Choice Screen Arrays
            //
            stretchingMovementsArray = stretchingCardioArray
            stretchingSelectedArray = presetsArraysCardio[0]
            pickerViewArray = pickerViewArrayCardio
            tableViewSectionArray = tableViewSectionArrayCardio
            presetsArrays = presetsArraysCardio
            emptyArray = emptyArrayCardio
            
            // Screen Arrays
            //
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
    // Outlets
    //
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    
    // Information View
    @IBOutlet weak var informationView: UIScrollView!
    
    // Information Title Label
    @IBOutlet weak var informationTitle: UILabel!
    
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
        
        let flash = UIView()
        
        flash.frame = CGRect(x: 0, y: pickerView.frame.maxY, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
            
            flash.alpha = 0
            
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
        
    }
    
    
    
    
    
    //
    // ViewDidLoad
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Arrays
        //
        setArrays()
        
        
        
        // Walkthrough
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2")
        }
        
        
        
        // Colour
        self.view.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        questionMark.tintColor = colour1
        
        
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString(navigationTitles[stretchingType], comment: ""))
        
        
        
        
        // Picker View Test
        pickerView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        
        
        
        
        
        
        
        // Plus Button Colour
        let origImage1 = UIImage(named: "Plus")
        let tintedImage1 = origImage1?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        addPreset.setImage(tintedImage1, for: .normal)
        
        //Image Tint
        //addPreset.tintColor = colour1
        addPreset.tintColor = colour2
        
        
        
        // Minus Button Colour
        let origImage2 = UIImage(named: "Minus")
        let tintedImage2 = origImage2?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        removePreset.setImage(tintedImage2, for: .normal)
        
        //Image Tint
        //removePreset.tintColor = colour1
        removePreset.tintColor = colour2
        
        
        
        
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.setTitleColor(colour2, for: .normal)
        
        
        
        
        
        
        
        // Information
        // Scroll View Frame
        self.informationView.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        
        
        view.bringSubview(toFront: informationView)
        
        
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
        
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationTitle.addGestureRecognizer(downSwipe)
        informationTitle.isUserInteractionEnabled = true
        
        
        
        self.view.addSubview(informationTitle)
        
        
        
        // Information Text and Attributes
        //
        // String
        let informationLabelString = ((NSLocalizedString("stretches", comment: ""))+"\n"+(NSLocalizedString("stretchingChoiceText", comment: "")))
        
        // Range of String
        let textRangeString = ((NSLocalizedString("stretches", comment: ""))+"\n"+(NSLocalizedString("stretchingChoiceText", comment: "")))
        let textRange = (informationLabelString as NSString).range(of: textRangeString)
        
        
        // Range of Titles
        let titleRangeString = (NSLocalizedString("stretches", comment: ""))
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
        
        
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationText.frame.size.height + informationTitle.frame.size.height + 20)
        
        
        
        

        
        
        // TableView Background
        //
        let tableViewBackground = UIView()
            
        tableViewBackground.backgroundColor = colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
            
        tableView.backgroundView = tableViewBackground
        
        
        
        
        
        
        
        //
        // Preset Stretching Sessions
        //
        let defaults = UserDefaults.standard
        
        // General
        defaults.register(defaults: ["stretchingPresetsGeneral" : stretchingGeneralPresets])
        defaults.register(defaults: ["stretchingPresetTextsGeneral" : presetTexts])
        defaults.register(defaults: ["stretchingPresetNumberGeneral" : 0])
        
        // Post Workout
        defaults.register(defaults: ["stretchingPresetsWorkout" : stretchingWorkoutPresets])
        defaults.register(defaults: ["stretchingPresetTextsWorkout" : presetTexts])
        defaults.register(defaults: ["stretchingPresetNumberWorkout" : 0])
        
        
        // Post Cardio
        defaults.register(defaults: ["stretchingPresetsCardio" : stretchingCardioPresets])
        defaults.register(defaults: ["stretchingPresetTextsCardio" : presetTexts])
        defaults.register(defaults: ["stretchingPresetNumberCardio" : 0])
        
        //
        defaults.synchronize()
        
        
        
        //
        beginButtonEnabled()
        
    }
    
    
    // Button Enabled
    func beginButtonEnabled() {
        // Begin Button
        for item in stretchingSelectedArray {
            if item.contains(1) {
                beginButton.isEnabled = true
                break
            } else {
                beginButton.isEnabled = false
            }
        }
        
    }
    
    
    
    
    
    
    
    
    // Set Personalized Preset
    //
    @IBAction func addPreset(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let number = defaults.integer(forKey: stretchingPresetNumbers[stretchingType])
        var stretchingPreset = defaults.object(forKey: stretchingPresets[stretchingType]) as! [Array<Array<Int>>]
        var presetTextArray = defaults.object(forKey: stretchingPresetTexts[stretchingType]) as! [String]
        
        
        // Set Preset
        if number < 3 {
            
            
            
            // Alert and Functions
            //
            let inputTitle = NSLocalizedString("stretchingInputTitle", comment: "")
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
                let textField = alert?.textFields![0]
                
                
                
                
                // Update Preset Text Arrays
                presetTextArray[number] = (textField?.text)!
                defaults.set(presetTextArray, forKey: self.stretchingPresetTexts[self.stretchingType])
                defaults.synchronize()
                
                
                
                
                
                // Set new Preset Array
                //
                stretchingPreset[number] = self.stretchingSelectedArray
                defaults.set(stretchingPreset, forKey: self.stretchingPresets[self.stretchingType])
                
                defaults.synchronize()
                
                
                // Increase Preset Counter
                //
                let newNumber = number + 1
                
                defaults.set(newNumber, forKey: self.stretchingPresetNumbers[self.stretchingType])
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
    
    
    
    
    // Remove Personalized Preset
    @IBAction func removePreset(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let number = defaults.integer(forKey: stretchingPresetNumbers[stretchingType])
        var stretchingPreset = defaults.object(forKey: stretchingPresets[stretchingType]) as! [Array<Array<Int>>]
        var presetTextArray = defaults.object(forKey: stretchingPresetTexts[stretchingType]) as! [String]
        
        
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let index = (selectedRow) - (pickerViewArray.count + 1)
        
        
        if index > -1 {
            
            stretchingPreset.remove(at: index)
            stretchingPreset.append(emptyArray)
            
            defaults.set(stretchingPreset, forKey: stretchingPresets[stretchingType])
            
            
            presetTextArray.remove(at: index)
            presetTextArray.append(emptyString)
            
            defaults.set(presetTextArray, forKey: stretchingPresetTexts[stretchingType])
            
            
            if number > 0 {
                let newNumber = number - 1
                defaults.set(newNumber, forKey: stretchingPresetNumbers[stretchingType])
            } else {
                
            }
            
            
            
            
            defaults.synchronize()
            
            
            
            
            // Flash Screen
            self.flashScreen()
            self.pickerView.reloadAllComponents()
            self.tableView.reloadData()
            
        } else {
            
        }
    }
    
    
    
    
    
    
    // Picker Views
    //
    
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerViewArray.count + 4
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if row < pickerViewArray.count {
            let rowLabel = UILabel()
            let titleData = NSLocalizedString(pickerViewArray[row], comment: "")
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
        } else if row == pickerViewArray.count {
            
            let line = UILabel()
            line.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width * (2/3), height: 1)
            line.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            line.isEnabled = false
            return line
            
            
        } else if row == pickerViewArray.count + 1 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: stretchingPresetTexts[stretchingType]) as! [String]
            let titleData = titleDataArray[0]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
            
            
        } else if row == pickerViewArray.count + 2 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: stretchingPresetTexts[stretchingType]) as! [String]
            let titleData = titleDataArray[1]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
            
            
        } else if row == pickerViewArray.count + 3 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: stretchingPresetTexts[stretchingType]) as! [String]
            let titleData = titleDataArray[2]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
        }
        
        return UIView()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let defaults = UserDefaults.standard
        
        switch row {
            
        case 0:
            stretchingSelectedArray = presetsArrays[row]
            
            self.tableView.reloadData()
            flashScreen()
        //
        case 1:
            stretchingSelectedArray = presetsArrays[row]
            
            self.tableView.reloadData()
            flashScreen()
        //
        case 2:
            stretchingSelectedArray = presetsArrays[row]
            
            self.tableView.reloadData()
            flashScreen()
        //
        case 3:
            stretchingSelectedArray = presetsArrays[row]
            
            
            self.tableView.reloadData()
            flashScreen()
        //
        case 4:
            stretchingSelectedArray = presetsArrays[row]
            
            
            self.tableView.reloadData()
            flashScreen()
        //
        case 5:
            stretchingSelectedArray = presetsArrays[row]
            
            self.tableView.reloadData()
            flashScreen()
        //
        case 6:
            stretchingSelectedArray = presetsArrays[row]
            
            self.tableView.reloadData()
            flashScreen()
        //
        case 7:
            break
        //
        case 8:
            let fullArray = defaults.object(forKey: stretchingPresets[stretchingType]) as! [Array<Array<Int>>]
            let array = fullArray[0]
            stretchingSelectedArray = array
            
            
            self.tableView.reloadData()
            flashScreen()
        //
        case 9:
            let fullArray = defaults.object(forKey: stretchingPresets[stretchingType]) as! [Array<Array<Int>>]
            let array = fullArray[1]
            stretchingSelectedArray = array
            
            
            self.tableView.reloadData()
            flashScreen()
        //
        case 10:
            let fullArray = defaults.object(forKey: stretchingPresets[stretchingType]) as! [Array<Array<Int>>]
            let array = fullArray[2]
            stretchingSelectedArray = array
            
            
            self.tableView.reloadData()
            flashScreen()
        //
        default:
            break
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    // Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stretchingMovementsArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(tableViewSectionArray[section], comment: "")
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 18)!
        header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        //colour2
        header.contentView.tintColor = colour1
        //
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stretchingMovementsArray[section].count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.textLabel?.text = NSLocalizedString(stretchingMovementsArray[indexPath.section][indexPath.row], comment: "")
        
        
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        cell.textLabel?.textColor = .black
        cell.tintColor = .black
        //
        
        
        if stretchingSelectedArray[indexPath.section][indexPath.row] == 1 {
            cell.layer.borderColor = colour2.cgColor
            cell.layer.borderWidth = 2
            
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        
        // Cell Image
        cell.imageView?.image = demonstrationArrayF[indexPath.section][indexPath.row]
        cell.imageView?.isUserInteractionEnabled = true
        
        // Image Tap
        let imageTap = UITapGestureRecognizer()
        imageTap.numberOfTapsRequired = 1
        imageTap.addTarget(self, action: #selector(handleTap))
        cell.imageView?.addGestureRecognizer(imageTap)
        
        
        
        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 72
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            stretchingSelectedArray[indexPath.section][indexPath.row] = 0
            tableView.reloadData()
        } else {
            cell?.accessoryType = .checkmark
            stretchingSelectedArray[indexPath.section][indexPath.row] = 1
            tableView.reloadData()
        }
        
        beginButtonEnabled()
    }
    
    
    
    
    
    
    
    
    
    
    // QuestionMark Button Action
    @IBAction func informationButtonAction(_ sender: Any) {
        
        // Information Down
        if self.informationView.frame.minY < self.view.frame.maxY {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            self.informationView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            
            
            // Buttons
            questionMark.image = #imageLiteral(resourceName: "QuestionMarkN")
            navigationBar.setHidesBackButton(false, animated: true)
            
            
            // Information Up
        } else {
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            self.informationView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            
            
            // Buttons
            questionMark.image = #imageLiteral(resourceName: "Down")
            navigationBar.setHidesBackButton(true, animated: true)
            
            
        }
        
    }
    
    
    
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.informationView.frame.minY < self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
                UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
                
                
                // Buttons
                questionMark.image = #imageLiteral(resourceName: "QuestionMarkN")
                navigationBar.setHidesBackButton(false, animated: true)
                
            }
        }
    }
    
    // Handle Tap
    //
    let expandedImage = UIImageView()
    let backgroundViewImage = UIButton()
    //
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        
        //
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        
        
        // Get Image
        let sender = extraTap.view as! UIImageView
        let image = sender.image
        
        
        
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
    
    
    
    
    
    
    
    
    
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        
        if UserDefaults.standard.string(forKey: "presentationStyle") == "detailed" {
            
            performSegue(withIdentifier: "stretchingSessionSegue1", sender: nil)
            
        } else {
            
            performSegue(withIdentifier: "stretchingSessionSegue2", sender: nil)
        }
        
        
        // Return background to homescreen
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            
            _ = self.navigationController?.popToRootViewController(animated: false)
            
        }
    }
    
    
    
    
    // Pass Array to next ViewController
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stretchingSessionSegue1") {
            
            // Compress Arrays
            //
            stretchingArray = zip(stretchingMovementsArray.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            setsArray = zip(setsArrayF.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            repsArray = zip(repsArrayF.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            demonstrationArray = zip(demonstrationArrayF.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            targetAreaArray = zip(targetAreaArrayF.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            explanationArray = zip(explanationArrayF.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            
            // Pass Data
            let destinationNC = segue.destination as! UINavigationController
            
            let destinationVC = destinationNC.viewControllers.first as! StretchingScreen
            
            destinationVC.stretchingArray = stretchingArray
            
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            
            
        } else if (segue.identifier == "stretchingSessionSegue2") {
            
            // Compress Arrays
            //
            stretchingArray = zip(stretchingMovementsArray.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            setsArray = zip(setsArrayF.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            repsArray = zip(repsArrayF.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            demonstrationArray = zip(demonstrationArrayF.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            targetAreaArray = zip(targetAreaArrayF.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            explanationArray = zip(explanationArrayF.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            
            // Pass Data
            let destinationNC = segue.destination as! UINavigationController
            
            let destinationVC = destinationNC.viewControllers.first as! StretchingScreenOverview
            
            destinationVC.stretchingArray = stretchingArray
            
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            
            let pickerIndex = pickerView.selectedRow(inComponent: 0)
            if pickerIndex < pickerViewArray.count - 1 {
                destinationVC.stretchingTitle = pickerViewArray[pickerIndex]
            } else if pickerIndex > pickerViewArray.count - 1 {
                let pickerArray = UserDefaults.standard.object(forKey: stretchingPresetTexts[stretchingType]) as! [String]
                destinationVC.stretchingTitle = pickerArray[pickerIndex - pickerViewArray.count]
            }
        }
    }
    
    
    
    
    
    
    //---------------------------------------------------------------------------------------------------------------
    
    
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
    
    
    
}
