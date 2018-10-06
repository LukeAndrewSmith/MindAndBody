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


class CardioTableViewCell: UITableViewCell {
    // DetailLabel (Time/Distance)
    @IBOutlet weak var detailLabel: UILabel!
    // Title Label
    @IBOutlet weak var movementLabel: UILabel!
}

var sessionTimer = Timer()

class CardioScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate {
    
    var selectedRow = 0
    
    // MARK: Variables from Session Data
    var fromCustom = false
    var fromSchedule = false

    // Key Array
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [1] Keys Array
    var keyArray: [String] = []
    
    // Length
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] length array
    var lengthArray: [Int] = []
    
    // Bells Arrays
    let bellsArray: [String] = BellsFunctions.shared.bellsArray
    
    // Check frame for header view
    var didSetFrame = false
    
    var soundPlayer: AVAudioPlayer!
    
    // Timer related
    var startTime = Double()
    var endTime: Double = -1
    
    // Local Timer
    var startTimeRow = Int()
    var endTimeRow = Int()
    var timerValueRow = Int()
    var timerShapeLayer: CAShapeLayer!
    
    // Time Base
    var sessionLength = Int()
    var arrayOfNotifications: [String] = []
    // Array of times to perform actions (next movement)
    var arrayOfTimes: [Int] = []
    // Session timer
    var sessionTime = Int()


    
    // Outlets
    let progressBar = UIProgressView()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Starts timers and sets notifications
        // WALKTHROUGH
        startSession()
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.dark

        // Set current notification center to self to handle playing sound
        UNUserNotificationCenter.current().delegate = self

        // Custom?
        if fromCustom == false {
            // Loop session
            for i in 0..<(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?.count)! {
                keyArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["movement"] as! String)
                lengthArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["time"] as! Int)
            }
        }
        
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        
        // Rounded Edges
        // Colour
        progressBar.trackTintColor = Colors.light
        progressBar.progressTintColor = Colors.green
        progressBar.setProgress(0, animated: true)
        
        // TableView Background
        let tableViewBackground = UIView()
        tableViewBackground.backgroundColor = Colors.dark
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        tableView.backgroundView = tableViewBackground
        tableView.tableFooterView = UIView()
        
        // Cancel Button
        cancelButton.tintColor = Colors.red
        
        // Watch for enter foreground
        NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
        cancelAll()
    }

    
    // MARK:- TableView
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }

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
            let key = keyArray[indexPath.row]
            
            // Cell
            cell.backgroundColor = Colors.dark
            cell.tintColor = Colors.dark
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.selectionStyle = .none
            
            // Movement
            cell.movementLabel.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0] , comment: "")
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-light", size: 33)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = Colors.light
            cell.movementLabel?.numberOfLines = 0
            cell.movementLabel?.lineBreakMode = .byWordWrapping
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            // Timer / Distance info
            cell.detailLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 72)
            cell.detailLabel.textColor = Colors.light

            if indexPath.row == selectedRow {
                if selectedRow != 0 {
                    cell.detailLabel.text = timeFormatted(totalSeconds: lengthArray[indexPath.row])
                } else {
                    cell.detailLabel.text = timeFormattedNicely(totalSeconds: lengthArray[indexPath.row])
                }
            } else {
                cell.detailLabel.text = timeFormattedNicely(totalSeconds: lengthArray[indexPath.row])
            }
            
            switch indexPath.row {
            case selectedRow - 1:
                cell.movementLabel.alpha = 0
            case selectedRow:
                cell.movementLabel.alpha = 1
            case selectedRow + 1:
                cell.movementLabel.alpha = 1
            default:
                cell.movementLabel.alpha = 1
            }
            
            return cell

        case 1:

            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            cell.separatorInset =  UIEdgeInsetsMake(0, 0, 0, 0)
            cell.layer.borderWidth = 2
            cell.layer.borderColor = Colors.light.cgColor
            cell.textLabel?.text = NSLocalizedString("end", comment: "")
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)
            cell.textLabel?.textColor = Colors.light
            cell.textLabel?.textAlignment = .center

            return cell
            
        default: return UITableViewCell(style: .value1, reuseIdentifier: nil)
        }
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {
        case 0:
            let toMinus = ElementHeights.statusBarHeight + 2 + ElementHeights.bottomSafeAreaInset
            switch indexPath.row {
            case selectedRow - 1, selectedRow, selectedRow - 1, selectedRow:
                return (UIScreen.main.bounds.height - toMinus) * 3/4
            case selectedRow + 1, selectedRow + 1:
                return (UIScreen.main.bounds.height - toMinus) * 1/4
            default:
                return (UIScreen.main.bounds.height - toMinus) * 1/4
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
        case 1:
            ScheduleVariables.shared.shouldReloadScheduleTracking()
            
            // Cancel notificaitons
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: self.arrayOfNotifications)
                
            // Dismiss
            cancelAll()
            ScheduleVariables.shared.shouldReloadScheduleTracking()
            self.dismiss(animated: true)

        default: break
        }
    }
    
    // MARK:- Functions
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
    
    // MARK:- Timers
    func startSession() {
        startSessionTimer()
        setNotifications()
        startRowTimer()
        Vibrate.shared.vibratePhone()
    }
    
    @objc func enterForeground() {
        startSessionTimer()
        removeCircle()
        updateSelectedRow()
        startRowTimer()
    }
    
    func updateSelectedRow() {
        let previousRow = selectedRow
        // Find first last time greater than the session time, this represents the last the row was changed, and thus the index of it is the selectedRow
        if let lastRowChange = arrayOfTimes.last(where: { $0 > sessionTime }) {
            selectedRow = Int(arrayOfTimes.index(of: lastRowChange)!) + 1
        }
        if previousRow != selectedRow {
            scrollToSelectedRow()
        }
    }
    
    func startSessionTimer() {
        startTime = Date().timeIntervalSinceReferenceDate
        if endTime == -1 {
            sessionLength = lengthArray.reduce(0, +)
            endTime = startTime + TimeInterval(sessionLength)
        }
        if endTime > startTime {
            sessionTime = Int(endTime - startTime)
        } else {
            sessionTime = 0
        }
        sessionTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateSessionTimer), userInfo: nil, repeats: true)
    }

    @objc func updateSessionTimer() {
        
        // Decrement session time
        if sessionTime != 0 {
            sessionTime -= 1
        } else {
            cancelAll()
            ScheduleVariables.shared.shouldReloadScheduleTracking()
            self.dismiss(animated: true)
        }
        
        // Start component timer at necessary times
        if sessionTime != 0 {
            if arrayOfTimes.contains(sessionTime) {
                if rowTimer.isValid {
                    rowTimer.invalidate()
                }
                selectedRow = Int(arrayOfTimes.index(of: sessionTime)!) + 1
                if animationAdded {
                    timerShapeLayer.removeAllAnimations()
                    timerShapeLayer.removeFromSuperlayer()
                    animationAdded = false
                }
                scrollToSelectedRow()
                startRowTimer()
            }
        }
    }
    
    func startRowTimer() {

        if rowTimer.isValid {
            rowTimer.invalidate()
        }
        startTimeRow = sessionTime
        endTimeRow = arrayOfTimes[selectedRow]
        if endTimeRow < startTimeRow {
            timerValueRow = startTimeRow - endTimeRow
        } else {
            timerValueRow = 0
        }
        
        if timerValueRow != 0 && sessionTime != 0  {
            //
            let indexPath = NSIndexPath(row: selectedRow, section: 0)
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CardioTableViewCell
            
            cell.detailLabel.text = timeFormatted(totalSeconds: timerValueRow)
            
            if animationAdded == false {
                self.addCircle()
                self.startAnimation()
            }
            rowTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateRowTimer), userInfo: nil, repeats: true)
        }
    }
    
    // Update Timer
    @objc func updateRowTimer() {

        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CardioTableViewCell
        
        if timerValueRow == 0 {
            cell.detailLabel.text = timeFormatted(totalSeconds: timerValueRow)
        } else {
            timerValueRow -= 1
            cell.detailLabel.text = timeFormatted(totalSeconds: timerValueRow)
        }
    }
    
    // MARK:- Notifications
    func setNotifications() {
        
        // Create Notifications
        if arrayOfNotifications.count == 0 {
            
            for i in 1...keyArray.count {
                
                let content = UNMutableNotificationContent()
                if i != keyArray.count {
                    
                    content.title = NSLocalizedString("begin", comment: "") + " " + NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![keyArray[i]]!["name"]![0], comment: "")
                    
                    // Sound, low if pause, high if start cardio
                    // All high intensity is even
                    if i % 2 == 0 {
                        // High == doing something
                        content.sound = UNNotificationSound(named: "tibetanBowlH.caf")
                        // All low intensity is odd
                    } else {
                        // Low == rest
                        content.sound = UNNotificationSound(named: "tibetanBowlL.caf")
                    }
                } else {
                    content.title = NSLocalizedString("cardioEnd", comment: "")
                    // Sound
                    content.sound = UNNotificationSound(named: "tibetanBowlL4.caf")
                }
                content.body = " "
                
                // Reduce session length to find notification time
                sessionLength -= lengthArray[i - 1]
                arrayOfTimes.append(sessionLength)
                
                let timeToTrigger = (endTime - startTime) - Double(sessionLength)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeToTrigger, repeats: false)
                
                let identifier = "timer" + String(i)
                arrayOfNotifications.append(identifier)
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
        }
    }
    
    // Handle foreground notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Update the app interface directly.
        Vibrate.shared.vibratePhone()
        // Play a sound.
        completionHandler(UNNotificationPresentationOptions.sound)
    }
    
    @IBAction func scrollToSelectedRow() {
        
        if selectedRow < keyArray.count {
            
            updateProgress()
            
            let indexPath = NSIndexPath(row: selectedRow, section: 0)
            UIView.animate(withDuration: 0.6, animations: {
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
            }, completion: { finished in})
        }
    }
    
    // Update Progress
    func updateProgress() {
        
        // Current Pose
        let currentPose = Float(selectedRow)
        // Total Number Poses
        let totalPoses = Float(keyArray.count - 1)

        if selectedRow > 0 {
            //
            let currentProgress = currentPose / totalPoses
            progressBar.setProgress(currentProgress, animated: true)
        } else {
            // Initial state
            progressBar.setProgress(0, animated: true)
        }
    }
    
    // Timer CountDown Title
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    
    // MARK:- Animations
    func addCircle() {

        let indexPath2 = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath2 as IndexPath) as! CardioTableViewCell
        
        var center = CGPoint()
        if selectedRow != keyArray.count - 1 {
            center = CGPoint(x: cell.detailLabel.center.x, y: cell.detailLabel.center.y + 22)
        } else {
            let centery = (view.frame.size.height - 49 - cell.frame.size.height) + cell.detailLabel.center.y
            center = CGPoint(x: cell.detailLabel.center.x, y: centery)
        }

        let radius = ((cell.frame.size.width - 50) / 2)
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: .pi * 1.5, endAngle: (.pi * 2) + (.pi * 1.5), clockwise: true)
        timerShapeLayer = CAShapeLayer()
        timerShapeLayer.path = circlePath.cgPath
        timerShapeLayer.fillColor = UIColor.clear.cgColor
        timerShapeLayer.strokeColor = Colors.light.cgColor
        timerShapeLayer.lineWidth = 2.0
        timerShapeLayer.strokeEnd = 0.0
        
        view.layer.addSublayer(timerShapeLayer)
    }
    
    func removeCircle() {
        timerShapeLayer.removeAllAnimations()
        timerShapeLayer.removeFromSuperlayer()
        animationAdded = false
    }
    
    var animationAdded = false
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = Double(timerValueRow)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        timerShapeLayer.strokeEnd = 1.0

        timerShapeLayer.add(animation, forKey: "circleAnimation")
        animationAdded = true
    }
    

    // MARK:- Finish early
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        // Alert View
        let title = NSLocalizedString("finishEarly", comment: "")
        let message = NSLocalizedString("finishEarlyMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        // Action
        let okAction = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: UIAlertActionStyle.default) { UIAlertAction in
            self.cancelAll()
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: UIAlertActionStyle.default) {UIAlertAction in}

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
    
    func cancelAll() {
        
        // Timers
        if rowTimer.isValid {
            rowTimer.invalidate()
        }
        if sessionTimer.isValid {
            sessionTimer.invalidate()
        }
        
        // Animations
        if animationAdded {
            timerShapeLayer.removeAllAnimations()
            timerShapeLayer.removeFromSuperlayer()
        }
        
        // Notifications
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: self.arrayOfNotifications)
    }
}

