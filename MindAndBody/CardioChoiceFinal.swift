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
    let demonstrationDictionary: [Int: [UIImage]] =
        [
            // Movement
            0: [#imageLiteral(resourceName: "Test 2")],    // Running
            1: [#imageLiteral(resourceName: "Test 2")],
            2: [#imageLiteral(resourceName: "Test 2")],
            3: [#imageLiteral(resourceName: "Pause")],     // Running Pauses
            4: [#imageLiteral(resourceName: "Pause")],
            5: [#imageLiteral(resourceName: "Pause")],
            
            6: [#imageLiteral(resourceName: "Test 2")],   // Bike
            7: [#imageLiteral(resourceName: "Test 2")],
            8: [#imageLiteral(resourceName: "Test 2")],
            9: [#imageLiteral(resourceName: "Pause")],      // Biking Pauses
            10: [#imageLiteral(resourceName: "Pause")],
            11: [#imageLiteral(resourceName: "Pause")],
            
            12: [#imageLiteral(resourceName: "Test 2")],   // Rowing
            13: [#imageLiteral(resourceName: "Test 2")],
            14: [#imageLiteral(resourceName: "Test 2")],
            15: [#imageLiteral(resourceName: "Pause")],   // Rowing Pauses
            16: [#imageLiteral(resourceName: "Pause")],
            17: [#imageLiteral(resourceName: "Pause")],
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
    
    
    // Target Area Dictionary
    let targetAreaDictionary: [Int: UIImage] =
        [
            // Movement
            0: #imageLiteral(resourceName: "Heart"),    // Running
            1: #imageLiteral(resourceName: "Heart"),
            2: #imageLiteral(resourceName: "Heart"),
            3: #imageLiteral(resourceName: "Heart"),     // Running Pauses
            4: #imageLiteral(resourceName: "Heart"),
            5: #imageLiteral(resourceName: "Heart"),
            
            6: #imageLiteral(resourceName: "Heart"),   // Bike
            7: #imageLiteral(resourceName: "Heart"),
            8: #imageLiteral(resourceName: "Heart"),
            9: #imageLiteral(resourceName: "Heart"),      // Biking Pauses
            10: #imageLiteral(resourceName: "Heart"),
            11: #imageLiteral(resourceName: "Heart"),
            
            12: #imageLiteral(resourceName: "Heart"),   // Rowing
            13: #imageLiteral(resourceName: "Heart"),
            14: #imageLiteral(resourceName: "Heart"),
            15: #imageLiteral(resourceName: "Heart"),   // Rowing Pauses
            16: #imageLiteral(resourceName: "Heart"),
            17: #imageLiteral(resourceName: "Heart"),
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
                [12,16,12,16,12,16,12,16],
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
                [30,60,30,60,30,60,30,60],
                [1,1,1,1,1,1,1,1],
                [1,1,1]
            ],
            // Meditation
            [
                [200,1,100,1,200,1,100,1],
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
        presetsTableView.layer.cornerRadius = 5
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //
        
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
            header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 18)!
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        case presetsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 18)!
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
            cell.imageView?.image = demonstrationDictionary[presetsArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]]?[0]
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
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsButton.frame.size.width - 60, height: 1)
                self.presetsTableView.alpha = 0
                self.backgroundViewExpanded.alpha = 0
                self.overviewTableView.reloadData()
                //
                self.tableConstraint1.constant = 73.75
                self.tableConstraint.constant = 49.75
                //
                self.presetsConstraint.constant = self.view.frame.size.height - 73.25
                //
                self.beginConstraint.constant = 0
                //
                self.view.layoutIfNeeded()
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
                if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2") == false {
                    self.walkthroughMindBody()
                    UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2")
                }
            })
        default: break
        }
        
    }
    
    
    //
    // Presets Button Action -----------------------------------------------------------------------------------------------------------------
    //
    @IBAction func presetsButtonAction(_ sender: Any) {
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
        //        })
    }
    
    
    // Dismiss presets table
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.presetsTableView.frame = CGRect(x: 30, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.size.height)!, width: self.presetsButton.frame.size.width - 60, height: 0)
            self.presetsTableView.alpha = 0
            self.backgroundViewExpanded.alpha = 0
        }, completion: { finished in
            //
            self.presetsTableView.removeFromSuperview()
            self.backgroundViewExpanded.removeFromSuperview()
        })
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
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        //
        // Get Array index
        let sender = extraTap.view as! UIImageView
        let demonstrationIndex = sender.tag
        //
        imageIndex = demonstrationIndex
        
        if demonstrationDictionary[demonstrationIndex]?[0] == #imageLiteral(resourceName: "Pause") {
            
        } else {
        
        // Expanded Image
        //
        expandedImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: height/2)
        expandedImage.center.x = self.view.frame.size.width/2
        expandedImage.center.y = (height/2) * 2.5
        //
        expandedImage.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        expandedImage.contentMode = .scaleAspectFit
        expandedImage.isUserInteractionEnabled = true
        //
        // Animation
        expandedImage.image = demonstrationDictionary[demonstrationIndex]?[0]
        expandedImage.animationImages = demonstrationDictionary[demonstrationIndex]
        expandedImage.animationImages?.removeFirst()
        expandedImage.animationDuration = animationDurationDictionary[demonstrationIndex]!
        expandedImage.animationRepeatCount = 1
        // Play
        let imagePress = UITapGestureRecognizer(target: self, action: #selector(imageSequenceAnimation))
        expandedImage.addGestureRecognizer(imagePress)
        //
        
        
        // Background View
        //
        backgroundViewImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: height)
        backgroundViewImage.backgroundColor = .black
        backgroundViewImage.alpha = 0
        backgroundViewImage.addTarget(self, action: #selector(retractImage(_:)), for: .touchUpInside)
        //
        self.navigationItem.setHidesBackButton(true, animated: true)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewImage, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(expandedImage, aboveSubview: backgroundViewImage)
        //
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandedImage.center.y = (height/2) * 1.5
            self.backgroundViewImage.alpha = 0.5
        }, completion: nil)
        }
    }
    
    // Retract image
    @IBAction func retractImage(_ sender: Any) {
        //
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        //
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandedImage.center.y = (height/2) * 2.5
            self.backgroundViewImage.alpha = 0
        }, completion: { finished in
            //
            self.expandedImage.removeFromSuperview()
            self.backgroundViewImage.removeFromSuperview()
            self.navigationItem.setHidesBackButton(false, animated: true)
        })
    }
    
    //
    // Play Image Sequence
    @IBAction func imageSequenceAnimation() {
        //
        if demonstrationDictionary[imageIndex]?.count != 1 {
            expandedImage.startAnimating()
        }
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
    // Walkthrough --------------------------------------------------------------------------------------------------------
    //
    var  viewNumber = 0
    let walkthroughView = UIView()
    let label = UILabel()
    let nextButton = UIButton()
    let backButton = UIButton()
    
    // Walkthrough
    func walkthroughMindBody() {
        //
        let screenSize = UIScreen.main.bounds
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        //
        walkthroughView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        walkthroughView.backgroundColor = .black
        walkthroughView.alpha = 0.72
        walkthroughView.clipsToBounds = true
        //
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        label.center = view.center
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "SFUIDisplay-light", size: 22)
        label.textColor = .white
        //
        nextButton.frame = screenSize
        nextButton.backgroundColor = .clear
        nextButton.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
        //
        backButton.frame = CGRect(x: 3, y: UIApplication.shared.statusBarFrame.height, width: 50, height: navigationBarHeight)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.textAlignment = .left
        backButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        backButton.titleLabel?.textColor = .white
        backButton.addTarget(self, action: #selector(backWalkthroughView(_:)), for: .touchUpInside)
        
        //
        switch viewNumber {
        case 0:
            //
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight, width: self.view.frame.size.width, height: 73.5))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            //
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            //
            label.text = NSLocalizedString("choiceScreen2W", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
        //
        case 1:
            //
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 73.5, width: self.view.frame.size.width, height: overviewTableView.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            //
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            //
            label.center.y = presetsButton.center.y + UIApplication.shared.statusBarFrame.height + navigationBarHeight
            label.text = NSLocalizedString("choiceScreen21", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
            //
        //
        case 2:
            //
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 73.5 + overviewTableView.frame.size.height, width: self.view.frame.size.width, height: 49))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            //
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            //
            label.center = overviewTableView.center
            label.text = NSLocalizedString("choiceScreen22", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
        //
        default: break
        }
    }
    
    //
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        label.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    
    //
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            label.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
    }
    //
    //
}
