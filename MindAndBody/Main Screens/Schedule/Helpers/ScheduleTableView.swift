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
    
    // Section Titles
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        switch tableView {
        case scheduleTable:
            // day
            if scheduleStyle == 0 {
                return NSLocalizedString(dayArray[ScheduleVariables.shared.selectedDay], comment: "")
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
                return weekOfThe + firstMondayWithOrdinal!
            }
        case scheduleChoiceTable:
            return NSLocalizedString("chooseSchedule", comment: "")
        default:
            return ""
        }
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        switch tableView {
        case scheduleTable:
            // Header
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 30)!
            header.textLabel?.textAlignment = .center
            header.textLabel?.textColor = Colors.light
            //
            header.backgroundColor = .clear
            header.backgroundView = UIView()
            //
        case scheduleChoiceTable:
            // Header
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
            header.textLabel?.textAlignment = .center
            header.textLabel?.textColor = Colors.dark
            //
            let background = UIView()
            background.frame = header.bounds
            background.backgroundColor = Colors.light
            header.backgroundView = background
        default: break
        }
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //
        switch tableView {
        case scheduleTable:
            // day
            return (UIScreen.main.bounds.height - (TopBarHeights.statusBarHeight + CGFloat(TopBarHeights.navigationBarHeight)) - 24.5) / 4
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
                    if scheduleStyle == 0 {
                        return schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![ScheduleVariables.shared.selectedDay].count
                    } else {
                        return TemporaryWeekArray.shared.weekArray.count
                    }
                } else {
                    return 0
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
            if scheduleStyle == 1 && ScheduleVariables.shared.choiceProgress[0] == -1 {
                return 49
            } else {
                return 72
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
            //
            cell.tag = indexPath.row
            
            // First Screen, showing groups
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                // Groups
                let dayLabel = UILabel()
                dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
                dayLabel.textColor = Colors.light
                //
                var text = String()
                if scheduleStyle == 0 {
                    text = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![ScheduleVariables.shared.selectedDay][indexPath.row]["group"] as! String
                } else {
                    text = TemporaryWeekArray.shared.weekArray[indexPath.row]["group"] as! String
                }
                dayLabel.text = NSLocalizedString(text, comment: "")
                dayLabel.numberOfLines = 2
                dayLabel.sizeToFit()
                if scheduleStyle == 1 && ScheduleVariables.shared.choiceProgress[0] == -1 {
                    dayLabel.frame = CGRect(x: 27, y: 0, width: view.bounds.width - 54, height: 49)
                } else {
                    dayLabel.frame = CGRect(x: 27, y: 0, width: view.bounds.width - 54, height: 72)
                }
                cell.addSubview(dayLabel)
                //
                // CheckMark if completed
                if ScheduleVariables.shared.shouldReloadChoice {
                    if indexPath.row != ScheduleVariables.shared.selectedRows[0] {
                        if isCompleted(row: indexPath.row) {
                            dayLabel.textColor = Colors.green
                            cell.tintColor = Colors.green
                            cell.accessoryType = .checkmark
                        }
                    }
                } else if isCompleted(row: indexPath.row) {
                    dayLabel.textColor = Colors.green
                    cell.tintColor = Colors.green
                    cell.accessoryType = .checkmark
                }
                
            // Currently selecting a session, i.e not first screen
            } else {
                // If title
                if indexPath.row == 0 {
                    let title = sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]][0]
                    cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 24)!
                    cell.textLabel?.textColor = Colors.light
                    cell.textLabel?.text = NSLocalizedString(title, comment: "")
                    cell.textLabel?.textAlignment = .center
                    //                    cell.textLabel?.numberOfLines = 2
                    //                    cell.textLabel?.sizeToFit()
                    cell.textLabel?.frame = CGRect(x: view.bounds.width / 2, y: 0, width: view.bounds.width / 2, height: 72)
                    //
                    cell.selectionStyle = .none
                    //
                    // Title Underline
                    let separator = CALayer()
                    separator.frame = CGRect(x: view.bounds.width / 4, y: 72 - 1, width: view.bounds.width / 2, height: 1)
                    separator.backgroundColor = Colors.light.cgColor
                    separator.opacity = 0.25
                    cell.layer.addSublayer(separator)
                    //
                    // Color if last choice
                    if isLastChoice() {
                        cell.textLabel?.textColor = Colors.green
                        separator.backgroundColor = Colors.green.cgColor
                    }
                    // Else if selection
                } else {
                    //
                    let choiceLabel = UILabel()
                    choiceLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
                    choiceLabel.textColor = Colors.light
                    //
                    // Normal
                    //
                    let text = sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]][indexPath.row]
                    choiceLabel.text = NSLocalizedString(text, comment: "")
                    choiceLabel.numberOfLines = 2
                    choiceLabel.sizeToFit()
                    choiceLabel.frame = CGRect(x: 27, y: 0, width: view.bounds.width - 54, height: 72)
                    cell.addSubview(choiceLabel)
                    
                    //
                    if isLastChoice() {
                        //
                        // CheckMark if completed
                        // - 1 as title included, so rows offset by 1
                        if indexPath.row != 0 {
                            if isCompleted(row: indexPath.row) {
                                choiceLabel.textColor = Colors.green
                                cell.tintColor = Colors.green
                                cell.accessoryType = .checkmark
                            }
                        }
                    }
                }
            }
            
        //
        case scheduleChoiceTable:
            let selectedSchedule = UserDefaults.standard.integer(forKey: "selectedSchedule")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = Colors.light
            if indexPath.row == selectedSchedule {
                cell.accessoryType = .checkmark
                cell.tintColor = Colors.green
            }
            cell.textLabel?.text = NSLocalizedString(schedules[indexPath.row]["scheduleInformation"]![0][0]["title"] as! String, comment: "")
            
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
        
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        // Session choice
        switch tableView {
        case scheduleTable:
            //
            // If ScheduleVariables.shared.choiceProgress[0] = -1
            if ScheduleVariables.shared.choiceProgress[0] != -1 && indexPath.row == 0 {
                
            } else {
                //
                // If completed, do nothing
                if !isLastChoice() && !isCompleted(row: indexPath.row) {
                    didSelectRowHandler(row: indexPath.row)
                } else if isLastChoice() && !isCompleted(row: indexPath.row) {
                    didSelectRowHandler(row: indexPath.row)
                }
                //
                tableView.deselectRow(at: indexPath, animated: true)
            }
          
        // Select schedule
        case scheduleChoiceTable:
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
            // Select schedule
            // Select new schedule in user settings
            var selectedSchedule = UserDefaults.standard.integer(forKey: "selectedSchedule")
            selectedSchedule = indexPath.row
            ScheduleVariables.shared.selectedSchedule = selectedSchedule
            scheduleStyle = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int
            UserDefaults.standard.set(selectedSchedule, forKey: "selectedSchedule")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["selectedSchedule"])
            // Reload table
            layoutViews()
            scheduleChoiceTable.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
                self.scheduleTable.reloadData()
                // Dismiss action sheet
                ActionSheet.shared.animateActionSheetDown()
                //
            })
            // Tracking
            updateWeekGoal()
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
        if editingStyle == UITableViewCellEditingStyle.delete {
            //
            // Update arrays
            schedules.remove(at: indexPath.row)
            UserDefaults.standard.set(schedules, forKey: "schedules")
                
            // Select 1 schedule before last schedule
            var selectedSchedule = UserDefaults.standard.integer(forKey: "selectedSchedule")
            if schedules.count == 0 || selectedSchedule == 0 {
                selectedSchedule = 0
                scheduleStyle = 0
            } else {
                selectedSchedule -= 1
                scheduleStyle = schedules[selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int
            }
            ScheduleVariables.shared.selectedSchedule = selectedSchedule
            ScheduleVariables.shared.selectedDay = Date().weekDayFromMonday
            UserDefaults.standard.set(selectedSchedule, forKey: "selectedSchedule")
            // Reload table
            layoutViews()
            scheduleTable.reloadData()
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["schedules", "selectedSchedule"])
            // Tracking
            updateWeekGoal()
            // Set Notifications
            ReminderNotifications.shared.setNotifications()
            
            //
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            //
            // Change indicator
            if schedules.count != 0 {
                let indexToReload = IndexPath(row: ScheduleVariables.shared.selectedSchedule, section: 0)
                let cell = scheduleChoiceTable.cellForRow(at: indexToReload)
                cell?.accessoryType = .checkmark
                cell?.tintColor = Colors.green
            }
        }
    }
}
