//
//  StretchingChoiceFinal.swift
//  MindAndBody
//
//  Created by Luke Smith on 18.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Stretching Choice Class -------------------------------------------------------------------------------------------------------------
//
class StretchingChoiceFinal: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Selected Stretching Type
    //
    var stretchingType = Int()
    
    // Selected Preset
    //
    var selectedPreset: [Int] = [0, 0]
    
    // Section Numbers
    //
    var sectionNumbers: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
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
    
    // Arrays to be set and used (Screen arrays)
    // Movements Array
    var stretchingArray: [String] = []
    
    // Reps Array
    var breathsArray: [String] = []
    
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
// Dictionaries -----------------------------------------------------------------------------------------------------
//
    // Table View Section Title Array
    var tableViewSectionArray: [String] =
        [
            "cardio",
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
            "quads",
            "fullBody"
    ]
    
    // Stretching Post Workout Array
    var fullKeyArray: [[Int]] =
        [
            // Recommended
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
            // Back
            [21,
             22,
             23,
             24,
             25,
             26,
             27,
             28,
             29,
             30],
            // Obliques(Sides)
            [31,
             32,
             33],
            // Neck
            [34,
             35,
             36,
             37,
             38,
             39],
            // Arms
            [40,
             41,
             42],
            // Pecs
            [43],
            // Shoulders
            [44,
             45,
             46,
             47,
             48,
             49],
            // Hips and Glutes
            [50,
             51,
             52,
             53,
             54,
             55,
             56],
            // Calves
            [57],
            // Hamstrings
            [58,
             59,
             60,
             61,
             62],
            // Quads
            [63,
             64],
            // Full Body
            [65,
            66]
    ]
    
    // Stretching Post Workout Array
    var stretchingMovementsDictionary: [Int : String] =
        [
            // Recommended
            0: "5minCardioL",
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
            // Back
            21: "catCow",
            22: "upwardsDog",
            23: "extendedPuppy",
            24: "childPose",
            25: "staffPose",
            26: "pelvicTilt",
            27: "kneeToChest",
            28: "legDrop",
            29: "seatedTwist",
            30: "legsWall",
            // Obliques(Sides)
            31: "sideLean",
            32: "extendedSideAngle",
            33: "seatedSide",
            // Neck
            34: "rearNeck",
            35: "rearNeckHand",
            36: "seatedLateral",
            37: "neckRotator",
            38: "scalene",
            39: "headRoll",
            // Arms
            40: "forearmStretch",
            41: "tricepStretch",
            42: "bicepStretch",
            // Pecs
            43: "pecStretch",
            // Shoulders
            44: "shoulderRoll",
            45: "behindBackTouch",
            46: "frontDelt",
            47: "lateralDelt",
            48: "rearDelt",
            49: "rotatorCuff",
            // Hips and Glutes
            50: "squatHold",
            51: "groinStretch",
            52: "butterflyPose",
            53: "lungeStretch",
            54: "threadTheNeedle",
            55: "pigeonPose",
            56: "seatedGlute",
            // Calves
            57: "calveStretch",
            // Hamstrings
            58: "standingHamstring",
            59: "standingOneLegHamstring",
            60: "downWardsDog",
            61: "singleLegHamstring",
            62: "twoLegHamstring",
            // Quads
            63: "lungeStretchWall",
            64: "QuadStretch",
            // Full Body
            65: "sumoSquatTwist",
            66: "tinyFencerStretch",
    ]
    
    // Breaths/Reps/Seconds Array
    var breathsDictionary: [Int : String] =
        [
            // Recommended
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
            19: "2-7 reps",
            20: "2-7 reps",
            // Back
            21: "15-20 reps",
            22: "5-10 breaths",
            23: "5-10 breaths",
            24: "5-10 breaths",
            25: "5-10 breaths",
            26: "10-30 reps",
            27: "5-10 breaths",
            28: "5-10 breaths",
            29: "5-10 breaths",
            30: "5-10 breaths",
            // Obliques(Sides)
            31: "5-10 breaths",
            32: "5-10 breaths",
            33: "5-10 breaths",
            // Neck
            34: "5-10 breaths",
            35: "5-10 breaths",
            36: "5-10 breaths",
            37: "5-10 breaths",
            38: "5-10 breaths",
            39: "5-10 breaths",
            // Arms
            40: "5-10 breaths",
            41: "5-10 breaths",
            42: "5-10 breaths",
            // Pecs
            43: "5-10 breaths",
            // Shoulders
            44: "5-10 breaths",
            45: "5-10 breaths",
            46: "5-10 breaths",
            47: "5-10 breaths",
            48: "5-10 breaths",
            49: "5-10 breaths",
            // Hips and Glutes
            50: "30 breaths",
            51: "5-10 reps",
            52: "5-10 breaths",
            53: "5-10 breaths",
            54: "5-10 breaths",
            55: "5-10 breaths",
            56: "5-10 breaths",
            // Calves
            57: "5-10 breaths",
            // Hamstrings
            58: "5-10 breaths",
            59: "5-10 breaths",
            60: "5-10 breaths",
            61: "5-10 breaths",
            62: "5-10 breaths",
            // Quads
            63: "5-10 breaths",
            64: "5-10 breaths",
            // Full Body
            65: "5-10 breaths",
            66: "5-10 breaths",
    ]
    
    // Demonstration Array
    var demonstrationDictionary: [Int : [UIImage]] =
        [
            // Mandatory
            0: [#imageLiteral(resourceName: "Test")],
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
            // Back
            21: [#imageLiteral(resourceName: "catCowS"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS2"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS3"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS2"), #imageLiteral(resourceName: "catCowS1")],
            22: [#imageLiteral(resourceName: "upwardsDogS")],
            23: [#imageLiteral(resourceName: "extendedPuppyS")],
            24: [#imageLiteral(resourceName: "childPoseS")],
            25: [#imageLiteral(resourceName: "staffPoseS")],
            26: [#imageLiteral(resourceName: "pelvicTilt"), #imageLiteral(resourceName: "pelvicTilt1"), #imageLiteral(resourceName: "pelvicTilt2"), #imageLiteral(resourceName: "pelvicTilt1"), #imageLiteral(resourceName: "pelvicTilt2"), #imageLiteral(resourceName: "pelvicTilt1"), #imageLiteral(resourceName: "pelvicTilt2")],
            27: [#imageLiteral(resourceName: "kneeToChest")],
            28: [#imageLiteral(resourceName: "legDrop"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop2"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop3"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop2"), #imageLiteral(resourceName: "legDrop1")],
            29: [#imageLiteral(resourceName: "seatedTwist")],
            30: [#imageLiteral(resourceName: "legsWall")],
            // Obliques(Sides)
            31: [#imageLiteral(resourceName: "sideLean")],
            32: [#imageLiteral(resourceName: "extendedSideAngleS")],
            33: [#imageLiteral(resourceName: "seatedSide")],
            // Neck
            34: [#imageLiteral(resourceName: "rearNeck")],
            35: [#imageLiteral(resourceName: "rearNeckHand")],
            36: [#imageLiteral(resourceName: "seatedLateral")],
            37: [#imageLiteral(resourceName: "neckRotator")],
            38: [#imageLiteral(resourceName: "scalene")],
            39: [#imageLiteral(resourceName: "headRoll")],
            // Arms
            40: [#imageLiteral(resourceName: "forearmStretch")],
            41: [#imageLiteral(resourceName: "tricepStretch")],
            42: [#imageLiteral(resourceName: "bicepStretch")],
            // Pecs
            43: [#imageLiteral(resourceName: "pecStretch")],
            // Shoulders
            44: [#imageLiteral(resourceName: "shoulderRoll"), #imageLiteral(resourceName: "shoulderRoll1"), #imageLiteral(resourceName: "shoulderRoll2"), #imageLiteral(resourceName: "shoulderRoll3"), #imageLiteral(resourceName: "shoulderRoll4"), #imageLiteral(resourceName: "shoulderRoll1"), #imageLiteral(resourceName: "shoulderRoll2"), #imageLiteral(resourceName: "shoulderRoll3"), #imageLiteral(resourceName: "shoulderRoll4")],
            45: [#imageLiteral(resourceName: "behindBackTouch")],
            46: [#imageLiteral(resourceName: "frontDelt")],
            47: [#imageLiteral(resourceName: "lateralDelt")],
            48: [#imageLiteral(resourceName: "rearDelt")],
            49: [#imageLiteral(resourceName: "rotatorCuff")],
            // Hips and Glutes
            50: [#imageLiteral(resourceName: "squatHold")],
            51: [#imageLiteral(resourceName: "groinStretch")],
            52: [#imageLiteral(resourceName: "butterflyPoseS")],
            53: [#imageLiteral(resourceName: "lungeStretch")],
            54: [#imageLiteral(resourceName: "threadTheNeedleS")],
            55: [#imageLiteral(resourceName: "pigeonPoseS")],
            56:[#imageLiteral(resourceName: "seatedGlute")],
            // Calves
            57: [#imageLiteral(resourceName: "calveStretch")],
            // Hamstrings
            58: [#imageLiteral(resourceName: "standingHamstring")],
            59: [#imageLiteral(resourceName: "standingSingleLegHamstring")],
            60: [#imageLiteral(resourceName: "downWardsDogS")],
            61: [#imageLiteral(resourceName: "singleLegHamstring")],
            62: [#imageLiteral(resourceName: "twoLegHamstring")],
            // Quads
            63: [#imageLiteral(resourceName: "lungeStretchWall")],
            64: [#imageLiteral(resourceName: "quadStretch")],
            // Full Body
            65: [#imageLiteral(resourceName: "sumoSquatTwist")],
            66: [#imageLiteral(resourceName: "tinyFencerStretch")]
    ]
    
    // Target Area Array
    var targetAreaDictionary: [Int : UIImage] =
        [
            // Mandatory
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
            19: #imageLiteral(resourceName: "Quad"),
            20: #imageLiteral(resourceName: "Calf"),
            // Back
            21: #imageLiteral(resourceName: "Spine"),
            22: #imageLiteral(resourceName: "Spine and Core"),
            23: #imageLiteral(resourceName: "Spine"),
            24: #imageLiteral(resourceName: "Spine"),
            25: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            26: #imageLiteral(resourceName: "Core"),
            27: #imageLiteral(resourceName: "Spine"),
            28: #imageLiteral(resourceName: "Core"),
            29: #imageLiteral(resourceName: "Core"),
            30: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            // Obliques(Sides)
            31: #imageLiteral(resourceName: "Oblique"),
            32: #imageLiteral(resourceName: "Oblique"),
            33: #imageLiteral(resourceName: "Oblique"),
            // Neck
            34: #imageLiteral(resourceName: "Rear Neck"),
            35: #imageLiteral(resourceName: "Rear Neck"),
            36: #imageLiteral(resourceName: "Lateral Neck"),
            37: #imageLiteral(resourceName: "Neck Rotator"),
            38: #imageLiteral(resourceName: "Neck Rotator"),
            39: #imageLiteral(resourceName: "Neck"),
            // Arms
            40: #imageLiteral(resourceName: "Forearm"),
            41: #imageLiteral(resourceName: "Tricep"),
            42: #imageLiteral(resourceName: "Bicep"),
            // Pecs
            43: #imageLiteral(resourceName: "Pec"),
            // Shoulders
            44: #imageLiteral(resourceName: "Shoulder Joint"),
            45: #imageLiteral(resourceName: "Shoulder Joint"),
            46: #imageLiteral(resourceName: "Front Delt"),
            47: #imageLiteral(resourceName: "Lateral Neck"),
            48: #imageLiteral(resourceName: "Rear Delt"),
            49: #imageLiteral(resourceName: "Rear Delt"),
            // Hips and Glutes
            50: #imageLiteral(resourceName: "Hip Joint"),
            51: #imageLiteral(resourceName: "Adductor"),
            52: #imageLiteral(resourceName: "Adductor"),
            53: #imageLiteral(resourceName: "Hip Area"),
            54: #imageLiteral(resourceName: "Piriformis"),
            55: #imageLiteral(resourceName: "Glute"),
            56: #imageLiteral(resourceName: "Glute"),
            // Calves
            57: #imageLiteral(resourceName: "Calf"),
            // Hamstrings
            58: #imageLiteral(resourceName: "Hamstring"),
            59: #imageLiteral(resourceName: "Hamstring"),
            60: #imageLiteral(resourceName: "Hamstring"),
            61: #imageLiteral(resourceName: "Hamstring"),
            62: #imageLiteral(resourceName: "Hamstring"),
            // Quads
            63: #imageLiteral(resourceName: "Quad"),
            64: #imageLiteral(resourceName: "Quad"),
            // Full Body
            65: #imageLiteral(resourceName: "Squat"),
            66: #imageLiteral(resourceName: "Squat")
    ]
    
    // Explanation Array
    var explanationDictionary: [Int : String] =
        [
            // Recommended
            0: "5minCardioLE",
            // Joint Rotations
            1: "wristE",
            2: "elbowE",
            3: "shoulderRE",
            4: "neckRE",
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
            // Back
            21: "catCowE",
            22: "upwardsDogE",
            23: "extendedPuppyE",
            24: "childPoseE",
            25: "staffPoseE",
            26: "pelvicTiltE",
            27: "kneeToChestE",
            28: "legDropE",
            29: "seatedTwistE",
            30: "legsWallE",
            // Obliques(Sides)
            31: "sideLeanE",
            32: "extendedSideAngleE",
            33: "seatedSideE",
            // Neck
            34: "rearNeckE",
            35: "rearNeckHandE",
            36: "seatedLateralE",
            37: "neckRotatorE",
            38: "scaleneE",
            39: "headRollE",
            // Arms
            40: "forearmStretchE",
            41: "tricepStretchE",
            42: "bicepStretchE",
            // Pecs
            43: "pecStretchE",
            // Shoulders
            44: "shoulderRollE",
            45: "behindBackTouchE",
            46: "frontDeltE",
            47: "lateralDeltE",
            48: "rearDeltE",
            49: "rotatorCuffE",
            // Hips and Glutes
            50: "squatHoldE",
            51: "groinStretchE",
            52: "butterflyPoseE",
            53: "lungeStretchE",
            54: "threadTheNeedleE",
            55: "pigeonPoseE",
            56: "seatedGluteE",
            // Calves
            57: "calveStretchE",
            // Hamstrings
            58: "standingHamstringE",
            59: "standingOneLegHamstringE",
            60: "downWardsDogE",
            61: "singleLegHamstringE",
            62: "twoLegHamstringE",
            // Quads
            63: "lungeStretchWallE",
            64: "QuadStretchE",
            // Full Body
            65: "sumoSquatTwistE",
            66: "tinyFencerStretchE"
    ]
    
    
    //
    // General -----------------------------------------------------------------------------------------------------
    //
    
    // Prests Table Array
    var presetsTableArrayGeneral: [[String]] =
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
    var presetsArraysGeneral: [[[Int]]] =
        [
            [
               [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64],
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
    // Post Workout -----------------------------------------------------------------------------------------------------------
    //
    // Post Workout Presets Arrays
    //
    // Prests Table Array
    var presetsTableArrayWorkout: [[String]] =
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
    var presetsArraysWorkout: [[[Int]]] =
        [
            [
                [0, 1, 2],
                [],
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
    // Post Cardio -----------------------------------------------------------------------------------------------------------
    //
    //
    
    // Presets Sessions Arrays
    //
    // Prests Table Array
    var presetsTableArrayCardio: [[String]] =
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
    
    
    //
    // Set Arrays Function -----------------------------------------------------------------------------------------------------------
    //
    func setArrays() {
        //
        
        switch stretchingType {
        //
        case 0:
            // Choice Screen Arrays
            presetsArray = presetsTableArrayGeneral
            presetsArrays = presetsArraysGeneral
        //
        case 1:
            // Choice Screen Arrays
            presetsArray = presetsTableArrayWorkout
            presetsArrays = presetsArraysWorkout
        //
        case 2:
            // Choice Screen Arrays
            presetsArray = presetsTableArrayCardio
            presetsArrays = presetsArraysCardio
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
        UIView.animate(withDuration: 0.3, animations: {
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
        presetsButton.setTitle(NSLocalizedString("selectStretching", comment: ""), for: .normal)
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
        navigationBar.title = (NSLocalizedString(navigationTitles[stretchingType], comment: ""))
        
        //
        presetsButton.backgroundColor = colour2
        presetsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //
        movementsTableView.tableFooterView = UIView()
        
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
            return " "
        default: break
        }
        return ""
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
        header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        header.contentView.tintColor = colour1
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
            cell.textLabel?.text = NSLocalizedString(stretchingMovementsDictionary[overviewArray[indexPath.section][indexPath.row]]!, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            // Cell Image
            cell.imageView?.image = demonstrationDictionary[overviewArray[indexPath.section][indexPath.row]]?[0]
            cell.imageView?.isUserInteractionEnabled = true
            //
            cell.imageView?.tag = overviewArray[indexPath.section][indexPath.row]
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
            cell.textLabel?.text = NSLocalizedString(presetsArray[indexPath.section][indexPath.row], comment: "")
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
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
            sectionNumbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
            
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
            // Dismiss Table
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
        UIView.animate(withDuration: animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
        UIView.animate(withDuration: animationTime2, animations: {
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
    var imageIndex = Int()
    //
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        // Get Image
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        //
        // Get Array index
        let sender = extraTap.view as! UIImageView
        let demonstrationIndex = sender.tag
        //
        imageIndex = demonstrationIndex
        
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
        // Animation
        expandedImage.image = demonstrationDictionary[demonstrationIndex]?[0]
        expandedImage.animationImages = demonstrationDictionary[demonstrationIndex]
        expandedImage.animationDuration = Double(demonstrationDictionary[demonstrationIndex]!.count) * 0.5
        expandedImage.animationImages?.removeFirst()
        expandedImage.animationRepeatCount = 1
        // Play
        let imagePress = UITapGestureRecognizer(target: self, action: #selector(imageSequenceAnimation))
        expandedImage.addGestureRecognizer(imagePress)
        //
        
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
        UIView.animate(withDuration: animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandedImage.center.y = (height/2) * 1.5
            self.backgroundViewImage.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract image
    @IBAction func retractImage(_ sender: Any) {
        //
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        //
        UIView.animate(withDuration: animationTime2, animations: {
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
    // Play Image Sequence
    @IBAction func imageSequenceAnimation() {
        //
        if demonstrationDictionary[imageIndex]?.count != 1 {
            expandedImage.startAnimating()
        }
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
        if (segue.identifier == "stretchingSessionSegue") {
            //
            let destinationVC = segue.destination as! StretchingScreen
            
            // Ensure array in ascending order
            // Compress Arrays
            for i in presetsArrays[selectedPreset[0]][selectedPreset[1]] {
                //
                stretchingArray.append(stretchingMovementsDictionary[i]!)
                //
                breathsArray.append(breathsDictionary[i]!)
                //
                demonstrationArray.append(demonstrationDictionary[i]!)
                //
                targetAreaArray.append(targetAreaDictionary[i]!)
                //
                explanationArray.append(explanationDictionary[i]!)
            }
            //
            destinationVC.sessionArray = stretchingArray
            destinationVC.breathsArray = breathsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = 2
            //
            destinationVC.sessionTitle = presetsArray[selectedPreset[0]][selectedPreset[1]]
        }
    }
    //
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
}
