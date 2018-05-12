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
    
}


// Overview End Cell
class EndRoundTableViewCell: UITableViewCell {
    // Title Label
    @IBOutlet weak var titleLabel: UILabel!
}


//
// Session Screen Overview Class ------------------------------------------------------------------------------------
//
class CircuitWorkoutScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    // Progress Bar
    let progressBar = UIProgressView()
    
    //
    @IBOutlet weak var finishEarly: UIButton!
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Session Started
        //
        // Alert View
        let title = NSLocalizedString("sessionStarted", comment: "")
        //let message = NSLocalizedString("resetMessage", comment: "")
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.tintColor = Colors.light
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
        self.present(alert, animated: true, completion: {
            //
            let delayInSeconds = 0.7
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                alert.dismiss(animated: true, completion: nil)
                //
                // MARK: Walkthrough
                let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                if walkthroughs["Session2"] == false {
                    self.walkthroughSession()
                }
            }
        })
        
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
        default: break
        }
        
        //
        view.backgroundColor = Colors.dark
        
        
        //
        finishEarly.tintColor = Colors.red
        
        
        // self.present(alert, animated: true, completion: (() -> Void)?)
        
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
            cell.movementLabel.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0] , comment: "")
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 23)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            //
            // Set and Reps
            // (numberOfMovementsInRound * sessionScreenRoundIndex) = first index of round
            let indexRow = (numberOfMovementsInRound * sessionScreenRoundIndex) + indexPath.row
            cell.setsRepsLabel?.text = repsArray[indexRow]
            cell.setsRepsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.setsRepsLabel?.textAlignment = .right
            cell.setsRepsLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
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
                cell.setsRepsLabel?.text = repsString
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
            var toMinus = CGFloat()
            if IPhoneType.shared.iPhoneType() == 2 {
                toMinus = TopBarHeights.statusBarHeight + 2 + 34
            } else {
                toMinus = TopBarHeights.statusBarHeight + 2
            }
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
                updateScheduleTracking(fromSchedule: fromSchedule)
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
            timerCountDown.invalidate()
            self.restAlert.dismiss(animated: true)
            //
            didSetEndTime = false
            //
            vibratePhone()
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
            timerCountDown.invalidate()
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
        timerCountDown = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
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
            self.vibratePhone()

            //
            // Dismiss Alert
            self.restAlert.dismiss(animated: true)
            timerCountDown.invalidate()
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
            if cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") {
                if imageCount != 1 {
                    sender.startAnimating()
                }
            }
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
            if cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") {
                if imageCount != 1 {
                    cell.imageViewCell.startAnimating()
                }
            }
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
        scrollViewExplanation.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
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
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
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
                if cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImageDot") || cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") {
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
                if cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImageDotDeselected") || cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlayDeselected") {
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
    var walkthroughLabel = UILabel()
    var nextButton = UIButton()
    
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["session0", "session1", "session3", "session4", "session5", "session6", "session7", "session8", "session9", "session102", "session11"]
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
    
    // Walkthrough
    @objc func walkthroughSession() {
        //
        var toMinus = CGFloat()
        if IPhoneType.shared.iPhoneType() == 2 {
            toMinus = TopBarHeights.statusBarHeight + 2 + 34
        } else {
            toMinus = TopBarHeights.statusBarHeight + 2
        }
        let cellHeight = (UIScreen.main.bounds.height - toMinus) * 3/4
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughSession), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Movement
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = Colors.dark
            walkthroughLabel.backgroundColor = Colors.light
            walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.light.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width / 2, height: 36)
            walkthroughHighlight.center = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight / 2) * (28/16)) + 2)
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Sets x Reps
        case 1:
            //
            highlightSize = CGSize(width: view.bounds.width / 3, height: 33)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight / 2) * (30/16)) + 2)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Demonstration
        case 2:
            //
            highlightSize = CGSize(width: view.bounds.width * (7/8), height: (cellHeight * (13/16)))
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight * (13/16)) / 2) + 2)
            highlightCornerRadius = 3
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Indicator
        case 3:
            //
            highlightSize = CGSize(width: 30, height: 15)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + 2 + ((cellHeight * (13/16))) - (15 / 2))
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
            
        // Target Area
        case 4:
            // Swipe demonstration
            let leftSwipe = UIView()
            leftSwipe.frame.size = CGSize(width: 50, height: 50)
            leftSwipe.backgroundColor = Colors.light
            leftSwipe.layer.cornerRadius = 25
            leftSwipe.clipsToBounds = true
            leftSwipe.center.y = TopBarHeights.statusBarHeight + ((cellHeight * (3/4)) / 2) + 2
            leftSwipe.center.x = view.bounds.width * (7/8)
            UIApplication.shared.keyWindow?.insertSubview(leftSwipe, aboveSubview: walkthroughView)
            // Perform swipe action
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                let leftSwipeSimulate = UISwipeGestureRecognizer()
                leftSwipeSimulate.direction = .left
                self.handleSwipes(extraSwipe: leftSwipeSimulate)
            })
            // Animate swipe demonstration
            nextButton.isEnabled = false
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                leftSwipe.center.x = self.view.bounds.width * (1/8)
                //
            }, completion: { finished in
                self.nextButton.isEnabled = true
                //
                leftSwipe.removeFromSuperview()
                
                //
                self.highlightSize = CGSize(width: self.view.bounds.width * (7/8), height: (cellHeight * (13/16)))
                self.highlightCenter = CGPoint(x: self.view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight * (13/16)) / 2) + 2)
                self.highlightCornerRadius = 3
                //
                self.labelFrame = 0
                //
                self.walkthroughBackgroundColor = Colors.light
                self.walkthroughTextColor = Colors.dark
                self.highlightColor = Colors.light
                //
                self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.highlightColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                
                //
                self.walkthroughProgress = self.walkthroughProgress + 1
            })
            
            
        // Return to demonstration and Explanation
        case 5:
            //
            highlightSize = CGSize(width: 30, height: 15)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + 2 + ((cellHeight * (13/16))) - (15 / 2))
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            //
            self.walkthroughProgress = self.walkthroughProgress + 1
            
            //
            // Swipe demonstration
            nextButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                //
                let rightSwipe = UIView()
                rightSwipe.frame.size = CGSize(width: 50, height: 50)
                rightSwipe.backgroundColor = Colors.light
                rightSwipe.layer.cornerRadius = 25
                rightSwipe.clipsToBounds = true
                rightSwipe.center.y = TopBarHeights.statusBarHeight + ((cellHeight * (3/4)) / 2) + 2
                rightSwipe.center.x = self.view.bounds.width * (1/8)
                UIApplication.shared.keyWindow?.insertSubview(rightSwipe, aboveSubview: self.walkthroughView)
                // Perform swipe action
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                    let rightSwipeSimulate = UISwipeGestureRecognizer()
                    rightSwipeSimulate.direction = .right
                    self.handleSwipes(extraSwipe: rightSwipeSimulate)
                })
                // Animate swipe demonstration
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    //
                    rightSwipe.center.x = self.view.bounds.width * (7/8)
                    //
                }, completion: { finished in
                    self.nextButton.isEnabled = true
                    //
                    rightSwipe.removeFromSuperview()
                    
                    //
                    self.highlightSize = CGSize(width: 45, height: 45)
                    self.highlightCenter = CGPoint(x: self.view.bounds.width - 25 - 2.5, y: TopBarHeights.statusBarHeight + cellHeight - 25 - 2.5)
                    self.highlightCornerRadius = 0
                    //
                    self.labelFrame = 0
                    //
                    self.walkthroughBackgroundColor = Colors.light
                    self.walkthroughTextColor = Colors.dark
                    self.highlightColor = Colors.light
                    //
                    self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.highlightColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                    
                    //
                    self.walkthroughProgress = self.walkthroughProgress + 1
                })
            })
            
            
            // Explanation open and Next Movement
        // Case 7 not 6 as + 1 to walkthroughprogress twice in case 5 for label reasons (need an empty label)
        case 7:
            backgroundViewExplanation.isEnabled = false
            expandExplanation()
            //
            highlightSize = CGSize(width: 45, height: 45)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + (view.bounds.height / 2))
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = .clear
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            //
            self.walkthroughProgress = self.walkthroughProgress + 1
            //
            // Next Movement
            nextButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2, execute: {
                //
                self.nextButton.isEnabled = true
                self.backgroundViewExplanation.isEnabled = true
                //
                self.retractExplanation(self)
                
                //
                self.highlightSize = CGSize(width: self.view.bounds.width, height: 4)
                self.highlightCenter = CGPoint(x: self.view.bounds.width / 2, y: TopBarHeights.statusBarHeight + 1)
                self.highlightCornerRadius = 0
                //
                self.labelFrame = 0
                //
                self.walkthroughBackgroundColor = Colors.light
                self.walkthroughTextColor = Colors.dark
                self.highlightColor = .clear
                //
                self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.highlightColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                //
                self.walkthroughProgress = self.walkthroughProgress + 1
            })
            
            
            // Progress
        // Case 9 not 8 as + 1 to walkthroughprogress twice in case 7 for label reasons (need an empty label)
        case 9:
            //
            walkthroughLabel.alpha = 0
            //
            // Swipe demonstration
            nextButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                //
                let upSwipe = UIView()
                upSwipe.frame.size = CGSize(width: 50, height: 50)
                upSwipe.backgroundColor = Colors.light
                upSwipe.layer.cornerRadius = 25
                upSwipe.clipsToBounds = true
                upSwipe.center.y = TopBarHeights.statusBarHeight + (cellHeight * (7/8)) + 2
                upSwipe.center.x = self.view.bounds.width / 2
                UIApplication.shared.keyWindow?.insertSubview(upSwipe, aboveSubview: self.walkthroughView)
                // Perform swipe action
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                    self.nextButtonAction()
                })
                // Animate swipe demonstration
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    //
                    upSwipe.center.y = TopBarHeights.statusBarHeight + (cellHeight * (1/8)) + 2
                    //
                }, completion: { finished in
                    self.nextButton.isEnabled = true
                    //
                    upSwipe.removeFromSuperview()
                    //
                    self.walkthroughLabel.alpha = 1
                    //
                    self.highlightSize = CGSize(width: self.view.bounds.width, height: 8)
                    self.highlightCenter = CGPoint(x: self.view.bounds.width / 2, y: TopBarHeights.statusBarHeight + 1)
                    self.highlightCornerRadius = 0
                    //
                    self.labelFrame = 0
                    //
                    self.walkthroughBackgroundColor = Colors.light
                    self.walkthroughTextColor = Colors.dark
                    self.highlightColor = Colors.light
                    //
                    self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.highlightColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                    //
                    self.walkthroughProgress = self.walkthroughProgress + 1
                    
                })
            })
            
            
        // Finish Early
        case 10:
            //
            highlightSize = CGSize(width: 36, height: 36)
            highlightCenter = CGPoint(x: 27, y: TopBarHeights.statusBarHeight + 2 + 5 + 22)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            //
            
            
        //
        default:
            //
            backButtonAction()
            //
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                walkthroughs["Session2"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["walkthroughs"])
            })
        }
    }
    //
}

