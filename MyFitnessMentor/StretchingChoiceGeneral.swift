//
//  StretchingChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 26.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class StretchingChoiceGeneral: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    
    // Add Preset
    @IBOutlet weak var addPreset: UIButton!
    @IBOutlet weak var removePreset: UIButton!
    
    var presetTexts = ["", "", ""]
    
    let emptyString = ""
    
    let emptyArray =
        [
            // Recommended
            [0,
             0],
            // Joint Rotations
            [0,
             0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Foam/Ball Roll
            [0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Back
            [0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Obliques(Sides)
            [0,
             0,
             0],
            // Neck
            [0,
             0,
             0,
             0,
             0,
             0],
            // Arms
            [0,
             0,
             0],
            // Pecs
            [0],
            // Shoulders
            [0,
             0,
             0,
             0,
             0,
             0],
            // Hips and Glutes
            [0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Calves
            [0],
            // Hamstrings
            [0,
             0,
             0,
             0,
             0,
             0],
            // Quads
            [0,
             0]
    ]
    
    var stretchingPresets =
        [
            [
                // Recommended
                [0,
                 0],
                // Joint Rotations
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Foam/Ball Roll
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Back
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Obliques(Sides)
                [0,
                 0,
                 0],
                // Neck
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Arms
                [0,
                 0,
                 0],
                // Pecs
                [0],
                // Shoulders
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Hips and Glutes
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Calves
                [0],
                // Hamstrings
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Quads
                [0,
                 0]
            ],
            [
                // Recommended
                [0,
                 0],
                // Joint Rotations
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Foam/Ball Roll
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Back
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Obliques(Sides)
                [0,
                 0,
                 0],
                // Neck
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Arms
                [0,
                 0,
                 0],
                // Pecs
                [0],
                // Shoulders
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Hips and Glutes
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Calves
                [0],
                // Hamstrings
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Quads
                [0,
                 0]
            ],
            [
                // Recommended
                [0,
                 0],
                // Joint Rotations
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Foam/Ball Roll
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Back
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Obliques(Sides)
                [0,
                 0,
                 0],
                // Neck
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Arms
                [0,
                 0,
                 0],
                // Pecs
                [0],
                // Shoulders
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Hips and Glutes
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Calves
                [0],
                // Hamstrings
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Quads
                [0,
                 0]
            ]
    ]
    
    
    
    // Stretching Upper Array
    var stretchingArray =
        [
            // Recommended
            ["5minCardioL",
             "5minCardioI"],
            // Joint Rotations
            ["wrist",
             "elbow",
             "shoulderR",
             "neckR",
             "waist",
             "hip",
             "knees",
             "ankles"],
            // Foam/Ball Roll
            ["backf",
             "thoracicSpine",
             "lat",
             "pecDelt",
             "rearDelt",
             "quadf",
             "adductorf",
             "hamstringf",
             "glutef",
             "calvef"],
            // Back
            ["catCow",
             "upwardsDog",
             "extendedPuppy",
             "childPose",
             "staffPose",
             "pelvicTilt",
             "kneeToChest",
             "legDrop",
             "seatedTwist",
             "legsWall"],
            // Obliques(Sides)
            ["sideLean",
             "extendedSideAngle",
             "seatedSide"],
            // Neck
            ["rearNeck",
             "rearNeckHand",
             "seatedLateral",
             "neckRotator",
             "scalene",
             "headRoll"],
            // Arms
            ["forearmStretch",
             "tricepStretch",
             "bicepStretch"],
            // Pecs
            ["pecStretch"],
            // Shoulders
            ["shoulderRoll",
             "behindBackTouch",
             "frontDelt",
             "lateralDelt",
             "rearDelt",
             "rotatorCuff"],
            // Hips and Glutes
            ["squatHold",
             "groinStretch",
             "butterflyPose",
             "lungeStretch",
             "threadTheNeedle",
             "pigeonPose",
             "seatedGlute"],
            // Calves
            ["calveStretch"],
            // Hamstrings
            ["standingHamstring",
             "standingOneLegHamstring",
             "singleLegStanding",
             "downWardsDog",
             "singleLegHamstring",
             "twoLegHamstring"],
            // Quads
            ["lungeStretchWall",
             "lyingQuadStretch"]
    ]
    
    
    // Default Stretching Selected Array
    var stretchingSelectedArray =
        [
            // Recommended
            [1,
             0],
            // Joint Rotations
            [0,
             0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Foam/Ball Roll
            [0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Back
            [0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Obliques(Sides)
            [0,
             0,
             0],
            // Neck
            [0,
             0,
             0,
             0,
             0,
             0],
            // Arms
            [0,
             0,
             0],
            // Pecs
            [0],
            // Shoulders
            [0,
             0,
             0,
             0,
             0,
             0],
            // Hips and Glutes
            [0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Calves
            [0],
            // Hamstrings
            [0,
             0,
             0,
             0,
             0,
             0],
            // Quads
            [0,
             0]
    ]
    
    // Picker View Array
    var pickerViewArray =
        [
            "default",
            "beginner",
            "bodyWeight",
            "bodybuilding",
            "strength",
            "highIntensity",
            "quick"
            
    ]
    
    // Table View Section Title Array
    var tableViewSectionArray =
        [
            "recommended",
            "jointRotation",
            "foamRoll",
            "backStretch",
            "sides",
            "neck",
            "arms",
            "pecs",
            "shoulders",
            "hipsaGlutes",
            "calves",
            "hamstrings",
            "quads"
    ]
    
    
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
        navigationBar.title = (NSLocalizedString("stretching", comment: ""))
        
        
        
        // Titles
        presetTitle.text = NSLocalizedString("presetSessions", comment: "")
        tableTitle.text = NSLocalizedString("stretches", comment: "")
        
        
        
        // Plus Button Colour
        let origImage1 = UIImage(named: "Plus")
        let tintedImage1 = origImage1?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        addPreset.setImage(tintedImage1, for: .normal)
        
        //Image Tint
        addPreset.tintColor = colour2
        
        
        
        // Minus Button Colour
        let origImage2 = UIImage(named: "Minus")
        let tintedImage2 = origImage2?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        removePreset.setImage(tintedImage2, for: .normal)
        
        //Image Tint
        removePreset.tintColor = colour2
        
        
        
        
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.setTitleColor(colour2, for: .normal)
        
        
        
        
        
        
        
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
        let informationLabelString = (
            (NSLocalizedString("purpose", comment: ""))+"\n"+(NSLocalizedString("purposeTextStretching", comment: ""))+"\n"+"\n"+(NSLocalizedString("body", comment: ""))+"\n"+(NSLocalizedString("bodyTextStretching", comment: ""))+"\n"+"\n"+(NSLocalizedString("mind", comment: ""))+"\n"+(NSLocalizedString("mindTextStretching", comment: "")))
        
        // Range of String
        let textRangeString = (NSLocalizedString("purpose", comment: ""))+"\n"+(NSLocalizedString("purposeTextStretching", comment: ""))+"\n"+"\n"+(NSLocalizedString("body", comment: ""))+"\n"+(NSLocalizedString("bodyTextStretching", comment: ""))+"\n"+"\n"+(NSLocalizedString("mind", comment: ""))+"\n"+(NSLocalizedString("mindTextStretching", comment: ""))
        let textRange = (informationLabelString as NSString).range(of: textRangeString)
        
        
        // Range of Titles
        let titleRangeString1 = (NSLocalizedString("purpose", comment: ""))
        let titleRangeString2 = (NSLocalizedString("body", comment: ""))
        let titleRangeString3 = (NSLocalizedString("mind", comment: ""))
        
        let titleRange1 = (informationLabelString as NSString).range(of: titleRangeString1)
        let titleRange2 = (informationLabelString as NSString).range(of: titleRangeString2)
        let titleRange3 = (informationLabelString as NSString).range(of: titleRangeString3)
        
        
        // Line Spacing
        let lineSpacing = NSMutableParagraphStyle()
        lineSpacing.lineSpacing = 1.4
        lineSpacing.hyphenationFactor = 1
        
        
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Light", size: 19)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange1)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange2)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange3)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        
        
        
        // Final Text Editing
        informationText.attributedText = informationLabelText
        informationText.textAlignment = .justified
        informationText.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationText.numberOfLines = 0
        informationText.sizeToFit()
        self.informationView.addSubview(informationText)
        
        
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationText.frame.size.height + informationTitle.frame.size.height + 20)
        
        
        
        
        
        
        //
        // Preset Stretchings
        //
        let defaults = UserDefaults.standard
        
        defaults.register(defaults: ["stretchingPresetsGeneral" : stretchingPresets])
        defaults.register(defaults: ["stretchingPresetTextsGeneral" : presetTexts])
        defaults.register(defaults: ["stretchingPresetNumberGeneral" : 0])
        
        defaults.synchronize()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    // Set Personalized Preset
    //
    @IBAction func addPreset(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let number = defaults.integer(forKey: "stretchingPresetNumberGeneral")
        var stretchingPreset = defaults.object(forKey: "stretchingPresetsGeneral") as! [Array<Array<Int>>]
        var presetTextArray = defaults.object(forKey: "stretchingPresetTextsGeneral") as! [String]
        
        
        // Set Preset
        if number < 3 {
            
            
            
            // Alert and Functions
            //
            let inputTitle = NSLocalizedString("stretchingInputTitle", comment: "")
            //
            let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
            alert.view.tintColor = colour1
            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.text = " "
                textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
            }
            
            // 3. Get the value from the text field, and perform actions when OK clicked.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0]
                
                
                
                
                // Update Preset Text Arrays
                presetTextArray[number] = (textField?.text)!
                defaults.set(presetTextArray, forKey: "stretchingPresetTextsGeneral")
                defaults.synchronize()
                
                
                
                
                
                // Set new Preset Array
                //
                stretchingPreset[number] = self.stretchingSelectedArray
                defaults.set(stretchingPreset, forKey: "stretchingPresetsGeneral")
                
                defaults.synchronize()
                
                
                // Increase Preset Counter
                //
                let newNumber = number + 1
                
                defaults.set(newNumber, forKey: "stretchingPresetNumberGeneral")
                defaults.synchronize()
                
                
                
                // Flash Screen
                self.flashScreen()
                self.pickerView.reloadAllComponents()
                self.tableView.reloadData()
                
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
            
            
            
            
            
            
        } else {
            
        }
    }
    
    
    
    
    // Remove Personalized Preset
    @IBAction func removePreset(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let number = defaults.integer(forKey: "stretchingPresetNumberGeneral")
        var stretchingPreset = defaults.object(forKey: "stretchingPresetsGeneral") as! [Array<Array<Int>>]
        var presetTextArray = defaults.object(forKey: "stretchingPresetTextsGeneral") as! [String]
        
        
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let index = (selectedRow) - (pickerViewArray.count + 1)
        
        
        if index > -1 {
            
            stretchingPreset.remove(at: index)
            stretchingPreset.append(emptyArray)
            
            defaults.set(stretchingPreset, forKey: "stretchingPresetsGeneral")
            
            
            presetTextArray.remove(at: index)
            presetTextArray.append(emptyString)
            
            defaults.set(presetTextArray, forKey: "stretchingPresetTextsGeneral")
            
            
            if number > 0 {
                let newNumber = number - 1
                defaults.set(newNumber, forKey: "stretchingPresetNumberGeneral")
            } else {
                
            }
            
            
            
            
            defaults.synchronize()
            
            
            
            
            // Flash Screen
            self.flashScreen()
            self.pickerView.reloadAllComponents()
            self.tableView.reloadData()
            
        } else {
            
        }
    }
    
    
    
    
    
    
    // Picker Views
    //
    
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerViewArray.count + 4
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if row < pickerViewArray.count {
            let rowLabel = UILabel()
            let titleData = NSLocalizedString(pickerViewArray[row], comment: "")
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 20)!,NSForegroundColorAttributeName:UIColor.black])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
        } else if row == pickerViewArray.count {
            
            let line = UILabel()
            line.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width / 2, height: 1)
            line.backgroundColor = .black
            line.isEnabled = false
            return line
            
            
        } else if row == pickerViewArray.count + 1 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsGeneral") as! [String]
            let titleData = titleDataArray[0]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 20)!,NSForegroundColorAttributeName:UIColor.black])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
            
            
        } else if row == pickerViewArray.count + 2 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsGeneral") as! [String]
            let titleData = titleDataArray[1]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 20)!,NSForegroundColorAttributeName:UIColor.black])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
            
            
        } else if row == pickerViewArray.count + 3 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: "stretchingPresetTextsGeneral") as! [String]
            let titleData = titleDataArray[2]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 20)!,NSForegroundColorAttributeName:UIColor.black])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
        }
        
        return UIView()
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let defaults = UserDefaults.standard
        
        switch row {
            
        case 0:
            stretchingSelectedArray =
                [
                    // Recommended
                    [1,
                     0],
                    // Joint Rotations
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Foam/Ball Roll
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Back
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Obliques(Sides)
                    [0,
                     0,
                     0],
                    // Neck
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Arms
                    [0,
                     0,
                     0],
                    // Pecs
                    [0],
                    // Shoulders
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Hips and Glutes
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Calves
                    [0],
                    // Hamstrings
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Quads
                    [0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 1:
            stretchingSelectedArray =
                [
                    // Recommended
                    [1,
                     0],
                    // Joint Rotations
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Foam/Ball Roll
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Back
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Obliques(Sides)
                    [0,
                     0,
                     0],
                    // Neck
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Arms
                    [0,
                     0,
                     0],
                    // Pecs
                    [0],
                    // Shoulders
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Hips and Glutes
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Calves
                    [0],
                    // Hamstrings
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Quads
                    [0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 2:
            stretchingSelectedArray =
                [
                    // Recommended
                    [1,
                     0],
                    // Joint Rotations
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Foam/Ball Roll
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Back
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Obliques(Sides)
                    [0,
                     0,
                     0],
                    // Neck
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Arms
                    [0,
                     0,
                     0],
                    // Pecs
                    [0],
                    // Shoulders
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Hips and Glutes
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Calves
                    [0],
                    // Hamstrings
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Quads
                    [0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 3:
            stretchingSelectedArray =
                [
                    // Recommended
                    [1,
                     0],
                    // Joint Rotations
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Foam/Ball Roll
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Back
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Obliques(Sides)
                    [0,
                     0,
                     0],
                    // Neck
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Arms
                    [0,
                     0,
                     0],
                    // Pecs
                    [0],
                    // Shoulders
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Hips and Glutes
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Calves
                    [0],
                    // Hamstrings
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Quads
                    [0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 4:
            stretchingSelectedArray =
                [
                    // Recommended
                    [1,
                     0],
                    // Joint Rotations
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Foam/Ball Roll
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Back
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Obliques(Sides)
                    [0,
                     0,
                     0],
                    // Neck
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Arms
                    [0,
                     0,
                     0],
                    // Pecs
                    [0],
                    // Shoulders
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Hips and Glutes
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Calves
                    [0],
                    // Hamstrings
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Quads
                    [0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 5:
            stretchingSelectedArray =
                [
                    // Recommended
                    [1,
                     0],
                    // Joint Rotations
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Foam/Ball Roll
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Back
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Obliques(Sides)
                    [0,
                     0,
                     0],
                    // Neck
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Arms
                    [0,
                     0,
                     0],
                    // Pecs
                    [0],
                    // Shoulders
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Hips and Glutes
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Calves
                    [0],
                    // Hamstrings
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Quads
                    [0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 6:
            stretchingSelectedArray =
                [
                    // Recommended
                    [1,
                     0],
                    // Joint Rotations
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Foam/Ball Roll
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Back
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Obliques(Sides)
                    [0,
                     0,
                     0],
                    // Neck
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Arms
                    [0,
                     0,
                     0],
                    // Pecs
                    [0],
                    // Shoulders
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Hips and Glutes
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Calves
                    [0],
                    // Hamstrings
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Quads
                    [0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 7:
            break
            
        case 8:
            let fullArray = defaults.object(forKey: "stretchingPresetsGeneral") as! [Array<Array<Int>>]
            let array = fullArray[0]
            stretchingSelectedArray = array
            
            
            self.tableView.reloadData()
            flashScreen()
            
        case 9:
            let fullArray = defaults.object(forKey: "stretchingPresetsGeneral") as! [Array<Array<Int>>]
            let array = fullArray[1]
            stretchingSelectedArray = array
            
            
            self.tableView.reloadData()
            flashScreen()
            
        case 10:
            let fullArray = defaults.object(forKey: "stretchingPresetsGeneral") as! [Array<Array<Int>>]
            let array = fullArray[2]
            stretchingSelectedArray = array
            
            
            self.tableView.reloadData()
            flashScreen()
            
        default:
            break
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    // Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stretchingArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(tableViewSectionArray[section], comment: "")
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)!
        header.textLabel?.textColor = .black
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        header.contentView.tintColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stretchingArray[section].count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.textLabel?.text = NSLocalizedString(stretchingArray[indexPath.section][indexPath.row], comment: "")
        
        cell.textLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = .clear
        cell.tintColor = .black
        
        
        if stretchingSelectedArray[indexPath.section][indexPath.row] == 1 {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        
        if cell.textLabel?.text == NSLocalizedString("5minCardioL", comment: "") {
            cell.isUserInteractionEnabled = false
        }
        if cell.textLabel?.text == NSLocalizedString("5minCardioI", comment: "") {
            cell.isUserInteractionEnabled = false
        }
        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 47
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            stretchingSelectedArray[indexPath.section][indexPath.row] = 0
        } else {
            cell?.accessoryType = .checkmark
            stretchingSelectedArray[indexPath.section][indexPath.row] = 1
        }
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
        if (segue.identifier == "stretchingGeneral") {
            
            
            let destinationNC = segue.destination as! UINavigationController
            
            let destinationVC = destinationNC.viewControllers.first as! StretchingScreenGeneral
            
            destinationVC.stretchingMovementsArray = stretchingArray
            destinationVC.stretchingMovementsSelectedArray = stretchingSelectedArray
            
        }
    }
    
    
}
