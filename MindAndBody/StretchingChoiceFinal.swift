//
//  StretchingChoiceFinal.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 28.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Stretching Choice Class ----------------------------------------------------------------------------------------------------
//
class StretchingChoiceFinal: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
  
    // Selected Stretching Type
    //
    var stretchingType = Int()
    
    // Custom
    //
    var emptyArrayofArrays: [[Int]] = []
    
    
//
// Arrays -----------------------------------------------------------------------------------------------------------
//
    // Selected Array
    var stretchingSelectedArray: [Int] = []
    
    // Picker View Array
    var pickerViewArray: [String] = []
    // TableView Section Array
    // Presets
    var presetsArrays: [[Int]] = []
    
    // Custom Presets
        // Empty Array
        var emptyArray: [[Int]] = [[]]
    
    
    // Arrays to be set and used (Screen arrays)
    // Movements Array
    var stretchingArray: [String] = []

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
    
    // Static Arrays
    // Initial Custom Preset Texts
    var presetTexts: [String] = []
    
    // Navigation Titles
    let navigationTitles: [String] =
        ["general",
         "postWorkout",
         "postCardio"]
    
    // Custom Preset Keys
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
// Dictionaries -----------------------------------------------------------------------------------------------------------------------
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
    var stretchingKeyArray: [[Int]] =
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
    var stretchingDictionary: [Int : String] =
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
// General -----------------------------------------------------------------------------------------------------
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
    var presetsArraysGeneral: [[Int]] =
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
// Post Workout -----------------------------------------------------------------------------------------------------------
//
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
    var presetsArraysWorkout: [[Int]] =
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
// Post Cardio -----------------------------------------------------------------------------------------------------------
//
    //
    
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
    
    
//
// Set Arrays Function -----------------------------------------------------------------------------------------------------------
//
    func setArrays() {
        //
        
        switch stretchingType {
        //
        case 0:
            // Choice Screen Arrays
            stretchingSelectedArray = presetsArraysGeneral[0]
            pickerViewArray = pickerViewArrayGeneral
        //
        case 1:
            // Choice Screen Arrays
            stretchingSelectedArray = presetsArraysWorkout[0]
            pickerViewArray = pickerViewArrayWorkout
        //
        case 2:
            // Choice Screen Arrays
            stretchingSelectedArray = presetsArraysCardio[0]
            pickerViewArray = pickerViewArrayCardio
        //
        default: break
        }
    }
    
    
//
// Outlets -----------------------------------------------------------------------------------------------------------
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
    
    
//
// Flash Screen -----------------------------------------------------------------------------------------------------------
//
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
// View Did Load -----------------------------------------------------------------------------------------------------------
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
        
        // Picker View
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
        informationView.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
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
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationText.frame.size.height + informationTitle.frame.size.height + 20)
        
        // TableView Background
        //
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        //
        tableView.backgroundView = tableViewBackground
    
        // Preset Stretching Sessions
        //
        let defaults = UserDefaults.standard
        // General
        defaults.register(defaults: ["stretchingPresetsGeneral" : emptyArrayofArrays])
        defaults.register(defaults: ["stretchingPresetTextsGeneral" : presetTexts])
        defaults.register(defaults: ["stretchingPresetNumberGeneral" : 0])
        // Post Workout
        defaults.register(defaults: ["stretchingPresetsWorkout" : emptyArrayofArrays])
        defaults.register(defaults: ["stretchingPresetTextsWorkout" : presetTexts])
        defaults.register(defaults: ["stretchingPresetNumberWorkout" : 0])
        // Post Cardio
        defaults.register(defaults: ["stretchingPresetsCardio" : emptyArrayofArrays])
        defaults.register(defaults: ["stretchingPresetTextsCardio" : presetTexts])
        defaults.register(defaults: ["stretchingPresetNumberCardio" : 0])
        //
        defaults.synchronize()
        
        //
        beginButtonEnabled()
    }
    
    
//
// Begin Button Enabled test --------------------------------------------------------------------------------------------------
//
    func beginButtonEnabled() {
        // Begin Button
        if stretchingSelectedArray.count != 0 {
            beginButton.isEnabled = true
        } else {
            beginButton.isEnabled = false
        }
    }
    
    
//
// Workout Choice Class -----------------------------------------------------------------------------------------------------------
//
    // Custom sessions
    @IBAction func addPreset(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
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
        //
        let defaults = UserDefaults.standard
        var stretchingPreset = defaults.object(forKey: stretchingPresets[stretchingType]) as! [Array<Array<Int>>]
        var presetTextArray = defaults.object(forKey: stretchingPresetTexts[stretchingType]) as! [String]
        //
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let index = (selectedRow) - (pickerViewArray.count + 1)
        //
        if index > -1 {
            //
            stretchingPreset.remove(at: index)
            stretchingPreset.append(emptyArray)
            defaults.set(stretchingPreset, forKey: stretchingPresets[stretchingType])
            //
            presetTextArray.remove(at: index)
            presetTextArray.append(emptyString)
            defaults.set(presetTextArray, forKey: stretchingPresetTexts[stretchingType])
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
// Workout Choice Class -----------------------------------------------------------------------------------------------------------
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
            let titleDataArray = UserDefaults.standard.object(forKey: stretchingPresetTexts[stretchingType]) as! [String]
            let titleData = titleDataArray[0]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
        //
        } else if row == pickerViewArray.count + 2 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: stretchingPresetTexts[stretchingType]) as! [String]
            let titleData = titleDataArray[1]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
        //
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
    
    // Row height for component
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
        let defaults = UserDefaults.standard
        //
        switch row {
         //
        case 0,1,2,3,4,5,6:
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
    

//
// Table View -----------------------------------------------------------------------------------------------------------
//
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return stretchingMovementsDictionary.count
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
        //colour2
        header.contentView.tintColor = colour1
        //
        
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stretchingMovementsDictionary[section].count
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        //
        cell.textLabel?.text = NSLocalizedString(stretchingMovementsDictionary[indexPath.section][indexPath.row], comment: "")
        //
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
        cell.imageView?.image = demonstrationDictionary[indexPath.section][indexPath.row]
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
            stretchingSelectedArray[indexPath.section][indexPath.row] = 0
            tableView.reloadData()
        } else {
            cell?.accessoryType = .checkmark
            stretchingSelectedArray[indexPath.section][indexPath.row] = 1
            tableView.reloadData()
        }
        //
        beginButtonEnabled()
    }
    

//
// Information Actions -----------------------------------------------------------------------------------------------------------
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
// Expand Image -----------------------------------------------------------------------------------------------------------
//
    // Expand Image
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
        //expandedImage.image = demonstrationDictionary[section][row]
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
    
    // Retract Image
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
// Begin Button -----------------------------------------------------------------------------------------------------------
//
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        //
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
    
    
//
// Pass Array to next view controller -----------------------------------------------------------------------------------
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if (segue.identifier == "stretchingSessionSegue1") {
            // Compress Arrays
            //
            stretchingArray = zip(stretchingMovementsDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            setsArray = zip(setsDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            repsArray = zip(repsDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            demonstrationArray = zip(demonstrationDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            targetAreaArray = zip(targetAreaDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            explanationArray = zip(explanationDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            
            // Pass Data
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.viewControllers.first as! SessionScreen
            //
            destinationVC.sessionArray = stretchingArray
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
        //
        } else if (segue.identifier == "stretchingSessionSegue2") {
            
            // Compress Arrays
            //
            stretchingArray = zip(stretchingMovementsDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            setsArray = zip(setsDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            repsArray = zip(repsDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            demonstrationArray = zip(demonstrationDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            targetAreaArray = zip(targetAreaDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            //
            explanationArray = zip(explanationDictionary.flatMap{$0},stretchingSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
            
            // Pass Data
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.viewControllers.first as! SessionScreenOverview
            //
            destinationVC.sessionArray = stretchingArray
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
                let pickerArray = UserDefaults.standard.object(forKey: stretchingPresetTexts[stretchingType]) as! [String]
                destinationVC.sessionTitle = pickerArray[pickerIndex - pickerViewArray.count]
            }
        }
    }
    
//
// Walkthrough -----------------------------------------------------------------------------------------------------------
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
    
    
    
}
