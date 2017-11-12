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
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    //
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    //
    var comingFromScheduleEditing = false

    
    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        UIApplication.shared.statusBarStyle = .lightContent
        //
        sectionLabel.text = NSLocalizedString("week", comment: "")
        //
        // Background Image/Colour
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            backgroundImageView.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = Colours.colour1
        }
        // Blur
        // BackgroundBlur/Vibrancy
        let backgroundBlur = UIVisualEffectView()
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        backgroundBlur.frame = backgroundImageView.bounds
        if backgroundIndex > BackgroundImages.backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImageView)
        }
        //
        // Table View
        weekTable.tableFooterView = UIView()
        weekTable.separatorColor = UIColor.white.withAlphaComponent(0.25)
        weekTable.backgroundColor = .clear
        weekTable.isScrollEnabled = false
        weekTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //
        // Done
        doneButton.backgroundColor = Colours.colour3.withAlphaComponent(0.25)
        doneButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
        
        //
        // Back
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
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
        //
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.row = indexPath.row
        cell.selectionStyle = .none
        //
        if indexPath.row == scheduleDataStructures.groupNames.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        //
        return cell
    }
    
    //
    // Done
    @IBAction func doneButonAction(_ sender: Any) {
        if comingFromScheduleEditing == true {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    //
    // Back
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
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "ScheduleHelpCreationSegue" {
            let destinationVC = segue.destination as! ScheduleCreator
            destinationVC.fromScheduleEditing = true
        }
    }
}


//
class CustomScheduleWeekCell: UITableViewCell {
    //
    // Outlets
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var sessionsLabel: UILabel!
    
    //
    // Passed data
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
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        var groupArray = [0,0,0,0,0,0]
        // Create array of nsession of groups from full week array in schedule ([0][7])
        if schedules[ScheduleVariables.shared.selectedSchedule][0][7].count != 0 {
            for i in 0...schedules[ScheduleVariables.shared.selectedSchedule][0][7].count - 1 {
                groupArray[schedules[ScheduleVariables.shared.selectedSchedule][0][7][i] as! Int] += 1
            }
        }
        sessionsLabel.text = String(groupArray[row])
        if groupArray[row] != 0 {
            sessionsLabel.textColor = Colours.colour3
        } else {
            sessionsLabel.textColor = Colours.colour1
        }
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
        
        // Update the array
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
        // update schedules
        schedules[ScheduleVariables.shared.selectedSchedule][0][7].append(row)
        schedules[ScheduleVariables.shared.selectedSchedule][0][7] = (schedules[ScheduleVariables.shared.selectedSchedule][0][7] as! [Int]).sorted()
        // Append to week tracking, start again as cannot sort
        scheduleTracking[ScheduleVariables.shared.selectedSchedule][7] = []
        if schedules[ScheduleVariables.shared.selectedSchedule][0][7].count != 0 {
            for i in 0...schedules[ScheduleVariables.shared.selectedSchedule][0][7].count - 1 {
                scheduleTracking[ScheduleVariables.shared.selectedSchedule][7].append(scheduleDataStructures.scheduleTrackingArrays[schedules[ScheduleVariables.shared.selectedSchedule][0][7][i] as! Int]!)
            }
        }
        // Add to first available day in the week
        for i in 0...6 {
            // If week not full (max 5 things per day in week
            if schedules[ScheduleVariables.shared.selectedSchedule][0][i].count < 5 {
                schedules[ScheduleVariables.shared.selectedSchedule][0][i].append(row)
                scheduleTracking[ScheduleVariables.shared.selectedSchedule][i].append(scheduleDataStructures.scheduleTrackingArrays[row]!)
                break
            }
        }
        
        //
        UserDefaults.standard.set(schedules, forKey: "schedules")
        UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
        
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
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
        // Remove from schedules array and update userdefaults
        // Remove first instance from from Week
        var shouldBreak = false
        // Loop week
        for i in 0...6 {
            // If day isn't empty
            if schedules[ScheduleVariables.shared.selectedSchedule][0][i].count != 0 {
                // Loop day
                for j in 0...schedules[ScheduleVariables.shared.selectedSchedule][0][i].count - 1 {
                    // If correct group
                    if schedules[ScheduleVariables.shared.selectedSchedule][0][i][j] as! Int == row {
                        // Remove
                        schedules[ScheduleVariables.shared.selectedSchedule][0][i].remove(at: j)
                        scheduleTracking[ScheduleVariables.shared.selectedSchedule][i].remove(at: j)
                        shouldBreak = true
                        break
                    }
                }
            }
            // Break week loop
            if shouldBreak == true {
                break
            }
        }
        //
        // Remove from full week array
        // If week not empty
        if schedules[ScheduleVariables.shared.selectedSchedule][0][7].count != 0 {
            for i in 0...schedules[ScheduleVariables.shared.selectedSchedule][0][7].count - 1 {
                if schedules[ScheduleVariables.shared.selectedSchedule][0][7][i] as! Int == row {
                    // Remove
                    schedules[ScheduleVariables.shared.selectedSchedule][0][7].remove(at: i)
                    scheduleTracking[ScheduleVariables.shared.selectedSchedule][7].remove(at: i)
                    break
                }
            }
        }
    
        UserDefaults.standard.set(schedules, forKey: "schedules")
        UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
        
        // Update label
        sessionsLabel.text = String(Int(sessionsLabel.text!)! - 1)
    }
}
