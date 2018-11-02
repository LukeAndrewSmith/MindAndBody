//
//  SessionChoiceHelpers.swift
//  MindAndBody
//
//  Created by Luke Smith on 26.09.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

extension SessionChoice {
    
    // OVERVIEW
    // Main functions
    // didSelectRowHandler:
    // decides what to do upon selection of row, wether it be go to next choice of go to overview screen
    // Also calls selectWarmup, selecteSession selectStretching
    // Update selected choice
    // Selected choice indicates to schedule where in the choice path the user is, i.e at which point he is at when choosing a session
    // This function updates it
    // selectWarmup, selecteSession selectStretching
    // These functions are called just before going to the session overview, they determine which session to present based on the choice pather (selectedChoice), and wether DifferenSessions settings is on
    
    // MARK:- Session choice helpers
    // MARK: didSelectRowHandler
    func didSelectRowHandler(row: Int) {
        
        updateSelectedChoice(row: row)

        // Present next choice or present session
        switch ScheduleVariables.shared.selectedGroup {
        case Groups.workout:
            // Session Choice
            switch ScheduleVariables.shared.choiceProgress {
            // Custom
            case 1:
                // Custom
                if row == 2 {
                    ScheduleVariables.shared.choiceProgress = 7
                    nextChoice()
                } else {
                    ScheduleVariables.shared.choiceProgress += 1
                    nextChoice()
                }
            // Go to length 1 or length 2 choice
            case 3:
                //
                if ScheduleVariables.shared.indicator == "gym" && ScheduleVariables.shared.indicator2 == "classic" {
                    ScheduleVariables.shared.choiceProgress = 4
                    nextChoice()
                    //
                } else {
                    ScheduleVariables.shared.choiceProgress = 5
                    nextChoice()
                }
            // Length 1 - Go to final choice
            case 4:
                ScheduleVariables.shared.choiceProgress = 6
                nextChoice()
            // Final Choice
            case 6:
                // Warmup
                if row == 0 {
                    selectedComponent = 0
                    selectWarmup()
                    // Session
                } else if row == 1 {
                    selectedComponent = 1
                    selectSession()
                    // Stretching
                } else if row == 2 {
                    selectedComponent = 2
                    selectStretching()
                }
                ScheduleVariables.shared.selectedRows.final = row
                performScheduleSegue()
            // Custom Choice
            case 7:
                // Indicate selected row
                ScheduleVariables.shared.selectedRows.final = row
                
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                // If app chooses warmup/stretching
                if settings["CustomWarmupStretching"]![0] == 0 {
                    // Warmup
                    if row == 0 {
                        selectedComponent = 0
                        selectWarmup()
                        performScheduleSegue()
                        // Session
                    } else if row == 1 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "workout"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        // Stretching
                    } else if row == 2 {
                        selectedComponent = 2
                        selectStretching()
                        performScheduleSegue()
                    }
                    // If custom warmup/stretching
                } else if settings["CustomWarmupStretching"]![0] == 1 {
                    // Warmup
                    if row == 0 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "warmup"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        // Session
                    } else if row == 1 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "workout"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        // Stretching
                    } else if row == 2 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "stretching"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                    }
                }
                // }
            // Normal next choice
            default:
                ScheduleVariables.shared.choiceProgress += 1
                nextChoice()
            }
            
        case Groups.yoga:
            // Session Choice
            switch ScheduleVariables.shared.choiceProgress {
            // Go to correct length choice
            case 1:
                switch ScheduleVariables.shared.indicator {
                case "relaxing":
                    ScheduleVariables.shared.choiceProgress = 2
                    nextChoice()
                case "neutral":
                    ScheduleVariables.shared.choiceProgress = 3
                    nextChoice()
                case "stimulating":
                    ScheduleVariables.shared.choiceProgress = 4
                    nextChoice()
                default: break
                }
                // Custom
                if row == 3 {
                    ScheduleVariables.shared.choiceProgress = 6
                    nextChoice()
                }
            // Go from length to final choice
            case 2,3:
                ScheduleVariables.shared.choiceProgress = 5
                nextChoice()
            // Final Choice
            case 5:
                // Warmup
                if row == 0 {
                    selectedComponent = 0
                    selectWarmup()
                    // Practice
                } else if row == 1 {
                    selectedComponent = 1
                    selectSession()
                    // Stretching
                }
                ScheduleVariables.shared.selectedRows.final = row
                performScheduleSegue()
            // Custom
            case 6:
                // Indicate selected row
                ScheduleVariables.shared.selectedRows.final = row
                
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                // If app chooses warmup/stretching
                if settings["CustomWarmupStretching"]![0] == 0 {
                    // Warmup
                    if row == 0 {
                        selectedComponent = 0
                        selectWarmup()
                        ScheduleVariables.shared.selectedRows.final = row
                        performScheduleSegue()
                        // Practice
                    } else if row == 1 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "yoga"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                    }
                    // If custom warmup/stretching
                } else if settings["CustomWarmupStretching"]![0] == 1 {
                    // Warmup
                    if row == 0 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "warmup"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        // Practice
                    } else if row == 1 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "yoga"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                    }
                }
                
            // Normal next choice
            default:
                ScheduleVariables.shared.choiceProgress += 1
                nextChoice()
            }
            
        // Meditation
        case Groups.meditation:
            // Session Choice
            switch ScheduleVariables.shared.choiceProgress {
            // Select meditation style - timer, 'guided'
            case 1:
                ScheduleVariables.shared.selectedRows.final = row // used to be 72 NINA
                // Timer
                if row == 0 {
                    performSegue(withIdentifier: "scheduleMeditationSegueTimer", sender: self)
                    // Guided
                } else {
                    performSegue(withIdentifier: "scheduleMeditationSegueGuided", sender: self)
                }
            default:
                ScheduleVariables.shared.choiceProgress += 1
                nextChoice()
            }
            
            // ------------------------------------------------------------------------------------------------
        // Endurance
        case Groups.endurance:
            switch ScheduleVariables.shared.choiceProgress {
            // Type 1, hiit vs steady state
            case 1:
                // HIIT
                if row == 0 {
                    ScheduleVariables.shared.choiceProgress += 1
                    nextChoice()
                    // Workout
                } else if row == 1 {
                    ScheduleVariables.shared.choiceProgress = 5
                    nextChoice()
                    // Steady state cardio
                } else if row == 2 {
                    ScheduleVariables.shared.choiceProgress = 7
                    nextChoice()
                    // Custom
                } else if row == 3 {
                    ScheduleVariables.shared.choiceProgress = 9
                    nextChoice()
                }
            // Go straight to final choice from hiit length
            case 4:
                ScheduleVariables.shared.choiceProgress = 6
                nextChoice()
            // Session Choice, To Do
            case 6:
                // Warmup
                if row == 0 {
                    selectedComponent = 0
                    selectWarmup()
                    // Session
                } else if row == 1 {
                    selectedComponent = 1
                    selectSession()
                    // Stretching
                } else if row == 2 {
                    selectedComponent = 2
                    selectStretching()
                }
                ScheduleVariables.shared.selectedRows.final = row
                performScheduleSegue()
                
            // Final choice steady state
            case 7:
                // Select now as this choice is final choice (even if you choose the length afterwards)
                ScheduleVariables.shared.selectedRows.final = row
                if row == 1 {
                    endurancePopup()
                } else {
                    if row == 0 {
                        steadyStateChoice = 0
                    } else if row == 2 {
                        steadyStateChoice = 1
                    }
                    //
                    ScheduleVariables.shared.choiceProgress += 1
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
                    selectedComponent = 2
                    selectStretching()
                }
                performScheduleSegue()
                //
                // Return to final choice without user seeing, as this is extra choice for length of warmup/stretching, need to get back to final choice
                ScheduleVariables.shared.choiceProgress -= 1
                nextChoice()
            // Custom
            case 9:
                // Indicate selected row
                ScheduleVariables.shared.selectedRows.final = row
                
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                // If app chooses warmup/stretching
                if settings["CustomWarmupStretching"]![0] == 0 {
                    // Warmup
                    if row == 0 {
                        selectedComponent = 0
                        selectWarmup()
                        performScheduleSegue()
                        // Practice
                    } else if row == 1 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "cardio"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                    }
                    // If custom warmup/stretching
                } else if settings["CustomWarmupStretching"]![0] == 1 {
                    // Warmup
                    if row == 0 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "warmup"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        // Practice
                    } else if row == 1 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "cardio"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                    }
                }
                
            default:
                ScheduleVariables.shared.choiceProgress += 1
                nextChoice()
            }
            
            // ------------------------------------------------------------------------------------------------
        // Flexibility
        case Groups.flexibility:
            switch ScheduleVariables.shared.choiceProgress {
            //
            case 1:
                switch row {
                // Custom
                case 5:
                    ScheduleVariables.shared.choiceProgress = 4
                    nextChoice()
                default:
                    ScheduleVariables.shared.choiceProgress += 1
                    nextChoice()
                }
            // Final choice -> session
            case 3:
                // Warmup
                if row == 0 {
                    selectedComponent = 0
                    selectWarmup()
                    // Session
                } else if row == 1 {
                    selectedComponent = 1
                    selectSession()
                }
                //
                ScheduleVariables.shared.selectedRows.final = row
                performScheduleSegue()
            // Custom
            case 4:
                // Indicate selected row
                ScheduleVariables.shared.selectedRows.final = row
                
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                // If app chooses warmup/stretching
                if settings["CustomWarmupStretching"]![0] == 0 {
                    // Warmup
                    if row == 0 {
                        selectedComponent = 0
                        selectWarmup()
                        performScheduleSegue()
                        // Practice
                    } else if row == 1 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "stretching"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                    }
                    // If custom warmup/stretching
                } else if settings["CustomWarmupStretching"]![0] == 1 {
                    // Warmup
                    if row == 0 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "warmup"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                        // Practice
                    } else if row == 1 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "stretching"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                    }
                }
                
            // Choice
            default:
                ScheduleVariables.shared.choiceProgress += 1
                nextChoice()
            }
            
        // Extra Session
        case Groups.extra:
            
            switch ScheduleVariables.shared.choiceProgress {
            //
            case 1:
                
                let groupString = row.groupFromInt()

                // Select correct session type
                ScheduleVariables.shared.selectedGroup = Groups(rawValue: groupString) ?? Groups.none
                
                // Update selected choice
                // selectedChoice...[0] to group
                ScheduleVariables.shared.selectedChoiceWarmup[0] = groupString
                ScheduleVariables.shared.selectedChoiceSession[0] = groupString
                // Notes ScheduleVariables.shared.selectedChoiceStretching not always used but set anyway for all, no harm done
                ScheduleVariables.shared.selectedChoiceStretching[0] = groupString
                
                nextChoice()
                
                setupGroupImage()
                
            // Choice
            default:
                ScheduleVariables.shared.choiceProgress += 1
                nextChoice()
            }
            
        default:
            break
        }
    }
    
    // MARK: Perform schedule Segue
    func performScheduleSegue() {
        // App chooses session
        if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["customSessionChoice"] as! Int == 0 {
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
            // Reload
            ScheduleVariables.shared.shouldReloadScheduleTracking()
            let indexPath = NSIndexPath(row: ScheduleVariables.shared.selectedRows.final, section: 0)
            // Find checkmark button and use this for markAsCompleted function
            if let cell = self.choiceTable.cellForRow(at: indexPath as IndexPath) {
                for view in (cell.subviews) {
                    if view is UIButton {
                        // Select only if unselected
                        if (view as! UIButton).backgroundColor != Colors.green {
                            (view as! UIButton).sendActions(for: .touchUpInside)
                            break
                        }
                    }
                }
            }
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
        switch ScheduleVariables.shared.selectedGroup {
        // Workout
        case Groups.workout:
            selectedWarmup.append("workout")
        // Yoga, Flexibility (same warmups)
        case Groups.yoga, Groups.flexibility:
            selectedWarmup.append("stretching")
        // Endurance
        case Groups.endurance:
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
        switch ScheduleVariables.shared.selectedGroup {
        // Workout
        case Groups.workout:
            selectedSession.append("workout")
            selectedSession.append(ScheduleVariables.shared.selectedChoiceSession[1]) // Workout type
        // Yoga
        case Groups.yoga:
            selectedSession.append("yoga")
            selectedSession.append(ScheduleVariables.shared.indicator) // relaxing, neutral, stimulating
        // Endurance
        case Groups.endurance:
            selectedSession.append("cardio")
            selectedSession.append(ScheduleVariables.shared.indicator) // hiit or bodyweight
        // Flexibility
        case Groups.flexibility:
            selectedSession.append("stretching")
            selectedSession.append("general")
        default: break
        }
        
        // Difficulty
        // Get difficulty levels
        let difficultyLevels = UserDefaults.standard.object(forKey: "difficultyLevels") as! [String: [String: Int]]
        let difficultyArray = scheduleDataStructures.difficultyArray
        let group = ScheduleVariables.shared.selectedGroup.rawValue
        
        // Cases for session types
        switch ScheduleVariables.shared.selectedGroup {
        // Workout
        case Groups.workout:
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
        case Groups.yoga:
            ScheduleVariables.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["yoga"]!]
        // Endurance
        case Groups.endurance:
            // HIIT is not indexed through difficulty, but rather two levels of length (session and interval)
            if ScheduleVariables.shared.indicator == "hiit" {
                break
            } else {
                ScheduleVariables.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["endurance"]!]
            }
            
        // Flexibility
        case Groups.flexibility:
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
        
        //
        if ScheduleVariables.shared.selectedGroup == Groups.workout {
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
                if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["pullupBar"] as! Int == 0 {
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
        switch ScheduleVariables.shared.selectedGroup {
        // Workout
        case Groups.workout:
            selectedStretching.append("postWorkout")
        // Endurance
        case Groups.endurance:
            selectedStretching.append("postCardio")
        default: break
        }
        
        // No difficulty level for warmup so default is average
        ScheduleVariables.shared.selectedChoiceStretching[3] = "average"
        
        // Select Random Session
        var randomSessionString = randomSession(selectedChoice: ScheduleVariables.shared.selectedChoiceStretching)
        // Not foam rolling (if foam rolling on, can include non foam rolling sessions)
        
        if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["foamRoller"] as! Int == 0 {
            // NOT Foam rolling (avoid a stretching session that ends in -F)
            while randomSessionString.suffix(2) == "-F" {
                randomSessionString = randomSession(selectedChoice: ScheduleVariables.shared.selectedChoiceStretching)
            }
        } else if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["foamRoller"] as! Int == 1 {
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
        // Present next choice or present session
        switch ScheduleVariables.shared.selectedGroup {
            // ------------------------------------------------------------------------------------------------
        // Workout
        case Groups.workout:
            switch ScheduleVariables.shared.choiceProgress {
            // Gym/Bodyweight
            case 1:
                // Reset ScheduleVariables.shared.indicator
                ScheduleVariables.shared.indicator = ""
                
                switch row {
                // Gym
                case 0:
                    ScheduleVariables.shared.indicator = "gym"
                // Bodyweight
                case 1:
                    ScheduleVariables.shared.indicator = "bodyweight"
                // Custom - just set to bodyweight short,
                case 2:
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
                case 0:
                    ScheduleVariables.shared.indicator2 = "classic"
                // Circuit
                case 1:
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
                        case 0:
                            ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaF"
                            ScheduleVariables.shared.selectedChoiceSession[1] = "classicGymFull"
                            ScheduleVariables.shared.selectedChoiceStretching[1] = "SF"
                        case 1:
                            ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaU"
                            ScheduleVariables.shared.selectedChoiceSession[1] = "classicGymUpper"
                            ScheduleVariables.shared.selectedChoiceStretching[1] = "SU"
                        case 2:
                            ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaL"
                            ScheduleVariables.shared.selectedChoiceSession[1] = "classicGymLower"
                            ScheduleVariables.shared.selectedChoiceStretching[1] = "SL"
                        default: break
                        }
                        // Circuit
                    } else if ScheduleVariables.shared.indicator2 == "circuit" {
                        switch row {
                        case 0:
                            ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaF"
                            ScheduleVariables.shared.selectedChoiceSession[1] = "circuitGymFull"
                            ScheduleVariables.shared.selectedChoiceStretching[1] = "SF"
                        case 1:
                            ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaU"
                            ScheduleVariables.shared.selectedChoiceSession[1] = "circuitGymUpper"
                            ScheduleVariables.shared.selectedChoiceStretching[1] = "SU"
                        case 2:
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
                        case 0:
                            ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaF"
                            ScheduleVariables.shared.selectedChoiceSession[1] = "classicBodyweightFull"
                            ScheduleVariables.shared.selectedChoiceStretching[1] = "SF"
                        case 1:
                            ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaU"
                            ScheduleVariables.shared.selectedChoiceSession[1] = "classicBodyweightUpper"
                            ScheduleVariables.shared.selectedChoiceStretching[1] = "SU"
                        case 2:
                            ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaL"
                            ScheduleVariables.shared.selectedChoiceSession[1] = "classicBodyweightLower"
                            ScheduleVariables.shared.selectedChoiceStretching[1] = "SL"
                        default: break
                        }
                        // Circuit
                    } else if ScheduleVariables.shared.indicator2 == "circuit" {
                        switch row {
                        case 0:
                            ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaF"
                            ScheduleVariables.shared.selectedChoiceSession[1] = "circuitBodyweightFull"
                            ScheduleVariables.shared.selectedChoiceStretching[1] = "SF"
                        case 1:
                            ScheduleVariables.shared.selectedChoiceWarmup[1] = "WaU"
                            ScheduleVariables.shared.selectedChoiceSession[1] = "circuitBodyweightUpper"
                            ScheduleVariables.shared.selectedChoiceStretching[1] = "SU"
                        case 2:
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
                        case 0:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                        case 1:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "medium"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                        case 2:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "long"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "normal"
                        default: break
                        }
                        // Circuit
                    } else if ScheduleVariables.shared.indicator2 == "circuit" {
                        switch row {
                        case 0:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                        case 1:
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
                        case 0:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                        case 1:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "normal"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "normal"
                        default: break
                        }
                        // Circuit
                    } else if ScheduleVariables.shared.indicator2 == "circuit" {
                        switch row {
                        case 0:
                            ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                            ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                        case 1:
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
        case Groups.yoga:
            switch ScheduleVariables.shared.choiceProgress {
            // Yoga Type
            case 1:
                // Reset ScheduleVariables.shared.indicator
                ScheduleVariables.shared.indicator = ""
                
                switch row {
                // Relaxing
                case 0:
                    ScheduleVariables.shared.indicator = "relaxing"
                    ScheduleVariables.shared.selectedChoiceSession[1] = "relaxing"
                // Neutral
                case 1:
                    ScheduleVariables.shared.indicator = "neutral"
                    ScheduleVariables.shared.selectedChoiceSession[1] = "neutral"
                // Stimulating
                case 2:
                    ScheduleVariables.shared.indicator = "stimulating"
                    ScheduleVariables.shared.selectedChoiceSession[1] = "stimulating"
                // Custom
                case 3:
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
                case 0:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleVariables.shared.selectedChoiceSession[2] = "veryShort"
                case 1:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                case 2:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleVariables.shared.selectedChoiceSession[2] = "medium"
                case 3:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                    ScheduleVariables.shared.selectedChoiceSession[2] = "long"
                default: break
                }
            // Length 2 - Neutral
            case 3:
                //
                switch row {
                case 0:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                case 1:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleVariables.shared.selectedChoiceSession[2] = "medium"
                case 2:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleVariables.shared.selectedChoiceSession[2] = "long"
                default: break
                }
            // Length 3 - Stimulating
            case 4:
                //
                switch row {
                case 0:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                case 1:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleVariables.shared.selectedChoiceSession[2] = "normal"
                default: break
                }
            default:
                break
            }
            // ------------------------------------------------------------------------------------------------
        // Meditation
        case Groups.meditation:
            // Not necessary
            break
            // ------------------------------------------------------------------------------------------------
        // Endurance
        case Groups.endurance:
            switch ScheduleVariables.shared.choiceProgress {
            // Cardio Type
            case 1:
                // Reset indication
                ScheduleVariables.shared.indicator = ""
                //
                switch row {
                case 0:
                    // Indicate to choice 3
                    ScheduleVariables.shared.indicator = "hiit"
                case 1:
                    ScheduleVariables.shared.indicator = "bodyweight"
                    ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                    ScheduleVariables.shared.selectedChoiceSession[1] = "bodyweight"
                    ScheduleVariables.shared.selectedChoiceStretching[1] = "stretching"
                case 2:
                    ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                    ScheduleVariables.shared.selectedChoiceStretching[1] = "stretching"
                case 3:
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
                case 0:
                    ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                    ScheduleVariables.shared.selectedChoiceSession[1] = "hiit"
                    ScheduleVariables.shared.selectedChoiceStretching[1] = "stretching"
                // Biking
                case 1:
                    ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                    ScheduleVariables.shared.selectedChoiceSession[1] = "hiit"
                    ScheduleVariables.shared.selectedChoiceStretching[1] = "stretching"
                // Rowing
                case 2:
                    ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                    ScheduleVariables.shared.selectedChoiceSession[1] = "hiit"
                    ScheduleVariables.shared.selectedChoiceStretching[1] = "stretching"
                default: break
                }
            // Length: HIIT&Bodyweight
            case 3,5:
                // HIIT
                if ScheduleVariables.shared.indicator == "hiit" {
                    switch row {
                    case 0:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                        ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                    case 1:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "medium"
                        ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                    case 2:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "long"
                        ScheduleVariables.shared.selectedChoiceStretching[2] = "normal"
                    default: break
                    }
                    // Workout
                } else {
                    switch row {
                    case 0:
                        ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                        ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                    case 1:
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
                case 0:
                    ScheduleVariables.shared.selectedChoiceSession[3] = "short"
                case 1:
                    ScheduleVariables.shared.selectedChoiceSession[3] = "medium"
                case 2:
                    ScheduleVariables.shared.selectedChoiceSession[3] = "long"
                default: break
                }
                
                //
            // Steady State Length
            case 8:
                switch row {
                case 0:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleVariables.shared.selectedChoiceStretching[2] = "short"
                case 1:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "normal"
                    ScheduleVariables.shared.selectedChoiceStretching[2] = "normal"
                default: break
                }
            default:
                break
            }
            // ------------------------------------------------------------------------------------------------
        // Flexibility
        case Groups.flexibility:
            switch ScheduleVariables.shared.choiceProgress {
            // Focus
            case 1:
                // Note warmups the same for now
                switch row {
                case 0:
                    ScheduleVariables.shared.selectedChoiceSession[1] = "full"
                case 1:
                    ScheduleVariables.shared.selectedChoiceSession[1] = "hamstrings"
                case 2:
                    ScheduleVariables.shared.selectedChoiceSession[1] = "hips"
                case 3:
                    ScheduleVariables.shared.selectedChoiceSession[1] = "backNeck"
                case 4:
                    ScheduleVariables.shared.selectedChoiceSession[1] = "foamRoll"
                // Custom
                case 5:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                default: break
                }
                ScheduleVariables.shared.selectedChoiceWarmup[1] = "warmup"
                
            // Length
            case 2:
                switch row {
                case 0:
                    ScheduleVariables.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleVariables.shared.selectedChoiceSession[2] = "short"
                case 1:
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
    
    //
    // MARK: Choice Functions
    func nextChoice() {
        // Next Table info
        slideLeft()
    }
    
    // Table View ------------------------------------
    // FOR SLIDING THROUGH GROUP CHOICES
    // Tableview slide left (next table)
    // Table View ------------------------------------
    // FOR SLIDING THROUGH GROUP CHOICES
    // Tableview slide left (next table)
    func slideLeft() {

        view.isUserInteractionEnabled = false

        // Slide across table
        let snapShotY = choiceTable.center.y
        // Snapshots
        let snapShot1 = choiceTable.snapshotView(afterScreenUpdates: false)
        snapShot1?.center = CGPoint(x: view.center.x, y: snapShotY)
        view.insertSubview((snapShot1)!, belowSubview: backButton)
        //
        choiceTable.reloadData()
        //
        let snapShot2 = choiceTable.snapshotView(afterScreenUpdates: true)
        snapShot2?.frame.origin = CGPoint(x: view.frame.maxX, y: choiceTable.frame.minY)
        view.insertSubview((snapShot2)!, belowSubview: snapShot1!)
        //
        choiceTable.isHidden = true
        // Animate new and old image to left
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
            snapShot2?.center.x = self.view.center.x

        }, completion: { finished in
            snapShot1?.removeFromSuperview()
            snapShot2?.removeFromSuperview()
            self.choiceTable.isHidden = false
            self.view.isUserInteractionEnabled = true
        })
        //
    }
    
    // FOR SLIDING THROUGH GROUP CHOICES
    // Tableview slide Right (previous table)
    func slideRight() {
        
        view.isUserInteractionEnabled = false
        
        // Slide table
        let snapShotY = choiceTable.center.y
        // Snapshots
        let snapShot1 = choiceTable.snapshotView(afterScreenUpdates: false)
        snapShot1?.center = CGPoint(x: view.center.x, y: snapShotY)
        view.insertSubview((snapShot1)!, belowSubview: backButton)
        //
        choiceTable.reloadData()
        // If going back to first choice of
        let snapShotImage = groupImage.snapshotView(afterScreenUpdates: false)
        if ScheduleVariables.shared.selectedGroup == Groups.extra {
            // nina
            view.insertSubview(snapShotImage!, belowSubview: snapShot1!)
            self.setupGroupImage()
        }

        let snapShot2 = choiceTable.snapshotView(afterScreenUpdates: true)
        if ScheduleVariables.shared.isExtraSession && ScheduleVariables.shared.selectedGroup == Groups.extra {
            backButtonTop.constant = -176 // Image height isn't changed till after animation, this puts the back button in the correct posisiton as anchored to image
            self.view.layoutIfNeeded()
            snapShot2?.frame.origin = CGPoint(x: view.frame.minX - view.frame.size.width, y: 0)
        } else {
            snapShot2?.center = CGPoint(x: view.center.x - view.frame.size.width, y: snapShotY)
        }
        if ScheduleVariables.shared.selectedGroup == Groups.extra {
            view.insertSubview((snapShot2)!, aboveSubview: snapShotImage!)
        } else {
            view.insertSubview((snapShot2)!, belowSubview: snapShot1!)
        }
        
        choiceTable.isHidden = true

        // Animate new and old image to left
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
            snapShot2?.center.x = self.view.center.x

        }, completion: { finished in
            self.backButtonTop.constant = 0
            snapShot1?.removeFromSuperview()
            snapShot2?.removeFromSuperview()
            snapShotImage?.removeFromSuperview()
            self.choiceTable.isHidden = false
            self.view.isUserInteractionEnabled = true
        })
    }

    
    // MARK:- Update Schedule Tracking
    // MARK: Mark as completed
    // Handler for the checkmark on the cell, the user can mark as completed themselves
    // Also marks as incomplete if previously comleted, note: rename
    @IBAction func markAsCompleted(_ sender: UIButton) {
        
        // Get indexPath.row
        let (day, indexInDay) = ScheduleVariables.shared.getIndexing(row: ScheduleVariables.shared.selectedRows.initial)
        let row = sender.tag
        ScheduleVariables.shared.updateCompletion(day: day, indexInDay: indexInDay, row: row)
        
        let indexPathToReload = NSIndexPath(row: row, section: 0)
        choiceTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
        
        // Return to schedule screen
        DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
            if ScheduleVariables.shared.isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: true) {
                ScheduleVariables.shared.shouldReloadInitialChoice = true
                self.popToRootView()
            }
        })
    }
    
    
    // MARK: Mark as completed and animate
    // if shouldReloadFinalChoice == true then this function is executed
    // Once having completed a session from the schedule, this function gets called upon return to the schedule, it reloads the necessary rows and animates back to initial screen if necessary
    func markAsCompletedAndAnimate() {
        // MARK AS COMPLETED
        if ScheduleVariables.shared.shouldReloadFinalChoice {
            ScheduleVariables.shared.shouldReloadFinalChoice = false
            
            // Get indexPath.row
            let (day, indexInDay) = ScheduleVariables.shared.getIndexing(row: ScheduleVariables.shared.selectedRows.initial)
            let row = ScheduleVariables.shared.selectedRows.final
            ScheduleVariables.shared.updateCompletion(day: day, indexInDay: indexInDay, row: row)
            
            // Animations
            // Delay so looks nice
            DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                
                // Reload the finalChoiceScreen Session after a delay
                let indexPathToReload = NSIndexPath(row: ScheduleVariables.shared.selectedRows.final, section: 0)
                self.choiceTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
                self.choiceTable.selectRow(at: indexPathToReload as IndexPath, animated: true, scrollPosition: .none)
                self.ensureCheckMarkGreen(indexPath: indexPathToReload as IndexPath)
                self.choiceTable.deselectRow(at: indexPathToReload as IndexPath, animated: true)

                // Pop if completed
                if ScheduleVariables.shared.isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: true) {
                    // Return to schedule screen
                    DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                        self.popToRootView()
                    })
                }
            })
        }
    }
    
    func ensureCheckMarkGreen(indexPath: IndexPath) {
        if let cell = self.choiceTable.cellForRow(at: indexPath as IndexPath) {
            for view in (cell.subviews) {
                if view is UIButton {
                    if let image = (view as! UIButton).imageView?.image, image == #imageLiteral(resourceName: "CheckMark") {
                        view.backgroundColor = Colors.green
                    }
                }
            }
        }
    }
    
    func popToRootView() {
        ScheduleVariables.shared.choiceProgress = 0
        self.navigationController?.popToRootViewController(animated: true)
        
    }
        
    
    // MARK:- Explanation of choices
    // Check if session choice needs an explanation
    func needsExplanation() -> Bool {
        switch ScheduleVariables.shared.selectedGroup {
            
        // Workout
        case Groups.workout:
            switch ScheduleVariables.shared.choiceProgress {
            case 2: return true
            default: return false
            }
            
        // Yoga
        case Groups.yoga:
            switch ScheduleVariables.shared.choiceProgress {
            case 1: return true
            default: return false
            }
            
        // Meditation
        case Groups.meditation:
            switch ScheduleVariables.shared.choiceProgress {
            default: return false
            }
            
        // Endurance
        case Groups.endurance:
            switch ScheduleVariables.shared.choiceProgress {
            case 1,4: return true
            default: return false
            }
            
        // Flexibility
        case Groups.flexibility:
            switch ScheduleVariables.shared.choiceProgress {
            default: return false
            }
            
        // Extra Sessions
        case Groups.extra:
            switch ScheduleVariables.shared.choiceProgress {
            case 1: return true
            default: return false
            }
            
        default: return false
        }
    }
    
    @objc func presentExplanation() {
        
        let text = sessionData.sessionChoiceExplanations[ScheduleVariables.shared.selectedGroup]![ScheduleVariables.shared.choiceProgress]!
        
        // Setup
        walkthroughNextButton.addTarget(self, action: #selector(explanationNextAction), for: .touchUpInside)
        walkthroughView = setWalkthrough(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, separator: walkthroughLabelSeparator, nextButton: walkthroughNextButton, backButton: walkthroughBackButton, highlight: walkthroughHighlight, simplePopup: true)
        
        // Label
        walkthroughLabelTitle.text = NSLocalizedString(text + "T", comment: "")
        
        walkthroughLabel.text = NSLocalizedString(text, comment: "")
        walkthroughLabel.frame.size = walkthroughLabel.sizeThatFits(CGSize(width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding, height: .greatestFiniteMagnitude))
        
        walkthroughLabel.frame = CGRect(
            x: WalkthroughVariables.padding,
            y: WalkthroughVariables.topHeight + WalkthroughVariables.padding,
            width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding,
            height: walkthroughLabel.frame.size.height)
        walkthroughLabelView.frame = CGRect(
            x: WalkthroughVariables.viewPadding,
            y: (tabBarController?.tabBar.frame.minY)! - WalkthroughVariables.topHeight - walkthroughLabel.frame.size.height - WalkthroughVariables.viewPadding - WalkthroughVariables.twicePadding,
            width: view.frame.size.width - WalkthroughVariables.twiceViewPadding,
            height: WalkthroughVariables.topHeight + walkthroughLabel.frame.size.height + WalkthroughVariables.twicePadding)
        
        // Colour
        walkthroughView.alpha = 1
        walkthroughLabelView.backgroundColor = Colors.dark
        walkthroughLabel.textColor = Colors.light
        walkthroughLabelTitle.textColor = Colors.light
        walkthroughLabelSeparator.backgroundColor = Colors.light
        walkthroughNextButton.setTitleColor(Colors.light, for: .normal)
        walkthroughBackButton.setTitleColor(Colors.light, for: .normal)
        
        // Highlight - none
        walkthroughHighlight.frame = CGRect.zero
    }
    @objc func explanationNextAction() {
        // Dismiss view
        UIView.animate(withDuration: 0.4, animations: {
            self.walkthroughView.alpha = 0
        }, completion: { finished in
            self.walkthroughView.alpha = 1
            self.walkthroughView.removeFromSuperview()
        })
    }
    
    
    // Previous Question
    func backAction() {
        // Table Counter
        // Return to choice 1 (sessions)
        if ScheduleVariables.shared.choiceProgress > 1 {
            switch ScheduleVariables.shared.selectedGroup {
            // Workout has 2 choice paths for the length + Custom
            case Groups.workout:
                switch ScheduleVariables.shared.choiceProgress {
                // Go back from custom
                case 7:
                    ScheduleVariables.shared.choiceProgress = 1
                // Go back from final choice
                case 6:
                    // Go back to length 1
                    if ScheduleVariables.shared.indicator == "gym" && ScheduleVariables.shared.indicator2 == "classic" {
                        ScheduleVariables.shared.choiceProgress = 4
                        // Go back to length 2
                    } else {
                        ScheduleVariables.shared.choiceProgress = 5
                    }
                // Go back from length choice
                case 5:
                    // Go back to chioce 3
                    ScheduleVariables.shared.choiceProgress = 3
                default:
                    ScheduleVariables.shared.choiceProgress -= 1
                }
            // Yoga has 3 choice paths for the length
            case Groups.yoga:
                switch ScheduleVariables.shared.choiceProgress {
                // Custom
                case 6:
                    ScheduleVariables.shared.choiceProgress = 1
                // Go back from final choice
                case 5:
                    // Go back to length 1
                    switch ScheduleVariables.shared.indicator {
                    case "relaxing":
                        ScheduleVariables.shared.choiceProgress = 2
                    case "neutral":
                        ScheduleVariables.shared.choiceProgress = 3
                    case "stimulating":
                        ScheduleVariables.shared.choiceProgress = 4
                    default: break
                    }
                // Go back from length choice
                case 4,3:
                    // Go back to chioce 3
                    ScheduleVariables.shared.choiceProgress = 1
                default:
                    ScheduleVariables.shared.choiceProgress -= 1
                }
            // Endurance has 3 choice paths
            case Groups.endurance:
                switch ScheduleVariables.shared.choiceProgress {
                // Custom
                case 9:
                    ScheduleVariables.shared.choiceProgress = 1
                case 6:
                    switch ScheduleVariables.shared.indicator {
                    case "bodyweight":
                        ScheduleVariables.shared.choiceProgress -= 1
                    case "hiit":
                        ScheduleVariables.shared.choiceProgress = 4
                    default: break
                    }
                    //
                // Steady State/Bodyweight skip back to first choice
                case 5,7:
                    ScheduleVariables.shared.choiceProgress = 1
                    
                default:
                    ScheduleVariables.shared.choiceProgress -= 1
                }
            // Stretching
            case Groups.flexibility:
                switch ScheduleVariables.shared.choiceProgress {
                // Custom
                case 4:
                    ScheduleVariables.shared.choiceProgress = 1
                default:
                    ScheduleVariables.shared.choiceProgress -= 1
                }
            // Normal
            default:
                ScheduleVariables.shared.choiceProgress -= 1
            }
            slideRight()
        // Return to choice 0 (groups)
        } else if ScheduleVariables.shared.choiceProgress == 1 {
            
            // If extra session, return to extra session choice
            if ScheduleVariables.shared.selectedGroup != Groups.extra && ScheduleVariables.shared.isExtraSession {
                ScheduleVariables.shared.selectedGroup = Groups.extra
                slideRight()
                
            // Normal
            } else {
                popToRootView()
            }
        }
    }
}
