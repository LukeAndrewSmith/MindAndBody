//
//  MeditationTimer.swift
//  MindAndBody
//
//  Created by Luke Smith on 08.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

//
// Meditation Class -----------------------------------------------------------------------------------------------
//
class MeditationTimer: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
//
// Arrays -----------------------------------------------------------------------------------------------
//

    // Bells Array
    var bellsArray: [String] =
        ["bowlRing", "bowlRing", "none"]
    
    // Background Sounds Array
    var backgroundSoundsArray: [String] =
        ["bowlRing", "none"]
    
    // Duration Array
    var durationTimeArray: [[Int]] =
        [
            [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
            [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 58, 59],
            [00, 10, 20, 30, 40, 50]
        ]
    
    // Custom Arrays
    //
    // Presets Arrays
    var presetsArray: [String] = []
    // Duration Array
    var durationArray: [Int] = []
    // Selected Starting Bell
    var startingBellsArray: [Int] = []
    // Interval Bells
    var intervalBellsArray: [[Int]] = []
    // Interval Bells Times
    var intervalBellsTimesArray: [[Int]] = []
    //
    var endingBellsArray: [Int] = []
    // Background Sound Array
    var selectedBackgroundSoundsArray: [Int] = []
    
    
    // Selected Preset
    var selectedPreset = Int()
    
    // Indicates Which row has been selected
    var selectedItem = Int()
    
    //
    var selectedStartingBell = Int()
    var didChangeStartingBell = Bool()
    
    //
    var selectedEndingBell = Int()
    var didChangeEndingBell = Bool()
    
    //
    var selectedBackgroundSound = Int()
    var didChangeBackgroundSound = Bool()
//
// Outlets -----------------------------------------------------------------------------------------------
//
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Background Image
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //
    @IBOutlet weak var presets: UIButton!
    @IBOutlet weak var presetsDetail: UILabel!
    
    //
    @IBOutlet weak var duration: UIButton!
    @IBOutlet weak var durationDetail: UILabel!
    //
    @IBOutlet weak var startingBell: UIButton!
    @IBOutlet weak var startingBellDetail: UILabel!
    //
    @IBOutlet weak var intervalBells: UIButton!
    @IBOutlet weak var intervalBellsDetail: UILabel!
    //
    @IBOutlet weak var endingBell: UIButton!
    @IBOutlet weak var endingBellDetail: UILabel!
    //
    @IBOutlet weak var backgroundSound: UIButton!
    @IBOutlet weak var backgroundSoundDetail: UILabel!
    
    var selectedButton = Int()
    
    // Begin
    @IBOutlet weak var beginButton: UIButton!
    
    //
    let backgroundBlur = UIVisualEffectView()
    
    //
    let presetBlur = UIVisualEffectView()
    
    // 
    let blur = UIVisualEffectView()
    let blur1 = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur3 = UIVisualEffectView()
    let blur4 = UIVisualEffectView()
    
    //
    let seperatorLine = UIVisualEffectView()
    
    //
    let beginBlur = UIVisualEffectView()
    
    // Contraints
    //
    // Preset Button Top
    @IBOutlet weak var presetButtonTop: NSLayoutConstraint!
    //
    @IBOutlet weak var midConstraint1: NSLayoutConstraint!
    //
    @IBOutlet weak var midConstraint2: NSLayoutConstraint!
    
    // Begin Button Constraint
    @IBOutlet weak var beginButtonBottom: NSLayoutConstraint!
    
    
    // Selection Items
    //
    let selectionView = UIView()
    let okButton = UIButton()
    let backgroundViewSelection = UIButton()
    //
    // Presets
    let presetsTableView = UITableView()
    // Duration
    let pickerViewDuration = UIPickerView()
        let hoursLabel = UILabel()
        let minutesLabel = UILabel()
        let secondsLabel = UILabel()
    // Bells
    let tableViewBells = UITableView()
    // Interval Bells
    let tableViewIntervalBells = UITableView()
    let pickerViewIntervalTimes = UIPickerView()
    // Background Sounds
    let tableViewBackgroundSounds = UITableView()
    
    // Sound
    var soundPlayer: AVAudioPlayer!

    
//
// View will appear -----------------------------------------------------------------------------------------------
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Initial Positions and States
        //
        presetButtonTop.constant = ((view.bounds.height - (navigationController?.navigationBar.frame.height)! - UIApplication.shared.statusBarFrame.height) / 2) - 22
        //
        beginButtonBottom.constant = -445
        //
        seperatorLine.alpha = 0
        //
        
        
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
            backgroundImage.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        }
    }
    
    
//
// View did load -----------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Defaults
        let defaults = UserDefaults.standard
        defaults.register(defaults: ["meditationTimerTitles" : presetsArray])
        defaults.register(defaults: ["meditationTimerDuration" : durationArray])
        defaults.register(defaults: ["meditationTimerStartingBells" : startingBellsArray])
        defaults.register(defaults: ["meditationTimerIntervalBells" : intervalBellsArray])
        defaults.register(defaults: ["meditationTimerIntervalTimes" : intervalBellsTimesArray])
        defaults.register(defaults: ["meditationTimerEndingBells" : endingBellsArray])
        defaults.register(defaults: ["meditationTimerBackgroundSounds" : selectedBackgroundSoundsArray])
        
        
        // Navigation Bar
        //
        // Title
        navigationBar.title = NSLocalizedString("meditationTimer", comment: "")
        // Appearance
        self.navigationController?.navigationBar.tintColor = colour1
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colour1, NSFontAttributeName: UIFont(name: "SFUIDisplay-heavy", size: 23)!]
        self.navigationController?.navigationBar.barTintColor = colour2
        
        // BackgroundBlur/Vibrancy
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        let vibrancyE = UIVibrancyEffect(blurEffect: backgroundBlurE)
        backgroundBlur.effect = vibrancyE
        backgroundBlur.isUserInteractionEnabled = false
        //
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
            if backgroundIndex > backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
        }
        
        //
        presets.setTitle(NSLocalizedString("meditation", comment: ""), for: .normal)
        presets.layer.cornerRadius = 22
        presets.layer.masksToBounds = true
        presets.contentHorizontalAlignment = .left
        presets.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        //
        let presetBlurE = UIBlurEffect(style: .dark)
        presetBlur.effect = presetBlurE
        presetBlur.isUserInteractionEnabled = false
        presetBlur.layer.cornerRadius = 22
        presetBlur.layer.masksToBounds = true
        view.insertSubview(presetBlur, belowSubview: presets)
        
        
        // Buttons
        //
        // Duration
        duration.setTitle(NSLocalizedString("duration", comment: ""), for: .normal)
        duration.contentHorizontalAlignment = .left
        duration.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        duration.layer.cornerRadius = 22
        duration.layer.masksToBounds = true
        
        // Starting Bell
        startingBell.setTitle(NSLocalizedString("startingBell", comment: ""), for: .normal)
        startingBell.contentHorizontalAlignment = .left
        startingBell.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        startingBell.layer.cornerRadius = 22
        startingBell.layer.masksToBounds = true
        //
        selectedStartingBell = -1
        didChangeStartingBell = false
        
        // Interval Bells
        intervalBells.setTitle(NSLocalizedString("intervalBells", comment: ""), for: .normal)
        intervalBells.contentHorizontalAlignment = .left
        intervalBells.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        intervalBells.layer.cornerRadius = 22
        intervalBells.layer.masksToBounds = true
        
        // Ending Bell
        endingBell.setTitle(NSLocalizedString("endingBell", comment: ""), for: .normal)
        endingBell.contentHorizontalAlignment = .left
        endingBell.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        endingBell.layer.cornerRadius = 22
        endingBell.layer.masksToBounds = true
        
        // Background Sound
        backgroundSound.setTitle(NSLocalizedString("backgroundSound", comment: ""), for: .normal)
        backgroundSound.contentHorizontalAlignment = .left
        backgroundSound.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        backgroundSound.layer.cornerRadius = 22
        backgroundSound.layer.masksToBounds = true
        
        
        //
        let blurE = UIBlurEffect(style: .regular)
        blur.effect = blurE
        blur.isUserInteractionEnabled = false
        blur.layer.cornerRadius = 22
        blur.layer.masksToBounds = true
        view.insertSubview(blur, belowSubview: startingBell)
        //
        let blur1E = UIBlurEffect(style: .regular)
        blur1.effect = blur1E
        blur1.isUserInteractionEnabled = false
        blur1.layer.cornerRadius = 22
        blur1.layer.masksToBounds = true
        view.insertSubview(blur1, belowSubview: duration)
        //
        let blur2E = UIBlurEffect(style: .regular)
        blur2.effect = blur2E
        blur2.isUserInteractionEnabled = false
        blur2.layer.cornerRadius = 22
        blur2.layer.masksToBounds = true
        view.insertSubview(blur2, belowSubview: backgroundSound)
        //
        let blur3E = UIBlurEffect(style: .regular)
        blur3.effect = blur3E
        blur3.isUserInteractionEnabled = false
        blur3.layer.cornerRadius = 22
        blur3.layer.masksToBounds = true
        view.insertSubview(blur3, belowSubview: intervalBells)
        //
        let blur4E = UIBlurEffect(style: .regular)
        blur4.effect = blur4E
        blur4.isUserInteractionEnabled = false
        blur4.layer.cornerRadius = 22
        blur4.layer.masksToBounds = true
        view.insertSubview(blur4, belowSubview: endingBell)
        

        // Begin Blur
        let beginBlurE = UIBlurEffect(style: .extraLight)
        beginBlur.effect = beginBlurE
        beginBlur.isUserInteractionEnabled = false
        view.insertSubview(beginBlur, belowSubview: beginButton)
        //
        beginButton.setTitle(NSLocalizedString("begin", comment: ""), for: .normal)
        
        // Iphone 5/SE layout
        if UIScreen.main.nativeBounds.height < 1334 {
            //
            midConstraint1.constant = 44
            midConstraint2.constant = 44
            //
        }
    
        switch backgroundIndex {
        case 3, backgroundImageArray.count:
            startingBell.setTitleColor(colour2, for: .normal)
            duration.setTitleColor(colour2, for: .normal)
            backgroundSound.setTitleColor(colour2, for: .normal)
            intervalBells.setTitleColor(colour2, for: .normal)
            endingBell.setTitleColor(colour2, for: .normal)
        default: break
        }
        
        // Selection Items
        selectionView.backgroundColor = colour2
        selectionView.layer.cornerRadius = 5
        selectionView.layer.masksToBounds = true
        
        
        // Presets TableView
        //
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = colour2
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        presetsTableView.tableFooterView = UIView()
        // TableView Cell action items
        //
        presetsTableView.backgroundColor = colour2
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        presetsTableView.layer.cornerRadius = 5
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        // Duration Picker
        pickerViewDuration.backgroundColor = colour2
        pickerViewDuration.delegate = self
        pickerViewDuration.dataSource = self
        
        
        // Bells Table
        let tableViewBackground3 = UIView()
        //
        tableViewBackground3.backgroundColor = colour2
        tableViewBackground3.frame = CGRect(x: 0, y: 0, width: self.tableViewBells.frame.size.width, height: self.tableViewBells.frame.size.height)
        //
        tableViewBells.backgroundView = tableViewBackground3
        tableViewBells.tableFooterView = UIView()
        // TableView Cell action items
        //
        tableViewBells.backgroundColor = colour2
        tableViewBells.delegate = self
        tableViewBells.dataSource = self
        tableViewBells.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewBells.layer.cornerRadius = 5
        tableViewBells.layer.masksToBounds = true
        tableViewBells.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        
        // Interval Bells Table
        let tableViewBackground4 = UIView()
        //
        tableViewBackground4.backgroundColor = colour2
        tableViewBackground4.frame = CGRect(x: 0, y: 0, width: self.tableViewIntervalBells.frame.size.width, height: self.tableViewIntervalBells.frame.size.height)
        //
        tableViewIntervalBells.backgroundView = tableViewBackground4
        tableViewIntervalBells.tableFooterView = UIView()
        // TableView Cell action items
        //
        tableViewIntervalBells.backgroundColor = colour2
        tableViewIntervalBells.delegate = self
        tableViewIntervalBells.dataSource = self
        tableViewIntervalBells.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewIntervalBells.layer.cornerRadius = 5
        tableViewIntervalBells.layer.masksToBounds = true
        tableViewIntervalBells.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        // Background Sounds Table View
        let tableViewBackground5 = UIView()
        //
        tableViewBackground5.backgroundColor = colour2
        tableViewBackground5.frame = CGRect(x: 0, y: 0, width: self.tableViewBackgroundSounds.frame.size.width, height: self.tableViewBackgroundSounds.frame.size.height)
        //
        tableViewBackgroundSounds.backgroundView = tableViewBackground5
        tableViewBackgroundSounds.tableFooterView = UIView()
        // TableView Cell action items
        //
        tableViewBackgroundSounds.backgroundColor = colour2
        tableViewBackgroundSounds.delegate = self
        tableViewBackgroundSounds.dataSource = self
        tableViewBackgroundSounds.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewBackgroundSounds.layer.cornerRadius = 5
        tableViewBackgroundSounds.layer.masksToBounds = true
        tableViewBackgroundSounds.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        
        // Interval Times Picker
        pickerViewIntervalTimes.backgroundColor = colour2
        pickerViewIntervalTimes.delegate = self
        pickerViewIntervalTimes.dataSource = self
        // Labels
        //
        hoursLabel.textAlignment = .center
        hoursLabel.textColor = colour1
        hoursLabel.text = "h"
        hoursLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        hoursLabel.numberOfLines = 1
        hoursLabel.sizeToFit()
        hoursLabel.center.y = pickerViewDuration.center.y
        hoursLabel.center.x = pickerViewDuration.frame.minX + (pickerViewDuration.frame.size.width * (2.4/6))
        pickerViewDuration.addSubview(hoursLabel)
        //
        minutesLabel.textAlignment = .center
        minutesLabel.textColor = colour1
        minutesLabel.text = "m"
        minutesLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        minutesLabel.numberOfLines = 1
        minutesLabel.sizeToFit()
        minutesLabel.center.y = pickerViewDuration.center.y
        minutesLabel.center.x = pickerViewDuration.frame.minX + (pickerViewDuration.frame.size.width * (3.55/6))
        pickerViewDuration.addSubview(minutesLabel)
        //
        secondsLabel.textAlignment = .center
        secondsLabel.textColor = colour1
        secondsLabel.text = "s"
        secondsLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        secondsLabel.numberOfLines = 1
        secondsLabel.sizeToFit()
        secondsLabel.center.y = pickerViewDuration.center.y
        secondsLabel.center.x = pickerViewDuration.frame.minX + (pickerViewDuration.frame.size.width * (4.65/6))
        pickerViewDuration.addSubview(secondsLabel)
       
    }
 
    
//
// View Did Dissapear  ---------------------------------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        backgroundImage.frame = view.bounds
        backgroundBlur.frame = backgroundImage.bounds
        
        //
        presetBlur.frame = presets.frame
        presetBlur.center = presets.center
        
        //
        blur.frame = startingBell.bounds
        blur.center = startingBell.center
        //
        blur1.frame = duration.bounds
        blur1.center = duration.center
        //
        blur2.frame = backgroundSound.bounds
        blur2.center = backgroundSound.center
        //
        blur3.frame = intervalBells.bounds
        blur3.center = intervalBells.center
        //
        blur4.frame = endingBell.bounds
        blur4.center = endingBell.center
        
        //
        beginBlur.frame = beginButton.bounds
        beginBlur.center = beginButton.center
        
        // Seperator
        let height = duration.frame.minY - presets.frame.maxY
        let seperatorEffect = UIBlurEffect(style: .regular)
        seperatorLine.effect = seperatorEffect
        seperatorLine.isUserInteractionEnabled = false
        seperatorLine.frame = CGRect(x: 11, y: presets.frame.maxY + (height / 2), width: view.frame.size.width - 22, height: 1)
        seperatorLine.layer.cornerRadius = 0.5
        seperatorLine.layer.masksToBounds = true
        view.insertSubview(seperatorLine, aboveSubview: backgroundBlur)
        
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
        switch backgroundIndex {
        case 3, backgroundImageArray.count:
            seperatorLine.effect = UIBlurEffect(style: .dark)
        default: break
        }
        
        //
        // Selection Elements
        // view
        selectionView.backgroundColor = colour2
        selectionView.layer.cornerRadius = 5
        selectionView.layer.masksToBounds = true
        // ok
        okButton.backgroundColor = colour1
        okButton.setTitleColor(colour2, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        //
        selectionView.addSubview(okButton)
        //
        // Background View
        backgroundViewSelection.backgroundColor = .black
        backgroundViewSelection.addTarget(self, action: #selector(backgroundViewSelectionAction(_:)), for: .touchUpInside)
        //
    }
 
    
//
// Selection Related actions ------------------------------------------------------------------------------------------------
//
    // Add movement table background (dismiss table)
    func backgroundViewSelectionAction(_ sender: Any) {
        //
        if (UIApplication.shared.keyWindow?.subviews.contains(self.presetsTableView))! {
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.presetsTableView.frame = CGRect(x: 30, y: self.presets.frame.minY + UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
                self.presetsTableView.alpha = 0
                self.backgroundViewSelection.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewSelection.removeFromSuperview()
            })
        //
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                //
                self.selectionView.alpha = 0
                self.backgroundViewSelection.alpha = 0
            //
            }, completion: { finished in
                for i in self.selectionView.subviews {
                    i.removeFromSuperview()
                }
                //
                self.selectionView.removeFromSuperview()
                self.backgroundViewSelection.removeFromSuperview()
            })
            
        // Extra
            switch selectedItem {
            case 0: break // OK button not used
            case 1:
                break
            case 2:
                //
                if soundPlayer != nil {
                    if soundPlayer.isPlaying {
                        soundPlayer.stop()
                    }
                }
            case 3:
                break
            case 4:
                //
                if soundPlayer != nil {
                    if soundPlayer.isPlaying {
                        soundPlayer.stop()
                    }
                }
            case 5:
                //
                if soundPlayer != nil {
                    if soundPlayer.isPlaying {
                        soundPlayer.stop()
                    }
                }
            default: break
            }
        }
    }
    
    // Ok button action
    func okButtonAction(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        //
        
        switch selectedItem {
        case 0: break // OK button not used
        case 1:
            var durationArray = UserDefaults.standard.object(forKey: "meditationTimerDuration") as! [Int]
            //
            durationArray[selectedPreset] = convertToSeconds()
            UserDefaults.standard.set(durationArray, forKey: "meditationTimerDuration")
            //
            UserDefaults.standard.synchronize()

            //
            let hmsArray = convertToHMS()
            durationDetail.text = String(hmsArray[0]) + "h " + String(hmsArray[1]) + "m " + String(hmsArray[2]) + "s"
            
        case 2:
            //
            if soundPlayer != nil {
                if soundPlayer.isPlaying == true {
                    soundPlayer.stop()
                }
            }
            //
            var startingBellsArray = UserDefaults.standard.object(forKey: "meditationTimerStartingBells") as! [Int]
            //
            startingBellsArray[selectedPreset] = selectedStartingBell
            startingBellDetail.text = NSLocalizedString(bellsArray[startingBellsArray[selectedPreset]], comment: "")
            //
            UserDefaults.standard.set(startingBellsArray, forKey: "meditationTimerStartingBells")
            //
            selectedStartingBell = -1
        case 3:
            break
        case 4:
            //
            if soundPlayer != nil {
                if soundPlayer.isPlaying == true {
                    soundPlayer.stop()
                }
            }
            //
            var endingBellsArray = UserDefaults.standard.object(forKey: "meditationTimerEndingBells") as! [Int]
            endingBellsArray[selectedPreset] = selectedEndingBell
            endingBellDetail.text = NSLocalizedString(bellsArray[endingBellsArray[selectedPreset]], comment: "")
            //
            UserDefaults.standard.set(endingBellsArray, forKey: "meditationTimerEndingBells")
            //
            selectedEndingBell = -1
        case 5:
            //
            if soundPlayer != nil {
                if soundPlayer.isPlaying == true {
                    soundPlayer.stop()
                }
            }
            //
            var selectedBackgroundSoundsArray = UserDefaults.standard.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
            selectedBackgroundSoundsArray[selectedPreset] = selectedBackgroundSound
            backgroundSoundDetail.text = NSLocalizedString(backgroundSoundsArray[selectedBackgroundSoundsArray[selectedPreset]], comment: "")
            //
            UserDefaults.standard.set(selectedBackgroundSoundsArray, forKey: "meditationTimerBackgroundSounds")
            //
            selectedBackgroundSound = -1
        default: break
        }
        
        //
        defaults.synchronize()
        //
        UIView.animate(withDuration: 0.4, animations: {
            //
            self.selectionView.alpha = 0
            self.backgroundViewSelection.alpha = 0
        //
        }, completion: { finished in
            for i in self.selectionView.subviews {
                i.removeFromSuperview()
            }
            //
            self.selectionView.removeFromSuperview()
            self.backgroundViewSelection.removeFromSuperview()
        })
        //
    }
    
    
//
// Elements check enabled funcs ------------------------------------------------------------------------------
//
    // Button Enabled
    func beginButtonEnabled() {
        // Begin Button
        let defaults = UserDefaults.standard
        //
//        if customTableView.isEditing {
//            beginButton.isEnabled = false
//        } else {
//            if warmupPreset.count == 0 {
//                beginButton.isEnabled = false
//            } else {
//                if warmupPreset[sessionPickerView.selectedRow(inComponent: 0)].count == 0 {
//                    beginButton.isEnabled = false
//                } else {
//                    beginButton.isEnabled = true
//                }
//            }
//        }
    }
 
    
//
// Button Actions ----------------------------------------------------------------------------------------------------
//
    
    // Prests
    @IBAction func presetsAction(_ sender: Any) {
        selectedItem = 0
        //
        presetsTableView.alpha = 0
        presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + (presets.frame.size.height / 2), width: presets.frame.size.width - 60, height: 0)
        //presetsTableView.frame = preset.bounds
        presetsTableView.center.x = presets.center.x
        presetsTableView.center.y = presets.center.y + UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!
        //
        backgroundViewSelection.alpha = 0
        backgroundViewSelection.frame = UIScreen.main.bounds
        // Present
        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: presetsTableView)
        // Animate table fade and size
        // Position
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.presetsTableView.alpha = 1
            self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88)
            self.presetsTableView.reloadData()
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
        //
    }

    // Duration
    @IBAction func durationAction(_ sender: Any) {
        selectedItem = 1
        // View
        selectionView.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        selectionView.frame = CGRect(x: 22, y: duration.frame.minY, width: UIScreen.main.bounds.width - 44, height: duration.frame.size.height)
        //
        // PickerView
        selectionView.addSubview(pickerViewDuration)
        pickerViewDuration.frame = CGRect(x: 0, y: 0, width: selectionView.frame.size.width, height: selectionView.frame.size.height - 49)
        // Select Rows
        let hmsArray = convertToHMS()
        pickerViewDuration.selectRow(durationTimeArray[0].index(of: hmsArray[0])!, inComponent: 0, animated: true)
        pickerViewDuration.selectRow(durationTimeArray[1].index(of: hmsArray[1])!, inComponent: 1, animated: true)
        pickerViewDuration.selectRow(durationTimeArray[2].index(of: hmsArray[2])!, inComponent: 2, animated: true)
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: selectionView.frame.size.width, height: 49)
        selectionView.addSubview(okButton)
        //
        backgroundViewSelection.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: selectionView)
        backgroundViewSelection.frame = UIScreen.main.bounds
        // Animate fade and size
        // Position
        UIView.animate(withDuration: 0.4, animations: {
            //
            self.selectionView.alpha = 1
            //
            self.selectionView.frame = CGRect(x: 22, y: 0, width: UIScreen.main.bounds.width - 44, height: 147 + 49)
            self.selectionView.center.y = self.view.center.y - ((UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!) / 2)
            //
            self.pickerViewDuration.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height - 49)
                self.hoursLabel.center.y = self.pickerViewDuration.center.y
                self.minutesLabel.center.y = self.pickerViewDuration.center.y
                self.secondsLabel.center.y = self.pickerViewDuration.center.y
            // ok
            self.okButton.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
    }

    // Starting Bell
    @IBAction func startingBellAction(_ sender: Any) {
        selectedItem = 2
        //
        selectedStartingBell = -1
        didChangeStartingBell = false
        tableViewBells.reloadData()
        // View
        selectionView.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        selectionView.frame = CGRect(x: 22, y: startingBell.frame.minY, width: UIScreen.main.bounds.width - 44, height: startingBell.frame.size.height)
        // Tableview
        selectionView.addSubview(tableViewBells)
        tableViewBells.frame = CGRect(x: 0, y: 0, width: selectionView.frame.size.width, height: selectionView.frame.size.height - 49)
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: selectionView.frame.size.width, height: 49)
        selectionView.addSubview(okButton)
        if selectedStartingBell != -1 {
            okButton.isEnabled = true
        }
        //
        backgroundViewSelection.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: selectionView)
        backgroundViewSelection.frame = UIScreen.main.bounds
        // Animate fade and size
        // Position
        UIView.animate(withDuration: 0.4, animations: {
            //
            let height = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            //
            self.selectionView.alpha = 1
            //
            self.selectionView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: height)
            // ok
            self.tableViewBells.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: height - 49)
            // ok
            self.okButton.frame = CGRect(x: 0, y: height - 49, width: self.selectionView.frame.size.width, height: 49)
            //
            self.backgroundViewSelection.alpha = 0.5
            
            //
            self.selectionView.alpha = 1
            //
            //
            
            //
        }, completion: nil)
    }

    // Interval Bells
    @IBAction func intervalBellsAction(_ sender: Any) {
        selectedItem = 3
        //
        selectionView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + (presets.frame.size.height / 2), width: presets.frame.size.width - 60, height: 0)
        //
        tableViewIntervalBells.alpha = 0
        self.tableViewIntervalBells.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height - 49)
        selectionView.addSubview(tableViewIntervalBells)
        //
        backgroundViewSelection.alpha = 0
        backgroundViewSelection.frame = UIScreen.main.bounds
        selectionView.addSubview(backgroundViewSelection)
        //
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: selectionView.frame.size.width, height: 49)
        selectionView.addSubview(okButton)
        // Present
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: selectionView)
        // Animate table fade and size
        // Position
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tableViewIntervalBells.alpha = 1
            //
            self.selectionView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88)
            self.tableViewIntervalBells.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height - 49)
            self.okButton.frame = CGRect(x: 0, y: self.selectionView.frame.size.height - 49, width: self.selectionView.frame.size.width, height: 49)

            self.tableViewIntervalBells.reloadData()
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
        //
    }

    // Ending Bell
    @IBAction func endingBellAction(_ sender: Any) {
        selectedItem = 4
        //
        selectedEndingBell = -1
        didChangeEndingBell = false
        tableViewBells.reloadData()
        // View
        selectionView.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        selectionView.frame = CGRect(x: 22, y: endingBell.frame.minY, width: UIScreen.main.bounds.width - 44, height: endingBell.frame.size.height)
        // Tableview
        selectionView.addSubview(tableViewBells)
        tableViewBells.frame = CGRect(x: 0, y: 0, width: selectionView.frame.size.width, height: selectionView.frame.size.height - 49)
        
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: selectionView.frame.size.width, height: 49)
        selectionView.addSubview(okButton)
        if selectedEndingBell != -1 {
            okButton.isEnabled = true
        }
        //
        backgroundViewSelection.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: selectionView)
        backgroundViewSelection.frame = UIScreen.main.bounds
        // Animate fade and size
        // Position
        UIView.animate(withDuration: 0.4, animations: {
            //
            let height = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            //
            self.selectionView.alpha = 1
            //
            self.selectionView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: height)
            // ok
            self.tableViewBells.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: height - 49)
            // ok
            self.okButton.frame = CGRect(x: 0, y: height - 49, width: self.selectionView.frame.size.width, height: 49)
            //
            self.backgroundViewSelection.alpha = 0.5
            
            //
            self.selectionView.alpha = 1
            //
            //
            
            //
        }, completion: nil)
    }

    // Background Sound
    @IBAction func backgroundSoundAction(_ sender: Any) {
        selectedItem = 5
        //
        selectedBackgroundSound = -1
        didChangeBackgroundSound = false
        tableViewBackgroundSounds.reloadData()
        // View
        selectionView.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        selectionView.frame = CGRect(x: 22, y: startingBell.frame.minY, width: UIScreen.main.bounds.width - 44, height: startingBell.frame.size.height)
        // Tableview
        selectionView.addSubview(tableViewBackgroundSounds)
        tableViewBackgroundSounds.frame = CGRect(x: 0, y: 0, width: selectionView.frame.size.width, height: selectionView.frame.size.height - 49)
        
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: selectionView.frame.size.width, height: 49)
        selectionView.addSubview(okButton)
        if selectedBackgroundSound != -1 {
            okButton.isEnabled = true
        }
        //
        backgroundViewSelection.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: selectionView)
        backgroundViewSelection.frame = UIScreen.main.bounds
        // Animate fade and size
        // Position
        UIView.animate(withDuration: 0.4, animations: {
            //
            let height = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            //
            self.selectionView.alpha = 1
            //
            self.selectionView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: height)
            // ok
            self.tableViewBackgroundSounds.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: height - 49)
            // ok
            self.okButton.frame = CGRect(x: 0, y: height - 49, width: self.selectionView.frame.size.width, height: 49)
            //
            self.backgroundViewSelection.alpha = 0.5
            
            //
            self.selectionView.alpha = 1
            //
            //
            
            //
        }, completion: nil)
    }

    
    
    
    
    
//
// TableView -----------------------------------------------------------------------------------------------------------------------
//
  
    // Update Main Screen Detail Labels
    func updateRows() {
        // Register Defaults
        let defaults = UserDefaults.standard
        let durationArray = defaults.object(forKey: "meditationTimerDuration") as! [Int]
        let startingBellsArray = defaults.object(forKey: "meditationTimerStartingBells") as! [Int]
        let intervalBellsArray = defaults.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
        let endingBellsArray = defaults.object(forKey: "meditationTimerEndingBells") as! [Int]
        let selectedBackgroundSoundsArray = defaults.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
        //
        if durationArray[selectedPreset] != 0 {
            let hmsArray = convertToHMS()
            durationDetail.text = String(hmsArray[0]) + "h " + String(hmsArray[1]) + "m " + String(hmsArray[2]) + "s"
        } else {
            durationDetail.text = "-"
        }
        //
        if startingBellsArray[selectedPreset] != -1 {
            startingBellDetail.text = NSLocalizedString(bellsArray[startingBellsArray[selectedPreset]], comment: "")
        } else {
            startingBellDetail.text = "-"
        }
        //
        if intervalBellsArray[selectedPreset].count != 0 {
            intervalBellsDetail.text = String(intervalBellsArray[selectedPreset].count)
        } else {
            intervalBellsDetail.text = "-"
        }
        //
        if endingBellsArray[selectedPreset] != -1 {
            endingBellDetail.text = NSLocalizedString(bellsArray[endingBellsArray[selectedPreset]], comment: "")
        } else {
            endingBellDetail.text = "-"
        }
        //
        if selectedBackgroundSoundsArray[selectedPreset] != -1 {
            backgroundSoundDetail.text = NSLocalizedString(backgroundSoundsArray[selectedBackgroundSoundsArray[selectedPreset]], comment: "")
        } else {
            backgroundSoundDetail.text = "-"
        }
    }
    
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case presetsTableView: return 1
        case tableViewBells: return 1
        case tableViewIntervalBells: return 1
        case tableViewBackgroundSounds: return 1
        default: return 0
        }
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case presetsTableView:
            return " " + NSLocalizedString("custom", comment: "")
        case tableViewBells: return ""
        case tableViewIntervalBells: return " " + NSLocalizedString("intervalBells", comment: "")
        case tableViewBackgroundSounds: return " "
        default: return ""
    }
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 18)!
        header.textLabel?.textColor = colour1
        header.contentView.backgroundColor = colour2
        header.contentView.tintColor = colour1
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case presetsTableView:
            // Retreive Preset Timers
            let presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
            return presetsArray.count + 1
        case tableViewBells:
            return bellsArray.count
        case tableViewIntervalBells:
            // Retreive Interval Bells
            let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            return intervalBellsArray[selectedPreset].count + 1
        case tableViewBackgroundSounds:
            return backgroundSoundsArray.count
        default: return 0
        }
        
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        //
        // Cell Content
        switch tableView {
        case presetsTableView:
            // Retreive Preset Timers
            let presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
            //
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = colour1
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            if indexPath.row == presetsArray.count {
                //
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
            //
            } else {
                //
                cell.textLabel?.text = presetsArray[indexPath.row]
            }
            //
        case tableViewBells:
            if selectedItem == 2 {
                //
                let startingBellsArray = UserDefaults.standard.object(forKey: "meditationTimerStartingBells") as! [Int]
                if didChangeStartingBell == false {
                    if startingBellsArray[selectedPreset] != -1 {
                        selectedStartingBell = startingBellsArray[selectedPreset]
                    }
                }
                //
                if indexPath.row == selectedStartingBell {
                    cell.layer.borderColor = colour1.cgColor
                    cell.layer.borderWidth = 1
                }
                //
                if selectedStartingBell != -1 {
                    okButton.isEnabled = true
                }
            } else if selectedItem == 4 {
                //
                let endingBellsArray = UserDefaults.standard.object(forKey: "meditationTimerEndingBells") as! [Int]
                if didChangeEndingBell == false {
                    if endingBellsArray[selectedPreset] != -1 {
                        selectedEndingBell = endingBellsArray[selectedPreset]
                    }
                }
                //
                if indexPath.row == selectedEndingBell {
                    cell.layer.borderColor = colour1.cgColor
                    cell.layer.borderWidth = 1
                }
                //
                if selectedEndingBell != -1 {
                    okButton.isEnabled = true
                }
            }
            //
            cell.textLabel?.text = NSLocalizedString(bellsArray[indexPath.row], comment: "")
            //
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = colour2
            cell.textLabel?.textColor = colour1
            cell.tintColor = colour1
        //
        case tableViewIntervalBells:
            let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            //
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = colour2
            cell.textLabel?.textColor = colour1
            cell.tintColor = colour1
            // New Bell Row
            if indexPath.row == intervalBellsArray[selectedPreset].count {
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
            // Bells Rows
            } else {
                cell.textLabel?.text = bellsArray[intervalBellsArray[selectedPreset][indexPath.row]]
            }
        //
        case tableViewBackgroundSounds:
            //
            let selectedBackgroundSoundsArray = UserDefaults.standard.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
            if didChangeBackgroundSound == false {
                if selectedBackgroundSoundsArray[selectedPreset] != -1 {
                    selectedBackgroundSound = selectedBackgroundSoundsArray[selectedPreset]
                }
            }
            //
            if indexPath.row == selectedBackgroundSound {
                cell.layer.borderColor = colour1.cgColor
                cell.layer.borderWidth = 1
            }
            //
            if selectedBackgroundSound != -1 {
                okButton.isEnabled = true
            }
        //
        cell.textLabel?.text = NSLocalizedString(backgroundSoundsArray[indexPath.row], comment: "")
        //
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = colour2
        cell.textLabel?.textColor = colour1
        cell.tintColor = colour1
            
        default: break
        }
        return cell
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    //
    var okAction = UIAlertAction()
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case presetsTableView:
            // Retreive Preset Timers
            var presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
            // Add Custom Meditation
            if indexPath.row == presetsArray.count {
                let snapShot1 = presetsTableView.snapshotView(afterScreenUpdates: false)
                snapShot1?.center.x = view.center.x
                snapShot1?.center.y = presetsTableView.center.y - UIApplication.shared.statusBarFrame.height - (navigationController?.navigationBar.frame.size.height)!
                view.addSubview(snapShot1!)
                self.presetsTableView.isHidden = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundViewSelection.alpha = 0
                }, completion: { finished in
                    self.backgroundViewSelection.isHidden = true
                })
                
                //
                // Alert and Functions
                //
                //
                let inputTitle = NSLocalizedString("meditationInputTitle", comment: "")
                //
                let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
                alert.view.tintColor = colour2
                alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
                //2. Add the text field
                alert.addTextField { (textField: UITextField) in
                    textField.text = " "
                    textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
                    textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
                }
                // 3. Get the value from the text field, and perform actions upon OK press
                okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    let defaults = UserDefaults.standard
                    //
                    let textField = alert?.textFields![0]
                    // Update Preset Text Arrays
                    presetsArray.append((textField?.text)!)
                    defaults.set(presetsArray, forKey: "meditationTimerTitles")
                    
                    //
                    var durationArray = defaults.object(forKey: "meditationTimerDuration") as! [Int]
                    var startingBellsArray = defaults.object(forKey: "meditationTimerStartingBells") as! [Int]
                    var intervalBellsArray = defaults.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
                    var intervalBellsTimesArray = defaults.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
                    var endingBellsArray = defaults.object(forKey: "meditationTimerEndingBells") as! [Int]
                    var selectedBackgroundSoundsArray = defaults.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
                    //
                    durationArray.append(0)
                    defaults.set(durationArray, forKey: "meditationTimerDuration")
                    //
                    startingBellsArray.append(-1)
                    defaults.set(startingBellsArray, forKey: "meditationTimerStartingBells")
                    //
                    intervalBellsArray.append([])
                    defaults.set(intervalBellsArray, forKey: "meditationTimerIntervalBells")
                    //
                    intervalBellsTimesArray.append([])
                    defaults.set(intervalBellsTimesArray, forKey: "meditationTimerIntervalTimes")
                    //
                    endingBellsArray.append(-1)
                    defaults.set(endingBellsArray, forKey: "meditationTimerEndingBells")
                    //
                    selectedBackgroundSoundsArray.append(-1)
                    defaults.set(selectedBackgroundSoundsArray, forKey: "meditationTimerBackgroundSounds")

                    
                    //
                    UserDefaults.standard.synchronize()
                    //
                    //
                    self.backgroundViewSelection.isHidden = false
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backgroundViewSelection.alpha = 0.5
                        self.presetsTableView.reloadData()
                    })
                    //
                    self.presetsTableView.isHidden = false
                    snapShot1?.removeFromSuperview()
                    //
                })
                okAction.isEnabled = false
                alert.addAction(okAction)
                // Cancel reset action
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    //
                    self.backgroundViewSelection.isHidden = false
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backgroundViewSelection.alpha = 0.5
                    })
                    //
                    self.presetsTableView.isHidden = false
                    snapShot1?.removeFromSuperview()
                }
                alert.addAction(cancelAction)
                // 4. Present the alert.
                self.present(alert, animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: true)
                //
            // Select Custom Meditation
            } else {
                //
                selectedPreset = indexPath.row
                //
                let presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
                //
                presetsDetail.text = presetsArray[selectedPreset]
                //
                tableView.deselectRow(at: indexPath, animated: true)
                // Dismiss Table
                UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.presetsTableView.frame = CGRect(x: 30, y: 44 + UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
                    self.presetsTableView.alpha = 0
                    self.backgroundViewSelection.alpha = 0
                    //
                    self.beginButtonBottom.constant = 0
                    self.presetButtonTop.constant = 44
                    self.seperatorLine.alpha = 1
                    self.view.layoutIfNeeded()
                }, completion: { finished in
                    //
                    self.presetsTableView.removeFromSuperview()
                    self.backgroundViewSelection.removeFromSuperview()
                })
                //
                updateRows()
            }
        //
        case tableViewBells:
            //
            
            if indexPath.row == bellsArray.count - 1 {
                if soundPlayer != nil {
                    if soundPlayer.isPlaying == true {
                        soundPlayer.stop()
                    }
                }
            } else {
            let bell = NSDataAsset(name: bellsArray[indexPath.row])
            
            do {
                let bell = try AVAudioPlayer(data: (bell?.data)!)
                soundPlayer = bell
                bell.play()
            } catch {
                // couldn't load file :(
            }
            }
            //
            if selectedItem == 2 {
                selectedStartingBell = indexPath.row
                didChangeStartingBell = true
            } else if selectedItem == 4 {
                selectedEndingBell = indexPath.row
                didChangeEndingBell = true
            }
            //
            tableViewBells.reloadData()
            tableViewBells.deselectRow(at: indexPath, animated: true)
        case tableViewIntervalBells:
            let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]

            //
            if indexPath.row == intervalBellsArray.count {
                
                
                
            } else {
                
                
                
            }
        case tableViewBackgroundSounds:
            //
            if indexPath.row == backgroundSoundsArray.count - 1 {
                if soundPlayer != nil {
                    if soundPlayer.isPlaying == true {
                        soundPlayer.stop()
                    }
                }
            } else {
                let backgroundSound = NSDataAsset(name: backgroundSoundsArray[indexPath.row])
                
                do {
                    let backgroundSound = try AVAudioPlayer(data: (backgroundSound?.data)!)
                    soundPlayer = backgroundSound
                    backgroundSound.play()
                } catch {
                    // couldn't load file :(
                }
            }
            //
            selectedBackgroundSound = indexPath.row
            didChangeBackgroundSound = true
            //
            tableViewBackgroundSounds.reloadData()
            tableViewBackgroundSounds.deselectRow(at: indexPath, animated: true)
        default: break
        }
    }

    // Custom Meditation Action
    func textChanged(_ sender: UITextField) {
        if sender.text == "" {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    
    // Edit Rows
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Retreive Preset Timers
        let presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
        var returnValue = Bool()
        if indexPath.row < presetsArray.count {
            returnValue = true
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let defaults = UserDefaults.standard
            //
            var presetsArray = defaults.object(forKey: "meditationTimerTitles") as! [String]
            presetsArray.remove(at: indexPath.row)
            defaults.set(presetsArray, forKey: "meditationTimerTitles")
            //

            var durationArray = defaults.object(forKey: "meditationTimerDuration") as! [Int]
            var startingBellsArray = defaults.object(forKey: "meditationTimerStartingBells") as! [Int]
            var intervalBellsArray = defaults.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            var intervalBellsTimesArray = defaults.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
            var endingBellsArray = defaults.object(forKey: "meditationTimerEndingBells") as! [Int]
            var selectedBackgroundSoundsArray = defaults.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
            //
            durationArray.remove(at: indexPath.row)
            defaults.set(durationArray, forKey: "meditationTimerDuration")
            //
            startingBellsArray.remove(at: indexPath.row)
            defaults.set(startingBellsArray, forKey: "meditationTimerStartingBells")
            //
            intervalBellsArray.remove(at: indexPath.row)
            defaults.set(intervalBellsArray, forKey: "meditationTimerIntervalBells")
            //
            intervalBellsTimesArray.remove(at: indexPath.row)
            defaults.set(intervalBellsTimesArray, forKey: "meditationTimerIntervalTimes")
            //
            endingBellsArray.remove(at: indexPath.row)
            defaults.set(endingBellsArray, forKey: "meditationTimerEndingBells")
            //
            selectedBackgroundSoundsArray.remove(at: indexPath.row)
            defaults.set(selectedBackgroundSoundsArray, forKey: "meditationTimerBackgroundSounds")
            //
            defaults.synchronize()
            //
            UIView.animate(withDuration: 0.2, animations: {
                self.presetsTableView.reloadData()
            })
        }
    }
    
    
//
// Picker View ----------------------------------------------------------------------------------------------------
//
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durationTimeArray[component].count
    }
    
    // Width for component
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return selectionView.frame.size.width / 6
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        let label = UILabel()
        label.text = String(durationTimeArray[component][row])
        label.font = UIFont(name: "SFUIDisplay-light", size: 24)
        label.textColor = colour1
        //
        label.textAlignment = .center
        return label
        //
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
    
    
    // Convert to seconds func
    func convertToSeconds() -> Int {
        let hours = durationTimeArray[0][pickerViewDuration.selectedRow(inComponent: 0)]
        let minutes = durationTimeArray[1][pickerViewDuration.selectedRow(inComponent: 1)]
        let seconds = durationTimeArray[2][pickerViewDuration.selectedRow(inComponent: 2)]
        //
        let timeInSeconds = (hours * 3600) + (minutes * 60) + seconds
        return timeInSeconds
    }
    
    // Convert to hours, minutes, seconds func
    func convertToHMS() -> [Int] {
        var hmsArray: [Int] = []
        //
        let timeInSeconds = UserDefaults.standard.object(forKey: "meditationTimerDuration") as! [Int]
        //
        let hours = Int(timeInSeconds[selectedPreset] / 3600)
        hmsArray.append(hours)
        //
        let minutes = Int((timeInSeconds[selectedPreset] % 3600) / 60)
        hmsArray.append(minutes)
        //
        let seconds = Int(timeInSeconds[selectedPreset] % 60)
        hmsArray.append(seconds)
        //
        return hmsArray
    }
    
    
//
// Begin Action -----------------------------------------------------------------------------------------------
//
    @IBAction func beginButtonAction(_ sender: Any) {
        // Register Defaults
        let defaults = UserDefaults.standard
        let durationArray = defaults.object(forKey: "meditationTimerDuration") as! [Int]
        let startingBellsArray = defaults.object(forKey: "meditationTimerStartingBells") as! [Int]
        let intervalBellsArray = defaults.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
        let intervalBellsTimesArray = defaults.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
        let endingBellsArray = defaults.object(forKey: "meditationTimerEndingBells") as! [Int]
        let selectedBackgroundSoundsArray = defaults.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
        //
        if durationArray[selectedPreset] != 0 && startingBellsArray[selectedPreset] != -1 && intervalBellsArray[selectedPreset].count != 0 && intervalBellsTimesArray[selectedPreset].count != 0 && endingBellsArray[selectedPreset] != -1 && selectedBackgroundSoundsArray[selectedPreset] != -1 {
            self.performSegue(withIdentifier: "meditationTimerSegue", sender: self)
            // Pop
            let delayInSeconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                _ = self.navigationController?.popToRootViewController(animated: false)
            }
        } else {
            //
            // Alert
            let inputTitle = NSLocalizedString("meditationBegin", comment: "")
            let inputMessage = NSLocalizedString("meditationBeginMessage", comment: "")
            //
            let alert = UIAlertController(title: inputTitle, message: inputMessage, preferredStyle: .alert)
            alert.view.tintColor = colour2
            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-Light", size: 20)!]), forKey: "attributedTitle")
            alert.setValue(NSAttributedString(string: inputMessage, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-thin", size: 17)!]), forKey: "attributedMessage")
            
            //
            okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            })
            alert.addAction(okAction)
            //
            self.present(alert, animated: true, completion: nil)
            //

        }
    }
    
    
    
//
// View Did Dissapear  ---------------------------------------------------------------------------------------------------------------------
//
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        // Background index
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
    }
//
}
