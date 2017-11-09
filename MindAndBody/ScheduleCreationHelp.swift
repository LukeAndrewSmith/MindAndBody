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
    @IBOutlet weak var backButton: UIButton!
    
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
    //
    @IBOutlet weak var progressBar: UIProgressView!
    //
    // Me/Goals/Sessions
    var selectedSection = 0
    // Question progress, incrimented by nextQuestion()
    var selectedQuestion = 0
    
    //
    var comingFromScheduleEditing = false
    
    //
    // Age
    var ageAnswer = ["16 (or less)", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "70+"]
    
    
    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Selected Schedule
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        ScheduleVariables.shared.selectedSchedule = settings[7][0]
        //
        UIApplication.shared.statusBarStyle = .lightContent
        //
        sectionLabel.text = NSLocalizedString("me", comment: "")
        //
        // Background Image/Colour
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
        // Me
        if selectedSection == 0 {
            return 1
            // Goals/Session
        } else {
            return scheduleDataStructures.scheduleCreationHelp[selectedSection].count
        }
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Me
        if selectedSection == 0 {
            return ""
            // Goals/Session
        } else {
            return NSLocalizedString(scheduleDataStructures.scheduleCreationHelp[selectedSection][section][0], comment: "")
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
                let height = questionsTable.bounds.height / CGFloat(scheduleDataStructures.scheduleCreationHelp[selectedSection].count * 2 + 1)
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
                let count = scheduleDataStructures.scheduleCreationHelp[0].count
                return count
                // Goals/Session
            } else {
                // If last section, add extra cell for completion
                // Goals -> nSessions, nSessions -> Schedule Creator
                if section == scheduleDataStructures.scheduleCreationHelp[selectedSection].count - 1 {
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
                let height = questionsTable.bounds.height / CGFloat(scheduleDataStructures.scheduleCreationHelp[selectedSection].count * 2 + 1)
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
    // Main table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        // Switch, me, goals, sessions
        switch selectedSection {
        // Me
        case 0:
            // Question Table
            if tableView == questionsTable && indexPath.row == selectedQuestion {
                switch indexPath.row {
                // Answer Table with image (flexibility questions)
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCreationHelpCell", for: indexPath) as! ScheduleCreationHelpCell
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
                let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
                let value = schedules[ScheduleVariables.shared.selectedSchedule][2][self.selectedSection][indexPath.section] as! Int
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
                let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
                // NOTE TOTAL N SESSIONS, THOUGH IN SAME ARRAY, IS PRESENTED IN TITLE
                // Therefore section + 1 to find first section value (n sessions is 0)
                let value = schedules[ScheduleVariables.shared.selectedSchedule][2][selectedSection][indexPath.section + 1] as! Int
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
    
    // Main table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        //
        var count = 0
        for i in 0...schedules[ScheduleVariables.shared.selectedSchedule][2][selectedSection].count - 1 {
            count += schedules[ScheduleVariables.shared.selectedSchedule][2][selectedSection][i] as! Int
        }
        
        // If user has actually put something in, do something
        if count != 0 {
            // Groups -> Sessions
            if selectedSection == 1 {
                nextQuestion()
            // Sessions -> either scheduleviewquestion or scheduleediting
            } else if selectedSection == 2 {
                //
                // MARK: Update schedules full week list
                // add each group * n sessions to the list (e.g [mind, mind, mind, flexibility, muscle gain, muscle gain] = [0,0,0,1,4,4]
                var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
                var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
                // reset full week list
                schedules[ScheduleVariables.shared.selectedSchedule][0][7] = []
                scheduleTracking[0][7] = []
                
                //
                // from 1, and -2 as array includes total n sessions
                // Loop group sessions array
                for i in 1...schedules[ScheduleVariables.shared.selectedSchedule][2][2].count - 2 {
                    if schedules[ScheduleVariables.shared.selectedSchedule][2][2][i] as! Int != 0 {
                        // Loop n session of each group with more than 0 sessions
                        for _ in 1...(schedules[ScheduleVariables.shared.selectedSchedule][2][2][i] as! Int) {
                            // i - 1 as group number is 1 less as array includes total n sessions so is offset by 1
                            schedules[ScheduleVariables.shared.selectedSchedule][0][7].append(i - 1)
                            scheduleTracking[0][7].append(scheduleDataStructures.scheduleTrackingArrays[i - 1]!)
                        }
                    }
                }
                UserDefaults.standard.set(schedules, forKey: "schedules")
                UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
                
                //
                // CHECK WHERE TO GO
                // If not coming from schedule editing, go to scheudle help question
                if comingFromScheduleEditing == false {
                    self.performSegue(withIdentifier: "ScheduleHelpQuestionSegue", sender: self)
                // Schedule editing
                        // -> either pop or go to schedule creator
                } else {
                    let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                    //
                    // If nothing changed, pop, else go to schedule creator
                    var scheduleHasChanged = false
                    var newNSessions = [0,0,0,0,0,0,0]
                    //
                    for i in 0...6 {
                        if schedules[ScheduleVariables.shared.selectedSchedule][0][i].count != 0 {
                            for j in 0...schedules[ScheduleVariables.shared.selectedSchedule][0][i].count - 1 {
                                // i + 1 as week before total n sessions in schedules whereas total n sessions before groups in sessions array
                                newNSessions[schedules[ScheduleVariables.shared.selectedSchedule][0][i][j] as! Int + 1] += 1
                                // Total n sessions count
                                newNSessions[0] += 1
                            }
                        }
                    }
                    
                    //
                    if newNSessions != schedules[ScheduleVariables.shared.selectedSchedule][2][2] as! [Int] {
                        scheduleHasChanged = true
                    }
                    //
                    // GO TO
                    if scheduleHasChanged == true {
                        self.performSegue(withIdentifier: "ScheduleHelpCreationSegue", sender: self)
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
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
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
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
            schedules[ScheduleVariables.shared.selectedSchedule][2][selectedSection][sender.tag + 1] = Int(roundedInt)
            // Thumb Tint
            // Red, below and above suggested
            let index = indexPath.section * 2
            let rangeLower = schedules[ScheduleVariables.shared.selectedSchedule][2][3][index] as! Int
            let rangeUpper = schedules[ScheduleVariables.shared.selectedSchedule][2][3][index + 1] as! Int
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
            for i in 1...schedules[ScheduleVariables.shared.selectedSchedule][2][2].count - 1 {
                nSessions += schedules[ScheduleVariables.shared.selectedSchedule][2][2][i] as! Int
            }
            schedules[ScheduleVariables.shared.selectedSchedule][2][2][0] = nSessions
            //
            let titleString = String(nSessions) + NSLocalizedString("nSessionsPerWeek", comment: "")
            sectionLabel.text = titleString
            
            // Goals
        } else {
            schedules[ScheduleVariables.shared.selectedSchedule][2][selectedSection][sender.tag] = Int(roundedInt)
        }
        
        let test = schedules[ScheduleVariables.shared.selectedSchedule][2][selectedSection] as! [Int]
        
        UserDefaults.standard.set(schedules, forKey: "schedules")
        
    }
    
    //
    // MARK: Set Slider Gradient
    //
    func setSliderGradient(slider:UISlider, section: Int) {
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
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
        let rangeLower = Double(schedules[ScheduleVariables.shared.selectedSchedule][2][3][index] as! Int) / Double(maxValue)
        var rangeLower1 = Double()
        var rangeLower2 = Double()
        if schedules[ScheduleVariables.shared.selectedSchedule][2][3][index] as! Int != 0 {
            rangeLower1 = rangeLower - 0.01
            rangeLower2 = rangeLower + 0.01
        } else {
            rangeLower1 = 0
            rangeLower1 = 0.01
        }
        let rangeUpper = Double(schedules[ScheduleVariables.shared.selectedSchedule][2][3][index + 1] as! Int) / Double(maxValue)
        var rangeUpper1 = Double()
        var rangeUpper2 = Double()
        if schedules[ScheduleVariables.shared.selectedSchedule][2][3][index + 1] as! Int != 0 {
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
        if (schedules[ScheduleVariables.shared.selectedSchedule][2][2][section + 1] as! Int) > (schedules[ScheduleVariables.shared.selectedSchedule][2][3][index] as! Int) - 1 && (schedules[ScheduleVariables.shared.selectedSchedule][2][2][section + 1] as! Int) < (schedules[ScheduleVariables.shared.selectedSchedule][2][3][index + 1] as! Int) {
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
        let currentQuestion = Float(selectedQuestion) + Float(selectedSection)
        // Total Number questions
        // + 2 for goals and n sessions
        let questionCount = Float(scheduleDataStructures.scheduleCreationHelp[0].count + 2)
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
        if selectedSection == 0 && selectedQuestion != scheduleDataStructures.scheduleCreationHelp[selectedSection].count - 1 {
            selectedQuestion += 1
            updateProgress()
            let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
            questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
            // -> Goals Section
        } else if selectedQuestion == scheduleDataStructures.scheduleCreationHelp[selectedSection].count - 1 && selectedSection == 0 {
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
            
        // -> NSession Section
        } else {
            //
            // MARK: CALL FUNCTIONS THAT SET DIFFICULTY LEVELS AND N SESSIONS
            // TODO: CALL SET N SESSIONS
            setNumberOfSessions(updating: false)
            //
            let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
            //
            selectedSection += 1
            updateProgress()
            questionsTable.isScrollEnabled = true
            //
            let titleString = String(schedules[ScheduleVariables.shared.selectedSchedule][2][2][0] as! Int) + NSLocalizedString("nSessionsPerWeek", comment: "")
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
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        if selectedSection == 0 {
            // If question has been answered
            if schedules[ScheduleVariables.shared.selectedSchedule][2][0][selectedQuestion] as! Int != -1 {
                // Me Section
//                // Next Question
//                selectedQuestion += 1
//                updateProgress()
//                let indexPath = NSIndexPath(row: selectedQuestion, section: 0)
//                questionsTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
//                // -> Goals Section
                nextQuestion()
            }
        }
    }
    
    //
    @objc func previousQuestion() {
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
            
        // Sessions -> Goals
        } else {
            selectedSection -= 1
            updateProgress()
            questionsTable.reloadData()
            sectionLabel.text = NSLocalizedString("goals", comment: "")
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
        questionLabel.textColor = Colours.colour1
        questionLabel.layer.cornerRadius = 15
        questionLabel.clipsToBounds = true
        questionLabel.backgroundColor = Colours.colour2
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
            answerImageView.backgroundColor = Colours.colour2
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
        answerTableView.backgroundColor = Colours.colour2
        answerTableView.separatorColor = Colours.colour1.withAlphaComponent(0.5)
        answerTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        answerTableView.layer.cornerRadius = 15
        answerTableView.clipsToBounds = true
        answerTableView.isScrollEnabled = false
        //
        questionLabel.text = NSLocalizedString(scheduleDataStructures.scheduleCreationHelp[selectedSection][row][0], comment: "")
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
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: answerTableView.bounds.width, height: 0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        // + 1 as question inclueded in array
        label.text = NSLocalizedString(scheduleDataStructures.scheduleCreationHelp[selectedSection][selectedQuestion][indexPath.row + 1], comment: "")
        label.sizeToFit()
        //
        setTableHeight()
        //
        if label.bounds.height > 49 {
            return 49 * 1.5
        } else {
            return 49
        }
        //
    }
    
    //
    func setTableHeight() {
        var tableHeightConstant: CGFloat = 0
        for i in 0...scheduleDataStructures.scheduleCreationHelp[selectedSection][selectedQuestion].count - 2 {
            let label = UILabel()
            label.frame = CGRect(x: 0, y: 0, width: answerTableView.bounds.width, height: 0)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.textAlignment = .center
            label.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            // + 1 as question inclueded in array
            label.text = NSLocalizedString(scheduleDataStructures.scheduleCreationHelp[selectedSection][selectedQuestion][i + 1], comment: "")
            label.sizeToFit()
            if label.bounds.height > 49 {
                tableHeightConstant += (49 * 1.5)
            } else {
                tableHeightConstant += 49
            }
        }
        tableHeight.constant = tableHeightConstant
        //
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleDataStructures.scheduleCreationHelp[selectedSection][selectedQuestion].count - 1
    }
    
    // ScheduleCreationHelpCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        //
        cell.backgroundColor = Colours.colour2
        cell.tintColor = Colours.colour3
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        // row + 1 as question included with answers
        cell.textLabel?.text = NSLocalizedString(scheduleDataStructures.scheduleCreationHelp[selectedSection][selectedQuestion][indexPath.row + 1], comment: "")
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        // Select answer
        if schedules[ScheduleVariables.shared.selectedSchedule][2][selectedSection][row] as! Int != -1 && indexPath.row == schedules[ScheduleVariables.shared.selectedSchedule][2][selectedSection][selectedQuestion] as! Int {
            cell.textLabel?.textColor = Colours.colour3
        }
        // If last cell hide seperator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if indexPath.row == (scheduleDataStructures.scheduleCreationHelp[selectedSection][selectedQuestion].count - 2) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        //
        return cell
    }
    
    // Cell Questions table, set answer in array to selected answer
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        schedules[ScheduleVariables.shared.selectedSchedule][2][selectedSection][row] = indexPath.row
        UserDefaults.standard.set(schedules, forKey: "schedules")
        //
        tableView.deselectRow(at: indexPath, animated: true)
        answerTableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.delegate?.nextQuestion()
        }
    }
}
