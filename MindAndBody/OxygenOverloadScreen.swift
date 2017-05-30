//
//  OxygenOverloadScreen.swift
//  MindAndBody
//
//  Created by Luke Smith on 30.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import AVFoundation


var timerCountUp = Timer()

//
// Oxgen Overload Screen Screen Class -------------------------------------------------------------------------------------------
//
class OxygenOverloadScreen: UIViewController {
    
    
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
    var didStartTimer = false
    
    
    
    //
    // Outlets -------------------------------------------------------------------------------------------
    //
    // Timer Label
    @IBOutlet weak var timerLabel: UILabel!
    //
    // Timer Countdown
    //
    var timerValue: Int = 0
    
    // Down Arrow
    @IBOutlet weak var checkMark: UIButton!
    
    // Background Image
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    // Blurs
    let blur = UIVisualEffectView()
    let blur1 = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur4 = UIVisualEffectView()
    
    
    
    // Background Sound
    // var backgroundSound = AVAudioPlayer()
    
    
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
        // All White
        case 0,2,3,4,5,6:
            timerLabel.textColor = colour1
        //
        default: break
        }
        
        
        //
        // Background Image Actions
        //
        backgroundImage.isUserInteractionEnabled = true
        
        //
        let doubleTap = UITapGestureRecognizer()
        doubleTap.numberOfTapsRequired = 2
        doubleTap.addTarget(self, action: #selector(doubleTapAction))
        backgroundImage.addGestureRecognizer(doubleTap)
        
        //
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: #selector(OxygenOverloadTimer))
        backgroundImage.addGestureRecognizer(tap)
        //
        let press = UILongPressGestureRecognizer()
        press.numberOfTapsRequired = 0
        press.numberOfTouchesRequired = 1
        press.allowableMovement = self.view.frame.size.height
        press.minimumPressDuration = CFTimeInterval(1)
        press.addTarget(self, action: #selector(OxygenOverloadTimer))
        backgroundImage.addGestureRecognizer(press)
        
        // Check
        timerLabel.isUserInteractionEnabled = false
        
        
        
        // CheckMark
        checkMark.tintColor = colour4
        
    }
    
    //
    // View Did Appear
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
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
        blur1.frame = CGRect(x: 0, y: 0, width: timerLabel.frame.size.width + 40, height: timerLabel.frame.size.height)
        blur1.isUserInteractionEnabled = false
        blur1.layer.cornerRadius = 30
        blur1.layer.masksToBounds = true
        view.insertSubview(blur1, belowSubview: timerLabel)
        //
        //
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
        //
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    // Start Timer/ End Timer
    func OxygenOverloadTimer(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.ended {
            //
            if didStartTimer == false {
                timerCountUp = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountUpTimer), userInfo: nil, repeats: true)
                didStartTimer = true
            } else {
                timerCountUp.invalidate()
                
            }
        }
    }
    
    // Update Timer
    func updateCountUpTimer() {
        //
        timerValue += 1
        timerLabel.text = timeFormatted(totalSeconds: timerValue)
    }
    
    // Reset Timer
    func doubleTapAction() {
        if didStartTimer == true {
            timerCountUp.invalidate()
            timerValue = 0
            didStartTimer = false
            timerLabel.text = "00:00"
        }
    }
    
    
    //
    // Buttons -------------------------------------------------------------------------------------------
    //
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
            timerCountUp.invalidate()
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
