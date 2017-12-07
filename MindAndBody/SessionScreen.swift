//
//  SessionScreenOverview.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 16.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


//
// Custom Overview Tableview Cells ---------------------------------------------------------------------------
//
// Overview TableView Cell
class OverviewTableViewCell: UITableViewCell {
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
    // Button View
    @IBOutlet weak var buttonView: UIView!
    // Explanation
    @IBOutlet weak var explanationButton: UIButton!
    //
    // CountdownLabel, if timed workout
    //
}

// Overview End Cell
class EndTableViewCell: UITableViewCell {
    // Title Label
    @IBOutlet weak var titleLabel: UILabel!
}


//
// Session Screen Overview Class ------------------------------------------------------------------------------------
//
class SessionScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    // Sets
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] sets array
    var setsArray: [Int] = []
    
    // Reps
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [3] reps array
    var repsArray: [String] = []
    
    
    // To Add (@2x or @3x) for demonstration images
    var toAdd = String()
    
    
    //
    
    //
    // Outlets -----------------------------------------------------------------------------------------------------------
    //
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Top layout constraint for finish early button, used to relayout to take account of the rest timer
    @IBOutlet weak var finishEarlyTop: NSLayoutConstraint!
    
    //
    @IBOutlet weak var restTimeView: UIView!
    @IBOutlet weak var restTimeHeight: NSLayoutConstraint!
    @IBOutlet weak var restTimeTitleLabel: UILabel!
    @IBOutlet weak var restTimeTimeLabel: UILabel!
    @IBOutlet weak var restTimeSkipButton: UIButton!
    // Timer Variables
    var timerValue = Int()
    var didSetEndTime = false
    var startTime = Double()
    var endTime = Double()
    var isTiming = false
    
    
    // Progress Bar
    let progressBar = UIProgressView()
    
    //
    @IBOutlet weak var finishEarly: UIButton!
    
    //
    var didEnterBackground = false
    
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
                // MARK: Walkthrough
                let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                if walkthroughs["Sessions"] == false {
                    self.walkthroughSession()
                }
            }
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        didEnterBackground = true
    }
    
    
    //
    // MARK: View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        if fromCustom == false {
            // Loop session
            for i in 0..<(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?.count)! {
                keyArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]!["movement"] as! String)
                setsArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]!["sets"] as! Int)
                repsArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]!["reps"] as! String)
            }
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
        view.backgroundColor = Colors.dark
        
        //
        finishEarly.tintColor = Colors.red
        
        //
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
        
        // Rest Time View Layout
        restTimeView.backgroundColor = Colors.dark
        restTimeView.alpha = 0
        restTimeHeight.constant = 0
        //
        restTimeTitleLabel.text = NSLocalizedString("rest:", comment: "")
        restTimeTitleLabel.textColor = Colors.light
        restTimeTimeLabel.textColor = Colors.light
        restTimeSkipButton.setTitle(NSLocalizedString("skip", comment: ""), for: .normal)
        restTimeSkipButton.setTitleColor(Colors.red, for: .normal)
        restTimeSkipButton.addTarget(self, action: #selector(skipRest), for: .touchUpInside)
        
        // Buttons
        //
        fillButtonArray()
        //
        
    }
    
    //
    // MARK: TableView ---------------------------------------------------------------------------------------------------------------------
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
            if header.subviews.contains(progressBar) == false {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as! OverviewTableViewCell
            //
            let key = keyArray[indexPath.row]
            //
            cell.buttonView.layoutIfNeeded()
            //
            // Clean Cell
            for v in cell.buttonView.subviews {
                v.removeFromSuperview()
            }
            //
            // Cell
            cell.backgroundColor = Colors.dark
            cell.tintColor = Colors.dark
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.selectionStyle = .none
            
            
            // New image to display
            // Demonstration on left
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let defaultImage = settings["DefaultImage"]![0]
            if defaultImage == 0 {
                // [key] = key, [0] = first image
                cell.imageViewCell.image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
                // Indicator
                if (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!).count > 1 {
                    cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                } else {
                    cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                }
                cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                // Target Area on left
            } else {
                // [key] = key
                cell.imageViewCell.image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])! + toAdd)
                // Indicator
                if (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!).count > 1 {
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
            cell.movementLabel.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0] , comment: "")
            
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 27)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            //
            // Sets x Reps
            // String
            var setsRepsString = String()
            let setsString = String(setsArray[indexPath.row])
            setsRepsString = setsString + " x " + repsArray[indexPath.row]
            // Indicate asymmetric exercises to the user
            // If asymmetric movement array contains the current movement
            if (sessionData.asymmetricMovements[SelectedSession.shared.selectedSession[0]]?.contains(key))! {
                // Append indicator
                let length = setsRepsString.count
                let stringToAdd = NSLocalizedString(") per side", comment: "")
                let length2 = stringToAdd.count
                setsRepsString = "(" + setsRepsString + stringToAdd
                let attributedString = NSMutableAttributedString(string: setsRepsString, attributes: [NSAttributedStringKey.font:UIFont(name: "SFUIDisplay-thin", size: 23.0)!])
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
                cell.setsRepsLabel?.text = setsRepsString
            }
            //
            cell.setsRepsLabel?.textAlignment = .center
            cell.setsRepsLabel.adjustsFontSizeToFitWidth = true
            
            //
            // Explanation
            cell.explanationButton.tintColor = Colors.light
            
            //
            // Button Stuff
            //
            // Button Tag
            for b in buttonArray[indexPath.row] {
                b.tag = indexPath.row
            }
            //
            // Set Button View
            cell.buttonView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            //
            // Stack View
            let stackView = UIStackView(arrangedSubviews: buttonArray[indexPath.row])
            //
            // Layout
            let numberOfButtons = CGFloat(setsArray[indexPath.row])
            let xValue = ((cell.buttonView.frame.size.width - (numberOfButtons * 42.875)) / (numberOfButtons + 1))
            let yValue = (cell.buttonView.frame.size.height - 42.875) / 2
            let widthValue1 =
                (numberOfButtons - 1) * (cell.buttonView.frame.size.width - (numberOfButtons * 42.875))
            let widthValue2 = (widthValue1 / (numberOfButtons + 1)) + (numberOfButtons * 42.875)
            // Layout formula
            stackView.frame = CGRect(x: xValue, y: yValue, width: widthValue2, height: 42.875)
            //
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            //
            cell.buttonView.addSubview(stackView)
            //
            // Set Buttons
            // Disable pressed buttons
            let indexOfUnpressedButton = buttonNumber[indexPath.row]
            if indexOfUnpressedButton > 0 {
                for s in 0...indexOfUnpressedButton - 1 {
                    //
                    buttonArray[indexPath.row][s].isEnabled = false
                    buttonArray[indexPath.row][s].backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                }
            }
            //
            // Enable next unpressed button
            if indexOfUnpressedButton == setsArray[indexPath.row] {
            } else {
                buttonArray[indexPath.row][indexOfUnpressedButton].isEnabled = true
            }
            
            
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
            case selectedRow - 1:
                cell.indicatorStack.alpha = 0
                cell.movementLabel.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.buttonView.alpha = 0
                cell.explanationButton.alpha = 0
            //
            case selectedRow:
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
                //cell.demonstrationImageView.isUserInteractionEnabled = true
            //
            case selectedRow + 1:
                //
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.selectionStyle = .none
                //
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 0
                cell.explanationButton.alpha = 0
                //cell.demonstrationImageView.isUserInteractionEnabled = false
            //
            default:
                //
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
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
            case selectedRow - 1, selectedRow:
                return (UIScreen.main.bounds.height - toMinus) * 7/8
            case selectedRow + 1:
                return (UIScreen.main.bounds.height - toMinus) * 1/8
            default:
                return (UIScreen.main.bounds.height - toMinus) * 1/8
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
        // End button
        case 1:
            //
            // Schedule Tracking
            updateScheduleTracking(fromSchedule: fromSchedule)
            //
            self.dismiss(animated: true)
            
        //
        default: break
        }
    }
    
    //
    // MARK: Set Buttons and Rest Timers --------------------
    //
    //
    // MARK: Set Buttons -----------------------------------------------------------------------------------------------
    //
    // Button Array
    var buttonArray = [[UIButton]]()
    // Set Button Action
    var buttonNumber = [Int]()
    //
    // Generate Buttons
    func createButton() -> UIButton {
        //
        let setButton = UIButton()
        let widthHeight = NSLayoutConstraint(item: setButton, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: setButton, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        setButton.addConstraints([widthHeight])
        setButton.frame = CGRect(x: 0, y: 0, width: 42.875, height: 42.875)
        setButton.layer.borderWidth = 3
        setButton.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        setButton.layer.cornerRadius = 21.4375
        setButton.addTarget(self, action: #selector(setButtonAction), for: .touchUpInside)
        setButton.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        setButton.isEnabled = false
        //
        return setButton
    }
    
    // Set Button
    @IBAction func setButtonAction(sender: UIButton) {
        // Do nothing if a set button has already been presssed
        // Do something if not
        if isTiming == false {
            //
            // Rest Timer Notification
            let content = UNMutableNotificationContent()
            content.title = NSLocalizedString("restOver", comment: "")
            content.body = NSLocalizedString("nextSet", comment: "")
            content.sound = UNNotificationSound.default()
            //
            let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let restTime = settings["RestTimes"]![1]
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(restTime), repeats: false)
            let request = UNNotificationRequest(identifier: "restTimer", content: content, trigger: trigger)
            //
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            // Start rest timer
            startTimer()
            
            //
            // Button editing, colour etc..
            let buttonRow = sender.tag
            //
            buttonArray[buttonRow][buttonNumber[buttonRow]].isEnabled = false
            // Increase Button Number
            if self.setsArray[buttonRow] == 0 {
            } else {
                if self.buttonNumber[buttonRow] < self.setsArray[buttonRow] {
                    self.buttonNumber[buttonRow] = self.buttonNumber[buttonRow] + 1
                }
            }
            // Enable After Delay
            let delayInSeconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                if self.setsArray[buttonRow] == 0 {
                } else {
                    if self.buttonNumber[buttonRow] < self.setsArray[buttonRow] {
                        self.buttonArray[buttonRow][self.buttonNumber[buttonRow]].isEnabled = true
                    }
                }
            }
            //
            sender.isEnabled = false
            sender.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            //
            updateProgress()
        }
    }
    
    
    // Generate an Array of Arrays of Buttons
    //
    func fillButtonArray() {
        for i in 0...(setsArray.count - 1){
            //
            var buttonArray2 = [UIButton]()
            //
            for _ in 1...setsArray[i]{
                buttonArray2 += [createButton()]
            }
            //
            buttonArray += [buttonArray2]
            buttonNumber.append(0)
        }
        buttonArray[0][0].isEnabled = true
    }
    
    //
    // MARK: Timer Functions
    //
    // Update and Format Timer
    // Timer CountDown Title
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Update Timer
    @objc func updateTimer() {
        //
        if timerValue == 0 {
            //
            restTimeHeight.constant = 0
            finishEarlyTop.constant = 7
            UIView.animate(withDuration: AnimationTimes.animationTime1) {
                self.restTimeView.alpha = 0
                self.view.layoutIfNeeded()
            }
            //
            vibratePhone()
            timerCountDown.invalidate()
            didSetEndTime = false
            isTiming = false
            NotificationCenter.default.removeObserver(self)
            //
        } else {
            timerValue -= 1
            restTimeTimeLabel.text = timeFormatted(totalSeconds: timerValue)
            //
        }
    }
    
    //
    // Start Timer
    @objc func startTimer() {
        // Dates and Times
        startTime = Date().timeIntervalSinceReferenceDate
        //
        if didSetEndTime == false {
            // Watch for enter foreground (Incase user puts app in background then returns app to foreground, timer should be updated upon enter foreground)
            NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
            // Layout
            restTimeHeight.constant = 49
            finishEarlyTop.constant = 7 + 49
            UIView.animate(withDuration: AnimationTimes.animationTime1) {
                self.restTimeView.alpha = 1
                self.view.layoutIfNeeded()
            }
            // Times
            isTiming = true
            didSetEndTime = true
            let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let duration = settings["RestTimes"]![1]
            endTime = startTime + Double(duration)
        }
        
        // Set timer value
        timerValue = Int(endTime - startTime)
        
        // Check Greater than 0
        if timerValue <= 0 {
            timerValue = 0
        }
        
        // Set Timer
        // Set initial time
        restTimeTimeLabel.text = timeFormatted(totalSeconds: timerValue)
        
        // Begin Timer
        timerCountDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    //
    // Skip Rest
    @IBAction func skipRest(sender: UIButton) {
        //
        restTimeHeight.constant = 0
        finishEarlyTop.constant = 7
        UIView.animate(withDuration: AnimationTimes.animationTime1) {
            self.restTimeView.alpha = 0
            self.view.layoutIfNeeded()
        }
        //
        vibratePhone()
        timerCountDown.invalidate()
        didSetEndTime = false
        isTiming = false
        NotificationCenter.default.removeObserver(self)
        //
    }
    
    
    
    
    //
    // MARK: Tap Handlers, buttons and funcs -------------------------------------------------------------------------------------------------------
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
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! OverviewTableViewCell
        //
        let key = keyArray[indexPath.row]
        //
        let imageCount = (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!).count
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
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let defaultImage = settings["DefaultImage"]![0]
            if defaultImage == 0 && cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") || UserDefaults.standard.string(forKey: "targetArea") == "demonstration" && cell.rightImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") {
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
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! OverviewTableViewCell
        //
        let key = keyArray[indexPath.row]
        //
        let imageCount = (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!).count
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
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let defaultImage = settings["DefaultImage"]![0]
            if defaultImage == 0 && cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") || UserDefaults.standard.string(forKey: "targetArea") == "demonstration" && cell.rightImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") {
                if imageCount != 1 {
                    cell.imageViewCell.startAnimating()
                }
            }
        }
    }
    
    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        if selectedRow < keyArray.count - 1 {
            //
            selectedRow += 1
            updateProgress()
            //
            //
            let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
            let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
            let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)
            //
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! OverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                // 1
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 27)
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
                //
                // -1
                cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! OverviewTableViewCell
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 0
                cell.buttonView.alpha = 0
                cell.explanationButton.alpha = 0
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
            }, completion: { finished in
                //                self.playAnimation(row: self.selectedRow)
            })
            // + 1
            if selectedRow < keyArray.count - 1 {
                tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableViewRowAnimation.none)
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
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! OverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
                
                // 1
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
                // - 1
                if self.selectedRow > 0 {
                    cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! OverviewTableViewCell
                    cell.indicatorStack.alpha = 0
                    cell.setsRepsLabel.alpha = 0
                    cell.movementLabel.alpha = 0
                    cell.buttonView.alpha = 0
                    cell.explanationButton.alpha = 0
                }
                // + 1
                cell = self.tableView.cellForRow(at: indexPath3 as IndexPath) as! OverviewTableViewCell
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 0
                cell.explanationButton.alpha = 0
                //
            })
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
        
        //
        // Scroll View
        scrollViewExplanation.addSubview(explanationLabel)
        scrollViewExplanation.contentSize = CGSize(width: bounds.width, height: explanationLabel.frame.size.height + 20)
        //
        scrollViewExplanation.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        //
        // Add Views
        UIApplication.shared.keyWindow?.addSubview(backgroundViewExplanation)
        UIApplication.shared.keyWindow?.addSubview(scrollViewExplanation)
        
        //
        // Animate
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.scrollViewExplanation.center.y = (((bounds.height - 20)/2) * 1.5) + 20
            self.backgroundViewExplanation.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract Explanation
    @IBAction func retractExplanation(_ sender: Any) {
        let bounds = UIScreen.main.bounds
        //
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
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
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! OverviewTableViewCell
        //
        let key = keyArray[indexPath.row]
        let imageCount = (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!).count
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
                    var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                    let defaultImage = settings["DefaultImage"]![0]
                    if defaultImage == 0 {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["targetArea"]![0] + toAdd)
                        // Indicator
                        if imageCount > 1 {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlayDeselected")
                        } else {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                        }
                        cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                        // Target Area on left
                    } else {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![0])
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
                    var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                    let defaultImage = settings["DefaultImage"]![0]
                    if defaultImage == 0 {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![0])
                        // Indicator
                        if imageCount > 1 {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                        } else {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                        }
                        cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                        // Target Area on left
                    } else {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["targetArea"]![0] + toAdd)
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
    @IBAction func finishEarlyAction(_ sender: Any) {
        //
        // Alert View
        let title = NSLocalizedString("finishEarly", comment: "")
        let message = NSLocalizedString("finishEarlyMessageYoga", comment: "")
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
    var walkthroughTexts = ["session0", "session1", "session2", "session3", "session4", "session5", "session6", "session7", "session8", "session9", "session10", "session11"]
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
        let cellHeight = (UIScreen.main.bounds.height - toMinus) * 7/8
        
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
            walkthroughHighlight.center = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight / 2) * (25/16)) + 2)
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
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight / 2) * (27/16)) + 2)
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
            
            
            
        // Rest Timer
        case 2:
            //
            highlightSize = CGSize(width: view.bounds.width * (7/8), height: 44)
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
        case 3:
            //
            highlightSize = CGSize(width: view.bounds.width * (7/8), height: (cellHeight * (7/8)))
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight * (7/8)) / 2) + 2)
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
        case 4:
            //
            highlightSize = CGSize(width: 30, height: 15)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + 2 + ((cellHeight * (7/8))) - (15 / 2))
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
        case 5:
            // Swipe demonstration
            let leftSwipe = UIView()
            leftSwipe.frame.size = CGSize(width: 50, height: 50)
            leftSwipe.backgroundColor = Colors.light
            leftSwipe.layer.cornerRadius = 25
            leftSwipe.clipsToBounds = true
            leftSwipe.center.y = TopBarHeights.statusBarHeight + ((cellHeight * (7/8)) / 2) + 2
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
                self.highlightSize = CGSize(width: self.view.bounds.width * (7/8), height: (cellHeight * (7/8)))
                self.highlightCenter = CGPoint(x: self.view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight * (7/8)) / 2) + 2)
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
        case 6:
            //
            highlightSize = CGSize(width: 30, height: 15)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + 2 + ((cellHeight * (7/8))) - (15 / 2))
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
                rightSwipe.center.y = TopBarHeights.statusBarHeight + ((cellHeight * (7/8)) / 2) + 2
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
        // Case 8 not 7 as + 1 to walkthroughprogress twice in case 6 for label reasons (need an empty label)
        case 8:
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
        // Case 10 not 9 as + 1 to walkthroughprogress twice in case 8 for label reasons (need an empty label)
        case 10:
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
        case 11:
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
                walkthroughs["Sessions"] = true
                // Session walkthrough 2 there so this walkthrough is always seen (important note on rest timer that isnt in circuit/stretching)
                walkthroughs["Session2"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["walkthroughs"])
            })
        }
    }
    //
}

