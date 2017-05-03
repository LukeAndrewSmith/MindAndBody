//
//  StretchingChoiceCustom.swift
//  MindAndBody
//
//  Created by Luke Smith on 18.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Stretching Choice Custom --------------------------------------------------------------------------------------
//
class StretchingChoiceCustom: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //
    // Arrays -----------------------------------------------------------------------------------------------------
    //
    // Custom Arrays
    //
    var presetTexts: [String] = []
    // stretchingPresetsCustom, SetsArray, RepsArray
    var emptyArrayOfArrays: [[Int]] = []
    // Selected row
    var selectedRow = Int()
    
    //
    var stretchingArray: [String] = []
    //
    var demonstrationArray: [UIImage] = []
    //
    var targetAreaArray: [UIImage] = []
    //
    var explanationArray: [String] = []
    
    //
    var setsArray: [Int] = []
    //
    var repsArray: [String] = []
    
    
    //
    // Stretching Arrays -----------------------------------------------------------------------------------------------
    //
    // Table View Section Title Array
    var tableViewSectionArray: [String] =
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
             18],
            // Back
            [19,
             20,
             21,
             22,
             23,
             24,
             25,
             26,
             27,
             28],
            // Obliques(Sides)
            [29,
             30,
             31],
            // Neck
            [32,
             33,
             34,
             35,
             36,
             37],
            // Arms
            [38,
             39,
             40],
            // Pecs
            [41],
            // Shoulders
            [42,
             43,
             44,
             45,
             46,
             47],
            // Hips and Glutes
            [48,
             49,
             50,
             51,
             52,
             53,
             54],
            // Calves
            [55],
            // Hamstrings
            [56,
             57,
             58,
             59,
             60,
             61],
            // Quads
            [62,
             63]
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
            // Back
            19: "catCow",
            20: "upwardsDog",
            21: "extendedPuppy",
            22: "childPose",
            23: "staffPose",
            24: "pelvicTilt",
            25: "kneeToChest",
            26: "legDrop",
            27: "seatedTwist",
            28: "legsWall",
            // Obliques(Sides)
            29: "sideLean",
            30: "extendedSideAngle",
            31: "seatedSide",
            // Neck
            32: "rearNeck",
            33: "rearNeckHand",
            34: "seatedLateral",
            35: "neckRotator",
            36: "scalene",
            37: "headRoll",
            // Arms
            38: "forearmStretch",
            39: "tricepStretch",
            40: "bicepStretch",
            // Pecs
            41: "pecStretch",
            // Shoulders
            42: "shoulderRoll",
            43: "behindBackTouch",
            44: "frontDelt",
            45: "lateralDelt",
            46: "rearDelt",
            47: "rotatorCuff",
            // Hips and Glutes
            48: "squatHold",
            49: "groinStretch",
            50: "butterflyPose",
            51: "lungeStretch",
            52: "threadTheNeedle",
            53: "pigeonPose",
            54: "seatedGlute",
            // Calves
            55: "calveStretch",
            // Hamstrings
            56: "standingHamstring",
            57: "standingOneLegHamstring",
            58: "singleLegStanding",
            59: "downWardsDog",
            60: "singleLegHamstring",
            61: "twoLegHamstring",
            // Quads
            62: "lungeStretchWall",
            63: "QuadStretch"
    ]
    
    // Screen Arrays
    //
    var setsDictionary: [Int : Int] =
        [
            // Recommended
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
            // Back
            19: 1,
            20: 1,
            21: 1,
            22: 1,
            23: 1,
            24: 1,
            25: 1,
            26: 1,
            27: 1,
            28: 1,
            // Obliques(Sides)
            29: 1,
            30: 1,
            31: 1,
            // Neck
            32: 1,
            33: 2,
            34: 1,
            35: 1,
            36: 1,
            37: 1,
            // Arms
            38: 1,
            39: 1,
            40: 1,
            // Pecs
            41: 1,
            // Shoulders
            42: 1,
            43: 1,
            44: 1,
            45: 1,
            46: 1,
            47: 1,
            // Hips and Glutes
            48: 2,
            49: 1,
            50: 1,
            51: 1,
            52: 1,
            53: 1,
            54: 1,
            // Calves
            55: 1,
            // Hamstrings
            56: 3,
            57: 3,
            58: 1,
            59: 1,
            60: 1,
            61: 1,
            // Quads
            62: 1,
            63: 1
    ]
    
    // Reps Array
    var repsDictionary: [Int : String] =
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
            // Back
            19: "15-20 reps",
            20: "15-30s",
            21: "30-60s",
            22: "30-180s",
            23: "30-90s",
            24: "10-30 reps",
            25: "30-60s",
            26: "25-45s",
            27: "30-60s",
            28: "30-180s",
            // Obliques(Sides)
            29: "10-20s",
            30: "15-30s",
            31: "15-30s",
            // Neck
            32: "15-30s",
            33: "5-10s",
            34: "15-30s",
            35: "15-30s",
            36: "15-30s",
            37: "20-40s",
            // Arms
            38: "15-30s",
            39: "15-30s",
            40: "15-30s",
            // Pecs
            41: "15-30s",
            // Shoulders
            42: "20-40s",
            43: "10-20s",
            44: "15-30s",
            45: "15-30s",
            46: "15-30s",
            47: "15-30s",
            // Hips and Glutes
            48: "1-5min",
            49: "5-10 reps",
            50: "15-30s",
            51: "15-30s",
            52: "15-30s",
            53: "15-45s",
            54: "15-45s",
            // Calves
            55: "15-30s",
            // Hamstrings
            56: "10s",
            57: "10s",
            58: "15-30s",
            59: "15-45s",
            60: "15-60s",
            61: "15-60s",
            // Quads
            62: "15-30s",
            63: "15-30s"
    ]
    
    // Demonstration Array
    var demonstrationDictionary: [Int : UIImage] =
        [
            // Mandatory
            0: #imageLiteral(resourceName: "Test"),
            // Joint Rotations
            1: #imageLiteral(resourceName: "Wrist Rotations"),
            2: #imageLiteral(resourceName: "Test"),
            3: #imageLiteral(resourceName: "Test"),
            4: #imageLiteral(resourceName: "Test"),
            5: #imageLiteral(resourceName: "Test"),
            6: #imageLiteral(resourceName: "Test"),
            7: #imageLiteral(resourceName: "Test"),
            8: #imageLiteral(resourceName: "Test"),
            // Foam/Ball Roll
            9: #imageLiteral(resourceName: "Test"),
            10: #imageLiteral(resourceName: "Test"),
            11: #imageLiteral(resourceName: "Test"),
            12: #imageLiteral(resourceName: "Test"),
            13: #imageLiteral(resourceName: "Test"),
            14: #imageLiteral(resourceName: "Test"),
            15: #imageLiteral(resourceName: "Test"),
            16: #imageLiteral(resourceName: "Test"),
            17: #imageLiteral(resourceName: "Test"),
            18: #imageLiteral(resourceName: "Test"),
            // Back
            19: #imageLiteral(resourceName: "Cow"),
            20: #imageLiteral(resourceName: "Upwards Dog"),
            21: #imageLiteral(resourceName: "Extended Puppy"),
            22: #imageLiteral(resourceName: "Childs Pose"),
            23: #imageLiteral(resourceName: "Staff Pose"),
            24: #imageLiteral(resourceName: "Pelvic Tilt"),
            25: #imageLiteral(resourceName: "Knee Chest"),
            26: #imageLiteral(resourceName: "Knee Drop"),
            27: #imageLiteral(resourceName: "Marichis Pose"),
            28: #imageLiteral(resourceName: "Legs Wall"),
            // Obliques(Sides)
            29: #imageLiteral(resourceName: "Side Bend"),
            30: #imageLiteral(resourceName: "Extended Side Angle"),
            31: #imageLiteral(resourceName: "Half Straddle Side Bend"),
            // Neck
            32: #imageLiteral(resourceName: "Test"),
            33: #imageLiteral(resourceName: "Test"),
            34: #imageLiteral(resourceName: "Test"),
            35: #imageLiteral(resourceName: "Test"),
            36: #imageLiteral(resourceName: "Test"),
            37: #imageLiteral(resourceName: "Test"),
            // Arms
            38: #imageLiteral(resourceName: "Test"),
            39: #imageLiteral(resourceName: "Test"),
            40: #imageLiteral(resourceName: "Test"),
            // Pecs
            41: #imageLiteral(resourceName: "Test"),
            // Shoulders
            42: #imageLiteral(resourceName: "Test"),
            43: #imageLiteral(resourceName: "Test"),
            44: #imageLiteral(resourceName: "Test"),
            45: #imageLiteral(resourceName: "Test"),
            46: #imageLiteral(resourceName: "Test"),
            47: #imageLiteral(resourceName: "Test"),
            // Hips and Glutes
            48: #imageLiteral(resourceName: "Test"),
            49: #imageLiteral(resourceName: "Test"),
            50: #imageLiteral(resourceName: "Test"),
            51: #imageLiteral(resourceName: "Test"),
            52: #imageLiteral(resourceName: "Test"),
            53: #imageLiteral(resourceName: "Test"),
            54:#imageLiteral(resourceName: "Test"),
            // Calves
            55: #imageLiteral(resourceName: "Test"),
            // Hamstrings
            56: #imageLiteral(resourceName: "Test"),
            57: #imageLiteral(resourceName: "Test"),
            58: #imageLiteral(resourceName: "Test"),
            59: #imageLiteral(resourceName: "Test"),
            60: #imageLiteral(resourceName: "Test"),
            61: #imageLiteral(resourceName: "Test"),
            // Quads
            62: #imageLiteral(resourceName: "Test"),
            63: #imageLiteral(resourceName: "Test")
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
            // Back
            19: #imageLiteral(resourceName: "Spine"),
            20: #imageLiteral(resourceName: "Spine and Core"),
            21: #imageLiteral(resourceName: "Spine"),
            22: #imageLiteral(resourceName: "Spine"),
            23: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            24: #imageLiteral(resourceName: "Core"),
            25: #imageLiteral(resourceName: "Spine"),
            26: #imageLiteral(resourceName: "Core"),
            27: #imageLiteral(resourceName: "Core"),
            28: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            // Obliques(Sides)
            29: #imageLiteral(resourceName: "Oblique"),
            30: #imageLiteral(resourceName: "Oblique"),
            31: #imageLiteral(resourceName: "Oblique"),
            // Neck
            32: #imageLiteral(resourceName: "Rear Neck"),
            33: #imageLiteral(resourceName: "Rear Neck"),
            34: #imageLiteral(resourceName: "Lateral Neck"),
            35: #imageLiteral(resourceName: "Neck Rotator"),
            36: #imageLiteral(resourceName: "Neck Rotator"),
            37: #imageLiteral(resourceName: "Neck"),
            // Arms
            38: #imageLiteral(resourceName: "Forearm"),
            39: #imageLiteral(resourceName: "Tricep"),
            40: #imageLiteral(resourceName: "Bicep"),
            // Pecs
            41: #imageLiteral(resourceName: "Pec"),
            // Shoulders
            42: #imageLiteral(resourceName: "Shoulder Joint"),
            43: #imageLiteral(resourceName: "Shoulder Joint"),
            44: #imageLiteral(resourceName: "Front Delt"),
            45: #imageLiteral(resourceName: "Lateral Neck"),
            46: #imageLiteral(resourceName: "Rear Delt"),
            47: #imageLiteral(resourceName: "Rear Delt"),
            // Hips and Glutes
            48: #imageLiteral(resourceName: "Hip Joint"),
            49: #imageLiteral(resourceName: "Adductor"),
            50: #imageLiteral(resourceName: "Adductor"),
            51: #imageLiteral(resourceName: "Hip Area"),
            52: #imageLiteral(resourceName: "Piriformis"),
            53: #imageLiteral(resourceName: "Glute"),
            54: #imageLiteral(resourceName: "Glute"),
            // Calves
            55: #imageLiteral(resourceName: "Calf"),
            // Hamstrings
            56: #imageLiteral(resourceName: "Hamstring"),
            57: #imageLiteral(resourceName: "Hamstring"),
            58: #imageLiteral(resourceName: "Hamstring"),
            59: #imageLiteral(resourceName: "Hamstring"),
            60: #imageLiteral(resourceName: "Hamstring"),
            61: #imageLiteral(resourceName: "Hamstring"),
            // Quads
            62: #imageLiteral(resourceName: "Quad"),
            63: #imageLiteral(resourceName: "Quad")
    ]
    
    // Explanation Array
    var explanationDictionary: [Int : String] =
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
            // Back
            19: "catCow",
            20: "upwardsDog",
            21: "extendedPuppy",
            22: "childPose",
            23: "staffPose",
            24: "pelvicTilt",
            25: "kneeToChest",
            26: "legDrop",
            27: "seatedTwist",
            28: "legsWall",
            // Obliques(Sides)
            29: "sideLean",
            30: "extendedSideAngle",
            31: "seatedSide",
            // Neck
            32: "rearNeck",
            33: "rearNeckHand",
            34: "seatedLateral",
            35: "neckRotator",
            36: "scalene",
            37: "headRoll",
            // Arms
            38: "forearmStretch",
            39: "tricepStretch",
            40: "bicepStretch",
            // Pecs
            41: "pecStretch",
            // Shoulders
            42: "shoulderRoll",
            43: "behindBackTouch",
            44: "frontDelt",
            45: "lateralDelt",
            46: "rearDelt",
            47: "rotatorCuff",
            // Hips and Glutes
            48: "squatHold",
            49: "groinStretch",
            50: "butterflyPose",
            51: "lungeStretch",
            52: "threadTheNeedle",
            53: "pigeonPose",
            54: "seatedGlute",
            // Calves
            55: "calveStretch",
            // Hamstrings
            56: "standingHamstring",
            57: "standingOneLegHamstring",
            58: "singleLegStanding",
            59: "downWardsDog",
            60: "singleLegHamstring",
            61: "twoLegHamstring",
            // Quads
            62: "lungeStretchWall",
            63: "QuadStretch"
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
    
    // Session Picker View
    @IBOutlet weak var sessionPickerView: UIPickerView!
    
    // Add Preset
    @IBOutlet weak var addPreset: UIButton!
    @IBOutlet weak var removePreset: UIButton!
    
    //
    @IBOutlet weak var tableViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewConstraint1: NSLayoutConstraint!
    
    @IBOutlet weak var seperatorConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var beginButtonConstraint: NSLayoutConstraint!
    
    
    //
    let emptyString = ""
    
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
        flash.frame = CGRect(x: 0, y: sessionPickerView.frame.maxY, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
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
    // View did load  ---------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // Preset Stretchings Sessions
        //
        let defaults = UserDefaults.standard
        // Custom
        defaults.register(defaults: ["stretchingPresetsCustom" : emptyArrayOfArrays])
        defaults.register(defaults: ["stretchingPresetTextsCustom" : presetTexts])
        //
        defaults.register(defaults: ["stretchingSetsCustom" : emptyArrayOfArrays])
        defaults.register(defaults: ["stretchingRepsCustom" : emptyArrayOfArrays])
        //
        defaults.synchronize()
        
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2")
        }
        
        // Colour
        self.view.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        // Navigation Bar Title
        navigationBar.title = NSLocalizedString("custom", comment: "")
        
        // Picker View Test
        sessionPickerView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        // TableView Editing
        // Start
        editingButton.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
        
        
        // Plus Button Colour
        let origImage1 = UIImage(named: "Plus")
        let tintedImage1 = origImage1?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        addPreset.setImage(tintedImage1, for: .normal)
        //Image Tint
        addPreset.tintColor = colour1
        
        // Minus Button Colour
        let origImage2 = UIImage(named: "Minus")
        let tintedImage2 = origImage2?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        removePreset.setImage(tintedImage2, for: .normal)
        //Image Tint
        removePreset.tintColor = colour1
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = colour3
        beginButton.setTitleColor(colour2, for: .normal)
        
        
        
        // Initial Element Positions
        let stretchingPreset = UserDefaults.standard.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        if stretchingPreset.count == 0 {
            editingButton.alpha = 0
            removePreset.alpha = 0
            //
            tableViewConstraint.constant = view.frame.size.height - 98
            tableViewConstraint1.constant = -49.25
            //
            seperatorConstraint.constant = -49.25
            //
            beginButtonConstraint.constant = -49
        }
    
        
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
        setsRepsView.backgroundColor = colour2
        setsRepsView.layer.cornerRadius = 5
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
        beginButtonEnabled()
        editButtonEnabled()
        pickerViewEnabled()
    }
    
    
    //
    // Elements check enabled funcs ------------------------------------------------------------------------------
    //
    // Button Enabled
    func beginButtonEnabled() {
        // Begin Button
        let defaults = UserDefaults.standard
        var stretchingPreset = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        //
        if customTableView.isEditing {
            beginButton.isEnabled = false
        } else {
            if stretchingPreset.count == 0 {
                beginButton.isEnabled = false
            } else {
                if stretchingPreset[sessionPickerView.selectedRow(inComponent: 0)].count == 0 {
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
        var stretchingPreset = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        //
        if stretchingPreset.count == 0 {
            editingButton.isEnabled = false
        } else {
            if stretchingPreset[sessionPickerView.selectedRow(inComponent: 0)].count == 0 {
                editingButton.isEnabled = false
            } else {
                editingButton.isEnabled = true
            }
        }
    }
    
    // PickerView Enabled
    func pickerViewEnabled() {
        //
        let defaults = UserDefaults.standard
        let stretchingPreset = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        //
        if stretchingPreset.count == 0 {
            sessionPickerView.isUserInteractionEnabled = false
        } else {
            sessionPickerView.isUserInteractionEnabled = true
        }
    }
    //
    // Custom Sessions -----------------------------------------------------------------------------------------------------
    //
    // Set Personalized Preset
    var okAction = UIAlertAction()
    //
    @IBAction func addCustomStretchingSession(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        var presetTextArray = defaults.object(forKey: "stretchingPresetTextsCustom") as! [String]
        //
        var customSetsArray = defaults.object(forKey: "stretchingSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "stretchingRepsCustom") as! [[Int]]
        // Alert and Functions
        //
        let inputTitle = NSLocalizedString("stretchingInputTitle", comment: "")
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
            defaults.set(presetTextArray, forKey: "stretchingPresetTextsCustom")
            // Add New empty array
            customKeyArray.append([])
            defaults.set(customKeyArray, forKey: "stretchingPresetsCustom")
            // Add new sets and reps arrays
            customSetsArray.append([])
            defaults.set(customSetsArray, forKey: "stretchingSetsCustom")
            //
            customRepsArray.append([])
            defaults.set(customRepsArray, forKey: "stretchingRepsCustom")
            //
            defaults.synchronize()
            // Flash Screen
            self.sessionPickerView.reloadAllComponents()
            self.sessionPickerView.selectRow(self.sessionPickerView.selectedRow(inComponent: 0) + 1, inComponent: 0, animated: true)
            self.customTableView.reloadData()
            //
            self.beginButtonEnabled()
            self.editButtonEnabled()
            self.pickerViewEnabled()
            
            //
            // Initial Element Positions
            if customKeyArray.count != 0 {
                //
                self.removePreset.alpha = 1
                //
                self.tableViewConstraint.constant = 49
                self.tableViewConstraint1.constant = 49.75
                //
                self.seperatorConstraint.constant = 49.25
                //
                self.beginButtonConstraint.constant = 0
                //
                UIView.animate(withDuration: 0.4) {
                    self.view.layoutIfNeeded()
                    self.editingButton.alpha = 1
                    self.removePreset.alpha = 1
                }
            }
        })
        okAction.isEnabled = false
        alert.addAction(okAction)
        // Cancel reset action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alert.addAction(cancelAction)
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        //
    }
    
    // Enable ok alert action func
    func textChanged(_ sender: UITextField) {
        if sender.text == "" {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    
    // Remove Personalized Preset
    @IBAction func removeCustomStretchingSession(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        var presetTextArray = defaults.object(forKey: "stretchingPresetTextsCustom") as! [String]
        //
        var customSetsArray = defaults.object(forKey: "stretchingSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "stretchingRepsCustom") as! [[Int]]
        //
        let selectedRow = sessionPickerView.selectedRow(inComponent: 0)
        //
        let inputTitle = NSLocalizedString("stretchingRemoveTitle", comment: "")
        //
        let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
        alert.view.tintColor = colour2
        alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        // 3. Get the value from the text field, and perform actions upon OK press
        okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            //
            if presetTextArray.count != 0 {
                //
                customKeyArray.remove(at: selectedRow)
                defaults.set(customKeyArray, forKey: "stretchingPresetsCustom")
                //
                presetTextArray.remove(at: selectedRow)
                defaults.set(presetTextArray, forKey: "stretchingPresetTextsCustom")
                //
                customSetsArray.remove(at: selectedRow)
                defaults.set(customSetsArray, forKey: "stretchingSetsCustom")
                //
                customRepsArray.remove(at: selectedRow)
                defaults.set(customRepsArray, forKey: "stretchingRepsCustom")
                //
                defaults.synchronize()
                
                // Reload Screen
                self.sessionPickerView.reloadAllComponents()
                self.customTableView.reloadData()
                //
                self.beginButtonEnabled()
                self.editButtonEnabled()
                self.pickerViewEnabled()
                
                //
                // Initial Element Positions
                if customKeyArray.count == 0 {
                    //
                    self.removePreset.alpha = 1
                    //
                    self.tableViewConstraint.constant = self.view.frame.size.height - 98
                    self.tableViewConstraint1.constant = -49.25
                    //
                    self.seperatorConstraint.constant = -49.25
                    //
                    self.beginButtonConstraint.constant = -49
                    //
                    UIView.animate(withDuration: 0.4) {
                        self.view.layoutIfNeeded()
                        self.editingButton.alpha = 0
                        self.removePreset.alpha = 0
                    }
                }
            } else {
            }
        })
        //
        if customSetsArray.count > 0 {
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
    // Picker View ----------------------------------------------------------------------------------------------------
    //
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == sessionPickerView {
            return 1
        } else if pickerView == setsRepsPicker {
            return 2
        }
        return 0
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sessionPickerView {
            let titleDataArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsCustom") as! [String]
            return titleDataArray.count
        } else if pickerView == setsRepsPicker {
            if component == 0{
                return 6
            } else {
                return 16
            }
        }
        return 0
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        if pickerView == sessionPickerView {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsCustom") as! [String]
            //
            if titleDataArray.count > 0 {
                let titleData = titleDataArray[row]
                let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
                rowLabel.attributedText = myTitle
                //
                rowLabel.textAlignment = .center
                return rowLabel
            }
            //
        } else if pickerView == setsRepsPicker {
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
        }
        return UILabel()
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Width
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        //
        if pickerView == sessionPickerView {
            return sessionPickerView.frame.size.width
            //
        } else if pickerView == setsRepsPicker {
            if component == 0 {
                return (setsRepsPicker.frame.size.width / 3)
            } else if component == 1{
                return (setsRepsPicker.frame.size.width / 3)
            }
        }
        return 0
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
        if pickerView == sessionPickerView {
            //
            self.customTableView.reloadData()
            flashScreen()
            //
        } else if pickerView == setsRepsPicker {
            //
            if component ==  0{
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
    }
    
    
    //
    // Table View ------------------------------------------------------------------------------------------------------------
    //
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        
        switch tableView {
        case customTableView:
            return 1
        case movementsTableView:
            let numberOfSections = tableViewSectionArray.count
            return numberOfSections
        default: break
        }
        return 0
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        switch tableView {
        //
        case customTableView:
            //
            let titleDataArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsCustom") as! [String]
            if titleDataArray.count != 0 {
                return titleDataArray[sessionPickerView.selectedRow(inComponent: 0)]
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
        //
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
            //
            if customKeyArray.count == 0 {
                return 1
            } else {
                return customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].count + 1
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
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
            //
            var customSetsArray = defaults.object(forKey: "stretchingSetsCustom") as! [[Int]]
            var customRepsArray = defaults.object(forKey: "stretchingRepsCustom") as! [[Int]]
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
                if indexPath.row == customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].count  {
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
                    let keyIndex = customKeyArray[sessionPickerView.selectedRow(inComponent: 0)][indexPath.row]
                    cell.textLabel?.text = NSLocalizedString(stretchingMovementsDictionary[keyIndex]!, comment: "")
                    //
                    cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
                    cell.textLabel?.adjustsFontSizeToFitWidth = true
                    cell.textLabel?.textAlignment = .left
                    cell.backgroundColor = colour1
                    cell.textLabel?.textColor = colour2
                    cell.tintColor = .black
                    // Detail sets x reps
                    cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
                    cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
                    cell.detailTextLabel?.textAlignment = .left
                    cell.detailTextLabel?.textColor = colour2
                    cell.detailTextLabel?.text = String(setsPickerArray[customSetsArray[sessionPickerView.selectedRow(inComponent: 0)][indexPath.row]]) + " x " + repsPickerArray[customRepsArray[sessionPickerView.selectedRow(inComponent: 0)][indexPath.row]]
                    //
                    // Cell Image
                    cell.imageView?.image = demonstrationDictionary[keyIndex]
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
            cell.textLabel?.text = NSLocalizedString(stretchingMovementsDictionary[keyIndex]!, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = .black
            cell.tintColor = .black
            // Cell Image
            cell.imageView?.image = demonstrationDictionary[keyIndex]
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
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
            //
            if customKeyArray.count == 0 {
                return 49
                //
            } else {
                //
                if indexPath.row == customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].count  {
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
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let defaults = UserDefaults.standard
        var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        //
        var customSetsArray = defaults.object(forKey: "stretchingSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "stretchingRepsCustom") as! [[Int]]
        // If no session created
        if customKeyArray.count == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            switch tableView {
            //
            case customTableView:
                //
                selectedRow = indexPath.row
                //
                if customKeyArray.count == 0 {
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
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
                        self.movementsTableView.alpha = 1
                        //
                    }, completion: nil)
                    // Position
                    UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                        self.movementsTableView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49)
                        //
                        self.backgroundViewExpanded.alpha = 0.7
                    }, completion: nil)
                    //
                } else {
                    //
                    if indexPath.row == customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].count {
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
                        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
                            self.movementsTableView.alpha = 1
                            //
                        }, completion: nil)
                        // Position
                        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                            self.movementsTableView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49)
                            //
                            self.backgroundViewExpanded.alpha = 0.7
                        }, completion: nil)
                        //
                    } else {
                        // View
                        setsRepsView.alpha = 0
                        UIApplication.shared.keyWindow?.insertSubview(setsRepsView, aboveSubview: view)
                        let selectedCell = tableView.cellForRow(at: indexPath)
                        setsRepsView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: UIScreen.main.bounds.width - 40, height: (selectedCell?.bounds.height)!)
                        // selected row
                        setsRepsPicker.selectRow(customSetsArray[sessionPickerView.selectedRow(inComponent: 0)][indexPath.row], inComponent: 0, animated: true)
                        setsRepsPicker.selectRow(customRepsArray[sessionPickerView.selectedRow(inComponent: 0)][indexPath.row], inComponent: 1, animated: true)
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
                        // Animate table fade and size
                        // Alpha
                        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
                            self.setsRepsView.alpha = 1
                            //
                        }, completion: nil)
                        // Position
                        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                            //
                            self.setsRepsView.frame = CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: 147 + 49)
                            self.setsRepsView.center.y = self.view.center.y - ((UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!) / 2)
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
                }
            //
            case movementsTableView:
                //
                customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].append(fullKeyArray[indexPath.section][indexPath.row])
                defaults.set(customKeyArray, forKey: "stretchingPresetsCustom")
                // sets
                customSetsArray[sessionPickerView.selectedRow(inComponent: 0)].append(0)
                defaults.set(customSetsArray, forKey: "stretchingSetsCustom")
                // reps
                customRepsArray[sessionPickerView.selectedRow(inComponent: 0)].append(0)
                defaults.set(customRepsArray, forKey: "stretchingRepsCustom")
                //
                defaults.synchronize()
                // Remove Table
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    self.movementsTableView.alpha = 0
                    //
                    self.backgroundViewExpanded.alpha = 0
                    //
                }, completion: nil)
                //
                let delayInSeconds = 0.4
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    self.movementsTableView.removeFromSuperview()
                    self.backgroundViewExpanded.removeFromSuperview()
                    //
                    self.customTableView.reloadData()
                    // Scroll to Bottom
                    if self.customTableView.contentSize.height > self.customTableView.frame.size.height {
                        //
                        self.customTableView.setContentOffset(CGPoint(x: 0, y: self.customTableView.contentSize.height - self.customTableView.frame.size.height), animated: true)
                    }
                }
            //
            default: break
            }
            //
            tableView.deselectRow(at: indexPath, animated: true)
            beginButtonEnabled()
            editButtonEnabled()
        }
    }
    
    
    //
    // TableView Editing -----------------------------------------------------------------------------------------------------
    //
    // Can edit row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //
        let defaults = UserDefaults.standard
        let customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        //
        if customKeyArray.count == 0 {
            return false
        } else {
            if indexPath.row == customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].count {
                return false
            } else {
                return true
            }
        }
    }
    
    // Can move to row
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        //
        let defaults = UserDefaults.standard
        let customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        //
        if customKeyArray.count == 0 {
            return false
        } else {
            if indexPath.row == customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].count {
                return false
            } else {
                return true
            }
        }
    }
    
    // Move row at
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //
        let defaults = UserDefaults.standard
        var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        var customSetsArray = defaults.object(forKey: "stretchingSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "stretchingRepsCustom") as! [[Int]]
        // Key
        let itemToMove = customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: sourceIndexPath.row)
        customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].insert(itemToMove, at: destinationIndexPath.row)
        //
        defaults.set(customKeyArray, forKey: "stretchingPresetsCustom")
        // Sets
        let setToMove = customSetsArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: sourceIndexPath.row)
        customSetsArray[sessionPickerView.selectedRow(inComponent: 0)].insert(setToMove, at: destinationIndexPath.row)
        //
        defaults.set(customSetsArray, forKey: "stretchingSetsCustom")
        // Reps
        let repToMove = customRepsArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: sourceIndexPath.row)
        customRepsArray[sessionPickerView.selectedRow(inComponent: 0)].insert(repToMove, at: destinationIndexPath.row)
        //
        defaults.set(customRepsArray, forKey: "stretchingRepsCustom")
        //
        defaults.synchronize()
    }
    
    // Target index path for move from row
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        //
        let defaults = UserDefaults.standard
        var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        //
        if proposedDestinationIndexPath.row == customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].count {
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
            let defaults = UserDefaults.standard
            var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
            var customSetsArray = defaults.object(forKey: "stretchingSetsCustom") as! [[Int]]
            var customRepsArray = defaults.object(forKey: "stretchingRepsCustom") as! [[Int]]
            // Key
            customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: indexPath.row)
            defaults.set(customKeyArray, forKey: "stretchingPresetsCustom")
            // sets
            customSetsArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: indexPath.row)
            defaults.set(customSetsArray, forKey: "stretchingSetsCustom")
            // reps
            customRepsArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: indexPath.row)
            defaults.set(customRepsArray, forKey: "stretchingRepsCustom")
            //
            defaults.synchronize()
            //
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    
    //
    // Table view related button actions ------------------------------------------------------------------------------------------------
    //
    // Add movement table background (dismiss table)
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.movementsTableView.alpha = 0
            self.setsRepsView.alpha = 0
            //
            self.backgroundViewExpanded.alpha = 0
        }, completion: nil)
        //
        let delayInSeconds = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.movementsTableView.removeFromSuperview()
            self.setsRepsView.removeFromSuperview()
            //
            self.backgroundViewExpanded.removeFromSuperview()
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
            addPreset.isEnabled = true
            removePreset.isEnabled = true
            self.beginButtonEnabled()
            self.pickerViewEnabled()
        //
        } else {
            self.customTableView.setEditing(true, animated: true)
            self.editingButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
            //
            addPreset.isEnabled = false
            removePreset.isEnabled = false
            self.beginButtonEnabled()
            self.pickerViewEnabled()
        }
    }
    
    
    //
    // Picker Related actions ------------------------------------------------------------------------------------------------
    //
    // Ok button action
    func okButtonAction(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        var customSetsArray = defaults.object(forKey: "stretchingSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "stretchingRepsCustom") as! [[Int]]
        //
        customSetsArray[sessionPickerView.selectedRow(inComponent: 0)][selectedRow] = setsRepsPicker.selectedRow(inComponent: 0)
        defaults.set(customSetsArray, forKey: "stretchingSetsCustom")
        //
        customRepsArray[sessionPickerView.selectedRow(inComponent: 0)][selectedRow] = setsRepsPicker.selectedRow(inComponent: 1)
        defaults.set(customRepsArray, forKey: "stretchingRepsCustom")
        //
        defaults.synchronize()
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.setsRepsView.alpha = 0
            //
            self.backgroundViewExpanded.alpha = 0
        }, completion: nil)
        //
        let delayInSeconds = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.setsRepsView.removeFromSuperview()
            //
            self.backgroundViewExpanded.removeFromSuperview()
        }
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
    // Begin Button ------------------------------------------------------------------------------------------------
    //
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        
        if UserDefaults.standard.string(forKey: "presentationStyle") == "detailed" {
            
            performSegue(withIdentifier: "stretchingCustomSegue1", sender: nil)
            
        } else {
            
            performSegue(withIdentifier: "stretchingCustomSegue2", sender: nil)
        }
        
        
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
        var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        //
        var customSetsArray = defaults.object(forKey: "stretchingSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "stretchingRepsCustom") as! [[Int]]
        //
        let titleDataArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsCustom") as! [String]
        
        
        if (segue.identifier == "stretchingCustomSegue1") {
            //
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.viewControllers.first as! SessionScreen
            
            // Compress Arrays
            for i in customKeyArray[sessionPickerView.selectedRow(inComponent: 0)] {
                //
                stretchingArray.append(stretchingMovementsDictionary[i]!)
                //
                demonstrationArray.append(demonstrationDictionary[i]!)
                //
                targetAreaArray.append(targetAreaDictionary[i]!)
                //
                explanationArray.append(explanationDictionary[i]!)
            }
            //
            for i in customSetsArray[sessionPickerView.selectedRow(inComponent: 0)] {
                setsArray.append(setsPickerArray[i])
            }
            //
            for i in customRepsArray[sessionPickerView.selectedRow(inComponent: 0)] {
                repsArray.append(repsPickerArray[i])
            }
            
            //
            destinationVC.sessionArray = stretchingArray
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = 0
            //
        } else if (segue.identifier == "stretchingCustomSegue2") {
            //
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.viewControllers.first as! SessionScreenOverview
            
            // Compress Arrays
            for i in customKeyArray[sessionPickerView.selectedRow(inComponent: 0)] {
                //
                stretchingArray.append(stretchingMovementsDictionary[i]!)
                //
                demonstrationArray.append(demonstrationDictionary[i]!)
                //
                targetAreaArray.append(targetAreaDictionary[i]!)
                //
                explanationArray.append(explanationDictionary[i]!)
            }
            //
            for i in customSetsArray[sessionPickerView.selectedRow(inComponent: 0)] {
                setsArray.append(setsPickerArray[i])
            }
            //
            for i in customRepsArray[sessionPickerView.selectedRow(inComponent: 0)] {
                repsArray.append(repsPickerArray[i])
            }
            
            //
            destinationVC.sessionArray = stretchingArray
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = 0
            //
            destinationVC.sessionTitle = titleDataArray[sessionPickerView.numberOfRows(inComponent: 0)]
        }
    }
    
    
    
    //
    // Walkthrough ------------------------------------------------------------------------------------------------
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
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight, width: self.view.frame.size.width, height: sessionPickerView.frame.size.height))
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
            
            
            
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            
            
        //
        case 1:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + sessionPickerView.frame.size.height, width: self.view.frame.size.width, height: customTableView.frame.size.height))
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
            
            label.center = sessionPickerView.center
            label.center.y = (UIApplication.shared.statusBarFrame.height/2) + sessionPickerView.frame.size.height
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
            path.addRect(CGRect(x: 0, y:   UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + sessionPickerView.frame.size.height + 24.5, width: 72 + 5, height: 72))
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
            
            label.center = sessionPickerView.center
            label.center.y = (UIApplication.shared.statusBarFrame.height/2) + sessionPickerView.frame.size.height
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
            path.addEllipse(in: CGRect(x: self.view.frame.size.width - 98, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + sessionPickerView.frame.size.height, width: 98, height: 49))
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
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + sessionPickerView.frame.size.height + customTableView.frame.size.height, width: self.view.frame.size.height, height: 49))
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
            self.sessionPickerView.selectRow(0, inComponent: 0, animated: true)
            
            
            
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
