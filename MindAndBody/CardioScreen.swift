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
    // Play/Pause
    @IBOutlet weak var playPauseButton: UIButton!
}


//
// Cardio Screen Class ------------------------------------------------------------------------------------
//
class CardioScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //
    // Retreive Arrays ---------------------------------------------------------------------------------------------------
    //
    //
    var sessionType = Int()
    
    
    // Title
    var sessionTitle = String()
    
    // Movement Array
    var sessionArray: [String] = []
    
    // Length Array
    var lengthArray: [Int] = []
    
    
    //
    // Variables
    var selectedRow = 0
    

    // Bells Arrays
    let bellsArray: [String] =
        ["Tibetan Chimes", "Tibetan Singing Bowl (Low)", "Tibetan Singing Bowl (Low)(x4)", "Tibetan Singing Bowl (Low)(Singing)", "Tibetan Singing Bowl (High)", "Tibetan Singing Bowl (High)(x4)", "Tibetan Singing Bowl (High)(Singing)", "Australian Rain Stick", "Australian Rain Stick (x2)", "Australian Rain Stick (2 sticks)", "Wind Chimes", "Gambang (Wood)(Up)", "Gambang (Wood)(Down)", "Gambang (Metal)", "Indonesian Frog", "Cow Bell (Small)", "Cow Bell (Big)"]
    
    
    //
    // Outlets -----------------------------------------------------------------------------------------------------------
    // Progress Bar
    let progressBar = UIProgressView()
    
    // Table view
    @IBOutlet weak var tableView: UITableView!
    
    // Pause/Play
    var playPause = UIButton()
    
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Session Started
        //
        // Alert View
        let title = NSLocalizedString("sessionStarted", comment: "") + "\n" + NSLocalizedString("begin", comment: "") + " " + NSLocalizedString(sessionArray[selectedRow], comment: "")
        //let message = NSLocalizedString("resetMessage", comment: "")
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.tintColor = colour1
        alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
        self.present(alert, animated: true, completion: {
            //
            let delayInSeconds = 0.7
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                alert.dismiss(animated: true, completion: nil)
                self.startTimer()
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
        
        // Play/Pause
        playPause.backgroundColor = colour2
        playPause.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        playPause.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
        playPause.tintColor = colour1
        //playPause.addTarget(self, action: #selector(pauseButtonAction), for: .touchUpInside)
        
        
        //
        // Watch for enter foreground
        switch sessionType {
        case 0:
            NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        case 1:
            NotificationCenter.default.addObserver(self, selector: #selector(startAllTimers), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
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
        case 0: return sessionArray.count
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
            
            // Cell
            //
            cell.backgroundColor = colour2
            cell.tintColor = colour2
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //
            cell.selectionStyle = .none
            
            // Movement
            //
            cell.movementLabel.text = NSLocalizedString(sessionArray[indexPath.row], comment: "")
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
            
            // Play Pause
            cell.playPauseButton.tintColor = colour1
            cell.playPauseButton.addTarget(self, action: #selector(playPauseAction), for: .touchUpInside)
            
            
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
                        startTimer()
                    } else {
                        cell.detailLabel.text = timeFormattedNicely(totalSeconds: lengthArray[indexPath.row])
                    }
                    cell.playPauseButton.alpha = 1
                } else {
                    //
                    cell.detailLabel.text = timeFormattedNicely(totalSeconds: lengthArray[indexPath.row])
                    cell.playPauseButton.alpha = 0
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
                    cell.playPauseButton.alpha = 0
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
                }
            default: break
            }

                    
                    
            
            
          
            //            cell.backButton.addGestureRecognizer(backTap)
            //            //
            
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
            case selectedRow - 1, selectedRow:
                return (UIScreen.main.bounds.height - 22) * 3/4
            case selectedRow + 1:
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
            // Dismiss
            self.dismiss(animated: true)
            
            //            // Alert View
            //            let title = NSLocalizedString("resetWarning", comment: "")
            //            let message = NSLocalizedString("resetWarningMessage", comment: "")
            //            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            //            alert.view.tintColor = colour2
            //            alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            //            let paragraphStyle = NSMutableParagraphStyle()
            //            paragraphStyle.alignment = .justified
            //            alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
            //
            //
            //            // Action
            //            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
            //                UIAlertAction in
            //
            //                UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            //                UserDefaults.standard.synchronize()
            //
            //                // Alert View
            //                let title = NSLocalizedString("resetTitle", comment: "")
            //                let message = NSLocalizedString("resetMessage", comment: "")
            //                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            //                alert.view.tintColor = self.colour2
            //                alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            //                let paragraphStyle = NSMutableParagraphStyle()
            //                paragraphStyle.alignment = .justified
            //                alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
            //
            //                self.present(alert, animated: true, completion: nil)
            //
            //
            //            }
            //            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
            //                UIAlertAction in
            //
            //            }
            //
            //            alert.addAction(okAction)
            //            alert.addAction(cancelAction)
            //
            //            self.present(alert, animated: true, completion: nil)
            //
            //            tableView.deselectRow(at: indexPath, animated: true)
            
        //
        default: break
        }
    }
    
    
    //
    // Tap Handlers -------------------------------------------------------------------------------------------------------
    //
    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        //
        if selectedRow < sessionArray.count - 1 {
            //
            selectedRow = selectedRow + 1
            //
            didSetEndTime = false
            
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
                // 1
                cell.movementLabel.alpha = 1
                // - 1
                let cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! CardioTableViewCell
                cell.playPauseButton.alpha = 0
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
            }, completion: { finished in
                self.tableView.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
            })
        } else {
        }
    }
    
    
    // Update Progress
    func updateProgress() {
        // Current Pose
        let currentPose = Float(selectedRow)
        // Total Number Poses
        let totalPoses = Float(sessionArray.count - 1)
        
        
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
// Count Down Timer -------------------------------------------------------------------------------------------------------------------------
//
    var isTiming = false
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
        
        if timerValue == 0 {
            if selectedRow < (sessionArray.count - 1) {
                timerCountDown.invalidate()
                removeCircle()
                isTiming = false
                nextButtonAction()
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

    
    var timerShapeLayer: CAShapeLayer!
    // Funcs
    func addCircle() {
        //
        let indexPath2 = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath2 as IndexPath) as! CardioTableViewCell
        
        var center = CGPoint()
        if selectedRow != sessionArray.count - 1 {
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
    }
    
    
    //
    var didSetEndTime = false
    var startTime = Double()
    var endTime = Double()
    //
    func startTimer() {
        //
        startTime = Date().timeIntervalSinceReferenceDate
        //
        if didSetEndTime == false {
            endTime = startTime + TimeInterval(lengthArray[selectedRow])
            //
            didSetEndTime = true
        }
        //
        timerValue = Int(endTime - startTime)

        isTiming = true
        
        //
        
        if timerValue != 0 {
            //
            let indexPath = NSIndexPath(row: selectedRow, section: 0)
            let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CardioTableViewCell

            //
            cell.detailLabel.text = timeFormatted(totalSeconds: timerValue)
            
            //
            self.addCircle()
            self.startAnimation()
            timerCountDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
                
            //
            let content = UNMutableNotificationContent()
            content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
            switch sessionType {
            case 0:
                if selectedRow != sessionArray.count - 1 {
                    content.title = NSLocalizedString("begin", comment: "") + " " + NSLocalizedString(sessionArray[selectedRow + 1], comment: "")
                } else {
                    content.title = NSLocalizedString("cardioEnd", comment: "")
                }
            case 1:
                if selectedRow != sessionArray.count - 1 {
                    content.title = NSLocalizedString("begin", comment: "") + " " + NSLocalizedString(sessionArray[selectedRow + 1], comment: "") + " " + String(lengthArray[selectedRow + 1]) + "m"
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
        }
    }
    
    // Next Alert
    func nextAlert() {
        //
        // Alert View
        //
        let title = NSLocalizedString("begin", comment: "") + " " + NSLocalizedString(sessionArray[selectedRow], comment: "")
        //
        //
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.tintColor = colour1
        alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
        self.present(alert, animated: true, completion: {
            //
            let delayInSeconds = 0.7
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                alert.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    //
    func playPauseAction(_ sender: Any) {
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CardioTableViewCell
        
        switch sessionType {
        case 0: break
            
        case 1:
            // Invalidate
            if timerCountDown.isValid == true {
                //
                //
                timerCountDown.invalidate()
                timerShapeLayer.removeAllAnimations()
                timerShapeLayer.removeFromSuperlayer()
                isTiming = false
                didSetEndTime = false
                
                //
                cell.playPauseButton.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
                //
                cell.detailLabel.text = timeFormattedNicely(totalSeconds: lengthArray[indexPath.row])
                
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timer"])
                
                
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
                // Action
                let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                    UIAlertAction in
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
                
                
                
                // Validate
            } else {
                cell.playPauseButton.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
                startTimer()
            }
            
        default: break
        }
    }
    //
    
    
    
    //
    // Time Base
    //
    func startAllTimers() {
        
        //
        //
        //
        // Create Function That Sets all timers and notifications, and moves table along (find end time, begin from selected row (thus after cancel removes all, start re begins from selected row)
        //
        //
        //
        
    }
    
//
}
