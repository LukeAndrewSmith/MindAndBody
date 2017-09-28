//
//  FinalChoiceCustom.swift
//  MindAndBody
//
//  Created by Luke Smith on 20.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Workout Choice Custom --------------------------------------------------------------------------------------
//
//class FinalChoiceCustom: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
//    
//    //

// Warmup, Workout, Cardio, Stretching, Yoga
var customSessionsRegister: [[[Any]]] =
    [
        // Warmup
        // [name] - string, [movements] - int, [sets] - int, [reps] - string
        [],
        // Workout
        // [name] - string, [movements] - int, [sets] - int, [reps] - string
        [],
        // Workout - Circuit
        // [name] - string, [movements] - int, [rounds] - int, [reps] - string
        [],
        // Cardio
        // [name] - string, [movements] - int, [time/distance] - int
        [],
        // Stretching
        // [name] - string, [stretches] - int, [breaths] - int
        [],
        // Yoga
        // [name] - string, [stretches] - int, [poses] - int
        []
]

    // Empty Session, Warmup, Workout, Workout - circuit - [string],[int],[int],[int]
    var emptySessionFour: [[Any]] =
        [
            // Name - String
            [],
            // Movements - Int
            [],
            // Sets - Int
            [],
            // Reps - String?
            []
    ]
    
    // Empty Session, Cardio, Stretching, Yoga, - [string],[int],[int]
    var emptySessionThree: [[Any]] =
        [
            // Name - String
            [],
            // Movements - Int
            [],
            // Rounds - Int
            [],
            // Reps - String?
            []
]
//
//    //
//    // Selected row
//    var selectedRow = Int()
//    var selectedSection = Int()
//    
//    //
//    var selectedPreset = -1
//    
//    //
//    var selectingNumberOfRounds = false
//    
//    // Classic (0) or circuit (1)
//    var selectedType = Int()
//    
//    //
//    var workoutArray: [String] = []
//    //
//    var demonstrationArray: [[UIImage]] = []
//    //
//    var targetAreaArray: [UIImage] = []
//    //
//    var explanationArray: [String] = []
//    
//    //
//    var setsArray: [Int] = []
//    //
//    var repsArray: [String] = []
//    //
//    var repsArrayC: [[String]] = []
//
//    
//    //
//    // Sets Reps Picker View
//    //
//    var setsPickerArray: [Int] = [1, 2, 3, 4, 5, 6]
//    //                              // Reps                                      Rep Ranges                     // Seconds
//    var repsPickerArray: [String] = ["1", "3", "5", "8", "10", "12", "15", "20", "3-5", "5-8", "8-12", "15-20", "15s", "30s", "60s", "90s"]
//    
//    //
//    var repsPickerArrayCircuit: [String] = ["5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60", "65", "70", "75", "80", "85", "90", "95"]
//    
//    //
//    var roundsPickerArray: [Int] = [2, 3, 4, 5, 6, 7, 8, 9]
//    
//    //
//    // Outlets ---------------------------------------------------------------------------------------------------------------------------
//    //
//    // Navigation Bar
//    @IBOutlet weak var navigationBar: UINavigationItem!
//    
//    // Presets
//    @IBOutlet weak var presetsButtonClassic: UIButton!
//    @IBOutlet weak var presetsButtonCircuit: UIButton!
//    
//    // Begin Button
//    @IBOutlet weak var beginButton: UIButton!
//    
//    // Table View
//    @IBOutlet weak var customTableView: UITableView!
//    
//    
//    // Editing
//    @IBOutlet weak var editingButton: UIButton!
//    //
//    
//    // Number of Rounds
//    @IBOutlet weak var numberOfRounds: UIButton!
//    
//    
//    //
//    // Constraints
//    @IBOutlet weak var presetsClassicTop: NSLayoutConstraint!
//    @IBOutlet weak var presetsClassicBottom: NSLayoutConstraint!
//    @IBOutlet weak var presetsCircuitTop: NSLayoutConstraint!
//    @IBOutlet weak var presetsCircuitBottom: NSLayoutConstraint!
//    //
//    @IBOutlet weak var editConstraint: NSLayoutConstraint!
//    @IBOutlet weak var numberOfRoundsConstraint: NSLayoutConstraint!
//    @IBOutlet weak var tableViewConstraintTop: NSLayoutConstraint!
//    @IBOutlet weak var tableViewConstraintBottom: NSLayoutConstraint!
//    @IBOutlet weak var beginButtonConstraint: NSLayoutConstraint!
//    
//    
//    //
//    let emptyString = ""
//    
//    // Presets
//    var presetsTableView = UITableView()
//    
//    // Elements for cell actions
//    //
//    // Add movement
//    var movementsTableView = UITableView()
//    var backgroundViewExpanded = UIButton()
//    
//    // Sets and Reps Choice
//    var setsRepsView = UIView()
//    var setsRepsPicker = UIPickerView()
//    var okButton = UIButton()
//    //
//    let setsIndicatorLabel = UILabel()
//    
//    
//    //
//    // View Will Appear
//    //
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        presetsButtonClassic.setTitle(NSLocalizedString("customWorkoutClassic", comment: ""), for: .normal)
//        presetsButtonCircuit.setTitle(NSLocalizedString("customWorkoutCircuit", comment: ""), for: .normal)
//    }
//    
//    //
//    // View did load  ---------------------------------------------------------------------------------------------------------------------------
//    //
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //
//        // Preset Workouts
//        //
//        let defaults = UserDefaults.standard
//        //
//        // Classic
//        defaults.register(defaults: ["workoutPresetsCustomClassic" : emptyArrayOfArrays])
//        defaults.register(defaults: ["workoutPresetTextsCustomClassic" : presetTexts])
//        //
//        defaults.register(defaults: ["workoutSetsCustomClassic" : emptyArrayOfArrays])
//        defaults.register(defaults: ["workoutRepsCustomClassic" : emptyArrayOfArrays])
//        //
//        // Circuit
//        defaults.register(defaults: ["workoutPresetsCustomCircuit" : emptyArrayOfArrays])
//        defaults.register(defaults: ["workoutPresetTextsCustomCircuit" : presetTexts])
//        //
//        defaults.register(defaults: ["workoutRoundsCustomCircuit" : emptyArrayOfInt])
//        //
//        defaults.register(defaults: ["workoutRepsCustomCircuit" : emptyArrayOfArraysOfArrays])
//        //
//        //
//        defaults.synchronize()
//        
//        //
//        // Initial Element Positions
//        //
//        presetsClassicTop.constant = 0
//        presetsClassicBottom.constant = view.frame.size.height/2
//        presetsCircuitTop.constant = view.frame.size.height/2
//        presetsCircuitBottom.constant = 0
//        editConstraint.constant = view.frame.size.height
//        numberOfRoundsConstraint.constant = view.frame.size.height
//        //
//        tableViewConstraintTop.constant = view.frame.size.height
//        tableViewConstraintBottom.constant = -49
//        //
//        beginButtonConstraint.constant = -49
//        
//        // Colour
//        self.view.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
//        
//        //
//        presetsButtonClassic.backgroundColor = colour2
//        presetsButtonCircuit.backgroundColor = colour2
//        
//        // Navigation Bar Title
//        navigationBar.title = NSLocalizedString("custom", comment: "")
//        
//        // Number of Rounds
//        let roundNumber = defaults.object(forKey: "workoutRoundsCustomCircuit") as! [Int]
//        if selectedPreset > -1 {
//            numberOfRounds.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String(roundNumber[selectedPreset]), for: .normal)
//        }
//        numberOfRounds.setTitleColor(colour2, for: .normal)
//        //numberOfRounds.backgroundColor = .white
//        //numberOfRounds.layer.cornerRadius = 5
//        //numberOfRounds.clipsToBounds = true
//        
//        // TableView Editing
//        // Start
//        editingButton.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
//        editingButton.setTitleColor(colour2, for: .normal)
//        
//        
//        // Begin Button Title
//        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
//        beginButton.backgroundColor = colour3
//        beginButton.setTitleColor(colour2, for: .normal)
//        
//        
//        
//        // Presets TableView
//        //
//        let tableViewBackground2 = UIView()
//        //
//        tableViewBackground2.backgroundColor = colour2
//        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
//        //
//        presetsTableView.backgroundView = tableViewBackground2
//        presetsTableView.tableFooterView = UIView()
//        // TableView Cell action items
//        //
//        presetsTableView.backgroundColor = colour2
//        presetsTableView.delegate = self
//        presetsTableView.dataSource = self
//        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
//        presetsTableView.layer.cornerRadius = 5
//        presetsTableView.layer.masksToBounds = true
//        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        
//        
//        
//        // TableView
//        //
//        // TableView Background
//        let tableViewBackground = UIView()
//        //
//        tableViewBackground.backgroundColor = colour2
//        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.customTableView.frame.size.width, height: self.customTableView.frame.size.height)
//        //
//        customTableView.backgroundView = tableViewBackground
//        // TableView Cell action items
//        //
//        // Movement table
//        movementsTableView.backgroundColor = colour2
//        movementsTableView.delegate = self
//        movementsTableView.dataSource = self
//        movementsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
//        movementsTableView.layer.cornerRadius = 5
//        movementsTableView.layer.masksToBounds = true
//        //
//        // Sets Reps Selection
//        // view
//        setsRepsView.backgroundColor = colour2
//        setsRepsView.layer.cornerRadius = 5
//        setsRepsView.layer.masksToBounds = true
//        // picker
//        setsRepsPicker.backgroundColor = colour2
//        setsRepsPicker.delegate = self
//        setsRepsPicker.dataSource = self
//        // ok
//        okButton.backgroundColor = colour1
//        okButton.setTitleColor(colour2, for: .normal)
//        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
//        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
//        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
//        // sets
//        setsIndicatorLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
//        setsIndicatorLabel.textColor = colour1
//        setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
//        //
//        setsRepsView.addSubview(setsRepsPicker)
//        setsRepsView.addSubview(okButton)
//        setsRepsView.addSubview(setsIndicatorLabel)
//        setsRepsView.bringSubview(toFront: setsIndicatorLabel)
//        //
//        // Background View
//        backgroundViewExpanded.backgroundColor = .black
//        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
//        //
//    }
//    
//    
//    var didLayout = false
//    //
//    // View did layout subviews Actions -------------------------------------------------------------------------------------------------
//    //
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        //
//        // Initial Element Positions
//        //
//        if didLayout == false {
//            presetsClassicTop.constant = 0
//            presetsClassicBottom.constant = view.frame.size.height/2
//            presetsCircuitTop.constant = view.frame.size.height/2
//            presetsCircuitBottom.constant = 0
//            editConstraint.constant = view.frame.size.height
//            numberOfRoundsConstraint.constant = view.frame.size.height
//            //
//            tableViewConstraintTop.constant = view.frame.size.height
//            tableViewConstraintBottom.constant = -49
//            //
//            beginButtonConstraint.constant = -49
//            //
//            didLayout = true
//        } else {
//            
//        }
//        
//        
//        // TableView Footer
//        let footerView = UIView(frame: .zero)
//        footerView.backgroundColor = .clear
//        customTableView.tableFooterView = footerView
//        //
//    }
//    
//    
//    //
//    // Elements check enabled funcs ------------------------------------------------------------------------------
//    //
//    // Button Enabled
//    func beginButtonEnabled() {
//        // Begin Button
//        let defaults = UserDefaults.standard
//        var customKeyArray: [[Int]] = []
//        //
//        switch selectedType {
//        case 0:
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//        //
//        case 1:
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//        //
//        default: break
//        }
//        
//        //
//        if customTableView.isEditing {
//            beginButton.isEnabled = false
//        } else {
//            if selectedPreset == -1 {
//                
//            } else {
//                if customKeyArray[selectedPreset].count == 0 {
//                    beginButton.isEnabled = false
//                } else {
//                    beginButton.isEnabled = true
//                }
//            }
//        }
//    }
//    
//    // Edit Button Enabled
//    func editButtonEnabled() {
//        //
//        let defaults = UserDefaults.standard
//        var customKeyArray: [[Int]] = []
//        //
//        switch selectedType {
//        case 0:
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//        //
//        case 1:
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//        //
//        default: break
//        }//
//        //
//        if customKeyArray.count == 0 {
//            editingButton.isEnabled = false
//        } else {
//            if customKeyArray[selectedPreset].count == 0 {
//                editingButton.isEnabled = false
//            } else {
//                editingButton.isEnabled = true
//            }
//        }
//    }
//    
//    
//    
//    //
//    // Picker View ----------------------------------------------------------------------------------------------------
//    //
//    // Number of components
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        // Number of Rounds
//        if selectingNumberOfRounds == true {
//            return 1
//            // Other
//        } else {
//            //
//            switch selectedType {
//            case -1: return 0
//            case 0: return 2
//            case 1: return 1
//            default: break
//            }
//        }
//        return 0
//    }
//    
//    // Number of rows
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        // Number of Rounds
//        if selectingNumberOfRounds == true {
//            return roundsPickerArray.count
//            
//        } else {
//            
//            // Other
//            switch selectedType {
//            case 0:
//                if component == 0 {
//                    return setsPickerArray.count
//                } else {
//                    return repsPickerArray.count
//                }
//            case 1:
//                return repsPickerArrayCircuit.count
//            default: break
//            }
//        }
//        return 0
//    }
//    
//    // View for row
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        // Number of Rounds
//        if selectingNumberOfRounds == true {
//            let roundLabel = UILabel()
//            roundLabel.text = String(roundsPickerArray[row])
//            roundLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
//            roundLabel.textColor = colour1
//            //
//            roundLabel.textAlignment = .center
//            return roundLabel
//            //
//            
//            // Other
//        } else {
//            //
//            switch selectedType {
//            case 0:
//                //
//                if component == 0 {
//                    let setsLabel = UILabel()
//                    setsLabel.text = String(setsPickerArray[row])
//                    setsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
//                    setsLabel.textColor = colour1
//                    //
//                    setsLabel.textAlignment = .center
//                    return setsLabel
//                    //
//                } else if component == 1 {
//                    //
//                    let repsLabel = UILabel()
//                    // Row Label Text
//                    switch row {
//                    //
//                    case 0:
//                        repsLabel.text = "        " + String(repsPickerArray[row]) + "  " + NSLocalizedString("rep", comment: "")
//                    //
//                    case 1:
//                        repsLabel.text = "         " + String(repsPickerArray[row]) + " " + NSLocalizedString("reps", comment: "")
//                    //
//                    case 2...15:
//                        repsLabel.text = String(repsPickerArray[row])
//                    //
//                    default: break
//                    }
//                    repsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
//                    repsLabel.textColor = colour1
//                    repsLabel.textAlignment = .center
//                    return repsLabel
//                    //
//                }
//            case 1:
//                let repsLabel = UILabel()
//                repsLabel.text = String(repsPickerArrayCircuit[row])
//                repsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
//                repsLabel.textColor = colour1
//                //
//                repsLabel.textAlignment = .center
//                return repsLabel
//            //
//            default: break
//            }
//        }
//        return UIView()
//    }
//    
//    // Row height
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 30
//    }
//    
//    // Width
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        // Number of Rounds
//        if selectingNumberOfRounds == true {
//            return setsRepsPicker.frame.size.width
//            
//            // Other
//        } else {
//            switch selectedType {
//            case 0:
//                //
//                if component == 0 {
//                    return (setsRepsPicker.frame.size.width / 3)
//                } else if component == 1{
//                    return (setsRepsPicker.frame.size.width / 3)
//                }
//            case 1:
//                return setsRepsPicker.frame.size.width
//            default: break
//            }
//        }
//        return 0
//    }
//    
//    // Did select row
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        // Number of Rounds
//        if selectingNumberOfRounds == true {
//        } else {
//            //
//            switch selectedType {
//            case 0:
//                //
//                if component == 0{
//                    //
//                    if row == 0 {
//                        self.setsIndicatorLabel.text = NSLocalizedString("set", comment: "")
//                    } else {
//                        self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
//                    }
//                    // Row Label
//                    //
//                } else {
//                }
//            default: break
//            }
//        }
//    }
//    
//    
//    //
//    // Table View ------------------------------------------------------------------------------------------------------------
//    //
//    // Number of Sections
//    func numberOfSections(in tableView: UITableView) -> Int {
//        
//        switch tableView {
//        case presetsTableView: return 1
//        case customTableView:
//            switch selectedType {
//            case 0:
//                return 1
//            case 1:
//                let roundNumber = UserDefaults.standard.object(forKey: "workoutRoundsCustomCircuit") as! [Int]
//                return roundNumber[selectedPreset]
//            default: break
//            }
//        case movementsTableView:
//            return tableViewSectionArray.count
//        default: break
//        }
//        return 0
//    }
//    
//    // Title for header
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        //
//        switch tableView {
//        case presetsTableView:
//            switch selectedType {
//            case 0:
//                return " " + NSLocalizedString("customWorkoutClassic", comment: "")
//            case 1:
//                return " " + NSLocalizedString("customWorkoutCircuit", comment: "")
//            default: break
//            }
//        //
//        case customTableView:
//            //
//            switch selectedType {
//            case 0:
//                var titleDataArray: [String] = []
//                //
//                switch selectedType {
//                case 0:
//                    // Retreive Preset Workouts
//                    titleDataArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomClassic") as! [String]
//                case 1:
//                    // Retreive Preset Workouts
//                    titleDataArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomCircuit") as! [String]
//                default: break
//                }
//                //
//                if titleDataArray.count != 0 {
//                    return titleDataArray[selectedPreset]
//                } else {
//                    return " "
//                }
//            case 1:
//                return " " + NSLocalizedString("round", comment: "") + " " + String(section + 1)
//            default: break
//            }
//        //
//        case movementsTableView:
//            return NSLocalizedString(tableViewSectionArray[section], comment: "")
//        default: break
//        }
//        return ""
//    }
//    
//    // Will display header
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//    {
//        switch tableView {
//        case presetsTableView:
//            let header = view as! UITableViewHeaderFooterView
//            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 17)!
//            header.textLabel?.textColor = colour1
//            header.contentView.backgroundColor = colour2
//            header.contentView.tintColor = colour1
//        case customTableView:
//            let header = view as! UITableViewHeaderFooterView
//            header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)!
//            header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
//            header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
//            header.contentView.tintColor = colour1
//        //
//        case movementsTableView:
//            let header = view as! UITableViewHeaderFooterView
//            header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)!
//            header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
//            header.textLabel?.adjustsFontSizeToFitWidth = true
//            header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
//            header.contentView.tintColor = colour1
//        //
//        default: break
//        }
//        
//    }
//    
//    // Number of rows
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //
//        switch tableView {
//        case presetsTableView:
//            switch selectedType {
//            case 0:
//                // Retreive Preset Workouts
//                let presetsArrayClassic = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomClassic") as! [String]
//                return presetsArrayClassic.count + 1
//            case 1:
//                // Retreive Preset Workouts
//                let presetsArrayCircuit = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomCircuit") as! [String]
//                return presetsArrayCircuit.count + 1
//            default: return 0
//            }
//            
//        //
//        case customTableView:
//            //
//            let defaults = UserDefaults.standard
//            var customKeyArray: [[Int]] = []
//            //
//            switch selectedType {
//            case 0:
//                customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//            case 1:
//                customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//            default: break
//            }
//            //
//            switch selectedType {
//            case 0:
//                if customKeyArray.count == 0 {
//                    return 1
//                } else {
//                    return customKeyArray[selectedPreset].count + 1
//                }
//            case 1:
//                if customKeyArray.count == 0 {
//                    return 1
//                } else {
//                    if section == 0 {
//                        return customKeyArray[selectedPreset].count + 1
//                    } else {
//                        return customKeyArray[selectedPreset].count
//                    }
//                }
//            default: break
//            }
//            
//        //
//        case movementsTableView:
//            //
//            return fullKeyArray[section].count
//        //
//        default: break
//        }
//        return 0
//    }
//    
//    // Cell for row
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //
//        switch tableView {
//        case presetsTableView:
//            var cell = UITableViewCell()
//            cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//            cell.textLabel?.adjustsFontSizeToFitWidth = true
//            //
//            // Retreive Preset Workouts
//            var presetsArray: [String] = []
//            switch selectedType {
//            case 0:
//                presetsArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomClassic") as! [String]
//            case 1:
//                presetsArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomCircuit") as! [String]
//            default: break
//            }
//            //
//            cell.textLabel?.textAlignment = .center
//            cell.backgroundColor = colour1
//            cell.textLabel?.textColor = colour2
//            cell.tintColor = colour2
//            //
//            if indexPath.row == presetsArray.count {
//                //
//                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
//                //
//                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
//                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
//                //
//            } else {
//                //
//                cell.textLabel?.text = presetsArray[indexPath.row]
//            }
//            //
//            return cell
//        //
//        case customTableView:
//            //
//            let defaults = UserDefaults.standard
//            var customKeyArray: [[Int]] = []
//            //
//            var customSetsArray: [[Int]] = []
//            //
//            var customRepsArray: [[Int]] = []
//            var customRepsArrayC: [[[Int]]] = []
//            //
//            switch selectedType {
//            case 0:
//                customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//                //
//                customSetsArray = defaults.object(forKey: "workoutSetsCustomClassic") as! [[Int]]
//                customRepsArray = defaults.object(forKey: "workoutRepsCustomClassic") as! [[Int]]
//            case 1:
//                customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//                //
//                customRepsArrayC = defaults.object(forKey: "workoutRepsCustomCircuit") as! [[[Int]]]
//            default: break
//            }
//            //
//            switch indexPath.section {
//            case 0:
//                if customKeyArray.count == 0 {
//                    //
//                    let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//                    //
//                    cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//                    cell.tintColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
//                    //
//                    cell.imageView?.image = #imageLiteral(resourceName: "Plus")
//                    //
//                    cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
//                    cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
//                    //
//                    return cell
//                    //
//                } else {
//                    //
//                    if indexPath.row == customKeyArray[selectedPreset].count  {
//                        //
//                        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//                        //
//                        cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//                        cell.tintColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
//                        //
//                        cell.imageView?.image = #imageLiteral(resourceName: "Plus")
//                        //
//                        cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
//                        cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
//                        //
//                        return cell
//                        //
//                    } else {
//                        //
//                        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//                        //
//                        let keyIndex = customKeyArray[selectedPreset][indexPath.row]
//                        cell.textLabel?.text = NSLocalizedString(workoutMovementsDictionary[keyIndex]!, comment: "")
//                        //
//                        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//                        cell.textLabel?.adjustsFontSizeToFitWidth = true
//                        cell.textLabel?.textAlignment = .left
//                        cell.backgroundColor = colour1
//                        cell.textLabel?.textColor = colour2
//                        cell.tintColor = .black
//                        // Detail sets x reps
//                        cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
//                        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
//                        cell.detailTextLabel?.textAlignment = .left
//                        cell.detailTextLabel?.textColor = colour2
//                        //
//                        switch selectedType {
//                        case 0:
//                            cell.detailTextLabel?.text = String(setsPickerArray[customSetsArray[selectedPreset][indexPath.row]]) + " x " + repsPickerArray[customRepsArray[selectedPreset][indexPath.row]]
//                        case 1:
//                            cell.detailTextLabel?.text = repsPickerArrayCircuit[customRepsArrayC[selectedPreset][indexPath.section][indexPath.row]] + " " + NSLocalizedString("reps", comment: "")
//                        default: break
//                        }
//                        //
//                        // Cell Image
//                        cell.imageView?.image = demonstrationDictionary[keyIndex]?[0]
//                        cell.imageView?.isUserInteractionEnabled = true
//                        // Image Tap
//                        let imageTap = UITapGestureRecognizer()
//                        imageTap.numberOfTapsRequired = 1
//                        imageTap.addTarget(self, action: #selector(handleTap))
//                        cell.imageView?.addGestureRecognizer(imageTap)
//                        //
//                        return cell
//                    }
//                }
//            default:
//                //
//                if indexPath.row == customKeyArray[selectedPreset].count  {
//                    //
//                    let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//                    //
//                    cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//                    cell.tintColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
//                    //
//                    cell.imageView?.image = #imageLiteral(resourceName: "Plus")
//                    //
//                    cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
//                    cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
//                    //
//                    return cell
//                    //
//                } else {
//                    //
//                    let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//                    //
//                    let keyIndex = customKeyArray[selectedPreset][indexPath.row]
//                    cell.textLabel?.text = NSLocalizedString(workoutMovementsDictionary[keyIndex]!, comment: "")
//                    //
//                    cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//                    cell.textLabel?.adjustsFontSizeToFitWidth = true
//                    cell.textLabel?.textAlignment = .left
//                    cell.backgroundColor = colour1
//                    cell.textLabel?.textColor = colour2
//                    cell.tintColor = .black
//                    // Detail sets x reps
//                    cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
//                    cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
//                    cell.detailTextLabel?.textAlignment = .left
//                    cell.detailTextLabel?.textColor = colour2
//                    //
//                    switch selectedType {
//                    case 0:
//                        cell.detailTextLabel?.text = String(setsPickerArray[customSetsArray[selectedPreset][indexPath.row]]) + " x " + repsPickerArray[customRepsArray[selectedPreset][indexPath.row]]
//                    case 1:
//                        cell.detailTextLabel?.text = repsPickerArrayCircuit[customRepsArrayC[selectedPreset][indexPath.section][indexPath.row]] + " " + NSLocalizedString("reps", comment: "")
//                    default: break
//                    }
//                    //
//                    // Cell Image
//                    cell.imageView?.image = demonstrationDictionary[keyIndex]?[0]
//                    cell.imageView?.isUserInteractionEnabled = true
//                    // Image Tap
//                    let imageTap = UITapGestureRecognizer()
//                    imageTap.numberOfTapsRequired = 1
//                    imageTap.addTarget(self, action: #selector(handleTap))
//                    cell.imageView?.addGestureRecognizer(imageTap)
//                    //
//                    return cell
//                }
//            }
//        //
//        case movementsTableView:
//            //
//            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//            //
//            let keyIndex = fullKeyArray[indexPath.section][indexPath.row]
//            cell.textLabel?.text = NSLocalizedString(workoutMovementsDictionary[keyIndex]!, comment: "")
//            //
//            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//            cell.textLabel?.adjustsFontSizeToFitWidth = true
//            cell.textLabel?.textAlignment = .left
//            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
//            cell.textLabel?.textColor = .black
//            cell.tintColor = .black
//            // Cell Image
//            cell.imageView?.image = demonstrationDictionary[keyIndex]?[0]
//            cell.imageView?.isUserInteractionEnabled = true
//            // Image Tap
//            let imageTap = UITapGestureRecognizer()
//            imageTap.numberOfTapsRequired = 1
//            imageTap.addTarget(self, action: #selector(handleTap))
//            cell.imageView?.addGestureRecognizer(imageTap)
//            //
//            return cell
//        //
//        default: break
//        }
//        return UITableViewCell()
//    }
//    
//    // Height for row
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        //
//        switch tableView {
//        case presetsTableView:
//            return 44
//        case customTableView:
//            //
//            let defaults = UserDefaults.standard
//            var customKeyArray: [[Int]] = []
//            //
//            switch selectedType {
//            case 0:
//                customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//            case 1:
//                customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//            default: break
//            }
//            //
//            if customKeyArray.count == 0 {
//                return 49
//                //
//            } else {
//                //
//                if indexPath.row == customKeyArray[selectedPreset].count  {
//                    return 49
//                    //
//                } else {
//                    return 72
//                }
//            }
//        case movementsTableView:
//            return 72
//        default: break
//        }
//        return 72
//    }
//    
//    //
//    var okAction = UIAlertAction()
//    // Did select row
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //
//        let defaults = UserDefaults.standard
//        var presetsArray: [String] = []
//        var roundNumber: [Int] = []
//        //
//        var customKeyArray: [[Int]] = []
//        //
//        var customSetsArray: [[Int]] = []
//        var customRepsArray: [[Int]] = []
//        var customRepsArrayC: [[[Int]]] = []
//        //
//        //
//        switch selectedType {
//        case 0:
//            presetsArray = defaults.object(forKey: "workoutPresetTextsCustomClassic") as! [String]
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//            //
//            customSetsArray = defaults.object(forKey: "workoutSetsCustomClassic") as! [[Int]]
//            customRepsArray = defaults.object(forKey: "workoutRepsCustomClassic") as! [[Int]]
//        case 1:
//            presetsArray = defaults.object(forKey: "workoutPresetTextsCustomCircuit") as! [String]
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//            //
//            roundNumber = defaults.object(forKey: "workoutRoundsCustomCircuit") as! [Int]
//            //
//            customRepsArrayC = defaults.object(forKey: "workoutRepsCustomCircuit") as! [[[Int]]]
//        default: break
//        }
//        
//        //
//        switch tableView {
//        case presetsTableView:
//            // Add Custom Workout
//            if indexPath.row == presetsArray.count {
//                let snapShot1 = presetsTableView.snapshotView(afterScreenUpdates: false)
//                snapShot1?.center.x = view.center.x
//                snapShot1?.center.y = presetsTableView.center.y - UIApplication.shared.statusBarFrame.height - (navigationController?.navigationBar.frame.size.height)!
//                view.addSubview(snapShot1!)
//                self.presetsTableView.isHidden = true
//                UIView.animate(withDuration: 0.3, animations: {
//                    self.backgroundViewExpanded.alpha = 0
//                }, completion: { finished in
//                    self.backgroundViewExpanded.isHidden = true
//                })
//                
//                // Alert and Functions
//                //
//                let inputTitle = NSLocalizedString("workoutInputTitle", comment: "")
//                //
//                let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
//                alert.view.tintColor = colour2
//                alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
//                //2. Add the text field
//                alert.addTextField { (textField: UITextField) in
//                    textField.text = " "
//                    textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
//                    textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
//                }
//                // 3. Get the value from the text field, and perform actions upon OK press
//                okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//                    //
//                    let textField = alert?.textFields![0]
//                    // Update Preset Text Arrays
//                    presetsArray.append((textField?.text)!)
//                    // Add New empty array
//                    customKeyArray.append([])
//                    // Add new sets and reps arrays
//                    customSetsArray.append([])
//                    // Add New Number of Rounds
//                    roundNumber.append(2)
//                    //
//                    customRepsArray.append([])
//                    //
//                    customRepsArrayC.append([])
//                    //
//                    let selectedIndexPath = NSIndexPath(row: presetsArray.count - 1, section: 0)
//                    self.presetsTableView.selectRow(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
//                    self.selectedPreset = selectedIndexPath.row
//                    customRepsArrayC[self.selectedPreset].append([])
//                    customRepsArrayC[self.selectedPreset].append([])
//                    //
//                    switch self.selectedType {
//                    case 0:
//                        defaults.set(presetsArray, forKey: "workoutPresetTextsCustomClassic")
//                        defaults.set(customKeyArray, forKey: "workoutPresetsCustomClassic")
//                        //
//                        defaults.set(customSetsArray, forKey: "workoutSetsCustomClassic")
//                        defaults.set(customRepsArray, forKey: "workoutRepsCustomClassic")
//                    case 1:
//                        defaults.set(presetsArray, forKey: "workoutPresetTextsCustomCircuit")
//                        defaults.set(customKeyArray, forKey: "workoutPresetsCustomCircuit")
//                        //
//                        defaults.set(roundNumber, forKey: "workoutRoundsCustomCircuit")
//                        //
//                        defaults.set(customRepsArrayC, forKey: "workoutRepsCustomCircuit")
//                    default: break
//                    }
//                    //
//                    defaults.synchronize()
//                    
//                    let roundNumber = defaults.object(forKey: "workoutRoundsCustomCircuit") as! [Int]
//                    self.numberOfRounds.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String(roundNumber[self.selectedPreset]), for: .normal)
//                    //
//                    //
//                    self.presetsTableView.isHidden = false
//                    snapShot1?.removeFromSuperview()
//                    //
//                    self.backgroundViewExpanded.isHidden = false
//                    UIView.animate(withDuration: 0.3, animations: {
//                        self.backgroundViewExpanded.alpha = 0.5
//                        self.presetsTableView.reloadData()
//                        // Dismiss and select new row
//                    }, completion: { finished in
//                        //
//                        //
//                        switch self.selectedType {
//                        case 0:
//                            presetsArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomClassic") as! [String]
//                        case 1:
//                            presetsArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomCircuit") as! [String]
//                        default: break
//                        }
//                        
//                        //
//                        let selectedIndexPath = NSIndexPath(row: presetsArray.count - 1, section: 0)
//                        self.presetsTableView.selectRow(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
//                        self.selectedPreset = selectedIndexPath.row
//                        //
//                        switch self.selectedType {
//                        case 0:
//                            self.presetsButtonClassic.setTitle("- " + presetsArray[self.selectedPreset] + " -", for: .normal)
//                        case 1:
//                            self.presetsButtonCircuit.setTitle("- " + presetsArray[self.selectedPreset] + " -", for: .normal)
//                        default: break
//                        }
//                        
//                        //
//                        tableView.deselectRow(at: indexPath, animated: true)
//                        // Flash Screen
//                        self.customTableView.reloadData()
//                        //
//                        self.beginButtonEnabled()
//                        self.editButtonEnabled()
//                        
//                        //
//                        // Element Positions
//                        //
//                        switch self.selectedType {
//                        case 0:
//                            //
//                            self.presetsButtonCircuit.alpha = 0
//                            self.presetsButtonCircuit.isEnabled = false
//                            self.presetsCircuitTop.constant = self.view.frame.size.height
//                            self.presetsCircuitBottom.constant = self.view.frame.size.height
//                            //
//                            self.numberOfRoundsConstraint.constant = self.view.frame.size.height
//                            //
//                            self.presetsClassicBottom.constant = self.view.frame.size.height - 73.5
//                        case 1:
//                            //
//                            self.presetsButtonClassic.alpha = 0
//                            self.presetsButtonClassic.isEnabled = false
//                            self.presetsClassicTop.constant = self.view.frame.size.height
//                            self.presetsClassicBottom.constant = self.view.frame.size.height
//                            //
//                            self.numberOfRoundsConstraint.constant = 73.5
//                            
//                            //
//                            self.presetsCircuitBottom.constant = self.view.frame.size.height - 73.5
//                            self.presetsCircuitTop.constant = 0
//                        default: break
//                        }
//                        //
//                        self.editConstraint.constant = 73.5
//                        //
//                        self.tableViewConstraintTop.constant = 122.5
//                        self.tableViewConstraintBottom.constant = 49
//                        //
//                        self.beginButtonConstraint.constant = 0
//                        //
//                        //
//                        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                            //
//                            self.view.layoutIfNeeded()
//                            self.editingButton.alpha = 1
//                            //
//                            self.presetsTableView.frame = CGRect(x: 30, y: self.presetsButtonClassic.frame.minY + UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
//                            self.presetsTableView.alpha = 0
//                            self.backgroundViewExpanded.alpha = 0
//                        }, completion: { finished in
//                            //
//                            self.presetsTableView.removeFromSuperview()
//                            self.backgroundViewExpanded.removeFromSuperview()
//                        })
//                    })
//                })
//                okAction.isEnabled = false
//                alert.addAction(okAction)
//                // Cancel reset action
//                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
//                    UIAlertAction in
//                    //
//                    self.backgroundViewExpanded.isHidden = false
//                    UIView.animate(withDuration: 0.3, animations: {
//                        self.backgroundViewExpanded.alpha = 0.5
//                    })
//                    //
//                    self.presetsTableView.isHidden = false
//                    snapShot1?.removeFromSuperview()
//                }
//                alert.addAction(cancelAction)
//                // 4. Present the alert.
//                self.present(alert, animated: true, completion: nil)
//                //
//                
//                
//                //
//                // Select Custom Workout
//            } else {
//                //
//                selectedPreset = indexPath.row
//                //
//                let roundNumber = defaults.object(forKey: "workoutRoundsCustomCircuit") as! [Int]
//                numberOfRounds.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String(roundNumber[selectedPreset]), for: .normal)
//                //
//                switch self.selectedType {
//                case 0:
//                    presetsArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomClassic") as! [String]
//                case 1:
//                    presetsArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomCircuit") as! [String]
//                default: break
//                }
//                //
//                //
//                switch self.selectedType {
//                case 0:
//                    self.presetsButtonClassic.setTitle("- " + presetsArray[self.selectedPreset] + " -", for: .normal)
//                case 1:
//                    self.presetsButtonCircuit.setTitle("- " + presetsArray[self.selectedPreset] + " -", for: .normal)
//                default: break
//                }
//                //
//                tableView.deselectRow(at: indexPath, animated: true)
//                // Dismiss Table
//                if presetsArray.count != 0 {
//                    //
//                    // Element Positions
//                    //
//                    switch selectedType {
//                    case 0:
//                        //
//                        presetsButtonCircuit.alpha = 0
//                        presetsButtonCircuit.isEnabled = false
//                        presetsCircuitTop.constant = view.frame.size.height
//                        presetsCircuitBottom.constant = view.frame.size.height
//                        //
//                        self.numberOfRoundsConstraint.constant = self.view.frame.size.height
//                        //
//                        presetsClassicBottom.constant = self.view.frame.size.height - 73.5
//                    case 1:
//                        //
//                        //
//                        presetsButtonClassic.alpha = 0
//                        presetsButtonClassic.isEnabled = false
//                        presetsClassicTop.constant = view.frame.size.height
//                        presetsClassicBottom.constant = view.frame.size.height
//                        //
//                        self.numberOfRoundsConstraint.constant = 73.5
//                        //
//                        presetsCircuitBottom.constant = self.view.frame.size.height - 73.5
//                        presetsCircuitTop.constant = 0
//                    default: break
//                    }
//                    //
//                    self.editConstraint.constant = 73.5
//                    //
//                    self.tableViewConstraintTop.constant = 122.5
//                    self.tableViewConstraintBottom.constant = 49
//                    //
//                    self.beginButtonConstraint.constant = 0
//                    //
//                    UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                        self.presetsTableView.frame = CGRect(x: 30, y: TopBarHeights.combinedHeight + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
//                        self.presetsTableView.alpha = 0
//                        self.backgroundViewExpanded.alpha = 0
//                        //
//                        //
//                        self.editingButton.alpha = 1
//                        //
//                        self.customTableView.reloadData()
//                        self.beginButtonEnabled()
//                        self.editButtonEnabled()
//                        //
//                        self.view.layoutIfNeeded()
//                    }, completion: { finished in
//                        //
//                        self.presetsTableView.removeFromSuperview()
//                        self.backgroundViewExpanded.removeFromSuperview()
//                        //
//                    })
//                }
//                //
//            }
//            //
//        //
//        case customTableView:
//            //
//            selectedRow = indexPath.row
//            selectedSection = indexPath.section
//            //
//            if indexPath.row == customKeyArray[selectedPreset].count {
//                //
//                movementsTableView.alpha = 0
//                UIApplication.shared.keyWindow?.insertSubview(movementsTableView, aboveSubview: view)
//                let selectedCell = tableView.cellForRow(at: indexPath)
//                movementsTableView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: UIScreen.main.bounds.width - 40, height: (selectedCell?.bounds.height)!)
//                //
//                backgroundViewExpanded.alpha = 0
//                UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: movementsTableView)
//                backgroundViewExpanded.frame = UIScreen.main.bounds
//                // Animate table fade and size
//                // Alpha
//                UIView.animate(withDuration: 0.4, animations: {
//                    self.movementsTableView.alpha = 1
//                    //
//                }, completion: nil)
//                // Position
//                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                    self.movementsTableView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49)
//                    //
//                    self.backgroundViewExpanded.alpha = 0.7
//                }, completion: nil)
//                //
//            } else {
//                //
//                setsRepsPicker.reloadAllComponents()
//                // View
//                setsRepsView.alpha = 0
//                UIApplication.shared.keyWindow?.insertSubview(setsRepsView, aboveSubview: view)
//                let selectedCell = tableView.cellForRow(at: indexPath)
//                setsRepsView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: UIScreen.main.bounds.width - 40, height: (selectedCell?.bounds.height)!)
//                // selected row
//                switch selectedType {
//                case 0:
//                    setsRepsPicker.selectRow(customSetsArray[selectedPreset][indexPath.row], inComponent: 0, animated: true)
//                    setsRepsPicker.selectRow(customRepsArray[selectedPreset][indexPath.row], inComponent: 1, animated: true)
//                case 1:
//                    setsRepsPicker.selectRow(customRepsArrayC[selectedPreset][indexPath.section][indexPath.row], inComponent: 0, animated: true)
//                default: break
//                }
//                //
//                let componentWidth = setsRepsPicker.frame.size.width / 3
//                let componentWidthFourth = componentWidth / 4
//                // picker
//                switch self.selectedType {
//                case 0:
//                    self.setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: self.setsRepsView.frame.size.width + componentWidthFourth, height: 147)
//                    self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
//                    self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
//                case 1:
//                    self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
//                    self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
//                    self.setsIndicatorLabel.text = NSLocalizedString("reps", comment: "")
//                default: break
//                }
//                // ok
//                okButton.frame = CGRect(x: 0, y: 147, width: setsRepsView.frame.size.width, height: 49)
//                //
//                backgroundViewExpanded.alpha = 0
//                UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: setsRepsView)
//                backgroundViewExpanded.frame = UIScreen.main.bounds
//                // Animate table fade and size
//                // Alpha
//                UIView.animate(withDuration: 0.4, animations: {
//                    self.setsRepsView.alpha = 1
//                    //
//                }, completion: nil)
//                // Position
//                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                    //
//                    self.setsRepsView.frame = CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: 147 + 49)
//                    self.setsRepsView.center.y = self.view.center.y - ((UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!) / 2)
//                    // picker
//                    switch self.selectedType {
//                    case 0:
//                        self.setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: self.setsRepsView.frame.size.width + componentWidthFourth, height: 147)
//                        self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
//                    case 1:
//                        self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
//                        self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
//                    default: break
//                    }
//                    // ok
//                    self.okButton.frame = CGRect(x: 0, y: 147, width: self.setsRepsView.frame.size.width, height: 49)
//                    // Sets Indicator Label
//                    //
//                    //
//                    self.backgroundViewExpanded.alpha = 0.7
//                    
//                }, completion: nil)
//            }
//            //        }
//        //
//        case movementsTableView:
//            //
//            customKeyArray[selectedPreset].append(fullKeyArray[indexPath.section][indexPath.row])
//            // sets
//            if selectedType == 0 {
//                customSetsArray[selectedPreset].append(0)
//                customRepsArray[selectedPreset].append(0)
//            } else {
//                for i in 0...(customRepsArrayC[selectedPreset].count - 1) {
//                    customRepsArrayC[selectedPreset][i].append(0)
//                }
//            }
//            // reps
//            //
//            //
//            switch self.selectedType {
//            case 0:
//                defaults.set(customKeyArray, forKey: "workoutPresetsCustomClassic")
//                //
//                defaults.set(customSetsArray, forKey: "workoutSetsCustomClassic")
//                defaults.set(customRepsArray, forKey: "workoutRepsCustomClassic")
//            case 1:
//                defaults.set(customKeyArray, forKey: "workoutPresetsCustomCircuit")
//                //
//                defaults.set(customRepsArrayC, forKey: "workoutRepsCustomCircuit")
//            default: break
//            }
//            //
//            defaults.synchronize()
//            // Remove Table
//            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self.movementsTableView.alpha = 0
//                //
//                self.backgroundViewExpanded.alpha = 0
//                //
//                self.beginButtonEnabled()
//                self.editButtonEnabled()
//                //
//            }, completion: { finished in
//                self.movementsTableView.removeFromSuperview()
//                self.backgroundViewExpanded.removeFromSuperview()
//                //
//                self.customTableView.reloadData()
//            })
//        //
//        default: break
//        }
//        //
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//    // Enable ok alert action func
//    func textChanged(_ sender: UITextField) {
//        if sender.text == "" {
//            okAction.isEnabled = false
//        } else {
//            okAction.isEnabled = true
//        }
//    }
//    
//    //
//    // TableView Editing -----------------------------------------------------------------------------------------------------
//    //
//    // Can edit row
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        
//        //
//        switch tableView {
//        case presetsTableView:
//            //
//            var presetsArray: [String] = []
//            //
//            switch self.selectedType {
//            case 0:
//                presetsArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomClassic") as! [String]
//            case 1:
//                presetsArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomCircuit") as! [String]
//            default: break
//            }
//            //
//            if indexPath.row < presetsArray.count {
//                return true
//            }
//        case movementsTableView: return false
//        case customTableView:
//            //
//            let defaults = UserDefaults.standard
//            var customKeyArray: [[Int]] = []
//            //
//            switch self.selectedType {
//            case 0:
//                customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//            case 1:
//                customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//            default: break
//            }
//            //
//            if indexPath.section == 0 {
//                if customKeyArray.count == 0 {
//                    return false
//                } else {
//                    if indexPath.row == customKeyArray[selectedPreset].count {
//                        return false
//                    } else {
//                        return true
//                    }
//                }
//            }
//        default: return false
//        }
//        return false
//    }
//    
//    // Can move to row
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        switch tableView {
//        case presetsTableView: return false
//        case movementsTableView: return false
//        case customTableView:
//            //
//            let defaults = UserDefaults.standard
//            var customKeyArray: [[Int]] = []
//            //
//            switch self.selectedType {
//            case 0:
//                customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//            case 1:
//                customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//            default: break
//            }
//            //
//            if customKeyArray.count == 0 {
//                return false
//            } else {
//                if indexPath.row == customKeyArray[selectedPreset].count {
//                    return false
//                } else {
//                    return true
//                }
//            }
//        default: return false
//        }
//    }
//    
//    // Move row at
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        //
//        let defaults = UserDefaults.standard
//        var customKeyArray: [[Int]] = []
//        //
//        var customSetsArray: [[Int]] = []
//        var customRepsArray: [[Int]] = []
//        //
//        var customRepsArrayC: [[[Int]]] = []
//        //
//        switch selectedType {
//        case 0:
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//            //
//            customSetsArray = defaults.object(forKey: "workoutSetsCustomClassic") as! [[Int]]
//            customRepsArray = defaults.object(forKey: "workoutRepsCustomClassic") as! [[Int]]
//        case 1:
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//            //
//            customRepsArrayC = defaults.object(forKey: "workoutRepsCustomCircuit") as! [[[Int]]]
//        default: break
//        }
//        //
//        // Key
//        let itemToMove = customKeyArray[selectedPreset].remove(at: sourceIndexPath.row)
//        customKeyArray[selectedPreset].insert(itemToMove, at: destinationIndexPath.row)
//        //
//        // Sets
//        if selectedType == 0 {
//            let setToMove = customSetsArray[selectedPreset].remove(at: sourceIndexPath.row)
//            customSetsArray[selectedPreset].insert(setToMove, at: destinationIndexPath.row)
//        }
//        //
//        // Reps
//        if selectedType == 0 {
//            let repToMove = customRepsArray[selectedPreset].remove(at: sourceIndexPath.row)
//            customRepsArray[selectedPreset].insert(repToMove, at: destinationIndexPath.row)
//        } else {
//            for i in 0...(customRepsArrayC[selectedPreset].count - 1) {
//                let repToMove = customRepsArrayC[selectedPreset][i].remove(at: sourceIndexPath.row)
//                customRepsArrayC[selectedPreset][i].insert(repToMove, at: destinationIndexPath.row)
//            }
//            
//        }
//        //
//        //
//        switch self.selectedType {
//        case 0:
//            defaults.set(customKeyArray, forKey: "workoutPresetsCustomClassic")
//            //
//            defaults.set(customSetsArray, forKey: "workoutSetsCustomClassic")
//            defaults.set(customRepsArray, forKey: "workoutRepsCustomClassic")
//        case 1:
//            defaults.set(customKeyArray, forKey: "workoutPresetsCustomCircuit")
//            //
//            defaults.set(customRepsArrayC, forKey: "workoutRepsCustomCircuit")
//        default: break
//        }
//        //
//        defaults.synchronize()
//        //
//        tableView.reloadData()
//    }
//    
//    // Target index path for move from row
//    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
//        //
//        let defaults = UserDefaults.standard
//        var customKeyArray: [[Int]] = []
//        //
//        switch self.selectedType {
//        case 0:
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//        case 1:
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//        default: break
//        }
//        //
//        if proposedDestinationIndexPath.row == customKeyArray[selectedPreset].count {
//            return NSIndexPath(row: proposedDestinationIndexPath.row - 1, section: proposedDestinationIndexPath.section) as IndexPath
//        } else {
//            return proposedDestinationIndexPath
//        }
//    }
//    
//    // Delete button title
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        //
//        return NSLocalizedString("remove", comment: "")
//    }
//    
//    // Commit editing style
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        //
//        if editingStyle == UITableViewCellEditingStyle.delete {
//            
//            switch tableView {
//            case presetsTableView:
//                //
//                let defaults = UserDefaults.standard
//                var presetsArray: [String] = []
//                var customKeyArray: [[Int]] = []
//                //
//                var customSetsArray: [[Int]] = []
//                var customRepsArray: [[Int]] = []
//                //
//                var customRepsArrayC: [[[Int]]] = []
//                var roundNumber: [Int] = []
//                //
//                switch selectedType {
//                case 0:
//                    presetsArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomClassic") as! [String]
//                    customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//                    //
//                    customSetsArray = defaults.object(forKey: "workoutSetsCustomClassic") as! [[Int]]
//                    customRepsArray = defaults.object(forKey: "workoutRepsCustomClassic") as! [[Int]]
//                case 1:
//                    presetsArray = UserDefaults.standard.object(forKey: "workoutPresetTextsCustomCircuit") as! [String]
//                    customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//                    //
//                    customRepsArrayC = defaults.object(forKey: "workoutRepsCustomCircuit") as! [[[Int]]]
//                    //
//                    roundNumber = UserDefaults.standard.object(forKey: "workoutRoundsCustomCircuit") as! [Int]
//                    
//                default: break
//                }
//                
//                //
//                //
//                customKeyArray.remove(at: self.selectedPreset)
//                //
//                presetsArray.remove(at: self.selectedPreset)
//                //
//                if selectedType == 0 {
//                    customSetsArray.remove(at: self.selectedPreset)
//                    customRepsArray.remove(at: self.selectedPreset)
//                } else {
//                    customRepsArrayC.remove(at: self.selectedPreset)
//                    roundNumber.remove(at: self.selectedPreset)
//                }
//                //
//                
//                //
//                //
//                switch self.selectedType {
//                case 0:
//                    defaults.set(presetsArray, forKey: "workoutPresetTextsCustomClassic")
//                    defaults.set(customKeyArray, forKey: "workoutPresetsCustomClassic")
//                    //
//                    defaults.set(customSetsArray, forKey: "workoutSetsCustomClassic")
//                    defaults.set(customRepsArray, forKey: "workoutRepsCustomClassic")
//                case 1:
//                    defaults.set(presetsArray, forKey: "workoutPresetTextsCustomCircuit")
//                    defaults.set(customKeyArray, forKey: "workoutPresetsCustomCircuit")
//                    //
//                    defaults.set(customRepsArrayC, forKey: "workoutRepsCustomCircuit")
//                    //
//                    defaults.set(roundNumber, forKey: "workoutRoundsCustomCircuit")
//                default: break
//                }
//                //
//                defaults.synchronize()
//                
//                //
//                numberOfRounds.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String(roundNumber[selectedPreset]), for: .normal)
//                
//                //
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.presetsTableView.reloadData()
//                })
//                //
//                self.selectedPreset = self.selectedPreset - 1
//                self.customTableView.reloadData()
//                self.beginButtonEnabled()
//                //
//                
//                //
//                UIView.animate(withDuration: 0.2, animations: {
//                    self.presetsTableView.reloadData()
//                    //
//                    if customKeyArray.count == 0 {
//                        switch self.selectedType {
//                        case 0:
//                            self.presetsButtonClassic.setTitle(NSLocalizedString("customWorkoutClassic", comment: ""), for: .normal)
//                        case 1:
//                            self.presetsButtonCircuit.setTitle(NSLocalizedString("customWorkoutClassic", comment: ""), for: .normal)
//                        default: break
//                        }
//                    } else {
//                        switch self.selectedType {
//                        case 0:
//                            self.presetsButtonClassic.setTitle("- " + presetsArray[self.selectedPreset] + " -", for: .normal)
//                        case 1:
//                            self.presetsButtonCircuit.setTitle("- " + presetsArray[self.selectedPreset] + " -", for: .normal)
//                        default: break
//                        }
//                    }
//                })
//                
//                
//                // Initial Element Positions
//                if customKeyArray.count == 0 && self.presetsButtonClassic.alpha == 1 && self.presetsButtonCircuit.alpha == 0 || customKeyArray.count == 0 && self.presetsButtonClassic.alpha == 0 && self.presetsButtonCircuit.alpha == 1 {
//                    
//                    self.presetsTableView.isHidden = false
//                    //
//                    self.backgroundViewExpanded.isHidden = false
//                    UIView.animate(withDuration: 0.3, animations: {
//                        self.backgroundViewExpanded.alpha = 0.5
//                        self.presetsTableView.reloadData()
//                        // Dismiss and select new row
//                    }, completion: { finished in
//                        //
//                        self.selectedPreset = -1
//                        //
//                        tableView.deselectRow(at: indexPath, animated: true)
//                        //
//                        
//                        // Reload Data
//                        self.customTableView.reloadData()
//                        self.beginButtonEnabled()
//                        self.editButtonEnabled()
//                        //
//                        self.beginButtonEnabled()
//                        self.editButtonEnabled()
//                        
//                        // Initial Element Positions
//                        //
//                        switch self.selectedType {
//                        case 0:
//                            self.presetsClassicBottom.constant = 0
//                        case 1:
//                            self.presetsCircuitBottom.constant = 0
//                        default: break
//                        }
//                        self.editConstraint.constant = self.view.frame.size.height
//                        self.numberOfRoundsConstraint.constant = self.view.frame.size.height
//                        //
//                        self.tableViewConstraintTop.constant = self.view.frame.size.height
//                        self.tableViewConstraintBottom.constant = -49
//                        //
//                        self.beginButtonConstraint.constant = -49
//                        //
//                        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                            //
//                            self.view.layoutIfNeeded()
//                            self.editingButton.alpha = 1
//                            //
//                            self.presetsTableView.frame = CGRect(x: 30, y: self.presetsButtonClassic.frame.minY + UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
//                            self.presetsTableView.alpha = 0
//                            self.backgroundViewExpanded.alpha = 0
//                        }, completion: { finished in
//                            //
//                            self.presetsTableView.removeFromSuperview()
//                            self.backgroundViewExpanded.removeFromSuperview()
//                        })
//                    })
//                }
//            //
//            case customTableView:
//                //
//                let defaults = UserDefaults.standard
//                var customKeyArray: [[Int]] = []
//                //
//                var customSetsArray: [[Int]] = []
//                var customRepsArray: [[Int]] = []
//                //
//                var customRepsArrayC: [[[Int]]] = []
//                //
//                switch selectedType {
//                case 0:
//                    customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//                    //
//                    customSetsArray = defaults.object(forKey: "workoutSetsCustomClassic") as! [[Int]]
//                    customRepsArray = defaults.object(forKey: "workoutRepsCustomClassic") as! [[Int]]
//                case 1:
//                    customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//                    //
//                    customRepsArrayC = defaults.object(forKey: "workoutRepsCustomCircuit") as! [[[Int]]]
//                default: break
//                }
//                // Key
//                customKeyArray[selectedPreset].remove(at: indexPath.row)
//                // sets
//                if selectedType == 0 {
//                    customSetsArray[selectedPreset].remove(at: indexPath.row)
//                    customRepsArray[selectedPreset].remove(at: indexPath.row)
//                } else {
//                    for i in 0...(customRepsArrayC[selectedPreset].count - 1) {
//                        customRepsArrayC[selectedPreset][i].remove(at: indexPath.row)
//                    }
//                }
//                // reps
//                //
//                switch self.selectedType {
//                case 0:
//                    defaults.set(customKeyArray, forKey: "workoutPresetsCustomClassic")
//                    //
//                    defaults.set(customSetsArray, forKey: "workoutSetsCustomClassic")
//                    defaults.set(customRepsArray, forKey: "workoutRepsCustomClassic")
//                case 1:
//                    defaults.set(customKeyArray, forKey: "workoutPresetsCustomCircuit")
//                    //
//                    defaults.set(customRepsArrayC, forKey: "workoutRepsCustomCircuit")
//                default: break
//                }
//                //
//                defaults.synchronize()
//                //
//                switch selectedType {
//                case 0:
//                    tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//                case 1:
//                    let roundNumber = UserDefaults.standard.object(forKey: "workoutRoundsCustomCircuit") as! [Int]
//                    var indexArray: [IndexPath] = []
//                    for i in 1...roundNumber[selectedPreset] {
//                        let row = indexPath.row
//                        let section = ((indexPath.section + 1) * i) - 1
//                        let indexPathToRemove = NSIndexPath(row: row, section: section)
//                        indexArray.append(indexPathToRemove as IndexPath)
//                    }
//                    tableView.deleteRows(at: indexArray, with: UITableViewRowAnimation.automatic)
//                default: break
//                }
//            default: break
//            }
//        }
//    }
//    
//    
//    //
//    // Table view related button actions ------------------------------------------------------------------------------------------------
//    //
//    // Prests
//    @IBAction func presetsClassicAction(_ sender: Any) {
//        //
//        selectedType = 0
//        //
//        presetsTableView.reloadData()
//        //
//        presetsTableView.alpha = 0
//        presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + (presetsButtonClassic.frame.size.height / 2), width: presetsButtonClassic.frame.size.width - 60, height: 0)
//        presetsTableView.center.x = presetsButtonClassic.center.x
//        presetsTableView.center.y = presetsButtonClassic.center.y + UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!
//        //
//        backgroundViewExpanded.alpha = 0
//        backgroundViewExpanded.frame = UIScreen.main.bounds
//        // Present
//        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
//        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: presetsTableView)
//        // Animate table fade and size
//        // Positiona
//        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.presetsTableView.alpha = 1
//            self.presetsTableView.frame = CGRect(x: 30, y: TopBarHeights.combinedHeight + 44, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88)
//            
//            //
//            self.backgroundViewExpanded.alpha = 0.5
//        }, completion: nil)
//        //
//    }
//    
//    @IBAction func presetsCircuitAction(_ sender: Any) {
//        //
//        selectedType = 1
//        //
//        presetsTableView.reloadData()
//        //
//        presetsTableView.alpha = 0
//        presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + (presetsButtonClassic.frame.size.height / 2), width: presetsButtonClassic.frame.size.width - 60, height: 0)
//        presetsTableView.center.x = presetsButtonClassic.center.x
//        presetsTableView.center.y = presetsButtonClassic.center.y + UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!
//        //
//        backgroundViewExpanded.alpha = 0
//        backgroundViewExpanded.frame = UIScreen.main.bounds
//        // Present
//        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
//        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: presetsTableView)
//        // Animate table fade and size
//        // Positiona
//        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.presetsTableView.alpha = 1
//            self.presetsTableView.frame = CGRect(x: 30, y: TopBarHeights.combinedHeight + 44, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88)
//            
//            //
//            self.backgroundViewExpanded.alpha = 0.5
//        }, completion: nil)
//        //
//        
//    }
//    
//    // Number Of Rounds Action
//    @IBAction func numberOfRoundsAction(_ sender: Any) {
//        //
//        selectingNumberOfRounds = true
//        setsRepsPicker.reloadAllComponents()
//        //
//        setsRepsView.alpha = 0
//        UIApplication.shared.keyWindow?.insertSubview(setsRepsView, aboveSubview: view)
//        setsRepsView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 73.5, width: UIScreen.main.bounds.width - 40, height: 44)
//        //
//        // selected number of rows
//        let roundNumber = UserDefaults.standard.object(forKey: "workoutRoundsCustomCircuit") as! [Int]
//        setsRepsPicker.selectRow(roundsPickerArray.index(of: roundNumber[selectedPreset])!, inComponent: 0, animated: true)
//        //
//        let componentWidth = setsRepsPicker.frame.size.width / 3
//        let componentWidthFourth = componentWidth / 4
//        // picker
//        self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
//        self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
//        self.setsIndicatorLabel.text = NSLocalizedString("rounds", comment: "")
//        // ok
//        okButton.frame = CGRect(x: 0, y: 147, width: setsRepsView.frame.size.width, height: 49)
//        //
//        backgroundViewExpanded.alpha = 0
//        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: setsRepsView)
//        backgroundViewExpanded.frame = UIScreen.main.bounds
//        // Animate table fade and size
//        // Alpha
//        UIView.animate(withDuration: 0.4, animations: {
//            self.setsRepsView.alpha = 1
//            //
//        }, completion: nil)
//        // Position
//        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            //
//            self.setsRepsView.frame = CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: 147 + 49)
//            self.setsRepsView.center.y = self.view.center.y - ((UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!) / 2)
//            // picker
//            self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
//            self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
//            // ok
//            self.okButton.frame = CGRect(x: 0, y: 147, width: self.setsRepsView.frame.size.width, height: 49)
//            // Sets Indicator Label
//            //
//            //
//            self.backgroundViewExpanded.alpha = 0.7
//            
//        }, completion: nil)
//    }
//    
//    
//    
//    // Add movement table background (dismiss table)
//    func backgroundViewExpandedAction(_ sender: Any) {
//        //
//        if selectingNumberOfRounds == true {
//            selectingNumberOfRounds = false
//        }
//        //
//        if (UIApplication.shared.keyWindow?.subviews.contains(self.presetsTableView))! {
//            //
//            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self.presetsTableView.frame = CGRect(x: 30, y: self.presetsButtonClassic.frame.minY + UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
//                self.presetsTableView.alpha = 0
//                self.backgroundViewExpanded.alpha = 0
//            }, completion: { finished in
//                //
//                self.presetsTableView.removeFromSuperview()
//                self.backgroundViewExpanded.removeFromSuperview()
//            })
//            //
//        } else {
//            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self.movementsTableView.alpha = 0
//                self.setsRepsView.alpha = 0
//                //
//                self.backgroundViewExpanded.alpha = 0
//            }, completion: { finished in
//                self.movementsTableView.removeFromSuperview()
//                self.setsRepsView.removeFromSuperview()
//                //
//                self.backgroundViewExpanded.removeFromSuperview()
//            })
//        }
//    }
//    
//    
//    // Edit Tableview
//    //
//    @IBAction func editingAction(_ sender: Any) {
//        //
//        if customTableView.isEditing {
//            self.customTableView.setEditing(false, animated: true)
//            self.editingButton.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
//            //
//            self.beginButtonEnabled()
//            //
//        } else {
//            self.customTableView.setEditing(true, animated: true)
//            self.editingButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
//            //
//            self.beginButtonEnabled()
//        }
//    }
//    
//    
//    //
//    // Picker Related actions ------------------------------------------------------------------------------------------------
//    //
//    // Ok button action
//    func okButtonAction(_ sender: Any) {
//        //
//        // Number of Rounds
//        if selectingNumberOfRounds == true {
//            let defaults = UserDefaults.standard
//            var roundNumber = defaults.object(forKey: "workoutRoundsCustomCircuit") as! [Int]
//            //
//            let customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//            //
//            var customRepsArrayC = defaults.object(forKey: "workoutRepsCustomCircuit") as! [[[Int]]]
//            
//            //
//            if roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)] > roundNumber[selectedPreset] {
//                //
//                let oldRound = roundNumber[selectedPreset]
//                let newRound = roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
//                //
//                let numberToAdd = newRound - oldRound
//                
//                // Add [] to reps
//                for _ in 0...(numberToAdd - 1) {
//                    customRepsArrayC[selectedPreset].append([])
//                }
//                // Add 0 to reps
//                if customKeyArray[selectedPreset].count != 0 {
//                    for i in oldRound...(newRound - 1) {
//                        for _ in 0...(customKeyArray[selectedPreset].count - 1) {
//                            customRepsArrayC[selectedPreset][i].append(0)
//                        }
//                    }
//                }
//                
//                //
//                defaults.set(customRepsArrayC, forKey: "workoutRepsCustomCircuit")
//                //
//                roundNumber[selectedPreset] = newRound
//                defaults.set(roundNumber, forKey: "workoutRoundsCustomCircuit")
//                //
//                //
//            } else if roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)] < roundNumber[selectedPreset] {
//                //
//                let oldRound = roundNumber[selectedPreset]
//                let newRound = roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
//                //
//                let numberToRemove = oldRound - newRound
//                
//                // remove reps and keys
//                for _ in 0...(numberToRemove - 1) {
//                    customRepsArrayC[selectedPreset].removeLast()
//                }
//                
//                //
//                defaults.set(customRepsArrayC, forKey: "workoutRepsCustomCircuit")
//                //
//                roundNumber[selectedPreset] = newRound
//                defaults.set(roundNumber, forKey: "workoutRoundsCustomCircuit")
//                //
//                //
//            }
//            //
//            defaults.synchronize()
//            //
//            numberOfRounds.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String(roundNumber[selectedPreset]), for: .normal)
//            //
//            selectingNumberOfRounds = false
//            //
//            //
//            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self.setsRepsView.alpha = 0
//                //
//                self.backgroundViewExpanded.alpha = 0
//            }, completion: { finished in
//                self.setsRepsView.removeFromSuperview()
//                //
//                self.backgroundViewExpanded.removeFromSuperview()
//            })
//            //
//            customTableView.reloadData()
//            //
//            
//            //
//        } else {
//            //
//            let defaults = UserDefaults.standard
//            //
//            var customSetsArray: [[Int]] = []
//            var customRepsArray: [[Int]] = []
//            //
//            var customRepsArrayC: [[[Int]]] = []
//            //
//            switch selectedType {
//            case 0:
//                //
//                customSetsArray = defaults.object(forKey: "workoutSetsCustomClassic") as! [[Int]]
//                customRepsArray = defaults.object(forKey: "workoutRepsCustomClassic") as! [[Int]]
//            case 1:
//                //
//                customRepsArrayC = defaults.object(forKey: "workoutRepsCustomCircuit") as! [[[Int]]]
//            default: break
//            }
//            //
//            if selectedType == 0 {
//                customSetsArray[selectedPreset][selectedRow] = setsRepsPicker.selectedRow(inComponent: 0)
//                customRepsArray[selectedPreset][selectedRow] = setsRepsPicker.selectedRow(inComponent: 1)
//            } else {
//                customRepsArrayC[selectedPreset][selectedSection][selectedRow] = setsRepsPicker.selectedRow(inComponent: 0)
//            }
//            //
//            //
//            //
//            switch self.selectedType {
//            case 0:
//                //
//                defaults.set(customSetsArray, forKey: "workoutSetsCustomClassic")
//                defaults.set(customRepsArray, forKey: "workoutRepsCustomClassic")
//            case 1:
//                //
//                defaults.set(customRepsArrayC, forKey: "workoutRepsCustomCircuit")
//            default: break
//            }
//            //
//            defaults.synchronize()
//            //
//            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self.setsRepsView.alpha = 0
//                //
//                self.backgroundViewExpanded.alpha = 0
//            }, completion: { finished in
//                self.setsRepsView.removeFromSuperview()
//                //
//                self.backgroundViewExpanded.removeFromSuperview()
//            })
//            //
//            customTableView.reloadData()
//            
//        }
//    }
//    
//    
//    //
//    // Expand/Retract Image ------------------------------------------------------------------------------------------------
//    //
//    // Expand Image
//    let expandedImage = UIImageView()
//    let backgroundViewImage = UIButton()
//    //
//    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
//        // Get Image
//        let sender = extraTap.view as! UIImageView
//        let image = sender.image
//        // Get Image
//        // let index = demonstrationImage.indexWhere
//        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
//        // Expanded Image
//        //
//        expandedImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: height/2)
//        expandedImage.center.x = self.view.frame.size.width/2
//        expandedImage.center.y = (height/2) * 2.5
//        //
//        expandedImage.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
//        expandedImage.contentMode = .scaleAspectFit
//        expandedImage.isUserInteractionEnabled = true
//        expandedImage.image = image
//        // Background View
//        //
//        backgroundViewImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: height)
//        backgroundViewImage.backgroundColor = .black
//        backgroundViewImage.alpha = 0
//        backgroundViewImage.addTarget(self, action: #selector(retractImage(_:)), for: .touchUpInside)
//        //
//        self.navigationItem.setHidesBackButton(true, animated: true)
//        UIApplication.shared.keyWindow?.insertSubview(backgroundViewImage, aboveSubview: view)
//        UIApplication.shared.keyWindow?.insertSubview(expandedImage, aboveSubview: backgroundViewImage)
//        //
//        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.expandedImage.center.y = (height/2) * 1.5
//            self.backgroundViewImage.alpha = 0.5
//        }, completion: nil)
//    }
//    
//    // Retract image
//    @IBAction func retractImage(_ sender: Any) {
//        //
//        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
//        //
//        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.expandedImage.center.y = (height/2) * 2.5
//            self.backgroundViewImage.alpha = 0
//        }, completion: { finished in
//            //
//            self.expandedImage.removeFromSuperview()
//            self.backgroundViewImage.removeFromSuperview()
//            self.navigationItem.setHidesBackButton(false, animated: true)
//        })
//    }
//    
//    
//    
//    //
//    // Begin Button ------------------------------------------------------------------------------------------------
//    //
//    // Begin Button
//    @IBAction func beginButton(_ sender: Any) {
//        //
//        switch selectedType {
//        case 0:
//            self.performSegue(withIdentifier: "workoutSessionSegueCustom0", sender: "")
//        case 1:
//            self.performSegue(withIdentifier: "workoutSessionSegueCustom1", sender: "")
//        default: break
//        }
//        // Return background to homescreen
//        let delayInSeconds = 0.5
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
//            
//            _ = self.navigationController?.popToRootViewController(animated: false)
//            
//        }
//    }
//    
//    
//    //
//    // Pass Arrays ------------------------------------------------------------------------------------------------
//    //
//    // Pass Array to next ViewController
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //
//        let defaults = UserDefaults.standard
//        var titleDataArray: [String] = []
//        var customKeyArray: [[Int]] = []
//        //
//        var customSetsArray: [[Int]] = []
//        var customRepsArray: [[Int]] = []
//        //
//        var roundNumber: [Int] = []
//        //
//        var customRepsArrayC: [[[Int]]] = []
//        //
//        switch selectedType {
//        case 0:
//            titleDataArray = defaults.object(forKey: "workoutPresetTextsCustomClassic") as! [String]
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomClassic") as! [[Int]]
//            //
//            customSetsArray = defaults.object(forKey: "workoutSetsCustomClassic") as! [[Int]]
//            customRepsArray = defaults.object(forKey: "workoutRepsCustomClassic") as! [[Int]]
//        case 1:
//            titleDataArray = defaults.object(forKey: "workoutPresetTextsCustomCircuit") as! [String]
//            customKeyArray = defaults.object(forKey: "workoutPresetsCustomCircuit") as! [[Int]]
//            //
//            roundNumber = defaults.object(forKey: "workoutRoundsCustomCircuit") as! [Int]
//            //
//            customRepsArrayC = defaults.object(forKey: "workoutRepsCustomCircuit") as! [[[Int]]]
//        default: break
//        }
//        //
//        
//        if (segue.identifier == "workoutSessionSegueCustom0") {
//            //
//            let destinationVC = segue.destination as! SessionScreen
//            
//            // Compress Arrays
//            for i in customKeyArray[selectedPreset] {
//                //
//                workoutArray.append(workoutMovementsDictionary[i]!)
//                //
//                demonstrationArray.append(demonstrationDictionary[i]!)
//                //
//                targetAreaArray.append(targetAreaDictionary[i]!)
//                //
//                explanationArray.append(explanationDictionary[i]!)
//            }
//            //
//            for i in customSetsArray[selectedPreset] {
//                setsArray.append(setsPickerArray[i])
//            }
//            //
//            for i in 0...(repsPickerArray.count - 1) {
//                repsPickerArray[i] = repsPickerArray[i] + " reps"
//            }
//            //
//            for i in customRepsArray[selectedPreset] {
//                repsArray.append(repsPickerArray[i])
//            }
//            
//            //
//            //            destinationVC.sessionArray = workoutArray
//            //            destinationVC.setsArray = setsArray
//            //            destinationVC.repsArray = repsArray
//            //            //destinationVC.demonstrationArray = demonstrationArray
//            //            //destinationVC.targetAreaArray = targetAreaArray
//            //            destinationVC.explanationArray = explanationArray
//            //            //
//            //            destinationVC.sessionType = 0
//            //
//            //
//        } else if (segue.identifier == "workoutSessionSegueCustom1") {
//            //
//            let destinationVC = segue.destination as! CircuitWorkoutScreen
//            
//            // Compress Arrays
//            for i in customKeyArray[selectedPreset] {
//                //
//                workoutArray.append(workoutMovementsDictionary[i]!)
//                //
//                demonstrationArray.append(demonstrationDictionary[i]!)
//                //
//                targetAreaArray.append(targetAreaDictionary[i]!)
//                //
//                explanationArray.append(explanationDictionary[i]!)
//            }
//            //
//            for i in 0...(repsPickerArrayCircuit.count - 1) {
//                repsPickerArrayCircuit[i] = repsPickerArrayCircuit[i] + " reps"
//            }
//            //
//            for i in 0...(customRepsArrayC[selectedPreset].count - 1) {
//                repsArrayC.append([])
//                for j in customRepsArrayC[selectedPreset][i] {
//                    repsArrayC[i].append(repsPickerArrayCircuit[j])
//                }
//            }
//            
//            //
//            //            destinationVC.numberOfRounds = roundNumber[selectedPreset]
//            //            //
//            //            destinationVC.sessionArray = workoutArray
//            //            destinationVC.repsArray = repsArrayC
//            //            //destinationVC.demonstrationArray = demonstrationArray
//            //            //destinationVC.targetAreaArray = targetAreaArray
//            //            destinationVC.explanationArray = explanationArray
//            //            //
//            //            destinationVC.sessionType = 0
//            //
//        }
//    }
//    
//    //
//}