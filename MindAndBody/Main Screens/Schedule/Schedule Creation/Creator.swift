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
    @IBOutlet weak var dayTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var createScheduleButton: UIButton!
    @IBOutlet weak var createScheduleButtonHeight: NSLayoutConstraint!
    
    let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
  
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var binView: UIImageView!
    
    @IBOutlet weak var separator: UIView!
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
    
    var themeColor = Colors.dark

    //
    // View did load --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // SETUP
        setVariables()
        setGroupLabels()
        setupCreateScheduleButton()
        //
        // Navigation Bar
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("schedule", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)
        
        separator.backgroundColor = Colors.dark.withAlphaComponent(0.43)

        binView.tintColor = Colors.red
        binView.alpha = 0
        bigGroupLabel5.layer.borderColor = UIColor.clear.cgColor
        bigGroupLabel5.layer.borderWidth = 2
        bigGroupLabel5.layer.cornerRadius = 15
        bigGroupLabel5.clipsToBounds = true
        
        // Tables
        // Day Table
        dayTable.tableFooterView = UIView()
        dayTable.backgroundColor = .clear
        dayTable.isScrollEnabled = false
        //
        // Iphone 5/SE layout
        if IPhoneType.shared.iPhoneType() == IPhone.little {
            dayTableHeight.constant = 7*38
            createScheduleButtonHeight.constant = 40
        } else {
            dayTableHeight.constant = 7*44
        }
        
        //
        for i in 0..<bigGroupLabelArray.count {
            longPressArray[i].minimumPressDuration = 0
            longPressArray[i].addTarget(self, action: #selector(beginDraggingFromTop(gestureRecognizer:)))
            bigGroupLabelArray[i].addGestureRecognizer(longPressArray[i])
        }
        
        
        // Dragging
        draggingLabel.textColor = themeColor
        draggingLabel.textAlignment = .center
        draggingLabel.font = Fonts.mediumElementRegular
        // Iphone 5/SE layout, smaller text for endurance
        if IPhoneType.shared.iPhoneType() == IPhone.little {
            draggingLabel.font = UIFont(name: "SFUIDisplay-light", size: 18)
        }
        draggingLabel.lineBreakMode = .byWordWrapping
        draggingLabel.layer.borderColor = themeColor.cgColor
        draggingLabel.layer.borderWidth = 2
        draggingLabel.layer.cornerRadius = 15
        draggingLabel.clipsToBounds = true
        
        // Long press cell
        longPressCell.minimumPressDuration = 0
        longPressCell.addTarget(self, action: #selector(beginDraggingFromCell(gestureRecognizer:)))
        dayTable.addGestureRecognizer(longPressCell)
    }
    
    func setupCreateScheduleButton() {
        // Not from schedule editing => schedule creation
        if !fromScheduleEditing {
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
        // Iphone 5/SE layout, smaller text for endurance
        if IPhoneType.shared.iPhoneType() == IPhone.little {
            return 38
        } else {
            return 44
        }
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell: DayCell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! DayCell
        cell.selectionStyle = .none
        //
        // Iphone 5/SE layout
        if IPhoneType.shared.iPhoneType() == IPhone.little {
            // Short names
            cell.dayLabel.text = NSLocalizedString(dayArrayShort[indexPath.row], comment: "")
        } else {
            cell.dayLabel.text = NSLocalizedString(dayArray[indexPath.row], comment: "")

        }
        cell.dayLabel.font = Fonts.mediumElementRegular
        cell.dayLabel.textColor = themeColor
        
        cell.layoutSubviews()
        
        for i in 0..<cell.groupLabelArray.count {
            cell.groupLabelArray[i].textColor = Colors.dark
            cell.groupLabelArray[i].font = Fonts.mediumElementRegular
        }
        
        
        // add relevant groups if they are there
        if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![indexPath.row].count != 0 {
            for i in 0...ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![indexPath.row].count - 1 {
                cell.groupLabelArray[i].tag = 1
                cell.groupLabelArray[i].alpha = 1
                cell.groupLabelArray[i].layer.borderWidth = 2
                cell.groupLabelArray[i].layer.borderColor = themeColor.cgColor
                cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                cell.groupLabelArray[i].clipsToBounds = true
                //
                // Get group as int
                let group = (ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![indexPath.row][i]["group"] as! String).groupFromString()
                cell.groupLabelArray[i].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[group], comment: "")
                cell.dayLabel.font = Fonts.mediumElementRegular
            }
        }
        return cell
        //
    }

    
    //
    // MARK: - Helper functions
    // MARK: General Helpers
    func setVariables() {
        
        

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
        if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
            for i in 0...6 {
                if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count != 0 {
                    for j in 0...ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count - 1 {
                        let indexOfGroupInLoop = (ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i][j]["group"] as! String).groupFromString()
                        dayTableGroupArray[indexOfGroupInLoop] += 1
                    }
                }
            }
        }
        
        ScheduleVariables.shared.saveSchedules()
    }
    
    func setGroupLabels() {
        
        // Custom schedule
        // Present all groups
        // Set titles for all groups
        for i in 0..<bigGroupLabelArray.count {
            //
            let groupTitle = NSLocalizedString(scheduleDataStructures.groupNames[i], comment: "")
            // Not selected filled in
            let title = groupTitle
            bigGroupLabelArray[i].text = title
            bigGroupLabelArray[i].textColor = themeColor
            bigGroupLabelArray[i].alpha = 1
            bigGroupLabelArray[i].layer.borderColor = themeColor.cgColor
            bigGroupLabelArray[i].layer.borderWidth = 2
            bigGroupLabelArray[i].isUserInteractionEnabled = true
            bigGroupLabelArray[i].layer.cornerRadius = 15
            bigGroupLabelArray[i].clipsToBounds = true
            if IPhoneType.shared.iPhoneType() == IPhone.little {
                bigGroupLabelArray[i].font = UIFont(name: "SFUIDisplay-regular", size: 17)
            } else {
                bigGroupLabelArray[i].font = Fonts.mediumElementRegular
            }

            //
            // App helps create schedule
            if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 && !fromScheduleEditing {
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
                    
                // Make label dark if all session of group have been chosen, or if not suggested
                } else {
                    if !fromScheduleEditing {
                        bigGroupLabelArray[i].layer.borderColor = Colors.dark.withAlphaComponent(0.5).cgColor
                        bigGroupLabelArray[i].textColor = Colors.dark.withAlphaComponent(0.5)
                    }
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
            view.addSubview(draggingLabel)
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
                        cell.groupLabelArray[i].backgroundColor = themeColor
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = Fonts.veryLargeElementRegular
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
                            previousCell.dayLabel.font = Fonts.mediumElementRegular
                            break
                        }
                    }
                }
                //
                let cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].backgroundColor == themeColor {
                        break
                    } else if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 2
                        cell.groupLabelArray[i].backgroundColor = themeColor
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = Fonts.veryLargeElementRegular
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
                            previousCell.dayLabel.font = Fonts.mediumElementRegular
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
                        previousCell.dayLabel.font = Fonts.mediumElementRegular
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
                
                // if there are already 5 lightgs in one day, do nolightg
                var dayIsFull = false
                // Put the goal in the day
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 1
                        cell.groupLabelArray[i].alpha = 1
                        cell.groupLabelArray[i].layer.borderWidth = 2
                        cell.groupLabelArray[i].layer.borderColor = themeColor.cgColor
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        //
                        cell.groupLabelArray[i].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[indexOfDraggedGroup], comment: "")
                        cell.dayLabel.font = Fonts.mediumElementRegular
                        break
                    } else if i == cell.groupLabelArray.count - 1 {
                        // Too much in one day, cant add any more
                        dayIsFull = true
                    }
                }
                
                if dayIsFull == false {
                    // Update the array
                    //
                    
                        // update dayTableGroupArray
                    dayTableGroupArray[indexOfDraggedGroup] += 1
                    // update schedules
                    ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![(previousIndexPath?.row)!].append(scheduleDataStructures.scheduleGroups[indexOfDraggedGroup]!)
                    ScheduleVariables.shared.saveSchedules()
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
                    indexOfDraggedGroup = (ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![indexPathForRow!.row][indexOfDrag]["group"] as! String).groupFromString()
                    //
                    previousIndexPath = indexPathForRow
                    
                    // Remove from schedules array and update userdefaults
                    ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![(indexPathForRow?.row)!].remove(at: indexOfDrag)
                    //
                    ScheduleVariables.shared.saveSchedules()
                    // Remove the label being dragged
                    cell.groupLabelArray[indexOfDrag].tag = 0
                    cell.groupLabelArray[indexOfDrag].alpha = 0

                    //reload cell
                    if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![(indexPathForRow?.row)!].count != 0 {
                        cell.layoutSubviews()
                        // Remove all groups
                        for j in 0...cell.groupLabelArray.count - 1 {
                            cell.groupLabelArray[j].tag = 0
                            cell.groupLabelArray[j].alpha = 0
                        }
                        
                        // Add all relevant groups
                        for k in 0...ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![(indexPathForRow?.row)!].count - 1 {
                            cell.groupLabelArray[k].tag = 1
                            cell.groupLabelArray[k].alpha = 1
                            cell.groupLabelArray[k].layer.borderWidth = 2
                            cell.groupLabelArray[k].layer.borderColor = themeColor.cgColor
                            cell.groupLabelArray[k].layer.cornerRadius = 15 / 2
                            cell.groupLabelArray[k].clipsToBounds = true
                            //
                            let groupIndex =  (ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![(indexPathForRow?.row)!][k]["group"] as! String).groupFromString()
                            cell.groupLabelArray[k].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[groupIndex], comment: "")
                            cell.dayLabel.font = Fonts.mediumElementRegular
                        }
                    }
                    
                    
                    
                    // Edit the draggingLabel
                    draggingLabel.text = NSLocalizedString(scheduleDataStructures.groupNames[indexOfDraggedGroup], comment: "")
                    draggingLabel.frame = bigGroupLabelArray[indexOfDrag].bounds
                    
                    // Add dragging label and mask stack views
                    draggingLabel.center = locationInView2
                    view.addSubview(draggingLabel)
                    maskStackViews()
                    
                    // Reveal bin
                    binView.alpha = 1
                    bigGroupLabel5.layer.borderColor = Colors.red.cgColor
                    bigGroupLabel5.backgroundColor = .clear
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
            if !dayTable.frame.contains(locationInView2) {
                // Clear old cell
                // CLEAR INDICATOR
                if previousIndexPath != nil {
                    let previousCell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                    for i in 0...previousCell.groupLabelArray.count - 1 {
                        if previousCell.groupLabelArray[i].tag == 2 {
                            previousCell.groupLabelArray[i].tag = 0
                            previousCell.groupLabelArray[i].backgroundColor = .clear
                            previousCell.groupLabelArray[i].alpha = 0
                            previousCell.dayLabel.font = Fonts.mediumElementRegular
                            break
                        }
                    }
                }
                
                bigGroupLabel5.backgroundColor = Colors.red.withAlphaComponent(0.5)
                binView.image = #imageLiteral(resourceName: "BinOpen")
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
                            cell.groupLabelArray[i].backgroundColor = themeColor
                            cell.groupLabelArray[i].alpha = 0.5
                            cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                            cell.groupLabelArray[i].clipsToBounds = true
                            cell.dayLabel.font = Fonts.veryLargeElementRegular
                            break
                        }
                    }
                
                    bigGroupLabel5.backgroundColor = .clear
                    binView.image = #imageLiteral(resourceName: "Bin")
                // Row is changing, changing highlight
            } else if indexPathForRow != nil && indexPathForRow != previousIndexPath {
                
                //
                
                if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![(indexPathForRow?.row)!].count != 5 {
                    // Clear old cell
                    // CLEAR INDICATOR
                    if previousIndexPath != nil {
                        let previousCell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                        for i in 0...previousCell.groupLabelArray.count - 1 {
                            if previousCell.groupLabelArray[i].tag == 2 {
                                previousCell.groupLabelArray[i].tag = 0
                                previousCell.groupLabelArray[i].backgroundColor = .clear
                                previousCell.groupLabelArray[i].alpha = 0
                                previousCell.dayLabel.font = Fonts.mediumElementRegular
                                break
                            }
                        }
                    }
                    
                    previousIndexPath = indexPathForRow!
                
                //
                let cell = dayTable.cellForRow(at: indexPathForRow!) as! DayCell
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].backgroundColor == themeColor {
                        break
                    } else if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 2
                        cell.groupLabelArray[i].backgroundColor = themeColor
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = Fonts.veryLargeElementRegular
                        break
                    }
                }
                
            }
                
                bigGroupLabel5.backgroundColor = .clear
                binView.image = #imageLiteral(resourceName: "Bin")
            // Dragging label is dragged off table, set to monday
            } else if indexPathForRow == nil {
                // Clear old cell
                // CLEAR INDICATOR
                //
                let cell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell
                // ADD INDICATOR
                for i in 0...cell.groupLabelArray.count - 1 {
                    if cell.groupLabelArray[i].backgroundColor == themeColor {
                        break
                    } else if cell.groupLabelArray[i].tag == 0 {
                        cell.groupLabelArray[i].tag = 2
                        cell.groupLabelArray[i].backgroundColor = themeColor
                        cell.groupLabelArray[i].alpha = 0.5
                        cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                        cell.groupLabelArray[i].clipsToBounds = true
                        cell.dayLabel.font = Fonts.veryLargeElementRegular
                        break
                    }
                }
                
                bigGroupLabel5.backgroundColor = .clear
                binView.image = #imageLiteral(resourceName: "Bin")
            }
            
            
        // Dragging label let go
        default:
            var shouldRemoveBin = true
            // If over bin
            if !dayTable.frame.contains(locationInView2) {
                // Haptic feedback
                var generator: UIImpactFeedbackGenerator? = UIImpactFeedbackGenerator(style: .light)
                generator?.prepare()
                generator?.impactOccurred()
                generator = nil
                
                // Animate lable to bin
                shouldRemoveBin = false // Remove bin handled here, after animation
                UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                    self.draggingLabel.frame.size = CGSize(width: 0, height: 0)
                    let center = CGPoint(x: self.bigGroupLabel5.center.x, y: self.groupStack2.center.y)
                    self.draggingLabel.center = center
                }, completion: { finished in
                    // Hide bin
                    self.binView.alpha = 0
                    self.bigGroupLabel5.backgroundColor = .clear
                    self.bigGroupLabel5.layer.borderColor = UIColor.clear.cgColor
                    self.draggingLabel.removeFromSuperview()
                    self.deMaskStackViews()
                })
                // Note: no need to remove from any arrays as already been removed when the label was picked up
                
                // Update group labels for session suggestion if app helps create schedule
                if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
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
                            previousCell.dayLabel.font = Fonts.mediumElementRegular
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
            
                    // if there are already 5 lightgs in one day, do nolightg
                    var dayIsFull = false
                    // Put the goal in the day
                    // ADD INDICATOR
                    for i in 0...cell.groupLabelArray.count - 1 {
                        if cell.groupLabelArray[i].tag == 0 {
                            cell.groupLabelArray[i].tag = 1
                            cell.groupLabelArray[i].alpha = 1
                            cell.groupLabelArray[i].layer.borderWidth = 2
                            cell.groupLabelArray[i].layer.borderColor = themeColor.cgColor
                            cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                            cell.groupLabelArray[i].clipsToBounds = true
                            //
                            cell.groupLabelArray[i].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[indexOfDraggedGroup], comment: "")
                            cell.dayLabel.font = Fonts.mediumElementRegular
                            break
                        } else if i == cell.groupLabelArray.count - 1 {
                            // Too much in one day, cant add any more
                            dayIsFull = true
                        }
                    }
            
                    if dayIsFull == false {
                        // Update the array
                        //
                        
                                // update schedules
                            // Do a check, if the user is dragging off the top of the teable (indexpathforrow == nil, set to previous indexpath(always monday))
                        if indexPathForRow != nil {
                            ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![(indexPathForRow?.row)!].append(scheduleDataStructures.scheduleGroups[indexOfDraggedGroup]!)
                        } else {
                            ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![(previousIndexPath?.row)!].append(scheduleDataStructures.scheduleGroups[indexOfDraggedGroup]!)
                        }
                        ScheduleVariables.shared.saveSchedules()
                    } else {
                        let cell = dayTable.cellForRow(at: previousIndexPath!) as! DayCell

                        // Put the goal in the day
                        // ADD INDICATOR
                        for i in 0...cell.groupLabelArray.count - 1 {
                            if cell.groupLabelArray[i].tag == 0 {
                                cell.groupLabelArray[i].tag = 1
                                cell.groupLabelArray[i].alpha = 1
                                cell.groupLabelArray[i].layer.borderWidth = 2
                                cell.groupLabelArray[i].layer.borderColor = themeColor.cgColor
                                cell.groupLabelArray[i].layer.cornerRadius = 15 / 2
                                cell.groupLabelArray[i].clipsToBounds = true
                                //
                                cell.groupLabelArray[i].text = NSLocalizedString(scheduleDataStructures.shortenedGroupNames[indexOfDraggedGroup], comment: "")
                                cell.dayLabel.font = Fonts.mediumElementRegular
                                break
                            } else if i == cell.groupLabelArray.count - 1 {
                                // Too much in one day, cant add any more
                                dayIsFull = true
                            }
                        }
                        
                        
                        // Update the array
                        //
                        
                                // update schedules
                        ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![(previousIndexPath?.row)!].append(scheduleDataStructures.scheduleGroups[indexOfDraggedGroup]!)
                        ScheduleVariables.shared.saveSchedules()
                }
                
                    draggingLabel.removeFromSuperview()
                    deMaskStackViews()
                
                // Remove bin
                if shouldRemoveBin {
                    // Hide bin
                    self.binView.alpha = 0
                    self.bigGroupLabel5.backgroundColor = .clear
                    self.bigGroupLabel5.layer.borderColor = UIColor.clear.cgColor
                }
            }
        }
        
        
        
        
    //
    }
    
    
    
    // Mask stacks
    func maskStackViews() {
        stackViewMask.backgroundColor  = .black
        stackViewMask.alpha = 0
        stackViewMask.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: separator.frame.maxY)
//        view.addSubview(stackViewMask)
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
    
    // Finished
    @IBAction func createScheduleButtonAction(_ sender: Any) {
        // Ensure notifications correct
        ReminderNotifications.shared.setNotifications()
        
        self.dismiss(animated: true)
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
    
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    var groupLabelArray: [UILabel] = []
    
    override func layoutSubviews() {
        groupLabelArray = [groupLabel0, groupLabel1, groupLabel2, groupLabel3, groupLabel4]
        if IPhoneType.shared.iPhoneType() == IPhone.little {
            top.constant = 4
            bottom.constant = 4
        }
    }
}
