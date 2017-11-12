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
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayViewButton: UIButton!
    @IBOutlet weak var weekViewButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var comingFromSchedule = false
    
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // Background Image/Colour
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            backgroundImage.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
            //
            backgroundImage.image = nil
            backgroundImage.backgroundColor = Colours.colour1
        }
        // Blur
        // BackgroundBlur/Vibrancy
        let backgroundBlur = UIVisualEffectView()
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        backgroundBlur.frame = backgroundImage.bounds
        if backgroundIndex > BackgroundImages.backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
        }
        
        //
        // Title Label
        titleLabel.text = NSLocalizedString("scheduleView", comment: "")
        titleLabel.textColor = Colours.colour1
        //
        // Buttons
        dayViewButton.titleLabel?.lineBreakMode = .byWordWrapping
        dayViewButton.setTitle(NSLocalizedString("scheduleView1", comment: ""), for: .normal)
        dayViewButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        dayViewButton.setTitleColor(Colours.colour1, for: .normal)
        //
        weekViewButton.titleLabel?.lineBreakMode = .byWordWrapping
        weekViewButton.setTitle(NSLocalizedString("scheduleView2", comment: ""), for: .normal)
        weekViewButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        weekViewButton.setTitleColor(Colours.colour1, for: .normal)
        
        //
        // Back
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
        
        if comingFromSchedule == true {
            backButton.alpha = 0
            backButton.isEnabled = false
        }
    }
    
    //
    // MARK: Button actions
    // Day
    @IBAction func dayButtonAction(_ sender: Any) {
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        // Set user settings for schedule style to week
        schedules[ScheduleVariables.shared.selectedSchedule][1][1][0] = 0
        UserDefaults.standard.set(schedules, forKey: "schedules")
        // Sync
        ICloudFunctions.shared.sync(toSync: ["schedules"])
        self.performSegue(withIdentifier: "ScheduleCreatorSegue", sender: self)
    }
    
    // Week
    @IBAction func weekButtonAction(_ sender: Any) {
        // If app schedule, go to week
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        // Set user settings for schedule style to week
        schedules[ScheduleVariables.shared.selectedSchedule][1][1][0] = 1
        UserDefaults.standard.set(schedules, forKey: "schedules")
        // Sync
        ICloudFunctions.shared.sync(toSync: ["schedules"])
        //
        // App helps create schedule, dismiss to schedule
        if schedules[ScheduleVariables.shared.selectedSchedule][1][3][0] as! Int == 0 {
            // Fill up days in week array with sessions
            var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
            var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
            // Loop sessions array from 1 (0 is total n sessions, rest are number of session of each group)
            for i in 1...schedules[ScheduleVariables.shared.selectedSchedule][2][2].count - 1 {
                // If n session not 0
                if schedules[ScheduleVariables.shared.selectedSchedule][2][2][i] as! Int != 0 {
                    // Loop number of sessions
                    for _ in 1...(schedules[ScheduleVariables.shared.selectedSchedule][2][2][i] as! Int) {
                        // Note: group is i - 1 as array includes total n session at 0
                        let group = i - 1
                        // Add to first available day in the week
                        for j in 0...6 {
                            // If week not full (max 5 things per day in week
                            if schedules[ScheduleVariables.shared.selectedSchedule][0][j].count < 5 {
                                schedules[ScheduleVariables.shared.selectedSchedule][0][j].append(group)
                                scheduleTracking[ScheduleVariables.shared.selectedSchedule][j].append(scheduleDataStructures.scheduleTrackingArrays[group]!)
                                break
                            }
                        }
                       // Not already added to full week array [7] in scheduleCreationHelp
                    }
                }
            }
            //
            UserDefaults.standard.set(schedules, forKey: "schedules")
            UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
            // Sync
            ICloudFunctions.shared.sync(toSync: ["schedules", "scheduleTracking"])
            //
            self.dismiss(animated: true)
        //
        // If custom schedule, go to schedule creator
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
