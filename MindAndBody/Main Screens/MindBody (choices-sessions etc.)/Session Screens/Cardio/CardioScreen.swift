//
//  CardioScreen.swift
//  MindAndBody
//
//  Created by Luke Smith on 30.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import AVFoundation


//
// Cardio Tableview Cell ---------------------------------------------------------------------------
//
// Cardio TableView Cell
class CardioTableViewCell: UITableViewCell {
    // DetailLabel (Time/Distance)
    @IBOutlet weak var detailLabel: UILabel!
    // Title Label
    @IBOutlet weak var movementLabel: UILabel!
}

//
var timerCountDown2 = Timer()

//
// Cardio Screen Class ------------------------------------------------------------------------------------
//
class CardioScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate {
    
    
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
    
    // Length
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] length array
    var lengthArray: [Int] = []
    
    
    // Distance based or time based, 0 = time based, 1 = distance based
    var sessionType = Int()
    
    
    // Bells Arrays
    let bellsArray: [String] =
        ["Tibetan Chimes", "Tibetan Singing Bowl (Low)", "Tibetan Singing Bowl (Low)(x4)", "Tibetan Singing Bowl (Low)(Singing)", "Tibetan Singing Bowl (High)", "Tibetan Singing Bowl (High)(x4)", "Tibetan Singing Bowl (High)(Singing)", "Australian Rain Stick", "Australian Rain Stick (x2)", "Australian Rain Stick (2 sticks)", "Wind Chimes", "Gambang (Wood)(Up)", "Gambang (Wood)(Down)", "Gambang (Metal)", "Indonesian Frog", "Cow Bell (Small)", "Cow Bell (Big)"]
    
    var soundPlayer: AVAudioPlayer!

    
    //
    // Outlets -----------------------------------------------------------------------------------------------------------
    // Progress Bar
    let progressBar = UIProgressView()
    
    // Table view
    @IBOutlet weak var tableView: UITableView!
    
    // Cancel Button
    @IBOutlet weak var cancelButton: UIButton!
    
    
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
                if self.sessionType == 0 {
                    self.startAllTimers()
                } else {
                    self.startTimer()
                }
            }
        })
    }
    
    //
    // View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        view.backgroundColor = Colors.dark
        //
        // Set current notification center to self to handle playing sound
        UNUserNotificationCenter.current().delegate = self
        
        //
        // Custom?
        if fromCustom == false {
            // Loop session
            for i in 0..<(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?.count)! {
                keyArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["movement"] as! String)
                lengthArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["time"] as! Int)
            }
        } else {
            // Time based
            sessionType = 0
        }
        
        //
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
        
        // Cancel Button
        cancelButton.tintColor = Colors.red
        
        //
        // Watch for enter foreground
        switch sessionType {
        //
        case 0:
            NotificationCenter.default.addObserver(self, selector: #selector(startAllTimers), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(enterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        case 1:
            NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        default: break
        }
        
    }
    
    //
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardioTableViewCell", for: indexPath) as! CardioTableViewCell
            //
            let key = keyArray[indexPath.row]
            
            // Cell
            //
            cell.backgroundColor = Colors.dark
            cell.tintColor = Colors.dark
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //
            cell.selectionStyle = .none
            
            // Next Swipe
            let nextSwipe = UISwipeGestureRecognizer()
            nextSwipe.direction = .up
            nextSwipe.addTarget(self, action: #selector(nextButtonAction))
            cell.addGestureRecognizer(nextSwipe)
            
            // Movement
            //
            cell.movementLabel.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0] , comment: "")
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-light", size: 33)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = Colors.light
            cell.movementLabel?.numberOfLines = 0
            cell.movementLabel?.lineBreakMode = .byWordWrapping
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            
            // Timer / Distance info
            //
            cell.detailLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 72)
            cell.detailLabel.textColor = Colors.light
            //
            switch sessionType {
            case 0:
                if indexPath.row == selectedRow {
                    //
                    if selectedRow != 0 {
                        cell.detailLabel.text = timeFormatted(totalSeconds: lengthArray[indexPath.row])
                    } else {
                        cell.detailLabel.text = timeFormattedNicely(totalSeconds: lengthArray[indexPath.row])
                    }
                } else {
                    //
                    cell.detailLabel.text = timeFormattedNicely(totalSeconds: lengthArray[indexPath.row])
                }
            case 1:
                // Even IndexPath.rows (movement)
                if indexPath.row % 2 == 0 {
                    //
                    cell.detailLabel.text = String(lengthArray[indexPath.row]) + "m"
                    //
                    if indexPath.row == selectedRow {
                        cell.addGestureRecognizer(nextSwipe)
                    }
                    //
                    // Odd IndexPath.rows (pauses)
                } else {
                    if indexPath.row == selectedRow {
                        cell.detailLabel.text = timeFormatted(totalSeconds: lengthArray[indexPath.row])
                        startTimer()
                    } else {
                        cell.detailLabel.text = timeFormattedNicely(totalSeconds: lengthArray[indexPath.row])
                        //
                        if indexPath.row == selectedRow + 1 {
                            cell.addGestureRecognizer(nextSwipe)
                        }
                    }
                    //
                }
            default: break
            }
            
            //
            switch indexPath.row {
            case selectedRow - 1:
                cell.movementLabel.alpha = 0
            //
            case selectedRow:
                cell.movementLabel.alpha = 1
            //
            case selectedRow + 1:
                //
                cell.movementLabel.alpha = 1
            //
            default:
                //
                cell.movementLabel.alpha = 1
            }
            
            return cell
        //
        case 1:
            //
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            //
            cell.separatorInset =  UIEdgeInsetsMake(0, 0, 0, 0)
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
            var toMinus = CGFloat()
            if IPhoneType.shared.iPhoneType() == 2 {
                toMinus = TopBarHeights.statusBarHeight + 2 + 34
            } else {
                toMinus = TopBarHeights.statusBarHeight + 2
            }
            switch indexPath.row {
            case selectedRow - 1, selectedRow, currentIndex - 1, currentIndex:
                return (UIScreen.main.bounds.height - toMinus) * 3/4
            case selectedRow + 1, currentIndex + 1:
                return (UIScreen.main.bounds.height - toMinus) * 1/4
            default:
                return (UIScreen.main.bounds.height - toMinus) * 1/4
            }
        //
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
        case 1:
            //
            // Schedule Tracking
            updateScheduleTracking(fromSchedule: fromSchedule)
            // Cancel notificaitons
            if self.sessionType == 0 {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: self.arrayOfNotifications)
            } else {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timer"])
            }
            // Dismiss
            self.dismiss(animated: true)
        //
        default: break
        }
    }
    
    
    
    
    //
    // Functions -------------------------------------------------------------------------------------------------------
    //
    //
    // Time Formatted
    func timeFormattedNicely(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        if minutes < 1 {
            if seconds < 10 {
                return String(format: "%01ds", seconds)
            } else {
                return String(format: "%02ds", seconds)
            }
        } else {
            if minutes < 10 {
                if seconds == 0 {
                    return String(format: "%01dmin", minutes)
                } else if seconds < 10 {
                    return String(format: "%01dmin %01ds", minutes, seconds)
                } else {
                    return String(format: "%01dmin %02ds", minutes, seconds)
                }
            } else {
                if seconds == 0 {
                    return String(format: "%02dmin", minutes)
                } else if seconds < 10 {
                    return String(format: "%02dmin %01ds", minutes, seconds)
                } else {
                    return String(format: "%02dmin %02ds", minutes, seconds)
                }
            }
        }
    }
    
    
    
    
    //
    // 0 -------------------------------------------------------------------------------------------------------
    //
    
    // Next Button
    @IBAction func nextButtonAction2() {
        //
        //
        if currentIndex < keyArray.count {
            //
            didSetEndTime2 = false
            //
            updateProgress2()
            //
            //
            let indexPath = NSIndexPath(row: currentIndex, section: 0)
            //
            if didEnterBackground != true {
                UIView.animate(withDuration: 0.6, animations: {
                    //
                    //
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                    //
                    self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
                    //
                }, completion: { finished in
                })
            } else {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
                //
                didSetEndTime2 = false
                self.startTimer2()
                //
                didEnterBackground = false
            }
        }  else {
        }
    }
    
    
    //
    var didEnterBackground = false
    //
    @objc func enterBackground() {
        didSetEndTime2 = false
        didEnterBackground = true
    }
    
    // Handle foreground notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Update the app interface directly.
        vibratePhone()
        // Play a sound.
        completionHandler(UNNotificationPresentationOptions.sound)
    }
    
    
    //
    // Time Base
    //
    //
    var sessionLength = Int()
    //
    var arrayOfNotifications: [String] = []
    // Array of times to perform actions (next movement)
    var arrayOfTimes: [Int] = []
    var currentIndex = Int() // Essentially the same as selected row but works on index of arrayoftimes
    // Session timer
    var timerValue2 = Int()
    //
    var didSetNotifications = false
    //
    var firstCall = true
    //
    var testValue = Double()
    var timerValue2Remainder = Double()
    
    //
    var task1: DispatchWorkItem?
    // Next button actions (thus vibrations that need to be cancelled if finish early)
    var task2: DispatchWorkItem?

    //
    //
    @objc func startAllTimers() {
        //
        startTime = Date().timeIntervalSinceReferenceDate
        
        //
        sessionLength = lengthArray.reduce(0, +)
        //
        if didSetEndTime == false {
            //
            endTime = startTime + TimeInterval(sessionLength)
            didSetEndTime = true
        }
        //
        if endTime > startTime {
            testValue = endTime - startTime
            timerValue2Remainder = testValue.truncatingRemainder(dividingBy: 1)
            timerValue2 = Int(endTime - startTime)
        } else {
            timerValue2 = 0
        }
        
        //
        // Create Notifications
        if didSetNotifications == false {
            didSetNotifications = true
            for i in 1...keyArray.count {
                //
                let content = UNMutableNotificationContent()
                if i != keyArray.count {
                    content.title = NSLocalizedString("begin", comment: "") + " " + NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![keyArray[i]]!["name"]![0], comment: "")
                    // Sound, low if pause, high if start cardio
                    // All high intensity is even
                    if i % 2 == 0 {
                        // High == doing something
                        content.sound = UNNotificationSound(named: "Tibetan Singing Bowl (High).caf")
                    // All low intensity is odd
                    } else {
                        // Low == rest
                        content.sound = UNNotificationSound(named: "Tibetan Singing Bowl (Low).caf")
                    }
                } else {
                    content.title = NSLocalizedString("cardioEnd", comment: "")
                    // Sound
                    content.sound = UNNotificationSound(named: "Tibetan Singing Bowl (Low).caf")
                }
                content.body = " "
                
                // Reduce session length (used for setting notification time)
                sessionLength -= lengthArray[i - 1]
                //
                arrayOfTimes.append(sessionLength)
                //
                let timeToTrigger = (endTime - startTime) - Double(sessionLength)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeToTrigger, repeats: false)
                //
                let identifier = "timer" + String(i)
                arrayOfNotifications.append(identifier)
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                //
            }
        }
        
        //
        if timerValue2 != 0 {
            //
            task1 = DispatchWorkItem {
                timerCountDown2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer2), userInfo: nil, repeats: true)
            }
            //
            let delayInSeconds = timerValue2Remainder
            let dispatchTime = DispatchTime.now() + delayInSeconds
            DispatchQueue.main.asyncAfter(deadline:  dispatchTime, execute: task1!)
            //
        } else
            if timerValue2 == 0 {
                self.dismiss(animated: true)
        }
        
        //
        // Start Timer 2
        if firstCall {
            startTimer2()
            firstCall = false
        }
        //
        // Background task
        task2 = DispatchWorkItem {
            if self.didEnterBackground {
                //
                // new current index
                let currentIndexCheck = self.currentIndex
                for i in self.arrayOfTimes {
                    if (self.timerValue2 - i) > 0 {
                        self.currentIndex = Int(self.arrayOfTimes.index(of: i)!)
                        if currentIndexCheck != self.currentIndex {
                            self.timerShapeLayer.removeAllAnimations()
                            self.timerShapeLayer.removeFromSuperlayer()
                        }
                        self.nextButtonAction2()
                        break
                    }
                }
            }
        }
        let delayInSeconds = timerValue2Remainder
        let dispatchTime = DispatchTime.now() + delayInSeconds
        DispatchQueue.main.asyncAfter(deadline:  dispatchTime, execute: task2!)
    }
    
    //
    @objc func updateTimer2() {
        if timerValue2 != 0 {
            timerValue2 -= 1
        } else {
            timerCountDown2.invalidate()
            self.dismiss(animated: true)
        }
        
        // Perform Actions
        if arrayOfTimes.contains(timerValue2) {
            if timerCountDown.isValid {
                timerCountDown.invalidate()
            }
            currentIndex = Int(arrayOfTimes.index(of: timerValue2)!) + 1
            if animationAdded {
                timerShapeLayer.removeAllAnimations()
                timerShapeLayer.removeFromSuperlayer()
                animationAdded = false
            }
            nextButtonAction2()
            startTimer2()
        }
    }
    
    
    
    // Local Timer
    //
    var didSetEndTime2 = false
    var startTime2 = Double()
    var endTime2 = Double()
    //
    func startTimer2() {
        //
        if timerCountDown.isValid {
            timerCountDown.invalidate()
        }
        //
        startTime2 = Double(timerValue2)
        //startTime2 = Date().timeIntervalSinceReferenceDate
        //
        if didSetEndTime2 == false {
            if didEnterBackground {
                endTime2 = startTime2 + (Double(timerValue2) - Double(arrayOfTimes[currentIndex]))
            } else {
                endTime2 = startTime2 + TimeInterval(lengthArray[currentIndex])
            }
            //
            didSetEndTime2 = true
        }
        //
        if endTime2 > startTime2 {
            timerValue = Int(endTime2 - startTime2)
        } else {
            timerValue = 0
        }
        
        //
        if timerValue != 0 && timerValue2 != 0  {
            //
            let indexPath = NSIndexPath(row: currentIndex, section: 0)
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CardioTableViewCell
            
            //
            cell.detailLabel.text = timeFormatted(totalSeconds: timerValue)
            
            //
            if animationAdded == false {
                self.addCircle2()
                self.startAnimation()
            }
            timerCountDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer3), userInfo: nil, repeats: true)
            
        }
    }
    
    
    
    // Update Timer
    @objc func updateTimer3() {
        //
        let indexPath = NSIndexPath(row: currentIndex, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CardioTableViewCell
        //
        //
        if timerValue == 0 {
            cell.detailLabel.text = timeFormatted(totalSeconds: timerValue)
            //
        } else {
            timerValue -= 1
            //
            cell.detailLabel.text = timeFormatted(totalSeconds: timerValue)
        }
    }
    
    
    
    //
    // 1 -------------------------------------------------------------------------------------------------------
    //
    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        //
        if selectedRow < keyArray.count - 1 {
            //
            selectedRow = selectedRow + 1
            //
            didSetEndTime = false
            didSetEndTime2 = false
            
            updateProgress()
            //
            //
            let indexPath = NSIndexPath(row: selectedRow, section: 0)
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
            }, completion: { finished in
                self.tableView.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
            })
        }  else {
        }
    }
    
    
    //
    var didSetEndTime = false
    var startTime = Double()
    var endTime = Double()
    //
    @objc func startTimer() {
        //
        var key = keyArray[selectedRow]
        
        // Movement
        if sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["isMovement"]![0] == "true" {

        // Pauses
        } else {
            
            //
            startTime = Date().timeIntervalSinceReferenceDate
            //
            if didSetEndTime == false {
                endTime = startTime + TimeInterval(lengthArray[selectedRow])
                //
                didSetEndTime = true
            }
            //
            if endTime > startTime {
                timerValue = Int(endTime - startTime)
            } else {
                timerValue = 0
            }
            
            
            //
            if timerValue != 0 {
                //
                let indexPath = NSIndexPath(row: selectedRow, section: 0)
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CardioTableViewCell
                
                //
                cell.detailLabel.text = timeFormatted(totalSeconds: timerValue)
                
                //
                if animationAdded == false {
                    self.addCircle()
                    self.startAnimation()
                }
                timerCountDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
                
                //
                let content = UNMutableNotificationContent()
                switch sessionType {
                case 0:
                    if selectedRow != keyArray.count - 1 {
                        key = keyArray[selectedRow + 1]
                        content.title = NSLocalizedString("begin", comment: "") + " " + NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["movement"]![0], comment: "")
                    } else {
                        content.title = NSLocalizedString("cardioEnd", comment: "")
                    }
                case 1:
                    if selectedRow != keyArray.count - 1 {
                        key = keyArray[selectedRow + 1]
                        content.title = NSLocalizedString("begin", comment: "") + " " + NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["movement"]![0], comment: "") + " " + String(lengthArray[selectedRow + 1]) + "m"
                    } else {
                        content.title = NSLocalizedString("cardioEnd", comment: "")
                    }
                default: break
                }
                
                content.body = " "
                content.sound = UNNotificationSound.default()
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(self.timerValue), repeats: false)
                let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            } else if timerValue == 0 {
                nextButtonAction()
                if animationAdded {
                    timerShapeLayer.removeAllAnimations()
                    timerShapeLayer.removeFromSuperlayer()
                    animationAdded = false
                }
            }
            
        }
    }
    
    
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
    
    // Update Progress
    func updateProgress2() {
        // Current Pose
        let currentPose = Float(currentIndex)
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
    
    
    var timerValue = Int()
    
    // Timer CountDown Title
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Update Timer
    @objc func updateTimer() {
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CardioTableViewCell
        //
        //
        if timerValue == 0 {
            if selectedRow < (keyArray.count - 1) {
                timerCountDown.invalidate()
                removeCircle()
                nextButtonAction()
                if animationAdded {
                    timerShapeLayer.removeAllAnimations()
                    timerShapeLayer.removeFromSuperlayer()
                    animationAdded = false
                }
            } else {
                self.dismiss(animated: true)
            }
            //
        } else if timerValue == 1 {
            timerValue -= 1
            cell.detailLabel.text = timeFormatted(totalSeconds: timerValue)
            //
        } else {
            timerValue -= 1
            cell.detailLabel.text = timeFormatted(totalSeconds: timerValue)
        }
    }
    
    // Cancel tasks
    func cancelTasks() {
        // Cancel Dispatch of next actions (and thus vibrations)
        if task2 != nil {
            task2?.cancel()
        }
        if task1 != nil {
            task1?.cancel()
        }
    }
    
    
    
    //
    // Circle -------------------------------------------------------------------------------------------------------------------------
    //
    var timerShapeLayer: CAShapeLayer!
    // Funcs
    func addCircle() {
        //
        let indexPath2 = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath2 as IndexPath) as! CardioTableViewCell
        
        var center = CGPoint()
        if selectedRow != keyArray.count - 1 {
            center = CGPoint(x: cell.detailLabel.center.x, y: cell.detailLabel.center.y + 22)
        } else {
            let centery = (view.frame.size.height - 49 - cell.frame.size.height) + cell.detailLabel.center.y
            
            center = CGPoint(x: cell.detailLabel.center.x, y: centery)
        }
        //
        let radius = ((cell.frame.size.width - 50) / 2)
        //}
        //
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: .pi * 1.5, endAngle: (.pi * 2) + (.pi * 1.5), clockwise: true)
        //let circlePath = UIBezierPath(arcCenter: cell.center, radius: CGFloat(20), startAngle: .pi, endAngle: .pi, clockwise: true)
        timerShapeLayer = CAShapeLayer()
        timerShapeLayer.path = circlePath.cgPath
        timerShapeLayer.fillColor = UIColor.clear.cgColor
        timerShapeLayer.strokeColor = Colors.light.cgColor
        timerShapeLayer.lineWidth = 2.0
        
        //
        timerShapeLayer.strokeEnd = 0.0
        
        
        view.layer.addSublayer(timerShapeLayer)
        //cell.layer.addSublayer(timerShapeLayer)
    }
    
    //
    func addCircle2() {
        //
        let indexPath2 = NSIndexPath(row: currentIndex, section: 0)
        let cell = tableView.cellForRow(at: indexPath2 as IndexPath) as! CardioTableViewCell
        
        var center = CGPoint()
        if currentIndex != keyArray.count - 1 {
            center = CGPoint(x: cell.detailLabel.center.x, y: cell.detailLabel.center.y + 22)
        } else {
            let centery = (view.frame.size.height - 49 - cell.frame.size.height) + cell.detailLabel.center.y
            
            center = CGPoint(x: cell.detailLabel.center.x, y: centery)
        }
        //
        let radius = ((cell.frame.size.width - 50) / 2)
        //}
        //
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: .pi * 1.5, endAngle: (.pi * 2) + (.pi * 1.5), clockwise: true)
        //let circlePath = UIBezierPath(arcCenter: cell.center, radius: CGFloat(20), startAngle: .pi, endAngle: .pi, clockwise: true)
        timerShapeLayer = CAShapeLayer()
        timerShapeLayer.path = circlePath.cgPath
        timerShapeLayer.fillColor = UIColor.clear.cgColor
        timerShapeLayer.strokeColor = Colors.light.cgColor
        timerShapeLayer.lineWidth = 2.0
        
        //
        timerShapeLayer.strokeEnd = 0.0
        
        
        view.layer.addSublayer(timerShapeLayer)
        //cell.layer.addSublayer(timerShapeLayer)
    }
    
    
    //
    func removeCircle() {
        timerShapeLayer.removeFromSuperlayer()
    }
    
    //
    var animationAdded = false
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = Double(timerValue)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        timerShapeLayer.strokeEnd = 1.0
        //
        timerShapeLayer.add(animation, forKey: "circleAnimation")
        animationAdded = true
        
    }
    
    
    
    //
    // Cancel --------------------
    //
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        // Invalidate
        
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
            self.cancelTasks()
            
            //
            if timerCountDown.isValid {
                timerCountDown.invalidate()
            }
            //
            if self.animationAdded {
                self.timerShapeLayer.removeAllAnimations()
                self.timerShapeLayer.removeFromSuperlayer()
            }
            //
            if self.sessionType == 0 {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: self.arrayOfNotifications)
            } else {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timer"])
            }
            
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
}

