//
//  YogaChoiceNormal.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 30.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class YogaChoicePractices: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour3 = UserDefaults.standard.color(forKey: "colour3")!
    let colour4 = UserDefaults.standard.color(forKey: "colour4")!
    let colour5 = UserDefaults.standard.color(forKey: "colour5")!
    let colour6 = UserDefaults.standard.color(forKey: "colour6")!
    let colour7 = UserDefaults.standard.color(forKey: "colour7")!
    let colour8 = UserDefaults.standard.color(forKey: "colour8")!
    

    
    
    
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
            "5 min",
            "10 min",
            "15 min",
            "30 min",
            "60 min"
            
        ]
    
    
    // Preset Arrays
    let practiceArrayTitles =
        [
            ["lit", "lit", "44"],
            ["noice", "vnoice"],
            ["wut", "pot"],
            ["qjf", "adjfa"],
            ["www", "Wkj", "35", "gsdfg"]
    
        ]
    
    
    let practiceArray =
        [
            [
            [1,2,3,4,5,6,7,8],
            [2,5,7,55,7,33,2],
            [3,4,4]
            ],
            
            [
            [1,2],
            [5,3]
            ],
            
            [
            [33,72],
            [34,24]
            ],
            
            [
            [3,4],
            [33,78]
            ],
            
            [
            [33,33,33],
            [9,8,7,6],
            [8,0,9],
            [67,6,7]
            ]
            
        ]
    
    // Selected Array
    var selectedArray = [Int]()
    
    // Selected Title
    var selectedTitle = Int()

    
    
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
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2y") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2y")
        }
        

        
        // Colour
        self.view.applyGradient(colours: [colour1, colour2])
        questionMark.tintColor = colour1
        
        
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("practices", comment: ""))
        
        
        // Titles
        presetTitle.text = NSLocalizedString("length", comment: "")
        tableTitle.text = NSLocalizedString("yogaTableTitle", comment: "")
        presetTitle.textColor = colour3
        tableTitle.textColor = colour3
        
    
        
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.setTitleColor(colour8, for: .normal)
        
        
        
        
        
        
        
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
        informationTitle.textColor = colour2
        informationTitle.backgroundColor = colour7
        
        
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
        
    
        selectedTitle = row
        
        
        flashScreen()
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    // Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return practiceArrayTitles[selectedTitle].count
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)!
//        header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
//        header.contentView.backgroundColor = colour7
//        //
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.textLabel?.text = NSLocalizedString(practiceArrayTitles[selectedTitle][indexPath.row], comment: "")
        
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
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
        
        selectedArray = practiceArray[i1][i2]
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
    
    
    
//---------------------------------------------------------------------------------------------------------------
    
    
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
        
        
        
        
        switch viewNumber {
        case 0:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: view.frame.size.width/2 - 80, y: UIApplication.shared.statusBarFrame.height, width: 160, height: 40))
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
            
            
            label.text = NSLocalizedString("choiceScreen21", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            
            
        //
        case 1:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49, width: self.view.frame.size.width, height: pickerView.frame.size.height))
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
            
            
            label.text = NSLocalizedString("choiceScreen22y", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        case 2:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 98 + pickerView.frame.size.height, width: self.view.frame.size.width, height: tableView.frame.size.height))
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
            
            label.center.y = pickerView.frame.minY + (navigationBarHeight * 2)
            
            label.text = NSLocalizedString("choiceScreen23y", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        case 3:

            //
            
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 98 + pickerView.frame.size.height + tableView.frame.size.height, width: self.view.frame.size.height, height: 49))
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
            
            
            label.text = NSLocalizedString("choiceScreen25", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        case 4:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width * 0.917, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
            
            
            label.text = NSLocalizedString("choiceScreen26", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        default: break
            
            
        }
        
        
    }
    
    
    
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    
    
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
        
    }

    
    
}
