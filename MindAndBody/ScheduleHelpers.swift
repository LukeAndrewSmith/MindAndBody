//
//  ScheduleHelpers.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

extension ScheduleScreen {
    //
    // MARK: Schedule Helper Functions
    //
    // MARK: didSelectRowHandler
    func didSelectRowHandler(row: Int) {
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]

        updateSelectedChoice(row: row)
        // ------------------------------------------------------------------------------------------------
        // Next Choice Function
        if ScheduleVariables.shared.choiceProgress[0] == -1 && row != schedules[ScheduleVariables.shared.selectedSchedule][0][ScheduleVariables.shared.selectedDay].count {
            ScheduleVariables.shared.choiceProgress[0] = schedules[ScheduleVariables.shared.selectedSchedule][0][ScheduleVariables.shared.selectedDay][row] as! Int
            ScheduleVariables.shared.choiceProgress[1] += 1
            ScheduleVariables.shared.selectedRows[0] = row
            maskView()
            // Next Table info
            slideLeft()
            
            //
        } else {
            // Present next choice or present session
            switch ScheduleVariables.shared.choiceProgress[0] {
                // ------------------------------------------------------------------------------------------------
            // Mind
            case 0:
                // Session Choice
                switch ScheduleVariables.shared.choiceProgress[1] {
                // First choice - yoga, meditation, walk
                case 1:
                    // Yoga, more choices
                    if row == 1 {
                        ScheduleVariables.shared.choiceProgress[1] += 1
                        nextChoice()
                    // Go to Meditation screen
                    } else if row == 2 {
                        // Meditation
                        ScheduleVariables.shared.choiceProgress[1] = 5
                        nextChoice()
                    // Walk, popup
                    } else if row == 3 {
                        ScheduleVariables.shared.selectedRows[1] = 72
                        // TODO: popup for walk
                    }
                case 4:
                    // Test - Yoga
                    // TODO: Selected choice as index to sortedGroups (in data structures)
                    // Warmup
                    if row == 1 {
                        selectWarmup()
                    // Session
                    } else if row == 2 {
                        selectSession()
                    }
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                case 5:
                    ScheduleVariables.shared.selectedRows[1] = 72
                    // Timer
                    if row == 1 {
                        performSegue(withIdentifier: "scheduleMeditationSegueTimer", sender: self)
                        // Guided
                    } else {
                        performSegue(withIdentifier: "scheduleMeditationSegueGuided", sender: self)
                    }
                default:
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                }
                
                // ------------------------------------------------------------------------------------------------
            // Flexibility
            case 1:
                // Final choice -> session
                if ScheduleVariables.shared.choiceProgress[1] == 4 {
                    // Test
                    // TODO: Selected choice as index to sortedGroups (in data structures)
                    // Warmup
                    if row == 1 {
                        selectWarmup()
                    // Session
                    } else if row == 2 {
                        selectSession()
                    }
                    //
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                // Choice
                } else {
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                }
                
                // ------------------------------------------------------------------------------------------------
            // Endurance
            case 2:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Type 1, hiit vs steady state
                case 1:
                    // Workout
                    if row == 2 {
                        ScheduleVariables.shared.choiceProgress[1] = 3
                        nextChoice()
                    // Steady state cardio
                    } else if row == 3 {
                        ScheduleVariables.shared.choiceProgress[1] = 5
                        nextChoice()
                    } else {
                        ScheduleVariables.shared.choiceProgress[1] += 1
                        nextChoice()
                    }
                case 3:
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                // Session Choice, To Do
                case 4:
                    // Test
                    // TODO: Selected choice as index to sortedGroups (in data structures)
                    // Warmup
                    if row == 1 {
                        selectWarmup()
                    // Session
                    } else if row == 2 {
                        selectSession()
                    // Stretching
                    } else if row == 3 {
                        selectStretching()
                    }
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                case 5:
                    if row == 2 {
                        // TODO: Popup saying go do cardio - run, bike, row, swim
                    } else {
                        if row == 1 {
                            steadyStateChoice = 0
                        } else if row == 3 {
                            steadyStateChoice = 1
                        }
                        //
                        ScheduleVariables.shared.choiceProgress[1] += 1
                        nextChoice()
                    }
                // Session Choice , To do
                case 6:
                    // Test
                    // TODO: Selected choice as index to sortedGroups (in data structures)
                    // Warmup
                    if steadyStateChoice == 0 {
                        selectWarmup()
                    // Stretching
                    } else if steadyStateChoice == 1 {
                        selectStretching()
                    }
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                    //
                    ScheduleVariables.shared.choiceProgress[1] -= 1
                    nextChoice()
                default:
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                }
                
                // ------------------------------------------------------------------------------------------------
            // Toning
            case 3:
                // Cardio
                if ScheduleVariables.shared.choiceProgress[1] == 1 && row == 2 {
                    ScheduleVariables.shared.choiceProgress[1] = 5
                    nextChoice()
                // Final choice workout
                } else if ScheduleVariables.shared.choiceProgress[1] == 4 || ScheduleVariables.shared.choiceProgress[1] == 6 {
                    // Test
                    // TODO: Selected choice as index to sortedGroups (in data structures)
                    // Warmup
                    if row == 1 {
                        selectWarmup()
                        // Session
                    } else if row == 2 {
                        selectSession()
                        // Stretching
                    } else if row == 3 {
                        selectStretching()
                    }
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                } else {
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                }
                
                // ------------------------------------------------------------------------------------------------
            // Muscle Gain
            case 4:
                // Session Choice
                if ScheduleVariables.shared.choiceProgress[1] == 4 {
                    // Test
                    // TODO: Selected choice as index to sortedGroups (in data structures)
                    // Warmup
                    if row == 1 {
                        selectWarmup()
                        // Session
                    } else if row == 2 {
                        selectSession()
                        // Stretching
                    } else if row == 3 {
                        selectStretching()
                    }
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                } else {
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                }
                
                // ------------------------------------------------------------------------------------------------
            // Strength
            case 5:
                // Session Choice
                if ScheduleVariables.shared.choiceProgress[1] == 4 {
                    // Test
                    // TODO: Selected choice as index to sortedGroups (in data structures)
                    // Warmup
                    if row == 1 {
                        selectWarmup()
                        // Session
                    } else if row == 2 {
                        selectSession()
                        // Stretching
                    } else if row == 3 {
                        selectStretching()
                    }
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                } else {
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                }
            default:
                break
            }
        }
    }
    
    //
    // Select sessions
    // Warmup
    func selectWarmup() {
        SelectedSession.shared.selectedSession = sessionData.sortedSessions[selectedChoiceWarmup[0]]![selectedChoiceWarmup[1]][selectedChoiceWarmup[2]][selectedChoiceWarmup[3]][selectedChoiceWarmup[4]][selectedChoiceWarmup[5]]
    }
    // Session
    func selectSession() {
        SelectedSession.shared.selectedSession = sessionData.sortedSessions[selectedChoiceSession[0]]![selectedChoiceSession[1]][selectedChoiceSession[2]][selectedChoiceSession[3]][selectedChoiceSession[4]][selectedChoiceSession[5]]
    }
    // Stretching
    func selectStretching() {
        SelectedSession.shared.selectedSession = sessionData.sortedSessions[selectedChoiceStretching[0]]![selectedChoiceStretching[1]][selectedChoiceStretching[2]][selectedChoiceStretching[3]][selectedChoiceStretching[4]][selectedChoiceStretching[5]]
    }
    
    //
    // MARK: Update selected choice
    // Look at both sortedGroups & sortedSessions in dataStructures to understand the following
        // Function for going through choices on the schedule screen, is called when group/choice is pressed and determines what to present next
    func updateSelectedChoice(row: Int) {
        //
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        // ------------------------------------------------------------------------------------------------
        if ScheduleVariables.shared.choiceProgress[0] == -1 && row != schedules[ScheduleVariables.shared.selectedSchedule][0][ScheduleVariables.shared.selectedDay].count {
            // Notes selectedChoiceStretching not always used
            // selectedChoice...[0] to group
            selectedChoiceWarmup[0] = schedules[ScheduleVariables.shared.selectedSchedule][0][ScheduleVariables.shared.selectedDay][row] as! Int
            selectedChoiceSession[0] = schedules[ScheduleVariables.shared.selectedSchedule][0][ScheduleVariables.shared.selectedDay][row] as! Int
            selectedChoiceStretching[0] = schedules[ScheduleVariables.shared.selectedSchedule][0][ScheduleVariables.shared.selectedDay][row] as! Int
        //
        } else {
            // Present next choice or present session
            switch ScheduleVariables.shared.choiceProgress[0] {
            // ------------------------------------------------------------------------------------------------
            // Mind
            case 0:
                // Session Choice
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Yoga
                case 1:
                    if row == 1 {
                        // selectedChoiceWarmup[1-3] = 0 (0,0,0,0,..)
                        selectedChoiceWarmup[1] = 0
                        selectedChoiceWarmup[2] = 0
                        selectedChoiceWarmup[3] = 0
                        // selectedChoiceSession[1] to 1 (1 being session) (0,1...)
                        selectedChoiceSession[1] = 1
                    }
                // Focus
                case 2:
                    // selectedChoiceSession[2] = 0 in this case due to nesting (0,1,0,...)
                    selectedChoiceSession[2] = 0
                    // selectedchoiceSession[3] = row - 1 == focus (row - 1 as row is 1 too large due to title row)
                    // (0,1,0,row-1)
                    selectedChoiceSession[3] = row - 1
                // Length
                case 3:
                    // selectedChoice...[] = row - 1 == length (row - 1 as row is 1 too large due to title row)
                    selectedChoiceWarmup[4] = row - 1
                    selectedChoiceSession[4] = row - 1
                    
                    // TODO: Update last index, difficulty, based on profile data
                    // Testing so just set to 0
                    selectedChoiceWarmup[5] = 0
                    selectedChoiceSession[5] = 0
                default:
                    break
                }
                
            // ------------------------------------------------------------------------------------------------
            // Flexibility
            case 1:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Stretching / Yoga
                case 1:
                    // Warmup (1,0,0), extra zeros necessary due to nesting
                    selectedChoiceWarmup[1] = 0
                    selectedChoiceWarmup[2] = 0
                    // Session
                    selectedChoiceSession[1] = 1
                    // selectedChoiceSession[2] = row - 1 == stretching/yoga
                    selectedChoiceSession[2] = row - 1
                // Focus
                case 2:
                    // Focus = row - 1 due to extra title row
                    selectedChoiceWarmup[3] = row - 1
                    selectedChoiceSession[3] = row - 1
                // Length
                case 3:
                    // Length = row - 1 due to extra title row
                    selectedChoiceWarmup[4] = row - 1
                    selectedChoiceSession[4] = row - 1
                    
                    // TODO: Update last index, difficulty, based on profile data
                    // Testing so just set to 0
                    selectedChoiceWarmup[5] = 0
                    selectedChoiceSession[5] = 0
                    
                default:
                    break
                }
                //
            // ------------------------------------------------------------------------------------------------
            // Endurance
            case 2:
                switch ScheduleVariables.shared.choiceProgress[1] {
                case 1:
                    // Warmup (2,0,0...), extra zeros necessary due to nesting
                    selectedChoiceWarmup[1] = 0 // warmup
                    selectedChoiceWarmup[2] = 0 // nesting
                    // Session (2,1,0...)
                    selectedChoiceSession[1] = 1 // session
                    selectedChoiceSession[2] = 0 // nesting
                    // Stretching (2,2,0....)
                    selectedChoiceStretching[1] = 2 // stretching
                    selectedChoiceStretching[2] = 0 // nesting
                    //
                    // Steady State
                    if row == 3 {
                        // Cardio so select 0 for warmup/workout
                        selectedChoiceWarmup[3] = 0 // hiit / workout
                        selectedChoiceStretching[3] = 0 // hiit / workout
                    // Cardio/Bodyweight Workout
                    } else if row == 2 {
                        selectedChoiceWarmup[3] = 3
                        selectedChoiceSession[3] = 3
                        selectedChoiceStretching[3] = 3
                    } else {
                        selectedChoiceWarmup[3] = row - 1
                        selectedChoiceSession[3] = row - 1
                        selectedChoiceStretching[3] = row - 1
                    }
                //
                // Rowing/Biking/Running
                // Type: Hiit or workout
                case 2:
                    // Rowing Biking Running all is same array, so 0-2, 3-5, 6-8 all different sections.. Could be done better having them in seperate arrays however late addition
                    // Below is to pass the info to length choice so that it knows which one to select
                    
                    // Row - 1 due to header
                    selectedChoiceWarmup[3] = row - 1
                    selectedChoiceSession[3] = row - 1
                    selectedChoiceStretching[3] = row - 1
//                    if row == 1 {
//                        selectedChoiceWarmup[4] = 0
//                        selectedChoiceSession[4] = 0
//                        selectedChoiceStretching[4] = 0
//                    } else if row == 2 {
//                        selectedChoiceWarmup[4] = 3
//                        selectedChoiceSession[4] = 3
//                        selectedChoiceStretching[4] = 3
//                    } else if row == 3 {
//                        selectedChoiceWarmup[4] = 6
//                        selectedChoiceSession[4] = 6
//                        selectedChoiceStretching[4] = 6
//                    }
                    
                // Length
                case 3:
                    // Length = row - 1 due to title row
                    // + selectedChoiceWarmup[4] as rowing/biking/running in same array
                    
                    // Row - 1 due to header
                    selectedChoiceWarmup[4] = row - 1
                    selectedChoiceSession[4] = row - 1
                    selectedChoiceStretching[4] = row - 1
                    
//                    selectedChoiceWarmup[4] = row - 1 + selectedChoiceWarmup[4]
//                    selectedChoiceSession[4] = row - 1 + selectedChoiceWarmup[4]
//                    selectedChoiceStretching[4] = row - 1 + selectedChoiceWarmup[4]
                    //
                    // TODO: Update last index, difficulty, based on profile data
                    // Testing so just set to 0
                    selectedChoiceWarmup[5] = 0
                    selectedChoiceSession[5] = 0
                //
                // Steady State
                // Length
                case 6:
                    // Length = row - 1 due to title row
                    selectedChoiceWarmup[4] = row - 1
                    selectedChoiceStretching[4] = row - 1
                    //
                    // TODO: Update last index, difficulty, based on profile data
                    // Testing so just set to 0
                    selectedChoiceWarmup[5] = 0
                    selectedChoiceStretching[5] = 0
                default:
                    break
                }
                // ------------------------------------------------------------------------------------------------
            // Toning
            case 3:
                switch ScheduleVariables.shared.choiceProgress[1] {
                case 1:
                    selectedChoiceWarmup[1] = 0 // warmup
                    selectedChoiceSession[1] = 1 // session
                    selectedChoiceStretching[1] = 2 // stretching
                    
                    // Workout
                    if row == 1 {
                        selectedChoiceWarmup[2] = 1 //
                        selectedChoiceSession[2] = 1 //
                        selectedChoiceStretching[2] = 1 //
                    // Cardio nesting required with 0
                    } else if row == 2 {
                        selectedChoiceWarmup[2] = 0 // nesting
                        selectedChoiceSession[2] = 0 // nesting
                        selectedChoiceStretching[2] = 0 // nesting
                    }
                //
                // Bodyweight workout
                // Focus
                case 2:
                    selectedChoiceWarmup[3] = row - 1
                    selectedChoiceSession[3] = row - 1
                    selectedChoiceStretching[3] = row - 1
                // Length
                case 3:
                    // Length = row - 1 due to title row
                    selectedChoiceWarmup[4] = row - 1
                    selectedChoiceSession[4] = row - 1
                    selectedChoiceStretching[4] = row - 1
                    //
                    // TODO: Update last index, difficulty, based on profile data
                    // Testing so just set to 0
                    selectedChoiceWarmup[5] = 0
                    selectedChoiceSession[5] = 0
                    selectedChoiceSession[5] = 0
                case 5:
                    // 0 due to nesting
                    selectedChoiceWarmup[3] = 0
                    selectedChoiceSession[3] = 0
                    selectedChoiceStretching[3] = 0
                    // Length = row - 1 due to title row
                    selectedChoiceWarmup[4] = row - 1
                    selectedChoiceSession[4] = row - 1
                    selectedChoiceStretching[4] = row - 1
                    //
                    // TODO: Update last index, difficulty, based on profile data
                    // Testing so just set to 0
                    selectedChoiceWarmup[5] = 0
                    selectedChoiceSession[5] = 0
                    selectedChoiceSession[5] = 0
                default:
                    break
                }
                // ------------------------------------------------------------------------------------------------
            // Muscle Gain
            case 4:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Gym/Bodyweight
                case 1:
                    // Warmup/Session/Stretching
                    selectedChoiceWarmup[1] = 0 // warmup
                    selectedChoiceSession[1] = 1 // session
                    selectedChoiceStretching[1] = 2 // stretching
                    // Gym/Bodyweight == row - 1 due to title
                    selectedChoiceWarmup[2] = row - 1
                    selectedChoiceSession[2] = row - 1
                    // 0 as nested due to stretching sessions being the same for gym/bodyweight
                    selectedChoiceStretching[2] = 0
                // Focus
                case 2:
                    // Focus == row - 1 due to title
                    selectedChoiceWarmup[3] = row - 1
                    selectedChoiceSession[3] = row - 1
                    selectedChoiceStretching[3] = row - 1
                // Length
                case 3:
                    // Length = row - 1 due to title row
                    selectedChoiceWarmup[4] = row - 1
                    selectedChoiceSession[4] = row - 1
                    selectedChoiceStretching[4] = row - 1
                    //
                    // TODO: Update last index, difficulty, based on profile data
                    // Testing so just set to 0
                    selectedChoiceWarmup[5] = 0
                    selectedChoiceSession[5] = 0
                    selectedChoiceSession[5] = 0
                default:
                     break
                }
                
            // ------------------------------------------------------------------------------------------------
            // Strength
            case 5:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Gym/Bodyweight
                case 1:
                    // Warmup/Session/Stretching
                    selectedChoiceWarmup[1] = 0 // warmup
                    selectedChoiceSession[1] = 1 // session
                    selectedChoiceStretching[1] = 2 // stretching
                    // Gym/Bodyweight == row - 1 due to title
                    selectedChoiceWarmup[2] = row - 1
                    selectedChoiceSession[2] = row - 1
                    // 0 as nested due to stretching sessions being the same for gym/bodyweight
                    selectedChoiceStretching[2] = 0
                // Focus
                case 2:
                    // Focus == row - 1 due to title
                    selectedChoiceWarmup[3] = row - 1
                    selectedChoiceSession[3] = row - 1
                    selectedChoiceStretching[3] = row - 1
                // Length
                case 3:
                    // Length = row - 1 due to title row
                    selectedChoiceWarmup[4] = row - 1
                    selectedChoiceSession[4] = row - 1
                    selectedChoiceStretching[4] = row - 1
                    //
                    // TODO: Update last index, difficulty, based on profile data
                    // Testing so just set to 0
                    selectedChoiceWarmup[5] = 0
                    selectedChoiceSession[5] = 0
                    selectedChoiceSession[5] = 0
                default:
                    break
                }
            //
            default:
                break
            }
        }
    }
    
    //
    // MARK: isLastChoice()
    // Last choice, i.e session choice
    // Used so the title can be set to green
    func isLastChoice() -> Bool {
        // Present next choice or present session
        switch ScheduleVariables.shared.choiceProgress[0] {
        // Mind
        case 0:
            if ScheduleVariables.shared.choiceProgress[1] == 4 {
                return true
            } else {
                return false
            }
        // Flexibility
        case 1:
            if ScheduleVariables.shared.choiceProgress[1] == 4 {
                return true
            } else {
                return false
            }
            
        // Endurance
        case 2:
            if ScheduleVariables.shared.choiceProgress[1] == 4 || ScheduleVariables.shared.choiceProgress[1] == 5 {
                return true
            } else {
                return false
            }
            
        // Toning
        case 3:
            if ScheduleVariables.shared.choiceProgress[1] == 4 || ScheduleVariables.shared.choiceProgress[1] == 6 {
                return true
            } else {
                return false
            }
            
        // Muscle Gain
        case 4:
            if ScheduleVariables.shared.choiceProgress[1] == 4 {
                return true
            } else {
                return false
            }
            
        // Strength
        case 5:
            if ScheduleVariables.shared.choiceProgress[1] == 4 {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }
    
    //
    // MARK: isCompleted()
    func isCompleted(row: Int) -> Bool {
        //
        let scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]

        // Day
        if scheduleStyle == 0 {
            // First choice screen, groups
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                return scheduleTracking[ScheduleVariables.shared.selectedSchedule][ScheduleVariables.shared.selectedDay][row][0][0]
            //
            // Later Choices
            } else if isLastChoice() == true {
                // All only have one array of bool for indicating final choice completion
                    // Flexibility, Toning, Muscle Gain, Strength, 1,3,4,5
                    return scheduleTracking[ScheduleVariables.shared.selectedSchedule][ScheduleVariables.shared.selectedDay][ScheduleVariables.shared.selectedRows[0]][1][row]
            }
        // Week
        } else if scheduleStyle == 1 {
            // First choice screen, groups
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                return scheduleTracking[ScheduleVariables.shared.selectedSchedule][7][row][0][0]
            //
            // TODO: IF LATER IN CHOICES, CHECK [1] FOR CHOICE PATH ETC...
            } else {
                // All only have one array of bool for indicating final choice completion
                // Flexibility, Toning, Muscle Gain, Strength, 1,3,4,5
                if isLastChoice() == true {
                    return scheduleTracking[ScheduleVariables.shared.selectedSchedule][7][ScheduleVariables.shared.selectedRows[0]][1][row]
                }
            }
        }
        return false
    }
    
    // Is group completed
    func isGroupCompleted() -> Bool {
        //
        // Check if group is completed
        var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
        let nRows = scheduleTable.numberOfRows(inSection: 0)
        var isCompleted = true
        // -2 because title included
        for i in 0...nRows - 2 {
            if scheduleTracking[ScheduleVariables.shared.selectedSchedule][ScheduleVariables.shared.selectedDay][ScheduleVariables.shared.selectedRows[0]][1][i] == false {
                isCompleted = false
                break
            }
        }
        //
        return isCompleted
    }
    
    //
    // MARK: Choice Functions
    func nextChoice() {
        //
        // Mask View
        maskView()
        // Next Table info
        slideLeft()
        //
        if isLastChoice() == true {
            if isGroupCompleted() == true {
                maskView3.backgroundColor = Colours.colour3
            } else {
                maskView3.backgroundColor = Colours.colour4
            }
        }
    }
    
    
    
    //
    // Navigation through days ---------------------------------------------------------------------------------------------------------------------
    //
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if ScheduleVariables.shared.choiceProgress[0] == -1 {
        //
        // Forward 1 day
        if (extraSwipe.direction == .left){
            // Update selected day
            switch ScheduleVariables.shared.selectedDay {
            case 6: ScheduleVariables.shared.selectedDay = 0
            default: ScheduleVariables.shared.selectedDay += 1
            }
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[ScheduleVariables.shared.selectedDay].alpha = 1
            animateDayIndicatorToDay()
            
            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x + self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            scheduleTable.alpha = 0
            //
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.scheduleTable.alpha = 1
                snapShot1?.removeFromSuperview()
                snapShot2?.removeFromSuperview()
            })
            
            //
            // Back 1 day
        } else if extraSwipe.direction == .right {
            // Update selected day
            switch ScheduleVariables.shared.selectedDay {
            case 0: ScheduleVariables.shared.selectedDay = 6
            default: ScheduleVariables.shared.selectedDay -= 1
            }
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[ScheduleVariables.shared.selectedDay].alpha = 1
            selectDay(day: ScheduleVariables.shared.selectedDay)
            animateDayIndicatorToDay()
            
            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x - self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            scheduleTable.alpha = 0
            //
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.scheduleTable.alpha = 1
                snapShot1?.removeFromSuperview()
                snapShot2?.removeFromSuperview()
            })
            
        }
        } else {
            if extraSwipe.direction == .right {
                maskAction()
            }
        }
    }
    
    //
    // Day Tap
    @objc func dayTapHandler(sender: UITapGestureRecognizer) {
        let dayLabel = sender.view as! UILabel
        let index = dayLabel.tag
        //
        // Forward
        if index > ScheduleVariables.shared.selectedDay {
            // Update selected day
            ScheduleVariables.shared.selectedDay = index
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[ScheduleVariables.shared.selectedDay].alpha = 1
            animateDayIndicatorToDay()

            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x + self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            scheduleTable.alpha = 0
            //
            view.isUserInteractionEnabled = false
            //
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.scheduleTable.alpha = 1
                snapShot1?.removeFromSuperview()
                snapShot2?.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
            })
            
            //
            // Back
        } else if index < ScheduleVariables.shared.selectedDay {
            // Update selected day
            ScheduleVariables.shared.selectedDay = index
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[ScheduleVariables.shared.selectedDay].alpha = 1
            selectDay(day: ScheduleVariables.shared.selectedDay)
            
            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x - self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            scheduleTable.alpha = 0
            //
            view.isUserInteractionEnabled = false
            //
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.scheduleTable.alpha = 1
                snapShot1?.removeFromSuperview()
                snapShot2?.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
            })
            
        }
    }

    //
    // MARK: Slide menu swipe
    @IBAction func edgeGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.performSegue(withIdentifier: "openMenu", sender: nil)
        }
    }
    //
    
    
    //
    // MARK: selectDay
    func selectDay(day: Int) {
        
        
        // Select indicator
        stackArray[day].alpha = 1
        
        // Reload table
        scheduleTable.reloadData()
    }
    
    
    //
    // MARK: Mark as completed
        // Also marks as incomplete if previously comleted, note: rename
    @IBAction func markAsCompleted(_ sender: UILongPressGestureRecognizer) {
        //
        var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]

        if sender.state == UIGestureRecognizerState.began {
            // Get Cell
            let cell = sender.view
            let row = cell?.tag
            
            // Indexing variables
                // Last three indexes of schedulesTracking or schedules index
                    // Differ if last choice or first choice
            var index0 = Int()
            var index1 = Int()
            var index2 = Int()
                        
            // If first choice
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                index0 = row!
                index1 = 0
                index2 = 0
            // If last choice
            } else if isLastChoice() == true && row! != 0 {
                // Selected row in first choice
                index0 = ScheduleVariables.shared.selectedRows[0]
                // 1 to access group contents tracking in trackingArray
                index1 = 1
                // -1 as title included in table so offset by 1
                index2 = row! - 1
            }
            
            //
            // Day View
            if scheduleStyle == 0 {
                let selectedGroup = schedules[ScheduleVariables.shared.selectedSchedule][0][ScheduleVariables.shared.selectedDay][index0] as! Int
                // Day
                // [index1][index2] when in group tracking to access main page tracker, look at schedule data: scheduleDataStructures.scheduleTrackingArrays to understand
                if scheduleTracking[ScheduleVariables.shared.selectedSchedule][ScheduleVariables.shared.selectedDay][index0][index1][index2] == false {
                    // Update day
                    scheduleTracking[ScheduleVariables.shared.selectedSchedule][ScheduleVariables.shared.selectedDay][index0][index1][index2] = true
                    // Update week
                    if scheduleTracking[ScheduleVariables.shared.selectedSchedule][7].count != 0 {
                        // Loop full week
                        for i in 0...scheduleTracking[ScheduleVariables.shared.selectedSchedule][7].count - 1 {
                            // If correct group and false
                            if schedules[ScheduleVariables.shared.selectedSchedule][0][7][i] as! Int == selectedGroup && scheduleTracking[ScheduleVariables.shared.selectedSchedule][7][i][index1][index2] == false {
                                scheduleTracking[ScheduleVariables.shared.selectedSchedule][7][i][index1][index2] = true
                                break
                            }
                        }
                    }
                    
                } else {
                    scheduleTracking[ScheduleVariables.shared.selectedSchedule][ScheduleVariables.shared.selectedDay][index0][index1][index2] = false
                    // Update week
                    if scheduleTracking[ScheduleVariables.shared.selectedSchedule][7].count != 0 {
                        // Loop full week
                        for i in 0...scheduleTracking[ScheduleVariables.shared.selectedSchedule][7].count - 1 {
                            // If correct group and true
                            if schedules[ScheduleVariables.shared.selectedSchedule][0][7][i] as! Int == selectedGroup && scheduleTracking[ScheduleVariables.shared.selectedSchedule][7][i][index1][index2] == true {
                                scheduleTracking[ScheduleVariables.shared.selectedSchedule][7][index0][index1][index2] = false
                                break
                            }
                        }
                    }
                }
            //
            // Full Week View
            } else if scheduleStyle == 1 {
                let selectedGroup = schedules[ScheduleVariables.shared.selectedSchedule][0][7][index0] as! Int
                var shouldBreak = false
                // Week
                if scheduleTracking[ScheduleVariables.shared.selectedSchedule][7][index0][index1][index2] == false {
                    // Update Full Week
                    scheduleTracking[ScheduleVariables.shared.selectedSchedule][7][index0][index1][index2] = true
                    // Update Day
                    // Loop week
                    for i in 0...6 {
                        // If day isn't empty
                        if schedules[ScheduleVariables.shared.selectedSchedule][0][i].count != 0 {
                            // Loop day
                            for j in 0...schedules[ScheduleVariables.shared.selectedSchedule][0][i].count - 1 {
                                // If correct group and false
                                if schedules[ScheduleVariables.shared.selectedSchedule][0][i][j] as! Int == selectedGroup && scheduleTracking[ScheduleVariables.shared.selectedSchedule][i][j][index1][index2] == false {
                                    scheduleTracking[ScheduleVariables.shared.selectedSchedule][i][j][index1][index2] = true
                                    shouldBreak = true
                                    break
                                }
                            }
                        }
                        if shouldBreak == true {
                            break
                        }
                    }
                } else {
                    // Update Full Week
                    scheduleTracking[ScheduleVariables.shared.selectedSchedule][7][index0][index1][index2] = false
                    // Update Day
                    // Loop week
                    for i in 0...6 {
                        // If day isn't empty
                        if schedules[ScheduleVariables.shared.selectedSchedule][0][i].count != 0 {
                            // Loop day
                            for j in 0...schedules[ScheduleVariables.shared.selectedSchedule][0][i].count - 1 {
                                // If correct group and true
                                if schedules[ScheduleVariables.shared.selectedSchedule][0][i][j] as! Int == selectedGroup && scheduleTracking[ScheduleVariables.shared.selectedSchedule][i][j][index1][index2] == true {
                                    scheduleTracking[ScheduleVariables.shared.selectedSchedule][i][j][index1][index2] = false
                                    shouldBreak = true
                                    break
                                }
                            }
                        }
                        if shouldBreak == true {
                            break
                        }
                    }
                }
            }
            
            // Update tracking array
            UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["scheduleTracking"])
            //
            let indexPathToReload = NSIndexPath(row: row!, section: 0)
            scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
            //
            // Box indicator round todo, done here because userdefaults set above
            if isLastChoice() == true {
                if isGroupCompleted() == true {
                    maskView3.backgroundColor = Colours.colour3
                } else if isGroupCompleted() == false {
                    maskView3.backgroundColor = Colours.colour4
                }
            } else if isLastChoice() == false {
                updateDayIndicatorColours()
            }
        }
    }
    
    
    //
    // MARK: Update Day Indicator colours
    func updateDayIndicatorColours() {
        //
        // If scheduleStyle == day update pageStack, if not do nothing
        if scheduleStyle == 0 {
            for i in 0...Date().currentWeekDayFromMonday - 1 {
                let isCompleted = isDayCompleted(day: i)
                // True, green
                if isCompleted == 0 {
                    (pageStack.arrangedSubviews[i] as! UILabel).textColor = Colours.colour3
                // False, red
                } else if isCompleted == 1 {
                    (pageStack.arrangedSubviews[i] as! UILabel).textColor = Colours.colour4
                // Nothing on day, White
                } else if isCompleted == 2 {
                    (pageStack.arrangedSubviews[i] as! UILabel).textColor = Colours.colour1
                }
            }
        }
    }
    
    // Is day completed
        // 0 == true, 1 == false, 2 == Nothing on the day
    func isDayCompleted(day: Int) -> Int {
        let scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
        var isCompleted = 0
        //
        if scheduleTracking.count != 0 && scheduleTracking[ScheduleVariables.shared.selectedSchedule][day].count != 0 {
            for i in 0...scheduleTracking[ScheduleVariables.shared.selectedSchedule][day].count - 1 {
                if scheduleTracking[ScheduleVariables.shared.selectedSchedule][day][i][0][0] == false {
                    isCompleted = 1
                    break
                }
            }
        } else {
            return 2
        }
        return isCompleted
    }
    
    
    //
    // Should scroll be enabled
    func scheduleTableScrollCheck() {
        let nRows = scheduleTable.numberOfRows(inSection: 0)
        var rowHeight = Int()
        // If first screen of week view, height 49, else 72
        if scheduleStyle == 1 && ScheduleVariables.shared.selectedRows[0] == -1 {
            rowHeight = 49
        } else {
            rowHeight = 72
        }
        let totalRowHeights = CGFloat(nRows * rowHeight)
        //
        let headerHeight = (view.bounds.height - 24.5) / 4
        //
        // Enabled
        if headerHeight + totalRowHeights <= scheduleTable.bounds.maxY {
            scheduleTable.isScrollEnabled = false
        } else {
            scheduleTable.isScrollEnabled = true
        }
    }
    
    
}
