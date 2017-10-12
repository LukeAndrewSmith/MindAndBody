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
    //
    // Key Array
    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [1] Keys Array
    var keyArray: [Int] = []
    
    // Reps
    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [3] reps array
    var repsArray: [String] = []
    
    //
    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [2] rounds array, [0] = round
    var numberOfRounds = Int()
    
    
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
        alert.view.tintColor = colour1
        alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
        self.present(alert, animated: true, completion: {
            //
            let delayInSeconds = 0.7
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                alert.dismiss(animated: true, completion: nil)
                //
                // MARK: Walkthrough
                let walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
                if walkthroughs[4] == false {
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
        
        //
        if fromCustom == false {
            keyArray = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[1] as! [Int]
            repsArray = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[3] as! [String]
            numberOfRounds = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[2][0] as! Int
        }
        
        // Device Scale for @2x and @3x of Target Area Images
        switch UIScreen.main.scale {
        case 1,2:
            toAdd = "@2x"
        case 3:
            toAdd = "@3x"
        default: break
        }

        //
        view.backgroundColor = colour2
        
       
        //
        finishEarly.tintColor = colour4
        
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutOverviewTableViewCell", for: indexPath) as! WorkoutOverviewTableViewCell
            
            //
            let key = keyArray[indexPath.row]

            //
            // Cell
            cell.backgroundColor = colour2
            cell.tintColor = colour2
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.selectionStyle = .none
            
        
            // New image to display
            // Demonstration on left
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let defaultImage = settings[5][0]
            if defaultImage == 0 {
                // [key] = key, [0] = first image
                cell.imageViewCell.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[selectedSession[0]][key]?[0])!)
                // Indicator
                if (sessionData.demonstrationDictionaries[selectedSession[0]][key]!).count > 1 {
                    cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                } else {
                    cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                }
                cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                // Target Area on left
            } else {
                // [key] = key
                cell.imageViewCell.image = getUncachedImage(named: (sessionData.targetAreaDictionaries[selectedSession[0]][key])! + toAdd)
                // Indicator
                if (sessionData.demonstrationDictionaries[selectedSession[0]][key]!).count > 1 {
                    cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImagePlayDeselected")
                } else {
                    cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                }
                cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
            }
            
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
            cell.movementLabel.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][key]!, comment: "")
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 23)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            //
            // Set and Reps
            //
            // (keyArray.count * sessionScreenRoundIndex) = first index of round
            var indexRow = (keyArray.count * sessionScreenRoundIndex) + indexPath.row
            cell.setsRepsLabel?.text = repsArray[indexRow]
            cell.setsRepsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.setsRepsLabel?.textAlignment = .right
            cell.setsRepsLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.setsRepsLabel.adjustsFontSizeToFitWidth = true
            
            //
            // Explanation
            cell.explanationButton.tintColor = colour1
            
            
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
            //
            default:
                //
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 0
                cell.explanationButton.alpha = 0
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
            cell.layer.borderColor = colour1.cgColor
            //
            if sessionScreenRoundIndex + 1 < numberOfRounds {
                cell.textLabel?.text = NSLocalizedString("endRound", comment: "") + " " + String(sessionScreenRoundIndex + 1)
            } else {
                cell.textLabel?.text = NSLocalizedString("endWorkout", comment: "")
            }
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)
            cell.textLabel?.textColor = colour1
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
            let height2 = 0.25/Double(keyArray.count - 1)
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
        case 0: break
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
                //
                // Tracking
                updateWeekProgress()
                updateMonthProgress()
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
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let restTimes = settings[4]
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
            var cell = self.tableView.cellForRow(at: indexPath0 as IndexPath) as! WorkoutOverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                // 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
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
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let restTimes = settings[4]
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
        // Get Cell
        let sender = imageTap.view as! UIImageView
        let tag = sender.tag
        let indexPath = NSIndexPath(row: tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! WorkoutOverviewTableViewCell
        //
        let key = keyArray[indexPath.row]
        //
        let imageCount = (sessionData.demonstrationDictionaries[selectedSession[0]][key]!).count
        //
        // Image Array
        if imageCount > 1 && cell.imageViewCell.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.demonstrationDictionaries[selectedSession[0]][key]![i])!)
            }
            //
            cell.imageViewCell.animationImages = animationArray
            cell.imageViewCell.animationDuration = Double(imageCount - 1) * 0.5
            cell.imageViewCell.animationRepeatCount = 1
            //
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let defaultImage = settings[5][0]
            if defaultImage == 0 && cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") || UserDefaults.standard.string(forKey: "targetArea") == "demonstration" && cell.rightImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") {
                if imageCount != 1 {
                    sender.startAnimating()
                }
            }
        }
    }
    
    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        if selectedRow < keyArray.count - 1 {
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
                //
                // -1
                cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! WorkoutOverviewTableViewCell
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.explanationButton.alpha = 0
                //
                //self.tableView.reloadRows(at: [indexPath2 as IndexPath], with: UITableViewRowAnimation.none)

                //
            })
            // + 1
            if selectedRow < keyArray.count - 1 {
                tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableViewRowAnimation.none)
            }
            
            // Next Round
            if selectedRow == keyArray.count - 1 {
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
                // - 1
                if self.selectedRow > 0 {
                    cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! WorkoutOverviewTableViewCell
                    cell.indicatorStack.alpha = 0
                    cell.setsRepsLabel.alpha = 0
                    cell.movementLabel.alpha = 0
                    cell.explanationButton.alpha = 0
                }
                // + 1
                cell = self.tableView.cellForRow(at: indexPath3 as IndexPath) as! WorkoutOverviewTableViewCell
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 0
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
        explanationLabel.attributedText = formatExplanationText(title: NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][key]!, comment: ""), howTo: NSLocalizedString(sessionData.explanationDictionaries[selectedSession[0]][key]![0], comment: ""), toAvoid: NSLocalizedString(sessionData.explanationDictionaries[selectedSession[0]][key]![1], comment: ""), focusOn: NSLocalizedString(sessionData.explanationDictionaries[selectedSession[0]][key]![2], comment: ""))
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
    
    
    //
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! WorkoutOverviewTableViewCell
        //
        let key = keyArray[indexPath.row]
        let imageCount = (sessionData.demonstrationDictionaries[selectedSession[0]][key]!).count
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
                    var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                    let defaultImage = settings[5][0]
                    if defaultImage == 0 {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.targetAreaDictionaries[selectedSession[0]][key]! + toAdd)
                        // Indicator
                        if imageCount > 1 {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlayDeselected")
                        } else {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                        }
                        cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                        // Target Area on left
                    } else {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.demonstrationDictionaries[selectedSession[0]][key]![0])
                        // Indicator
                        if imageCount > 1 {
                            cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                        } else {
                            cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                        }
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                    }
                    
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
                    var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                    let defaultImage = settings[5][0]
                    if defaultImage == 0 {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.demonstrationDictionaries[selectedSession[0]][key]![0])
                        // Indicator
                        if imageCount > 1 {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                        } else {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                        }
                        cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                        // Target Area on left
                    } else {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.targetAreaDictionaries[selectedSession[0]][key]! + toAdd)
                        // Indicator
                        if imageCount > 1 {
                            cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImagePlayDeselected")
                        } else {
                            cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                        }
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                    }
                    
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
    
    //
    @IBAction func finishEarlyAction(_ sender: Any) {
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
    func walkthroughSession() {
        //
        var cellHeight = (UIScreen.main.bounds.height - 22) * 3/4
        
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
            walkthroughLabel.textColor = colour2
            walkthroughLabel.backgroundColor = colour1
            walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width / 2, height: 36)
            walkthroughHighlight.center = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight / 2) * (28/16)) + 2)
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
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
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour1
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
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour1
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
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour1
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
            
        // Target Area
        case 4:
            // Swipe demonstration
            let leftSwipe = UIView()
            leftSwipe.frame.size = CGSize(width: 50, height: 50)
            leftSwipe.backgroundColor = colour1
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
                self.walkthroughBackgroundColor = colour1
                self.walkthroughTextColor = colour2
                self.highlightColor = colour1
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
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour1
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
                rightSwipe.backgroundColor = colour1
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
                    self.walkthroughBackgroundColor = colour1
                    self.walkthroughTextColor = colour2
                    self.highlightColor = colour1
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
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
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
                self.walkthroughBackgroundColor = colour1
                self.walkthroughTextColor = colour2
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
                upSwipe.backgroundColor = colour1
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
                    self.walkthroughBackgroundColor = colour1
                    self.walkthroughTextColor = colour2
                    self.highlightColor = colour1
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
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour1
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
                var walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
                walkthroughs[4] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            })
        }
    }
//
}
