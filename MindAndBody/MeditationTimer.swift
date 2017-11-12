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
    
    // Bells Arrays
    let bellsArray: [String] =
        ["Tibetan Chimes", "Tibetan Singing Bowl (Low)", "Tibetan Singing Bowl (Low)(x4)", "Tibetan Singing Bowl (Low)(Singing)", "Tibetan Singing Bowl (High)", "Tibetan Singing Bowl (High)(x4)", "Tibetan Singing Bowl (High)(Singing)", "Australian Rain Stick", "Australian Rain Stick (x2)", "Australian Rain Stick (2 sticks)", "Wind Chimes", "Gambang (Wood)(Up)", "Gambang (Wood)(Down)", "Gambang (Metal)", "Indonesian Frog", "Cow Bell (Small)", "Cow Bell (Big)"]
    let bellsImages: [UIImage] =
        [#imageLiteral(resourceName: "Tibetan Chimes"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Wind Chimes"), #imageLiteral(resourceName: "Indonesian Xylophone Big"), #imageLiteral(resourceName: "Indonesian Xylophone Big"), #imageLiteral(resourceName: "Indonesian Xylophone Small"), #imageLiteral(resourceName: "Indonesian Frog"), #imageLiteral(resourceName: "Cow Bell"), #imageLiteral(resourceName: "Cow Bell Big")]
    
    // Background Sounds Array
    let backgroundSoundsArray: [String] =
        ["TestBackground"]
    let backgroundSoundsImages: [UIImage] =
        [#imageLiteral(resourceName: "Tibetan Chimes")]
    
    
    // Duration Array
    let durationTimeArray: [[Int]] =
        [
            [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
            [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 58, 59],
            [00, 10, 20, 30, 40, 50]
    ]
    
    
    // Selected Preset
    var selectedPreset = Int()
    
    // Indicates Which row of the options has been selected
    var selectedItem = Int()
    
    //
    var didChangeDuration = Bool()
    
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
    var comingFromSchedule = false
    
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
        
        //
        // Initial Positions and States
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
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        //
        // Background Image/Colour
        //
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            //
            backgroundImage.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
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
        
        // Navigation Bar
        //
        // Title
        navigationBar.title = NSLocalizedString("meditationTimer", comment: "")
        // Appearance
        self.navigationController?.navigationBar.tintColor = Colours.colour1
        self.navigationController?.navigationBar.barTintColor = Colours.colour2
        
        // BackgroundBlur/Vibrancy
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        let vibrancyE = UIVibrancyEffect(blurEffect: backgroundBlurE)
        backgroundBlur.effect = vibrancyE
        backgroundBlur.isUserInteractionEnabled = false
        //
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
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
        //
        didChangeDuration = false
        
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
        case 1,2,3,5,6, BackgroundImages.backgroundImageArray.count:
            presets.setTitleColor(Colours.colour1, for: .normal)
            presetsDetail.textColor = Colours.colour1
            duration.setTitleColor(Colours.colour2, for: .normal)
            durationDetail.textColor = Colours.colour2
            startingBell.setTitleColor(Colours.colour2, for: .normal)
            startingBellDetail.textColor = Colours.colour2
            intervalBells.setTitleColor(Colours.colour2, for: .normal)
            intervalBellsDetail.textColor = Colours.colour2
            endingBell.setTitleColor(Colours.colour2, for: .normal)
            endingBellDetail.textColor = Colours.colour2
            backgroundSound.setTitleColor(Colours.colour2, for: .normal)
            backgroundSoundDetail.textColor = Colours.colour2
        // All White
        case 0,3,4:
            presets.setTitleColor(Colours.colour1, for: .normal)
            presetsDetail.textColor = Colours.colour1
            duration.setTitleColor(Colours.colour1, for: .normal)
            durationDetail.textColor = Colours.colour1
            startingBell.setTitleColor(Colours.colour1, for: .normal)
            startingBellDetail.textColor = Colours.colour1
            intervalBells.setTitleColor(Colours.colour1, for: .normal)
            intervalBellsDetail.textColor = Colours.colour1
            endingBell.setTitleColor(Colours.colour1, for: .normal)
            endingBellDetail.textColor = Colours.colour1
            backgroundSound.setTitleColor(Colours.colour1, for: .normal)
            backgroundSoundDetail.textColor = Colours.colour1
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
        beginButton.setTitleColor(Colours.colour1, for: .normal)
        beginButton.backgroundColor = Colours.colour3
        
        
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
        deleteButton.backgroundColor = Colours.colour4
        deleteButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 19)
        
        
        // Presets TableView
        //
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = Colours.colour2
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        presetsTableView.tableFooterView = UIView()
        // TableView Cell action items
        //
        presetsTableView.backgroundColor = Colours.colour2
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        presetsTableView.layer.cornerRadius = 15
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        
        // Duration Picker
        pickerViewDuration.backgroundColor = Colours.colour2
        pickerViewDuration.delegate = self
        pickerViewDuration.dataSource = self
        
        
        // Bells Table
        let tableViewBackground3 = UIView()
        //
        tableViewBackground3.backgroundColor = Colours.colour2
        tableViewBackground3.frame = CGRect(x: 0, y: 0, width: self.tableViewBells.frame.size.width, height: self.tableViewBells.frame.size.height)
        //
        tableViewBells.backgroundView = tableViewBackground3
        tableViewBells.tableFooterView = UIView()
        // TableView Cell action items
        //
        tableViewBells.backgroundColor = Colours.colour2
        tableViewBells.delegate = self
        tableViewBells.dataSource = self
        tableViewBells.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewBells.layer.cornerRadius = 15
        tableViewBells.layer.masksToBounds = true
        //
        
        // Interval Bells Table
        let tableViewBackground4 = UIView()
        //
        tableViewBackground4.backgroundColor = Colours.colour2
        tableViewBackground4.frame = CGRect(x: 0, y: 0, width: self.tableViewIntervalBells.frame.size.width, height: self.tableViewIntervalBells.frame.size.height)
        //
        tableViewIntervalBells.backgroundView = tableViewBackground4
        tableViewIntervalBells.tableFooterView = UIView()
        // TableView Cell action items
        //
        tableViewIntervalBells.backgroundColor = Colours.colour2
        tableViewIntervalBells.delegate = self
        tableViewIntervalBells.dataSource = self
        tableViewIntervalBells.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewIntervalBells.layer.cornerRadius = 15
        tableViewIntervalBells.layer.masksToBounds = true
        //tableViewIntervalBells.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        // Background Sounds Table View
        let tableViewBackground5 = UIView()
        //
        tableViewBackground5.backgroundColor = Colours.colour2
        tableViewBackground5.frame = CGRect(x: 0, y: 0, width: self.tableViewBackgroundSounds.frame.size.width, height: self.tableViewBackgroundSounds.frame.size.height)
        //
        tableViewBackgroundSounds.backgroundView = tableViewBackground5
        tableViewBackgroundSounds.tableFooterView = UIView()
        // TableView Cell action items
        //
        tableViewBackgroundSounds.backgroundColor = Colours.colour2
        tableViewBackgroundSounds.delegate = self
        tableViewBackgroundSounds.dataSource = self
        tableViewBackgroundSounds.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewBackgroundSounds.layer.cornerRadius = 15
        tableViewBackgroundSounds.layer.masksToBounds = true
        //tableViewBackgroundSounds.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        
        // Interval Times Picker
        pickerViewIntervalTimes.backgroundColor = Colours.colour2
        pickerViewIntervalTimes.delegate = self
        pickerViewIntervalTimes.dataSource = self
        
        
        //
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Select
        self.presets.sendActions(for: .touchUpInside)
    }
    
    //
    // View Did Dissapear  ---------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Picker Labels
        //
        hoursLabel.textAlignment = .center
        hoursLabel.textColor = Colours.colour1
        hoursLabel.text = "h"
        hoursLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        hoursLabel.numberOfLines = 1
        hoursLabel.sizeToFit()
        hoursLabel.center.y = pickerViewDuration.center.y
        hoursLabel.center.x = pickerViewDuration.frame.minX + (pickerViewDuration.frame.size.width * (2.4/6))
        pickerViewDuration.addSubview(hoursLabel)
        //
        minutesLabel.textAlignment = .center
        minutesLabel.textColor = Colours.colour1
        minutesLabel.text = "m"
        minutesLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        minutesLabel.numberOfLines = 1
        minutesLabel.sizeToFit()
        minutesLabel.center.y = pickerViewDuration.center.y
        minutesLabel.center.x = pickerViewDuration.frame.minX + (pickerViewDuration.frame.size.width * (3.55/6))
        pickerViewDuration.addSubview(minutesLabel)
        //
        secondsLabel.textAlignment = .center
        secondsLabel.textColor = Colours.colour1
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
        
        //
        // Selection Elements
        // view
        selectionView.backgroundColor = Colours.colour2
        selectionView.layer.cornerRadius = 15
        selectionView.layer.masksToBounds = true
        // ok
        okButton.backgroundColor = Colours.colour1
        okButton.setTitleColor(Colours.colour3, for: .normal)
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
        durationTimeLabel.textColor = Colours.colour1
        durationTimeLabel.font = UIFont(name: "SFUIDisplay-thin", size: 17)
        durationTimeLabel.text = "  " + NSLocalizedString("duration", comment: "")
        
        // view2
        selectionView2.backgroundColor = Colours.colour2
        selectionView2.layer.cornerRadius = 15
        selectionView2.layer.masksToBounds = true
        //
        intervalBellTimeLabel.textColor = Colours.colour1
        intervalBellTimeLabel.font = UIFont(name: "SFUIDisplay-thin", size: 17)
        intervalBellTimeLabel.text = " " + NSLocalizedString("bellTime", comment: "")
        // ok2
        okButton2.backgroundColor = Colours.colour1
        okButton2.setTitleColor(Colours.colour3, for: .normal)
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
    @objc func backgroundViewSelectionAction(_ sender: Any) {
        //
        updateRows()
        //
        if (UIApplication.shared.keyWindow?.subviews.contains(self.presetsTableView))! {
            //
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.view.frame.size.width - 20, height: self.presetsTableView.frame.size.height)
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
            isDurationSelected()
            
            //
        } else {
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                //
                self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height)
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
    var bellToAdd = [-1, 0] // Interval bell to add
    //
    @objc func okButtonAction(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        var meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        //
        var removeView = false
        
        // Ok Actions
        switch selectedItem {
        // Presets
        case 0: break // OK button not used
        // Duration
        case 1:
            if didChangeDuration == true {
                //
                didChangeDuration = false
                //
                // Set new duration
                if (meditationArray[selectedPreset][1][0] as! [Int]).count != 0 {
                    meditationArray[selectedPreset][1][0][0] = convertToSeconds()
                } else {
                    meditationArray[selectedPreset][1][0].append(convertToSeconds())
                }
                // Set ending bell time to duration
                let lastIndex = (meditationArray[selectedPreset][2] as! [[Int]]).count - 1
                meditationArray[selectedPreset][2][lastIndex][1] = convertToSeconds()
                //
                UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                
                // Change duration button detail text label
                let hmsArray = convertToHMS(time: 0, index: 0)
                durationDetail.text = String(hmsArray[0]) + "h " + String(hmsArray[1]) + "m " + String(hmsArray[2]) + "s"
                //
                isDurationSelected()
                //
                // Check if interval bells should be removed (if new duration is shorter than old, there might be some interval bells that are after the end time and that should be removed)
                // > 2 because starting and ending bells included in array
                if (meditationArray[selectedPreset][2] as! [[Int]]).count > 2 {
                    removeIntervalBells()
                }
            }
            //
            removeView = true
        // Starting Bell
        case 2:
            if didChangeStartingBell == true {
                //
                didChangeStartingBell = false
                //
                if soundPlayer != nil {
                    if soundPlayer.isPlaying == true {
                        soundPlayer.stop()
                    }
                }
                //
                // Change Starting Bell
                meditationArray[selectedPreset][2][0][0] = selectedStartingBell
                //
                UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                //
                startingBellDetail.text = NSLocalizedString(bellsArray[meditationArray[selectedPreset][2].first![0] as! Int], comment: "")
                //
                selectedStartingBell = -1
                //
            }
            //
            removeView = true
            //
        // Interval Bells
        case 3:
            //
            switch intervalBellStage {
            case 0:
                //
                //
                if soundPlayer != nil {
                    if soundPlayer.isPlaying == true {
                        soundPlayer.stop()
                    }
                }
                //
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
                // ToAdd interval bell, set bell
                bellToAdd = [-1, 0]
                bellToAdd[0] = selectedIntervalBell
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
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    //
                    let selectionWidth = self.view.frame.size.width - 20
                    let selectionHeight = CGFloat(147 + 49)
                    self.selectionView2.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
                    //
                    self.intervalBellTimeLabel.frame = CGRect(x: 0, y: 0, width: self.selectionView2.frame.size.width, height: 22)
                    //
                    self.tableViewBells.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
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
                didChangeIntervalBell = false
                //
                intervalBellStage = 0
                //
                //
                // Set Interval Bell Time, and insert it in relevant place
                bellToAdd[1] = convertToSeconds()
                // 1 as interval bells start at 1 (starting bell = 0)
                let count = (meditationArray[selectedPreset][2] as! [[Int]]).count - 2
                if count > 0 {
                    // If biggest
                    if bellToAdd[1] > meditationArray[selectedPreset][2][count][1] as! Int {
                        meditationArray[selectedPreset][2].insert(bellToAdd, at: count)
                    } else {
                        // Else find spoty
                        for i in 1...count {
                            // If new time < i time, add at i
                            if bellToAdd[1] < meditationArray[selectedPreset][2][i][1] as! Int {
                                meditationArray[selectedPreset][2].insert(bellToAdd, at: i)
                                break
                            }
                        }
                    }
                    // No intervals yet -> insert between starting and ending thus at 1
                } else {
                    meditationArray[selectedPreset][2].insert(bellToAdd, at: 1)
                }
                //
                UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                //
                selectionView.isHidden = false
                selectionView.frame = CGRect(x: selectionView.frame.maxX, y: selectionView.frame.minY, width: 0, height: selectionView.frame.size.height)
                //
                removeView = false
                
                // Position
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    //
                    //
                    let selectionWidth = self.view.frame.size.width - 20
                    let selectionHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
                    self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
                    //
                    self.selectionView2.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: 0, height: self.selectionView.frame.size.height)
                    self.pickerViewDuration.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: 0, height: self.selectionView.frame.size.height)
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
        // Ending Bell
        case 4:
            if didChangeEndingBell == true {
                //
                didChangeEndingBell = false
                //
                if soundPlayer != nil {
                    if soundPlayer.isPlaying == true {
                        soundPlayer.stop()
                    }
                }
                //
                // .last = ending bell, [0] = bell
                let lastIndex = (meditationArray[selectedPreset][2] as! [[Int]]).count - 1
                meditationArray[selectedPreset][2][lastIndex][0] = selectedEndingBell
                //
                UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                //
                endingBellDetail.text = NSLocalizedString(bellsArray[selectedEndingBell], comment: "")
                //
                selectedEndingBell = -1
                //
            }
            //
            removeView = true
        // Background Sound
        case 5:
            if didChangeBackgroundSound == true {
                //
                didChangeBackgroundSound = false
                //
                if soundPlayer != nil {
                    if soundPlayer.isPlaying == true {
                        soundPlayer.stop()
                    }
                }
                //
                // [3] = background sound
                meditationArray[selectedPreset][3][0][0] = selectedBackgroundSound
                //
                UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                //
                backgroundSoundDetail.text = NSLocalizedString(backgroundSoundsArray[selectedBackgroundSound], comment: "")
                //
                selectedBackgroundSound = -1
                //
            }
            removeView = true
        default: break
        }
        
        //
        // Remove View
        if removeView == true {
            //
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                //
                self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height)
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
    
    
    //
    // Helper functions
    //
    // Remove interval Bells if time too high
    func removeIntervalBells() {
        //
        let defaults = UserDefaults.standard
        var meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        //
        // 1 as interval bells start at 1 (starting bell = 0)
        for i in 1...(meditationArray[selectedPreset][2] as! [[Int]]).count - 2 {
            // If time > duration -> remove bell
            if meditationArray[selectedPreset][2][i][1] as! Int > meditationArray[selectedPreset][1][0][0] as! Int {
                meditationArray[selectedPreset][2].remove(at: i)
                break
            }
        }
        //
        defaults.set(meditationArray, forKey: "meditationTimer")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
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
    @objc func deleteAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        var meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        // Set Nil
        switch deleteTag {
        // Starting Bell
        case 0:
            //
            meditationArray[selectedPreset][2][0][0] = -1
            //
            startingBellDetail.text = "-"
            startingBellDetail.alpha = 1
        //
        case 1:
            //
            // 1 as interval bells start at 1 (starting bell = 0)
            let count = (meditationArray[selectedPreset][2] as! [[Int]]).count - 2
            if count > 0 {
                // Remove all interval bells
                for _ in 1...count {
                    // If new time < i time, add at i
                    meditationArray[selectedPreset][2].remove(at: 1)
                }
            }
            
            //
            intervalBellsDetail.text = "-"
            intervalBellsDetail.alpha = 1
        //
        case 2:
            //
            let count = (meditationArray[selectedPreset][2] as! [[Int]]).count - 1
            meditationArray[selectedPreset][2][count][0] = -1
            //
            endingBellDetail.text = "-"
            endingBellDetail.alpha = 1
        //
        case 3:
            //
            meditationArray[selectedPreset][3][0][0] = -1
            //
            backgroundSoundDetail.text = "-"
            backgroundSoundDetail.alpha = 1
        default: break
        }
        //
        defaults.set(meditationArray, forKey: "meditationTimer")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
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
        // Enable only if duration selected
        let defaults = UserDefaults.standard
        let meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        if meditationArray.count != 0 {
            if meditationArray[selectedPreset][1][0].count == 0 {
                print("thatsnotgonewell")
            } else if (meditationArray[selectedPreset][1][0][0] as! Int) == 0 {
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
    }
    
    
    
    //
    // Main Button Actions ----------------------------------------------------------------------------------------------------
    //
    
    // Prests
    @IBAction func presetsAction(_ sender: Any) {
        selectedItem = 0
        //
        self.duration.isEnabled = false
        self.startingBell.isEnabled = false
        self.intervalBells.isEnabled = false
        self.endingBell.isEnabled = false
        self.backgroundSound.isEnabled = false
        //
        presetsTableView.reloadData()
        //
        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: presetsTableView)
        //
        animateActionSheetUp(actionSheet: presetsTableView, actionSheetHeight: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88, backgroundView: backgroundViewSelection)
    }
    
    // Duration
    @IBAction func durationAction(_ sender: Any) {
        selectedItem = 1
        didChangeDuration = false
        //
        okButton.isEnabled = true
        //
        // View
        let selectionWidth = self.view.frame.size.width - 20
        let selectionHeight = CGFloat(147 + 49)
        //
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        selectionView.frame = CGRect(x: 10, y: view.frame.maxY, width: selectionWidth, height: selectionHeight)
        //
        // PickerView
        selectionView.addSubview(pickerViewDuration)
        self.pickerViewDuration.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height - 49)
        self.hoursLabel.center.y = self.pickerViewDuration.center.y
        self.minutesLabel.center.y = self.pickerViewDuration.center.y
        self.secondsLabel.center.y = self.pickerViewDuration.center.y
        //
        self.secondsLabel.center.x = self.pickerViewDuration.frame.minX + (self.pickerViewDuration.frame.size.width * (4.65/6))
        self.minutesLabel.center.x = self.pickerViewDuration.frame.minX + (self.pickerViewDuration.frame.size.width * (3.55/6))
        self.hoursLabel.center.x = self.pickerViewDuration.frame.minX + (self.pickerViewDuration.frame.size.width * (2.4/6))
        //
        // Select Rows if duration already set
        let defaults = UserDefaults.standard
        let meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        if meditationArray[selectedPreset][1][0].count != 0 {
            let hmsArray = convertToHMS(time: 0, index: 0)
            pickerViewDuration.selectRow(durationTimeArray[0].index(of: hmsArray[0])!, inComponent: 0, animated: true)
            pickerViewDuration.selectRow(durationTimeArray[1].index(of: hmsArray[1])!, inComponent: 1, animated: true)
            pickerViewDuration.selectRow(durationTimeArray[2].index(of: hmsArray[2])!, inComponent: 2, animated: true)
        }
        //
        selectionView.addSubview(durationTimeLabel)
        durationTimeLabel.textAlignment = .left
        self.durationTimeLabel.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: 22)
        // ok
        self.okButton.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
        selectionView.addSubview(okButton)
        //
        backgroundViewSelection.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: selectionView)
        backgroundViewSelection.frame = UIScreen.main.bounds
        // Animate fade and size
        // Position
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
    }
    
    // Starting Bell
    @IBAction func startingBellAction(_ sender: Any) {
        //
        okButton.isEnabled = true
        //
        if isDeleting == false {
            selectedItem = 2
            //
            selectedStartingBell = -1
            didChangeStartingBell = false
            tableViewBells.reloadData()
            //
            // View
            let selectionWidth = self.view.frame.size.width - 20
            let selectionHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: selectionWidth, height: selectionHeight)
            // Tableview
            selectionView.addSubview(tableViewBells)
            self.tableViewBells.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: selectionHeight - 49)
            // ok
            self.okButton.frame = CGRect(x: 0, y: selectionHeight - 49, width: self.selectionView.frame.size.width, height: 49)
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
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
                //
                self.backgroundViewSelection.alpha = 0.5
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
        okButton.isEnabled = true
        //
        if isDeleting == false {
            selectedItem = 3
            //
            selectedIntervalBell = -1
            didChangeIntervalBell = false
            intervalBellStage = 0
            tableViewIntervalBells.reloadData()
            //
            // View
            let selectionWidth = self.view.frame.size.width - 20
            let selectionHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: selectionWidth, height: selectionHeight)
            // Tableview
            selectionView.addSubview(tableViewIntervalBells)
            self.tableViewIntervalBells.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: selectionHeight - 49)
            // ok
            self.okButton.frame = CGRect(x: 0, y: selectionHeight - 49, width: self.selectionView.frame.size.width, height: 49)
            selectionView.addSubview(okButton)
            if selectedIntervalBell != -1 {
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
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
                //
                self.backgroundViewSelection.alpha = 0.5
                //
            }, completion: nil)
            
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
        okButton.isEnabled = true
        //
        if isDeleting == false {
            selectedItem = 4
            //
            selectedEndingBell = -1
            didChangeEndingBell = false
            tableViewBells.reloadData()
            //
            // View
            let selectionWidth = self.view.frame.size.width - 20
            let selectionHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: selectionWidth, height: selectionHeight)
            // Tableview
            selectionView.addSubview(tableViewBells)
            self.tableViewBells.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: selectionHeight - 49)
            // ok
            self.okButton.frame = CGRect(x: 0, y: selectionHeight - 49, width: self.selectionView.frame.size.width, height: 49)
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
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
                //
                self.backgroundViewSelection.alpha = 0.5
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
        okButton.isEnabled = true
        //
        if isDeleting == false {
            selectedItem = 5
            //
            selectedBackgroundSound = -1
            didChangeBackgroundSound = false
            tableViewBackgroundSounds.reloadData()
            //
            // View
            let selectionWidth = self.view.frame.size.width - 20
            let selectionHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: selectionWidth, height: selectionHeight)
            // Tableview
            selectionView.addSubview(tableViewBackgroundSounds)
            self.tableViewBackgroundSounds.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: selectionHeight - 49)
            // ok
            self.okButton.frame = CGRect(x: 0, y: selectionHeight - 49, width: self.selectionView.frame.size.width, height: 49)
            selectionView.addSubview(okButton)
            if selectedBackgroundSound != -1 {
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
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
                //
                self.backgroundViewSelection.alpha = 0.5
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
        //
        let defaults = UserDefaults.standard
        let meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        //
        // Test all for nil
        if meditationArray.count != 0 {
            
            // Title
            // []0 = names, [0] = name array, [0] = name --> array due to interval bells needing to be in arrays, though only 1 value in name, duration, background sounds arrays
            presetsDetail.text = meditationArray[selectedPreset][0][0][0] as? String
            // Duration
            // [1] = duration array, [0] = duration (as in array)
            if (meditationArray[selectedPreset][1][0] as! [Int]).count != 0 && (meditationArray[selectedPreset][1][0][0] as! Int) != 0 {
                let hmsArray = convertToHMS(time: 0, index: 0)
                durationDetail.text = String(hmsArray[0]) + "h " + String(hmsArray[1]) + "m " + String(hmsArray[2]) + "s"
            } else {
                durationDetail.text = "-"
            }
            //
            // Starting Bell
            // [2] = bells array, .first = starting bell, [0] = bell
            let startingBell = meditationArray[selectedPreset][2].first![0] as! Int
            if startingBell != -1 {
                startingBellDetail.text = NSLocalizedString(bellsArray[startingBell], comment: "")
            } else {
                startingBellDetail.text = "-"
            }
            //
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset][2] as! [[Int]]
            // Remove starting and ending bell
            intervalBellsArray.removeFirst()
            intervalBellsArray.removeLast()
            if intervalBellsArray.count != 0 {
                intervalBellsDetail.text = String(intervalBellsArray.count)
            } else {
                intervalBellsDetail.text = "-"
            }
            //
            // Ending Bells
            // [2] = bells array, .first = ending bell, [0] = bell
            let endingBell = meditationArray[selectedPreset][2].last![0] as! Int
            if endingBell != -1 {
                endingBellDetail.text = NSLocalizedString(bellsArray[endingBell], comment: "")
            } else {
                endingBellDetail.text = "-"
            }
            //
            // Background Sounds
            // [3] = bells array, [0] = background sound array, [0] = background sounds
            let backgroundSound = meditationArray[selectedPreset][3][0][0] as! Int
            if backgroundSound != -1 {
                backgroundSoundDetail.text = NSLocalizedString(backgroundSoundsArray[backgroundSound], comment: "")
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
        header.textLabel?.textColor = Colours.colour1
        header.contentView.backgroundColor = Colours.colour2
        header.contentView.tintColor = Colours.colour1
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaults = UserDefaults.standard
        let meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        
        switch tableView {
        case presetsTableView:
            // Retreive Preset Timers
            //            let presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
            return meditationArray.count + 1
        case tableViewBells:
            return bellsArray.count
        case tableViewIntervalBells:
            // Retreive Interval Bells
            //            let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset][2] as! [[Int]]
            // Remove starting and ending bell
            intervalBellsArray.removeFirst()
            intervalBellsArray.removeLast()
            return intervalBellsArray.count + 1
        case tableViewBackgroundSounds:
            return backgroundSoundsArray.count
        default: return 0
        }
        
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let defaults = UserDefaults.standard
        let meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        
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
            //            let presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
            //
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = Colours.colour1
            cell.textLabel?.textColor = Colours.colour2
            cell.tintColor = Colours.colour2
            //
            if indexPath.row == meditationArray.count {
                //
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
                //
            } else {
                //
                cell.textLabel?.text = meditationArray[indexPath.row][0][0][0] as? String
            }
        //
        case tableViewBells:
            //
            cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
            //
            //
            cell.textLabel?.text = NSLocalizedString(bellsArray[indexPath.row], comment: "")
            cell.imageView?.image = bellsImages[indexPath.row]
            //
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = Colours.colour2
            cell.textLabel?.textColor = Colours.colour1
            cell.tintColor = Colours.colour1
            //
            switch selectedItem {
            case 2:
                //
                //                let startingBellsArray = UserDefaults.standard.object(forKey: "meditationTimerStartingBells") as! [Int]
                // Interval Bells
                if didChangeStartingBell == false {
                    let startingBell = meditationArray[selectedPreset][2].first![0] as! Int
                    if startingBell != -1 {
                        selectedStartingBell = startingBell
                    }
                }
                //
                if indexPath.row == selectedStartingBell {
                    cell.textLabel?.textColor = Colours.colour3
                    cell.accessoryType = .checkmark
                    cell.tintColor = Colours.colour3
                }
                //
                if selectedStartingBell != -1 {
                    okButton.isEnabled = true
                }
            case 3:
                //
                if indexPath.row == selectedIntervalBell {
                    cell.textLabel?.textColor = Colours.colour3
                    cell.accessoryType = .checkmark
                    cell.tintColor = Colours.colour3
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
                //                let endingBellsArray = UserDefaults.standard.object(forKey: "meditationTimerEndingBells") as! [Int]
                if didChangeEndingBell == false {
                    let endingBell = meditationArray[selectedPreset][2].last![0] as! Int
                    if endingBell != -1 {
                        selectedEndingBell = endingBell
                    }
                }
                //
                if indexPath.row == selectedEndingBell {
                    cell.textLabel?.textColor = Colours.colour3
                    cell.accessoryType = .checkmark
                    cell.tintColor = Colours.colour3
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
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset][2] as! [[Int]]
            // Remove starting and ending bell
            intervalBellsArray.removeFirst()
            intervalBellsArray.removeLast()
            //
            // New Bell
            if indexPath.row == intervalBellsArray.count {
                cell.backgroundColor = Colours.colour2
                cell.textLabel?.textColor = Colours.colour1
                cell.tintColor = Colours.colour1
                cell.layer.borderColor = Colours.colour1.cgColor
                cell.layer.borderWidth = 1
                //
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                cell.imageView?.tintColor = Colours.colour1
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
                // Bells Rows
            } else {
                cell.backgroundColor = Colours.colour2
                cell.textLabel?.textColor = Colours.colour1
                cell.tintColor = Colours.colour1
                //
                let timesArray = convertToHMS(time: 1, index: indexPath.row)
                cell.detailTextLabel?.text = String(timesArray[0]) + "h " + String(timesArray[1]) + "m " + String(timesArray[2]) + "s"
                //
                cell.detailTextLabel?.textColor = Colours.colour1
                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
                //
                cell.textLabel?.text = NSLocalizedString(bellsArray[intervalBellsArray[indexPath.row][0]], comment: "")
                cell.imageView?.image = bellsImages[intervalBellsArray[indexPath.row][0]]
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
            cell.backgroundColor = Colours.colour2
            cell.textLabel?.textColor = Colours.colour1
            cell.tintColor = Colours.colour1
            //
            //            let selectedBackgroundSoundsArray = UserDefaults.standard.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
            if didChangeBackgroundSound == false {
                let chosenBackgroundSound = meditationArray[selectedPreset][3][0][0] as! Int
                if chosenBackgroundSound != -1 {
                    selectedBackgroundSound = chosenBackgroundSound
                }
            }
            //
            if indexPath.row == selectedBackgroundSound {
                cell.textLabel?.textColor = Colours.colour3
                cell.accessoryType = .checkmark
                cell.tintColor = Colours.colour3
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
        let defaults = UserDefaults.standard
        let meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        
        switch tableView {
        case presetsTableView:
            return 44
        case tableViewIntervalBells:
            //            let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset][2] as! [[Int]]
            // Remove starting and ending bell
            intervalBellsArray.removeFirst()
            intervalBellsArray.removeLast()
            if indexPath.row == intervalBellsArray.count {
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
        let defaults = UserDefaults.standard
        var meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        //
        switch tableView {
        case presetsTableView:
            // Retreive Preset Timers
            //            var presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
            // Add Custom Meditation
            if indexPath.row == meditationArray.count {
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
                alert.view.tintColor = Colours.colour2
                alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
                //2. Add the text field
                alert.addTextField { (textField: UITextField) in
                    textField.text = " "
                    textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
                    textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
                }
                // 3. Get the value from the text field, and perform actions upon OK press
                okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    //
                    let textField = alert?.textFields![0]
                    //
                    // New empty session array
                    var newSession = Register.meditationEmptySession
                    // Update name
                    newSession[0][0].append((textField?.text)!)
                    meditationArray.append(newSession)
                    //
                    defaults.set(meditationArray, forKey: "meditationTimer")
                    // Sync
                    ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                    
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
                        //                        let presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
                        //
                        let selectedIndexPath = NSIndexPath(row: meditationArray.count - 1, section: 0)
                        self.presetsTableView.selectRow(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
                        self.selectedPreset = selectedIndexPath.row
                        //
                        self.presetsDetail.text = meditationArray[self.selectedPreset][0][0][0] as? String
                        //
                        tableView.deselectRow(at: indexPath, animated: true)
                        
                        //
                        // Dismiss Table
                        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                            self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.view.frame.size.width - 20, height: self.presetsTableView.frame.size.height)
                            self.backgroundViewSelection.alpha = 0
                        }, completion: { finished in
                            //
                            self.presetsTableView.removeFromSuperview()
                            self.backgroundViewSelection.removeFromSuperview()
                        })
                        //
                        // Animate up new elements
                        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
                //                let presetsArray = UserDefaults.standard.object(forKey: "meditationTimerTitles") as! [String]
                //
                presetsDetail.text = meditationArray[selectedPreset][0][0][0] as? String
                //
                tableView.deselectRow(at: indexPath, animated: true)
                // Dismiss Table
                if meditationArray.count != 0 {
                    //
                    // Dismiss Table
                    UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                        self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.view.frame.size.width - 20, height: self.presetsTableView.frame.size.height)
                        self.backgroundViewSelection.alpha = 0
                    }, completion: { finished in
                        //
                        self.presetsTableView.removeFromSuperview()
                        self.backgroundViewSelection.removeFromSuperview()
                    })
                    //
                    // Animate up new elements
                    UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
                        self.duration.isEnabled = true
                        self.startingBell.isEnabled = true
                        self.intervalBells.isEnabled = true
                        self.endingBell.isEnabled = true
                        self.backgroundSound.isEnabled = true
                        self.isDurationSelected()
                    })
                }
                //
                updateRows()
            }
        //
        case tableViewBells:
            //
            okButton.isEnabled = true
            //
            let url = Bundle.main.url(forResource: bellsArray[indexPath.row], withExtension: "caf")!
            //
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
            tableViewBells.deselectRow(at: indexPath, animated: true)
            tableViewBells.reloadData()
            
        //
        case tableViewIntervalBells:
            //
            okButton.isEnabled = true
            //
            //            var intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            //
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset][2] as! [[Int]]
            // Remove starting and ending bell
            intervalBellsArray.removeFirst()
            intervalBellsArray.removeLast()
            //
            if indexPath.row == intervalBellsArray.count {
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
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    //
                    let selectionWidth = self.view.frame.size.width - 20
                    let selectionHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
                    self.selectionView2.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
                    //
                    self.selectionView2.alpha = 1
                    //
                    // ok
                    self.tableViewBells.frame = CGRect(x: 0, y: 0, width: self.selectionView2.frame.size.width, height: selectionHeight - 49)
                    // ok
                    self.okButton2.frame = CGRect(x: 0, y: selectionHeight - 49, width: self.selectionView2.frame.size.width, height: 49)
                    //
                    self.selectionView2.alpha = 1
                    //
                }, completion: nil)
                //
                tableViewIntervalBells.deselectRow(at: indexPath, animated: true)
            }
            
        case tableViewBackgroundSounds:
            //
            okButton.isEnabled = true
            //
            let url = Bundle.main.url(forResource: backgroundSoundsArray[indexPath.row], withExtension: "caf")!
            //
            do {
                let bell = try AVAudioPlayer(contentsOf: url)
                soundPlayer = bell
                soundPlayer.numberOfLoops = -1
                bell.play()
            } catch {
                // couldn't load file :(
            }
            //
            selectedBackgroundSound = indexPath.row
            didChangeBackgroundSound = true
            //
            tableViewBackgroundSounds.deselectRow(at: indexPath, animated: true)
            tableViewBackgroundSounds.reloadData()
        default: break
        }
    }
    
    // Custom Meditation Action
    @objc func textChanged(_ sender: UITextField) {
        if sender.text == "" {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    
    // Edit Rows
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let defaults = UserDefaults.standard
        let meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        //
        switch tableView {
        case presetsTableView:
            // Retreive Preset Timers
            var returnValue = Bool()
            if indexPath.row < meditationArray.count {
                returnValue = true
            }
            return returnValue
        //
        case tableViewIntervalBells:
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset][2] as! [[Int]]
            // Remove starting and ending bell
            intervalBellsArray.removeFirst()
            intervalBellsArray.removeLast()
            var returnValue = Bool()
            if indexPath.row < intervalBellsArray.count {
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
        let defaults = UserDefaults.standard
        var meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        //
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            //
            switch tableView{
            //
            case presetsTableView:
                //
                // Remove session
                meditationArray.remove(at: indexPath.row)
                defaults.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                //
                UIView.animate(withDuration: 0.2, animations: {
                    self.presetsTableView.reloadData()
                })
                
                //
                if meditationArray.count != 0 {
                    if selectedPreset == meditationArray.count {
                        selectedPreset = selectedPreset - 1
                    }
                } else {
                    selectedPreset = 0
                }
                //
                updateRows()
                // If no more meditations
                if meditationArray.count == 0 {
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
                // Remove Bell
                // [2] = bells, indexPath.row + 1 because array contains starting bell as well in position 0, therefore interval bells begin at 1 not 0
                meditationArray[selectedPreset][2].remove(at: indexPath.row + 1)
                defaults.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
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
        label.textColor = Colours.colour1
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
        if convertToSeconds() == 0 {
            okButton.isEnabled = false
        } else {
            okButton.isEnabled = true
            didChangeDuration = true
        }
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
        let defaults = UserDefaults.standard
        let meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        //
        var hmsArray: [Int] = []
        //
        switch time {
        case 0:
            //
            // Time in seconds (duration)
            // [1] = duration array
            let timeInSeconds = meditationArray[selectedPreset][1][0][0] as! Int
            //
            let hours = Int(timeInSeconds / 3600)
            hmsArray.append(hours)
            //
            let minutes = Int((timeInSeconds % 3600) / 60)
            hmsArray.append(minutes)
            //
            let seconds = Int(timeInSeconds % 60)
            hmsArray.append(seconds)
        //
        case 1:
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset][2] as! [[Int]]
            // Remove starting and ending bell
            intervalBellsArray.removeFirst()
            intervalBellsArray.removeLast()
            // [1] = time
            let hours = Int(intervalBellsArray[index][1] / 3600)
            hmsArray.append(hours)
            //
            let minutes = Int((intervalBellsArray[index][1]  % 3600) / 60)
            hmsArray.append(minutes)
            //
            let seconds = Int(intervalBellsArray[index][1]  % 60)
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
        let defaults = UserDefaults.standard
        let meditationArray = defaults.object(forKey: "meditationTimer") as! [[[[Any]]]]
        //
        if meditationArray[selectedPreset][1][0].count != 0 && meditationArray[selectedPreset][1][0][0] as! Int != 0 {
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
            alert.view.tintColor = Colours.colour2
            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-Light", size: 20)!]), forKey: "attributedTitle")
            alert.setValue(NSAttributedString(string: inputMessage, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 17)!]), forKey: "attributedMessage")
            
            //
            okAction = UIAlertAction(title: "Ok", style: .default) {
                UIAlertAction in
            }
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
            //
            destinationVC.fromSchedule = comingFromSchedule
        }
    }
    
}

