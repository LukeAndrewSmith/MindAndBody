//
//  TimeBasedHelpers.swift
//  MindAndBody
//
//  Created by Luke Smith on 13.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension TimeBasedScreen {
    
    //
    // MARK:- Time Helpers
    //
    //
    // Circle -------------------------------------------------------------------------------------------------------------------------
    // Funcs
    func addCircle() {
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
        
        var center = CGPoint()
        if selectedRow != keyArray.count - 1 {
            center = CGPoint(x: cell.timeLabel.center.x, y: cell.timeLabel.center.y + 22)
        } else {
            let centery = (view.frame.size.height - 49 - cell.frame.size.height) + cell.timeLabel.center.y
            center = CGPoint(x: cell.timeLabel.center.x, y: centery)
        }
        //
        let radius = ((cell.timeLabel.frame.height - 2) / 2)
        //}
        //
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: .pi * 1.5, endAngle: (.pi * 2) + (.pi * 1.5), clockwise: true)
        timerShapeLayer = CAShapeLayer()
        timerShapeLayer.path = circlePath.cgPath
        timerShapeLayer.fillColor = UIColor.clear.cgColor
        timerShapeLayer.lineWidth = 2.0
        timerShapeLayer.strokeEnd = 0.0
        // Color
        switch movementProgress {
        // Rest Time
        case 0:
            timerShapeLayer.strokeColor = Colors.red.cgColor
        // Prepare for movement
        case 1:
            timerShapeLayer.strokeColor = Colors.red.cgColor
        // Perform movement for:
        case 2:
            timerShapeLayer.strokeColor = Colors.green.cgColor
        default:
            break
        }
        //
        view.layer.addSublayer(timerShapeLayer)
    }
    
    //
    func removeCircle() {
        // SAFE!.. NICE UNWRAPPING
        if let sublayers = view.layer.sublayers {
            if let shapeLayer = timerShapeLayer {
                if sublayers.contains(shapeLayer) {
                    timerShapeLayer.removeFromSuperlayer()
                }
            }
        }
    }
    
    //
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        // Rest Time
        if movementProgress == 0 {
            let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let restTimes = settings["RestTimes"]!
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup
            case "warmup":
                animation.duration = Double(restTimes[0])
            // Workout
            case "workout":
                animation.duration = Double(restTimes[1])
            // Stretching
            case "stretching":
                animation.duration = Double(restTimes[2])
            default:
                break
            }
            // Prepare for movement
        } else if movementProgress == 1 {
            //
            // Longer preparation for circuit workout
            switch SelectedSession.shared.selectedSession[1] {
            case "circuitBodyweightFull", "circuitBodyweightUpper", "circuitBodyweightLower":
                animation.duration = Double(5)
            default:
                animation.duration = Double(5)
            }
            // Movement Time
        } else if movementProgress == 2 {
            if isCircuit {
                let indexRow = (nMovementsInRound * sessionScreenRoundIndex) + selectedRow
                animation.duration = Double(lengthArray[indexRow])
            } else {
                animation.duration = Double(lengthArray[selectedRow])
            }
        }
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        timerShapeLayer.strokeEnd = 1.0
        //
        timerShapeLayer.add(animation, forKey: "circleAnimation")
        animationAdded = true
    }
    
    
    //
    func startTimer() {
        // Check
        if lengthTimer.isValid {
            lengthTimer.invalidate()
        }
        //
        switch movementProgress {
        // Rest Time
        case 0:
            let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let restTimes = settings["RestTimes"]!
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup
            case "warmup":
                timerValue = restTimes[0]
            // Workout
            case "workout":
                timerValue = restTimes[1]
            // Stretching
            case "stretching":
                timerValue = restTimes[2]
            default:
                break
            }
        // Prepare for movement
        case 1:
            //
            // Longer preparation for circuit workout
            switch SelectedSession.shared.selectedSession[1] {
            case "circuitBodyweightFull", "circuitBodyweightUpper", "circuitBodyweightLower":
                timerValue = 5
            default:
                timerValue = 5
            }
        // Perform movement for:
        case 2:
            //
            if isCircuit {
                let indexRow = (nMovementsInRound * sessionScreenRoundIndex) + selectedRow
                timerValue = lengthArray[indexRow]
            } else {
                timerValue = lengthArray[selectedRow]
            }
            
        default:
            break
        }
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
        cell.timeLabel.text = timeFormatted(totalSeconds: timerValue)
        //
        addCircle()
        startAnimation()
        lengthTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        Vibrate.shared.vibratePhone()
    }
    
    //
    @objc func updateTimer() {
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
        //
        let key = keyArray[indexPath.row]
        //
        if timerValue <= 0 {
            // Movement is not asymmetric (or is aysmmetric but rest or prepare)
            if sessionData.movements[SelectedSession.shared.selectedSession[0]]?[key]?["attributes"]?[0].contains("a") ?? false == false || movementProgress != 2 {
                movementProgress += 1
                removeCircle()
                lengthTimer.invalidate()
                indicateMovementProgress()
            // Movement is asymmetric and first side just finished being timed
            } else if asymmetricProgress == 0 {
                asymmetricProgress += 1
                removeCircle()
                lengthTimer.invalidate()
                Vibrate.shared.vibratePhone()
                indicateMovementProgress()
            // Movement is asymmetric and second side just finished being timed
            } else if asymmetricProgress == 1 {
                movementProgress += 1
                removeCircle()
                lengthTimer.invalidate()
                indicateMovementProgress()
                asymmetricProgress = 0
            }
            //
            //
        } else {
            timerValue -= 1
            cell.timeLabel.text = timeFormatted(totalSeconds: timerValue)
            //
        }
    }
    
    //
    // Display in timerLabel: rest, prepare, perform
    // Then perform necessary actions, start timer, play bell, start animation etc...
    func indicateMovementProgress(){
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
        //
        switch movementProgress {
        // Rest time
        case 0:
            let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let restTimes = settings["RestTimes"]!
            if restTimes[0] == 0 {
                movementProgress += 1
                indicateMovementProgress()
            } else {
                cell.indicatorLabel.text = " "
                finishEarly.isEnabled = false
                cell.timeLabel.text = NSLocalizedString("rest", comment: "")
                canSwipeMovement = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    self.canSwipeMovement = true
                    cell.indicatorLabel.text = NSLocalizedString("rest", comment: "")
                    self.startTimer()
                    self.finishEarly.isEnabled = true
                    self.playBell(bell: 0)
                })
            }
        case 1:
            cell.indicatorLabel.text = " "
            finishEarly.isEnabled = false
            cell.timeLabel.text = NSLocalizedString("prepare", comment: "")
            canSwipeMovement = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.canSwipeMovement = true
                cell.indicatorLabel.text = NSLocalizedString("prepare", comment: "")
                self.startTimer()
                self.finishEarly.isEnabled = true
                self.playBell(bell: 0)
            })
        case 2:
            cell.indicatorLabel.text = " "
            finishEarly.isEnabled = false
            
            //
            let key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[selectedRow]["movement"] as! String
            // Title
            // Movement is not asymmetric
            if sessionData.movements[SelectedSession.shared.selectedSession[0]]?[key]?["attributes"]?[0].contains("a") ?? false == false {
                cell.timeLabel.text = NSLocalizedString("beginMovement", comment: "")
                // Asymmetric and first side, left
            } else if asymmetricProgress == 0 {
                cell.timeLabel.text = NSLocalizedString("beginMovementSide1", comment: "")
                // Asymmetric and second side, right
            } else {
                cell.timeLabel.text = NSLocalizedString("beginMovementSide2", comment: "")
            }
            //
            canSwipeMovement = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.canSwipeMovement = true
                self.startTimer()
                self.finishEarly.isEnabled = true
                self.playBell(bell: 1)
            })
        case 3:
            if !isCircuit && selectedRow != keyArray.count - 1 || isCircuit && (selectedRow + (sessionScreenRoundIndex * nMovementsInRound)) != keyArray.count - 1 {
                //
                // Special case for circuit workout
                switch SelectedSession.shared.selectedSession[1] {
                case "circuitBodyweightFull", "circuitBodyweightUpper","circuitBodyweightLower":
                    // If new selected movement is a multiple of the number of movements in the original key array, then it is the end of a round and a rest timer must be presented
                    if isNewRound() {
                        movementProgress = 0
                    } else {
                        movementProgress = 1
                    }
                default:
                    movementProgress = 0
                }
                // Next round
                    // If circuit AND final movement
                if isCircuit && ((selectedRow + 1) % nMovementsInRound) == 0 {
                    endRound()
                // Next movement
                } else {
                    nextButtonAction()
                }
            } else {
                // Schedule Tracking
                ScheduleManager.shared.shouldReloadScheduleTracking()
                dismissView()
            }
        default:
            break
        }
    }
    
    // Helper is new round
    func isNewRound() -> Bool {
        if (selectedRow + 1) % nMovementsInRound == 0 {
            return true
        } else {
            return false
        }
    }
    
    
    //
    // MARK: Next Round -------------------------------------------------------------------------------------------
    //
    // Update Timer
    @objc func updateRestTimer() {
        //
        if restTime == 0 {
            //
            endRest()
            //
        } else {
            restTime -= 1
            restAlert.setValue(NSAttributedString(string: "\n" + String(describing: restTime), attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-Thin", size: 23)!]), forKey: "attributedMessage")
        }
    }
    
    //
    // Start Timer
    //
    @objc func startRestTimer() {
        // Dates and Times
        startTime = Date().timeIntervalSinceReferenceDate
        //
        if didSetEndTime == false {
            //
            didSetEndTime = true
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
        }

        // Set Timer
        // Set initial time
        restAlert.setValue(NSAttributedString(string: "\n" + String(describing: restTime), attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-Thin", size: 23)!]), forKey: "attributedMessage")
        
        // Begin Timer or dismiss view
        rowTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateRestTimer), userInfo: nil, repeats: true)
    }
    
    //
    func endRest() {
        // Increase round indicator
        sessionScreenRoundIndex += 1
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
        self.tableView.scrollToRow(at: indexPath0 as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
        //
        let cell = self.tableView.cellForRow(at: indexPath0 as IndexPath) as! TimeBasedTableViewCell
        //
        UIView.animate(withDuration: 0.6, animations: {
            // 1
            cell.movementLabel.alpha = 1
            cell.explanationButton.alpha = 1
            //
            self.updateProgress()
            //
        }, completion: { finished in
            self.tableView.reloadData()
            self.indicateMovementProgress()
        })
        
        //
        // Next Round Alert
        // Alert View
        let titleString = "round" + String(self.sessionScreenRoundIndex + 1)
        let title = NSLocalizedString(titleString, comment: "")
        //let message = NSLocalizedString("resetMessage", comment: "")
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.tintColor = Colors.light
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
        self.present(alert, animated: true, completion: {
            //
            let delayInSeconds = 0.7
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                alert.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    //
    // End Round func
    func endRound() {
        
        // Rest Alert
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
        content.sound = UNNotificationSound.default
        //
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(restTime), repeats: false)
        let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
        //
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        // Timer
        startRestTimer()
        
        // Rest Alert
        restAlert = UIAlertController()
        restAlert.view.tintColor = Colors.dark
        restAlert.setValue(NSAttributedString(string: restTitle, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
        restAlert.setValue(NSAttributedString(string: restMessage, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-Thin", size: 23)!]), forKey: "attributedMessage")
        let skipAction = UIAlertAction(title: NSLocalizedString("skip", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            //
            self.endRest()
        }
        self.restAlert.addAction(skipAction)
        //
        self.present(restAlert, animated: true, completion: {
        })
        
    }
    
    // Cancel timers and dismiss
    func dismissView() {
        playBell(bell: 0)
        if lengthTimer.isValid {
            lengthTimer.invalidate()
        }
        self.dismiss(animated: true)
    }
}

