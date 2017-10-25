//
//  ScheduleCreator.swift
//  MindAndBody
//
//  Created by Luke Smith on 11.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
// MARK: Custom Schedule Creator Day Cell
class DayCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    //
    @IBOutlet weak var groupLabel0: UILabel!
    @IBOutlet weak var groupLabel1: UILabel!
    @IBOutlet weak var groupLabel2: UILabel!
    @IBOutlet weak var groupLabel3: UILabel!
    @IBOutlet weak var groupLabel4: UILabel!
    
    var groupLabelArray: [UILabel] = []
    
    override func layoutSubviews() {
        groupLabelArray = [groupLabel0, groupLabel1, groupLabel2, groupLabel3, groupLabel4]
    }
}

//
// MARK: Schedule Creator Class
class ScheduleCreator: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var dayTable: UITableView!
    //
    let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
    var backgroundIndex = Int()
    let backgroundImageView = UIImageView()
    let backgroundBlur = UIVisualEffectView()
    
    //
    // Stack Views
    @IBOutlet weak var groupStack: UIStackView!
    @IBOutlet weak var groupStack1: UIStackView!
    @IBOutlet weak var groupStack2: UIStackView!
    
    // Stack View contents
        // 6 labels as 6 groups
            // Note labels default to alpha = 0
    @IBOutlet weak var bigGroupLabel0: UILabel!
    @IBOutlet weak var bigGroupLabel1: UILabel!
    @IBOutlet weak var bigGroupLabel2: UILabel!
    @IBOutlet weak var bigGroupLabel3: UILabel!
    @IBOutlet weak var bigGroupLabel4: UILabel!
    @IBOutlet weak var bigGroupLabel5: UILabel!
    
    var bigGroupLabelArray: [UILabel] = []
    
    // Dragging
    let longPress0 = UILongPressGestureRecognizer()
    let longPress1 = UILongPressGestureRecognizer()
    let longPress2 = UILongPressGestureRecognizer()
    let longPress3 = UILongPressGestureRecognizer()
    let longPress4 = UILongPressGestureRecognizer()
    let longPress5 = UILongPressGestureRecognizer()
    var longPressArray: [UILongPressGestureRecognizer] = []
    
    let longPressCell = UILongPressGestureRecognizer()
    
    // Dragging elements
    var draggingLabel = UILabel()
    var stackViewMask = UIView()
    // indicates the group that is being dragged
    var indexOfDraggedGroup = Int()
    // index of the biggrouplabel in the biggrouplabelarray
    var indexOfDrag = Int()
    // If dragging label dragged over new row, this indicates the old
    var previousIndexPath: IndexPath? = nil
    // Dragging label from dayTable, indicates where the group came from
    var initialIndexPath: IndexPath? = nil
    
    // Array indicating the number of each group currently in the table
        // Updated in the beginning
        // When the number of sessions of a group in this array equals that in the profileQA[2][i + 1] array then the top label is to be darkened and made green
                            // [mind, flexibility, endurance, toning, muscle gain, strength]
    var dayTableGroupArray = [0,0,0,0,0,0]
    
    //
    // Arrays
    // The number of groups
    var nGroups = 0
    // Indicates which groups are relevant
        // GROUP INDEXES
            // contains the indexes of the groups of the sessions e.g [1,3,4] = [flexibility, toning, muscle gain]
    var groupIndexes = [Int]()
    // Both used to determin when the user has chosen a time for all sessions
    var sessionProgress = 0
    
    let dayArray = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday",]
    
    //
    // View did load --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setVariables()
        setGroupLabels()
        
        backgroundIndex = settings[0][0]
        //
        // Background Image
        backgroundImageView.frame = UIScreen.main.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        //
        if backgroundIndex < backgroundImageArray.count {
            backgroundImageView.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = colour1
        }
        //
        self.view.addSubview(backgroundImageView)
        self.view.sendSubview(toBack: backgroundImageView)
        //
        // BackgroundBlur/Vibrancy
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        //
        backgroundBlur.frame = backgroundImageView.bounds
        //
        view.insertSubview(backgroundBlur, aboveSubview: backgroundImageView)
        
        //
        // Tables
        // Day Table
        dayTable.tableFooterView = UIView()
        dayTable.separatorStyle = .singleLine
        dayTable.separatorColor = colour1.withAlphaComponent(0.15)
        dayTable.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        dayTable.backgroundColor = .clear
        dayTable.isScrollEnabled = false
        
        //
        // Test tap, just there to dismiss view when testing
        for i in 0...bigGroupLabelArray.count - 1 {
            longPressArray[i].minimumPressDuration = 0
            longPressArray[i].addTarget(self, action: #selector(beginDraggingFromTop(gestureRecognizer:)))
            bigGroupLabelArray[i].addGestureRecognizer(longPressArray[i])
        }
        
        // Dragging
        draggingLabel.textColor = colour1
        draggingLabel.textAlignment = .center
        draggingLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        draggingLabel.lineBreakMode = .byWordWrapping
        draggingLabel.layer.borderColor = colour1.withAlphaComponent(0.5).cgColor
        draggingLabel.layer.borderWidth = 1
        draggingLabel.layer.cornerRadius = 15
        draggingLabel.clipsToBounds = true
        
        // Long press cell
        longPressCell.minimumPressDuration = 0
        longPressCell.addTarget(self, action: #selector(beginDraggingFromCell(gestureRecognizer:)))
        dayTable.addGestureRecognizer(longPressCell)
        
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
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Days
        return 7
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! DayCell
        //
        cell.dayLabel.text = NSLocalizedString(dayArray[indexPath.row], comment: "")
        //
        // If friday, hide separayor
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        if indexPath.row == 6 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        
        // add relevant groups if they are there
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Int]]]
        if schedules[0][indexPath.row].count != 0 {
            cell.layoutSubviews()
            for i in 0...schedules[0][indexPath.row].count - 1 {
                cell.groupLabelArray[i].tag = 1
                cell.groupLabelArray[i].alpha = 1
                cell.groupLabelArray[i].layer.borderWidth = 1
                cell.groupLabelArray[i].layer.borderColor = colour1.withAlphaComponent(0.75).cgColor
                cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                cell.groupLabelArray[i].clipsToBounds = true
                //
                cell.groupLabelArray[i].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[schedules[0][indexPath.row][i]], comment: "")
                cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            }
        }
        
        //
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //
        // Selected goal
        // Schedules
            // Note: app schedule = schedulesArray[0]
//        let schedulesArray = UserDefaults.standard.object(forKey: "schedules") as! [[[Int]]]
//        schedulesArray[0][selectedRow]
        
        // TODO: didSelectRow, set session to day
//        difficulties:
//        if i just put in ints indicating the groups into the schedules array, it might be difficult to loop through when wanting to remove a group from a day
        
    }
    
    
    //
    // MARK: - Helper functions
    // MARK: General Helpers
    func setVariables() {
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        // nGroups, groupsIndexes, nSessions
        for i in 1...profileAnswers[2].count - 1 {
            if profileAnswers[2][i] != 0 {
                nGroups += 1
                // i - 1 as totalnsession included in array
                groupIndexes.append(i - 1)
            }
        }
        //
        bigGroupLabelArray = [bigGroupLabel0, bigGroupLabel1, bigGroupLabel2, bigGroupLabel3, bigGroupLabel4, bigGroupLabel5]
        //
        longPressArray = [longPress0, longPress1, longPress2, longPress3, longPress4, longPress5]
        
        // Set dayTableGroupArray
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Int]]]
        for i in 0...schedules[0].count - 1 {
            if schedules[0][i].count != 0 {
                for j in 0...schedules[0][i].count - 1 {
                    let indexOfGroupInLoop = schedules[0][i][j]
                    dayTableGroupArray[indexOfGroupInLoop] += 1
                }
            }
        }
        
        // Update dayTableGroupArray and Schedule array
            // This is for if the user has edited their profile and been taken to this screen, it is possible they will now have less of something, if so then remove the relevant number of sessions starting from monday down
        // Loop the groups
        // GROUP LOOP
        for i in 0...dayTableGroupArray.count - 1 {
            // If the group in dayTableGroupArray has more sessions than in the profileAnswers[2][i + 1], remove the relevant amount
            if dayTableGroupArray[i] > profileAnswers[2][i + 1] {
                // Find the relevant amount to remove
                let difference = dayTableGroupArray[i] - profileAnswers[2][i + 1]
                // Loop the difference, removing one each time
                // DIFFERENCE LOOP
                for _ in 1...difference {
                    // Loop the schedule, finding non empty days
                    // SCHEDULE LOOP
                    for j in 0...schedules[0].count - 1 {
                        // variable to break the schedule loop if the day is removed (the difference loop will then be continued)
                        var breakScheduleLoop = false
                        // Non empty day
                        if schedules[0][j].count != 0 {
                            // Loop the day, removing the first instance of the group to remove if there is one, then stopping
                            // DAY LOOP
                            for k in 0...schedules[0][j].count - 1 {
                                // if the group in th eday is equal to the desired group
                                if schedules[0][j][k] == i {
                                    // Remove 1 from the dayTableGroupArray
                                    dayTableGroupArray[i] -= 1
                                    // Remove the group from the schedule
                                    schedules[0][j].remove(at: k)
                                    // Break the day Loop and the schedule loop
                                    breakScheduleLoop = true
                                    break
                                }
                            // DAY LOOP
                            }
                        }
                        // Break the schedule loop
                        if breakScheduleLoop == true {
                            break
                        }
                    // SCHEDULE LOOP
                    }
                // DIFFERENCE LOOP
                }
            }
        // GROUP LOOP
        }
        UserDefaults.standard.set(schedules, forKey: "schedules")
    }
    
    func setGroupLabels() {
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        // Set titles
        for i in 0...nGroups - 1 {
            //
            let indexOfGroup = groupIndexes[i]
            let groupTitle = NSLocalizedString(scheduleDataStructures.groupNames[indexOfGroup], comment: "")
            // Not selected filled in
            var nGroupsString = String()
            if dayTableGroupArray[indexOfGroup] == 0 {
                nGroupsString = "\n" + String(profileAnswers[2][indexOfGroup + 1]) + "x"
            // Some selected already
            } else if dayTableGroupArray[indexOfGroup] != profileAnswers[2][indexOfGroup + 1] {
                let number = profileAnswers[2][indexOfGroup + 1] - dayTableGroupArray[indexOfGroup]
                nGroupsString = "\n" + String(number) + "x"
            } else {
                nGroupsString = ""
            }
            let title = groupTitle + nGroupsString
            bigGroupLabelArray[i].text = title
            bigGroupLabelArray[i].textColor = colour1
            bigGroupLabelArray[i].alpha = 1
            bigGroupLabelArray[i].layer.borderColor = colour1.withAlphaComponent(0.5).cgColor
            bigGroupLabelArray[i].layer.borderWidth = 1
            bigGroupLabelArray[i].isUserInteractionEnabled = true
            bigGroupLabelArray[i].layer.cornerRadius = 15
            bigGroupLabelArray[i].clipsToBounds = true

            
            // Make label dark and green if all session of group have been chosen
            if dayTableGroupArray[indexOfGroup] == profileAnswers[2][indexOfGroup + 1] {
                bigGroupLabelArray[i].alpha = 0.75
                bigGroupLabelArray[i].layer.borderColor = colour3.withAlphaComponent(0.5).cgColor
                bigGroupLabelArray[i].textColor = colour3
            }
        }
    }
    
    //
    // MARK: Table Helpers
        // When a group is selected, screenshot and put in key window, mask stack views so that the week table is highlighted
        // The screenshot animates from big (size of original label) to small (size of group label in custom day cell (49 - 16)^2)
        // User drags screenshot to desired day, the day label on the cell highlights to indecate where it would be dropped
            // User lets go and the group label now indicates
        // -1 from the stack view label (i.e Mind x2 -> Mind x1) or decrease alpha to indicate all have been selected)
    
        // User can drag from cell to
    
    // MARK: Begin Dragging
    func beginDraggingFromTop(gestureRecognizer: UIGestureRecognizer) {
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]

        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: self.view)
        let locationInView2 = longPress.location(in: self.dayTable)
        let indexPathForRow = self.dayTable.indexPathForRow(at: locationInView2)
        
        //
        switch state {
        // Add dragging label
        case .began:
            
            // Get the index of the long press
            indexOfDrag = longPressArray.index(of: longPress)!
            indexOfDraggedGroup = groupIndexes[indexOfDrag]
            
            // If there are some session left to drag from group
            if dayTableGroupArray[indexOfDraggedGroup] != profileAnswers[2][indexOfDraggedGroup + 1] {
                // Haptic feedback
                var generator: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .medium)
                generator?.prepare()
                generator?.impactOccurred()
                generator = nil
                
                // Edit the draggingLabel
                draggingLabel.text = NSLocalizedString(scheduleDataStructures.groupNames[indexOfDraggedGroup], comment: "")
                draggingLabel.frame = bigGroupLabelArray[indexOfDrag].bounds
                draggingLabel.center = locationInView
                
                // Add dragging label and mask stack views
                UIApplication.shared.keyWindow?.addSubview(draggingLabel)
                maskStackViews()
                
            } else {
                longPress.isEnabled = false
                longPress.isEnabled = true
            }
 
            
        // Dragging lable being dragged
        case .changed:
            // Keep the draggingLabel under the finger
            draggingLabel.center = locationInView
            
            // If dragging label is over the dayTable, highlight the relevant label of the relevant day
            // Row being highlighted
            if indexPathForRow != nil && indexPathForRow == previousIndexPath {
                //
                let cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].tag == 2 {
                        break
                    } else if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 2
                        cell.groupLabelArray[i].backgroundColor = colour1
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 27)
                        break
                    }
                }
            // Row is changing, changing highlight
            } else if indexPathForRow != nil && indexPathForRow != previousIndexPath {
                // Clear old cell
                // CLEAR INDICATOR
                if previousIndexPath != nil {
                    let previousCell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                    for i in 0...previousCell.groupLabelArray.count - 1 {
                        if previousCell.groupLabelArray[i].tag == 2 {
                            previousCell.groupLabelArray[i].tag = 0
                            previousCell.groupLabelArray[i].backgroundColor = .clear
                            previousCell.groupLabelArray[i].alpha = 0
                            previousCell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                            break
                        }
                    }
                }
                previousIndexPath = indexPathForRow!
                
                //
                let cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].backgroundColor == colour1 {
                        break
                    } else if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 2
                        cell.groupLabelArray[i].backgroundColor = colour1
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 27)
                        break
                    }
                }
            // Dragging label is dragged off table
            } else if indexPathForRow == nil {
                // Clear old cell
                // CLEAR INDICATOR
                if previousIndexPath != nil {
                    let previousCell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                    for i in 0...previousCell.groupLabelArray.count - 1 {
                        if previousCell.groupLabelArray[i].tag == 2 {
                            previousCell.groupLabelArray[i].tag = 0
                            previousCell.groupLabelArray[i].backgroundColor = .clear
                            previousCell.groupLabelArray[i].alpha = 0
                            previousCell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                            break
                        }
                    }
                }
            }
            
            
        // Dragging label let go
        default:
            // Clear old cell
            // CLEAR INDICATOR
            if previousIndexPath != nil {
                let previousCell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                for i in 0...previousCell.groupLabelArray.count - 1 {
                    if previousCell.groupLabelArray[i].tag == 2 {
                        previousCell.groupLabelArray[i].tag = 0
                        previousCell.groupLabelArray[i].backgroundColor = .clear
                        previousCell.groupLabelArray[i].alpha = 0
                        previousCell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                        break
                    }
                }
            }
            
            //
            // If Dragging label is over a day
                // Set goal to day
                // Remove 1 from the relevant label of the group at the top of the screen
                    // If no more sessions of group, darken top label and make it green
            if indexPathForRow != nil {
                // Haptic feedback
                var generator: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .light)
                generator?.prepare()
                generator?.impactOccurred()
                generator = nil
                
                let cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
                
                // if there are already 5 things in one day, do nothing
                var dayIsFull = false
                // Put the goal in the day
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 1
                        cell.groupLabelArray[i].alpha = 1
                        cell.groupLabelArray[i].layer.borderWidth = 1
                        cell.groupLabelArray[i].layer.borderColor = colour1.withAlphaComponent(0.75).cgColor
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        //
                        cell.groupLabelArray[i].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[indexOfDraggedGroup], comment: "")
                        cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                        break
                    } else if i == cell.groupLabelArray.count - 1 {
                        // Too much in one day, cant add any more
                        dayIsFull = true
                    }
                }
                
                if dayIsFull == false {
                    // Update the array
                    var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Int]]]
                    // update dayTableGroupArray
                    dayTableGroupArray[indexOfDraggedGroup] += 1
                    // update schedules
                    schedules[0][(indexPathForRow?.row)!].append(indexOfDraggedGroup)
                    UserDefaults.standard.set(schedules, forKey: "schedules")
                    // update label
                    setGroupLabels()
                }
                
                draggingLabel.removeFromSuperview()
                deMaskStackViews()
                
            // Dragging label is not over a day
            } else {
                draggingLabel.removeFromSuperview()
                deMaskStackViews()
            }
        }
    }
    
    
    //
    // MARK: Begin Dragging from cell
    func beginDraggingFromCell(gestureRecognizer: UIGestureRecognizer) {
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: self.dayTable)
        let indexPathForRow = self.dayTable.indexPathForRow(at: locationInView)
        
        //
        switch state {
        // Add dragging label
        case .began:
            var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Int]]]
            
            let cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
            let locationInView2 = longPress.location(in: cell)

            
            // Get the index of the long press and perform the relevant actions, if the press is not in the view, cancel the press
            for i in 0...cell.groupLabelArray.count - 1 {
                if cell.groupLabelArray[i].tag == 1 && cell.groupLabelArray[i].frame.contains(locationInView2) {
                    
                    // Haptic feedback
                    var generator: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .medium)
                    generator?.prepare()
                    generator?.impactOccurred()
                    generator = nil
                    indexOfDrag = i
                    
                    // Get index of the group being dragged using the schedules array
                    indexOfDraggedGroup = schedules[0][indexPathForRow!.row][indexOfDrag]
                    // Set the initial index path
                    initialIndexPath = indexPathForRow
                    previousIndexPath = indexPathForRow
                    
                    // Remove from schedules array
                    schedules[0][(indexPathForRow?.row)!].remove(at: indexOfDrag)
                    UserDefaults.standard.set(schedules, forKey: "schedules")
                    // Remove the label being dragged
                    cell.groupLabelArray[indexOfDrag].tag = 0
                    cell.groupLabelArray[indexOfDrag].alpha = 0

                    //reload cell
                    if schedules[0][(indexPathForRow?.row)!].count != 0 {
                        cell.layoutSubviews()
                        // Remove all groups
                        for i in 0...schedules[0][(indexPathForRow?.row)!].count {
                            cell.groupLabelArray[i].tag = 0
                            cell.groupLabelArray[i].alpha = 0
                        }
                        
                        // Add all relevant groups
                        for i in 0...schedules[0][(indexPathForRow?.row)!].count - 1 {
                            cell.groupLabelArray[i].tag = 1
                            cell.groupLabelArray[i].alpha = 1
                            cell.groupLabelArray[i].layer.borderWidth = 1
                            cell.groupLabelArray[i].layer.borderColor = colour1.withAlphaComponent(0.75).cgColor
                            cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                            cell.groupLabelArray[i].clipsToBounds = true
                            //
                            cell.groupLabelArray[i].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[schedules[0][(indexPathForRow?.row)!][i]], comment: "")
                            cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                        }
                    }
                    
                    
                    
                    // Edit the draggingLabel
                    draggingLabel.text = NSLocalizedString(scheduleDataStructures.groupNames[indexOfDraggedGroup], comment: "")
                    draggingLabel.frame = bigGroupLabelArray[indexOfDrag].bounds
                    draggingLabel.center = locationInView
                    
                    // Add dragging label and mask stack views
                    dayTable.addSubview(draggingLabel)
                    maskStackViews()
                    break
                } else {
                    previousIndexPath = nil
                }
            }
            
            if previousIndexPath == nil {
                longPress.isEnabled = false
                longPress.isEnabled = true
            }
            
            
            //
            
//            }
        // Dragging lable being dragged
        case .changed:
            // Keep the draggingLabel under the finger
            if locationInView.y > 0 {
                draggingLabel.center = locationInView
            }
            // If dragging label is over the dayTable, highlight the relevant label of the relevant day
            // Row being highlighted
            if indexPathForRow != nil && indexPathForRow == previousIndexPath {
                    //
                    let cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
                    // ADD INDICATOR
                    for i in 0...cell.groupLabelArray.count - 1 {
                        if cell.groupLabelArray[i].tag == 2 {
                            break
                        } else if cell.groupLabelArray[i].tag == 0 {
                            cell.groupLabelArray[i].tag = 2
                            cell.groupLabelArray[i].backgroundColor = colour1
                            cell.groupLabelArray[i].alpha = 0.5
                            cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                            cell.groupLabelArray[i].clipsToBounds = true
                            cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 27)
                            break
                        }
                    }
                    // Row is changing, changing highlight
                } else if indexPathForRow != nil && indexPathForRow != previousIndexPath {
                
                let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Int]]]
                if schedules[0][(indexPathForRow?.row)!].count != 5 {
                    // Clear old cell
                    // CLEAR INDICATOR
                    if previousIndexPath != nil {
                        let previousCell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                        for i in 0...previousCell.groupLabelArray.count - 1 {
                            if previousCell.groupLabelArray[i].tag == 2 {
                                previousCell.groupLabelArray[i].tag = 0
                                previousCell.groupLabelArray[i].backgroundColor = .clear
                                previousCell.groupLabelArray[i].alpha = 0
                                previousCell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                                break
                            }
                        }
                    }
                    
                    previousIndexPath = indexPathForRow!
                
                //
                let cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].backgroundColor == colour1 {
                        break
                    } else if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 2
                        cell.groupLabelArray[i].backgroundColor = colour1
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 27)
                        break
                    }
                }
                
            }
                
            // Dragging label is dragged off table, set to monday
            } else if indexPathForRow == nil {
                // Clear old cell
                // CLEAR INDICATOR
                //
                let cell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].backgroundColor == colour1 {
                        break
                    } else if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 2
                        cell.groupLabelArray[i].backgroundColor = colour1
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 27)
                        break
                    }
                }
            }
            
            
        // Dragging label let go
        default:
            // If it is equal to nil, then the long press is not in a label
            if previousIndexPath != nil {
                // Haptic feedback
                var generator: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .light)
                generator?.prepare()
                generator?.impactOccurred()
                generator = nil
            
            
                // Clear old cell
                // CLEAR INDICATOR
                if previousIndexPath != nil {
                    let previousCell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                    for i in 0...previousCell.groupLabelArray.count - 1 {
                        if previousCell.groupLabelArray[i].tag == 2 {
                            previousCell.groupLabelArray[i].tag = 0
                            previousCell.groupLabelArray[i].backgroundColor = .clear
                            previousCell.groupLabelArray[i].alpha = 0
                            previousCell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                            break
                        }
                    }
                }
            
                //
                // If Dragging label is over a day (if it isn't then above table, set to previousindexpath (monday))
                // Set goal to day
                // Remove 1 from the relevant label of the group at the top of the screen
                // If no more sessions of group, darken top label and make it green
                var cell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                if indexPathForRow != nil {
                    cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
                }
            
                    // if there are already 5 things in one day, do nothing
                    var dayIsFull = false
                    // Put the goal in the day
                    // ADD INDICATOR
                    for i in 0...cell.groupLabelArray.count - 1 {
                        if cell.groupLabelArray[i].tag == 0 {
                            cell.groupLabelArray[i].tag = 1
                            cell.groupLabelArray[i].alpha = 1
                            cell.groupLabelArray[i].layer.borderWidth = 1
                            cell.groupLabelArray[i].layer.borderColor = colour1.withAlphaComponent(0.75).cgColor
                            cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                            cell.groupLabelArray[i].clipsToBounds = true
                            //
                            cell.groupLabelArray[i].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[indexOfDraggedGroup], comment: "")
                            cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                            break
                        } else if i == cell.groupLabelArray.count - 1 {
                            // Too much in one day, cant add any more
                            dayIsFull = true
                        }
                    }
            
                    if dayIsFull == false {
                        // Update the array
                        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Int]]]
                        // update schedules
                            // Do a check, if the user is dragging off the top of the teable (indexpathforrow == nil, set to previous indexpath(always monday))
                        if indexPathForRow != nil {
                            schedules[0][(indexPathForRow?.row)!].append(indexOfDraggedGroup)
                        } else {
                            schedules[0][(previousIndexPath?.row)!].append(indexOfDraggedGroup)
                        }
                        UserDefaults.standard.set(schedules, forKey: "schedules")
                    } else {
                        let cell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell

                        // Put the goal in the day
                        // ADD INDICATOR
                        for i in 0...cell.groupLabelArray.count - 1 {
                            if cell.groupLabelArray[i].tag == 0 {
                                cell.groupLabelArray[i].tag = 1
                                cell.groupLabelArray[i].alpha = 1
                                cell.groupLabelArray[i].layer.borderWidth = 1
                                cell.groupLabelArray[i].layer.borderColor = colour1.withAlphaComponent(0.75).cgColor
                                cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                                cell.groupLabelArray[i].clipsToBounds = true
                                //
                                cell.groupLabelArray[i].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[indexOfDraggedGroup], comment: "")
                                cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                                break
                            } else if i == cell.groupLabelArray.count - 1 {
                                // Too much in one day, cant add any more
                                dayIsFull = true
                            }
                        }
                        
                        
                        // Update the array
                        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Int]]]
                        // update schedules
                        schedules[0][(previousIndexPath?.row)!].append(indexOfDraggedGroup)
                        UserDefaults.standard.set(schedules, forKey: "schedules")
                }
            
                    draggingLabel.removeFromSuperview()
                    deMaskStackViews()
            }
        }
    }
    
    
    
    // Mask stacks
    func maskStackViews() {
        stackViewMask.backgroundColor  = .black
        stackViewMask.alpha = 0
        stackViewMask.frame = CGRect(x: 0, y: UIScreen.main.bounds.minY, width: view.bounds.width, height: groupStack.bounds.height + 8 + TopBarHeights.statusBarHeight)
        view.addSubview(stackViewMask)
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            self.stackViewMask.alpha = 0.5
        })
    }
    func deMaskStackViews() {
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            self.stackViewMask.alpha = 0
        }, completion: { finished in
            self.stackViewMask.removeFromSuperview()
        })
    }
    
    // Drag Stack
    
    
    
    
    
    
    
    
    //
    // MARK: Back Swipe
    @IBAction func edgeGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
