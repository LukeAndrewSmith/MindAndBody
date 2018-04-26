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
        let orderedGroupArray = ["workout", "yoga", "meditation", "endurance", "flexibility"]
        
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
            // Workout
            case 0:
                // Session Choice
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Go to length 1 or length 2 choice
                case 3:
                    //
                    if indicator == "gym" && indicator2 == "classic" {
                        ScheduleVariables.shared.choiceProgress[1] = 4
                        nextChoice()
                    //
                    } else {
                        ScheduleVariables.shared.choiceProgress[1] = 5
                        nextChoice()
                    }
                // Length 1 - Go to final choice
                case 4:
                    ScheduleVariables.shared.choiceProgress[1] = 6
                    nextChoice()
                // Final Choice
                case 6:
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
                // Normal next choice
                default:
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                }
                
            // Yoga
            case 1:
                // Session Choice
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Go to correct length choice
                case 1:
                    switch indicator {
                    case "relaxing":
                        ScheduleVariables.shared.choiceProgress[1] = 2
                        nextChoice()
                    case "neutral":
                        ScheduleVariables.shared.choiceProgress[1] = 3
                        nextChoice()
                    case "stimulating":
                        ScheduleVariables.shared.choiceProgress[1] = 4
                        nextChoice()
                    default: break
                    }
                // Go from length to final choice
                case 2,3:
                    ScheduleVariables.shared.choiceProgress[1] = 5
                    nextChoice()
                // Final Choice
                case 5:
                    // Test
                    // TODO: Selected choice as index to sortedGroups (in data structures)
                    // Warmup
                    if row == 1 {
                        selectWarmup()
                    // Practice
                    } else if row == 2 {
                        selectSession()
                        // Stretching
                    }
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                // Normal next choice
                default:
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                }
                
            // Mind
            case 2:
                // Session Choice
                switch ScheduleVariables.shared.choiceProgress[1] {
                // First choice - yoga, meditation, walk
                case 1:
                    // Go to Meditation screen
                    if row == 1 {
                        // Meditation
                        ScheduleVariables.shared.choiceProgress[1] += 1
                        nextChoice()
                    // Walk, popup
                    } else if row == 2 {
                        ScheduleVariables.shared.selectedRows[1] = 72
                        // TODO: popup for walk
                    }
                // Select meditation style - timer, 'guided'
                case 2:
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
            // Endurance
            case 3:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Type 1, hiit vs steady state
                case 1:
                    // Workout
                    if row == 2 {
                        ScheduleVariables.shared.choiceProgress[1] = 5
                        nextChoice()
                        // Steady state cardio
                    } else if row == 3 {
                        ScheduleVariables.shared.choiceProgress[1] = 7
                        nextChoice()
                    } else {
                        ScheduleVariables.shared.choiceProgress[1] += 1
                        nextChoice()
                    }
                // Go straight to final choice from hiit length
                case 4:
                    ScheduleVariables.shared.choiceProgress[1] = 6
                    nextChoice()
                // Session Choice, To Do
                case 6:
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
                case 7:
                    if row == 2 {
                        endurancePopup()
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
                case 8:
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
            // Flexibility
            case 4:
                // Final choice -> session
                if ScheduleVariables.shared.choiceProgress[1] == 3 {
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
                
            default:
                break
            }
            
            // Check wether to add extra back button
            backToBeginningButtonAddRemove()
        }
    }
    
    // Popup for steady state, saying go for run and press ok when done
    func endurancePopup() {
        //
        // Alert View
        let title = NSLocalizedString("endurancePopupTitle", comment: "")
        let message = NSLocalizedString("endurancePopupMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        //
        // Action
        let okAction = UIAlertAction(title: "Done", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
            //
            // Indexing variables
            // Differ if last choice or first choice
            let indexingVariables = self.getIndexingVariables(row: 2, firstChoice: false, checkLastChoice: false)
            // index0 = selected row in initial choice screen (schedule homescreen selected group) i.e index to group in current day in schedule
            let index0 = indexingVariables.0
            // index1 = Selected row in final choice (i.e warmup, session, stretching)
            let index1 = indexingVariables.1
            //
            let day = indexingVariables.2
            //
            // Update Tracking
            // True/False
            let currentBool = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0][index1] as! Bool
            
            // Update
            schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0][index1] = !currentBool
            // Update Badges
            ReminderNotifications.shared.updateBadges(day: day, currentBool: currentBool)
            
            // Update Week Progress
            if !self.isLastChoice() {
                self.updateWeekProgress(add: !currentBool)
            }
            
            UserDefaults.standard.set(schedules, forKey: "schedules")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
            //
            let indexPathToReload = NSIndexPath(row: 2, section: 0)
            self.scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        //
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        //
        self.present(alert, animated: true, completion: nil)
    }
    
    //
    // MARK: Select sessions
    // Warmup
    func selectWarmup() {
        
        var selectedWarmup: [String] = []
        selectedWarmup.append("warmup")
        
        // Cases for session types
        switch ScheduleVariables.shared.choiceProgress[0] {
        // Workout
        case 0:
            selectedWarmup.append("workout")
        // Yoga, Flexibility (same warmups)
        case 1,4:
            selectedWarmup.append("stretching")
        // Endurance
        case 3:
            selectedWarmup.append("cardio")
        default: break
        }
            
        // No difficulty level for warmup so default is average
        selectedChoiceWarmup[3] = "average"
        
        // Select Random Session
        print(selectedChoiceWarmup)
        let choices = sessionData.sortedSessions[selectedChoiceWarmup[0]]![selectedChoiceWarmup[1]]![selectedChoiceWarmup[2]]![selectedChoiceWarmup[3]]!
        let random = Int(arc4random_uniform(UInt32(choices.count)))
        selectedWarmup.append(choices[random])
        //
        SelectedSession.shared.selectedSession = selectedWarmup
    }
    // Session
    func selectSession() {
        
        var selectedSession: [String] = []
        
        // Cases for session types
        switch ScheduleVariables.shared.choiceProgress[0] {
        // Workout
        case 0:
            selectedSession.append("workout")
            selectedSession.append(selectedChoiceSession[1]) // Workout type
        // Yoga
        case 1:
            selectedSession.append("yoga")
            selectedSession.append(indicator) // relaxing, neutral, stimulating
        // Endurance
        case 3:
            selectedSession.append("cardio")
            selectedSession.append(indicator) // hiit or bodyweight
        // Flexibility
        case 4:
            selectedSession.append("stretching")
            selectedSession.append("general")
        default: break
        }
        
        // Difficulty
        // Get difficulty levels
        let difficultyLevels = UserDefaults.standard.object(forKey: "difficultyLevels") as! [String: [String: Int]]
        let difficultyArray = scheduleDataStructures.difficultyArray
        let group = ScheduleVariables.shared.choiceProgress[0].groupFromInt()
        
        // Cases for session types
        switch ScheduleVariables.shared.choiceProgress[0] {
        // Workout
        case 0:
            switch selectedChoiceSession[1] {
            // Full
            case "classicGymFull", "circuitGymFull", "classicBodyweightFull", "circuitBodyweightFull":
                selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["workout"]!]
            // Upper
            case "classicGymUpper", "circuitGymUpper", "classicBodyweightUpper", "circuitBodyweightUpper":
                selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["workoutUpper"]!]
            // Lower
            case "classicGymLower", "circuitGymLower", "classicBodyweightLower", "circuitBodyweightLower":
                selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["workoutLower"]!]
                
            default: break
            }
        // Yoga
        case 1:
            selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["yoga"]!]
        // Endurance
        case 3:
            // HIIT is not indexed through difficulty, but rather two levels of length (session and interval)
            if indicator == "hiit" {
                break
            } else {
                selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["endurance"]!]
            }
            
        // Flexibility
        case 4:
            switch selectedChoiceSession[1] {
            case "full":
                selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["overall"]!]
            case "hamstrings":
                selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["hamstrings"]!]
            case "hips":
                selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["hips"]!]
            case "backNeck":
                selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["backNeck"]!]
            default: break
            }
        default: break
        }
        
        // Select Random Session
        var randomSessionString = randomSession(selectedChoice: selectedChoiceSession)
        
        // WORKOUT - Checks for Women, and bodyweight pullup bar
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [Int]
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        //
        if ScheduleVariables.shared.choiceProgress[0] == 0 {
            // Women - only applies for gym workouts
            if selectedChoiceSession[1].contains("Gym") {
                // User is a woman
                    // Gender is second question, female or other == 1 or 2 (we give 'other' female workouts for now)
                if profileAnswers[1] > 0 {
                    // Avoid sessions that are for men
                    while randomSessionString.contains("-M") {
                        randomSessionString = randomSession(selectedChoice: selectedChoiceSession)
                    }
                // User is a man
                } else {
                    // Avoid sessions that are for women
                    while randomSessionString.contains("-W") {
                        randomSessionString = randomSession(selectedChoice: selectedChoiceSession)
                    }
                }
                
            // Equipment - only applies for bodyweight workouts
            } else {
                // No equipment (currently just a pullup bar)
                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["pullupBar"] as! Int == 0 {
                    while randomSessionString.contains("-E") {
                        randomSessionString = randomSession(selectedChoice: selectedChoiceSession)
                    }
                }
                // no need for other case, any session goes
            }
        }
            
        selectedSession.append(randomSessionString)
        //
        SelectedSession.shared.selectedSession = selectedSession
    }
    // Stretching (Just for workout & endurance)
    func selectStretching() {
        
        var selectedStretching: [String] = []
        selectedStretching.append("stretching")
        
        // Cases for session types
        switch ScheduleVariables.shared.choiceProgress[0] {
        // Workout
        case 0:
            selectedStretching.append("postWorkout")
        // Endurance
        case 3:
            selectedStretching.append("postCardio")
        default: break
        }
        
        // No difficulty level for warmup so default is average
        selectedChoiceStretching[3] = "average"
        
        // Select Random Session
        var randomSessionString = randomSession(selectedChoice: selectedChoiceStretching)
        // Not foam rolling (if foam rolling on, can include non foam rolling sessions)
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["foamRoller"] as! Int == 0 {
            // NOT Foam rolling (avoid a stretching session that ends in -F)
            while randomSessionString.suffix(2) == "-F" {
                randomSessionString = randomSession(selectedChoice: selectedChoiceStretching)
            }
        } else if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["foamRoller"] as! Int == 1 {
            // Foam rolling (get only stretching session that end in -F)
            while randomSessionString.suffix(2) != "-F" {
                randomSessionString = randomSession(selectedChoice: selectedChoiceStretching)
            }
        }
        selectedStretching.append(randomSessionString)
        //
        SelectedSession.shared.selectedSession = selectedStretching
    }
    //
    func randomSession(selectedChoice: [String]) -> String {
        let choices = sessionData.sortedSessions[selectedChoice[0]]![selectedChoice[1]]![selectedChoice[2]]![selectedChoice[3]]!
        let random = Int(arc4random_uniform(UInt32(choices.count)))
        return choices[random]
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
            // Workout
            case 0:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Gym/Bodyweight
                case 1:
                    // Reset indicator
                    indicator = ""
                    
                    switch row {
                    // Gym
                    case 1:
                        indicator = "gym"
                    // Bodyweight
                    case 2:
                        indicator = "bodyweight"
                    default: break
                    }
                    
                // Circuit/Classic
                case 2:
                    // Reset indicator
                    indicator2 = ""
                    
                    switch row {
                    // Classic
                    case 1:
                        indicator2 = "classic"
                    // Circuit
                    case 2:
                        indicator2 = "circuit"
                    default: break
                    }
                    
                // Focus
                case 3:
                    // Note only session different for now
                    // Gym
                    if indicator == "gym" {
                            // Classic
                        if indicator2 == "classic" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[1] = "WaF"
                                selectedChoiceSession[1] = "classicGymFull"
                                selectedChoiceStretching[1] = "SF"
                            case 2:
                                selectedChoiceWarmup[1] = "WaU"
                                selectedChoiceSession[1] = "classicGymUpper"
                                selectedChoiceStretching[1] = "SU"
                            case 3:
                                selectedChoiceWarmup[1] = "WaL"
                                selectedChoiceSession[1] = "classicGymLower"
                                selectedChoiceStretching[1] = "SL"
                            default: break
                            }
                            // Circuit
                        } else if indicator2 == "circuit" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[1] = "WaF"
                                selectedChoiceSession[1] = "circuitGymFull"
                                selectedChoiceStretching[1] = "SF"
                            case 2:
                                selectedChoiceWarmup[1] = "WaU"
                                selectedChoiceSession[1] = "circuitGymUpper"
                                selectedChoiceStretching[1] = "SU"
                            case 3:
                                selectedChoiceWarmup[1] = "WaL"
                                selectedChoiceSession[1] = "circuitGymLower"
                                selectedChoiceStretching[1] = "SL"
                            default: break
                            }
                        }
                        // Bodyweight
                    } else if indicator == "bodyweight" {
                            // Classic
                        if indicator2 == "classic" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[1] = "WaF"
                                selectedChoiceSession[1] = "classicBodyweightFull"
                                selectedChoiceStretching[1] = "SF"
                            case 2:
                                selectedChoiceWarmup[1] = "WaU"
                                selectedChoiceSession[1] = "classicBodyweightUpper"
                                selectedChoiceStretching[1] = "SU"
                            case 3:
                                selectedChoiceWarmup[1] = "WaL"
                                selectedChoiceSession[1] = "classicBodyweightLower"
                                selectedChoiceStretching[1] = "SL"
                            default: break
                            }
                            // Circuit
                        } else if indicator2 == "circuit" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[1] = "WaF"
                                selectedChoiceSession[1] = "circuitBodyweightFull"
                                selectedChoiceStretching[1] = "SF"
                            case 2:
                                selectedChoiceWarmup[1] = "WaU"
                                selectedChoiceSession[1] = "circuitBodyweightUpper"
                                selectedChoiceStretching[1] = "SU"
                            case 3:
                                selectedChoiceWarmup[1] = "WaL"
                                selectedChoiceSession[1] = "circuitBodyweightLower"
                                selectedChoiceStretching[1] = "SL"
                            default: break
                            }
                        }
                    }
                // Length
                case 4,5:
                    // Note, currently all the same
                    // Gym
                    if indicator == "gym" {
                            // Classic
                        if indicator2 == "classic" {
                            switch row {
                            case 1:
                                selectedChoiceWarmup[2] = "short"
                                selectedChoiceSession[2] = "short"
                                selectedChoiceStretching[2] = "short"
                            case 2:
                                selectedChoiceWarmup[2] = "normal"
                                selectedChoiceSession[2] = "medium"
                                selectedChoiceStretching[2] = "normal"
                            case 3:
                                selectedChoiceWarmup[2] = "normal"
                                selectedChoiceSession[2] = "long"
                                selectedChoiceStretching[2] = "normal"
                            default: break
                            }
                            // Circuit
                        } else if indicator2 == "circuit" {
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
                        }
                        // Bodyweight
                    } else if indicator == "bodyweight" {
                            // Classic
                        if indicator2 == "classic" {
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
                            // Circuit
                        } else if indicator2 == "circuit" {
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
                        }
                    }
                default:
                    break
                }
            
                // ------------------------------------------------------------------------------------------------
            // Yoga
            case 1:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Yoga Type
                case 1:
                    // Reset indicator
                    indicator = ""
                    
                    switch row {
                    // Relaxing
                    case 1:
                        indicator = "relaxing"
                    // Neutral
                    case 2:
                        indicator = "neutral"
                    // Stimulating
                    case 3:
                        indicator = "stimulating"
                    default: break
                    }
                    
                // Length 1 - Relaxing
                case 2:
                    //
                    switch row {
                    case 1:
                        selectedChoiceWarmup[2] = "veryShort"
                        selectedChoiceSession[2] = "veryShort"
                        selectedChoiceStretching[2] = "veryShort"
                    case 2:
                        selectedChoiceWarmup[2] = "short"
                        selectedChoiceSession[2] = "short"
                        selectedChoiceStretching[2] = "short"
                    case 3:
                        selectedChoiceWarmup[2] = "medium"
                        selectedChoiceSession[2] = "medium"
                        selectedChoiceStretching[2] = "medium"
                    case 4:
                        selectedChoiceWarmup[2] = "long"
                        selectedChoiceSession[2] = "long"
                        selectedChoiceStretching[2] = "long"
                    default: break
                    }
                // Length 2 - Neutral
                case 3:
                    //
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
                // Length 3 - Stimulating
                case 4:
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
            // ------------------------------------------------------------------------------------------------
            // Meditation
            case 2:
                // Not necessary
                break
            // ------------------------------------------------------------------------------------------------
            // Endurance
            case 3:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Cardio Type
                case 1:
                    // Reset indication
                    indicator = ""
                    //
                    switch row {
                    case 1:
                        // Indicate to choice 3
                        indicator = "hiit"
                    case 2:
                        indicator = "bodyweight"
                        selectedChoiceWarmup[1] = "warmup"
                        selectedChoiceSession[1] = "bodyweight"
                        selectedChoiceStretching[1] = "stretching"
                    case 3:
                        selectedChoiceWarmup[1] = "warmup"
                        selectedChoiceStretching[1] = "stretching"
                    default: break
                    }
                    //
                // HIIT ?Rowing/Biking/Running or workout length
                case 2:
                    // Cardio Type
                    switch row {
                    // Running
                    case 1:
                        selectedChoiceWarmup[1] = "warmup"
                        selectedChoiceSession[1] = "hiit"
                        selectedChoiceStretching[1] = "stretching"
                    // Biking
                    case 2:
                        selectedChoiceWarmup[1] = "warmup"
                        selectedChoiceSession[1] = "hiit"
                        selectedChoiceStretching[1] = "stretching"
                    // Rowing
                    case 3:
                        selectedChoiceWarmup[1] = "warmup"
                        selectedChoiceSession[1] = "hiit"
                        selectedChoiceStretching[1] = "stretching"
                    default: break
                    }
                // Length: HIIT&Bodyweight
                case 3,5:
                    // HIIT
                    if indicator == "cardio" {
                        switch row {
                        case 1:
                            selectedChoiceWarmup[2] = "short"
                            selectedChoiceSession[2] = "short"
                            selectedChoiceStretching[2] = "short"
                        case 2:
                            selectedChoiceWarmup[2] = "normal"
                            selectedChoiceSession[2] = "medium"
                            selectedChoiceStretching[2] = "normal"
                        case 3:
                            selectedChoiceWarmup[2] = "normal"
                            selectedChoiceSession[2] = "long"
                            selectedChoiceStretching[2] = "normal"
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
                            selectedChoiceWarmup[2] = "normal"
                            selectedChoiceSession[2] = "normal"
                            selectedChoiceStretching[2] = "normal"
                        default: break
                        }
                    }
                    
                // HIIT interval Length
                case 4:
                    // HIIT
                    switch row {
                    case 1:
                        selectedChoiceSession[3] = "short"
                    case 2:
                        selectedChoiceSession[3] = "medium"
                    case 3:
                        selectedChoiceSession[3] = "long"
                    default: break
                        }
                    
                    //
                // Steady State Length
                case 8:
                    switch row {
                    case 1:
                        selectedChoiceWarmup[2] = "short"
                        selectedChoiceStretching[2] = "short"
                    case 2:
                        selectedChoiceWarmup[2] = "normal"
                        selectedChoiceStretching[2] = "normal"
                    default: break
                    }
                default:
                    break
                }
            // ------------------------------------------------------------------------------------------------
            // Flexibility
            case 4:
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Focus
                case 1:
                    // Note warmups the same for now
                    switch row {
                    case 1:
                        selectedChoiceWarmup[1] = "warmup"
                        selectedChoiceSession[1] = "full"
                    case 2:
                        selectedChoiceWarmup[1] = "warmup"
                        selectedChoiceSession[1] = "hamstrings"
                    case 3:
                        selectedChoiceWarmup[1] = "warmup"
                        selectedChoiceSession[1] = "hips"
                    case 4:
                        selectedChoiceWarmup[1] = "warmup"
                        selectedChoiceSession[1] = "backNeck"
                    default: break
                    }
                // Length
                case 2:
                    switch row {
                    case 1:
                        selectedChoiceWarmup[2] = "short"
                        selectedChoiceSession[2] = "short"
                    case 2:
                        selectedChoiceWarmup[2] = "normal"
                        selectedChoiceSession[2] = "normal"
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
        // Workout
        case 0:
            if ScheduleVariables.shared.choiceProgress[1] == 6 {
                return true
            } else {
                return false
            }
        // Yoga
        case 1:
            if ScheduleVariables.shared.choiceProgress[1] == 5 {
                return true
            } else {
                return false
            }
            
        // Meditation
        case 2:
            if ScheduleVariables.shared.choiceProgress[1] == 2 {
                return true
            } else {
                return false
            }
            
        // Endurance
        case 3:
            if ScheduleVariables.shared.choiceProgress[1] == 6 || ScheduleVariables.shared.choiceProgress[1] == 7 {
                return true
            } else {
                return false
            }
            
        // Flexibility
        case 4:
            if ScheduleVariables.shared.choiceProgress[1] == 3 {
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
        // Just checks on part of the group
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
            //selectDay(day: ScheduleVariables.shared.selectedDay)
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
    // Edge pan
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        
        MenuVariables.shared.menuInteractionType = 1

        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .Right)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.performSegue(withIdentifier: "openMenu", sender: nil)
        }
    }
    // Button
    
    
    
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
            
            // if first or last choiec
            if index1 != "notFirstOrLastChoice" {
                // Update Tracking
                // True/False
                let currentBool = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0][index1] as! Bool
                
                // UPDATES
                // Update
                schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0][index1] = !currentBool
                // Update Badges
                ReminderNotifications.shared.updateBadges(day: day, currentBool: currentBool)
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
                
                // Only called if is last choice
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
        // Update Badges
            // currentBool == False as False -> True
        ReminderNotifications.shared.updateBadges(day: day, currentBool: false)
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
        let yCoord = (147 + 49) + 10 + 49 + 10 + 49 + 10
        actionSheetSeparator.frame = CGRect(x: 5, y: yCoord, width: Int(view.bounds.width - 30), height: 1)
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
