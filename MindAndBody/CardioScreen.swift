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
class CardioScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //
    // Variables
    var selectedRow = 0
    
    //
    // MARK: Variables from Session Data
    //
    // Key Array
    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [1] Keys Array
    var keyArray = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[1] as! [Int]
    
    // Length
    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [2] length array
    var lengthArray = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[2] as! [Int]
    
    
    // Distance based or time based, 0 = time based, 1 = distance based
    var sessionType = Int()
    

    // Bells Arrays
    let bellsArray: [String] =
        ["Tibetan Chimes", "Tibetan Singing Bowl (Low)", "Tibetan Singing Bowl (Low)(x4)", "Tibetan Singing Bowl (Low)(Singing)", "Tibetan Singing Bowl (High)", "Tibetan Singing Bowl (High)(x4)", "Tibetan Singing Bowl (High)(Singing)", "Australian Rain Stick", "Australian Rain Stick (x2)", "Australian Rain Stick (2 sticks)", "Wind Chimes", "Gambang (Wood)(Up)", "Gambang (Wood)(Down)", "Gambang (Metal)", "Indonesian Frog", "Cow Bell (Small)", "Cow Bell (Big)"]
    
    
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
        alert.view.tintColor = colour1
        alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
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
        //
        view.backgroundColor = colour2
        
        
        
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        
        // Rounded Edges
        // Colour
        progressBar.trackTintColor = colour1
        progressBar.progressTintColor = colour3
        //
        progressBar.setProgress(0, animated: true)
        
        // TableView Background
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        //
        tableView.backgroundView = tableViewBackground
        //
        tableView.tableFooterView = UIView()
        
        // Cancel Button
        cancelButton.tintColor = colour4
        
        //
        // Watch for enter foreground
        switch sessionType {
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
        header.contentView.backgroundColor = colour1
        
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
            cell.backgroundColor = colour2
            cell.tintColor = colour2
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //
            cell.selectionStyle = .none
            
            // Movement
            //
            cell.movementLabel.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][key]!, comment: "")
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = colour1
            cell.movementLabel?.numberOfLines = 0
            cell.movementLabel?.lineBreakMode = .byWordWrapping
            cell.movementLabel?.adjustsFontSizeToFitWidth = true

            
            //
            // Next Swipe
            let nextSwipe = UISwipeGestureRecognizer()
            nextSwipe.direction = .up
            nextSwipe.addTarget(self, action: #selector(nextButtonAction))
            
            
            // Timer / Distance info
            //
            cell.detailLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 72)
            cell.detailLabel.textColor = colour1
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "EndTableViewCell", for: indexPath) as! EndTableViewCell
            //
            cell.backgroundColor = colour2
            //
            cell.separatorInset =  UIEdgeInsetsMake(0, 0, 0, 0)
            //
            cell.layer.borderWidth = 2
            cell.layer.borderColor = colour1.cgColor
            //
            cell.titleLabel?.text = NSLocalizedString("end", comment: "")
            cell.titleLabel?.textColor = colour1
            cell.titleLabel?.textAlignment = .center
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
            switch indexPath.row {
            case selectedRow - 1, selectedRow, currentIndex - 1, currentIndex:
                return (UIScreen.main.bounds.height - 22) * 3/4
            case selectedRow + 1, currentIndex + 1:
                return (UIScreen.main.bounds.height - 22) * 1/4
            default:
                return (UIScreen.main.bounds.height - 22) * 1/4
            }
        //
        case 1: return 49
        default: return 0
        }
        return 0
    }
    
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch indexPath.section {
        case 0: break
        //
        case 1:
            //
            // Tracking
            updateWeekProgress()
            updateMonthProgress()
            //
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
    // Random -------------------------------------------------------------------------------------------------------
    //
    //
    // Time
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
    func enterBackground() {
        didSetEndTime2 = false
        didEnterBackground = true
    }
    
    
    //
    // Time Base
    //
    //
    var sessionLength = Int()
    // Index of element in length array
    var indexNumber = Int()
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
    //
    func startAllTimers() {
        //
        //
        startTime = Date().timeIntervalSinceReferenceDate
        
        //
        sessionLength = lengthArray.reduce(0, +)
        indexNumber = -1
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
            for i in lengthArray {
                //
                indexNumber += 1
                //
                let content = UNMutableNotificationContent()
                content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
                if indexNumber != keyArray.count - 1 {
                    content.title = NSLocalizedString("begin", comment: "") + " " + NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][indexNumber + 1]!, comment: "")
                } else {
                    content.title = NSLocalizedString("cardioEnd", comment: "")
                }
                
                content.body = " "
                content.sound = UNNotificationSound.default()
                
                sessionLength -= i
                //
                arrayOfTimes.append(sessionLength)
                //
                let timeToTrigger = (endTime - startTime) - Double(sessionLength)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeToTrigger, repeats: false)
                //
                let identifier = "timer" + String(indexNumber)
                arrayOfNotifications.append(identifier)
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                //
            }
        }
        
        //
        if timerValue2 != 0 {
            //
            let delayInSeconds = timerValue2Remainder
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                timerCountDown2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer2), userInfo: nil, repeats: true)
            }
            //
        } else
        if timerValue2 == 0 {
            self.dismiss(animated: true)
        }
        
        //
        // Start Timer 2
        if firstCall == true {
            startTimer2()
            firstCall = false
        }
        //
        //
        let delayInSeconds = timerValue2Remainder
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
        if self.didEnterBackground == true {
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
    }
    
    //
    func updateTimer2() {
        if timerValue2 != 0 {
            timerValue2 -= 1
        } else {
            timerCountDown2.invalidate()
            self.dismiss(animated: true)
        }
        
        // Perform Actions
        if arrayOfTimes.contains(timerValue2) {
            if timerCountDown.isValid == true {
                timerCountDown.invalidate()
                timeFormatted(totalSeconds: 0)
            }
            currentIndex = Int(arrayOfTimes.index(of: timerValue2)!) + 1
            if animationAdded == true {
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
        if timerCountDown.isValid == true {
            timerCountDown.invalidate()
        }
        //
        startTime2 = Double(timerValue2)
        //startTime2 = Date().timeIntervalSinceReferenceDate
        //
        if didSetEndTime2 == false {
            if didEnterBackground == true {
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
    func updateTimer3() {
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
            let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
            //
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CardioTableViewCell
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
    func startTimer() {
        
        //
        let key = keyArray[selectedRow]
        
        // Even IndexPath.rows (movement)
        if selectedRow % 2 == 0 {
            
            // Odd IndexPath.rows (pauses)
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
                content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
                switch sessionType {
                case 0:
                    if selectedRow != keyArray.count - 1 {
                        content.title = NSLocalizedString("begin", comment: "") + " " + NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][key + 1]!, comment: "")
                    } else {
                        content.title = NSLocalizedString("cardioEnd", comment: "")
                    }
                case 1:
                    if selectedRow != keyArray.count - 1 {
                        content.title = NSLocalizedString("begin", comment: "") + " " + NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][key + 1]!, comment: "") + " " + String(lengthArray[key + 1]) + "m"
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
                if animationAdded == true {
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
    func updateTimer() {
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
                if animationAdded == true {
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
            //
            cell.detailLabel.text = timeFormatted(totalSeconds: timerValue)
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
        timerShapeLayer.strokeColor = colour1.cgColor
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
        timerShapeLayer.strokeColor = colour1.cgColor
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
            let message = NSLocalizedString("finishEarlyMessageYoga", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = colour2
            alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
        
            //
            // Action
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                UIAlertAction in
                //
                if timerCountDown.isValid == true {
                    timerCountDown.invalidate()
                }
                    //
                if self.animationAdded == true {
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
