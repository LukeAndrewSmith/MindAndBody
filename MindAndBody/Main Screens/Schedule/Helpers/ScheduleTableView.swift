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
            if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
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
        
        
        
        switch tableView {
        case scheduleTable:
            if ScheduleVariables.shared.schedules.count > 0 {
                // Note: +1 for extra sessions cell
                if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                    return (ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]?[ScheduleVariables.shared.selectedDay].count)! + 1
                } else {
                    return ScheduleVariables.shared.weekArray.count + 1
                }
            } else {
                return 1
            }
            
        case scheduleChoiceTable:
            return ScheduleVariables.shared.schedules.count
        default:
            return 0
        }
        //
    }
    
    // Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case scheduleTable:
            calculateCellHeight()
            return cellHeight
        case scheduleChoiceTable:
            return 47
        default:
            return 0
        }
    }
    
    func calculateCellHeight() {
        // First choice == session choice
        
        if ScheduleVariables.shared.schedules.count > 0 {
            // Get number of rows
            var count = 0
            if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                count = ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![ScheduleVariables.shared.selectedDay].count + 1
            } else if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.week.rawValue {
                count = ScheduleVariables.shared.weekArray.count + 1
            }
            
            // If height set to preset is too big
            if CGFloat(count) * presetCellHeight > (scheduleTable.bounds.height - headerHeight) {
                
                // Height calculated to fit screen unless it gets too small
                let height = (scheduleTable.bounds.height - headerHeight) / CGFloat(count)
                if height < 49 {
                    cellHeight = 49
                } else {
                    cellHeight = height
                }
                
            } else {
                cellHeight = presetCellHeight
            }
        } else {
            cellHeight = presetCellHeight
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        // Enure cell height is correct
        calculateCellHeight()
        
        switch tableView {
        case scheduleTable:
            
            if ScheduleVariables.shared.schedules.count > 0 {
                //
                cell.tag = indexPath.row
                
                // Extra Session Cell
                if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue && indexPath.row == ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![ScheduleVariables.shared.selectedDay].count || ScheduleVariables.shared.scheduleStyle == ScheduleStyle.week.rawValue && indexPath.row == ScheduleVariables.shared.weekArray.count {
                    
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
                    if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                        groupString = ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![ScheduleVariables.shared.selectedDay][indexPath.row]["group"] as! String
                    } else {
                        groupString = ScheduleVariables.shared.weekArray[indexPath.row]["group"] as! String
                    }
                    dayLabel.text = NSLocalizedString(groupString, comment: "")
                    dayLabel.numberOfLines = 2
                    dayLabel.frame = CGRect(x: tableSpacing + 8 + imageHeight, y: 0, width: view.bounds.width - 54, height: cellHeight)
                    cell.addSubview(dayLabel)
                    
                    
                    let groupImage = UIImageView()
                    groupImage.frame = CGRect(x: tableSpacing, y: gap, width: imageHeight, height: imageHeight)
                    groupImage.contentMode = .scaleAspectFill
                    groupImage.clipsToBounds = true
                    groupImage.image = ScheduleVariables.shared.groupImageThumbnails[groupString]
                    groupImage.layer.cornerRadius = 4
                    cell.addSubview(groupImage)
                    
                    
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
                    
                    // Checkmark if completed
                    let (day, indexInDay) = ScheduleVariables.shared.getIndexing(row: indexPath.row)
                    // If shouldReloadInitialChoice, then animate checkmark in so leave the row to be animated alone as animated handled in viewDidAppear
                    if ScheduleVariables.shared.shouldReloadInitialChoice && indexPath.row != ScheduleVariables.shared.selectedRows.initial {
                        if ScheduleVariables.shared.isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: false) {
                            checkButton(button: checkBox)
                        }
                    } else if ScheduleVariables.shared.isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: false) {
                        checkButton(button: checkBox)
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
            label.text = ScheduleVariables.shared.schedules[indexPath.row]["scheduleInformation"]![0][0]["title"] as? String
            label.textColor = Colors.light
            label.sizeToFit()
            // twice nomal padding
            let padding: CGFloat = 16 + 16
            // 1 for border
            label.center = CGPoint(x: 1 + padding + (label.bounds.width / 2), y: cell.bounds.height / 2)
            cell.addSubview(label)

            if indexPath.row == ScheduleVariables.shared.selectedScheduleIndex {
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
            
            // Extra Session
            // (day view last cell || week view last cell)
            if  (ScheduleVariables.shared.scheduleStyle == "day" && indexPath.row == ScheduleVariables.shared.currentDayCount() ||  ScheduleVariables.shared.scheduleStyle == "week" && indexPath.row == ScheduleVariables.shared.weekArray.count) {
                
                ScheduleVariables.shared.initializeChoice(extraSession: true, selectedRow: indexPath.row)
                performSegue(withIdentifier: "SessionChoiceSegue", sender: self)
                goingToSessionChoice = true
            } else {
                
                let (day, indexInDay) = ScheduleVariables.shared.getIndexing(row: indexPath.row)
                // If group is not completed, do something
                if !ScheduleVariables.shared.isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: false) {
                    ScheduleVariables.shared.initializeChoice(extraSession: false, selectedRow: indexPath.row)
                    performSegue(withIdentifier: "SessionChoiceSegue", sender: self)
                    goingToSessionChoice = true
                }
               
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
            
        // Select schedule
        case scheduleChoiceTable:
        
            ScheduleVariables.shared.selectedScheduleIndex = indexPath.row
            ScheduleVariables.shared.saveSelectedScheduleIndex()
            ScheduleVariables.shared.scheduleStyle = (ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int).scheduleStyleFromInt()
            
            // If week view, create temporary week array
            ScheduleVariables.shared.createTemporaryWeekViewArray()
            
            // Reload table
            layoutViews()
            // nina
            scheduleChoiceTable.reloadData()
            self.scheduleTable.reloadData()
            
            // Tracking
            Tracking.shared.updateWeekGoal()
            Tracking.shared.updateWeekProgress()
            Tracking.shared.updateTracking()
            
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
        //
        // Delete if not plus row
        if tableView == scheduleChoiceTable && editingStyle == UITableViewCellEditingStyle.delete {

            ScheduleVariables.shared.deleteSchedule(at: indexPath.row)
            
            // Reload table
            layoutViews()
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            scheduleTable.reloadData()
            scheduleChoiceTable.reloadData()
        }
    }
}
