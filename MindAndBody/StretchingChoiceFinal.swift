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
            // Back
            21: ["catCowS", "catCowS1", "catCowS2", "catCowS1", "catCowS3", "catCowS1", "catCowS2", "catCowS1"],
            22: ["upwardsDogS"],
            23: ["extendedPuppyS"],
            24: ["childPoseS"],
            25: ["staffPoseS"],
            26: ["pelvicTilt", "pelvicTilt1", "pelvicTilt", "pelvicTilt1", "pelvicTilt", "pelvicTilt1", "pelvicTilt"],
            27: ["kneeToChest"],
            28: ["legDrop", "legDrop1", "legDrop2", "legDrop1", "legDrop", "legDrop1", "legDrop2", "legDrop1"],
            29: ["seatedTwist"],
            30: ["legsWall"],
            // Obliques(Sides)
            31: ["sideLean"],
            32: ["extendedSideAngleS"],
            33: ["seatedSide"],
            // Neck
            34: ["rearNeckStretch"],
            35: ["rearNeckHand"],
            36: ["seatedLateral"],
            37: ["neckRotatorStretch"],
            38: ["scalene"],
            39: ["headRoll"],
            // Arms
            40: ["forearmStretch"],
            41: ["tricepStretch"],
            42: ["bicepStretch"],
            // Pecs
            43: ["pecStretch"],
            // Shoulders
            44: ["shoulderRoll", "shoulderRoll1", "shoulderRoll2", "shoulderRoll3", "shoulderRoll", "shoulderRoll1", "shoulderRoll2", "shoulderRoll3"],
            45: ["behindBackTouch"],
            46: ["frontDeltStretch"],
            47: ["lateralDeltStretch"],
            48: ["rearDeltStretch"],
            49: ["rotatorCuff"],
            // Hips and Glutes
            50: ["squatHold"],
            51: ["groinStretch"],
            52: ["butterflyPoseS"],
            53: ["lungeStretch"],
            54: ["threadTheNeedleS"],
            55: ["pigeonPoseS"],
            56: ["seatedGlute"],
            // Calves
            57: ["calveStretch"],
            // Hamstrings
            58: ["standingHamstring"],
            59: ["standingSingleLegHamstring"],
            60: ["downWardsDogS"],
            61: ["singleLegHamstring"],
            62: ["twoLegHamstring"],
            // Quads
            63: ["lungeStretchWall"],
            64: ["quadStretch"],
            // Full Body
            65: ["sumoSquatTwist"],
            66: ["tinyFencerStretch"]
    ]
    
    // Target Area Array
    var targetAreaDictionary: [Int : String] =
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
            // Back
            21: "spine",
            22: "spineCore",
            23: "spine",
            24: "spine",
            25: "hamstringLowerBack",
            26: "core",
            27: "spine",
            28: "core",
            29: "core",
            30: "hamstringLowerBack",
            // Obliques(Sides)
            31: "oblique",
            32: "oblique",
            33: "oblique",
            // Neck
            34: "rearNeck",
            35: "rearNeck",
            36: "lateralNeck",
            37: "neckRotator",
            38: "neckRotator",
            39: "neck",
            // Arms
            40: "forearm",
            41: "tricep",
            42: "bicep",
            // Pecs
            43: "pec",
            // Shoulders
            44: "shoulderJoint",
            45: "shoulderJoint",
            46: "frontDelt",
            47: "lateralNeck",
            48: "rearDelt",
            49: "rearDelt",
            // Hips and Glutes
            50: "hip",
            51: "adductor",
            52: "adductor",
            53: "hipArea",
            54: "piriformis",
            55: "glute",
            56: "glute",
            // Calves
            57: "calf",
            // Hamstrings
            58: "hamstring",
            59: "hamstring",
            60: "hamstring",
            61: "hamstring",
            62: "hamstring",
            // Quads
            63: "quad",
            64: "quad",
            // Full Body
            65: "squatBody",
            66: "squatBody"
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Select
        self.presetsButton.sendActions(for: .touchUpInside)
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
            cell.imageView?.image = getUncachedImage(named: (demonstrationDictionary[overviewArray[indexPath.section][indexPath.row]]?[0])!)
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
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: tableWidth, height: tableHeight)
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
            // Animate new elements up
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
    var imageIndex = Int()
    //
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        //
        // Get Array index
        let sender = extraTap.view as! UIImageView
        let demonstrationIndex = sender.tag
        imageIndex = demonstrationIndex
        expandedImage.image = getUncachedImage(named: (demonstrationDictionary[imageIndex]?[0])!)
        //
        // Animation
        if demonstrationDictionary[imageIndex]?.count != 1 {
            var animationArray: [UIImage] = []
            for i in 1...(demonstrationDictionary[imageIndex]?.count)! - 1 {
                animationArray.append(getUncachedImage(named: (demonstrationDictionary[imageIndex]?[i])!)!)
            }
            //
            expandedImage.animationImages = animationArray
            expandedImage.animationDuration = Double(demonstrationDictionary[imageIndex]!.count - 1) * 0.5
            expandedImage.animationRepeatCount = 1
            // Play
            let imagePress = UITapGestureRecognizer(target: self, action: #selector(imageSequenceAnimation))
            expandedImage.addGestureRecognizer(imagePress)
            //
            // Animate
            backgroundViewImage.addTarget(self, action: #selector(retractImage(_:)), for: .touchUpInside)
        }
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
    // Play Image Sequence
    @IBAction func imageSequenceAnimation() {
        //
        if expandedImage.isAnimating == false {
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
