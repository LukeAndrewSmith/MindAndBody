//
//  SessionChoice.swift
//  MindAndBody
//
//  Created by Luke Smith on 25.09.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class SessionChoice: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var sessionChoiceTable: UITableView!
    
    var cellHeight: CGFloat = 72 // 110 // 88 // 72
    let tableSpacing: CGFloat = 27
    let foregroundColor = Colors.dark
    var scheduleStyle = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        let row = ScheduleVariables.shared.selectedRows[0]
        scheduleStyle = ScheduleVariables.shared.selectedSchedule["scheduleInformation"]![0][0]["scheduleStyle"] as! Int
        var groupString = String()
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            groupString = ScheduleVariables.shared.selectedSchedule["schedule"]![ScheduleVariables.shared.selectedDay][row]["group"] as! String
        } else {
            groupString = ScheduleVariables.shared.weekArray[row]["group"] as! String
        }
        // Image
        groupImage.image = groupString.groupImageFromString()
        groupImage.contentMode = .scaleAspectFill
        groupImage.clipsToBounds = true
        
    }
    
    
    //
    // Schedule TableView
    // Sections
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Rows
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress].count
    }
    
    // Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        calculateCellHeight()
        return cellHeight
    }
    
    func calculateCellHeight() {
        // If too many choices, reduce size of cell
        if CGFloat((sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress].count) * 72) > (sessionChoiceTable.bounds.height - groupImage.bounds.height) {
            let height = (sessionChoiceTable.bounds.height - groupImage.bounds.height) / CGFloat((sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress]).count)
            cellHeight = height
            
        // Height 72
        } else {
            cellHeight = 72
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Note: accessing title so cast as any
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        // Get cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        // Enure cell height is correct
        calculateCellHeight()
        
        //
        cell.tag = indexPath.row
        
        // Currently selecting a session, i.e not first screen
        // If title
        if indexPath.row == 0 {
            
            let title = sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress][0]
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
            let groupString = sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress][indexPath.row]
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
                if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.week.rawValue && ScheduleVariables.shared.selectedGroup == .none {
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

        cell.backgroundColor = .clear
        cell.backgroundView = UIView()

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
        let cell = tableView.cellForRow(at: indexPath)
        for view in (cell?.subviews)! {
            if view is UIButton {
                if let image = (view as! UIButton).imageView?.image, image == #imageLiteral(resourceName: "CheckMark") {
                    view.backgroundColor = Colors.green
                }
            }
        }
        
        //
        // Session choice
            let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
            
        // If title of choice table, do nothing, if not then do something
        if !(ScheduleVariables.shared.selectedGroup != .none && indexPath.row == 0) {
            
            // First choice
            if ScheduleVariables.shared.selectedGroup == .none {
                
                // New Test
                // Nina
                ScheduleVariables.shared.selectedRows[0] = indexPath.row
                performSegue(withIdentifier: "SessionChoiceSegue", sender: self)
                
                
                // Old
                if false {
                    // Extra session
                    // (day view last cell || week view last cell)
                    if  (ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue && indexPath.row == ScheduleVariables.shared.selectedSchedule["schedule"]![ScheduleVariables.shared.selectedDay].count || ScheduleVariables.shared.scheduleStyle == ScheduleStyle.week.rawValue && indexPath.row == ScheduleVariables.shared.weekArray.count) {
                        didSelectRowHandler(row: 723)
                        
                        // Normal session, if not completed, do something
                    } else if !isCompleted(row: indexPath.row) {
                        didSelectRowHandler(row: indexPath.row)
                    }
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
        if tableView == sessionChoiceTable {
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
                ScheduleVariables.shared.createTemporaryWeekViewArray()
            }
            
            // Reload table
            layoutViews()
            sessionChoiceTable.reloadData()
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
