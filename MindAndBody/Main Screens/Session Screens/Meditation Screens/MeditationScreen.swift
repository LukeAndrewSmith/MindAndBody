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


var rowTimer = Timer()
var endingBellPlayer = AVAudioPlayer()

//
// Meditation Screen Class -------------------------------------------------------------------------------------------
//
class MeditationScreen: UIViewController {
    
    var selectedPreset = Int()
    
    // For guided meditation
    var durationOfPractice = Int()
    var bellChosen = String()
    var bellFrequency = Int()
    
    var audioPlayerArray: [AVAudioPlayer] = []
    
    // Variables
    var startTime = Double()
    var endTime = Double()
    
    //
    var isHours = Bool()
    
    // Meditation Array
    let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
    
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
    
    // Hide Screen
    @IBOutlet weak var hideScreen: UIButton!
    
    
    // Blurs
    let blur = UIVisualEffectView()
    let blur1 = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur3 = UIVisualEffectView()
    let blur4 = UIVisualEffectView()
    
    // Button things
    // Hide Screen
    let hideScreenView = UIView()
    //
    var userBrightness = UIScreen.main.brightness
    
    // Background Sound
    var soundPlayer: AVAudioPlayer?
    
    var fromSchedule = false
    
    //
    // View will appear -----------------------------------------------------------------------------------------------
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        // BackgroundImage
        if selectedPreset != -1 {
            if let backgroundSound = meditationArray[selectedPreset]["BackgroundSound"]?[0][0] as? Int, backgroundSound != -1 {
                addBackgroundImage(withBlur: false, fullScreen: true, image: MeditationSounds.shared.backgroundSoundsArray[backgroundSound])
            } else {
                addBackgroundImage(withBlur: true, fullScreen: true, image: "")
            }
        } else {
            addBackgroundImage(withBlur: true, fullScreen: true, image: "")
        }
        
        
        // Initial Conditions
        //
        // Determine wether hours or not
        if selectedPreset != -1 {
            if meditationArray[selectedPreset]["Duration"]?[0][0] as! Int > 3599 {
                isHours = true
            } else {
                isHours = false
            }
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
        // Enable audio in background for Meditation Bells/Sounds
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)), mode: .default)
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
        
        // Colours
        timerLabel.textColor = Colors.light
        hideScreen.tintColor = Colors.light
        
        // Element Positions
        // Iphone 5
        if IPhoneType.shared.iPhoneType() == IPhone.little {
           timerLabel.font = UIFont(name: "SFUIDisplay-thin", size: 50)
        }
        
        // CheckMark
        checkMark.tintColor = Colors.red
        
        // Watch for enter foreground
        NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    //
    // View Did Appear
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Begin Timer
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Remove observers
        NotificationCenter.default.removeObserver(self)

        // Set back to false
        BellPlayer.shared.didSetEndTime = false
        UIScreen.main.brightness = userBrightness
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
        //let vibrancyE = UIVibrancyEffect(blurEffect: blurE)
        //blur.effect = vibrancyE
        blur.frame = checkMark.bounds
        blur.isUserInteractionEnabled = false
        checkMark.insertSubview(blur, belowSubview: checkMark.imageView!)
        //
        let blurE1 = UIBlurEffect(style: .dark)
        blur1.effect = blurE1
        let vibrancyE1 = UIVibrancyEffect(blurEffect: blurE1)
        blur1.effect = vibrancyE1
        //
        if isHours {
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
    
    
    
    
    // MARK:- Timer Functions
    // Update and Format Timer
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
    @objc func updateTimer() {

        // MARK: End of meditation
        if timerValue == 0 {
            //
            rowTimer.invalidate()
            // Stop sounds
            if selectedPreset != -1 && meditationArray[selectedPreset]["BackgroundSound"]?[0][0] as! Int != -1 {
                if (self.soundPlayer?.isPlaying)! {
                    self.soundPlayer?.stop()
                }
            }
            //
            NotificationCenter.default.removeObserver(self)
            //
            // Schedule Tracking
            ScheduleManager.shared.shouldReloadScheduleTracking()
            //
            if view.subviews.contains(hideScreenView) {
                UIApplication.shared.isStatusBarHidden = false
                hideScreenView.removeFromSuperview()
                UIScreen.main.brightness = userBrightness
            }
            //
            self.dismiss(animated: true)
            //
        } else {
            timerValue -= 1
            if isHours {
                timerLabel.text = timeFormattedHours(totalSeconds: timerValue)
            } else {
                timerLabel.text = timeFormatted(totalSeconds: timerValue)
            }
        }
    }
    
    // Start Timer
    @objc func startTimer() {
        
        // Dates and Times
        startTime = Date().timeIntervalSinceReferenceDate

        // Meditation Timer
        if selectedPreset != -1 && BellPlayer.shared.didSetEndTime == false {

            BellPlayer.shared.didSetEndTime = true

            let duration = meditationArray[selectedPreset]["Duration"]?[0][0] as! Int
            endTime = startTime + Double(duration)
            
            // Bells
            // Perform delays
            for i in 0...(meditationArray[selectedPreset]["Bells"]?.count)! - 2 {
                // Bells
                if meditationArray[selectedPreset]["Bells"]?[i][0] as! Int != -1 {
                    // Delay bell
                    let delayInSeconds = Double(meditationArray[selectedPreset]["Bells"]?[i][1] as! Int)
                    // Play with delay
                    let url = Bundle.main.url(forResource: MeditationSounds.shared.bellsArray[meditationArray[selectedPreset]["Bells"]?[i][0] as! Int], withExtension: "caf")!

                    do {
                        let audioPlayer = try AVAudioPlayer(contentsOf: url)
                        audioPlayerArray.append(audioPlayer)
                        audioPlayer.play(atTime: audioPlayer.deviceCurrentTime + delayInSeconds)
                    } catch {
                        // couldn't load file :(
                    }
                }
            }
            
            // Ending Bell
            // Requires different audio player to continue playing after view is dismissed
            let lastIndex = (meditationArray[selectedPreset]["Bells"]?.count)! - 1
            if meditationArray[selectedPreset]["Bells"]?[lastIndex][0] as! Int != -1 {

                // Delay bell
                let delayInSeconds = Double(meditationArray[selectedPreset]["Bells"]?[lastIndex][1] as! Int)
                
                let url = Bundle.main.url(forResource: MeditationSounds.shared.bellsArray[meditationArray[selectedPreset]["Bells"]?[lastIndex][0] as! Int], withExtension: "caf")!
                do {
                    endingBellPlayer = try AVAudioPlayer(contentsOf: url)
                    audioPlayerArray.append(endingBellPlayer)
                    endingBellPlayer.play(atTime: endingBellPlayer.deviceCurrentTime + delayInSeconds)
                } catch {
                    // couldn't load file :(
                }
            }
            
            // Background Sound
            if meditationArray[selectedPreset]["BackgroundSound"]?[0][0] as! Int != -1 {
                let url = Bundle.main.url(forResource: MeditationSounds.shared.backgroundSoundsArray[meditationArray[selectedPreset]["BackgroundSound"]?[0][0] as! Int], withExtension: "caf")!
                //
                do {
                    let bell = try AVAudioPlayer(contentsOf: url)
                    soundPlayer = bell
                    soundPlayer?.numberOfLoops = -1
                    bell.play()
                } catch {
                    // couldn't load file :(
                }
            }
            
        // Meditation Guided
        } else if selectedPreset == -1 && BellPlayer.shared.didSetEndTime == false {
            
            // Get the bells
            let url = Bundle.main.url(forResource: bellChosen, withExtension: "caf")!
            // MARK: Ending bell
            // 4 times so user knows when the meditation has ended
            let urlEnding = Bundle.main.url(forResource: "tibetanBowlL4", withExtension: "caf")!

            endTime = startTime + Double(durationOfPractice)
            BellPlayer.shared.didSetEndTime = true

            // Bells
            // Perform delays
            var bellTime = bellFrequency
            // Start Bell
            // Play with delay
            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayerArray.append(audioPlayer)
                audioPlayer.play(atTime: audioPlayer.deviceCurrentTime)
            } catch {
                // couldn't load file :(
            }
            //var bellTime = startTime
            if bellFrequency != 0 {
                while bellTime < durationOfPractice {
                    // Bells
                    // Delay bell
                    let delayInSeconds = bellTime
                    bellTime += bellFrequency
                    // Play with delay
                    do {
                        let audioPlayer = try AVAudioPlayer(contentsOf: url)
                        audioPlayerArray.append(audioPlayer)
                        audioPlayer.play(atTime: audioPlayer.deviceCurrentTime + Double(delayInSeconds))
                    } catch {
                        // couldn't load file :(
                    }
                }
            }
            
            // Ending Bell
            // Requires different audio player to continue playing after view is dismissed
            // Delay bell
            do {
                endingBellPlayer = try AVAudioPlayer(contentsOf: urlEnding)
                audioPlayerArray.append(endingBellPlayer)
                endingBellPlayer.play(atTime: endingBellPlayer.deviceCurrentTime + Double(durationOfPractice))
            } catch {
                // couldn't load file :(
            }
        }
        
        // Same for both guided and timer
        // Set timer value
        timerValue = Int(endTime - startTime)
        
        // Check Greater than 0
        if timerValue <= 0 {
            timerValue = 0
        }
        
        // Set Timer
        // Set initial time
        if isHours {
            timerLabel.text = timeFormattedHours(totalSeconds: timerValue)
        } else {
            timerLabel.text = timeFormatted(totalSeconds: timerValue)
        }
        
        // Begin Timer
        rowTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    
    //
    // Buttons -------------------------------------------------------------------------------------------
    //
    //
    @IBAction func hideScreen(_ sender: Any) {
        // Hide Screen view
        let screenSize = UIScreen.main.bounds
        hideScreenView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        hideScreenView.backgroundColor = .black
        hideScreenView.clipsToBounds = true
        hideScreenView.alpha = 0
        
        let label = UILabel()
        label.text = NSLocalizedString("tapToDismiss", comment: "")
        label.font = UIFont(name: "SFUIDisplay-light", size: 30)
        label.textColor = Colors.light
        label.sizeToFit()
        label.center = view.center
        hideScreenView.addSubview(label)
        
        // single Tap
        let singleTap = UITapGestureRecognizer()
        singleTap.addTarget(self, action: #selector(handleTap))
        hideScreenView.isUserInteractionEnabled = true
        hideScreenView.addGestureRecognizer(singleTap)
        //
        view.addSubview(hideScreenView)
        //
        UIView.animate(withDuration: 0.4, animations: {
            UIApplication.shared.isStatusBarHidden = true
            self.hideScreenView.alpha = 1
            UIScreen.main.brightness = CGFloat(0.25)
        }, completion: { finished in
        })
    }
    
    // Remove Hide Screen
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        //
        UIApplication.shared.isStatusBarHidden = false
        hideScreenView.removeFromSuperview()
        UIScreen.main.brightness = userBrightness
    }
    
    
    
    // Dismiss View
    @IBAction func dismissView(_ sender: Any) {
        // Alert View
        let title = NSLocalizedString("finishEarly", comment: "")
        let message = NSLocalizedString("finishEarlyMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        // Action
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            // Cancel Timer
            rowTimer.invalidate()
            // Timer
            if self.selectedPreset != -1 {
                // Stop sounds
                if self.meditationArray[self.selectedPreset]["BackgroundSound"]?[0][0] as! Int != -1 {
                    if (self.soundPlayer?.isPlaying)! {
                        self.soundPlayer?.stop()
                    }
                }
                // Cancel Work Items
                if self.audioPlayerArray.count != 0 {
                    for i in 0..<self.audioPlayerArray.count {
                        self.audioPlayerArray[i].stop()
                    }
                }
            // Guided
            } else {
                // Stop sounds
                if self.soundPlayer != nil {
                    if (self.soundPlayer?.isPlaying)! {
                        self.soundPlayer?.stop()
                    }
                }
                // Cancel Work Items
                if self.audioPlayerArray.count != 0 {
                    for i in 0..<self.audioPlayerArray.count {
                        self.audioPlayerArray[i].stop()
                    }
                }
            }
            NotificationCenter.default.removeObserver(self)
            if UIScreen.main.brightness == 0 {
                UIScreen.main.brightness = self.userBrightness
            }
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default) {
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


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
