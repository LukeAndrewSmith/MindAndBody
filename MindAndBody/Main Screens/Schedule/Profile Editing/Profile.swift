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
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var leftItem: UIBarButtonItem!
    
    @IBOutlet weak var questionsTable: UITableView!
    
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
    var comingFromScheduleEditing = false
    var fromSettings = false
    
    //
    // Age
    var ageAnswer = ["16 (or less)", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "70+"]
    
    
    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("profile", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: false)
        
        
        leftItem.tintColor = Colors.red

        // BackgroundImage / Color
        view.backgroundColor = Colors.light
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
        progressBar.trackTintColor = Colors.dark
        progressBar.progressTintColor = Colors.green
        progressBar.setProgress(0, animated: true)
        progressBar.addShadow()
        
        //
        // Previous question swipe
        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(previousQuestion))
        downSwipe.direction = .down
        questionsTable.addGestureRecognizer(downSwipe)
        //
        upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upSwipeAction))
        upSwipe.direction = .up
        questionsTable.addGestureRecognizer(upSwipe)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        questionsTable.reloadData()
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
            
            
//            switch indexPath.row {
//            // Age Picker
//            case 0:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileAgeCell", for: indexPath) as! ProfileAgeCell
//                cell.row = indexPath.row
//                cell.ageAnswer = ageAnswer
//                cell.selectedQuestion = selectedQuestion
//                cell.agePicker.reloadAllComponents()
//                cell.delegate = self
//                return cell
//                //
            // Answer Table with image (flexibility questions)
//            default:
            
            
            let cell: ProfileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell.row = indexPath.row
            cell.selectedQuestion = selectedQuestion
            cell.answerTableView.reloadData()
            // Recalculate height because cell frame wrong
            if indexPath.row < scheduleDataStructures.profileQA.count - 1 {
                cell.cellHeight = questionsTable.bounds.height
            } else if indexPath.row == scheduleDataStructures.profileQA.count - 1 {
                cell.cellHeight = questionsTable.bounds.height - 49
            }
            cell.delegate = self
            return cell
            
            
                //
//            }
            
            
        // Last row, save profile cell
        } else if indexPath.row == scheduleDataStructures.profileQA.count {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            // Indicator Label
            cell.backgroundColor = Colors.green
            if !fromSettings && !comingFromScheduleEditing {
                cell.textLabel?.text = NSLocalizedString("next", comment: "")
            } else {
                cell.textLabel?.text = NSLocalizedString("saveProfile", comment: "")
            }
            cell.textLabel?.font = Fonts.bottomButton
            cell.textLabel?.textColor = Colors.dark
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
            
            let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [String: Int]
            var allAnswered = true
            if profileAnswers.values.contains(-1) {
                allAnswered = false
            }
            
            if allAnswered {
                // Editing
                if comingFromScheduleEditing {
                    self.navigationController?.popToRootViewController(animated: true)

                // Updating from settings
                } else if fromSettings {
                    
                    self.dismiss(animated: true)

                // Creating
                } else {
                    // Tell parent to go to next section in schedule creation
                    if let parentVC = self.parent as? ScheduleCreationPageController {
                        parentVC.nextViewController()
                    }
                }
                
            // Not all questions are answered
            } else {
                unansweredQuestionsAlert()
            }
        }
    }
    
    //
    func unansweredQuestionsAlert() {
        // Alert View asking if you really want to delete
        let title = NSLocalizedString("profileNotCompleteWarning", comment: "")
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: Fonts.smallElementRegular!]), forKey: "attributedTitle")
        
        // Reset app action
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        // Add Actions
        alert.addAction(okAction)
        
        // Present Alert
        self.present(alert, animated: true, completion: nil)
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
            questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: true)
        }
    }
    
    //
    //
    @objc func upSwipeAction() {
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [String: Int]
        // If question has been answered
        if profileAnswers[scheduleDataStructures.profileQASorted[selectedQuestion]] != -1 {
            nextQuestion()
        }
    }
    
    //
    @objc func previousQuestion() {
        if selectedQuestion > 0 {
            selectedQuestion -= 1
            updateProgress()
            let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
            questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: true)
        }
    }
    
    //
    // Dismiss View
    @IBAction func dismissViewButtonAction(_ sender: Any) {
        if comingFromScheduleEditing {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.dismiss(animated: true)
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
        questionLabel.font = Fonts.smallElementRegular
        questionLabel.textColor = Colors.dark
        questionLabel.layer.cornerRadius = 15
        questionLabel.clipsToBounds = true
        questionLabel.backgroundColor = Colors.light
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        questionLabel.adjustsFontSizeToFitWidth = true
        // Answer Elements 1 - Age Picker
        // picker
        agePicker.backgroundColor = Colors.dark
        agePicker.delegate = self
        agePicker.dataSource = self
        agePicker.layer.cornerRadius = 15
        agePicker.clipsToBounds = true
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [String: Int]
        switch profileAnswers[scheduleDataStructures.profileQASorted[row]] {
        case -1:
            agePicker.selectRow(0, inComponent: 0, animated: true)
        default:
            agePicker.selectRow(profileAnswers[scheduleDataStructures.profileQASorted[row]]!, inComponent: 0, animated: true)
        }
        // Ok Button
        okButton.backgroundColor = Colors.light
        okButton.setTitleColor(Colors.green, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        okButton.layer.cornerRadius = 15
        okButton.clipsToBounds = true
        //
        questionLabel.text = NSLocalizedString(scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[row]]!["Q"]![0], comment: "")
        questionLabel.sizeToFit()
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
            //return scheduleDataStructures.profileQA[selectedSection][selectedQuestion].count - 1
            // TODO:- NOT SURE !!!!!!!!!!!!!
            return scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[selectedQuestion]]!["Q"]!.count - 1
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
        var profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [String: Int]
        profileAnswers[scheduleDataStructures.profileQASorted[selectedQuestion]] = agePicker.selectedRow(inComponent: 0)
        UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
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
    @IBOutlet weak var answerImageHeight: NSLayoutConstraint!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    //
    @IBOutlet weak var separator: UIView!
    
    //
    // Passed data
    var row = Int()
    var questionsTableHeight = CGFloat()
    var selectedQuestion = Int()
    var selectedSection = Int()
    var cellHeight = CGFloat()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        separator.backgroundColor = Colors.dark
        //
        self.backgroundColor = .clear
        self.selectionStyle = .none
        // Questions Label
        questionLabel.font = Fonts.mediumElementRegular
        questionLabel.backgroundColor = Colors.light
        questionLabel.textColor = Colors.dark
        questionLabel.layer.cornerRadius = 15
        questionLabel.clipsToBounds = true
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        questionLabel.adjustsFontSizeToFitWidth = true
        
        questionLabel.text = NSLocalizedString(scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[row]]!["Q"]![0], comment: "")
        let fit = questionLabel.sizeThatFits(CGSize(width: questionLabel.bounds.width, height: .greatestFiniteMagnitude))
        questionLabel.frame.size = CGSize(width: questionLabel.bounds.width, height: fit.height)
        
        // Table View
        answerTableView.dataSource = self
        answerTableView.delegate = self
        answerTableView.layer.cornerRadius = 15
        answerTableView.layer.masksToBounds = true
        answerTableView.tableFooterView = UIView()
        answerTableView.backgroundColor = Colors.light
        answerTableView.separatorColor = Colors.dark
        answerTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        answerTableView.layer.cornerRadius = 15
        answerTableView.layer.borderColor = Colors.dark.cgColor
        answerTableView.layer.borderWidth = 2
        answerTableView.clipsToBounds = true
        answerTableView.isScrollEnabled = false
        
        //
        let image = scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[row]]!["image"]![0]
        // Demonstration Image View
        if image == "" {
            // Hide image
            answerImageHeight.constant = 0
        } else {
            answerImageView.backgroundColor = Colors.light
            answerImageView.layer.cornerRadius = 15
            answerImageView.clipsToBounds = true
            answerImageView.image = getUncachedImage(named: image)

            let totalElementHeight = getTableHieght() + questionLabel.bounds.height + (2 * 10)
            let padding = CGFloat(2 * 16)
            answerImageHeight.constant = cellHeight - totalElementHeight - padding
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
        let font = Fonts.mediumElementRegular
        let height = NSLocalizedString(scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[selectedQuestion]]!["A"]![indexPath.row], comment: "").height(withConstrainedWidth: answerTableView.bounds.width - 32, font: font!)
        //
        setTableHeight()
        //
        if height > (49 * 1.5) {
            return 49 * 2
        } else if height > 49 {
            return 49 * 1.5
        } else {
            return 49
        }
        //
    }
    
    //
    func setTableHeight() {
        var tableHeightConstant: CGFloat = 0
        for i in 0..<scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[selectedQuestion]]!["A"]!.count {
            let font = Fonts.mediumElementRegular
            let height = NSLocalizedString(scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[selectedQuestion]]!["A"]![i], comment: "").height(withConstrainedWidth: answerTableView.bounds.width - 32, font: font!)
            if height > (49 * 1.5) {
                tableHeightConstant += (49 * 2)
            } else if height > 49 {
                tableHeightConstant += (49 * 1.5)
            } else {
                tableHeightConstant += 49
            }
        }
        tableHeight.constant = tableHeightConstant
        //
        
    }
    
    func getTableHieght() -> CGFloat {
        var tableHeightConstant: CGFloat = 0
        for i in 0..<scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[selectedQuestion]]!["A"]!.count {
            let font = Fonts.mediumElementRegular
            let height = NSLocalizedString(scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[selectedQuestion]]!["A"]![i], comment: "").height(withConstrainedWidth: answerTableView.bounds.width - 32, font: font!)
            if height > (49 * 1.5) {
                tableHeightConstant += (49 * 2)
            } else if height > 49 {
                tableHeightConstant += (49 * 1.5)
            } else {
                tableHeightConstant += 49
            }
        }
        return tableHeightConstant
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[selectedQuestion]]!["A"]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [String: Int]
        //
        cell.backgroundColor = Colors.light
        cell.tintColor = Colors.green
        cell.textLabel?.textColor = Colors.dark
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        // row + 1 as question included with answers
        cell.textLabel?.text = NSLocalizedString(scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[selectedQuestion]]!["A"]![indexPath.row], comment: "")
        cell.textLabel?.font = Fonts.mediumElementRegular
        // Select answer
        if profileAnswers[scheduleDataStructures.profileQASorted[row]] != -1 && indexPath.row == profileAnswers[scheduleDataStructures.profileQASorted[selectedQuestion]] {
            cell.textLabel?.textColor = Colors.green
        }
        // If last cell hide separator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if indexPath.row == (scheduleDataStructures.profileQA[scheduleDataStructures.profileQASorted[selectedQuestion]]!["A"]!.count - 1) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        //
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [String: Int]
        profileAnswers[scheduleDataStructures.profileQASorted[row]] = indexPath.row
        UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
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
            for i in 0..<scheduleDataStructures.defaultProfileAnswers.count {
                if profileAnswers[scheduleDataStructures.profileQASorted[i]] == -1 {
                    allAnswered = false
                }
            }
            // Each time a question is answered and all the questions have been answered, the difficulty levels are updated
            if allAnswered {
                // Call set difficulty levels
                ProfileFunctions.shared.setDifficultyLevels()
            }
            //
            self.delegate?.nextQuestion()
            
        }
    }
}

class ProfileNavigation: UINavigationController {
    
}

