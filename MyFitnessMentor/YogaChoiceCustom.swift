//
//  YogaChoiceCustom.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 31.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class YogaChoiceCustom: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    
    // Information View
    @IBOutlet weak var informationView: UIScrollView!
    
    // Information Title Label
    @IBOutlet weak var informationTitle: UILabel!
    
    // PickerViews
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    
    // Titles
    @IBOutlet weak var presetTitle: UILabel!
    
    @IBOutlet weak var tableTitle: UILabel!
    
    
    
    // Custom Buttons
    //
    @IBOutlet weak var addPreset: UIButton!
    @IBOutlet weak var removePreset: UIButton!
    //
    @IBOutlet weak var addPose: UIButton!
    @IBOutlet weak var removePose: UIButton!
    
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour3 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour4 = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
    
    
    
    // Is Enabled
    var beginButtonEnabled = 0
    
    
    
    //
    // Yoga Poses
    //
    let posesDictionary =
        [
            // Standing
            0: "upwardsSalute",
            1: "mountain",
            2: "tree",
            3: "extendedHandToe",
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
            21: "lungeY",
            22: "deepSquat",
            // Hand/Elbows and Feet/Knees
            23: "dolphin",
            24: "downwardDog",
            25: "halfDownwardDog",
            26: "plank",
            27: "dolphinPlank",
            28: "fourLimbedStaff",
            29: "sidePlank",
            30: "cat",
            31: "cow",
            32: "kowtow",
            33: "catBalance",
            34: "dynamicTiger",
            35: "halfMonkey",
            36: "childPose",            //
            37: "wildThing",
            38: "upwardBow",
            39: "bridge",
            40: "upwardPlank",
            41: "extendedPuppy",
            42: "upwardDog",
            43: "kneelingBridge",
            // Seated
            44: "crossLeg",
            45: "lotus",
            46: "fireLog",
            47: "boat",
            48: "cowFace",
            49: "hero",
            50: "heron",
            51: "butterfly",            //
            52: "staffPose",
            53: "archer",
            54: "forwardBend",
            55: "vForwardBend",
            56: "halfVForwardPose",
            57: "halfVSideBend",
            58: "marichi1",
            59: "marichi3",
            60: "bharadvajaTwist",
            61: "halfLordFish",
            62: "frontSplit",
            63: "sideSplit",
            // Lying
            64: "corpse",
            65: "lyingMountain",
            66: "fish",
            67: "lyingButterfly",
            68: "legRaiseToe",
            69: "threadTheNeedle",
            70: "shoulderStand",
            71: "plow",
            72: "frog",
            73: "cobra",
            74: "sphinx",
            75: "pigeon",
            76: "spineRolling",
            // Hand Stands
            77: "handstand",
            78: "headstand",
            79: "flatHandHandstand",
            80: "forearmStand"
            
    ]
    
    
    
    
    
    
    
    
    // Picker View Array
    let pickerViewArray =
        [
            "",
            "",
            "",
            "",
            ""
            
    ]
    
    
    // Preset Arrays
    let customArrayTitles = ["", ""]
    
    
    // Selected Array
    var selectedArray = [Int]()
    
    
    // Flash Screen
    func flashScreen() {
        
        let flash = UIView()
        
        flash.frame = CGRect(x: 0, y: pickerView.frame.maxY, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
            
            flash.alpha = 0
            
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
        
    }
    
    
    
    
    
    //
    // ViewDidLoad
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Colour
        self.view.applyGradient(colours: [colour1, colour2])
        questionMark.tintColor = colour1
        
        
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("custom", comment: ""))
        
        
        // Titles
        presetTitle.text = NSLocalizedString("customPractices", comment: "")
        tableTitle.text = NSLocalizedString("yogaTableTitle", comment: "")
        
        
        
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.setTitleColor(colour2, for: .normal)
        
        
        
        // Custom Buttons
        addPreset.tintColor = colour3
        removePreset.tintColor = colour3
        
        addPose.tintColor = colour3
        removePose.tintColor = colour3
        
        
        
        // Information
        // Scroll View Frame
        self.informationView.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        
        
        view.bringSubview(toFront: informationView)
        
        
        // Information Text
        //
        // Information Text Frame
        let informationText = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationView.frame.size.width - 40, height: 0))
        
        
        
        
        
        // Information Text Frame
        self.informationTitle.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 49)
        informationTitle.text = (NSLocalizedString("information", comment: ""))
        informationTitle.textAlignment = .center
        informationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitle.textColor = .white
        informationTitle.backgroundColor = colour2
        
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationTitle.addGestureRecognizer(downSwipe)
        informationTitle.isUserInteractionEnabled = true
        
        
        
        self.view.addSubview(informationTitle)
        
        
        
        // Information Text and Attributes
        //
        // String
        let informationLabelString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("warmupChoiceText", comment: "")))
        
        // Range of String
        let textRangeString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("warmupChoiceText", comment: "")))
        let textRange = (informationLabelString as NSString).range(of: textRangeString)
        
        
        // Range of Titles
        let titleRangeString = (NSLocalizedString("movements", comment: ""))
        let titleRange1 = (informationLabelString as NSString).range(of: titleRangeString)
        
        
        // Line Spacing
        let lineSpacing = NSMutableParagraphStyle()
        lineSpacing.lineSpacing = 1.4
        lineSpacing.hyphenationFactor = 1
        
        
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Light", size: 19)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange1)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        
        
        
        // Final Text Editing
        informationText.attributedText = informationLabelText
        informationText.textAlignment = .justified
        informationText.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationText.numberOfLines = 0
        informationText.sizeToFit()
        self.informationView.addSubview(informationText)
        
        
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationText.frame.size.height + informationTitle.frame.size.height + 20)
        
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        
        // Begin Button
        beginEnabled()
    }
    
    
    
    // Is Begin Button Enabled
    func beginEnabled() {
        
        if beginButtonEnabled == 0 {
            beginButton.isEnabled = false
        } else {
            beginButton.isEnabled = true
        }
    }
    
    
    
    // Picker Views
    //
    
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerViewArray.count
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let rowLabel = UILabel()
        let titleData = NSLocalizedString(pickerViewArray[row], comment: "")
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 20)!,NSForegroundColorAttributeName:UIColor.black])
        rowLabel.attributedText = myTitle
        rowLabel.textAlignment = .center
        return rowLabel
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        flashScreen()
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    // Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return customArrayTitles.count
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        //        let header = view as! UITableViewHeaderFooterView
        //        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)!
        //        header.textLabel?.textColor = colour3
        //        header.contentView.backgroundColor = colour1
        //        //
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.textLabel?.text = NSLocalizedString(customArrayTitles[indexPath.row], comment: "")
        
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = colour3
        cell.textLabel?.textColor = .black
        cell.tintColor = .black
        //
        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 47
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        
        for visibleCell in tableView.visibleCells where visibleCell != cell {
            visibleCell.accessoryType = .none
        }
        
        cell?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        // Enable Begin Button
        beginButtonEnabled = 1
        beginEnabled()
        
        
        
        // Selected Array
        //
        let i1 = pickerView.selectedRow(inComponent: 0)
        let i2 = indexPath.row
        
        //selectedArray = practiceArray[i1][i2]
    }
    
    
    
    
    
    
    
    
    
    // QuestionMark Button Action
    @IBAction func informationButtonAction(_ sender: Any) {
        
        if self.informationView.frame.minY < self.view.frame.maxY {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            self.informationView.contentOffset.y = 0
            
            
        } else {
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            self.informationView.contentOffset.y = 0
            
            
        }
        
    }
    
    
    
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.informationView.frame.minY < self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
                UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
                
            }
        }
    }
    
    
    
    
    
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        
        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            
            _ = self.navigationController?.popToRootViewController(animated: false)
            
        }
        
    }
    
    
    
    
    // Pass Array to next ViewController
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "warmupUpper") {
            
            
            
            let destinationNC = segue.destination as! UINavigationController
            
            let destinationVC = destinationNC.viewControllers.first as! YogaScreenPractices
            
            destinationVC.keyArray = selectedArray
            destinationVC.poses = posesDictionary
            
        }
    }
    
    
}
