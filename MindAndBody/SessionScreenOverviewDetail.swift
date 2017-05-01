//
//  SessionScreenOverviewDetail2.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 23.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import UserNotifications


//
// Session Screen Overview Detail Class -------------------------------------------------------------------
//
class SessionScreenOverviewDetail: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {
    
    
//
// Receive Arrays --------------------------------------------------------------------------------------------
//
    //
    var sessionType = Int()
    
    // Selected Movement
    //
    var selectedMovement = Int()
    
    // Initialize Arrays
    //
    // Movement Array
    var sessionArray: [String] = []
    
    // Sets Array
    var setsArray: [Int] = []
    
    // Reps Array
    var repsArray: [String] = []
    
    // Demonstration Array
    var demonstrationArray: [UIImage] = []
    
    // Target Area Array
    var targetAreaArray: [UIImage] = []
    
    // Explanation Array
    var explanationArray: [String] = []
    
    
//
// Outlets -----------------------------------------------------------------------------------------------------
//
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    //
    let navigationTitle = UILabel()
    
    // Set Rep
    @IBOutlet weak var setRepView: UIView!
    // Buttons
    var setButton1 = UIButton()
    var setButton2 = UIButton()
    var setButton3 = UIButton()
    
    // Image View
    @IBOutlet weak var imageScroll: UIScrollView!
    
    // Explanation Expand
    @IBOutlet weak var explanationExpand: UIButton!
    
    // Timer
    // Timer View
    var timerView = UIView()
    // Timer Elements
    // Timer Countdown Label
    let countDownLabel = UILabel()
    // Timer Countdown
    var timerCountDown = Timer()
    // Timer Value
    var timerValue = 0
    // Timer Start
    var timerStart = UIButton()
    // Timer Cancel
    var timerCancel = UIButton()
    // Picker View
    // Picker Data
    var minuteData = [Int]()
    var secondData = [Int]()
    // Picker Views
    let minutePicker = UIPickerView()
    let secondPicker = UIPickerView()
    let minuteLabel = UILabel()
    let secondLabel = UILabel()
    var pickerViewTimer = UIView()
    
    // Timer Show Buttons
    @IBOutlet weak var timerButton: UIButton!
    
    // Progress Bar
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    //
    @IBOutlet weak var progressBarLeft: NSLayoutConstraint!
    
    // Title Labels
    // Sets and Reps
    @IBOutlet weak var setsRepsLabel: UILabel!
    @IBOutlet weak var weightSuggestion: UILabel!
    // Explanation Text
    let explanationText = UILabel()
    // Progress Label
    @IBOutlet weak var progressLabel: UILabel!
    
    // Hide Screen
    @IBOutlet weak var hideScreen: UIButton!
    
    // Image Scroll
    //
    @IBOutlet weak var targetAreaButton: UIButton!
    //
    @IBOutlet weak var demonstrationImageButton: UIButton!
    
    // Images
    let demonstrationImage = UIImageView()
    let bodyImage = UIImageView()
    //
    var imageExpanded = false
    
    // Button Stack View Height
    @IBOutlet weak var buttonStackHeight: NSLayoutConstraint!

    
//
// View did load --------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Iphone 5/SE layout
        //
        if UIScreen.main.nativeBounds.height < 1334 {
            buttonStackHeight.constant = 49
        }
        
        // Navigation
        self.navigationController?.navigationBar.tintColor = colour1
        navigationController?.delegate = self
        
        // Background Gradient
        //
        self.view.applyGradient(colours: [colour1, colour1])
        
        // Images
        //
        // Demonstration Image
        demonstrationImage.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        imageScroll.addSubview(demonstrationImage)
        //
        let imageSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        imageSwipeLeft.direction = UISwipeGestureRecognizerDirection.left
        demonstrationImage.addGestureRecognizer(imageSwipeLeft)
        demonstrationImage.isUserInteractionEnabled = true
        
        // Body Image
        bodyImage.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        imageScroll.addSubview(bodyImage)
        //
        let imageSwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        imageSwipeRight.direction = UISwipeGestureRecognizerDirection.right
        bodyImage.addGestureRecognizer(imageSwipeRight)
        bodyImage.isUserInteractionEnabled = true
        
        // Weight suggestion
        if sessionType != 1 {
            weightSuggestion.removeFromSuperview()
        }
        
        // Set Rep View
        setRepView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        // Explanation Text
        explanationText.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        explanationText.textColor = .black
        explanationText.textAlignment = .natural
        explanationText.lineBreakMode = NSLineBreakMode.byWordWrapping
        explanationText.numberOfLines = 0
        
        // Expand Button
        let origImage1 = UIImage(named: "QuestionMarkM")
        let tintedImage1 = origImage1?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        explanationExpand.setImage(tintedImage1, for: .normal)
        //Image Tint
        explanationExpand.tintColor = colour2
        
        //
        // Timer
        //
        // Image With Tint
        let origImage3 = UIImage(named: "Timer")
        let tintedImage3 = origImage3?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        timerButton.setImage(tintedImage3, for: .normal)
        //Image Tint
        timerButton.tintColor = colour2
        // Timer View
        timerView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        // Timer Elements
        //
        // Picker View Timer
        //
        pickerViewTimer.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        //
        // Pick Minutes
        minutePicker.frame = CGRect(x: 10, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        minutePicker.dataSource = self
        minutePicker.delegate = self
        minutePicker.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        //
        minuteLabel.text = NSLocalizedString("minutes", comment: "")
        minuteLabel.font = UIFont(name: "SFUIDisplay-light", size: 19)
        minuteLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        minuteLabel.textAlignment = .left
        //
        // Pick Seconds
        secondPicker.dataSource = self
        secondPicker.delegate = self
        secondPicker.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        //
        secondLabel.text = NSLocalizedString("seconds", comment: "")
        secondLabel.font = UIFont(name: "SFUIDisplay-light", size: 19)
        secondLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        secondLabel.textAlignment = .left
        //
        // Picker View Data
        minuteData = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 30]
        secondData = [0, 15, 30, 45]
        //
        // Start Button Timer
        timerStart.backgroundColor = colour1
        timerStart.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
        timerStart.setTitleColor(colour2, for: .normal)
        timerStart.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        timerStart.titleLabel?.textAlignment = .center
        //
        timerStart.addTarget(self, action: #selector(startTimer(_:)), for: .touchUpInside)
        //
        // Cancel Button Timer
        timerCancel.backgroundColor = colour1
        timerCancel.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        timerCancel.setTitleColor(colour2, for: .normal)
        timerCancel.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        timerCancel.titleLabel?.textAlignment = .center
        //
        timerCancel.addTarget(self, action: #selector(cancelTimer(_:)), for: .touchUpInside)
        //
        // Countdown Label
        countDownLabel.textAlignment = .center
        countDownLabel.font = UIFont(name: "SFUIDisplay-Light", size: 43)
        countDownLabel.text = "00:00"
        countDownLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        // App Moved To Background
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        // Progress Bar
        //
        // Thickness
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        // Initial state
        progressBar.setProgress(0, animated: true)
        // Colour
        progressBar.trackTintColor = colour2
        progressBar.progressTintColor = colour3
        //

        // Display Content
        // Navigation Bar
        navigationTitle.text = NSLocalizedString(sessionArray[selectedMovement], comment: "")
        // Navigation Title
        navigationTitle.frame = (navigationController?.navigationItem.accessibilityFrame)!
        navigationTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        navigationTitle.center.x = self.view.center.x
        navigationTitle.textColor = colour1
        navigationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 22)
        navigationTitle.backgroundColor = .clear
        navigationTitle.textAlignment = .center
        navigationTitle.adjustsFontSizeToFitWidth = true
        self.navigationController?.navigationBar.barTintColor = colour2
        //
        navigationBar.titleView = navigationTitle
        
        // Images
        //
        demonstrationImage.image = demonstrationArray[selectedMovement]
        //
        bodyImage.image = targetAreaArray[selectedMovement]
        // Scroll
        imageScroll.contentOffset.x = 0
        //
        demonstrationImageButton.alpha = 0
        demonstrationImageButton.isEnabled = false
        //
        targetAreaButton.alpha = 1
        targetAreaButton.isEnabled = true
        
        // Set Buttons
        //
        let setRepSubViews = self.setRepView.subviews
        for subview in setRepSubViews{
            subview.removeFromSuperview()
        }
        buttonArray = []
        createButtonArray()
        // Stack View
        //
        let stackView = UIStackView(arrangedSubviews: buttonArray)
        buttonArray[0].isEnabled = true
        let numberOfButtons2 = CGFloat(setsArray[selectedMovement])
        // Set Button Layout
        //
        let xValue = ((view.frame.size.width - (numberOfButtons2 * 42.875)) / CGFloat(numberOfButtons2 + 1))
        let yValue = (setRepView.frame.size.height - 42.875) / 2
        let widthValue1 =
            CGFloat(numberOfButtons2 - 1) * CGFloat(view.frame.size.width - (numberOfButtons2 * 42.875))
        let widthValue2 = (CGFloat(widthValue1) / CGFloat(numberOfButtons2 + 1)) + (numberOfButtons2 * 42.875)
        // Layout formula
        stackView.frame = CGRect(x: xValue, y: yValue, width: widthValue2, height: 42.875)
        //
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        //
        setRepView.addSubview(stackView)
        
        // Timer to Back
        self.view.bringSubview(toFront: timerButton)
        cancelTimer(Any.self)
        
        // Title Labels
        // Sets Reps
        self.setsRepsLabel.text = (String(setsArray[selectedMovement]) + " x " + repsArray[selectedMovement])
        // Progress
        self.progressLabel.text = (String(selectedMovement + 1)+"/"+String(sessionArray.count))
        //
        setsRepsLabel.textColor = colour2
        progressLabel.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        // Progress Bar
        let sessionIndexP = Float(selectedMovement)
        let sessionArrayP = Float(self.sessionArray.count)
        //
        let fractionalProgress = sessionIndexP/sessionArrayP
        //
        progressBar.setProgress(fractionalProgress, animated: true)
        
        
        // Image Scroll
        //
        imageScroll.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        imageScroll.contentSize = CGSize(width: imageScroll.frame.size.width * 2, height: imageScroll.frame.size.height)
        imageScroll.isScrollEnabled = false
        
        // Demonstration Image
        demonstrationImage.frame = imageScroll.bounds
        demonstrationImage.contentMode = .scaleAspectFit
        
        // Body Image
        bodyImage.frame = CGRect(x: imageScroll.frame.size.width, y: 0, width: imageScroll.frame.size.width, height: imageScroll.frame.size.height)
        bodyImage.contentMode = .scaleAspectFit
        
        // Image Scroll Position on Target Area
        //
        imageScroll.contentOffset.x = imageScroll.frame.size.width
        //
        targetAreaButton.isEnabled = false
        targetAreaButton.alpha = 0
        //
        demonstrationImageButton.isEnabled = true
        demonstrationImageButton.alpha = 1
    }
    
    
//
// View did layout subviews ----------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    
    
//
// Generate Buttons ----------------------------------------------------------------------------------------------
//
    // Create Buttons
    func createButton() -> UIButton {
        let setButton = UIButton()
        let widthHeight = NSLayoutConstraint(item: setButton, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: setButton, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        setButton.addConstraints([widthHeight])
        setButton.frame = CGRect(x: 0, y: 0, width: 42.875, height: 42.875)
        setButton.layer.borderWidth = 4
        setButton.layer.borderColor = colour1.cgColor
        setButton.layer.cornerRadius = 21.4375
        setButton.addTarget(self, action: #selector(setButtonAction), for: .touchUpInside)
        setButton.backgroundColor = colour2
        setButton.isEnabled = false
        //
        setRepView.addSubview(setButton)
        //
        return setButton
    }
    
    // Create Button Array
    var buttonArray = [UIButton]()
    //
    func createButtonArray(){
        //
        let numberOfButtons = setsArray[selectedMovement]
        //
        for _ in 1...numberOfButtons{
            buttonArray += [createButton()]
        }
        // Set Buttons
        //
        // Disable pressed buttons
        let indexOfUnpressedButton = buttonNumber[selectedMovement]
        if indexOfUnpressedButton > 0 {
            for s in 0...indexOfUnpressedButton - 1 {
                //
                buttonArray[s].isEnabled = false
                buttonArray[s].backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            }
        }
        // Enable next unpressed button
        if indexOfUnpressedButton == setsArray[selectedMovement] {
        } else {
            buttonArray[indexOfUnpressedButton].isEnabled = true
        }
    }
    
    
//
// Flash Screen ---------------------------------------------------------------------------------------------------------------------
//
    func flashScreen() {
        //
        let flash = UIView()
        //
        flash.frame = CGRect(x: 0, y: -100, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        //
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
            //
            flash.alpha = 0
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
    }
    

//
// CountDown Timer -------------------------------------------------------------------------------------------
//
    var isTiming = false
    //
    // Timer CountDown Value
    func setTimerValue() {
        //
        let minutesSelectedRow = minutePicker.selectedRow(inComponent: 0)
        let minutes = minuteData[minutesSelectedRow]
        //
        let secondsSelectedRow = secondPicker.selectedRow(inComponent: 0)
        let seconds = secondData[secondsSelectedRow]
        //
        self.timerValue = (minutes * 60) + seconds
    }
    
    // Timer CountDown Title
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Update Timer
    func updateTimer() {
        //
        if timerValue == 0{
            self.timerCountDown.invalidate()
            removeCircle()
            timerView.bringSubview(toFront: timerStart)
            countDownLabel.removeFromSuperview()
            pickerViewTimer.alpha = 1
            isTiming = false
        //
        } else if timerValue == 1 {
            timerValue -= 1
            countDownLabel.text = timeFormatted(totalSeconds: timerValue)
        //
        } else {
            timerValue -= 1
            countDownLabel.text = timeFormatted(totalSeconds: timerValue)
        }
    }
    
    //
    let timerShapeLayer = CAShapeLayer()
    // Funcs
    // Add Circle
    func addCircle() {
        let circlePath = UIBezierPath(arcCenter: countDownLabel.center, radius: CGFloat((pickerViewTimer.frame.size.height-10)/2), startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(2*M_PI-M_PI_2), clockwise: true)
        timerShapeLayer.path = circlePath.cgPath
        timerShapeLayer.fillColor = UIColor.clear.cgColor
        timerShapeLayer.strokeColor = colour1.cgColor
        timerShapeLayer.lineWidth = 1.0
        //
        timerView.layer.addSublayer(timerShapeLayer)
    }
    
    // Remove Circle
    func removeCircle() {
        timerShapeLayer.removeFromSuperlayer()
    }
    
    // Start Animation
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double(timerValue)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        //
        timerShapeLayer.add(animation, forKey: "circleAnimation")
    }
    
    // Start Timer
    @IBAction func startTimer(_ sender: Any) {
        //
        setTimerValue()
        isTiming = true
        //
        if timerValue == 0 {
        } else {
            //
            self.timerView.bringSubview(toFront: timerCancel)
            //
            pickerViewTimer.alpha = 0
            timerView.addSubview(countDownLabel)
            timerView.bringSubview(toFront: countDownLabel)
            //
            self.countDownLabel.text = timeFormatted(totalSeconds: timerValue)
            
            //
            let delayInSeconds = 0.1
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                //
                self.addCircle()
                self.startAnimation()
                self.timerCountDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
               
                //
                let content = UNMutableNotificationContent()
                content.title = NSLocalizedString("timerEnd", comment: "")
                content.body = " "
                content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
                content.sound = UNNotificationSound.default()
                //
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(self.timerValue), repeats: false)
                let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
                //
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                //
            }
        }
    }
    
    // Cancel Timer
    @IBAction func cancelTimer(_ sender: Any) {
        //
        self.timerCountDown.invalidate()
        self.timerValue = 0
        self.countDownLabel.text = "00:00"
        removeCircle()
        self.timerView.bringSubview(toFront: timerStart)
        countDownLabel.removeFromSuperview()
        pickerViewTimer.alpha = 1
        isTiming = false
        //
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timer"])
    }
    
    
//
// Picker View ---------------------------------------------------------------------------------------------------------------------
//
    // Number of components
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        //
        if pickerView == minutePicker {
            return 14
        } else if pickerView == secondPicker {
            return 4
        }
        //
        return 0
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        if pickerView == minutePicker {
            //
            let rowLabel = UILabel()
            let titleData = String(minuteData[row])
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 27)!,NSForegroundColorAttributeName:UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
        //
        } else if pickerView == secondPicker {
            //
            let rowLabel = UILabel()
            let titleData = String(secondData[row])
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 27)!,NSForegroundColorAttributeName:UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
        }
        return UIView()
    }
    
    // Row Height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Calcel timer if app moves to background (notification still pops up at end of time)
    func appMovedToBackground() {
        //
        self.timerCountDown.invalidate()
        self.timerValue = 0
        removeCircle()
        self.countDownLabel.text = "00:00"
        timerView.bringSubview(toFront: timerStart)
        isTiming = false
    }
    
    // Display TimerView
    //
    let backgroundViewTimer = UIButton()
    //
    @IBAction func timerViewButton(_ sender: Any) {
        // Timer View
        //
        timerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/2)
        timerView.center.x = self.view.frame.size.width/2
        timerView.center.y = (self.view.frame.size.height/2) * 2.5
        
        // Picker View Timer
        //
        pickerViewTimer.frame = CGRect(x: 0, y: 0, width: self.timerView.frame.size.width * (2/3), height: self.timerView.frame.size.height * (2/3))
        pickerViewTimer.center.x = timerView.center.x
        timerView.addSubview(pickerViewTimer)
        // Pick Minutes
        //
        minutePicker.frame = CGRect(x: 10, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        minutePicker.center.y = pickerViewTimer.center.y
        pickerViewTimer.addSubview(minutePicker)
        //
        minuteLabel.frame = CGRect(x: 10 + minutePicker.frame.size.width, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        minuteLabel.center.y = pickerViewTimer.center.y
        pickerViewTimer.addSubview(minuteLabel)
        // Pick Seconds
        //
        secondPicker.frame = CGRect(x: 10 + minutePicker.frame.size.width + minuteLabel.frame.size.width, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        secondPicker.center.y = pickerViewTimer.center.y
        pickerViewTimer.addSubview(secondPicker)
        //
        secondLabel.frame = CGRect(x: 10 + minutePicker.frame.size.width + minuteLabel.frame.size.width + secondPicker.frame.size.width, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        secondLabel.center.y = pickerViewTimer.center.y
        pickerViewTimer.addSubview(secondLabel)
        //
        timerView.addSubview(pickerViewTimer)
        
        // Start Button Timer
        //
        timerStart.frame = CGRect(x: 0, y: self.timerView.frame.size.height * (2/3), width: self.pickerViewTimer.frame.size.width, height: (self.timerView.frame.size.height*(1/3)))
        timerStart.center.x = timerView.center.x
        timerStart.layer.borderWidth = timerStart.frame.size.height/4
        timerStart.layer.borderColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0).cgColor
        timerStart.layer.cornerRadius = (timerStart.frame.height - (timerStart.frame.size.height/4)) / 2
        timerStart.clipsToBounds = true
        timerView.addSubview(timerStart)
        // Cancel Button Timer
        //
        timerCancel.frame = CGRect(x: 0, y: self.timerView.frame.size.height * (2/3), width: self.pickerViewTimer.frame.size.width, height: (self.timerView.frame.size.height*(1/3)))
        timerCancel.center.x = timerView.center.x
        timerCancel.layer.borderWidth = timerCancel.frame.size.height/4
        timerCancel.layer.borderColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0).cgColor
        timerCancel.layer.cornerRadius = (timerCancel.frame.height - (timerCancel.frame.size.height/4)) / 2
        timerCancel.clipsToBounds = true
        timerView.addSubview(timerCancel)
        
        //
        if isTiming == false {
            timerView.bringSubview(toFront: timerStart)
        } else if isTiming == true {
            timerView.bringSubview(toFront: timerCancel)
        }
        
        // Countdown Label
        countDownLabel.frame = CGRect(x: self.timerView.frame.size.width/2, y: 0, width: self.timerView.frame.size.width/2, height: self.timerView.frame.size.height)
        countDownLabel.center.x = timerView.center.x
        countDownLabel.center.y = pickerViewTimer.center.y
        
        // Background View
        //
        backgroundViewTimer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        backgroundViewTimer.backgroundColor = .black
        backgroundViewTimer.alpha = 0
        //
        backgroundViewTimer.addTarget(self, action: #selector(retractTimer(_:)), for: .touchUpInside)
        
        //
        navigationItem.setHidesBackButton(true, animated: true)
        
        //
        self.view.addSubview(timerView)
        self.view.addSubview(backgroundViewTimer)
        //
        self.view.bringSubview(toFront: timerView)
        
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.timerView.center.y = (self.view.frame.size.height/2) * 1.5
            self.backgroundViewTimer.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract Timer
    @IBAction func retractTimer(_ sender: Any) {
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.timerView.center.y = (self.view.frame.size.height/2) * 2.5
            self.backgroundViewTimer.alpha = 0
        }, completion: nil)
        //
        let delayInSeconds = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            //
            self.timerView.removeFromSuperview()
            self.backgroundViewTimer.removeFromSuperview()
        }
        //
        navigationItem.setHidesBackButton(false, animated: true)
    }
    
    
//
// Set Button Action -------------------------------------------------------------------------------------
//
    // Set Buttons
    //
    var buttonNumber = [Int]()
    // Set Button
    @IBAction func setButtonAction(sender: UIButton) {
        //
        // Rest Timer Notification
        //
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("restOver", comment: "")
        content.body = NSLocalizedString("nextSet", comment: "")
        content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
        content.sound = UNNotificationSound.default()
        //
        let restTimes = UserDefaults.standard.object(forKey: "restTimes") as! [Int]
        //
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(restTimes[sessionType]), repeats: false)
        let request = UNNotificationRequest(identifier: "restTimer", content: content, trigger: trigger)
        //
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        

        //
        buttonArray[buttonNumber[selectedMovement]].isEnabled = false
        
        // Increase Button Number
        if self.buttonArray.count == 0 {
        } else {
            if self.buttonNumber[self.selectedMovement] < self.setsArray[self.selectedMovement] {
                self.buttonNumber[self.selectedMovement] = self.buttonNumber[self.selectedMovement] + 1
            }
        }
        // Enable Button
        let delayInSeconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            if self.buttonArray.count == 0 {
            } else {
                if self.buttonNumber[self.selectedMovement] < self.setsArray[self.selectedMovement] {
                    self.buttonArray[self.buttonNumber[self.selectedMovement]].isEnabled = true
                }
            }
        }
        
        //
        sender.backgroundColor = UIColor(red: 0.88, green: 0.89, blue: 0.89, alpha: 1.0)
        sender.isEnabled = false
    }
    

//
// Explanation ---------------------------------------------------------------------------------------------------
//
    // Expand Explanation
    //
    let scrollViewExplanation = UIScrollView()
    let backgroundViewExplanation = UIButton()
    //
    let explanationLabel = UILabel()
    
    // Expand Explanation
    //
    @IBAction func expandExplanation(_ sender: Any) {
        // View
        //
        scrollViewExplanation.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 2)
        scrollViewExplanation.center.x = self.view.frame.size.width/2
        scrollViewExplanation.center.y = (self.view.frame.size.height/2) * 2.5
        //
        scrollViewExplanation.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        // Background View
        //
        backgroundViewExplanation.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
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
        let attributedStringE = NSMutableAttributedString(string: NSLocalizedString(explanationArray[selectedMovement], comment: ""))
        let paragraphStyleEE = NSMutableParagraphStyle()
        paragraphStyleEE.alignment = .natural
        //
        attributedStringE.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyleEE, range: NSMakeRange(0, attributedStringE.length))
        //
        explanationLabel.attributedText = attributedStringE
        //
        explanationLabel.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 0)
        explanationLabel.sizeToFit()
        
        // Scroll View
        scrollViewExplanation.addSubview(explanationLabel)
        scrollViewExplanation.contentSize = CGSize(width: self.view.frame.size.width, height: explanationLabel.frame.size.height + 20)
        //
        scrollViewExplanation.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        //
        navigationItem.setHidesBackButton(true, animated: true)
        
        // Add Views
        view.addSubview(scrollViewExplanation)
        view.addSubview(backgroundViewExplanation)
        //
        view.bringSubview(toFront: scrollViewExplanation)
        
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.scrollViewExplanation.center.y = (self.view.frame.size.height/2) * 1.5
            self.backgroundViewExplanation.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract Explanation
    @IBAction func retractExplanation(_ sender: Any) {
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            //
            self.scrollViewExplanation.center.y = (self.view.frame.size.height/2) * 2.5
            self.backgroundViewExplanation.alpha = 0
        }, completion: nil)
        //
        let delayInSeconds = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            //
            self.scrollViewExplanation.removeFromSuperview()
            self.backgroundViewExplanation.removeFromSuperview()
            //
            self.explanationLabel.removeFromSuperview()
        }
        
        //
        navigationItem.setHidesBackButton(false, animated: true)
    }
    
    
//
// Pocket Mode --------------------------------------------------------------------------------------------------------
//
    let blurEffectView = UIVisualEffectView()
    let hideLabel = UILabel()
    var brightness = UIScreen.main.brightness
    //
    @IBAction func hideScreen(_ sender: Any) {
        
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
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.blurEffectView.alpha = 1
            //UIScreen.main.brightness = self.brightness/2
        }, completion: nil)
        //
        let delayInSeconds = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.hideLabel.alpha = 1
        }
    }
    
    // Exit pocket mode
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        //
        self.hideLabel.alpha = 0
        
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.blurEffectView.alpha = 0
            //UIScreen.main.brightness = self.brightness/2
        }, completion: nil)
        //
        let delayInSeconds = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            //
            self.blurEffectView.removeFromSuperview()
            self.hideLabel.removeFromSuperview()
            //UIScreen.main.brightness = brightness
        }
    }
    
    
//
// Image Buttons -----------------------------------------------------------------------------------------------
//
    // Target Area Button (move to right image)
    @IBAction func targetAreaAction(_ sender: Any) {
        //
        targetAreaButton.alpha = 0
        targetAreaButton.isEnabled = false
        demonstrationImageButton.alpha = 1
        demonstrationImageButton.isEnabled = true
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.imageScroll.contentOffset.x = self.imageScroll.frame.size.width
        }, completion: nil)
    }
    
    // Demonstration Button (move to left image)
    @IBAction func demonstrationAction(_ sender: Any) {
        //
        targetAreaButton.alpha = 1
        targetAreaButton.isEnabled = true
        demonstrationImageButton.alpha = 0
        demonstrationImageButton.isEnabled = false
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.imageScroll.contentOffset.x = 0
        }, completion: nil)
    }
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        //
        if (extraSwipe.direction == .right){
            //
            targetAreaButton.alpha = 1
            targetAreaButton.isEnabled = true
            demonstrationImageButton.alpha = 0
            demonstrationImageButton.isEnabled = false
            //
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.imageScroll.contentOffset.x = 0
            }, completion: nil)
        //
        } else if extraSwipe.direction == .left {
            //
            targetAreaButton.alpha = 0
            targetAreaButton.isEnabled = false
            demonstrationImageButton.alpha = 1
            demonstrationImageButton.isEnabled = true
            //
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.imageScroll.contentOffset.x = self.imageScroll.frame.size.width
            }, completion: nil)
        }
    }
    

//
// Pass set button data back ----------------------------------------------------------------------------------------
//
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? SessionScreenOverview {
            controller.buttonNumber = buttonNumber
            controller.tableView.reloadData()
        }
    }
    
//
}
