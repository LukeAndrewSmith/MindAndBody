//
//  MeditationTimer.swift
//  MindAndBody
//
//  Created by Luke Smith on 08.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
// Meditation Class -----------------------------------------------------------------------------------------------
//
class MeditationTimer: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    @IBOutlet weak var startingBellDuration: UILabel!
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
        presets.setTitle(NSLocalizedString("preset", comment: ""), for: .normal)
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
        UIView.animate(withDuration: 0.4, animations: {
            self.selectionView.alpha = 0
            //
            self.backgroundViewSelection.alpha = 0
        }, completion: { finished in
        //
            self.selectionView.removeFromSuperview()
            //
            self.backgroundViewSelection.removeFromSuperview()
        })
    }
    
    // Ok button action
    func okButtonAction(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        //
        
        //
        defaults.synchronize()
        //
        UIView.animate(withDuration: 0.4, animations: {
            self.selectionView.alpha = 0
            //
            self.backgroundViewSelection.alpha = 0
        }, completion: { finished in
            self.selectionView.removeFromSuperview()
            //
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
        //
        presetsTableView.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
        presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + (presetsButton.frame.size.height / 2), width: presetsButton.frame.size.width - 60, height: 0)
        //presetsTableView.frame = presetsButton.bounds
        presetsTableView.center.x = presetsButton.center.x
        presetsTableView.center.y = presetsButton.center.y + UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!
        //
        backgroundViewExpanded.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: presetsTableView)
        backgroundViewExpanded.frame = UIScreen.main.bounds
        // Animate table fade and size
        // Position
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.presetsTableView.alpha = 1
            self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)! + 44, width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88)
            self.presetsTableView.reloadData()
            //
            self.backgroundViewExpanded.alpha = 0.7
        }, completion: nil)
        //
    }

    // Duration
    @IBAction func durationAction(_ sender: Any) {
        // View
        selectionView.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        selectionView.frame = CGRect(x: 22, y: duration.frame.minY, width: UIScreen.main.bounds.width - 44, height: duration.frame.size.height)
        //
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: selectionView.frame.size.width, height: 49)
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
            // ok
            self.okButton.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
    }

    // Starting Bell
    @IBAction func startingBellAction(_ sender: Any) {
        // View
        selectionView.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        selectionView.frame = CGRect(x: 22, y: startingBell.frame.minY, width: UIScreen.main.bounds.width - 44, height: startingBell.frame.size.height)
        //
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: selectionView.frame.size.width, height: 49)
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
            // ok
            self.okButton.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
    }

    // Interval Bells
    @IBAction func intervalBellsAction(_ sender: Any) {
        // View
        selectionView.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        selectionView.frame = CGRect(x: 22, y: intervalBells.frame.minY, width: UIScreen.main.bounds.width - 44, height: intervalBells.frame.size.height)
        //
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: selectionView.frame.size.width, height: 49)
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
            // ok
            self.okButton.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
    }

    // Ending Bell
    @IBAction func endingBellAction(_ sender: Any) {
        // View
        selectionView.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        selectionView.frame = CGRect(x: 22, y: endingBell.frame.minY, width: UIScreen.main.bounds.width - 44, height: endingBell.frame.size.height)
        //
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: selectionView.frame.size.width, height: 49)
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
            // ok
            self.okButton.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
    }

    // Background Sound
    @IBAction func backgroundSoundAction(_ sender: Any) {
        // View
        selectionView.alpha = 0
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        selectionView.frame = CGRect(x: 22, y: backgroundSound.frame.minY, width: UIScreen.main.bounds.width - 44, height: backgroundSound.frame.size.height)
        //
        // ok
        okButton.frame = CGRect(x: 0, y: 147, width: selectionView.frame.size.width, height: 49)
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
            // ok
            self.okButton.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
            //
            self.backgroundViewSelection.alpha = 0.5
        }, completion: nil)
    }

    
//
// TableView -----------------------------------------------------------------------------------------------------------------------
//
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return NSLocalizedString("presets", comment: "")
        case 1: return NSLocalizedString("custom", comment: "")
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
        switch section {
        case 0: return 5
        case 1: return 1 // + .count
        default: return 0
        }
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //
        cell.textLabel?.text = "- " + NSLocalizedString(presetsArray[indexPath.section][indexPath.row], comment: "") + " -"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.backgroundColor = colour1
        cell.textLabel?.textColor = colour2
        cell.tintColor = colour2
        //
        return cell
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case movementsTableView:
            return 72
        case presetsTableView:
            return 44
        default: break
        }
        return 0
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        //
        case movementsTableView:
            break
        //
        case presetsTableView:
            //
            selectedPreset[0] = indexPath.section
            selectedPreset[1] = indexPath.row
            //
            sectionNumbers = [0, 1, 2, 3, 4, 5, 6, 7, 8]
            
            // Compress to new array
            overviewArray = fullKeyArray
            
            //
            for i in (0...(overviewArray.count - 1)).reversed() {
                // Reduce Array to session
                for j in (0...(overviewArray[i].count - 1)).reversed() {
                    if presetsArrays[selectedPreset[0]][selectedPreset[1]].contains(overviewArray[i][j]) == false {
                        overviewArray[i].remove(at: j)
                    }
                }
                
                // Remove empty arrays
                if overviewArray[i] == [] {
                    overviewArray.remove(at: i)
                    sectionNumbers.remove(at: i)
                }
            }
            
            
            
            
            presetsButton.setTitle("- " + NSLocalizedString(presetsArray[indexPath.section][indexPath.row], comment: "") + " -", for: .normal)
            presetsTableView.deselectRow(at: indexPath, animated: true)
            
            //
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsButton.frame.size.width - 60, height: 1)
                self.presetsTableView.alpha = 0
                self.backgroundViewExpanded.alpha = 0
                self.movementsTableView.reloadData()
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
                if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2") == false {
                    self.walkthroughMindBody()
                    UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2")
                }
            })
            
            //
            self.tableConstraint1.constant = 73.75
            self.tableConstraint.constant = 49.75
            //
            self.presetsConstraint.constant = self.view.frame.size.height - 73.25
            //
            self.beginConstraint.constant = 0
            UIView.animate(withDuration: 0.7) {
                self.view.layoutIfNeeded()
            }
        default: break
        }
        
    }
    

    
    
//
// Begin Action -----------------------------------------------------------------------------------------------
//
    @IBAction func beginButtonAction(_ sender: Any) {
        // Pop
        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            _ = self.navigationController?.popToRootViewController(animated: false)
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
