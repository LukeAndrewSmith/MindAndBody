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
    
    
    //
    // Outlets -------------------------------------------------------------------------------------------
    //
    // Timer Label
    @IBOutlet weak var timerLabel: UILabel!
    //
    // Timer Countdown
    var timerCountDown = Timer()
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
    
    
    
    
//
// View will appear -----------------------------------------------------------------------------------------------
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    }
    
    
    
    
//
// Timer Functions ---------------------------------------------------------------------------------------------------------------
//
    var isTiming = false
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
            self.timerCountDown.invalidate()
            isTiming = false
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
    
    
    // Bells
    func bellNotifications() {
        
        //
        // Bells
        let intervalTimes = UserDefaults.standard.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
        let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
        
        for i in 0...1 {
        //
        let content = UNMutableNotificationContent()
        //content.title = NSLocalizedString("timerEnd", comment: "")
        //content.body = " "
        content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
        content.sound = UNNotificationSound.default()
        //
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(self.timerValue), repeats: false)
        let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
    
        //
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }


    var isHours = Bool()
//
// View did load -------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CheckMark
        checkMark.tintColor = colour4
        
        
        //
        hideScreen.tintColor = colour1
        
        
        
        
        
        //
        // Test
        //
        let content = UNMutableNotificationContent()
        content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
        content.sound = UNNotificationSound.default()
        //
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(5), repeats: false)
        let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
        
        //
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        
        
        
        
        //
        let defaults = UserDefaults.standard
        //
        let presetsArray = defaults.object(forKey: "meditationTimerTitles") as! [String]
        //
        let durationArray = defaults.object(forKey: "meditationTimerDuration") as! [Int]
        let startingBellsArray = defaults.object(forKey: "meditationTimerStartingBells") as! [Int]
        let intervalBellsArray = defaults.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
        let intervalBellsTimesArray = defaults.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
        let endingBellsArray = defaults.object(forKey: "meditationTimerEndingBells") as! [Int]
        let selectedBackgroundSoundsArray = defaults.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
        
        
        // Determine wether hours or not
        if durationArray[selectedPreset] > 3599 {
            isHours = true
        } else {
            isHours = false
        }
        
        // Set initial time
        if isHours == true {
            timerLabel.text = timeFormattedHours(totalSeconds: durationArray[selectedPreset])
        } else {
            timerLabel.text = timeFormatted(totalSeconds: durationArray[selectedPreset])
        }

        // SEt timer value
        timerValue = durationArray[selectedPreset]
        
        
        
        // Blur
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        //
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurEffectView)
//        view.sendSubview(toBack: blurEffectView)
//        //
//        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
//        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
//        vibrancyEffectView.frame = view.bounds
//        vibrancyEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //view.addSubview(vibrancyEffectView)
        //view.sendSubview(toBack: vibrancyEffectView)
        
        
    }

//
// View Did Appear
// 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Begin Timer
        self.timerCountDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        
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
            self.timerCountDown.invalidate()
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
