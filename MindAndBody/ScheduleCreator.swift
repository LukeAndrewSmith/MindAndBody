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
        indicationLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
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
        //
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // nGroups, groupsIndexes, nSessions
        // If app helps create schedule, find which groups shown
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
            // Loop sessions array to find out what is presented
            for i in 1..<schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0].count {
                //
                // schedules[schedulesCreationHelp] indexed with strings, therefore retreive relevant string index from scheduleCreationHelp question array
                let stringIndex = scheduleDataStructures.scheduleCreationHelpSorted[0][i][0]
                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][stringIndex] as! Int != 0 {
                    nGroups += 1
                    // i - 1 as totalnsession included in array
                    groupIndexes.append(i - 1)
                }
            }
        // If custom schedule, all groups shown
        } else {
            for i in 0...5 {
                nGroups += 1
                // i - 1 as totalnsession included in array
                groupIndexes.append(i)
            }
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
        
        // TODO: SHOULD I REMOVE THIS
            // I beleive i now handle removal of groups in relevant places, so don't need to do here
            // Perhaps this is necessary in the schedule creation help screen, incase the number of groups changes and it's necessary to remove sessions
        
        
//        // Update dayTableGroupArray and Schedule array
//            // This is for if the user has edited their profile and been taken to this screen, it is possible they will now have less of something, if so then remove the relevant number of sessions starting from monday down
//        // Loop the groups
//        // GROUP LOOP
//            // Day
//        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
//            for i in 0...dayTableGroupArray.count - 1 {
//                // If the group in dayTableGroupArray has more sessions than in the schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![2][i + 1], remove the relevant amount
//                if dayTableGroupArray[i] > schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![2][i + 1] as! Int {
//                    // Find the relevant amount to remove
//                    let difference = dayTableGroupArray[i] - (schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![2][i + 1] as! Int)
//                    // Loop the difference, removing one each time
//                    // DIFFERENCE LOOP
//                    for _ in 1...difference {
//                        // Loop the week (schedule), finding non empty days
//                        // SCHEDULE LOOP
//                        for j in 0...6 - 1 {
//                            // variable to break the schedule loop if the day is removed (the difference loop will then be continued)
//                            var breakScheduleLoop = false
//                            // Non empty day
//                            if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j].count != 0 {
//                                // Loop the day, removing the first instance of the group to remove if there is one, then stopping
//                                // DAY LOOP
//                                for k in 0...schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j].count - 1 {
//                                    // if the group in th eday is equal to the desired group
//                                    if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j][k] as! Int == i {
//                                        // Remove 1 from the dayTableGroupArray
//                                        dayTableGroupArray[i] -= 1
//                                        // Remove the group from the schedule
//                                        schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j].remove(at: k)
//                                        scheduleTracking[ScheduleVariables.shared.selectedSchedule][j].remove(at: k)
//                                        // Break the day Loop and the schedule loop
//                                        breakScheduleLoop = true
//                                        break
//                                    }
//                                // DAY LOOP
//                                }
//                            }
//                            // Break the schedule loop
//                            if breakScheduleLoop {
//                                break
//                            }
//                        // SCHEDULE LOOP
//                        }
//                    // DIFFERENCE LOOP
//                    }
//                }
//            // GROUP LOOP
//            }
//        }
        UserDefaults.standard.set(schedules, forKey: "schedules")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
    }
    
    func setGroupLabels() {
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // app helps create schedule
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
            // Set titles
            if nGroups != 0 {
                for i in 0...nGroups - 1 {
                    //
                    let indexOfGroup = groupIndexes[i]
                    // schedule creation help indexed through names of groups etc, so get the string index from the originial question array, scheduleCreationHelp
                    let stringIndex = scheduleDataStructures.scheduleCreationHelpSorted[0][indexOfGroup][0]
                    //
                    let groupTitle = NSLocalizedString(scheduleDataStructures.groupNames[indexOfGroup], comment: "")
                    // Not selected filled in
                    var nGroupsString = String()
                    if dayTableGroupArray[indexOfGroup] == 0 {
                        nGroupsString = "\n" + String(schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][stringIndex] as! Int) + "x"
                    // Some selected already
                    } else if dayTableGroupArray[indexOfGroup] != schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][stringIndex] as! Int {
                        let number = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][stringIndex] as! Int - dayTableGroupArray[indexOfGroup]
                        nGroupsString = "\n" + String(number) + "x"
                    } else {
                        nGroupsString = ""
                    }
                    let title = groupTitle + nGroupsString
                    bigGroupLabelArray[i].text = title
                    bigGroupLabelArray[i].textColor = Colors.light
                    bigGroupLabelArray[i].alpha = 1
                    bigGroupLabelArray[i].layer.borderColor = Colors.light.withAlphaComponent(0.5).cgColor
                    bigGroupLabelArray[i].layer.borderWidth = 1
                    bigGroupLabelArray[i].isUserInteractionEnabled = true
                    bigGroupLabelArray[i].layer.cornerRadius = 15
                    bigGroupLabelArray[i].clipsToBounds = true

                    
                    // Make label dark and green if all session of group have been chosen
                    if dayTableGroupArray[indexOfGroup] == schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][stringIndex] as! Int {
                        bigGroupLabelArray[i].alpha = 0.75
                        bigGroupLabelArray[i].layer.borderColor = Colors.green.withAlphaComponent(0.5).cgColor
                        bigGroupLabelArray[i].textColor = Colors.green
                    }
                }
            }
        // Custom schedule
        // Present all groups
        } else {
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
            }
        }
    }
    
    // Update full week array
        // If user is in day mode, the full week should be still updating
        // For when user adds new group to week, adds to the fullweek array as well to ensure consistency
    // TODO: TESTING, UPDATE FULL WEEK
//    func updateFullWeek() {
//        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
////
////        schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![7] = []
////        scheduleTracking[ScheduleVariables.shared.selectedSchedule][7] = []
//        var shouldAppend = false
//        var indexAtWhichToAdd = 0
//        var shouldBreak = false
//        let count = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![7].count
//        if count != 0 {
//            for i in 0...count - 1 {
//                // Compare group at i and 1 after i,  if groupAti <= groupToAdd < groupAti+1, the insert at i + 1
//                    // e.g 001112233, inserting 2, -> 2 <= 2 < 3
//                    // e.g 0015, inserting 2, -> 1 <= 2 < 5
//                switch i {
//                // Last, can't compare to i+1, indicate to append not insert
//                case count - 1:
//                    shouldAppend = true
//                default:
//                    let groupAtI = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![7][i] as! Int
//                    let groupAtI1 = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![7][i + 1] as! Int
//                    if groupAtI <= indexOfDraggedGroup && indexOfDraggedGroup < groupAtI1 {
//                        indexAtWhichToAdd = i + 1
//                        shouldBreak = true
//                    }
//                }
//                if shouldBreak {
//                    break
//                }
//            }
//        // Nowhere to insert - append
//        } else {
//            shouldAppend = true
//        }
//
//        // Append
//        if shouldAppend {
//            schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![7].append(indexOfDraggedGroup)
//            scheduleTracking[ScheduleVariables.shared.selectedSchedule][7].append(scheduleDataStructures.scheduleTrackingArrays[indexOfDraggedGroup]!)
//        // Insert
//        } else {
//            schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![7].insert(indexOfDraggedGroup, at: indexAtWhichToAdd)
//            scheduleTracking[ScheduleVariables.shared.selectedSchedule][7].insert(scheduleDataStructures.scheduleTrackingArrays[indexOfDraggedGroup]!, at: indexAtWhichToAdd)
//        }
//
//        //
////        UserDefaults.standard.set(schedules, forKey: "schedules")
//        // Sync
//        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
//        //
//        // Update
//        // Loop full week
//        dayTableGroupArray = [0,0,0,0,0,0]
//        if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![7].count != 0 {
//            for i in 0...schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![7].count - 1 {
//                let index = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![7][i] as! Int
//                dayTableGroupArray[index] += 1
//            }
//        }
//        dayTable.reloadData()
//    }
    
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
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]

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
            
            //
            let stringIndex = scheduleDataStructures.scheduleCreationHelpSorted[0][indexOfDraggedGroup][0]
            
            // If there are some session left to drag from group or if custom schedule
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 1 || dayTableGroupArray[indexOfDraggedGroup] != schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][stringIndex] as! Int {
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
            } else {
                previousIndexPath = nil
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
                    // TODO: !!!!!
//                    updateFullWeek()
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
                    // If app helps create schedule, add to day table
                    if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
                        draggingLabel.center = locationInView
                        dayTable.addSubview(draggingLabel)
                    // If custom schedule, add to view
                    } else {
                        draggingLabel.center = locationInView2
                        UIApplication.shared.keyWindow?.addSubview(draggingLabel)
                    }
                    maskStackViews()
                    
                    // If custom schedule, turn createschedulebutton into bin
                    if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 1 {
                        createScheduleButton.backgroundColor = Colors.red.withAlphaComponent(0.25)
                        createScheduleButton.setImage(#imageLiteral(resourceName: "Bin"), for: .normal)
                        createScheduleButton.setTitle("", for: .normal)
                    }
                    
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
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 && locationInView.y > 0 && locationInView.y < dayTable.frame.maxY {
                draggingLabel.center = locationInView
            // If custom, location in view
            } else if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 1 && locationInView.y > 0 {
                draggingLabel.center = locationInView2
            }
            
            // If Custom schedule and press over bin (createschedulebutton)
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 1 && createScheduleButton.frame.contains(locationInView2) {
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
                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 1 {
                    createScheduleButton.setImage(#imageLiteral(resourceName: "Bin"), for: .normal)
                    createScheduleButton.setTitle("", for: .normal)
                }
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
                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 1 {
                    createScheduleButton.setImage(#imageLiteral(resourceName: "Bin"), for: .normal)
                    createScheduleButton.setTitle("", for: .normal)
                }
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
                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 1 {
                    createScheduleButton.setImage(#imageLiteral(resourceName: "Bin"), for: .normal)
                    createScheduleButton.setTitle("", for: .normal)
                }
            }
            
            
        // Dragging label let go
        default:
            var shouldRemoveBin = true
            // If over bin
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 1 && createScheduleButton.frame.contains(locationInView2) {
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
                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 1 && shouldRemoveBin {
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
    // MARK: Dismiss view when finished
    // TODO: THIS FUNC

    
    
    
    //
    // MARK: Back Swipe
    @IBAction func edgeGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //
    // Dismiss view
    @IBAction func createScheduleButtonAction(_ sender: Any) {
        // Ensure notifications correct
        ReminderNotifications.shared.setNotifications()
        //
        // Return to schedule overview
        if fromScheduleEditing {
            self.navigationController?.popToRootViewController(animated: true)
        //
        // Schedule has just been created, dismiss to schedule screen
        } else {
            self.dismiss(animated: true)
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
