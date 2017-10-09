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
    // Age
    var ageAnswer = ["16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "70+"]
    //
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Present walkthrough
        let walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
        switch selectedSection {
        case 0:
            if walkthroughs[8] == false {
                walkthroughProfileDetail()
            }
        case 1:
            if walkthroughs[9] == false {
                walkthroughProfileDetail()
            }
        case 2:
            if walkthroughs[10] == false {
                walkthroughProfileDetail()
            }
        default:
            break
        }
    }
    
    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return scheduleDataStructures.profileQA[selectedSection].count
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        return NSLocalizedString(scheduleDataStructures.profileQA[selectedSection][section][0], comment: "")
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
        header.textLabel?.adjustsFontSizeToFitWidth = true
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
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        //
        switch selectedSection {
        case 0:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            //
            cell.backgroundColor = colour1
            //
            if profileAnswers[selectedSection][indexPath.section] == -1 {
                cell.textLabel?.text = NSLocalizedString("answer", comment: "")
                cell.textLabel?.textColor = colour4
            } else {
                if indexPath.section != 0 {
                    // + 1 due as question in same array at 0
                    cell.textLabel?.text = NSLocalizedString(scheduleDataStructures.profileQA[selectedSection][indexPath.section][profileAnswers[selectedSection][indexPath.section] + 1], comment: "")
                } else {
                    cell.textLabel?.text = ageAnswer[profileAnswers[selectedSection][indexPath.section]]
                }
                
                cell.textLabel?.textColor = colour3
            }
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.textLabel?.textAlignment = .left
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
            let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
            let value = profileAnswers[selectedSection][indexPath.section]
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
            let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
            let value = profileAnswers[selectedSection - 1][indexPath.section]
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
        //
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        //
        selectedQuestion = indexPath.section
        answerPicker.reloadAllComponents()
        switch profileAnswers[selectedSection][selectedQuestion] {
        case -1:
            answerPicker.selectRow(0, inComponent: 0, animated: true)
        default:
            answerPicker.selectRow(profileAnswers[selectedSection][selectedQuestion], inComponent: 0, animated: true)
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
        if selectedQuestion != 0 {
            // -1 as question included with answers
            return scheduleDataStructures.profileQA[selectedSection][selectedQuestion].count - 1
        } else {
            return ageAnswer.count
        }
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        let answerLabel = UILabel()
        if selectedQuestion != 0 {
            // row + 1 as question included with answers
            answerLabel.text = NSLocalizedString(scheduleDataStructures.profileQA[selectedSection][selectedQuestion][row + 1], comment: "")
        } else {
            answerLabel.text = ageAnswer[row]
        }
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
        var profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        profileAnswers[selectedSection][selectedQuestion] = answerPicker.selectedRow(inComponent: 0)
        UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
        //
        animateActionSheetDown(actionSheet: answerView, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
        //
        let indexPath = NSIndexPath(row: 0, section: selectedQuestion)
        questionsTable.reloadRows(at: [indexPath as IndexPath], with: .automatic)
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
        //
        // Update Selected Value
        var profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        profileAnswers[selectedSection][sender.tag] = Int(roundedValue)
        UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")

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
    var walkthroughTexts = ["me0", "goals0", "nSessions0"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    // Walkthrough
    func walkthroughProfileDetail() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughProfileDetail), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
        // First has to be done differently
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[selectedSection], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = colour1
            walkthroughLabel.backgroundColor = colour2
            // Highlight
            if selectedSection != 0 {
                walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(0.5)
                walkthroughHighlight.layer.borderColor = colour2.cgColor
                walkthroughHighlight.frame.size = CGSize(width: view.bounds.width - 25, height: 47)
                walkthroughHighlight.center = CGPoint(x: ((view.frame.size.width - 30) / 2) + 12.5, y: CGFloat(TopBarHeights.combinedHeight) + 47 + (47 / 2))
                walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            } else {
                walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                walkthroughHighlight.layer.borderColor = colour1.cgColor
                walkthroughHighlight.frame.size = CGSize(width: 172, height: 33)
                walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: 40)
                walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            }
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                if self.selectedSection != 0 {
                    self.walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(1)
                } else {
                    self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
                }
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    if self.selectedSection != 0 {
                        self.walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(0.5)
                    } else {
                        self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                    }                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                var walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
                switch self.selectedSection {
                case 0:
                    walkthroughs[8] = true
                case 1:
                    walkthroughs[9] = true
                case 2:
                    walkthroughs[10] = true
                default: break
                }
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            })
        }
    //
}

    
}
