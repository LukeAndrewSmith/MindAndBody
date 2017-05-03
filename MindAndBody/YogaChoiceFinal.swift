//
//  YogaChoiceFinal.swift
//  MindAndBody
//
//  Created by Luke Smith on 23.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Warmup Choice Class -------------------------------------------------------------------------------------------------------------
//
class YogaChoiceFinal: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Selected Yoga Type
    //
    var yogaType = Int()
    
    // Selected Preset
    //
    var selectedPreset: [Int] = [0, 0]
    
    // Section Numbers
    //
    var sectionNumbers: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    
    //
    // Arrays ------------------------------------------------------------------------------------------------------------------------------
    
    //
    // Picker View Array
    //
    
    // Arrays to be set and used (Screen arrays)
    // Pses Array
    var yogaArray: [String] = []
    
    // Breaths Array
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
        ["practices",
         "guided"]    
    
    // Yoga Poses
    let yogaPosesDictionary: [Int: String] =
        [
            // Standing
            0: "upwardsSalute",
            1: "mountain",
            2: "tree",
            3: "extendedToeGrab",
            4: "eagle",
            5: "chair",
            6: "lordOfDance",
            7: "warrior1",
            8: "warrior2",
            9: "warrior3",
            10: "halfMoon",
            11: "extendedTriangle",
            12: "extendedSideAngleY",
            13: "revolvedSideAngle",
            14: "revolvedTriangle",
            15: "halfForwardBend",
            16: "forwardBend",
            17: "wideLeggedForwardBend",
            18: "intenseSide",
            19: "gate",
            20: "highLunge",
            21: "lowLungeY",
            22: "deepSquat",
            // Hand/Elbows and Feet/Knees
            23: "dolphin",
            24: "downwardDog",
            25: "halfDownwardDog",
            26: "plank",
            27: "dolphinPlank",
            28: "fourLimbedStaff",
            29: "sidePlank",
            30: "cat",
            31: "cow",
            32: "catCow",
            33: "halfMonkey",
            34: "childPose",
            35: "wildThing",
            36: "upwardBow",
            37: "bridge",
            38: "upwardPlank",
            39: "extendedPuppy",
            40: "upwardDog",
            // Seated
            41: "crossLeg", // Pic Only
            42: "lotus", // Pic Only
            43: "fireLog",  // Pic Only
            44: "boat",
            45: "cowFace", // Pic Only
            46: "hero", // Pic Only
            47: "butterfly", // Pic Only
            48: "staffPose", // Pic Only
            49: "seatedForwardBend", // Pic Only
            50: "vForwardBend",
            51: "vSideBend",
            52: "halfVForwardBend",
            53: "halfVSideBend",
            54: "marichi1",
            55: "marichi3",
            56: "frontSplit", // Pic Only
            57: "sideSplit", // Pic Only
            // Lying
            58: "corpse",
            59: "fish",
            60: "happyBaby",
            61: "lyingButterfly",
            62: "legRaiseToe",
            63: "threadTheNeedle",
            64: "shoulderStand",
            65: "plow",
            66: "cobra",
            67: "sphinx",
            68: "pigeon",
            69: "spineRolling",
            // Hand Stands
            70: "handstand",
            71: "headstand",
            72: "forearmStand"
    ]
    
    // Explanation Dictionary
    let explanationDictionary: [Int: String] =
        [
            // Standing
            0: "upwardsSaluteE",
            1: "mountainE",
            2: "treeE",
            3: "extendedToeGrabE",
            4: "eagleE",
            5: "chairE",
            6: "lordOfDanceE",
            7: "warrior1E",
            8: "warrior2E",
            9: "warrior3E",
            10: "halfMoonE",
            11: "extendedTriangleE",
            12: "extendedSideAngleYE",
            13: "revolvedSideAngleE",
            14: "revolvedTriangleE",
            15: "halfForwardBendE",
            16: "forwardBendE",
            17: "wideLeggedForwardBendE",
            18: "intenseSideE",
            19: "gateE",
            20: "highLungeE",
            21: "lowLungeYE",
            22: "deepSquatE",
            // Hand/Elbows and Feet/Knees
            23: "dolphinE",
            24: "downwardDogE",
            25: "halfDownwardDogE",
            26: "plankE",
            27: "dolphinPlankE",
            28: "fourLimbedStaffE",
            29: "sidePlankE",
            30: "catE",
            31: "cowE",
            32: "catCowE",
            33: "halfMonkeyE",
            34: "childPoseE",
            35: "wildThingE",
            36: "upwardBowE",
            37: "bridgeE",
            38: "upwardPlankE",
            39: "extendedPuppyE",
            40: "upwardDogE",
            // Seated
            41: "crossLegE",
            42: "lotusE",
            43: "fireLogE",
            44: "boatE",
            45: "cowFaceE",
            46: "heroE",
            47: "butterflyE",
            48: "staffPoseE",
            49: "seatedForwardBendE",
            50: "vForwardBendE",
            51: "vSideBend",
            52: "halfVForwardBendE",
            53: "halfVSideBendE",
            54: "marichi1E",
            55: "marichi3E",
            56: "frontSplitE",
            57: "sideSplitE",
            // Lying
            58: "corpseE",
            59: "fishE",
            60: "happyBabyE",
            61: "lyingButterflyE",
            62: "legRaiseToeE",
            63: "threadTheNeedleE",
            64: "shoulderStandE",
            65: "plowE",
            66: "cobraE",
            67: "sphinxE",
            68: "pigeonE",
            69: "spineRollingE",
            // Hand Stands
            70: "handstandE",
            71: "headstandE",
            72: "forearmStandE"
    ]
    
    // Breaths Dictionary
    let breathsDictionary: [Int: String] =
        [
            // Standing
            0: "5",
            1: "5",
            2: "5",
            3: "5",
            4: "5",
            5: "5",
            6: "5",
            7: "5",
            8: "5",
            9: "5",
            10: "5",
            11: "5",
            12: "5",
            13: "5",
            14: "5",
            15: "5",
            16: "5",
            17: "5",
            18: "5",
            19: "5",
            20: "5",
            21: "5",
            22: "5",
            // Hand/Elbows and Feet/Knees
            23: "5",
            24: "5",
            25: "5",
            26: "5",
            27: "5",
            28: "5",
            29: "5",
            30: "5",
            31: "5",
            32: "5",
            33: "5",
            34: "5",
            35: "5",
            36: "5",
            37: "5",
            38: "5",
            39: "5",
            40: "5",
            // Seated
            41: "5",
            42: "5",
            43: "5",
            44: "5",
            45: "5",
            46: "5",
            47: "5",
            48: "5",
            49: "5",
            50: "5",
            51: "5",
            52: "5",
            53: "5",
            54: "5",
            55: "5",
            56: "5",
            // Lying
            57: "5",
            58: "5",
            59: "5",
            60: "5",
            61: "5",
            62: "5",
            63: "5",
            64: "5",
            65: "5",
            66: "5",
            67: "5",
            68: "5",
            // Hand Stands
            69: "5",
            70: "5",
            71: "5",
            72: "5"
    ]
    
    // Demonstration Poses
    let demonstrationDictionary: [Int: [UIImage]] =
        [
            // Standing
            0: [#imageLiteral(resourceName: "Test 2")],
            1: [#imageLiteral(resourceName: "Test 2")],
            2: [#imageLiteral(resourceName: "tree"), #imageLiteral(resourceName: "tree1"), #imageLiteral(resourceName: "tree2"), #imageLiteral(resourceName: "tree3"), #imageLiteral(resourceName: "tree4"), #imageLiteral(resourceName: "tree5"), #imageLiteral(resourceName: "tree6")],
            3: [#imageLiteral(resourceName: "extendedToeGrab"), #imageLiteral(resourceName: "extendedToeGrab1"), #imageLiteral(resourceName: "extendedToeGrab2"), #imageLiteral(resourceName: "extendedToeGrab3"), #imageLiteral(resourceName: "extendedToeGrab4"), #imageLiteral(resourceName: "extendedToeGrab5")],
            4: [#imageLiteral(resourceName: "eagle"), #imageLiteral(resourceName: "eagle1"), #imageLiteral(resourceName: "eagle2"), #imageLiteral(resourceName: "eagle3"), #imageLiteral(resourceName: "eagle4"), #imageLiteral(resourceName: "eagle5"), #imageLiteral(resourceName: "eagle6"), #imageLiteral(resourceName: "eagle7")],
            5: [#imageLiteral(resourceName: "chair"), #imageLiteral(resourceName: "chair1"), #imageLiteral(resourceName: "chair2"), #imageLiteral(resourceName: "chair3"), #imageLiteral(resourceName: "chair4"), #imageLiteral(resourceName: "chair5")],
            6: [#imageLiteral(resourceName: "lordOfDance"), #imageLiteral(resourceName: "lordOfDance1"), #imageLiteral(resourceName: "lordOfDance2"), #imageLiteral(resourceName: "lordOfDance3"), #imageLiteral(resourceName: "lordOfDance4"), #imageLiteral(resourceName: "lordOfDance5"), #imageLiteral(resourceName: "lordOfDance6"), #imageLiteral(resourceName: "lordOfDance7")],
            7: [#imageLiteral(resourceName: "Test 2")],
            8: [#imageLiteral(resourceName: "Test 2")],
            9: [#imageLiteral(resourceName: "warrior3"), #imageLiteral(resourceName: "warrior31"), #imageLiteral(resourceName: "warrior32"), #imageLiteral(resourceName: "warrior33"), #imageLiteral(resourceName: "warrior34"), #imageLiteral(resourceName: "warrior35"), #imageLiteral(resourceName: "warrior36")],
            10: [#imageLiteral(resourceName: "Test 2")],
            11: [#imageLiteral(resourceName: "Test 2")],
            12: [#imageLiteral(resourceName: "extendedSideAngle"), #imageLiteral(resourceName: "extendedSideAngle1"), #imageLiteral(resourceName: "extendedSideAngle2"), #imageLiteral(resourceName: "extendedSideAngle3"), #imageLiteral(resourceName: "extendedSideAngle4"), #imageLiteral(resourceName: "extendedSideAngle5"), #imageLiteral(resourceName: "extendedSideAngle6")],
            13: [#imageLiteral(resourceName: "revolvedSideAngle"), #imageLiteral(resourceName: "revolvedSideAngle1"), #imageLiteral(resourceName: "revolvedSideAngle2"), #imageLiteral(resourceName: "revolvedSideAngle3"), #imageLiteral(resourceName: "revolvedSideAngle4"), #imageLiteral(resourceName: "revolvedSideAngle5"), #imageLiteral(resourceName: "revolvedSideAngle6")],
            14: [#imageLiteral(resourceName: "revolvedTriangle"), #imageLiteral(resourceName: "revolvedTriangle1"), #imageLiteral(resourceName: "revolvedTriangle2"), #imageLiteral(resourceName: "revolvedTriangle3"), #imageLiteral(resourceName: "revolvedTriangle4"), #imageLiteral(resourceName: "revolvedTriangle5"), #imageLiteral(resourceName: "revolvedTriangle6")],
            15: [#imageLiteral(resourceName: "Test 2")],
            16: [#imageLiteral(resourceName: "Test 2")],
            17: [#imageLiteral(resourceName: "Test 2")],
            18: [#imageLiteral(resourceName: "Test 2")],
            19: [#imageLiteral(resourceName: "Test 2")],
            20: [#imageLiteral(resourceName: "Test 2")],
            21: [#imageLiteral(resourceName: "Test 2")],
            22: [#imageLiteral(resourceName: "deepSquat"), #imageLiteral(resourceName: "deepSquat1"), #imageLiteral(resourceName: "deepSquat2"), #imageLiteral(resourceName: "deepSquat3"), #imageLiteral(resourceName: "deepSquat4"), #imageLiteral(resourceName: "deepSquat5")],
            // Hand/Elbows and Feet/Knees
            23: [#imageLiteral(resourceName: "dolphin"), #imageLiteral(resourceName: "dolphin1"), #imageLiteral(resourceName: "dolphin2"), #imageLiteral(resourceName: "dolphin3")],
            24: [#imageLiteral(resourceName: "downwardDog"), #imageLiteral(resourceName: "downwardDog1"), #imageLiteral(resourceName: "downwardDog2"), #imageLiteral(resourceName: "downwardDog3"), #imageLiteral(resourceName: "downwardDog4")],
            25: [#imageLiteral(resourceName: "halfDownwardDog"), #imageLiteral(resourceName: "halfDownwardDog1"), #imageLiteral(resourceName: "halfDownwardDog2"), #imageLiteral(resourceName: "halfDownwardDog3"), #imageLiteral(resourceName: "halfDownwardDog4")],
            26: [#imageLiteral(resourceName: "Test 2")],
            27: [#imageLiteral(resourceName: "Test 2")],
            28: [#imageLiteral(resourceName: "Test 2")],
            29: [#imageLiteral(resourceName: "sidePlank"), #imageLiteral(resourceName: "sidePlank1"), #imageLiteral(resourceName: "sidePlank2"), #imageLiteral(resourceName: "sidePlank3"), #imageLiteral(resourceName: "sidePlank4")],
            30: [#imageLiteral(resourceName: "Test 2")],
            31: [#imageLiteral(resourceName: "Test 2")],
            32: [#imageLiteral(resourceName: "Test 2")],
            33: [#imageLiteral(resourceName: "Test 2")],
            34: [#imageLiteral(resourceName: "Test 2")],
            35: [#imageLiteral(resourceName: "Test 2")],
            36: [#imageLiteral(resourceName: "Test 2")],
            37: [#imageLiteral(resourceName: "Test 2")],
            38: [#imageLiteral(resourceName: "Test 2")],
            39: [#imageLiteral(resourceName: "Test 2")],
            40: [#imageLiteral(resourceName: "Test 2")],
            // Seated
            41: [#imageLiteral(resourceName: "Test 2")],
            42: [#imageLiteral(resourceName: "Test 2")],
            43: [#imageLiteral(resourceName: "Test 2")],
            44: [#imageLiteral(resourceName: "Test 2")],
            45: [#imageLiteral(resourceName: "Test 2")],
            46: [#imageLiteral(resourceName: "Test 2")],
            47: [#imageLiteral(resourceName: "Test 2")],
            48: [#imageLiteral(resourceName: "Test 2")],
            49: [#imageLiteral(resourceName: "Test 2")],
            50: [#imageLiteral(resourceName: "Test 2")],
            51: [#imageLiteral(resourceName: "Test 2")],
            52: [#imageLiteral(resourceName: "Test 2")],
            53: [#imageLiteral(resourceName: "Test 2")],
            54: [#imageLiteral(resourceName: "Test 2")],
            55: [#imageLiteral(resourceName: "Test 2")],
            56: [#imageLiteral(resourceName: "Test 2")],
            // Lying
            57: [#imageLiteral(resourceName: "Test 2")],
            58: [#imageLiteral(resourceName: "Test 2")],
            59: [#imageLiteral(resourceName: "Test 2")],
            60: [#imageLiteral(resourceName: "Test 2")],
            61: [#imageLiteral(resourceName: "Test 2")],
            62: [#imageLiteral(resourceName: "Test 2")],
            63: [#imageLiteral(resourceName: "Test 2")],
            64: [#imageLiteral(resourceName: "Test 2")],
            65: [#imageLiteral(resourceName: "Test 2")],
            66: [#imageLiteral(resourceName: "Test 2")],
            67: [#imageLiteral(resourceName: "Test 2")],
            68: [#imageLiteral(resourceName: "Test 2")],
            // Hand Stands
            69: [#imageLiteral(resourceName: "Test 2")],
            70: [#imageLiteral(resourceName: "Test 2")],
            71: [#imageLiteral(resourceName: "Test 2")],
            72: [#imageLiteral(resourceName: "Test 2")]
    ]
    
    // Demonstration Animation Duration
    let animationDurationDictionary: [Int: Double] =
        [
            // Standing
            0: 0,
            1: 0,
            2: 3.5,
            3: 3.0,
            4: 4.0,
            5: 3.0,
            6: 4.0,
            7: 0,
            8: 0,
            9: 3.5,
            10: 0,
            11: 0,
            12: 3.5,
            13: 3.5,
            14: 3.5,
            15: 0,
            16: 0,
            17: 0,
            18: 0,
            19: 0,
            20: 0,
            21: 0,
            22: 3.0,
            // Hand/Elbows and Feet/Knees
            23: 2.0,
            24: 2.5,
            25: 2.5,
            26: 0,
            27: 0,
            28: 0,
            29: 2.5,
            30: 0,
            31: 0,
            32: 0,
            33: 0,
            34: 0,
            35: 0,
            36: 0,
            37: 0,
            38: 0,
            39: 0,
            40: 0,
            // Seated
            41: 0,
            42: 0,
            43: 0,
            44: 0,
            45: 0,
            46: 0,
            47: 0,
            48: 0,
            49: 0,
            50: 0,
            51: 0,
            52: 0,
            53: 0,
            54: 0,
            55: 0,
            56: 0,
            // Lying
            57: 0,
            58: 0,
            59: 0,
            60: 0,
            61: 0,
            62: 0,
            63: 0,
            64: 0,
            65: 0,
            66: 0,
            67: 0,
            68: 0,
            // Hand Stands
            69: 0,
            70: 0,
            71: 0,
            72: 0
        ]
    
    
    // Target Area Dictionary
    let targetAreaDictionary: [Int: UIImage] =
        [
            // Standing
            0: #imageLiteral(resourceName: "Heart"),
            1: #imageLiteral(resourceName: "Heart"),
            2: #imageLiteral(resourceName: "Heart"),
            3: #imageLiteral(resourceName: "Heart"),
            4: #imageLiteral(resourceName: "Heart"),
            5: #imageLiteral(resourceName: "Heart"),
            6: #imageLiteral(resourceName: "Heart"),
            7: #imageLiteral(resourceName: "Heart"),
            8: #imageLiteral(resourceName: "Heart"),
            9: #imageLiteral(resourceName: "Heart"),
            10: #imageLiteral(resourceName: "Heart"),
            11: #imageLiteral(resourceName: "Heart"),
            12: #imageLiteral(resourceName: "Heart"),
            13: #imageLiteral(resourceName: "Heart"),
            14: #imageLiteral(resourceName: "Heart"),
            15: #imageLiteral(resourceName: "Heart"),
            16: #imageLiteral(resourceName: "Heart"),
            17: #imageLiteral(resourceName: "Heart"),
            18: #imageLiteral(resourceName: "Heart"),
            19: #imageLiteral(resourceName: "Heart"),
            20: #imageLiteral(resourceName: "Heart"),
            21: #imageLiteral(resourceName: "Heart"),
            22: #imageLiteral(resourceName: "Heart"),
            // Hand/Elbows and Feet/Knees
            23: #imageLiteral(resourceName: "Heart"),
            24: #imageLiteral(resourceName: "Heart"),
            25: #imageLiteral(resourceName: "Heart"),
            26: #imageLiteral(resourceName: "Heart"),
            27: #imageLiteral(resourceName: "Heart"),
            28: #imageLiteral(resourceName: "Heart"),
            29: #imageLiteral(resourceName: "Heart"),
            30: #imageLiteral(resourceName: "Heart"),
            31: #imageLiteral(resourceName: "Heart"),
            32: #imageLiteral(resourceName: "Heart"),
            33: #imageLiteral(resourceName: "Heart"),
            34: #imageLiteral(resourceName: "Heart"),
            35: #imageLiteral(resourceName: "Heart"),
            36: #imageLiteral(resourceName: "Heart"),
            37: #imageLiteral(resourceName: "Heart"),
            38: #imageLiteral(resourceName: "Heart"),
            39: #imageLiteral(resourceName: "Heart"),
            40: #imageLiteral(resourceName: "Heart"),
            // Seated
            41: #imageLiteral(resourceName: "Heart"),
            42: #imageLiteral(resourceName: "Heart"),
            43: #imageLiteral(resourceName: "Heart"),
            44: #imageLiteral(resourceName: "Heart"),
            45: #imageLiteral(resourceName: "Heart"),
            46: #imageLiteral(resourceName: "Heart"),
            47: #imageLiteral(resourceName: "Heart"),
            48: #imageLiteral(resourceName: "Heart"),
            49: #imageLiteral(resourceName: "Heart"),
            50: #imageLiteral(resourceName: "Heart"),
            51: #imageLiteral(resourceName: "Heart"),
            52: #imageLiteral(resourceName: "Heart"),
            53: #imageLiteral(resourceName: "Heart"),
            54: #imageLiteral(resourceName: "Heart"),
            55: #imageLiteral(resourceName: "Heart"),
            56: #imageLiteral(resourceName: "Heart"),
            // Lying
            57: #imageLiteral(resourceName: "Heart"),
            58: #imageLiteral(resourceName: "Heart"),
            59: #imageLiteral(resourceName: "Heart"),
            60: #imageLiteral(resourceName: "Heart"),
            61: #imageLiteral(resourceName: "Heart"),
            62: #imageLiteral(resourceName: "Heart"),
            63: #imageLiteral(resourceName: "Heart"),
            64: #imageLiteral(resourceName: "Heart"),
            65: #imageLiteral(resourceName: "Heart"),
            66: #imageLiteral(resourceName: "Heart"),
            67: #imageLiteral(resourceName: "Heart"),
            68: #imageLiteral(resourceName: "Heart"),
            // Hand Stands
            69: #imageLiteral(resourceName: "Heart"),
            70: #imageLiteral(resourceName: "Heart"),
            71: #imageLiteral(resourceName: "Heart"),
            72: #imageLiteral(resourceName: "Heart")
    ]
    
    
    // Practice Section Title
    let practiceSectionTitles: [String] =
            // Test
            ["test",
            // Meditation
            "yogaMeditation"]
    
    
    // Preset Arrays
    let practiceTitlesArray: [[String]] =
        [
            // Test
            // Relaxing
            ["lit", "lit", "44"],
            // Yoga Meditation
            ["lettingGo", "breathing"]
    ]
    
    // Practice Content Array
    let practiceArray: [[[Int]]] =
        [
        // 5 min
            // Relaxing
            [
                [2,3,4,5,6,9,12,13,14,22,23,24,25,29,32,34,37,38,39,51,52,53,54,55,59,61,63,65,69],
                [2,5,7,55,7,33,2],
                [3,4,4]
            ],
        // Meditation
            [
                [33,33,33],
                [66,66,66]
            ]
        ]
    
    // Selected Array
    var selectedArray: [Int] = []
    
    // Selected Title
    var selectedTitle = Int()
    
    
    
    //
    // Outlets ------------------------------------------------------------------------------------------------------------------------------
    //
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    // Movements Table View
    @IBOutlet weak var posesTableView: UITableView!
    
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
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
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
        presetsButton.setTitle(NSLocalizedString("selectPractice", comment: ""), for: .normal)
    }
    
    //
    // View did load ------------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colour
        view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString(navigationTitles[yogaType], comment: ""))
        
        //
        presetsButton.backgroundColor = colour2
        presetsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //
        posesTableView.tableFooterView = UIView()
        
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
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.posesTableView.frame.size.width, height: self.posesTableView.frame.size.height)
        //
        posesTableView.backgroundView = tableViewBackground
        
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
        case posesTableView:
            return 1
        case presetsTableView:
            return 2
        default: break
        }
        return 0
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case posesTableView:
            return " "
        case presetsTableView:
            return NSLocalizedString(practiceSectionTitles[section], comment: "")
        default: break
        }
        return ""
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        switch tableView {
        case posesTableView:
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
        case posesTableView:
            return practiceArray[selectedPreset[0]][selectedPreset[1]].count
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
        case posesTableView:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            cell.selectionStyle = .none
            //
            cell.textLabel?.text = NSLocalizedString(yogaPosesDictionary[practiceArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]]!, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            // Cell Image
            cell.imageView?.image = demonstrationDictionary[practiceArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]]?[0]
            cell.imageView?.isUserInteractionEnabled = true
            //
            cell.imageView?.tag = practiceArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]
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
            cell.textLabel?.text = "- " + NSLocalizedString(practiceTitlesArray[indexPath.section][indexPath.row], comment: "") + " -"
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
        case posesTableView:
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
        case posesTableView:
            break
        //
        case presetsTableView:
            //
            selectedPreset[0] = indexPath.section
            selectedPreset[1] = indexPath.row
            //
            
            
            presetsButton.setTitle("- " + NSLocalizedString(practiceTitlesArray[indexPath.section][indexPath.row], comment: "") + " -", for: .normal)
            presetsTableView.deselectRow(at: indexPath, animated: true)
            
            //
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsButton.frame.size.width - 60, height: 1)
                self.presetsTableView.alpha = 0
                self.backgroundViewExpanded.alpha = 0
                self.posesTableView.reloadData()
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
                if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2") == false {
                    self.walkthroughMindBody()
                    UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2")
                }
            })
            
            //
            self.tableConstraint1.constant = 73.75
            self.tableConstraint.constant = 49.75
            //
            self.presetsConstraint.constant = self.view.frame.size.height - 73.25
            //
            self.beginConstraint.constant = 0
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
            }
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
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.presetsTableView.alpha = 1
            self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88)
            self.presetsTableView.reloadData()
            //
            self.backgroundViewExpanded.alpha = 0.7
        }, completion: nil)
        //
        //        })
    }
    
    
    // Dismiss presets table
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
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
    var imageIndex = Int()
    //
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        //
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
        expandedImage.animationDuration = animationDurationDictionary[demonstrationIndex]!
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
            self.navigationItem.setHidesBackButton(false, animated: true)
        }
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
        if UserDefaults.standard.string(forKey: "presentationStyle") == "detailed" {
            performSegue(withIdentifier: "yogaSessionSegue1", sender: nil)
        } else {
            performSegue(withIdentifier: "yogaSessionSegue2", sender: nil)
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
        //
        if (segue.identifier == "yogaSessionSegue1") {
            //
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.viewControllers.first as! YogaScreen
            
            // Ensure array in ascending order
            for i in practiceArray[selectedPreset[0]][selectedPreset[1]] {
                //
                yogaArray.append(yogaPosesDictionary[i]!)
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
            destinationVC.sessionArray = yogaArray
            destinationVC.breathsArray = breathsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = 0
        //
        } else if (segue.identifier == "yogaSessionSegue2") {
//            //
//            let destinationNC = segue.destination as! UINavigationController
//            let destinationVC = destinationNC.viewControllers.first as! YogaScreenOverview
//            
//            // Ensure array in ascending order
//            // Compress Arrays
//            for i in practiceArray[selectedPreset[0]][selectedPreset[1]] {
//                //
//                yogaArray.append(yogaPosesDictionary[i]!)
//                //
//                breathsArray.append(breathsDictionary[i]!)
//                //
//                demonstrationArray.append(demonstrationDictionary[i]!)
//                //
//                targetAreaArray.append(targetAreaDictionary[i]!)
//                //
//                explanationArray.append(explanationDictionary[i]!)
//            }
//            //
//            destinationVC.sessionArray = yogaArray
//            destinationVC.breathsArray = breathsArray
//            destinationVC.demonstrationArray = demonstrationArray
//            destinationVC.targetAreaArray = targetAreaArray
//            destinationVC.explanationArray = explanationArray
//            //
//            destinationVC.sessionType = 1
//            //
//            destinationVC.sessionTitle = practiceTitlesArray[selectedPreset[0]][selectedPreset[1]]
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
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 73.5, width: self.view.frame.size.width, height: posesTableView.frame.size.height))
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
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 73.5 + posesTableView.frame.size.height, width: self.view.frame.size.width, height: 49))
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
            label.center = posesTableView.center
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
