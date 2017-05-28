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
    @IBOutlet weak var nextImage: UIButton!
    @IBOutlet weak var previousImage: UIButton!
    // Title Label
    @IBOutlet weak var movementLabel: UILabel!
    // Sets x Reps label
    @IBOutlet weak var setsRepsLabel: UILabel!
    // Explanation Button
    @IBOutlet weak var explanationButton: UIButton!
    // Hide Screen
    @IBOutlet weak var hideScreen: UIButton!
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
    // Retreive Arrays ---------------------------------------------------------------------------------------------------
    //
    // Session Type
    var sessionType = Int()
    
    //
    var numberOfRounds = Int()
    
    
    // Initialize Arrays
    //
    // Movement Array
    var sessionArray: [String] = []
    
    // Reps Array
    var repsArray: [[String]] = []
    
    // Demonstration Array
    var demonstrationArray: [UIImage] = []
    
    // Target Area Array
    var targetAreaArray: [UIImage] = []
    
    // Explanation Array
    var explanationArray: [String] = []
    
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
    // View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        view.backgroundColor = colour2
        
        //
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
            }
        })
        
        // self.present(alert, animated: true, completion: (() -> Void)?)
        
        // Progress Bar
        // Thickness
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as! WorkoutOverviewTableViewCell
            

            //
            // Cell
            cell.backgroundColor = colour2
            cell.tintColor = colour2
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.selectionStyle = .none
            
            
            // Image Tap
            //            let imageTap = UITapGestureRecognizer()
            //            imageTap.numberOfTapsRequired = 1
            //            imageTap.addTarget(self, action: #selector(handleImageTap))
            //            cell.demonstrationImageView.addGestureRecognizer(imageTap)
            //
            // Images
            
            //
            // Images
            if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                cell.imageViewCell.image = demonstrationArray[indexPath.row]
            } else {
                cell.imageViewCell.image = targetAreaArray[indexPath.row]
            }
            
            //
            // Buttons
            cell.nextImage.tintColor = colour1
            cell.previousImage.tintColor = colour1
            
            //
            // Movement
            cell.movementLabel.text = NSLocalizedString(sessionArray[indexPath.row], comment: "")
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 23)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            //
            // Set and Reps
            cell.setsRepsLabel?.text = repsArray[sessionScreenRoundIndex][indexPath.row]
            cell.setsRepsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.setsRepsLabel?.textAlignment = .right
            cell.setsRepsLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.setsRepsLabel.adjustsFontSizeToFitWidth = true
            
            //
            // Explanation
            cell.explanationButton.tintColor = colour1
            
            //
            // Hide Screen
            cell.hideScreen.tintColor = colour1
            
            
            
            
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
            
            // HideScreen
            let hideScreenTap = UITapGestureRecognizer()
            hideScreenTap.numberOfTapsRequired = 1
            hideScreenTap.addTarget(self, action: #selector(hideScreenAction))
            cell.hideScreen.addGestureRecognizer(hideScreenTap)
            
            // Left Image Swift
            let imageSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            imageSwipeLeft.direction = UISwipeGestureRecognizerDirection.left
            cell.imageViewCell.addGestureRecognizer(imageSwipeLeft)
            cell.imageViewCell.isUserInteractionEnabled = true
            //
            let nextImageTap = UITapGestureRecognizer()
            nextImageTap.numberOfTapsRequired = 1
            nextImageTap.addTarget(self, action: #selector(nextImageAction))
            cell.nextImage.addGestureRecognizer(nextImageTap)
            
            // Right Image Swipe
            let imageSwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            imageSwipeRight.direction = UISwipeGestureRecognizerDirection.right
            cell.imageViewCell.addGestureRecognizer(imageSwipeRight)
            cell.imageViewCell.isUserInteractionEnabled = true
            //
            let previousImageTap = UITapGestureRecognizer()
            previousImageTap.numberOfTapsRequired = 1
            previousImageTap.addTarget(self, action: #selector(previousImageAction))
            cell.previousImage.addGestureRecognizer(previousImageTap)
            
            
            // Alphas
            switch indexPath.row {
            case selectedRow:
                //
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.hideScreen.alpha = 1
                cell.nextImage.alpha = 1
                cell.previousImage.alpha = 0
            //
            default:
                //
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 0
                cell.hideScreen.alpha = 0
                cell.nextImage.alpha = 0
                cell.previousImage.alpha = 0
            }
            
            //
            return cell
        //
        case 1:
            //
            let cell = tableView.dequeueReusableCell(withIdentifier: "EndRoundTableViewCell", for: indexPath) as! EndRoundTableViewCell
            //
            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            //
            cell.separatorInset =  UIEdgeInsetsMake(0.0, 0.0, 0.0, -cell.bounds.size.width)
            //
            cell.layer.borderWidth = 2
            cell.layer.borderColor = colour1.cgColor
            //
            if sessionScreenRoundIndex + 1 < numberOfRounds {
                cell.titleLabel?.text = NSLocalizedString("endRound", comment: "") + " " + String(sessionScreenRoundIndex + 1)
            } else {
                cell.titleLabel?.text = NSLocalizedString("endWorkout", comment: "")
            }
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
            //
            let height2 = 0.25/Double(sessionArray.count - 1)
            //
            switch indexPath.row {
            case selectedRow:
                return (UIScreen.main.bounds.height - 22) * 3/4
            case selectedRow + 1, selectedRow - 1:
                return (UIScreen.main.bounds.height - 22) * CGFloat(height2)
            default:
                return (UIScreen.main.bounds.height - 22) * CGFloat(height2)
            }
        case 1: return 49
        default: return 0
        }
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch indexPath.section {
        case 0:
            if indexPath.row == selectedRow {
                //
                //                performSegue(withIdentifier: "SessionDetailSegue", sender: nil)
                //                tableView.deselectRow(at: indexPath, animated: true)
                //
            } else if indexPath.row == selectedRow + 1 {
                //
                if selectedRow < sessionArray.count {
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
                    //
                    UIView.animate(withDuration: 0.6, animations: {
                        //
                        self.tableView.beginUpdates()
                        self.tableView.endUpdates()
                        // 1
                        cell.setsRepsLabel.alpha = 1
                        cell.movementLabel.alpha = 1
                        cell.explanationButton.alpha = 1
                        cell.hideScreen.alpha = 1
                        cell.nextImage.alpha = 1
                        cell.previousImage.alpha = 0
                        //cell.demonstrationImageView.isUserInteractionEnabled = true
                        // -1
                        cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! WorkoutOverviewTableViewCell
                        cell.setsRepsLabel.alpha = 0
                        cell.movementLabel.alpha = 0
                        cell.hideScreen.alpha = 0
                        //
                    })
                    // + 1
                    if selectedRow < sessionArray.count - 1 {
                        tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableViewRowAnimation.none)
                    }
                }
            }
        //
        case 1:
            
            if sessionScreenRoundIndex < numberOfRounds - 1{
                //
                sessionScreenRoundIndex += 1
                selectedRow = 0
                //
                endRound()
                //
            } else {
                self.dismiss(animated: true)
            }
           
            //
            tableView.deselectRow(at: indexPath, animated: true)
            //
            
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
    // Next Round -------------------------------------------------------------------------------------------
    //
    let restTitle = NSLocalizedString("rest", comment: "")
    //
    var restTime = Int()
    //
    var restMessage = String()
    //
    var restAlert = UIAlertController()
    //
    // Timer
    // Variables
    var didSetEndTime = false
    var startTime = Double()
    var endTime = Double()
    
    // Update Timer
    func updateTimer() {
        //
        if restTime == 0 {
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
            var cell = self.tableView.cellForRow(at: indexPath0 as IndexPath) as! WorkoutOverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                // 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.hideScreen.alpha = 1
                if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                    if cell.imageViewCell.image == self.demonstrationArray[self.selectedRow] {
                        cell.nextImage.alpha = 1
                        cell.nextImage.isEnabled = true
                        cell.previousImage.alpha = 0
                        cell.previousImage.isEnabled = false
                    } else {
                        cell.nextImage.alpha = 0
                        cell.nextImage.isEnabled = false
                        cell.previousImage.alpha = 1
                        cell.previousImage.isEnabled = true
                    }
                } else {
                    if cell.imageViewCell.image == self.targetAreaArray[self.selectedRow] {
                        cell.nextImage.alpha = 1
                        cell.nextImage.isEnabled = true
                        cell.previousImage.alpha = 0
                        cell.previousImage.isEnabled = false
                    } else {
                        cell.nextImage.alpha = 0
                        cell.nextImage.isEnabled = false
                        cell.previousImage.alpha = 1
                        cell.previousImage.isEnabled = true
                    }
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
            alert.view.tintColor = colour1
            alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
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
            restAlert.setValue(NSAttributedString(string: "\n" + String(describing: restTime), attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-Thin", size: 23)!]), forKey: "attributedMessage")
        }
    }
    
    //
    // Start Timer
    //
    func startTimer() {
        // Dates and Times
        startTime = Date().timeIntervalSinceReferenceDate
        //
        if didSetEndTime == false {
            //
            didSetEndTime = true
            //
            //
            // Rest Timer
            let restTimes = UserDefaults.standard.object(forKey: "restTimes") as! [Int]
            let duration = restTimes[1]
            let endingTime = Int(startTime) + duration
            //
            endTime = Double(endingTime)
        }
        
        // Set timer value
        restTime = Int(endTime - startTime)
        
        // Check Greater than 0
        if restTime <= 0 {
            restTime = 0
        }
        
        // Set Timer
        // Set initial time
        restAlert.setValue(NSAttributedString(string: "\n" + String(describing: restTime), attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-Thin", size: 23)!]), forKey: "attributedMessage")

        // Begin Timer or dismiss view
        timerCountDown = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    //
    // End Round func
    func endRound() {
        // Rest Alert
        //
        let restTimes = UserDefaults.standard.object(forKey: "restTimes") as! [Int]
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
        content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
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
        restAlert.view.tintColor = colour2
        restAlert.setValue(NSAttributedString(string: restTitle, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
        restAlert.setValue(NSAttributedString(string: restMessage, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-Thin", size: 23)!]), forKey: "attributedMessage")
        let skipAction = UIAlertAction(title: NSLocalizedString("skip", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            
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
                cell.hideScreen.alpha = 1
                if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                    if cell.imageViewCell.image == self.demonstrationArray[self.selectedRow] {
                        cell.nextImage.alpha = 1
                        cell.nextImage.isEnabled = true
                        cell.previousImage.alpha = 0
                        cell.previousImage.isEnabled = false
                    } else {
                        cell.nextImage.alpha = 0
                        cell.nextImage.isEnabled = false
                        cell.previousImage.alpha = 1
                        cell.previousImage.isEnabled = true
                    }
                } else {
                    if cell.imageViewCell.image == self.targetAreaArray[self.selectedRow] {
                        cell.nextImage.alpha = 1
                        cell.nextImage.isEnabled = true
                        cell.previousImage.alpha = 0
                        cell.previousImage.isEnabled = false
                    } else {
                        cell.nextImage.alpha = 0
                        cell.nextImage.isEnabled = false
                        cell.previousImage.alpha = 1
                        cell.previousImage.isEnabled = true
                    }
                }
                //
                self.updateProgress()
            //
            }, completion: { finished in
                self.tableView.reloadData()
                self.tableView.reloadData()
            })
            
            //
            // Next Round Alert
            // Alert View
            let titleString = "round" + String(self.sessionScreenRoundIndex + 1)
            let title = NSLocalizedString(titleString, comment: "")
            //let message = NSLocalizedString("resetMessage", comment: "")
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
        self.restAlert.addAction(skipAction)
        //
        self.present(restAlert, animated: true, completion: {
        })
        
    }
    
    
    
    
    
    
    //
    // Pocket Mode ------------------------------------------------------------------------------------------------------
    //
    let blurEffectView = UIVisualEffectView()
    let hideLabel = UILabel()
    //
    @IBAction func hideScreenAction() {
        // Blur
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let screenSize = UIScreen.main.bounds
        blurEffectView.effect = blurEffect
        blurEffectView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        
        // Triple Tap
        let tripleTap = UITapGestureRecognizer()
        tripleTap.numberOfTapsRequired = 3
        tripleTap.addTarget(self, action: #selector(handleTap))
        blurEffectView.isUserInteractionEnabled = true
        blurEffectView.addGestureRecognizer(tripleTap)
        
        // Text
        hideLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        hideLabel.center = blurEffectView.center
        hideLabel.textAlignment = .center
        hideLabel.numberOfLines = 0
        hideLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        hideLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        hideLabel.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        hideLabel.alpha = 0
        hideLabel.text = NSLocalizedString("hideScreen", comment: "")
        
        //
        blurEffectView.addSubview(hideLabel)
        UIApplication.shared.keyWindow?.insertSubview(blurEffectView, aboveSubview: view)
        //
        UIView.animate(withDuration: 0.4, animations: {
            self.blurEffectView.alpha = 1
        }, completion: { finished in
            self.hideLabel.alpha = 1
        })
    }
    
    // Exit pocket mode
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        //
        self.hideLabel.alpha = 0
        
        //
        UIView.animate(withDuration: 0.4, animations: {
            self.blurEffectView.alpha = 0
        }, completion: { finished in
            //
            self.blurEffectView.removeFromSuperview()
            self.hideLabel.removeFromSuperview()
        })
    }
    
    
    //
    // Tap Handlers, buttons and funcs -------------------------------------------------------------------------------------------------------
    //
    //
    //
    // Image
    @IBAction func handleImageTap(imageTap:UITapGestureRecognizer) {
        //
        // Get Image
        let sender = imageTap.view as! UIImageView
        let tag = sender.tag
        //
        //if demonstrationArray[tag].count != 1 {
        //   sender.startAnimating()
        //}
    }
    
    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        if selectedRow < sessionArray.count - 1 {
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
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.hideScreen.alpha = 1
                if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                    if cell.imageViewCell.image == self.demonstrationArray[self.selectedRow] {
                        cell.nextImage.alpha = 1
                        cell.nextImage.isEnabled = true
                        cell.previousImage.alpha = 0
                        cell.previousImage.isEnabled = false
                    } else {
                        cell.nextImage.alpha = 0
                        cell.nextImage.isEnabled = false
                        cell.previousImage.alpha = 1
                        cell.previousImage.isEnabled = true
                    }
                } else {
                    if cell.imageViewCell.image == self.targetAreaArray[self.selectedRow] {
                        cell.nextImage.alpha = 1
                        cell.nextImage.isEnabled = true
                        cell.previousImage.alpha = 0
                        cell.previousImage.isEnabled = false
                    } else {
                        cell.nextImage.alpha = 0
                        cell.nextImage.isEnabled = false
                        cell.previousImage.alpha = 1
                        cell.previousImage.isEnabled = true
                    }
                }
                //
                // -1
                cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! WorkoutOverviewTableViewCell
                cell.setsRepsLabel.alpha = 0
                cell.explanationButton.alpha = 0
                cell.hideScreen.alpha = 0
                cell.nextImage.alpha = 0
                cell.nextImage.isEnabled = false
                cell.previousImage.alpha = 0
                cell.previousImage.isEnabled = false
                //self.tableView.reloadRows(at: [indexPath2 as IndexPath], with: UITableViewRowAnimation.none)

                //
            })
            // + 1
            if selectedRow < sessionArray.count - 1 {
                tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableViewRowAnimation.none)
            }
            
            // Next Round
            if selectedRow == sessionArray.count - 1 {
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
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.hideScreen.alpha = 1
                if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                    if cell.imageViewCell.image == self.demonstrationArray[self.selectedRow] {
                        cell.nextImage.alpha = 1
                        cell.nextImage.isEnabled = true
                        cell.previousImage.alpha = 0
                        cell.previousImage.isEnabled = false
                    } else {
                        cell.nextImage.alpha = 0
                        cell.nextImage.isEnabled = false
                        cell.previousImage.alpha = 1
                        cell.previousImage.isEnabled = true
                    }
                } else {
                    if cell.imageViewCell.image == self.targetAreaArray[self.selectedRow] {
                        cell.nextImage.alpha = 1
                        cell.nextImage.isEnabled = true
                        cell.previousImage.alpha = 0
                        cell.previousImage.isEnabled = false
                    } else {
                        cell.nextImage.alpha = 0
                        cell.nextImage.isEnabled = false
                        cell.previousImage.alpha = 1
                        cell.previousImage.isEnabled = true
                    }
                }
                // - 1
                if self.selectedRow > 0 {
                    cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! WorkoutOverviewTableViewCell
                    cell.setsRepsLabel.alpha = 0
                    cell.movementLabel.alpha = 0
                    cell.explanationButton.alpha = 0
                    cell.hideScreen.alpha = 0
                }
                // + 1
                cell = self.tableView.cellForRow(at: indexPath3 as IndexPath) as! WorkoutOverviewTableViewCell
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 0
                cell.hideScreen.alpha = 0
                cell.nextImage.alpha = 0
                cell.previousImage.alpha = 0
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
        
        // Contents
        //
        explanationLabel.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        explanationLabel.textColor = .black
        explanationLabel.textAlignment = .natural
        explanationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        explanationLabel.numberOfLines = 0
        //
        let attributedStringE = NSMutableAttributedString(string: NSLocalizedString(explanationArray[selectedRow], comment: ""))
        let paragraphStyleEE = NSMutableParagraphStyle()
        paragraphStyleEE.alignment = .natural
        //
        attributedStringE.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyleEE, range: NSMakeRange(0, attributedStringE.length))
        //
        explanationLabel.attributedText = attributedStringE
        //
        explanationLabel.frame = CGRect(x: 10, y: 10, width: bounds.width - 20, height: 0)
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
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.scrollViewExplanation.center.y = (((bounds.height - 20)/2) * 1.5) + 20
            self.backgroundViewExplanation.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract Explanation
    @IBAction func retractExplanation(_ sender: Any) {
        let bounds = UIScreen.main.bounds
        //
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
    
    
    //
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! WorkoutOverviewTableViewCell
        //
        switch extraSwipe.direction {
        //
        case UISwipeGestureRecognizerDirection.left:
            //
            if cell.nextImage.alpha == 1 {
                //
                let snapshot1 = cell.imageViewCell.snapshotView(afterScreenUpdates: false)
                snapshot1?.bounds = cell.imageViewCell.bounds
                snapshot1?.center.x = cell.center.x
                cell.addSubview(snapshot1!)
                
                //
                if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                    cell.imageViewCell.image = targetAreaArray[indexPath.row]
                } else {
                    cell.imageViewCell.image = demonstrationArray[indexPath.row]
                }
                //
                cell.imageViewCell.reloadInputViews()
                
                //
                let snapshot2 = cell.imageViewCell.snapshotView(afterScreenUpdates: true)
                snapshot2?.bounds = cell.imageViewCell.bounds
                snapshot2?.center.x = cell.center.x + cell.frame.size.width
                cell.addSubview(snapshot2!)
                //
                cell.imageViewCell.alpha = 0
                //
                UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    snapshot1?.center.x = cell.center.x - cell.frame.size.width
                    snapshot2?.center.x = cell.center.x
                    //
                    cell.nextImage.alpha = 0
                    cell.nextImage.isEnabled = false
                    cell.previousImage.alpha = 1
                    cell.previousImage.isEnabled = true
                }, completion: { finished in
                    cell.imageViewCell.alpha = 1
                    snapshot1?.removeFromSuperview()
                    snapshot2?.removeFromSuperview()
                })
                //
            }
        //
        case UISwipeGestureRecognizerDirection.right:
            //
            if cell.previousImage.alpha == 1 {
                //
                let snapshot1 = cell.imageViewCell.snapshotView(afterScreenUpdates: false)
                snapshot1?.bounds = cell.imageViewCell.bounds
                snapshot1?.center.x = cell.center.x
                cell.addSubview(snapshot1!)
                
                //
                if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                    cell.imageViewCell.image = demonstrationArray[indexPath.row]
                } else {
                    cell.imageViewCell.image = targetAreaArray[indexPath.row]
                }
                
                //
                let snapshot2 = cell.imageViewCell.snapshotView(afterScreenUpdates: true)
                snapshot2?.bounds = cell.imageViewCell.bounds
                snapshot2?.center.x = cell.center.x - cell.frame.size.width
                cell.addSubview(snapshot2!)
                
                //
                cell.imageViewCell.alpha = 0
                //
                UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    snapshot1?.center.x = cell.center.x + cell.frame.size.width
                    snapshot2?.center.x = cell.center.x
                    //
                    cell.nextImage.alpha = 1
                    cell.nextImage.isEnabled = true
                    cell.previousImage.alpha = 0
                    cell.previousImage.isEnabled = false
                }, completion: { finished in
                    cell.imageViewCell.alpha = 1
                    snapshot1?.removeFromSuperview()
                    snapshot2?.removeFromSuperview()
                })
                //
            }
        default: break
        }
    }
    
    
    //
    // Next Image Buttons
    @IBAction func nextImageAction() {
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! WorkoutOverviewTableViewCell
        //
        //
        if cell.nextImage.alpha == 1 {
            //
            let snapshot1 = cell.imageViewCell.snapshotView(afterScreenUpdates: false)
            snapshot1?.bounds = cell.imageViewCell.bounds
            snapshot1?.center.x = cell.center.x
            cell.addSubview(snapshot1!)
            
            //
            if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                cell.imageViewCell.image = targetAreaArray[indexPath.row]
            } else {
                cell.imageViewCell.image = demonstrationArray[indexPath.row]
            }
            //
            cell.imageViewCell.reloadInputViews()
            
            //
            let snapshot2 = cell.imageViewCell.snapshotView(afterScreenUpdates: true)
            snapshot2?.bounds = cell.imageViewCell.bounds
            snapshot2?.center.x = cell.center.x + cell.frame.size.width
            cell.addSubview(snapshot2!)
            //
            cell.imageViewCell.alpha = 0
            //
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                snapshot1?.center.x = cell.center.x - cell.frame.size.width
                snapshot2?.center.x = cell.center.x
                //
                cell.nextImage.alpha = 0
                cell.nextImage.isEnabled = false
                cell.previousImage.alpha = 1
                cell.previousImage.isEnabled = true
            }, completion: { finished in
                cell.imageViewCell.alpha = 1
                snapshot1?.removeFromSuperview()
                snapshot2?.removeFromSuperview()
            })
            //
        }
    }
    
    //
    // Previous Image Buttons
    @IBAction func previousImageAction() {
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! WorkoutOverviewTableViewCell
        //
        //
        if cell.previousImage.alpha == 1 {
            //
            let snapshot1 = cell.imageViewCell.snapshotView(afterScreenUpdates: false)
            snapshot1?.bounds = cell.imageViewCell.bounds
            snapshot1?.center.x = cell.center.x
            cell.addSubview(snapshot1!)
            
            //
            if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                cell.imageViewCell.image = demonstrationArray[indexPath.row]
            } else {
                cell.imageViewCell.image = targetAreaArray[indexPath.row]
            }
            
            //
            let snapshot2 = cell.imageViewCell.snapshotView(afterScreenUpdates: true)
            snapshot2?.bounds = cell.imageViewCell.bounds
            snapshot2?.center.x = cell.center.x - cell.frame.size.width
            cell.addSubview(snapshot2!)
            
            //
            cell.imageViewCell.alpha = 0
            //
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                snapshot1?.center.x = cell.center.x + cell.frame.size.width
                snapshot2?.center.x = cell.center.x
                //
                cell.nextImage.alpha = 1
                cell.nextImage.isEnabled = true
                cell.previousImage.alpha = 0
                cell.previousImage.isEnabled = false
            }, completion: { finished in
                cell.imageViewCell.alpha = 1
                snapshot1?.removeFromSuperview()
                snapshot2?.removeFromSuperview()
            })
            //
        }
    }
    
    //
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
}
