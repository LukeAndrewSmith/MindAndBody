//
//  YogaChoiceCustom.swift
//  MindAndBody
//
//  Created by Luke Smith on 15.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Yoga Choice Custom --------------------------------------------------------------------------------------
//
class YogaChoiceCustom: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //
    // Arrays -----------------------------------------------------------------------------------------------------
    //
    // Custom Arrays
    //
    var presetTexts: [String] = []
    // yogaPresetsCustom, SetsArray, RepsArray
    var emptyArrayOfArrays: [[Int]] = []
    // Selected row
    var selectedRow = Int()
    
    //
    var selectedPreset = Int()
    
    //
    var yogaArray: [String] = []
    //
    var demonstrationArray: [[UIImage]] = []
    var animationDurationArray: [Double] = []
    //
    var targetAreaArray: [UIImage] = []
    //
    var explanationArray: [String] = []
    
    //
    var breathsArray: [Int] = []
    
    
    //
    // Yoga Arrays -----------------------------------------------------------------------------------------------
    //
    // TableView Section Array
    var tableViewSectionArray: [String] =
        [
            "standing",
            "handElbow",
            "seated",
            "lying",
            "handStands"
    ]
    
    // Full Key Array
    var fullKeyArray: [[Int]] =
        [
            // Standing
            [0,
             1,
             2,
             3,
             4,
             5,
             6,
             7,
             8,
             9,
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
             20,
             21,
             22],
            // Hand/Elbows and Feet/Knees
            [23,
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
             34,
             35,
             36,
             37,
             38,
             39,
             40],
            // Seated
            [41,
             42,
             43,
             44,
             45,
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
             56,
             57],
            // Lying
            [58,
             59,
             60,
             61,
             62,
             63,
             64,
             65,
             66,
             67,
             68,
             69],
            // Hand Stands
            [70,
             71,
             72]
    ]
    
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
            32: [#imageLiteral(resourceName: "catCow"), #imageLiteral(resourceName: "catCow1"), #imageLiteral(resourceName: "catCow2"), #imageLiteral(resourceName: "catCow1"), #imageLiteral(resourceName: "catCow3"), #imageLiteral(resourceName: "catCow1")],
            33: [#imageLiteral(resourceName: "Test 2")],
            34: [#imageLiteral(resourceName: "childPose"), #imageLiteral(resourceName: "childPose1"), #imageLiteral(resourceName: "childPose2"), #imageLiteral(resourceName: "childPose3")],
            35: [#imageLiteral(resourceName: "Test 2")],
            36: [#imageLiteral(resourceName: "Test 2")],
            37: [#imageLiteral(resourceName: "bridge"), #imageLiteral(resourceName: "bridge1"), #imageLiteral(resourceName: "bridge2"), #imageLiteral(resourceName: "bridge3")],
            38: [#imageLiteral(resourceName: "upwardPlank"), #imageLiteral(resourceName: "upwardPlank1"), #imageLiteral(resourceName: "upwardPlank2"), #imageLiteral(resourceName: "upwardPlank3"), #imageLiteral(resourceName: "upwardPlank4"), #imageLiteral(resourceName: "upwardPlank5")],
            39: [#imageLiteral(resourceName: "extendedPuppy"), #imageLiteral(resourceName: "extendedPuppy1"), #imageLiteral(resourceName: "extendedPuppy2"), #imageLiteral(resourceName: "extendedPuppy3"), #imageLiteral(resourceName: "extendedPuppy4"), #imageLiteral(resourceName: "extendedPuppy5")],
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
            51: [#imageLiteral(resourceName: "vSideBend"), #imageLiteral(resourceName: "vSideBend1"), #imageLiteral(resourceName: "vSideBend2"), #imageLiteral(resourceName: "vSideBend3"), #imageLiteral(resourceName: "vSideBend4"), #imageLiteral(resourceName: "vSideBend5")],
            52: [#imageLiteral(resourceName: "halfVForwardBend"), #imageLiteral(resourceName: "halfVForwardBend1"), #imageLiteral(resourceName: "halfVForwardBend2"), #imageLiteral(resourceName: "halfVForwardBend3"), #imageLiteral(resourceName: "halfVForwardBend4"), #imageLiteral(resourceName: "halfVForwardBend5"), #imageLiteral(resourceName: "halfVForwardBend6")],
            53: [#imageLiteral(resourceName: "halfVSideBend"), #imageLiteral(resourceName: "halfVSideBend1"),
                 #imageLiteral(resourceName: "halfVSideBend2"), #imageLiteral(resourceName: "halfVSideBend3"), #imageLiteral(resourceName: "halfVSideBend4"), #imageLiteral(resourceName: "halfVSideBend5")],
            54: [#imageLiteral(resourceName: "marichi1"), #imageLiteral(resourceName: "marichi11"), #imageLiteral(resourceName: "marichi12"), #imageLiteral(resourceName: "marichi13"), #imageLiteral(resourceName: "marichi14"), #imageLiteral(resourceName: "marichi15"), #imageLiteral(resourceName: "marichi16"), #imageLiteral(resourceName: "marichi17")],
            55: [#imageLiteral(resourceName: "marichi3"), #imageLiteral(resourceName: "marichi31"), #imageLiteral(resourceName: "marichi32"), #imageLiteral(resourceName: "marichi33"), #imageLiteral(resourceName: "marichi34"), #imageLiteral(resourceName: "marichi35"), #imageLiteral(resourceName: "marichi36"), #imageLiteral(resourceName: "marichi37")],
            56: [#imageLiteral(resourceName: "Test 2")],
            // Lying
            57: [#imageLiteral(resourceName: "Test 2")],
            58: [#imageLiteral(resourceName: "Test 2")],
            59: [#imageLiteral(resourceName: "fish"), #imageLiteral(resourceName: "fish1"), #imageLiteral(resourceName: "fish2"), #imageLiteral(resourceName: "fish3"), #imageLiteral(resourceName: "fish4"), #imageLiteral(resourceName: "fish5")],
            60: [#imageLiteral(resourceName: "Test 2")],
            61: [#imageLiteral(resourceName: "lyingButterfly"), #imageLiteral(resourceName: "lyingButterfly1"), #imageLiteral(resourceName: "lyingButterfly2"), #imageLiteral(resourceName: "lyingButterfly3"), #imageLiteral(resourceName: "lyingButterfly4")],
            62: [#imageLiteral(resourceName: "Test 2")],
            63: [#imageLiteral(resourceName: "threadTheNeedle"), #imageLiteral(resourceName: "threadTheNeedle1"), #imageLiteral(resourceName: "threadTheNeedle2"), #imageLiteral(resourceName: "threadTheNeedle3"), #imageLiteral(resourceName: "threadTheNeedle4"), #imageLiteral(resourceName: "threadTheNeedle5")],
            64: [#imageLiteral(resourceName: "Test 2")],
            65: [#imageLiteral(resourceName: "plow"), #imageLiteral(resourceName: "plow1"), #imageLiteral(resourceName: "plow2"), #imageLiteral(resourceName: "plow3"), #imageLiteral(resourceName: "plow4")],
            66: [#imageLiteral(resourceName: "Test 2")],
            67: [#imageLiteral(resourceName: "Test 2")],
            68: [#imageLiteral(resourceName: "Test 2")],
            69: [#imageLiteral(resourceName: "spineRolling"), #imageLiteral(resourceName: "spineRolling1"), #imageLiteral(resourceName: "spineRolling2"), #imageLiteral(resourceName: "spineRolling3"), #imageLiteral(resourceName: "spineRolling2"), #imageLiteral(resourceName: "spineRolling4"), #imageLiteral(resourceName: "spineRolling2"), #imageLiteral(resourceName: "spineRolling3"), #imageLiteral(resourceName: "spineRolling2"), #imageLiteral(resourceName: "spineRolling4")],
            // Hand Stands
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
            32: 3.0,
            33: 0,
            34: 2.0,
            35: 0,
            36: 0,
            37: 2.0,
            38: 3.0,
            39: 3.0,
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
            51: 3.0,
            52: 3.5,
            53: 3.0,
            54: 4.0,
            55: 4.0,
            56: 0,
            // Lying
            57: 0,
            58: 0,
            59: 3.0,
            60: 0,
            61: 2.5,
            62: 0,
            63: 3.0,
            64: 0,
            65: 2.5,
            66: 0,
            67: 0,
            68: 0,
            69: 5.0,
            // Hand Stands
            70: 0,
            71: 0,
            72: 0
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
    
    
    
    //
    // Breaths/Breaths/Seconds Picker View
    //
    var breathsPickerArray: [Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99]
    
    
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
    var breathsView = UIView()
    var breathsPicker = UIPickerView()
    var okButton = UIButton()
    //
    let breathsIndicatorLabel = UILabel()
    
    
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
        presetsButton.setTitle(NSLocalizedString("customYogaPractice", comment: ""), for: .normal)
    }
    
    //
    // View did load  ---------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // Preset Yoga Sessions
        //
        let defaults = UserDefaults.standard
        // Custom
        defaults.register(defaults: ["yogaPresetsCustom" : emptyArrayOfArrays])
        defaults.register(defaults: ["yogaPresetTextsCustom" : presetTexts])
        //
        defaults.register(defaults: ["yogaBreathsCustom" : emptyArrayOfArrays])
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
        self.view.backgroundColor = colour1
        
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
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = colour2
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        presetsTableView.tableFooterView = UIView()
        // TableView Cell action items
        //
        presetsTableView.backgroundColor = colour2
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        presetsTableView.layer.cornerRadius = 5
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        
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
        movementsTableView.layer.cornerRadius = 5
        movementsTableView.layer.masksToBounds = true
        //
        // Sets Reps Selection
        // view
        breathsView.backgroundColor = colour2
        breathsView.layer.cornerRadius = 5
        breathsView.layer.masksToBounds = true
        // picker
        breathsPicker.backgroundColor = colour2
        breathsPicker.delegate = self
        breathsPicker.dataSource = self
        // ok
        okButton.backgroundColor = colour1
        okButton.setTitleColor(colour2, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        // sets
        breathsIndicatorLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        breathsIndicatorLabel.textColor = colour1
        breathsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
        //
        breathsView.addSubview(breathsPicker)
        breathsView.addSubview(okButton)
        breathsView.addSubview(breathsIndicatorLabel)
        breathsView.bringSubview(toFront: breathsIndicatorLabel)
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
        var yogaPreset = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
        //
        if customTableView.isEditing {
            beginButton.isEnabled = false
        } else {
            if selectedPreset == -1 {
                
            } else {
                if yogaPreset[selectedPreset].count == 0 {
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
        var yogaPreset = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
        //
        //
        if yogaPreset.count == 0 {
            editingButton.isEnabled = false
        } else {
            if yogaPreset[selectedPreset].count == 0 {
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
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breathsPickerArray.count
        
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        let breathsLabel = UILabel()
        // Row Label Text
        breathsLabel.text = String(breathsPickerArray[row])
        //
        breathsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
        breathsLabel.textColor = colour1
        breathsLabel.textAlignment = .center
        return breathsLabel
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
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
            return " " + NSLocalizedString("customYogaPractice", comment: "")
        //
        case customTableView:
            //
            let titleDataArray = UserDefaults.standard.object(forKey: "yogaPresetTextsCustom") as! [String]
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
            let presetsArray = UserDefaults.standard.object(forKey: "yogaPresetTextsCustom") as! [String]
            return presetsArray.count + 1
        //
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
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
            let presetsArray = UserDefaults.standard.object(forKey: "yogaPresetTextsCustom") as! [String]
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
            let customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
            //
            var customBreathsArray = defaults.object(forKey: "yogaBreathsCustom") as! [[Int]]
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
                    cell.textLabel?.text = NSLocalizedString(yogaPosesDictionary[keyIndex]!, comment: "")
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
                    cell.detailTextLabel?.text = String(breathsPickerArray[customBreathsArray[selectedPreset][indexPath.row]]) + " br."
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
            cell.textLabel?.text = NSLocalizedString(yogaPosesDictionary[keyIndex]!, comment: "")
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
            let customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
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
        var presetsArray = defaults.object(forKey: "yogaPresetTextsCustom") as! [String]
        var customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
        //
        var customBreathsArray = defaults.object(forKey: "yogaBreathsCustom") as! [[Int]]
        
        //
        switch tableView {
        case presetsTableView:
            // Add Custom Yoga
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
                var customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
                var presetTextArray = defaults.object(forKey: "yogaPresetTextsCustom") as! [String]
                //
                var customBreathsArray = defaults.object(forKey: "yogaBreathsCustom") as! [[Int]]
                // Alert and Functions
                //
                let inputTitle = NSLocalizedString("yogaInputTitle", comment: "")
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
                    defaults.set(presetTextArray, forKey: "yogaPresetTextsCustom")
                    // Add New empty array
                    customKeyArray.append([])
                    defaults.set(customKeyArray, forKey: "yogaPresetsCustom")
                    // Add new breaths arrays
                    customBreathsArray.append([])
                    defaults.set(customBreathsArray, forKey: "yogaBreathsCustom")
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
                        let presetsArray = UserDefaults.standard.object(forKey: "yogaPresetTextsCustom") as! [String]
                        //
                        let selectedIndexPath = NSIndexPath(row: presetsArray.count - 1, section: 0)
                        self.presetsTableView.selectRow(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
                        self.selectedPreset = selectedIndexPath.row
                        //
                        if self.selectedPreset == -1 {
                            self.presetsButton.setTitle(NSLocalizedString("customYogaPractice", comment: ""), for: .normal)
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
                // Select Custom Yoga
            } else {
                //
                selectedPreset = indexPath.row
                //
                let presetsArray = UserDefaults.standard.object(forKey: "yogaPresetTextsCustom") as! [String]
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
                    UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.presetsTableView.frame = CGRect(x: 30, y: 44 + UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
                        self.presetsTableView.alpha = 0
                        self.backgroundViewExpanded.alpha = 0
                        //
                        //
                        self.view.layoutIfNeeded()
                        self.editingButton.alpha = 1
                        //
                        self.customTableView.reloadData()
                        self.beginButtonEnabled()
                        self.editButtonEnabled()
                    }, completion: { finished in
                        //
                        self.presetsTableView.removeFromSuperview()
                        self.backgroundViewExpanded.removeFromSuperview()
                        //
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
                movementsTableView.alpha = 0
                UIApplication.shared.keyWindow?.insertSubview(movementsTableView, aboveSubview: view)
                let selectedCell = tableView.cellForRow(at: indexPath)
                movementsTableView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: UIScreen.main.bounds.width - 40, height: (selectedCell?.bounds.height)!)
                //
                backgroundViewExpanded.alpha = 0
                UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: movementsTableView)
                backgroundViewExpanded.frame = UIScreen.main.bounds
                // Animate table fade and size
                // Alpha
                UIView.animate(withDuration: 0.4, animations: {
                    self.movementsTableView.alpha = 1
                    //
                }, completion: nil)
                // Position
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.movementsTableView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49)
                    //
                    self.backgroundViewExpanded.alpha = 0.7
                }, completion: nil)
                //
            } else {
                    // View
                    breathsView.alpha = 0
                    UIApplication.shared.keyWindow?.insertSubview(breathsView, aboveSubview: view)
                    let selectedCell = tableView.cellForRow(at: indexPath)
                    breathsView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: UIScreen.main.bounds.width - 40, height: (selectedCell?.bounds.height)!)
                    // selected row
                    breathsPicker.selectRow(customBreathsArray[selectedPreset][indexPath.row], inComponent: 0, animated: true)
                    //
                    // picker
                    breathsPicker.frame = CGRect(x: 0, y: 0, width: breathsView.frame.size.width, height: 147)
                    // ok
                    okButton.frame = CGRect(x: 0, y: 147, width: breathsView.frame.size.width, height: 49)
                    //
                    self.breathsIndicatorLabel.frame = CGRect(x: breathsPicker.frame.size.width + 17, y: (self.breathsPicker.frame.size.height / 2) - 15, width: 100, height: 30)
                    //
                    backgroundViewExpanded.alpha = 0
                    UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: breathsView)
                    backgroundViewExpanded.frame = UIScreen.main.bounds
                    // Animate table fade and size
                    // Alpha
                    UIView.animate(withDuration: 0.4, animations: {
                        self.breathsView.alpha = 1
                        //
                    }, completion: nil)
                    // Position
                    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        //
                        self.breathsView.frame = CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: 147 + 49)
                        self.breathsView.center.y = self.view.center.y - ((UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!) / 2)
                        // picker
                        self.breathsPicker.frame = CGRect(x:0, y: 0, width: self.breathsView.frame.size.width, height: 147)
                        // ok
                        self.okButton.frame = CGRect(x: 0, y: 147, width: self.breathsView.frame.size.width, height: 49)
                        // Sets Indicator Label
                        self.breathsIndicatorLabel.frame = CGRect(x: (self.breathsPicker.frame.size.width / 2) + 17, y: (self.breathsPicker.frame.size.height / 2) - 15, width: 100, height: 30)
                        self.breathsIndicatorLabel.text = NSLocalizedString("breathsC", comment: "")
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
            defaults.set(customKeyArray, forKey: "yogaPresetsCustom")
            // reps
            customBreathsArray[selectedPreset].append(0)
            defaults.set(customBreathsArray, forKey: "yogaBreathsCustom")
            //
            defaults.synchronize()
            // Remove Table
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.movementsTableView.alpha = 0
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
                    self.customTableView.setContentOffset(CGPoint(x: 0, y: self.customTableView.contentSize.height - self.customTableView.frame.size.height), animated: true)
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
            let presetsArray = UserDefaults.standard.object(forKey: "yogaPresetTextsCustom") as! [String]
            //
            if indexPath.row < presetsArray.count {
                return true
            }
        case movementsTableView: return false
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
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
            let customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
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
        var customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
        var customBreathsArray = defaults.object(forKey: "yogaBreathsCustom") as! [[Int]]
        // Key
        let itemToMove = customKeyArray[selectedPreset].remove(at: sourceIndexPath.row)
        customKeyArray[selectedPreset].insert(itemToMove, at: destinationIndexPath.row)
        //
        defaults.set(customKeyArray, forKey: "yogaPresetsCustom")
        // Reps
        let breathToMove = customBreathsArray[selectedPreset].remove(at: sourceIndexPath.row)
        customBreathsArray[selectedPreset].insert(breathToMove, at: destinationIndexPath.row)
        //
        defaults.set(customBreathsArray, forKey: "yogaBreathsCustom")
        //
        defaults.synchronize()
    }
    
    // Target index path for move from row
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        //
        let defaults = UserDefaults.standard
        var customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
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
                var customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
                var presetTextArray = defaults.object(forKey: "yogaPresetTextsCustom") as! [String]
                //
                var customBreathsArray = defaults.object(forKey: "yogaBreathsCustom") as! [[Int]]
                //
                //
                customKeyArray.remove(at: indexPath.row)
                defaults.set(customKeyArray, forKey: "yogaPresetsCustom")
                //
                presetTextArray.remove(at: indexPath.row)
                defaults.set(presetTextArray, forKey: "yogaPresetTextsCustom")
                //
                customBreathsArray.remove(at: indexPath.row)
                defaults.set(customBreathsArray, forKey: "yogaBreathsCustom")
                //
                defaults.synchronize()
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.presetsTableView.reloadData()
                })
                //
                self.selectedPreset = self.selectedPreset - 1
                self.customTableView.reloadData()
                //
                
                //
                UIView.animate(withDuration: 0.2, animations: {
                    self.presetsTableView.reloadData()
                    //
                    if customKeyArray.count == 0 {
                        self.presetsButton.setTitle(NSLocalizedString("customYogaPractice", comment: ""), for: .normal)
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
                let defaults = UserDefaults.standard
                var customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
                var customBreathsArray = defaults.object(forKey: "yogaBreathsCustom") as! [[Int]]
                // Key
                customKeyArray[selectedPreset].remove(at: indexPath.row)
                defaults.set(customKeyArray, forKey: "yogaPresetsCustom")
                // Breaths
                customBreathsArray[selectedPreset].remove(at: indexPath.row)
                defaults.set(customBreathsArray, forKey: "yogaBreathsCustom")
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
        presetsTableView.reloadData()
        //
        presetsTableView.alpha = 0
        presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + (presetsButton.frame.size.height / 2), width: presetsButton.frame.size.width - 60, height: 0)
        presetsTableView.center.x = presetsButton.center.x
        presetsTableView.center.y = presetsButton.center.y + UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!
        //
        backgroundViewExpanded.alpha = 0
        backgroundViewExpanded.frame = UIScreen.main.bounds
        // Present
        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: presetsTableView)
        // Animate table fade and size
        // Positiona
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.presetsTableView.alpha = 1
            self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88)
            
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
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.presetsTableView.frame = CGRect(x: 30, y: self.presetsButton.frame.minY + UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
                self.presetsTableView.alpha = 0
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.movementsTableView.alpha = 0
                self.breathsView.alpha = 0
                //
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                self.movementsTableView.removeFromSuperview()
                self.breathsView.removeFromSuperview()
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
        var customBreathsArray = defaults.object(forKey: "yogaBreathsCustom") as! [[Int]]
        //
        customBreathsArray[selectedPreset][selectedRow] = breathsPicker.selectedRow(inComponent: 0)
        defaults.set(customBreathsArray, forKey: "yogaBreathsCustom")
        //
        defaults.synchronize()
        //
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.breathsView.alpha = 0
            //
            self.backgroundViewExpanded.alpha = 0
        }, completion: { finished in
            self.breathsView.removeFromSuperview()
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
        var customKeyArray = defaults.object(forKey: "yogaPresetsCustom") as! [[Int]]
        var customBreathsArray = defaults.object(forKey: "yogaBreathsCustom") as! [[Int]]
        //
        if (segue.identifier == "yogaSessionSegueCustom") {
            //
            let destinationVC = segue.destination as! YogaScreen
            
            // Compress Arrays
            for i in customKeyArray[selectedPreset] {
                //
                yogaArray.append(yogaPosesDictionary[i]!)
                //
                demonstrationArray.append(demonstrationDictionary[i]!)
                //
                explanationArray.append(explanationDictionary[i]!)
                //
                animationDurationArray.append(animationDurationDictionary[i]!)
            }
            //
            for i in customBreathsArray[selectedPreset] {
                breathsArray.append(breathsPickerArray[i])
            }
            
            //
            destinationVC.sessionArray = yogaArray
            destinationVC.breathsArray = breathsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.explanationArray = explanationArray
            //
        }
    }
    
    
    
    //
    // Walkthrough ------------------------------------------------------------------------------------------------
    ////
    //    var  viewNumber = 0
    //    let walkthroughView = UIView()
    //    let label = UILabel()
    //    let nextButton = UIButton()
    //    let backButton = UIButton()
    //
    //    // Walkthrough
    //    func walkthroughMindBody() {
    //
    //        //
    //        let screenSize = UIScreen.main.bounds
    //        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
    //        //
    //        walkthroughView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
    //        walkthroughView.backgroundColor = .black
    //        walkthroughView.alpha = 0.72
    //        walkthroughView.clipsToBounds = true
    //        //
    //        label.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
    //        label.center = view.center
    //        label.textAlignment = .center
    //        label.numberOfLines = 0
    //        label.lineBreakMode = NSLineBreakMode.byWordWrapping
    //        label.font = UIFont(name: "SFUIDisplay-light", size: 22)
    //        label.textColor = .white
    //        //
    //        nextButton.frame = screenSize
    //        nextButton.backgroundColor = .clear
    //        nextButton.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
    //        //
    //        backButton.frame = CGRect(x: 3, y: UIApplication.shared.statusBarFrame.height, width: 50, height: navigationBarHeight)
    //        backButton.setTitle("Back", for: .normal)
    //        backButton.titleLabel?.textAlignment = .left
    //        backButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
    //        backButton.titleLabel?.textColor = .white
    //        backButton.addTarget(self, action: #selector(backWalkthroughView(_:)), for: .touchUpInside)
    //
    //
    //
    //
    //        switch viewNumber {
    //        case 0:
    //            //
    //
    //
    //            // Clear Section
    //            let path = CGMutablePath()
    //            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight, width: self.view.frame.size.width, height: sessionPickerView.frame.size.height))
    //            path.addRect(screenSize)
    //            //
    //            let maskLayer = CAShapeLayer()
    //            maskLayer.backgroundColor = UIColor.black.cgColor
    //            maskLayer.path = path
    //            maskLayer.fillRule = kCAFillRuleEvenOdd
    //            //
    //            walkthroughView.layer.mask = maskLayer
    //            walkthroughView.clipsToBounds = true
    //            //
    //
    //
    //            label.text = NSLocalizedString("choiceScreen21", comment: "")
    //            walkthroughView.addSubview(label)
    //
    //
    //
    //            walkthroughView.addSubview(nextButton)
    //            self.view.addSubview(walkthroughView)
    //            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
    //            walkthroughView.bringSubview(toFront: nextButton)
    //
    //
    //
    //        //
    //        case 1:
    //            //
    //
    //
    //            // Clear Section
    //            let path = CGMutablePath()
    //            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + sessionPickerView.frame.size.height, width: self.view.frame.size.width, height: customTableView.frame.size.height))
    //            path.addRect(screenSize)
    //            //
    //            let maskLayer = CAShapeLayer()
    //            maskLayer.backgroundColor = UIColor.black.cgColor
    //            maskLayer.path = path
    //            maskLayer.fillRule = kCAFillRuleEvenOdd
    //            //
    //            walkthroughView.layer.mask = maskLayer
    //            walkthroughView.clipsToBounds = true
    //            //
    //
    //            label.center = sessionPickerView.center
    //            label.center.y = (UIApplication.shared.statusBarFrame.height/2) + sessionPickerView.frame.size.height
    //            label.text = NSLocalizedString("choiceScreen22", comment: "")
    //            walkthroughView.addSubview(label)
    //
    //
    //
    //
    //            walkthroughView.addSubview(backButton)
    //            walkthroughView.addSubview(nextButton)
    //            self.view.addSubview(walkthroughView)
    //            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
    //            walkthroughView.bringSubview(toFront: nextButton)
    //            walkthroughView.bringSubview(toFront: backButton)
    //
    //
    //        //
    //        case 2:
    //            //
    //
    //
    //            // Clear Section
    //            let path = CGMutablePath()
    //            path.addRect(CGRect(x: 0, y:   UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + sessionPickerView.frame.size.height + 24.5, width: 72 + 5, height: 72))
    //            path.addRect(screenSize)
    //            //
    //            let maskLayer = CAShapeLayer()
    //            maskLayer.backgroundColor = UIColor.black.cgColor
    //            maskLayer.path = path
    //            maskLayer.fillRule = kCAFillRuleEvenOdd
    //            //
    //            walkthroughView.layer.mask = maskLayer
    //            walkthroughView.clipsToBounds = true
    //            //
    //
    //            label.center = sessionPickerView.center
    //            label.center.y = (UIApplication.shared.statusBarFrame.height/2) + sessionPickerView.frame.size.height
    //            label.text = NSLocalizedString("choiceScreen23", comment: "")
    //            walkthroughView.addSubview(label)
    //
    //
    //
    //
    //            walkthroughView.addSubview(backButton)
    //            walkthroughView.addSubview(nextButton)
    //            self.view.addSubview(walkthroughView)
    //            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
    //            walkthroughView.bringSubview(toFront: nextButton)
    //            walkthroughView.bringSubview(toFront: backButton)
    //
    //
    //
    //
    //        //
    //        case 3:
    //            //
    //
    //
    //            // Clear Section
    //            let path = CGMutablePath()
    //            path.addEllipse(in: CGRect(x: self.view.frame.size.width - 98, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + sessionPickerView.frame.size.height, width: 98, height: 49))
    //            path.addRect(screenSize)
    //            //
    //            let maskLayer = CAShapeLayer()
    //            maskLayer.backgroundColor = UIColor.black.cgColor
    //            maskLayer.path = path
    //            maskLayer.fillRule = kCAFillRuleEvenOdd
    //            //
    //            walkthroughView.layer.mask = maskLayer
    //            walkthroughView.clipsToBounds = true
    //            //
    //            label.text = NSLocalizedString("choiceScreen24", comment: "")
    //            walkthroughView.addSubview(label)
    //
    //
    //
    //            walkthroughView.addSubview(backButton)
    //            walkthroughView.addSubview(nextButton)
    //            self.view.addSubview(walkthroughView)
    //            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
    //            walkthroughView.bringSubview(toFront: nextButton)
    //            walkthroughView.bringSubview(toFront: backButton)
    //
    //
    //        //
    //        case 4:
    //            //
    //
    //
    //            // Clear Section
    //            let path = CGMutablePath()
    //            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + sessionPickerView.frame.size.height + customTableView.frame.size.height, width: self.view.frame.size.height, height: 49))
    //            path.addRect(screenSize)
    //            //
    //            let maskLayer = CAShapeLayer()
    //            maskLayer.backgroundColor = UIColor.black.cgColor
    //            maskLayer.path = path
    //            maskLayer.fillRule = kCAFillRuleEvenOdd
    //            //
    //            walkthroughView.layer.mask = maskLayer
    //            walkthroughView.clipsToBounds = true
    //            //
    //
    //
    //            label.text = NSLocalizedString("choiceScreen25", comment: "")
    //            walkthroughView.addSubview(label)
    //
    //
    //
    //            // Picker
    //            self.sessionPickerView.selectRow(0, inComponent: 0, animated: true)
    //
    //
    //
    //            walkthroughView.addSubview(backButton)
    //            walkthroughView.addSubview(nextButton)
    //            self.view.addSubview(walkthroughView)
    //            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
    //            walkthroughView.bringSubview(toFront: nextButton)
    //            walkthroughView.bringSubview(toFront: backButton)
    //
    //
    //
    //        //
    //        case 5:
    //            //
    //
    //
    //            // Clear Section
    //            let path = CGMutablePath()
    //            path.addArc(center: CGPoint(x: view.frame.size.width * 0.917, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
    //            path.addRect(screenSize)
    //            //
    //            let maskLayer = CAShapeLayer()
    //            maskLayer.backgroundColor = UIColor.black.cgColor
    //            maskLayer.path = path
    //            maskLayer.fillRule = kCAFillRuleEvenOdd
    //            //
    //            walkthroughView.layer.mask = maskLayer
    //            walkthroughView.clipsToBounds = true
    //            //
    //
    //
    //            label.text = NSLocalizedString("choiceScreen26", comment: "")
    //            walkthroughView.addSubview(label)
    //
    //
    //
    //
    //            walkthroughView.addSubview(backButton)
    //            walkthroughView.addSubview(nextButton)
    //            self.view.addSubview(walkthroughView)
    //            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
    //            walkthroughView.bringSubview(toFront: nextButton)
    //            walkthroughView.bringSubview(toFront: backButton)
    //
    //
    //
    //        //
    //        default: break
    //
    //
    //        }
    //
    //
    //    }
    //
    //
    //
    //    func nextWalkthroughView(_ sender: Any) {
    //        walkthroughView.removeFromSuperview()
    //        viewNumber = viewNumber + 1
    //        walkthroughMindBody()
    //    }
    //
    //
    //    func backWalkthroughView(_ sender: Any) {
    //        if viewNumber > 0 {
    //            backButton.removeFromSuperview()
    //            walkthroughView.removeFromSuperview()
    //            viewNumber = viewNumber - 1
    //            walkthroughMindBody()
    //        }
    //
    //    }
    
    
    //
}
