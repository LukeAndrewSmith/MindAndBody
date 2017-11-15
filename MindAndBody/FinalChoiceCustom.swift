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
class FinalChoiceCustom: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //    // TEMPLATE
    //    //
    //    // Find out session type
    //    // Switch SelectedSession.shared.selectedSession[0] and SelectedSession.shared.selectedSession[1]
    //    switch SelectedSession.shared.selectedSession[0] {
    //    // Warmup
    //    case 0:
    //
    //    // Workout
    //    case 1:
    //
    //    // Cardio
    //    case 2:
    //
    //    // Stretching
    //    case 3:
    //
    //    // Yoga
    //    case 4:
    //
    //    default:
    //    break
    //    }
    
    //
    // Selected row
    var selectedRow = Int()
    var selectedSection = Int()
    //
    var selectedPreset = -1
    //
    var selectingNumberOfRounds = false
    
    //
    // Picker Arrays
    // Sets
    var setsPickerArray: [Int] = [1, 2, 3, 4, 5, 6]
    // Reps
    var repsPickerArray: [String] = ["1", "3", "5", "8", "10", "12", "15", "20", "3-5", "5-8", "8-12", "15-20", "15s", "30s", "60s", "90s"]
    // RepsCircuit
    var repsPickerArrayCircuit: [String] = ["1", "3", "5", "8", "10", "12", "15", "20", "30", "40", "50", "3-5", "5-8", "8-12", "15-20", "20-30", "30-40", "15s", "30s", "60s", "90s"]
    // Breaths
    var breathsPickerArray: [Int] = [5,10,15,20,25,30,35,40,45,50,100]
    // Time
    var timePickerArray: [Int] = [10,30,60,90,120,150,180,210,240,270,300]
    
    //
    // Presets button titles
    let presetsButtonTitles = ["customWarmup", "customWorkout", "customHIITCardioSession", "customStretchingSession", "customYogaPractice"]
    
    
    
    // Rounds
    // Note: if 1, "1 (not a circuit workout)"
    var roundsPickerArray: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    //
    
    //
    // Outlets ---------------------------------------------------------------------------------------------------------------------------
    //
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Presets
    @IBOutlet weak var presetsButton: UIButton!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    // Table View
    @IBOutlet weak var customTableView: UITableView!
    
    // Action Buttons
    @IBOutlet weak var nRoundsButton: UIButton!
    @IBOutlet weak var newMovementButton: UIButton!
    
    
    //
    // Constraints
    @IBOutlet weak var presetsTop: NSLayoutConstraint!
    @IBOutlet weak var presetsBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var tableViewConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var tableViewConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak var beginButtonConstraint: NSLayoutConstraint!
    //
    @IBOutlet weak var nRoundsRight: NSLayoutConstraint!
    @IBOutlet weak var newMovementLeft: NSLayoutConstraint!
    
    //
    let emptyString = ""
    
    // Presets
    var presetsTableView = UITableView()
    
    // Elements for cell actions
    //
    // Add movement
    var movementsTableView = UITableView()
    
    // Sets and Reps Choice
    var setsRepsView = UIView()
    var setsRepsPicker = UIPickerView()
    var okButton = UIButton()
    //
    let setsIndicatorLabel = UILabel()
    
    // Nº Rounds Title
    let nRoundsTitle = NSLocalizedString("nRoundsTitle", comment: "")
    
    
    //
    // View Will Appear
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set Title of presets button
        presetsButton.setTitle(NSLocalizedString(presetsButtonTitles[SelectedSession.shared.selectedSession[0]], comment: ""), for: .normal)
    }
    
    //
    // View did appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Select
        if selectedPreset == -1 {
            self.presetsButton.sendActions(for: .touchUpInside)
        }
    }
    
    
    //
    // View did load  ---------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Long press reorder
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(gestureRecognizer:)))
        customTableView.addGestureRecognizer(longPress)
        
        //
        // Initial Element Positions
        presetsTop.constant = 0
        presetsBottom.constant = 0
        //
        tableViewConstraintTop.constant = view.frame.size.height
        tableViewConstraintBottom.constant = -49
        //
        beginButtonConstraint.constant = -49
        
        // Width of action buttons
        // If Workout, option for circuit workout (numberofrounds)
        if SelectedSession.shared.selectedSession[0] != 1 {
            nRoundsRight.constant = view.bounds.width
            nRoundsButton.alpha = 0
            newMovementLeft.constant = 0
        } else {
            nRoundsRight.constant = view.bounds.width / 2
            newMovementLeft.constant = view.bounds.width / 2
            nRoundsButton.setTitle(nRoundsTitle + "1", for: .normal)
        }
        
        
        // Colour
        self.view.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        //
        presetsButton.backgroundColor = Colours.colour2
        
        // Navigation Bar Title
        navigationBar.title = NSLocalizedString("custom", comment: "")
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = Colours.colour3
        beginButton.setTitleColor(Colours.colour2, for: .normal)
        
        
        
        // Presets TableView
        //
        // Movement tabl
        presetsTableView.backgroundColor = Colours.colour2
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        presetsTableView.layer.cornerRadius = 15
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        presetsTableView.layer.borderColor = Colours.colour1.cgColor
        presetsTableView.layer.borderWidth = 1
        //
        //
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = Colours.colour1
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        presetsTableView.tableFooterView = UIView()
        
        
        
        // TableView
        //
        // TableView Background
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = Colours.colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.customTableView.frame.size.width, height: self.customTableView.frame.size.height)
        //
        customTableView.backgroundView = tableViewBackground
        // TableView Cell action items
        //
        // Movement table
        movementsTableView.backgroundColor = Colours.colour2
        movementsTableView.delegate = self
        movementsTableView.dataSource = self
        movementsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        movementsTableView.layer.cornerRadius = 15
        movementsTableView.layer.masksToBounds = true
        //
        // Sets Reps Selection
        // view
        setsRepsView.backgroundColor = Colours.colour2
        setsRepsView.layer.cornerRadius = 15
        setsRepsView.layer.masksToBounds = true
        // picker
        setsRepsPicker.backgroundColor = Colours.colour2
        setsRepsPicker.delegate = self
        setsRepsPicker.dataSource = self
        // ok
        okButton.backgroundColor = Colours.colour1
        okButton.setTitleColor(Colours.colour3, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        // sets
        setsIndicatorLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        setsIndicatorLabel.textColor = Colours.colour1
        setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
        //
        setsRepsView.addSubview(setsRepsPicker)
        setsRepsView.addSubview(okButton)
        setsRepsView.addSubview(setsIndicatorLabel)
        setsRepsView.bringSubview(toFront: setsIndicatorLabel)
        //
    }
    
    
    var didLayout = false
    //
    // View did layout subviews Actions -------------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //
        // Initial Element Positions
        //
        if didLayout == false {
            presetsTop.constant = 0
            presetsBottom.constant = 0
            //
            tableViewConstraintTop.constant = view.frame.size.height
            tableViewConstraintBottom.constant = -49
            //
            beginButtonConstraint.constant = -49
            //
            didLayout = true
        } else {
            
        }
        
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
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        if customTableView.isEditing {
            beginButton.isEnabled = false
        } else {
            if selectedPreset == -1 {
                
            } else {
                if customSessionsArray[SelectedSession.shared.selectedSession[0]].count == 0 {
                    beginButton.isEnabled = false
                } else {
                    beginButton.isEnabled = true
                }
            }
        }
    }
    
    //
    // Picker View ----------------------------------------------------------------------------------------------------
    //
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        // Number of Rounds
        if selectingNumberOfRounds == true {
            return 1
            // Set/Reps/Breaths
        } else {
            switch SelectedSession.shared.selectedSession[0] {
            case 0:
                return 2
            case 1:
                // If circuit
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    return 1
                    // Normal
                } else {
                    return 2
                }
            case 2,3,4:
                return 1
            default:
                break
            }
        }
        return 0
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        // Number of Rounds
        if selectingNumberOfRounds == true {
            return roundsPickerArray.count
        } else {
            switch SelectedSession.shared.selectedSession[0] {
            case 0:
                if component == 0 {
                    return setsPickerArray.count
                } else {
                    return repsPickerArray.count
                }
            case 1:
                // If circuit
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    return repsPickerArrayCircuit.count
                    // Normal
                } else {
                    if component == 0 {
                        return setsPickerArray.count
                    } else {
                        return repsPickerArray.count
                    }
                }
            case 2:
                return timePickerArray.count
            case 3,4:
                return breathsPickerArray.count
            default: break
            }
        }
        return 0
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        // Number of Rounds
        if selectingNumberOfRounds == true {
            let roundLabel = UILabel()
            roundLabel.text = String(roundsPickerArray[row])
            if row == 0 {
                roundLabel.text = String(roundsPickerArray[row]) + NSLocalizedString("notCircuitWorkout", comment: "")
            }
            roundLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
            roundLabel.textColor = Colours.colour1
            //
            roundLabel.textAlignment = .center
            return roundLabel
            //
            // Other
        } else {
            //
            // Find out session type
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup - Sets x Reps
            case 0:
                //
                if component == 0 {
                    let setsLabel = UILabel()
                    setsLabel.text = String(setsPickerArray[row])
                    setsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                    setsLabel.textColor = Colours.colour1
                    setsLabel.textAlignment = .center
                    return setsLabel
                    //
                } else if component == 1 {
                    //
                    let repsLabel = UILabel()
                    // Row Label Text
                    switch row {
                    case 0:
                        repsLabel.text = "        " + String(repsPickerArray[row]) + "  " + NSLocalizedString("rep", comment: "")
                    case 1:
                        repsLabel.text = "         " + String(repsPickerArray[row]) + " " + NSLocalizedString("reps", comment: "")
                    case 2...15:
                        repsLabel.text = String(repsPickerArray[row])
                    default: break
                    }
                    repsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                    repsLabel.textColor = Colours.colour1
                    repsLabel.textAlignment = .center
                    return repsLabel
                    //
                }
            // Workout
            case 1:
                // Circuit - Reps
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    //
                    let repsLabel = UILabel()
                    repsLabel.text = String(repsPickerArrayCircuit[row])
                    repsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                    repsLabel.textColor = Colours.colour1
                    repsLabel.textAlignment = .center
                    return repsLabel
                    // Normal - Sets x Reps
                } else {
                    //
                    if component == 0 {
                        let setsLabel = UILabel()
                        setsLabel.text = String(setsPickerArray[row])
                        setsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                        setsLabel.textColor = Colours.colour1
                        setsLabel.textAlignment = .center
                        return setsLabel
                        //
                    } else if component == 1 {
                        //
                        let repsLabel = UILabel()
                        // Row Label Text
                        switch row {
                        case 0:
                            repsLabel.text = "        " + String(repsPickerArray[row]) + "  " + NSLocalizedString("rep", comment: "")
                        case 1:
                            repsLabel.text = "         " + String(repsPickerArray[row]) + " " + NSLocalizedString("reps", comment: "")
                        case 2...15:
                            repsLabel.text = String(repsPickerArray[row])
                        default: break
                        }
                        repsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                        repsLabel.textColor = Colours.colour1
                        repsLabel.textAlignment = .center
                        return repsLabel
                        //
                    }
                }
            // Cardio
            case 2:
                //
                let timeLabel = UILabel()
                timeLabel.text = String(timePickerArray[row])
                timeLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                timeLabel.textColor = Colours.colour1
                timeLabel.textAlignment = .center
                return timeLabel
            // Stretching/Yoga - Breaths
            case 3,4:
                //
                let breathsLabel = UILabel()
                breathsLabel.text = String(breathsPickerArray[row])
                breathsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                breathsLabel.textColor = Colours.colour1
                breathsLabel.textAlignment = .center
                return breathsLabel
            //
            default:
                break
            }
        }
        return UIView()
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Width
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        // Number of Rounds
        if selectingNumberOfRounds == true {
            return setsRepsPicker.frame.size.width
            // Set/Reps/Breaths
        } else {
            switch SelectedSession.shared.selectedSession[0] {
            case 0:
                if component == 0 {
                    return (setsRepsPicker.frame.size.width / 3)
                } else if component == 1{
                    return (setsRepsPicker.frame.size.width / 3)
                }
            case 1:
                // If circuit
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    return setsRepsPicker.frame.size.width
                    // Normal
                } else {
                    if component == 0 {
                        return (setsRepsPicker.frame.size.width / 3)
                    } else if component == 1{
                        return (setsRepsPicker.frame.size.width / 3)
                    }
                }
            case 2,3,4:
                return setsRepsPicker.frame.size.width
            default: break
            }
        }
        return 0
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        // Number of Rounds
        if selectingNumberOfRounds == true {
            // Do nothing
            // Set/Reps/Breaths
        } else {
            switch SelectedSession.shared.selectedSession[0] {
            case 0:
                if row == 0 {
                    self.setsIndicatorLabel.text = NSLocalizedString("set", comment: "")
                } else {
                    self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                }
            case 1:
                // If circuit
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    // Do nothing
                    // Normal
                } else {
                    if row == 0 {
                        self.setsIndicatorLabel.text = NSLocalizedString("set", comment: "")
                    } else {
                        self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                    }
                }
            default:
                break
            }
        }
    }
    
    
    //
    // Table View ------------------------------------------------------------------------------------------------------------
    //
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        switch tableView {
        case presetsTableView:
            return 1
        case customTableView:
            // Nothing selected
            if selectedPreset == -1 {
                return 0
                // Not workout
            } else if SelectedSession.shared.selectedSession[0] != 1 {
                return 1
                // Workout (could be circuit)
            } else {
                // Not circuit wokrout ([1] = -1 if circuit workout)
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    return customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int
                    // Circuit Workout
                } else {
                    return 1
                }
            }
        //
        case movementsTableView:
            let numberSections = sessionData.fullKeyArrays[SelectedSession.shared.selectedSession[0]].count
            return numberSections
        default: break
        }
        return 0
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        switch tableView {
        case presetsTableView:
            return " "
        //
        case customTableView:
            // Not workout
            if SelectedSession.shared.selectedSession[0] != 1 {
                return " "
                // Workout (could be circuit)
            } else {
                // If nothing
                // Circuit wokrout ([1] == -1 if circuit workout)
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    return " " + NSLocalizedString("round", comment: "") + " " + String(section + 1)
                } else {
                    return " "
                }
            }
        //
        case movementsTableView:
            return NSLocalizedString(sessionData.tableViewSectionArrays[SelectedSession.shared.selectedSession[0]][section] as String, comment: "")
        default: break
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        switch tableView {
        case presetsTableView:
            return 23.5
        //
        case customTableView:
            // Not workout
            if SelectedSession.shared.selectedSession[0] != 1 {
                return 1
                // Workout (could be circuit)
            } else {
                // If nothing
                // Circuit wokrout ([1] == -1 if circuit workout)
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    return 23.5
                } else {
                    return 1
                }
            }
        //
        case movementsTableView:
            return 23.5
        default: break
        }
        return 0
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        switch tableView {
        case presetsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 17)!
            header.textLabel?.textColor = Colours.colour1
            header.contentView.backgroundColor = Colours.colour2
            header.contentView.tintColor = Colours.colour1
        case customTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)!
            header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            header.contentView.tintColor = Colours.colour1
        //
        case movementsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)!
            header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            header.textLabel?.adjustsFontSizeToFitWidth = true
            header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            header.contentView.tintColor = Colours.colour1
        //
        default: break
        }
        
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        
        //
        switch tableView {
        case presetsTableView:
            return customSessionsArray[SelectedSession.shared.selectedSession[0]].count + 1
        //
        case customTableView:
            if selectedPreset == -1 || customSessionsArray[SelectedSession.shared.selectedSession[0]].count == 0 || customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].count == 0 {
                return 0
            } else {
                return (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]).count
            }
        //
        case movementsTableView:
            //
            let numberRows = sessionData.fullKeyArrays[SelectedSession.shared.selectedSession[0]][section].count
            return numberRows
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
            // Retreive Preset Sessions
            var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
            //
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = Colours.colour1
            cell.textLabel?.textColor = Colours.colour2
            cell.tintColor = Colours.colour2
            //
            if indexPath.row == (customSessionsArray[SelectedSession.shared.selectedSession[0]]).count {
                //
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
                //
                cell.layer.borderWidth = 1
                cell.layer.borderColor = Colours.colour2.cgColor
                //
            } else {
                //
                cell.textLabel?.text = customSessionsArray[SelectedSession.shared.selectedSession[0]][indexPath.row][0][0] as? String
            }
            //
            return cell
        //
        case customTableView:
            //
            let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            let keyIndex = (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int])[indexPath.row]
            cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[SelectedSession.shared.selectedSession[0]][keyIndex]! as String, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            //            cell.textLabel?.numberOfLines = 0
            //            cell.textLabel?.lineBreakMode = .byTruncatingTail
            cell.backgroundColor = Colours.colour1
            cell.textLabel?.textColor = Colours.colour2
            cell.tintColor = .black
            // Detail sets x reps
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
            cell.detailTextLabel?.textColor = Colours.colour2
            //
            // Find out session type
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup - Sets x Reps
            case 0:
                let setsInt = (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] as! [Int])[indexPath.row]
                let sets = String(setsInt)
                let reps = (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3] as! [String])[indexPath.row]
                cell.detailTextLabel?.text = sets + " x " + reps
            // Workout
            case 1:
                // Circuit - Reps
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    //
                    let numberOfMovements = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].count
                    let index = indexPath.row + (indexPath.section * numberOfMovements)
                    let reps = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3][index] as! String
                    cell.detailTextLabel?.text = reps + " " + NSLocalizedString("reps", comment: "")
                    // Normal - Sets x Reps
                } else {
                    let setsInt = (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] as! [Int])[indexPath.row]
                    let sets = String(setsInt)
                    let reps = (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3] as! [String])[indexPath.row]
                    cell.detailTextLabel?.text = sets + " x " + reps
                }
            // Cardio
            case 2:
                let timeInt = (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] as! [Int])[indexPath.row]
                let time = String(timeInt)
                cell.detailTextLabel?.text = time + NSLocalizedString("s", comment: "")
            // Stretching/Yoga - Breaths
            case 3,4:
                let breathsInt = (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] as! [Int])[indexPath.row]
                let breaths = String(breathsInt)
                cell.detailTextLabel?.text = breaths + " " + NSLocalizedString("breaths", comment: "")
            default:
                break
            }
            //
            // Cell Image
            cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][keyIndex]?[0])!)
            cell.imageView?.isUserInteractionEnabled = true
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleTap))
            cell.imageView?.addGestureRecognizer(imageTap)
            //
            return cell
        //
        case movementsTableView:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            let keyIndex = sessionData.fullKeyArrays[SelectedSession.shared.selectedSession[0]][indexPath.section][indexPath.row]
            cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[SelectedSession.shared.selectedSession[0]][keyIndex]! as String, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = .black
            cell.tintColor = .black
            // Cell Image
            cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][keyIndex]?[0])!)
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        switch tableView {
        case presetsTableView:
            return 44
        case customTableView:
            //
            if customSessionsArray[SelectedSession.shared.selectedSession[0]].count == 0 || (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]).count == 0 {
                return 49
                //
            } else {
                //
                if indexPath.row == (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]).count  {
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        
        //
        switch tableView {
        case presetsTableView:
            // Add Custom Workout
            if indexPath.row == (customSessionsArray[SelectedSession.shared.selectedSession[0]]  as [[Any]]).count {
                
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
                
                // Alert and Functions
                //
                let inputTitle = NSLocalizedString("sessionInputTitle", comment: "")
                //
                let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
                alert.view.tintColor = Colours.colour2
                alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
                //2. Add the text field
                alert.addTextField { (textField: UITextField) in
                    textField.text = " "
                    textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
                    textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
                }
                // 3. Get the value from the text field, and perform actions upon OK press
                okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    //
                    // Append relevant (to SelectedSession.shared.selectedSession[0]) new array to customSessionsArray
                    switch SelectedSession.shared.selectedSession[0] {
                    // Warmup, Workout,
                    case 0,1:
                        customSessionsArray[SelectedSession.shared.selectedSession[0]].append(customSectionEmtpySessions.emptySessionFour)
                    case 2,3,4:
                        customSessionsArray[SelectedSession.shared.selectedSession[0]].append(customSectionEmtpySessions.emptySessionThree)
                    //
                    default:
                        break
                    }
                    //
                    // Update Title
                    let textField = alert?.textFields![0]
                    let lastIndex = customSessionsArray[SelectedSession.shared.selectedSession[0]].count - 1
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][lastIndex][0][0] = textField?.text!
                    //
                    // Default mumber of rounds if relevant
                    if SelectedSession.shared.selectedSession[0] == 1 {
                        self.nRoundsButton.setTitle(NSLocalizedString("numberOfRounds", comment: "") + "1", for: .normal)
                    }
                    //
                    // SET NEW ARRAY
                    UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                    // Sync
                    ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
                    //
                    // Select new session and dismiss
                    let selectedIndexPath = NSIndexPath(row: lastIndex, section: 0)
                    self.presetsTableView.selectRow(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
                    self.selectedPreset = lastIndex
                    //
                    self.presetsTableView.isHidden = false
                    snapShot1?.removeFromSuperview()
                    self.backgroundViewExpanded.isHidden = false
                    //
                    // Presets title
                    let string = customSessionsArray[SelectedSession.shared.selectedSession[0]][self.selectedPreset][0][0] as! String
                    self.presetsButton.setTitle("- " + string + " -", for: .normal)
                    
                    //
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backgroundViewExpanded.alpha = 0.5
                        self.presetsTableView.reloadData()
                        // Dismiss and select new row
                    }, completion: { finished in
                        //
                        tableView.deselectRow(at: indexPath, animated: true)
                        // Reload
                        self.customTableView.reloadData()
                        self.beginButtonEnabled()
                        //
                        // Element Positions
                        self.presetsBottom.constant = self.view.frame.size.height - 73.5
                        self.tableViewConstraintTop.constant = 122.5
                        self.tableViewConstraintBottom.constant = 49
                        self.beginButtonConstraint.constant = 0
                        //
                        // Dismiss presets table
                        UIView.animate(withDuration: AnimationTimes.animationTime3, animations: {
                            self.view.layoutIfNeeded()
                        }, completion: nil)
                        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                            self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
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
                // Select Custom Workout
            } else {
                //
                selectedPreset = indexPath.row
                //
                // NUMBER OF ROUNDS title
                if SelectedSession.shared.selectedSession[0] == 1 {
                    // Rounds
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                        //
                        nRoundsButton.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String(customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int), for: .normal)
                        // No rounds
                    } else {
                        nRoundsButton.setTitle(NSLocalizedString("numberOfRounds", comment: "") + "1", for: .normal)
                    }
                }
                //
                if selectedPreset == -1 {
                    self.presetsButton.setTitle(NSLocalizedString(self.presetsButtonTitles[SelectedSession.shared.selectedSession[0]], comment: ""), for: .normal)
                } else {
                    let string = customSessionsArray[SelectedSession.shared.selectedSession[0]][self.selectedPreset][0][0] as! String
                    self.presetsButton.setTitle("- " + string + " -", for: .normal)
                    
                }
                //
                tableView.deselectRow(at: indexPath, animated: true)
                // Dismiss Table
                if customSessionsArray[SelectedSession.shared.selectedSession[0]].count != 0 {
                    //
                    // Element Positions
                    presetsBottom.constant = self.view.frame.size.height - 73.5
                    //
                    self.tableViewConstraintTop.constant = 122.5
                    self.tableViewConstraintBottom.constant = 49
                    //
                    self.beginButtonConstraint.constant = 0
                    //
                    // Dismiss presets table
                    UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                        self.customTableView.reloadData()
                        self.beginButtonEnabled()
                        self.view.layoutIfNeeded()
                        self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
                        self.backgroundViewExpanded.alpha = 0
                    }, completion: { finished in
                        //
                        self.presetsTableView.removeFromSuperview()
                        self.backgroundViewExpanded.removeFromSuperview()
                    })
                }
                //
                customTableView.reloadData()
                //
            }
            //
        //
        case customTableView:
            //
            selectedRow = indexPath.row
            selectedSection = indexPath.section
            //
            setsRepsPicker.reloadAllComponents()
            // View
            UIApplication.shared.keyWindow?.insertSubview(setsRepsView, aboveSubview: view)
            //
            // Set component widths, indicator label frame and select row in picker
            let componentWidth = setsRepsPicker.frame.size.width / 3
            let componentWidthFourth = componentWidth / 4
            // Find out session type
            // Switch SelectedSession.shared.selectedSession[0] and SelectedSession.shared.selectedSession[1]
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup - Sets x Reps
            case 0:
                self.setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: self.setsRepsView.frame.size.width + componentWidthFourth, height: 147)
                self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
                self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                // Select row in picker
                let setsIndex = setsPickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][indexPath.row] as! Int)
                setsRepsPicker.selectRow(setsIndex!, inComponent: 0, animated: true)
                let repsIndex = repsPickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3][indexPath.row] as! String)
                setsRepsPicker.selectRow(repsIndex!, inComponent: 1, animated: true)
                
            // Workout
            case 1:
                // Circuit - Reps
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    //
                    self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
                    self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
                    self.setsIndicatorLabel.text = NSLocalizedString("reps", comment: "")
                    // Select row in picker
                    let repsIndex = repsPickerArrayCircuit.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3][indexPath.row] as! String)
                    setsRepsPicker.selectRow(repsIndex!, inComponent: 0, animated: true)
                    // Normal - Sets x Reps
                } else {
                    self.setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: self.setsRepsView.frame.size.width + componentWidthFourth, height: 147)
                    self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
                    self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                    // Select row in picker
                    let setsIndex = setsPickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][indexPath.row] as! Int)
                    setsRepsPicker.selectRow(setsIndex!, inComponent: 0, animated: true)
                    let repsIndex = repsPickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3][indexPath.row] as! String)
                    setsRepsPicker.selectRow(repsIndex!, inComponent: 1, animated: true)
                }
            // Cardio
            case 2:
                self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
                self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
                self.setsIndicatorLabel.text = NSLocalizedString("s", comment: "")
                // Select row in picker
                let timeIndex = timePickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][indexPath.row] as! Int)
                setsRepsPicker.selectRow(timeIndex!, inComponent: 0, animated: true)
            // Stretching/Yoga - Breaths
            case 3,4:
                self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
                self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
                self.setsIndicatorLabel.text = NSLocalizedString("breaths", comment: "")
                // Select row in picker
                let breathsIndex = breathsPickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][indexPath.row] as! Int)
                setsRepsPicker.selectRow(breathsIndex!, inComponent: 0, animated: true)
                
            default:
                break
            }
            // okButton
            okButton.frame = CGRect(x: 0, y: 147, width: setsRepsView.frame.size.width, height: 49)
            //
            UIApplication.shared.keyWindow?.insertSubview(setsRepsView, aboveSubview: view)
            setsRepsView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: UIScreen.main.bounds.width - 20, height: 147 + 49)
            //
            backgroundViewExpanded.alpha = 0
            UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: setsRepsView)
            backgroundViewExpanded.frame = UIScreen.main.bounds
            //
            // Animate Picker in
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.setsRepsView.frame = CGRect(x: 10, y: self.view.frame.maxY - 147 - 49 - 10, width: UIScreen.main.bounds.width - 20, height: 147 + 49)
                // ok
                self.okButton.frame = CGRect(x: 0, y: 147, width: self.setsRepsView.frame.size.width, height: 49)
                // Sets Indicator Label
                self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
                self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                //
                self.backgroundViewExpanded.alpha = 0.7
                //
                // Redo Sets indicator and picker frame
                switch SelectedSession.shared.selectedSession[0] {
                // Warmup - Sets x Reps
                case 0:
                    self.setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: self.setsRepsView.frame.size.width + componentWidthFourth, height: 147)
                    self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
                    self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                // Workout
                case 1:
                    // Circuit - Reps
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]][self.selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][self.selectedPreset][2][1] as! Int == -1 {
                        //
                        self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
                        self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.21, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
                        self.setsIndicatorLabel.text = NSLocalizedString("reps", comment: "")
                        // Normal - Sets x Reps
                    } else {
                        self.setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: self.setsRepsView.frame.size.width + componentWidthFourth, height: 147)
                        self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
                        self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                    }
                // Cardio
                case 2:
                    self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
                    self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
                    self.setsIndicatorLabel.text = NSLocalizedString("s", comment: "")
                // Stretching/Yoga - Breaths
                case 3,4:
                    self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
                    self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 130, height: 30)
                    self.setsIndicatorLabel.text = NSLocalizedString("breaths", comment: "")
                default:
                    break
                }
            }, completion: nil)
            
        //
        case movementsTableView:
            //
            // Append movement
            customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].append(sessionData.fullKeyArrays[SelectedSession.shared.selectedSession[0]][indexPath.section][indexPath.row])
            // Sets/Reps/Breaths
            //
            // Find out session type
            // Switch SelectedSession.shared.selectedSession[0] and SelectedSession.shared.selectedSession[1]
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup
            case 0:
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].append(1)
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].append("1")
            // Workout
            case 1:
                // Circuit
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    //
                    let numberOfRounds = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int
                    for i in 0...numberOfRounds - 1 {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].insert("1", at: i)
                    }
                    
                    // Normal
                } else {
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].append(1)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].append("1")
                }
            // Cardio
            case 2:
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].append(30)
            // Stretching/Yoga
            case 3,4:
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].append(5)
            default:
                break
            }
            
            //
            // SET ARRAY
            UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
            //
            // Remove Table
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.movementsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.movementsTableView.frame.size.width, height: self.movementsTableView.frame.size.height)
                //
                self.backgroundViewExpanded.alpha = 0
                //
                self.beginButtonEnabled()
                //
            }, completion: { finished in
                self.movementsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
                //
                self.customTableView.reloadData()
                // Scroll to Bottom
                if self.customTableView.contentSize.height > self.customTableView.frame.size.height {
                    let scrollIndex = NSIndexPath(row: customSessionsArray[SelectedSession.shared.selectedSession[0]][self.selectedPreset][1].count - 1, section: 0)
                    self.customTableView.scrollToRow(at: scrollIndex as IndexPath, at: .top, animated: true)
                }
            })
        //
        default: break
        }
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Enable ok alert action func
    @objc func textChanged(_ sender: UITextField) {
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        switch tableView {
        case presetsTableView:
            
            //
            if indexPath.row < (customSessionsArray[SelectedSession.shared.selectedSession[0]]  as [[Any]]).count {
                return true
            }
        case movementsTableView: return false
        case customTableView:
            //
            if customSessionsArray[SelectedSession.shared.selectedSession[0]].count == 0 || (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]).count == 0 {
                return false
            } else {
                if indexPath.row == (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]).count {
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        switch tableView {
        case presetsTableView: return false
        case movementsTableView: return false
        case customTableView:
            //
            if (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]).count == 0 {
                return false
            } else {
                if indexPath.row == (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]).count {
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        // Key
        let itemToMove = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].remove(at: sourceIndexPath.row)
        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].insert(itemToMove, at: destinationIndexPath.row)
        //
        // Sets
        if SelectedSession.shared.selectedSession[0] == 0 {
            let setToMove = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].remove(at: sourceIndexPath.row)
            customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].insert(setToMove, at: destinationIndexPath.row)
        }
        //
        // Reps
        if SelectedSession.shared.selectedSession[0] == 0 {
            let repToMove = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].remove(at: sourceIndexPath.row)
            customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].insert(repToMove, at: destinationIndexPath.row)
        } else {
            for _ in 0...((customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3] as! [Int]).count - 1) {
                let repToMove = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].remove(at: sourceIndexPath.row)
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].insert(repToMove, at: destinationIndexPath.row)
            }
            
        }
        //
        //
        // SET NEW ARRAY
        UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
        
        //
        tableView.reloadData()
    }
    
    // Target index path for move from row
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        
        //
        if proposedDestinationIndexPath.row == (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]).count {
            return NSIndexPath(row: proposedDestinationIndexPath.row - 1, section: proposedDestinationIndexPath.section) as IndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
    
    // Delete button title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        //
        if tableView == customTableView {
            return NSLocalizedString("remove", comment: "")
        } else {
            return NSLocalizedString("delete", comment: "")
        }
    }
    
    // Commit editing style
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            switch tableView {
            case presetsTableView:
                // New array
                customSessionsArray[SelectedSession.shared.selectedSession[0]].remove(at: indexPath.row)
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
                //
                UIView.animate(withDuration: 0.2, animations: {
                    self.presetsTableView.reloadData()
                })
                //
                self.selectedPreset = -1
                self.customTableView.reloadData()
                self.beginButtonEnabled()
                //
                UIView.animate(withDuration: 0.2, animations: {
                    self.presetsTableView.reloadData()
                    //
                    if self.selectedPreset == -1 {
                        self.presetsButton.setTitle(NSLocalizedString(self.presetsButtonTitles[SelectedSession.shared.selectedSession[0]], comment: ""), for: .normal)
                    } else {
                        let string = customSessionsArray[SelectedSession.shared.selectedSession[0]][self.selectedPreset][0][0] as! String
                        self.presetsButton.setTitle("- " + string + " -", for: .normal)
                    }
                })
                //
                //
                self.presetsTableView.isHidden = false
                //
                self.backgroundViewExpanded.isHidden = false
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundViewExpanded.alpha = 0.5
                    self.presetsTableView.reloadData()
                    // Dismiss and select new row
                }, completion: { finished in
                    //
                    tableView.deselectRow(at: indexPath, animated: true)
                    //
                    // Reload Data
                    self.customTableView.reloadData()
                    self.beginButtonEnabled()
                    //
                    // Initial Element Positions
                    self.presetsBottom.constant = 0
                    self.tableViewConstraintTop.constant = self.view.frame.size.height
                    self.tableViewConstraintBottom.constant = -49
                    self.beginButtonConstraint.constant = -49
                })
            //
            case customTableView:
                //
                // Key
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].remove(at: indexPath.row)
                
                // Sets/Reps/Breaths
                //
                // Find out session type
                // Switch SelectedSession.shared.selectedSession[0] and SelectedSession.shared.selectedSession[1]
                switch SelectedSession.shared.selectedSession[0] {
                // Warmup
                case 0:
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].remove(at: indexPath.row)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].remove(at: indexPath.row)
                // Workout
                case 1:
                    // Circuit
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                        //
                        let numberOfRounds = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int
                        let nMovements = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].count
                        
                        for i in (1...numberOfRounds).reversed() {
                            //
                            let lastIndexInRound = (i * nMovements) - 1
                            let removeFromLastIndex = (nMovements - 1) - indexPath.row
                            let indexToRemove = lastIndexInRound - removeFromLastIndex
                            customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].remove(at: indexToRemove)
                        }
                        
                        // Normal
                    } else {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].remove(at: indexPath.row)
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].remove(at: indexPath.row)
                    }
                // Cardio/Stretching/Yoga
                case 2,3,4:
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].remove(at: indexPath.row)
                default:
                    break
                }
                
                //
                // SET NEW ARRAY
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
                //
                switch SelectedSession.shared.selectedSession[0] {
                case 0,2,3,4:
                    tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                case 1:
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                        var indexArray: [IndexPath] = []
                        for i in 1...(customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int) {
                            let row = indexPath.row
                            let section = i - 1
                            let indexPathToRemove = NSIndexPath(row: row, section: section)
                            indexArray.append(indexPathToRemove as IndexPath)
                        }
                        tableView.deleteRows(at: indexArray, with: UITableViewRowAnimation.automatic)
                    } else {
                        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                    }
                default: break
                }
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
        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
        let tableHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
        let tableWidth = UIScreen.main.bounds.width - 20
        self.presetsTableView.frame = CGRect(x: 10, y: view.frame.maxY, width: tableWidth, height: tableHeight)
        //
        //
        backgroundViewExpanded.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: presetsTableView)
        backgroundViewExpanded.frame = UIScreen.main.bounds
        // Animate table fade and size
        // Position
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
            self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY - tableHeight - 10, width: tableWidth, height: tableHeight)
            self.presetsTableView.reloadData()
            //
            self.backgroundViewExpanded.alpha = 0.5
        }, completion: nil)
        //
    }
    
    // Number Of Rounds Action
    @IBAction func numberOfRoundsAction(_ sender: Any) {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        selectingNumberOfRounds = true
        setsRepsPicker.reloadAllComponents()
        //
        UIApplication.shared.keyWindow?.insertSubview(setsRepsView, aboveSubview: view)
        setsRepsView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 73.5, width: UIScreen.main.bounds.width - 40, height: 44)
        //
        // selected number of rows
        setsRepsPicker.selectRow(roundsPickerArray.index(of: (customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int))!, inComponent: 0, animated: true)
        //
        // picker
        self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
        self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
        self.setsIndicatorLabel.text = NSLocalizedString("rounds", comment: "")
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: setsRepsView.frame.size.width, height: 49)
        //
        backgroundViewExpanded.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: setsRepsView)
        backgroundViewExpanded.frame = UIScreen.main.bounds
        // Animate table fade and size
        // Position
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.setsRepsView.frame = CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: 147 + 49)
            self.setsRepsView.center.y = self.view.center.y - ((UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!) / 2)
            // picker
            self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
            self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
            // ok
            self.okButton.frame = CGRect(x: 0, y: 147, width: self.setsRepsView.frame.size.width, height: 49)
            // Sets Indicator Label
            //
            //
            self.backgroundViewExpanded.alpha = 0.7
            
        }, completion: nil)
    }
    
    
    
    // Add movement table background (dismiss table)
    @objc func backgroundViewExpandedAction(_ sender: Any) {
        //
        if (UIApplication.shared.keyWindow?.subviews.contains(self.presetsTableView))! {
            //
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
        } else {
            if selectingNumberOfRounds == true {
                selectingNumberOfRounds = false
            }
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.movementsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.movementsTableView.frame.size.width, height: self.movementsTableView.frame.size.height)
                self.setsRepsView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.setsRepsView.frame.size.width, height: self.setsRepsView.frame.size.height)
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
    
    
    //
    // Picker Related actions ------------------------------------------------------------------------------------------------
    //
    // Ok button action
    @objc func okButtonAction(_ sender: Any) {
        //
        // NUMBER OF ROUNDS!
        if selectingNumberOfRounds == true {
            selectingNumberOfRounds = false
            var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
            let numberOfMovements = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].count
            //
            nRoundsButton.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String(roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]), for: .normal)
            //
            // Empty session -> Empty session
            if numberOfMovements == 0 {
                // Selecting 1 round (not circuit)
                if setsRepsPicker.selectedRow(inComponent: 0) == 0 {
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count != 0 {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] = []
                    }
                    // Selecting > 1 round (circuit)
                } else {
                    // Update values
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count != 0 {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] = roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
                        // Append values
                    } else {
                        // Append nRounds
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].append(roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)])
                        // Append circuit indicator
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].append(-1)
                    }
                }
                // Set
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
                //
                // Circuit -> Non-circuit
                // If selected a non circuit workout, i.e selectedRounds = 1
            } else if setsRepsPicker.selectedRow(inComponent: 0) == 0 {
                //
                // If it was previously a circuit workout do something (if not do nothing)
                // Isn't empty && roundsArray[1] == -1 (indicating its a circuit workout)
                if numberOfMovements != 0 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    //
                    // Set sets and reps array same length as movements array by removing &&
                    let nRoundsOld = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int
                    let nToRemove = nRoundsOld - 1
                    for _ in 1...nToRemove {
                        for _ in 1...numberOfMovements {
                            customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].removeLast()
                        }
                    }
                    // Reset sets to 0, and append 1 for each movement (new set always 1)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] = []
                    for _ in 1...numberOfMovements {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].append(1)
                    }
                    // Set
                    UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                    // Sync
                    ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
                }
                //
                //
                // Non-circuit -> Circuit
                // If nMovments != 0 &&
                // either [2].count not 2 or
                // [2].count 2 and [2][1] != -1 (as if == -1 then circuit workout)
            } else if numberOfMovements != 0 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count != 2 || numberOfMovements != 0 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int != -1 {
                // Sets array -> Rounds array
                // Clear sets array
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] = []
                // Append nRounds
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].append(roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)])
                // Append circuit indicator
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].append(-1)
                // Reps array -> rounds reps array (add new set of x(nMovements) reps for each round)
                // For each round (-2 as round 1 already there)
                for _ in 0...roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)] - 2 {
                    // for each movement
                    for i in 0...numberOfMovements - 1 {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].append(customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3][i])
                    }
                }
                // Set
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
                
                //
                // Circuit -> Circuit
                // If circuit workout
            } else if numberOfMovements != 0 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                // Note: nRoundsNew == nRoundsOld, do nothing (therefore no if for such a case)
                let nRoundsNew = roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
                let nRoundsOld = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int
                //
                // nRoundsNew > nRoundsOld
                if nRoundsNew > nRoundsOld {
                    // Change number of rounds
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] = nRoundsNew
                    // Add reps
                    let nRoundsToAdd = nRoundsNew - nRoundsOld
                    for _ in 1...nRoundsToAdd {
                        for _ in 1...numberOfMovements {
                            customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].append("1")
                        }
                    }
                    //
                    // nRoundsNew < nRoundOld
                } else if nRoundsNew < nRoundsOld {
                    // Change number of rounds
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] = nRoundsNew
                    // Remove reps
                    let nRoundsToRemove = nRoundsOld - nRoundsNew
                    for _ in 1...nRoundsToRemove {
                        // for each movement
                        for _ in 0...numberOfMovements - 1 {
                            customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].removeLast()
                        }
                    }
                }
                // Set
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
                
            }
            //
            //
            // SETS/REPS/BREATHS/TIME
        } else {
            var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
            //
            // Find out session type
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup - Sets x Reps
            case 0:
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][selectedRow] = setsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3][selectedRow] = repsPickerArray[setsRepsPicker.selectedRow(inComponent: 1)]
            // Workout
            case 1:
                // Circuit - Reps
                if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                    //
                    let numberOfMovements = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].count
                    let index = selectedRow + (selectedSection * numberOfMovements)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3][index] = repsPickerArrayCircuit[setsRepsPicker.selectedRow(inComponent: 0)]
                    // Normal - Sets x Reps
                } else {
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][selectedRow] = setsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3][selectedRow] = repsPickerArray[setsRepsPicker.selectedRow(inComponent: 1)]
                }
            // Cardio
            case 2:
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][selectedRow] = timePickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
            // Stretching/Yoga - Breaths
            case 3,4:
                customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][selectedRow] = breathsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
            default:
                break
            }
            //
            // SET NEW ARRAY
            UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
            
        }
        //
        // Animate picker down and off
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            self.setsRepsView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.setsRepsView.frame.size.width, height: self.setsRepsView.frame.size.height)
            self.backgroundViewExpanded.alpha = 0
        }, completion: { finished in
            self.setsRepsView.removeFromSuperview()
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
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandedImage.center.y = (height/2) * 1.5
            self.backgroundViewImage.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract image
    @IBAction func retractImage(_ sender: Any) {
        //
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        //
        UIView.animate(withDuration: AnimationTimes.animationTime2, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
    // Long press reorder
    @objc func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        
        let longpress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longpress.state
        let locationInView = longpress.location(in: self.customTableView)
        var indexPath = self.customTableView.indexPathForRow(at: locationInView)
        
        switch state {
        case .began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath
                let cell = self.customTableView.cellForRow(at: indexPath!)
                My.cellSnapShot = snapshopOfCell(inputView: cell!)
                var center = cell?.center
                My.cellSnapShot?.center = center!
                My.cellSnapShot?.alpha = 0.0
                self.customTableView.addSubview(My.cellSnapShot!)
                
                center?.y = locationInView.y
                My.cellSnapShot?.center = center!
                My.cellSnapShot?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                My.cellSnapShot?.alpha = 0.98
                cell?.isHidden = true
            }
            
        // Reorder
        case .changed:
            var center = My.cellSnapShot?.center
            center?.y = locationInView.y
            My.cellSnapShot?.center = center!
            if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) && indexPath?.section == Path.initialIndexPath?.section {
                //
                var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
                
                //
                // Find out session type
                // Switch SelectedSession.shared.selectedSession[0] and SelectedSession.shared.selectedSession[1]
                switch SelectedSession.shared.selectedSession[0] {
                // Warmup
                case 0:
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                // Workout
                case 1:
                    // Circuit
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                        // Swap movements
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                        // Swap reps
                        let numberOfRounds = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int
                        let numberOfMovements = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].count
                        // For each round, swap the reps index's
                        // A workout with 3 movements and 3 rounds will have 9 reps (012,345,678), each set of 3 corresponding to the round
                        // Swapping 0 and 1 gives (102,435,768)
                        for i in 0...numberOfRounds - 1 {
                            // + (numberOfMovements * i) to find the index in each round
                            let from = (indexPath?.row)! + (numberOfMovements * i)
                            let to  = (Path.initialIndexPath?.row)! + (numberOfMovements * i)
                            customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].swapAt((from), (to))
                        }
                        //
                        // Normal
                    } else {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                        customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                    }
                // Cardio/Stretching/Yoga
                case 2,3,4:
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                default:
                    break
                }
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
                //
                self.customTableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                Path.initialIndexPath = indexPath
                //
            }
            
        default:
            let cell = self.customTableView.cellForRow(at: Path.initialIndexPath!)
            cell?.isHidden = false
            cell?.alpha = 0.0
            UIView.animate(withDuration: 0.25, animations: {
                My.cellSnapShot?.center = (cell?.center)!
                My.cellSnapShot?.transform = .identity
                My.cellSnapShot?.alpha = 0.0
                cell?.alpha = 1.0
            }, completion: { (finished) -> Void in
                if finished {
                    Path.initialIndexPath = nil
                    My.cellSnapShot?.removeFromSuperview()
                    My.cellSnapShot = nil
                }
            })
            //
            // Reload other sections if circuit workout
            let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
            if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                let numberOfRounds = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int
                var sections = IndexSet(integersIn: 0...numberOfRounds - 1)
                sections.remove((indexPath?.section)!)
                customTableView.reloadSections(sections, with: .automatic)
            }
        }
    }
    
    func snapshopOfCell(inputView: UIView) -> UIView {
        
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
    struct My {
        static var cellSnapShot: UIView? = nil
    }
    
    struct Path {
        static var initialIndexPath: IndexPath? = nil
    }
    
    //
    // Add Movement ------------------------------------------------------
    //
    @IBAction func addMovementAction(_ sender: Any) {
        //
        let height = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49
        //
        UIApplication.shared.keyWindow?.insertSubview(movementsTableView, aboveSubview: view)
        movementsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: UIScreen.main.bounds.width - 20, height: height)
        //
        backgroundViewExpanded.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: movementsTableView)
        backgroundViewExpanded.frame = UIScreen.main.bounds
        //
        // Animate table
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.movementsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY - height - 10, width: UIScreen.main.bounds.width - 20, height: height)
            //
            self.backgroundViewExpanded.alpha = 0.7
        }, completion: nil)
    }
    
    //
    // MARK: Nº Rounds Action
    @IBAction func nRoundsAction(_ sender: Any) {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        selectingNumberOfRounds = true
        setsRepsPicker.reloadAllComponents()
        //        let test1 = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int
        //        let test2 = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] as! [Int]
        // [1] == -1 indicates circuit workout
        if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
            let index = roundsPickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int)
            setsRepsPicker.selectRow(index!, inComponent: 0, animated: true)
        } else {
            setsRepsPicker.selectRow(0, inComponent: 0, animated: true)
        }
        // picker
        self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
        self.setsIndicatorLabel.text = NSLocalizedString("", comment: "")
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: setsRepsView.frame.size.width, height: 49)
        //
        UIApplication.shared.keyWindow?.insertSubview(setsRepsView, aboveSubview: view)
        setsRepsView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: UIScreen.main.bounds.width - 20, height: 147 + 49)
        //
        backgroundViewExpanded.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: setsRepsView)
        backgroundViewExpanded.frame = UIScreen.main.bounds
        //
        // Animate table
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.setsRepsView.frame = CGRect(x: 10, y: self.view.frame.maxY - 147 - 49 - 10, width: UIScreen.main.bounds.width - 20, height: 147 + 49)
            //
            self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
            // ok
            self.okButton.frame = CGRect(x: 0, y: 147, width: self.setsRepsView.frame.size.width, height: 49)
            //
            self.backgroundViewExpanded.alpha = 0.7
        }, completion: nil)
        
    }
    
    
    //
    // Begin Button ------------------------------------------------------------------------------------------------
    //
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        
        // Segue
        switch SelectedSession.shared.selectedSession[0] {
        // Warmup
        case 0:
            // Warmup uses stretching Screen
            performSegue(withIdentifier: "customSessionSegueStretching", sender: self)
        // Workout
        case 1:
            // If circuit session
            if customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2].count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][1] as! Int == -1 {
                performSegue(withIdentifier: "customSessionSegueCircuit", sender: self)
                // Normal session
            } else {
                performSegue(withIdentifier: "customSessionSegue", sender: self)
            }
        // Cardio
        case 2:
            performSegue(withIdentifier: "customSessionSegueCardio", sender: self)
        // Stretching
        case 3:
            performSegue(withIdentifier: "customSessionSegueStretching", sender: self)
        // Yoga
        case 4:
            performSegue(withIdentifier: "customSessionSegueYoga", sender: self)
        default:
            break
        }
        
        //
        // Return background to homescreen
        perform(#selector(popToRootView), with: Any?.self, afterDelay: 0.5)
    }
    
    // Pop to root view
    @objc func popToRootView() {
        _ = self.navigationController?.popToRootViewController(animated: false)
    }
    
    
    //
    // Pass Arrays ------------------------------------------------------------------------------------------------
    //
    // Pass Array to next ViewController
    //
    // Prepare for segue Cardio
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        switch segue.identifier {
        // Warmup / Stretching
        case "customSessionSegueStretching"?:
            // Warmup
            let destinationVC = segue.destination as! StretchingScreen
            destinationVC.fromCustom = true
            destinationVC.keyArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]
            destinationVC.setsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] as! [Int]
            destinationVC.repsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3] as! [String]
            // Stretching
            destinationVC.breathsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] as! [Int]
        // Circuit Workout
        case "customSessionSegueCircuit"?:
            let destinationVC = segue.destination as! CircuitWorkoutScreen
            destinationVC.fromCustom = true
            destinationVC.keyArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]
            destinationVC.numberOfRounds = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2][0] as! Int
            destinationVC.repsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3] as! [String]
        // Normal Workout
        case "customSessionSegue"?:
            let destinationVC = segue.destination as! SessionScreen
            destinationVC.fromCustom = true
            destinationVC.keyArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]
            destinationVC.setsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] as! [Int]
            destinationVC.repsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][3] as! [String]
        // Cardio
        case "customSessionSegueCardio"?:
            let destinationVC = segue.destination as! CardioScreen
            destinationVC.fromCustom = true
            destinationVC.keyArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]
            destinationVC.lengthArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] as! [Int]
        // Yoga
        case "customSessionSegueYoga"?:
            let destinationVC = segue.destination as! YogaScreen
            destinationVC.fromCustom = true
            destinationVC.keyArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][1] as! [Int]
            destinationVC.breathsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]][selectedPreset][2] as! [Int]
        default:
            break
        }
        
        if segue.identifier == "sessionSegueCardio" {
            //
            let destinationVC = segue.destination as! CardioScreen
            //
            destinationVC.sessionType = 0
        }
    }
    //
}

