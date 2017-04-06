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

    // Selected Warmup Type
    //
    var warmupType = Int()
 
    
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
// Warmup Arrays -----------------------------------------------------------------------------------------------
//
    // TableView Section Array
    var tableViewSectionArray: [String] =
        [
            "mandatory",
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
            [0,
             1],
            // Joint Rotations
            [2,
             3,
             4,
             5,
             6,
             7,
             8,
             9],
            // Foam/Ball Roll
            [10,
             11,
             12,
             13,
             14,
             15,
             16,
             17,
             18,
             19],
            // Lower Back
            [20,
             21,
             22,
             23,
             24],
            // Shoulder
            [25,
             26,
             27,
             28],
            // Band/Bar/Machine Assisted
            [29,
             30,
             31,
             32,
             33,
             34],
            // General Mobility
            [35,
             36,
             37,
             38,
             39,
             40,
             41,
             42,
             43,
             44,
             45],
            // Dynamic Warmup Drills
            [46,
             47,
             48,
             49,
             50,
             51,
             52,
             53,
             54],
            // Accessory
            [55,
             56,
             57,
             58]
    ]
    
    // Warmup Movements Dictionary
    var warmupMovementsDictionary: [Int : String] =
    [
        // Cardio
        0: "5minCardioL",
        1: "5minCardioI",
        // Joint Rotations
        2: "wrist",
        3: "elbow",
        4: "shoulder",
        5: "neckR",
        6: "waist",
        7: "hip",
        8: "knees",
        9: "ankles",
        // Foam/Ball Roll
        10: "backf",
        11: "thoracicSpine",
        12: "lat",
        13: "pecDelt",
        14: "rearDelt",
        15: "quadf",
        16: "adductorf",
        17: "hamstringf",
        18: "glutef",
        19: "calvef",
        // Lower Back
        20: "sideLegDrop",
        21: "sideLegKick",
        22: "scorpionKick",
        23: "sideBend",
        24: "catCow",
        // Shoulder
        25: "wallSlides",
        26: "superManShoulder",
        27: "scapula",
        28: "shoulderRotation",
        // Band/Bar/Machine Assisted
        29: "facePull",
        30: "externalRotation",
        31: "internalRotation",
        32: "shoulderDislocation",
        33: "rearDeltFly",
        34: "latPullover",
        // General Mobility
        35: "rollBack",
        36: "hipCircles",
        37: "mountainClimber",
        38: "groinStretch",
        39: "gluteBridge",
        40: "threadTheNeedle",
        41: "butterflyPose",
        42: "cossakSquat",
        43: "hipHinges",
        44: "sideLegSwings",
        45: "frontLegSwings",
        // Dynamic Warmup Drills
        46: "jumpSquat",
        47: "lunge",
        48: "gluteKicks",
        49: "aSkips",
        50: "bSkips",
        51: "grapeVines",
        52: "lateralBound",
        53: "straightLegBound",
        54: "sprints",
        // Accessory
        55: "latStretch",
        56: "calveStretch",
        57: "pushUp",
        58: "pullUp"
    ]

    // Demonstration Array
    var demonstrationArray: [[UIImage]] = [[]]
    
    // Target Area Array
    var targetAreaDictionary: [Int: UIImage] =
        [
            // Mandatory
            0: #imageLiteral(resourceName: "Heart"),
            1: #imageLiteral(resourceName: "Heart"),
            // Joint Rotations
            2: #imageLiteral(resourceName: "Wrist Joint"),
            3: #imageLiteral(resourceName: "Elbow Joint"),
            4: #imageLiteral(resourceName: "Shoulder Joint"),
            5: #imageLiteral(resourceName: "Neck Joint"),
            6: #imageLiteral(resourceName: "Waist Joint"),
            7: #imageLiteral(resourceName: "Hip Joint"),
            8: #imageLiteral(resourceName: "Knee Joint"),
            9: #imageLiteral(resourceName: "Ankle Joint"),
            // Foam/Ball Roll
            10: #imageLiteral(resourceName: "Thoracic"),
            11: #imageLiteral(resourceName: "Thoracic"),
            12: #imageLiteral(resourceName: "Lat and Delt"),
            13: #imageLiteral(resourceName: "Pec and Front Delt"),
            14: #imageLiteral(resourceName: "Rear Delt"),
            15: #imageLiteral(resourceName: "Quad"),
            16: #imageLiteral(resourceName: "Adductor"),
            17: #imageLiteral(resourceName: "Hamstring"),
            18: #imageLiteral(resourceName: "Glute"),
            19: #imageLiteral(resourceName: "Calf"),
            // Lower Back
            20: #imageLiteral(resourceName: "Core"),
            21: #imageLiteral(resourceName: "Core"),
            22: #imageLiteral(resourceName: "Core"),
            23: #imageLiteral(resourceName: "Core"),
            24: #imageLiteral(resourceName: "Spine"),
            // Shoulder
            25: #imageLiteral(resourceName: "Shoulder"),
            26: #imageLiteral(resourceName: "Back and Shoulder"),
            27: #imageLiteral(resourceName: "Serratus"),
            28: #imageLiteral(resourceName: "Shoulder"),
            // Band/Bar/Machine Assisted
            29: #imageLiteral(resourceName: "Upper Back and Shoulder"),
            30: #imageLiteral(resourceName: "Rear Delt"),
            31: #imageLiteral(resourceName: "Rear Delt"),
            32: #imageLiteral(resourceName: "Shoulder"),
            33: #imageLiteral(resourceName: "Rear Delt"),
            34: #imageLiteral(resourceName: "Back"),
            // General Mobility
            35: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            36: #imageLiteral(resourceName: "Hip Area"),
            37: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            38: #imageLiteral(resourceName: "Adductor"),
            39: #imageLiteral(resourceName: "Hamstring and Lower Back"),
            40: #imageLiteral(resourceName: "Piriformis"),
            41: #imageLiteral(resourceName: "Adductor"),
            42: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            43: #imageLiteral(resourceName: "Hamstring and Glute"),
            44: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            45: #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
            // Dynamic Warm Up Drills
            46: #imageLiteral(resourceName: "Squat"),
            47: #imageLiteral(resourceName: "Squat"),
            48: #imageLiteral(resourceName: "Squat"),
            49: #imageLiteral(resourceName: "Squat"),
            50: #imageLiteral(resourceName: "Squat"),
            51: #imageLiteral(resourceName: "Squat"),
            52: #imageLiteral(resourceName: "Squat"),
            53: #imageLiteral(resourceName: "Squat"),
            54: #imageLiteral(resourceName: "Squat"),
            // Accessory
            55: #imageLiteral(resourceName: "Lat"),
            56: #imageLiteral(resourceName: "Calf"),
            57: #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
            58: #imageLiteral(resourceName: "Back and Bicep")
    ]
    
    // Explanation Array
    var explanationArray: [Int : String] =
        [
            // Mandatory
            0: "5minCardioLE",
            1: "5minCardioIE",
            // Joint Rotations
            2: "wristE",
            3: "elbowE",
            4: "shoulderE",
            5: "neckE",
            6: "waistE",
            7: "hipE",
            8: "kneesE",
            9: "anklesE",
            // Foam/Ball Roll
            10: "backfE",
            11: "thoracicSpineE",
            12: "latE",
            13: "pecDeltE",
            14: "rearDeltE",
            15: "quadfE",
            16: "adductorfE",
            17: "hamstringfE",
            18: "glutefE",
            19: "calvefE",
            // Back
            20: "sideLegDropE",
            21: "sideLegKickE",
            22: "scorpionKickE",
            23: "sideBendE",
            24: "catCowE",
            // Shoulder
            25: "wallSlidesE",
            26: "superManShoulderE",
            27: "scapulaE",
            28: "shoulderRotationE",
            // Band/Bar/Machine Assisted
            29: "facePullE",
            30: "externalRotationE",
            31: "internalRotationE",
            32: "shoulderDislocationE",
            33: "rearDeltFlyE",
            34: "latPulloverE",
            // General Mobility
            35: "rollBackE",
            36: "hipCirclesE",
            37: "mountainClimberE",
            38: "groinStretchE",
            39: "gluteBridgeE",
            40: "threadTheNeedleE",
            41: "butterflyPoseE",
            42: "cossakSquatE",
            43: "hipHingesE",
            44: "sideLegSwingsE",
            45: "frontLegSwingsE",
            // Dynamic Warm Up Drills
            46: "jumpSquatE",
            47: "lungeE",
            48: "gluteKicksE",
            49: "aSkipsE",
            50: "bSkipsE",
            51: "grapeVinesE",
            52: "lateralBoundE",
            53: "straightLegBoundE",
            54: "sprintsE",
            // Accessory
            55: "latStretchE",
            56: "calveStretchE",
            57: "pushUpE",
            58: "pullUpE"
    ]
    
    
    //
    // Sets Reps Picker View
    //
    var setsPickerArray: [Int] = [1, 2, 3, 4, 5, 6]
    //                              // Reps                                      Rep Range§                     // Seconds
    var repsPickerArray: [String] = ["1", "3", "5", "8", "10", "12", "15", "20", "3-5", "5-8", "8-12", "15-20", "15", "30", "60", "90"]
    
    
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
    
    // Information View
    let informationView = UIScrollView()
    // Information Title Label
    let informationTitle = UILabel()
    
    // Session Picker View
    @IBOutlet weak var sessionPickerView: UIPickerView!
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
    // Add Preset
    @IBOutlet weak var addPreset: UIButton!
    @IBOutlet weak var removePreset: UIButton!
    
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
// View will Appear  ------------------------------------------------------------------------------------------------
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    }
    

//
// View did load  ---------------------------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        questionMark.tintColor = colour1
        
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
        addPreset.tintColor = colour2
        
        // Minus Button Colour
        let origImage2 = UIImage(named: "Minus")
        let tintedImage2 = origImage2?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        removePreset.setImage(tintedImage2, for: .normal)
        //Image Tint
        removePreset.tintColor = colour2
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.setTitleColor(colour2, for: .normal)
        
        // Information
        //
        // Scroll View Frame
        informationView.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        informationView.backgroundColor = colour1
        // Information Text
        //
        // Information Text Frame
        let informationText = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationView.frame.size.width - 40, height: 0))
        // Information Text Frame
        informationTitle.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 49)
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
        let informationLabelString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("warmupChoiceText", comment: "")))
        // Range of String
        let textRangeString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("warmupChoiceText", comment: "")))
        let textRange = (informationLabelString as NSString).range(of: textRangeString)
        // Range of Titles
        let titleRangeString = (NSLocalizedString("movements", comment: ""))
        let titleRange1 = (informationLabelString as NSString).range(of: titleRangeString)
        // Line Spacing
        let lineSpacing = NSMutableParagraphStyle()
        lineSpacing.lineSpacing = 1.6
        lineSpacing.hyphenationFactor = 1
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-thin", size: 21)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 21)!, range: titleRange1)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        // Final Text Editing
        informationText.attributedText = informationLabelText
        informationText.textAlignment = .justified
        informationText.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationText.numberOfLines = 0
        informationText.sizeToFit()
        self.informationView.addSubview(informationText)
        //
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationText.frame.size.height + informationTitle.frame.size.height + 20)
        
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
    }

    
//
// Begin button check enabled func ------------------------------------------------------------------------------------------------
//
    // Button Enabled
    func beginButtonEnabled() {
        // Begin Button
        let defaults = UserDefaults.standard
        var warmupPreset = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]

        if customTableView.isEditing {
            beginButton.isEnabled = false
        } else {
            if warmupPreset.count == 0 {
                beginButton.isEnabled = false
            } else {
                if warmupPreset[sessionPickerView.selectedRow(inComponent: 0)].count == 0 {
                    beginButton.isEnabled = false
                } else {
                    beginButton.isEnabled = true
                }
            }
        }
    }
    
    
//
// Custom Sessions -----------------------------------------------------------------------------------------------------
//
    // Set Personalized Preset
    var okAction = UIAlertAction()
    //
    @IBAction func addCustomWarmup(_ sender: Any) {
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
                // Flash Screen
                self.flashScreen()
                self.sessionPickerView.reloadAllComponents()
                self.customTableView.reloadData()
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
    @IBAction func removeCustomWarmup(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        var customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
        var presetTextArray = defaults.object(forKey: "warmupPresetTextsCustom") as! [String]
        //
        var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
        //
        let selectedRow = sessionPickerView.selectedRow(inComponent: 0)
        //
        let inputTitle = NSLocalizedString("warmupRemoveTitle", comment: "")
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
                defaults.set(customKeyArray, forKey: "warmupPresetsCustom")
                //
                presetTextArray.remove(at: selectedRow)
                defaults.set(presetTextArray, forKey: "warmupPresetTextsCustom")
                //
                customSetsArray.remove(at: selectedRow)
                defaults.set(customSetsArray, forKey: "warmupSetsCustom")
                //
                customRepsArray.remove(at: selectedRow)
                defaults.set(customRepsArray, forKey: "warmupRepsCustom")
                //
                defaults.synchronize()
                // Flash Screen
                self.flashScreen()
                self.sessionPickerView.reloadAllComponents()
                self.customTableView.reloadData()
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
            let titleDataArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
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
            let titleDataArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
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
                case 12:
                    repsLabel.text = "       " + String(repsPickerArray[row]) + " " + NSLocalizedString("sec", comment: "")
                //
                case 2...11, 13...15:
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
            } else if component == 1 {
                //
                let componentWidth = setsRepsPicker.frame.size.width / 3
                let componentWidthFourth = componentWidth / 4
                //
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
            let titleDataArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
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
            let customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
            let customTitleArray = defaults.object(forKey: "warmupPresetTextsCustom") as! [String]
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
                    cell.textLabel?.text = NSLocalizedString(warmupMovementsDictionary[keyIndex]!, comment: "")
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
                    cell.imageView?.image = #imageLiteral(resourceName: "Test")
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
            cell.imageView?.image = #imageLiteral(resourceName: "Test")
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
            let customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
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
        var customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
        //
        var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
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
            defaults.set(customKeyArray, forKey: "warmupPresetsCustom")
            // sets
            customSetsArray[sessionPickerView.selectedRow(inComponent: 0)].append(0)
            defaults.set(customSetsArray, forKey: "warmupSetsCustom")
            // reps
            customRepsArray[sessionPickerView.selectedRow(inComponent: 0)].append(0)
            defaults.set(customRepsArray, forKey: "warmupRepsCustom")
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
        }
    }
    
    
//
// TableView Editing -----------------------------------------------------------------------------------------------------
//
    // Can edit row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //
        let defaults = UserDefaults.standard
        let customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
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
        let customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
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
        var customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
        var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
        var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
        // Key
        let itemToMove = customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: sourceIndexPath.row)
        customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].insert(itemToMove, at: destinationIndexPath.row)
        //
        defaults.set(customKeyArray, forKey: "warmupPresetsCustom")
        // Sets
        let setToMove = customSetsArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: sourceIndexPath.row)
        customSetsArray[sessionPickerView.selectedRow(inComponent: 0)].insert(setToMove, at: destinationIndexPath.row)
        //
        defaults.set(customSetsArray, forKey: "warmupSetsCustom")
        // Reps
        let repToMove = customRepsArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: sourceIndexPath.row)
        customRepsArray[sessionPickerView.selectedRow(inComponent: 0)].insert(repToMove, at: destinationIndexPath.row)
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
            var customKeyArray = defaults.object(forKey: "warmupPresetsCustom") as! [[Int]]
            var customSetsArray = defaults.object(forKey: "warmupSetsCustom") as! [[Int]]
            var customRepsArray = defaults.object(forKey: "warmupRepsCustom") as! [[Int]]
            // Key
            customKeyArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: indexPath.row)
            defaults.set(customKeyArray, forKey: "warmupPresetsCustom")
            // sets
            customSetsArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: indexPath.row)
            defaults.set(customSetsArray, forKey: "warmupSetsCustom")
            // reps
            customRepsArray[sessionPickerView.selectedRow(inComponent: 0)].remove(at: indexPath.row)
            defaults.set(customRepsArray, forKey: "warmupRepsCustom")
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
            self.sessionPickerView.isUserInteractionEnabled = true
            self.beginButton.isEnabled = true
        //
        } else {
            self.customTableView.setEditing(true, animated: true)
            self.editingButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
            self.sessionPickerView.isUserInteractionEnabled = false
            self.beginButton.isEnabled = false
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
        customSetsArray[sessionPickerView.selectedRow(inComponent: 0)][selectedRow] = setsRepsPicker.selectedRow(inComponent: 0)
        defaults.set(customSetsArray, forKey: "warmupSetsCustom")
        //
        customRepsArray[sessionPickerView.selectedRow(inComponent: 0)][selectedRow] = setsRepsPicker.selectedRow(inComponent: 1)
        defaults.set(customRepsArray, forKey: "warmupRepsCustom")
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
// Information Actions ------------------------------------------------------------------------------------------------
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
// Information Actions ------------------------------------------------------------------------------------------------
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
        //expandedImage.image = demonstrationArray[section][row]
        expandedImage.image = #imageLiteral(resourceName: "Test 2")
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
            self.questionMark.isEnabled = true
            self.navigationItem.setHidesBackButton(false, animated: true)
        }
    }
    
    
    
//
// Begin Button ------------------------------------------------------------------------------------------------
//
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        
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
// Pass Arrays ------------------------------------------------------------------------------------------------
//
    
//    // Pass Array to next ViewController
//    //
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "warmupSessionSegue1") {
//            
//            
//            let destinationNC = segue.destination as! UINavigationController
//            
//            let destinationVC = destinationNC.viewControllers.first as! WarmupScreen
//            
//            destinationVC.warmupMovementsArray = warmupMovementsArray
//            destinationVC.warmupMovementsSelectedArray = warmupSelectedArray
//            
//            
//            destinationVC.setsArrayF = setsArrayF
//            destinationVC.repsArrayF = repsArrayF
//            destinationVC.demonstrationArrayF = demonstrationArrayF
//            destinationVC.targetAreaArrayF = targetAreaArrayF
//            destinationVC.explanationArrayF = explanationArrayF
//            
//            
//        } else if (segue.identifier == "warmupSessionSegue2") {
//            
//            
//            let destinationNC = segue.destination as! UINavigationController
//            
//            let destinationVC = destinationNC.viewControllers.first as! WarmupScreenOverview
//            
//            destinationVC.warmupMovementsArray = warmupMovementsArray
//            destinationVC.warmupMovementsSelectedArray = warmupSelectedArray
//            
//            
//            destinationVC.setsArrayF = setsArrayF
//            destinationVC.repsArrayF = repsArrayF
//            destinationVC.demonstrationArrayF = demonstrationArrayF
//            destinationVC.targetAreaArrayF = targetAreaArrayF
//            destinationVC.explanationArrayF = explanationArrayF
//            
//            let pickerIndex = pickerView.selectedRow(inComponent: 0)
//            if pickerIndex < pickerViewArray.count - 1 {
//                destinationVC.warmupTitle = pickerViewArray[pickerIndex]
//            } else if pickerIndex > pickerViewArray.count - 1 {
//                let pickerArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
//                destinationVC.warmupTitle = pickerArray[pickerIndex - pickerViewArray.count]
//            }
//        }
//    }
//    
 
    
    
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
    
    
    
}
