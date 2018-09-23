//
//  ScheduleTableView.swift
//  MindAndBody
//
//  Created by Luke Smith on 22.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

extension ScheduleScreen: UITableViewDelegate, UITableViewDataSource {
    //
    // Schedule TableView
    // Sections
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        switch tableView {
        case scheduleTable:
            var title = String()
            if scheduleStyle == 0 {
                title = NSLocalizedString(dayArray[ScheduleVariables.shared.selectedDay], comment: "")
                // week
            } else {
                let weekOfThe = NSLocalizedString("weekOfThe", comment: "")
                // Date formatters
                let df = DateFormatter()
                df.dateFormat = "dd"
                let firstMonday = df.string(from: Date().firstMondayInCurrentWeek)
                let firstMondayInt = Int(firstMonday)
                //
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .ordinal
                let firstMondayWithOrdinal = numberFormatter.string(from: firstMondayInt! as NSNumber)
                //
                title = weekOfThe + firstMondayWithOrdinal!
            }
            
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = Fonts.lessonTitle
            titleLabel.textColor = foregroundColor
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            let size = titleLabel.sizeThatFits(CGSize(width: view.bounds.width - 54, height: .greatestFiniteMagnitude))
            titleLabel.frame = CGRect(x: tableSpacing, y: headerHeight - size.height - (tableSpacing * 3/4), width: view.bounds.width - 32, height: size.height)
            header.addSubview(titleLabel)
            
            
        case scheduleChoiceTable:
            
            let titleLabel = UILabel()
            titleLabel.text = NSLocalizedString("mySchedules", comment: "")
            titleLabel.font = Fonts.navigationBar
            titleLabel.textColor = Colors.dark
            titleLabel.numberOfLines = 1
            titleLabel.textAlignment = .center
            titleLabel.frame = CGRect(x: 0, y: 0, width: scheduleChoiceTable.bounds.width, height: 47)
            header.addSubview(titleLabel)
            
            header.backgroundColor = Colors.light
            
            break
        default: break
        }
        return header
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //
        switch tableView {
        case scheduleTable:
            // day
            return headerHeight + headerSpacing
        case scheduleChoiceTable:
            return 47
        default:
            return 0
        }
    }
    
    // Rows
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        //
        switch tableView {
        case scheduleTable:
            // First Screen, showing groups
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                if schedules.count != 0 {
                    // Note: +1 for extra sessions cell
                    if scheduleStyle == 0 {
                        return schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![ScheduleVariables.shared.selectedDay].count + 1
                    } else {
                        return TemporaryWeekArray.shared.weekArray.count + 1
                    }
                } else {
                    return 1
                }
            // Selecting a session
            } else {
                return sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]].count
            }
        case scheduleChoiceTable:
            return schedules.count
        default:
            return 0
        }
        //
    }
    
    // Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case scheduleTable:
            // First choice == session choice
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
                if schedules.count != 0 {
                    // Get number of rows
                    var count = 0
                    if scheduleStyle == 0 {
                        count = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![ScheduleVariables.shared.selectedDay].count + 1
                    } else if scheduleStyle == 1 {
                        count = TemporaryWeekArray.shared.weekArray.count + 1
                    }
                    
                    // If height set to 72 is too big
                    if CGFloat(count) * presetCellHeight > (scheduleTable.bounds.height - headerHeight) {
                        
                        // Height calculated to fit screen unless it gets too small
                        let height = (scheduleTable.bounds.height - headerHeight) / CGFloat(count)
                        if height < 49 {
                            cellHeight = 49
                            return 49
                        } else {
                            cellHeight = height
                            return height
                        }
                        
                    // Height 72
                    } else {
                        cellHeight = presetCellHeight
                        return presetCellHeight
                    }
                } else {
                    cellHeight = presetCellHeight
                    return presetCellHeight
                }
                
            // Not first choice
            } else {
                // If too many choices, reduce size of cell
                if CGFloat((sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]].count) * 72) > (scheduleTable.bounds.height - headerHeight) {
                    let height = (scheduleTable.bounds.height - headerHeight) / CGFloat((sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]]).count)
                    cellHeight = height
                    return height
                    
                // Height 72
                } else {
                    cellHeight = 72
                    return 72
                }
            }
            
        case scheduleChoiceTable:
            return 47
        default:
            return 0
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Note: accessing title so cast as any
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        // Get cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        //
        switch tableView {
        case scheduleTable:
            
            if schedules.count != 0 {
                //
                cell.tag = indexPath.row
                
                // First Screen, showing groups
                if ScheduleVariables.shared.choiceProgress[0] == -1 {
                    
                    // Extra Session Cell
                    if scheduleStyle == 0 && indexPath.row == schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![ScheduleVariables.shared.selectedDay].count || scheduleStyle == 1 && indexPath.row == TemporaryWeekArray.shared.weekArray.count {
                        
                        // Groups
                        let extraLabel = UILabel()
                        extraLabel.font = Fonts.scheduleCell
                        extraLabel.textColor = foregroundColor
                        extraLabel.text = NSLocalizedString("extra", comment: "")
                        extraLabel.sizeToFit()
                        extraLabel.frame = CGRect(x: tableSpacing, y: 0, width: view.bounds.width - 54, height: cellHeight)
                        cell.addSubview(extraLabel)
                        
                        //
                        // Checkmark box
                        let checkBox = UIButton()
                        checkBox.tag = indexPath.row
                        checkBox.layer.backgroundColor = UIColor.clear.cgColor
                        checkBox.layer.borderWidth = 1
                        checkBox.layer.borderColor = foregroundColor.withAlphaComponent(0.33).cgColor
                        checkBox.layer.cornerRadius = 4
                        checkBox.frame = CGRect(x: view.bounds.width - tableSpacing - 24.5, y: 0, width: 24.5, height: 24.5)
                        checkBox.center.y = extraLabel.center.y
                        checkBox.setImage(#imageLiteral(resourceName: "Plus"), for: .normal)
                        checkBox.imageView?.tintColor = foregroundColor
                        checkBox.isEnabled = false
                        cell.addSubview(checkBox)
                        
                        extraLabel.alpha = 0.33
                        checkBox.alpha = 0.33
                        
                    // Session cells
                    } else {
                        
                        let gap: CGFloat = 8
                        let imageHeight = cellHeight - (2*gap)
                        // Groups
                        let dayLabel = UILabel()
                        dayLabel.font = Fonts.scheduleCell
                        dayLabel.textColor = foregroundColor
                        //
                        var groupString = String()
                        if scheduleStyle == 0 {
                            groupString = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![ScheduleVariables.shared.selectedDay][indexPath.row]["group"] as! String
                        } else {
                            groupString = TemporaryWeekArray.shared.weekArray[indexPath.row]["group"] as! String
                        }
                        dayLabel.text = NSLocalizedString(groupString, comment: "")
                        dayLabel.numberOfLines = 2
                        dayLabel.frame = CGRect(x: tableSpacing + 8 + imageHeight, y: 0, width: view.bounds.width - 54, height: cellHeight)
                        cell.addSubview(dayLabel)
                        
                        
                        let groupImage = UIImageView()
                        groupImage.frame = CGRect(x: tableSpacing, y: gap, width: imageHeight, height: imageHeight)
                        groupImage.contentMode = .scaleAspectFill
                        groupImage.clipsToBounds = true
                        groupImage.image = groupImages[groupString]
                        groupImage.layer.cornerRadius = 4
                        cell.addSubview(groupImage)
                        
                        
                        //
                        // Checkmark box
                        let checkBox = UIButton()
                        checkBox.tag = indexPath.row
                        checkBox.layer.backgroundColor = UIColor.clear.cgColor
                        checkBox.layer.borderWidth = 1
                        checkBox.layer.borderColor = foregroundColor.cgColor
                        checkBox.layer.cornerRadius = 4
                        checkBox.frame = CGRect(x: view.bounds.width - tableSpacing - 24.5, y: 0, width: 24.5, height: 24.5)
                        checkBox.center.y = dayLabel.center.y
                        checkBox.addTarget(self, action: #selector(markAsCompleted(_:)), for: .touchUpInside)
                        cell.addSubview(checkBox)
                        
                        // To make sure its easy to press the button
                        let checkBoxExtraButton = UIButton()
                        checkBoxExtraButton.tag = indexPath.row
                        checkBoxExtraButton.frame = CGRect(x: 0, y: 0, width: cellHeight, height: cellHeight)
                        checkBoxExtraButton.center.x = checkBox.center.x
                        checkBoxExtraButton.addTarget(self, action: #selector(markAsCompleted(_:)), for: .touchUpInside)
                        cell.addSubview(checkBoxExtraButton)
                        
                        //
                        // CheckMark if completed
                        if ScheduleVariables.shared.shouldReloadChoice {
                            if indexPath.row != ScheduleVariables.shared.selectedRows[0] {
                                if isCompleted(row: indexPath.row) {
                                    checkButton(button: checkBox)
                                }
                            }
                        } else if isCompleted(row: indexPath.row) {
                            checkButton(button: checkBox)
                        }
                    }
                    
                // Currently selecting a session, i.e not first screen
                } else {
                    // If title
                    if indexPath.row == 0 {
                        
                        let title = sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]][0]
                        cell.textLabel?.font = Fonts.scheduleCell
                        cell.textLabel?.textColor = foregroundColor
                        cell.textLabel?.text = NSLocalizedString(title, comment: "")
                        cell.textLabel?.textAlignment = .center
                        cell.textLabel?.frame = CGRect(x: view.bounds.width / 2, y: 0, width: view.bounds.width / 2, height: cellHeight)
                        //
                        cell.selectionStyle = .none
                        
                        // Title Underline
                        
                        let separator = CALayer()
                        separator.frame = CGRect(x: view.bounds.width / 4, y: cellHeight - 1, width: view.bounds.width / 2, height: 1)
                        separator.backgroundColor = foregroundColor.cgColor
                        separator.opacity = 0.25
                        cell.layer.addSublayer(separator)
                        
                        // TODO: question mark
                        // Question mark - explanation of choice
                        if needsExplanation() {
                            
                            let explanationButton = UIButton()
                            explanationButton.frame = CGRect(x: view.bounds.width * (3/4), y: 0, width: view.bounds.width / 4, height: cellHeight)
                            explanationButton.setImage(#imageLiteral(resourceName: "QuestionMarkMenu"), for: .normal)
                            explanationButton.tintColor = foregroundColor
                            explanationButton.addTarget(self, action: #selector(presentExplanation), for: .touchUpInside)
                            cell.addSubview(explanationButton)
                            
                            let border = UIView()
                            border.layer.borderWidth = 1
                            border.layer.borderColor = foregroundColor.withAlphaComponent(0.13).cgColor
                            border.layer.cornerRadius = 11
                            border.frame.size = CGSize(width: 44, height: 44)
                            border.center = explanationButton.center
                            border.isUserInteractionEnabled = false
                            cell.addSubview(border)
                        }
                        
                    // Else if selection
                    } else {
                        //
                        let choiceLabel = UILabel()
                        choiceLabel.font = Fonts.scheduleCell
                        choiceLabel.textColor = foregroundColor
                        
                        // Normal
                        let groupString = sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]][indexPath.row]
                        choiceLabel.text = NSLocalizedString(groupString, comment: "")
                        choiceLabel.numberOfLines = 2
                        choiceLabel.sizeToFit()
                        choiceLabel.frame = CGRect(x: tableSpacing, y: 0, width: view.bounds.width - 54, height: cellHeight)
                        cell.addSubview(choiceLabel)
                        
                        if isLastChoice() {
                            
                            // Checkmark box
                            let checkBox = UIButton()
                            checkBox.tag = indexPath.row
                            // Use layer as not affected by cell highlight
                            checkBox.layer.backgroundColor = UIColor.clear.cgColor
                            checkBox.backgroundColor = .clear
                            checkBox.layer.borderWidth = 1
                            checkBox.layer.borderColor = foregroundColor.cgColor
                            checkBox.layer.cornerRadius = 4
                            checkBox.frame = CGRect(x: view.bounds.width - tableSpacing - 24.5, y: 0, width: 24.5, height: 24.5)
                            checkBox.center.y = choiceLabel.center.y
                            checkBox.addTarget(self, action: #selector(markAsCompleted(_:)), for: .touchUpInside)
                            cell.addSubview(checkBox)
                            
                            // To make sure its easy to press the button
                            let checkBoxExtraButton = UIButton()
                            checkBoxExtraButton.tag = indexPath.row
                            var height = 72
                            if scheduleStyle == 1 && ScheduleVariables.shared.choiceProgress[0] == -1 {
                                height = 49
                            }
                            checkBoxExtraButton.frame = CGRect(x: 0, y: 0, width: height, height: height)
                            checkBoxExtraButton.center.x = checkBox.center.x
                            checkBoxExtraButton.addTarget(self, action: #selector(markAsCompleted(_:)), for: .touchUpInside)
                            cell.addSubview(checkBoxExtraButton)
                            
                            // CheckMark if completed
                            // - 1 as title included, so rows offset by 1
                            if indexPath.row != 0 {
                                if isCompleted(row: indexPath.row) {
                                    checkButton(button: checkBox)
                                }
                            }
                        }
                    }
                }
                
            // No schedules, note saying create one in top right
            } else {
                
                // Groups
                let noteLabel = UILabel()
                noteLabel.numberOfLines = 0
                noteLabel.lineBreakMode = .byWordWrapping
                noteLabel.font = UIFont(name: "SFUIDisplay-light", size: 17)
                noteLabel.textColor = foregroundColor
                noteLabel.text = NSLocalizedString("noScheduleNote", comment: "")
                noteLabel.sizeToFit()
                noteLabel.frame = CGRect(x: tableSpacing, y: 0, width: view.bounds.width - 54, height: cellHeight)
                cell.addSubview(noteLabel)
            }
            
        
        case scheduleChoiceTable:
            
            let label = UILabel()
            label.font = Fonts.smallElementRegular
            label.text = schedules[indexPath.row]["scheduleInformation"]![0][0]["title"] as? String
            label.textColor = Colors.light
            label.sizeToFit()
            // twice nomal padding
            let padding: CGFloat = 16 + 16
            // 1 for border
            label.center = CGPoint(x: 1 + padding + (label.bounds.width / 2), y: cell.bounds.height / 2)
            cell.addSubview(label)
            
            let selectedSchedule = UserDefaults.standard.integer(forKey: "selectedSchedule")
            if indexPath.row == selectedSchedule {
                let indicator = UIImageView()
                indicator.image = #imageLiteral(resourceName: "CheckMark")
                indicator.frame.size = CGSize(width: cell.bounds.height / 2, height: cell.bounds.height / 2)
                indicator.center = CGPoint(x: 1 + (padding / 2), y: label.center.y)
                indicator.tintColor = Colors.green
                cell.addSubview(indicator)
                
                let editButton = UIButton()
                editButton.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
                editButton.titleLabel?.font = Fonts.smallElementLight
                editButton.setTitleColor(UIColor.gray, for: .normal)
                editButton.sizeToFit()
                let buttonWidth = editButton.bounds.width
                editButton.frame = CGRect(x: tableView.bounds.width - buttonWidth - 32, y: 0, width: buttonWidth + 32, height: 47)
                editButton.addTarget(self, action: #selector(editScheduleAction), for: .touchUpInside)
                cell.addSubview(editButton)
            }
            
        //
        default:
            break
        }
        //
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        //
        return cell
    }
    
    // MARK: Helper
    func checkButton(button: UIButton) {
        button.setImage(#imageLiteral(resourceName: "CheckMark"), for: .normal)
        button.imageView?.tintColor = foregroundColor
        // Use layer as not affected by cell highlight
        button.layer.backgroundColor = Colors.green.cgColor
        button.backgroundColor = Colors.green
        button.layer.borderColor = Colors.green.cgColor
    }
        
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Silly highlighting issue
        // Highlight affects checkBox background colors, therefore find the button through the image, and set the background color to green if the border is green as implies that it is selected
        if tableView == scheduleTable {
            let cell = tableView.cellForRow(at: indexPath)
            for view in (cell?.subviews)! {
                if view is UIButton {
                    if let image = (view as! UIButton).imageView?.image, image == #imageLiteral(resourceName: "CheckMark") {
                        view.backgroundColor = Colors.green
                    }
                }
            }
        }
        
        //
        // Session choice
        switch tableView {
        case scheduleTable:
            let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]

            // If title of choice table, do nothing, if not then do something
            if !(ScheduleVariables.shared.choiceProgress[0] != -1 && indexPath.row == 0) {
                
                // First choice
                if ScheduleVariables.shared.choiceProgress[0] == -1 {
                    
                    // Extra session
                    // (day view last cell || week view last cell)
                    if  (scheduleStyle == 0 && indexPath.row == schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![ScheduleVariables.shared.selectedDay].count || scheduleStyle == 1 && indexPath.row == TemporaryWeekArray.shared.weekArray.count) {
                        didSelectRowHandler(row: 723)
                        
                    // Normal session, if not completed, do something
                    } else if !isCompleted(row: indexPath.row) {
                        didSelectRowHandler(row: indexPath.row)
                    }
                    
                    tableView.deselectRow(at: indexPath, animated: true)
                    
                // Other choices
                } else {
                    
                    // Normal
                    if !isLastChoice() {
                        didSelectRowHandler(row: indexPath.row)
                        
                    // If last choice and not completed, do something
                    } else if isLastChoice() && !isCompleted(row: indexPath.row) {
                        didSelectRowHandler(row: indexPath.row)
                    }
                    
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            }
          
        // Select schedule
        case scheduleChoiceTable:
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
            
            // Select new schedule, update schedule style, and save
            var selectedSchedule = UserDefaults.standard.integer(forKey: "selectedSchedule")
            
            selectedSchedule = indexPath.row
            ScheduleVariables.shared.selectedSchedule = selectedSchedule
            scheduleStyle = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int
            
            UserDefaults.standard.set(selectedSchedule, forKey: "selectedSchedule")
            ICloudFunctions.shared.pushToICloud(toSync: ["selectedSchedule"])
            
            // If week view, create temporary week array
            TemporaryWeekArray.shared.createTemporaryWeekViewArray()
            
            // Reload table
            layoutViews()
            scheduleChoiceTable.reloadData()
            self.scheduleTable.reloadData()
            
            // Tracking
            updateWeekGoal()
            updateWeekProgress()
            updateTracking()
            
            // Notifications
            ReminderNotifications.shared.setNotifications()
            tableView.deselectRow(at: indexPath, animated: true)
            
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // Enable ok alert action func
    @objc func textChanged(_ sender: UITextField) {
        if sender.text == "" {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    
    // Delete
    //
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //
        if tableView == scheduleTable {
            return false
        } else if tableView == scheduleChoiceTable {
            return true
        }
        return false
    }
    
    // Commit editing style
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        //
        // Delete if not plus row
        if tableView == scheduleChoiceTable && editingStyle == UITableViewCellEditingStyle.delete {
            //
            // Update arrays
            schedules.remove(at: indexPath.row)
            UserDefaults.standard.set(schedules, forKey: "schedules")
                
            // Select 1 schedule before last schedule
            var selectedSchedule = UserDefaults.standard.integer(forKey: "selectedSchedule")
            if schedules.count == 0 {
                selectedSchedule = 0
                scheduleStyle = 0
            } else {
                if selectedSchedule != 0 {
                    selectedSchedule -= 1
                }
                scheduleStyle = schedules[selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int
            }
            ScheduleVariables.shared.selectedSchedule = selectedSchedule
            ScheduleVariables.shared.selectedDay = Date().weekDayFromMonday
            UserDefaults.standard.set(selectedSchedule, forKey: "selectedSchedule")
            
            // If week view, create temporary week array
            if schedules.count != 0 {
                TemporaryWeekArray.shared.createTemporaryWeekViewArray()
            }
            
            // Reload table
            layoutViews()
            scheduleTable.reloadData()
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["schedules", "selectedSchedule"])
            // Tracking
            updateWeekGoal()
            updateWeekProgress()
            updateTracking()
            // Set Notifications
            ReminderNotifications.shared.setNotifications()
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)

            // Change indicator
            if schedules.count != 0 {
                // Select new cell (reloading row has strange animation)
                let indexToReload = IndexPath(row: ScheduleVariables.shared.selectedSchedule, section: 0)
                let cell = tableView.cellForRow(at: indexToReload)
                let padding: CGFloat = 16 + 16

                let indicator = UIImageView()
                indicator.image = #imageLiteral(resourceName: "CheckMark")
                indicator.frame.size = CGSize(width: (cell?.bounds.height)! / 2, height: (cell?.bounds.height)! / 2)
                indicator.center = CGPoint(x: 1 + (padding / 2), y: (cell?.bounds.height)! / 2)
                indicator.tintColor = Colors.green
                cell?.addSubview(indicator)
                
                let editButton = UIButton()
                editButton.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
                editButton.titleLabel?.font = Fonts.smallElementLight
                editButton.setTitleColor(UIColor.gray, for: .normal)
                editButton.sizeToFit()
                let buttonWidth = editButton.bounds.width
                editButton.frame = CGRect(x: tableView.bounds.width - buttonWidth - 32, y: 0, width: buttonWidth + 32, height: 47)
                editButton.addTarget(self, action: #selector(editScheduleAction), for: .touchUpInside)
                cell?.addSubview(editButton)
            }
        }
    }
}
