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
        switch ScheduleManager.shared.selectedGroup {
        case Groups.workout:
            // Session Choice
            switch ScheduleManager.shared.choiceProgress {
            // Custom
            case 1:
                // Custom
                if row == 2 {
                    ScheduleManager.shared.choiceProgress = 7
                    nextChoice()
                } else {
                    ScheduleManager.shared.choiceProgress += 1
                    nextChoice()
                }
            // Go to length 1 or length 2 choice
            case 3:
                //
                if ScheduleManager.shared.indicator == "gym" && ScheduleManager.shared.indicator2 == "classic" {
                    ScheduleManager.shared.choiceProgress = 4
                    nextChoice()
                    //
                } else {
                    ScheduleManager.shared.choiceProgress = 5
                    nextChoice()
                }
            // Length 1 - Go to final choice
            case 4:
                ScheduleManager.shared.choiceProgress = 6
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
                ScheduleManager.shared.selectedRows.final = row
                performScheduleSegue()
            // Custom Choice
            case 7:
                // Indicate selected row
                ScheduleManager.shared.selectedRows.final = row
                
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
                ScheduleManager.shared.choiceProgress += 1
                nextChoice()
            }
            
        case Groups.yoga:
            // Session Choice
            switch ScheduleManager.shared.choiceProgress {
            // Go to correct length choice
            case 1:
                switch ScheduleManager.shared.indicator {
                case "relaxing":
                    ScheduleManager.shared.choiceProgress = 2
                    nextChoice()
                case "neutral":
                    ScheduleManager.shared.choiceProgress = 3
                    nextChoice()
                case "stimulating":
                    ScheduleManager.shared.choiceProgress = 4
                    nextChoice()
                default: break
                }
                // Custom
                if row == 3 {
                    ScheduleManager.shared.choiceProgress = 6
                    nextChoice()
                }
            // Go from length to final choice
            case 2,3:
                ScheduleManager.shared.choiceProgress = 5
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
                ScheduleManager.shared.selectedRows.final = row
                performScheduleSegue()
            // Custom
            case 6:
                // Indicate selected row
                ScheduleManager.shared.selectedRows.final = row
                
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                // If app chooses warmup/stretching
                if settings["CustomWarmupStretching"]![0] == 0 {
                    // Warmup
                    if row == 0 {
                        selectedComponent = 0
                        selectWarmup()
                        ScheduleManager.shared.selectedRows.final = row
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
                ScheduleManager.shared.choiceProgress += 1
                nextChoice()
            }
            
        // Meditation
        case Groups.meditation:
            // Session Choice
            switch ScheduleManager.shared.choiceProgress {
            // Select meditation style - timer, 'guided'
            case 1:
                ScheduleManager.shared.selectedRows.final = row // used to be 72 NINA
                // Timer
                if row == 0 {
                    performSegue(withIdentifier: "scheduleMeditationSegueTimer", sender: self)
                    // Guided
                } else {
                    performSegue(withIdentifier: "scheduleMeditationSegueGuided", sender: self)
                }
            default:
                ScheduleManager.shared.choiceProgress += 1
                nextChoice()
            }
            
            // ------------------------------------------------------------------------------------------------
        // Endurance
        case Groups.endurance:
            switch ScheduleManager.shared.choiceProgress {
            // Type 1, hiit vs steady state
            case 1:
                // HIIT
                if row == 0 {
                    ScheduleManager.shared.choiceProgress += 1
                    nextChoice()
                    // Workout
                } else if row == 1 {
                    ScheduleManager.shared.choiceProgress = 5
                    nextChoice()
                    // Steady state cardio
                } else if row == 2 {
                    ScheduleManager.shared.choiceProgress = 7
                    nextChoice()
                    // Custom
                } else if row == 3 {
                    ScheduleManager.shared.choiceProgress = 9
                    nextChoice()
                }
            // Go straight to final choice from hiit length
            case 4:
                ScheduleManager.shared.choiceProgress = 6
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
                ScheduleManager.shared.selectedRows.final = row
                performScheduleSegue()
                
            // Final choice steady state
            case 7:
                // Select now as this choice is final choice (even if you choose the length afterwards)
                ScheduleManager.shared.selectedRows.final = row
                if row == 1 {
                    endurancePopup()
                } else {
                    if row == 0 {
                        steadyStateChoice = 0
                    } else if row == 2 {
                        steadyStateChoice = 1
                    }
                    //
                    ScheduleManager.shared.choiceProgress += 1
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
                ScheduleManager.shared.choiceProgress -= 1
                nextChoice()
            // Custom
            case 9:
                // Indicate selected row
                ScheduleManager.shared.selectedRows.final = row
                
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
                        SelectedSession.shared.selectedSession[0] = "endurance"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                    
                    } else if row == 2 {
                        selectedComponent = 2
                        selectStretching()
                        performScheduleSegue()
                    }
                    // If custom warmup/stretching
                } else if settings["CustomWarmupStretching"]![0] == 1 {
                    // Warmup
                    if row == 0 {
                        // Select warmup
                        SelectedSession.shared.selectedSession[0] = "warmup"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                    // Session
                    } else if row == 1 {
                        // Select workout
                        SelectedSession.shared.selectedSession[0] = "endurance"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                    // Stretching
                    } else if row == 2 {
                        // Select stretching
                        SelectedSession.shared.selectedSession[0] = "stretching"
                        performSegue(withIdentifier: "scheduleSegueCustom", sender: self)
                    }
                }
                
            default:
                ScheduleManager.shared.choiceProgress += 1
                nextChoice()
            }
            
            // ------------------------------------------------------------------------------------------------
        // Flexibility
        case Groups.flexibility:
            switch ScheduleManager.shared.choiceProgress {
            //
            case 1:
                switch row {
                // Custom
                case 5:
                    ScheduleManager.shared.choiceProgress = 4
                    nextChoice()
                default:
                    ScheduleManager.shared.choiceProgress += 1
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
                ScheduleManager.shared.selectedRows.final = row
                performScheduleSegue()
            // Custom
            case 4:
                // Indicate selected row
                ScheduleManager.shared.selectedRows.final = row
                
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
                ScheduleManager.shared.choiceProgress += 1
                nextChoice()
            }
            
        // Extra Session
        case Groups.extra:
            
            switch ScheduleManager.shared.choiceProgress {
            //
            case 1:
                
                let groupString = row.groupFromInt()

                // Select correct session type
                ScheduleManager.shared.selectedGroup = Groups(rawValue: groupString) ?? Groups.none
                
                // Update selected choice
                // selectedChoice...[0] to group
                ScheduleManager.shared.selectedChoiceWarmup[0] = groupString
                ScheduleManager.shared.selectedChoiceSession[0] = groupString
                // Notes ScheduleVariables.shared.selectedChoiceStretching not always used but set anyway for all, no harm done
                ScheduleManager.shared.selectedChoiceStretching[0] = groupString
                
                nextChoice()
                
                setupGroupImage()
                
            // Choice
            default:
                ScheduleManager.shared.choiceProgress += 1
                nextChoice()
            }
            
        default:
            break
        }
    }
    
    // MARK: Perform schedule Segue
    func performScheduleSegue() {
        // App chooses session
        if ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["customSessionChoice"] as! Int == 0 {
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
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        //
        // Action
        let okAction = UIAlertAction(title: NSLocalizedString("done", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            // Reload
            ScheduleManager.shared.shouldReloadScheduleTracking()
            let indexPath = NSIndexPath(row: ScheduleManager.shared.selectedRows.final, section: 0)
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
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertAction.Style.default) {
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
        switch ScheduleManager.shared.selectedGroup {
        // Workout
        case Groups.workout:
            selectedWarmup.append("workout")
        // Yoga, Flexibility (same warmups)
        case Groups.yoga, Groups.flexibility:
            selectedWarmup.append("stretching")
        // Endurance
        case Groups.endurance:
            selectedWarmup.append("endurance")
        default: break
        }
        
        // No difficulty level for warmup so default is average
        ScheduleManager.shared.selectedChoiceWarmup[3] = "average"
        
        // Select Random Session
        let choices = sessionData.sortedSessions[ScheduleManager.shared.selectedChoiceWarmup[0]]![ScheduleManager.shared.selectedChoiceWarmup[1]]![ScheduleManager.shared.selectedChoiceWarmup[2]]![ScheduleManager.shared.selectedChoiceWarmup[3]]!
        let random = Int(arc4random_uniform(UInt32(choices.count)))
        selectedWarmup.append(choices[random])
        //
        SelectedSession.shared.selectedSession = selectedWarmup
    }
    // Session
    func selectSession() {
        
        var selectedSession: [String] = []
        
        // Cases for session types
        switch ScheduleManager.shared.selectedGroup {
        // Workout
        case Groups.workout:
            selectedSession.append("workout")
            selectedSession.append(ScheduleManager.shared.selectedChoiceSession[1]) // Workout type
        // Yoga
        case Groups.yoga:
            selectedSession.append("yoga")
            selectedSession.append(ScheduleManager.shared.indicator) // relaxing, neutral, stimulating
        // Endurance
        case Groups.endurance:
            selectedSession.append("endurance")
            selectedSession.append(ScheduleManager.shared.indicator) // hiit or bodyweight
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
        let group = ScheduleManager.shared.selectedGroup.rawValue
        
        // Cases for session types
        switch ScheduleManager.shared.selectedGroup {
        // Workout
        case Groups.workout:
            switch ScheduleManager.shared.selectedChoiceSession[1] {
            // Full
            case "classicGymFull", "circuitGymFull", "classicBodyweightFull", "circuitBodyweightFull":
                ScheduleManager.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["workout"]!]
            // Upper
            case "classicGymUpper", "circuitGymUpper", "classicBodyweightUpper", "circuitBodyweightUpper":
                ScheduleManager.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["workoutUpper"]!]
            // Lower
            case "classicGymLower", "circuitGymLower", "classicBodyweightLower", "circuitBodyweightLower":
                ScheduleManager.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["workoutLower"]!]
                
            default: break
            }
        // Yoga
        case Groups.yoga:
            ScheduleManager.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["yoga"]!]
        // Endurance
        case Groups.endurance:
            // HIIT is not indexed through difficulty, but rather two levels of length (session and interval) which have already been set by updateSelectedChoice
            if ScheduleManager.shared.indicator == "hiit" {
                break
            } else {
                ScheduleManager.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["endurance"]!]
            }
            
        // Flexibility
        case Groups.flexibility:
            switch ScheduleManager.shared.selectedChoiceSession[1] {
            case "full":
                ScheduleManager.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["overall"]!]
            case "hamstrings":
                ScheduleManager.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["hamstrings"]!]
            case "hips":
                ScheduleManager.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["hips"]!]
            case "backNeck":
                ScheduleManager.shared.selectedChoiceSession[3] = difficultyArray[difficultyLevels[group]!["backNeck"]!]
            case "foamRoll":
                // only one difficulty
                ScheduleManager.shared.selectedChoiceSession[3] = "average"
            default: break
            }
        default: break
        }
        
        // Select Random Session
        var randomSessionString = randomSession(selectedChoice: ScheduleManager.shared.selectedChoiceSession)
        
        // WORKOUT - Checks for Women, and bodyweight pullup bar
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [String: Int]
        
        //
        if ScheduleManager.shared.selectedGroup == Groups.workout {
            // Women - only applies for gym workouts
            if ScheduleManager.shared.selectedChoiceSession[1].contains("Gym") {
                // User is a woman
                // Gender is second question, female or other == 1 or 2 (we give 'other' female workouts for now)
                if profileAnswers["gender"]! > 0 {
                    // Avoid sessions that are for men
                    while randomSessionString.contains("-M") {
                        randomSessionString = randomSession(selectedChoice: ScheduleManager.shared.selectedChoiceSession)
                    }
                    // User is a man
                } else {
                    // Avoid sessions that are for women
                    while randomSessionString.contains("-W") {
                        randomSessionString = randomSession(selectedChoice: ScheduleManager.shared.selectedChoiceSession)
                    }
                }
                
                // Equipment - only applies for bodyweight workouts
            } else {
                // No equipment (currently just a pullup bar)
                if ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["pullupBar"] as! Int == 0 {
                    while randomSessionString.contains("-E") {
                        randomSessionString = randomSession(selectedChoice: ScheduleManager.shared.selectedChoiceSession)
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
        switch ScheduleManager.shared.selectedGroup {
        // Workout
        case Groups.workout:
            selectedStretching.append("postWorkout")
        // Endurance
        case Groups.endurance:
            selectedStretching.append("postCardio")
        default: break
        }
        
        // No difficulty level for warmup so default is average
        ScheduleManager.shared.selectedChoiceStretching[3] = "average"
        
        // Select Random Session
        var randomSessionString = randomSession(selectedChoice: ScheduleManager.shared.selectedChoiceStretching)
        // Not foam rolling (if foam rolling on, can include non foam rolling sessions)
        
        if ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["foamRoller"] as! Int == 0 {
            // NOT Foam rolling (avoid a stretching session that ends in -F)
            while randomSessionString.suffix(2) == "-F" {
                randomSessionString = randomSession(selectedChoice: ScheduleManager.shared.selectedChoiceStretching)
            }
        } else if ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["foamRoller"] as! Int == 1 {
            // Foam rolling (get only stretching session that end in -F)
            while randomSessionString.suffix(2) != "-F" {
                randomSessionString = randomSession(selectedChoice: ScheduleManager.shared.selectedChoiceStretching)
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
        switch ScheduleManager.shared.selectedGroup {
            // ------------------------------------------------------------------------------------------------
        // Workout
        case Groups.workout:
            switch ScheduleManager.shared.choiceProgress {
            // Gym/Bodyweight
            case 1:
                // Reset ScheduleVariables.shared.indicator
                ScheduleManager.shared.indicator = ""
                
                switch row {
                // Gym
                case 0:
                    ScheduleManager.shared.indicator = "gym"
                // Bodyweight
                case 1:
                    ScheduleManager.shared.indicator = "bodyweight"
                // Custom - just set to bodyweight short,
                case 2:
                    ScheduleManager.shared.selectedChoiceWarmup[1] = "WaF"
                    ScheduleManager.shared.selectedChoiceStretching[1] = "SF"
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceStretching[2] = "short"
                default: break
                }
                
            // Circuit/Classic
            case 2:
                // Reset ScheduleVariables.shared.indicator
                ScheduleManager.shared.indicator2 = ""
                
                switch row {
                // Classic
                case 0:
                    ScheduleManager.shared.indicator2 = "classic"
                // Circuit
                case 1:
                    ScheduleManager.shared.indicator2 = "circuit"
                default: break
                }
                
            // Focus
            case 3:
                // Note only session different for now
                // Gym
                if ScheduleManager.shared.indicator == "gym" {
                    // Classic
                    if ScheduleManager.shared.indicator2 == "classic" {
                        switch row {
                        case 0:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaF"
                            ScheduleManager.shared.selectedChoiceSession[1] = "classicGymFull"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SF"
                        case 1:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaU"
                            ScheduleManager.shared.selectedChoiceSession[1] = "classicGymUpper"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SU"
                        case 2:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaL"
                            ScheduleManager.shared.selectedChoiceSession[1] = "classicGymLower"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SL"
                        default: break
                        }
                        // Circuit
                    } else if ScheduleManager.shared.indicator2 == "circuit" {
                        switch row {
                        case 0:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaF"
                            ScheduleManager.shared.selectedChoiceSession[1] = "circuitGymFull"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SF"
                        case 1:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaU"
                            ScheduleManager.shared.selectedChoiceSession[1] = "circuitGymUpper"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SU"
                        case 2:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaL"
                            ScheduleManager.shared.selectedChoiceSession[1] = "circuitGymLower"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SL"
                        default: break
                        }
                    }
                    // Bodyweight
                } else if ScheduleManager.shared.indicator == "bodyweight" {
                    // Classic
                    if ScheduleManager.shared.indicator2 == "classic" {
                        switch row {
                        case 0:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaF"
                            ScheduleManager.shared.selectedChoiceSession[1] = "classicBodyweightFull"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SF"
                        case 1:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaU"
                            ScheduleManager.shared.selectedChoiceSession[1] = "classicBodyweightUpper"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SU"
                        case 2:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaL"
                            ScheduleManager.shared.selectedChoiceSession[1] = "classicBodyweightLower"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SL"
                        default: break
                        }
                        // Circuit
                    } else if ScheduleManager.shared.indicator2 == "circuit" {
                        switch row {
                        case 0:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaF"
                            ScheduleManager.shared.selectedChoiceSession[1] = "circuitBodyweightFull"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SF"
                        case 1:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaU"
                            ScheduleManager.shared.selectedChoiceSession[1] = "circuitBodyweightUpper"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SU"
                        case 2:
                            ScheduleManager.shared.selectedChoiceWarmup[1] = "WaL"
                            ScheduleManager.shared.selectedChoiceSession[1] = "circuitBodyweightLower"
                            ScheduleManager.shared.selectedChoiceStretching[1] = "SL"
                        default: break
                        }
                    }
                }
            // Length
            case 4,5:
                // Note, currently all the same
                // Gym
                if ScheduleManager.shared.indicator == "gym" {
                    // Classic
                    if ScheduleManager.shared.indicator2 == "classic" {
                        switch row {
                        case 0:
                            ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleManager.shared.selectedChoiceSession[2] = "short"
                            ScheduleManager.shared.selectedChoiceStretching[2] = "short"
                        case 1:
                            ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleManager.shared.selectedChoiceSession[2] = "medium"
                            ScheduleManager.shared.selectedChoiceStretching[2] = "short"
                        case 2:
                            ScheduleManager.shared.selectedChoiceWarmup[2] = "normal"
                            ScheduleManager.shared.selectedChoiceSession[2] = "long"
                            ScheduleManager.shared.selectedChoiceStretching[2] = "normal"
                        default: break
                        }
                        // Circuit
                    } else if ScheduleManager.shared.indicator2 == "circuit" {
                        switch row {
                        case 0:
                            ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleManager.shared.selectedChoiceSession[2] = "short"
                            ScheduleManager.shared.selectedChoiceStretching[2] = "short"
                        case 1:
                            ScheduleManager.shared.selectedChoiceWarmup[2] = "normal"
                            ScheduleManager.shared.selectedChoiceSession[2] = "normal"
                            ScheduleManager.shared.selectedChoiceStretching[2] = "normal"
                        default: break
                        }
                    }
                    // Bodyweight
                } else if ScheduleManager.shared.indicator == "bodyweight" {
                    // Classic
                    if ScheduleManager.shared.indicator2 == "classic" {
                        switch row {
                        case 0:
                            ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleManager.shared.selectedChoiceSession[2] = "short"
                            ScheduleManager.shared.selectedChoiceStretching[2] = "short"
                        case 1:
                            ScheduleManager.shared.selectedChoiceWarmup[2] = "normal"
                            ScheduleManager.shared.selectedChoiceSession[2] = "normal"
                            ScheduleManager.shared.selectedChoiceStretching[2] = "normal"
                        default: break
                        }
                        // Circuit
                    } else if ScheduleManager.shared.indicator2 == "circuit" {
                        switch row {
                        case 0:
                            ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                            ScheduleManager.shared.selectedChoiceSession[2] = "short"
                            ScheduleManager.shared.selectedChoiceStretching[2] = "short"
                        case 1:
                            ScheduleManager.shared.selectedChoiceWarmup[2] = "normal"
                            ScheduleManager.shared.selectedChoiceSession[2] = "normal"
                            ScheduleManager.shared.selectedChoiceStretching[2] = "normal"
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
            switch ScheduleManager.shared.choiceProgress {
            // Yoga Type
            case 1:
                // Reset ScheduleVariables.shared.indicator
                ScheduleManager.shared.indicator = ""
                
                switch row {
                // Relaxing
                case 0:
                    ScheduleManager.shared.indicator = "relaxing"
                    ScheduleManager.shared.selectedChoiceSession[1] = "relaxing"
                // Neutral
                case 1:
                    ScheduleManager.shared.indicator = "neutral"
                    ScheduleManager.shared.selectedChoiceSession[1] = "neutral"
                // Stimulating
                case 2:
                    ScheduleManager.shared.indicator = "stimulating"
                    ScheduleManager.shared.selectedChoiceSession[1] = "stimulating"
                // Custom
                case 3:
                    // Length
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                default: break
                }
                
                // Warmup
                ScheduleManager.shared.selectedChoiceWarmup[1] = "warmup"
                
                
            // Length 1 - Relaxing
            case 2:
                //
                switch row {
                case 0:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceSession[2] = "veryShort"
                case 1:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceSession[2] = "short"
                case 2:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceSession[2] = "medium"
                case 3:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "normal"
                    ScheduleManager.shared.selectedChoiceSession[2] = "long"
                default: break
                }
            // Length 2 - Neutral
            case 3:
                //
                switch row {
                case 0:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceSession[2] = "short"
                case 1:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceSession[2] = "medium"
                case 2:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceSession[2] = "long"
                default: break
                }
            // Length 3 - Stimulating
            case 4:
                //
                switch row {
                case 0:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceSession[2] = "short"
                case 1:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceSession[2] = "normal"
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
            switch ScheduleManager.shared.choiceProgress {
            // Cardio Type
            case 1:
                // Reset indication
                ScheduleManager.shared.indicator = ""
                //
                switch row {
                case 0:
                    // Indicate to choice 3
                    ScheduleManager.shared.indicator = "hiit"
                case 1:
                    ScheduleManager.shared.indicator = "bodyweight"
                    ScheduleManager.shared.selectedChoiceWarmup[1] = "warmup"
                    ScheduleManager.shared.selectedChoiceSession[1] = "bodyweight"
                    ScheduleManager.shared.selectedChoiceStretching[1] = "stretching"
                case 2:
                    ScheduleManager.shared.selectedChoiceWarmup[1] = "warmup"
                    ScheduleManager.shared.selectedChoiceStretching[1] = "stretching"
                case 3:
                    ScheduleManager.shared.selectedChoiceWarmup[1] = "warmup"
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceStretching[1] = "stretching"
                    ScheduleManager.shared.selectedChoiceStretching[2] = "short"
                default: break
                }
                //
            // HIIT ?Rowing/Biking/Running or workout length
            case 2:
                // Cardio Type
                switch row {
                // Running
                case 0:
                    ScheduleManager.shared.selectedChoiceWarmup[1] = "warmup"
                    ScheduleManager.shared.selectedChoiceSession[1] = "hiit"
                    ScheduleManager.shared.selectedChoiceStretching[1] = "stretching"
                // Biking
                case 1:
                    ScheduleManager.shared.selectedChoiceWarmup[1] = "warmup"
                    ScheduleManager.shared.selectedChoiceSession[1] = "hiit"
                    ScheduleManager.shared.selectedChoiceStretching[1] = "stretching"
                // Rowing
                case 2:
                    ScheduleManager.shared.selectedChoiceWarmup[1] = "warmup"
                    ScheduleManager.shared.selectedChoiceSession[1] = "hiit"
                    ScheduleManager.shared.selectedChoiceStretching[1] = "stretching"
                default: break
                }
            // Length: HIIT&Bodyweight
            case 3,5:
                // HIIT
                if ScheduleManager.shared.indicator == "hiit" {
                    switch row {
                    case 0:
                        ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleManager.shared.selectedChoiceSession[2] = "short"
                        ScheduleManager.shared.selectedChoiceStretching[2] = "short"
                    case 1:
                        ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleManager.shared.selectedChoiceSession[2] = "medium"
                        ScheduleManager.shared.selectedChoiceStretching[2] = "short"
                    case 2:
                        ScheduleManager.shared.selectedChoiceWarmup[2] = "normal"
                        ScheduleManager.shared.selectedChoiceSession[2] = "long"
                        ScheduleManager.shared.selectedChoiceStretching[2] = "normal"
                    default: break
                    }
                    // Workout
                } else {
                    switch row {
                    case 0:
                        ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                        ScheduleManager.shared.selectedChoiceSession[2] = "short"
                        ScheduleManager.shared.selectedChoiceStretching[2] = "short"
                    case 1:
                        ScheduleManager.shared.selectedChoiceWarmup[2] = "normal"
                        ScheduleManager.shared.selectedChoiceSession[2] = "normal"
                        ScheduleManager.shared.selectedChoiceStretching[2] = "normal"
                    default: break
                    }
                }
                
            // HIIT interval Length
            case 4:
                // HIIT
                switch row {
                case 0:
                    ScheduleManager.shared.selectedChoiceSession[3] = "short"
                case 1:
                    ScheduleManager.shared.selectedChoiceSession[3] = "medium"
                case 2:
                    ScheduleManager.shared.selectedChoiceSession[3] = "long"
                default: break
                }
                
                //
            // Steady State Length
            case 8:
                switch row {
                case 0:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceStretching[2] = "short"
                case 1:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "normal"
                    ScheduleManager.shared.selectedChoiceStretching[2] = "normal"
                default: break
                }
            default:
                break
            }
            // ------------------------------------------------------------------------------------------------
        // Flexibility
        case Groups.flexibility:
            switch ScheduleManager.shared.choiceProgress {
            // Focus
            case 1:
                // Note warmups the same for now
                switch row {
                case 0:
                    ScheduleManager.shared.selectedChoiceSession[1] = "full"
                case 1:
                    ScheduleManager.shared.selectedChoiceSession[1] = "hamstrings"
                case 2:
                    ScheduleManager.shared.selectedChoiceSession[1] = "hips"
                case 3:
                    ScheduleManager.shared.selectedChoiceSession[1] = "backNeck"
                case 4:
                    ScheduleManager.shared.selectedChoiceSession[1] = "foamRoll"
                // Custom
                case 5:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                default: break
                }
                ScheduleManager.shared.selectedChoiceWarmup[1] = "warmup"
                
            // Length
            case 2:
                switch row {
                case 0:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "short"
                    ScheduleManager.shared.selectedChoiceSession[2] = "short"
                case 1:
                    ScheduleManager.shared.selectedChoiceWarmup[2] = "normal"
                    ScheduleManager.shared.selectedChoiceSession[2] = "normal"
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
            
            /// Extra session has a mask at the top to hide the image, animate it off with the table if leaving extra session choice
            if ScheduleManager.shared.isExtraSession && ScheduleManager.shared.choiceProgress == 1 {
                self.extraSessionMask.center.x = self.view.center.x - self.view.frame.size.width
            }

        }, completion: { finished in
            snapShot1?.removeFromSuperview()
            snapShot2?.removeFromSuperview()
            self.choiceTable.isHidden = false
            self.view.isUserInteractionEnabled = true
            
            if ScheduleManager.shared.isExtraSession && ScheduleManager.shared.choiceProgress == 1 {
                self.extraSessionMask.removeFromSuperview()
            }
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
        if ScheduleManager.shared.selectedGroup == Groups.extra {
            // nina
            view.insertSubview(snapShotImage!, belowSubview: snapShot1!)
            self.setupGroupImage()
        }

        let snapShot2 = choiceTable.snapshotView(afterScreenUpdates: true)
        if ScheduleManager.shared.isExtraSession && ScheduleManager.shared.selectedGroup == Groups.extra {
            // Image height isn't changed till after animation, this puts the back button in the correct posisiton as anchored to image
            backButtonTop.constant = -groupImageHeight.constant + ElementHeights.topSafeAreaInset // -176
            self.view.layoutIfNeeded()
            snapShot2?.frame.origin = CGPoint(x: view.frame.minX - view.frame.size.width, y: backButton.frame.minY)
            self.extraSessionMask.center.x = self.view.center.x - self.view.frame.size.width
            self.view.addSubview(self.extraSessionMask)
        } else {
            snapShot2?.center = CGPoint(x: view.center.x - view.frame.size.width, y: snapShotY)
        }
        if ScheduleManager.shared.selectedGroup == Groups.extra {
            view.insertSubview((snapShot2)!, aboveSubview: snapShotImage!)
        } else {
            view.insertSubview((snapShot2)!, belowSubview: snapShot1!)
        }
        
        choiceTable.isHidden = true

        // Animate new and old image to left
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
            snapShot2?.center.x = self.view.center.x
            
            if ScheduleManager.shared.isExtraSession && ScheduleManager.shared.selectedGroup == Groups.extra {
                self.extraSessionMask.center.x = self.view.center.x
            }

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
        let (day, indexInDay) = ScheduleManager.shared.getIndexing(row: ScheduleManager.shared.selectedRows.initial)
        let row = sender.tag
        ScheduleManager.shared.updateCompletion(day: day, indexInDay: indexInDay, row: row)
        
        let indexPathToReload = NSIndexPath(row: row, section: 0)
        choiceTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
        
        // Return to schedule screen
        DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
            if ScheduleManager.shared.isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: true) {
                ScheduleManager.shared.shouldReloadInitialChoice = true
                self.popToRootView()
            }
        })
    }
    
    
    // MARK: Mark as completed and animate
    // if shouldReloadFinalChoice == true then this function is executed
    // Once having completed a session from the schedule, this function gets called upon return to the schedule, it reloads the necessary rows and animates back to initial screen if necessary
    func markAsCompletedAndAnimate() {
        // MARK AS COMPLETED
        if ScheduleManager.shared.shouldReloadFinalChoice {
            ScheduleManager.shared.shouldReloadFinalChoice = false
            
            // Get indexPath.row
            let (day, indexInDay) = ScheduleManager.shared.getIndexing(row: ScheduleManager.shared.selectedRows.initial)
            let row = ScheduleManager.shared.selectedRows.final
            ScheduleManager.shared.updateCompletion(day: day, indexInDay: indexInDay, row: row)
            
            // Animations
            // Delay so looks nice
            DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                
                // Reload the finalChoiceScreen Session after a delay
                let indexPathToReload = NSIndexPath(row: ScheduleManager.shared.selectedRows.final, section: 0)
                self.choiceTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
                self.choiceTable.selectRow(at: indexPathToReload as IndexPath, animated: true, scrollPosition: .none)
                self.ensureCheckMarkGreen(indexPath: indexPathToReload as IndexPath)
                self.choiceTable.deselectRow(at: indexPathToReload as IndexPath, animated: true)

                // Pop if completed
                if ScheduleManager.shared.isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: true) {
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
        ScheduleManager.shared.choiceProgress = 0
        self.navigationController?.popToRootViewController(animated: true)
        
    }
        
    
    // MARK:- Explanation of choices
    // Check if session choice needs an explanation
    func needsExplanation() -> Bool {
        switch ScheduleManager.shared.selectedGroup {
            
        // Workout
        case Groups.workout:
            switch ScheduleManager.shared.choiceProgress {
            case 2: return true
            default: return false
            }
            
        // Yoga
        case Groups.yoga:
            switch ScheduleManager.shared.choiceProgress {
            case 1: return true
            default: return false
            }
            
        // Meditation
        case Groups.meditation:
            switch ScheduleManager.shared.choiceProgress {
            default: return false
            }
            
        // Endurance
        case Groups.endurance:
            switch ScheduleManager.shared.choiceProgress {
            case 1,4: return true
            default: return false
            }
            
        // Flexibility
        case Groups.flexibility:
            switch ScheduleManager.shared.choiceProgress {
            default: return false
            }
            
        // Extra Sessions
        case Groups.extra:
            switch ScheduleManager.shared.choiceProgress {
            case 1: return true
            default: return false
            }
            
        default: return false
        }
    }
    
    @objc func presentExplanation() {
        
        let text = sessionData.sessionChoiceExplanations[ScheduleManager.shared.selectedGroup]![ScheduleManager.shared.choiceProgress]!
        
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
        if ScheduleManager.shared.choiceProgress > 1 {
            switch ScheduleManager.shared.selectedGroup {
            // Workout has 2 choice paths for the length + Custom
            case Groups.workout:
                switch ScheduleManager.shared.choiceProgress {
                // Go back from custom
                case 7:
                    ScheduleManager.shared.choiceProgress = 1
                // Go back from final choice
                case 6:
                    // Go back to length 1
                    if ScheduleManager.shared.indicator == "gym" && ScheduleManager.shared.indicator2 == "classic" {
                        ScheduleManager.shared.choiceProgress = 4
                        // Go back to length 2
                    } else {
                        ScheduleManager.shared.choiceProgress = 5
                    }
                // Go back from length choice
                case 5:
                    // Go back to chioce 3
                    ScheduleManager.shared.choiceProgress = 3
                default:
                    ScheduleManager.shared.choiceProgress -= 1
                }
            // Yoga has 3 choice paths for the length
            case Groups.yoga:
                switch ScheduleManager.shared.choiceProgress {
                // Custom
                case 6:
                    ScheduleManager.shared.choiceProgress = 1
                // Go back from final choice
                case 5:
                    // Go back to length 1
                    switch ScheduleManager.shared.indicator {
                    case "relaxing":
                        ScheduleManager.shared.choiceProgress = 2
                    case "neutral":
                        ScheduleManager.shared.choiceProgress = 3
                    case "stimulating":
                        ScheduleManager.shared.choiceProgress = 4
                    default: break
                    }
                // Go back from length choice
                case 4,3:
                    // Go back to chioce 3
                    ScheduleManager.shared.choiceProgress = 1
                default:
                    ScheduleManager.shared.choiceProgress -= 1
                }
            // Endurance has 3 choice paths
            case Groups.endurance:
                switch ScheduleManager.shared.choiceProgress {
                // Custom
                case 9:
                    ScheduleManager.shared.choiceProgress = 1
                case 6:
                    switch ScheduleManager.shared.indicator {
                    case "bodyweight":
                        ScheduleManager.shared.choiceProgress -= 1
                    case "hiit":
                        ScheduleManager.shared.choiceProgress = 4
                    default: break
                    }
                    //
                // Steady State/Bodyweight skip back to first choice
                case 5,7:
                    ScheduleManager.shared.choiceProgress = 1
                    
                default:
                    ScheduleManager.shared.choiceProgress -= 1
                }
            // Stretching
            case Groups.flexibility:
                switch ScheduleManager.shared.choiceProgress {
                // Custom
                case 4:
                    ScheduleManager.shared.choiceProgress = 1
                default:
                    ScheduleManager.shared.choiceProgress -= 1
                }
            // Normal
            default:
                ScheduleManager.shared.choiceProgress -= 1
            }
            slideRight()
        // Return to choice 0 (groups)
        } else if ScheduleManager.shared.choiceProgress == 1 {
            
            // If extra session, return to extra session choice
            if ScheduleManager.shared.selectedGroup != Groups.extra && ScheduleManager.shared.isExtraSession {
                ScheduleManager.shared.selectedGroup = Groups.extra
                slideRight()
                
            // Normal
            } else {
                popToRootView()
            }
        }
    }
}
