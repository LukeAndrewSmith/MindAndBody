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
    
    // Arrays to be set and used (Screen arrays)
    // Movements Array
    var warmupArray: [String] = []
    
    // Sets Array
    var setsArray: [Int] = []
    
    // Reps Array
    var repsArray: [String] = []
    
    // Demonstration Array
    var demonstrationArray: [UIImage] = []
    
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
            "lowerBack",
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
             18],
            // Lower Back
            [19,
             20,
             21,
             22,
             23],
            // Shoulder
            [24,
             25,
             26,
             27],
            // Band/Bar/Machine Assisted
            [28,
             29,
             30,
             31,
             32,
             33],
            // General Mobility
            [34,
             35,
             36,
             37,
             38,
             39,
             40,
             41,
             42,
             43,
             44],
            // Dynamic Warmup Drills
            [45,
             46,
             47,
             48,
             49,
             50,
             51,
             52,
             53],
            // Accessory
            [54,
             55,
             56,
             57]
    ]
    
    // Warmup Movements Dictionary
    var warmupMovementsDictionary: [Int : String] =
        [
            // Cardio
            0: "5minCardio",
            // Joint Rotations
            1: "wrist",
            2: "elbow",
            3: "shoulder",
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
            // Lower Back
            19: "sideLegDrop",
            20: "sideLegKick",
            21: "scorpionKick",
            22: "sideBend",
            23: "catCow",
            // Shoulder
            24: "wallSlides",
            25: "superManShoulder",
            26: "scapula",
            27: "shoulderRotation",
            // Band/Bar/Machine Assisted
            28: "facePull",
            29: "externalRotation",
            30: "internalRotation",
            31: "shoulderDislocation",
            32: "rearDeltFly",
            33: "latPullover",
            // General Mobility
            34: "rollBack",
            35: "hipCircles",
            36: "mountainClimber",
            37: "groinStretch",
            38: "gluteBridge",
            39: "threadTheNeedle",
            40: "butterflyPose",
            41: "cossakSquat",
            42: "hipHinges",
            43: "sideLegSwings",
            44: "frontLegSwings",
            // Dynamic Warmup Drills
            45: "jumpSquat",
            46: "lunge",
            47: "gluteKicks",
            48: "aSkips",
            49: "bSkips",
            50: "grapeVines",
            51: "lateralBound",
            52: "straightLegBound",
            53: "sprints",
            // Accessory
            54: "latStretch",
            55: "calveStretch",
            56: "pushUp",
            57: "pullUp"
    ]
    
    // Demonstration Array
    var demonstrationDictionary: [Int : UIImage] =
        [
            // Cardio
            0: #imageLiteral(resourceName: "Test 2"),
            // Joint Rotations
            1: #imageLiteral(resourceName: "Test 2"),
            2: #imageLiteral(resourceName: "Test 2"),
            3: #imageLiteral(resourceName: "Test 2"),
            4: #imageLiteral(resourceName: "Test 2"),
            5: #imageLiteral(resourceName: "Test 2"),
            6: #imageLiteral(resourceName: "Test 2"),
            7: #imageLiteral(resourceName: "Test 2"),
            8: #imageLiteral(resourceName: "Test 2"),
            // Foam/Ball Roll
            9: #imageLiteral(resourceName: "Test 2"),
            10: #imageLiteral(resourceName: "Test 2"),
            11: #imageLiteral(resourceName: "Test 2"),
            12: #imageLiteral(resourceName: "Test 2"),
            13: #imageLiteral(resourceName: "Test 2"),
            14: #imageLiteral(resourceName: "Test 2"),
            15: #imageLiteral(resourceName: "Test 2"),
            16: #imageLiteral(resourceName: "Test 2"),
            17: #imageLiteral(resourceName: "Test 2"),
            18: #imageLiteral(resourceName: "Test 2"),
            // Lower Back
            19: #imageLiteral(resourceName: "Test 2"),
            20: #imageLiteral(resourceName: "Test 2"),
            21: #imageLiteral(resourceName: "Test 2"),
            22: #imageLiteral(resourceName: "Test 2"),
            23: #imageLiteral(resourceName: "Test 2"),
            // Shoulder
            24: #imageLiteral(resourceName: "Test 2"),
            25: #imageLiteral(resourceName: "Test 2"),
            26: #imageLiteral(resourceName: "Test 2"),
            27: #imageLiteral(resourceName: "Test 2"),
            // Band/Bar/Machine Assisted
            28: #imageLiteral(resourceName: "Test 2"),
            29: #imageLiteral(resourceName: "Test 2"),
            30: #imageLiteral(resourceName: "Test 2"),
            31: #imageLiteral(resourceName: "Test 2"),
            32: #imageLiteral(resourceName: "Test 2"),
            33: #imageLiteral(resourceName: "Test 2"),
            // General Mobility
            34: #imageLiteral(resourceName: "Test 2"),
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
            // Dynamic Warm Up Drills
            45: #imageLiteral(resourceName: "Test 2"),
            46: #imageLiteral(resourceName: "Test 2"),
            47: #imageLiteral(resourceName: "Test 2"),
            48: #imageLiteral(resourceName: "Test 2"),
            49: #imageLiteral(resourceName: "Test 2"),
            50: #imageLiteral(resourceName: "Test 2"),
            51: #imageLiteral(resourceName: "Test 2"),
            52: #imageLiteral(resourceName: "Test 2"),
            53: #imageLiteral(resourceName: "Test 2"),
            // Accessory
            54: #imageLiteral(resourceName: "Test 2"),
            55: #imageLiteral(resourceName: "Test 2"),
            56: #imageLiteral(resourceName: "Test 2"),
            57: #imageLiteral(resourceName: "Test 2")
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
            // Lower Back
            19: #imageLiteral(resourceName: "Core"),
            20: #imageLiteral(resourceName: "Core"),
            21: #imageLiteral(resourceName: "Core"),
            22: #imageLiteral(resourceName: "Core"),
            23: #imageLiteral(resourceName: "Spine"),
            // Shoulder
            24: #imageLiteral(resourceName: "Shoulder"),
            25: #imageLiteral(resourceName: "Back and Shoulder"),
            26: #imageLiteral(resourceName: "Serratus"),
            27: #imageLiteral(resourceName: "Shoulder"),
            // Band/Bar/Machine Assisted
            28: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            29: #imageLiteral(resourceName: "Rear Delt"),
            30: #imageLiteral(resourceName: "Rear Delt"),
            31: #imageLiteral(resourceName: "Shoulder"),
            32: #imageLiteral(resourceName: "Rear Delt"),
            33: #imageLiteral(resourceName: "Back"),
            // General Mobility
            34: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            35: #imageLiteral(resourceName: "Hip Area"),
            36: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            37: #imageLiteral(resourceName: "Adductor"),
            38: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            39: #imageLiteral(resourceName: "Piriformis"),
            40: #imageLiteral(resourceName: "Adductor"),
            41: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            42: #imageLiteral(resourceName: "Hamstring and Glute"),
            43: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            44: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            // Dynamic Warm Up Drills
            45: #imageLiteral(resourceName: "Squat"),
            46: #imageLiteral(resourceName: "Squat"),
            47: #imageLiteral(resourceName: "Squat"),
            48: #imageLiteral(resourceName: "Squat"),
            49: #imageLiteral(resourceName: "Squat"),
            50: #imageLiteral(resourceName: "Squat"),
            51: #imageLiteral(resourceName: "Squat"),
            52: #imageLiteral(resourceName: "Squat"),
            53: #imageLiteral(resourceName: "Squat"),
            // Accessory
            54: #imageLiteral(resourceName: "Lat"),
            55: #imageLiteral(resourceName: "Calf"),
            56: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            57: #imageLiteral(resourceName: "Back and Bicep")
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
            // Back
            19: "sideLegDropE",
            20: "sideLegKickE",
            21: "scorpionKickE",
            22: "sideBendE",
            23: "catCowE",
            // Shoulder
            24: "wallSlidesE",
            25: "superManShoulderE",
            26: "scapulaE",
            27: "shoulderRotationE",
            // Band/Bar/Machine Assisted
            28: "facePullE",
            29: "externalRotationE",
            30: "internalRotationE",
            31: "shoulderDislocationE",
            32: "rearDeltFlyE",
            33: "latPulloverE",
            // General Mobility
            34: "rollBackE",
            35: "hipCirclesE",
            36: "mountainClimberE",
            37: "groinStretchE",
            38: "gluteBridgeE",
            39: "threadTheNeedleE",
            40: "butterflyPoseE",
            41: "cossakSquatE",
            42: "hipHingesE",
            43: "sideLegSwingsE",
            44: "frontLegSwingsE",
            // Dynamic Warm Up Drills
            45: "jumpSquatE",
            46: "lungeE",
            47: "gluteKicksE",
            48: "aSkipsE",
            49: "bSkipsE",
            50: "grapeVinesE",
            51: "lateralBoundE",
            52: "straightLegBoundE",
            53: "sprintsE",
            // Accessory
            54: "latStretchE",
            55: "calveStretchE",
            56: "pushUpE",
            57: "pullUpE"
    ]

    // Sets Dictionary
    var setsDictionary: [Int : Int] =
        [
            // Cardio
            0: 1,
            // Joint Rotations
            1: 1,
            2: 1,
            3: 1,
            4: 1,
            5: 1,
            6: 1,
            7: 1,
            8: 1,
            // Foam/Ball Roll
            9: 1,
            10: 3,
            11: 1,
            12: 1,
            13: 1,
            14: 1,
            15: 1,
            16: 1,
            17: 1,
            18: 1,
            // Lower Back
            19: 1,
            20: 1,
            21: 1,
            22: 1,
            23: 1,
            // Shoulder
            24: 2,
            25: 1,
            26: 1,
            27: 1,
            // Band/Bar/Machine Assisted
            28: 2,
            29: 1,
            30: 1,
            31: 1,
            32: 1,
            33: 1,
            // General Mobility
            34: 1,
            35: 1,
            36: 1,
            37: 1,
            38: 1,
            39: 2,
            40: 1,
            41: 1,
            42: 2,
            43: 1,
            44: 1,
            // Dynamic Warm Up Drills
            45: 2,
            46: 2,
            47: 3,
            48: 3,
            49: 3,
            50: 2,
            51: 2,
            52: 2,
            53: 4,
            // Accessory
            54: 1,
            55: 1,
            56: 1,
            57: 1
    ]
    
    // Reps Array
    var repsDictionary: [Int : String] =
        [
            // Mandatory
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
            // Lower Back
            19: "5-10 reps",
            20: "5-10 reps",
            21: "5-10 reps",
            22: "5-10 reps",
            23: "15-20 reps",
            // Shoulder
            24: "10-20 reps",
            25: "5-10 reps",
            26: "15 reps",
            27: "10 reps",
            // Band/Bar/Machine Assisted
            28: "10-15 reps",
            29: "5-15 reps",
            30: "5-10 reps",
            31: "5-10 reps",
            32: "10-15 reps",
            33: "10-20 reps",
            // General Mobility
            34: "10-15 reps",
            35: "5-10 reps",
            36: "5-10 reps",
            37: "5-10 reps",
            38: "10-15 reps",
            39: "15-30s",
            40: "15-30s",
            41: "5-10 reps",
            42: "10-20 reps",
            43: "10-20 reps",
            44: "10-20 reps",
            // Dynamic Warm Up Drills
            45: "5-15 reps",
            46: "10-15 reps",
            47: "15-30s",
            48: "15-30s",
            49: "15-30s",
            50: "50m",
            51: "50m",
            52: "50m",
            53: "5-20 reps",
            // Accessory
            54 :"15-30s",
            55: "15-30s",
            56: NSLocalizedString("asNecessary", comment: ""),
            57: NSLocalizedString("asNecessary", comment: "")
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
                [0, 10, 15, 19, 24, 25, 27, 30, 31, 32],
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
    
    
    // Set Arrays Function
    func setArrays() {
        //
        switch warmupType {
        //
        case 0:
            // Choice Screen Arrays
            presetsArray = presetsArrayFull
            presetsArrays = presetsArraysFull
        //
        case 1:
            // Choice Screen Arrays
            presetsArray = presetsArrayUpper
            presetsArrays = presetsArraysUpper
        //
        case 2:
            // Choice Screen Arrays
            presetsArray = presetsArrayLower
            presetsArrays = presetsArraysLower
        //
        case 3:
            // Choice Screen Arrays
            presetsArray = presetsArrayCardio
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
        presetsTableView.layer.cornerRadius = 5
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        switch tableView {
        case movementsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 18)!
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        case presetsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 18)!
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
            // Cell Image
            cell.imageView?.image = demonstrationDictionary[overviewArray[indexPath.section][indexPath.row]]
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
            sectionNumbers = [0, 1, 2, 3, 4, 5, 6, 7, 8]
            
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
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsButton.frame.size.width - 60, height: 1)
                self.presetsTableView.alpha = 0
                self.backgroundViewExpanded.alpha = 0
                self.movementsTableView.reloadData()
                //
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
        presetsTableView.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
        presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + (presetsButton.frame.size.height / 2), width: presetsButton.frame.size.width - 60, height: 0)
        //presetsTableView.frame = presetsButton.bounds
        presetsTableView.center.x = presetsButton.center.x
        presetsTableView.center.y = presetsButton.center.y + UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!
        //
        backgroundViewExpanded.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: presetsTableView)
        backgroundViewExpanded.frame = UIScreen.main.bounds
        // Animate table fade and size
        // Position
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.presetsTableView.alpha = 1
            self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88)
            self.presetsTableView.reloadData()
                //
            self.backgroundViewExpanded.alpha = 0.7
        }, completion: nil)
        //
    }
    
    
    // Dismiss presets table
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsButton.frame.size.width - 60, height: 0)
            self.presetsTableView.alpha = 0
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
            for i in presetsArrays[selectedPreset[0]][selectedPreset[1]] {
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
            // Compress Arrays
            for i in presetsArrays[selectedPreset[0]][selectedPreset[1]] {
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
