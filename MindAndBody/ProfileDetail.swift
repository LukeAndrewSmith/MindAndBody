//
//  ProfileDetail.swift
//  MindAndBody
//
//  Created by Luke Smith on 10.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
class ProfileDetail: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //
    // MARK: Outlets --------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var navigationBar: UINavigationItem!
    //
    @IBOutlet weak var questionsTable: UITableView!
    //
    // Answer elements
    var selectedQuestion = Int()
    var answerView = UIView()
    var answerPicker = UIPickerView()
    var okButton = UIButton()
    var backgroundViewExpanded = UIButton()
    
    //
    var selectedSection = Int()
    
    // Arrays
    var titleArray: [String] = ["me", "goals", "numberSessions"]
    //
    var questionArray: [[String]] =
        [
            // Me
            ["This is a question about me", "This also is a question", "Hmm, tricky question", "Obvious question"],
            // Goals
            ["calm", "acceptance", "bodyShaping", "endurance", "strength", "flexibility", "postureJoints"],
            // Groups
            ["Body Group - Calm", "Body Group - Reduced Stress", "Body Group - Strength", "Body Group - Body Shaping"]
        ]
    // 
    var answerArray: [[[String]]] =
        [
            // Me
            [
                // Q1
                ["Possible Answer", "Also a possible answer", "Could be", "Definitely not"],
                // Q2
                ["Possible Answer2", "Also a possible answer", "Could be", "Definitely not"],
                // Q3
                ["Possible Answer3", "Also a possible answer", "Could be", "Definitely not"],
                // Q4
                ["Possible Answer4", "Also a possible answer", "Could be", "Definitely not"]
            ],
    ]
    //
    var sliderArray: [[Int]] =
    [
        [0,0,0,0,0,0,0],
        [0,0,0,0]
    ]
    //
    var selectedAnswerArray: [[Int]] =
        [
            // Me
            [-1, -1, -1, -1],
            // Goals
            [-1, -1, -1, -1],
            // Groups
            [-1, -1, -1, -1],
    ]

    
    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString(titleArray[selectedSection], comment: ""))
        
        // Table View
        questionsTable.tableFooterView = UIView()
        questionsTable.separatorStyle = .none
        questionsTable.backgroundColor = colour1
        
        // Answer Elements
        // view
        answerView.backgroundColor = colour2
        answerView.layer.cornerRadius = 15
        answerView.layer.masksToBounds = true
        answerView.frame.size = CGSize(width: view.bounds.width - 20, height: 147 + 49)
        // picker
        answerPicker.backgroundColor = colour2
        answerPicker.delegate = self
        answerPicker.dataSource = self
        answerPicker.frame = CGRect(x: 0, y: 0, width: answerView.bounds.width, height: 147)
        // ok
        okButton.backgroundColor = colour1
        okButton.setTitleColor(colour3, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        okButton.frame = CGRect(x: 0, y: 147, width: answerView.bounds.width, height: 49)
        //
        answerView.addSubview(answerPicker)
        answerView.addSubview(okButton)
        //
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //
    }
    
    
    
    
    //
    // Table View --------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionArray[selectedSection].count
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        return NSLocalizedString(questionArray[selectedSection][section], comment: "")
    }
    
    // Header Customization
    var didAdd1 = false
    var didAdd2 = false
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 22)!
        header.textLabel?.textColor = colour2
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        // Detail
        func createDetailLabel(section: Int) {
            let detailLabel = UILabel()
            detailLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)!
            detailLabel.textColor = colour2.withAlphaComponent(0.5)
            detailLabel.textAlignment = .right
            //
            if section == 0 {
                detailLabel.text = NSLocalizedString("mind", comment: "")
            } else if section == 2 {
                detailLabel.text = NSLocalizedString("body", comment: "")
            }
            //
            //
            detailLabel.sizeToFit()
            detailLabel.frame = CGRect(x: view.bounds.width - detailLabel.bounds.width - 15, y: (header.bounds.height - detailLabel.bounds.height) / 2, width: detailLabel.bounds.width, height: detailLabel.bounds.height)
            header.addSubview(detailLabel)
        }
        //
        if section == 0 {
            if didAdd1 == false {
                createDetailLabel(section: 0)
                didAdd1 = true
            }
        } else if section == 2 {
            if didAdd2 == false {
                createDetailLabel(section: 2)
                didAdd2 = true
            }
        }
        
        //
        header.contentView.backgroundColor = colour1
        
        let seperator = CALayer()
        seperator.frame = CGRect(x: 15, y: header.frame.size.height - 1, width: view.frame.size.width, height: 1)
        seperator.backgroundColor = colour2.cgColor
        seperator.opacity = 0.5
        header.layer.addSublayer(seperator)
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }

    
    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return 1
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        return 47
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        switch selectedSection {
        case 0:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            //
            cell.backgroundColor = colour1
            //
            if selectedAnswerArray[selectedSection][indexPath.section] == -1 {
                cell.textLabel?.text = "Answer"
            } else {
                cell.textLabel?.text = answerArray[selectedSection][indexPath.row][selectedAnswerArray[selectedSection][indexPath.section]]
            }
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.textLabel?.textAlignment = .left
            cell.textLabel? .textColor = colour2
            //
            // Border
            //        }
            //
            return cell
        //
        case 1:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            cell.backgroundColor = colour1
            //
            // Slider
            let slider = UISlider()
            cell.addSubview(slider)
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            // Colours
            slider.thumbTintColor = colour2
            slider.minimumTrackTintColor = colour3
            slider.maximumTrackTintColor = colour4
            // Frame
            slider.frame = CGRect(x: 45, y: (cell.bounds.height - slider.frame.height) / 2, width: view.frame.size.width - 60, height: slider.frame.height)
            // Values
            slider.minimumValue = 0
            slider.maximumValue = 3
            // Section tag
            slider.tag = indexPath.section
            //
            let value = sliderArray[selectedSection - 1][indexPath.section]
            slider.value = Float(value)
            //
            // Indicator Label
            cell.textLabel?.text = String(value)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
            cell.textLabel?.textColor = colour2

            //
            return cell
        //
        case 2:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            cell.selectionStyle = .none
            cell.backgroundColor = colour1
            //
            // Slider
            let slider = UISlider()
            cell.addSubview(slider)
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            // Frame
            slider.frame = CGRect(x: 45, y: (cell.bounds.height - slider.frame.height) / 2, width: view.frame.size.width - 60, height: slider.frame.height)
            // Values
            slider.minimumValue = 0
            slider.maximumValue = 10
            // Colours
            slider.thumbTintColor = colour4
            setSliderGradient(slider: slider)
            // Section tag
            slider.tag = indexPath.section
            //
            let value = sliderArray[selectedSection - 1][indexPath.section]
            slider.value = Float(value)
            //
            // Indicator Label
            cell.textLabel?.text = String(value)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
            cell.textLabel?.textColor = colour2
            //
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    // didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        switch indexPath.row {
//        case 4:
//            break
//        default:
//            // Selected section
//        }
        //
        selectedQuestion = indexPath.section
        switch selectedAnswerArray[selectedSection][selectedQuestion] {
        case -1:
            answerPicker.selectRow(0, inComponent: 0, animated: true)
        default:
            answerPicker.selectRow(selectedAnswerArray[selectedSection][selectedQuestion], inComponent: 0, animated: true)
            
        }
        //
        UIApplication.shared.keyWindow?.insertSubview(answerView, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: answerView)
        animateActionSheetUp(actionSheet: answerView, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    //
    // Picker View ----------------------------------------------------------------------------------------------------
    //
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answerArray[selectedSection][selectedQuestion].count
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        let answerLabel = UILabel()
        answerLabel.text = NSLocalizedString(answerArray[selectedSection][selectedQuestion][row], comment: "")
        answerLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        answerLabel.textColor = colour1
        //
        answerLabel.textAlignment = .center
        return answerLabel
        //
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 37
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
    
    
    // Background view expanded action
    // Add movement table background (dismiss table)
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        animateActionSheetDown(actionSheet: answerView, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
    }

    // OK Button
    //
    // Ok button action
    func okButtonAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        //
//        var restTimes = UserDefaults.standard.object(forKey: "restTimes") as! [Int]
        //
//        restTimes[selectedRow] = restTimesArray[restTimePicker.selectedRow(inComponent: 0)]
//        defaults.set(restTimes, forKey: "restTimes")
        //
//        defaults.synchronize()
        selectedAnswerArray[selectedSection][selectedQuestion] = answerPicker.selectedRow(inComponent: 0)
        //
        animateActionSheetDown(actionSheet: answerView, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
        //
        questionsTable.reloadData()
    }
    
    //
    // MARK: Slider Helpers -----------------------------------------------------------
    
    
    //
        // MARK: sliderValueChanged
    let step: Float = 1
    @IBAction func sliderValueChanged(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        //
        sliderArray[selectedSection - 1][sender.tag] = Int(roundedValue)
        //
        // Indicator
        let indexPath = NSIndexPath(row: 0, section: sender.tag)
        let cell = questionsTable.cellForRow(at: indexPath as IndexPath)
        cell?.textLabel?.text = String(Int(roundedValue))
        
        // Change thumbTintColor for groups
        if selectedSection == 2 {
            // Red, below and above suggested
            if roundedValue <= 2 || roundedValue >= 6 {
                sender.thumbTintColor = colour4
                // Green, suggested
            } else {
                sender.thumbTintColor = colour3
            }
        }
    }
    
    //
    // MARK: Set Slider Gradient
    //
    func setSliderGradient(slider:UISlider) {
        //
        // Gradient Layer
        let tgl = CAGradientLayer()
        let frame = CGRect(x: 0.0, y: 0.0, width: slider.bounds.width, height: 2 )
        tgl.frame = frame
        //
        tgl.colors = [colour4.cgColor,colour4.cgColor,colour3.cgColor,colour3.cgColor,colour4.cgColor,colour4.cgColor]
        tgl.locations = [0,0.2,0.3,0.5,0.6,1]
        tgl.endPoint = CGPoint(x: 1.0, y:  1.0)
        tgl.startPoint = CGPoint(x: 0.0, y:  1.0)
        
        UIGraphicsBeginImageContextWithOptions(tgl.frame.size, false, 0.0)
        tgl.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        slider.setMinimumTrackImage(image?.resizableImage(withCapInsets:.zero),  for: .normal)
        slider.setMaximumTrackImage(image?.resizableImage(withCapInsets:.zero),  for: .normal)
    }
    
    
}
