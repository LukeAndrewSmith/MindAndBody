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
    // StretchingPresetsCustom, SetsArray, RepsArray
    var emptyArrayOfArrays: [[Int]] = []
    // Selected row
    var selectedRow = Int()
    
    //
    var selectedPreset = Int()
    
    //
    var stretchingArray: [String] = []
    //
    var demonstrationArray: [[UIImage]] = []
    //
    var targetAreaArray: [UIImage] = []
    //
    var explanationArray: [String] = []
    
    //
    var breathsArray: [String] = []
    
    
    //
    // Stretching Arrays -----------------------------------------------------------------------------------------------
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
    
    
    // Demonstration Array
    var demonstrationDictionary: [Int : [UIImage]] =
        [
            // Mandatory
            0: [#imageLiteral(resourceName: "Test")],
            // Joint Rotations
            1: [#imageLiteral(resourceName: "Wrist Rotations")],
            2: [#imageLiteral(resourceName: "Test")],
            3: [#imageLiteral(resourceName: "Test")],
            4: [#imageLiteral(resourceName: "Test")],
            5: [#imageLiteral(resourceName: "Test")],
            6: [#imageLiteral(resourceName: "Test")],
            7: [#imageLiteral(resourceName: "Test")],
            8: [#imageLiteral(resourceName: "Test")],
            // Foam/Ball Roll
            9: [#imageLiteral(resourceName: "Test")],
            10: [#imageLiteral(resourceName: "Test")],
            11: [#imageLiteral(resourceName: "Test")],
            12: [#imageLiteral(resourceName: "Test")],
            13: [#imageLiteral(resourceName: "Test")],
            14: [#imageLiteral(resourceName: "Test")],
            15: [#imageLiteral(resourceName: "Test")],
            16: [#imageLiteral(resourceName: "Test")],
            17: [#imageLiteral(resourceName: "Test")],
            18: [#imageLiteral(resourceName: "Test")],
            // Back
            19: [#imageLiteral(resourceName: "catCowS"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS2"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS3"), #imageLiteral(resourceName: "catCowS1"), #imageLiteral(resourceName: "catCowS2"), #imageLiteral(resourceName: "catCowS1")],
            20: [#imageLiteral(resourceName: "upwardsDogS")],
            21: [#imageLiteral(resourceName: "extendedPuppyS")],
            22: [#imageLiteral(resourceName: "childPoseS")],
            23: [#imageLiteral(resourceName: "staffPoseS")],
            24: [#imageLiteral(resourceName: "pelvicTilt"), #imageLiteral(resourceName: "pelvicTilt1"), #imageLiteral(resourceName: "pelvicTilt2"), #imageLiteral(resourceName: "pelvicTilt1"), #imageLiteral(resourceName: "pelvicTilt2"), #imageLiteral(resourceName: "pelvicTilt1"), #imageLiteral(resourceName: "pelvicTilt2")],
            25: [#imageLiteral(resourceName: "kneeToChest")],
            26: [#imageLiteral(resourceName: "legDrop"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop2"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop3"), #imageLiteral(resourceName: "legDrop1"), #imageLiteral(resourceName: "legDrop2"), #imageLiteral(resourceName: "legDrop1")],
            27: [#imageLiteral(resourceName: "seatedTwist")],
            28: [#imageLiteral(resourceName: "legsWall")],
            // Obliques(Sides)
            29: [#imageLiteral(resourceName: "sideLean")],
            30: [#imageLiteral(resourceName: "extendedSideAngleS")],
            31: [#imageLiteral(resourceName: "seatedSide")],
            // Neck
            32: [#imageLiteral(resourceName: "rearNeck")],
            33: [#imageLiteral(resourceName: "rearNeckHand")],
            34: [#imageLiteral(resourceName: "seatedLateral")],
            35: [#imageLiteral(resourceName: "neckRotator")],
            36: [#imageLiteral(resourceName: "scalene")],
            37: [#imageLiteral(resourceName: "headRoll")],
            // Arms
            38: [#imageLiteral(resourceName: "forearmStretch")],
            39: [#imageLiteral(resourceName: "tricepStretch")],
            40: [#imageLiteral(resourceName: "bicepStretch")],
            // Pecs
            41: [#imageLiteral(resourceName: "pecStretch")],
            // Shoulders
            42: [#imageLiteral(resourceName: "shoulderRoll"), #imageLiteral(resourceName: "shoulderRoll1"), #imageLiteral(resourceName: "shoulderRoll2"), #imageLiteral(resourceName: "shoulderRoll3"), #imageLiteral(resourceName: "shoulderRoll4"), #imageLiteral(resourceName: "shoulderRoll1"), #imageLiteral(resourceName: "shoulderRoll2"), #imageLiteral(resourceName: "shoulderRoll3"), #imageLiteral(resourceName: "shoulderRoll4")],
            43: [#imageLiteral(resourceName: "behindBackTouch")],
            44: [#imageLiteral(resourceName: "frontDelt")],
            45: [#imageLiteral(resourceName: "lateralDelt")],
            46: [#imageLiteral(resourceName: "rearDelt")],
            47: [#imageLiteral(resourceName: "rotatorCuff")],
            // Hips and Glutes
            48: [#imageLiteral(resourceName: "squatHold")],
            49: [#imageLiteral(resourceName: "groinStretch")],
            50: [#imageLiteral(resourceName: "butterflyPoseS")],
            51: [#imageLiteral(resourceName: "lungeStretch")],
            52: [#imageLiteral(resourceName: "threadTheNeedleS")],
            53: [#imageLiteral(resourceName: "pigeonPoseS")],
            54:[#imageLiteral(resourceName: "seatedGlute")],
            // Calves
            55: [#imageLiteral(resourceName: "calveStretch")],
            // Hamstrings
            56: [#imageLiteral(resourceName: "standingHamstring")],
            57: [#imageLiteral(resourceName: "standingSingleLegHamstring")],
            58: [#imageLiteral(resourceName: "downWardsDogS")],
            59: [#imageLiteral(resourceName: "singleLegHamstring")],
            60: [#imageLiteral(resourceName: "twoLegHamstring")],
            // Quads
            61: [#imageLiteral(resourceName: "lungeStretchWall")],
            62: [#imageLiteral(resourceName: "quadStretch")],
            // Full Body
            63: [#imageLiteral(resourceName: "sumoSquatTwist")],
            64: [#imageLiteral(resourceName: "tinyFencerStretch")]
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
    // Breaths/Breaths/Seconds Picker View
    //
    var breathsPickerArray: [String] = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99"]
    
    
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
        presetsButton.setTitle(NSLocalizedString("customStretchingSession", comment: ""), for: .normal)
    }
    
    //
    // View did load  ---------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // Preset Stretching Sessions
        //
        let defaults = UserDefaults.standard
        // Custom
        defaults.register(defaults: ["stretchingPresetsCustom" : emptyArrayOfArrays])
        defaults.register(defaults: ["stretchingPresetTextsCustom" : presetTexts])
        //
        defaults.register(defaults: ["stretchingBreathsCustom" : emptyArrayOfArrays])
        //
        defaults.synchronize()
        
        
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
        var stretchingPreset = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        //
        if customTableView.isEditing {
            beginButton.isEnabled = false
        } else {
            if selectedPreset == -1 {
                
            } else {
                if stretchingPreset[selectedPreset].count == 0 {
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
        //
        if stretchingPreset.count == 0 {
            editingButton.isEnabled = false
        } else {
            if stretchingPreset[selectedPreset].count == 0 {
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
            return " " + NSLocalizedString("customStretchingSession", comment: "")
        //
        case customTableView:
            //
            let titleDataArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsCustom") as! [String]
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
            let presetsArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsCustom") as! [String]
            return presetsArray.count + 1
        //
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
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
            let presetsArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsCustom") as! [String]
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
            let customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
            //
            var customBreathsArray = defaults.object(forKey: "stretchingBreathsCustom") as! [[Int]]
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
                    cell.textLabel?.text = NSLocalizedString(stretchingMovementsDictionary[keyIndex]!, comment: "")
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
                    if keyIndex == 0 {
                        
                    } else {
                        cell.detailTextLabel?.text = breathsPickerArray[customBreathsArray[selectedPreset][indexPath.row]] + " br."
                    }
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
            cell.textLabel?.text = NSLocalizedString(stretchingMovementsDictionary[keyIndex]!, comment: "")
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
            let customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
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
        var presetsArray = defaults.object(forKey: "stretchingPresetTextsCustom") as! [String]
        var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        //
        var customBreathsArray = defaults.object(forKey: "stretchingBreathsCustom") as! [[Int]]
        
        //
        switch tableView {
        case presetsTableView:
            // Add Custom Stretching
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
                var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
                var presetTextArray = defaults.object(forKey: "stretchingPresetTextsCustom") as! [String]
                //
                var customBreathsArray = defaults.object(forKey: "stretchingBreathsCustom") as! [[Int]]
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
                    // Add new breaths arrays
                    customBreathsArray.append([])
                    defaults.set(customBreathsArray, forKey: "stretchingBreathsCustom")
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
                        let presetsArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsCustom") as! [String]
                        //
                        let selectedIndexPath = NSIndexPath(row: presetsArray.count - 1, section: 0)
                        self.presetsTableView.selectRow(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
                        self.selectedPreset = selectedIndexPath.row
                        //
                        if self.selectedPreset == -1 {
                            self.presetsButton.setTitle(NSLocalizedString("customStretchingSession", comment: ""), for: .normal)
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
                // Select Custom Stretch
            } else {
                //
                selectedPreset = indexPath.row
                //
                let presetsArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsCustom") as! [String]
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
                if customKeyArray[selectedPreset][indexPath.row] == 0 {
                    tableView.deselectRow(at: indexPath, animated: true)
                    // Nothing for cardio
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
            }
            //        }
        //
        case movementsTableView:
            //
            customKeyArray[selectedPreset].append(fullKeyArray[indexPath.section][indexPath.row])
            defaults.set(customKeyArray, forKey: "stretchingPresetsCustom")
            // reps
            customBreathsArray[selectedPreset].append(0)
            defaults.set(customBreathsArray, forKey: "stretchingBreathsCustom")
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
            let presetsArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsCustom") as! [String]
            //
            if indexPath.row < presetsArray.count {
                return true
            }
        case movementsTableView: return false
        case customTableView:
            //
            let defaults = UserDefaults.standard
            let customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
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
            let customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
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
        var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        var customBreathsArray = defaults.object(forKey: "stretchingBreathsCustom") as! [[Int]]
        // Key
        let itemToMove = customKeyArray[selectedPreset].remove(at: sourceIndexPath.row)
        customKeyArray[selectedPreset].insert(itemToMove, at: destinationIndexPath.row)
        //
        defaults.set(customKeyArray, forKey: "stretchingPresetsCustom")
        // Reps
        let breathToMove = customBreathsArray[selectedPreset].remove(at: sourceIndexPath.row)
        customBreathsArray[selectedPreset].insert(breathToMove, at: destinationIndexPath.row)
        //
        defaults.set(customBreathsArray, forKey: "stretchingBreathsCustom")
        //
        defaults.synchronize()
    }
    
    // Target index path for move from row
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        //
        let defaults = UserDefaults.standard
        var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
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
                var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
                var presetTextArray = defaults.object(forKey: "stretchingPresetTextsCustom") as! [String]
                //
                var customBreathsArray = defaults.object(forKey: "stretchingBreathsCustom") as! [[Int]]
                //
                //
                customKeyArray.remove(at: indexPath.row)
                defaults.set(customKeyArray, forKey: "stretchingPresetsCustom")
                //
                presetTextArray.remove(at: indexPath.row)
                defaults.set(presetTextArray, forKey: "stretchingPresetTextsCustom")
                //
                customBreathsArray.remove(at: indexPath.row)
                defaults.set(customBreathsArray, forKey: "stretchingBreathsCustom")
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
                        self.presetsButton.setTitle(NSLocalizedString("customStretchingSession", comment: ""), for: .normal)
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
                var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
                var customBreathsArray = defaults.object(forKey: "stretchingBreathsCustom") as! [[Int]]
                // Key
                customKeyArray[selectedPreset].remove(at: indexPath.row)
                defaults.set(customKeyArray, forKey: "stretchingPresetsCustom")
                // Breaths
                customBreathsArray[selectedPreset].remove(at: indexPath.row)
                defaults.set(customBreathsArray, forKey: "stretchingBreathsCustom")
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
        var customBreathsArray = defaults.object(forKey: "stretchingBreathsCustom") as! [[Int]]
        //
        customBreathsArray[selectedPreset][selectedRow] = breathsPicker.selectedRow(inComponent: 0)
        defaults.set(customBreathsArray, forKey: "stretchingBreathsCustom")
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
        //
        var customKeyArray = defaults.object(forKey: "stretchingPresetsCustom") as! [[Int]]
        //
        var customBreathsArray = defaults.object(forKey: "stretchingBreathsCustom") as! [[Int]]
        //
        let titleDataArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsCustom") as! [String]
        
        if (segue.identifier == "stretchingSessionSegueCustom") {
            //
            let destinationVC = segue.destination as! StretchingScreen
            
            // Compress Arrays
            for i in customKeyArray[selectedPreset] {
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
            for i in customBreathsArray[selectedPreset] {
                breathsArray.append(breathsPickerArray[i])
            }
            
            //
            destinationVC.sessionArray = stretchingArray
            destinationVC.breathsArray = breathsArray
            //destinationVC.demonstrationArray = demonstrationArray
            //destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = 0
        }
    }
    
    //
}
