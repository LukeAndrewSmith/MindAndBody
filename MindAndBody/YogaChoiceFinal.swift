//
//  YogaChoiceFinal.swift
//  MindAndBody
//
//  Created by Luke Smith on 23.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Warmup Choice Class -------------------------------------------------------------------------------------------------------------
//
class YogaChoiceFinal: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Selected Preset
    //
    var selectedPreset: [Int] = [0, 0]
    
    //
    // Arrays ------------------------------------------------------------------------------------------------------------------------------
    
    //
    // Picker View Array
    //
    
    // Arrays to be set and used (Screen arrays)
    // Pses Array
    var yogaArray: [String] = []
    
    
    // Demonstration Array
    var demonstrationArray: [[String]] = []
    
    // Target Area Array
    var targetAreaArray: [UIImage] = []
    
    // Explanation Array
    var explanationArray: [String] = []
    
    
    // Yoga Poses
    let yogaPosesDictionary: [Int: String] =
        [
            // Standing
            0: "upwardsSalute",
            1: "mountain",
            2: "tree",
            3: "extendedToeGrab",
            4: "eagle",
            5: "chair",
            6: "lordOfDance",
            7: "warrior1",
            8: "warrior2",
            9: "warrior3",
            10: "halfMoon",
            11: "extendedTriangle",
            12: "extendedSideAngleY",
            13: "revolvedSideAngle",
            14: "revolvedTriangle",
            15: "halfForwardBend",
            16: "forwardBend",
            17: "wideLeggedForwardBend",
            18: "intenseSide",
            19: "gate",
            20: "highLunge",
            21: "lowLungeY",
            22: "deepSquat",
            // Hand/Elbows and Feet/Knees
            23: "dolphin",
            24: "downwardDog",
            25: "halfDownwardDog",
            26: "plank", //// UNUSED
            27: "dolphinPlank",
            28: "fourLimbedStaff",
            29: "sidePlank",
            30: "cat",
            31: "cow",
            32: "catCow",
            33: "halfMonkey",
            34: "childPose",
            35: "wildThing",
            36: "upwardBow",
            37: "bridge",
            38: "upwardPlank",
            39: "extendedPuppy",
            40: "upwardDog",
            // Seated
            41: "crossLeg",
            42: "lotus",
            43: "fireLog",
            44: "boat",
            45: "cowFace",
            46: "hero",
            47: "butterfly",
            48: "staffPose",
            49: "seatedForwardBend",
            50: "vForwardBend",
            51: "vSideBend",
            52: "halfVForwardBend",
            53: "halfVSideBend",
            54: "marichi1",
            55: "marichi3",
            56: "frontSplit",
            57: "sideSplit",
            // Lying
            58: "corpse",
            59: "fish",
            60: "happyBaby",
            61: "lyingButterfly",
            62: "legRaiseToe",
            63: "threadTheNeedle",
            64: "shoulderStand",
            65: "plow",
            66: "cobra",
            67: "sphinx",
            68: "pigeon",
            69: "spineRolling",
            // Hand Stands
            70: "handstand",
            71: "headstand",
            72: "forearmStand"
        ]
    
    
    // Explanation Dictionary
    let explanationDictionary: [Int: String] =
        [
            // Standing
            0: "upwardsSaluteE",
            1: "mountainE",
            2: "treeE",
            3: "extendedToeGrabE",
            4: "eagleE",
            5: "chairE",
            6: "lordOfDanceE",
            7: "warrior1E",
            8: "warrior2E",
            9: "warrior3E",
            10: "halfMoonE",
            11: "extendedTriangleE",
            12: "extendedSideAngleYE",
            13: "revolvedSideAngleE",
            14: "revolvedTriangleE",
            15: "halfForwardBendE",
            16: "forwardBendE",
            17: "wideLeggedForwardBendE",
            18: "intenseSideE",
            19: "gateE",
            20: "highLungeE",
            21: "lowLungeYE",
            22: "deepSquatE",
            // Hand/Elbows and Feet/Knees
            23: "dolphinE",
            24: "downwardDogE",
            25: "halfDownwardDogE",
            26: "plankE", //// UNUSED
            27: "dolphinPlankE",
            28: "fourLimbedStaffE",
            29: "sidePlankE",
            30: "catE",
            31: "cowE",
            32: "catCowE",
            33: "halfMonkeyE",
            34: "childPoseE",
            35: "wildThingE",
            36: "upwardBowE",
            37: "bridgeE",
            38: "upwardPlankE",
            39: "extendedPuppyE",
            40: "upwardDogE",
            // Seated
            41: "crossLegE",
            42: "lotusE",
            43: "fireLogE",
            44: "boatE",
            45: "cowFaceE",
            46: "heroE",
            47: "butterflyE",
            48: "staffPoseE",
            49: "seatedForwardBendE",
            50: "vForwardBendE",
            51: "vSideBend",
            52: "halfVForwardBendE",
            53: "halfVSideBendE",
            54: "marichi1E",
            55: "marichi3E",
            56: "frontSplitE",
            57: "sideSplitE",
            // Lying
            58: "corpseE",
            59: "fishE",
            60: "happyBabyE",
            61: "lyingButterflyE",
            62: "legRaiseToeE",
            63: "threadTheNeedleE",
            64: "shoulderStandE",
            65: "plowE",
            66: "cobraE",
            67: "sphinxE",
            68: "pigeonE",
            69: "spineRollingE",
            // Hand Stands
            70: "handstandE",
            71: "headstandE",
            72: "forearmStandE"
        ]
    
    
    // Demonstration Poses
    let demonstrationDictionary: [Int: [String]] =
        [
            // Standing
            0: ["upwardSalute"],
            1: ["mountain"],
            2: ["tree", "tree1", "tree2", "tree3", "tree4", "tree5", "tree6"],
            3: ["extendedToeGrab", "extendedToeGrab1", "extendedToeGrab2", "extendedToeGrab3", "extendedToeGrab4", "extendedToeGrab5"],
            4: ["eagle", "eagle1", "eagle2", "eagle3", "eagle4", "eagle5", "eagle6", "eagle7"],
            5: ["chair", "chair1", "chair2", "chair3", "chair4", "chair5"],
            6: ["lordOfDance", "lordOfDance1", "lordOfDance2", "lordOfDance3", "lordOfDance4", "lordOfDance5", "lordOfDance6", "lordOfDance7"],
            7: ["warrior1", "warrior11", "warrior12", "warrior13", "warrior14", "warrior15"],
            8: ["warrior2", "warrior21", "warrior22", "warrior23", "warrior24", "warrior25"],
            9: ["warrior3", "warrior31", "warrior32", "warrior33", "warrior34", "warrior35", "warrior36"],
            10: ["halfMoon", "halfMoon1", "halfMoon2", "halfMoon3", "halfMoon4", "halfMoon5", "halfMoon6", "halfMoon7"],
            11: ["extendedTriangle", "extendedTriangle1", "extendedTriangle2", "extendedTriangle3", "extendedTriangle4", "extendedTriangle5"],
            12: ["extendedSideAngle", "extendedSideAngle1", "extendedSideAngle2", "extendedSideAngle3", "extendedSideAngle4", "extendedSideAngle5", "extendedSideAngle6"],
            13: ["revolvedSideAngle", "revolvedSideAngle1", "revolvedSideAngle2", "revolvedSideAngle3", "revolvedSideAngle4", "revolvedSideAngle5", "revolvedSideAngle6"],
            14: ["revolvedTriangle", "revolvedTriangle1", "revolvedTriangle2", "revolvedTriangle3", "revolvedTriangle4", "revolvedTriangle5", "revolvedTriangle6"],
            15: ["halfForwardBend", "halfForwardBend1", "halfForwardBend2", "halfForwardBend3", "halfForwardBend4", "halfForwardBend5", "halfForwardBend6", "halfForwardBend7"],
            16: ["forwardBend", "forwardBend1", "forwardBend2", "forwardBend3", "forwardBend4", "forwardBend5", "forwardBend6", "forwardBend7"],
            17: ["wideLeggedForwardBend", "wideLeggedForwardBend1", "wideLeggedForwardBend2", "wideLeggedForwardBend3", "wideLeggedForwardBend4", "wideLeggedForwardBend5", "wideLeggedForwardBend6"],
            18: ["intenseSide", "intenseSide1", "intenseSide2", "intenseSide3", "intenseSide4", "intenseSide5"],
            19: ["gate"],
            20: ["highLunge", "highLunge1", "highLunge2", "highLunge3", "highLunge4", "highLunge5", "highLunge6"],
            21: ["lowLunge", "lowLunge1", "lowLunge2", "lowLunge3", "lowLunge4", "lowLunge5", "lowLunge6"],
            22: ["deepSquat", "deepSquat1", "deepSquat2", "deepSquat3", "deepSquat4", "deepSquat5"],
            // Hand/Elbows and Feet/Knees
            23: ["dolphin", "dolphin1", "dolphin2", "dolphin3"],
            24: ["downwardDog", "downwardDog1", "downwardDog2", "downwardDog3", "downwardDog4"],
            25: ["halfDownwardDog", "halfDownwardDog1", "halfDownwardDog2", "halfDownwardDog3", "halfDownwardDog4"],
            26: [""], //// UNUSED!!!!!!!
            27: ["dolphinPlank"],
            28: ["fourLimbedStaff"],
            29: ["sidePlank", "sidePlank1", "sidePlank2", "sidePlank3", "sidePlank4"],
            30: ["cat"],
            31: ["cow"],
            32: ["cat", "catCow1", "catCow2", "catCow1", "catCow3", "catCow1"],
            33: ["halfMonkey", "halfMonkey1", "halfMonkey2", "halfMonkey3", "halfMonkey4"],
            34: ["childPose", "childPose1", "childPose2", "childPose3"],
            35: ["wildThing", "wildThing1", "wildThing2", "wildThing3", "wildThing4", "wildThing5", "wildThing6"],
            36: ["upwardBow", "upwardBow1", "upwardBow2", "upwardBow3", "upwardBow4", "upwardBow5"],
            37: ["bridge", "bridge1", "bridge2", "bridge3"],
            38: ["upwardPlank", "upwardPlank1", "upwardPlank2", "upwardPlank3", "upwardPlank4", "upwardPlank5"],
            39: ["extendedPuppy", "extendedPuppy1", "extendedPuppy2", "extendedPuppy3", "extendedPuppy4", "extendedPuppy5"],
            40: ["upwardDog", "upwardDog1", "upwardDog2", "upwardDog3", "upwardDog4"],
            // Seated
            41: ["crossLegged"],
            42: ["lotus"],
            43: ["fireLog"],
            44: ["boat"],
            45: ["cowFace"],
            46: ["hero"],
            47: ["butterfly"],
            48: ["staff"],
            49: ["seatedForwardBend"],
            50: ["vForwardBend"],
            51: ["vSideBend", "vSideBend1", "vSideBend2", "vSideBend3", "vSideBend4", "vSideBend5"],
            52: ["halfVForwardBend", "halfVForwardBend1", "halfVForwardBend2", "halfVForwardBend3", "halfVForwardBend4", "halfVForwardBend5", "halfVForwardBend6"],
            53: ["halfVSideBend", "halfVSideBend1", "halfVSideBend2", "halfVSideBend3", "halfVSideBend4", "halfVSideBend5"],
            54: ["marichi1", "marichi11", "marichi12", "marichi13", "marichi14", "marichi15", "marichi16", "marichi17"],
            55: ["marichi3", "marichi31", "marichi32", "marichi33", "marichi34", "marichi35", "marichi36", "marichi37"],
            56: ["frontSplit"],
            57: ["sideSplit"],
            // Lying
            58: ["corpse"],
            59: ["fish", "fish1", "fish2", "fish3", "fish4", "fish5"],
            60: ["happyBaby"],
            61: ["lyingButterfly", "lyingButterfly1", "lyingButterfly2", "lyingButterfly3", "lyingButterfly4"],
            62: ["legRaiseToe"],
            63: ["threadTheNeedle", "threadTheNeedle1", "threadTheNeedle2", "threadTheNeedle3", "threadTheNeedle4", "threadTheNeedle5"],
            64: ["shoulderStand", "shoulderStand1", "shoulderStand2", "shoulderStand3", "shoulderStand4", "shoulderStand5", "shoulderStand6", "shoulderStand7"],
            65: ["plow", "plow1", "plow2", "plow3", "plow4"],
            66: ["cobra", "cobra1", "cobra2", "cobra3", "cobra4"],
            67: ["sphinx"],
            68: ["pigeon", "pigeon1", "pigeon2", "pigeon3", "pigeon4", "pigeon5", "pigeon6", "pigeon7", "pigeon8"],
            69: ["spineRolling", "spineRolling1", "spineRolling2", "spineRolling3", "spineRolling2", "spineRolling4", "spineRolling2", "spineRolling3", "spineRolling2", "spineRolling4"],
            // Hand Stands
            70: ["handStand", "handStand1", "handStand2", "handStand3", "handStand4", "handStand5", "handStand6", "handStand7", "handStand8"],
            71: ["headStand", "headStand1", "headStand2", "headStand3", "headStand4", "headStand5", "headStand6", "headStand7", "headStand8"],
            72: ["forearmStand", "forearmStand1", "forearmStand2", "forearmStand3", "forearmStand4", "forearmStand5", "forearmStand6"]
        ]
   
    
    // Practice Section Title
    let practiceSectionTitles: [String] =
            // Test
            ["test",
            // Meditation
            "yogaMeditation"]
    
    
    // Preset Arrays
    let practiceTitlesArray: [[String]] =
        [
            // Test
            // Relaxing
            ["lit", "lit", "test"],
            // Yoga Meditation
            ["lettingGo", "breathing"]
    ]
    
    
     //// 26 UNUSED
    
    // Practice Content Array
    let practiceArray: [[[Int]]] =
        [
        // 5 min
            // Relaxing
            [
                //0,1
                [ 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72],
                [2,3,4,5,6,9,12,13],
                [2,3,4]
            ],
        // Meditation
            [
                [33,33,33],
                [66,66,66]
            ]
        ]
    
    // Breaths Array
    var breathsArray: [[[Int]]] =
        [
            // 5 min
            // Relaxing
            [
                [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72],
                [1,1,1,1,1,1,1,1],
                [1,1,1]
            ],
            // Meditation
            [
                [5,5,5],
                [5,5,5]
            ]
    ]
    
    
    
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
    @IBOutlet weak var posesTableView: UITableView!
    
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
        presetsButton.setTitle(NSLocalizedString("selectPractice", comment: ""), for: .normal)
    }
    
    //
    // View did load ------------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colour
        view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("practices", comment: ""))
        
        //
        presetsButton.backgroundColor = colour2
        presetsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //
        posesTableView.tableFooterView = UIView()
        
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
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.posesTableView.frame.size.width, height: self.posesTableView.frame.size.height)
        //
        posesTableView.backgroundView = tableViewBackground
        
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
    
    
    //
    // TableView -----------------------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case posesTableView:
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
        case posesTableView:
            return ""
        case presetsTableView:
            return NSLocalizedString(practiceSectionTitles[section], comment: "")
        default: break
        }
        return ""
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        switch tableView {
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
        case posesTableView:
            return practiceArray[selectedPreset[0]][selectedPreset[1]].count
        case presetsTableView:
            return practiceTitlesArray[section].count
        default: break
        }
        return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        //
        case posesTableView:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            cell.selectionStyle = .none
            //
            cell.textLabel?.text = NSLocalizedString(yogaPosesDictionary[practiceArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]]!, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            // Cell Image
            cell.imageView?.image = getUncachedImage(named: (demonstrationDictionary[practiceArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]]?[0])!)
            cell.imageView?.isUserInteractionEnabled = true
            //
            cell.imageView?.tag = practiceArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]
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
            cell.textLabel?.text = "- " + NSLocalizedString(practiceTitlesArray[indexPath.section][indexPath.row], comment: "") + " -"
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
        case posesTableView:
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
        case posesTableView:
            break
        //
        case presetsTableView:
            //
            selectedPreset[0] = indexPath.section
            selectedPreset[1] = indexPath.row
            //
            
            
            presetsButton.setTitle("- " + NSLocalizedString(practiceTitlesArray[indexPath.section][indexPath.row], comment: "") + " -", for: .normal)
            presetsTableView.deselectRow(at: indexPath, animated: true)
            
            //
            let tableHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            let tableWidth = UIScreen.main.bounds.width - 20
            //
            // Dismiss Presets Table
            //
            UIView.animate(withDuration: animationTime2, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: tableWidth, height: tableHeight)
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
            // Animate new Elements up
            UIView.animate(withDuration: animationTime3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.posesTableView.reloadData()
                let indexPath2 = NSIndexPath(row: 0, section: 0)
                self.posesTableView.scrollToRow(at: indexPath2 as IndexPath, at: .top, animated: true)
                //
                self.tableConstraint1.constant = 73.75
                self.tableConstraint.constant = 49.75
                //
                self.presetsConstraint.constant = self.view.frame.size.height - 73.25
                //
                self.beginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }, completion: { finished in
                //
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
        // Animation
        if demonstrationDictionary[imageIndex]?.count != 1 {
            var animationArray: [UIImage] = []
            for i in 1...(demonstrationDictionary[demonstrationIndex]?.count)! - 1 {
                animationArray.append(getUncachedImage(named: (demonstrationDictionary[demonstrationIndex]?[i])!)!)
            }
            //
            expandedImage.animationImages = animationArray
            expandedImage.animationDuration = Double(demonstrationDictionary[demonstrationIndex]!.count - 1) * 0.5
            expandedImage.animationRepeatCount = 1
            // Play
            let imagePress = UITapGestureRecognizer(target: self, action: #selector(imageSequenceAnimation))
            expandedImage.addGestureRecognizer(imagePress)
            //
            // Animate
            backgroundViewImage.addTarget(self, action: #selector(retractImage(_:)), for: .touchUpInside)
        }
        //
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewImage, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(expandedImage, aboveSubview: backgroundViewImage)
        //
        animateViewUp(animationView: expandedImage, backgroundView: backgroundViewImage)
    }
    
    // Retract image
    @IBAction func retractImage(_ sender: Any) {
        //
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        //
        UIView.animate(withDuration: animationTime2, animations: {
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
        if (segue.identifier == "yogaSessionSegue") {
            //
            let destinationVC = segue.destination as! YogaScreen
            
            // Ensure array in ascending order
            // Compress Arrays
            for i in practiceArray[selectedPreset[0]][selectedPreset[1]] {
                //
                yogaArray.append(yogaPosesDictionary[i]!)
                //
                demonstrationArray.append(demonstrationDictionary[i]!)
                //
                //targetAreaArray.append(targetAreaDictionary[i]!)
                //
                explanationArray.append(explanationDictionary[i]!)
            }
            //
            destinationVC.sessionArray = yogaArray
            destinationVC.breathsArray = breathsArray[selectedPreset[0]][selectedPreset[1]]
            destinationVC.demonstrationArray = demonstrationArray
            //destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionTitle = practiceTitlesArray[selectedPreset[0]][selectedPreset[1]]
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
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 73.5, width: self.view.frame.size.width, height: posesTableView.frame.size.height))
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
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 73.5 + posesTableView.frame.size.height, width: self.view.frame.size.width, height: 49))
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
            label.center = posesTableView.center
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
