//
//  ScheduleView.swift
//  MindAndBody
//
//  Created by Luke Smith on 23.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

// A view for a quick question asking wether the user would like to see their schedule as 'day view' or as 'week view'

class ScheduleViewQuestion: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayViewButton: UIButton!
    @IBOutlet weak var dayViewImage: UIImageView!
    @IBOutlet weak var weekViewButton: UIButton!
    @IBOutlet weak var weekViewImage: UIImageView!
    
    @IBOutlet weak var topSeparator: UIView!
    @IBOutlet weak var middleSeparator: UIView!
    
    // 0 == day, 1 == week
    var selectedStyle = 0
    
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Title Label
        titleLabel.text = NSLocalizedString("scheduleView", comment: "")
        titleLabel.font = Fonts.mediumElementRegular
        titleLabel.textColor = Colors.dark
        
        topSeparator.backgroundColor = Colors.dark
        topSeparator.alpha = 0.5
        
        middleSeparator.backgroundColor = Colors.dark
        middleSeparator.alpha = 0.5

        // Buttons
        dayViewButton.titleLabel?.lineBreakMode = .byWordWrapping
        dayViewButton.setTitle(NSLocalizedString("scheduleView1", comment: ""), for: .normal)
        dayViewButton.titleLabel?.font = Fonts.mediumElementRegular
        dayViewButton.setTitleColor(Colors.dark, for: .normal)
        
        weekViewButton.titleLabel?.lineBreakMode = .byWordWrapping
        weekViewButton.setTitle(NSLocalizedString("scheduleView2", comment: ""), for: .normal)
        weekViewButton.titleLabel?.font = Fonts.mediumElementRegular
        weekViewButton.setTitleColor(Colors.dark, for: .normal)
    }
    
    // MARK: Button actions
    // Day
    @IBAction func dayButtonAction(_ sender: Any) {
        
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // Set user settings for schedule style to week
        schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] = 0
        UserDefaults.standard.set(schedules, forKey: "schedules")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
        
        selectedStyle = 0
        nextAndUpdate()
    }
    
    // Week
    @IBAction func weekButtonAction(_ sender: Any) {
        // If app schedule, go to week
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // Set user settings for schedule style to week
        schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] = 1
        UserDefaults.standard.set(schedules, forKey: "schedules")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
        //
        // App helps create schedule, fill suggested sessions into week creator
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
            
            // Ensure that the schedule is clean
            schedules[ScheduleVariables.shared.selectedSchedule]["schedule"] = scheduleDataStructures.emptyWeek["schedule"]
            // Loop sessions array - therefore loop groups
            for i in 0..<ScheduleVariables.shared.temporarySessionsArray.count {
                // If n session not 0 for a group
                if ScheduleVariables.shared.temporarySessionsArray[i] != 0 {
                    // Loop number of sessions, appending to week
                    for _ in 0..<ScheduleVariables.shared.temporarySessionsArray[i] {
                        // Add to first available day in the week
                        for j in 0...6 {
                            // If day not full (max 5 things per day in week)
                                // Note, i is the group
                            if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j].count < 5 {
                                schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j].append(scheduleDataStructures.scheduleGroups[i]!)
                                break
                            }
                        }
                    }
                }
            }
            //
            UserDefaults.standard.set(schedules, forKey: "schedules")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
            
            // Create temporary week view array, as week is viewed as full week
            TemporaryWeekArray.shared.createTemporaryWeekViewArray()

            // Then go to schedule editor to let them finalise the schedule
            
            
        // If custom schedule, go straight to schedule creator
        }
        
        selectedStyle = 1
        nextAndUpdate()
    }
    
    // Tells parent to update next screen based on choice, and tells to go to next screen
    func nextAndUpdate() {
        if let parentVC = self.parent as? ScheduleCreationPageController {
            parentVC.updateContentStyle(style: selectedStyle)
            parentVC.nextViewController()
        }
    }
    
}
