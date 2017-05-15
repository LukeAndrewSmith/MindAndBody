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
    let bellsArray: [String] =
        ["bowlRing", "bowlRing"]
    let bellsImages: [UIImage] =
        [#imageLiteral(resourceName: "bowlImage"), #imageLiteral(resourceName: "bowlImage")]
    
    // Background Sounds Array
    let backgroundSoundsArray: [String] =
        ["bowlRing"]
    let backgroundSoundsImages: [UIImage] =
        [#imageLiteral(resourceName: "bowlImage")]
    
    // Duration Array
    let durationTimeArray: [[Int]] =
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
    var selectedIntervalBell = Int()
    var didChangeIntervalBell = Bool()
    var intervalBellStage = Int()
    
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
    
    //
    var deleteButton = UIButton()
    
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
    // Begin Button Constraint
    @IBOutlet weak var beginButtonBottom: NSLayoutConstraint!
    
    // Constraints
    @IBOutlet weak var presetsConstraint: NSLayoutConstraint!
    @IBOutlet weak var durationConstraint: NSLayoutConstraint!
    @IBOutlet weak var startingConstraint: NSLayoutConstraint!
    @IBOutlet weak var intervalConstraint: NSLayoutConstraint!
    @IBOutlet weak var endingConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundConstraint: NSLayoutConstraint!
    
    
    
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
        let durationTimeLabel = UILabel()
    // Bells
    let tableViewBells = UITableView()
    // Interval Bells
    let selectionView2 = UIView()
    let intervalBellTimeLabel = UILabel()
    let okButton2 = UIButton()
    let backgroundViewSelection2 = UIView()
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
        //
        presetsConstraint.constant = (view.frame.maxY / 2) - presets.frame.maxY
        //
        durationConstraint.constant = view.frame.maxY - duration.frame.maxY + 22
        startingConstraint.constant = view.frame.maxY - startingBell.frame.maxY + 44
        intervalConstraint.constant = view.frame.maxY - intervalBells.frame.maxY + 44
        endingConstraint.constant = view.frame.maxY - endingBell.frame.maxY + 55
        
        backgroundConstraint.constant = view.frame.maxY - backgroundSound.frame.maxY + 66
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
        //
        selectedIntervalBell = -1
        didChangeIntervalBell = false
        intervalBellStage = 0
        
        // Ending Bell
        endingBell.setTitle(NSLocalizedString("endingBell", comment: ""), for: .normal)
        endingBell.contentHorizontalAlignment = .left
        endingBell.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        endingBell.layer.cornerRadius = 22
        endingBell.layer.masksToBounds = true
        //
        selectedEndingBell = -1
        didChangeEndingBell = false
        
        // Background Sound
        backgroundSound.setTitle(NSLocalizedString("backgroundSound", comment: ""), for: .normal)
        backgroundSound.contentHorizontalAlignment = .left
        backgroundSound.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        backgroundSound.layer.cornerRadius = 22
        backgroundSound.layer.masksToBounds = true
        
        
        // Colours
        // Background Index
        //
        // Title Colours and Blurs
        //
        switch backgroundIndex {
        // All Black, white presets
        case 1,2,3,5,6, backgroundImageArray.count:
            presets.setTitleColor(colour1, for: .normal)
            presetsDetail.textColor = colour1
            duration.setTitleColor(colour2, for: .normal)
            durationDetail.textColor = colour2
            startingBell.setTitleColor(colour2, for: .normal)
            startingBellDetail.textColor = colour2
            intervalBells.setTitleColor(colour2, for: .normal)
            intervalBellsDetail.textColor = colour2
            endingBell.setTitleColor(colour2, for: .normal)
            endingBellDetail.textColor = colour2
            backgroundSound.setTitleColor(colour2, for: .normal)
            backgroundSoundDetail.textColor = colour2
        // All White
        case 0,3,4:
            presets.setTitleColor(colour1, for: .normal)
            presetsDetail.textColor = colour1
            duration.setTitleColor(colour1, for: .normal)
            durationDetail.textColor = colour1
            startingBell.setTitleColor(colour1, for: .normal)
            startingBellDetail.textColor = colour1
            intervalBells.setTitleColor(colour1, for: .normal)
            intervalBellsDetail.textColor = colour1
            endingBell.setTitleColor(colour1, for: .normal)
            endingBellDetail.textColor = colour1
            backgroundSound.setTitleColor(colour1, for: .normal)
            backgroundSoundDetail.textColor = colour1
        //
        default: break
        }
        
        
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
        beginButton.setTitleColor(colour3, for: .normal)
        
        // Iphone 5/SE layout
//        if UIScreen.main.nativeBounds.height < 1334 {
//            //
//            midConstraint1.constant = 44
//            midConstraint2.constant = 44
//            //
//        }
    
        switch backgroundIndex {
        case 3, backgroundImageArray.count:
            startingBell.setTitleColor(colour2, for: .normal)
            duration.setTitleColor(colour2, for: .normal)
            backgroundSound.setTitleColor(colour2, for: .normal)
            intervalBells.setTitleColor(colour2, for: .normal)
            endingBell.setTitleColor(colour2, for: .normal)
        default: break
        }
        
        // None Swipe and Button (named delete in code)
        // Swipe Left Buttons
        let deleteSwipe0 = UISwipeGestureRecognizer()
        deleteSwipe0.direction = .left
        deleteSwipe0.addTarget(self, action: #selector(deleteSwipeAction))
        //
        let deleteSwipe1 = UISwipeGestureRecognizer()
        deleteSwipe1.direction = .left
        deleteSwipe1.addTarget(self, action: #selector(deleteSwipeAction))
        //
        let deleteSwipe2 = UISwipeGestureRecognizer()
        deleteSwipe2.direction = .left
        deleteSwipe2.addTarget(self, action: #selector(deleteSwipeAction))
        //
        let deleteSwipe3 = UISwipeGestureRecognizer()
        deleteSwipe3.direction = .left
        deleteSwipe3.addTarget(self, action: #selector(deleteSwipeAction))
        //
        startingBell.addGestureRecognizer(deleteSwipe0)
        intervalBells.addGestureRecognizer(deleteSwipe1)
        endingBell.addGestureRecognizer(deleteSwipe2)
        backgroundSound.addGestureRecognizer(deleteSwipe3)
        //
        startingBell.tag = 0
        intervalBells.tag = 1
        endingBell.tag = 2
        backgroundSound.tag = 3
        //
        deleteButton.frame.size = CGSize(width: 44, height: 88)
        deleteButton.setTitle(NSLocalizedString("none", comment: ""), for: .normal)
        deleteButton.backgroundColor = colour4
        deleteButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 19)

        
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
        //tableViewBells.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        //tableViewIntervalBells.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
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
        //tableViewBackgroundSounds.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        
        // Interval Times Picker
        pickerViewIntervalTimes.backgroundColor = colour2
        pickerViewIntervalTimes.delegate = self
        pickerViewIntervalTimes.dataSource = self
        
       
    }
 
    
//
// View Did Dissapear  ---------------------------------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Picker Labels
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
        okButton.setTitleColor(colour3, for: .normal)
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
        //
        //
        durationTimeLabel.textColor = colour1
        durationTimeLabel.font = UIFont(name: "SFUIDisplay-thin", size: 17)
        durationTimeLabel.text = " " + NSLocalizedString("duration", comment: "")
       
        // view2
        selectionView2.backgroundColor = colour2
        selectionView2.layer.cornerRadius = 5
        selectionView2.layer.masksToBounds = true
        //
        intervalBellTimeLabel.textColor = colour1
        intervalBellTimeLabel.font = UIFont(name: "SFUIDisplay-thin", size: 17)
        intervalBellTimeLabel.text = " " + NSLocalizedString("bellTime", comment: "")
        // ok2
        okButton2.backgroundColor = colour1
        okButton2.setTitleColor(colour2, for: .normal)
        okButton2.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton2.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton2.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        //
        backgroundViewSelection2.backgroundColor = .clear
    }
 
    
//
// Selection Related actions ------------------------------------------------------------------------------------------------
//
    // Add movement table background (dismiss table)
    func backgroundViewSelectionAction(_ sender: Any) {
        //
        updateRows()
        //
        if (UIApplication.shared.keyWindow?.subviews.contains(self.presetsTableView))! {
            //
            updateRows()
            //
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.presetsTableView.frame = CGRect(x: 30, y: self.presets.frame.minY + UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
                self.presetsTableView.alpha = 0
                self.backgroundViewSelection.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewSelection.removeFromSuperview()
                //
                self.duration.isEnabled = true
                self.startingBell.isEnabled = true
                self.intervalBells.isEnabled = true
                self.endingBell.isEnabled = true
                self.backgroundSound.isEnabled = true
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
                //
                UserDefaults.standard.set(startingBellsArray, forKey: "meditationTimerStartingBells")
                //
                selectedStartingBell = -1
                //
                updateRows()
            //
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
        //
        isDurationSelected()
    }
    
    // Ok button action
    func okButtonAction(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        //
        //
        var removeView = false
        
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
            let hmsArray = convertToHMS(time: 0, index: 0)
            durationDetail.text = String(hmsArray[0]) + "h " + String(hmsArray[1]) + "m " + String(hmsArray[2]) + "s"
            //
            removeView = true
            //
            isDurationSelected()
            //
            var intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            if intervalBellsArray[selectedPreset].count > 0 {
                removeIntervalBells()
            }
        //
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
            //
            removeView = true
            //
        //
        case 3:
            //
            switch intervalBellStage {
            case 0:
                //
                if soundPlayer != nil {
                    if soundPlayer.isPlaying == true {
                        soundPlayer.stop()
                    }
                }
                //
                var intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
                //
                if didChangeIntervalBell == true {
                    intervalBellsDetail.text = String(intervalBellsArray[selectedPreset].count)
                }
                //
                selectedIntervalBell = -1
                //
                removeView = true
                //
                updateRows()
                //
            //
            case 1:
                //
                intervalBellStage = 2
                //
                if soundPlayer != nil {
                    if soundPlayer.isPlaying == true {
                        soundPlayer.stop()
                    }
                }
                //
                var intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
                //
                intervalBellsArray[selectedPreset].append(selectedIntervalBell)
                //
                UserDefaults.standard.set(intervalBellsArray, forKey: "meditationTimerIntervalBells")
                UserDefaults.standard.synchronize()
                //
                selectedIntervalBell = -1
                //
                removeView = false
                
                //
                // Present Times View
                // Hide original Selection View
                selectionView.isHidden = true
                //
                // PickerView
                selectionView2.addSubview(pickerViewDuration)
                pickerViewDuration.frame = CGRect(x: selectionView2.frame.maxX, y: 0, width: 0, height: selectionView2.frame.size.height - 49)
                //
                //
                selectionView2.addSubview(intervalBellTimeLabel)
                intervalBellTimeLabel.textAlignment = .left
                //
                // Select Rows
                pickerViewDuration.selectRow(0, inComponent: 0, animated: true)
                pickerViewDuration.selectRow(0, inComponent: 1, animated: true)
                pickerViewDuration.selectRow(0, inComponent: 2, animated: true)
                // ok
                //
                // Animate fade and size
                // Position
                UIView.animate(withDuration: 0.4, animations: {
                    //
                    self.selectionView2.frame = CGRect(x: 22, y: 0, width: UIScreen.main.bounds.width - 44, height: 147 + 49)
                    self.selectionView2.center.y = self.view.center.y - ((UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!) / 2)
                    //
                    self.intervalBellTimeLabel.frame = CGRect(x: 0, y: 0, width: self.selectionView2.frame.size.width, height: 22)
                    //
                    self.tableViewBells.frame = CGRect(x: 0, y: 0, width: 0, height: self.tableViewBells.frame.size.height)
                    //
                    self.pickerViewDuration.frame = CGRect(x: 0, y: 0, width: self.selectionView2.frame.size.width, height: self.selectionView2.frame.size.height - 49)
                    //
                    self.okButton2.frame = CGRect(x: 0, y: 147, width: self.selectionView2.frame.size.width, height: 49)
                    //
                    self.hoursLabel.center.y = self.pickerViewDuration.center.y
                    self.minutesLabel.center.y = self.pickerViewDuration.center.y
                    self.secondsLabel.center.y = self.pickerViewDuration.center.y
                    //
                    self.secondsLabel.center.x = self.pickerViewDuration.frame.minX + (self.pickerViewDuration.frame.size.width * (4.65/6))
                    self.minutesLabel.center.x = self.pickerViewDuration.frame.minX + (self.pickerViewDuration.frame.size.width * (3.55/6))
                    self.hoursLabel.center.x = self.pickerViewDuration.frame.minX + (self.pickerViewDuration.frame.size.width * (2.4/6))
                    // ok
                }, completion: { finished in
                    self.tableViewBells.removeFromSuperview()
                })
            //
            case 2:
                //
                intervalBellStage = 0
                //
                //
                var intervalTimesArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
                //
                //
                intervalTimesArray[selectedPreset].append(convertToSeconds())
                //
                UserDefaults.standard.set(intervalTimesArray, forKey: "meditationTimerIntervalTimes")
                UserDefaults.standard.synchronize
                //
                selectionView.isHidden = false
                selectionView.frame = CGRect(x: selectionView.frame.maxX, y: selectionView.frame.minY, width: 0, height: selectionView.frame.size.height)
                //
                removeView = false
                //
                // Reorder Arrays
                self.reorderIntervalBells()
                
                // Position
                UIView.animate(withDuration: 0.4, animations: {
                    //
                    self.selectionView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88)
                    //
                    self.selectionView2.frame = CGRect(x: 22, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: 0, height: self.selectionView.frame.size.height)
                    self.pickerViewDuration.frame = CGRect(x: 22, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: 0, height: self.selectionView.frame.size.height)
                    self.pickerViewDuration.alpha = 0
                    //
                    self.pickerViewDuration.frame = CGRect(x: 0, y: 0, width: 0, height: self.selectionView.frame.size.height - 49)
                    //
                    self.okButton2.frame = CGRect(x: 0, y: self.selectionView.frame.size.height - 49, width: 0, height: 49)
                    //
                    
                    //
                    self.tableViewIntervalBells.reloadData()
                    // ok
                }, completion: { finished in
                    //
                    for i in self.selectionView2.subviews {
                        i.removeFromSuperview()
                    }
                    //
                    self.selectionView2.removeFromSuperview()
                    self.backgroundViewSelection2.removeFromSuperview()
                    self.pickerViewDuration.alpha = 1
                    //
                    self.hoursLabel.alpha = 1
                    self.minutesLabel.alpha = 1
                })
            
            default: break
            }
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
            //
            removeView = true
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
            //
            removeView = true
        default: break
        }
        
        //
        defaults.synchronize()
        
        // Remove View
        if removeView == true {
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
    }
    
    
    // Reorder interval Bells
    func reorderIntervalBells() {
        //
        let defaults = UserDefaults.standard
        var intervalBellsArray = defaults.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
        var intervalBellsTimesArray = defaults.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
        
        //
        let combined = zip(intervalBellsTimesArray[selectedPreset], intervalBellsArray[selectedPreset]).sorted {$0.0 < $1.0}
        
        //
        intervalBellsTimesArray[selectedPreset] = combined.map {$0.0}
        intervalBellsArray[selectedPreset] = combined.map {$0.1}
        
        defaults.set(intervalBellsArray, forKey: "meditationTimerIntervalBells")
        defaults.set(intervalBellsTimesArray, forKey: "meditationTimerIntervalTimes")
    
        defaults.synchronize()
    }
    
    // Remove interval Bells if time too high
    func removeIntervalBells() {
        //
        let defaults = UserDefaults.standard
        defaults.set(presetsArray, forKey: "meditationTimerTitles")
        var intervalBellsArray = defaults.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
        var intervalBellsTimesArray = defaults.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
        //
        let durationArray = UserDefaults.standard.object(forKey: "meditationTimerDuration") as! [Int]
        //
        for i in intervalBellsTimesArray[selectedPreset] {
            //
            if i > durationArray[selectedPreset] {
                let index = intervalBellsTimesArray[selectedPreset].index(of: i)
                intervalBellsTimesArray[selectedPreset].remove(at: index!)
                intervalBellsArray[selectedPreset].remove(at: index!)
            }
        }
        //
        defaults.set(intervalBellsArray, forKey: "meditationTimerIntervalBells")
        defaults.set(intervalBellsTimesArray, forKey: "meditationTimerIntervalTimes")
        //
        defaults.synchronize()
        //
        updateRows()
    }
    
    
    
    
    
    //
    // None Button and Swipe
    var buttonArray: [UIButton] = []
    var deleteTag = Int()
    var isDeleting = Bool()
    // Delete Swipe
    @IBAction func deleteSwipeAction(sender: UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizerDirection.left {
            //
            isDeleting = true
            buttonArray = [startingBell, intervalBells, endingBell, backgroundSound]
            let buttonDetailArray = [startingBellDetail, intervalBellsDetail, endingBellDetail, backgroundSoundDetail]
            //
            let buttonTag = sender.view?.tag
            let button = buttonArray[buttonTag!]
            //
            button.addSubview(deleteButton)
            deleteButton.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
            deleteButton.frame = CGRect(x: button.frame.size.width, y: 0, width: 0, height: button.frame.size.height)
            deleteTag = buttonTag!
            //
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.deleteButton.frame = CGRect(x: button.frame.size.width - 88, y: 0, width: 88, height: button.frame.size.height)
                //
            }, completion: nil)
            
            // Disable Buttons
            for i in 0...(buttonArray.count - 1) {
                buttonArray[i].isEnabled = false
            }
            buttonArray[buttonTag!].isEnabled = true
            //
            duration.isEnabled = false
            presets.isEnabled = false
            beginButton.isEnabled = false
            //
            buttonDetailArray[buttonTag!]?.alpha = 0
        }
    }
    
    //
    func deleteAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        // Set Nil
        switch deleteTag {
        case 0:
            //
            var startingBellsArray = defaults.object(forKey: "meditationTimerStartingBells") as! [Int]
            startingBellsArray[selectedPreset] = -1
            defaults.set(startingBellsArray, forKey: "meditationTimerStartingBells")
            //
            startingBellDetail.text = "-"
            startingBellDetail.alpha = 1
        //
        case 1:
            //
            var intervalBellsArray = defaults.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            intervalBellsArray[selectedPreset] = []
            defaults.set(intervalBellsArray, forKey: "meditationTimerIntervalBells")
            //
            var intervalBellsTimesArray = defaults.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
            intervalBellsTimesArray[selectedPreset] = []
            defaults.set(intervalBellsTimesArray, forKey: "meditationTimerIntervalTimes")
            //
            intervalBellsDetail.text = "-"
            intervalBellsDetail.alpha = 1
        //
        case 2:
            //
            var endingBellsArray = defaults.object(forKey: "meditationTimerEndingBells") as! [Int]
            endingBellsArray[selectedPreset] = -1
            defaults.set(endingBellsArray, forKey: "meditationTimerEndingBells")
            //
            endingBellDetail.text = "-"
            endingBellDetail.alpha = 1
        //
        case 3:
            //
            var selectedBackgroundSoundsArray = defaults.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
            selectedBackgroundSoundsArray[selectedPreset] = -1
            defaults.set(selectedBackgroundSoundsArray, forKey: "meditationTimerBackgroundSounds")
            //
            backgroundSoundDetail.text = "-"
            backgroundSoundDetail.alpha = 1
        default: break
        }
        //
        defaults.synchronize()
        //
        //
        isDeleting = false
        //
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.deleteButton.frame = CGRect(x: self.duration.frame.size.width, y: 0, width: 0, height: self.duration.frame.size.height)
            //
        }, completion: { finished in
            self.deleteButton.removeFromSuperview()
            //
            self.presets.isEnabled = true
            self.duration.isEnabled = true
            self.startingBell.isEnabled = true
            self.intervalBells.isEnabled = true
            self.endingBell.isEnabled = true
            self.backgroundSound.isEnabled = true
            //
            self.beginButton.isEnabled = true
            //
        })

    }
    
    //
    
//
// Check if duration option is completed ------------------------------------------------------------------------------
//
    func isDurationSelected() {
        //
        // Enable only duration
        let durationArray = UserDefaults.standard.object(forKey: "meditationTimerDuration") as! [Int]
        if durationArray.count == 0 {
            
        } else if durationArray[selectedPreset] == 0 {
            self.startingBell.isEnabled = false
            self.intervalBells.isEnabled = false
            self.endingBell.isEnabled = false
            self.backgroundSound.isEnabled = false
        } else {
            self.startingBell.isEnabled = true
            self.intervalBells.isEnabled = true
            self.endingBell.isEnabled = true
            self.backgroundSound.isEnabled = true
        }
    }
    
//
// Button Actions ----------------------------------------------------------------------------------------------------
//
    
    // Prests
    @IBAction func presetsAction(_ sender: Any) {
        //
        self.duration.isEnabled = false
        self.startingBell.isEnabled = false
        self.intervalBells.isEnabled = false
        self.endingBell.isEnabled = false
        self.backgroundSound.isEnabled = false
        //
        presetsTableView.reloadData()
        //

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
        // Positiona
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.presetsTableView.alpha = 1
            self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88)
            
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
        //
   
    }

    // Duration
    @IBAction func durationAction(_ sender: Any) {
        //
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
        let hmsArray = convertToHMS(time: 0, index: 0)
        pickerViewDuration.selectRow(durationTimeArray[0].index(of: hmsArray[0])!, inComponent: 0, animated: true)
        pickerViewDuration.selectRow(durationTimeArray[1].index(of: hmsArray[1])!, inComponent: 1, animated: true)
        pickerViewDuration.selectRow(durationTimeArray[2].index(of: hmsArray[2])!, inComponent: 2, animated: true)
        //
        selectionView.addSubview(durationTimeLabel)
        durationTimeLabel.textAlignment = .left
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
            self.secondsLabel.center.x = self.pickerViewDuration.frame.minX + (self.pickerViewDuration.frame.size.width * (4.65/6))
            self.minutesLabel.center.x = self.pickerViewDuration.frame.minX + (self.pickerViewDuration.frame.size.width * (3.55/6))
            self.hoursLabel.center.x = self.pickerViewDuration.frame.minX + (self.pickerViewDuration.frame.size.width * (2.4/6))
            //
            self.durationTimeLabel.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: 22)
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
    }

    // Starting Bell
    @IBAction func startingBellAction(_ sender: Any) {
    //
    if isDeleting == false {
        selectedItem = 2
        //
        selectedStartingBell = -1
        didChangeStartingBell = false
        tableViewBells.reloadData()
        // View
        selectionView.alpha = 0
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
        backgroundViewSelection.frame = UIScreen.main.bounds
        //
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: selectionView)
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
        
    // Remove Delete Button
    } else {
        isDeleting = false
        //
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.deleteButton.frame = CGRect(x: self.duration.frame.size.width, y: 0, width: 0, height: self.duration.frame.size.height)
            self.startingBellDetail.alpha = 1
            //
        }, completion: { finished in
            self.deleteButton.removeFromSuperview()
            //
            self.presets.isEnabled = true
            self.duration.isEnabled = true
            self.startingBell.isEnabled = true
            self.intervalBells.isEnabled = true
            self.endingBell.isEnabled = true
            self.backgroundSound.isEnabled = true
            //
            self.beginButton.isEnabled = true
            //
        })
        }
    }

    // Interval Bells
    @IBAction func intervalBellsAction(_ sender: Any) {
    //
    if isDeleting == false {
        selectedItem = 3
        //
        selectedIntervalBell = -1
        didChangeIntervalBell = false
        intervalBellStage = 0
        tableViewIntervalBells.reloadData()
        // View
        selectionView.alpha = 0
        selectionView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + intervalBells.frame.minY, width: presets.frame.size.width - 44, height: 0)
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        // Table
        self.tableViewIntervalBells.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height - 49)
        selectionView.addSubview(tableViewIntervalBells)
        // ok
        okButton.frame = CGRect(x: 0, y: self.selectionView.frame.size.height - 49, width: selectionView.frame.size.width, height: 49)
        selectionView.addSubview(okButton)
        //
        backgroundViewSelection.alpha = 0
        backgroundViewSelection.frame = UIScreen.main.bounds
        //
        // Present
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: selectionView)
        // Animate table fade and size
        // Position
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.selectionView.alpha = 1
            //
            self.selectionView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88)
            self.tableViewIntervalBells.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height - 49)
            self.okButton.frame = CGRect(x: 0, y: self.selectionView.frame.size.height - 49, width: self.selectionView.frame.size.width, height: 49)

            self.tableViewIntervalBells.reloadData()
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
        //
        
    // Remove Delete Button
    } else {
        isDeleting = false
        //
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.deleteButton.frame = CGRect(x: self.duration.frame.size.width, y: 0, width: 0, height: self.duration.frame.size.height)
            self.intervalBellsDetail.alpha = 1
            //
        }, completion: { finished in
            self.deleteButton.removeFromSuperview()
            //
            self.presets.isEnabled = true
            self.duration.isEnabled = true
            self.startingBell.isEnabled = true
            self.intervalBells.isEnabled = true
            self.endingBell.isEnabled = true
            self.backgroundSound.isEnabled = true
            //
            self.beginButton.isEnabled = true
            //
        })
        }
    }

    // Ending Bell
    @IBAction func endingBellAction(_ sender: Any) {
    //
    if isDeleting == false {
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
        }, completion: nil)
        
        
    // Remove Delete Button
    } else {
        isDeleting = false
        //
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.deleteButton.frame = CGRect(x: self.duration.frame.size.width, y: 0, width: 0, height: self.duration.frame.size.height)
            self.endingBellDetail.alpha = 1
            //
        }, completion: { finished in
            self.deleteButton.removeFromSuperview()
            //
            self.presets.isEnabled = true
            self.duration.isEnabled = true
            self.startingBell.isEnabled = true
            self.intervalBells.isEnabled = true
            self.endingBell.isEnabled = true
            self.backgroundSound.isEnabled = true
            //
            self.beginButton.isEnabled = true
            //
        })
        }
    }

    // Background Sound
    @IBAction func backgroundSoundAction(_ sender: Any) {
    //
    if isDeleting == false {
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
        
        
    // Remove Delete Button
    } else {
        isDeleting = false
        //
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.deleteButton.frame = CGRect(x: self.duration.frame.size.width, y: 0, width: 0, height: self.duration.frame.size.height)
            self.backgroundSoundDetail.alpha = 1
            //
        }, completion: { finished in
            self.deleteButton.removeFromSuperview()
            //
            self.presets.isEnabled = true
            self.duration.isEnabled = true
            self.startingBell.isEnabled = true
            self.intervalBells.isEnabled = true
            self.endingBell.isEnabled = true
            self.backgroundSound.isEnabled = true
            //
            self.beginButton.isEnabled = true
            //
        })
        }
    }

    
    
    
    
    
//
// TableView -----------------------------------------------------------------------------------------------------------------------
//
  
    // Update Main Screen Detail Labels
    func updateRows() {
        // Register Defaults
        let defaults = UserDefaults.standard
        let presetsArray = defaults.object(forKey: "meditationTimerTitles") as! [String]
        let durationArray = defaults.object(forKey: "meditationTimerDuration") as! [Int]
        let startingBellsArray = defaults.object(forKey: "meditationTimerStartingBells") as! [Int]
        let intervalBellsArray = defaults.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
        let endingBellsArray = defaults.object(forKey: "meditationTimerEndingBells") as! [Int]
        let selectedBackgroundSoundsArray = defaults.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
        //
    // Test all for nil
    if presetsArray.count != 0 {
        
        //
        if durationArray[selectedPreset] != 0 {
            let hmsArray = convertToHMS(time: 0, index: 0)
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
    //
    } else {
        presetsDetail.text = "-"
        durationDetail.text = "-"
        startingBellDetail.text = "-"
        intervalBellsDetail.text = "-"
        endingBellDetail.text = "-"
        backgroundSoundDetail.text = "-"
    }
    //
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
            return " " + NSLocalizedString("meditations", comment: "")
        case tableViewBells:
            switch selectedItem {
            case 2:
                return " " + NSLocalizedString("startingBell", comment: "")
            case 3:
                return " " + NSLocalizedString("bells", comment: "")
            case 4:
                return " " + NSLocalizedString("endingBell", comment: "")
            default: return " "
            }
        case tableViewIntervalBells: return " " + NSLocalizedString("intervalBells", comment: "")
        case tableViewBackgroundSounds: return " " + NSLocalizedString("backgroundSound", comment: "")
        default: return ""
    }
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 17)!
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
        var cell = UITableViewCell()
        
        //
        // Cell Content
        switch tableView {
        case presetsTableView:
            cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            //
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
            //
            cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            //
            //
            cell.textLabel?.text = NSLocalizedString(bellsArray[indexPath.row], comment: "")
            cell.imageView?.image = bellsImages[indexPath.row]
            //
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = colour2
            cell.textLabel?.textColor = colour1
            cell.tintColor = colour1
            //
            switch selectedItem {
            case 2:
                //
                let startingBellsArray = UserDefaults.standard.object(forKey: "meditationTimerStartingBells") as! [Int]
                if didChangeStartingBell == false {
                    if startingBellsArray[selectedPreset] != -1 {
                        selectedStartingBell = startingBellsArray[selectedPreset]
                    }
                }
                //
                if indexPath.row == selectedStartingBell {
                    cell.textLabel?.textColor = colour3
                    cell.accessoryType = .checkmark
                    cell.tintColor = colour3
                }
                //
                if selectedStartingBell != -1 {
                    okButton.isEnabled = true
                }
            case 3:
                //
                if indexPath.row == selectedIntervalBell {
                    cell.textLabel?.textColor = colour3
                    cell.accessoryType = .checkmark
                    cell.tintColor = colour3
                }
                //
                if indexPath.row == bellsArray.count {
                    cell.alpha = 0
                    cell.isUserInteractionEnabled = false
                }
                //
                if selectedIntervalBell != -1 {
                    okButton.isEnabled = true
                }
            case 4:
                //
                let endingBellsArray = UserDefaults.standard.object(forKey: "meditationTimerEndingBells") as! [Int]
                if didChangeEndingBell == false {
                    if endingBellsArray[selectedPreset] != -1 {
                        selectedEndingBell = endingBellsArray[selectedPreset]
                    }
                }
                //
                if indexPath.row == selectedEndingBell {
                    cell.textLabel?.textColor = colour3
                    cell.accessoryType = .checkmark
                    cell.tintColor = colour3
                }
                //
                if selectedEndingBell != -1 {
                    okButton.isEnabled = true
                }
            default: break
            }
            
        //
        case tableViewIntervalBells:
            //
            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.textLabel?.textAlignment = .left
            //
            let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            //
                // New Bell
                if indexPath.row == intervalBellsArray[selectedPreset].count {
                    cell.backgroundColor = colour2
                    cell.textLabel?.textColor = colour1
                    cell.tintColor = colour1
                    cell.layer.borderColor = colour1.cgColor
                    cell.layer.borderWidth = 1
                    //
                    cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                    //
                    cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                    cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
                    // Bells Rows
                } else {
                    let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
                    cell.backgroundColor = colour2
                    cell.textLabel?.textColor = colour1
                    cell.tintColor = colour1
                    //
                    cell.textLabel?.text = NSLocalizedString(bellsArray[intervalBellsArray[selectedPreset][indexPath.row]], comment: "")
                    cell.imageView?.image = bellsImages[intervalBellsArray[selectedPreset][indexPath.row]]

                    //
                    let timesArray = convertToHMS(time: 1, index: indexPath.row)
                    cell.detailTextLabel?.text = String(timesArray[0]) + "h " + String(timesArray[1]) + "m " + String(timesArray[2]) + "s"
                    //
                    cell.detailTextLabel?.textColor = colour1
                    cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
                    //
                    cell.selectionStyle = .none
            }
        //
        case tableViewBackgroundSounds:
            //
            cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            //
            //
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = colour2
            cell.textLabel?.textColor = colour1
            cell.tintColor = colour1
            //
            let selectedBackgroundSoundsArray = UserDefaults.standard.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
            if didChangeBackgroundSound == false {
                if selectedBackgroundSoundsArray[selectedPreset] != -1 {
                    selectedBackgroundSound = selectedBackgroundSoundsArray[selectedPreset]
                }
            }
            //
            if indexPath.row == selectedBackgroundSound {
                cell.textLabel?.textColor = colour3
                cell.accessoryType = .checkmark
                cell.tintColor = colour3
            }
            //
            if selectedBackgroundSound != -1 {
                okButton.isEnabled = true
            }
        //
        cell.textLabel?.text = NSLocalizedString(backgroundSoundsArray[indexPath.row], comment: "")
        cell.imageView?.image = backgroundSoundsImages[indexPath.row]
        
            
        default: break
        }
        return cell
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case presetsTableView:
            return 44
        case tableViewIntervalBells:
            let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            if indexPath.row == intervalBellsArray[selectedPreset].count {
                return 44
            } else {
                return 88
            }
        case tableViewBackgroundSounds, tableViewBells:
            return 88
        default: return 0
        }
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
                    // Enable rows
                    self.isDurationSelected()
                    
                    //
                    self.presetsTableView.isHidden = false
                    snapShot1?.removeFromSuperview()
                    //
                    self.backgroundViewSelection.isHidden = false
                    UIView.animate(withDuration: 0.3, animations: {
                        self.backgroundViewSelection.alpha = 0.5
                        self.presetsTableView.reloadData()
                    // Dismiss and select new row
                    }, completion: { finished in
                        //
                        //
                        let presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
                        //
                        let selectedIndexPath = NSIndexPath(row: presetsArray.count - 1, section: 0)
                        self.presetsTableView.selectRow(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
                        self.selectedPreset = indexPath.row
                        //
                        self.presetsDetail.text = presetsArray[self.selectedPreset]
                        //
                        tableView.deselectRow(at: indexPath, animated: true)
                        // Dismiss Table
                        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.presetsTableView.frame = CGRect(x: 30, y: 44 + UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
                        self.presetsTableView.alpha = 0
                        self.backgroundViewSelection.alpha = 0
                        //
                        self.presetsConstraint.constant = 0
                        self.durationConstraint.constant = 0
                        self.startingConstraint.constant = 0
                        self.intervalConstraint.constant = 0
                        self.endingConstraint.constant = 0
                        self.backgroundConstraint.constant = 0
                        //
                        self.beginButtonBottom.constant = 0
                        self.seperatorLine.alpha = 1
                        self.view.layoutIfNeeded()
                        }, completion: { finished in
                        //
                        self.presetsTableView.removeFromSuperview()
                        self.backgroundViewSelection.removeFromSuperview()
                        //
                        self.duration.isEnabled = true
                        self.startingBell.isEnabled = true
                        self.intervalBells.isEnabled = true
                        self.endingBell.isEnabled = true
                        self.backgroundSound.isEnabled = true
                        self.isDurationSelected()
                        })
                        //
                        self.updateRows()
                    })
                   
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
                if presetsArray.count != 0 {
                UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.presetsTableView.frame = CGRect(x: 30, y: 44 + UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsTableView.frame.size.width, height: 1)
                    self.presetsTableView.alpha = 0
                    self.backgroundViewSelection.alpha = 0
                    //
                    self.presetsConstraint.constant = 0
                    self.durationConstraint.constant = 0
                    self.startingConstraint.constant = 0
                    self.intervalConstraint.constant = 0
                    self.endingConstraint.constant = 0
                    self.backgroundConstraint.constant = 0
                    //
                    self.beginButtonBottom.constant = 0
                    self.seperatorLine.alpha = 1
                    self.view.layoutIfNeeded()
                }, completion: { finished in
                    //
                    self.presetsTableView.removeFromSuperview()
                    self.backgroundViewSelection.removeFromSuperview()
                    //
                    self.duration.isEnabled = true
                    self.startingBell.isEnabled = true
                    self.intervalBells.isEnabled = true
                    self.endingBell.isEnabled = true
                    self.backgroundSound.isEnabled = true
                })
                }
                //
                updateRows()
            }
        //
        case tableViewBells:
            //
            let bell = NSDataAsset(name: bellsArray[indexPath.row])
            
            let url = Bundle.main.url(forResource: bellsArray[indexPath.row], withExtension: "caf")!
            
            do {
                let bell = try AVAudioPlayer(contentsOf: url)
                soundPlayer = bell
                bell.play()
            } catch {
                // couldn't load file :(
            }
            //
            switch selectedItem {
            case 2:
                selectedStartingBell = indexPath.row
                didChangeStartingBell = true
            case 3:
                selectedIntervalBell = indexPath.row
                didChangeIntervalBell = true
                okButton2.isEnabled = true
            case 4:
                selectedEndingBell = indexPath.row
                didChangeEndingBell = true
            default: break
            }
            //
            tableViewBells.reloadData()
            tableViewBells.deselectRow(at: indexPath, animated: true)
            
        //
        case tableViewIntervalBells:
            //
            var intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            //
            //
            if indexPath.row == intervalBellsArray[selectedPreset].count {
                    //
                    selectedItem = 3
                    //
                    selectedIntervalBell = -1
                    didChangeIntervalBell = false
                    intervalBellStage = 1
                    tableViewBells.reloadData()
                    //
                    UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection2, aboveSubview: selectionView)
                    backgroundViewSelection2.frame = UIScreen.main.bounds
                    // View
                    selectionView2.alpha = 0
                    UIApplication.shared.keyWindow?.insertSubview(selectionView2, aboveSubview: backgroundViewSelection2)
                    selectionView2.frame = CGRect(x: selectionView.frame.maxX, y: selectionView.frame.minY, width: 0, height: selectionView.frame.size.height)
                    // Tableview
                    selectionView2.addSubview(tableViewBells)
                    tableViewBells.frame = CGRect(x: 0, y: 0, width: selectionView2.frame.size.width, height: selectionView2.frame.size.height - 49)
                    
                    // ok
                    okButton2.frame = CGRect(x: 0, y: selectionView2.frame.size.height - 49, width: selectionView2.frame.size.width, height: 49)
                    selectionView2.addSubview(okButton2)
                    //
                    okButton2.isEnabled = false
                    // Animate fade and size
                    // Position
                    UIView.animate(withDuration: 0.4, animations: {
                        //
                        let height = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
                        //
                        self.selectionView2.alpha = 1
                        //
                        self.selectionView2.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: height)
                        // ok
                        self.tableViewBells.frame = CGRect(x: 0, y: 0, width: self.selectionView2.frame.size.width, height: height - 49)
                        // ok
                        self.okButton2.frame = CGRect(x: 0, y: height - 49, width: self.selectionView2.frame.size.width, height: 49)
                        //
                        self.selectionView2.alpha = 1
                        //
                    }, completion: nil)
                    //
                    tableViewIntervalBells.deselectRow(at: indexPath, animated: true)
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
        switch tableView {
        case presetsTableView:
            // Retreive Preset Timers
            let presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
            var returnValue = Bool()
            if indexPath.row < presetsArray.count {
                returnValue = true
            }
            return returnValue
        //
        case tableViewIntervalBells:
            // Retreive Preset Timers
            let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            var returnValue = Bool()
                if indexPath.row < intervalBellsArray[selectedPreset].count {
                    returnValue = true
                }
            return returnValue
        //
        case tableViewBells:
            return false
        default: return false
        }
    }
    
    // Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            //
            switch tableView{
            //
            case presetsTableView:
                //
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
                
                //
                updateRows()
                // If no more meditations
                if presetsArray.count == 0 {
                    //
                    //
                    
                    if seperatorLine.alpha != 0 {
                    UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    // Initial Positions and States
                    //
                    //
                    self.presetsConstraint.constant = (self.view.frame.maxY / 2) - self.presets.frame.maxY
                    //
                    self.durationConstraint.constant = self.view.frame.maxY - self.duration.frame.maxY + 22
                    self.startingConstraint.constant = self.view.frame.maxY - self.startingBell.frame.maxY + 44
                    self.intervalConstraint.constant = self.view.frame.maxY - self.intervalBells.frame.maxY + 44
                    self.endingConstraint.constant = self.view.frame.maxY - self.endingBell.frame.maxY + 55
                    
                    self.backgroundConstraint.constant = self.view.frame.maxY - self.backgroundSound.frame.maxY + 66
                    //
                    self.beginButtonBottom.constant = -445
                    //
                    self.seperatorLine.alpha = 0
                    //
                    })
                    }
                }
                
            case tableViewIntervalBells:
                let defaults = UserDefaults.standard
                var intervalBellsArray = defaults.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
                var intervalBellsTimesArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
                //
                intervalBellsArray[selectedPreset].remove(at: indexPath.row)
                //intervalBellsTimesArray[selectedPreset].remove(at: indexPath.row)
                //
                defaults.set(intervalBellsArray, forKey: "meditationTimerIntervalBells")
                //defaults.set(intervalBellsTimesArray, forKey: "meditationTimerIntervalTimes")
                //
                defaults.synchronize()
                //
                UIView.animate(withDuration: 0.2, animations: {
                    self.tableViewIntervalBells.reloadData()
                })
            //
            default: break
            }
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
        // duration
        if selectedItem == 1 {
            return durationTimeArray[component].count
        // interval
        } else {
            let hmsArray = convertToHMS(time: 0, index: 0)
            
            if hmsArray[0] == 0 && hmsArray[1] == 0 {
                //
                hoursLabel.alpha = 0
                minutesLabel.alpha = 0
                //
                switch component {
                case 0:
                    return 0
                case 1:
                    return 0
                case 2:
                    let index = durationTimeArray[2].index(of: hmsArray[2])
                    return index!
                default: return 0
                }
                //
            //
            } else if hmsArray[0] == 0 {
                //
                hoursLabel.alpha = 0
                //
                switch component {
                case 0:
                    return 0
                case 1:
                    let index = durationTimeArray[1].index(of: hmsArray[1])
                    return index!
                case 2:
                    return durationTimeArray[component].count
                default: return 0
                }
                //
            //
            } else {
                switch component {
                case 0:
                    let index = durationTimeArray[0].index(of: hmsArray[0])
                    return index!
                case 1:
                    return durationTimeArray[component].count
                case 2:
                    return durationTimeArray[component].count
                default: return 0
                }
                //
            //
            }
        }
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
    func convertToHMS(time: Int, index: Int) -> [Int] {
        //
        var hmsArray: [Int] = []
        //
        switch time {
        case 0:
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
        case 1:
            //
            let timeInSeconds = UserDefaults.standard.object(forKey: "meditationTimerIntervalTimes") as! [[Int]]
            //
            let hours = Int(timeInSeconds[selectedPreset][index] / 3600)
            hmsArray.append(hours)
            //
            let minutes = Int((timeInSeconds[selectedPreset][index]  % 3600) / 60)
            hmsArray.append(minutes)
            //
            let seconds = Int(timeInSeconds[selectedPreset][index]  % 60)
            hmsArray.append(seconds)
        //
        default: break
        }
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
        //
        if durationArray[selectedPreset] != 0 {
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
    
    // Prepare for segue
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
        if segue.identifier == "meditationTimerSegue" {
            //
            let destinationVC = segue.destination as! MeditationScreen
            //
            destinationVC.bellsArray = bellsArray
            destinationVC.backgroundSoundsArray = backgroundSoundsArray
            //
            destinationVC.selectedPreset = selectedPreset
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
