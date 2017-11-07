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
// Initial Profile Class
class ScheduleCreationHelp: UIViewController, UITableViewDelegate, UITableViewDataSource, NextRowDelegate {
    
    //
    // MARK: Outlets --------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var questionsTable: UITableView!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    //
    @IBOutlet weak var dismissViewButton: UIButton!
    @IBOutlet weak var skipToGoalsButton: UIButton!
    
    // Answer elements
    // Age Picker
    var agePicker = UIPickerView()
    let okButton = UIButton()
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
    //
    @IBOutlet weak var progressBar: UIProgressView!
    //
    // Me/Goals/Sessions
    var selectedSection = 0
    // Question progress, incrimented by nextQuestion()
    var selectedQuestion = 0
    
    // schedule
    var comingFromSchedule = false
    // from schedule editing
    var comingFromScheduleEditing = false
    
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
        sectionLabel.text = NSLocalizedString("me", comment: "")
        //
        // Background Image/Colour
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            backgroundImageView.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = Colours.colour1
        }
        // Blur
        // BackgroundBlur/Vibrancy
        let backgroundBlur = UIVisualEffectView()
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        backgroundBlur.frame = backgroundImageView.bounds
        if backgroundIndex > BackgroundImages.backgroundImageArray.count {
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
        progressBar.trackTintColor = Colours.colour1
        progressBar.progressTintColor = Colours.colour3
        progressBar.setProgress(0, animated: true)
        //
        //
        skipToGoalsButton.backgroundColor = Colours.colour2.withAlphaComponent(0.5)
        if comingFromSchedule == true {
            skipToGoalsButton.isUserInteractionEnabled = true
            skipToGoalsButton.isEnabled = true
            skipToGoalsButton.alpha = 1
            dismissViewButton.isUserInteractionEnabled = true
            dismissViewButton.isEnabled = true
            dismissViewButton.alpha = 1
        } else {
            skipToGoalsButton.isUserInteractionEnabled = false
            skipToGoalsButton.isEnabled = false
            skipToGoalsButton.alpha = 0
            dismissViewButton.isUserInteractionEnabled = false
            dismissViewButton.isEnabled = false
            dismissViewButton.alpha = 0
        }
        
        //
        // Previous question swipe
        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(previousQuestion))
        downSwipe.direction = .down
        questionsTable.addGestureRecognizer(downSwipe)
        //
        downTap = UITapGestureRecognizer(target: self, action: #selector(previousQuestion))
        sectionLabel.isUserInteractionEnabled = true
        sectionLabel.addGestureRecognizer(downTap)
        //
        upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upSwipeAction))
        upSwipe.direction = .up
        questionsTable.addGestureRecognizer(upSwipe)
        
        //
        // If coming from schedule editing, means that the user wants help editing schedule, so profile irrelevent, skip to schedule creation questions
        if comingFromScheduleEditing == true {
            //
            // Go to relevant question
            selectedQuestion = 19
            updateProgress()
            let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
            questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
            questionsTable.reloadData()
            //
            // Enable back button
        }
    }
    
    //
    // Table View --------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        // Me
        if selectedSection == 0 {
            return 1
            // Goals/Session
        } else {
            return scheduleDataStructures.profileQA[selectedSection].count
        }
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Me
        if selectedSection == 0 {
            return ""
            // Goals/Session
        } else {
            return NSLocalizedString(scheduleDataStructures.profileQA[selectedSection][section][0], comment: "")
        }
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //
        if selectedSection != 0 {
            // Header
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 22)!
            header.textLabel?.textColor = Colours.colour1
            //
            header.backgroundColor = .clear
            header.backgroundView = UIView()
            //
            let seperator = CALayer()
            if header.layer.sublayers?.contains(seperator) == false {
                seperator.frame = CGRect(x: 15, y: header.frame.size.height - 1, width: view.frame.size.width, height: 1)
                seperator.backgroundColor = Colours.colour1.cgColor
                seperator.opacity = 0.5
                header.layer.addSublayer(seperator)
            }
        }
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //
        if tableView == questionsTable {
            // Me
            if selectedSection == 0 {
                return 0
                // Goals/Session
            } else {
                let height = questionsTable.bounds.height / CGFloat(scheduleDataStructures.profileQA[selectedSection].count * 2 + 1)
                if height >= 45 {
                    return height
                } else {
                    return 45
                }
            }
        }
        return 0
    }
    
    
    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        if tableView == questionsTable {
            // Me
            if selectedSection == 0 {
                let count = scheduleDataStructures.profileQA[0].count
                return count
                // Goals/Session
            } else {
                // If last section, add extra cell for completion
                // Goals -> nSessions, nSessions -> Schedule Creator
                if section == scheduleDataStructures.profileQA[selectedSection].count - 1 {
                    return 2
                } else {
                    return 1
                }
            }
        }
        return 0
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        if tableView == questionsTable {
            if selectedSection == 0 {
                return questionsTable.bounds.height
            } else {
                let height = questionsTable.bounds.height / CGFloat(scheduleDataStructures.profileQA[selectedSection].count * 2 + 1)
                if height >= 45 {
                    return height
                } else {
                    return 45
                }
            }
        }
        return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        // Switch, me, goals, sessions
        switch selectedSection {
        // Me
        case 0:
            // Question Table
            if tableView == questionsTable && indexPath.row == selectedQuestion {
                switch indexPath.row {
                // Age Picker
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileAgeCell", for: indexPath) as! ProfileAgeCell
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
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
                    cell.row = indexPath.row
                    cell.answerImageArray = scheduleDataStructures.answerImageArray
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
                slider.thumbTintColor = Colours.colour2
                slider.minimumTrackTintColor = Colours.colour3
                slider.maximumTrackTintColor = Colours.colour4
                // Frame
                slider.frame = CGRect(x: 45, y: (cell.bounds.height - slider.frame.height) / 2, width: view.frame.size.width - 60, height: slider.frame.height)
                // Values
                slider.minimumValue = 0
                slider.maximumValue = 2
                // Section tag
                slider.tag = indexPath.section
                //
                let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
                let value = profileAnswers[self.selectedSection][indexPath.section]
                slider.value = Float(value)
                //
                // Indicator Label
                cell.textLabel?.text = String(value)
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.textLabel?.textColor = Colours.colour1
                //
                // Next Section -> N Sessions
            } else {
                // Indicator Label
                cell.backgroundColor = Colours.colour3.withAlphaComponent(0.25)
                cell.textLabel?.text = NSLocalizedString("done", comment: "")
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.textLabel?.textColor = Colours.colour1
                cell.textLabel?.textAlignment = .center
            }
            return cell
            //
        // Session
        case 2:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            // Sliders
            // Only row 1 in final section, for next section, rest are in seperate sections, row 0
            if indexPath.row != 1 {
                //
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                //
                // Slider
                let slider = UISlider()
                cell.addSubview(slider)
                slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
                // Frame
                slider.frame = CGRect(x: 45, y: (cell.bounds.height - slider.frame.height) / 2, width: view.frame.size.width - 60, height: slider.frame.height)
                // Values
                // mind
                if indexPath.section == 0 {
                    slider.minimumValue = 0
                    slider.maximumValue = 14
                } else {
                    slider.minimumValue = 0
                    slider.maximumValue = 10
                }
                
                // Colours
                setSliderGradient(slider: slider, section: indexPath.section)
                // Section tag
                slider.tag = indexPath.section
                //
                let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
                // NOTE TOTAL N SESSIONS, THOUGH IN SAME ARRAY, IS PRESENTED IN TITLE
                // Therefore section + 1 to find first section value (n sessions is 0)
                let value = profileAnswers[selectedSection][indexPath.section + 1]
                slider.value = Float(value)
                //
                // Indicator Label
                cell.textLabel?.text = String(value)
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.textLabel?.textColor = Colours.colour1
                //
                // Next Section -> Create schedule
            } else {
                // Indicator Label
                cell.backgroundColor = Colours.colour3.withAlphaComponent(0.25)
                cell.textLabel?.text = NSLocalizedString("createSchedule", comment: "")
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.textLabel?.textColor = Colours.colour1
                cell.textLabel?.textAlignment = .center
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        //
        var count = 0
        for i in 0...profileAnswers[selectedSection].count - 1 {
            count += profileAnswers[selectedSection][i]
        }
        
        // If user has actually put something in, do something
        if count != 0 {
            if selectedSection == 1 {
                nextQuestion()
            } else if selectedSection == 2 {
                // MARK: Update schedules full week list
                // add each group * n sessions to the list (e.g [mind, mind, mind, flexibility, muscle gain, muscle gain] = [0,0,0,1,4,4]
                //
                var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
                var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
                // reset full week list
                schedules[0][7] = []
                scheduleTracking[0][7] = []
                // from 1, and -2 as array includes total n sessions
                // Loop group sessions array
                for i in 1...profileAnswers[2].count - 2 {
                    if profileAnswers[2][i] != 0 {
                        // Loop n session of each group with more than 0 sessions
                        for _ in 1...profileAnswers[2][i] {
                            // i - 1 as group number is 1 less as array includes total n sessions so is offset by 1
                            schedules[0][7].append(i - 1)
                            scheduleTracking[0][7].append(scheduleDataStructures.scheduleTrackingArrays[i - 1]!)
                        }
                    }
                }
                UserDefaults.standard.set(schedules, forKey: "schedules")
                UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
                
                
                // Go to schedule creator
                self.performSegue(withIdentifier: "ScheduleViewQuestionSegue", sender: self)
            }
        }
    }
    
    // Mask cells under clear header
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if selectedSection > 0 {
            for cell in questionsTable.visibleCells {
                let hiddenFrameHeight = scrollView.contentOffset.y + 49 - cell.frame.origin.y + 2
                if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
                    maskCell(cell: cell, margin: Float(hiddenFrameHeight))
                }
            }
        }
    }
    func maskCell(cell: UITableViewCell, margin: Float) {
        cell.layer.mask = visibilityMaskForCell(cell: cell, location: (margin / Float(cell.frame.size.height) ))
        cell.layer.masksToBounds = true
    }
    func visibilityMaskForCell(cell: UITableViewCell, location: Float) -> CAGradientLayer {
        let mask = CAGradientLayer()
        mask.frame = cell.bounds
        mask.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        mask.locations = [NSNumber(value: location), NSNumber(value: location)]
        return mask;
    }
    
    
    //
    // MARK: Slider Helpers -----------------------------------------------------------
    //
    // MARK: sliderValueChanged
    let step: Float = 1
    @IBAction func sliderValueChanged(sender: UISlider) {
        var profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
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
        // N Sessions
        // Change thumbTintColor for groups
        // Update total n sessions
        if selectedSection == 2 {
            profileAnswers[selectedSection][sender.tag + 1] = Int(roundedInt)
            // Thumb Tint
            // Red, below and above suggested
            let index = indexPath.section * 2
            let rangeLower = profileAnswers[3][index]
            let rangeUpper = profileAnswers[3][index + 1]
            // Value within range -> Green
            if roundedInt >= rangeLower && roundedInt <= rangeUpper {
                sender.thumbTintColor = Colours.colour3
                // Value out of range -> Red
            } else {
                sender.thumbTintColor = Colours.colour4
            }
            //
            // Total n sessions
            var nSessions = 0
            for i in 1...profileAnswers[2].count - 1 {
                nSessions += profileAnswers[2][i]
            }
            profileAnswers[2][0] = nSessions
            //
            let titleString = String(nSessions) + NSLocalizedString("nSessionsPerWeek", comment: "")
            sectionLabel.text = titleString
            
            // Goals
        } else {
            profileAnswers[selectedSection][sender.tag] = Int(roundedInt)
        }
        UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
        
    }
    
    //
    // MARK: Set Slider Gradient
    //
    func setSliderGradient(slider:UISlider, section: Int) {
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        // Max possible slider value
        var maxValue = Int()
        if section == 0 {
            maxValue = 14
        } else {
            maxValue = 10
        }
        //
        // Gradient Layer
        let tgl = CAGradientLayer()
        let frame = CGRect(x: 0.0, y: 0.0, width: slider.bounds.width, height: 2 )
        tgl.frame = frame
        //
        // Locations
        var locationsArray = [Double]()
        let index = section * 2
        let rangeLower = Double(profileAnswers[3][index]) / Double(maxValue)
        var rangeLower1 = Double()
        var rangeLower2 = Double()
        if profileAnswers[3][index] != 0 {
            rangeLower1 = rangeLower - 0.01
            rangeLower2 = rangeLower + 0.01
        } else {
            rangeLower1 = 0
            rangeLower1 = 0.01
        }
        let rangeUpper = Double(profileAnswers[3][index + 1]) / Double(maxValue)
        var rangeUpper1 = Double()
        var rangeUpper2 = Double()
        if profileAnswers[3][index + 1] != 0 {
            rangeUpper1 = rangeUpper - 0.01
            rangeUpper2 = rangeUpper + 0.01
        } else {
            rangeUpper1 = 0.02
            rangeUpper2 = 0.03
        }
        locationsArray = [0, rangeLower1,rangeLower2, rangeUpper1,rangeUpper2, 1]
        //
        tgl.colors = [Colours.colour4.cgColor,Colours.colour4.cgColor,Colours.colour3.cgColor,Colours.colour3.cgColor,Colours.colour4.cgColor,Colours.colour4.cgColor]
        tgl.locations = locationsArray as [NSNumber]
        tgl.endPoint = CGPoint(x: 1.0, y:  1.0)
        tgl.startPoint = CGPoint(x: 0.0, y:  1.0)
        //
        // Button color
        // If within range
        if profileAnswers[2][section + 1] > profileAnswers[3][index] - 1 && profileAnswers[2][section + 1] < profileAnswers[3][index + 1] {
            slider.thumbTintColor = Colours.colour3
        } else {
            slider.thumbTintColor = Colours.colour4
        }
        
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
        // Current Question
        // Add on selectedSection for goals and sessions
        var currentQuestion = Float(selectedQuestion) + Float(selectedSection)
        // Total Number questions
        // + 2 for goals and n sessions
        var questionCount = Float(scheduleDataStructures.profileQA[0].count + 2)
        // -19 as relevant questions for schedule creation start at 19 therefore 19 == first question
        if comingFromScheduleEditing == true {
            currentQuestion -= 19
            questionCount -= 19
        }
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
        // Next Question
        if selectedSection == 0 && selectedQuestion != scheduleDataStructures.profileQA[selectedSection].count - 1 {
            selectedQuestion += 1
            updateProgress()
            let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
            questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
            // -> Goals Section
        } else if selectedQuestion == scheduleDataStructures.profileQA[selectedSection].count - 1 && selectedSection == 0 {
            questionsTable.removeGestureRecognizer(downSwipe)
            sectionLabel.addGestureRecognizer(downTap)
            //
            sectionLabel.text = NSLocalizedString("goalsI", comment: "")
            selectedSection += 1
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
            questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
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
            //
            if comingFromSchedule == true {
                skipToGoalsButton.isEnabled = false
                skipToGoalsButton.isUserInteractionEnabled = false
                skipToGoalsButton.alpha = 0
            }
            
            // -> NSession Section
        } else {
            // Select app schedule
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            settings[7][0] = 0
            UserDefaults.standard.set(settings, forKey: "userSettings")
            //
            // MARK: CALL FUNCTIONS THAT SET DIFFICULTY LEVELS AND N SESSIONS
            setDifficultyLevels()
            setNumberOfSessions(updating: false)
            //
            let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
            //
            selectedSection += 1
            updateProgress()
            questionsTable.isScrollEnabled = true
            //
            let titleString = String(profileAnswers[2][0]) + NSLocalizedString("nSessionsPerWeek", comment: "")
            sectionLabel.text = titleString
            //
            // Animate as if normal scroll down
            let snapShot1 = questionsTable.snapshotView(afterScreenUpdates: false)
            snapShot1?.center.y = questionsTable.center.y
            view.insertSubview(snapShot1!, aboveSubview: questionsTable)
            // Reload
            questionsTable.reloadData()
            let indexPath = NSIndexPath(row: 0, section: 0)
            questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
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
        }
    }
    
    //
    //
    @objc func upSwipeAction() {
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        if selectedSection == 0 {
            // If question has been answered
            if profileAnswers[0][selectedQuestion] != -1 {
                // Me Section
                // Next Question
                if selectedQuestion != scheduleDataStructures.profileQA[selectedSection].count - 1 {
                    selectedQuestion += 1
                    updateProgress()
                    let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
                    questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
                    // -> Goals Section
                }
            }
        }
    }
    
    //
    @objc func previousQuestion() {
        // Me
        if selectedSection == 0 {
            var initialQuestion = 0
            // If coming from schedule, profile irrelevent, only creation of schedule relevant (question 19 or above)
            if comingFromScheduleEditing == true {
                initialQuestion = 19
            }
            if selectedQuestion > initialQuestion {
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
            // Goals -> Me
        } else if selectedSection == 1 {
            questionsTable.isScrollEnabled = false
            questionsTable.addGestureRecognizer(downSwipe)
            sectionLabel.removeGestureRecognizer(downTap)
            selectedSection -= 1
            updateProgress()
            questionsTable.reloadData()
            let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
            questionsTable.reloadRows(at: [indexPath as IndexPath], with: .automatic)
            questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
            //
            sectionLabel.text = NSLocalizedString("me", comment: "")
            
            if comingFromSchedule == true {
                skipToGoalsButton.isEnabled = true
                skipToGoalsButton.isUserInteractionEnabled = true
                skipToGoalsButton.alpha = 1
            }
            //
            //            questionsTable.reloadData()
            
            // Sessions -> Goals
        } else {
            selectedSection -= 1
            updateProgress()
            questionsTable.reloadData()
            sectionLabel.text = NSLocalizedString("goals", comment: "")
        }
    }
    
    //
    // Skip to goals
    @IBAction func skipToGoalsAction(_ sender: Any) {
        skipToGoalsButton.isEnabled = false
        skipToGoalsButton.isUserInteractionEnabled = false
        skipToGoalsButton.alpha = 0
        // Set selected question to last question and perform nextquestion()
        selectedQuestion = scheduleDataStructures.profileQA[selectedSection].count - 1
        nextQuestion()
    }
    
    //
    // Dismiss View
    @IBAction func dismissViewButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
