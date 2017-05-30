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
// Warmup Arrays -----------------------------------------------------------------------------------------------
//
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
            cell.textLabel?.text = NSLocalizedString(warmupMovementsDictionary[keyIndex]!, comment: "")
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
                    setsRepsView.alpha = 0
                    UIApplication.shared.keyWindow?.insertSubview(setsRepsView, aboveSubview: view)
                    let selectedCell = tableView.cellForRow(at: indexPath)
                    setsRepsView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: UIScreen.main.bounds.width - 40, height: (selectedCell?.bounds.height)!)
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
                    // Animate table fade and size
                    // Alpha
                    UIView.animate(withDuration: 0.4, animations: {
                        self.setsRepsView.alpha = 1
                        //
                    }, completion: nil)
                    // Position
                    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
                self.setsRepsView.alpha = 0
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
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.setsRepsView.alpha = 0
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
                demonstrationArray.append(demonstrationDictionary[i]!)
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
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = 0
            //
            destinationVC.sessionTitle = titleDataArray[selectedPreset]
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
