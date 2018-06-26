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
// Schedule creator
// Used for custom session creation, and for app helps create schedule, after the user has been presented with a suggested number of groups, he/she must choose days in the week to perform them on
//
// 6 labels at the top of the screen correspond to the 6 groups of the app
// The user drags the group to the day they wish to perform the group
//

// NOTE: LABELS/GROUPS ARE STILL INDEXED WITH INTEGERS,


//
// MARK: Schedule Creator Class
class ScheduleCreator: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Passed data
    var fromScheduleEditing = false
    
    @IBOutlet weak var dayTable: UITableView!
    //
    let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
    
    // Create schedule button
    @IBOutlet weak var createScheduleButton: UIButton!
    @IBOutlet weak var createScheduleButtonHeight: NSLayoutConstraint!
    
    // Indication
    @IBOutlet weak var indicationLabel: UILabel!
    
    
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
    // If dragging label dragged over new row, this indicates the old row
    var previousIndexPath: IndexPath? = nil
    // So that the state of the tracking isn't changed
    var draggedTrackingArray: [[Bool]] = []
    
    
    // Array indicating the number of each group currently in the table
        // Updated in the beginning
        // When the number of sessions of a group in this array equals that in the profileQA[2][i + 1] array then the top label is to be darkened and made green
                            // [mind, flexibility, endurance, toning, muscle gain, strength]
    var dayTableGroupArray = [0,0,0,0,0,0]
        // Parrallel to profileQA[2][i + 1]
    
    //
    // Arrays
    // The number of different groups
    var nGroups = 0
    // Indicates which groups are relevant
        // GROUP INDEXES
            // contains the indexes of the groups of the sessions e.g [1,3,4] = [flexibility, toning, muscle gain]
    var groupIndexes = [Int]()
    
    let dayArray = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday",]
    let dayArrayShort = ["mondayChar", "tuesdayChar", "wednesdayChar", "thursdayChar", "fridayChar", "saturdayChar", "sundayChar",]

    //
    // View did load --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // SETUP
        setVariables()
        setGroupLabels()
        //
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: true)
        
        // Indication Label
        indicationLabel.font = UIFont(name: "SFUIDisplay-thin", size: 20)
        indicationLabel.textColor = Colors.light
        indicationLabel.text = NSLocalizedString("scheduleCreatorIndication", comment: "")

        //
        // Tables
        // Day Table
        dayTable.tableFooterView = UIView()
        dayTable.backgroundColor = .clear
        dayTable.isScrollEnabled = false
        
        //
        for i in 0...bigGroupLabelArray.count - 1 {
            longPressArray[i].minimumPressDuration = 0
            longPressArray[i].addTarget(self, action: #selector(beginDraggingFromTop(gestureRecognizer:)))
            bigGroupLabelArray[i].addGestureRecognizer(longPressArray[i])
        }
        
        // Iphone 5/SE layout, smaller text for endurance
        if IPhoneType.shared.iPhoneType() == 0 {
            bigGroupLabelArray[3].font = UIFont(name: "SFUIDisplay-thin", size: 21)
        }
        
        // Dragging
        draggingLabel.textColor = Colors.light
        draggingLabel.textAlignment = .center
        draggingLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        draggingLabel.lineBreakMode = .byWordWrapping
        draggingLabel.layer.borderColor = Colors.light.withAlphaComponent(0.5).cgColor
        draggingLabel.layer.borderWidth = 1
        draggingLabel.layer.cornerRadius = 15
        draggingLabel.clipsToBounds = true
        
        // Long press cell
        longPressCell.minimumPressDuration = 0
        longPressCell.addTarget(self, action: #selector(beginDraggingFromCell(gestureRecognizer:)))
        dayTable.addGestureRecognizer(longPressCell)
        
        // Back Swipe to previous screen
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
        
        //
        // Create schedule button
        createScheduleButton.backgroundColor = Colors.green.withAlphaComponent(0.25)
        createScheduleButton.tintColor = Colors.light
        createScheduleButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
        
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
        return 7
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 49
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! DayCell
        cell.selectionStyle = .none
        //
        // Iphone 5/SE layout
        if IPhoneType.shared.iPhoneType() == 0 {
            // Short names
            cell.dayLabel.text = NSLocalizedString(dayArrayShort[indexPath.row], comment: "")
        } else {
            cell.dayLabel.text = NSLocalizedString(dayArray[indexPath.row], comment: "")

        }
        cell.layoutSubviews()
        //
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        //
        // add relevant groups if they are there
        if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![indexPath.row].count != 0 {
            for i in 0...schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![indexPath.row].count - 1 {
                cell.groupLabelArray[i].tag = 1
                cell.groupLabelArray[i].alpha = 1
                cell.groupLabelArray[i].layer.borderWidth = 1
                cell.groupLabelArray[i].layer.borderColor = Colors.light.withAlphaComponent(0.75).cgColor
                cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                cell.groupLabelArray[i].clipsToBounds = true
                //
                // Get group as int
                let group = (schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![indexPath.row][i]["group"] as! String).groupFromString()
                cell.groupLabelArray[i].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[group], comment: "")
                cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            }
        }
        return cell
        //
    }

    
    //
    // MARK: - Helper functions
    // MARK: General Helpers
    func setVariables() {
        
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]

        // Show group
        for i in 0...5 {
            nGroups += 1
            // i - 1 as totalnsession included in array
            groupIndexes.append(i)
        }
        //
        bigGroupLabelArray = [bigGroupLabel0, bigGroupLabel1, bigGroupLabel2, bigGroupLabel3, bigGroupLabel4]
        //
        longPressArray = [longPress0, longPress1, longPress2, longPress3, longPress4]
        
        // Set dayTableGroupArray
            // indicates how many are of each group in the table
        //
        // week
        // If app schedule, find out
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
            for i in 0...6 {
                if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i].count != 0 {
                    for j in 0...schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i].count - 1 {
                        let indexOfGroupInLoop = (schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i][j]["group"] as! String).groupFromString()
                        dayTableGroupArray[indexOfGroupInLoop] += 1
                    }
                }
            }
        }
        
        UserDefaults.standard.set(schedules, forKey: "schedules")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
    }
    
    func setGroupLabels() {
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // Custom schedule
        // Present all groups
        // Set titles for all groups
        for i in 0..<bigGroupLabelArray.count {
            //
            let groupTitle = NSLocalizedString(scheduleDataStructures.groupNames[i], comment: "")
            // Not selected filled in
            let title = groupTitle
            bigGroupLabelArray[i].text = title
            bigGroupLabelArray[i].textColor = Colors.light
            bigGroupLabelArray[i].alpha = 1
            bigGroupLabelArray[i].layer.borderColor = Colors.light.withAlphaComponent(0.5).cgColor
            bigGroupLabelArray[i].layer.borderWidth = 1
            bigGroupLabelArray[i].isUserInteractionEnabled = true
            bigGroupLabelArray[i].layer.cornerRadius = 15
            bigGroupLabelArray[i].clipsToBounds = true

            //
            // app helps create schedule, change title
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
                // Indicate suggestion in group label
                    // If user selects more than selected, leave button green
                if groupIndexes.contains(i) && dayTableGroupArray[i] < ScheduleVariables.shared.temporarySessionsArray[i] {
                    // Group
                    var nGroupsString = String()
                    // None dragged
                    if dayTableGroupArray[i] == 0 {
                        nGroupsString = "\n" + String(ScheduleVariables.shared.temporarySessionsArray[i]) + "x"
                    // Some selected already
                    } else if dayTableGroupArray[i] != ScheduleVariables.shared.temporarySessionsArray[i] {
                        let number = ScheduleVariables.shared.temporarySessionsArray[i] - dayTableGroupArray[i]
                        nGroupsString = "\n" + String(number) + "x"
                    } else {
                        nGroupsString = ""
                    }
                    
                    // Set Title
                    let groupTitle = NSLocalizedString(i.groupFromInt(), comment: "")
                    let title = groupTitle + nGroupsString
                    bigGroupLabelArray[i].text = title
                    
                // Make label dark and green if all session of group have been chosen, or if not suggested
                } else {
//                        bigGroupLabelArray[i].alpha = 0.75
                        bigGroupLabelArray[i].layer.borderColor = Colors.green.withAlphaComponent(0.5).cgColor
                        bigGroupLabelArray[i].textColor = Colors.green
                }
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
    @objc func beginDraggingFromTop(gestureRecognizer: UIGestureRecognizer) {
        
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
                        
            // Begin drag
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
            
            previousIndexPath = nil
 
            
        // Dragging label being dragged
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
                        cell.groupLabelArray[i].backgroundColor = Colors.light
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 27)
                        break
                    }
                }
                previousIndexPath = indexPathForRow!
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
                //
                let cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].backgroundColor == Colors.light {
                        break
                    } else if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 2
                        cell.groupLabelArray[i].backgroundColor = Colors.light
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 27)
                        break
                    }
                }
                previousIndexPath = indexPathForRow!
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
            //
            // If Dragging label is over a day
                // Set goal to day
                // Remove 1 from the relevant label of the group at the top of the screen
                    // If no more sessions of group, darken top label and make it green
                // Haptic feedback
                var generator: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .light)
                generator?.prepare()
                generator?.impactOccurred()
                generator = nil
                
                let cell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                
                // if there are already 5 things in one day, do nothing
                var dayIsFull = false
                // Put the goal in the day
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 1
                        cell.groupLabelArray[i].alpha = 1
                        cell.groupLabelArray[i].layer.borderWidth = 1
                        cell.groupLabelArray[i].layer.borderColor = Colors.light.withAlphaComponent(0.75).cgColor
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
                    //
                    var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
                        // update dayTableGroupArray
                    dayTableGroupArray[indexOfDraggedGroup] += 1
                    // update schedules
                    schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![(previousIndexPath?.row)!].append(scheduleDataStructures.scheduleGroups[indexOfDraggedGroup]!)
                    UserDefaults.standard.set(schedules, forKey: "schedules")
                        // Sync
                    ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
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
        //
    }
    
    
    //
    // MARK: Begin Dragging from cell
    @objc func beginDraggingFromCell(gestureRecognizer: UIGestureRecognizer) {
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: self.dayTable)
        let locationInView2 = longPress.location(in: self.view)
        let indexPathForRow = self.dayTable.indexPathForRow(at: locationInView)
        
        //
        switch state {
        // Add dragging label
        case .began:
            //
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
                
            let cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
            let locationInCell = longPress.location(in: cell)

            
            // Get the index of the long press and perform the relevant actions, if the press is not in the view, cancel the press
            for i in 0...cell.groupLabelArray.count - 1 {
                if cell.groupLabelArray[i].tag == 1 && cell.groupLabelArray[i].frame.contains(locationInCell) {
                    
                    // Haptic feedback
                    var generator: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .medium)
                    generator?.prepare()
                    generator?.impactOccurred()
                    generator = nil
                    indexOfDrag = i
                    
                    //
                    // Get index of the group being dragged using the schedules array
                        // i.e find out which group being dragged
                    indexOfDraggedGroup = (schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![indexPathForRow!.row][indexOfDrag]["group"] as! String).groupFromString()
                    //
                    previousIndexPath = indexPathForRow
                    
                    // Remove from schedules array and update userdefaults
                    schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![(indexPathForRow?.row)!].remove(at: indexOfDrag)
                    //
                    UserDefaults.standard.set(schedules, forKey: "schedules")
                        // Sync
                    ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
                    // Remove the label being dragged
                    cell.groupLabelArray[indexOfDrag].tag = 0
                    cell.groupLabelArray[indexOfDrag].alpha = 0

                    //reload cell
                    if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![(indexPathForRow?.row)!].count != 0 {
                        cell.layoutSubviews()
                        // Remove all groups
                        for j in 0...cell.groupLabelArray.count - 1 {
                            cell.groupLabelArray[j].tag = 0
                            cell.groupLabelArray[j].alpha = 0
                        }
                        
                        // Add all relevant groups
                        for k in 0...schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![(indexPathForRow?.row)!].count - 1 {
                            cell.groupLabelArray[k].tag = 1
                            cell.groupLabelArray[k].alpha = 1
                            cell.groupLabelArray[k].layer.borderWidth = 1
                            cell.groupLabelArray[k].layer.borderColor = Colors.light.withAlphaComponent(0.75).cgColor
                            cell.groupLabelArray[k].layer.cornerRadius = 15 / 2
                            cell.groupLabelArray[k].clipsToBounds = true
                            //
                            let groupIndex =  (schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![(indexPathForRow?.row)!][k]["group"] as! String).groupFromString()
                            cell.groupLabelArray[k].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[groupIndex], comment: "")
                            cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                        }
                    }
                    
                    
                    
                    // Edit the draggingLabel
                    draggingLabel.text = NSLocalizedString(scheduleDataStructures.groupNames[indexOfDraggedGroup], comment: "")
                    draggingLabel.frame = bigGroupLabelArray[indexOfDrag].bounds
                    
                    // Add dragging label and mask stack views
                    draggingLabel.center = locationInView2
                    UIApplication.shared.keyWindow?.addSubview(draggingLabel)
                    maskStackViews()
                    
                    // Turn createschedulebutton into bin
                    createScheduleButton.backgroundColor = Colors.red.withAlphaComponent(0.25)
                    createScheduleButton.setImage(#imageLiteral(resourceName: "Bin"), for: .normal)
                    createScheduleButton.setTitle("", for: .normal)
                    
                    break
                // Press is not in a group label, indicate by setting previousindexpath = nil
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
            // If app helps create schedule, location in table
            
            draggingLabel.center = locationInView2
            
            // If over bin (createschedulebutton)
            if createScheduleButton.frame.contains(locationInView2) {
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
                createScheduleButton.setImage(#imageLiteral(resourceName: "BinOpen"), for: .normal)
            // If dragging label is over the dayTable, highlight the relevant label of the relevant day
            // Row being highlighted
            } else if indexPathForRow != nil && indexPathForRow == previousIndexPath {
                    //
                    let cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
                    // ADD INDICATOR
                    for i in 0...cell.groupLabelArray.count - 1 {
                        if cell.groupLabelArray[i].tag == 2 {
                            break
                        } else if cell.groupLabelArray[i].tag == 0 {
                            cell.groupLabelArray[i].tag = 2
                            cell.groupLabelArray[i].backgroundColor = Colors.light
                            cell.groupLabelArray[i].alpha = 0.5
                            cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                            cell.groupLabelArray[i].clipsToBounds = true
                            cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 27)
                            break
                        }
                    }
                    createScheduleButton.setImage(#imageLiteral(resourceName: "Bin"), for: .normal)
                    createScheduleButton.setTitle("", for: .normal)
                // Row is changing, changing highlight
            } else if indexPathForRow != nil && indexPathForRow != previousIndexPath {
                
                //
                let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
                if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![(indexPathForRow?.row)!].count != 5 {
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
                    if cell.groupLabelArray[i].backgroundColor == Colors.light {
                        break
                    } else if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 2
                        cell.groupLabelArray[i].backgroundColor = Colors.light
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 27)
                        break
                    }
                }
                
            }
                createScheduleButton.setImage(#imageLiteral(resourceName: "Bin"), for: .normal)
                createScheduleButton.setTitle("", for: .normal)
            // Dragging label is dragged off table, set to monday
            } else if indexPathForRow == nil {
                // Clear old cell
                // CLEAR INDICATOR
                //
                let cell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].backgroundColor == Colors.light {
                        break
                    } else if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 2
                        cell.groupLabelArray[i].backgroundColor = Colors.light
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 27)
                        break
                    }
                }
                createScheduleButton.setImage(#imageLiteral(resourceName: "Bin"), for: .normal)
                createScheduleButton.setTitle("", for: .normal)
            }
            
            
        // Dragging label let go
        default:
            var shouldRemoveBin = true
            // If over bin
            if createScheduleButton.frame.contains(locationInView2) {
                // Haptic feedback
                var generator: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .light)
                generator?.prepare()
                generator?.impactOccurred()
                generator = nil
                
                // Animate lable to bin
                shouldRemoveBin = false // Remove bin handled here, after animation
                UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                    self.draggingLabel.frame.size = CGSize(width: 0, height: 0)
                    self.draggingLabel.center = self.createScheduleButton.center
                }, completion: { finished in
                    self.createScheduleButton.setImage(nil, for: .normal)
                    self.createScheduleButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
                    self.createScheduleButton.backgroundColor = Colors.green.withAlphaComponent(0.25)
                    self.draggingLabel.removeFromSuperview()
                    self.deMaskStackViews()
                })
                // Note: no need to remove from any arrays as already been removed when the label was picked up
                
                // Update group labels for session suggestion if app helps create schedule
                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
                    dayTableGroupArray[indexOfDraggedGroup] -= 1
                    setGroupLabels()
                }
                
            // If it is equal to nil, then the long press is not in a label
            } else if previousIndexPath != nil {
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
                            cell.groupLabelArray[i].layer.borderColor = Colors.light.withAlphaComponent(0.75).cgColor
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
                        //
                        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
                                // update schedules
                            // Do a check, if the user is dragging off the top of the teable (indexpathforrow == nil, set to previous indexpath(always monday))
                        if indexPathForRow != nil {
                            schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![(indexPathForRow?.row)!].append(scheduleDataStructures.scheduleGroups[indexOfDraggedGroup]!)
                        } else {
                            schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![(previousIndexPath?.row)!].append(scheduleDataStructures.scheduleGroups[indexOfDraggedGroup]!)
                        }
                        UserDefaults.standard.set(schedules, forKey: "schedules")
                                // Sync
                        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
                    } else {
                        let cell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell

                        // Put the goal in the day
                        // ADD INDICATOR
                        for i in 0...cell.groupLabelArray.count - 1 {
                            if cell.groupLabelArray[i].tag == 0 {
                                cell.groupLabelArray[i].tag = 1
                                cell.groupLabelArray[i].alpha = 1
                                cell.groupLabelArray[i].layer.borderWidth = 1
                                cell.groupLabelArray[i].layer.borderColor = Colors.light.withAlphaComponent(0.75).cgColor
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
                        //
                        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
                                // update schedules
                        schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![(previousIndexPath?.row)!].append(scheduleDataStructures.scheduleGroups[indexOfDraggedGroup]!)
                        UserDefaults.standard.set(schedules, forKey: "schedules")
                                // Sync
                        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
                }
                
                    draggingLabel.removeFromSuperview()
                    deMaskStackViews()
                
                // Remove bin
                if shouldRemoveBin {
                    createScheduleButton.setImage(nil, for: .normal)
                    createScheduleButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
                    createScheduleButton.backgroundColor = Colors.green.withAlphaComponent(0.25)
                }
            }
        }
        
        
        
        
    //
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
    
    //
    // Finished
    @IBAction func createScheduleButtonAction(_ sender: Any) {
        // Ensure notifications correct
        ReminderNotifications.shared.setNotifications()
        //
        // Return to sc  hedule overview
        if fromScheduleEditing {
            self.navigationController?.popToRootViewController(animated: true)
        //
        // Schedule has just been created, go to schedule equiptment question
        } else {
            self.performSegue(withIdentifier: "ScheduleCreatorEquiptmentSegue1", sender: self)
        }
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "ScheduleCreatorEquiptmentSegue1" {
            let destinationVC = segue.destination as! ScheduleEquipment
            destinationVC.isScheduleCreation = true
        }
    }
}


//
// MARK: - Custom Cells
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