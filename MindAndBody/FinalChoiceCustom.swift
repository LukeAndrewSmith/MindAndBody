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

    // selectedSession[0] == Warmup, Workout, Workout(Circuit), Cardio, Stretching, Yoga
    
    // Presets button titles
    let presetsButtonTitles = ["customWarmup", "customWorkout", "customCircuitWorkout", "customHIITCardioSession", "customStretchingSession", "customYogaPractice"]
    
    
    
    //
    // Selected row
    var selectedRow = Int()
    var selectedSection = Int()
    
    //
    var selectedPreset = -1
    
    //
    var selectingNumberOfRounds = false
    
    
    //
    // Sets Reps Picker View
    //
    var setsPickerArray: [Int] = [1, 2, 3, 4, 5, 6]
    //                              // Reps                                      Rep Ranges                     // Seconds
    var repsPickerArray: [String] = ["1", "3", "5", "8", "10", "12", "15", "20", "3-5", "5-8", "8-12", "15-20", "15s", "30s", "60s", "90s"]
    
    //
    var repsPickerArrayCircuit: [String] = ["5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60", "65", "70", "75", "80", "85", "90", "95"]
    
    //
    var roundsPickerArray: [Int] = [2, 3, 4, 5, 6, 7, 8, 9]
    
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
    @IBOutlet weak var nRoundButton: UIButton!
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
    // View Will Appear
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set Title of presets button
        presetsButton.setTitle(NSLocalizedString(presetsButtonTitles[selectedSession[0]], comment: ""), for: .normal)
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
        // TODO: width for all sections
        if selectedSession[0] == 0 {
            nRoundButton.frame.size = CGSize(width: 0, height: nRoundButton.bounds.height)
            newMovementButton.frame.size = CGSize(width: view.bounds.width, height: newMovementButton.bounds.height)
        }
        
        
        // Colour
        self.view.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        //
        presetsButton.backgroundColor = colour2
        
        // Navigation Bar Title
        navigationBar.title = NSLocalizedString("custom", comment: "")
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = colour3
        beginButton.setTitleColor(colour2, for: .normal)
        
        
        
        // Presets TableView
        //
        // Movement tabl
        presetsTableView.backgroundColor = colour2
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        presetsTableView.layer.cornerRadius = 15
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        presetsTableView.layer.borderColor = colour1.cgColor
        presetsTableView.layer.borderWidth = 1
        //
        //
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = colour1
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        presetsTableView.tableFooterView = UIView()
        
        
        
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
        movementsTableView.layer.cornerRadius = 15
        movementsTableView.layer.masksToBounds = true
        //
        // Sets Reps Selection
        // view
        setsRepsView.backgroundColor = colour2
        setsRepsView.layer.cornerRadius = 15
        setsRepsView.layer.masksToBounds = true
        // picker
        setsRepsPicker.backgroundColor = colour2
        setsRepsPicker.delegate = self
        setsRepsPicker.dataSource = self
        // ok
        okButton.backgroundColor = colour1
        okButton.setTitleColor(colour3, for: .normal)
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        
        //
        if customTableView.isEditing {
            beginButton.isEnabled = false
        } else {
            if selectedPreset == -1 {
                
            } else {
                if customSessionsArray[selectedSession[0]].count == 0 || (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count == 0 {
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
        // Number of Rounds
        if selectingNumberOfRounds == true {
            return 1
            // Other
        } else {
            //
            switch selectedSession[0] {
            case -1: return 0
            case 0: return 2
            case 1: return 1
            default: break
            }
        }
        return 0
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Number of Rounds
        if selectingNumberOfRounds == true {
            return roundsPickerArray.count
            
        } else {
            
            // Other
            switch selectedSession[0] {
            case 0:
                if component == 0 {
                    return setsPickerArray.count
                } else {
                    return repsPickerArray.count
                }
            case 1:
                return repsPickerArrayCircuit.count
            default: break
            }
        }
        return 0
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // Number of Rounds
        if selectingNumberOfRounds == true {
            let roundLabel = UILabel()
            roundLabel.text = String(roundsPickerArray[row])
            roundLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
            roundLabel.textColor = colour1
            //
            roundLabel.textAlignment = .center
            return roundLabel
            //
            
            // Other
        } else {
            //
            switch selectedSession[0] {
            case 0:
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
            case 1:
                let repsLabel = UILabel()
                repsLabel.text = String(repsPickerArrayCircuit[row])
                repsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
                repsLabel.textColor = colour1
                //
                repsLabel.textAlignment = .center
                return repsLabel
            //
            default: break
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
        // Number of Rounds
        if selectingNumberOfRounds == true {
            return setsRepsPicker.frame.size.width
            
            // Other
        } else {
            switch selectedSession[0] {
            case 0:
                //
                if component == 0 {
                    return (setsRepsPicker.frame.size.width / 3)
                } else if component == 1{
                    return (setsRepsPicker.frame.size.width / 3)
                }
            case 1:
                return setsRepsPicker.frame.size.width
            default: break
            }
        }
        return 0
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Number of Rounds
        if selectingNumberOfRounds == true {
        } else {
            //
            switch selectedSession[0] {
            case 0:
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
            default: break
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
            return 1

            // TODO: Determine when circuit needs to be activated
//            switch selectedSession[0] {
//            case 0:
//            case 1:
//                return (customSessionsArray[selectedSession[0]][selectedPreset][2] as! [Int])[0]
//            default: break
//            }
        case movementsTableView:
            let numberSections = sessionData.fullKeyArrays[selectedSession[0]].count
            return numberSections
        default: break
        }
        return 0
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]

        //
        switch tableView {
        case presetsTableView:
//            return " " + NSLocalizedString("customSession", comment: "")
            return " "
        //
        case customTableView:
            //
            switch selectedSession[0] {
            case 0:
                var titleDataArray: [String] = []
                //
                if titleDataArray.count != 0 {
                    return titleDataArray[selectedPreset]
                } else {
                    return " "
                }
            case 1:
                return " " + NSLocalizedString("round", comment: "") + " " + String(section + 1)
            default: break
            }
        //
        case movementsTableView:
            return NSLocalizedString(sessionData.tableViewSectionArrays[selectedSession[0]][section] as String, comment: "")
        default: break
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        
        // TODO: Find circuit workouts
        switch tableView {
        case presetsTableView:
            //            return " " + NSLocalizedString("customSession", comment: "")
            return 23.5
        //
        case customTableView:
            //
            switch selectedSession[0] {
            case 0:
                var titleDataArray: [String] = []
                //
                if titleDataArray.count != 0 {
                    return 23.5
                } else {
                    return 1
                }
            case 1:
                return 23.5
            default: break
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
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        case customTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)!
            header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            header.contentView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            header.contentView.tintColor = colour1
        //
        case movementsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)!
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]

        //
        switch tableView {
        case presetsTableView:
            return customSessionsArray[selectedSession[0]].count + 1
        //
        case customTableView:
            //
//            switch selectedSession[0] {
            // TODO: Selected Type
                
//            case 15:
//                if (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count == 0 {
//                    return 1
//                } else {
//                    if section == 0 {
//                        return (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count + 1
//                    } else {
//                        return (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count
//                    }
//                }
//            default:
//            let test = customSessionsArray[selectedSession[0]].count == 0
//            let test2 = customSessionsArray[selectedSession[0]][selectedPreset][1].count
                if selectedPreset == -1 || customSessionsArray[selectedSession[0]].count == 0 || customSessionsArray[selectedSession[0]][selectedPreset][1].count == 0 {
                    return 0
                } else {
                    return (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count
                }
//            }
            
        //
        case movementsTableView:
            //
            let numberRows = sessionData.fullKeyArrays[selectedSession[0]][section].count
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
            cell.backgroundColor = colour1
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            if indexPath.row == (customSessionsArray[selectedSession[0]]).count {
                //
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
                //
            } else {
                //
                cell.textLabel?.text = customSessionsArray[selectedSession[0]][indexPath.row][0][0] as! String
            }
            //
            return cell
        //
        case customTableView:
            //
            var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]

            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            let keyIndex = (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int])[indexPath.row]
            cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][keyIndex]! as String, comment: "")
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
            //
            switch selectedSession[0] {
            case 0:
                let setsInt = setsPickerArray[(customSessionsArray[selectedSession[0]][selectedPreset][2] as! [Int])[indexPath.row]]
                let sets = String(setsInt)
                let reps = (customSessionsArray[selectedSession[0]][selectedPreset][3] as! [String])[indexPath.row]
                cell.detailTextLabel?.text = sets + " x " + reps
            case 1:
                cell.detailTextLabel?.text = (customSessionsArray[selectedSession[0]][selectedPreset][3] as! [String])[indexPath.row] + " " + NSLocalizedString("reps", comment: "")
            default: break
            }
            //
            // Cell Image
            cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[selectedSession[0]][keyIndex]?[0])!)
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
            let keyIndex = sessionData.fullKeyArrays[selectedSession[0]][indexPath.section][indexPath.row] as! Int
            cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][keyIndex]! as String, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = .black
            cell.tintColor = .black
            // Cell Image
            cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[selectedSession[0]][keyIndex]?[0])!)
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
            if customSessionsArray[selectedSession[0]].count == 0 || (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count == 0 {
                return 49
                //
            } else {
                //
                if indexPath.row == (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count  {
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
            if indexPath.row == (customSessionsArray[selectedSession[0]]  as! [[Any]]).count {
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
                
                // Alert and Functions
                //
                let inputTitle = NSLocalizedString("sessionInputTitle", comment: "")
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
                    // Append relevant (to selectedSession[0]) new array to customSessionsArray
                    switch selectedSession[0] {
                    // Warmup, Workout,
                    case 0,1,2,3:
                        customSessionsArray[selectedSession[0]].append(customSectionEmtpySessions.emptySessionFour)
                    case 4,5:
                        customSessionsArray[selectedSession[0]].append(customSectionEmtpySessions.emptySessionThree)

                    //
                    default:
                        break
                    }
                    //
                    // Update Title
                    let textField = alert?.textFields![0]
                    let lastIndex = customSessionsArray[selectedSession[0]].count - 1
                    customSessionsArray[selectedSession[0]][lastIndex][0][0] = textField?.text!
                    //
                    // Default mumber of rounds if relevant
                    // TODO: Selected Type
//                    if selectedSession[0] == 2 {
//                        customSessionsArray[selectedSession[0]][self.selectedPreset][2].append(2)
//                        self.numberOfRounds.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String((customSessionsArray[selectedSession[0]][self.selectedPreset][2] as! [Int])[self.selectedPreset]), for: .normal)
//                    }
                    
                    //
                    // SET NEW ARRAY
                    UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                    
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
                    let string = customSessionsArray[selectedSession[0]][self.selectedPreset][0][0] as! String
                    self.presetsButton.setTitle("- " + string + " -", for: .normal)
                    
                    //
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backgroundViewExpanded.alpha = 0.5
                        self.presetsTableView.reloadData()
                        // Dismiss and select new row
                    }, completion: { finished in
                        
//                        //
//                        let selectedIndexPath = NSIndexPath(row: (customSessionsArray[selectedSession[0]] as! [[Any]]).count - 1, section: 0)
//                        self.presetsTableView.selectRow(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
//                        self.selectedPreset = selectedIndexPath.row
//                        //
//                        switch selectedSession[0] {
//                        case 0:
//                            let string = customSessionsArray[selectedSession[0]][self.selectedPreset][0] as! String
//                            self.presetsButton.setTitle("- " + string + " -", for: .normal)
//                        case 1:
//                            break
//                        default: break
//                        }
                        
                        //
                        tableView.deselectRow(at: indexPath, animated: true)
                        // Reload
                        self.customTableView.reloadData()
                        //
                        self.beginButtonEnabled()
                        
                        //
                        // Element Positions
                        //
                        self.presetsBottom.constant = self.view.frame.size.height - 73.5
                        //
                        //
                        self.tableViewConstraintTop.constant = 122.5
                        self.tableViewConstraintBottom.constant = 49
                        //
                        self.beginButtonConstraint.constant = 0
                        //
                        //
                        //
                        // Dismiss presets table
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
                // TODO: NUMBER OF ROUNDS title
//                let titleInt = customSessionsArray[selectedSession[0]][selectedPreset][2][0] as! Int
//                numberOfRounds.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String(titleInt), for: .normal)
                //
                switch selectedSession[0] {
                case 0:
                    let string = customSessionsArray[selectedSession[0]][selectedPreset][0][0] as! String
                    self.presetsButton.setTitle("- " + string + " -", for: .normal)
                case 1:
                    break
                default: break
                }
                //
                tableView.deselectRow(at: indexPath, animated: true)
                // Dismiss Table
                if (customSessionsArray[selectedSession[0]]  as! [[Any]]).count != 0 {
                    //
                    // Element Positions
                    //
                    //
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
            let selectedCell = tableView.cellForRow(at: indexPath)
            setsRepsView.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: UIScreen.main.bounds.width - 40, height: (selectedCell?.bounds.height)!)
            
            //
            // selected row
            // TODO: selectedSession[0]
            switch selectedSession[0] {
            case 0:
                setsRepsPicker.selectRow((customSessionsArray[selectedSession[0]][selectedPreset][2][indexPath.row] as! Int), inComponent: 0, animated: true)
                let repsIndex = repsPickerArray.index(of: customSessionsArray[selectedSession[0]][selectedPreset][3][indexPath.row] as! String)
                setsRepsPicker.selectRow(repsIndex!, inComponent: 1, animated: true)
            case 1:
                setsRepsPicker.selectRow((customSessionsArray[selectedSession[0]][selectedPreset][3][indexPath.row] as! Int), inComponent: 0, animated: true)
            default: break
            }
            //
            let componentWidth = setsRepsPicker.frame.size.width / 3
            let componentWidthFourth = componentWidth / 4
            // picker
            switch selectedSession[0] {
            case 0:
                self.setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: self.setsRepsView.frame.size.width + componentWidthFourth, height: 147)
                self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
                self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
            case 1:
                self.setsRepsPicker.frame = CGRect(x: 0, y: 0, width: self.setsRepsView.frame.size.width, height: 147)
                self.setsIndicatorLabel.frame = CGRect(x: (self.setsRepsPicker.frame.size.width / 2) * 1.13, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 70, height: 30)
                self.setsIndicatorLabel.text = NSLocalizedString("reps", comment: "")
            default: break
            }
            // ok
            okButton.frame = CGRect(x: 0, y: 147, width: setsRepsView.frame.size.width, height: 49)
            //
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
                // picker
                self.setsRepsPicker.frame = CGRect(x: -componentWidthFourth, y: 0, width: self.setsRepsView.frame.size.width + componentWidthFourth, height: 147)
                // ok
                self.okButton.frame = CGRect(x: 0, y: 147, width: self.setsRepsView.frame.size.width, height: 49)
                // Sets Indicator Label
                self.setsIndicatorLabel.frame = CGRect(x: (componentWidth * 1.25) - componentWidthFourth, y: (self.setsRepsPicker.frame.size.height / 2) - 15, width: 50, height: 30)
                self.setsIndicatorLabel.text = NSLocalizedString("sets", comment: "")
                //
                self.backgroundViewExpanded.alpha = 0.7
            }, completion: nil)

        //
        case movementsTableView:
            //
            customSessionsArray[selectedSession[0]][selectedPreset][1].append(sessionData.fullKeyArrays[selectedSession[0]][indexPath.section][indexPath.row] as! Int)
            // sets
            // TODO: selectedSession[0]
            if selectedSession[0] == 0 {
                customSessionsArray[selectedSession[0]][selectedPreset][2].append(0)
                customSessionsArray[selectedSession[0]][selectedPreset][3].append("1")
            } else {
                for i in 0...((customSessionsArray[selectedSession[0]][selectedPreset][3] as! [Int]).count - 1) {
                    customSessionsArray[selectedSession[0]][selectedPreset][3].append(0)
                }
            }
            // reps
            //
            //
            // SET ARRAY
            UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
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
                    //
//                    let scrollIndex = NSIndexPath(row: customKeyArray[self.selectedPreset].count - 1, section: 0)
//                    self.customTableView.scrollToRow(at: scrollIndex as IndexPath, at: .top, animated: true)
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        switch tableView {
        case presetsTableView:

            //
            if indexPath.row < (customSessionsArray[selectedSession[0]]  as! [[Any]]).count {
                return true
            }
        case movementsTableView: return false
        case customTableView:
            //
            if indexPath.section == 0 {
                if customSessionsArray[selectedSession[0]].count == 0 || (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count == 0 {
                    return false
                } else {
                    if indexPath.row == (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count {
                        return false
                    } else {
                        return true
                    }
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
            if (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count == 0 {
                return false
            } else {
                if indexPath.row == (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count {
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
        let itemToMove = customSessionsArray[selectedSession[0]][selectedPreset][1].remove(at: sourceIndexPath.row)
        customSessionsArray[selectedSession[0]][selectedPreset][1].insert(itemToMove, at: destinationIndexPath.row)
        //
        // Sets
        if selectedSession[0] == 0 {
            let setToMove = customSessionsArray[selectedSession[0]][selectedPreset][2].remove(at: sourceIndexPath.row)
            customSessionsArray[selectedSession[0]][selectedPreset][2].insert(setToMove, at: destinationIndexPath.row)
        }
        //
        // Reps
        if selectedSession[0] == 0 {
            let repToMove = customSessionsArray[selectedSession[0]][selectedPreset][3].remove(at: sourceIndexPath.row)
            customSessionsArray[selectedSession[0]][selectedPreset][3].insert(repToMove, at: destinationIndexPath.row)
        } else {
            for i in 0...((customSessionsArray[selectedSession[0]][selectedPreset][3] as! [Int]).count - 1) {
                let repToMove = customSessionsArray[selectedSession[0]][selectedPreset][3].remove(at: sourceIndexPath.row)
                customSessionsArray[selectedSession[0]][selectedPreset][3].insert(repToMove, at: destinationIndexPath.row)
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]

        //
        if proposedDestinationIndexPath.row == (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count {
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
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
        //
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            switch tableView {
            case presetsTableView:
                //
                customSessionsArray[selectedSession[0]].remove(at: indexPath.row)
                //
                // SET NEW ARRAY
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")

                //
//                numberOfRounds.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String((customSessionsArray[selectedSession[0]][selectedPreset][2][0] as! Int)), for: .normal)
                
                //
                UIView.animate(withDuration: 0.2, animations: {
                    self.presetsTableView.reloadData()
                })
                //
                // Selected last
                if customSessionsArray[selectedSession[0]].count == 0 {
//                    self.selectedPreset = customSessionsArray[selectedSession[0]].count - 1
//                // None to select
//                } else {
                self.selectedPreset = -1
//                }
                self.customTableView.reloadData()
                self.beginButtonEnabled()
                //

                // TODO: d
                UIView.animate(withDuration: 0.2, animations: {
                    self.presetsTableView.reloadData()
                    //
                    if customSessionsArray[selectedSession[0]].count == 0 || (customSessionsArray[selectedSession[0]][self.selectedPreset][1] as! [Int]).count == 0 {
                        switch selectedSession[0] {
                        case 0:
                            self.presetsButton.setTitle(NSLocalizedString(self.presetsButtonTitles[selectedSession[0]], comment: ""), for: .normal)
                        case 1:
                            break
                        default: break
                        }
                    } else {
                        let string = customSessionsArray[selectedSession[0]][self.selectedPreset][0][0] as! String
                        self.presetsButton.setTitle("- " + string + " -", for: .normal)

                    }
                })
                    //
                // Initial Element Positions
                if customSessionsArray[selectedSession[0]].count == 0 || (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count == 0 && self.presetsButton.alpha == 1 || (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count == 0 && self.presetsButton.alpha == 0 {

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
                        //
                        self.beginButtonEnabled()

                        // Initial Element Positions
                        //
                        self.presetsBottom.constant = 0
                        //
                        self.tableViewConstraintTop.constant = self.view.frame.size.height
                        self.tableViewConstraintBottom.constant = -49
                        //
                        self.beginButtonConstraint.constant = -49
                    })
                }
                }
            //
            case customTableView:
                //
                // Key
                customSessionsArray[selectedSession[0]][selectedPreset][1].remove(at: indexPath.row)
                // sets
                if selectedSession[0] == 0 {
                    customSessionsArray[selectedSession[0]][selectedPreset][2].remove(at: indexPath.row)
                    customSessionsArray[selectedSession[0]][selectedPreset][3].remove(at: indexPath.row)
                } else {
                    for i in 0...((customSessionsArray[selectedSession[0]][selectedPreset][3] as! [Int]).count - 1) {
                        customSessionsArray[selectedSession[0]][selectedPreset][3].remove(at: indexPath.row)
                    }
                }
                // reps
                //
                // SET NEW ARRAY
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                //
                switch selectedSession[0] {
                case 0:
                    tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                case 1:
                    var indexArray: [IndexPath] = []
                    for i in 1...(customSessionsArray[selectedSession[0]][selectedPreset][2][0] as! Int) {
                        let row = indexPath.row
                        let section = ((indexPath.section + 1) * i) - 1
                        let indexPathToRemove = NSIndexPath(row: row, section: section)
                        indexArray.append(indexPathToRemove as IndexPath)
                    }
                    tableView.deleteRows(at: indexArray, with: UITableViewRowAnimation.automatic)
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
        let roundNumber = UserDefaults.standard.object(forKey: "workoutRoundsCustomCircuit") as! [Int]
        setsRepsPicker.selectRow(roundsPickerArray.index(of: (customSessionsArray[selectedSession[0]][selectedPreset][2][0] as! Int))!, inComponent: 0, animated: true)
        //
        let componentWidth = setsRepsPicker.frame.size.width / 3
        let componentWidthFourth = componentWidth / 4
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
    func backgroundViewExpandedAction(_ sender: Any) {
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
    func okButtonAction(_ sender: Any) {
        //
        // Number of Rounds
        if selectingNumberOfRounds == true {
            var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]

            //
            if roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)] > (customSessionsArray[selectedSession[0]][selectedPreset][2][0] as! Int) {
                //
                let oldRound = (customSessionsArray[selectedSession[0]][selectedPreset][2][0] as! Int)
                let newRound = roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
                //
                let numberToAdd = newRound - oldRound
                
                // Add [] to reps
                for _ in 0...(numberToAdd - 1) {
                    customSessionsArray[selectedSession[0]][selectedPreset][3].append([])
                }
                // Add 0 to reps
                if (customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count != 0 {
                    for i in oldRound...(newRound - 1) {
                        for _ in 0...((customSessionsArray[selectedSession[0]][selectedPreset][1] as! [Int]).count - 1) {
                            customSessionsArray[selectedSession[0]][selectedPreset][3].append(0)
                        }
                    }
                }
                
                // SET ARRAY
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                //
                customSessionsArray[selectedSession[0]][selectedPreset][2][0] = newRound
                //
                //
            } else if roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)] < (customSessionsArray[selectedSession[0]][selectedPreset][2][0] as! Int) {
                //
                let oldRound = (customSessionsArray[selectedSession[0]][selectedPreset][2][0] as! Int)
                let newRound = roundsPickerArray[setsRepsPicker.selectedRow(inComponent: 0)]
                //
                let numberToRemove = oldRound - newRound
                
                // remove reps and keys
                for _ in 0...(numberToRemove - 1) {
                    customSessionsArray[selectedSession[0]][selectedPreset][3].removeLast()
                }
                
                // SET ARRAY
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                //
                customSessionsArray[selectedSession[0]][selectedPreset][2][0] = newRound
                //
                //
            }
            //
//            numberOfRounds.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String((customSessionsArray[selectedSession[0]][selectedPreset][2][0] as! Int)), for: .normal)
            //
            selectingNumberOfRounds = false
            //
            //
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.setsRepsView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.setsRepsView.frame.size.width, height: self.setsRepsView.frame.size.height)
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                self.setsRepsView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
            customTableView.reloadData()
            //
            
            //
        } else {
            //
            var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
            //
            if selectedSession[0] == 0 {
                customSessionsArray[selectedSession[0]][selectedPreset][2][selectedRow] = setsRepsPicker.selectedRow(inComponent: 0)
                customSessionsArray[selectedSession[0]][selectedPreset][3][selectedRow] = repsPickerArray[setsRepsPicker.selectedRow(inComponent: 1)]
            } else {
                customSessionsArray[selectedSession[0]][selectedPreset][3][selectedRow] = setsRepsPicker.selectedRow(inComponent: 0)
            }
            //
            //
            // SET NEW ARRAY
            UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
            //
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
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        
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
                
                UIView.animate(withDuration: 0.25, animations: {
                    center?.y = locationInView.y
                    My.cellSnapShot?.center = center!
                    My.cellSnapShot?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    My.cellSnapShot?.alpha = 0.98
                    cell?.alpha = 0.0
                }, completion: { (finished) -> Void in
                    if finished {
                        cell?.isHidden = true
                    }
                })
            }
            
        case .changed:
            var center = My.cellSnapShot?.center
            center?.y = locationInView.y
            My.cellSnapShot?.center = center!
            if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                
                var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [[[[Any]]]]
                customSessionsArray[selectedSession[0]][selectedPreset][1].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                customSessionsArray[selectedSession[0]][selectedPreset][2].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                customSessionsArray[selectedSession[0]][selectedPreset][3].swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                //
//                self.wayPoints.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                //swap(&self.wayPoints[(indexPath?.row)!], &self.wayPoints[(Path.initialIndexPath?.row)!])
                self.customTableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                Path.initialIndexPath = indexPath
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
    // Begin Button ------------------------------------------------------------------------------------------------
    //
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        //
        switch selectedSession[0] {
        case 0:
            self.performSegue(withIdentifier: "workoutSessionSegueCustom0", sender: "")
        case 1:
            self.performSegue(withIdentifier: "workoutSessionSegueCustom1", sender: "")
        default: break
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
    //
    // Prepare for segue Cardio
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sessionSegueCardio" {
            //
            let destinationVC = segue.destination as! CardioScreen
            //
            destinationVC.sessionType = 0
        }
    }
    //
}
