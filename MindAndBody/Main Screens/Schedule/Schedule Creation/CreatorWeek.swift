//
//  ScheduleCreatorWeek.swift
//  MindAndBody
//
//  Created by Luke Smith on 09.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
// MARK: Schedule Creator Week Class
class ScheduleCreatorWeek: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //
    // MARK: Outlets --------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var weekTable: UITableView!
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    //
    var comingFromScheduleEditing = false

    @IBOutlet weak var createScheduleButton: UIButton!
    @IBOutlet weak var createScheduleButtonHeight: NSLayoutConstraint!
    
    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.light
        
        setupCreateScheduleButton()
        
        // Navigation Bar
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("week", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)


        // Table View
        weekTable.tableFooterView = UIView()
//        weekTable.separatorColor = Colors.dark.withAlphaComponent(0.25)
        weekTable.backgroundColor = .clear
        weekTable.isScrollEnabled = false
        weekTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Ensure temporary week array created
        ScheduleVariables.shared.createTemporaryWeekViewArray()
    }
    
    func setupCreateScheduleButton() {
        // Not from schedule editing => schedule creation
        if !comingFromScheduleEditing {
            createScheduleButton.backgroundColor = Colors.green
            createScheduleButton.setTitle(NSLocalizedString("create", comment: ""), for: .normal)
            createScheduleButton.setTitleColor(Colors.dark, for: .normal)
            createScheduleButton.titleLabel?.font = Fonts.bottomButton
            createScheduleButton.isEnabled = true
            createScheduleButton.alpha = 1
            createScheduleButtonHeight.constant = 49
            
            // Schedule editing, hide button
        } else {
            createScheduleButton.isEnabled = false
            createScheduleButton.alpha = 0
            createScheduleButtonHeight.constant = 0
        }
    }
    
    //
    // Table View --------------------------------------------------------------------------------------------------------
    //
    // Answers tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return weekTable.bounds.height / CGFloat(scheduleDataStructures.groupNames.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleDataStructures.groupNames.count
    }
    
    // ScheduleCreationHelpCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomScheduleWeekCell", for: indexPath) as! CustomScheduleWeekCell
        
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.row = indexPath.row
        cell.selectionStyle = .none
        if indexPath.row == scheduleDataStructures.groupNames.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        
        cell.groupLabel.font = Fonts.mediumElementRegular
        cell.groupLabel.textColor = Colors.dark
        
        cell.sessionsLabel.font = Fonts.veryLargeElementRegular
        cell.sessionsLabel.textColor = Colors.dark
        
        cell.plusButton.tintColor = Colors.dark
        cell.minusButton.tintColor = Colors.dark
        
        return cell
    }
    
    // Finished
    @IBAction func createScheduleButtonAction(_ sender: Any) {
        // Ensure notifications correct
        ReminderNotifications.shared.setNotifications()
        // Ensure temporary week array created
        ScheduleVariables.shared.createTemporaryWeekViewArray()
        
        self.dismiss(animated: true)
    }
}


//
class CustomScheduleWeekCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var sessionsLabel: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!

    // Passed data
        // Row = indexpath.row of cell = groupIndex
    var row = Int()
    
    //
    // Layout/data
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        groupLabel.text = NSLocalizedString(scheduleDataStructures.groupNames[row], comment: "")
        groupLabel.lineBreakMode = .byWordWrapping
        groupLabel.numberOfLines = 0
        //
        
        var groupArray = [0,0,0,0,0,0]
        // Create array of nsession of each group
        // Loop Week
        for i in 0...6 {
            // If day not empty
            if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count != 0 {
                // Loop day
                for j in 0..<ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count {
                    // Index of the group as int for group Array
                    let index = (ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i][j]["group"] as! String).groupFromString()
                    groupArray[index] += 1
                }
            }
        }
        
        sessionsLabel.text = String(groupArray[row])
        sessionsLabel.textColor = Colors.dark
    }
    
    //
    // Increment Buttons
    // MARK: Increase
    @IBAction func increaseButtonAction(_ sender: Any) {
        //
        // Set goal to week if space in goal section
        // Haptic feedback
        var generator: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .light)
        generator?.prepare()
        generator?.impactOccurred()
        generator = nil
        
        
      
        // Add to first available day in the week
        for i in 0...6 {
            // If week not full (max 5 things per day in week
            if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count < 5 {
                ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].append(scheduleDataStructures.scheduleGroups[row]!)
                break
            }
        }
        
        ScheduleVariables.shared.saveSchedules()
        
        // Update label
        sessionsLabel.text = String(Int(sessionsLabel.text!)! + 1)
    }
    
    
    // MARK: Decrease
    @IBAction func decreaseButtonAction(_ sender: Any) {
        //
        // Set goal to week if space in goal section
        // Haptic feedback
        var generator: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .light)
        generator?.prepare()
        generator?.impactOccurred()
        generator = nil
        
        // Update the array
        
        // Remove from schedules array and update userdefaults
        // Remove first instance from from Week
        var shouldBreak = false
        // Loop week
        for i in (0...6).reversed() {
            // If day isn't empty
            if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count != 0 {
                // Loop day
                for j in 0...ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count - 1 {
                    // If correct group
                    if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i][j]["group"] as! String == row.groupFromInt() {
                        // Remove
                        ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].remove(at: j)
                        shouldBreak = true
                        break
                    }
                }
            }
            // Break week loop
            if shouldBreak {
                break
            }
        }
        //
    
        ScheduleVariables.shared.saveSchedules()
        
        // Update label
        sessionsLabel.text = String(Int(sessionsLabel.text!)! - 1)
    }
}
