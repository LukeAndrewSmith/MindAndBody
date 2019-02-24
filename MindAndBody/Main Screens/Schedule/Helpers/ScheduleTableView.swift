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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        switch tableView {
        case scheduleTable:

            var title = String()
            if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                title = NSLocalizedString(dayArray[ScheduleManager.shared.selectedDay], comment: "")
            } else {
                let weekOfThe = NSLocalizedString("weekOfThe", comment: "")
                let df = DateFormatter()
                df.dateFormat = "dd"
                let firstMonday = df.string(from: Date().firstMondayInCurrentWeek)
                let firstMondayInt = Int(firstMonday)

                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .ordinal
                let firstMondayWithOrdinal = numberFormatter.string(from: firstMondayInt! as NSNumber)

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
            
        default: break
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView {
        case scheduleTable:
            return headerHeight + headerSpacing
        case scheduleChoiceTable:
            return 47
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case scheduleTable:
            if ScheduleManager.shared.schedules.count > 0 {
                /// +1 for extra sessions cell
                if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                    return (ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["schedule"]?[ScheduleManager.shared.selectedDay].count)! + 1
                } else {
                    return ScheduleManager.shared.weekArray.count + 1
                }
            } else {
                return 1
            }
            
        case scheduleChoiceTable:
            return ScheduleManager.shared.schedules.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case scheduleTable:
            calculateCellHeight() // Depends on number of sessions set
            return cellHeight
        case scheduleChoiceTable:
            return 47
        default:
            return 0
        }
    }
    
    func calculateCellHeight() {
        if ScheduleManager.shared.schedules.count > 0 {
            /// Get number of rows
            var count: Int {
                if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                    return ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["schedule"]![ScheduleManager.shared.selectedDay].count + 1
                } else {
                    return ScheduleManager.shared.weekArray.count + 1
                }
            }
            
            /// If preset height is too big (i.e the rows exceed the allocated space in the table)
            if CGFloat(count) * presetCellHeight > (scheduleTable.bounds.height - headerHeight) {
                /// Height calculated to fit screen (unless it gets too smaller than 49)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        
        /// Ensure the calculated cell height is correct
        calculateCellHeight()
        
        switch tableView {
        ///---------------------------------------------------------------------------------
        case scheduleTable:
            if ScheduleManager.shared.schedules.count > 0 {
                cell.tag = indexPath.row
                
                /// Extra Session Cell (last row)
                if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue && indexPath.row == ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["schedule"]![ScheduleManager.shared.selectedDay].count || ScheduleManager.shared.scheduleStyle == ScheduleStyle.week.rawValue && indexPath.row == ScheduleManager.shared.weekArray.count {
                    
                    let extraLabel = UILabel()
                    extraLabel.font = Fonts.scheduleCell
                    extraLabel.textColor = foregroundColor
                    extraLabel.text = NSLocalizedString("extra", comment: "")
                    extraLabel.sizeToFit()
                    extraLabel.frame = CGRect(x: tableSpacing, y: 0, width: view.bounds.width - 54, height: cellHeight)
                    cell.addSubview(extraLabel)
                    
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
                    
                /// Session Cells
                } else {
                    let gap: CGFloat = 8
                    let imageHeight = cellHeight - (2*gap)
                    
                    var groupString: String {
                        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                            return ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["schedule"]![ScheduleManager.shared.selectedDay][indexPath.row]["group"] as! String
                        } else {
                            return ScheduleManager.shared.weekArray[indexPath.row]["group"] as! String
                        }
                    }
                    let dayLabel = UILabel()
                    dayLabel.font = Fonts.scheduleCell
                    dayLabel.textColor = foregroundColor
                    dayLabel.text = NSLocalizedString(groupString, comment: "")
                    dayLabel.numberOfLines = 2
                    dayLabel.frame = CGRect(x: tableSpacing + 8 + imageHeight, y: 0, width: view.bounds.width - 54, height: cellHeight)
                    cell.addSubview(dayLabel)
                    
                    let groupImage = UIImageView()
                    groupImage.frame = CGRect(x: tableSpacing, y: gap, width: imageHeight, height: imageHeight)
                    groupImage.contentMode = .scaleAspectFill
                    groupImage.clipsToBounds = true
                    groupImage.image = ScheduleManager.shared.groupImageThumbnails[groupString]
                    groupImage.layer.cornerRadius = 4
                    cell.addSubview(groupImage)
                    
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
                    
                    /// Make sure its easy to press the button by adding bigger button behind
                    let checkBoxExtraButton = UIButton()
                    checkBoxExtraButton.tag = indexPath.row
                    checkBoxExtraButton.frame = CGRect(x: 0, y: 0, width: cellHeight, height: cellHeight)
                    checkBoxExtraButton.center.x = checkBox.center.x
                    checkBoxExtraButton.addTarget(self, action: #selector(markAsCompleted(_:)), for: .touchUpInside)
                    cell.addSubview(checkBoxExtraButton)
                    
                    /// Checkmark if completed
                    let (day, indexInDay) = ScheduleManager.shared.getIndexing(row: indexPath.row)
                    /// If shouldReloadInitialChoice, checking handled animated in viewDidAppear so don't check the row (however can check all other rows that are completed, hence indexPath.row != selectedRows.initial)
                        /// If someone completes a session (selectedRows.initial), then animated back to schedule screen and the checking of the session in animated when the view appears
                    if ScheduleManager.shared.shouldReloadInitialChoice && indexPath.row != ScheduleManager.shared.selectedRows.initial {
                        if ScheduleManager.shared.isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: false) {
                            checkButton(button: checkBox)
                        }
                    } else if ScheduleManager.shared.isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: false) {
                        checkButton(button: checkBox)
                    }
                }
                
            /// No schedules -> note saying create one by pressing top right button
            } else {
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
            
        ///---------------------------------------------------------------------------------
        case scheduleChoiceTable:
            let label = UILabel()
            label.font = Fonts.smallElementRegular
            label.text = ScheduleManager.shared.schedules[indexPath.row]["scheduleInformation"]![0][0]["title"] as? String
            label.textColor = Colors.light
            label.sizeToFit()
            /// Twice nomal padding
            let padding: CGFloat = 16 + 16
            /// 1 for border
            label.center = CGPoint(x: 1 + padding + (label.bounds.width / 2), y: cell.bounds.height / 2)
            cell.addSubview(label)

            /// Indicate selection and edit possibility
            if indexPath.row == ScheduleManager.shared.selectedScheduleIndex {
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
            
        default:
            break
        }
        
        return cell
    }
    
    func checkButton(button: UIButton) {
        button.setImage(#imageLiteral(resourceName: "CheckMark"), for: .normal)
        button.imageView?.tintColor = foregroundColor
        button.layer.backgroundColor = Colors.green.cgColor
        button.backgroundColor = Colors.green
        button.layer.borderColor = Colors.green.cgColor
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if ScheduleManager.shared.schedules.count > 0 {
            
            ///---------------------------------------------------------------------------------
            /// Silly highlighting issue
                /// Cell selection removes the checkBox background colors, therefore reset to green upon selection
                /// find the button (identified through image), and set the background color to green if the border is green as a green border implies that it is selected
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
            
            switch tableView {
            ///---------------------------------------------------------------------------------
            /// Session choice
            case scheduleTable:
                /// Extra Session
                    /// (day view last cell || week view last cell)
                if  (ScheduleManager.shared.scheduleStyle == "day" && indexPath.row == ScheduleManager.shared.currentDayCount() ||  ScheduleManager.shared.scheduleStyle == "week" && indexPath.row == ScheduleManager.shared.weekArray.count) {
                    /// Reset extra session choice array / completion array
                    ScheduleManager.shared.initializeChoice(extraSession: true, selectedRow: indexPath.row)
                    goingToSessionChoice = true
                    performSegue(withIdentifier: "SessionChoiceSegue", sender: self)
                    
                /// Normal Session
                } else {
                    let (day, indexInDay) = ScheduleManager.shared.getIndexing(row: indexPath.row)
                    /// If group is not completed, do something
                    if !ScheduleManager.shared.isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: false) {
                        ScheduleManager.shared.initializeChoice(extraSession: false, selectedRow: indexPath.row)
                        goingToSessionChoice = true
                        performSegue(withIdentifier: "SessionChoiceSegue", sender: self)
                    }
                   
                }
               
            ///---------------------------------------------------------------------------------
            /// Schedule Choice
            case scheduleChoiceTable:
                
                /// Select schedule
                ScheduleManager.shared.selectedScheduleIndex = indexPath.row
                ScheduleManager.shared.saveSelectedScheduleIndex()
                ScheduleManager.shared.scheduleStyle = (ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int).scheduleStyleFromInt()
                
                /// If week view, create temporary week array
                ScheduleManager.shared.createTemporaryWeekViewArray()
                
                /// Ensure view layout correct
                layoutViews()
                
                /// Reload table content
                scheduleChoiceTable.reloadData()
                self.scheduleTable.reloadData()
                
                /// Tracking
                Tracking.shared.updateWeekGoal()
                Tracking.shared.updateWeekProgress()
                Tracking.shared.updateTracking()
                
                /// Notifications
                ReminderNotifications.shared.setNotifications()
                
            default: break
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
            
        /// No schedules
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        /// Can delete schedules
        if tableView == scheduleChoiceTable {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        /// Delete
        if tableView == scheduleChoiceTable && editingStyle == UITableViewCell.EditingStyle.delete {
            ScheduleManager.shared.deleteSchedule(at: indexPath.row)
            
            /// Reload table
            layoutViews()
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            scheduleTable.reloadData()
            scheduleChoiceTable.reloadData()
        }
    }
}
