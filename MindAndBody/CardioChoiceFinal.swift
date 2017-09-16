//
//  CardioChoiceFinal.swift
//  MindAndBody
//
//  Created by Luke Smith on 30.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Warmup Choice Class -------------------------------------------------------------------------------------------------------------
//
class CardioChoiceFinal: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Selected Preset
    //
    var selectedPreset: [Int] = [0, 0]
    
    // 0 == rowing, 1 == biking, 2 == running
    var cardioType = 0
    
    
    //
    // Arrays to be set
    //
    var presetsTitlesArray: [[String]] = []
    var presetsArray: [[[Int]]] = []
    var lengthArray: [[[Int]]] = []
    
    //
    // Arrays ------------------------------------------------------------------------------------------------------------------------------
    //
    // Picker View Array
    //
    
    // Arrays to be set and used (Screen arrays)
    // Pses Array
    var cardioArray: [String] = []
    
    // 
    var lengthArraySession: [Int] = []
    
    // Demonstration Array
    var animationDurationArray: [Double] = []
    
    
    // Explanation Array
    var explanationArray: [String] = []
    
    // Yoga Poses
    let cardioMovementsDictionary: [Int: String] =
        [
            // Movement
            0: "sprint",    // Running
            1: "run",
            2: "jog",
            3: "still",     // Running Pauses
            4: "slowJog",
            5: "stretch",
            
            6: "sprintB",   // Bike
            7: "fastB",
            8: "mediumB",
            9: "stillB",      // Biking Pauses
            10: "slowB",
            11: "stretch",
            
            12: "sprintR",   // Rowing
            13: "fastR",
            14: "mediumR",
            15: "stillR",   // Rowing Pauses
            16: "slowR",
            17: "stretch",
    ]
    
    // Demonstration Poses
    let demonstrationDictionary: [Int: [String]] =
        [
            // Movement
            0: ["running"],    // Running
            1: ["running"],
            2: ["running"],
            3: ["Pause"],     // Running Pauses
            4: ["Pause"],
            5: ["Pause"],
            
            6: ["rowing"],   // Bike
            7: ["rowing"],
            8: ["rowing"],
            9: ["Pause"],      // Biking Pauses
            10: ["Pause"],
            11: ["Pause"],
            
            12: ["rowing"],   // Rowing
            13: ["rowing"],
            14: ["rowing"],
            15: ["Pause"],   // Rowing Pauses
            16: ["Pause"],
            17: ["Pause"],
    ]
    
    // Demonstration Animation Duration
    let animationDurationDictionary: [Int: Double] =
        [
            // Movement
            0: 0,    // Running
            1: 0,
            2: 0,
            3: 0,     // Running Pauses
            4: 0,
            5: 0,
            
            6: 0,   // Bike
            7: 0,
            8: 0,
            9: 0,      // Biking Pauses
            10: 0,
            11: 0,
            
            12: 0,   // Rowing
            13: 0,
            14: 0,
            15: 0,   // Rowing Pauses
            16: 0,
            17: 0,
    ]

    
    // Presets Header Arrays
    let presetsHeaderArray: [String] = ["timeBased", "distanceBased"]
    
    //
    // Rowing ---------------------------------------------------------------------------------------------
    //
    // Preset Arrays
    let presetsTitlesArrayRowing: [[String]] =
        [
            // Test
            // Relaxing
            ["test", "?", "?"],
            // Yoga Meditation
            ["test2", "?"]
    ]
    
    // Content Array
    let presetsArrayRowing: [[[Int]]] =
        [
            // 5 min
            // Relaxing
            [
                [12,16,12,16,12,16],
                [2,3,4,5,6,9,12,13],
                [2,3,4]
            ],
            // Meditation
            [
                [12,16,12,16,12,16,12,16],
                [66,66,66]
            ]
    ]
    
    // Length Array
    let lengthArrayRowing: [[[Int]]] =
        [
            // 5 min
            // Relaxing
            [
                [5,10,5,10,5,10],
                [1,1,1,1,1,1,1,1],
                [1,1,1]
            ],
            // Meditation
            [
                [200,10,100,5,200,5,100,5],
                [5,5,5]
            ]
    ]
    
    //
    // Rowing ---------------------------------------------------------------------------------------------
    //
    // Preset Arrays
    let presetsTitlesArrayBiking: [[String]] =
        [
            // Test
            // Relaxing
            ["lit", "lit", "test"],
            // Yoga Meditation
            ["lettingGo", "breathing"]
    ]
    
    // Content Array
    let presetsArrayBiking: [[[Int]]] =
        [
            // 5 min
            // Relaxing
            [
                [2,3,4,5,6,9],
                [2,3,4,5,6,9,12,13],
                [2,3,4]
            ],
            // Meditation
            [
                [33,33,33],
                [66,66,66]
            ]
    ]
    
    // Length Array
    let lengthArrayBiking: [[[Int]]] =
        [
            // 5 min
            // Relaxing
            [
                [1,1,1,1,5,5],
                [1,1,1,1,1,1,1,1],
                [1,1,1]
            ],
            // Meditation
            [
                [5,5,5],
                [5,5,5]
            ]
    ]
    
    
    //
    // Rowing ---------------------------------------------------------------------------------------------
    //
    // Preset Arrays
    let presetsTitlesArrayRunning: [[String]] =
        [
            // Test
            // Relaxing
            ["lit", "lit", "test"],
            // Yoga Meditation
            ["lettingGo", "breathing"]
    ]
    
    // Content Array
    let presetsArrayRunning: [[[Int]]] =
        [
            // 5 min
            // Relaxing
            [
                [2,3,4,5,6,9],
                [2,3,4,5,6,9,12,13],
                [2,3,4]
            ],
            // Meditation
            [
                [33,33,33],
                [66,66,66]
            ]
    ]
    
    // Length Array
    var lengthArrayRunning: [[[Int]]] =
        [
            // 5 min
            // Relaxing
            [
                [1,1,1,1,5,5],
                [1,1,1,1,1,1,1,1],
                [1,1,1]
            ],
            // Meditation
            [
                [5,5,5],
                [5,5,5]
            ]
    ]
    
    
    // Set Arrays
    func setArrays() {
        switch cardioType {
        // Rowing
        case 0:
            presetsTitlesArray = presetsTitlesArrayRowing
            presetsArray = presetsArrayRowing
            lengthArray = lengthArrayRowing
        // Biking
        case 1:
            presetsTitlesArray = presetsTitlesArrayBiking
            presetsArray = presetsArrayBiking
            lengthArray = lengthArrayBiking
        // Running
        case 2:
            presetsTitlesArray = presetsTitlesArrayRunning
            presetsArray = presetsArrayRunning
            lengthArray = lengthArrayRunning
        default: break
        }
    }
    
    
    
    //
    let navigationTitles: [String] = ["rowing", "biking", "runnung"]
    
    
    
    
    // Selected Array
    var selectedArray: [Int] = []
    
    // Selected Title
    var selectedTitle = Int()
    
    
    
    //
    // Outlets ------------------------------------------------------------------------------------------------------------------------------
    //
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    // Movements Table View
    @IBOutlet weak var overviewTableView: UITableView!
    
    // Presets Button
    @IBOutlet weak var presetsButton: UIButton!
    
    //
    @IBOutlet weak var presetsConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableConstraint1: NSLayoutConstraint!
    
    @IBOutlet weak var tableConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var beginConstraint: NSLayoutConstraint!
    
    
    
    let emptyString = ""
    
    // Presets Table
    //
    // Select Prest
    var presetsTableView = UITableView()
    var backgroundViewExpanded = UIButton()
    
    
    // Flash Screen
    func flashScreen() {
        //
        let flash = UIView()
        //
        flash.frame = CGRect(x: 0, y: presetsButton.frame.maxY, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        //
        UIView.animate(withDuration: 0.3, animations: {
            flash.alpha = 0
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
    }
    
    //
    // View will appear
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        setArrays()
        
        //
        presetsButton.setTitle(NSLocalizedString("selectCardioSession", comment: ""), for: .normal)
    }
    
    //
    // View did load ------------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setArrays()

        // Colour
        view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString(navigationTitles[cardioType], comment: ""))
        
        //
        presetsButton.backgroundColor = colour2
        presetsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //
        overviewTableView.tableFooterView = UIView()
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = colour3
        beginButton.setTitleColor(colour2, for: .normal)
        
        
        
        
        
        
        // Initial Element Positions
        //
        presetsConstraint.constant = 0
        //
        tableConstraint1.constant = view.frame.size.height
        tableConstraint.constant = -49.25
        //
        beginConstraint.constant = -49
        
        
        
        //
        // TableView Backgrounds
        //
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.overviewTableView.frame.size.width, height: self.overviewTableView.frame.size.height)
        //
        overviewTableView.backgroundView = tableViewBackground
        
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
        // Movement table
        presetsTableView.backgroundColor = colour2
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        presetsTableView.layer.cornerRadius = 15
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        presetsTableView.layer.borderColor = colour1.cgColor
        presetsTableView.layer.borderWidth = 1
        //
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Select
        self.presetsButton.sendActions(for: .touchUpInside)
    }
    
    //
    // TableView -----------------------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case overviewTableView:
            return 1
        case presetsTableView:
            return 2
        default: break
        }
        return 0
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case overviewTableView:
            return ""
        case presetsTableView:
            return NSLocalizedString(presetsHeaderArray[section], comment: "")
        default: break
        }
        return ""
    }
    
    //
   
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        switch tableView {
        case overviewTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        case presetsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        default: break
        }
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case overviewTableView:
            return presetsArray[selectedPreset[0]][selectedPreset[1]].count
        case presetsTableView:
            return presetsTitlesArray[section].count
        default: break
        }
        return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        //
        case overviewTableView:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            cell.selectionStyle = .none
            //
            cell.textLabel?.text = NSLocalizedString(cardioMovementsDictionary[presetsArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]]!, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            
            // Detail
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.textAlignment = .right
            cell.detailTextLabel?.textColor = colour2
            //
            // Time
            if selectedPreset[0] == 0 {
                cell.detailTextLabel?.text = timeToString(totalSeconds: lengthArray[selectedPreset[0]][selectedPreset[1]][indexPath.row])
            } else {
                // Even IndexPath.rows (movement)
                if indexPath.row % 2 == 0 {
                    cell.detailTextLabel?.text = String(lengthArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]) + "m"
                // Odd IndexPath.rows (pauses)
                } else {
                    cell.detailTextLabel?.text = timeToString(totalSeconds: lengthArray[selectedPreset[0]][selectedPreset[1]][indexPath.row])
                }
            }
            
            
            //
            // Cell Image
            cell.imageView?.image = getUncachedImage(named: (demonstrationDictionary[presetsArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]]?[0])!)
            cell.imageView?.isUserInteractionEnabled = true
            //
            cell.imageView?.tag = presetsArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleTap))
            cell.imageView?.addGestureRecognizer(imageTap)
            //
            return cell
        //
        case presetsTableView:
            //
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            cell.textLabel?.text = "- " + NSLocalizedString(presetsTitlesArray[indexPath.section][indexPath.row], comment: "") + " -"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.backgroundColor = colour1
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            return cell
        default: break
        }
        return UITableViewCell()
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case overviewTableView:
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
        case overviewTableView:
            break
        //
        case presetsTableView:
            //
            selectedPreset[0] = indexPath.section
            selectedPreset[1] = indexPath.row
            //
            
            
            presetsButton.setTitle("- " + NSLocalizedString(presetsTitlesArray[indexPath.section][indexPath.row], comment: "") + " -", for: .normal)
            presetsTableView.deselectRow(at: indexPath, animated: true)
            
            //
            let tableHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            let tableWidth = UIScreen.main.bounds.width - 20
            
            //
            // Dismiss Action Sheet
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: tableWidth, height: tableHeight)
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
            // Present new elements
            UIView.animate(withDuration: AnimationTimes.animationTime3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.overviewTableView.reloadData()
                let indexPath2 = NSIndexPath(row: 0, section: 0)
                self.overviewTableView.scrollToRow(at: indexPath2 as IndexPath, at: .top, animated: true)
                //
                self.tableConstraint1.constant = 73.75
                self.tableConstraint.constant = 49.75
                //
                self.presetsConstraint.constant = self.view.frame.size.height - 73.25
                //
                self.beginConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
            
        default: break
        }
        
        //
        // MARK: Walkthrough
        if UserDefaults.standard.bool(forKey: "finalChoiceWalkthrough") == false {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + AnimationTimes.animationTime3, execute: {
                self.walkthroughFinalChoice()
            })
        }
    }
    
    
    //
    // Presets Button Action -----------------------------------------------------------------------------------------------------------------
    //
    @IBAction func presetsButtonAction(_ sender: Any) {
        //
        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: presetsTableView)
        //
        animateActionSheetUp(actionSheet: presetsTableView, actionSheetHeight: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88, backgroundView: backgroundViewExpanded)
    }
    
    
    // Dismiss presets table
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        animateActionSheetDown(actionSheet: presetsTableView, actionSheetHeight: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88, backgroundView: backgroundViewExpanded)
    }
    
    
    //
    // Expand image actions ----------------------------------------------------------------------------------------------------------------
    //
    // Handle Tap
    let expandedImage = UIImageView()
    let backgroundViewImage = UIButton()
    var imageIndex = Int()
    //
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        //
        // Get Array index
        let sender = extraTap.view as! UIImageView
        let demonstrationIndex = sender.tag
        imageIndex = demonstrationIndex
        //
        expandedImage.image = getUncachedImage(named: (demonstrationDictionary[demonstrationIndex]?[0])!)
        //
        // Animate
        backgroundViewImage.addTarget(self, action: #selector(retractImage(_:)), for: .touchUpInside)
        //
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewImage, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(expandedImage, aboveSubview: backgroundViewImage)
        //
        animateViewUp(animationView: expandedImage, backgroundView: backgroundViewImage)
    }
        
    // Retract image
    @IBAction func retractImage(_ sender: Any) {
        //
        animateViewDown(animationView: expandedImage, backgroundView: backgroundViewImage)
    }
    
    //
    // Time
    func timeToString(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        if minutes < 1 {
            if seconds < 10 {
                return String(format: "%01ds", seconds)
            } else {
                return String(format: "%02ds", seconds)
            }
        } else {
            if minutes < 10 {
                if seconds == 0 {
                    return String(format: "%01dmin", minutes)
                } else if seconds < 10 {
                    return String(format: "%01dmin %01ds", minutes, seconds)
                } else {
                    return String(format: "%01dmin %02ds", minutes, seconds)
                }
            } else {
                if seconds == 0 {
                    return String(format: "%02dmin", minutes)
                } else if seconds < 10 {
                    return String(format: "%02dmin %01ds", minutes, seconds)
                } else {
                    return String(format: "%02dmin %02ds", minutes, seconds)
                }
            }
        }
    }
    
    
    //
    // Begin Button ---------------------------------------------------------------------------------------------------------------------------
    //
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        //
        // Return background to homescreen
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            _ = self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    
    //
    // Pass Arrays ---------------------------------------------------------------------------------------------------------------------------
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "cardioSessionSegue") {
            //
            let destinationVC = segue.destination as! CardioScreen
            
            // Ensure array in ascending order
            // Compress Arrays
            for i in presetsArray[selectedPreset[0]][selectedPreset[1]] {
                //
                cardioArray.append(cardioMovementsDictionary[i]!)
                //
            }
            //
            destinationVC.sessionArray = cardioArray
            destinationVC.lengthArray = lengthArray[selectedPreset[0]][selectedPreset[1]]
            
            //
            destinationVC.sessionTitle = presetsTitlesArray[selectedPreset[0]][selectedPreset[1]]
            //
            destinationVC.sessionType = selectedPreset[0]
        }
    }
    
    
    
    //
    // MARK: Walkthrough ------------------------------------------------------------------------------------------------------------------
    //
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabel = UILabel()
    var nextButton = UIButton()
    
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["finalChoice0", "finalChoice1", "finalChoice2"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    var highlightColor = UIColor()
    
    // Walkthrough
    func walkthroughFinalChoice() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughFinalChoice), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Preset Session
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = colour1
            walkthroughLabel.backgroundColor = colour2
            walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width / 2, height: 36)
            walkthroughHighlight.center = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.combinedHeight + (73.5 / 2))
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Overview
        case 1:
            //
            highlightSize = CGSize(width: view.bounds.width, height: (view.bounds.height - 73.5 - 49))
            highlightCenter = CGPoint(x: (view.bounds.width / 2), y: TopBarHeights.combinedHeight + 73.5 + ((view.bounds.height - 73.5 - 49) / 2))
            highlightCornerRadius = 3
            //
            labelFrame = 1
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour2
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
            
        // Begin
        case 2:
            //
            highlightSize = CGSize(width: view.bounds.width / 3, height: 36)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y:  view.frame.maxY - 24.5)
            highlightCornerRadius = 0
            //
            labelFrame = 1
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour2
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                UserDefaults.standard.set(true, forKey: "finalChoiceWalkthrough")
            })
        }
    }

    
//
}
