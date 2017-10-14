//
//  TimeBasedHelpers.swift
//  MindAndBody
//
//  Created by Luke Smith on 13.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

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
        //let circlePath = UIBezierPath(arcCenter: cell.center, radius: CGFloat(20), startAngle: .pi, endAngle: .pi, clockwise: true)
        timerShapeLayer = CAShapeLayer()
        timerShapeLayer.path = circlePath.cgPath
        timerShapeLayer.fillColor = UIColor.clear.cgColor
        timerShapeLayer.lineWidth = 2.0
        timerShapeLayer.strokeEnd = 0.0
        // Color
        switch movementProgress {
        // Rest Time
        case 0:
            timerShapeLayer.strokeColor = colour4.cgColor
        // Prepare for movement
        case 1:
            timerShapeLayer.strokeColor = colour4.cgColor
        // Perform movement for:
        case 2:
            timerShapeLayer.strokeColor = colour3.cgColor
        default:
            break
        }
        
        view.layer.addSublayer(timerShapeLayer)
        //cell.layer.addSublayer(timerShapeLayer)
    }
    
    //
    func removeCircle() {
        timerShapeLayer.removeFromSuperlayer()
    }
    
    //
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        // Rest Time
        if movementProgress == 0 {
            let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let restTimes = settings[4]
            switch selectedSession[0] {
            // Warmup
            case 0:
                animation.duration = Double(restTimes[0])
            // Workout
            case 1:
                animation.duration = Double(restTimes[1])
            // Stretching
            case 3:
                animation.duration = Double(restTimes[2])
            default:
                break
            }
        // Prepare for movement
        } else if movementProgress == 1 {
            //
            // Longer preparation for circuit workout
            switch selectedSession[1] {
            case 13,14,15:
                animation.duration = Double(10)
            default:
                animation.duration = Double(5)
            }
        // Movement Time
        } else if movementProgress == 2 {
            animation.duration = Double(lengthArray[selectedRow])
        }
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        timerShapeLayer.strokeEnd = 1.0
        //
        timerShapeLayer.add(animation, forKey: "circleAnimation")
        animationAdded = true
    }
    
    
    //
    func startTimer() {
        // Check
        if lengthTimer.isValid == true {
            lengthTimer.invalidate()
        }
        //
        switch movementProgress {
        // Rest Time
        case 0:
            let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let restTimes = settings[4]
            switch selectedSession[0] {
            // Warmup
            case 0:
                timerValue = restTimes[0]
            // Workout
            case 1:
                timerValue = restTimes[1]
            // Stretching
            case 3:
                timerValue = restTimes[2]
            default:
                break
            }
        // Prepare for movement
        case 1:
            //
            // Longer preparation for circuit workout
            switch selectedSession[1] {
            case 13,14,15:
                timerValue = 10
            default:
                timerValue = 5
            }
        // Perform movement for:
        case 2:
            timerValue = lengthArray[selectedRow]
            
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
        // TODO: Vibrate properly
        vibratePhone()
    }
    
    //
    func updateTimer() {
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
        //
        if timerValue == 0 {
            // Movement is not asymmetric (or is aysmmetric but rest or prepare)
            if sessionData.asymmetricMovements[selectedSession[0]].contains(keyArray[selectedRow]) == false || movementProgress != 2 {
                movementProgress += 1
                removeCircle()
                lengthTimer.invalidate()
                indicateMovementProgress()
            // Movement is asymmetric and first side just finished being timed
            } else if asymmetricProgress == 0 {
                asymmetricProgress += 1
                removeCircle()
                lengthTimer.invalidate()
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
            cell.indicatorLabel.text = " "
            finishEarly.isEnabled = false
            cell.timeLabel.text = NSLocalizedString("rest", comment: "")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                cell.indicatorLabel.text = NSLocalizedString("rest", comment: "")
                self.startTimer()
                self.finishEarly.isEnabled = true
                self.playBell(bell: 0)
            })
        case 1:
            cell.indicatorLabel.text = " "
            finishEarly.isEnabled = false
            cell.timeLabel.text = NSLocalizedString("prepare", comment: "")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                cell.indicatorLabel.text = NSLocalizedString("prepare", comment: "")
                self.startTimer()
                self.finishEarly.isEnabled = true
                self.playBell(bell: 0)
            })
        case 2:
                cell.indicatorLabel.text = " "
                finishEarly.isEnabled = false
                // Title
                // Movement is not asymmetric
                if sessionData.asymmetricMovements[selectedSession[0]].contains(keyArray[selectedRow]) == false {
                    cell.timeLabel.text = NSLocalizedString("beginMovement", comment: "")
                // Asymmetric and first side, left
                } else if asymmetricProgress == 0 {
                    cell.timeLabel.text = NSLocalizedString("beginMovementSide1", comment: "")
                // Asymmetric and second side, right
                } else {
                    cell.timeLabel.text = NSLocalizedString("beginMovementSide2", comment: "")
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    self.startTimer()
                    self.finishEarly.isEnabled = true
                    self.playBell(bell: 1)
                    // Reverse image if second side of asymmetric exersize
                    if sessionData.asymmetricMovements[selectedSession[0]].contains(self.keyArray[self.selectedRow]) && self.asymmetricProgress == 1 {
                        self.playAnimationReversed(row: self.selectedRow)
                    } else {
                        self.playAnimation(row: self.selectedRow)
                    }
                })
        case 3:
            if selectedRow != keyArray.count - 1 {
                //
                // Special case for circuit workout
                switch selectedSession[1] {
                case 13,14,15:
                    // If new selected movement is a multiple of the number of movements in the original key array, then it is the end of a round and a rest timer must be presented
                    if isNewRound() == true {
                        movementProgress = 0
                    } else {
                        movementProgress = 1
                    }
                default:
                    movementProgress = 0
                }
                nextButtonAction()
            } else {
                self.dismiss(animated: true)
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
    
}
