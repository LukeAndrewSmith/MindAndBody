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
    
    
    //
    // MARK: didSelectRowHandler
    func didSelectRowHandler(row: Int) {
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        updateSelectedChoice(row: row)
        // ------------------------------------------------------------------------------------------------
        // Next Choice Function
        if ScheduleVariables.shared.choiceProgress[0] == -1 {
            
            // Extra Session
            if row == 723 {
                ScheduleVariables.shared.isExtraSession = true
                ScheduleVariables.shared.extraSessionCompletion = [false, false, false]
                ScheduleVariables.shared.choiceProgress[0] = 723
                ScheduleVariables.shared.choiceProgress[1] += 1
                ScheduleVariables.shared.selectedRows[0] = row
                maskView(animated: true)
                // Next Table info
                slideLeft()
            // Normal Session
            } else {
                ScheduleVariables.shared.isExtraSession = false
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
            }
            
        //
        } else {
            // Present next choice or present session
            switch ScheduleVariables.shared.choiceProgress[0] {
                // ------------------------------------------------------------------------------------------------
            // Workout
            case 0:
                // Session Choice
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Custom
                case 1:
                    // Custom
                    if row == 3 {
                        ScheduleVariables.shared.choiceProgress[1] = 7
                        nextChoice()
                    } else {
                        ScheduleVariables.shared.choiceProgress[1] += 1
                        nextChoice()
                    }
                // Go to length 1 or length 2 choice
                case 3:
                    //
                    if ScheduleVariables.shared.indicator == "gym" && ScheduleVariables.shared.indicator2 == "classic" {
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
                    // Warmup
                    if row == 1 {
                        selectedComponent = 0
                        selectWarmup()
                        // Session
                    } else if row == 2 {
                        selectedComponent = 1
                        selectSession()
                        // Stretching
                    } else if row == 3 {
                        selectedComponent = 2
                        selectStretching()
                    }
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performScheduleSegue()
                // Custom Choice
                case 7:
                    // Indicate selected row
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    
                    var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                    // If app chooses warmup/stretching
                    if settings["CustomWarmupStretching"]![0] == 0 {
                        // Warmup
                        if row == 1 {
                            selectedComponent = 0
                            selectWarmup()
                            performScheduleSegue()
                            // Session
                        } else if row == 2 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "workout"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                            // Stretching
                        } else if row == 3 {
                            selectedComponent = 2
                            selectStretching()
                            performScheduleSegue()
                        }
                    // If custom warmup/stretching
                    } else if settings["CustomWarmupStretching"]![0] == 1 {
                        // Warmup
                        if row == 1 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "warmup"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        // Session
                        } else if row == 2 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "workout"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        // Stretching
                        } else if row == 3 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "stretching"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        }
                    }
                    // }
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
                    switch ScheduleVariables.shared.indicator {
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
                    // Custom
                    if row == 4 {
                        ScheduleVariables.shared.choiceProgress[1] = 6
                        nextChoice()
                    }
                // Go from length to final choice
                case 2,3:
                    ScheduleVariables.shared.choiceProgress[1] = 5
                    nextChoice()
                // Final Choice
                case 5:
                    // Warmup
                    if row == 1 {
                        selectedComponent = 0
                        selectWarmup()
                    // Practice
                    } else if row == 2 {
                        selectedComponent = 1
                        selectSession()
                        // Stretching
                    }
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performScheduleSegue()
                // Custom
                case 6:
                    // Indicate selected row
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    
                    var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                    // If app chooses warmup/stretching
                    if settings["CustomWarmupStretching"]![0] == 0 {
                        // Warmup
                        if row == 1 {
                            selectedComponent = 0
                            selectWarmup()
                            ScheduleVariables.shared.selectedRows[1] = row - 1
                            performScheduleSegue()
                            // Practice
                        } else if row == 2 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "yoga"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        }
                    // If custom warmup/stretching
                    } else if settings["CustomWarmupStretching"]![0] == 1 {
                        // Warmup
                        if row == 1 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "warmup"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        // Practice
                        } else if row == 2 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "yoga"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        }
                    }

                // Normal next choice
                default:
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                }
                
            // Meditation
            case 2:
                // Session Choice
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Select meditation style - timer, 'guided'
                case 1:
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
                    // HIIT
                    if row == 1 {
                        ScheduleVariables.shared.choiceProgress[1] += 1
                        nextChoice()
                    // Workout
                    } else if row == 2 {
                        ScheduleVariables.shared.choiceProgress[1] = 5
                        nextChoice()
                        // Steady state cardio
                    } else if row == 3 {
                        ScheduleVariables.shared.choiceProgress[1] = 7
                        nextChoice()
                    // Custom
                    } else if row == 4 {
                        ScheduleVariables.shared.choiceProgress[1] = 9
                        nextChoice()
                    }
                // Go straight to final choice from hiit length
                case 4:
                    ScheduleVariables.shared.choiceProgress[1] = 6
                    nextChoice()
                // Session Choice, To Do
                case 6:
                    // Warmup
                    if row == 1 {
                        selectedComponent = 0
                        selectWarmup()
                        // Session
                    } else if row == 2 {
                        selectedComponent = 1
                        selectSession()
                        // Stretching
                    } else if row == 3 {
                        selectedComponent = 2
                        selectStretching()
                    }
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performScheduleSegue()
                    
                // Final choice steady state
                case 7:
                    // Select now as this choice is final choice (even if you choose the length afterwards)
                    ScheduleVariables.shared.selectedRows[1] = row - 1
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
                    // Warmup
                    if steadyStateChoice == 0 {
                        selectedComponent = 0
                        selectWarmup()
                        // Stretching
                    } else if steadyStateChoice == 1 {
                        selectedComponent = 1
                        selectStretching()
                    }
                    performScheduleSegue()
                    //
                    // Return to final choice without user seeing, as this is extra choice for length of warmup/stretching, need to get back to final choice
                    ScheduleVariables.shared.choiceProgress[1] -= 1
                    nextChoice()
                // Custom
                case 9:
                    // Indicate selected row
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    
                    var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                    // If app chooses warmup/stretching
                    if settings["CustomWarmupStretching"]![0] == 0 {
                        // Warmup
                        if row == 1 {
                            selectedComponent = 0
                            selectWarmup()
                            performScheduleSegue()
                            // Practice
                        } else if row == 2 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "cardio"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        }
                        // If custom warmup/stretching
                    } else if settings["CustomWarmupStretching"]![0] == 1 {
                        // Warmup
                        if row == 1 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "warmup"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                            // Practice
                        } else if row == 2 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "cardio"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        }
                    }
                    
                default:
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                }
                
                // ------------------------------------------------------------------------------------------------
            // Flexibility
            case 4:
                switch ScheduleVariables.shared.choiceProgress[1] {
                //
                case 1:
                    switch row {
                    // Custom
                    case 6:
                        ScheduleVariables.shared.choiceProgress[1] = 4
                        nextChoice()
                    default:
                        ScheduleVariables.shared.choiceProgress[1] += 1
                        nextChoice()
                    }
                // Final choice -> session
                case 3:
                    // Warmup
                    if row == 1 {
                        selectedComponent = 0
                        selectWarmup()
                    // Session
                    } else if row == 2 {
                        selectedComponent = 1
                        selectSession()
                    }
                    //
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    performScheduleSegue()
                // Custom
                case 4:
                    // Indicate selected row
                    ScheduleVariables.shared.selectedRows[1] = row - 1
                    
                    var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                    // If app chooses warmup/stretching
                    if settings["CustomWarmupStretching"]![0] == 0 {
                        // Warmup
                        if row == 1 {
                            selectedComponent = 0
                            selectWarmup()
                            performScheduleSegue()
                            // Practice
                        } else if row == 2 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "stretching"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        }
                    // If custom warmup/stretching
                    } else if settings["CustomWarmupStretching"]![0] == 1 {
                        // Warmup
                        if row == 1 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "warmup"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                            // Practice
                        } else if row == 2 {
                            // Select workout
                            SelectedSession.shared.selectedSession[0] = "stretching"
                            performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        }
                    }
                    
                // Choice
                default:
                    ScheduleVariables.shared.choiceProgress[1] += 1
                    nextChoice()
                }
                
            // Extra Session
            case 723:
                
                switch ScheduleVariables.shared.choiceProgress[1] {
                //
                case 1:
                    // Select correct session type
                    ScheduleVariables.shared.choiceProgress[0] = row - 1
                    
                    // Update selected choice
                    let groupString = (row - 1).groupFromInt()
                    // selectedChoice...[0] to group
                    ScheduleVariables.shared.selectedChoiceWarmup[0] = groupString
                    ScheduleVariables.shared.selectedChoiceSession[0] = groupString
                    // Notes ScheduleVariables.shared.selectedChoiceStretching not always used but set anyway for all, no harm done
                    ScheduleVariables.shared.selectedChoiceStretching[0] = groupString
                    
                    nextChoice()

                // Choice
                default:
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
    
    // MARK: Perform schedule Segue
    func performScheduleSegue() {
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // App chooses session
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] as! Int == 0 {
            performSegue(withIdentifier: "scheduleSegueOverview", sender: self)

        // User chooses sessions
        } else {
            performSegue(withIdentifier: "scheduleSegueFinalChoice", sender: self)

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
        let okAction = UIAlertAction(title: NSLocalizedString("done", comment: ""), style: UIAlertActionStyle.default) {
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
            
            UserDefaults.standard.set(schedules, forKey: "schedules")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
            
            // Update Tracking
            self.updateWeekProgress()
            self.updateTracking()
            self.updateWeekTracking()
            
            // Update row
            let indexPathToReload = NSIndexPath(row: 2, section: 0)
            self.scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
            self.scheduleTable.selectRow(at: indexPathToReload as IndexPath, animated: true, scrollPosition: .none)
            self.scheduleTable.deselectRow(at: indexPathToReload as IndexPath, animated: true)
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default) {
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
        ScheduleVariables.shared.selectedChoiceWarmup[3] = "average"
        
        // Select Random Session
        let choices = sessionData.sortedSessions[ScheduleVariables.shared.selectedChoiceWarmup[0]]![ScheduleVariables.shared.selectedChoiceWarmup[1]]![ScheduleVariables.shared.selectedChoiceWarmup[2]]![ScheduleVariables.shared.selectedChoiceWarmup[3]]!
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
            selectedSession.append(ScheduleVariables.shared.selectedChoiceSession[1]) // Workout type
        // Yoga
        case 1:
            selectedSession.append("yoga")
            selectedSession.append(ScheduleVariables.shared.indicator) // relaxing, neutral, stimulating
        // Endurance
        case 3:
            selectedSession.append("cardio")
            selectedSession.append(ScheduleVariables.shared.indicator) // hiit or bodyweight
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
            switch ScheduleVariables.shared.selectedChoiceSession[1] {
            // Full
            case "classicGymFull", "circuitGymFull", "classicBodyweightFull", "circuitBodyweightFull":
                ScheduleVariables.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["workout"]!]
            // Upper
            case "classicGymUpper", "circuitGymUpper", "classicBodyweightUpper", "circuitBodyweightUpper":
                ScheduleVariables.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["workoutUpper"]!]
            // Lower
            case "classicGymLower", "circuitGymLower", "classicBodyweightLower", "circuitBodyweightLower":
                ScheduleVariables.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["workoutLower"]!]
                
            default: break
            }
        // Yoga
        case 1:
            ScheduleVariables.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["yoga"]!]
        // Endurance
        case 3:
            // HIIT is not indexed through difficulty, but rather two levels of length (session and interval)
            if ScheduleVariables.shared.indicator == "hiit" {
                break
            } else {
                ScheduleVariables.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["endurance"]!]
            }
            
        // Flexibility
        case 4:
            switch ScheduleVariables.shared.selectedChoiceSession[1] {
            case "full":
                ScheduleVariables.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["overall"]!]
            case "hamstrings":
                ScheduleVariables.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["hamstrings"]!]
            case "hips":
                ScheduleVariables.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["hips"]!]
            case "backNeck":
                ScheduleVariables.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["backNeck"]!]
            case "foamRoll":
                // only one difficulty
                ScheduleVariables.shared.selectedChoiceSession[3] = "average"
            default: break
            }
        default: break
        }
        
        // Select Random Session
        var randomSessionString = randomSession(selectedChoice: ScheduleVariables.shared.selectedChoiceSession)
        
        // WORKOUT - Checks for Women, and bodyweight pullup bar
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [String: Int]
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        //
        if ScheduleVariables.shared.choiceProgress[0] == 0 {
            // Women - only applies for gym workouts
            if ScheduleVariables.shared.selectedChoiceSession[1].contains("Gym") {
                // User is a woman
                    // Gender is second question, female or other == 1 or 2 (we give 'other' female workouts for now)
                if profileAnswers["gender"]! > 0 {
                    // Avoid sessions that are for men
                    while randomSessionString.contains("-M") {
                        randomSessionString = randomSession(selectedChoice: ScheduleVariables.shared.selectedChoiceSession)
                    }
                // User is a man
                } else {
                    // Avoid sessions that are for women
                    while randomSessionString.contains("-W") {
                        randomSessionString = randomSession(selectedChoice: ScheduleVariables.shared.selectedChoiceSession)
                    }
                }
                
            // Equipment - only applies for bodyweight workouts
            } else {
                // No equipment (currently just a pullup bar)
                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["pullupBar"] as! Int == 0 {
                    while randomSessionString.contains("-E") {
                        randomSessionString = randomSession(selectedChoice: ScheduleVariables.shared.selectedChoiceSession)
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
        ScheduleVariables.shared.selectedChoiceStretching[3] = "average"
        
        // Select Random Session
        var randomSessionString = randomSession(selectedChoice: ScheduleVariables.shared.selectedChoiceStretching)
        // Not foam rolling (if foam rolling on, can include non foam rolling sessions)
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["foamRoller"] as! Int == 0 {
            // NOT Foam rolling (avoid a stretching session that ends in -F)
            while randomSessionString.suffix(2) == "-F" {
                randomSessionString = randomSession(selectedChoice: ScheduleVariables.shared.selectedChoiceStretching)
            }
        } else if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["foamRoller"] as! Int == 1 {
            // Foam rolling (get only stretching session that end in -F)
            while randomSessionString.suffix(2) != "-F" {
                randomSessionString = randomSession(selectedChoice: ScheduleVariables.shared.selectedChoiceStretching)
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
            
            // Extra session
            if row != 723 {
                var groupString = String()
                if scheduleStyle == 0 {
                    groupString = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![ScheduleVariables.shared.selectedDay][row]["group"] as! String
                } else {
                    groupString = TemporaryWeekArray.shared.weekArray[row]["group"] as! String
                }
                // selectedChoice...[0] to group
                ScheduleVariables.shared.selectedChoiceWarmup[0] = groupString
                ScheduleVariables.shared.selectedChoiceSession[0] = groupString
                // Notes ScheduleVariables.shared.selectedChoiceStretching not always used but set anyway for all, no harm done
                ScheduleVariables.shared.selectedChoiceStretching[0] = groupString
            }
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
                    // Reset ScheduleVariables.shared.indicator
                    ScheduleVariables.shared.indicator = ""
                    
                    switch row {
                    // Gym
                    case 1:
                        ScheduleVariables.shared.indicator = "gym"
                    // Bodyweight
                    case 2:
                        ScheduleVariables.shared.indicator = "bodyweight"
                    // Custom - just set to bodyweight short,
                    case 3:
                        ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaF"
                        ScheduleVariables.shared.selectedChoiceStretching[1] = "SF"
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                    default: break
                    }
                    
                // Circuit/Classic
                case 2:
                    // Reset ScheduleVariables.shared.indicator
                    ScheduleVariables.shared.indicator2 = ""
                    
                    switch row {
                    // Classic
                    case 1:
                        ScheduleVariables.shared.indicator2 = "classic"
                    // Circuit
                    case 2:
                        ScheduleVariables.shared.indicator2 = "circuit"
                    default: break
                    }
                    
                // Focus
                case 3:
                    // Note only session different for now
                    // Gym
                    if ScheduleVariables.shared.indicator == "gym" {
                            // Classic
                        if ScheduleVariables.shared.indicator2 == "classic" {
                            switch row {
                            case 1:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaF"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "classicGymFull"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SF"
                            case 2:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaU"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "classicGymUpper"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SU"
                            case 3:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaL"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "classicGymLower"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SL"
                            default: break
                            }
                            // Circuit
                        } else if ScheduleVariables.shared.indicator2 == "circuit" {
                            switch row {
                            case 1:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaF"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "circuitGymFull"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SF"
                            case 2:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaU"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "circuitGymUpper"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SU"
                            case 3:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaL"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "circuitGymLower"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SL"
                            default: break
                            }
                        }
                        // Bodyweight
                    } else if ScheduleVariables.shared.indicator == "bodyweight" {
                            // Classic
                        if ScheduleVariables.shared.indicator2 == "classic" {
                            switch row {
                            case 1:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaF"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "classicBodyweightFull"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SF"
                            case 2:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaU"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "classicBodyweightUpper"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SU"
                            case 3:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaL"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "classicBodyweightLower"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SL"
                            default: break
                            }
                            // Circuit
                        } else if ScheduleVariables.shared.indicator2 == "circuit" {
                            switch row {
                            case 1:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaF"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "circuitBodyweightFull"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SF"
                            case 2:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaU"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "circuitBodyweightUpper"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SU"
                            case 3:
                                ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaL"
                                ScheduleVariables.shared.selectedChoiceSession[1] = "circuitBodyweightLower"
                                ScheduleVariables.shared.selectedChoiceStretching[1] = "SL"
                            default: break
                            }
                        }
                    }
                // Length
                case 4,5:
                    // Note, currently all the same
                    // Gym
                    if ScheduleVariables.shared.indicator == "gym" {
                            // Classic
                        if ScheduleVariables.shared.indicator2 == "classic" {
                            switch row {
                            case 1:
                                ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                                ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                                ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                            case 2:
                                ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                                ScheduleVariables.shared.selectedChoiceSession[2] = "medium"
                                ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                            case 3:
                                ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                                ScheduleVariables.shared.selectedChoiceSession[2] = "long"
                                ScheduleVariables.shared.selectedChoiceStretching[2] = "normal"
                            default: break
                            }
                            // Circuit
                        } else if ScheduleVariables.shared.indicator2 == "circuit" {
                            switch row {
                            case 1:
                                ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                                ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                                ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                            case 2:
                                ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                                ScheduleVariables.shared.selectedChoiceSession[2] = "normal"
                                ScheduleVariables.shared.selectedChoiceStretching[2] = "normal"
                            default: break
                            }
                        }
                        // Bodyweight
                    } else if ScheduleVariables.shared.indicator == "bodyweight" {
                            // Classic
                        if ScheduleVariables.shared.indicator2 == "classic" {
                            switch row {
                            case 1:
                                ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                                ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                                ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                            case 2:
                                ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                                ScheduleVariables.shared.selectedChoiceSession[2] = "normal"
                                ScheduleVariables.shared.selectedChoiceStretching[2] = "normal"
                            default: break
                            }
                            // Circuit
                        } else if ScheduleVariables.shared.indicator2 == "circuit" {
                            switch row {
                            case 1:
                                ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                                ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                                ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                            case 2:
                                ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                                ScheduleVariables.shared.selectedChoiceSession[2] = "normal"
                                ScheduleVariables.shared.selectedChoiceStretching[2] = "normal"
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
                    // Reset ScheduleVariables.shared.indicator
                    ScheduleVariables.shared.indicator = ""
                    
                    switch row {
                    // Relaxing
                    case 1:
                        ScheduleVariables.shared.indicator = "relaxing"
                        ScheduleVariables.shared.selectedChoiceSession[1] = "relaxing"
                    // Neutral
                    case 2:
                        ScheduleVariables.shared.indicator = "neutral"
                        ScheduleVariables.shared.selectedChoiceSession[1] = "neutral"
                    // Stimulating
                    case 3:
                        ScheduleVariables.shared.indicator = "stimulating"
                        ScheduleVariables.shared.selectedChoiceSession[1] = "stimulating"
                    // Custom
                    case 4:
                        // Length
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    default: break
                    }
                    
                    // Warmup
                    ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"

                    
                // Length 1 - Relaxing
                case 2:
                    //
                    switch row {
                    case 1:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "veryShort"
                    case 2:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                    case 3:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "medium"
                    case 4:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "long"
                    default: break
                    }
                // Length 2 - Neutral
                case 3:
                    //
                    switch row {
                    case 1:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                    case 2:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "medium"
                    case 3:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "long"
                    default: break
                    }
                // Length 3 - Stimulating
                case 4:
                    //
                    switch row {
                    case 1:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                    case 2:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "normal"
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
                    ScheduleVariables.shared.indicator = ""
                    //
                    switch row {
                    case 1:
                        // Indicate to choice 3
                        ScheduleVariables.shared.indicator = "hiit"
                    case 2:
                        ScheduleVariables.shared.indicator = "bodyweight"
                        ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                        ScheduleVariables.shared.selectedChoiceSession[1] = "bodyweight"
                        ScheduleVariables.shared.selectedChoiceStretching[1] = "stretching"
                    case 3:
                        ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                        ScheduleVariables.shared.selectedChoiceStretching[1] = "stretching"
                    case 4:
                        ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceStretching[1] = "stretching"
                        ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                    default: break
                    }
                    //
                // HIIT ?Rowing/Biking/Running or workout length
                case 2:
                    // Cardio Type
                    switch row {
                    // Running
                    case 1:
                        ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                        ScheduleVariables.shared.selectedChoiceSession[1] = "hiit"
                        ScheduleVariables.shared.selectedChoiceStretching[1] = "stretching"
                    // Biking
                    case 2:
                        ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                        ScheduleVariables.shared.selectedChoiceSession[1] = "hiit"
                        ScheduleVariables.shared.selectedChoiceStretching[1] = "stretching"
                    // Rowing
                    case 3:
                        ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                        ScheduleVariables.shared.selectedChoiceSession[1] = "hiit"
                        ScheduleVariables.shared.selectedChoiceStretching[1] = "stretching"
                    default: break
                    }
                // Length: HIIT&Bodyweight
                case 3,5:
                    // HIIT
                    if ScheduleVariables.shared.indicator == "cardio" {
                        switch row {
                        case 1:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                        case 2:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "medium"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                        case 3:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "long"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "normal"
                        default: break
                        }
                    // Workout
                    } else {
                        switch row {
                        case 1:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                        case 2:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "normal"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "normal"
                        default: break
                        }
                    }
                    
                // HIIT interval Length
                case 4:
                    // HIIT
                    switch row {
                    case 1:
                        ScheduleVariables.shared.selectedChoiceSession[3] = "short"
                    case 2:
                        ScheduleVariables.shared.selectedChoiceSession[3] = "medium"
                    case 3:
                        ScheduleVariables.shared.selectedChoiceSession[3] = "long"
                    default: break
                        }
                    
                    //
                // Steady State Length
                case 8:
                    switch row {
                    case 1:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                    case 2:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                        ScheduleVariables.shared.selectedChoiceStretching[2] = "normal"
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
                        ScheduleVariables.shared.selectedChoiceSession[1] = "full"
                    case 2:
                        ScheduleVariables.shared.selectedChoiceSession[1] = "hamstrings"
                    case 3:
                        ScheduleVariables.shared.selectedChoiceSession[1] = "hips"
                    case 4:
                        ScheduleVariables.shared.selectedChoiceSession[1] = "backNeck"
                    case 5:
                        ScheduleVariables.shared.selectedChoiceSession[1] = "foamRoll"
                    // Custom
                    case 6:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    default: break
                    }
                    ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"

                // Length
                case 2:
                    switch row {
                    case 1:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                    case 2:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "normal"
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
            if ScheduleVariables.shared.choiceProgress[1] == 6 || ScheduleVariables.shared.choiceProgress[1] == 7 {
                return true
            } else {
                return false
            }
        // Yoga
        case 1:
            if ScheduleVariables.shared.choiceProgress[1] == 5 || ScheduleVariables.shared.choiceProgress[1] == 6 {
                return true
            } else {
                return false
            }
            
        // Meditation
        case 2:
            if ScheduleVariables.shared.choiceProgress[1] == 1 {
                return true
            } else {
                return false
            }
            
        // Endurance
        case 3:
            if ScheduleVariables.shared.choiceProgress[1] == 6 || ScheduleVariables.shared.choiceProgress[1] == 7 || ScheduleVariables.shared.choiceProgress[1] == 9 {
                return true
            } else {
                return false
            }
            
        // Flexibility
        case 4:
            if ScheduleVariables.shared.choiceProgress[1] == 3 || ScheduleVariables.shared.choiceProgress[1] == 4 {
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
        
        // Extra session
        if ScheduleVariables.shared.isExtraSession && ScheduleVariables.shared.choiceProgress[0] != -1 {
            // row - 1 as title included
            return ScheduleVariables.shared.extraSessionCompletion[row - 1]
            
        // Normal
        } else {
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
    }
    
    // Is group completed
        // If on the last choice, this function checks if and element of a group (checkAll=false)/all the elements of a group have been performed (checkAll=true)
    func isGroupCompleted(checkAll: Bool) -> Bool {
        
        // Extra session
        if ScheduleVariables.shared.isExtraSession {
            // -1 for title
            let nRows = scheduleTable.numberOfRows(inSection: 0) - 1
            var isCompleted = true
            for i in 0..<nRows {
                if !ScheduleVariables.shared.extraSessionCompletion[i] {
                    isCompleted = false
                    break
                }
            }
            return isCompleted
            
        // Normal
        } else {
            let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
            //
            // Check if group is completed
                // -1 for title
            let nRows = scheduleTable.numberOfRows(inSection: 0) - 1
            var isCompleted = true
            //
            // Get day/index in day for the two different schedule styles
            var day = Int()
            var indexInDay = Int()
            if scheduleStyle == 0 {
                day = ScheduleVariables.shared.selectedDay
                indexInDay = ScheduleVariables.shared.selectedRows[0]
            } else {
                day = TemporaryWeekArray.shared.weekArray[ScheduleVariables.shared.selectedRows[0]]["day"] as! Int
                indexInDay = TemporaryWeekArray.shared.weekArray[ScheduleVariables.shared.selectedRows[0]]["index"] as! Int
            }
            // Loop second array in scheduleTracking, if one if false, not completed (warmup/session/stretching)
                // -2 because title included
            if checkAll {
                if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][indexInDay]["group"] as! String == "yoga" {
                    // Yoga warmup optional, so is completed if session is finished
                    if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][indexInDay]["1"] as! Bool == false {
                        isCompleted = false
                    }
                // Normal case
                } else {
                    for i in 0..<nRows {
                        print(ScheduleVariables.shared.selectedRows[0])
                        if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][indexInDay][String(i)] as! Bool == false {
                            isCompleted = false
                            break
                        }
                    }
                }
            // Just checks on part of the group
            } else {
                return schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][indexInDay]["isGroupCompleted"] as! Bool
            }
            //
            return isCompleted
        }
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
            if (extraSwipe.direction == .left) && ScheduleVariables.shared.selectedDay != 6{
                // Update selected day
                ScheduleVariables.shared.selectedDay += 1
                
                // Deselect all ScheduleVariables.shared.indicators
                for i in 0...(stackArray.count - 1) {
                    stackArray[i].font = stackFontUnselected
                }
                // Select ScheduleVariables.shared.indicator
                stackArray[ScheduleVariables.shared.selectedDay].font = stackFontSelected
                animateDayIndicatorToDay()
                
                // Animate
                // Snapshot before update
                let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
                snapShot1?.center.y += pageStack.bounds.height
                view.insertSubview(snapShot1!, aboveSubview: scheduleTable)
                // Move table and reload
                scheduleTable.center.x = view.center.x + self.view.frame.size.width
                scheduleTable.reloadData()
                //
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
                    self.scheduleTable.center.x = self.view.center.x
                }, completion: { finish in
                    snapShot1?.removeFromSuperview()
                })
                
            //
            // Back 1 day
            } else if extraSwipe.direction == .right && ScheduleVariables.shared.selectedDay != 0 {
                // Update selected day
                ScheduleVariables.shared.selectedDay -= 1
                
                // Deselect all indicators
                for i in 0...(stackArray.count - 1) {
                    stackArray[i].font = stackFontUnselected
                }
                // Select indicator
                stackArray[ScheduleVariables.shared.selectedDay].font = stackFontSelected
                selectDay(day: ScheduleVariables.shared.selectedDay)
                animateDayIndicatorToDay()
                
                // Animate
                //
                // Snapshot before update
                let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
                snapShot1?.center.y += pageStack.bounds.height
                view.insertSubview(snapShot1!, aboveSubview: scheduleTable)
                // Move table and reload
                scheduleTable.center.x = view.center.x - self.view.frame.size.width
                scheduleTable.reloadData()
                //
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
                    self.scheduleTable.center.x = self.view.center.x
                }, completion: { finish in
                    self.scheduleTable.isHidden = false
                    snapShot1?.removeFromSuperview()
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
                stackArray[i].font = stackFontUnselected
            }
            // Select indicator
            stackArray[ScheduleVariables.shared.selectedDay].font = stackFontSelected
            animateDayIndicatorToDay()

            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            snapShot1?.center.y += pageStack.bounds.height
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            snapShot2?.center.y += pageStack.bounds.height
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
                stackArray[i].font = stackFontUnselected
            }
            // Select indicator
            stackArray[ScheduleVariables.shared.selectedDay].font = stackFontSelected
            //selectDay(day: ScheduleVariables.shared.selectedDay)
            animateDayIndicatorToDay()
            
            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            snapShot1?.center.y += pageStack.bounds.height
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            snapShot2?.center.y += pageStack.bounds.height
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
    @IBAction func markAsCompleted(_ sender: UIButton) {
        
        // Extra session
        if ScheduleVariables.shared.isExtraSession {

            // Get indexPath.row
            let row = sender.tag

            // Update bool
            ScheduleVariables.shared.extraSessionCompletion[row - 1] = !ScheduleVariables.shared.extraSessionCompletion[row - 1]
            
            // Reload row
            let indexPathToReload = NSIndexPath(row: row, section: 0)
            scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
            
            // Box indicator round todo
            var shouldUpdateArraysAgain = false
            if isLastChoice() {
                if isGroupCompleted(checkAll: true) {
                    maskView3.backgroundColor = Colors.green
                    shouldUpdateArraysAgain = true
                }
            }
            
            // Only called if is last choice
            if shouldUpdateArraysAgain {
                // Update Tracking
                updateWeekProgress()
                updateTracking()
                updateWeekTracking()
                // Animate back to initial choice
                ScheduleVariables.shared.isExtraSession = false
                let toAdd = AnimationTimes.animationTime1 + AnimationTimes.animationTime2
                DispatchQueue.main.asyncAfter(deadline: .now() + toAdd, execute: {
                    self.backToBeginning()
                })
            }
            
        } else {
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]

            //
            // Get indexPath.row
            let row = sender.tag
            
            // If first choice
            // indicate to reset first choice
            var shouldResetSelectedRows = false
            // Set selected row to ScheduleVariables.shared.selectedRow[0]
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                ScheduleVariables.shared.selectedRows[0] = row
                shouldResetSelectedRows = true
            }
            
            // Indexing variables
                // Differ if last choice or first choice
            let indexingVariables = getIndexingVariables(row: row, firstChoice: false, checkLastChoice: false)
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
                UserDefaults.standard.set(schedules, forKey: "schedules")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
                // Update Badges
                ReminderNotifications.shared.updateBadges(day: day, currentBool: currentBool)
                // Update Week Progress & Tracking
                updateWeekProgress()
                updateTracking()
                updateWeekTracking()
                
                //
                let indexPathToReload = NSIndexPath(row: row, section: 0)
                scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
            
                
                //
                // Box indicator round todo, done here because userdefaults set above && check if full group needs to be completed
                var shouldUpdateArraysAgain = false
                if isLastChoice() {
                    if isGroupCompleted(checkAll: true) {
                        maskView3.backgroundColor = Colors.green
                        //
                        schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0]["isGroupCompleted"] = true
                        shouldUpdateArraysAgain = true
                    } else {
                        maskView3.backgroundColor = Colors.red
                        //
                        schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0]["isGroupCompleted"] = false
                        shouldUpdateArraysAgain = true
                    }
                // Update day indicators
                } else {
                    updateDayIndicatorColours()
                }
                
                // Only called if is last choice
                if shouldUpdateArraysAgain {
                    UserDefaults.standard.set(schedules, forKey: "schedules")
                    // Sync
                    ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
                    // Update Tracking
                    updateWeekProgress()
                    updateTracking()
                    updateWeekTracking()
                }
                
                //
                // Mark first instance of group in all other schedules as completed- called after to avoid conflicts storing to userdefaults
                if isGroupCompleted(checkAll: false) {
                    markAsGroupForOtherSchedules(markAs: !currentBool)
                    // Animate back to initial choice
                    if isLastChoice() {
                        animateFromLongPress()
                    }
                }
                
                // ScheduleVariables.shared.choiceProgress[0] was updated just for the duration of the mark as complete function, reset back to -1 now completed
                // Reset first choice to -1 to indicate still on schedule home screen
                if shouldResetSelectedRows {
                    ScheduleVariables.shared.choiceProgress[0] = -1
                }
            } else {
                let indexPathToReload = NSIndexPath(row: row, section: 0)
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
            for i in 0...6 {
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
        // Enabled
        if headerHeight + totalRowHeights <= scheduleTable.bounds.maxY {
            scheduleTable.isScrollEnabled = false
        } else {
            scheduleTable.isScrollEnabled = true
        }
    }
    
    // MARK: - Reload Functions
    // MARK: Reload Choice
        // if shouldReloadChoice == true then this function is executed
        // Once having completed a session from the schedule, this function gets called upon return to the schedule, if the group is complete then the tracking is updated, and the schedule is animated back to the initial choice of groups
    func markAsCompletedAndAnimate() {
        // MARK AS COMPLETED
        
        // Extra session
        if ScheduleVariables.shared.shouldReloadChoice && ScheduleVariables.shared.isExtraSession {
            //
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                self.maskView3.backgroundColor = Colors.green
                // Slide back to initial choice when completed
            }, completion: { finished in
                DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                    ScheduleVariables.shared.choiceProgress[1] = 1
                    self.maskAction()
                    
                    ScheduleVariables.shared.shouldReloadChoice = false
                    nina
                    reload rows
//                    // Animate initial choice group completion after slideRight() animation finished
//                    let toAdd = AnimationTimes.animationTime1 + AnimationTimes.animationTime2
//                    DispatchQueue.main.asyncAfter(deadline: .now() + toAdd, execute: {
//                        let indexPathToReload2 = NSIndexPath(row: ScheduleVariables.shared.selectedRows[0], section: 0)
//                        self.scheduleTable.reloadRows(at: [indexPathToReload2 as IndexPath], with: .automatic)
//                        self.selectRow(indexPath: indexPathToReload2 as IndexPath)
//                        self.scheduleTable.deselectRow(at: indexPathToReload2 as IndexPath, animated: true)
//                    })
                })
            })
            
        // Normal session (NOT MEDITATION, = 72 => MEDITATION)
        } else if ScheduleVariables.shared.shouldReloadChoice && ScheduleVariables.shared.selectedRows[1] != 72 {
            //
            // Delay so looks nice
            DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                // Reload the finalChoiceScreen Session after a delay
                let indexPathToReload = NSIndexPath(row: ScheduleVariables.shared.selectedRows[1] + 1, section: 0)
                self.scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
                self.selectRow(indexPath: indexPathToReload as IndexPath)
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
                                self.selectRow(indexPath: indexPathToReload2 as IndexPath)
                                self.scheduleTable.deselectRow(at: indexPathToReload2 as IndexPath, animated: true)
                            })
                        })
                    })
                }
            })
        // Meditation
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
                self.selectRow(indexPath: indexPathToReload2 as IndexPath)
                self.scheduleTable.deselectRow(at: indexPathToReload2 as IndexPath, animated: true)
            })
            updateDayIndicatorColours()
        }
    }
    
    func selectRow(indexPath: IndexPath) {
        scheduleTable.selectRow(at: indexPath as IndexPath, animated: true, scrollPosition: .none)
        // Called due to silly issue with highlighting cell messing up checkBox background color, see didSelectRow for more detail
        scheduleTable.delegate?.tableView!(scheduleTable, didSelectRowAt: indexPath)
    }
    
    func animateFromLongPress() {
        // Update schedule tracking
        DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
            ScheduleVariables.shared.choiceProgress[1] = 1
            // Set to true to avoid the tick being loaded before the animation has finished
            ScheduleVariables.shared.shouldReloadChoice = true
            self.maskAction()
            ScheduleVariables.shared.shouldReloadChoice = false
            // Animate initial choice group completion after slideRight() animation finished
            let toAdd = AnimationTimes.animationTime1 + AnimationTimes.animationTime2
            DispatchQueue.main.asyncAfter(deadline: .now() + toAdd, execute: {
                let indexPathToReload2 = NSIndexPath(row: ScheduleVariables.shared.selectedRows[0], section: 0)
                self.scheduleTable.reloadRows(at: [indexPathToReload2 as IndexPath], with: .automatic)
                self.selectRow(indexPath: indexPathToReload2 as IndexPath)
                self.scheduleTable.deselectRow(at: indexPathToReload2 as IndexPath, animated: true)
                self.updateDayIndicatorColours()
            })
        })
    }
    
    // Only called for updaing full group, i.e group is completed
        // Updates the tracking of a full group, setting to true
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
        // Update Tracking
        updateWeekProgress()
        updateTracking()
        updateWeekTracking()

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
    @objc func reloadView() {
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
        print(SubscriptionsCheck.shared.isValid)
        if !SubscriptionsCheck.shared.isValid {
            self.performSegue(withIdentifier: "SubscriptionsSegue", sender: self)
        }
    }
    
    // MARK: View Setup/Layout
    func setupViews() {
        // Set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
        //
        // table   // buttons // spaces
        
        let tableHeight: CGFloat = (47*4.5) + 49 // 47 is height of a row in the table - 49 for the header
        let buttonHeight: CGFloat = 49
        
        let elementWidth = ActionSheet.shared.actionWidth
        
        // Schedule View
        scheduleView.backgroundColor = Colors.dark
        scheduleView.frame = CGRect(x: 0, y: 0, width: elementWidth, height: tableHeight + buttonHeight)
        scheduleView.layer.cornerRadius = CGFloat(buttonHeight / 2)
        scheduleView.clipsToBounds = true
        scheduleView.layer.borderWidth = 1
        scheduleView.layer.borderColor = Colors.light.cgColor
        // Important order for the shadow on editSchedule button to be in front of scheduleChoiceTable but behind editScheduleButton
        scheduleView.addSubview(scheduleChoiceTable)
        scheduleView.addSubview(createScheduleButton)
        // Schedule choice
        scheduleChoiceTable.backgroundColor = Colors.dark
        scheduleChoiceTable.delegate = self
        scheduleChoiceTable.dataSource = self
        scheduleChoiceTable.frame = CGRect(x: 0, y: 0, width: elementWidth, height: tableHeight)
        scheduleChoiceTable.tableFooterView = UIView()
        scheduleChoiceTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scheduleChoiceTable.layer.borderWidth = 1
        scheduleChoiceTable.layer.borderColor = Colors.light.cgColor
        
        // Create Schedule
        createScheduleButton.addTarget(self, action: #selector(createScheduleAction), for: .touchUpInside)
        createScheduleButton.setTitle(NSLocalizedString("createSchedule", comment: ""), for: .normal)
        createScheduleButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        createScheduleButton.frame = CGRect(x: 0, y: tableHeight, width: elementWidth, height: buttonHeight)
        createScheduleButton.setTitleColor(Colors.dark, for: .normal)
        createScheduleButton.backgroundColor = Colors.light
        createScheduleButton.setImage(#imageLiteral(resourceName: "Plus"), for: .normal)
        createScheduleButton.tintColor = Colors.dark
        createScheduleButton.layer.shadowColor = UIColor.black.cgColor
        createScheduleButton.layer.shadowOpacity = 0.72
        createScheduleButton.layer.shadowRadius = 8
        createScheduleButton.layer.shadowOffset = CGSize.zero
        //
        
        // Separator
        separator.frame = CGRect(x: 27, y: separatorY, width: view.bounds.width - 54, height: 1)
        separator.backgroundColor = Colors.light.withAlphaComponent(0.5)
        view.insertSubview(separator, aboveSubview: scheduleTable)
        
        //
        // Navigation Bar
        self.navigationController?.navigationBar.barTintColor = Colors.dark
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBar]

        // Navigation Title
        navigationBar.title = NSLocalizedString("schedule", comment: "")
        
        //
        // TableView
        scheduleTable.backgroundView = UIView()
        scheduleTable.backgroundColor = .clear
        scheduleTable.tableFooterView = UIView()
        scheduleTable.separatorStyle = .none
        
    }
    
    // Layout views
    func layoutViews() {
        //
        // Remove navigation separator
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //
        // Present as days or as week
        // days
        if scheduleStyle == 0 {
            pageStack.frame.size = CGSize(width: pageStack.bounds.width, height: pageStackHeight)
            navigationSeparatorTopConstraint.constant = pageStackHeight
            scheduleTableTopConstraint.constant = pageStackHeight
            separator.center.y = separatorY
            pageStack.alpha = 1
            pageStack.isUserInteractionEnabled = true
        // week
        } else if scheduleStyle == 1 {
            pageStack.frame.size = CGSize(width: pageStack.bounds.width, height: 0)
            navigationSeparatorTopConstraint.constant = 0
            scheduleTableTopConstraint.constant = 0
            separator.center.y = separatorY
            pageStack.alpha = 0
            pageStack.isUserInteractionEnabled = false
        }
        
        // Day indicator
        if scheduleStyle == 0 {
            dayIndicator.alpha = 1
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
                dayLabel.font = stackFontUnselected
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
            // Add background color to stack view
            let backgroundStackView = UIView(frame: pageStack.bounds)
            backgroundStackView.backgroundColor = Colors.dark
            backgroundStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pageStack.insertSubview(backgroundStackView, at: 0)
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
        // Get current day as index
        if scheduleStyle == 0 {
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                ScheduleVariables.shared.selectedDay = Date().weekDayFromMonday
                stackArray[ScheduleVariables.shared.selectedDay].font = stackFontSelected
                dayIndicatorLeading.constant = stackArray[ScheduleVariables.shared.selectedDay].frame.minX
                self.view.layoutIfNeeded()
            } else {
                stackArray[ScheduleVariables.shared.selectedDay].font = stackFontUnselected
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
        dayIndicator.backgroundColor = Colors.light
        if scheduleStyle == 0 {
            view.addSubview(dayIndicator)
            view.bringSubview(toFront: dayIndicator)
        }
        
        //
        updateDayIndicatorColours()
        
        //
        scheduleTableScrollCheck()
    }
    
    //
    @objc func checkSelectedDay() {
        // If see each day
        if scheduleStyle == 0 {
            //
            if ScheduleVariables.shared.lastDayOpened != Date().setToMidnightUTC() {
                // Reload
                ScheduleVariables.shared.selectedDay = Date().weekDayFromMonday
                ScheduleVariables.shared.shouldReloadSchedule = true
                reloadView()
                ScheduleVariables.shared.lastDayOpened = Date().setToMidnightUTC()
            }
        }
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
