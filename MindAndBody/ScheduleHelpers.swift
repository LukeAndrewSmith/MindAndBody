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
    
    // OVERVIEW
    // Main functions
    // didSelectRowHandler:
        // decides what to do upon selection of row, wether it be go to next choice of go to overview screen
        // Also calls selectWarmup, selecteSession selectStretching
    // Update selected choice
        // Selected choice indicates to schedule where in the choice path the user is, i.e at which point he is at when choosing a session
        // This function updates it
    // selectWarmup, selecteSession selectStretching
        // These functions are called just before going to the session overview, they determine which session to present based on the choice pather (selectedChoice), and wether DifferenSessions settings is on, in which case they select a random session of equivalent sessions
    //
    //
    // MARK: Schedule Helper Functions
    func createTemporaryWeekViewArray() {
        
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        // Ensure empty
        TemporaryWeekArray.shared.weekArray = []
        
        // Create array ordered, by first finding and adding all instances of mind, then of flexibility, then of endurance etc...
        let orderedGroupArray = ["mind", "flexibility", "endurance", "toning", "muscleGain", "strength"]
        
        // Loop groups
        for i in 0..<orderedGroupArray.count {
            // Loop week
            for j in 0...6 {
                // If day not empty
                if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j].count != 0 {
                    // Loop day
                    for k in 0..<schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j].count {
                        // If correct group
                        if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![j][k]["group"] as! String == orderedGroupArray[i] {
                            // Create group dict
                            let groupDict: [String: Any] = [
                                "group": orderedGroupArray[i],
                                "day": j,
                                "index": k,
                            ]
                            // Append
                        TemporaryWeekArray.shared.weekArray.append(groupDict)
                        }
                    }
                }
            }
        }
    }
    
    
    //
    // MARK: didSelectRowHandler
    func didSelectRowHandler(row: Int) {
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]

        updateSelectedChoice(row: row)
        // ------------------------------------------------------------------------------------------------
        // Next Choice Function
        if ScheduleVariables.shared.choiceProgress[0] == -1 {
            //
            var groupString = String()
            if scheduleStyle == 0 {
                groupString = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![ScheduleVariables.shared.selectedDay][row]["group"] as! String
            } else {
                groupString = TemporaryWeekArray.shared.weekArray[row]["group"] as! String
            }
            let groupInt = groupString.groupFromString()
            ScheduleVariables.shared.choiceProgress[0] = groupInt
            ScheduleVariables.shared.choiceProgress[1] += 1
            ScheduleVariables.shared.selectedRows[0] = row
            maskView(animated: true)
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
                    
                // Final choice steady state
                case 6:
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
                case 7:
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
                    // Return to final choice without user seeing
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
                if ScheduleVariables.shared.choiceProgress[1] == 5 {
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
        // TODO: SELECT 3
        // Testing so just set to "easy"
        selectedChoiceWarmup[3] = "easy"
        
        //
        SelectedSession.shared.selectedSession = sessionData.sortedSessions[selectedChoiceWarmup[0]]![selectedChoiceWarmup[1]]![selectedChoiceWarmup[2]]![selectedChoiceWarmup[3]]![0]
    }
    // Session
    func selectSession() {
        // TODO: SELECT 3
        // Testing so just set to "easy"
        selectedChoiceSession[3] = "easy"
        
        //
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        // Choose same session each time
        if settings["DifferentSessions"]![0] == 0 {
            SelectedSession.shared.selectedSession = sessionData.sortedSessions[selectedChoiceSession[0]]![selectedChoiceSession[1]]![selectedChoiceSession[2]]![selectedChoiceSession[3]]![0]
        // Choose random session of deemed equivalent sessions
        } else {
            let count = sessionData.sortedSessions[selectedChoiceSession[0]]![selectedChoiceSession[1]]![selectedChoiceSession[2]]![selectedChoiceSession[3]]!.count
            let random = Int(arc4random_uniform(UInt32(count)))
            SelectedSession.shared.selectedSession = sessionData.sortedSessions[selectedChoiceSession[0]]![selectedChoiceSession[1]]![selectedChoiceSession[2]]![selectedChoiceSession[3]]![random]
        }
    }
    // Stretching
    func selectStretching() {
        // TODO: SELECT 3
        // Testing so just set to "easy"
        selectedChoiceStretching[3] = "easy"
        
        //
        SelectedSession.shared.selectedSession = sessionData.sortedSessions[selectedChoiceStretching[0]]![selectedChoiceStretching[1]]![selectedChoiceStretching[2]]![selectedChoiceStretching[3]]![0]
    }
    
    //
    // MARK: Update selected choice
    // Look at both sortedGroups & sortedSessions in dataStructures to understand the following
        // Function for going through choices on the schedule screen, is called when group/choice is pressed and determines what to present next
    func updateSelectedChoice(row: Int) {
        //
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // ------------------------------------------------------------------------------------------------
        if ScheduleVariables.shared.choiceProgress[0] == -1 {
            //
            var groupString = String()
            if scheduleStyle == 0 {
                groupString = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![ScheduleVariables.shared.selectedDay][row]["group"] as! String
            } else {
                groupString = TemporaryWeekArray.shared.weekArray[row]["group"] as! String
            }
            // selectedChoice...[0] to group
            selectedChoiceWarmup[0] = groupString
            selectedChoiceSession[0] = groupString
            // Notes selectedChoiceStretching not always used but set anyway for all, no harm done
            selectedChoiceStretching[0] = groupString
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
                        selectedChoiceWarmup[1] = "warmup"
                    }
                // Focus
                case 2:
                    switch row {
                    case 0:
                        selectedChoiceSession[1] = "calm"
                    case 1:
                        selectedChoiceSession[1] = "stressReduction"
                    case 2:
                        selectedChoiceSession[1] = "strength"
                    case 3:
                        selectedChoiceSession[1] = "energising"
                    case 4:
                        selectedChoiceSession[1] = "focusing"
                    default: break
                    }
                // Length
                case 3:
                    //
                    switch row {
                    case 1:
                        selectedChoiceWarmup[2] = "short"
                        selectedChoiceSession[2] = "short"
                    case 2:
                        selectedChoiceWarmup[2] = "medium"
                        selectedChoiceSession[2] = "medium"
                    case 3:
                        selectedChoiceWarmup[2] = "long"
                        selectedChoiceSession[2] = "long"
                    default: break
                    }

                default:
                    break
                }
                
            // ------------------------------------------------------------------------------------------------
            // Flexibility
            case 1:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Stretching / Yoga
                case 1:
                    // To indicated to the next choice what this choice was
                    indicator = ""
                    switch row {
                    case 1:
                        indicator = "stretching"
                    case 2:
                        indicator = "yoga"
                    default: break
                    }
                // Focus
                case 2:
                    // Note warmups the same for now
                    if indicator == "stretching" {
                        switch row {
                        case 1:
                            selectedChoiceWarmup[1] = "generalWarmup"
                            selectedChoiceSession[1] = "generalStretching"
                        case 2:
                            selectedChoiceWarmup[1] = "hamstringWarmup"
                            selectedChoiceSession[1] = "hamstringStretching"
                        case 3:
                            selectedChoiceWarmup[1] = "hipsWarmup"
                            selectedChoiceSession[1] = "hipsStretching"
                        case 4:
                            selectedChoiceWarmup[1] = "stretching"
                            selectedChoiceSession[1] = "backNeckStretching"
                        default: break
                        }
                    } else {
                        switch row {
                        case 1:
                            selectedChoiceWarmup[1] = "generalWarmup"
                            selectedChoiceSession[1] = "generalYoga"
                        case 2:
                            selectedChoiceWarmup[1] = "hamstringWarmup"
                            selectedChoiceSession[1] = "hamstringYoga"
                        case 3:
                            selectedChoiceWarmup[1] = "hipsWarmup"
                            selectedChoiceSession[1] = "hipsYoga"
                        case 4:
                            selectedChoiceWarmup[1] = "stretching"
                            selectedChoiceSession[1] = "backNeckYoga"
                        default: break
                        }
                    }
                // Length
                case 3:
                    switch row {
                    case 1:
                        selectedChoiceWarmup[2] = "short"
                        selectedChoiceSession[2] = "short"
                    case 2:
                        selectedChoiceWarmup[2] = "medium"
                        selectedChoiceSession[2] = "medium"
                    case 3:
                        selectedChoiceWarmup[2] = "long"
                        selectedChoiceSession[2] = "long"
                    default: break
                    }
                default:
                    break
                }
                //
            // ------------------------------------------------------------------------------------------------
            // Endurance
            case 2:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Cardio Type
                case 1:
                    // Reset indication
                    indicator = ""
                    //
                    switch row {
                    case 1:
                        // Indicate to choice 3
                        indicator = "cardio"
                    case 2:
                        selectedChoiceWarmup[1] = "workoutWarmup"
                        selectedChoiceSession[1] = "workoutSession"
                        selectedChoiceStretching[1] = "workoutStretching"
                    default: break
                    }
                //
                // HIIT Rowing/Biking/Running or workout length
                case 2:
                    // Cardio Type
                    switch row {
                    case 1:
                        selectedChoiceWarmup[1] = "runningWarmup"
                        selectedChoiceSession[1] = "runningSession"
                        selectedChoiceStretching[1] = "runningStretching"
                    case 2:
                        selectedChoiceWarmup[1] = "bikingWarmup"
                        selectedChoiceSession[1] = "bikingSession"
                        selectedChoiceStretching[1] = "bikingStretching"
                    case 3:
                        selectedChoiceWarmup[1] = "rowingWarmup"
                        selectedChoiceSession[1] = "rowingSession"
                        selectedChoiceStretching[1] = "rowingStretching"
                    default: break
                    }
                // HIIT Length
                case 3:
                    // Note currently the same
                    // HIIT
                    if indicator == "cardio" {
                        switch row {
                        case 1:
                            selectedChoiceWarmup[2] = "short"
                            selectedChoiceSession[2] = "short"
                            selectedChoiceStretching[2] = "short"
                        case 2:
                            selectedChoiceWarmup[2] = "medium"
                            selectedChoiceSession[2] = "medium"
                            selectedChoiceStretching[2] = "medium"
                        case 3:
                            selectedChoiceWarmup[2] = "long"
                            selectedChoiceSession[2] = "long"
                            selectedChoiceStretching[2] = "long"
                        default: break
                        }
                    // Workout
                    } else {
                        switch row {
                        case 1:
                            selectedChoiceWarmup[2] = "short"
                            selectedChoiceSession[2] = "short"
                            selectedChoiceStretching[2] = "short"
                        case 2:
                            selectedChoiceWarmup[2] = "medium"
                            selectedChoiceSession[2] = "medium"
                            selectedChoiceStretching[2] = "medium"
                        case 3:
                            selectedChoiceWarmup[2] = "long"
                            selectedChoiceSession[2] = "long"
                            selectedChoiceStretching[2] = "long"
                        default: break
                        }
                    }
                    
                // Steady state type
                case 5:
                    switch row {
                    case 1:
                        selectedChoiceWarmup[1] = "runningWarmup"
                        selectedChoiceStretching[1] = "runningStretching"
                    case 2:
                        selectedChoiceWarmup[1] = "bikingWarmup"
                        selectedChoiceStretching[1] = "bikingStretching"
                    case 3:
                        selectedChoiceWarmup[1] = "rowingWarmup"
                        selectedChoiceStretching[1] = "rowingStretching"
                    default: break
                    }
                //
                // Steady State Length
                case 7:
                    switch row {
                    case 1:
                        selectedChoiceWarmup[2] = "short"
                        selectedChoiceStretching[2] = "short"
                    case 2:
                        selectedChoiceWarmup[2] = "medium"
                        selectedChoiceStretching[2] = "medium"
                    case 3:
                        selectedChoiceWarmup[2] = "long"
                        selectedChoiceStretching[2] = "long"
                    default: break
                    }
                default:
                    break
                }
                // ------------------------------------------------------------------------------------------------
            // Toning
            case 3:
                switch ScheduleVariables.shared.choiceProgress[1] {
                case 1:
                    //
                    switch row {
                    case 2:
                        selectedChoiceWarmup[1] = "cardioWarmup"
                        selectedChoiceSession[1] = "cardioSession"
                        selectedChoiceStretching[1] = "cardioStretching"
                    default: break
                    }
                    
                // Bodyweight Workout
                // Focus
                case 2:
                    // Note warmup and stretching currently the same
                    switch row {
                    case 1:
                        selectedChoiceWarmup[1] = "fullWarmup"
                        selectedChoiceSession[1] = "fullSession"
                        selectedChoiceStretching[1] = "fullStretching"
                    case 2:
                        selectedChoiceWarmup[1] = "upperWarmup"
                        selectedChoiceSession[1] = "upperSession"
                        selectedChoiceStretching[1] = "upperStretching"
                    case 3:
                        selectedChoiceWarmup[1] = "lowerWarmup"
                        selectedChoiceSession[1] = "lowerSession"
                        selectedChoiceStretching[1] = "lowerStretching"
                    default: break
                    }

                // Workout Length
                case 3:
                    switch row {
                    case 1:
                        selectedChoiceWarmup[2] = "short"
                        selectedChoiceSession[2] = "short"
                        selectedChoiceStretching[2] = "short"
                    case 2:
                        selectedChoiceWarmup[2] = "medium"
                        selectedChoiceSession[2] = "medium"
                        selectedChoiceStretching[2] = "medium"
                    case 3:
                        selectedChoiceWarmup[2] = "long"
                        selectedChoiceSession[2] = "long"
                        selectedChoiceStretching[2] = "long"
                    default: break
                    }
                    
                // HIIT Length
                case 5:
                    switch row {
                    case 1:
                        selectedChoiceWarmup[2] = "short"
                        selectedChoiceSession[2] = "short"
                        selectedChoiceStretching[2] = "short"
                    case 2:
                        selectedChoiceWarmup[2] = "medium"
                        selectedChoiceSession[2] = "medium"
                        selectedChoiceStretching[2] = "medium"
                    case 3:
                        selectedChoiceWarmup[2] = "long"
                        selectedChoiceSession[2] = "long"
                        selectedChoiceStretching[2] = "long"
                    default: break
                    }
                    
                default:
                    break
                }
            // ------------------------------------------------------------------------------------------------
            // Muscle Gain
            case 4:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Gym/Bodyweight
                case 1:
                    // Reset indicator
                    indicator = ""

                    switch row {
                    // Circuit
                    case 1:
                        indicator = "gym"
                    // Classic
                    case 2:
                        indicator = "bodyweight"
                    default: break
                    }
                    
                // Circuit/Classic
                case 2:
                    // Reset indicator
                    indicator2 = ""
                    
                    switch row {
                    // Circuit
                    case 1:
                        indicator2 = "circuit"
                    // Classic
                    case 2:
                        indicator2 = "classic"
                    default: break
                    }
                    
                // Focus
                case 3:
                    // Note only session different for now
                    // Gym
                    if indicator == "gym" {
                        // Circuit
                        if indicator2 == "circuit" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[1] = "gymWarmupFull"
                                selectedChoiceSession[1] = "gymSessionFullCircuit"
                                selectedChoiceStretching[1] = "gymStretchingFull"
                            case 2:
                                selectedChoiceWarmup[1] = "gymWarmupUpper"
                                selectedChoiceSession[1] = "gymSessionUpperCircuit"
                                selectedChoiceStretching[1] = "gymStretchingUpper"
                            case 3:
                                selectedChoiceWarmup[1] = "gymWarmupLower"
                                selectedChoiceSession[1] = "gymSessionLowerCircuit"
                                selectedChoiceStretching[1] = "gymStretchingLower"
                            default: break
                            }
                        // Classic
                        } else if indicator2 == "classic" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[1] = "gymWarmupFull"
                                selectedChoiceSession[1] = "gymSessionFullClassic"
                                selectedChoiceStretching[1] = "gymStretchingFull"
                            case 2:
                                selectedChoiceWarmup[1] = "gymWarmupUpper"
                                selectedChoiceSession[1] = "gymSessionUpperClassic"
                                selectedChoiceStretching[1] = "gymStretchingUpper"
                            case 3:
                                selectedChoiceWarmup[1] = "gymWarmupLower"
                                selectedChoiceSession[1] = "gymSessionLowerClassic"
                                selectedChoiceStretching[1] = "gymStretchingLower"
                            default: break
                            }
                        }
                    // Bodyweight
                    } else if indicator == "bodyweight" {
                        // Circuit
                        if indicator2 == "circuit" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[1] = "bodyweightWarmupFull"
                                selectedChoiceSession[1] = "bodyweightSessionFullCircuit"
                                selectedChoiceStretching[1] = "bodyweightStretchingFull"
                            case 2:
                                selectedChoiceWarmup[1] = "bodyweightWarmupUpper"
                                selectedChoiceSession[1] = "bodyweightSessionUpperCircuit"
                                selectedChoiceStretching[1] = "bodyweightStretchingUpper"
                            case 3:
                                selectedChoiceWarmup[1] = "bodyweightWarmupLower"
                                selectedChoiceSession[1] = "bodyweightSessionLowerCircuit"
                                selectedChoiceStretching[1] = "bodyweightStretchingLower"
                            default: break
                            }
                        // Classic
                        } else if indicator2 == "classic" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[1] = "bodyweightWarmupFull"
                                selectedChoiceSession[1] = "bodyweightSessionFullClassic"
                                selectedChoiceStretching[1] = "bodyweightStretchingFull"
                            case 2:
                                selectedChoiceWarmup[1] = "bodyweightWarmupUpper"
                                selectedChoiceSession[1] = "bodyweightSessionUpperClassic"
                                selectedChoiceStretching[1] = "bodyweightStretchingUpper"
                            case 3:
                                selectedChoiceWarmup[1] = "bodyweightWarmupLower"
                                selectedChoiceSession[1] = "bodyweightSessionLowerClassic"
                                selectedChoiceStretching[1] = "bodyweightStretchingLower"
                            default: break
                            }
                        }
                    }
                // Length
                case 4:
                    // Note, currently all the same
                    // Gym
                    if indicator == "gym" {
                        // Circuit
                        if indicator2 == "circuit" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[2] = "short"
                                selectedChoiceSession[2] = "short"
                                selectedChoiceStretching[2] = "short"
                            case 2:
                                selectedChoiceWarmup[2] = "medium"
                                selectedChoiceSession[2] = "medium"
                                selectedChoiceStretching[2] = "medium"
                            case 3:
                                selectedChoiceWarmup[2] = "long"
                                selectedChoiceSession[2] = "long"
                                selectedChoiceStretching[2] = "long"
                            default: break
                            }
                            // Classic
                        } else if indicator2 == "classic" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[2] = "short"
                                selectedChoiceSession[2] = "short"
                                selectedChoiceStretching[2] = "short"
                            case 2:
                                selectedChoiceWarmup[2] = "medium"
                                selectedChoiceSession[2] = "medium"
                                selectedChoiceStretching[2] = "medium"
                            case 3:
                                selectedChoiceWarmup[2] = "long"
                                selectedChoiceSession[2] = "long"
                                selectedChoiceStretching[2] = "long"
                            default: break
                            }
                        }
                        // Bodyweight
                    } else if indicator == "bodyweight" {
                        // Circuit
                        if indicator2 == "circuit" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[2] = "short"
                                selectedChoiceSession[2] = "short"
                                selectedChoiceStretching[2] = "short"
                            case 2:
                                selectedChoiceWarmup[2] = "medium"
                                selectedChoiceSession[2] = "medium"
                                selectedChoiceStretching[2] = "medium"
                            case 3:
                                selectedChoiceWarmup[2] = "long"
                                selectedChoiceSession[2] = "long"
                                selectedChoiceStretching[2] = "long"
                            default: break
                            }
                            // Classic
                        } else if indicator2 == "classic" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[2] = "short"
                                selectedChoiceSession[2] = "short"
                                selectedChoiceStretching[2] = "short"
                            case 2:
                                selectedChoiceWarmup[2] = "medium"
                                selectedChoiceSession[2] = "medium"
                                selectedChoiceStretching[2] = "medium"
                            case 3:
                                selectedChoiceWarmup[2] = "long"
                                selectedChoiceSession[2] = "long"
                                selectedChoiceStretching[2] = "long"
                            default: break
                            }
                        }
                    }
                default:
                     break
                }
                
            // ------------------------------------------------------------------------------------------------
            // Strength
            case 5:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Gym/Bodyweight
                case 1:
                    // Reset indicator
                    indicator = ""
                    
                    switch row {
                    // Circuit
                    case 1:
                        indicator = "gym"
                    // Classic
                    case 2:
                        indicator = "bodyweight"
                    default: break
                    }
                    
                // Focus
                case 2:
                    //
                    // Gym
                    if indicator == "gym" {
                        switch row {
                        case 1:
                            selectedChoiceWarmup[1] = "5x5-1GymWarmup"
                            selectedChoiceSession[1] = "5x5-1GymSession"
                            selectedChoiceStretching[1] = "5x5-1GymStretching"
                        case 2:
                            selectedChoiceWarmup[1] = "5x5-2GymWarmup"
                            selectedChoiceSession[1] = "5x5-1GymSession"
                            selectedChoiceStretching[1] = "5x5-2GymStretching"
                        case 3:
                            selectedChoiceWarmup[1] = "accessory-1GymWarmup"
                            selectedChoiceSession[1] = "accessory-1GymSession"
                            selectedChoiceStretching[1] = "accessory-1GymStretching"
                        case 4:
                            selectedChoiceWarmup[1] = "accessory-2GymWarmup"
                            selectedChoiceSession[1] = "accessory-2GymSession"
                            selectedChoiceStretching[1] = "accessory-2GymStretching"
                        default: break
                        }
                    // Bodyweight
                    } else if indicator == "bodyweight" {
                        switch row {
                        case 1:
                            selectedChoiceWarmup[1] = "5x5-1BodyweightWarmup"
                            selectedChoiceSession[1] = "5x5-1BodyweightSession"
                            selectedChoiceStretching[1] = "5x5-1BodyweightStretching"
                        case 2:
                            selectedChoiceWarmup[1] = "5x5-2BodyweightWarmup"
                            selectedChoiceSession[1] = "5x5-2BodyweightSession"
                            selectedChoiceStretching[1] = "5x5-2BodyweightStretching"
                        case 3:
                            selectedChoiceWarmup[1] = "accessory-1BodyweightWarmup"
                            selectedChoiceSession[1] = "accessory-1BodyweightSession"
                            selectedChoiceStretching[1] = "accessory-1BodyweightStretching"
                        case 4:
                            selectedChoiceWarmup[1] = "accessory-2BodyweightWarmup"
                            selectedChoiceSession[1] = "accessory-2BodyweightSession"
                            selectedChoiceStretching[1] = "accessory-2BodyweightStretching"
                        default: break
                        }
                    }
                    
                // Length
                case 3:
                    //
                    switch row {
                    case 1:
                        selectedChoiceWarmup[2] = "short"
                        selectedChoiceSession[2] = "short"
                        selectedChoiceStretching[2] = "short"
                    case 2:
                        selectedChoiceWarmup[2] = "normal"
                        selectedChoiceSession[2] = "normal"
                        selectedChoiceStretching[2] = "normal"
                    default: break
                    }
                    
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
            if ScheduleVariables.shared.choiceProgress[1] == 4 || ScheduleVariables.shared.choiceProgress[1] == 6 {
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
            if ScheduleVariables.shared.choiceProgress[1] == 5 {
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
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        // Indexing variables
        // Differ if last choice or first choice
        let indexingVariables = getIndexingVariables(row: row, firstChoice: false, checkLastChoice: false)
        // index0 = selected row in initial choice screen (schedule homescreen selected group) i.e index to group in current day in schedule
        let index0 = indexingVariables.0
        // index1 = Selected row in final choice (i.e warmup, session, stretching)
        let index1 = indexingVariables.1
        //
        let day = indexingVariables.2
        
        // Return bool
        if index1 != "notFirstOrLastChoice" {
            return schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0][index1] as! Bool
        } else {
            return false
        }
    }
    
    // Is group completed
    func isGroupCompleted(checkAll: Bool) -> Bool {
        
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        //
        // Check if group is completed
        let nRows = scheduleTable.numberOfRows(inSection: 0)
        var isCompleted = true
        //
        var day = Int()
        if scheduleStyle == 0 {
            day = ScheduleVariables.shared.selectedDay
        } else {
            day = TemporaryWeekArray.shared.weekArray[ScheduleVariables.shared.selectedRows[0]]["day"] as! Int
        }
        // Loop second array in scheduleTracking, if one if false, not completed (warmup/session/stretching)
            // -2 because title included
        if checkAll {
            for i in 0...nRows - 2 {
                if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][ScheduleVariables.shared.selectedRows[0]][String(i)] as! Bool == false {
                    isCompleted = false
                    break
                }
            }
        } else {
            return schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][ScheduleVariables.shared.selectedRows[0]]["isGroupCompleted"] as! Bool
        }
        //
        return isCompleted
    }
    
    //
    // MARK: Choice Functions
    func nextChoice() {
        //
        // Mask View
        maskView(animated: true)
        // Next Table info
        slideLeft()
        //
        if isLastChoice() {
            if isGroupCompleted(checkAll: true) {
                maskView3.backgroundColor = Colors.green
            } else {
                maskView3.backgroundColor = Colors.red
            }
        }
    }
    
    
    
    //
    // Navigation through days ---------------------------------------------------------------------------------------------------------------------
    //
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        // Determine wether the swipe should be enabled
            // Only should be enabled if schedule style is day view, or if swiping back from choices
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        var shouldBeEnabled = true
        if schedules.count != 0 {
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int == 1 {
                shouldBeEnabled = false
            }
        }
        //
        if ScheduleVariables.shared.choiceProgress[0] == -1 && shouldBeEnabled {
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
                    stackArray[i].font = UIFont(name: "SFUIDisplay-thin", size: 17)
                }
                // Select indicator
                stackArray[ScheduleVariables.shared.selectedDay].font = UIFont(name: "SFUIDisplay-light", size: 17)
                animateDayIndicatorToDay()
                
                // Animate
                //
                // Snapshot before update
                let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
                view.addSubview(snapShot1!)
                view.bringSubview(toFront: snapShot1!)
                //
                // Snapshot after update
                scheduleTable.reloadData()
                let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
                snapShot2?.center.x = view.center.x + self.view.frame.size.width
                view.addSubview(snapShot2!)
                view.bringSubview(toFront: snapShot2!)
                //
                scheduleTable.isHidden = true
                //
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
                    snapShot2?.center.x = self.view.center.x
                }, completion: { finish in
                    self.scheduleTable.isHidden = false
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
                    stackArray[i].font = UIFont(name: "SFUIDisplay-thin", size: 17)
                }
                // Select indicator
                stackArray[ScheduleVariables.shared.selectedDay].font = UIFont(name: "SFUIDisplay-light", size: 17)
                selectDay(day: ScheduleVariables.shared.selectedDay)
                animateDayIndicatorToDay()
                
                // Animate
                //
                // Snapshot before update
                let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
                view.addSubview(snapShot1!)
                view.bringSubview(toFront: snapShot1!)
                //
                // Snapshot after update
                scheduleTable.reloadData()
                let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
                snapShot2?.center.x = view.center.x - self.view.frame.size.width
                view.addSubview(snapShot2!)
                view.bringSubview(toFront: snapShot2!)
                //
                scheduleTable.isHidden = true
                //
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
                    snapShot2?.center.x = self.view.center.x
                }, completion: { finish in
                    self.scheduleTable.isHidden = false
                    snapShot1?.removeFromSuperview()
                    snapShot2?.removeFromSuperview()
                })
                
            }
        } else if ScheduleVariables.shared.choiceProgress[0] != -1 {
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
                stackArray[i].font = UIFont(name: "SFUIDisplay-thin", size: 17)
            }
            // Select indicator
            stackArray[ScheduleVariables.shared.selectedDay].font = UIFont(name: "SFUIDisplay-light", size: 17)
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
                stackArray[i].font = UIFont(name: "SFUIDisplay-thin", size: 17)
            }
            // Select indicator
            stackArray[ScheduleVariables.shared.selectedDay].font = UIFont(name: "SFUIDisplay-light", size: 17)
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
    // Function return the index within the day of the gorup, and the index within the group to track
    // Takes as parameters
        // row = the selected row/row to update
        // firstChoice, indicates that we might want the indexing of the first choice but that it is not == -1, i.e if you hold down the group to mark as completed is sets the first choice
        // checkLastChoice, very specific case, if updating the other schedules, then the first choice will be set, so we need to set is firstChoice to true, but we might be updating the last choice so need an extra check
        func getIndexingVariables(row: Int, firstChoice: Bool, checkLastChoice: Bool) -> (Int, String, Int) {
        // Indexing variables
        // Differ if last choice or first choice
        // index0 = selected row in initial choice screen (schedule homescreen selected group) i.e index to group in current day in schedule
        var index0 = Int()
        // index1 = Selected row in final choice (i.e warmup, session, stretching)
        var index1 = String()
        //
        var selectedDay = Int()
        
        // If first choice
            // if only want first choice then firstChoice && !checkLastChoice
            // if perhaps first choice, then  firstChoice && checkLastChoice && !isLastChoice()
            // if normal check ScheduleVariables.shared.choiceProgress[0] == -1
        if firstChoice && !checkLastChoice || firstChoice && checkLastChoice && !isLastChoice() || ScheduleVariables.shared.choiceProgress[0] == -1 {
            // Day view - index is simply row
            if scheduleStyle == 0 {
                index0 = row
                selectedDay = ScheduleVariables.shared.selectedDay
                // Week view -  find stored index to schedule week using temporary full week array
            } else {
                index0 = TemporaryWeekArray.shared.weekArray[row]["index"] as! Int
                selectedDay = TemporaryWeekArray.shared.weekArray[row]["day"] as! Int
            }
            index1 = "isGroupCompleted"
            // If last choice
        } else if isLastChoice() && row != 0 {
            // Day view - index is simply row
            if scheduleStyle == 0 {
                index0 = ScheduleVariables.shared.selectedRows[0]
                selectedDay = ScheduleVariables.shared.selectedDay
                // Week view -  find stored index to schedule week using temporary full week array
            } else {
                index0 = TemporaryWeekArray.shared.weekArray[ScheduleVariables.shared.selectedRows[0]]["index"] as! Int
                selectedDay = TemporaryWeekArray.shared.weekArray[ScheduleVariables.shared.selectedRows[0]]["day"] as! Int
            }
            // -1 as title included in table so offset by 1
            index1 = String(row - 1)
        } else {
            index1 = "notFirstOrLastChoice"
        }
        return (index0, index1, selectedDay)
    }
    
    //
    // MARK: Mark as completed
        // Handler for the long touch on the cell, the user can mark as completed themselves
        // Also marks as incomplete if previously comleted, note: rename
    @IBAction func markAsCompleted(_ sender: UILongPressGestureRecognizer) {
        //
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        //

        if sender.state == UIGestureRecognizerState.began {
            // Get Cell
            let cell = sender.view
            let row = cell?.tag
            
            // indicate to reset first choice
            var shouldResetSelectedRows = false
            // Set selected row to ScheduleVariables.shared.selectedRow[0]
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                ScheduleVariables.shared.selectedRows[0] = row!
                shouldResetSelectedRows = true
            }
            
            // Indexing variables
                // Differ if last choice or first choice
            let indexingVariables = getIndexingVariables(row: row!, firstChoice: false, checkLastChoice: false)
            // index0 = selected row in initial choice screen (schedule homescreen selected group) i.e index to group in current day in schedule
            let index0 = indexingVariables.0
            // index1 = Selected row in final choice (i.e warmup, session, stretching)
            let index1 = indexingVariables.1
            //
            let day = indexingVariables.2
            
            if index1 != "notFirstOrLastChoice" {
                // Update Tracking
                // True/False
                let currentBool = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0][index1] as! Bool
                
                // Update
                schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0][index1] = !currentBool
                
                // Update Week Progress
                if !isLastChoice() {
                    updateWeekProgress(add: !currentBool)
                }
                
                UserDefaults.standard.set(schedules, forKey: "schedules")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
                //
                let indexPathToReload = NSIndexPath(row: row!, section: 0)
                scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
                
                //
                // Box indicator round todo, done here because userdefaults set above && check if full group needs to be completed
                var shouldUpdateArraysAgain = false
                if isLastChoice() {
                    if isGroupCompleted(checkAll: true) {
                        maskView3.backgroundColor = Colors.green
                        //
                        if !isGroupCompleted(checkAll: false) {
                            schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0]["isGroupCompleted"] = true
                            shouldUpdateArraysAgain = true
                        }
                    } else {
                        maskView3.backgroundColor = Colors.red
                        //
                        if isGroupCompleted(checkAll: false) {
                            schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0]["isGroupCompleted"] = false
                            shouldUpdateArraysAgain = true
                        }
                    }
                } else {
                    updateDayIndicatorColours()
                }
                
                if shouldUpdateArraysAgain {
                    UserDefaults.standard.set(schedules, forKey: "schedules")
                    // Sync
                    ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
                }
                
                //
                // Mark first instance of group in all other schedules as completed- called after to avoid conflicts storing to userdefaults
                if isGroupCompleted(checkAll: false) {
                    markAsGroupForOtherSchedules(markAs: !currentBool)
                }
                
                // Reset first choice to -1 to indicate still on schedule home screen
                if shouldResetSelectedRows {
                    ScheduleVariables.shared.choiceProgress[0] = -1
                }
            } else {
                let indexPathToReload = NSIndexPath(row: row!, section: 0)
                scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
            }
        }
    }
    
    // MARK: Mark other schedules as completed
        // Only called if full group completed
    func markAsGroupForOtherSchedules(markAs: Bool) {
        //
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        //
        // Indexing variables
        // Differ if last choice or first choice
        let row = ScheduleVariables.shared.selectedRows[0]
        let indexingVariables = getIndexingVariables(row: row, firstChoice: true, checkLastChoice: false)
        // index0 = selected row in initial choice screen (schedule homescreen selected group) i.e index to group in current day in schedule
        let index0 = indexingVariables.0
        // index1 = Selected row in final choice (i.e warmup, session, stretching)
        let index1 = indexingVariables.1
        //
        let day = indexingVariables.2
        
        // Get selected group
        var selectedGroup = String()
        // Day View
        selectedGroup = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0]["group"] as! String
        
        // Mark first instance of group in all other schedules as completed
        if schedules.count != 0 {
            // Loop Schedules
            for i in 0...schedules.count - 1 {
                // If not currentlu selected schedule, currently selected schedule handled in viewdidappear of scheduescreen
                if i != ScheduleVariables.shared.selectedSchedule {
                    // Loop days
                    var shouldBreak = false
                    // Update Day
                    // Loop week
                    for j in 0...6 {
                        // If day isn't empty
                        if schedules[i]["schedule"]![j].count != 0 {
                            // Loop day
                            for k in 0...schedules[i]["schedule"]![j].count - 1 {
                                // If correct group and false
                                if schedules[i]["schedule"]![j][k]["group"] as! String == selectedGroup && schedules[i]["schedule"]![j][k][index1] as! Bool == !markAs {
                                    schedules[i]["schedule"]![j][k][index1] = markAs
                                    shouldBreak = true
                                    break
                                }
                            }
                        }
                        if shouldBreak {
                            break
                        }
                    }
                }
            }
        }
        
        // Update
        UserDefaults.standard.set(schedules, forKey: "schedules")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
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
                    (pageStack.arrangedSubviews[i] as! UILabel).textColor = Colors.green
                // False, red
                } else if isCompleted == 1 {
                    (pageStack.arrangedSubviews[i] as! UILabel).textColor = Colors.red
                // Nothing on day, White
                } else if isCompleted == 2 {
                    (pageStack.arrangedSubviews[i] as! UILabel).textColor = Colors.light
                }
            }
        }
    }
    
    // Is day completed
        // 0 == true, 1 == false, 2 == Nothing on the day
    func isDayCompleted(day: Int) -> Int {
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        var isCompleted = 0
        // If not empty
        if schedules.count != 0 && schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day].count != 0 {
            // Loop day
            for i in 0..<schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day].count {
                if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][i]["isGroupCompleted"] as! Bool
                    == false {
                    // 1 == false
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
    
    // MARK: - Reload Functions
    // MARK: Reload Choice
        // shouldReloadChoice
    func markAsCompletedAndAnimate() {
        // MARK AS COMPLETED
        if ScheduleVariables.shared.shouldReloadChoice && ScheduleVariables.shared.selectedRows[1] != 72 {
            //
            DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                // Reload the finalChoiceScreen Session after a delay
                let indexPathToReload = NSIndexPath(row: ScheduleVariables.shared.selectedRows[1] + 1, section: 0)
                self.scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
                self.scheduleTable.selectRow(at: indexPathToReload as IndexPath, animated: true, scrollPosition: .none)
                self.scheduleTable.deselectRow(at: indexPathToReload as IndexPath, animated: true)
                //
                // Check if group is completed for the day
                if self.isGroupCompleted(checkAll: true) {
                    // Update schedule tracking
                    self.updateGroupTracking()
                    //
                    UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                        self.maskView3.backgroundColor = Colors.green
                        // Slide back to initial choice when completed
                    }, completion: { finished in
                        DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                            ScheduleVariables.shared.choiceProgress[1] = 1
                            self.maskAction()
                            // Set to false here so the tick doesn;t get loaded before the view has appeared
                            ScheduleVariables.shared.shouldReloadChoice = false
                            // Animate initial choice group completion after slideRight() animation finished
                            let toAdd = AnimationTimes.animationTime1 + AnimationTimes.animationTime2
                            DispatchQueue.main.asyncAfter(deadline: .now() + toAdd, execute: {
                                let indexPathToReload2 = NSIndexPath(row: ScheduleVariables.shared.selectedRows[0], section: 0)
                                self.scheduleTable.reloadRows(at: [indexPathToReload2 as IndexPath], with: .automatic)
                                self.scheduleTable.selectRow(at: indexPathToReload2 as IndexPath, animated: true, scrollPosition: .none)
                                self.scheduleTable.deselectRow(at: indexPathToReload2 as IndexPath, animated: true)
                            })
                        })
                    })
                }
            })
        // Meditation/Walk
        } else if ScheduleVariables.shared.shouldReloadChoice && ScheduleVariables.shared.selectedRows[1] == 72 {
            //
            // Go to initial choice
            ScheduleVariables.shared.choiceProgress[1] = 1
            maskAction()
            //
            updateGroupTracking()
            // Mark first instance of group in all other schedules as completed
            markAsGroupForOtherSchedules(markAs: true)
            // Set to false here so the tick doesn't get loaded before the view has appeared
            ScheduleVariables.shared.shouldReloadChoice = false
            // Animate initial choice group completion after slideRight() animation finished
            let toAdd = AnimationTimes.animationTime1 + AnimationTimes.animationTime2
            DispatchQueue.main.asyncAfter(deadline: .now() + toAdd, execute: {
                let indexPathToReload2 = NSIndexPath(row: ScheduleVariables.shared.selectedRows[0], section: 0)
                self.scheduleTable.reloadRows(at: [indexPathToReload2 as IndexPath], with: .automatic)
                self.scheduleTable.selectRow(at: indexPathToReload2 as IndexPath, animated: true, scrollPosition: .none)
                self.scheduleTable.deselectRow(at: indexPathToReload2 as IndexPath, animated: true)
            })
            updateDayIndicatorColours()
        }
    }
    
    // Only called for updaing full group, i.e group is completed
    func updateGroupTracking() {
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        // Indexing variables
        // Differ if last choice or first choice
        let row = ScheduleVariables.shared.selectedRows[0]
        let indexingVariables = getIndexingVariables(row: row, firstChoice: true, checkLastChoice: false)
        // index0 = selected row in initial choice screen (schedule homescreen selected group) i.e index to group in current day in schedule
        let index0 = indexingVariables.0
        // index1 = Selected row in final choice (i.e warmup, session, stretching)
        let index1 = indexingVariables.1
        //
        let day = indexingVariables.2
        
        // Update
        schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0][index1] = true
        // Update Week Progress
        updateWeekProgress(add: true)

        UserDefaults.standard.set(schedules, forKey: "schedules")
        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
        
        // Mark first instance of group in all other schedules as completed
        if isGroupCompleted(checkAll: true) {
            markAsGroupForOtherSchedules(markAs: true)
        }
        //
        updateDayIndicatorColours()
    }
    
    // MARK: Reload View
        // shouldReloadSchedule
    func reloadView() {
        // RELOAD VIEW
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        if ScheduleVariables.shared.shouldReloadSchedule {
            //
            ScheduleVariables.shared.shouldReloadSchedule = false
            // Set ScheduleVariables.shared.selectedSchedule to last schedule if too high
            var selectedSchedule = UserDefaults.standard.integer(forKey: "selectedSchedule")
            if ScheduleVariables.shared.selectedSchedule > schedules.count - 1 {
                if schedules.count == 0 || selectedSchedule == 0 {
                    selectedSchedule = 0
                } else {
                    selectedSchedule = schedules.count - 1
                }
                UserDefaults.standard.set(selectedSchedule, forKey: "selectedSchedule")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["selectedSchedule"])
            }
            ScheduleVariables.shared.selectedSchedule = selectedSchedule
            //
            if schedules.count != 0 {
                scheduleStyle = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int
            } else {
                scheduleStyle = 0
            }
            //
            layoutViews()
            //
            scheduleTable.reloadData()
            scheduleChoiceTable.reloadData()
            //
            scheduleTableScrollCheck()
        }
    }
    
    // MARK: Subscriptions
    // Upon completion of check subscription, perform action
    @objc func subscriptionCheckCompleted() {
        Loading.shared.shouldPresentLoading = false
        Loading.shared.endLoading()
        if !SubscriptionsCheck.shared.isValid {
            self.performSegue(withIdentifier: "SubscriptionsSegue", sender: self)
        }
    }
    
    // MARK: View Setup/Layout
    func setupViews() {
        // Set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
        //
        // Present schedule walkthrough
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["Schedule"] == false {
            walkthroughSchedule()
        }
        
        // table    // buttons // spaces
        // Schedule choice
        scheduleChoiceTable.backgroundColor = Colors.dark
        scheduleChoiceTable.delegate = self
        scheduleChoiceTable.dataSource = self
        scheduleChoiceTable.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 20, height: 147 + 49)
        scheduleChoiceTable.tableFooterView = UIView()
        scheduleChoiceTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scheduleChoiceTable.layer.cornerRadius = 15
        scheduleChoiceTable.clipsToBounds = true
        scheduleChoiceTable.layer.borderWidth = 1
        scheduleChoiceTable.layer.borderColor = Colors.light.cgColor
        // Edit schedule
        editScheduleButton.addTarget(self, action: #selector(editScheduleAction), for: .touchUpInside)
        editScheduleButton.setTitle(NSLocalizedString("editSchedule", comment: ""), for: .normal)
        editScheduleButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        editScheduleButton.frame = CGRect(x: 0, y: (147 + 49) + 10, width: view.bounds.width - 20, height: 49)
        editScheduleButton.layer.cornerRadius = 49 / 2
        editScheduleButton.clipsToBounds = true
        editScheduleButton.setTitleColor(Colors.dark, for: .normal)
        editScheduleButton.backgroundColor = Colors.light
        editScheduleButton.setImage(#imageLiteral(resourceName: "Calendar"), for: .normal)
        editScheduleButton.tintColor = Colors.dark
        // Edit profile
        editProfileButton.addTarget(self, action: #selector(editProfileAction), for: .touchUpInside)
        editProfileButton.setTitle(NSLocalizedString("editProfile", comment: ""), for: .normal)
        editProfileButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        editProfileButton.frame = CGRect(x: 0, y: (147 + 49) + 10 + 49 + 10, width: view.bounds.width - 20, height: 49)
        editProfileButton.layer.cornerRadius = 49 / 2
        editProfileButton.clipsToBounds = true
        editProfileButton.setTitleColor(Colors.dark, for: .normal)
        editProfileButton.backgroundColor = Colors.light
        editProfileButton.setImage(#imageLiteral(resourceName: "Profile"), for: .normal)
        editProfileButton.tintColor = Colors.dark
        //
        actionSheetSeparator.backgroundColor = Colors.light.withAlphaComponent(0.25)
        actionSheetSeparator.frame = CGRect(x: 5, y: (147 + 49) + 10 + 49 + 10 + 49 + 10, width: view.bounds.width - 30, height: 1)
        actionSheetSeparator.layer.cornerRadius = 0.25
        actionSheetSeparator.clipsToBounds = true
        
        //
        addBackgroundImage(withBlur: true, fullScreen: false)
        
        //
        // Navigation Bar
        self.navigationController?.navigationBar.barTintColor = Colors.dark
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        // Navigation Title
        navigationBar.title = NSLocalizedString("Mind & Body", comment: "")
        
        //
        // TableView
        scheduleTable.backgroundView = UIView()
        scheduleTable.backgroundColor = .clear
        scheduleTable.tableFooterView = UIView()
        scheduleTable.separatorStyle = .none
        // Tableview top view
        let topView = UIVisualEffectView()
        let topViewE = UIBlurEffect(style: .dark)
        topView.effect = topViewE
        topView.isUserInteractionEnabled = false
        //
        topView.frame = CGRect(x: 0, y: scheduleTable.frame.minY - scheduleTable.bounds.height, width: scheduleTable.bounds.width, height: scheduleTable.bounds.height)
        //
        scheduleTable.addSubview(topView)
        
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
    }
    
    // Layout views
    func layoutViews() {
        //
        // Present as days or as week
        // days
        if scheduleStyle == 0 {
            scheduleTableBottom.constant = 24.5
            pageStack.isUserInteractionEnabled = true
            // week
        } else if scheduleStyle == 1 {
            scheduleTableBottom.constant = 0
            pageStack.isUserInteractionEnabled = false
        }
        
        // Day indicator
        if scheduleStyle == 0 {
            dayIndicator.alpha = 0.72
        } else {
            dayIndicator.alpha = 0
        }
        
        // Set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
                
        //
        // Custom 'Page Control' m,t,w,t,f,s,s for bottom
        // If week is being presented as days, style 1
        if scheduleStyle == 0 && pageStack.arrangedSubviews.count == 0 {
            
            for i in 0...(dayArray.count - 1) {
                let dayLabel = UILabel()
                dayLabel.textColor = Colors.light
                dayLabel.textAlignment = .center
                dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 17)
                dayLabel.text = NSLocalizedString(dayArrayChar[i], comment: "")
                dayLabel.sizeToFit()
                dayLabel.tag = i
                //
                let dayTap = UITapGestureRecognizer()
                dayTap.numberOfTapsRequired = 1
                dayTap.addTarget(self, action: #selector(dayTapHandler))
                dayLabel.isUserInteractionEnabled = true
                dayLabel.addGestureRecognizer(dayTap)
                stackArray.append(dayLabel)
            }
            for i in 0...stackArray.count - 1 {
                pageStack.addArrangedSubview(stackArray[i])
            }
            pageStack.isUserInteractionEnabled = true
            //
        }
        //
        // Day Swipes (also used for swipe back in choices)
        daySwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        daySwipeLeft.direction = UISwipeGestureRecognizerDirection.left
        scheduleTable.addGestureRecognizer(daySwipeLeft)
        //
        daySwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        daySwipeRight.direction = UISwipeGestureRecognizerDirection.right
        scheduleTable.addGestureRecognizer(daySwipeRight)
        //
        
        //
        // Select Today
        // Get current day as index, currentWeekDay - 1 as week starts at 0 in array
        if scheduleStyle == 0 {
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                ScheduleVariables.shared.selectedDay = Date().currentWeekDayFromMonday - 1
                stackArray[ScheduleVariables.shared.selectedDay].font = UIFont(name: "SFUIDisplay-light", size: 17)
                dayIndicatorLeading.constant = stackArray[ScheduleVariables.shared.selectedDay].frame.minX
                self.view.layoutIfNeeded()
            } else {
                stackArray[ScheduleVariables.shared.selectedDay].font = UIFont(name: "SFUIDisplay-thin", size: 17)
                dayIndicatorLeading.constant = stackArray[ScheduleVariables.shared.selectedDay].frame.minX
                self.pageStack.layoutIfNeeded()
                maskView(animated: false)
            }
        } else {
            // 7 is the full week array
            ScheduleVariables.shared.selectedDay = 7
            maskView(animated: false)
        }
        
        //
        dayIndicator.frame.size = CGSize(width: view.bounds.width / 7, height: 1)
        dayIndicator.backgroundColor = Colors.light.withAlphaComponent(0.5)
        if scheduleStyle == 0 {
            view.addSubview(dayIndicator)
            view.bringSubview(toFront: dayIndicator)
        }
        
        //
        updateDayIndicatorColours()
        
        //
        scheduleTableScrollCheck()
    }
    
    func setScheduleStyle() {
        // Check wether to present the schedule as :
        // Days
        // The whole week
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        if schedules.count != 0 {
            scheduleStyle = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int
        } else {
            scheduleStyle = 0
        }
    }
}
