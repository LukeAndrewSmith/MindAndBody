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

    // Arrays
    // Bells Arrays
    var bellsArray: [String] = []
    var bellsImages: [UIImage] = []
 
    // Background Sounds Array
    var backgroundSoundsArray: [String] = []
    var backgroundSoundsImages: [UIImage] = []
    
    // Duration Array
    var durationTimeArray: [[Int]] = []
    
    // Selected Preset
    var selectedPreset = Int()
    
    var creatingSession = false
    
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
    
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!

    // Main Buttons
    //
    @IBOutlet weak var presets: UIButton!
    @IBOutlet weak var presetsDetail: UILabel!
    
    //
    @IBOutlet weak var duration: UIButton!
    @IBOutlet weak var durationDetail: UILabel!
    //
    @IBOutlet weak var startingBell: UIButton!
    @IBOutlet weak var startingBellImage: UIImageView!
    @IBOutlet weak var startingBellNone: UILabel!
    //
    @IBOutlet weak var intervalBells: UIButton!
    @IBOutlet weak var intervalBellsDetail: UILabel!
    //
    @IBOutlet weak var endingBell: UIButton!
    @IBOutlet weak var endingBellImage: UIImageView!
    @IBOutlet weak var endingBellNone: UILabel!
    //
    @IBOutlet weak var backgroundSound: UIButton!
    @IBOutlet weak var backgroundSoundImage: UIImageView!
    @IBOutlet weak var backgroundSoundNone: UILabel!
    
    var selectedButton = Int()
    
    //
    var deleteButton = UIButton()
    
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
    let separatorLine = UIVisualEffectView()
    
    // Selection Items
    let selectionView = UIView()
    let okButton = UIButton()
    let noneButton = UIButton()
    //
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

    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar
        // Title
        // Creating
        if creatingSession {
            navigationBar.title = NSLocalizedString("create", comment: "")
            // Editing
        } else {
            navigationBar.title = NSLocalizedString("edit", comment: "")
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBar!]
        // Appearance
        self.navigationController?.navigationBar.tintColor = Colors.light
        self.navigationController?.navigationBar.barTintColor = Colors.dark
        // Done button
        navigationBar.leftBarButtonItem?.tintColor = Colors.light
        navigationBar.leftBarButtonItem?.title = NSLocalizedString("done", comment: "")
        navigationBar.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBarButton!], for: .normal)
        
        
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: false)
        
        
        let cornerRadius: CGFloat = 22
        let titleFont = UIFont(name: "SFUIDisplay-light", size: 20)
        let detailFont = UIFont(name: "SFUIDisplay-light", size: 19)
        //
        presets.setTitle(NSLocalizedString("name", comment: ""), for: .normal)
        presets.titleLabel?.font = titleFont
        presets.layer.cornerRadius = cornerRadius
        presets.layer.masksToBounds = true
        presets.contentHorizontalAlignment = .left
        presets.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        //
        let presetBlurE = UIBlurEffect(style: .dark)
        presetBlur.effect = presetBlurE
        presetBlur.isUserInteractionEnabled = false
        presetBlur.layer.cornerRadius = cornerRadius
        presetBlur.layer.masksToBounds = true
        view.insertSubview(presetBlur, belowSubview: presets)
        
        
        // Buttons
        // Duration
        duration.setTitle(NSLocalizedString("duration", comment: ""), for: .normal)
        duration.titleLabel?.font = titleFont
        duration.contentHorizontalAlignment = .left
        duration.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        duration.layer.cornerRadius = cornerRadius
        duration.layer.masksToBounds = true
        //
        durationDetail.font = detailFont
        //
        didChangeDuration = false
        
        // Starting Bell
        startingBell.setTitle(NSLocalizedString("startingBell", comment: ""), for: .normal)
        startingBell.titleLabel?.font = titleFont
        startingBell.contentHorizontalAlignment = .left
        startingBell.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        startingBell.layer.cornerRadius = cornerRadius
        startingBell.layer.masksToBounds = true
        //
        startingBellNone.font = detailFont
        startingBellNone.text = "-"
        //
        selectedStartingBell = -1
        didChangeStartingBell = false
        
        // Interval Bells
        intervalBells.setTitle(NSLocalizedString("intervalBells", comment: ""), for: .normal)
        intervalBells.titleLabel?.font = titleFont
        intervalBells.contentHorizontalAlignment = .left
        intervalBells.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        intervalBells.layer.cornerRadius = cornerRadius
        intervalBells.layer.masksToBounds = true
        //
        intervalBellsDetail.font = detailFont
        //
        selectedIntervalBell = -1
        didChangeIntervalBell = false
        intervalBellStage = 0
        
        // Ending Bell
        endingBell.setTitle(NSLocalizedString("endingBell", comment: ""), for: .normal)
        endingBell.titleLabel?.font = titleFont
        endingBell.contentHorizontalAlignment = .left
        endingBell.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        endingBell.layer.cornerRadius = cornerRadius
        endingBell.layer.masksToBounds = true
        //
        endingBellNone.font = detailFont
        endingBellNone.text = "-"
        //
        selectedEndingBell = -1
        didChangeEndingBell = false
        
        // Background Sound
        backgroundSound.setTitle(NSLocalizedString("backgroundSound", comment: ""), for: .normal)
        backgroundSound.titleLabel?.font = titleFont
        backgroundSound.contentHorizontalAlignment = .left
        backgroundSound.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        backgroundSound.layer.cornerRadius = cornerRadius
        backgroundSound.layer.masksToBounds = true
        //
        backgroundSoundNone.font = detailFont
        backgroundSoundNone.text = "-"
        
        // Colours
        // Background Index
        //
        // Title Colours and Blurs
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let backgroundIndex = settings["BackgroundImage"]![0]
        switch backgroundIndex {
        // All Black, white presets
        case 1,2,3,5,6, BackgroundImages.backgroundImageArray.count:
            presets.setTitleColor(Colors.light, for: .normal)
            presetsDetail.textColor = Colors.light
            duration.setTitleColor(Colors.dark, for: .normal)
            durationDetail.textColor = Colors.dark
            startingBell.setTitleColor(Colors.dark, for: .normal)
            intervalBells.setTitleColor(Colors.dark, for: .normal)
            intervalBellsDetail.textColor = Colors.dark
            endingBell.setTitleColor(Colors.dark, for: .normal)
            backgroundSound.setTitleColor(Colors.dark, for: .normal)
            //
            startingBellNone.textColor = Colors.dark
            endingBellNone.textColor = Colors.dark
            backgroundSoundNone.textColor = Colors.dark
        // All White
        case 0,4:
            presets.setTitleColor(Colors.light, for: .normal)
            presetsDetail.textColor = Colors.light
            duration.setTitleColor(Colors.light, for: .normal)
            durationDetail.textColor = Colors.light
            startingBell.setTitleColor(Colors.light, for: .normal)
            intervalBells.setTitleColor(Colors.light, for: .normal)
            intervalBellsDetail.textColor = Colors.light
            endingBell.setTitleColor(Colors.light, for: .normal)
            backgroundSound.setTitleColor(Colors.light, for: .normal)
            //
            startingBellNone.textColor = Colors.light
            endingBellNone.textColor = Colors.light
            backgroundSoundNone.textColor = Colors.light
        //
        default: break
        }
        
        
        //
        let blurE = UIBlurEffect(style: .regular)
        blur.effect = blurE
        blur.isUserInteractionEnabled = false
        blur.layer.cornerRadius = cornerRadius
        blur.layer.masksToBounds = true
        view.insertSubview(blur, belowSubview: startingBell)
        //
        let blur1E = UIBlurEffect(style: .regular)
        blur1.effect = blur1E
        blur1.isUserInteractionEnabled = false
        blur1.layer.cornerRadius = cornerRadius
        blur1.layer.masksToBounds = true
        view.insertSubview(blur1, belowSubview: duration)
        //
        let blur2E = UIBlurEffect(style: .regular)
        blur2.effect = blur2E
        blur2.isUserInteractionEnabled = false
        blur2.layer.cornerRadius = cornerRadius
        blur2.layer.masksToBounds = true
        view.insertSubview(blur2, belowSubview: backgroundSound)
        //
        let blur3E = UIBlurEffect(style: .regular)
        blur3.effect = blur3E
        blur3.isUserInteractionEnabled = false
        blur3.layer.cornerRadius = cornerRadius
        blur3.layer.masksToBounds = true
        view.insertSubview(blur3, belowSubview: intervalBells)
        //
        let blur4E = UIBlurEffect(style: .regular)
        blur4.effect = blur4E
        blur4.isUserInteractionEnabled = false
        blur4.layer.cornerRadius = cornerRadius
        blur4.layer.masksToBounds = true
        view.insertSubview(blur4, belowSubview: endingBell)
        
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
        deleteButton.backgroundColor = Colors.red
        deleteButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 19)
        
        // Duration Picker
        pickerViewDuration.backgroundColor = Colors.dark
        pickerViewDuration.delegate = self
        pickerViewDuration.dataSource = self
        
        
        // Bells Table
        let tableViewBackground3 = UIView()
        //
        tableViewBackground3.backgroundColor = Colors.dark
        tableViewBackground3.frame = CGRect(x: 0, y: 0, width: self.tableViewBells.frame.size.width, height: self.tableViewBells.frame.size.height)
        //
        tableViewBells.backgroundView = tableViewBackground3
        tableViewBells.tableFooterView = UIView()
        tableViewBells.backgroundColor = Colors.dark
        tableViewBells.delegate = self
        tableViewBells.dataSource = self
        tableViewBells.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewBells.layer.cornerRadius = 15
        tableViewBells.layer.masksToBounds = true
        //
        
        // Interval Bells Table
        let tableViewBackground4 = UIView()
        //
        tableViewBackground4.backgroundColor = Colors.dark
        tableViewBackground4.frame = CGRect(x: 0, y: 0, width: self.tableViewIntervalBells.frame.size.width, height: self.tableViewIntervalBells.frame.size.height)
        //
        tableViewIntervalBells.backgroundView = tableViewBackground4
        tableViewIntervalBells.tableFooterView = UIView()
        tableViewIntervalBells.backgroundColor = Colors.dark
        tableViewIntervalBells.delegate = self
        tableViewIntervalBells.dataSource = self
        tableViewIntervalBells.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewIntervalBells.layer.cornerRadius = 15
        tableViewIntervalBells.layer.masksToBounds = true
        //tableViewIntervalBells.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        // Background Sounds Table View
        let tableViewBackground5 = UIView()
        //
        tableViewBackground5.backgroundColor = Colors.dark
        tableViewBackground5.frame = CGRect(x: 0, y: 0, width: self.tableViewBackgroundSounds.frame.size.width, height: self.tableViewBackgroundSounds.frame.size.height)
        //
        tableViewBackgroundSounds.backgroundView = tableViewBackground5
        tableViewBackgroundSounds.tableFooterView = UIView()
        // TableView Cell action items
        //
        tableViewBackgroundSounds.backgroundColor = Colors.dark
        tableViewBackgroundSounds.delegate = self
        tableViewBackgroundSounds.dataSource = self
        tableViewBackgroundSounds.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewBackgroundSounds.layer.cornerRadius = 15
        tableViewBackgroundSounds.layer.masksToBounds = true
        //tableViewBackgroundSounds.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        
        // Interval Times Picker
        pickerViewIntervalTimes.backgroundColor = Colors.dark
        pickerViewIntervalTimes.delegate = self
        pickerViewIntervalTimes.dataSource = self
        
        
        //
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        updateRows()
    }

    // View Did Dissapear
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Picker Labels
        hoursLabel.textAlignment = .center
        hoursLabel.textColor = Colors.light
        hoursLabel.text = "h"
        hoursLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        hoursLabel.numberOfLines = 1
        hoursLabel.sizeToFit()
        hoursLabel.center.y = pickerViewDuration.center.y
        hoursLabel.center.x = pickerViewDuration.frame.minX + (pickerViewDuration.frame.size.width * (2.4/6))
        pickerViewDuration.addSubview(hoursLabel)
        //
        minutesLabel.textAlignment = .center
        minutesLabel.textColor = Colors.light
        minutesLabel.text = "m"
        minutesLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        minutesLabel.numberOfLines = 1
        minutesLabel.sizeToFit()
        minutesLabel.center.y = pickerViewDuration.center.y
        minutesLabel.center.x = pickerViewDuration.frame.minX + (pickerViewDuration.frame.size.width * (3.55/6))
        pickerViewDuration.addSubview(minutesLabel)
        //
        secondsLabel.textAlignment = .center
        secondsLabel.textColor = Colors.light
        secondsLabel.text = "s"
        secondsLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        secondsLabel.numberOfLines = 1
        secondsLabel.sizeToFit()
        secondsLabel.center.y = pickerViewDuration.center.y
        secondsLabel.center.x = pickerViewDuration.frame.minX + (pickerViewDuration.frame.size.width * (4.65/6))
        pickerViewDuration.addSubview(secondsLabel)
        //
        
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
        
        // separator
        let height = duration.frame.minY - presets.frame.maxY
        let separatorEffect = UIBlurEffect(style: .regular)
        separatorLine.effect = separatorEffect
        separatorLine.isUserInteractionEnabled = false
        separatorLine.frame = CGRect(x: 11, y: presets.frame.maxY + (height / 2), width: view.frame.size.width - 22, height: 1)
        separatorLine.layer.cornerRadius = 0.5
        separatorLine.layer.masksToBounds = true
        view.insertSubview(separatorLine, aboveSubview: backgroundBlur)
        
        //
        // Selection Elements
        // view
        selectionView.backgroundColor = Colors.dark
        selectionView.layer.cornerRadius = 15
        selectionView.layer.masksToBounds = true
        // ok
        okButton.backgroundColor = Colors.light
        okButton.setTitleColor(Colors.green, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        //
        noneButton.backgroundColor = Colors.light
        noneButton.setTitleColor(Colors.green, for: .normal)
        noneButton.setTitle(NSLocalizedString("none", comment: ""), for: .normal)
        noneButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        noneButton.layer.cornerRadius = noneButton.bounds.height / 2
        noneButton.clipsToBounds = true
        noneButton.addTarget(self, action: #selector(noneButtonAction), for: .touchUpInside)
        //
        selectionView.addSubview(okButton)
        //
        durationTimeLabel.textColor = Colors.light
        durationTimeLabel.font = UIFont(name: "SFUIDisplay-thin", size: 17)
        durationTimeLabel.text = "  " + NSLocalizedString("duration", comment: "")
        
        // view2
        selectionView2.backgroundColor = Colors.dark
        selectionView2.layer.cornerRadius = 15
        selectionView2.layer.masksToBounds = true
        //
        intervalBellTimeLabel.textColor = Colors.light
        intervalBellTimeLabel.font = UIFont(name: "SFUIDisplay-thin", size: 17)
        intervalBellTimeLabel.text = " " + NSLocalizedString("bellTime", comment: "")
        // ok2
        okButton2.backgroundColor = Colors.light
        okButton2.setTitleColor(Colors.green, for: .normal)
        okButton2.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton2.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton2.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        //
    }
    
    
    //
    // Selection Related actions ------------------------------------------------------------------------------------------------
    //
    // Add movement table background (dismiss table)
    @objc func backgroundViewSelectionAction(_ sender: Any) {
        //
        updateRows()
        //
        //
        ActionSheet.shared.animateActionSheetDown()
        
        // Extra
        switch selectedItem {
        case 0: break // OK button not used
        case 1:
            break
        case 2:
            //
            if BellPlayer.shared.bellPlayer != nil {
                if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                    BellPlayer.shared.bellPlayer?.stop()
                }
            }
        case 3:
            //
            if BellPlayer.shared.bellPlayer != nil {
                if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                    BellPlayer.shared.bellPlayer?.stop()
                }
            }
        //
        case 4:
            //
            if BellPlayer.shared.bellPlayer != nil {
                if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                    BellPlayer.shared.bellPlayer?.stop()
                }
            }
        case 5:
            //
            if BellPlayer.shared.bellPlayer != nil {
                if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                    BellPlayer.shared.bellPlayer?.stop()
                }
            }
        default: break
        }
    }
    
    // Ok button action
    var bellToAdd = [-1, 0] // Interval bell to add
    //
    @objc func okButtonAction(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        var meditationArray = defaults.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
        //
        var removeView = false
        
        // Ok Actions
        switch selectedItem {
        // Presets
        case 0: break // OK button not used
        // Duration
        case 1:
            if didChangeDuration {
                //
                didChangeDuration = false
                //
                // Set new duration
                meditationArray[selectedPreset]["Duration"]?[0][0] = convertToSeconds()
                // Set ending bell time to duration
                let lastIndex = (meditationArray[selectedPreset]["Bells"] as! [[Int]]).count - 1
                meditationArray[selectedPreset]["Bells"]?[lastIndex][1] = convertToSeconds()
                //
                UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                
                // Change duration button detail text label
                let hmsArray = convertToHMS(time: 0, index: 0)
                durationDetail.text = String(hmsArray[0]) + "h " + String(hmsArray[1]) + "m " + String(hmsArray[2]) + "s"
                //
                // Check if interval bells should be removed (if new duration is shorter than old, there might be some interval bells that are after the end time and that should be removed)
                // > 2 because starting and ending bells included in array
                if (meditationArray[selectedPreset]["Bells"] as! [[Int]]).count > 2 {
                    removeIntervalBells()
                }
            }
            //
            removeView = true
        // Starting Bell
        case 2:
            if didChangeStartingBell {
                //
                didChangeStartingBell = false
                //
                if BellPlayer.shared.bellPlayer != nil {
                    if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                        BellPlayer.shared.bellPlayer?.stop()
                    }
                }
                //
                // Change Starting Bell
                meditationArray[selectedPreset]["Bells"]?[0][0] = selectedStartingBell
                //
                UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                //
                startingBellImage.image = bellsImages[selectedStartingBell]
                startingBellNone.alpha = 0
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
                if BellPlayer.shared.bellPlayer != nil {
                    if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                        BellPlayer.shared.bellPlayer?.stop()
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
                if BellPlayer.shared.bellPlayer != nil {
                    if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                        BellPlayer.shared.bellPlayer?.stop()
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
//                ActionSheet.shared.actionSheetBackgroundView.isHidden = true
                //
                // PickerView
                selectionView2.addSubview(pickerViewDuration)
                pickerViewDuration.frame = CGRect(x: selectionView2.frame.maxX, y: 0, width: 0, height: selectionView2.frame.size.height - 49)
                //
                //
                selectionView2.addSubview(intervalBellTimeLabel)
                intervalBellTimeLabel.textAlignment = .left
                //
                // iPhone X
                var toMinus = CGFloat()
                if IPhoneType.shared.iPhoneType() == 2 {
                    toMinus = 10 + ControlBarHeights.homeIndicatorHeight
                } else {
                    toMinus = 10
                }
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
                    self.selectionView2.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - toMinus, width: selectionWidth, height: selectionHeight)
                    //
                    self.intervalBellTimeLabel.frame = CGRect(x: 0, y: 0, width: self.selectionView2.frame.size.width, height: 22)
                    //
                    self.tableViewBells.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - toMinus, width: selectionWidth, height: selectionHeight)
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
                let count = (meditationArray[selectedPreset]["Bells"] as! [[Int]]).count - 2
                if count > 0 {
                    // If biggest
                    if bellToAdd[1] > meditationArray[selectedPreset]["Bells"]?[count][1] as! Int {
                        meditationArray[selectedPreset]["Bells"]?.insert(bellToAdd, at: count)
                    } else {
                        // Else find spoty
                        for i in 1...count {
                            // If new time < i time, add at i
                            if bellToAdd[1] < meditationArray[selectedPreset]["Bells"]?[i][1] as! Int {
                                meditationArray[selectedPreset]["Bells"]?.insert(bellToAdd, at: i)
                                break
                            }
                        }
                    }
                    // No intervals yet -> insert between starting and ending thus at 1
                } else {
                    meditationArray[selectedPreset]["Bells"]?.insert(bellToAdd, at: 1)
                }
                //
                UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                
                //
                removeView = false
                
                //
                ActionSheet.shared.actionSheetBackgroundView.center.x += 2 * view.bounds.width
                ActionSheet.shared.actionSheet.isHidden = false
                ActionSheet.shared.cancelButton.isHidden = false
                
                // Position
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    //
                    ActionSheet.shared.actionSheetBackgroundView.center.x -= self.view.bounds.width
                    self.backgroundViewSelection2.center.x -= self.view.bounds.width
                    //
                    self.selectionView2.center.x -= self.view.bounds.width
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
                    //
                    ActionSheet.shared.actionSheetBackgroundView.isEnabled = true
                })
                
            default: break
            }
        // Ending Bell
        case 4:
            if didChangeEndingBell {
                //
                didChangeEndingBell = false
                //
                if BellPlayer.shared.bellPlayer != nil {
                    if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                        BellPlayer.shared.bellPlayer?.stop()
                    }
                }
                //
                // .last = ending bell, [0] = bell
                let lastIndex = (meditationArray[selectedPreset]["Bells"] as! [[Int]]).count - 1
                meditationArray[selectedPreset]["Bells"]?[lastIndex][0] = selectedEndingBell
                //
                UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                //
                endingBellImage.image = bellsImages[selectedEndingBell]
                endingBellNone.alpha = 0
                //
                selectedEndingBell = -1
                //
            }
            //
            removeView = true
        // Background Sound
        case 5:
            if didChangeBackgroundSound {
                //
                didChangeBackgroundSound = false
                //
                if BellPlayer.shared.bellPlayer != nil {
                    if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                        BellPlayer.shared.bellPlayer?.stop()
                    }
                }
                //
                // [3] = background sound
                meditationArray[selectedPreset]["BackgroundSound"]?[0][0] = selectedBackgroundSound
                //
                UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
                //
                backgroundSoundImage.image = backgroundSoundsImages[selectedBackgroundSound]
                backgroundSoundNone.alpha = 0
                //
                selectedBackgroundSound = -1
                //
            }
            removeView = true
        default: break
        }
        
        //
        // Remove View
        if removeView {
            //
            ActionSheet.shared.animateActionSheetDown()
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
        var meditationArray = defaults.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
        //
        // 1 as interval bells start at 1 (starting bell = 0)
        for i in 1...(meditationArray[selectedPreset]["Bells"] as! [[Int]]).count - 2 {
            // If time > duration -> remove bell
            if meditationArray[selectedPreset]["Bells"]?[i][1] as! Int > meditationArray[selectedPreset]["Duration"]?[0][0] as! Int {
                meditationArray[selectedPreset]["Bells"]?.remove(at: i)
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
            let buttonDetailArray: [Any] = [startingBellImage, intervalBellsDetail, endingBellImage, backgroundSoundImage]
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
            //
            // Label
            if buttonTag == 1 {
                (buttonDetailArray[buttonTag!] as! UILabel).alpha = 0
            // Image
            } else {
                (buttonDetailArray[buttonTag!] as! UIImageView).alpha = 0
            }
        }
    }
    
    @objc func noneButtonAction() {
        var meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
        // Set Nil
        switch deleteTag {
        // Starting Bell
        case 0:
            //
            meditationArray[selectedPreset]["Bells"]?[0][0] = -1
            //
            startingBellImage.image = nil
            startingBellImage.alpha = 1
            startingBellNone.alpha = 1
        //
        case 1:
            //
            // 1 as interval bells start at 1 (starting bell = 0)
            let count = (meditationArray[selectedPreset]["Bells"] as! [[Int]]).count - 2
            if count > 0 {
                // Remove all interval bells
                for _ in 1...count {
                    // If new time < i time, add at i
                    meditationArray[selectedPreset]["Bells"]?.remove(at: 1)
                }
            }
            
            //
            intervalBellsDetail.text = "-"
            intervalBellsDetail.alpha = 1
        //
        case 2:
            //
            let count = (meditationArray[selectedPreset]["Bells"] as! [[Int]]).count - 1
            meditationArray[selectedPreset]["Bells"]?[count][0] = -1
            //
            endingBellImage.image = nil
            endingBellImage.alpha = 1
            endingBellNone.alpha = 1
        //
        case 3:
            //
            meditationArray[selectedPreset]["BackgroundSound"]?[0][0] = -1
            //
            backgroundSoundImage.image = nil
            backgroundSoundImage.alpha = 1
            backgroundSoundNone.alpha = 1
        default: break
        }
        //
        UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
        //
        ActionSheet.shared.animateActionSheetDown()
    }
    
    //
    @objc func deleteAction(_ sender: Any) {
        var meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
        // Set Nil
        switch deleteTag {
        // Starting Bell
        case 0:
            //
            meditationArray[selectedPreset]["Bells"]?[0][0] = -1
            //
            startingBellImage.image = nil
            startingBellImage.alpha = 1
            startingBellNone.alpha = 1
        //
        case 1:
            //
            // 1 as interval bells start at 1 (starting bell = 0)
            let count = (meditationArray[selectedPreset]["Bells"] as! [[Int]]).count - 2
            if count > 0 {
                // Remove all interval bells
                for _ in 1...count {
                    // If new time < i time, add at i
                    meditationArray[selectedPreset]["Bells"]?.remove(at: 1)
                }
            }
            
            //
            intervalBellsDetail.text = "-"
            intervalBellsDetail.alpha = 1
        //
        case 2:
            //
            let count = (meditationArray[selectedPreset]["Bells"] as! [[Int]]).count - 1
            meditationArray[selectedPreset]["Bells"]?[count][0] = -1
            //
            endingBellImage.image = nil
            endingBellImage.alpha = 1
            endingBellNone.alpha = 1
        //
        case 3:
            //
            meditationArray[selectedPreset]["BackgroundSound"]?[0][0] = -1
            //
            backgroundSoundImage.image = nil
            backgroundSoundImage.alpha = 1
            backgroundSoundNone.alpha = 1
        default: break
        }
        //
        UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
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
        })
    }
    //
    
    //
    // Check if duration option is completed ------------------------------------------------------------------------------
    //
    func isDurationSelected() -> Bool {
        //
        // Enable only if duration selected
                let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]

        if meditationArray.count != 0 {
            if meditationArray[selectedPreset]["Duration"]?[0].count == 0 {
                print("error")
            } else if (meditationArray[selectedPreset]["Duration"]?[0][0] as! Int) == 0 {
                return false
            } else {
                return true
            }
        }
        return false
    }
    
    
    //
    // Main Button Actions ----------------------------------------------------------------------------------------------------
    //
    
    // Prests
    @IBAction func presetsAction(_ sender: Any) {
        selectedItem = 0
        
        var meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
        
        // Alert for title and Functions
        let inputTitle = NSLocalizedString("meditationInputTitle", comment: "")
        //
        let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        //2. Add the text field
        alert.addTextField { (textField: UITextField) in
            textField.text = meditationArray[self.selectedPreset]["Name"]![0][0] as? String
            textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        }
        // 3. Get the value from the text field, and perform actions upon OK press
        okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { [weak alert] (_) in
            
            let textField = alert?.textFields![0]

            // Update name
            meditationArray[self.selectedPreset]["Name"]![0][0] = textField?.text!
            //
            UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
            
            self.presetsDetail.text = meditationArray[self.selectedPreset]["Name"]![0][0] as? String
        })
        okAction.isEnabled = false
        alert.addAction(okAction)
        // Cancel reset action
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alert.addAction(cancelAction)
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // Duration
    @IBAction func durationAction(_ sender: Any) {
        selectedItem = 1
        didChangeDuration = false
        //
        okButton.isEnabled = true
        //
        // View
        let selectionWidth = ActionSheet.shared.actionWidth
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
                let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]

        if meditationArray[selectedPreset]["Duration"]?[0].count != 0 {
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
        selectionView.frame = CGRect(x: 0, y: 0, width: selectionWidth, height: selectionHeight)
        //
        ActionSheet.shared.setupActionSheet()
        ActionSheet.shared.actionSheet.addSubview(selectionView)
        let heightToAdd = selectionView.bounds.height
        ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
        ActionSheet.shared.resetCancelFrame()
        ActionSheet.shared.animateActionSheetUp()
    }
    
    // Starting Bell
    @IBAction func startingBellAction(_ sender: Any) {
        //
        okButton.isEnabled = true
        //
        
        if isDeleting == false && isDurationSelected() {
            selectedItem = 2
            //
            selectedStartingBell = -1
            didChangeStartingBell = false
            tableViewBells.reloadData()
            //
            // View
            let selectionWidth = ActionSheet.shared.actionWidth
            let selectionHeight = ActionSheet.shared.actionTableHeight - 49 - 8
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
            noneButton.frame = CGRect(x: 0, y: selectionHeight + 10, width: selectionWidth, height: 49)
            noneButton.setTitle(NSLocalizedString("noStartingBell", comment: ""), for: .normal)
            noneButton.layer.cornerRadius = noneButton.bounds.height / 2
            //
            selectionView.frame = CGRect(x: 0, y: 0, width: selectionWidth, height: selectionHeight)
            //
            // Scroll to row
            let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
            if meditationArray[selectedPreset]["Bells"]?[0][0] as! Int != -1 {
                let indexPath = IndexPath(row: meditationArray[selectedPreset]["Bells"]?[0][0] as! Int, section: 0)
                tableViewBells.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            //
            ActionSheet.shared.setupActionSheet()
            ActionSheet.shared.actionSheet.addSubview(selectionView)
            ActionSheet.shared.actionSheet.addSubview(noneButton)
            let heightToAdd = selectionView.bounds.height + 10 + 49
            ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
            ActionSheet.shared.resetCancelFrame()
            ActionSheet.shared.animateActionSheetUp()
            
            // Remove Delete Button
        } else {
            isDeleting = false
            //
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.deleteButton.frame = CGRect(x: self.duration.frame.size.width, y: 0, width: 0, height: self.duration.frame.size.height)
                self.startingBellImage.alpha = 1
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
            })
        }
    }
    
    // Interval Bells
    @IBAction func intervalBellsAction(_ sender: Any) {
        //
        okButton.isEnabled = true
        //
        if isDeleting == false && isDurationSelected() {
            selectedItem = 3
            //
            selectedIntervalBell = -1
            didChangeIntervalBell = false
            intervalBellStage = 0
            tableViewIntervalBells.reloadData()
            //
            // View
            let selectionWidth = ActionSheet.shared.actionWidth
            let selectionHeight = ActionSheet.shared.actionTableHeight
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
            selectionView.frame = CGRect(x: 0, y: 0, width: selectionWidth, height: selectionHeight)
            //
            ActionSheet.shared.setupActionSheet()
            ActionSheet.shared.actionSheet.addSubview(selectionView)
            let heightToAdd = selectionView.bounds.height
            ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
            ActionSheet.shared.resetCancelFrame()
            ActionSheet.shared.animateActionSheetUp()
            
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
            })
        }
    }
    
    // Ending Bell
    @IBAction func endingBellAction(_ sender: Any) {
        //
        okButton.isEnabled = true
        //
        if isDeleting == false && isDurationSelected() {
            selectedItem = 4
            //
            selectedEndingBell = -1
            didChangeEndingBell = false
            tableViewBells.reloadData()
            //
            // View
            let selectionWidth = ActionSheet.shared.actionWidth
            let selectionHeight = ActionSheet.shared.actionTableHeight - 49 - 8
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
            noneButton.frame = CGRect(x: 0, y: selectionHeight + 10, width: selectionWidth, height: 49)
            noneButton.setTitle(NSLocalizedString("noEndingBell", comment: ""), for: .normal)
            noneButton.layer.cornerRadius = noneButton.bounds.height / 2
            //
            selectionView.frame = CGRect(x: 0, y: 0, width: selectionWidth, height: selectionHeight)
            //
            // Scroll to row
            let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
            // .last = ending bell, [0] = bell
            let lastIndex = (meditationArray[selectedPreset]["Bells"] as! [[Int]]).count - 1
            if meditationArray[selectedPreset]["Bells"]?[lastIndex][0] as! Int != -1 {
                let indexPath = IndexPath(row: meditationArray[selectedPreset]["Bells"]?[lastIndex][0] as! Int, section: 0)
                tableViewBells.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            //
            ActionSheet.shared.setupActionSheet()
            ActionSheet.shared.actionSheet.addSubview(selectionView)
            ActionSheet.shared.actionSheet.addSubview(noneButton)
            let heightToAdd = selectionView.bounds.height + 10 + 49
            ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
            ActionSheet.shared.resetCancelFrame()
            ActionSheet.shared.animateActionSheetUp()
            
            
            // Remove Delete Button
        } else {
            isDeleting = false
            //
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.deleteButton.frame = CGRect(x: self.duration.frame.size.width, y: 0, width: 0, height: self.duration.frame.size.height)
                self.endingBellImage.alpha = 1
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
            })
        }
    }
    
    // MARK: Background Sound
    @IBAction func backgroundSoundAction(_ sender: Any) {
        //
        okButton.isEnabled = true
        //
        if isDeleting == false && isDurationSelected() {
            selectedItem = 5
            //
            selectedBackgroundSound = -1
            didChangeBackgroundSound = false
            tableViewBackgroundSounds.reloadData()
            //
            // View
            let selectionWidth = ActionSheet.shared.actionWidth
            let selectionHeight = ActionSheet.shared.actionTableHeight - 49 - 8
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
            selectionView.frame = CGRect(x: 0, y: 0, width: selectionWidth, height: selectionHeight)
            //
            // Scroll to row
            let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
            // .last = ending bell, [0] = bell
            if meditationArray[selectedPreset]["BackgroundSound"]?[0][0] as! Int != -1 {
                let indexPath = IndexPath(row: meditationArray[selectedPreset]["BackgroundSound"]?[0][0] as! Int, section: 0)
                tableViewBells.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            //
            noneButton.frame = CGRect(x: 0, y: selectionHeight + 10, width: selectionWidth, height: 49)
            noneButton.setTitle(NSLocalizedString("noBackgroundSound", comment: ""), for: .normal)
            noneButton.layer.cornerRadius = noneButton.bounds.height / 2
            //
            ActionSheet.shared.setupActionSheet()
            ActionSheet.shared.actionSheet.addSubview(selectionView)
            ActionSheet.shared.actionSheet.addSubview(noneButton)
            let heightToAdd = selectionView.bounds.height + 10 + 49
            ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
            ActionSheet.shared.resetCancelFrame()
            ActionSheet.shared.animateActionSheetUp()
            
            
            // Remove Delete Button
        } else {
            isDeleting = false
            //
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.deleteButton.frame = CGRect(x: self.duration.frame.size.width, y: 0, width: 0, height: self.duration.frame.size.height)
                self.backgroundSoundImage.alpha = 1
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
            })
        }
    }
    
    
    
    
    
    
    //
    // TableView -----------------------------------------------------------------------------------------------------------------------
    //
    
    // Update Main Screen Detail Labels
    func updateRows() {
        //
        let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]

        //
        // Test all for nil
        if meditationArray.count != 0 {
            
            // Title
            // []0 = names, [0] = name array, [0] = name --> array due to interval bells needing to be in arrays, though only 1 value in name, duration, background sounds arrays
            presetsDetail.text = meditationArray[selectedPreset]["Name"]![0][0] as? String
            // Duration
            // [1] = duration array, [0] = duration (as in array)
            if (meditationArray[selectedPreset]["Duration"]?[0] as! [Int]).count != 0 && (meditationArray[selectedPreset]["Duration"]?[0][0] as! Int) != 0 {
                let hmsArray = convertToHMS(time: 0, index: 0)
                durationDetail.text = String(hmsArray[0]) + "h " + String(hmsArray[1]) + "m " + String(hmsArray[2]) + "s"
            } else {
                durationDetail.text = "-"
            }
            //
            // Starting Bell
            // [2] = bells array, .first = starting bell, [0] = bell
            let startingBell = meditationArray[selectedPreset]["Bells"]?.first![0] as! Int
            if startingBell != -1 {
                startingBellImage.image = bellsImages[startingBell]
                startingBellNone.alpha = 0
            } else {
                startingBellImage.image = nil
                startingBellNone.alpha = 1
            }
            //
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset]["Bells"] as! [[Int]]
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
            let endingBell = meditationArray[selectedPreset]["Bells"]?.last![0] as! Int
            if endingBell != -1 {
                endingBellImage.image = bellsImages[endingBell]
                endingBellNone.alpha = 0
            } else {
                endingBellImage.image = nil
                endingBellNone.alpha = 1
            }
            //
            // Background Sounds
            // [3] = bells array, [0] = background sound array, [0] = background sounds
            let backgroundSound = meditationArray[selectedPreset]["BackgroundSound"]?[0][0] as! Int
            if backgroundSound != -1 {
                backgroundSoundImage.image = backgroundSoundsImages[backgroundSound]
                backgroundSoundNone.alpha = 0
            } else {
                backgroundSoundImage.image = nil
                backgroundSoundNone.alpha = 1
            }
            //
        } else {
            presetsDetail.text = "-"
            durationDetail.text = "-"
            startingBellImage.image = nil
            startingBellNone.alpha = 1
            intervalBellsDetail.text = "-"
            endingBellImage.image = nil
            endingBellNone.alpha = 1
            backgroundSoundImage.image = nil
            backgroundSoundNone.alpha = 1
        }
        //
    }
    
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case tableViewBells: return 1
        case tableViewIntervalBells: return 1
        case tableViewBackgroundSounds: return 1
        default: return 0
        }
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
//        case tableViewBells:
//            switch selectedItem {
//            case 2:
//                return " " + NSLocalizedString("startingBell", comment: "")
//            case 3:
//                return " " + NSLocalizedString("bells", comment: "")
//            case 4:
//                return " " + NSLocalizedString("endingBell", comment: "")
//            default: return " "
//            }
//        case tableViewIntervalBells: return " " + NSLocalizedString("intervalBells", comment: "")
//        case tableViewBackgroundSounds: return " " + NSLocalizedString("backgroundSound", comment: "")
        default: return ""
        }
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 17)!
        header.textLabel?.textColor = Colors.light
        header.contentView.backgroundColor = Colors.dark
        header.contentView.tintColor = Colors.light
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]

        switch tableView {
        case tableViewBells:
            return bellsArray.count
        case tableViewIntervalBells:
            // Retreive Interval Bells
            //            let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset]["Bells"] as! [[Int]]
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
        let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]

        
        // Cell
        var cell = UITableViewCell()
        
        // Cell Content
        switch tableView {
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
            cell.backgroundColor = Colors.dark
            cell.textLabel?.textColor = Colors.light
            cell.tintColor = Colors.light
            //
            switch selectedItem {
            case 2:
                //
                //                let startingBellsArray = UserDefaults.standard.object(forKey: "meditationTimerStartingBells") as! [Int]
                // Interval Bells
                if didChangeStartingBell == false {
                    let startingBell = meditationArray[selectedPreset]["Bells"]?.first![0] as! Int
                    if startingBell != -1 {
                        selectedStartingBell = startingBell
                    }
                }
                //
                if indexPath.row == selectedStartingBell {
                    cell.textLabel?.textColor = Colors.green
                    cell.accessoryType = .checkmark
                    cell.tintColor = Colors.green
                }
                //
                if selectedStartingBell != -1 {
                    okButton.isEnabled = true
                }
            case 3:
                //
                if indexPath.row == selectedIntervalBell {
                    cell.textLabel?.textColor = Colors.green
                    cell.accessoryType = .checkmark
                    cell.tintColor = Colors.green
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
                    let endingBell = meditationArray[selectedPreset]["Bells"]?.last![0] as! Int
                    if endingBell != -1 {
                        selectedEndingBell = endingBell
                    }
                }
                //
                if indexPath.row == selectedEndingBell {
                    cell.textLabel?.textColor = Colors.green
                    cell.accessoryType = .checkmark
                    cell.tintColor = Colors.green
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
            var intervalBellsArray = meditationArray[selectedPreset]["Bells"] as! [[Int]]
            // Remove starting and ending bell
            intervalBellsArray.removeFirst()
            intervalBellsArray.removeLast()
            //
            // New Bell
            if indexPath.row == intervalBellsArray.count {
                cell.backgroundColor = Colors.dark
                cell.textLabel?.textColor = Colors.light
                cell.tintColor = Colors.light
                cell.layer.borderColor = Colors.light.cgColor
                cell.layer.borderWidth = 1
                //
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                cell.imageView?.tintColor = Colors.light
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
                // Bells Rows
            } else {
                cell.backgroundColor = Colors.dark
                cell.textLabel?.textColor = Colors.light
                cell.tintColor = Colors.light
                //
                let timesArray = convertToHMS(time: 1, index: indexPath.row)
                cell.detailTextLabel?.text = String(timesArray[0]) + "h " + String(timesArray[1]) + "m " + String(timesArray[2]) + "s"
                //
                cell.detailTextLabel?.textColor = Colors.light
                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
                //
                cell.textLabel?.text = NSLocalizedString(bellsArray[intervalBellsArray[indexPath.row][0]] + "Short", comment: "")
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
            cell.backgroundColor = Colors.dark
            cell.textLabel?.textColor = Colors.light
            cell.tintColor = Colors.light
            //
            //            let selectedBackgroundSoundsArray = UserDefaults.standard.object(forKey: "meditationTimerBackgroundSounds") as! [Int]
            if didChangeBackgroundSound == false {
                let chosenBackgroundSound = meditationArray[selectedPreset]["BackgroundSound"]?[0][0] as! Int
                if chosenBackgroundSound != -1 {
                    selectedBackgroundSound = chosenBackgroundSound
                }
            }
            //
            if indexPath.row == selectedBackgroundSound {
                cell.textLabel?.textColor = Colors.green
                cell.accessoryType = .checkmark
                cell.tintColor = Colors.green
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
                let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]

        
        switch tableView {
        case tableViewIntervalBells:
            //            let intervalBellsArray = UserDefaults.standard.object(forKey: "meditationTimerIntervalBells") as! [[Int]]
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset]["Bells"] as! [[Int]]
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
        var meditationArray = defaults.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
        //
        switch tableView {
        case tableViewBells:
            //
            okButton.isEnabled = true
            //
            let url = Bundle.main.url(forResource: bellsArray[indexPath.row], withExtension: "caf")!
            //
            do {
                let bell = try AVAudioPlayer(contentsOf: url)
                BellPlayer.shared.bellPlayer = bell
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
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset]["Bells"] as! [[Int]]
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
                
                ActionSheet.shared.actionSheetBackgroundView.isEnabled = false

                // View
                UIApplication.shared.keyWindow?.addSubview(selectionView2)
                UIApplication.shared.keyWindow?.bringSubview(toFront: selectionView2)
                
                // iPhone X
                var toMinus = CGFloat()
                if UIScreen.main.nativeBounds.height == 2436 {
                    toMinus = 10 + ControlBarHeights.homeIndicatorHeight
                } else {
                    toMinus = 10
                }
                selectionView2.frame = CGRect(x: view.frame.maxX, y: view.frame.maxY - selectionView.bounds.height - toMinus, width: self.view.frame.size.width - 20, height: selectionView.frame.size.height)
                // Tableview
                selectionView2.addSubview(tableViewBells)
                tableViewBells.frame = CGRect(x: 0, y: 0, width: selectionView2.frame.size.width, height: selectionView2.frame.size.height - 49)
                
                //
                backgroundViewSelection2.frame = UIScreen.main.bounds
                backgroundViewSelection2.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                backgroundViewSelection2.center.x = view.center.x + view.bounds.width
                UIApplication.shared.keyWindow?.addSubview(backgroundViewSelection2)
                UIApplication.shared.keyWindow?.bringSubview(toFront: backgroundViewSelection2)
                
                //
                UIApplication.shared.keyWindow?.insertSubview(selectionView2, aboveSubview: backgroundViewSelection2)
                
                // ok
                okButton2.frame = CGRect(x: 0, y: selectionView2.frame.size.height - 49, width: selectionView2.frame.size.width, height: 49)
                selectionView2.addSubview(okButton2)
                //
                okButton2.isEnabled = false
                // Animate fade and size
                // Position
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    //
                    ActionSheet.shared.actionSheetBackgroundView.center.x -= self.view.bounds.width
                    self.backgroundViewSelection2.center.x = self.view.center.x
                    //
                    let selectionWidth = self.view.frame.size.width - 20
                    let selectionHeight = ActionSheet.shared.actionTableHeight
                    self.selectionView2.frame = CGRect(x: 10, y: self.view.frame.maxY - self.selectionView2.bounds.height - toMinus, width: selectionWidth, height: selectionHeight)
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
                }, completion: { finished in
                    //
                    ActionSheet.shared.actionSheet.isHidden = true
                    ActionSheet.shared.cancelButton.isHidden = true
                })
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
                BellPlayer.shared.bellPlayer = bell
                BellPlayer.shared.bellPlayer?.numberOfLoops = -1
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
                let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]

        //
        switch tableView {
        case tableViewIntervalBells:
            // Interval Bells
            // [2] = bells array
            var intervalBellsArray = meditationArray[selectedPreset]["Bells"] as! [[Int]]
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
        var meditationArray = defaults.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
        //
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            //
            switch tableView{
            case tableViewIntervalBells:
                let defaults = UserDefaults.standard
                // Remove Bell
                // [2] = bells, indexPath.row + 1 because array contains starting bell as well in position 0, therefore interval bells begin at 1 not 0
                meditationArray[selectedPreset]["Bells"]?.remove(at: indexPath.row + 1)
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
        label.textColor = Colors.light
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
            let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]

        //
        var hmsArray: [Int] = []
        //
        switch time {
        case 0:
            //
            // Time in seconds (duration)
            // [1] = duration array
            let timeInSeconds = meditationArray[selectedPreset]["Duration"]?[0][0] as! Int
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
            var intervalBellsArray = meditationArray[selectedPreset]["Bells"] as! [[Int]]
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
    
    // MARK: Dismiss
    @IBAction func doneButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
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

class MeditationTimerEditingNavigation: UINavigationController {
    
}
