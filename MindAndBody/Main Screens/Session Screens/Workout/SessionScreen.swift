//
//  SessionScreenOverview.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 16.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


//
// Custom Overview Tableview Cells ---------------------------------------------------------------------------
//
// Overview TableView Cell
class SessionTableViewCell: UITableViewCell {
    // Image View
    @IBOutlet weak var imageViewCell: UIImageView!
    //
    @IBOutlet weak var indicatorStack: UIStackView!
    @IBOutlet weak var leftImageIndicator: UIImageView!
    @IBOutlet weak var rightImageIndicator: UIImageView!
    // Title Label
    @IBOutlet weak var movementLabel: UILabel!
    // Sets x Reps label
    @IBOutlet weak var setsRepsLabel: UILabel!
    // Button View
    @IBOutlet weak var buttonView: UIView!
    // Explanation
    @IBOutlet weak var explanationButton: UIButton!
    // Timer
    @IBOutlet weak var timerButton: UIButton!
    //
    // CountdownLabel, if timed workout
    @IBOutlet weak var weightButton: UIButton!
    
    var imageState = 0 // 0 == left image, 1 == right image
}

// Overview End Cell
class EndTableViewCell: UITableViewCell {
    // Title Label
    @IBOutlet weak var titleLabel: UILabel!
}


//
// Session Screen Overview Class ------------------------------------------------------------------------------------
//
class SessionScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //
    // Variables
    var selectedRow = 0
    
    //
    // MARK: Variables from Session Data
    var fromCustom = false
    var fromSchedule = false
    //
    // Key Array
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [1] Keys Array
    var keyArray: [String] = []
    
    // Sets
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] sets array
    var setsArray: [Int] = []
    
    // Reps
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [3] reps array
    var repsArray: [String] = []
    
    
    // To Add (@2x or @3x) for demonstration images
    var toAdd = String()
    
    
    //
    
    //
    // Outlets -----------------------------------------------------------------------------------------------------------
    //
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Top layout constraint for finish early button, used to relayout to take account of the rest timer
    @IBOutlet weak var finishEarlyTop: NSLayoutConstraint!
    
    //
    @IBOutlet weak var restTimeView: UIView!
    @IBOutlet weak var restTimeHeight: NSLayoutConstraint!
    @IBOutlet weak var restTimeTitleLabel: UILabel!
    @IBOutlet weak var restTimeTimeLabel: UILabel!
    @IBOutlet weak var restTimeSkipButton: UIButton!
    // Timer Variables
    var timerValue = Int()
    var didSetEndTime = false
    var startTime = Double()
    var endTime = Double()
    var isTiming = false
    
    //
    // Weight choice elements
    var actionSheetView = UIView()
    var weightPicker = UIPickerView()
    var okButton = UIButton()
    //
    let unitIndicatorLabel = UILabel()
    //
    var units = 0 // 0 == metric, 1 == imperial
    
    // Progress Bar
    let progressBar = UIProgressView()
    
    //
    @IBOutlet weak var finishEarly: UIButton!
    
    //
    var didEnterBackground = false
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // MARK: Walkthrough
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["Session"] == false {
            self.walkthroughSession()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        didEnterBackground = true
    }
    
    
    //
    // MARK: View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        if fromCustom == false {
            // Loop session
            for i in 0..<(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?.count)! {
                keyArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["movement"] as! String)
                setsArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["sets"] as! Int)
                repsArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["reps"] as! String)
            }
        }
        
        // Device Scale for @2x and @3x of Target Area Images
        switch UIScreen.main.scale {
        case 1,2:
            toAdd = "@2x"
        case 3:
            toAdd = "@3x"
        default:
            toAdd = "@3x"
        }
        
        //
        view.backgroundColor = Colors.dark
        
        //
        finishEarly.tintColor = Colors.red
        
        //
        // Progress Bar
        // Thickness
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        // Rounded Edges
        // Colour
        progressBar.trackTintColor = Colors.light
        progressBar.progressTintColor = Colors.green
        //
        progressBar.setProgress(0, animated: true)
        
        // TableView Background
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = Colors.dark
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        //
        tableView.backgroundView = tableViewBackground
        //
        tableView.tableFooterView = UIView()
        
        // Rest Time View Layout
        restTimeView.backgroundColor = Colors.dark
        restTimeView.alpha = 0
        restTimeHeight.constant = 0
        //
        restTimeTitleLabel.text = NSLocalizedString("rest:", comment: "")
        restTimeTitleLabel.textColor = Colors.light
        restTimeTimeLabel.textColor = Colors.light
        restTimeSkipButton.setTitle(NSLocalizedString("skip", comment: ""), for: .normal)
        restTimeSkipButton.setTitleColor(Colors.red, for: .normal)
        restTimeSkipButton.addTarget(self, action: #selector(skipRest), for: .touchUpInside)
        
        // Buttons
        //
        fillButtonArray()
        //
        
        //
        // Weight (Action Sheet)
        // view
        actionSheetView.backgroundColor = Colors.dark
        actionSheetView.layer.cornerRadius = 15
        actionSheetView.layer.masksToBounds = true
        // picker
        weightPicker.backgroundColor = Colors.dark
        weightPicker.delegate = self
        weightPicker.dataSource = self
        // ok
        okButton.backgroundColor = Colors.light
        okButton.setTitleColor(Colors.green, for: .normal)
        okButton.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        actionSheetView.addSubview(okButton)
        // Units
        unitIndicatorLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        unitIndicatorLabel.textColor = Colors.light
        // Units
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        units = settings["Units"]![0]
        // Metric
        if units == 0 {
            unitIndicatorLabel.text = NSLocalizedString("kg", comment: "")
        // Imperial
        } else {
            unitIndicatorLabel.text = NSLocalizedString("lb", comment: "")
        }
    }
    
    
    //
    // MARK: TableView ---------------------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    // Will Display Header
    var didSetFrame = false
    //
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = Colors.light
        
        //
        if section == 0 {
            //
            if header.subviews.contains(progressBar) == false {
                header.addSubview(progressBar)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 2
        case 1: return 0
        default: break
        }
        return 0
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        switch section {
        case 0: return keyArray.count
        case 1: return 1
        default: return 0
        }
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        switch indexPath.section {
        case 0:
            let cell: SessionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SessionTableViewCell", for: indexPath) as! SessionTableViewCell
            //
            let key = keyArray[indexPath.row]
            //
            cell.buttonView.layoutIfNeeded()
            //
            // Clean Cell
            for v in cell.buttonView.subviews {
                v.removeFromSuperview()
            }
            //
            // Cell
            cell.backgroundColor = Colors.dark
            cell.tintColor = Colors.dark
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.selectionStyle = .none
            
            
            // New image to display
            // Demonstration on left
            // [key] = key, [0] = first image
            cell.imageViewCell.image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
            // Indicator
            if ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"])?.count)! > 1 {
                cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
            } else {
                cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
            }
            cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
            cell.leftImageIndicator.tintColor = Colors.light
            cell.rightImageIndicator.tintColor = Colors.light
            
            //
            cell.imageViewCell.tag = indexPath.row
            cell.setsRepsLabel.tag = indexPath.row
            //
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleImageTap))
            cell.imageViewCell.addGestureRecognizer(imageTap)
            //
            
            //
            // Movement
            let movement = sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0]
            cell.movementLabel.text = NSLocalizedString(movement, comment: "")
            
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 27)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = Colors.light
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            //
            // Sets x Reps
            // String
            var setsRepsString = String()
            let setsString = String(setsArray[indexPath.row])
            // Weighted
            // If weighted i.e attributes contains "w"
            if sessionData.movements[SelectedSession.shared.selectedSession[0]]?[key]?["attributes"]?[0].contains("w") ?? false {
                // Units
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                let units = settings["Units"]![0]
                var unit = String()
                // Metric
                if units == 0 {
                    unit = NSLocalizedString("kg", comment: "")
                // Imperial
                } else {
                    unit = NSLocalizedString("lb", comment: "")
                }
                // Weight
                //
                var movementWeights = UserDefaults.standard.object(forKey: "movementWeights") as! [String: Int]
                // Presents sets x reps, and weight
                let key = keyArray[indexPath.row]
                let rowIndex = sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0]
                weightPicker.selectRow(movementWeights[rowIndex]!, inComponent: 0, animated: false)
                var weight = Float()
                // Metric
                if units == 0 {
                    weight = sessionData.weightsMetric()[movementWeights[rowIndex]!]
                // Imperial
                } else {
                    weight = sessionData.weightsImperial()[movementWeights[rowIndex]!]
                }
                setsRepsString = setsString + " x " + repsArray[indexPath.row] + "  |  " + String(weight) + unit
            // Unweighted movement
            } else {
                // Present sets x reps
                setsRepsString = setsString + " x " + repsArray[indexPath.row]
            }
            // Indicate asymmetric exercises to the user
            // If asymmetric movement i.e attributes contains "a"
            if sessionData.movements[SelectedSession.shared.selectedSession[0]]?[key]?["attributes"]?[0].contains("a") ?? false {
                // Append indicator
                let length = setsRepsString.count
                let stringToAdd = NSLocalizedString(") per side", comment: "")
                let length2 = stringToAdd.count
                setsRepsString = "(" + setsRepsString + stringToAdd
                let attributedString = NSMutableAttributedString(string: setsRepsString, attributes: [NSAttributedString.Key.font:UIFont(name: "SFUIDisplay-thin", size: 23.0)!])
                // Change indicator to red
                let range = NSRange(location:0,length:1) // specific location. This means "range" handle 1 character at location 2
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.red, range: range)
                let range2 = NSRange(location: 1 + length,length: length2)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.red, range: range2)
                cell.setsRepsLabel?.textColor = Colors.light
                cell.setsRepsLabel?.attributedText = attributedString
            } else {
                cell.setsRepsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.setsRepsLabel?.textColor = Colors.light
                cell.setsRepsLabel?.text = setsRepsString
            }
            //
            cell.setsRepsLabel?.textAlignment = .center
            cell.setsRepsLabel.adjustsFontSizeToFitWidth = true
            
            //
            // Explanation
            cell.explanationButton.tintColor = Colors.light
            // Timer
            cell.timerButton.tintColor = Colors.light

            //
            // Button Stuff
            //
            // Button Tag
            for b in buttonArray[indexPath.row] {
                b.tag = indexPath.row
            }
            //
            // Set Button View
            cell.buttonView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            //
            // Stack View
            let stackView = UIStackView(arrangedSubviews: buttonArray[indexPath.row])
            //
            // Layout
            let numberOfButtons = CGFloat(setsArray[indexPath.row])
            let xValue = ((cell.buttonView.frame.size.width - (numberOfButtons * 42.875)) / (numberOfButtons + 1))
            let yValue = (cell.buttonView.frame.size.height - 42.875) / 2
            let widthValue1 =
                (numberOfButtons - 1) * (cell.buttonView.frame.size.width - (numberOfButtons * 42.875))
            let widthValue2 = (widthValue1 / (numberOfButtons + 1)) + (numberOfButtons * 42.875)
            // Layout formula
            stackView.frame = CGRect(x: xValue, y: yValue, width: widthValue2, height: 42.875)
            //
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            //
            cell.buttonView.addSubview(stackView)
            //
            // Set Buttons
            // Disable pressed buttons
            let indexOfUnpressedButton = buttonNumber[indexPath.row]
            if indexOfUnpressedButton > 0 {
                for s in 0...indexOfUnpressedButton - 1 {
                    //
                    buttonArray[indexPath.row][s].isEnabled = false
                    buttonArray[indexPath.row][s].backgroundColor = Colors.light
                }
            }
            //
            // Enable next unpressed button
            if indexOfUnpressedButton == setsArray[indexPath.row] {
            } else {
                buttonArray[indexPath.row][indexOfUnpressedButton].isEnabled = true
            }
            
            
            //
            // Gestures
            //
            // Next Swipe
            let nextSwipe = UISwipeGestureRecognizer()
            nextSwipe.direction = .up
            nextSwipe.addTarget(self, action: #selector(nextButtonAction))
            cell.addGestureRecognizer(nextSwipe)
            
            // Back Swipe
            let backSwipe = UISwipeGestureRecognizer()
            backSwipe.direction = .down
            backSwipe.addTarget(self, action: #selector(backButtonAction))
            cell.addGestureRecognizer(backSwipe)
            
            // Explanation
            let explanationTap = UITapGestureRecognizer()
            explanationTap.numberOfTapsRequired = 1
            explanationTap.addTarget(self, action: #selector(expandExplanation))
        cell.explanationButton.addGestureRecognizer(explanationTap)
            
            // Timer
            let timerTap = UITapGestureRecognizer()
            timerTap.numberOfTapsRequired = 1
            timerTap.addTarget(self, action: #selector(timerAction))
        cell.timerButton.addGestureRecognizer(timerTap)
            
            // Left Image Swift
            let imageSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            imageSwipeLeft.direction = UISwipeGestureRecognizer.Direction.left
            cell.imageViewCell.addGestureRecognizer(imageSwipeLeft)
            cell.imageViewCell.isUserInteractionEnabled = true
            
            // Right Image Swipe
            let imageSwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            imageSwipeRight.direction = UISwipeGestureRecognizer.Direction.right
            cell.imageViewCell.addGestureRecognizer(imageSwipeRight)
            cell.imageViewCell.isUserInteractionEnabled = true
            
            
            // Alphas
            switch indexPath.row {
            case selectedRow - 1:
                cell.indicatorStack.alpha = 0
                cell.movementLabel.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.buttonView.alpha = 0
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
                cell.weightButton.isEnabled = false
            //
            case selectedRow:
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
                if isTimedMovement() && !fromCustom {
                    cell.timerButton.alpha = 1
                } else {
                    cell.timerButton.alpha = 0
                }
                cell.weightButton.isEnabled = true
                //cell.demonstrationImageView.isUserInteractionEnabled = true
            //
            case selectedRow + 1:
                //
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.selectionStyle = .none
                //
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 0
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
                cell.weightButton.isEnabled = false
                //cell.demonstrationImageView.isUserInteractionEnabled = false
            //
            default:
                //
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
                if isTimedMovement() && !fromCustom {
                    cell.timerButton.alpha = 1
                }
                cell.weightButton.isEnabled = true
            }
            
            // Reset image state
            cell.imageState = 0
            
            //
            return cell
        //
        case 1:
            //
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            //
            cell.separatorInset =  UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            //
            cell.layer.borderWidth = 2
            cell.layer.borderColor = Colors.light.cgColor
            //
            cell.textLabel?.text = NSLocalizedString("end", comment: "")
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)
            cell.textLabel?.textColor = Colors.light
            cell.textLabel?.textAlignment = .center
            //
            return cell
        default: return UITableViewCell(style: .value1, reuseIdentifier: nil)
        }
    }
    
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch indexPath.section {
        case 0:
            let toMinus: CGFloat = ElementHeights.statusBarHeight + 2 + ElementHeights.bottomSafeAreaInset
            switch indexPath.row {
            case selectedRow - 1, selectedRow:
                return (UIScreen.main.bounds.height - toMinus) * 7/8
            case selectedRow + 1:
                return (UIScreen.main.bounds.height - toMinus) * 1/8
            default:
                return (UIScreen.main.bounds.height - toMinus) * 1/8
            }
        case 1: return 49
        default: return 0
        }
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch indexPath.section {
        case 0: break
            //
        // End button
        case 1:
            //
            // Schedule Tracking
            ScheduleManager.shared.shouldReloadScheduleTracking()
            //
            self.dismiss(animated: true)
            
        //
        default: break
        }
    }
    
    // MARK: Weight Action
    @IBAction func weightButton(_ sender: Any) {
        // Get movement
        let key = keyArray[selectedRow]
        let movement = sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0]
        //
        // If weighted i.e attributes contains "w"
        if sessionData.movements[SelectedSession.shared.selectedSession[0]]?[key]?["attributes"]?[0].contains("w") ?? false {
            //
            actionSheetView.addSubview(weightPicker)
            actionSheetView.addSubview(unitIndicatorLabel)
            actionSheetView.bringSubviewToFront(unitIndicatorLabel)
            //
            var movementWeights = UserDefaults.standard.object(forKey: "movementWeights") as! [String: Int]
            // View
            let weightWidth = ActionSheet.shared.actionWidth
            let weightHeight = CGFloat(147 + 49)
            actionSheetView.frame = CGRect(x: 10, y: view.frame.maxY, width: weightWidth, height: weightHeight)
            UIApplication.shared.keyWindow?.insertSubview(actionSheetView, aboveSubview: tableView)
            //
            // select correct row
            weightPicker.selectRow(movementWeights[movement]!, inComponent: 0, animated: false)
            //
            // picker
            weightPicker.frame = CGRect(x: 0, y: 0, width: actionSheetView.frame.size.width, height: 147)
            // ok
            okButton.frame = CGRect(x: 0, y: 147, width: actionSheetView.frame.size.width, height: 49)
            //
            self.unitIndicatorLabel.frame = CGRect(x: (actionSheetView.frame.size.width / 2 + 40), y: (self.weightPicker.frame.size.height / 2) - 15, width: 50, height: 30)
            //
            self.actionSheetView.frame = CGRect(x: 0, y: 0, width: weightWidth, height: weightHeight)
            
            // picker
            self.weightPicker.frame = CGRect(x: 0, y: 0, width: self.actionSheetView.frame.size.width, height: 147)
            // ok
            self.okButton.frame = CGRect(x: 0, y: 147, width: self.actionSheetView.frame.size.width, height: 49)
            // Sets Indicator Label
            self.unitIndicatorLabel.frame = CGRect(x: (self.actionSheetView.frame.size.width / 2 + 40), y: (self.weightPicker.frame.size.height / 2) - 15, width: 50, height: 30)
            //
            ActionSheet.shared.setupActionSheet()
            ActionSheet.shared.actionSheet.addSubview(actionSheetView)
            let heightToAdd = actionSheetView.bounds.height
            ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
            ActionSheet.shared.resetCancelFrame()
            ActionSheet.shared.animateActionSheetUp()
        }
    }
    //
    // MARK: Weight Ok button action
    @objc func okButtonAction(_ sender: Any) {
        
        // Weights
        var movementWeights = UserDefaults.standard.object(forKey: "movementWeights") as! [String: Int]
        //
        // select correct row
        let key = keyArray[selectedRow]
        let rowIndex = sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0]
        movementWeights[rowIndex] = weightPicker.selectedRow(inComponent: 0)
        //
        UserDefaults.standard.set(movementWeights, forKey: "movementWeights")
        //
        
        ActionSheet.shared.animateActionSheetDown()
        //
        tableView.reloadData()
    }
    //
    // MARK: Picker View ----------------------------------------------------------------------------------------------------
    //
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Metric
        if units == 0 {
            return sessionData.weightsMetric().count
        // Imperial
        } else {
            return sessionData.weightsImperial().count
        }
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        let weightLabel = UILabel()
        // Metric
        if units == 0 {
            weightLabel.text = String(sessionData.weightsMetric()[row])
        // Imperial
        } else {
            weightLabel.text = String(sessionData.weightsImperial()[row])
        }
        weightLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
        weightLabel.textColor = Colors.light
        //
        weightLabel.textAlignment = .center
        return weightLabel
        //
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    
    //
    // MARK: Set Buttons and Rest Timers --------------------
    //
    //
    // MARK: Set Buttons -----------------------------------------------------------------------------------------------
    //
    // Button Array
    var buttonArray = [[UIButton]]()
    // Set Button Action
    var buttonNumber = [Int]()
    //
    // Generate Buttons
    func createButton() -> UIButton {
        //
        let setButton = UIButton()
        let widthHeight = NSLayoutConstraint(item: setButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: .equal, toItem: setButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        setButton.addConstraints([widthHeight])
        setButton.frame = CGRect(x: 0, y: 0, width: 42.875, height: 42.875)
        setButton.layer.borderWidth = 3
        setButton.layer.borderColor = Colors.light.cgColor
        setButton.layer.cornerRadius = 21.4375
        setButton.addTarget(self, action: #selector(setButtonAction), for: .touchUpInside)
        setButton.backgroundColor = Colors.dark
        setButton.isEnabled = false
        //
        return setButton
    }
    
    // Set Button
    @IBAction func setButtonAction(sender: UIButton) {
        // Do nothing if a set button has already been presssed
        // Do something if not
        if isTiming == false {
            //
            // Rest Timer Notification
            let content = UNMutableNotificationContent()
            content.title = NSLocalizedString("restOver", comment: "")
            content.body = NSLocalizedString("nextSet", comment: "")
            content.sound = UNNotificationSound.default
            //
            let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let restTime = settings["RestTimes"]![1]
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(restTime), repeats: false)
            let request = UNNotificationRequest(identifier: "restTimer", content: content, trigger: trigger)
            //
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            // Start rest timer
            startTimer()
            
            //
            // Button editing, colour etc..
            let buttonRow = sender.tag
            //
            buttonArray[buttonRow][buttonNumber[buttonRow]].isEnabled = false
            // Increase Button Number
            if self.setsArray[buttonRow] == 0 {
            } else {
                if self.buttonNumber[buttonRow] < self.setsArray[buttonRow] {
                    self.buttonNumber[buttonRow] = self.buttonNumber[buttonRow] + 1
                }
            }
            // Enable After Delay
            let delayInSeconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                if self.setsArray[buttonRow] == 0 {
                } else {
                    if self.buttonNumber[buttonRow] < self.setsArray[buttonRow] {
                        self.buttonArray[buttonRow][self.buttonNumber[buttonRow]].isEnabled = true
                    }
                }
            }
            //
            sender.isEnabled = false
            sender.backgroundColor = Colors.light
            //
            updateProgress()
        }
    }
    
    
    // Generate an Array of Arrays of Buttons
    //
    func fillButtonArray() {
        for i in 0...(setsArray.count - 1){
            //
            var buttonArray2 = [UIButton]()
            //
            for _ in 1...setsArray[i]{
                buttonArray2 += [createButton()]
            }
            //
            buttonArray += [buttonArray2]
            buttonNumber.append(0)
        }
        buttonArray[0][0].isEnabled = true
    }
    
    //
    // MARK: Timer Functions
    //
    // Update and Format Timer
    // Timer CountDown Title
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Update Timer
    @objc func updateTimer() {
        //
        if timerValue == 0 {
            //
            restTimeHeight.constant = 0
            finishEarlyTop.constant = 7
            UIView.animate(withDuration: AnimationTimes.animationTime1) {
                self.restTimeView.alpha = 0
                self.view.layoutIfNeeded()
            }
            //
            Vibrate.shared.vibratePhone()
            rowTimer.invalidate()
            didSetEndTime = false
            isTiming = false
            NotificationCenter.default.removeObserver(self)
            //
        } else {
            timerValue -= 1
            restTimeTimeLabel.text = timeFormatted(totalSeconds: timerValue)
            //
        }
    }
    
    //
    // Start Timer
    @objc func startTimer() {
        // Dates and Times
        startTime = Date().timeIntervalSinceReferenceDate
        //
        if didSetEndTime == false {
            // Watch for enter foreground (Incase user puts app in background then returns app to foreground, timer should be updated upon enter foreground)
            NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: UIApplication.willEnterForegroundNotification, object: nil)
            // Layout
            restTimeHeight.constant = 49
            finishEarlyTop.constant = 7 + 49
            UIView.animate(withDuration: AnimationTimes.animationTime1) {
                self.restTimeView.alpha = 1
                self.view.layoutIfNeeded()
            }
            // Times
            isTiming = true
            didSetEndTime = true
            let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let duration = settings["RestTimes"]![1]
            endTime = startTime + Double(duration)
        }
        
        // Set timer value
        timerValue = Int(endTime - startTime)
        
        // Check Greater than 0
        if timerValue <= 0 {
            timerValue = 0
        }
        
        // Set Timer
        // Set initial time
        restTimeTimeLabel.text = timeFormatted(totalSeconds: timerValue)
        
        // Begin Timer
        rowTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    //
    // Skip Rest
    @IBAction func skipRest(sender: UIButton) {
        //
        restTimeHeight.constant = 0
        finishEarlyTop.constant = 7
        UIView.animate(withDuration: AnimationTimes.animationTime1) {
            self.restTimeView.alpha = 0
            self.view.layoutIfNeeded()
        }
        //
        Vibrate.shared.vibratePhone()
        rowTimer.invalidate()
        didSetEndTime = false
        isTiming = false
        NotificationCenter.default.removeObserver(self)
        //
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    //
    // MARK: Tap Handlers, buttons and funcs -------------------------------------------------------------------------------------------------------
    //
    //
    //
    // Image
    @IBAction func handleImageTap(imageTap:UITapGestureRecognizer) {
        //
        // Get Cell
        let sender = imageTap.view as! UIImageView
        let tag = sender.tag
        let indexPath = NSIndexPath(row: tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! SessionTableViewCell
        //
        let key = keyArray[indexPath.row]
        //
        let imageCount = ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"])?.count)!
        //
        // Image Array
        if imageCount > 1 && cell.imageViewCell.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![i])!)
            }
            //
            cell.imageViewCell.animationImages = animationArray
            cell.imageViewCell.animationDuration = Double(imageCount - 1) * 0.5
            cell.imageViewCell.animationRepeatCount = 1
            //
            sender.startAnimating()
        }
    }
    
    // Play Image
    func playAnimation(row: Int) {
        //
        // Get Cell
        let indexPath = NSIndexPath(row: row, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! SessionTableViewCell
        //
        let key = keyArray[indexPath.row]
        //
        let imageCount = ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"])?.count)!        //
        // Image Array
        if imageCount > 1 && cell.imageViewCell.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![i])!)
            }
            //
            cell.imageViewCell.animationImages = animationArray
            cell.imageViewCell.animationDuration = Double(imageCount - 1) * 0.5
            cell.imageViewCell.animationRepeatCount = 1
            //
            cell.imageViewCell.startAnimating()
        }
    }
    
    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        if selectedRow < keyArray.count - 1 {
            //
            selectedRow += 1
            updateProgress()
            //
            //
            let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
            let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
            let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)
            //
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! SessionTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                // 1
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 27)
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
                if self.isTimedMovement() && !self.fromCustom {
                    cell.timerButton.alpha = 1
                }
                cell.weightButton.isEnabled = true
                //
                // -1
                cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! SessionTableViewCell
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 0
                cell.buttonView.alpha = 0
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
                cell.weightButton.isEnabled = false
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: false)
            }, completion: { finished in
                //                self.playAnimation(row: self.selectedRow)
            })
            // + 1
            if selectedRow < keyArray.count - 1 {
                tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableView.RowAnimation.none)
            }
        }
    }
    
    // Back Button
    @IBAction func backButtonAction() {
        
        if selectedRow != 0 {

            selectedRow = selectedRow - 1
            updateProgress()

            let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
            let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
            let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)

            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! SessionTableViewCell

            UIView.animate(withDuration: 0.6, animations: {
                
                // As progress bar is contained in the table view header, scrolling back to row 0 jumps the progress bar off the screen
                // Silly fix below seems to work
                if self.selectedRow == 0 {
                    self.tableView.beginUpdates()
                    self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: false)
                    self.tableView.endUpdates()
                } else {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                    self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: false)
                }
                
                // 1
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
                if self.isTimedMovement() && !self.fromCustom {
                    cell.timerButton.alpha = 1
                }
                cell.weightButton.isEnabled = true
                // - 1
                if self.selectedRow > 0 {
                    cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! SessionTableViewCell
                    cell.indicatorStack.alpha = 0
                    cell.setsRepsLabel.alpha = 0
                    cell.movementLabel.alpha = 0
                    cell.buttonView.alpha = 0
                    cell.explanationButton.alpha = 0
                    cell.timerButton.alpha = 0
                    cell.weightButton.isEnabled = false
                }
                // + 1
                cell = self.tableView.cellForRow(at: indexPath3 as IndexPath) as! SessionTableViewCell
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 0
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
                cell.weightButton.isEnabled = false
                //
            })
        }
    }
    
    //
    // Explanation
    //
    let scrollViewExplanation = UIScrollView()
    let backgroundViewExplanation = UIButton()
    //
    let explanationLabel = UILabel()
    // Expand
    @IBAction func expandExplanation() {
        let bounds = UIScreen.main.bounds
        // View
        //
        scrollViewExplanation.frame = CGRect(x: 0, y: 0, width: bounds.width, height: (bounds.height - 20) / 2)
        scrollViewExplanation.center.x = bounds.width/2
        scrollViewExplanation.center.y = (((bounds.height - 20)/2) * 2.5) + 20
        //
        scrollViewExplanation.backgroundColor = Colors.light
        
        // Background View
        //
        backgroundViewExplanation.frame = CGRect(x: 0, y: 0, width: bounds.width, height: (bounds.height - 20))
        backgroundViewExplanation.backgroundColor = .black
        backgroundViewExplanation.alpha = 0
        //
        backgroundViewExplanation.addTarget(self, action: #selector(retractExplanation(_:)), for: .touchUpInside)
        
        //
        // Contents
        explanationLabel.textAlignment = .natural
        explanationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        explanationLabel.numberOfLines = 0
        //
        let key = keyArray[selectedRow]
        explanationLabel.attributedText = formatExplanationText(title: NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0], comment: ""), howTo: NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["explanation"]![0], comment: ""), toAvoid: NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["explanation"]![1], comment: ""), focusOn: NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["explanation"]![2], comment: ""))
        explanationLabel.frame = CGRect(x: 10, y: 10, width: scrollViewExplanation.frame.size.width - 10, height: 0)
        //
        explanationLabel.sizeToFit()
        
        //
        // Scroll View
        scrollViewExplanation.addSubview(explanationLabel)
        scrollViewExplanation.contentSize = CGSize(width: bounds.width, height: explanationLabel.frame.size.height + 20)
        //
        scrollViewExplanation.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        //
        // Add Views
        UIApplication.shared.keyWindow?.addSubview(backgroundViewExplanation)
        UIApplication.shared.keyWindow?.addSubview(scrollViewExplanation)
        
        //
        // Animate
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.scrollViewExplanation.center.y = (((bounds.height - 20)/2) * 1.5) + 20
            self.backgroundViewExplanation.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract Explanation
    @IBAction func retractExplanation(_ sender: Any) {
        let bounds = UIScreen.main.bounds
        //
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            self.scrollViewExplanation.center.y = ((bounds.height - 20)/2) * 2.5 + 20
            self.backgroundViewExplanation.alpha = 0
        }, completion: { finished in
            //
            self.scrollViewExplanation.removeFromSuperview()
            self.backgroundViewExplanation.removeFromSuperview()
            //
            self.explanationLabel.removeFromSuperview()
            //
        })
    }
    
    @IBAction func timerAction(_ sender: Any) {
        //
        if isTimedMovement() {
            if !didSetEndTime {
                print(SelectedSession.shared.selectedSession)
               let time = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[selectedRow]["time"] as! Int
                StopClock.shared.setupStopClock(time: time)
                StopClock.shared.resetOptionFrames()
                StopClock.shared.animatestopClockUp()
            } else {
                //
                // Alert View
                let title = NSLocalizedString("setTimer", comment: "")
                let message = NSLocalizedString("setTimerWarning", comment: "")
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.view.tintColor = Colors.dark
                alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
                //
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .natural
                alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
                
                //
                // Action
                let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    //
                }
                //
                alert.addAction(okAction)
                //
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    //
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! SessionTableViewCell
        //
        let key = keyArray[indexPath.row]
        let imageCount = ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"])?.count)!        //
        if cell.imageViewCell.isAnimating == false {
            //
            switch extraSwipe.direction {
            //
            case UISwipeGestureRecognizer.Direction.left:
                //
                // nina
                // Check left image is displayed
                if cell.imageState == 0 {
                    cell.imageState = 1
                    // Screenshot of current image
                    let snapshot1 = cell.imageViewCell.snapshotView(afterScreenUpdates: false)
                    snapshot1?.bounds = cell.imageViewCell.bounds
                    snapshot1?.center.x = cell.center.x
                    cell.addSubview(snapshot1!)
                    
                    // New image to display
                    // Demonstration on left
                    cell.imageViewCell.image = getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["targetArea"]![0] + toAdd)
                    // Indicator
                    if imageCount > 1 {
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlayDeselected")
                    } else {
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                    }
                    cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                    
                    
                    // Move new image to right of screen
                    cell.imageViewCell.center.x = cell.center.x + cell.frame.size.width
                    cell.imageViewCell.reloadInputViews()
                    
                    // Animate new and old image
                    UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        //
                        snapshot1?.center.x = cell.center.x - cell.frame.size.width
                        cell.imageViewCell.center.x = cell.center.x
                        //
                    }, completion: { finished in
                        snapshot1?.removeFromSuperview()
                    })
                    //
                }
            //
            case UISwipeGestureRecognizer.Direction.right:
                //
                if cell.imageState == 1 {
                    cell.imageState = 0
                    //
                    let snapshot1 = cell.imageViewCell.snapshotView(afterScreenUpdates: false)
                    snapshot1?.bounds = cell.imageViewCell.bounds
                    snapshot1?.center.x = cell.center.x
                    cell.addSubview(snapshot1!)
                    
                    // New image to display
                    // Demonstration on left
                    cell.imageViewCell.image = getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![0])
                    // Indicator
                    if imageCount > 1 {
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                    } else {
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                    }
                    cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                    
                    //
                    cell.imageViewCell.center.x = cell.center.x - cell.frame.size.width
                    cell.imageViewCell.reloadInputViews()
                    
                    //
                    UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        snapshot1?.center.x = cell.center.x + cell.frame.size.width
                        cell.imageViewCell.center.x = cell.center.x
                        //
                    }, completion: { finished in
                        snapshot1?.removeFromSuperview()
                    })
                    //
                }
            default: break
            }
        }
    }
    
    //
    // Update Progress
    func updateProgress() {
        // Current Pose
        let currentPose = Float(selectedRow)
        // Total Number Poses
        let totalPoses = Float(keyArray.count - 1)
        
        
        //
        if selectedRow > 0 {
            //
            let currentProgress = currentPose / totalPoses
            progressBar.setProgress(currentProgress, animated: true)
        } else {
            // Initial state
            progressBar.setProgress(0, animated: true)
        }
    }
    
    //
    @IBAction func finishEarlyAction(_ sender: Any) {
        //
        // Alert View
        let title = NSLocalizedString("finishEarly", comment: "")
        let message = NSLocalizedString("finishEarlyMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        //
        // Action
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            //
            //
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["restTimer"])
            
            //
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        //
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        //
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // Check whether timed movement
    func isTimedMovement() -> Bool {
        // Classic gym workouts have no timing
        if SelectedSession.shared.selectedSession[1].hasPrefix("classicGym") {
            return false
        } else {
            let setsRepsString = repsArray[selectedRow]
            // seconds/breaths
            if setsRepsString.hasSuffix("s") {
                return true
            } else {
                return false
            }
        }
    }
    
    //
    // MARK: Walkthrough ------------------------------------------------------------------------------------------------------------------
    //
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabelView = UIView()
    var walkthroughLabelTitle = UILabel()
    var walkthroughLabelSeparator = UIView()
    var walkthroughLabel = UILabel()
    var walkthroughNextButton = UIButton()
    var walkthroughBackButton = UIButton()
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["session01", "session1", "session2", "session3", "session4", "session5"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    var highlightColor = UIColor()
    
    @objc func backActionWalkthrough() {
        if walkthroughProgress != 0 && walkthroughProgress != 1 {
            walkthroughProgress -= 2
            walkthroughSession()
        }
    }
    
    // Walkthrough
    @objc func walkthroughSession() {
        //
        let toAdd = ElementHeights.statusBarHeight + 2
        let toMinus: CGFloat = ElementHeights.statusBarHeight + 2 + ElementHeights.bottomSafeAreaInset
        let cellHeight = (UIScreen.main.bounds.height - toMinus) * 3/4
        
        let delayShort = 0.6
        
        //
        if didSetWalkthrough == false {
            //
            walkthroughNextButton.addTarget(self, action: #selector(walkthroughSession), for: .touchUpInside)
            walkthroughBackButton.addTarget(self, action: #selector(backActionWalkthrough), for: .touchUpInside)
            
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, separator: walkthroughLabelSeparator, nextButton: walkthroughNextButton, backButton: walkthroughBackButton, highlight: walkthroughHighlight, simplePopup: false)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Sets x Reps
        case 0:
            
            //
            walkthroughLabelTitle.text = NSLocalizedString(walkthroughTexts[walkthroughProgress] + "T", comment: "")
            
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.frame.size = walkthroughLabel.sizeThatFits(CGSize(width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding, height: .greatestFiniteMagnitude))
            
            walkthroughLabel.frame = CGRect(
                x: WalkthroughVariables.padding,
                y: WalkthroughVariables.topHeight + WalkthroughVariables.padding,
                width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding,
                height: walkthroughLabel.frame.size.height)
            walkthroughLabelView.frame = CGRect(
                x: 13,
                y: 13 + ElementHeights.combinedHeight,
                width: view.frame.size.width - WalkthroughVariables.twiceViewPadding,
                height: WalkthroughVariables.topHeight + walkthroughLabel.frame.size.height + WalkthroughVariables.twicePadding)
            
            // Colour
            walkthroughLabelView.backgroundColor = Colors.light
            walkthroughLabel.textColor = Colors.dark
            walkthroughLabelTitle.textColor = Colors.dark
            walkthroughLabelSeparator.backgroundColor = Colors.dark
            walkthroughNextButton.setTitleColor(Colors.dark, for: .normal)
            walkthroughBackButton.setTitleColor(Colors.dark, for: .normal)
            walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.light.cgColor
            
            // Flash
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! SessionTableViewCell
                self.walkthroughHighlight.frame.size = CGSize(width: cell.setsRepsLabel.frame.width + 16, height: cell.setsRepsLabel.frame.height + 4)
                self.walkthroughHighlight.center = cell.setsRepsLabel.center
                self.walkthroughHighlight.center.y += toAdd
                self.walkthroughHighlight.layer.cornerRadius = self.walkthroughHighlight.bounds.height / 2
                
                self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            walkthroughProgress = self.walkthroughProgress + 1
         
        // Rest Timer
        case 1:
            //
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! SessionTableViewCell
            highlightSize = CGSize(width: cell.buttonView.frame.width, height: cell.buttonView.frame.height + 8)
            highlightCenter = cell.buttonView.center
            highlightCenter?.y += toAdd
            //
            highlightCornerRadius = 0
            // Top of view
            labelFrame = 1
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)

            //
            walkthroughProgress = self.walkthroughProgress + 1

        // Demonstration (+ target area)
        case 2:
            //
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! SessionTableViewCell
            highlightSize = cell.indicatorStack.frame.size
            highlightCenter = cell.indicatorStack.center
            highlightCenter?.y += toAdd
            //
            highlightCornerRadius = 0
            // Top of view
            labelFrame = 1
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Explanation
        case 3:
            //
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! SessionTableViewCell
            highlightSize = cell.explanationButton.frame.size
            highlightCenter = cell.explanationButton.center
            highlightCenter?.y += toAdd
            //
            highlightCornerRadius = 0
            // Top
            labelFrame = 1
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            walkthroughHighlight.alpha = 1
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        // Next Movement
        case 4:
            //
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! SessionTableViewCell
            highlightSize = cell.explanationButton.frame.size
            highlightCenter = cell.explanationButton.center
            highlightCenter?.y += toAdd
            //
            highlightCornerRadius = 0
            // Top
            labelFrame = 1
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            walkthroughHighlight.alpha = 0
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        // Next movement demonstration and then go to finish early
        case 5:
            //
            walkthroughLabelView.alpha = 0
            //
            // Swipe demonstration
            walkthroughNextButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayShort, execute: {
                //
                let upSwipe = UIView()
                upSwipe.frame.size = CGSize(width: 50, height: 50)
                upSwipe.backgroundColor = Colors.light
                upSwipe.layer.cornerRadius = 25
                upSwipe.clipsToBounds = true
                upSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (7/8)) + 2
                upSwipe.center.x = self.view.bounds.width / 2
                UIApplication.shared.keyWindow?.insertSubview(upSwipe, aboveSubview: self.walkthroughView)
                // Perform swipe action
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                    self.nextButtonAction()
                })
                // Animate swipe demonstration
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    //
                    upSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (1/8)) + 2
                    //
                }, completion: { finished in
                    upSwipe.removeFromSuperview()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayShort, execute: {
                        //
                        let downSwipe = UIView()
                        downSwipe.frame.size = CGSize(width: 50, height: 50)
                        downSwipe.backgroundColor = Colors.light
                        downSwipe.layer.cornerRadius = 25
                        downSwipe.clipsToBounds = true
                        downSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (1/8)) + 2
                        downSwipe.center.x = self.view.bounds.width / 2
                        UIApplication.shared.keyWindow?.insertSubview(downSwipe, aboveSubview: self.walkthroughView)
                        // Perform swipe action
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                            self.backButtonAction()
                        })
                        // Animate swipe demonstration
                        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            //
                            downSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (7/8)) + 2
                            //
                        }, completion: { finished in
                            self.walkthroughNextButton.isEnabled = true
                            //
                            downSwipe.removeFromSuperview()
                            //
                            self.walkthroughLabelView.alpha = 1
                            //
                            self.highlightSize = CGSize(width: 36, height: 36)
                            self.highlightCenter = CGPoint(x: 27, y: ElementHeights.statusBarHeight + 2 + 5 + 22)
                            self.highlightCornerRadius = 0
                            self.walkthroughHighlight.alpha = 1
                            //
                            self.labelFrame = 0
                            //
                            self.walkthroughBackgroundColor = Colors.light
                            self.walkthroughTextColor = Colors.dark
                            self.highlightColor = Colors.light
                            //
                            self.nextWalkthroughViewTest(walkthroughView: self.walkthroughView, labelView: self.walkthroughLabelView, label: self.walkthroughLabel, title: self.walkthroughLabelTitle, highlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                            //
                            self.walkthroughProgress = self.walkthroughProgress + 1
                            
                        })
                    })
                })
            })
            
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.didSetWalkthrough = false
                self.walkthroughView.removeFromSuperview()
                var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                walkthroughs["Session"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            })
        }
    }
}

