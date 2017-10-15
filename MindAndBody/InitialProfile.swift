//
//  InitialProfile.swift
//  MindAndBody
//
//  Created by Luke Smith on 14.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// MARK: Age cell
class InitialProfileAgeCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: NextRowDelegate?
    //
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var elementStack: UIStackView!
    // Passed
    var ageAnswer: [String] = []
    var row = Int()
    var selectedQuestion = Int()
    var selectedSection = Int()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        self.backgroundColor = .clear
        self.selectionStyle = .none
        // Questions Label
        questionLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        questionLabel.textColor = colour1
        questionLabel.layer.cornerRadius = 15
        questionLabel.clipsToBounds = true
        questionLabel.backgroundColor = colour2
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 2
        questionLabel.adjustsFontSizeToFitWidth = true
        // Answer Elements 1 - Age Picker
        // picker
        agePicker.backgroundColor = colour2
        agePicker.delegate = self
        agePicker.dataSource = self
        agePicker.layer.cornerRadius = 15
        agePicker.clipsToBounds = true
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        switch profileAnswers[selectedSection][row] {
        case -1:
            agePicker.selectRow(0, inComponent: 0, animated: true)
        default:
            agePicker.selectRow(profileAnswers[selectedSection][row], inComponent: 0, animated: true)
        }
        // Ok Button
        okButton.backgroundColor = colour1
        okButton.setTitleColor(colour3, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.layer.cornerRadius = 15
        okButton.clipsToBounds = true
        //
        questionLabel.text = NSLocalizedString(scheduleDataStructures.profileQA[selectedSection][row][0], comment: "")
        questionLabel.sizeToFit()
        questionLabel.frame.size.width = elementStack.bounds.width
        //
    }
    
    //
    // Picker View
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
        answerLabel.text = ageAnswer[row]
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
    
    //
    @IBAction func okButtonAction(_ sender: Any) {
        var profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        profileAnswers[selectedSection][selectedQuestion] = agePicker.selectedRow(inComponent: 0)
        UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
        //
        delegate?.nextQuestion()
    }
    
    
}

//
// MARK: Default Cell With Image
class InitialProfileCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: NextRowDelegate?
    //
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var elementStack: UIStackView!
    @IBOutlet weak var answerImageLeading: NSLayoutConstraint!
    @IBOutlet weak var answerImageTrailing: NSLayoutConstraint!
    //
    // Passed data
    var row = Int()
    var questionsTableHeight = CGFloat()
    var answerImageArray: [String] = []
    var selectedQuestion = Int()
    var selectedSection = Int()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        self.backgroundColor = .clear
        self.selectionStyle = .none
        // Questions Label
        questionLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        questionLabel.textColor = colour1
        questionLabel.layer.cornerRadius = 15
        questionLabel.clipsToBounds = true
        questionLabel.backgroundColor = colour2
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 2
        questionLabel.adjustsFontSizeToFitWidth = true
        // Demonstration Image View
        if answerImageArray[row] == "" {
            // Hide image
//            answerImageView.removeFromSuperview()
            answerImageLeading.constant = elementStack.bounds.width / 2
            answerImageTrailing.constant = elementStack.bounds.width / 2
        } else {
            answerImageLeading.constant = 0
            answerImageTrailing.constant = 0
            // Ensure image is in stack view
//            if elementStack.arrangedSubviews.contains(answerImageView) == false {
//                elementStack.insertArrangedSubview(answerImageView, at: 1)
//            }
            answerImageView.backgroundColor = colour2
            answerImageView.layer.cornerRadius = 15
            answerImageView.clipsToBounds = true
            answerImageView.image = getUncachedImage(named: answerImageArray[row])
        }
        // Table View
        answerTableView.dataSource = self
        answerTableView.delegate = self
        answerTableView.layer.cornerRadius = 15
        answerTableView.layer.masksToBounds = true
        answerTableView.tableFooterView = UIView()
        answerTableView.backgroundColor = colour2
        answerTableView.separatorColor = colour1.withAlphaComponent(0.5)
        answerTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        answerTableView.layer.cornerRadius = 15
        answerTableView.clipsToBounds = true
        answerTableView.isScrollEnabled = false
        //
        questionLabel.text = NSLocalizedString(scheduleDataStructures.profileQA[selectedSection][row][0], comment: "")
        questionLabel.sizeToFit()
        questionLabel.frame.size.width = elementStack.bounds.width
        //
        if answerImageArray[row] != "" && elementStack.bounds.height > questionsTableHeight {
            answerImageTrailing.constant = (elementStack.bounds.width * 0.25) / 2
            answerImageLeading.constant = (elementStack.bounds.width * 0.25) / 2
        }
    }
    
    //
    // Answers tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleDataStructures.profileQA[0][selectedQuestion].count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        //
        cell.backgroundColor = colour2
        cell.tintColor = colour3
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        // row + 1 as question included with answers
        cell.textLabel?.text = NSLocalizedString(scheduleDataStructures.profileQA[selectedSection][selectedQuestion][indexPath.row + 1], comment: "")
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        // Select answer
        if profileAnswers[selectedSection][row] != -1 && indexPath.row == profileAnswers[selectedSection][selectedQuestion] {
            cell.textLabel?.textColor = colour3
        }
        // If last cell hide seperator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if indexPath.row == (scheduleDataStructures.profileQA[0][selectedQuestion].count - 2) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        //
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        profileAnswers[selectedSection][row] = indexPath.row
        UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
        //
        tableView.deselectRow(at: indexPath, animated: true)
        answerTableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.delegate?.nextQuestion()
        }
    }
}

//
// Initial Profile Class
class InitialProfile: UIViewController, UITableViewDelegate, UITableViewDataSource, NextRowDelegate {

    //
    // MARK: Outlets --------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var questionsTable: UITableView!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    // Answer elements
    // Age Picker
    var agePicker = UIPickerView()
    let okButton = UIButton()
    // Answer Table
    var answerLabelQuestion = UILabel()
    var answerImageView = UIImageView()
    //
    @IBOutlet weak var progressBar: UIProgressView!
    //
    // Me/Goals/Sessions
    var selectedSection = 0
    // Question progress, incrimented by nextQuestion()
    var selectedQuestion = 0

    //
    // Age
    var ageAnswer = ["16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "70+"]
    // Answer Images
    var answerImageArray = ["", "", "standingHamstring", "butterfly", "deepSquat", "hero", "upwardDog", "neckRotatorStretch", "tree", "", "", "", "pushUp", "pullUp", "", "", "", "", "", "", "",]
    

    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        //
        sectionLabel.text = NSLocalizedString("me", comment: "")
        //
        // Background Image/Colour
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        if backgroundIndex < backgroundImageArray.count {
            backgroundImageView.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = colour1
        }
        // Blur
        // BackgroundBlur/Vibrancy
        let backgroundBlur = UIVisualEffectView()
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        backgroundBlur.frame = backgroundImageView.bounds
        if backgroundIndex > backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImageView)
        }
        //
        // Table View
        questionsTable.tableFooterView = UIView()
        questionsTable.separatorStyle = .none
        questionsTable.backgroundColor = .clear
        questionsTable.isScrollEnabled = false
        //
        // Progress Bar
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        progressBar.trackTintColor = colour1
        progressBar.progressTintColor = colour3
        progressBar.setProgress(0, animated: true)
        
        //
        // Previous question swipe
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(previousQuestion))
        downSwipe.direction = .down
        questionsTable.addGestureRecognizer(downSwipe)
    }

    //
    // Table View --------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        return ""
    }

    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        //
//        let header = view as! UITableViewHeaderFooterView
//        header.contentView.backgroundColor = colour1
//        //
//        if header.subviews.contains(progressBar) == false {
//            header.addSubview(progressBar)
//        }
    }

    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //
//        if tableView == questionsTable {
//            return 2
//        }
        return 0
    }


    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        if tableView == questionsTable {
            let count = scheduleDataStructures.profileQA[0].count + scheduleDataStructures.profileQA[1].count + scheduleDataStructures.profileQA[2].count
            return count
        }
        return 0
    }

    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        if tableView == questionsTable {
                // - sectionlabelheight - progressbarheight
            return questionsTable.bounds.height
        }
        return 0
    }

    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        // Switch, me, goals, sessions
        switch selectedSection {
        // Me
        case 0:
            // Question Table
            if tableView == questionsTable && indexPath.row == selectedQuestion {
                switch indexPath.row {
                // Age Picker
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "InitialProfileAgeCell", for: indexPath) as! InitialProfileAgeCell
                    cell.row = indexPath.row
                    cell.ageAnswer = ageAnswer
                    cell.selectedQuestion = selectedQuestion
                    cell.selectedSection = selectedSection
                    cell.agePicker.reloadAllComponents()
                    cell.delegate = self
                    return cell
                    //
                // Answer Table with image (flexibility questions)
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "InitialProfileCell", for: indexPath) as! InitialProfileCell
                    cell.row = indexPath.row
                    cell.answerImageArray = answerImageArray
                    cell.selectedQuestion = selectedQuestion
                    cell.selectedSection = selectedSection
                    cell.answerTableView.reloadData()
                    cell.delegate = self
                    return cell
                    //
                }
            }
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            return cell
            //
        // Goals
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
        // Session
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
    // Update Progress
    func updateProgress() {
        // Current Pose
        let currentQuestion = Float(selectedQuestion)
        // Total Number Poses
        let questionCount = Float(scheduleDataStructures.profileQA[0].count + scheduleDataStructures.profileQA[1].count + scheduleDataStructures.profileQA[2].count)
        //
        if selectedQuestion > 0 {
            //
            let currentProgress = currentQuestion / questionCount
            progressBar.setProgress(currentProgress, animated: true)
        } else {
            // Initial state
            progressBar.setProgress(0, animated: true)
        }
    }

    //
    func nextQuestion() {
        // Section
        if selectedQuestion == scheduleDataStructures.profileQA[selectedSection].count - 1 {
            selectedSection += 1
        }
        // Question
        selectedQuestion += 1
        updateProgress()
        let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
        questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
        // Section title
        if selectedSection == 1 {
            sectionLabel.text = NSLocalizedString("goals", comment: "")
        } else if selectedSection == 2 {
            sectionLabel.text = NSLocalizedString("nSessions", comment: "")
        }
    }
    
    //
    func previousQuestion() {
        // Me
        if selectedSection == 0 {
            if selectedQuestion > 0 {
                selectedQuestion -= 1
                updateProgress()
                let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
                questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
                //
                // Section title
                if selectedSection == 0 {
                    sectionLabel.text = NSLocalizedString("me", comment: "")
                } else if selectedSection == 1 {
                    sectionLabel.text = NSLocalizedString("goals", comment: "")
                }
            }
        // Goals/Profile
        } else {
            
        }
    }
}

protocol NextRowDelegate: class {
    func nextQuestion()
}

