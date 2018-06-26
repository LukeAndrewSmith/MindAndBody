//
//  ScheduleView.swift
//  MindAndBody
//
//  Created by Luke Smith on 23.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

// A view for a quick question asking wether the user would like to see their

// I would like to:
    // Create a weekly schedule, and each day of the week see the current day and what I have planned to do on that day
    // See the whole week as a list of my planned weekly sessions

class ScheduleViewQuestion: UIViewController {
    
    //
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayViewButton: UIButton!
    @IBOutlet weak var dayViewImage: UIImageView!
    @IBOutlet weak var weekViewButton: UIButton!
    @IBOutlet weak var weekViewImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    var comingFromSchedule = false
    
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: true)
        
        //
        // Title Label
        titleLabel.text = NSLocalizedString("scheduleView", comment: "")
        titleLabel.textColor = Colors.light
        //
        // Buttons
        dayViewButton.titleLabel?.lineBreakMode = .byWordWrapping
        dayViewButton.setTitle(NSLocalizedString("scheduleView1", comment: ""), for: .normal)
        dayViewButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        dayViewButton.setTitleColor(Colors.light, for: .normal)
        dayViewImage.layer.borderWidth = 1
        dayViewImage.layer.borderColor = Colors.light.withAlphaComponent(0.5).cgColor
        //
        weekViewButton.titleLabel?.lineBreakMode = .byWordWrapping
        weekViewButton.setTitle(NSLocalizedString("scheduleView2", comment: ""), for: .normal)
        weekViewButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        weekViewButton.setTitleColor(Colors.light, for: .normal)
        weekViewImage.layer.borderWidth = 1
        weekViewImage.layer.borderColor = Colors.light.withAlphaComponent(0.5).cgColor
        
        //
        // Back
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
        
        if comingFromSchedule {
            backButton.alpha = 0
            backButton.isEnabled = false
        }
    }
    
    //
    // MARK: Button actions
    // Day
    @IBAction func dayButtonAction(_ sender: Any) {
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // Set user settings for schedule style to week
        schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] = 0
        UserDefaults.standard.set(schedules, forKey: "schedules")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
        self.performSegue(withIdentifier: "ScheduleCreatorSegue", sender: self)
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
        // App helps create schedule, first create preliminary number of groups
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
            // Fill up days in week array with sessions
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
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
            //
            // Create temporary week view array, as week is viewed as full week
            TemporaryWeekArray.shared.createTemporaryWeekViewArray()
            //
            // Then go to schedule editor to let them finalise the schedule
            self.performSegue(withIdentifier: "ScheduleWeekCreatorSegue", sender: self)
        //
        // If custom schedule, go straight to schedule creator
        } else {
            self.performSegue(withIdentifier: "ScheduleWeekCreatorSegue", sender: self)
        }
    }
    
    //
    // Back Button
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "ScheduleCreatorSegue" {
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
    
}