//
//  WarmupChoiceCustom.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 29.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class WarmupChoiceCustom: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //
    // Warmup Type
    //
    
    // Selected Warmup Type
    //
    var warmupType = Int()
    
    
    
    // Arrays -------------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // Changeable Arrays to be used
    //
    
    // Picker View Array
    var pickerViewArray = [String]()
    
    // TableView Section Array
    var tableViewSectionArray = [String]()
    
    // Presets
    var presetsArrays = [[[Int]]]()
    
    // Custom Presets
    // Empty Array
    var emptyArray = [[Int]]()
    
    
    // Screen Arrays
    // Sets Array
    var setsArrayF = [[Int]]()
    
    // Reps Array
    var repsArrayF = [[String]]()
    
    // Demonstration Array
    var demonstrationArrayF = [[UIImage]]()
    
    // Target Area Array
    var targetAreaArrayF = [[UIImage]]()
    
    // Explanation Array
    var explanationArrayF = [[String]]()
    
    
    
    
    // Static Arrays
    // Initial Custom Preset Texts
    var presetTexts = ["", "", ""]
    
    //
    // Warmup Arrays -------------------------------------------------------------------------------------------------------------------------------------------------------
    //
    
    
    var warmupPresetsCustom =
        [
            [], [], []
        ]
  
    
    // Warmup Movements Array
    var warmupMovementsArray =
        [
            // Cardio
            ["5minCardioL",
             "5minCardioI"],
            // Joint Rotations
            ["wrist",
             "elbow",
             "shoulder",
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
            // Lower Back
            ["sideLegDrop",
             "sideLegKick",
             "scorpionKick",
             "sideBend",
             "catCow"],
            // Shoulder
            ["wallSlides",
             "superManShoulder",
             "scapula",
             "shoulderRotation"],
            // Band/Bar/Machine Assisted
            ["facePull",
             "externalRotation",
             "internalRotation",
             "shoulderDislocation",
             "rearDeltFly",
             "latPullover"],
            // General Mobility
            ["rollBack",
             "hipCircles",
             "mountainClimber",
             "groinStretch",
             "gluteBridge",
             "threadTheNeedle",
             "butterflyPose",
             "cossakSquat",
             "hipHinges",
             "sideLegSwings",
             "frontLegSwings"],
            // Dynamic Warmup Drills
            ["jumpSquat",
             "lunge",
             "gluteKicks",
             "aSkips",
             "bSkips",
             "grapeVines",
             "lateralBound",
             "straightLegBound",
             "sprints"],
            // Accessory
            ["latStretch",
             "calveStretch",
             "pushUp",
             "pullUp"]
    ]
    
    // Demonstration Array
    var demonstrationArrayFull = [[UIImage]]()
    
    // Target Area Array
    var targetAreaArrayFull =
        [
            // Mandatory
            [#imageLiteral(resourceName: "Heart"),
             #imageLiteral(resourceName: "Heart")],
            // Joint Rotations
            [#imageLiteral(resourceName: "Wrist Joint"),
             #imageLiteral(resourceName: "Elbow Joint"),
             #imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Neck Joint"),
             #imageLiteral(resourceName: "Waist Joint"),
             #imageLiteral(resourceName: "Hip Joint"),
             #imageLiteral(resourceName: "Knee Joint"),
             #imageLiteral(resourceName: "Ankle Joint")],
            // Foam/Ball Roll
            [#imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Lat and Delt"),
             #imageLiteral(resourceName: "Pec and Front Delt"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Quad"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Glute"),
             #imageLiteral(resourceName: "Calf")],
            // Lower Back
            [#imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Spine")],
            // Shoulder
            [#imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Back and Shoulder"),
             #imageLiteral(resourceName: "Serratus"),
             #imageLiteral(resourceName: "Shoulder")],
            // Band/Bar/Machine Assisted
            [#imageLiteral(resourceName: "Upper Back and Shoulder"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Back")],
            // General Mobility
            [#imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Hip Area"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Piriformis"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Hamstring and Glute"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch")],
            // Dynamic Warm Up Drills
            [#imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat")],
            // Accessory
            [#imageLiteral(resourceName: "Lat"),
             #imageLiteral(resourceName: "Calf"),
             #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
             #imageLiteral(resourceName: "Back and Bicep")]
    ]
    
    // Explanation Array
    var explanationArrayFull =
        [
            // Mandatory
            ["5minCardioLE",
             "5minCardioIE"],
            // Joint Rotations
            ["wristE",
             "elbowE",
             "shoulderE",
             "neckE",
             "waistE",
             "hipE",
             "kneesE",
             "anklesE"],
            // Foam/Ball Roll
            ["backfE",
             "thoracicSpineE",
             "latE",
             "pecDeltE",
             "rearDeltE",
             "quadfE",
             "adductorfE",
             "hamstringfE",
             "glutefE",
             "calvefE"],
            // Back
            ["sideLegDropE",
             "sideLegKickE",
             "scorpionKickE",
             "sideBendE",
             "catCowE"],
            // Shoulder
            ["wallSlidesE",
             "superManShoulderE",
             "scapulaE",
             "shoulderRotationE"],
            // Band/Bar/Machine Assisted
            ["facePullE",
             "externalRotationE",
             "internalRotationE",
             "shoulderDislocationE",
             "rearDeltFlyE",
             "latPulloverE"],
            // General Mobility
            ["rollBackE",
             "hipCirclesE",
             "mountainClimberE",
             "groinStretchE",
             "gluteBridgeE",
             "threadTheNeedleE",
             "butterflyPoseE",
             "cossakSquatE",
             "hipHingesE",
             "sideLegSwingsE",
             "frontLegSwingsE"],
            // Dynamic Warm Up Drills
            ["jumpSquatE",
             "lungeE",
             "gluteKicksE",
             "aSkipsE",
             "bSkipsE",
             "grapeVinesE",
             "lateralBoundE",
             "straightLegBoundE",
             "sprintsE"],
            // Accessory
            ["latStretchE",
             "calveStretchE",
             "pushUpE",
             "pullUpE"]
    ]
    
    
    
    
    
    
    //
    // Outlets
    //
    
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
    
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour3 = UserDefaults.standard.color(forKey: "colour3")!
    let colour4 = UserDefaults.standard.color(forKey: "colour4")!
    let colour5 = UserDefaults.standard.color(forKey: "colour5")!
    let colour6 = UserDefaults.standard.color(forKey: "colour6")!
    let colour7 = UserDefaults.standard.color(forKey: "colour7")!
    let colour8 = UserDefaults.standard.color(forKey: "colour8")!
    
    
    // Add Preset
    @IBOutlet weak var addPreset: UIButton!
    @IBOutlet weak var removePreset: UIButton!
    
    
    let emptyString = ""
    
    
    
    
    
    
    
    
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
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2")
        }
        
        
        
        // Colour
        self.view.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        questionMark.tintColor = colour1
        
        
        
        // Navigation Bar Title
        navigationBar.title = NSLocalizedString("custom", comment: "")
        
        
        
        
        // Picker View Test
        pickerView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        
        
        
        
        
        
        
        
        // Plus Button Colour
        let origImage1 = UIImage(named: "Plus")
        let tintedImage1 = origImage1?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        addPreset.setImage(tintedImage1, for: .normal)
        
        //Image Tint
        //addPreset.tintColor = colour2
        addPreset.tintColor = colour3
        
        
        
        // Minus Button Colour
        let origImage2 = UIImage(named: "Minus")
        let tintedImage2 = origImage2?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        removePreset.setImage(tintedImage2, for: .normal)
        
        //Image Tint
        //removePreset.tintColor = colour2
        removePreset.tintColor = colour3
        
        
        
        
        
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
        lineSpacing.lineSpacing = 1.6
        lineSpacing.hyphenationFactor = 1
        
        
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-thin", size: 21)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 21)!, range: titleRange1)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        
        
        
        // Final Text Editing
        informationText.attributedText = informationLabelText
        informationText.textAlignment = .justified
        informationText.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationText.numberOfLines = 0
        informationText.sizeToFit()
        self.informationView.addSubview(informationText)
        
        
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationText.frame.size.height + informationTitle.frame.size.height + 20)
        
        
        
        
        
        
        
        // TableView Background
        let tableViewBackground = UIView()
            
        tableViewBackground.backgroundColor = colour7
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
            
        tableView.backgroundView = tableViewBackground
        
        // TableView Footer
        let footerView = UIView(frame: .zero)
        footerView.backgroundColor = .clear
        tableView.tableFooterView = footerView
            
        
        
        
        
        
        
        
        //
        // Preset Warmups
        //
        let defaults = UserDefaults.standard
        
        // Custom
        defaults.register(defaults: ["warmupPresetsCustom" : warmupPresetsCustom])
        defaults.register(defaults: ["warmupPresetTextsCustom" : presetTexts])
        defaults.register(defaults: ["warmupPresetNumberCustom" : 0])
        
        
        defaults.synchronize()
        
        
        
        //
        beginButtonEnabled()
        
    }
    
    
    // Button Enabled
    func beginButtonEnabled() {
        // Begin Button
        let defaults = UserDefaults.standard
        var warmupPreset = defaults.object(forKey: "warmupPresetsCustom") as! [Array<Array<Int>>]
        
        if warmupPreset[pickerView.selectedRow(inComponent: 0)].count == 0 {
            beginButton.isEnabled = false
        } else {
            beginButton.isEnabled = true
        }
        
        
    }
    
    
    
    
    
    
    
    
    // Set Personalized Preset
    //
    @IBAction func addPreset(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let number = defaults.integer(forKey: "warmupPresetNumberCustom")
        var warmupPreset = defaults.object(forKey: "warmupPresetsCustom") as! [Array<Array<Int>>]
        var presetTextArray = defaults.object(forKey: "warmupPresetTextsCustom") as! [String]
        
        
        // Set Preset
        if number < 3 {
            
            
            
            // Alert and Functions
            //
            let inputTitle = NSLocalizedString("warmupInputTitle", comment: "")
            //
            let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
            alert.view.tintColor = colour7
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
                defaults.set(presetTextArray, forKey: "warmupPresetTextsCustom")
                defaults.synchronize()
                
                
                
                // Increase Preset Counter
                //
                let newNumber = number + 1
                
                defaults.set(newNumber, forKey: "warmupPresetNumberCustom")
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
        let number = defaults.integer(forKey: "warmupPresetNumberCustom")
        var warmupPreset = defaults.object(forKey: "warmupPresetsCustom") as! [Array<Array<Int>>]
        var presetTextArray = defaults.object(forKey: "warmupPresetTextsCustom") as! [String]
        
        
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let index = (selectedRow) - (pickerViewArray.count + 1)
        
        
        if index > -1 {
            
            warmupPreset.remove(at: index)
            warmupPreset.append(emptyArray)
            
            defaults.set(warmupPreset, forKey: "warmupPresetsCustom")
            
            
            presetTextArray.remove(at: index)
            presetTextArray.append(emptyString)
            
            defaults.set(presetTextArray, forKey: "warmupPresetTextsCustom")
            
            
            if number > 0 {
                let newNumber = number - 1
                defaults.set(newNumber, forKey: "warmupPresetNumberCustom")
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
        
        return 3
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        switch row {
        case 0:
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
            let titleData = titleDataArray[0]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
            
            
        case 1:
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
            let titleData = titleDataArray[1]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
            
            
        case 2:
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
            let titleData = titleDataArray[2]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 24)!,NSForegroundColorAttributeName:UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
            
        default: return UIView()
        }
        
        return UIView()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let defaults = UserDefaults.standard
        
        switch row {
        //
        case 0:
            let fullArray = defaults.object(forKey: "warmupPresetsCustom") as! [Array<Array<Int>>]
            let array = fullArray[0]
            
            
            self.tableView.reloadData()
            flashScreen()
        //
        case 1:
            let fullArray = defaults.object(forKey: "warmupPresetsCustom") as! [Array<Array<Int>>]
            let array = fullArray[1]
            
            
            self.tableView.reloadData()
            flashScreen()
        //
        case 2:
            let fullArray = defaults.object(forKey: "warmupPresetsCustom") as! [Array<Array<Int>>]
            let array = fullArray[2]
            
            
            self.tableView.reloadData()
            flashScreen()
        //
        default:
            break
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    // Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaults = UserDefaults.standard
        return 0
//        let fullArray = defaults.object(forKey: "warmupPresetsCustom") as! [Array<Array<Int>>]
//        return fullArray[pickerView.selectedRow(inComponent: 0)].count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.textLabel?.text = NSLocalizedString(warmupMovementsArray[pickerView.selectedRow(inComponent: 0)][indexPath.row], comment: "")
        
        
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        cell.textLabel?.textColor = .black
        cell.tintColor = .black
        //
        
        
        
        // Cell Image
        cell.imageView?.image = #imageLiteral(resourceName: "Test")
        cell.imageView?.isUserInteractionEnabled = true
        
        // Image Tap
        let imageTap = UITapGestureRecognizer()
        imageTap.numberOfTapsRequired = 1
        imageTap.addTarget(self, action: #selector(handleTap))
        cell.imageView?.addGestureRecognizer(imageTap)
        
        
        
        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 72
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        beginButtonEnabled()
    }
    
    
    
    
    
    
    
    
    
    
    // QuestionMark Button Action
    @IBAction func informationButtonAction(_ sender: Any) {
        
        // Information Down
        if self.informationView.frame.minY < self.view.frame.maxY {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            self.informationView.contentOffset.y = 0
            
            
            // Buttons
            questionMark.image = #imageLiteral(resourceName: "QuestionMarkN")
            navigationBar.setHidesBackButton(false, animated: true)
            
            
            // Information Up
        } else {
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            self.informationView.contentOffset.y = 0
            
            
            // Buttons
            questionMark.image = #imageLiteral(resourceName: "Down")
            navigationBar.setHidesBackButton(true, animated: true)
            
            
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
                
                
                // Buttons
                questionMark.image = #imageLiteral(resourceName: "QuestionMarkN")
                navigationBar.setHidesBackButton(false, animated: true)
                
            }
        }
    }
    
    // Handle Tap
    //
    let expandedImage = UIImageView()
    let backgroundViewImage = UIButton()
    //
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        
        
        // Get Image
        let sender = extraTap.view as! UIImageView
        let image = sender.image
        // Get Image
        // let index = demonstrationImage.indexWhere
        
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        
        // Expanded Image
        //
        expandedImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: height/2)
        expandedImage.center.x = self.view.frame.size.width/2
        expandedImage.center.y = (height/2) * 2.5
        //
        expandedImage.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        expandedImage.contentMode = .scaleAspectFit
        expandedImage.isUserInteractionEnabled = true
        
        //expandedImage.image = demonstrationArrayF[section][row]
        expandedImage.image = #imageLiteral(resourceName: "Test 2")
        
        
        
        // Background View
        //
        backgroundViewImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: height)
        backgroundViewImage.backgroundColor = .black
        backgroundViewImage.alpha = 0
        
        backgroundViewImage.addTarget(self, action: #selector(retractImage(_:)), for: .touchUpInside)
        
        //
        self.questionMark.isEnabled = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewImage, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(expandedImage, aboveSubview: backgroundViewImage)
        
        
        
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.expandedImage.center.y = (height/2) * 1.5
            self.backgroundViewImage.alpha = 0.5
        }, completion: nil)
    }
    
    
    @IBAction func retractImage(_ sender: Any) {
        //
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.expandedImage.center.y = (height/2) * 2.5
            self.backgroundViewImage.alpha = 0
            
        }, completion: nil)
        
        //
        let delayInSeconds = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            //
            self.expandedImage.removeFromSuperview()
            self.backgroundViewImage.removeFromSuperview()
            self.questionMark.isEnabled = true
            self.navigationItem.setHidesBackButton(false, animated: true)
        }
    }
    
    
    
    
    
    
    
    
    
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        
        if UserDefaults.standard.string(forKey: "presentationStyle") == "detailed" {
            
            performSegue(withIdentifier: "warmupSessionSegue1", sender: nil)
            
        } else {
            
            performSegue(withIdentifier: "warmupSessionSegue2", sender: nil)
        }
        
        
        // Return background to homescreen
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            
            _ = self.navigationController?.popToRootViewController(animated: false)
            
        }
    }
    
    
    
    
//    // Pass Array to next ViewController
//    //
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "warmupSessionSegue1") {
//            
//            
//            let destinationNC = segue.destination as! UINavigationController
//            
//            let destinationVC = destinationNC.viewControllers.first as! WarmupScreen
//            
//            destinationVC.warmupMovementsArray = warmupMovementsArray
//            destinationVC.warmupMovementsSelectedArray = warmupSelectedArray
//            
//            
//            destinationVC.setsArrayF = setsArrayF
//            destinationVC.repsArrayF = repsArrayF
//            destinationVC.demonstrationArrayF = demonstrationArrayF
//            destinationVC.targetAreaArrayF = targetAreaArrayF
//            destinationVC.explanationArrayF = explanationArrayF
//            
//            
//        } else if (segue.identifier == "warmupSessionSegue2") {
//            
//            
//            let destinationNC = segue.destination as! UINavigationController
//            
//            let destinationVC = destinationNC.viewControllers.first as! WarmupScreenOverview
//            
//            destinationVC.warmupMovementsArray = warmupMovementsArray
//            destinationVC.warmupMovementsSelectedArray = warmupSelectedArray
//            
//            
//            destinationVC.setsArrayF = setsArrayF
//            destinationVC.repsArrayF = repsArrayF
//            destinationVC.demonstrationArrayF = demonstrationArrayF
//            destinationVC.targetAreaArrayF = targetAreaArrayF
//            destinationVC.explanationArrayF = explanationArrayF
//            
//            let pickerIndex = pickerView.selectedRow(inComponent: 0)
//            if pickerIndex < pickerViewArray.count - 1 {
//                destinationVC.warmupTitle = pickerViewArray[pickerIndex]
//            } else if pickerIndex > pickerViewArray.count - 1 {
//                let pickerArray = UserDefaults.standard.object(forKey: "warmupPresetTextsCustom") as! [String]
//                destinationVC.warmupTitle = pickerArray[pickerIndex - pickerViewArray.count]
//            }
//        }
//    }
//    
    
    
    
    
    
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
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight, width: self.view.frame.size.width, height: pickerView.frame.size.height))
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
            
            
            nextButton.isEnabled = false
            let delayInSeconds2 = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds2) {
                self.pickerView.selectRow(self.pickerViewArray.count, inComponent: 0, animated: true)
                self.nextButton.isEnabled = true
            }
            //
            // Picker View
            let delayInSeconds = 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.pickerView.selectRow(self.pickerViewArray.count, inComponent: 0, animated: true)
                self.nextButton.isEnabled = true
            }
            
            
            
            
            
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            
            
        //
        case 1:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + pickerView.frame.size.height, width: self.view.frame.size.width, height: tableView.frame.size.height))
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
            
            label.center = pickerView.center
            label.center.y = (UIApplication.shared.statusBarFrame.height/2) + pickerView.frame.size.height
            label.text = NSLocalizedString("choiceScreen22", comment: "")
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
            path.addRect(CGRect(x: 0, y:   UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + pickerView.frame.size.height + 24.5, width: 72 + 5, height: 72))
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
            
            label.center = pickerView.center
            label.center.y = (UIApplication.shared.statusBarFrame.height/2) + pickerView.frame.size.height
            label.text = NSLocalizedString("choiceScreen23", comment: "")
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
            path.addEllipse(in: CGRect(x: self.view.frame.size.width - 98, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + pickerView.frame.size.height, width: 98, height: 49))
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
            label.text = NSLocalizedString("choiceScreen24", comment: "")
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
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + pickerView.frame.size.height + tableView.frame.size.height, width: self.view.frame.size.height, height: 49))
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
            
            
            
            // Picker
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        case 5:
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
