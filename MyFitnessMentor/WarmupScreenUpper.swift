//
//  PresentationScreen.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 29/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation



class WarmupScreenUpper: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
//    weak var delegate: ModalViewControllerDelegate? = nil
//  
    
    
    // Warmup Screen Index
    //
    var warmupScreenIndex = 0

    
    //Outlets
    //
    
    // Scroll Views
    @IBOutlet weak var scrollViewExplanation: UIScrollView!
    @IBOutlet weak var scrollViewDemonstration: UIScrollView!
    @IBOutlet weak var scrollViewClock: UIScrollView!
    
    
    // TableView
    @IBOutlet weak var tableView: UITableView!
    
    
    // Body Image View
    @IBOutlet weak var bodyImage: UIImageView!
    
    
    
    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // Extra Information View
    @IBOutlet weak var extraInformationView: UIView!


    // Explanation Title Label
    @IBOutlet weak var explanationTitle: UILabel!
    
    
    
    //
    // Initialize Arrays
    //
 
    var warmupMovementsArray: [String] = []

    
    
    
    //
    // Initialize View Elements
    //
    
    
        // Explanation Label
        let explanationLabel = UILabel()

    
        // Clock/Time Views
        let timerView = UIView()
        let clockView = UIView()
    
    
        // Timer View Position
        let timerViewPosition = UIView()
        // Timer View CountDown
        let timerViewCountDown = UIView()
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
    
    
        // ScrollViewClock Position Indicators
        let leftDot = UILabel()
        let rightDot = UILabel()
    
    
        // Picker Data
        var minuteData = [Int]()
        var secondData = [Int]()
        // Picker Views
        let minutePicker = UIPickerView()
        let secondPicker = UIPickerView()
        // Picker Background View
        let pickerViewTimer = UIView()
        //
        let nilLabel = UILabel()
    
    
        // Stop Clock Label
        let stopClockLabel = UILabel()
        // StopClock Start Button
        let stopClockStart = UIButton()
        // StopClock Stop
        let stopClockStop = UIButton()
        // StopClock Reset
        let stopClockReset = UIButton()
        // StopClock Value
        var stopClockValue = 0
        // StopClock Timer
        var stopClockTimer = Timer()
    
    
    
    
    
    // Hide Back Button
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    //
    // ViewDidLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Background Gradient
        //
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        
        
        
        
        //
        // Scroll View Explanation Label
        //
        
        explanationTitle.text = NSLocalizedString("explanationTitle", comment: "")
        
        scrollViewExplanation.frame = CGRect(x: 0, y: 0, width: scrollViewExplanation.frame.size.width, height: scrollViewExplanation.frame.size.height)
        scrollViewExplanation.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        
            // Explanation Label
            explanationLabel.frame = CGRect(x: 10, y: 10, width: scrollViewExplanation.frame.size.width - 20, height: scrollViewExplanation.frame.size.height)
            //explanationLabel.text = NSLocalizedString("purposeText", comment: "")
        
        
            explanationLabel.font = UIFont(name: "SFUIDisplay-light", size: 19)
            explanationLabel.textAlignment = .justified
            explanationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            explanationLabel.numberOfLines = 0
            explanationLabel.sizeToFit()

        
        scrollViewExplanation.addSubview(explanationLabel)
        scrollViewExplanation.contentSize = CGSize(width: scrollViewExplanation.frame.size.width, height: explanationLabel.frame.size.height + 20)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //
        // Scroll  View Clock
        //
        
        scrollViewClock.frame = CGRect(x: 0, y: scrollViewClock.frame.maxY, width: scrollViewClock.frame.size.width, height: scrollViewClock.frame.size.height)
        scrollViewClock.contentSize = CGSize(width: scrollViewClock.frame.size.width * 2, height: scrollViewClock.frame.size.height)
        scrollViewClock.isScrollEnabled = false
        
        
        
        
        
        
        //
        // CountDown Timer
        //
        
            // Timer View
            timerView.frame = CGRect(x: 0, y: 0, width: scrollViewClock.frame.size.width, height: scrollViewClock.frame.size.height)
            timerView.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        
            let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleClockSwipes))
            leftSwipe.direction = UISwipeGestureRecognizerDirection.left
            timerView.addGestureRecognizer(leftSwipe)
            timerView.isUserInteractionEnabled = true
        
        

        
            // Timer View Position Indicator (Two dots at bottom of view)
            //
            timerViewPosition.frame = CGRect(x: 0, y: 0, width: (view.frame.size.width - 4) / 2, height: scrollViewClock.frame.size.height / 8)
            timerViewPosition.center = CGPoint(x: collectionView.center.x * 1.5, y: collectionView.center.y - (24.5/2) - (timerViewPosition.frame.size.height / 2))
            timerViewPosition.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        
        
            // Timer View Left Indicator
            leftDot.frame = CGRect(x: (timerViewPosition.frame.size.width * (9/20)) - ((timerView.frame.size.height/32)/2), y: (timerViewPosition.frame.size.height / 2) - ((timerView.frame.size.height/32)/2), width: timerView.frame.size.height/32, height: timerView.frame.size.height/32)
            //
            leftDot.layer.cornerRadius = (timerView.frame.size.height/32)/2
            leftDot.layer.masksToBounds = true
        
            timerViewPosition.addSubview(leftDot)
        
        
        
            // Timer View Right Indicator
            rightDot.frame = CGRect(x: (timerViewPosition.frame.size.width * (11/20)) - ((timerView.frame.size.height/32)/2), y: (timerViewPosition.frame.size.height / 2) - ((timerView.frame.size.height/32)/2), width: timerView.frame.size.height/32, height: timerView.frame.size.height/32)
            //
            rightDot.layer.cornerRadius = (timerView.frame.size.height/32)/2
            rightDot.layer.masksToBounds = true
        
            timerViewPosition.addSubview(rightDot)
        
        
            leftDot.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
            rightDot.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)

        
        
                self.view.addSubview(timerViewPosition)
        
        
        
        
        
            // Timer View CountDown Label View
            //
            timerViewCountDown.frame = CGRect(x: 0, y: 0, width: self.timerView.frame.size.width/1.5, height: self.timerView.frame.size.height/3)
            timerViewCountDown.center = CGPoint(x: self.timerView.center.x, y: self.timerView.frame.size.height / 3)
            timerViewCountDown.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
            self.timerView.addSubview(timerViewCountDown)
            self.timerView.sendSubview(toBack: timerViewCountDown)
        
        
            // TimerView CountDown Label
            countDownLabel.frame = CGRect(x: 0, y: 0, width: self.timerView.frame.size.width/1.5, height: self.timerView.frame.size.height/3)
            countDownLabel.textAlignment = .center
            countDownLabel.font = UIFont(name: "SFUIDisplay-Light", size: 27)
            countDownLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        
            self.timerViewCountDown.addSubview(countDownLabel)
        
        
        
        
        
        
        
            // Picker View Timer
            //
            pickerViewTimer.frame = CGRect(x: 0, y: 0, width: self.timerView.frame.size.width * 0.75, height: self.timerView.frame.size.height/3)
            pickerViewTimer.center = CGPoint(x: self.timerView.center.x, y: self.timerView.frame.size.height / 3)
            pickerViewTimer.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)

        
        
            // Pick Minutes
            //
            minutePicker.frame = CGRect(x: 0, y: 0, width: pickerViewTimer.frame.size.width / 4, height: pickerViewTimer.frame.size.height)
            minutePicker.dataSource = self
            minutePicker.delegate = self
            minutePicker.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
            pickerViewTimer.addSubview(minutePicker)
        
        
            let minuteLabel = UILabel()
            minuteLabel.frame = CGRect(x: minutePicker.frame.size.width, y: 0, width: minutePicker.frame.size.width, height: pickerViewTimer.frame.size.height)
            minuteLabel.text = NSLocalizedString("minutes", comment: "")
            minuteLabel.font = UIFont(name: "SFUIDisplay-light", size: 17)
            minuteLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            minuteLabel.textAlignment = .left
        
            pickerViewTimer.addSubview(minuteLabel)
        
        
        
            // Pick Seconds
            //
            secondPicker.frame = CGRect(x: minutePicker.frame.size.width + minuteLabel.frame.size.width, y: 0, width: pickerViewTimer.frame.size.width / 4, height: pickerViewTimer.frame.size.height)
            secondPicker.dataSource = self
            secondPicker.delegate = self
            secondPicker.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
            pickerViewTimer.addSubview(secondPicker)
       
        
            let secondLabel = UILabel()
            secondLabel.frame = CGRect(x: minutePicker.frame.size.width + minuteLabel.frame.size.width + secondPicker.frame.size.width, y: 0, width: secondPicker.frame.size.width, height: pickerViewTimer.frame.size.height)
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
            timerStart.frame = CGRect(x: 0, y: 0, width: self.timerView.frame.size.width * (2/3), height: self.timerView.frame.size.height/7)
            timerStart.center = CGPoint(x: timerView.center.x, y: (self.timerView.frame.size.height / 4) * 3)
            timerStart.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
            timerStart.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
            timerStart.titleLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            timerStart.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)
            timerStart.titleLabel?.textAlignment = .center
        
            timerStart.addTarget(self, action: #selector(startTimer(_:)), for: .touchUpInside)
        
            timerView.addSubview(timerStart)
        
        
        
            // Cancel Button Timer
            //
            timerCancel.frame = CGRect(x: 0, y: 0, width: self.timerView.frame.size.width * (2/3), height: self.timerView.frame.size.height/7)
            timerCancel.center = CGPoint(x: timerView.center.x, y: (self.timerView.frame.size.height / 4) * 3)
            timerCancel.backgroundColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0)
            timerCancel.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
            timerCancel.titleLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            timerCancel.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)
            timerCancel.titleLabel?.textAlignment = .center
        
            timerCancel.addTarget(self, action: #selector(cancelTimer(_:)), for: .touchUpInside)
        
            timerView.addSubview(timerCancel)
        
            timerView.sendSubview(toBack: timerCancel)

        
                scrollViewClock.addSubview(timerView)
        
        
        
        
    
        
        
        //
        // StopClock
        //
        
        
        
            // StopClock View
            //
            clockView.frame = CGRect(x: scrollViewClock.frame.maxX, y: 0, width: scrollViewClock.frame.size.width, height: scrollViewClock.frame.size.height)
            clockView.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleClockSwipes))
            rightSwipe.direction = UISwipeGestureRecognizerDirection.right
            clockView.addGestureRecognizer(rightSwipe)
            clockView.isUserInteractionEnabled = true
        
        
        
                scrollViewClock.addSubview(clockView)
        
        
        
        
            //
            // StopClock Label
            //stopClockLabel.frame = CGRect(x: 0, y: 0, width: self.clockView.frame.size.width/1.5, height: self.clockView.frame.size.height/3)
            stopClockLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            stopClockLabel.center = CGPoint(x: timerView.center.x, y: self.timerView.frame.size.height / 3)
            stopClockLabel.textAlignment = .center
            stopClockLabel.font = UIFont(name: "SFUIDisplay-Light", size: 27)
            stopClockLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            stopClockLabel.text = "00:00"
            stopClockLabel.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
    

                self.clockView.addSubview(stopClockLabel)
        
        
        
        
            // Start Button StopClock
            stopClockStart.frame = CGRect(x: 0, y: 0, width: self.timerView.frame.size.width * (1/3), height: self.timerView.frame.size.height/7)
            stopClockStart.center = CGPoint(x: (timerView.center.x * 1.5) - (stopClockStart.frame.size.width / 16), y: (self.timerView.frame.size.height / 4) * 3)
            stopClockStart.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
            stopClockStart.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
            stopClockStart.titleLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            stopClockStart.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)
            stopClockStart.titleLabel?.textAlignment = .center
        
            stopClockStart.addTarget(self, action: #selector(startStopClock(_:)), for: .touchUpInside)
        
            clockView.addSubview(stopClockStart)
        
        
            // Stop Button StopClock
            stopClockStop.frame = CGRect(x: 0, y: 0, width: self.timerView.frame.size.width * (1/3), height: self.timerView.frame.size.height/7)
            stopClockStop.center = CGPoint(x: (timerView.center.x * 1.5) - (stopClockStart.frame.size.width / 16), y: (self.timerView.frame.size.height / 4) * 3)
            stopClockStop.backgroundColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0)
            stopClockStop.setTitle(NSLocalizedString("stop", comment: ""), for: .normal)
            stopClockStop.titleLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            stopClockStop.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)
            stopClockStop.titleLabel?.textAlignment = .center
        
            stopClockStop.addTarget(self, action: #selector(stopStopClock(_:)), for: .touchUpInside)
        
            clockView.addSubview(stopClockStop)
        
        
            // Reset Button StopClock
            stopClockReset.frame = CGRect(x: 0, y: 0, width: self.timerView.frame.size.width * (1/3), height: self.timerView.frame.size.height/7)
            stopClockReset.center = CGPoint(x: (timerView.center.x / 2) + (stopClockReset.frame.size.width / 16), y: (self.timerView.frame.size.height / 4) * 3)
            stopClockReset.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
            stopClockReset.setTitle(NSLocalizedString("reset", comment: ""), for: .normal)
            stopClockReset.titleLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            stopClockReset.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)
            stopClockReset.titleLabel?.textAlignment = .center
        
            stopClockReset.addTarget(self, action: #selector(resetStopClock(_:)), for: .touchUpInside)
        
            clockView.addSubview(stopClockReset)
        
            stopClockReset.isUserInteractionEnabled = false
        
        
        
        
            clockView.bringSubview(toFront: stopClockStart)
        
        
        
        
        
        
        
        // Extra Information View
        //
        self.extraInformationView.frame = CGRect(x: 0, y: self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.height, height: self.view.frame.size.height)
        self.extraInformationView.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        
        
            // Extra Information Label
            let extraInformationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 49))
            extraInformationLabel.text = NSLocalizedString("information", comment: "")
            extraInformationLabel.textAlignment = .center
            extraInformationLabel.font = UIFont(name: "SFUIDisplay-medium", size: 20)
            extraInformationLabel.textColor = .white
            extraInformationLabel.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
        
            // Swipe Down
            //
            let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            downSwipe.direction = UISwipeGestureRecognizerDirection.down
            extraInformationLabel.addGestureRecognizer(downSwipe)
            extraInformationLabel.isUserInteractionEnabled = true
    
        extraInformationView.addSubview(extraInformationLabel)

        
        
        
        
        
        // Collection View
        collectionView.backgroundColor = .black
        
        
        
        
        // View Order
        //
        view.bringSubview(toFront: timerViewPosition)
        view.bringSubview(toFront: extraInformationView)
        view.bringSubview(toFront: collectionView)
        
        
        
        
        
        
        // Display Content
        //
        displayContent()
        
        

        
        
        
        
        
        //
        // End of ViewDidLoad()
        //
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
            self.timerView.bringSubview(toFront: pickerViewTimer)
            self.timerView.bringSubview(toFront: timerStart)
            
            // Vibrate and Sound
            let systemSoundID: SystemSoundID = 1016
            AudioServicesPlaySystemSound (systemSoundID)
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            
        } else if timerValue == 1 {
            
            // Vibrate and Sound
            let systemSoundID: SystemSoundID = 1016
            AudioServicesPlaySystemSound (systemSoundID)
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            timerValue -= 1
            countDownLabel.text = timeFormatted(totalSeconds: timerValue)
            
        } else {
        timerValue -= 1
        countDownLabel.text = timeFormatted(totalSeconds: timerValue)
        
        }
        
    }
    

    let timerShapeLayer = CAShapeLayer()
    //            var countDownTimer = Timer()
    
    //            let timerLabel = UILabel()
    
    
    
    // Funcs
    func addCircle() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: timerView.center.x ,y: (timerView.center.y * 2) / 3), radius: CGFloat((timerView.frame.size.width / 2) - 30), startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(2*M_PI-M_PI_2), clockwise: true)
        timerShapeLayer.path = circlePath.cgPath
        timerShapeLayer.fillColor = UIColor.clear.cgColor
        timerShapeLayer.strokeColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0).cgColor
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
        
        
        
        self.timerView.sendSubview(toBack: pickerViewTimer)
        self.timerView.bringSubview(toFront: timerCancel)
        
        self.countDownLabel.text = timeFormatted(totalSeconds: timerValue)
        
        let delayInSeconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            
            self.addCircle()
            self.startAnimation()
            self.timerCountDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
            
            
        }
        
        }
        
    }
    
    
    
    @IBAction func cancelTimer(_ sender: Any) {
        
        
        self.timerCountDown.invalidate()
        self.timerValue = 0
        removeCircle()
        self.timerView.bringSubview(toFront: pickerViewTimer)
        self.timerView.bringSubview(toFront: timerStart)
        
        
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
        
        return nilLabel
    }
    
    
    
    
    //
    // StopClock
    //
    
    func updateStopClock() {
        
        
        if stopClockValue == 3600 {
            
            self.stopClockTimer.invalidate()
            
            
        } else {
        
            stopClockValue += 1
            stopClockLabel.text = timeFormatted(totalSeconds: stopClockValue)

        }
        
    }

    
    
    
    @IBAction func startStopClock(_ sender: Any) {
        
    
        self.clockView.bringSubview(toFront: stopClockStop)

        
        self.countDownLabel.text = timeFormatted(totalSeconds: stopClockValue)
    
        self.stopClockTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateStopClock), userInfo: nil, repeats: true)
        
        
        stopClockReset.isUserInteractionEnabled = false
        
    }

    
    @IBAction func stopStopClock(_ sender: Any) {
        
        
        self.clockView.bringSubview(toFront: stopClockStart)
        
        
        self.stopClockTimer.invalidate()
        
        stopClockReset.isUserInteractionEnabled = true
    
    }
    
    
    @IBAction func resetStopClock(_ sender: Any) {
        
        
        stopClockValue = 0
        self.stopClockLabel.text = "00:00"
        
        stopClockReset.isUserInteractionEnabled = false
    }
    
    
    
    
    
    




    
    
    
    
    
    
    
    // Display Content Function
    func displayContent() {
        
        
        // Navigation Bar
        self.navigationItem.title = warmupMovementsArray[warmupScreenIndex]
        
        
        // TableView
        self.tableView.reloadData()
        
        
        // Body Image
        bodyImage.image = #imageLiteral(resourceName: "BodyImage")
        
        
        
        
        // Explanation Label
        
        
        
        
        
        
        // Demonstration Image
        
        
        
        
        
        
        // Extra Information Label
        
        
        
        
        
        
        
    }

    
    
    
    
    
    
    
    
    
    
    
    // Flash Screen
    func flashScreen() {
        
        let flash = UIView()
        
        flash.frame = CGRect(x: 0, y: -100, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0)
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
    // Top Bar Button Actions
    //
    // Back button
    
        @IBAction func backButton(_ sender: Any) {
    
            if warmupScreenIndex == 0 {
            
            } else {
                warmupScreenIndex = warmupScreenIndex - 1
        
                displayContent()
            }
        
        
            // Swipe Down on Press
            if self.extraInformationView.frame.maxY == self.view.frame.maxY + 24.5 {
            
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                    self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            
            
            }
            
            flashScreen()

        }
    
    
    
    
        // Next Button
        @IBAction func nextButton(_ sender: Any) {
    
            if warmupScreenIndex == warmupMovementsArray.count - 1 {
                
                warmupScreenIndex = 0
                
                self.dismiss(animated: true)
                
                
                
            } else {
                warmupScreenIndex = warmupScreenIndex + 1
                displayContent()
            }
    
            // Swipe Down on Press
            if self.extraInformationView.frame.maxY == self.view.frame.maxY + 24.5 {
            
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                    self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            }
            
            
            flashScreen()
        
            
        }
    
    
        // Extra Information Button
        @IBAction func extraInformationButton(_ sender: Any) {
        
        
            if self.extraInformationView.frame.maxY == self.view.frame.maxY + self.view.frame.size.height {
                
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                    self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.size.height - 24.5))
                }, completion: nil)
        
            } else if self.extraInformationView.frame.maxY == self.view.frame.maxY + 24.5 {
            
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                    self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            }
        }
    
    
    
    
    
    
    
    
    
    //
    // Swipe Handlers
    //

    
    // Extra InformationLabel Downswipe
    //
    
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.extraInformationView.frame.maxY == self.view.frame.maxY + 24.5 {
                
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                    
                    self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            }
        }
    }

    
    // Horizontal Clock Swipe
    @IBAction func handleClockSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .left){
            
          
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                    
                self.scrollViewClock.contentOffset.x = self.scrollViewClock.frame.size.width
            }, completion: nil)
            
            
            leftDot.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            rightDot.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
            
            
            
        } else if (extraSwipe.direction == .right){
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                self.scrollViewClock.contentOffset.x = 0
            }, completion: nil)
            
            
            leftDot.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
            rightDot.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)

            
            
        }
    }
    
    

    
    
    
    


    
    
    
    

    
    
    //
    // Table View and Collection View
    //
    
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return 5
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let titleCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        
        if indexPath.row == 0 {
            titleCell.textLabel?.text = (NSLocalizedString("setsReps", comment: "") + " " + String(warmupScreenIndex))
            titleCell.textLabel?.textAlignment = .center
            titleCell.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)
            titleCell.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
            titleCell.textLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            titleCell.isUserInteractionEnabled = false
            
            
            return titleCell
        } else {
            cell.textLabel?.text = "Hi"
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 17)
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.tintColor = UIColor.black
            return cell
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 35.0
        } else if indexPath.row != 0{
            
            
            
            let height = ((self.view.frame.size.height / 3) - 35)
            
            
            
            return height / 4
            
            
            
        }
        
        
        return 35.0
    }

    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
    }
    
    
    
    
    
    
    
    
    
    // Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return warmupMovementsArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
        
        
        cell.backgroundColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0)
        
        //Green colour: UIColor(red:0.41, green:0.97, blue:0.63, alpha:1.0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCells = CGFloat(warmupMovementsArray.count)
        
        let width = (self.view.frame.size.width-3)/numberOfCells
        return CGSize(width: width, height: 24.5)
    }
    
    
    
    
    
    
}
