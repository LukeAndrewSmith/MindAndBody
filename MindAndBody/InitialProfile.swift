////
////  InitialProfile.swift
////  MindAndBody
////
////  Created by Luke Smith on 14.10.17.
////  Copyright © 2017 Luke Smith. All rights reserved.
////
//
//import Foundation
//import UIKit
//
////
//// Custom Cells
//class InitialProfileAgeCell: UITableViewCell {
//    @IBOutlet weak var questionLabel: UILabel!
//    @IBOutlet weak var agePicker: UIPickerView!
//}
//
//class InitialProfileDefaultCell: UITableViewCell {
//    @IBOutlet weak var questionLabel: UILabel!
//    @IBOutlet weak var demonstrationImageView: UIImageView!
//    @IBOutlet weak var answerTableView: UITableView!
//
//}
//
////
//// Initial Profile Class
//class InitialProfile: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
//
//
//
//
//    //
//    // MARK: Outlets --------------------------------------------------------------------------------------------------------
//    //
//
//    @IBOutlet weak var questionsTable: UITableView!
//    //
//    // Answer elements
//    var selectedQuestion = Int()
//    // Age Picker
//    var stackViewAge = UIStackView()
//    var agePicker = UIPickerView()
//    // Answer Table
//    var stackViewQA = UIStackView()
//    var answerLabelQuestion = UILabel()
//    var answerImageView = UIImageView()
//    var answerTableView = UITableView()
//    //
//    let progressBar = UIProgressView()
//    //
//    // Age
//    var ageAnswer = ["16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "70+"]
//    // Answer Images
//    var answerImageArray = ["standingHamstring", "butterfly", "deepSquat", "hero", "upwardDog", "neckRotatorStretch", "tree"]
//
//    //
//    // Viewdidload --------------------------------------------------------------------------------------------------------
//    //
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //
//        // Table View
//        questionsTable.tableFooterView = UIView()
//        questionsTable.separatorStyle = .none
//        questionsTable.backgroundColor = colour1
//
//        // Answer Elements 1 - Age Picker
//        // picker
//        agePicker.backgroundColor = colour2
//        agePicker.delegate = self
//        agePicker.dataSource = self
//        agePicker.frame = CGRect(x: 0, y: 0, width: stackViewAge.bounds.width, height: 147)
//        //
//        // Ansewr Elements 2 - Questions
//        //
//        // Table View
//        answerTableView.dataSource = self
//        answerTableView.delegate = self
//        answerTableView.frame.size = CGSize(width: view.bounds.width - 20, height: 147)
//        answerTableView.layer.cornerRadius = 15
//        answerTableView.layer.masksToBounds = true
//        answerTableView.tableFooterView = UIView()
//        answerTableView.backgroundColor = colour2
//        answerTableView.separatorColor = colour1.withAlphaComponent(0.5)
//        answerTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        // Answer Image
//        answerImageView.backgroundColor = colour2
//        answerImageView.layer.cornerRadius = 15
//        answerImageView.clipsToBounds = true
//        answerImageView.frame.size = CGSize(width: view.bounds.width - 20, height: view.bounds.width - 20)
//        // Answer Question
//        answerLabelQuestion.font = UIFont(name: "SFUIDisplay-thin", size: 23)
//        answerLabelQuestion.textColor = colour1
//        answerLabelQuestion.frame.size = CGSize(width: view.bounds.width - 20, height: 49)
//        answerLabelQuestion.layer.cornerRadius = 15
//        answerLabelQuestion.clipsToBounds = true
//        answerLabelQuestion.backgroundColor = colour2
//        answerLabelQuestion.lineBreakMode = .byWordWrapping
//        answerLabelQuestion.numberOfLines = 2
//        answerLabelQuestion.adjustsFontSizeToFitWidth = true
//        //
//
//        //
//        // Progress Bar
//        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
//        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
//        progressBar.trackTintColor = colour1
//        progressBar.progressTintColor = colour3
//        progressBar.setProgress(0, animated: true)
//    }
//
//
//    //
//    // Table View --------------------------------------------------------------------------------------------------------
//    //
//    // Number of sections
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    // Header
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        //
//        if tableView == questionsTable {
//
//        } else if tableView == answerTableView {
//            return ""
//        }
//        return ""
//    }
//
//    // Header Customization
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        //
//        let header = view as! UITableViewHeaderFooterView
//        header.contentView.backgroundColor = colour1
//        //
//        if section == 0 {
//            //
//            if header.subviews.contains(progressBar) == false {
//                header.addSubview(progressBar)
//            }
//        }
//    }
//
//    // Header Height
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        //
//        if tableView == questionsTable {
//            return 2
//        } else if tableView == answerTableView {
//            return 0
//        }
//        return 0
//    }
//
//
//    // Number of row
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //
//        if tableView == questionsTable {
//            let count = scheduleDataStructures.profileQA[0].count + scheduleDataStructures.profileQA[1].count + scheduleDataStructures.profileQA[2].count
//            return count
//        } else if tableView == answerTableView {
//            // Answers.count - 1 as question included in array
//            return scheduleDataStructures.profileQA[0].count - 1
//        }
//        return 0
//    }
//
//    // Height for row
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        //
//        if tableView == questionsTable {
//            return 47
//        } else if tableView == answerTableView {
//            return 49
//        }
//        return 0
//    }
//
//    // Cell for row
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //
//        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
//        // Switch, me, goals, sessions
//        switch selectedSection {
//        // Me
//        case 0:
//            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//            // Question Table
//            if tableView == questionsTable {
//                cell.backgroundColor = colour1
//                //
//                if profileAnswers[selectedSection][indexPath.section] == -1 {
//                    cell.textLabel?.text = NSLocalizedString("answer", comment: "")
//                    cell.textLabel?.textColor = colour4
//                } else {
//                    if indexPath.section != 0 {
//                        // + 1 due as question in same array at 0
//                        cell.textLabel?.text = NSLocalizedString(scheduleDataStructures.profileQA[selectedSection][indexPath.section][profileAnswers[selectedSection][indexPath.section] + 1], comment: "")
//                    } else {
//                        cell.textLabel?.text = ageAnswer[profileAnswers[selectedSection][indexPath.section]]
//                    }
//                    cell.textLabel?.textColor = colour3
//                }
//                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
//                // Answer table
//            } else if tableView == answerTableView {
//                cell.backgroundColor = colour2
//                cell.tintColor = colour3
//                cell.textLabel?.textColor = .white
//                cell.textLabel?.textAlignment = .center
//                // row + 1 as question included with answers
//                cell.textLabel?.text = NSLocalizedString(scheduleDataStructures.profileQA[selectedSection][selectedQuestion][indexPath.row + 1], comment: "")
//                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
//                // Select answer
//                if profileAnswers[selectedSection][selectedQuestion] != -1 && indexPath.row == profileAnswers[selectedSection][selectedQuestion] {
//                    cell.textLabel?.textColor = colour3
//                }
//            }
//            //
//            return cell
//        // Goals
//        case 1:
//            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//            cell.selectionStyle = .none
//            cell.backgroundColor = colour1
//            //
//            // Slider
//            let slider = UISlider()
//            cell.addSubview(slider)
//            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
//            // Colours
//            slider.thumbTintColor = colour2
//            slider.minimumTrackTintColor = colour3
//            slider.maximumTrackTintColor = colour4
//            // Frame
//            slider.frame = CGRect(x: 45, y: (cell.bounds.height - slider.frame.height) / 2, width: view.frame.size.width - 60, height: slider.frame.height)
//            // Values
//            slider.minimumValue = 0
//            slider.maximumValue = 3
//            // Section tag
//            slider.tag = indexPath.section
//            //
//            let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
//            let value = profileAnswers[selectedSection][indexPath.section]
//            slider.value = Float(value)
//            //
//            // Indicator Label
//            cell.textLabel?.text = String(value)
//            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
//            cell.textLabel?.textColor = colour2
//
//            //
//            return cell
//        // Session
//        case 2:
//            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//            //
//            cell.selectionStyle = .none
//            cell.backgroundColor = colour1
//            //
//            // Slider
//            let slider = UISlider()
//            cell.addSubview(slider)
//            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
//            // Frame
//            slider.frame = CGRect(x: 45, y: (cell.bounds.height - slider.frame.height) / 2, width: view.frame.size.width - 60, height: slider.frame.height)
//            // Values
//            slider.minimumValue = 0
//            slider.maximumValue = 10
//            // Colours
//            slider.thumbTintColor = colour4
//            setSliderGradient(slider: slider)
//            // Section tag
//            slider.tag = indexPath.section
//            //
//            let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
//            let value = profileAnswers[selectedSection - 1][indexPath.section]
//            slider.value = Float(value)
//            //
//            // Indicator Label
//            cell.textLabel?.text = String(value)
//            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 20)
//            cell.textLabel?.textColor = colour2
//            //
//            return cell
//        default:
//            return UITableViewCell()
//        }
//    }
//
//
//    // didSelectRow
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // Only perform action if me section
//        if selectedSection == 0 {
//            // Question, present answers
//            if tableView == questionsTable {
//                //
//                let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
//                selectedQuestion = indexPath.section
//                //
//                switch indexPath.section {
//                // Age Picker
//                case 0:
//                    agePicker.reloadAllComponents()
//                    switch profileAnswers[selectedSection][selectedQuestion] {
//                    case -1:
//                        agePicker.selectRow(0, inComponent: 0, animated: true)
//                    default:
//                        agePicker.selectRow(profileAnswers[selectedSection][selectedQuestion], inComponent: 0, animated: true)
//                    }
//                    //
//                    UIApplication.shared.keyWindow?.insertSubview(answerView, aboveSubview: view)
//                    UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: answerView)
//                    animateActionSheetUp(actionSheet: answerView, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
//                // Answer Table with image (flexibility questions)
//                case 2,3,4,5,6,7,8:
//                    answerTableView.reloadData()
//                    // Question
//                    answerLabelQuestion.text = " " + NSLocalizedString(scheduleDataStructures.profileQA[selectedSection][selectedQuestion][0], comment: "")
//                    answerLabelQuestion.sizeToFit()
//                    answerLabelQuestion.frame = CGRect(x: 0, y: 0, width: view.frame.size.width - 20, height: answerLabelQuestion.frame.size.height)
//                    // Image
//                    // -2 as first question that requires image is index path 2
//                    answerImageView.image = getUncachedImage(named: answerImageArray[selectedQuestion - 2])
//                    answerImageView.frame = CGRect(x: 0, y: answerViewQuestion.bounds.height + 10, width: answerView2.bounds.width, height: view.bounds.width - 20)
//                    answerImageView.alpha = 1
//                    // AnswerTable
//                    answerTableView.frame = CGRect(x: 0, y: answerLabelQuestion.bounds.height + 10 + answerImageView.bounds.height + 10, width: answerTableView.bounds.width, height: answerTableView.bounds.height)
//                    //
//                    let totalHeight = answerLabelQuestion.bounds.height + 10 + answerImageView.bounds.height + 10 + 147
//                    UIApplication.shared.keyWindow?.insertSubview(answerView2, aboveSubview: view)
//                    UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: answerView2)
//                    animateActionSheetUp(actionSheet: answerView2, actionSheetHeight: totalHeight, backgroundView: backgroundViewExpanded)
//                // Answer Table
//                default:
//                    answerTableView.reloadData()
//                    // Question
//                    answerLabelQuestion.text = " " + NSLocalizedString(scheduleDataStructures.profileQA[selectedSection][selectedQuestion][0], comment: "")
//                    answerLabelQuestion.sizeToFit()
//                    answerLabelQuestion.frame = CGRect(x: 0, y: 0, width: view.frame.size.width - 20, height: answerLabelQuestion.frame.size.height)                        // Image
//                    answerImageView.frame.size = CGSize(width: view.bounds.width - 20, height: 0)
//                    answerImageView.alpha = 0
//                    // AnsweTable
//                    answerTableView.frame = CGRect(x: 0, y: answerLabelQuestion.bounds.height + 10, width: answerTableView.bounds.width, height: answerTableView.bounds.height)
//                    //
//                    let totalHeight = answerLabelQuestion.bounds.height + 10 + 147
//                    UIApplication.shared.keyWindow?.insertSubview(answerView2, aboveSubview: view)
//                    UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: answerView2)
//                    animateActionSheetUp(actionSheet: answerView2, actionSheetHeight: totalHeight, backgroundView: backgroundViewExpanded)
//
//                }
//                // Answer, select answer and remove answers
//            } else if tableView == answerTableView {
//                var profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
//                profileAnswers[selectedSection][selectedQuestion] = indexPath.row
//                UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
//                answerTableView.reloadData()
//                //
//                let indexPath = NSIndexPath(row: 0, section: selectedQuestion)
//                questionsTable.reloadRows(at: [indexPath as IndexPath], with: .automatic)
//                //
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
//                    switch self.selectedQuestion {
//                    case 2,3,4,5,6,7,8:
//                        let totalHeight = self.answerLabelQuestion.bounds.height + 10 + self.answerImageView.bounds.height + 10 + 147
//                        self.animateActionSheetDown(actionSheet: self.answerView2, actionSheetHeight: totalHeight, backgroundView: self.backgroundViewExpanded)
//                    default:
//                        let totalHeight = self.answerLabelQuestion.bounds.height + 10 + 147
//                        self.animateActionSheetDown(actionSheet: self.answerView2, actionSheetHeight: totalHeight, backgroundView: self.backgroundViewExpanded)
//                    }
//                })
//
//            }
//            //
//            tableView.deselectRow(at: indexPath, animated: true)
//
//        }
//    }
//
//
//    //
//    // Picker View ----------------------------------------------------------------------------------------------------
//    //
//    // Number of components
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    // Number of rows
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if selectedQuestion != 0 {
//            // -1 as question included with answers
//            return scheduleDataStructures.profileQA[selectedSection][selectedQuestion].count - 1
//        } else {
//            return ageAnswer.count
//        }
//    }
//
//    // View for row
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        //
//        let answerLabel = UILabel()
//        answerLabel.text = ageAnswer[row]
//        answerLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
//        answerLabel.textColor = colour1
//        //
//        answerLabel.textAlignment = .center
//        return answerLabel
//        //
//    }
//
//    // Row height
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 37
//    }
//
//    // Did select row
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        //
//    }
//
//
//    // Background view expanded action
//    // Add movement table background (dismiss table)
//    func backgroundViewExpandedAction(_ sender: Any) {
//        // Age Picker
//        if selectedQuestion == 0 {
//            animateActionSheetDown(actionSheet: answerView, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
//            // Answer Table
//        } else {
//            switch selectedQuestion {
//            case 2,3,4,5,6,7,8:
//                let totalHeight = answerLabelQuestion.bounds.height + 10 + answerImageView.bounds.height + 10 + 147
//                self.animateActionSheetDown(actionSheet: self.answerView2, actionSheetHeight: totalHeight, backgroundView: self.backgroundViewExpanded)
//            default:
//                let totalHeight = answerLabelQuestion.bounds.height + 10 + 147
//                self.animateActionSheetDown(actionSheet: self.answerView2, actionSheetHeight: totalHeight, backgroundView: self.backgroundViewExpanded)
//            }
//        }
//    }
//
//    // OK Button
//    //
//    // Ok button action
//    func okButtonAction(_ sender: Any) {
//        var profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
//        profileAnswers[selectedSection][selectedQuestion] = agePicker.selectedRow(inComponent: 0)
//        UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
//        //
//        animateActionSheetDown(actionSheet: answerView, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
//        //
//        let indexPath = NSIndexPath(row: 0, section: selectedQuestion)
//        questionsTable.reloadRows(at: [indexPath as IndexPath], with: .automatic)
//    }
//
//    //
//    // MARK: Slider Helpers -----------------------------------------------------------
//
//
//    //
//    // MARK: sliderValueChanged
//    let step: Float = 1
//    @IBAction func sliderValueChanged(sender: UISlider) {
//        let roundedValue = round(sender.value / step) * step
//        sender.value = roundedValue
//        //
//        // Indicator
//        let indexPath = NSIndexPath(row: 0, section: sender.tag)
//        let cell = questionsTable.cellForRow(at: indexPath as IndexPath)
//        cell?.textLabel?.text = String(Int(roundedValue))
//
//        // Change thumbTintColor for groups
//        if selectedSection == 2 {
//            // Red, below and above suggested
//            if roundedValue <= 2 || roundedValue >= 6 {
//                sender.thumbTintColor = colour4
//                // Green, suggested
//            } else {
//                sender.thumbTintColor = colour3
//            }
//        }
//        //
//        // Update Selected Value
//        var profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
//        profileAnswers[selectedSection][sender.tag] = Int(roundedValue)
//        UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
//
//    }
//
//    //
//    // MARK: Set Slider Gradient
//    //
//    func setSliderGradient(slider:UISlider) {
//        //
//        // Gradient Layer
//        let tgl = CAGradientLayer()
//        let frame = CGRect(x: 0.0, y: 0.0, width: slider.bounds.width, height: 2 )
//        tgl.frame = frame
//        //
//        tgl.colors = [colour4.cgColor,colour4.cgColor,colour3.cgColor,colour3.cgColor,colour4.cgColor,colour4.cgColor]
//        tgl.locations = [0,0.2,0.3,0.5,0.6,1]
//        tgl.endPoint = CGPoint(x: 1.0, y:  1.0)
//        tgl.startPoint = CGPoint(x: 0.0, y:  1.0)
//
//        UIGraphicsBeginImageContextWithOptions(tgl.frame.size, false, 0.0)
//        tgl.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        slider.setMinimumTrackImage(image?.resizableImage(withCapInsets:.zero),  for: .normal)
//        slider.setMaximumTrackImage(image?.resizableImage(withCapInsets:.zero),  for: .normal)
//    }
//
//
//    //
//    // Update Progress
//    func updateProgress() {
//        // Current Pose
//        let currentPose = Float(selectedRow)
//        // Total Number Poses
//        let totalPoses = Float(keyArray.count - 1)
//
//
//        //
//        if selectedRow > 0 {
//            //
//            let currentProgress = currentPose / totalPoses
//            progressBar.setProgress(currentProgress, animated: true)
//        } else {
//            // Initial state
//            progressBar.setProgress(0, animated: true)
//        }
//    }
//
//}

