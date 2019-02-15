//
//  ScheduleCreationHelp.swift
//  MindAndBody
//
//  Created by Luke Smith on 07.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
// Schedule Creation Help
class ScheduleCreationHelp: UIViewController, UITableViewDelegate, UITableViewDataSource, NextRowDelegate {
    
    //
    // MARK: Outlets --------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var questionsTable: UITableView!
    @IBOutlet weak var previousSectionButton: UIButton!
    
    // Answer elements
    // Answer Table
    var answerLabelQuestion = UILabel()
    var answerImageView = UIImageView()
    // 2 gesture for going back
    // swipe - question
    // tap - section
    var downSwipe = UISwipeGestureRecognizer()
    var downTap = UITapGestureRecognizer()
    // gesture for going forward
    var upSwipe = UISwipeGestureRecognizer()
    
    // Currently unused
    var progressBar = UIProgressView()

    // Me/Goals/Sessions
    var selectedSection = 0
    // Question progress, incrimented by nextQuestion()
    var selectedQuestion = 0
    
    // Age
    var ageAnswer = ["16 (or less)", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "70+"]
    
    
    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        UIApplication.shared.statusBarStyle = .lightContent

        // Table View
        questionsTable.tableFooterView = UIView()
        questionsTable.separatorStyle = .none
        questionsTable.backgroundColor = .clear
        questionsTable.isScrollEnabled = true
        
        //
        previousSectionButton.tintColor = Colors.dark
        previousSectionButton.alpha = 0
        
        // Progress Bar
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        progressBar.trackTintColor = Colors.dark
        progressBar.progressTintColor = Colors.green
        progressBar.setProgress(0, animated: true)
        
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
        // Goals
        if selectedSection == 0 {
            return scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count
        // Questions and answers
        } else {
            return 1
        }
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Goals
        if selectedSection == 0 {
            return NSLocalizedString(scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][section][0], comment: "")
        // Questions and answers
        } else {
            return ""
        }
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // Goals
        if selectedSection == 0 {
            // Header
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = Fonts.regularCell
            header.textLabel?.textColor = Colors.dark
            //
            header.backgroundColor = Colors.light
            header.backgroundView = UIView()
            //
            // Check for and remove any separators leftover
            for view in header.subviews {
                if view.tag == 72 {
                    view.removeFromSuperview()
                }
            }
            let separator = UIView()
            separator.tag = 72
            separator.frame = CGRect(x: 15, y: header.frame.size.height - 1, width: view.frame.size.width, height: 1)
            separator.backgroundColor = Colors.dark
            separator.alpha = 0.5
            header.addSubview(separator)
        }
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //
        if tableView == questionsTable {
            // Goals
            if selectedSection == 0 {
                let height = questionsTable.bounds.height / CGFloat((scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count * 2) + 1)
                return height
            // Questions and answers
            } else {
                return 0
            }
        }
        return 0
    }
    
    
    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        if tableView == questionsTable {
            // Goals
            if selectedSection == 0 {
                // If last section, add extra cell for completion
                // Goals -> nSessions, nSessions -> Schedule Creator
                if section == scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count - 1 {
                    return 2
                } else {
                    return 1
                }
            // Questions and answers
            } else {
                // + 1 for save cell
                let count = scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count + 1
                return count
            }
        }
        return 0
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        if tableView == questionsTable {
            // Goals
            if selectedSection == 0 {
                let height = questionsTable.bounds.height / CGFloat((scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count * 2) + 1)
                return height
            // Questions and answers
            } else {
                //
                if indexPath.row < scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count - 1 {
                    return questionsTable.bounds.height
                // Last question, make space for save profile cell
                } else if indexPath.row == scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count - 1 {
                    return questionsTable.bounds.height - 49
                    // Last row, save profile cell
                } else if indexPath.row == scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count {
                    return 49
                }
                return 0
            }
        }
        return 0
    }
    
    // Cell for row
    // Main table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        // Switch, me, goals, sessions
        switch selectedSection {
        // Goals
        case 0:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            // Sliders
            // Only row 1 in final section, for next section, rest are in seperate sections, row 0
            if indexPath.row != 1 {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                //
                // Slider
                let slider = UISlider()
                cell.addSubview(slider)
                slider.addTarget(self, action: #selector(self.sliderValueChanged), for: .valueChanged)
                // Colours
                slider.thumbTintColor = Colors.dark
                slider.minimumTrackTintColor = Colors.green
                slider.maximumTrackTintColor = Colors.red
                // Frame
                slider.frame = CGRect(x: 45, y: (cell.bounds.height - slider.frame.height) / 2, width: view.frame.size.width - 60, height: slider.frame.height)
                // Values
                slider.minimumValue = 0
                slider.maximumValue = 3
                // Section tag
                slider.tag = indexPath.section
                //
                
                let indexString = scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][indexPath.section][0]
                let value = ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleCreationHelp"]![0][selectedSection][indexString] as! Int
                slider.value = Float(value)
                
                //
                // Indicator Label
                cell.textLabel?.text = String(value)
                cell.textLabel?.font = Fonts.largeElementRegular
                cell.textLabel?.textColor = Colors.dark
                //
                // Next Section -> N Sessions
            } else {
                // Indicator Label
                cell.backgroundColor = Colors.green
                cell.textLabel?.text = NSLocalizedString("done", comment: "")
                cell.textLabel?.font = Fonts.bottomButton
                cell.textLabel?.textColor = Colors.dark
                cell.textLabel?.textAlignment = .center
            }
            return cell
        // Questions
        case 1:
            if indexPath.row < scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count {
                // Question Table
                if tableView == questionsTable && indexPath.row == selectedQuestion {
                    switch indexPath.row {
                    // Answer Table with image (flexibility questions)
                    default:
                        let cell: ScheduleCreationHelpCell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCreationHelpCell", for: indexPath) as! ScheduleCreationHelpCell
                        cell.row = indexPath.row
                        cell.selectedQuestion = selectedQuestion
                        cell.selectedSection = selectedSection
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
                    }
                }
                let cell = UITableViewCell()
                cell.backgroundColor = .clear
                return cell
            // Last row, save profile cell
            } else if indexPath.row == scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count {
                let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
                // Indicator Label
                cell.backgroundColor = Colors.green
                cell.textLabel?.text = NSLocalizedString("next", comment: "")
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-regular", size: 23)
                cell.textLabel?.textColor = Colors.dark
                cell.textLabel?.textAlignment = .center
                return cell
            }
        
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    // Main table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //
        
        // If first section and last row
        if selectedSection == 0 && indexPath.row == 1 {
            //
            // Count goals, making sure that there are actually some goals set
            var count = 0
            for i in 0..<ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleCreationHelp"]![0][selectedSection].count {
                count += ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleCreationHelp"]![0][selectedSection][scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][i][0]] as! Int
            }
            
            // If goals not empty
            if count != 0 {
                // Groups -> Questions
                if selectedSection == 0 {
                    nextQuestion()
                    previousSectionButton.alpha = 1
                }
            // Goals empty, alert user
            } else {
                //
                // Alert
                let title = NSLocalizedString("noGoalsChosenWarning", comment: "")
                let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
                alert.view.tintColor = Colors.dark
                alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-light", size: 20)!]), forKey: "attributedTitle")
                
                // Reset app action
                let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                }
                // Add Actions
                alert.addAction(okAction)
                
                // Present Alert
                self.present(alert, animated: true, completion: nil)
            }
        // Last cell, save
        } else if indexPath.row == scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count {
            
            //
            // Make sure no question is unanswered
            
            var allAnswered = true
            for i in 0..<ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleCreationHelp"]![0][selectedSection].count {
                if ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleCreationHelp"]![0][selectedSection][scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][i][0]] as! Int == -1 {
                    allAnswered = false
                    break
                }
            }
            
            // If all questions answered, go to next screen
            if allAnswered {
                
                // Set number of sessions
                setNumberOfSessions(updating: false)
                
                // Go to next section in schedule creation
                if let parentVC = self.parent as? ScheduleCreationPageController {
                    parentVC.nextViewController()
                }
            
            // If not all questions are answered, alert user
            } else {
                
                // Alert
                let title = NSLocalizedString("profileNotCompleteWarning", comment: "")
                let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
                alert.view.tintColor = Colors.dark
                alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-light", size: 21)!]), forKey: "attributedTitle")
                
                // Reset app action
                let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                }
                // Add Actions
                alert.addAction(okAction)
                
                // Present Alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    //
    // MARK: Slider Helpers -----------------------------------------------------------
    //
    // MARK: sliderValueChanged
    let step: Float = 1
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        //
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        let roundedInt = Int(roundedValue)
        //
        // Indicator
        // + 1 as totaln session not in table (so not row 0) but index 0 in array
        let indexPath = NSIndexPath(row: 0, section: sender.tag)
        let cell = questionsTable.cellForRow(at: indexPath as IndexPath)
        cell?.textLabel?.text = String(Int(roundedValue))
        //
        // Goals
        // Find question string to index schedules, as questions saved to schedules are index by the title of the question
        let question = scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][sender.tag][0]
        ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleCreationHelp"]![0][selectedSection][question] = Int(roundedInt)
        
        ScheduleManager.shared.saveSchedules()
    }
    
    
    //
    // Update Progress
    func updateProgress() {
        // Current Question
        // Add on selectedSection for goals and sessions
        let currentQuestion = Float(selectedQuestion) + Float(selectedSection)
        // Total Number questions
        // + 2 for goals and n sessions
        let questionCount = Float(scheduleDataStructures.scheduleCreationHelpSorted[0].count + 2)
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
        // Me Section
        if selectedSection == 0 {
            //
            // Animate as if normal scroll
            // Snapshot of before and after, animated '2 off screen and 1 on screen' to '2 on screen and 1 off screen'
            let snapShot1 = questionsTable.snapshotView(afterScreenUpdates: false)
            snapShot1?.center.y = questionsTable.center.y
            view.insertSubview(snapShot1!, aboveSubview: questionsTable)

                // Sandwitched in animation to get updating at the right time
                questionsTable.isScrollEnabled = false
                questionsTable.addGestureRecognizer(downSwipe)
                selectedSection += 1
                updateProgress()
                questionsTable.reloadData()
                let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
                questionsTable.reloadRows(at: [indexPath as IndexPath], with: .automatic)
                questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: false)

            // Reload
            questionsTable.reloadData()
            let indexPath2 = NSIndexPath(row: 0, section: 0)
            questionsTable.scrollToRow(at: indexPath2 as IndexPath, at: UITableView.ScrollPosition.top, animated: false)
            let snapShot2 = questionsTable.snapshotView(afterScreenUpdates: true)
            questionsTable.alpha = 0
            snapShot2?.center.y = questionsTable.center.y + questionsTable.bounds.height
            view.insertSubview(snapShot2!, aboveSubview: questionsTable)
            //
            UIView.animate(withDuration: AnimationTimes.animationTime3, animations: {
                snapShot1?.center.y -= self.questionsTable.bounds.height
                snapShot2?.center.y = self.questionsTable.center.y
            }, completion: { finished in
                snapShot1?.removeFromSuperview()
                snapShot2?.removeFromSuperview()
                self.questionsTable.alpha = 1
            })
        // Next Question
        } else if selectedSection > 0 && selectedQuestion != scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count - 1 {
            selectedQuestion += 1
            updateProgress()
            let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
            questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: true)
        }
    }
    
    //
    //
    @objc func upSwipeAction() {
        
        // Questions
        if selectedSection > 0 {
            // If question has been answered
            if ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleCreationHelp"]![0][selectedSection][scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][selectedQuestion][0]] as! Int != -1 {
                // If not last question, go to next question
                if selectedQuestion != scheduleDataStructures.scheduleCreationHelpSorted[selectedSection].count - 1 {
                    nextQuestion()
                }
            }
        }
    }
    
    
    @IBAction func previousSectionButtonAction(_ sender: Any) {
        previousQuestion()
    }
    
    //
    @objc func previousQuestion() {
        // Questions
        if selectedSection > 0 {
            // Previous question
            if selectedQuestion > 0 {
                selectedQuestion -= 1
                updateProgress()
                let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
                questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: true)
            // Questions -> Goals
            } else {
                previousSectionButton.alpha = 0
                questionsTable.removeGestureRecognizer(downSwipe)
                selectedSection -= 1
                updateProgress()
                questionsTable.isScrollEnabled = true
                //
                // Animate as if normal scroll
                // Snapshot of before and after, animated '2 off screen and 1 on screen' to '2 on screen and 1 off screen'
                let snapShot1 = questionsTable.snapshotView(afterScreenUpdates: false)
                snapShot1?.center.y = questionsTable.center.y
                view.insertSubview(snapShot1!, aboveSubview: questionsTable)
                // Reload
                questionsTable.reloadData()
                let indexPath = NSIndexPath(row: 0, section: 0)
                questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: false)
                let snapShot2 = questionsTable.snapshotView(afterScreenUpdates: true)
                questionsTable.alpha = 0
                snapShot2?.center.y = questionsTable.center.y - questionsTable.bounds.height
                view.insertSubview(snapShot2!, aboveSubview: questionsTable)
                //
                UIView.animate(withDuration: AnimationTimes.animationTime3, animations: {
                    snapShot1?.center.y += self.questionsTable.bounds.height
                    snapShot2?.center.y = self.questionsTable.center.y
                }, completion: { finished in
                    snapShot1?.removeFromSuperview()
                    snapShot2?.removeFromSuperview()
                    self.questionsTable.alpha = 1
                })
            }
        }
    }
    
    //
    // Dismiss View
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //
    // MARK: Back Swipe
    @IBAction func edgeGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "ScheduleHelpCreationSegue" {
            let destinationVC = segue.destination as! ScheduleCreator
            destinationVC.fromScheduleEditing = true
        }
    }
}

//
// MARK: Default Cell With Image
class ScheduleCreationHelpCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: NextRowDelegate?
    //
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerImageView: UIImageView!
    @IBOutlet weak var elementStack: UIStackView!
    @IBOutlet weak var answerImageHeight: NSLayoutConstraint!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var separator: UIView!
    //
    
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
        
        //
        questionLabel.text = NSLocalizedString(scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][row][0], comment: "")
        questionLabel.sizeToFit()
        questionLabel.frame.size.width = elementStack.bounds.width
        //
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
        
        // no image
        let image = ""
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
        // + 1 as question inclueded in array
        let height = NSLocalizedString(scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][selectedQuestion][indexPath.row + 1], comment: "").height(withConstrainedWidth: answerTableView.bounds.width - 32, font: font!)
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
        for i in 1...scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][selectedQuestion].count - 1 {
            let font = Fonts.mediumElementRegular
            // + 1 as question inclueded in array
            let height = NSLocalizedString(scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][selectedQuestion][i], comment: "").height(withConstrainedWidth: answerTableView.bounds.width - 32, font: font!)
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
        return scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][selectedQuestion].count - 1
    }
    
    // ScheduleCreationHelpCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        //
        //
        cell.backgroundColor = Colors.light
        cell.tintColor = Colors.green
        cell.textLabel?.textColor = Colors.dark
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        // row + 1 as question included with answers
        cell.textLabel?.text = NSLocalizedString(scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][selectedQuestion][indexPath.row + 1], comment: "")
        cell.textLabel?.font = Fonts.mediumElementRegular
        // Select answer
            // If answer not -1, and row is correct
        if indexPath.row == ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleCreationHelp"]![0][selectedSection][scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][row][0]] as! Int {
            cell.textLabel?.textColor = Colors.green
        }
        // If last cell hide separator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if indexPath.row == (scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][selectedQuestion].count - 2) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        //
        return cell
    }
    
    // Cell Questions table, set answer in array to selected answer
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Find question string to index schedules, as questions saved to schedules are index by the title of the question
        let question = scheduleDataStructures.scheduleCreationHelpSorted[selectedSection][selectedQuestion][0]
        ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleCreationHelp"]![0][selectedSection][question] = indexPath.row
        ScheduleManager.shared.saveSchedules()
        //
        tableView.deselectRow(at: indexPath, animated: true)
        answerTableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.delegate?.nextQuestion()
        }
    }
}
