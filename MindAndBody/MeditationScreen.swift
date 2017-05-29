//
//  MeditationScreen.swift
//  MindAndBody
//
//  Created by Luke Smith on 13.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import AVFoundation


var timerCountDown = Timer()

//
// Meditation Screen Class -------------------------------------------------------------------------------------------
//
class MeditationScreen: UIViewController {
    
    
    
    //
    // Arrays -------------------------------------------------------------------------------------------
    //
    var bellsArray: [String] = []
    //
    var backgroundSoundsArray: [String] = []
    //
    var selectedPreset = Int()
    
    
    // Arrays
    var durationArray: [Int] = []
    var startingBellsArray: [Int] = []
    var intervalBellsArray: [[Int]] = []
    var intervalTimes: [[Int]] = []
    var endingBellsArray: [Int] = []
    var selectedBackgroundSoundsArray: [Int] = []
    
    
    // Variables
    var didSetEndTime = false
    var startTime = Double()
    var endTime = Double()
    
    //
    var isHours = Bool()

    
    
    //
    // Outlets -------------------------------------------------------------------------------------------
    //
    // Timer Label
    @IBOutlet weak var timerLabel: UILabel!
    //
    // Timer Countdown
    //
    var timerValue = Int()
    
    // Down Arrow
    @IBOutlet weak var checkMark: UIButton!
    
    // Background Image
    @IBOutlet weak var backgroundImage: UIImageView!
    
    // Hide Screen
    @IBOutlet weak var hideScreen: UIButton!
    
    
    // Blurs
    let blur = UIVisualEffectView()
    let blur1 = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur3 = UIVisualEffectView()
    let blur4 = UIVisualEffectView()
    
    
    
    // Background Sound
   // var backgroundSound = AVAudioPlayer()
    
    
//
// View will appear -----------------------------------------------------------------------------------------------
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set Arrays
        let defaults = UserDefaults.standard
        durationArray = defaults.object(forKey: "meditationTimerDuration") as! [Int]
        startingBellsArray = defaults.object(forKey: "meditationTimerStartingBells") as! [Int]
        intervalBellsArray = defaults.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
        intervalTimes = UserDefaults.standard.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
        endingBellsArray = defaults.object(forKey: "meditationTimerEndingBells") as! [Int]
        selectedBackgroundSoundsArray = defaults.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
        
        
        
        //
        backgroundImage.frame = view.bounds
        
        // Background Index
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
        
        //
        // Background Image/Colour
        //
        if backgroundIndex < backgroundImageArray.count {
            //
            backgroundImage.image = backgroundImageArray[backgroundIndex]
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImage.image = nil
            backgroundImage.backgroundColor = colour1
        }
        
        
        
        
        // Initial Conditions
        //
        // Determine wether hours or not
        if durationArray[selectedPreset] > 3599 {
            isHours = true
        } else {
            isHours = false
        }
    }

    
//
// View did load -------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //
        // Colours
        //
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
        //
        switch backgroundIndex {
        // All Black
        case 1,3,backgroundImageArray.count:
            timerLabel.textColor = colour2
            hideScreen.tintColor = colour2
        // All White
        case 0,2,3,4,5,6:
            timerLabel.textColor = colour1
            hideScreen.tintColor = colour1
        //
        default: break
        }

        
        
        
        // CheckMark
        checkMark.tintColor = colour4
        
        
        
        //
        // Watch for enter foreground
        NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }

//
// View Did Appear
// 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Begin Timer
        startTimer()
        
    }
    
//
// Buttons -------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        
        // Blurs
        let blurE = UIBlurEffect(style: .dark)
        blur.effect = blurE
        let vibrancyE = UIVibrancyEffect(blurEffect: blurE)
        blur.effect = vibrancyE
        blur.frame = checkMark.bounds
        blur.isUserInteractionEnabled = false
        checkMark.insertSubview(blur, belowSubview: checkMark.imageView!)
        //
        let blurE1 = UIBlurEffect(style: .dark)
        blur1.effect = blurE1
        let vibrancyE1 = UIVibrancyEffect(blurEffect: blurE1)
        blur1.effect = vibrancyE1
        //
        if isHours == true {
            blur1.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: timerLabel.frame.size.height)
        } else {
            blur1.frame = CGRect(x: 0, y: 0, width: timerLabel.frame.size.width + 40, height: timerLabel.frame.size.height)
        }
        blur1.isUserInteractionEnabled = false
        blur1.layer.cornerRadius = 30
        blur1.layer.masksToBounds = true
        view.insertSubview(blur1, belowSubview: timerLabel)
        //
        //
        let blurE3 = UIBlurEffect(style: .dark)
        blur3.effect = blurE3
        let vibrancyE3 = UIVibrancyEffect(blurEffect: blurE3)
        blur3.effect = vibrancyE3
        blur3.frame = hideScreen.bounds
        blur3.isUserInteractionEnabled = false
        hideScreen.insertSubview(blur3, belowSubview: hideScreen.imageView!)
        //
        let blurE4 = UIBlurEffect(style: .dark)
        //let vibrancyE4 = UIVibrancyEffect(blurEffect: blurE4)
        //blur4.effect = vibrancyE4
        blur4.effect = blurE4
        blur4.frame = UIApplication.shared.statusBarFrame
        blur4.isUserInteractionEnabled = false
        
        
        // Corner radii
        //
        blur.layer.cornerRadius = checkMark.frame.size.height / 2
        blur.layer.masksToBounds = true
        //
        blur1.center = timerLabel.center
        //
        blur3.layer.cornerRadius = hideScreen.frame.size.height / 2
        blur3.layer.masksToBounds = true
        //
        view.addSubview(blur4)
    }
   
    
    
    
    //
    // Timer Functions ---------------------------------------------------------------------------------------------------------------
    //
    //
    // Update and Format Timer
    //
    // Timer CountDown Title
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    // Time formatted hours
    func timeFormattedHours(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    // Update Timer
    func updateTimer() {
        //
        if timerValue == 0 {
            timerCountDown.invalidate()
            //
            self.dismiss(animated: true)
            
            // Ending Bell
            //
            if endingBellsArray[selectedPreset] != -1 {

            let content = UNMutableNotificationContent()
            content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
            let soundName = bellsArray[endingBellsArray[selectedPreset]] + ".caf"
            content.sound = UNNotificationSound(named: soundName)
            
            //
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
            let name = "end"
            let request = UNNotificationRequest(identifier: name, content: content, trigger: trigger)
            
            //
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
            //
        } else if timerValue == 1 {
            timerValue -= 1
            if isHours == true {
                timerLabel.text = timeFormattedHours(totalSeconds: timerValue)
            } else {
                timerLabel.text = timeFormatted(totalSeconds: timerValue)
            }
            //
        } else {
            timerValue -= 1
            if isHours == true {
                timerLabel.text = timeFormattedHours(totalSeconds: timerValue)
            } else {
                timerLabel.text = timeFormatted(totalSeconds: timerValue)
            }
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
            createNotifications()
            //
            didSetEndTime = true
            //
            //
            let duration = durationArray[selectedPreset]
            let endingTime = Int(startTime) + duration
            //
            endTime = Double(endingTime)
            
            // Starting Bell
            //
            if startingBellsArray[selectedPreset] != -1 {
            
            let content = UNMutableNotificationContent()
            content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
            let soundName = bellsArray[startingBellsArray[selectedPreset]] + ".caf"
            content.sound = UNNotificationSound(named: soundName)
            
            //
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
            let name = "start"
            let request = UNNotificationRequest(identifier: name, content: content, trigger: trigger)
            
            //
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
        }
        
        // Set timer value
        timerValue = Int(endTime - startTime)
        
        // Check Greater than 0
        if timerValue <= 0 {
            timerValue = 0
        }
        
        // Set Timer
        // Set initial time
        if isHours == true {
            timerLabel.text = timeFormattedHours(totalSeconds: timerValue)
        } else {
            timerLabel.text = timeFormatted(totalSeconds: timerValue)
        }
        
        // Begin Timer or dismiss view
        timerCountDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    
    //
    // Notifications
    //
    func createNotifications() {
        
        if intervalBellsArray[selectedPreset].count != 0 {
        //
        // Bells
        for i in intervalTimes[selectedPreset] {
            let index = intervalTimes[selectedPreset].index(of: i)
            //
            let content = UNMutableNotificationContent()
            content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
            let soundName = bellsArray[intervalBellsArray[selectedPreset][index!]] + ".caf"
            content.sound = UNNotificationSound(named: soundName)
            
            //
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(i), repeats: false)
            let name = "bell" + String(describing: index)
            let request = UNNotificationRequest(identifier: name, content: content, trigger: trigger)
            
            //
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        }
    }
    //
    func removeNotifications() {
        //
        var identifiers: [String] = []
        //
        for i in 0...(intervalTimes[selectedPreset].count - 1) {
            //
            let name = "bell" + String(describing: i)
            //
            identifiers.append(name)
            //
        }
        //
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
//
// Buttons -------------------------------------------------------------------------------------------
//
    // Hide Screen
    let hideScreenView = UIView()
    //
    var brightness = UIScreen.main.brightness
    //
    @IBAction func hideScreen(_ sender: Any) {
        // Hide Screen view
        let screenSize = UIScreen.main.bounds
        hideScreenView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        hideScreenView.backgroundColor = .black
        hideScreenView.clipsToBounds = true
        hideScreenView.alpha = 0
        // single Tap
        let singleTap = UITapGestureRecognizer()
        singleTap.addTarget(self, action: #selector(handleTap))
        hideScreenView.isUserInteractionEnabled = true
        hideScreenView.addGestureRecognizer(singleTap)
        //
        UIApplication.shared.keyWindow?.insertSubview(self.hideScreenView, aboveSubview: view)
        //
        UIView.animate(withDuration: 0.4, animations: {
            UIApplication.shared.isStatusBarHidden = true
            self.hideScreenView.alpha = 1
        }, completion: { finished in
            UIScreen.main.brightness = CGFloat(0)
        })
    }
    // Remove Hide Screen
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        //
        UIApplication.shared.isStatusBarHidden = false
        hideScreenView.removeFromSuperview()
        UIScreen.main.brightness = brightness
    }
    
    // Dismiss View
    @IBAction func dismissView(_ sender: Any) {
        // Alert View
        let title = NSLocalizedString("finishEarly", comment: "")
        let message = NSLocalizedString("finishEarlyMessage", comment: "")
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
            // Cancel Timer
            timerCountDown.invalidate()
            NotificationCenter.default.removeObserver(self)
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
}
