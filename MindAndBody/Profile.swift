//
//  Profile
//  MindAndBody
//
//  Created by Luke Smith on 14.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
// Profile Class
class Profile: UIViewController, UITableViewDelegate, UITableViewDataSource, NextRowDelegate {
    
    //
    // MARK: Outlets --------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var questionsTable: UITableView!
    @IBOutlet weak var sectionLabel: UILabel!
    //
    // Also used as back button
    @IBOutlet weak var dismissViewButton: UIButton!
    
    // Answer elements
    // Age Picker
    var agePicker = UIPickerView()
    let okButton = UIButton()
    // Answer Table
    var answerLabelQuestion = UILabel()
    var answerImageView = UIImageView()
    // gesture for going back a question
    var downSwipe = UISwipeGestureRecognizer()
    // gesture for going forward a question
    var upSwipe = UISwipeGestureRecognizer()
    //
    @IBOutlet weak var progressBar: UIProgressView!
    //
    // Question progress, incrimented by nextQuestion()
    var selectedQuestion = 0
    
    // schedule
    var comingFromSchedule = false
    
    //
    // Age
    var ageAnswer = ["16 (or less)", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "70+"]
    
    
    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        //
        sectionLabel.text = NSLocalizedString("profile", comment: "")
        if comingFromSchedule == false {
            dismissViewButton.imageView?.image = #imageLiteral(resourceName: "Back Arrow")
        }
        //
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: true)
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
        progressBar.trackTintColor = Colors.light
        progressBar.progressTintColor = Colors.green
        progressBar.setProgress(0, animated: true)
        
        //
        // Previous question swipe
        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(previousQuestion))
        downSwipe.direction = .down
        questionsTable.addGestureRecognizer(downSwipe)
        //
        upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upSwipeAction))
        upSwipe.direction = .up
        questionsTable.addGestureRecognizer(upSwipe)
        //
        // Back
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
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
        return ""
    }

    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  + 1 for save profile cell
        let count = scheduleDataStructures.profileQA.count + 1
        return count
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        if indexPath.row < scheduleDataStructures.profileQA.count - 1 {
            return questionsTable.bounds.height

        // Last question, make space for save profile cell
        } else if indexPath.row == scheduleDataStructures.profileQA.count - 1 {
            return questionsTable.bounds.height - 49
        // Last row, save profile cell
        } else if indexPath.row == scheduleDataStructures.profileQA.count {
            return 49
        }
        return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Question Table
            // Only present the current cell
                // This is necessary as tableview within the cell is reused, so can only be loaded for one cell
        if tableView == questionsTable && indexPath.row == selectedQuestion {
            switch indexPath.row {
            // Age Picker
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileAgeCell", for: indexPath) as! ProfileAgeCell
                cell.row = indexPath.row
                cell.ageAnswer = ageAnswer
                cell.selectedQuestion = selectedQuestion
                cell.agePicker.reloadAllComponents()
                cell.delegate = self
                return cell
                //
            // Answer Table with image (flexibility questions)
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
                cell.row = indexPath.row
                cell.answerImageArray = scheduleDataStructures.answerImageArray
                cell.selectedQuestion = selectedQuestion
                cell.answerTableView.reloadData()
                cell.delegate = self
                return cell
                //
            }
        // Last row, save profile cell
        } else if indexPath.row == scheduleDataStructures.profileQA.count {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            // Indicator Label
            cell.backgroundColor = Colors.green.withAlphaComponent(0.25)
            cell.textLabel?.text = NSLocalizedString("saveProfile", comment: "")
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            cell.textLabel?.textColor = Colors.light
            cell.textLabel?.textAlignment = .center
            return cell
        }
        // Issue
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        return cell
        //
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // If last row
        if indexPath.row == scheduleDataStructures.profileQA.count {
            if comingFromSchedule {
                self.dismiss(animated: true)
            } else {
                let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
                let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [Int]
                var allAnswered = true
                for i in 0...profileAnswers.count - 1 {
                    if profileAnswers[i] == -1 {
                        allAnswered = false
                    }
                }
                if allAnswered {
                    // App helps schedule creation
                    if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
                        self.performSegue(withIdentifier: "ProfileAppHelpSegue", sender: self)
                    // Custom schedule creation
                    } else {
                        self.performSegue(withIdentifier: "ProfileCustomSegue", sender: self)
                    }
                } else {
                    //
                    // Alert View asking if you really want to delete
                    let title = NSLocalizedString("profileNotCompleteWarning", comment: "")
                    let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
                    alert.view.tintColor = Colors.dark
                    alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 23)!]), forKey: "attributedTitle")
                    
                    // Reset app action
                    let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertActionStyle.default) {
                        UIAlertAction in
                    }
                    // Add Actions
                    alert.addAction(okAction)
                    
                    // Present Alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    //
    // Update Progress
    func updateProgress() {
        // Current Question
        let currentQuestion = Float(selectedQuestion)
        // Total Number questions
        let questionCount = Float(scheduleDataStructures.profileQA.count - 1)
        //
        //
        let currentProgress = currentQuestion / questionCount
        progressBar.setProgress(currentProgress, animated: true)

    }
    
    //
    func nextQuestion() {
        // Next Question
        if selectedQuestion < scheduleDataStructures.profileQA.count - 1 {
            selectedQuestion += 1
            updateProgress()
            let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
            questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
        }
    }
    
    //
    //
    @objc func upSwipeAction() {
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [Int]
        // If question has been answered
        if profileAnswers[selectedQuestion] != -1 {
            nextQuestion()
        }
    }
    
    //
    @objc func previousQuestion() {
        if selectedQuestion > 0 {
            selectedQuestion -= 1
            updateProgress()
            let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
            questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
        }
    }
    
    //
    // Dismiss View
    @IBAction func dismissViewButtonAction(_ sender: Any) {
        if comingFromSchedule {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //
    // MARK: Back Swipe
    @IBAction func edgeGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

protocol NextRowDelegate: class {
    func nextQuestion()
}


// MARK: - Custom Cells
//
// MARK: Age cell
class ProfileAgeCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        questionLabel.textColor = Colors.light
        questionLabel.layer.cornerRadius = 15
        questionLabel.clipsToBounds = true
        questionLabel.backgroundColor = Colors.dark
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 2
        questionLabel.adjustsFontSizeToFitWidth = true
        // Answer Elements 1 - Age Picker
        // picker
        agePicker.backgroundColor = Colors.dark
        agePicker.delegate = self
        agePicker.dataSource = self
        agePicker.layer.cornerRadius = 15
        agePicker.clipsToBounds = true
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [Int]
        switch profileAnswers[row] {
        case -1:
            agePicker.selectRow(0, inComponent: 0, animated: true)
        default:
            agePicker.selectRow(profileAnswers[row], inComponent: 0, animated: true)
        }
        // Ok Button
        okButton.backgroundColor = Colors.light
        okButton.setTitleColor(Colors.green, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        okButton.layer.cornerRadius = 15
        okButton.clipsToBounds = true
        //
        questionLabel.text = NSLocalizedString(scheduleDataStructures.profileQA[row][0], comment: "")
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
        answerLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        answerLabel.textColor = Colors.light
        //
        answerLabel.textAlignment = .center
        return answerLabel
        //
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 37
    }
    
    //
    @IBAction func okButtonAction(_ sender: Any) {
        var profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [Int]
        profileAnswers[selectedQuestion] = agePicker.selectedRow(inComponent: 0)
        UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["profileAnswers"])
        //
        delegate?.nextQuestion()
    }
    
    
}

//
// MARK: Default Cell With Image
class ProfileCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: NextRowDelegate?
    //
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var elementStack: UIStackView!
    @IBOutlet weak var answerImageLeading: NSLayoutConstraint!
    @IBOutlet weak var answerImageTrailing: NSLayoutConstraint!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    //
    
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
        questionLabel.textColor = Colors.light
        questionLabel.layer.cornerRadius = 15
        questionLabel.clipsToBounds = true
        questionLabel.backgroundColor = Colors.dark
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
            answerImageView.backgroundColor = Colors.dark
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
        answerTableView.backgroundColor = Colors.dark
        answerTableView.separatorColor = Colors.light.withAlphaComponent(0.5)
        answerTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        answerTableView.layer.cornerRadius = 15
        answerTableView.clipsToBounds = true
        answerTableView.isScrollEnabled = false
        //
        questionLabel.text = NSLocalizedString(scheduleDataStructures.profileQA[row][0], comment: "")
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
        let font = UIFont(name: "SFUIDisplay-thin", size: 23)
        // + 1 as question inclueded in array
        let height = NSLocalizedString(scheduleDataStructures.profileQA[selectedQuestion][indexPath.row + 1], comment: "").height(withConstrainedWidth: answerTableView.bounds.width - 32, font: font!)
        //
        setTableHeight()
        //
        if height > 49 {
            return 49 * 1.5
        } else {
            return 49
        }
        //
    }
    
    //
    func setTableHeight() {
        var tableHeightConstant: CGFloat = 0
        for i in 1...scheduleDataStructures.profileQA[selectedQuestion].count - 1 {
            let font = UIFont(name: "SFUIDisplay-thin", size: 23)
            let height = NSLocalizedString(scheduleDataStructures.profileQA[selectedQuestion][i], comment: "").height(withConstrainedWidth: answerTableView.bounds.width - 32, font: font!)
            if height > 49 {
                tableHeightConstant += (49 * 1.5)
            } else {
                tableHeightConstant += 49
            }
        }
        tableHeight.constant = tableHeightConstant
        //
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleDataStructures.profileQA[selectedQuestion].count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [Int]
        //
        cell.backgroundColor = Colors.dark
        cell.tintColor = Colors.green
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        // row + 1 as question included with answers
        cell.textLabel?.text = NSLocalizedString(scheduleDataStructures.profileQA[selectedQuestion][indexPath.row + 1], comment: "")
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        // Select answer
        if profileAnswers[row] != -1 && indexPath.row == profileAnswers[selectedQuestion] {
            cell.textLabel?.textColor = Colors.green
        }
        // If last cell hide seperator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if indexPath.row == (scheduleDataStructures.profileQA[selectedQuestion].count - 2) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        //
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [Int]
        profileAnswers[row] = indexPath.row
        UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["profileAnswers"])
        //
        answerTableView.isUserInteractionEnabled = false
        //
        tableView.deselectRow(at: indexPath, animated: true)
        answerTableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.answerTableView.isUserInteractionEnabled = true
            // Update difficulty levels each time row selected
                // this is incase 
            var allAnswered = true
            for i in 0...profileAnswers.count - 1 {
                if profileAnswers[i] == -1 {
                    allAnswered = false
                }
            }
            if allAnswered {
                // TODO: Call set difficulty levels
                ProfileFunctions.shared.setDifficultyLevels()
            }
            //
            self.delegate?.nextQuestion()
            
        }
    }
}

