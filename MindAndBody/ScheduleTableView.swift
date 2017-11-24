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
            return NSLocalizedString("chooseCreateSchedule", comment: "")
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
            header.textLabel?.textColor = Colours.colour1
            
            //
            header.backgroundColor = .clear
            header.backgroundView = UIView()
            
            //
            // Seperator
            seperator.frame = CGRect(x: 27, y: header.bounds.height - 1, width: view.bounds.width - 54, height: 1)
            seperator.backgroundColor = Colours.colour1.cgColor
            seperator.opacity = 0.5
            header.layer.addSublayer(seperator)
        case scheduleChoiceTable:
            // Header
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
            header.textLabel?.textAlignment = .center
            header.textLabel?.textColor = Colours.colour2
            //
            let background = UIView()
            background.frame = header.bounds
            background.backgroundColor = Colours.colour1
            header.backgroundView = background
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        seperator.removeFromSuperlayer()
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
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[[[Any]]]]
        //
        switch tableView {
        case scheduleTable:
            // First Screen, showing groups
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                if schedules.count != 0 {
                    return schedules[ScheduleVariables.shared.selectedSchedule][0][ScheduleVariables.shared.selectedDay].count
                } else {
                    return 0
                }
            // Selecting a session
            } else {
                return sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]].count
            }
        case scheduleChoiceTable:
            return schedules.count + 1
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
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[[[Any]]]]
        
        // Get cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //
        switch tableView {
        case scheduleTable:
            // Long tap; ability to mark session as complete
            let markAsCompletedGesture = UILongPressGestureRecognizer()
            cell.tag = indexPath.row
            markAsCompletedGesture.addTarget(self, action: #selector(markAsCompleted))
            cell.addGestureRecognizer(markAsCompletedGesture)
            
            // First Screen, showing groups
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                // Groups
                let dayLabel = UILabel()
                dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
                dayLabel.textColor = Colours.colour1
                //
                let text = sessionData.sortedGroups[schedules[ScheduleVariables.shared.selectedSchedule][0][ScheduleVariables.shared.selectedDay][indexPath.row] as! Int]![0][0]
                
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
                if ScheduleVariables.shared.shouldReloadChoice == true {
                    if indexPath.row != ScheduleVariables.shared.selectedRows[0] {
                        if isCompleted(row: indexPath.row) == true {
                            dayLabel.textColor = Colours.colour3
                            cell.tintColor = Colours.colour3
                            cell.accessoryType = .checkmark
                        }
                    }
                } else if isCompleted(row: indexPath.row) == true {
                    dayLabel.textColor = Colours.colour3
                    cell.tintColor = Colours.colour3
                    cell.accessoryType = .checkmark
                }
                
                // Currently selecting a session, i.e not first screen
            } else {
                // If title
                if indexPath.row == 0 {
                    let title = sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]][0]
                    cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 24)!
                    cell.textLabel?.textColor = Colours.colour1
                    cell.textLabel?.text = NSLocalizedString(title, comment: "")
                    cell.textLabel?.textAlignment = .center
                    //                    cell.textLabel?.numberOfLines = 2
                    //                    cell.textLabel?.sizeToFit()
                    cell.textLabel?.frame = CGRect(x: view.bounds.width / 2, y: 0, width: view.bounds.width / 2, height: 72)
                    //
                    cell.selectionStyle = .none
                    //
                    // Title Underline
                    let seperator = CALayer()
                    seperator.frame = CGRect(x: view.bounds.width / 4, y: 72 - 1, width: view.bounds.width / 2, height: 1)
                    seperator.backgroundColor = Colours.colour1.cgColor
                    seperator.opacity = 0.25
                    cell.layer.addSublayer(seperator)
                    //
                    // Color if last choice
                    if isLastChoice() == true {
                        cell.textLabel?.textColor = Colours.colour3
                        seperator.backgroundColor = Colours.colour3.cgColor
                    }
                    // Else if selection
                } else {
                    //
                    let choiceLabel = UILabel()
                    choiceLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
                    choiceLabel.textColor = Colours.colour1
                    //
                    // Normal
                    //
                    // BORDER TEST
                    //                    if isLastChoice() == false {
                    let text = sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]][indexPath.row]
                    choiceLabel.text = NSLocalizedString(text, comment: "")
                    // Last Choice, indicator by color border round the outside, red when incomplete, green when complete
                    //                    } else {
                    // insert border
                    // PROBABLY SHOULDN'T BE DONE HERE, BUT IN NEXT CHOICE FUNCTION
                    //                    }
                    //
                    choiceLabel.numberOfLines = 2
                    choiceLabel.sizeToFit()
                    choiceLabel.frame = CGRect(x: 27, y: 0, width: view.bounds.width - 54, height: 72)
                    cell.addSubview(choiceLabel)
                    
                    //
                    if isLastChoice() == true {
                        //
                        // CheckMark if completed
                        // - 1 as title included, so rows offset by 1
                        if indexPath.row != 0 {
                            if isCompleted(row: indexPath.row - 1) == true {
                                choiceLabel.textColor = Colours.colour3
                                cell.tintColor = Colours.colour3
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
            switch indexPath.row {
            case schedules.count:
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                cell.tintColor = Colours.colour1
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1)
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1)
            default:
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
                cell.textLabel?.textAlignment = .left
                cell.textLabel?.textColor = Colours.colour1
                if indexPath.row == selectedSchedule {
                    cell.accessoryType = .checkmark
                    cell.tintColor = Colours.colour3
                }
                cell.textLabel?.text = NSLocalizedString(schedules[indexPath.row][1][0][0] as! String, comment: "")
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
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch tableView {
        case scheduleTable:
            //
            // If ScheduleVariables.shared.choiceProgress[0] = -1
            if ScheduleVariables.shared.choiceProgress[0] != -1 && indexPath.row == 0 {
                
            } else {
                //
                // If completed, do nothing
                if isLastChoice() == false && isCompleted(row: indexPath.row) == false {
                    didSelectRowHandler(row: indexPath.row)
                } else if isLastChoice() == true && isCompleted(row: indexPath.row - 1) == false {
                    didSelectRowHandler(row: indexPath.row)
                }
                //
                tableView.deselectRow(at: indexPath, animated: true)
            }
            
        case scheduleChoiceTable:
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[[[Any]]]]
            // Creat new schedule
            if indexPath.row == schedules.count {
                // Dismiss action sheet
                ActionSheet.shared.animateActionSheetDown()
                //
                self.performSegue(withIdentifier: "ScheduleCreationSegue", sender: self)
                //
                // Select schedule
            } else {
                // Select new schedule in user settings
                var scheduleTracking = UserDefaults.standard.object(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
                var selectedSchedule = UserDefaults.standard.integer(forKey: "selectedSchedule")
                selectedSchedule = indexPath.row
                ScheduleVariables.shared.selectedSchedule = selectedSchedule
                scheduleStyle = schedules[ScheduleVariables.shared.selectedSchedule][1][1][0] as! Int
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
                //
                updateWeekGoal()
            }
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
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[[[Any]]]]
        if tableView == scheduleTable {
            return false
        } else if tableView == scheduleChoiceTable {
            if indexPath.row != schedules.count {
                return true
            }
        }
        return false
    }
    
    // Commit editing style
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[[[Any]]]]
        var scheduleTracking = UserDefaults.standard.object(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
        //
        // Delete if not plus row
        if editingStyle == UITableViewCellEditingStyle.delete {
            //
            updateWeekGoal()
            // Update arrays
            schedules.remove(at: indexPath.row)
            scheduleTracking.remove(at: indexPath.row)
            UserDefaults.standard.set(schedules, forKey: "schedules")
            UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
            
            // Select 1 schedule before last schedule
            var selectedSchedule = UserDefaults.standard.integer(forKey: "selectedSchedule")
            if schedules.count == 0 || selectedSchedule == 0 {
                selectedSchedule = 0
            } else {
                selectedSchedule -= 1
            }
            ScheduleVariables.shared.selectedSchedule = selectedSchedule
            scheduleStyle = schedules[ScheduleVariables.shared.selectedSchedule][1][1][0] as! Int
            ScheduleVariables.shared.selectedDay = Date().currentWeekDayFromMonday - 1
            UserDefaults.standard.set(selectedSchedule, forKey: "selectedSchedule")
            // Reload table
            layoutViews()
            scheduleTable.reloadData()
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["schedules", "scheduleTracking", "selectedSchedule"])
            
            //
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            //
            // Change indicator
            if schedules.count != 0 {
                let indexToReload = IndexPath(row: ScheduleVariables.shared.selectedSchedule, section: 0)
                let cell = scheduleChoiceTable.cellForRow(at: indexToReload)
                cell?.accessoryType = .checkmark
                cell?.tintColor = Colours.colour3
            }
        }
    }
}
