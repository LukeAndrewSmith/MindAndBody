//
//  WarmupChoiceCustom.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 29.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Warmup Choice Custom --------------------------------------------------------------------------------------
//
class WarmupChoiceCustom: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    
//
// Arrays -----------------------------------------------------------------------------------------------------
//
    // Custom Arrays
    //
    var presetTexts: [String] = []
    // WarmupPresetsCustom, SetsArray, RepsArray
    var emptyArrayOfArrays: [[Int]] = []
    // Selected row
    var selectedRow = Int()
    
    //
    var selectedPreset = Int()
    
    //
    var warmupArray: [String] = []
    //
    var demonstrationArray: [[UIImage]] = []
    //
    var targetAreaArray: [UIImage] = []
    //
    var explanationArray: [String] = []
    
    //
    var setsArray: [Int] = []
    //
    var repsArray: [String] = []
  
    
//
// Warmup Arrays -----------------------------------------------------------------------------------------------
//
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
    
    // Target Area Dictionary
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
    
    // Explanation Dictionary
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
    // Sets Reps Picker View
    //
    var setsPickerArray: [Int] = [1, 2, 3, 4, 5, 6]
    //                              // Reps                                      Rep Range§                     // Seconds
    var repsPickerArray: [String] = ["1", "3", "5", "8", "10", "12", "15", "20", "3-5", "5-8", "8-12", "15-20", "15s", "30s", "60s", "90s"]
    
    
//
// Outlets ---------------------------------------------------------------------------------------------------------------------------
//
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    // Table View
    @IBOutlet weak var customTableView: UITableView!

    
        // Editing
        @IBOutlet weak var editingButton: UIButton!
    //
    @IBOutlet weak var presetsButton: UIButton!
    
    
    //
    // Constraints
    @IBOutlet weak var presetsConstraint: NSLayoutConstraint!
    @IBOutlet weak var editConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var tableViewConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak var beginButtonConstraint: NSLayoutConstraint!
    
    
    //
    let emptyString = ""
    
    // Presets
    var presetsTableView = UITableView()
    
    // Elements for cell actions
    //
    // Add movement
    var movementsTableView = UITableView()
    var backgroundViewExpanded = UIButton()
    
    // Sets and Reps Choice
    var setsRepsView = UIView()
    var setsRepsPicker = UIPickerView()
    var okButton = UIButton()
    //
    let setsIndicatorLabel = UILabel()
    
    
//
// Flash Screen -----------------------------------------------------------------------------------------------
//
    // Flash Screen
    func flashScreen() {
        //
        let flash = UIView()
        flash.frame = CGRect(x: 0, y: presetsButton.frame.maxY, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        flash.alpha = 0.7

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
// View Will Appear
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presetsButton.setTitle(NSLocalizedString("customWarmup", comment: ""), for: .normal)
    }
    
//
// View did load  ---------------------------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // Preset Warmups
        //
        let defaults = UserDefaults.standard
        // Custom
        defaults.register(defaults: ["warmupPresetsCustom" : emptyArrayOfArrays])
        defaults.register(defaults: ["warmupPresetTextsCustom" : presetTexts])
        //
        defaults.register(defaults: ["warmupSetsCustom" : emptyArrayOfArrays])
        defaults.register(defaults: ["warmupRepsCustom" : emptyArrayOfArrays])
        //
        defaults.synchronize()
        
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                //self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2")
        }
        
        
        // Initial Element Positions
        //
        presetsConstraint.constant = 0
        editConstraint.constant = view.frame.size.height
        //
        tableViewConstraintTop.constant = view.frame.size.height
        tableViewConstraintBottom.constant = -49
        //
        beginButtonConstraint.constant = -49
        
        
       
        // Colour
        self.view.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        //
        presetsButton.backgroundColor = colour2
        
        // Navigation Bar Title
        navigationBar.title = NSLocalizedString("custom", comment: "")

        // TableView Editing
        // Start
        editingButton.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
        
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = colour3
        beginButton.setTitleColor(colour2, for: .normal)
        

        
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
        //
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = colour1
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        presetsTableView.tableFooterView = UIView()
        

        
        // TableView
        //
        // TableView Background
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.customTableView.frame.size.width, height: self.customTableView.frame.size.height)
        //
        customTableView.backgroundView = tableViewBackground
        // TableView Cell action items
        //
        // Movement table
        movementsTableView.backgroundColor = colour2
        movementsTableView.delegate = self
        movementsTableView.dataSource = self
        movementsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        movementsTableView.layer.cornerRadius = 15
        movementsTableView.layer.masksToBounds = true
        //
        // Sets Reps Selection
        // view
        setsRepsView.backgroundColor = colour2
        setsRepsView.layer.cornerRadius = 15
        setsRepsView.layer.masksToBounds = true
        // picker
        setsRepsPicker.backgroundColor = colour2
        setsRepsPicker.delegate = self
        setsRepsPicker.dataSource = self
        // ok
        okButton.backgroundColor = colour1
        okButton.setTitleColor(colour2, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        // sets
        setsIndicatorLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        setsIndicatorLabel.textColor = colour1
        setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
        //
        setsRepsView.addSubview(setsRepsPicker)
        setsRepsView.addSubview(okButton)
        setsRepsView.addSubview(setsIndicatorLabel)
        setsRepsView.bringSubview(toFront: setsIndicatorLabel)
        //
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //
    }
    
    
//
// View did layout subviews Actions -------------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // TableView Footer
        let footerView = UIView(frame: .zero)
        footerView.backgroundColor = .clear
        customTableView.tableFooterView = footerView
        //
    }

    
//
// Elements check enabled funcs ------------------------------------------------------------------------------
//
    // Button Enabled
    func beginButtonEnabled() {
        // Begin Button
        let defaults = UserDefaults.standard
        var warmupPreset = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
        //
        if customTableView.isEditing {
            beginButton.isEnabled = false
        } else {
            if selectedPreset == -1 {
                
            } else {
                if warmupPreset[selectedPreset].count == 0 {
                    beginButton.isEnabled = false
                } else {
                    beginButton.isEnabled = true
                }
            }
        }
    }
    
    // Edit Button Enabled
    func editButtonEnabled() {
        //
        let defaults = UserDefaults.standard
        var warmupPreset = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
        //
        //
        if warmupPreset.count == 0 {
            editingButton.isEnabled = false
        } else {
            if warmupPreset[selectedPreset].count == 0 {
                editingButton.isEnabled = false
            } else {
                editingButton.isEnabled = true
            }
        }
    }
    
    
    
//
// Picker View ----------------------------------------------------------------------------------------------------
//
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return 6
        } else {
            return 16
        }
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        //
        if component == 0 {
            let setsLabel = UILabel()
            setsLabel.text = String(setsPickerArray[row])
            setsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
            setsLabel.textColor = colour1
            //
            setsLabel.textAlignment = .center
            return setsLabel
        //
        } else if component == 1 {
            //
            let repsLabel = UILabel()
            // Row Label Text
            switch row {
            //
            case 0:
                repsLabel.text = "        " + String(repsPickerArray[row]) + "  " + NSLocalizedString("rep", comment: "")
            //
            case 1:
                repsLabel.text = "         " + String(repsPickerArray[row]) + " " + NSLocalizedString("reps", comment: "")
            //
            case 2...15:
                repsLabel.text = String(repsPickerArray[row])
            //
            default: break
            }
            repsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
            repsLabel.textColor = colour1
            repsLabel.textAlignment = .center
            return repsLabel
        //
        }
        return UIView()
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Width
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        //
        if component == 0 {
            return (setsRepsPicker.frame.size.width / 3)
        } else if component == 1{
            return (setsRepsPicker.frame.size.width / 3)
        }
        return 0
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
        //
        if component == 0{
            //
            if row == 0 {
                self.setsIndicatorLabel.text = NSLocalizedString("set", comment: "")
            } else {
                self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
            }
        // Row Label
        //
        } else {
        }
    }
    
    
//
// Table View ------------------------------------------------------------------------------------------------------------
//
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {

        switch tableView {
        case presetsTableView: return 1
        case customTableView:
            return 1
        case movementsTableView:
            return tableViewSectionArray.count
        default: break
        }
    return 0
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        switch tableView {
        case presetsTableView:
            return " " + NSLocalizedString("customWarmup", comment: "")
        //
        case customTableView:
            //
            let titleDataArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
            if titleDataArray.count != 0 {
                return titleDataArray[selectedPreset]
            } else {
                return " "
            }
        //
        case movementsTableView:
            return NSLocalizedString(tableViewSectionArray[section], comment: "")
        default: break
        }
    return ""
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        switch tableView {
        case presetsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 17)!
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        case customTableView:
        let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 18)!
            header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            header.contentView.tintColor = colour1
            //
        case movementsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 18)!
            header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            header.textLabel?.adjustsFontSizeToFitWidth = true
            header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            header.contentView.tintColor = colour1
        //
        default: break
        }
        
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        switch tableView {
        case presetsTableView:
            // Retreive Preset Timers
            let presetsArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
            return presetsArray.count + 1
        //
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
            //
            if customKeyArray.count == 0 {
                return 1
            } else {
                return customKeyArray[selectedPreset].count + 1
            }
        //
        case movementsTableView:
            //
            return fullKeyArray[section].count
        //
        default: break
        }
    return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        switch tableView {
        case presetsTableView:
            var cell = UITableViewCell()
            cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            //
            // Retreive Preset Timers
            let presetsArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
            //
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = colour1
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            if indexPath.row == presetsArray.count {
                //
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
                //
            } else {
                //
                cell.textLabel?.text = presetsArray[indexPath.row]
            }
            //
            return cell
        //
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
            //
            var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
            var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
            //
            if customKeyArray.count == 0 {
                //
                let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                //
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                cell.tintColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
                //
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
                //
                return cell
            //
            } else {
                //
                if indexPath.row == customKeyArray[selectedPreset].count  {
                    //
                    let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                    //
                    cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                    cell.tintColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
                    //
                    cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                    //
                    cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                    cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
                    //
                    return cell
                //
                } else {
                    //
                    let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                    //
                    let keyIndex = customKeyArray[selectedPreset][indexPath.row]
                    cell.textLabel?.text = NSLocalizedString(warmupMovementsDictionary[keyIndex]!, comment: "")
                    //
                    cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
                    cell.textLabel?.adjustsFontSizeToFitWidth = true
                    cell.textLabel?.textAlignment = .left
                    cell.backgroundColor = colour1
                    cell.textLabel?.textColor = colour2
                    cell.tintColor = .black
                    // Detail sets x reps
                    cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
                    cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
                    cell.detailTextLabel?.textAlignment = .left
                    cell.detailTextLabel?.textColor = colour2
                    cell.detailTextLabel?.text = String(setsPickerArray[customSetsArray[selectedPreset][indexPath.row]]) + " x " + repsPickerArray[customRepsArray[selectedPreset][indexPath.row]]
                    //
                    // Cell Image
                    cell.imageView?.image = demonstrationDictionary[keyIndex]?[0]
                    cell.imageView?.isUserInteractionEnabled = true
                    // Image Tap
                    let imageTap = UITapGestureRecognizer()
                    imageTap.numberOfTapsRequired = 1
                    imageTap.addTarget(self, action: #selector(handleTap))
                    cell.imageView?.addGestureRecognizer(imageTap)
                    //
                    return cell
                }
            }
        //
        case movementsTableView:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            let keyIndex = fullKeyArray[indexPath.section][indexPath.row]
            cell.textLabel?.text = NSLocalizedString(warmupMovementsDictionary[keyIndex]!, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = .black
            cell.tintColor = .black
            // Cell Image
            cell.imageView?.image = demonstrationDictionary[keyIndex]?[0]
            cell.imageView?.isUserInteractionEnabled = true
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleTap))
            cell.imageView?.addGestureRecognizer(imageTap)
            //
            return cell
        //
        default: break
        }
    return UITableViewCell()
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch tableView {
        case presetsTableView:
            return 44
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
            //
            if customKeyArray.count == 0 {
                return 49
            //
            } else {
                //
                if indexPath.row == customKeyArray[selectedPreset].count  {
                    return 49
                //
                } else {
                    return 72
                }
            }
        case movementsTableView:
            return 72
        default: break
        }
    return 72
    }
    
    //
    var okAction = UIAlertAction()
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let defaults = UserDefaults.standard
        var presetsArray = defaults.object(forKey: "warmupPresetTextsCustom") as! [String]
        var customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
        //
        var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
        switch tableView {
        case presetsTableView:
            // Add Custom Warmup
            if indexPath.row == presetsArray.count {
                let snapShot1 = presetsTableView.snapshotView(afterScreenUpdates: false)
                snapShot1?.center.x = view.center.x
                snapShot1?.center.y = presetsTableView.center.y - UIApplication.shared.statusBarFrame.height - (navigationController?.navigationBar.frame.size.height)!
                view.addSubview(snapShot1!)
                self.presetsTableView.isHidden = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundViewExpanded.alpha = 0
                }, completion: { finished in
                    self.backgroundViewExpanded.isHidden = true
                })
                
                //
                let defaults = UserDefaults.standard
                var customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
                var presetTextArray = defaults.object(forKey: "warmupPresetTextsCustom") as! [String]
                //
                var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
                var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
                // Alert and Functions
                //
                let inputTitle = NSLocalizedString("warmupInputTitle", comment: "")
                //
                let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
                alert.view.tintColor = colour2
                alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
                //2. Add the text field
                alert.addTextField { (textField: UITextField) in
                    textField.text = " "
                    textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
                    textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
                }
                // 3. Get the value from the text field, and perform actions upon OK press
                okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    //
                    let textField = alert?.textFields![0]
                    // Update Preset Text Arrays
                    presetTextArray.append((textField?.text)!)
                    defaults.set(presetTextArray, forKey: "warmupPresetTextsCustom")
                    // Add New empty array
                    customKeyArray.append([])
                    defaults.set(customKeyArray, forKey: "warmupPresetsCustom")
                    // Add new sets and reps arrays
                    customSetsArray.append([])
                    defaults.set(customSetsArray, forKey: "warmupSetsCustom")
                    //
                    customRepsArray.append([])
                    defaults.set(customRepsArray, forKey: "warmupRepsCustom")
                    //
                    defaults.synchronize()
                    
                    
                    //
                    self.presetsTableView.isHidden = false
                    snapShot1?.removeFromSuperview()
                    //
                    self.backgroundViewExpanded.isHidden = false
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backgroundViewExpanded.alpha = 0.5
                        self.presetsTableView.reloadData()
                        // Dismiss and select new row
                    }, completion: { finished in
                        //
                        //
                        let presetsArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
                        //
                        let selectedIndexPath = NSIndexPath(row: presetsArray.count - 1, section: 0)
                        self.presetsTableView.selectRow(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
                        self.selectedPreset = selectedIndexPath.row
                        //
                        if self.selectedPreset == -1 {
                            self.presetsButton.setTitle(NSLocalizedString("customWarmup", comment: ""), for: .normal)
                        } else {
                            self.presetsButton.setTitle("- " + presetsArray[self.selectedPreset] + " -", for: .normal)
                        }
                        //
                        tableView.deselectRow(at: indexPath, animated: true)
                        // Flash Screen
                        self.customTableView.reloadData()
                        //
                        self.beginButtonEnabled()
                        self.editButtonEnabled()
                    
                        // Element Positions
                        //
                        self.presetsConstraint.constant = self.view.frame.size.height - 73.5
                        self.editConstraint.constant = 73.5
                        //
                        self.tableViewConstraintTop.constant = 122.5
                        self.tableViewConstraintBottom.constant = 49
                        //
                        self.beginButtonConstraint.constant = 0
                        //
                        UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                            //
                            self.editingButton.alpha = 1
                            self.view.layoutIfNeeded()
                        })
                        //
                        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                            self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
                            self.backgroundViewExpanded.alpha = 0
                            //
                            //
                            self.customTableView.reloadData()
                            self.beginButtonEnabled()
                            self.editButtonEnabled()
                        }, completion: { finished in
                            //
                            self.presetsTableView.removeFromSuperview()
                            self.backgroundViewExpanded.removeFromSuperview()
                        })
                    })
                })
                okAction.isEnabled = false
                alert.addAction(okAction)
                // Cancel reset action
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    //
                    self.backgroundViewExpanded.isHidden = false
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backgroundViewExpanded.alpha = 0.5
                    })
                    //
                    self.presetsTableView.isHidden = false
                    snapShot1?.removeFromSuperview()
                }
                alert.addAction(cancelAction)
                // 4. Present the alert.
                self.present(alert, animated: true, completion: nil)
                //

            
            //
            // Select Custom Warmup
            } else {
                //
                selectedPreset = indexPath.row
                //
                let presetsArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
                //
                self.presetsButton.setTitle("- " + presetsArray[self.selectedPreset] + " -", for: .normal)
                //
                tableView.deselectRow(at: indexPath, animated: true)
                // Dismiss Table
                if presetsArray.count != 0 {
                    //
                    // Element Positions
                    //
                    self.presetsConstraint.constant = self.view.frame.size.height - 73.5
                    self.editConstraint.constant = 73.5
                    //
                    self.tableViewConstraintTop.constant = 122.5
                    self.tableViewConstraintBottom.constant = 49
                    //
                    self.beginButtonConstraint.constant = 0
                    //
                    UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                        //
                        self.editingButton.alpha = 1
                        self.view.layoutIfNeeded()
                    })
                    //
                    UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                        self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
                        self.backgroundViewExpanded.alpha = 0
                        //
                        //
                        self.customTableView.reloadData()
                        self.beginButtonEnabled()
                        self.editButtonEnabled()
                    }, completion: { finished in
                        //
                        self.presetsTableView.removeFromSuperview()
                        self.backgroundViewExpanded.removeFromSuperview()
                    })
                }
                //
            }
            //
        //
        case customTableView:
            //
            selectedRow = indexPath.row
            //
                if indexPath.row == customKeyArray[selectedPreset].count {
                    //
                    let height = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49

                    UIApplication.shared.keyWindow?.insertSubview(movementsTableView, aboveSubview: view)
                    let selectedCell = tableView.cellForRow(at: indexPath)
                    movementsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: UIScreen.main.bounds.width - 20, height: height)
                    //
                    backgroundViewExpanded.alpha = 0
                    UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: movementsTableView)
                    backgroundViewExpanded.frame = UIScreen.main.bounds
                    //
                    // Animate table
                    UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        //
                        //
                        self.movementsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY - height - 10, width: UIScreen.main.bounds.width - 20, height: height)
                        //
                        self.backgroundViewExpanded.alpha = 0.7
                    }, completion: nil)
                //
                } else {
                    // View
                    UIApplication.shared.keyWindow?.insertSubview(setsRepsView, aboveSubview: view)
                    let selectedCell = tableView.cellForRow(at: indexPath)
                    setsRepsView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: UIScreen.main.bounds.width - 20, height: 147 + 49)
                    // selected row
                    setsRepsPicker.selectRow(customSetsArray[selectedPreset][indexPath.row], inComponent: 0, animated: true)
                    setsRepsPicker.selectRow(customRepsArray[selectedPreset][indexPath.row], inComponent: 1, animated: true)
                    //
                    let componentWidth = setsRepsPicker.frame.size.width / 3
                    let componentWidthFourth = componentWidth / 4
                    // picker
                    setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: setsRepsView.frame.size.width + componentWidthFourth, height: 147)
                    // ok
                    okButton.frame = CGRect(x: 0, y: 147, width: setsRepsView.frame.size.width, height: 49)
                    //
                    self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
                    //
                    backgroundViewExpanded.alpha = 0
                    UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: setsRepsView)
                    backgroundViewExpanded.frame = UIScreen.main.bounds
                    //
                    // Animate table
                    UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        //
                        self.setsRepsView.frame = CGRect(x: 10, y: self.view.frame.maxY - 147 - 49 - 10, width: UIScreen.main.bounds.width - 20, height: 147 + 49)
                        // picker
                        self.setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: self.setsRepsView.frame.size.width + componentWidthFourth, height: 147)
                        // ok
                        self.okButton.frame = CGRect(x: 0, y: 147, width: self.setsRepsView.frame.size.width, height: 49)
                        // Sets Indicator Label
                        self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
                        self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                        //
                        //
                        self.backgroundViewExpanded.alpha = 0.7
                        
                    }, completion: nil)
            }
//        }
        //
        case movementsTableView:
            //
            customKeyArray[selectedPreset].append(fullKeyArray[indexPath.section][indexPath.row])
            defaults.set(customKeyArray, forKey: "warmupPresetsCustom")
            // sets
            customSetsArray[selectedPreset].append(0)
            defaults.set(customSetsArray, forKey: "warmupSetsCustom")
            // reps
            customRepsArray[selectedPreset].append(0)
            defaults.set(customRepsArray, forKey: "warmupRepsCustom")
            //
            defaults.synchronize()
            // Remove Table
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.movementsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.movementsTableView.frame.size.width, height: self.movementsTableView.frame.size.height)
                //
                self.backgroundViewExpanded.alpha = 0
                //
                self.beginButtonEnabled()
                self.editButtonEnabled()
            //
            }, completion: { finished in
                self.movementsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
                //
                self.customTableView.reloadData()
                // Scroll to Bottom
                if self.customTableView.contentSize.height > self.customTableView.frame.size.height {
                    //
                    let scrollIndex = NSIndexPath(row: customKeyArray[self.selectedPreset].count - 1, section: 0)
                    self.customTableView.scrollToRow(at: scrollIndex as IndexPath, at: .top, animated: true)
                }
            })
        //
        default: break
        }
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Enable ok alert action func
    func textChanged(_ sender: UITextField) {
        if sender.text == "" {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    
//
// TableView Editing -----------------------------------------------------------------------------------------------------
//
    // Can edit row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        //
        switch tableView {
        case presetsTableView:
            let presetsArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
            //
            if indexPath.row < presetsArray.count {
                return true
            }
        case movementsTableView: return false
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
            //
            if customKeyArray.count == 0 {
                return false
            } else {
                if indexPath.row == customKeyArray[selectedPreset].count {
                    return false
                } else {
                    return true
                }
            }
        default: return false
        }
        return false
    }
    
    // Can move to row
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        switch tableView {
        case presetsTableView: return false
        case movementsTableView: return false
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
            //
            if customKeyArray.count == 0 {
                return false
            } else {
                if indexPath.row == customKeyArray[selectedPreset].count {
                    return false
                } else {
                    return true
                }
            }
        default: return false
        }
    }
    
    // Move row at
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //
        let defaults = UserDefaults.standard
        var customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
        var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
        // Key
        let itemToMove = customKeyArray[selectedPreset].remove(at: sourceIndexPath.row)
        customKeyArray[selectedPreset].insert(itemToMove, at: destinationIndexPath.row)
        //
        defaults.set(customKeyArray, forKey: "warmupPresetsCustom")
        // Sets
        let setToMove = customSetsArray[selectedPreset].remove(at: sourceIndexPath.row)
        customSetsArray[selectedPreset].insert(setToMove, at: destinationIndexPath.row)
        //
        defaults.set(customSetsArray, forKey: "warmupSetsCustom")
        // Reps
        let repToMove = customRepsArray[selectedPreset].remove(at: sourceIndexPath.row)
        customRepsArray[selectedPreset].insert(repToMove, at: destinationIndexPath.row)
        //
        defaults.set(customRepsArray, forKey: "warmupRepsCustom")
        //
        defaults.synchronize()
    }
    
    // Target index path for move from row
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        //
        let defaults = UserDefaults.standard
        var customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
        //
        if proposedDestinationIndexPath.row == customKeyArray[selectedPreset].count {
            return NSIndexPath(row: proposedDestinationIndexPath.row - 1, section: proposedDestinationIndexPath.section) as IndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
    
    // Delete button title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        //
        return NSLocalizedString("remove", comment: "")
    }
    
    // Commit editing style
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            switch tableView {
            case presetsTableView:
                //
                let defaults = UserDefaults.standard
                var customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
                var presetTextArray = defaults.object(forKey: "warmupPresetTextsCustom") as! [String]
                //
                var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
                var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
                
                //
                //
                customKeyArray.remove(at: self.selectedPreset)
                defaults.set(customKeyArray, forKey: "warmupPresetsCustom")
                //
                presetTextArray.remove(at: self.selectedPreset)
                defaults.set(presetTextArray, forKey: "warmupPresetTextsCustom")
                //
                customSetsArray.remove(at: self.selectedPreset)
                defaults.set(customSetsArray, forKey: "warmupSetsCustom")
                //
                customRepsArray.remove(at: self.selectedPreset)
                defaults.set(customRepsArray, forKey: "warmupRepsCustom")
                //
                defaults.synchronize()
                    
                UIView.animate(withDuration: 0.2, animations: {
                    self.presetsTableView.reloadData()
                })
                //
                self.selectedPreset = self.selectedPreset - 1
                self.customTableView.reloadData()
                self.beginButtonEnabled()
                //
                
                //
                UIView.animate(withDuration: 0.2, animations: {
                    self.presetsTableView.reloadData()
                    //
                    if customKeyArray.count == 0 {
                        self.presetsButton.setTitle(NSLocalizedString("customWarmup", comment: ""), for: .normal)
                    } else {
                        self.presetsButton.setTitle("- " + presetTextArray[self.selectedPreset] + " -", for: .normal)
                    }
                })
                   
                    
                // Initial Element Positions
                if customKeyArray.count == 0 {
                        
                self.presetsTableView.isHidden = false
                //
                self.backgroundViewExpanded.isHidden = false
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundViewExpanded.alpha = 0.5
                    self.presetsTableView.reloadData()
                    // Dismiss and select new row
                }, completion: { finished in
                    //
                    self.selectedPreset = -1
                    //
                    tableView.deselectRow(at: indexPath, animated: true)
                    //
                    
                    // Reload Data
                    self.customTableView.reloadData()
                    self.beginButtonEnabled()
                    self.editButtonEnabled()
                    //
                    self.beginButtonEnabled()
                    self.editButtonEnabled()
                        
                        // Initial Element Positions
                        //
                        self.presetsConstraint.constant = 0
                        self.editConstraint.constant = self.view.frame.size.height
                        //
                        self.tableViewConstraintTop.constant = self.view.frame.size.height
                        self.tableViewConstraintBottom.constant = -49
                        //
                        self.beginButtonConstraint.constant = -49
                        //
                        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            //
                            self.view.layoutIfNeeded()
                            self.editingButton.alpha = 1
                            //
                            self.presetsTableView.frame = CGRect(x: 30, y: self.presetsButton.frame.minY + UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
                            self.presetsTableView.alpha = 0
                            self.backgroundViewExpanded.alpha = 0
                        }, completion: { finished in
                            //
                            self.presetsTableView.removeFromSuperview()
                            self.backgroundViewExpanded.removeFromSuperview()
                        })
                    })
                }
                //
            case customTableView:
                //
                let defaults = UserDefaults.standard
                var customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
                var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
                var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
                // Key
                customKeyArray[selectedPreset].remove(at: indexPath.row)
                defaults.set(customKeyArray, forKey: "warmupPresetsCustom")
                // sets
                customSetsArray[selectedPreset].remove(at: indexPath.row)
                defaults.set(customSetsArray, forKey: "warmupSetsCustom")
                // reps
                customRepsArray[selectedPreset].remove(at: indexPath.row)
                defaults.set(customRepsArray, forKey: "warmupRepsCustom")
                //
                defaults.synchronize()
                //
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            default: break
            }
        }
    }
    
    
//
// Table view related button actions ------------------------------------------------------------------------------------------------
//
    // Prests
    @IBAction func presetsAction(_ sender: Any) {
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
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
            self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY - tableHeight - 10, width: tableWidth, height: tableHeight)
            self.presetsTableView.reloadData()
            //
            self.backgroundViewExpanded.alpha = 0.5
        }, completion: nil)
        //
    }
    
    
    // Add movement table background (dismiss table)
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        if (UIApplication.shared.keyWindow?.subviews.contains(self.presetsTableView))! {
            //
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
        } else {
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.movementsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.movementsTableView.frame.size.width, height: self.movementsTableView.frame.size.height)
                self.setsRepsView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.setsRepsView.frame.size.width, height: self.setsRepsView.frame.size.height)
                //
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                self.movementsTableView.removeFromSuperview()
                self.setsRepsView.removeFromSuperview()
                //
                self.backgroundViewExpanded.removeFromSuperview()
            })
        }
    }
    
    
    // Edit Tableview
    //
    @IBAction func editingAction(_ sender: Any) {
        //
        if customTableView.isEditing {
            self.customTableView.setEditing(false, animated: true)
            self.editingButton.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
            //
            self.beginButtonEnabled()
        //
        } else {
            self.customTableView.setEditing(true, animated: true)
            self.editingButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
            //
            self.beginButtonEnabled()
        }
    }
   
    
//
// Picker Related actions ------------------------------------------------------------------------------------------------
//
    // Ok button action
    func okButtonAction(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
        //
        customSetsArray[selectedPreset][selectedRow] = setsRepsPicker.selectedRow(inComponent: 0)
        defaults.set(customSetsArray, forKey: "warmupSetsCustom")
        //
        customRepsArray[selectedPreset][selectedRow] = setsRepsPicker.selectedRow(inComponent: 1)
        defaults.set(customRepsArray, forKey: "warmupRepsCustom")
        //
        defaults.synchronize()
        //
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            self.setsRepsView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.setsRepsView.frame.size.width, height: self.setsRepsView.frame.size.height)
            //
            self.backgroundViewExpanded.alpha = 0
        }, completion: { finished in
            self.setsRepsView.removeFromSuperview()
            //
            self.backgroundViewExpanded.removeFromSuperview()
        })
        //
        customTableView.reloadData()
    }
    
    
//
// Expand/Retract Image ------------------------------------------------------------------------------------------------
//
    // Expand Image
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
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandedImage.center.y = (height/2) * 1.5
            self.backgroundViewImage.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract image
    @IBAction func retractImage(_ sender: Any) {
        //
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        //
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
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
// Begin Button ------------------------------------------------------------------------------------------------
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
// Pass Arrays ------------------------------------------------------------------------------------------------
//
    // Pass Array to next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        let defaults = UserDefaults.standard
        //
        var customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
        //
        var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
        //
        let titleDataArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]

        
        if (segue.identifier == "warmupSessionSegueCustom") {
            //
            let destinationVC = segue.destination as! SessionScreen
            
            // Compress Arrays
            for i in customKeyArray[selectedPreset] {
                //
                warmupArray.append(warmupMovementsDictionary[i]!)
                //
                //demonstrationArray.append(demonstrationDictionary[i]!)
                //
                targetAreaArray.append(targetAreaDictionary[i]!)
                //
                explanationArray.append(explanationDictionary[i]!)
            }
            //
            for i in customSetsArray[selectedPreset] {
                setsArray.append(setsPickerArray[i])
            }
            //
            for i in 0...11 {
                if i == 0 {
                   repsPickerArray[i] = repsPickerArray[i] + " rep"
                } else {
                    repsPickerArray[i] = repsPickerArray[i] + " reps"
                }
            }
            //
            for i in customRepsArray[selectedPreset] {
                repsArray.append(repsPickerArray[i])
            }
            
            //
            destinationVC.sessionArray = warmupArray
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            //destinationVC.demonstrationArray = demonstrationArray
            //destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = 0
            //
            destinationVC.sessionTitle = titleDataArray[selectedPreset]
        }
    }
 
    
//
}
