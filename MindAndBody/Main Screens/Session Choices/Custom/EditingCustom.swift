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
class EditingCustom: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //
    // Selected row
    var selectedRow = Int()
    var selectedSection = Int()
    //
    var selectedSession = 0
    //
    var selectingNumberOfRounds = false
    
    var creatingSession = false
    
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
    
    // Rounds
    // Note: if 1, "1 (not a circuit workout)"
    var roundsPickerArray: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        
    //
    // Outlets ---------------------------------------------------------------------------------------------------------------------------
    //
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Name
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameButton: UIButton!
    
    // N Rounds
    @IBOutlet weak var roundsTitleLabel: UILabel!
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var roundsButton: UIButton!
    @IBOutlet weak var roundsHeight: NSLayoutConstraint!
    
    // Separators
    @IBOutlet weak var topSeparator: UIView!
    @IBOutlet weak var topSeparator2: UIView!
    @IBOutlet weak var topSeparator3: UIView!
    
    // Table View
    @IBOutlet weak var customTableView: UITableView!
    
    // Action Buttons
    @IBOutlet weak var newMovementButton: UIButton!
    
    //
    let emptyString = ""
    
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
    // View did load  ---------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]

        // If Workout, option for circuit workout (numberofrounds)
        if SelectedSession.shared.selectedSession[0] != "workout" {
            roundsHeight.constant = 0
            roundsButton.alpha = 0
            roundsTitleLabel.alpha = 0
            roundsLabel.alpha = 0
            roundsButton.isEnabled = false
            topSeparator2.alpha = 0
        } else {
            roundsHeight.constant = 44
            roundsTitleLabel.text = nRoundsTitle
            // Rounds
            if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                //
                roundsLabel.text = String(customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] as! Int)
            // No rounds
            } else {
                roundsLabel.text = "1"
            }
        }
        // Add movement button
        switch SelectedSession.shared.selectedSession[0] {
        case "warmup", "workout":
            newMovementButton.setTitle(NSLocalizedString("addMovement", comment: ""), for: .normal)
        case "cardio":
            newMovementButton.setTitle(NSLocalizedString("addInterval", comment: ""), for: .normal)
        case "stretching":
            newMovementButton.setTitle(NSLocalizedString("addStretch", comment: ""), for: .normal)
        case "yoga":
            newMovementButton.setTitle(NSLocalizedString("addPose", comment: ""), for: .normal)
        default: break
        }
        newMovementButton.setTitleColor(Colors.dark, for: .normal)
        newMovementButton.setImage(#imageLiteral(resourceName: "Plus"), for: .normal)
        newMovementButton.titleLabel?.font = Fonts.smallElementLight
        
        roundsTitleLabel.font = Fonts.smallElementLight
        roundsLabel.font = Fonts.smallElementLight
        
        //
        nameButton.backgroundColor = Colors.light
        nameTitleLabel.text = NSLocalizedString("nameTitle", comment: "")
        nameTitleLabel.font = Fonts.smallElementLight
        nameTitleLabel.isUserInteractionEnabled = false
        if customSessionsArray[SelectedSession.shared.selectedSession[0]]![self.selectedSession]["name"]![0] as! String == "" {
            nameLabel.text = NSLocalizedString("chooseName", comment: "")
        } else {
            nameLabel.text = customSessionsArray[SelectedSession.shared.selectedSession[0]]![self.selectedSession]["name"]![0] as? String
        }
        nameLabel.font = Fonts.smallElementLight
        nameLabel.isUserInteractionEnabled = false
        
        topSeparator.backgroundColor = Colors.dark.withAlphaComponent(0.27)
        topSeparator2.backgroundColor = Colors.dark.withAlphaComponent(0.27)
        topSeparator3.backgroundColor = Colors.dark.withAlphaComponent(0.27)
        
        // Navigation Bar Title
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("editSchedule", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)

        // Creating
        if creatingSession {
            setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("create", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)
        // Editing
        } else {
            setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("edit", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)
        }
        
        navigationBar.leftBarButtonItem?.tintColor = Colors.light
        navigationBar.leftBarButtonItem?.title = NSLocalizedString("done", comment: "")
        navigationBar.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBarButton!], for: .normal)
        
        
        // TableView
        // TableView Background
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = Colors.light
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.customTableView.frame.size.width, height: self.customTableView.frame.size.height)
        //
        customTableView.backgroundView = tableViewBackground
        // TableView Cell action items
        //
        // Movement table
        movementsTableView.backgroundColor = Colors.dark
        movementsTableView.delegate = self
        movementsTableView.dataSource = self
        movementsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        movementsTableView.layer.cornerRadius = 15
        movementsTableView.layer.masksToBounds = true
        //
        // Sets Reps Selection
        // view
        setsRepsView.backgroundColor = Colors.dark
        setsRepsView.layer.cornerRadius = 15
        setsRepsView.layer.masksToBounds = true
        // picker
        setsRepsPicker.backgroundColor = Colors.dark
        setsRepsPicker.delegate = self
        setsRepsPicker.dataSource = self
        // ok
        okButton.backgroundColor = Colors.light
        okButton.setTitleColor(Colors.green, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        // sets
        setsIndicatorLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        setsIndicatorLabel.textColor = Colors.light
        setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
        //
        setsRepsView.addSubview(setsRepsPicker)
        setsRepsView.addSubview(okButton)
        setsRepsView.addSubview(setsIndicatorLabel)
        setsRepsView.bringSubview(toFront: setsIndicatorLabel)
        //
        // Colour
        self.view.backgroundColor = Colors.light
        
        // Long press reorder
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(gestureRecognizer:)))
        customTableView.addGestureRecognizer(longPress)
    }
    
    //
    // View did layout subviews Actions -------------------------------------------------------------------------------------------------
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // TableView Footer
        let footerView = UIView(frame: .zero)
        footerView.backgroundColor = .clear
        customTableView.tableFooterView = footerView
        //
    }
    
    //
    // MARK: Picker View
    //
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        // Number of Rounds
        if selectingNumberOfRounds {
            return 1
            // Set/Reps/Breaths
        } else {
            switch SelectedSession.shared.selectedSession[0] {
            case "warmup":
                return 2
            case "workout":
                // If circuit
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    return 1
                    // Normal
                } else {
                    return 2
                }
            case "cardio", "stretching", "yoga":
                return 1
            default:
                break
            }
        }
        return 0
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        // Number of Rounds
        if selectingNumberOfRounds {
            return roundsPickerArray.count
        } else {
            switch SelectedSession.shared.selectedSession[0] {
            case "warmup":
                if component == 0 {
                    return setsPickerArray.count
                } else {
                    return repsPickerArray.count
                }
            case "workout":
                // If circuit
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    return repsPickerArrayCircuit.count
                    // Normal
                } else {
                    if component == 0 {
                        return setsPickerArray.count
                    } else {
                        return repsPickerArray.count
                    }
                }
            case "cardio":
                return timePickerArray.count
            case "stretching", "yoga":
                return breathsPickerArray.count
            default: break
            }
        }
        return 0
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        // Number of Rounds
        if selectingNumberOfRounds {
            let roundLabel = UILabel()
            roundLabel.text = String(roundsPickerArray[row])
            if row == 0 {
                roundLabel.text = String(roundsPickerArray[row]) + NSLocalizedString("notCircuitWorkout", comment: "")
            }
            roundLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
            roundLabel.textColor = Colors.light
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
            case "warmup":
                //
                if component == 0 {
                    let setsLabel = UILabel()
                    setsLabel.text = String(setsPickerArray[row])
                    setsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                    setsLabel.textColor = Colors.light
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
                    repsLabel.textColor = Colors.light
                    repsLabel.textAlignment = .center
                    return repsLabel
                    //
                }
            // Workout
            case "workout":
                // Circuit - Reps
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    //
                    let repsLabel = UILabel()
                    repsLabel.text = String(repsPickerArrayCircuit[row])
                    repsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                    repsLabel.textColor = Colors.light
                    repsLabel.textAlignment = .center
                    return repsLabel
                    // Normal - Sets x Reps
                } else {
                    //
                    if component == 0 {
                        let setsLabel = UILabel()
                        setsLabel.text = String(setsPickerArray[row])
                        setsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                        setsLabel.textColor = Colors.light
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
                        repsLabel.textColor = Colors.light
                        repsLabel.textAlignment = .center
                        return repsLabel
                        //
                    }
                }
            // Cardio
            case "cardio":
                //
                let timeLabel = UILabel()
                timeLabel.text = String(timePickerArray[row])
                timeLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                timeLabel.textColor = Colors.light
                timeLabel.textAlignment = .center
                return timeLabel
            // Stretching/Yoga - Breaths
            case "stretching", "yoga":
                //
                let breathsLabel = UILabel()
                breathsLabel.text = String(breathsPickerArray[row])
                breathsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                breathsLabel.textColor = Colors.light
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
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        // Number of Rounds
        if selectingNumberOfRounds {
            return setsRepsPicker.frame.size.width
            // Set/Reps/Breaths
        } else {
            switch SelectedSession.shared.selectedSession[0] {
            case "warmup":
                if component == 0 {
                    return (setsRepsPicker.frame.size.width / 3)
                } else if component == 1{
                    return (setsRepsPicker.frame.size.width / 3)
                }
            case "workout":
                // If circuit
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    return setsRepsPicker.frame.size.width
                    // Normal
                } else {
                    if component == 0 {
                        return (setsRepsPicker.frame.size.width / 3)
                    } else if component == 1{
                        return (setsRepsPicker.frame.size.width / 3)
                    }
                }
            case "cardio", "stretching", "yoga":
                return setsRepsPicker.frame.size.width
            default: break
            }
        }
        return 0
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        // Number of Rounds
        if selectingNumberOfRounds {
            // Do nothing
            // Set/Reps/Breaths
        } else {
            switch SelectedSession.shared.selectedSession[0] {
            case "warmup":
                if row == 0 {
                    self.setsIndicatorLabel.text = NSLocalizedString("set", comment: "")
                } else {
                    self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                }
            case "workout":
                // If circuit
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
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
    // MARK: Table View
    //
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        switch tableView {
        case customTableView:
            // Nothing selected
            if selectedSession == -1 {
                return 0
                // Not workout
            } else if SelectedSession.shared.selectedSession[0] != "workout" {
                return 1
            // Workout (could be circuit)
            } else {
                // Not circuit wokrout ([1] = -1 if circuit workout)
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    return customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] as! Int
                // Circuit Workout
                } else {
                    return 1
                }
            }
        //
        case movementsTableView:
            let numberSections = sessionData.fullKeyArrays[SelectedSession.shared.selectedSession[0]]?.count
            return numberSections!
        default: break
        }
        return 0
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        switch tableView {
        case customTableView:
            // Not workout
            if SelectedSession.shared.selectedSession[0] != "workout" {
                return " "
                // Workout (could be circuit)
            } else {
                // If nothing
                // Circuit wokrout ([1] == -1 if circuit workout)
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    return " " + NSLocalizedString("round", comment: "") + " " + String(section + 1)
                } else {
                    return " "
                }
            }
        //
        case movementsTableView:
            return NSLocalizedString(sessionData.tableViewSectionArrays[SelectedSession.shared.selectedSession[0]]![section] as String, comment: "")
        default: break
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        switch tableView {
        case customTableView:
            // Not workout
            if SelectedSession.shared.selectedSession[0] != "workout" {
                return 1
                // Workout (could be circuit)
            } else {
                // If nothing
                // Circuit wokrout ([1] == -1 if circuit workout)
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
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
        case customTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)!
            header.textLabel?.textColor = Colors.light
            header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            header.contentView.tintColor = Colors.light
        //
        case movementsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)!
            header.textLabel?.textColor = Colors.light
            header.textLabel?.adjustsFontSizeToFitWidth = true
            header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            header.contentView.tintColor = Colors.light
        //
        default: break
        }
        
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        
        //
        switch tableView {
        case customTableView:
            if selectedSession == -1 || customSessionsArray[SelectedSession.shared.selectedSession[0]]?.count == 0 || customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count == 0 {
                return 0
            } else {
                return customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count
            }
        //
        case movementsTableView:
            //
            let numberRows = sessionData.fullKeyArrays[SelectedSession.shared.selectedSession[0]]![section].count
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
        case customTableView:
            //
            let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            let movement = (customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]! as! [String])[indexPath.row]
            cell.textLabel?.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![movement]!["name"]![0] as String, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            //            cell.textLabel?.numberOfLines = 0
            //            cell.textLabel?.lineBreakMode = .byTruncatingTail
            cell.backgroundColor = Colors.light
            cell.textLabel?.textColor = Colors.dark
            cell.tintColor = .black
            // Detail sets x reps
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
            cell.detailTextLabel?.textColor = Colors.dark
            //
            // Find out session type
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup - Sets x Reps
            case "warmup":
                let setsInt = (customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! as! [Int])[indexPath.row]
                let sets = String(setsInt)
                let reps = (customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]! as! [String])[indexPath.row]
                cell.detailTextLabel?.text = sets + " x " + reps
            // Workout
            case "workout":
                // Circuit - Reps
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    //
                    let numberOfMovements = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count
                    let index = indexPath.row + (indexPath.section * numberOfMovements)
                    let reps = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]![index] as! String
                    cell.detailTextLabel?.text = reps + " " + NSLocalizedString("reps", comment: "")
                    // Normal - Sets x Reps
                } else {
                    let setsInt = (customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! as! [Int])[indexPath.row]
                    let sets = String(setsInt)
                    let reps = (customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]! as! [String])[indexPath.row]
                    cell.detailTextLabel?.text = sets + " x " + reps
                }
            // Cardio
            case "cardio":
                let timeInt = (customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! as! [Int])[indexPath.row]
                let time = String(timeInt)
                cell.detailTextLabel?.text = time + NSLocalizedString("s", comment: "")
            // Stretching/Yoga - Breaths
            case "stretching", "yoga":
                let breathsInt = (customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! as! [Int])[indexPath.row]
                let breaths = String(breathsInt)
                cell.detailTextLabel?.text = breaths + " " + NSLocalizedString("breaths", comment: "")
            default:
                break
            }
            //
            // Cell Image
            // Flip asymmetric images for yoga
            let movementImage = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![movement]!["demonstration"]![0]))
            if SelectedSession.shared.selectedSession[0] == "yoga" {
                // If asymmetric movement, flip image that has attribute "a"
                if sessionData.movements[SelectedSession.shared.selectedSession[0]]?[movement]?["attributes"]?[0].contains("a") ?? false {
                    let flippedImage = UIImage(cgImage: (movementImage?.cgImage!)!, scale: (movementImage?.scale)!, orientation: .upMirrored)
                    cell.imageView?.image = flippedImage
                } else {
                    cell.imageView?.image = movementImage
                }
                
            // Normal
            } else {
                cell.imageView?.image = movementImage
            }
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
            let movement = sessionData.fullKeyArrays[SelectedSession.shared.selectedSession[0]]![indexPath.section][indexPath.row]
            cell.textLabel?.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![movement]!["name"]![0] as String, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = Colors.light
            cell.textLabel?.textColor = .black
            cell.tintColor = .black
            // Cell Image
            let movementImage = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![movement]!["demonstration"]![0]))
            if SelectedSession.shared.selectedSession[0] == "yoga" {
                // If asymmetric movement, flip image that has attribute "a"
                if sessionData.movements[SelectedSession.shared.selectedSession[0]]?[movement]?["attributes"]?[0].contains("a") ?? false {
                    let flippedImage = UIImage(cgImage: (movementImage?.cgImage!)!, scale: (movementImage?.scale)!, orientation: .upMirrored)
                    cell.imageView?.image = flippedImage
                } else {
                    cell.imageView?.image = movementImage
                }
                
                // Normal append
            } else {
                cell.imageView?.image = movementImage
            }
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        switch tableView {
        case customTableView:
            //
            if customSessionsArray[SelectedSession.shared.selectedSession[0]]?.count == 0 || customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count == 0 {
                return 49
                //
            } else {
                //
                if indexPath.row == customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count  {
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        
        //
        switch tableView {
        case customTableView:
            //
            selectedRow = indexPath.row
            selectedSection = indexPath.section
            //
            setsRepsPicker.reloadAllComponents()
            // okButton
            //
            setsRepsView.frame = CGRect(x: 0, y: 0, width: ActionSheet.shared.actionWidth, height: 147 + 49)
            //
            okButton.frame = CGRect(x: 0, y: 147, width: setsRepsView.frame.size.width, height: 49)

            // Setup picker
            //
            // Set component widths, indicator label frame and select row in picker
            let componentWidth = setsRepsPicker.frame.size.width / 3
            let componentWidthFourth = componentWidth / 4
            // Find out session type
            // Switch SelectedSession.shared.selectedSession[0] and SelectedSession.shared.selectedSession[1]
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup - Sets x Reps
            case "warmup":
                self.setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: self.setsRepsView.frame.size.width + componentWidthFourth, height: 147)
                self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
                self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                // Select row in picker
                let setsIndex = setsPickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![indexPath.row] as! Int)
                setsRepsPicker.selectRow(setsIndex!, inComponent: 0, animated: true)
                let repsIndex = repsPickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]![indexPath.row] as! String)
                setsRepsPicker.selectRow(repsIndex!, inComponent: 1, animated: true)
                
            // Workout
            case "workout":
                // Circuit - Reps
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    //
                    self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
                    self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
                    self.setsIndicatorLabel.text = NSLocalizedString("reps", comment: "")
                    // Select row in picker
                    let numberOfMovements = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count
                    let index = indexPath.row + (selectedSection * numberOfMovements)
                    let repsIndex = repsPickerArrayCircuit.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]![index] as! String)
                    setsRepsPicker.selectRow(repsIndex!, inComponent: 0, animated: true)
                // Normal - Sets x Reps
                } else {
                    self.setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: self.setsRepsView.frame.size.width + componentWidthFourth, height: 147)
                    self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
                    self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                    // Select row in picker
                    let setsIndex = setsPickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![indexPath.row] as! Int)
                    setsRepsPicker.selectRow(setsIndex!, inComponent: 0, animated: true)
                    let repsIndex = repsPickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]![indexPath.row] as! String)
                    setsRepsPicker.selectRow(repsIndex!, inComponent: 1, animated: true)
                }
            // Cardio
            case "cardio":
                self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
                self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
                self.setsIndicatorLabel.text = NSLocalizedString("s", comment: "")
                // Select row in picker
                let timeIndex = timePickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![indexPath.row] as! Int)
                setsRepsPicker.selectRow(timeIndex!, inComponent: 0, animated: true)
            // Stretching/Yoga - Breaths
            case "stretching", "yoga":
                self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
                self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
                self.setsIndicatorLabel.text = NSLocalizedString("breaths", comment: "")
                // Select row in picker
                let breathsIndex = breathsPickerArray.index(of: customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![indexPath.row] as! Int)
                setsRepsPicker.selectRow(breathsIndex!, inComponent: 0, animated: true)
                
            default:
                break
            }
            //
            //
            ActionSheet.shared.setupActionSheet()
            ActionSheet.shared.actionSheet.addSubview(setsRepsView)
            let heightToAdd = setsRepsView.bounds.height
            ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
            ActionSheet.shared.resetCancelFrame()
            ActionSheet.shared.animateActionSheetUp()
            
            
        //
        case movementsTableView:
            //
            // Append movement
            customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.append(sessionData.fullKeyArrays[SelectedSession.shared.selectedSession[0]]![indexPath.section][indexPath.row])
            // Sets/Reps/Breaths
            // Find out session type
            // Switch SelectedSession.shared.selectedSession[0] and SelectedSession.shared.selectedSession[1]
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup
            case "warmup":
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.append(1)
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.append("1")
            // Workout
            case "workout":
                // Circuit
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    //
                    let numberOfRounds = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] as! Int
                    for i in 0...numberOfRounds - 1 {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.insert("1", at: i)
                    }
                    
                    // Normal
                } else {
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.append(1)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.append("1")
                }
            // Cardio
            case "cardio":
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.append(30)
            // Stretching/Yoga
            case "stretching", "yoga":
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.append(5)
            default:
                break
            }
            
            //
            // SET ARRAY
            UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
            //
            // Remove Table
            self.customTableView.reloadData()
            //
            // Scroll to Bottom
            if self.customTableView.contentSize.height > self.customTableView.frame.size.height {
                let scrollIndex = NSIndexPath(row: (customSessionsArray[SelectedSession.shared.selectedSession[0]]![self.selectedSession]["movements"]?.count)! - 1, section: 0)
                self.customTableView.scrollToRow(at: scrollIndex as IndexPath, at: .top, animated: true)
            }
            
            // Generate feedback
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        //
        default: break
        }
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    //
    // MARK: TableView Editing
    //
    // Can edit row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        switch tableView {
        case movementsTableView: return false
        case customTableView:
            //
            if customSessionsArray[SelectedSession.shared.selectedSession[0]]?.count == 0 || customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count == 0 {
                return false
            } else {
                if indexPath.row == customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count {
                    return false
                } else {
                    return true
                }
            }
        default: return false
        }
    }
    
    // Can move to row
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        switch tableView {
        case movementsTableView: return false
        case customTableView:
            //
            if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count == 0 {
                return false
            } else {
                return true
            }
        default: return false
        }
    }
    
    // Move row at
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        // Key
        let itemToMove = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.remove(at: sourceIndexPath.row)
        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.insert(itemToMove, at: destinationIndexPath.row)
        //
        // Sets
        if SelectedSession.shared.selectedSession[0] == "warmup" {
            let setToMove = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.remove(at: sourceIndexPath.row)
            customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.insert(setToMove, at: destinationIndexPath.row)
        }
        //
        // Reps
        if SelectedSession.shared.selectedSession[0] == "warmup" {
            let repToMove = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.remove(at: sourceIndexPath.row)
            customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.insert(repToMove, at: destinationIndexPath.row)
        } else {
            for _ in 0...(customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.count - 1) {
                let repToMove = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.remove(at: sourceIndexPath.row)
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.insert(repToMove, at: destinationIndexPath.row)
            }
            
        }
        //
        //
        // SET NEW ARRAY
        UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
        
        //
        tableView.reloadData()
    }
    
    // Target index path for move from row
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        
        //
        if proposedDestinationIndexPath.row == customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count {
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            switch tableView {
            case customTableView:
                //
                // Key
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.remove(at: indexPath.row)
                
                // Sets/Reps/Breaths
                //
                // Find out session type
                // Switch SelectedSession.shared.selectedSession[0] and SelectedSession.shared.selectedSession[1]
                switch SelectedSession.shared.selectedSession[0] {
                // Warmup
                case "warmup":
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.remove(at: indexPath.row)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.remove(at: indexPath.row)
                // Workout
                case "workout":
                    // Circuit
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                        //
                        let numberOfRounds = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] as! Int
                        let nMovements = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count
                        
                        for i in (1...numberOfRounds).reversed() {
                            //
                            let lastIndexInRound = (i * nMovements) - 1
                            let removeFromLastIndex = (nMovements - 1) - indexPath.row
                            let indexToRemove = lastIndexInRound - removeFromLastIndex
                            customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.remove(at: indexToRemove)
                        }
                        
                        // Normal
                    } else {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.remove(at: indexPath.row)
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.remove(at: indexPath.row)
                    }
                // Cardio/Stretching/Yoga
                case "cardio", "stretching", "yoga":
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.remove(at: indexPath.row)
                default:
                    break
                }
                
                //
                // SET NEW ARRAY
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                //
                switch SelectedSession.shared.selectedSession[0] {
                case "warmup", "cardio", "stretching", "yoga":
                    tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                case "workout":
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                        var indexArray: [IndexPath] = []
                        for i in 1...(customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] as! Int) {
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
    // MARK: Table view related button actions
    var okAction = UIAlertAction()
    // Enable ok alert action func
    @objc func textChanged(_ sender: UITextField) {
        if sender.text == "" {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    // MARK: Rename
    @IBAction func nameAction(_ sender: Any) {
        
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]

        // Alert and Functions
        let inputTitle = NSLocalizedString("sessionInputName", comment: "")
        //
        let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        // 2. Add the text field
        alert.addTextField { (textField: UITextField) in
            textField.text = customSessionsArray[SelectedSession.shared.selectedSession[0]]![self.selectedSession]["name"]![0] as? String
            textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        }
        // 3. Get the value from the text field, and perform actions upon OK press
        okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { [weak alert] (_) in
            //
            // Update Title
            let textField = alert?.textFields![0]
            let title = textField?.text!
            customSessionsArray[SelectedSession.shared.selectedSession[0]]![self.selectedSession]["name"]![0] = title as Any
            // Set
            UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
            
            // Update title on page
            self.nameLabel.text = customSessionsArray[SelectedSession.shared.selectedSession[0]]![self.selectedSession]["name"]![0] as? String
        })
        okAction.isEnabled = false
        alert.addAction(okAction)
        // Cancel reset action
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            ActionSheet.shared.actionSheetBackgroundView.isHidden = false
        }
        alert.addAction(cancelAction)
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Picker Related actions
    // Ok button action
    @objc func okButtonAction(_ sender: Any) {
        //
        // NUMBER OF ROUNDS!
        if selectingNumberOfRounds {
            selectingNumberOfRounds = false
            var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
            let numberOfMovements = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count
            //
            roundsLabel.text = String(roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)])

            //
            // Empty session -> Empty session
            if numberOfMovements == 0 {
                // Selecting 1 round (not circuit)
                if setsRepsPicker.selectedRow(inComponent: 0) == 0 {
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count != 0 {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! = []
                    }
                // Selecting > 1 round (circuit)
                } else {
                    // Update values
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count != 0 {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] = roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
                        // Append values
                    } else {
                        // Append nRounds
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.append(roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)])
                        // Append circuit indicator
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.append(-1)
                    }
                }
                // Set
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                //
            // Circuit -> Non-circuit
            // If selected a non circuit workout, i.e selectedRounds = 1
            } else if setsRepsPicker.selectedRow(inComponent: 0) == 0 {
                //
                // If it was previously a circuit workout do something (if not do nothing)
                // Isn't empty && roundsArray[1] == -1 (indicating its a circuit workout)
                if numberOfMovements != 0 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    //
                    // Set sets and reps array same length as movements array by removing &&
                    let nRoundsOld = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] as! Int
                    let nToRemove = nRoundsOld - 1
                    for _ in 1...nToRemove {
                        for _ in 1...numberOfMovements {
                            customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.removeLast()
                        }
                    }
                    // Reset sets to 0, and append 1 for each movement (new set always 1)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! = []
                    for _ in 1...numberOfMovements {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.append(1)
                    }
                    // Set
                    UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                }
                //
                //
                // Non-circuit -> Circuit
                // If nMovments != 0 &&
                // either [2].count not 2 or
                // [2].count 2 and [2][1] != -1 (as if == -1 then circuit workout)
            } else if numberOfMovements != 0 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count != 2 || numberOfMovements != 0 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int != -1 {
                // Sets array -> Rounds array
                // Clear sets array
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! = []
                // Append nRounds
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.append(roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)])
                // Append circuit indicator
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.append(-1)
                // Reps array -> rounds reps array (add new set of x(nMovements) reps for each round)
                // For each round (-2 as round 1 already there)
                for _ in 0...roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)] - 2 {
                    // for each movement
                    for i in 0...numberOfMovements - 1 {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.append(customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]![i])
                    }
                }
                // Set
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                
                //
                // Circuit -> Circuit
                // If circuit workout
            } else if numberOfMovements != 0 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                // Note: nRoundsNew == nRoundsOld, do nothing (therefore no if for such a case)
                let nRoundsNew = roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
                let nRoundsOld = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] as! Int
                //
                // nRoundsNew > nRoundsOld
                if nRoundsNew > nRoundsOld {
                    // Change number of rounds
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] = nRoundsNew
                    // Add reps
                    let nRoundsToAdd = nRoundsNew - nRoundsOld
                    for _ in 1...nRoundsToAdd {
                        for _ in 1...numberOfMovements {
                            customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.append("1")
                        }
                    }
                    //
                    // nRoundsNew < nRoundOld
                } else if nRoundsNew < nRoundsOld {
                    // Change number of rounds
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] = nRoundsNew
                    // Remove reps
                    let nRoundsToRemove = nRoundsOld - nRoundsNew
                    for _ in 1...nRoundsToRemove {
                        // for each movement
                        for _ in 0...numberOfMovements - 1 {
                            customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.removeLast()
                        }
                    }
                }
                // Set
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                
            }
            //
            //
            // SETS/REPS/BREATHS/TIME
        } else {
            var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
            //
            // Find out session type
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup - Sets x Reps
            case "warmup":
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![selectedRow] = setsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]![selectedRow] = repsPickerArray[setsRepsPicker.selectedRow(inComponent: 1)]
            // Workout
            case "workout":
                // Circuit - Reps
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    //
                    let numberOfMovements = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count
                    let index = selectedRow + (selectedSection * numberOfMovements)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]![index] = repsPickerArrayCircuit[setsRepsPicker.selectedRow(inComponent: 0)]
                    // Normal - Sets x Reps
                } else {
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![selectedRow] = setsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]![selectedRow] = repsPickerArray[setsRepsPicker.selectedRow(inComponent: 1)]
                }
            // Cardio
            case "cardio":
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![selectedRow] = timePickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
            // Stretching/Yoga - Breaths
            case "stretching", "yoga":
                customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![selectedRow] = breathsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
            default:
                break
            }
            //
            // SET NEW ARRAY
            UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
            
        }
        //
        // Animate picker down and off
        ActionSheet.shared.animateActionSheetDown()
        //
        customTableView.reloadData()
    }
    
    
    //
    // MARK: Expand/Retract Image
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
        expandedImage.backgroundColor = Colors.dark
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
                var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
                
                //
                // Find out session type
                // Switch SelectedSession.shared.selectedSession[0] and SelectedSession.shared.selectedSession[1]
                switch SelectedSession.shared.selectedSession[0] {
                // Warmup
                case "warmup":
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                // Workout
                case "workout":
                    // Circuit
                    if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                        // Swap movements
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                        // Swap reps
                        let numberOfRounds = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] as! Int
                        let numberOfMovements = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.count
                        // For each round, swap the reps index's
                        // A workout with 3 movements and 3 rounds will have 9 reps (012,345,678), each set of 3 corresponding to the round
                        // Swapping 0 and 1 gives (102,435,768)
                        for i in 0...numberOfRounds - 1 {
                            // + (numberOfMovements * i) to find the index in each round
                            let from = (indexPath?.row)! + (numberOfMovements * i)
                            let to  = (Path.initialIndexPath?.row)! + (numberOfMovements * i)
                            customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.swapAt((from), (to))
                        }
                        //
                        // Normal
                    } else {
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                        customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]!.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                    }
                // Cardio/Stretching/Yoga
                case "cardio", "stretching", "yoga":
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]!.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                    customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                default:
                    break
                }
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                //
                self.customTableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                Path.initialIndexPath = indexPath
                //
            }
            
        default:
            let cell = self.customTableView.cellForRow(at: Path.initialIndexPath!)
            cell?.alpha = 0.0
            cell?.isHidden = false
            UIView.animate(withDuration: 0.25, animations: {
                My.cellSnapShot?.center = (cell?.center)!
                My.cellSnapShot?.transform = .identity
            }, completion: { (finished) -> Void in
                if finished {
                    Path.initialIndexPath = nil
                    My.cellSnapShot?.removeFromSuperview()
                    My.cellSnapShot = nil
                    cell?.alpha = 1.0
                }
            })
            //
            // Reload other sections if circuit workout
            let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
            if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                let numberOfRounds = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] as! Int
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
    // MARK: Add Movement
    //
    @IBAction func addMovementAction(_ sender: Any) {
        //
        let height = ActionSheet.shared.actionTableHeight
        //
        UIApplication.shared.keyWindow?.insertSubview(movementsTableView, aboveSubview: view)
        movementsTableView.frame = CGRect(x: 0, y: 0, width: ActionSheet.shared.actionWidth, height: height)
        //
        ActionSheet.shared.setupActionSheet()
        ActionSheet.shared.actionSheet.addSubview(movementsTableView)
        let heightToAdd = movementsTableView.bounds.height
        ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
        ActionSheet.shared.resetCancelFrame()
        // Cancel button is a done button for this case
        ActionSheet.shared.cancelButton.setTitleColor(Colors.green, for: .normal)
        ActionSheet.shared.cancelButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
        ActionSheet.shared.animateActionSheetUp()
    }
    
    //
    // MARK: Nº Rounds Action
    @IBAction func roundsAction(_ sender: Any) {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        
        // If no movements added yet, do nothing
        if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count != 0 {
            //
            selectingNumberOfRounds = true
            setsRepsPicker.reloadAllComponents()
            //
            // selected number of rows
            setsRepsPicker.selectRow(roundsPickerArray.index(of: (customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] as! Int))!, inComponent: 0, animated: true)
            //
            self.setsRepsView.frame = CGRect(x: 0, y: 0, width: ActionSheet.shared.actionWidth, height: 147 + 49)
            // picker
            self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
            self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
            self.setsIndicatorLabel.text = NSLocalizedString("rounds", comment: "")
            // ok
            okButton.frame = CGRect(x: 0, y: 147, width: setsRepsView.frame.size.width, height: 49)
            // Sets Indicator Label
            //
            ActionSheet.shared.setupActionSheet()
            ActionSheet.shared.actionSheet.addSubview(setsRepsView)
            let heightToAdd = setsRepsView.bounds.height
            ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
            ActionSheet.shared.resetCancelFrame()
            //
            ActionSheet.shared.animateActionSheetUp()
        
        // No movements added
        } else {
            // Alert
            let inputTitle = NSLocalizedString("nRoundsAlert", comment: "")
            let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
            alert.view.tintColor = Colors.dark
            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 17)!]), forKey: "attributedTitle")
            
            // Ok action
            okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { UIAlertAction in
            })
            alert.addAction(okAction)
            
            // Present the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: Dismiss
    @IBAction func doneButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: Navigation controller
class CustomSessionEditingNavigation: UINavigationController {
    
}

