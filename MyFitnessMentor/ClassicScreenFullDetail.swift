//
//  ClassicScreenFullDetail.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 13.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import UserNotifications



class ClassicScreenFullDetail: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {
    
    
    // Selected Movement
    var selectedMovement = Int()
    
    
    // Initialize Arrays
    // Workout Choice Movement Array
    var workoutArray: [String] = []
    // Workout Choice Selected Array
    var workoutMovementsSelectedArray: [[Int]] = [[]]
    
    // Sets Array
    var setsArray: [Int] = []
    // Reps Array
    var repsArray: [String] = []
    // Weight Array
    var weightArray: [Int] = []
    // Demonstration Array
    var demonstrationArray: [UIImage] = []
    // Target Area Array
    var targetAreaArray: [UIImage] = []
    
    // Explanation Array
    var explanationArray: [String] = []
    
    
    

    //
    // Outlets
    //
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Navigation Title
    let navigationTitle = UILabel()
    
    
    // Set Rep
    @IBOutlet weak var setRepView: UIView!
    // Buttons
    var setButton1 = UIButton()
    var setButton2 = UIButton()
    var setButton3 = UIButton()
    
    // Scroll Views
    
    // Explanation
    @IBOutlet weak var scrollViewExplanation: UIScrollView!
    
    
    // Image View
    @IBOutlet weak var bodyImage: UIImageView!
    
    // Demonstration Image
    @IBOutlet weak var demonstrationImage: UIImageView!
    
    
    
    @IBOutlet weak var imageExpand: UIButton!
    
    
    
    
    
    // Explanation
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
    @IBOutlet weak var timerButton2: UIButton!
    
    
    
    // Progress Bar
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    // Title Labels
    // Sets and Reps
    @IBOutlet weak var setsRepsLabel: UILabel!
    // Weight
    @IBOutlet weak var weightLabel: UILabel!
    // Demonstration
    @IBOutlet weak var demonstrationLabel: UILabel!
    // Target Area Label
    @IBOutlet weak var targetAreaLabel: UILabel!
    // Explanation Label
    @IBOutlet weak var explanationLabel: UILabel!
    let explanationText = UILabel()
    // Progress Label
    @IBOutlet weak var progressLabel: UILabel!
    
    
    
    
    // Constraints
    @IBOutlet weak var setTop: NSLayoutConstraint!
    @IBOutlet weak var setBottom: NSLayoutConstraint!
    @IBOutlet weak var imageBottom: NSLayoutConstraint!
    @IBOutlet weak var explanationBottom: NSLayoutConstraint!
    
    
    // Hide Screen
    @IBOutlet weak var hideScreen: UIButton!
    
    
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
        
    
    //
    // View Did Load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Iphone 5/SE layout
        //
        if UIScreen.main.nativeBounds.height < 1334 {
            
            setTop.constant = 36.75
            setBottom.constant = 36.75
            imageBottom.constant = 36.75
            explanationBottom.constant = 36.75
        }
        
        
        
        
        
        // Navigation
        self.navigationController?.navigationBar.tintColor = colour1
        navigationController?.delegate = self
        
        // Background Gradient and Colours
        //
        self.view.applyGradient(colours: [colour1, colour1])
        
        
        //
        // Demonstration Image
        //
        demonstrationImage.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        
        demonstrationImage.image = #imageLiteral(resourceName: "Test 2")
        demonstrationImage.contentMode = .scaleAspectFit
        
        
        
        
        // Body Image View
        bodyImage.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        
        
        // Image Expand
        let origImageImage = UIImage(named: "Plus")
        let tintedImageImage = origImageImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        imageExpand.setImage(tintedImageImage, for: .normal)
        
        //Image Tint
        imageExpand.tintColor = colour2
        
        
        
        
        
        
        
        
        
        
        
        // Explanation Text
        explanationText.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        explanationText.textColor = .black
        explanationText.textAlignment = .justified
        explanationText.lineBreakMode = NSLineBreakMode.byWordWrapping
        explanationText.numberOfLines = 0
        
        
        // Expand Button
        let origImage1 = UIImage(named: "Plus")
        let tintedImage1 = origImage1?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        explanationExpand.setImage(tintedImage1, for: .normal)
        
        //Image Tint
        explanationExpand.tintColor = colour2
        
        
        
        //
        // Timer
        //
        // Timer Button
        self.view.bringSubview(toFront: timerButton)
        // Image With Tint
        let origImage3 = UIImage(named: "Timer")
        let tintedImage3 = origImage3?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        timerButton.setImage(tintedImage3, for: .normal)
        timerButton2.setImage(tintedImage3, for: .normal)
        
        //Image Tint
        timerButton.tintColor = colour2
        timerButton2.tintColor = colour2
        
        
        
        
        // Timer View
        timerView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        
        // Timer Elements
        //
        // Picker View Timer
        //
        pickerViewTimer.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        view.addSubview(pickerViewTimer)
        
        
        // Pick Minutes
        //
        minutePicker.dataSource = self
        minutePicker.delegate = self
        minutePicker.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        pickerViewTimer.addSubview(minutePicker)
        
        
        
        minuteLabel.text = NSLocalizedString("minutes", comment: "")
        minuteLabel.font = UIFont(name: "SFUIDisplay-light", size: 17)
        minuteLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        minuteLabel.textAlignment = .left
        
        pickerViewTimer.addSubview(minuteLabel)
        
        
        // Pick Seconds
        //
        secondPicker.dataSource = self
        secondPicker.delegate = self
        secondPicker.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        pickerViewTimer.addSubview(secondPicker)
        
        
        secondLabel.text = NSLocalizedString("seconds", comment: "")
        secondLabel.font = UIFont(name: "SFUIDisplay-light", size: 17)
        secondLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        secondLabel.textAlignment = .left
        
        pickerViewTimer.addSubview(secondLabel)
        
        timerView.addSubview(pickerViewTimer)
        
        
        // Picker View Data
        //
        minuteData = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 30]
        secondData = [0, 15, 30, 45]
        
        
        // Start Button Timer
        //
        timerStart.backgroundColor = colour1
        timerStart.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
        timerStart.setTitleColor(colour2, for: .normal)
        timerStart.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 19)
        timerStart.titleLabel?.textAlignment = .center
        
        timerStart.addTarget(self, action: #selector(startTimer(_:)), for: .touchUpInside)
        
        pickerViewTimer.addSubview(timerStart)
        
        
        
        // Cancel Button Timer
        //
        timerCancel.backgroundColor = colour1
        timerCancel.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        timerCancel.setTitleColor(colour2, for: .normal)
        timerCancel.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 19)
        timerCancel.titleLabel?.textAlignment = .center
        
        timerCancel.addTarget(self, action: #selector(cancelTimer(_:)), for: .touchUpInside)
        
        pickerViewTimer.addSubview(timerCancel)
        
        pickerViewTimer.bringSubview(toFront: timerStart)
        
        
        
        // Countdown Label
        countDownLabel.textAlignment = .center
        countDownLabel.font = UIFont(name: "SFUIDisplay-Light", size: 27)
        countDownLabel.text = "00:00"
        countDownLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        
        self.timerView.addSubview(countDownLabel)
        
        
        //self.view.addSubview(timerView)
        //self.view.sendSubview(toBack: timerView)
        
        
        // App Moved To Background
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // Progress Bar
        //
        
        // Thickness
        
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 49, height: self.progressBarView.frame.size.height / 2)
        progressBar.center = progressBarView.center
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3)
        
        // Rounded Edges
        progressBar.layer.cornerRadius = self.progressBar.frame.size.height / 2
        progressBar.layer.masksToBounds = true
        
        // Initial state
        progressBar.setProgress(0, animated: true)
        
        
        
        // Display Content
        displayContent()
        
        
        
    }
    
    
    
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        //
        // Timer View
        //
        // Timer View
        //
        if UIScreen.main.nativeBounds.height < 1334 {
            timerView.frame = CGRect(x: 0, y: 0, width: self.scrollViewExplanation.frame.size.width, height: self.scrollViewExplanation.frame.size.height + 73.5)
            timerView.center.x = scrollViewExplanation.center.x
            timerView.center.y = scrollViewExplanation.center.y + 36.75
        } else {
            timerView.frame = CGRect(x: 0, y: 0, width: self.scrollViewExplanation.frame.size.width, height: self.scrollViewExplanation.frame.size.height)
            timerView.center.x = scrollViewExplanation.center.x
            timerView.center.y = scrollViewExplanation.center.y
        }
        // Timer View Elements
        //
        pickerViewTimer.frame = CGRect(x: 0, y: 0, width: self.scrollViewExplanation.frame.size.width/2, height: self.timerView.frame.size.height)
        //
        
        
        
        minutePicker.frame = CGRect(x: 10, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        minuteLabel.frame = CGRect(x: 10 + minutePicker.frame.size.width, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        
        //
        secondPicker.frame = CGRect(x: 10 + minutePicker.frame.size.width + minuteLabel.frame.size.width, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        secondLabel.frame = CGRect(x: 10 + minutePicker.frame.size.width + minuteLabel.frame.size.width + secondPicker.frame.size.width, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        
        //
        timerStart.frame = CGRect(x: 0, y: self.timerView.frame.size.height * (2/3), width: self.pickerViewTimer.frame.size.width, height: (self.timerView.frame.size.height*(1/3)))
        timerStart.layer.borderWidth = timerStart.frame.size.height/4
        timerStart.layer.borderColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0).cgColor
        //
        timerCancel.frame = CGRect(x: 0, y: self.timerView.frame.size.height * (2/3), width: self.pickerViewTimer.frame.size.width, height: (self.timerView.frame.size.height*(1/3)))
        timerCancel.layer.borderWidth = timerCancel.frame.size.height/4
        timerCancel.layer.borderColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0).cgColor
        //
        countDownLabel.frame = CGRect(x: self.scrollViewExplanation.frame.size.width/2, y: 0, width: self.scrollViewExplanation.frame.size.width/2, height: self.timerView.frame.size.height)
        
        
    }
    
    
    
    
    
    
    //
    // Generate Buttons
    //
    func createButton() -> UIButton {
        let setButton = UIButton()
        let widthHeight = NSLayoutConstraint(item: setButton, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: setButton, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        setButton.addConstraints([widthHeight])
        setButton.frame = CGRect(x: 0, y: 0, width: 42.875, height: 42.875)
        setButton.layer.borderWidth = 4
        setButton.layer.borderColor = colour2.cgColor
        setButton.layer.cornerRadius = 21.4375
        setButton.addTarget(self, action: #selector(setButtonAction), for: .touchUpInside)
        setButton.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        setButton.isEnabled = false
        
        
        
        setRepView.addSubview(setButton)
        
        return setButton
    }
    
    
    var buttonArray = [UIButton]()
    
    func createButtonArray(){
        //generate an array of buttons
        
        
        let numberOfButtons = setsArray[selectedMovement]
        
        for _ in 1...numberOfButtons {
            buttonArray += [createButton()]
            
        }
        
        
        if setsArray[selectedMovement] == 1 {
            
            let stackView = UIStackView(arrangedSubviews: buttonArray)
            stackView.frame = CGRect(x: (self.view.frame.size.width / 2) - 24.5, y: 9.1875, width: 42.875, height: 42.875)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            setRepView.addSubview(stackView)
            
            buttonArray[0].isEnabled = true
            
            
        } else if setsArray[selectedMovement] == 2 {
            
            let stackView = UIStackView(arrangedSubviews: buttonArray)
            stackView.frame = CGRect(x: ((self.view.frame.size.width - 85.75) / 3), y: 9.1875, width: ((self.view.frame.size.width - 85.75) / 3) + 85.75, height: 42.875)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            setRepView.addSubview(stackView)
            
            buttonArray[0].isEnabled = true
            
            
        } else if setsArray[selectedMovement] == 3 {
            
            let stackView = UIStackView(arrangedSubviews: buttonArray)
            stackView.frame = CGRect(x: ((self.view.frame.size.width - 128.625) / 4), y: 9.1875, width: ((2 * (self.view.frame.size.width - 128.625)) / 4) + 128.625, height: 42.875)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            setRepView.addSubview(stackView)
            
            buttonArray[0].isEnabled = true
            
        }   else if setsArray[selectedMovement] == 4 {
            
            let stackView = UIStackView(arrangedSubviews: buttonArray)
            stackView.frame = CGRect(x: ((self.view.frame.size.width - 171.5) / 5), y: 9.1875, width: ((3 * (self.view.frame.size.width - 171.5)) / 5) + 171.5, height: 42.875)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            setRepView.addSubview(stackView)
            
            buttonArray[0].isEnabled = true
            
        }    else if setsArray[selectedMovement] == 5 {
            
            let stackView = UIStackView(arrangedSubviews: buttonArray)
            stackView.frame = CGRect(x: ((self.view.frame.size.width - 214.375) / 6), y: 9.1875, width: ((4 * (self.view.frame.size.width - 214.375)) / 6) + 214.375, height: 42.875)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            setRepView.addSubview(stackView)
            
            buttonArray[0].isEnabled = true
            
        }
        
        
        
        
        
        // Set Buttons
        //
        // Disable pressed buttons
        let indexOfUnpressedButton = buttonNumber[selectedMovement]
        if indexOfUnpressedButton > 0 {
            for s in 0...indexOfUnpressedButton - 1 {
    
                buttonArray[s].isEnabled = false
                buttonArray[s].backgroundColor = colour2
                
            }
        }
    
    
        // Enable next unpressed button
        if indexOfUnpressedButton == setsArray[selectedMovement] {
            
        } else {
            buttonArray[indexOfUnpressedButton].isEnabled = true
        }
        
    }
    
    
    
    
    
    
    

    // Display Content Function
    func displayContent() {
        
        
        // Navigation Bar
        self.navigationTitle.text = NSLocalizedString(workoutArray[selectedMovement], comment: "")
        
        
        // Navigation Title
        //
        navigationTitle.frame = (navigationController?.navigationItem.accessibilityFrame)!
        navigationTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        navigationTitle.center.x = self.view.center.x
        navigationTitle.textColor = colour1
        navigationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 22)
        navigationTitle.backgroundColor = .clear
        navigationTitle.textAlignment = .center
        navigationTitle.adjustsFontSizeToFitWidth = true
        self.navigationController?.navigationBar.barTintColor = colour2
        
        navigationBar.titleView = navigationTitle
        
        
        
        
        
        // Set Buttons
        let setRepSubViews = self.setRepView.subviews
        for subview in setRepSubViews{
            subview.removeFromSuperview()
        }
        buttonArray = []
        createButtonArray()
        
        
        
        
        // Body Image
        bodyImage.image = targetAreaArray[selectedMovement]
        bodyImage.contentMode = .scaleAspectFit
        
        
        
        // Explanation Text and Scroll View
        let attributedExplanation = NSMutableAttributedString(string: NSLocalizedString(explanationArray[selectedMovement], comment: ""))
        let paragraphStyleE = NSMutableParagraphStyle()
        paragraphStyleE.alignment = .justified
        paragraphStyleE.hyphenationFactor = 1
        
        attributedExplanation.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyleE, range: NSMakeRange(0, attributedExplanation.length))
        
        explanationText.attributedText = attributedExplanation
        
        explanationText.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 0)
        explanationText.sizeToFit()
        // Scroll View
        scrollViewExplanation.addSubview(explanationText)
        scrollViewExplanation.contentSize = CGSize(width: self.view.frame.size.width, height: explanationText.frame.size.height + 20)
        
        self.scrollViewExplanation.contentOffset.y = 0
        
        
        
        
        // Timer to Back
        self.scrollViewExplanation.alpha = 1
        timerView.removeFromSuperview()
        //self.view.bringSubview(toFront: scrollViewExplanation)
        self.view.bringSubview(toFront: timerButton)
        cancelTimer(Any.self)
        
        
        
        
        // Explanation
        
        self.scrollViewExplanation.contentOffset.y = 0
        
        
        self.view.bringSubview(toFront: scrollViewExplanation)
        
        
        
        
        // Title Labels
        // Sets Reps
        self.setsRepsLabel.text = (String(setsArray[selectedMovement]) + " x " + repsArray[selectedMovement])
        // Weight
        self.weightLabel.text = (String(weightArray[selectedMovement]) + UserDefaults.standard.string(forKey: "units")!)
        // Progress
        self.progressLabel.text = (String(selectedMovement + 1)+"/"+String(workoutArray.count))
        
        setsRepsLabel.textColor = colour2
        weightLabel.textColor = colour2
        progressLabel.textColor = colour2
        
        
        
        
        // Progress Bar
        let workoutIndexP = Float(selectedMovement)
        let workoutArrayP = Float(self.workoutArray.count)
        
        let fractionalProgress = workoutIndexP/workoutArrayP
        
        progressBar.setProgress(fractionalProgress, animated: true)
        
        
    }
    
    
    
    
    
    
    // Flash Screen
    func flashScreen() {
        
        let flash = UIView()
        
        flash.frame = CGRect(x: 0, y: -100, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
            
            flash.alpha = 0
            
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //
    // Count Down Timer
    //
    
    
    // Timer CountDown Value
    func setTimerValue() {
        
        let minutesSelectedRow = minutePicker.selectedRow(inComponent: 0)
        let minutes = minuteData[minutesSelectedRow]
        
        let secondsSelectedRow = secondPicker.selectedRow(inComponent: 0)
        let seconds = secondData[secondsSelectedRow]
        
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
        
        
        if timerValue == 0{
            self.timerCountDown.invalidate()
            removeCircle()
            self.pickerViewTimer.bringSubview(toFront: timerStart)
            
        } else if timerValue == 1 {
            
            timerValue -= 1
            countDownLabel.text = timeFormatted(totalSeconds: timerValue)
            
        } else {
            timerValue -= 1
            countDownLabel.text = timeFormatted(totalSeconds: timerValue)
            
        }
        
    }
    
    
    let timerShapeLayer = CAShapeLayer()
    
    // Funcs
    func addCircle() {
        let circlePath = UIBezierPath(arcCenter: countDownLabel.center, radius: CGFloat((timerView.frame.size.height-10)/2), startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(2*M_PI-M_PI_2), clockwise: true)
        timerShapeLayer.path = circlePath.cgPath
        timerShapeLayer.fillColor = UIColor.clear.cgColor
        timerShapeLayer.strokeColor = colour1.cgColor
        timerShapeLayer.lineWidth = 1.0
        
        timerView.layer.addSublayer(timerShapeLayer)
        
    }
    
    func removeCircle() {
        
        timerShapeLayer.removeFromSuperlayer()
        
    }
    
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double(timerValue)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        timerShapeLayer.add(animation, forKey: "circleAnimation")
        
        
    }
    
    
    @IBAction func startTimer(_ sender: Any) {
        
        setTimerValue()
        
        
        if timerValue == 0 {
            
        } else {
            
            
            self.pickerViewTimer.bringSubview(toFront: timerCancel)
            
            self.countDownLabel.text = timeFormatted(totalSeconds: timerValue)
            
            let delayInSeconds = 0.1
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                
                self.addCircle()
                self.startAnimation()
                self.timerCountDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
                
                
                
                if #available(iOS 10.0, *) {
                    
                    let content = UNMutableNotificationContent()
                    content.title = NSLocalizedString("timerEnd", comment: "")
                    content.body = " "
                    content.sound = UNNotificationSound.default()
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(self.timerValue), repeats: false)
                    let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
                    
                    
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                    
                    
                } else {
                    // Fallback on earlier versions
                }
                
                
                
            }
            
        }
        
    }
    
    
    
    @IBAction func cancelTimer(_ sender: Any) {
        
        
        self.timerCountDown.invalidate()
        self.timerValue = 0
        self.countDownLabel.text = "00:00"
        removeCircle()
        self.pickerViewTimer.bringSubview(toFront: timerStart)
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timer"])
        
    }
    
    
    
    // Picker Views
    //
    
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        
        if pickerView == minutePicker {
            return 14
        } else if pickerView == secondPicker {
            return 4
        }
        
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == minutePicker {
            
            let rowLabel = UILabel()
            let titleData = String(minuteData[row])
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 23)!,NSForegroundColorAttributeName:UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
        } else if pickerView == secondPicker {
            
            let rowLabel = UILabel()
            let titleData = String(secondData[row])
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 23)!,NSForegroundColorAttributeName:UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
        }
        
        return UIView()
    }
    
    
    // Background
    func appMovedToBackground() {
        
        self.timerCountDown.invalidate()
        self.timerValue = 0
        removeCircle()
        self.countDownLabel.text = "00:00"
        self.pickerViewTimer.bringSubview(toFront: timerStart)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //
    // Button Actions
    //
    
    
    var buttonNumber = [Int]()
    
    // Set Button
    @IBAction func setButtonAction(sender: UIButton) {
        
        //
        // Rest Timer Notification
        //
        if #available(iOS 10.0, *) {
            
            let content = UNMutableNotificationContent()
            content.title = NSLocalizedString("restOver", comment: "")
            content.body = NSLocalizedString("nextSet", comment: "")
            content.sound = UNNotificationSound.default()
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
            let request = UNNotificationRequest(identifier: "restTimer", content: content, trigger: trigger)
            
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            
        }
        
        
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
        
        sender.backgroundColor = colour2
        sender.isEnabled = false
        
    }
    
    
    
    
    // Display TimerView
    @IBAction func timerViewButton(_ sender: Any) {
        
        self.view.addSubview(timerView)
        self.view.bringSubview(toFront: timerView)
        
        
        self.view.bringSubview(toFront: timerButton2)
        
        
        
        
        // Ensure Explanation Hidden
        self.scrollViewExplanation.alpha = 0
        
        
        
    }
    
    
    @IBAction func timerViewButton2(_ sender: Any) {
        
        
        timerView.removeFromSuperview()
        
        self.view.bringSubview(toFront: timerButton)
        
        
        
        // Ensure Explanation Hidden
        self.scrollViewExplanation.alpha = 1
        self.explanationExpand.alpha = 1
        
        
        
    }
    
    
    
    
    
    
    // Expand and Retract Images
    //
    
    
    let imageViewExpanded = UIView()
    let backgroundViewExpanded = UIButton()
    let cancelButtonImage = UIButton()
    
    let bodyImageExpanded = UIImageView()
    let demonstrationImageExpanded = UIImageView()
    
    let targetButton = UIButton()
    let demonstrationButton = UIButton()
    
    
    
    @IBAction func expandImage(_ sender: Any) {
        
        //Screen Size
        //
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        
        // View
        //
        imageViewExpanded.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: (view.frame.size.height * (2/3) + 36.75))
        imageViewExpanded.center.x = width/2
        imageViewExpanded.center.y = height/2
        imageViewExpanded.isUserInteractionEnabled = true
        
        imageViewExpanded.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        
        
        // Background View
        //
        backgroundViewExpanded.frame = CGRect(x: 0, y: 0, width: width, height: height)
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.alpha = 0.5
        
        backgroundViewExpanded.addTarget(self, action: #selector(retractImage), for: .touchUpInside)
        
        
        
        
        // Cancel Button
        //
        cancelButtonImage.frame = CGRect(x: 0, y: 0, width: 36.75, height: 36.75)
        cancelButtonImage.center.y = imageViewExpanded.frame.minY/2
        cancelButtonImage.center.x = imageViewExpanded.frame.maxX - (imageViewExpanded.frame.minY/2)
        
        cancelButtonImage.addTarget(self, action: #selector(retractImage), for: .touchUpInside)
        cancelButtonImage.layer.cornerRadius = 18.375
        cancelButtonImage.layer.masksToBounds = true
        
        
        cancelButtonImage.backgroundColor = colour2
        
        let origImage = UIImage(named: "Minus")
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        cancelButtonImage.setImage(tintedImage, for: .normal)
        //Image Tint
        cancelButtonImage.tintColor = colour1
        
        
        
        
        
        
        
        // Demonstration or Body Image
        //
        // Demonstration
        demonstrationButton.isEnabled = true
        demonstrationButton.frame = CGRect(x: 0, y: 0, width: imageViewExpanded.frame.size.width/2, height: 36.75)
        demonstrationButton.setTitle(NSLocalizedString("demonstration", comment: ""), for: .normal)
        demonstrationButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 22)
        demonstrationButton.addTarget(self, action: #selector(demonstrationImageButton(_:)), for: .touchUpInside)
        
        imageViewExpanded.addSubview(demonstrationButton)
        
        
        demonstrationButton.backgroundColor = .white
        demonstrationButton.setTitleColor(colour1, for: .normal)
        
        // Target
        targetButton.frame = CGRect(x: imageViewExpanded.frame.size.width/2, y: 0, width: imageViewExpanded.frame.size.width/2, height: 36.75)
        
        targetButton.setTitle(NSLocalizedString("targetArea", comment: ""), for: .normal)
        targetButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 22)
        targetButton.addTarget(self, action: #selector(bodyImageButton(_:)), for: .touchUpInside)
        
        targetButton.backgroundColor = .white
        targetButton.setTitleColor(colour1, for: .normal)
        
        imageViewExpanded.addSubview(targetButton)
        
        
        
        
        // Seperator
        let seperator = UILabel()
        seperator.frame = CGRect(x: 0, y: 0, width: 1, height: 36.75)
        seperator.center.x = imageViewExpanded.center.x
        seperator.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        imageViewExpanded.addSubview(seperator)
        
        
        
        
        // Order
        imageViewExpanded.bringSubview(toFront: demonstrationImageExpanded)
        demonstrationImageExpanded.alpha = 1
        bodyImageExpanded.alpha = 0
        demonstrationButton.backgroundColor = colour2
        
        
        
        
        
        
        
        
        
        // View Contents
        //
        // Body Image
        bodyImageExpanded.frame = CGRect(x: 0, y: 36.75, width: imageViewExpanded.frame.size.width, height: imageViewExpanded.frame.size.height - 36.75)
        bodyImageExpanded.image = targetAreaArray[selectedMovement]
        bodyImageExpanded.contentMode = .scaleAspectFit
        
        imageViewExpanded.addSubview(bodyImageExpanded)
        
        
        
        // Demonstration Image
        demonstrationImageExpanded.frame = CGRect(x: 0, y: 36.75, width: imageViewExpanded.frame.size.width, height: imageViewExpanded.frame.size.height - 36.75)
        demonstrationImageExpanded.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        
        demonstrationImageExpanded.image = #imageLiteral(resourceName: "Test 2")
        demonstrationImageExpanded.contentMode = .scaleAspectFit
        
        imageViewExpanded.addSubview(demonstrationImageExpanded)
        
        
        
        
        // Add Subviews
        //
        view.addSubview(backgroundViewExpanded)
        view.addSubview(imageViewExpanded)
        view.addSubview(cancelButtonImage)
        
        
        view.bringSubview(toFront: backgroundViewExpanded)
        view.bringSubview(toFront: imageViewExpanded)
        view.bringSubview(toFront: cancelButtonImage)
        
        view.bringSubview(toFront: seperator)
        
    }
    
    @IBAction func demonstrationImageButton(_ sender: Any) {
        
        imageViewExpanded.bringSubview(toFront: demonstrationImageExpanded)
        demonstrationImageExpanded.alpha = 1
        bodyImageExpanded.alpha = 0
        
        demonstrationButton.backgroundColor = colour2
        targetButton.backgroundColor = .white
        
    }
    
    @IBAction func bodyImageButton(_ sender: Any) {
        
        imageViewExpanded.bringSubview(toFront: bodyImageExpanded)
        bodyImageExpanded.alpha = 1
        demonstrationImageExpanded.alpha = 0
        
        targetButton.backgroundColor = colour2
        demonstrationButton.backgroundColor = .white
    }
    
    
    @IBAction func retractImage(_ sender: Any) {
        
        imageViewExpanded.bringSubview(toFront: demonstrationImageExpanded)
        
        imageViewExpanded.removeFromSuperview()
        backgroundViewExpanded.removeFromSuperview()
        cancelButtonImage.removeFromSuperview()
        
    }
    
    
    
    
    
    
    // Expand Explanation
    //
    let scrollViewExplanationE = UIScrollView()
    let backgroundViewExplanationE = UIButton()
    let cancelButtonExplanationE = UIButton()
    
    let explanationLabelE = UILabel()
    
    
    
    
    
    
    // Expand Explanation
    //
    
    @IBAction func expandExplanation(_ sender: Any) {
        
        // View
        //
        scrollViewExplanationE.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: (view.frame.size.height * (2/3) + 24.5))
        scrollViewExplanationE.center.x = self.view.frame.size.width/2
        scrollViewExplanationE.center.y = self.view.frame.size.height/2
        
        scrollViewExplanationE.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        
        
        // Background View
        //
        backgroundViewExplanationE.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        backgroundViewExplanationE.backgroundColor = .black
        backgroundViewExplanationE.alpha = 0.5
        
        backgroundViewExplanationE.addTarget(self, action: #selector(retractExplanation(_:)), for: .touchUpInside)
        
        
        
        
        // Cancel Button
        //
        cancelButtonExplanationE.frame = CGRect(x: 0, y: 0, width: 36.75, height: 36.75)
        cancelButtonExplanationE.center.y = scrollViewExplanationE.frame.minY/2
        cancelButtonExplanationE.center.x = scrollViewExplanationE.frame.maxX - (scrollViewExplanationE.frame.minY/2)
        
        cancelButtonExplanationE.addTarget(self, action: #selector(retractExplanation(_:)), for: .touchUpInside)
        cancelButtonExplanationE.layer.cornerRadius = 18.375
        cancelButtonExplanationE.layer.masksToBounds = true
        
        
        cancelButtonExplanationE.backgroundColor = colour2
        
        let origImage = UIImage(named: "Minus")
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        cancelButtonExplanationE.setImage(tintedImage, for: .normal)
        //Image Tint
        cancelButtonExplanationE.tintColor = colour1
        
        
        
        
        // Contents
        //
        explanationLabelE.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        explanationLabelE.textColor = .black
        explanationLabelE.textAlignment = .justified
        explanationLabelE.lineBreakMode = NSLineBreakMode.byWordWrapping
        explanationLabelE.numberOfLines = 0
        
        
        let attributedStringE = NSMutableAttributedString(string: NSLocalizedString(explanationArray[selectedMovement], comment: ""))
        let paragraphStyleEE = NSMutableParagraphStyle()
        paragraphStyleEE.alignment = .justified
        paragraphStyleEE.hyphenationFactor = 1
        
        attributedStringE.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyleEE, range: NSMakeRange(0, attributedStringE.length))
        
        explanationLabelE.attributedText = attributedStringE
        
        explanationLabelE.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 0)
        explanationLabelE.sizeToFit()
        
        // Scroll View
        scrollViewExplanationE.addSubview(explanationLabelE)
        scrollViewExplanationE.contentSize = CGSize(width: self.view.frame.size.width, height: explanationLabelE.frame.size.height + 20)
        
        scrollViewExplanationE.contentOffset.y = 0
        
        
        
        
        
        
        // Add Views
        view.addSubview(scrollViewExplanationE)
        view.addSubview(backgroundViewExplanationE)
        view.addSubview(cancelButtonExplanationE)
        
        view.bringSubview(toFront: scrollViewExplanationE)
        view.bringSubview(toFront: cancelButtonExplanationE)
        
    }
    
    
    
    @IBAction func retractExplanation(_ sender: Any) {
        
        
        scrollViewExplanationE.removeFromSuperview()
        backgroundViewExplanationE.removeFromSuperview()
        cancelButtonExplanationE.removeFromSuperview()
        
        explanationLabelE.removeFromSuperview()
       
    }
    
    
    
    // Hide Screen
    //
    let hideScreenView = UIView()
    let blurEffectView = UIVisualEffectView()
    let hideLabel = UILabel()
    
    
    @IBAction func hideScreen(_ sender: Any) {
        
        
        
        
        
        // Hide Screen view
        let screenSize = UIScreen.main.bounds
        hideScreenView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        hideScreenView.backgroundColor = .clear
        hideScreenView.clipsToBounds = true
        hideScreenView.alpha = 0
        
        // Blur
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView.effect = blurEffect
        blurEffectView.frame = hideScreenView.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hideScreenView.addSubview(blurEffectView)
        blurEffectView.alpha = 0
        
        
        
        
        
        // Double Tap
        let doubleTap = UITapGestureRecognizer()
        doubleTap.numberOfTapsRequired = 2
        doubleTap.addTarget(self, action: #selector(handleTap))
        hideScreenView.isUserInteractionEnabled = true
        hideScreenView.addGestureRecognizer(doubleTap)
        
        
        // Text
        hideLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        hideLabel.center = hideScreenView.center
        hideLabel.textAlignment = .center
        hideLabel.numberOfLines = 0
        hideLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        hideLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        hideLabel.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        hideLabel.text = NSLocalizedString("hideScreen", comment: "")
        
        
        //
        hideScreenView.addSubview(hideLabel)
        UIApplication.shared.keyWindow?.insertSubview(hideScreenView, aboveSubview: view)
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.blurEffectView.alpha = 1
            self.hideScreenView.alpha = 1
        }, completion: nil)
    }
    
    
    
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        
        blurEffectView.removeFromSuperview()
        hideLabel.removeFromSuperview()
        
        hideScreenView.removeFromSuperview()
        
    }
    
    
    
    
    
    // Pass Data Back
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? ClassicScreenFull2 {
            controller.buttonNumber = buttonNumber
            controller.tableView.reloadData()
        }
    }
    
}

