//
//  SessionScreenTest.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 18.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import UserNotifications


//
// Session Screen Class --------------------------------------------------------------------------------------------------------
//
class SessionScreen: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
//
// Retreive Arrays ---------------------------------------------------------------------------------------------------------
//
    // Session Type
    var sessionType = Int()
    
    // Session Screen Index
    //
    var sessionScreenIndex = 0
    
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
// Outlets ---------------------------------------------------------------------------------------------------------------------
//
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    let navigationTitle = UILabel()
    // Buttons
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
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
    @IBOutlet weak var progressBar: UIProgressView!
    //
    
    // Labels
    // Sets and Reps
    @IBOutlet weak var setsRepsLabel: UILabel!
    // Weight suggestion label
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
// View did load ---------------------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough3") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough3")
        }
        
        //Iphone 5/SE layout
        //
        if UIScreen.main.nativeBounds.height < 1334 {
            buttonStackHeight.constant = 49
        }
        
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
        
        // Background Color
        //
        self.view.backgroundColor = colour1
        //
        backButton.tintColor = .clear
        
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
        //
        demonstrationImageButton.alpha = 0
        
        // Weight suggestion
        if sessionType != 1 {
            weightSuggestion.removeFromSuperview()
        }
        
        // Set Rep View
        setRepView.backgroundColor = colour2
        
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
// Timer ---------------------------------------------------------------------------------------------------------------------
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
        // Pick Minutes
        //
        minutePicker.frame = CGRect(x: 10, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        minutePicker.dataSource = self
        minutePicker.delegate = self
        minutePicker.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        //
        minuteLabel.text = NSLocalizedString("minutes", comment: "")
        minuteLabel.font = UIFont(name: "SFUIDisplay-light", size: 19)
        minuteLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        minuteLabel.textAlignment = .left
        // Pick Seconds
        //
        secondPicker.dataSource = self
        secondPicker.delegate = self
        secondPicker.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        //
        secondLabel.text = NSLocalizedString("seconds", comment: "")
        secondLabel.font = UIFont(name: "SFUIDisplay-light", size: 19)
        secondLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        secondLabel.textAlignment = .left
        // Picker View Data
        //
        minuteData = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 30]
        secondData = [0, 15, 30, 45]
        // Start Button Timer
        //
        timerStart.backgroundColor = colour1
        timerStart.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
        timerStart.setTitleColor(colour2, for: .normal)
        timerStart.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        timerStart.titleLabel?.textAlignment = .center
        //
        timerStart.addTarget(self, action: #selector(startTimer(_:)), for: .touchUpInside)
        // Cancel Button Timer
        //
        timerCancel.backgroundColor = colour1
        timerCancel.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        timerCancel.setTitleColor(colour2, for: .normal)
        timerCancel.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        timerCancel.titleLabel?.textAlignment = .center
        //
        timerCancel.addTarget(self, action: #selector(cancelTimer(_:)), for: .touchUpInside)
        // Countdown Label
        countDownLabel.textAlignment = .center
        countDownLabel.font = UIFont(name: "SFUIDisplay-Light", size: 43)
        countDownLabel.text = "00:00"
        countDownLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        // App Moved To Background
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        

//
// Progress Bar ----------------------------------------------------------------------------------------------------------
//
        // Thickness
        //progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        // Rounded Edges
        // Colour
        progressBar.trackTintColor = colour2
        progressBar.progressTintColor = colour3
        // Initial state
        progressBar.setProgress(0, animated: true)
        //
        
        // Display Content
        displayContent()
    }
    
    
//
// View did layout subviews -------------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
    }
    
    
//
// Generate Buttons ---------------------------------------------------------------------------------------------------------------------
//
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
    
    //
    var buttonArray = [UIButton]()
    //
    func createButtonArray(){
        //
        let numberOfButtons = setsArray[sessionScreenIndex]
        //
        for _ in 1...numberOfButtons{
            buttonArray += [createButton()]
        }
    }
    

//
// Display Content ---------------------------------------------------------------------------------------------------------------------
//
    // Display Content Function
    func displayContent() {
        // Navigation Bar
        navigationTitle.text = NSLocalizedString(sessionArray[sessionScreenIndex], comment: "")
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
        self.navigationController?.navigationBar.topItem?.titleView = navigationTitle
        
        // Images
        //
        //demonstrationImage.loadGif(name: "TestGif")
        demonstrationImage.image = demonstrationArray[sessionScreenIndex]
        //
        bodyImage.image = targetAreaArray[sessionScreenIndex]
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
        let numberOfButtons2 = CGFloat(setsArray[sessionScreenIndex])
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
        self.setsRepsLabel.text = (String(setsArray[sessionScreenIndex]) + " x " + repsArray[sessionScreenIndex])
        // Progress
        self.progressLabel.text = (String(sessionScreenIndex + 1)+"/"+String(sessionArray.count))
        //
        setsRepsLabel.textColor = colour2
        progressLabel.textColor = colour2
        
        // Progress Bar
        let sessionIndexP = Float(sessionScreenIndex)
        let sessionArrayP = Float(self.sessionArray.count)
        //
        let fractionalProgress = sessionIndexP/sessionArrayP
        //
        progressBar.setProgress(fractionalProgress, animated: true)
    }
    
    
//
// Flash Screen ---------------------------------------------------------------------------------------------------------
//
    // Flash Screen
    func flashScreenGreen() {
        //
        let flash = UIView()
        //
        flash.frame = UIScreen.main.bounds
        flash.backgroundColor = colour3
        flash.alpha = 0.9
        UIApplication.shared.keyWindow?.insertSubview(flash, aboveSubview: view)
        //
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
            flash.alpha = 0
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
    }
    //
    func flashScreenRed() {
        //
        let flash = UIView()
        //
        flash.frame = UIScreen.main.bounds
        flash.backgroundColor = colour4
        flash.alpha = 0.9
        UIApplication.shared.keyWindow?.insertSubview(flash, aboveSubview: view)
        //
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
            flash.alpha = 0
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
    }

    
  
//
// CountDown Timer ---------------------------------------------------------------------------------------------
//
    var isTiming = false
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
    
    let timerShapeLayer = CAShapeLayer()
    // Funcs
    // Add circle
    func addCircle() {
        let circlePath = UIBezierPath(arcCenter: countDownLabel.center, radius: CGFloat((pickerViewTimer.frame.size.height-10)/2), startAngle: CGFloat(-(Double.pi / 2)), endAngle:CGFloat((2*Double.pi)-(Double.pi / 2)), clockwise: true)
        timerShapeLayer.path = circlePath.cgPath
        timerShapeLayer.fillColor = UIColor.clear.cgColor
        timerShapeLayer.strokeColor = colour1.cgColor
        timerShapeLayer.lineWidth = 1.0
        //
        timerView.layer.addSublayer(timerShapeLayer)
    }
    
    // Remove circle
    func removeCircle() {
        timerShapeLayer.removeFromSuperlayer()
    }
    
    // Start animation
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
    
    
    // Stop timer if moved to background (notification will still ring)
    func appMovedToBackground() {
        //
        self.timerCountDown.invalidate()
        self.timerValue = 0
        removeCircle()
        self.countDownLabel.text = "00:00"
        timerView.bringSubview(toFront: timerStart)
        isTiming = false
    }
    

//
// Timer Picker View ---------------------------------------------------------------------------------------------
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
        //
        } else if pickerView == secondPicker {
            return 4
        }
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
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    
//
// Timer Display and retract ----------------------------------------------------------------------------------------
//
    // Display TimerView
    //
    let backgroundViewTimer = UIButton()
    //
    @IBAction func timerViewButton(_ sender: Any) {
        //
        nextButton.isEnabled = false
        backButton.isEnabled = false
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
            //
            self.nextButton.isEnabled = true
            self.backButton.isEnabled = true
        }
    }
  
    
//
// Button Actions ------------------------------------------------------------------------------------------------
//
    // Set Buttons
    //
    var buttonNumber = 0
    
    // Set Button
    @IBAction func setButtonAction(sender: UIButton) {
        //
        // Rest Timer Notification
        //
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
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { finished in
            if self.buttonArray.count == 1 {
            } else {
                if self.buttonNumber < 2 {
                    self.buttonNumber = self.buttonNumber + 1
                    self.buttonArray[self.buttonNumber].isEnabled = true
                }
            }
        })
        
        //
        buttonArray[buttonNumber].isEnabled = false
        //
        //
        sender.backgroundColor = colour1
        sender.isEnabled = false
    }
    
    
    // Next Navigation Button
    @IBAction func nextButton(_ sender: Any) {
        //
        if sessionScreenIndex == sessionArray.count - 1 {
            //
            sessionScreenIndex = 0
            self.dismiss(animated: true)
        //
        } else {
            //
            backButton.tintColor = colour4
            sessionScreenIndex = sessionScreenIndex + 1
            buttonNumber = 0
            displayContent()
        }
        //
        flashScreenGreen()
    }
    
    // Back Navigation Button
    @IBAction func backButton(_ sender: Any) {
        //
        if sessionScreenIndex == 0 {
            
        } else if sessionScreenIndex == 1 {
            //
            backButton.tintColor = .clear
            sessionScreenIndex = sessionScreenIndex - 1
            buttonNumber = 0
            //
            flashScreenRed()
            displayContent()
        } else {
            //
            sessionScreenIndex = sessionScreenIndex - 1
            buttonNumber = 0
            //
            flashScreenRed()
            displayContent()
        }
    }
    
    
//
// Explanation -------------------------------------------------------------------------------------------------------------
//
    // Expand Explanation
    //
    let scrollViewExplanation = UIScrollView()
    let backgroundViewExplanation = UIButton()
    //
    let explanationLabel = UILabel()
    
    // Expand Explanation
    @IBAction func expandExplanation(_ sender: Any) {
        //
        nextButton.isEnabled = false
        backButton.isEnabled = false
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
        let attributedStringE = NSMutableAttributedString(string: NSLocalizedString(explanationArray[sessionScreenIndex], comment: ""))
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
            //
            self.nextButton.isEnabled = true
            self.backButton.isEnabled = true
        }
    }
    
    
//
// Pocket Mode ---------------------------------------------------------------------------------------------------------------------
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
        }
    }
    

//
// Image Buttons ----------------------------------------------------------------------------------------------------------
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
// Walkthrough ----------------------------------------------------------------------------------------------------
//
    var  viewNumber = 0
    let walkthroughView = UIView()
    let label = UILabel()
    let nextButtonW = UIButton()
    let backButtonW = UIButton()
    
    // Walkthrough
    func walkthroughMindBody() {
        
        
        //
        let screenSize = UIScreen.main.bounds
        let navigationBarHeight = CGFloat(44)
        //
        walkthroughView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        walkthroughView.backgroundColor = .black
        walkthroughView.alpha = 0.72
        walkthroughView.clipsToBounds = true
        //
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        label.center = view.center
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "SFUIDisplay-light", size: 22)
        label.textColor = .white
        //
        nextButtonW.frame = screenSize
        nextButtonW.backgroundColor = .clear
        nextButtonW.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
        //
        backButtonW.frame = CGRect(x: 3, y: UIApplication.shared.statusBarFrame.height, width: 50, height: navigationBarHeight)
        backButtonW.setTitle("Back", for: .normal)
        backButtonW.titleLabel?.textAlignment = .left
        backButtonW.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        backButtonW.titleLabel?.textColor = .white
        backButtonW.addTarget(self, action: #selector(backWalkthroughView(_:)), for: .touchUpInside)
        
        
        
        
        switch viewNumber {
            
        case 0:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: view.frame.size.width/2 - ((navigationTitle.frame.size.width + 50) / 2), y: UIApplication.shared.statusBarFrame.height, width: navigationTitle.frame.size.width + 50, height: 40))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("movementScreen0", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            
            
            
            
        //
        case 1:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width * 0.917, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("movementScreen1", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
        case 2:
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width * 0.075, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("movementScreen2", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            backButtonW.setTitle("", for: .normal)
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
        case 3:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height, width: imageScroll.frame.size.width, height: imageScroll.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            let centerY = setRepView.frame.maxY + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.center.y = centerY
            label.text = NSLocalizedString("movementScreen3", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
           
            
            
        case 4:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: view.frame.size.width - targetAreaButton.frame.size.width, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + imageScroll.frame.size.height - targetAreaButton.frame.size.height, width: targetAreaButton.frame.size.width, height: targetAreaButton.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            let centerY = setRepView.frame.maxY + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.center.y = centerY
            label.text = NSLocalizedString("movementScreen4", comment: "")
            walkthroughView.addSubview(label)
            
            
            // Demonstration Image
            //
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.imageScroll.contentOffset.x = 0
            }, completion: nil)
            //
            targetAreaButton.alpha = 1
            targetAreaButton.isEnabled = true
            demonstrationImageButton.alpha = 0
            demonstrationImageButton.isEnabled = false
            //
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
        case 5:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height, width: imageScroll.frame.size.width, height: imageScroll.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            let centerY = setRepView.frame.maxY + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.center.y = centerY
            label.text = NSLocalizedString("movementScreen5", comment: "")
            walkthroughView.addSubview(label)
            
            
            // Target Area Image
            //
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.imageScroll.contentOffset.x = self.imageScroll.frame.size.width
            }, completion: nil)
            //
            targetAreaButton.alpha = 0
            targetAreaButton.isEnabled = false
            demonstrationImageButton.alpha = 1
            demonstrationImageButton.isEnabled = true
            //
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
        case 6:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + imageScroll.frame.size.height - demonstrationImageButton.frame.size.height, width: demonstrationImageButton.frame.size.width, height: demonstrationImageButton.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            let centerY = setRepView.frame.maxY + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.center.y = centerY
            label.text = NSLocalizedString("movementScreen6", comment: "")
            walkthroughView.addSubview(label)
            
            
            // Target Area Image
            //
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.imageScroll.contentOffset.x = self.imageScroll.frame.size.width
            }, completion: nil)
            //
            targetAreaButton.alpha = 0
            targetAreaButton.isEnabled = false
            demonstrationImageButton.alpha = 1
            demonstrationImageButton.isEnabled = true
            //
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
        case 7:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: (view.frame.size.width / 2) - (setsRepsLabel.frame.size.width / 2), y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + imageScroll.frame.size.height, width: setsRepsLabel.frame.size.width, height: setsRepsLabel.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            let centerY = imageScroll.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.center.y = centerY
            label.text = NSLocalizedString("movementScreen7", comment: "")
            walkthroughView.addSubview(label)
            
            
            // Demonstration Image
            //
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.imageScroll.contentOffset.x = 0
            }, completion: nil)
            //
            targetAreaButton.alpha = 1
            targetAreaButton.isEnabled = true
            demonstrationImageButton.alpha = 0
            demonstrationImageButton.isEnabled = false
            //
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
            
        case 8:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + imageScroll.frame.size.height + setsRepsLabel.frame.size.height, width: setRepView.frame.size.width, height: setRepView.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            let centerY = imageScroll.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.center.y = centerY
            label.text = NSLocalizedString("movementScreen8", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
        case 9:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + imageScroll.frame.size.height + setsRepsLabel.frame.size.height + setRepView.frame.size.height, width: timerButton.frame.size.width, height: timerButton.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            let centerY = imageScroll.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.center.y = centerY
            label.text = NSLocalizedString("movementScreen9", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
        case 10:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: (view.frame.size.width / 2) - (explanationExpand.frame.size.width / 2), y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + imageScroll.frame.size.height + setsRepsLabel.frame.size.height + setRepView.frame.size.height, width: explanationExpand.frame.size.width, height: explanationExpand.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            let centerY = imageScroll.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.center.y = centerY
            label.text = NSLocalizedString("movementScreen10", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
            
        case 11:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: view.frame.size.width - hideScreen.frame.size.width, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + imageScroll.frame.size.height + setsRepsLabel.frame.size.height + setRepView.frame.size.height, width: hideScreen.frame.size.width, height: hideScreen.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            let centerY = imageScroll.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.center.y = centerY
            label.text = NSLocalizedString("movementScreen11", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
            
            
        case 12:
            // Clear Section
            let path = CGMutablePath()
            let y = navigationBarHeight + UIApplication.shared.statusBarFrame.height + imageScroll.frame.size.height
            let yValue = y + setsRepsLabel.frame.size.height + setRepView.frame.size.height + timerButton.frame.size.height
            path.addRect(CGRect(x: 0, y: yValue, width: progressLabel.frame.size.width + 14, height: progressLabel.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            
            label.text = NSLocalizedString("movementScreen12", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
        case 13:
            // Clear Section
            let path = CGMutablePath()
            let y = navigationBarHeight + UIApplication.shared.statusBarFrame.height + imageScroll.frame.size.height
            let yValue = y + setsRepsLabel.frame.size.height + setRepView.frame.size.height + timerButton.frame.size.height
            path.addRect(CGRect(x: 14 + progressLabel.frame.size.width, y: yValue, width: view.frame.size.width - 14 - progressLabel.frame.size.width, height: progressBar.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("movementScreen13", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
        default: break
            
            
        }
        
        
    }
    
    //
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    
    //
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButtonW.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
    }
//
}
