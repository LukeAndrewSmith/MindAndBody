//
//  WorkoutSessionScreenOverview.swift
//  MindAndBody
//
//  Created by Luke Smith on 20.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


//
// Custom Overview Tableview Cells ---------------------------------------------------------------------------
//
// Overview TableView Cell
class WorkoutOverviewTableViewCell: UITableViewCell {
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
    // Explanation Button
    @IBOutlet weak var explanationButton: UIButton!
    // Timer
    @IBOutlet weak var timerButton: UIButton!
    
    //
    var imageState = 0 // 0 == left image, 1 == right image
}


// Overview End Cell
class EndRoundTableViewCell: UITableViewCell {
    // Title Label
    @IBOutlet weak var titleLabel: UILabel!
}


//
// Session Screen Overview Class ------------------------------------------------------------------------------------
//
class CircuitWorkoutScreen: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //
    // MARK: Variables from Session Data
    var fromCustom = false
    var fromSchedule = false
    //
    // Key Array
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [1] Keys Array
    var keyArray: [String] = []
    
    // Reps
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [3] reps array
    var repsArray: [String] = []
    
    //
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] rounds array, [0] = round
    var numberOfRounds = Int()
    
    var numberOfMovementsInRound = Int()
    
    // To Add (@2x or @3x) for demonstration images
    var toAdd = String()
    
    
    
    //
    // Variables
    var selectedRow = 0
    
    //
    var sessionScreenRoundIndex = 0
    //
    
    //
    // Outlets -----------------------------------------------------------------------------------------------------------
    //
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // MARK: Walkthrough
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["Session2"] == false {
            self.walkthroughSession()
        }
    }
    
    
    //
    // View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If not from custom, retreive data
        if fromCustom == false && keyArray == [] {
            // Loop session
            for i in 0..<(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?.count)! {
                keyArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["movement"] as! String)
                repsArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["reps"] as! String)
            }
            // Rounds in first movement
            numberOfRounds = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[0]["rounds"] as! Int
            
            //
            // Cardio bodyweight workouts uses this screen, but accesses movements from the workout section, so this switch is necessary but ok, as all the session information has just been transferred to temporary arrays
            if SelectedSession.shared.selectedSession[0] == "cardio" {
                SelectedSession.shared.selectedSession[0] = "workout"
            }
        }
        
        //
        numberOfMovementsInRound = keyArray.count / numberOfRounds

        
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
        
        //
        // Watch for enter foreground
        NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // TableView ---------------------------------------------------------------------------------------------------------------------
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
            if header.subviews.contains(progressBar) {
            } else {
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
        case 0:
            return numberOfMovementsInRound
        case 1: return 1
        default: return 0
        }
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutOverviewTableViewCell", for: indexPath) as! WorkoutOverviewTableViewCell
            
            //
            let key = keyArray[indexPath.row]
            
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
            
            //
            cell.imageViewCell.tag = indexPath.row
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
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 23)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = Colors.light
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            //
            // Set and Reps
            // (numberOfMovementsInRound * sessionScreenRoundIndex) = first index of round
            let indexRow = (numberOfMovementsInRound * sessionScreenRoundIndex) + indexPath.row
            //
            // Sets x Reps (Note: not actually any sets for circuit workouts)
            // String
            var setsRepsString = String()
            // Weighted
            print(SelectedSession.shared.selectedSession)
            if sessionData.weightedWorkoutMovements.contains(movement) && SelectedSession.shared.selectedSession[1] != "bodyweight" {
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
                setsRepsString = repsArray[indexRow] + "  |  " + String(weight) + unit
                // Unweighted movement
            } else {
                // Present sets x reps
                setsRepsString = repsArray[indexRow]
            }
            cell.setsRepsLabel?.text = setsRepsString
            cell.setsRepsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.setsRepsLabel?.textAlignment = .right
            cell.setsRepsLabel?.textColor = Colors.light
            cell.setsRepsLabel.adjustsFontSizeToFitWidth = true
            
            
            
            //
            // Sets x Reps
            // String
            var repsString = repsArray[indexRow]
            //
            // Indicate asymmetric exercises to the user
            // If asymmetric movement array contains the current movement
            if (sessionData.asymmetricMovements[SelectedSession.shared.selectedSession[0]]?.contains(key))! {
                // Append indicator
                let length = repsString.count
                let stringToAdd = NSLocalizedString(") per side", comment: "")
                let length2 = stringToAdd.count
                repsString = "(" + repsString + stringToAdd
                let attributedString = NSMutableAttributedString(string: repsString, attributes: [NSAttributedStringKey.font:UIFont(name: "SFUIDisplay-thin", size: 23.0)!])
                // Change indicator to red
                let range = NSRange(location:0,length:1) // specific location. This means "range" handle 1 character at location 2
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: Colors.red, range: range)
                let range2 = NSRange(location: 1 + length,length: length2)
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: Colors.red, range: range2)
                cell.setsRepsLabel?.textColor = Colors.light
                cell.setsRepsLabel?.attributedText = attributedString
            } else {
                cell.setsRepsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.setsRepsLabel?.textColor = Colors.light
            }
            
            cell.setsRepsLabel?.textAlignment = .center
            cell.setsRepsLabel.adjustsFontSizeToFitWidth = true
            //
            
            //
            // Explanation
            cell.explanationButton.tintColor = Colors.light
            // Timer
            cell.timerButton.tintColor = Colors.light
            
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
            imageSwipeLeft.direction = UISwipeGestureRecognizerDirection.left
            cell.imageViewCell.addGestureRecognizer(imageSwipeLeft)
            cell.imageViewCell.isUserInteractionEnabled = true
            
            // Right Image Swipe
            let imageSwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            imageSwipeRight.direction = UISwipeGestureRecognizerDirection.right
            cell.imageViewCell.addGestureRecognizer(imageSwipeRight)
            cell.imageViewCell.isUserInteractionEnabled = true
            
            
            // Alphas
            switch indexPath.row {
            case selectedRow:
                //
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                if isTimedMovement() {
                    cell.timerButton.alpha = 1
                } else {
                    cell.timerButton.alpha = 0
            }            //
            default:
                //
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 0
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
            }
            
            //
            return cell
        //
        case 1:
            //
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            //
            cell.separatorInset =  UIEdgeInsetsMake(0.0, 0.0, 0.0, -cell.bounds.size.width)
            //
            cell.layer.borderWidth = 2
            cell.layer.borderColor = Colors.light.cgColor
            //
            if sessionScreenRoundIndex + 1 < numberOfRounds {
                cell.textLabel?.text = NSLocalizedString("endRound", comment: "") + " " + String(sessionScreenRoundIndex + 1)
            } else {
                cell.textLabel?.text = NSLocalizedString("endWorkout", comment: "")
            }
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)
            cell.textLabel?.textColor = Colors.light
            cell.textLabel?.textAlignment = .center
            //
            return cell
        default:
            return UITableViewCell(style: .value1, reuseIdentifier: nil)
        }
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch indexPath.section {
        case 0:
            //
            let height2 = 0.25/Double(numberOfMovementsInRound - 1)
            //
            let toMinus: CGFloat = ElementHeights.statusBarHeight + 2 + ElementHeights.bottomSafeAreaInset
            switch indexPath.row {
            case selectedRow:
                return (UIScreen.main.bounds.height - toMinus) * 3/4
            case selectedRow + 1, selectedRow - 1:
                return (UIScreen.main.bounds.height - toMinus) * CGFloat(height2)
            default:
                return (UIScreen.main.bounds.height - toMinus) * CGFloat(height2)
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
        // End Round/Workout button
        case 1:
            
            if sessionScreenRoundIndex < numberOfRounds - 1 {
                //
                sessionScreenRoundIndex += 1
                selectedRow = 0
                //
                endRound()
                //
            } else {
                //
                // Schedule Tracking
                ScheduleVariables.shared.shouldReloadScheduleTracking()
                //
                self.dismiss(animated: true)
            }
            //
            tableView.deselectRow(at: indexPath, animated: true)
            //
        //
        default: break
        }
    }
    
    //
    // MARK: Weight Action
    @IBAction func weightButton(_ sender: Any) {
        // Get movement
        let key = keyArray[selectedRow]
        let movement = sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0]
        //
        if sessionData.weightedWorkoutMovements.contains(movement) && SelectedSession.shared.selectedSession[0].contains("Gym")  {
            //
            actionSheetView.addSubview(weightPicker)
            actionSheetView.addSubview(unitIndicatorLabel)
            actionSheetView.bringSubview(toFront: unitIndicatorLabel)
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
    // MARK: Next Round -------------------------------------------------------------------------------------------
    //
    let restTitle = NSLocalizedString("rest", comment: "")
    var restTime = Int()
    var restMessage = String()
    var restAlert = UIAlertController()
    //
    // Timer
    // Variables
    var didSetEndTime = false
    var startTime = Double()
    var endTime = Double()
    
    // Update Timer
    @objc func updateTimer() {
        //
        if restTime == 0 {
            rowTimer.invalidate()
            self.restAlert.dismiss(animated: true)
            //
            didSetEndTime = false
            //
            Vibrate.shared.vibratePhone()
            //
            // Next Round
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            //
            let indexPath0 = NSIndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: indexPath0 as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
            //
            let cell = self.tableView.cellForRow(at: indexPath0 as IndexPath) as! WorkoutOverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                // 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                if self.self.isTimedMovement() {
                    cell.timerButton.alpha = 1
                }
                //
                self.updateProgress()
                //
            }, completion: { finished in
                self.tableView.reloadData()
            })
            
            //
            // Alert View
            let titleString = "round" + String(self.sessionScreenRoundIndex + 1)
            let title = NSLocalizedString(titleString, comment: "")
            //let message = NSLocalizedString("resetMessage", comment: "")
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            alert.view.tintColor = Colors.light
            alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
            self.present(alert, animated: true, completion: {
                //
                let delayInSeconds = 0.7
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    alert.dismiss(animated: true, completion: nil)
                }
            })
            
            //
        } else {
            restTime -= 1
            restAlert.setValue(NSAttributedString(string: "\n" + String(describing: restTime), attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-Thin", size: 23)!]), forKey: "attributedMessage")
        }
    }
    
    //
    // Start Timer
    //
    @objc func startTimer() {
        // Dates and Times
        startTime = Date().timeIntervalSinceReferenceDate
        //
        if didSetEndTime == false {
            //
            didSetEndTime = true
            //
            //
            // Rest Timer
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let restTimes = settings["RestTimes"]!
            let duration = restTimes[1]
            let endingTime = Int(startTime) + duration
            //
            endTime = Double(endingTime)
        }
        
        // Set timer value
        restTime = Int(endTime - startTime) - 1
        
        // Check Greater than 0
        if restTime <= 0 {
            restTime = 0
            //
            rowTimer.invalidate()
            self.restAlert.dismiss(animated: true)
            //
            didSetEndTime = false
            //
            // Next Round
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            //
            let indexPath0 = NSIndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: indexPath0 as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
            //
            let cell = self.tableView.cellForRow(at: indexPath0 as IndexPath) as! WorkoutOverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                // 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                if self.isTimedMovement() {
                    cell.timerButton.alpha = 1
                }
                //
                self.updateProgress()
                //
            }, completion: { finished in
                self.tableView.reloadData()
            })
            
            //
            // Alert View
            let titleString = "round" + String(self.sessionScreenRoundIndex + 1)
            let title = NSLocalizedString(titleString, comment: "")
            //let message = NSLocalizedString("resetMessage", comment: "")
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            alert.view.tintColor = Colors.light
            alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
            self.present(alert, animated: true, completion: {
                //
                let delayInSeconds = 0.7
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    alert.dismiss(animated: true, completion: nil)
                }
            })
        }
        
        // Set Timer
        // Set initial time
        restAlert.setValue(NSAttributedString(string: "\n" + String(describing: restTime), attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-Thin", size: 23)!]), forKey: "attributedMessage")
        
        // Begin Timer or dismiss view
        rowTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    //
    // End Round func
    func endRound() {
        // Rest Alert
        //
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let restTimes = settings["RestTimes"]!
        restTime = restTimes[1]
        //
        restMessage = "\n" + String(restTime)
        //
        restAlert.title = restTitle
        restAlert.message = restMessage
        //
        // Timer end Notification
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("timerEnd", comment: "")
        content.body = " "
        content.sound = UNNotificationSound.default()
        //
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(restTime), repeats: false)
        let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
        //
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        // Timer
        startTimer()
        
        // Rest Alert
        restAlert = UIAlertController()
        restAlert.view.tintColor = Colors.dark
        restAlert.setValue(NSAttributedString(string: restTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
        restAlert.setValue(NSAttributedString(string: restMessage, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-Thin", size: 23)!]), forKey: "attributedMessage")
        let skipAction = UIAlertAction(title: NSLocalizedString("skip", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            //
            Vibrate.shared.vibratePhone()

            //
            // Dismiss Alert
            self.restAlert.dismiss(animated: true)
            rowTimer.invalidate()
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timer"])
            
            //
            // Next Round
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            //
            self.selectedRow = 0
            //
            let indexPath0 = NSIndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: indexPath0 as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
            //
            let cell = self.tableView.cellForRow(at: indexPath0 as IndexPath) as! WorkoutOverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                // 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                if self.isTimedMovement() {
                    cell.timerButton.alpha = 1
                }
                //
                self.updateProgress()
                //
            }, completion: { finished in
                self.tableView.reloadData()
            })
            
            //
            // Next Round Alert
            // Alert View
            let titleString = "round" + String(self.sessionScreenRoundIndex + 1)
            let title = NSLocalizedString(titleString, comment: "")
            //let message = NSLocalizedString("resetMessage", comment: "")
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            alert.view.tintColor = Colors.light
            alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
            self.present(alert, animated: true, completion: {
                //
                let delayInSeconds = 0.7
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    alert.dismiss(animated: true, completion: nil)
                }
            })
        }
        self.restAlert.addAction(skipAction)
        //
        self.present(restAlert, animated: true, completion: {
        })
        
    }
    
    
    
    //
    // Tap Handlers, buttons and funcs -------------------------------------------------------------------------------------------------------
    //
    //
    // Image
    @IBAction func handleImageTap(imageTap:UITapGestureRecognizer) {
        //
        // Get Cell
        let sender = imageTap.view as! UIImageView
        let tag = sender.tag
        let indexPath = NSIndexPath(row: tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! WorkoutOverviewTableViewCell
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
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! WorkoutOverviewTableViewCell
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
            cell.imageViewCell.startAnimating()
        }
    }
    
    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        if selectedRow < numberOfMovementsInRound - 1 {
            //
            let indexPath0 = NSIndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath0 as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
            //
            selectedRow = selectedRow + 1
            updateProgress()
            //
            //
            let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
            let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
            let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)
            //
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! WorkoutOverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                // 1
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                if self.isTimedMovement() {
                    cell.timerButton.alpha = 1
                }
                //
                // -1
                cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! WorkoutOverviewTableViewCell
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
                //
                //self.tableView.reloadRows(at: [indexPath2 as IndexPath], with: UITableViewRowAnimation.none)
                
                //
            }, completion: { finished in
                //                self.playAnimation(row: self.selectedRow)
            })
            // + 1
            if selectedRow < numberOfMovementsInRound - 1 {
                tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableViewRowAnimation.none)
            }
            
            // Next Round
            if selectedRow == numberOfMovementsInRound - 1 {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                //
                UIView.animate(withDuration: 0.6, animations: {
                    let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
                    self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
                })
            }
        }
    }
    
    // Back Button
    @IBAction func backButtonAction() {
        
        if selectedRow != 0 {
            //
            selectedRow = selectedRow - 1
            updateProgress()
            //
            let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
            let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
            let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)
            //
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! WorkoutOverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                //
                
                // 1
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                if self.isTimedMovement() {
                    cell.timerButton.alpha = 1
                }
                // - 1
                if self.selectedRow > 0 {
                    cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! WorkoutOverviewTableViewCell
                    cell.indicatorStack.alpha = 0
                    cell.setsRepsLabel.alpha = 0
                    cell.movementLabel.alpha = 0
                    cell.explanationButton.alpha = 0
                    cell.timerButton.alpha = 0
                }
                // + 1
                cell = self.tableView.cellForRow(at: indexPath3 as IndexPath) as! WorkoutOverviewTableViewCell
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
                //
            })
            //
            //
            let indexPath0 = NSIndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath0 as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
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
        
        
        // Scroll View
        scrollViewExplanation.addSubview(explanationLabel)
        scrollViewExplanation.contentSize = CGSize(width: bounds.width, height: explanationLabel.frame.size.height + 20)
        //
        scrollViewExplanation.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        // Add Views
        UIApplication.shared.keyWindow?.addSubview(backgroundViewExplanation)
        UIApplication.shared.keyWindow?.addSubview(scrollViewExplanation)
        
        //
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.scrollViewExplanation.center.y = (((bounds.height - 20)/2) * 1.5) + 20
            self.backgroundViewExplanation.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract Explanation
    @IBAction func retractExplanation(_ sender: Any) {
        let bounds = UIScreen.main.bounds
        //
        UIView.animate(withDuration: AnimationTimes.animationTime2, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
                alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
                //
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .natural
                alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
                
                //
                // Action
                let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertActionStyle.default) {
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
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! WorkoutOverviewTableViewCell
        //
        let key = keyArray[indexPath.row]
        let imageCount = ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"])?.count)!
        //
        if cell.imageViewCell.isAnimating == false {
            //
            switch extraSwipe.direction {
            //
            case UISwipeGestureRecognizerDirection.left:
                //
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
            case UISwipeGestureRecognizerDirection.right:
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
            // ((sessionScreenRoundIndex * 3) + sessionScreenRoundIndex) accounts for the current round
        let currentPose = Float((sessionScreenRoundIndex * 3) + sessionScreenRoundIndex + selectedRow)
        // Total Number Poses
        let totalPoses = Float(keyArray.count - 1)
        
        //
        //
        let currentProgress = currentPose / totalPoses
        progressBar.setProgress(currentProgress, animated: true)
    }
    //
    
    // Check whether timed movement
    func isTimedMovement() -> Bool {
        let setsRepsString = repsArray[selectedRow]
        // seconds/breaths
        if setsRepsString.hasSuffix("s") {
            return true
        } else {
            return false
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
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        //
        // Action
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            //
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["restTimer"])
            
            //
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        //
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        //
        self.present(alert, animated: true, completion: nil)
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
    var walkthroughTexts = ["session0C", "session2", "session3", "session4", "session5"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    var highlightColor = UIColor()
    //
    
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
                y: tableView.frame.maxY - WalkthroughVariables.topHeight - walkthroughLabel.frame.size.height - 13 - WalkthroughVariables.twicePadding,
                width: view.frame.size.width - 26,
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
                let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! WorkoutOverviewTableViewCell
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
            
        // Demonstration (+ target area)
        case 1:
            //
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! WorkoutOverviewTableViewCell
            highlightSize = cell.indicatorStack.frame.size
            highlightCenter = cell.indicatorStack.center
            highlightCenter?.y += toAdd
            //
            highlightCornerRadius = 0
            // Top of view
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)

            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Explanation
        case 2:
            //
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! WorkoutOverviewTableViewCell
            highlightSize = cell.explanationButton.frame.size
            highlightCenter = cell.explanationButton.center
            highlightCenter?.y += toAdd
            //
            highlightCornerRadius = 0
            // Top
            labelFrame = 0
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
        case 3:
            //
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! WorkoutOverviewTableViewCell
            highlightSize = cell.explanationButton.frame.size
            highlightCenter = cell.explanationButton.center
            highlightCenter?.y += toAdd
            //
            highlightCornerRadius = 0
            // Top
            labelFrame = 0
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
        case 4:
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
                walkthroughs["Session2"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            })
        }
    }
    //
}

