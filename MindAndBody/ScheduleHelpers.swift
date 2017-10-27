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
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Int]]]

        updateSelectedChoice(row: row)
        // ------------------------------------------------------------------------------------------------
        // Next Choice Function
        if choiceProgress[0] == -1 && row != schedules[0][selectedDay].count {
            choiceProgress[0] = schedules[0][selectedDay][row]
            choiceProgress[1] += 1
            maskView()
            // Next Table info
            slideLeft()
            
            //
        } else {
            // Present next choice or present session
            switch choiceProgress[0] {
                // ------------------------------------------------------------------------------------------------
            // Mind
            case 0:
                // Session Choice
                switch choiceProgress[1] {
                // First choice - yoga, meditation, walk
                case 1:
                    // Yoga, more choices
                    if row == 1 {
                        choiceProgress[1] += 1
                        nextChoice()
                        // Go to Meditation screen
                    } else if row == 2 {
                        // Meditation
                        choiceProgress[1] = 5
                        nextChoice()
                        // Walk, popup
                    } else if row == 3 {
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
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                case 5:
                    // Timer
                    if row == 1 {
                        performSegue(withIdentifier: "scheduleMeditationSegueTimer", sender: self)
                        // Guided
                    } else {
                        performSegue(withIdentifier: "scheduleMeditationSegueGuided", sender: self)
                    }
                default:
                    choiceProgress[1] += 1
                    nextChoice()
                }
                
                // ------------------------------------------------------------------------------------------------
            // Flexibility
            case 1:
                // Final choice -> session
                if choiceProgress[1] == 4 {
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
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                // Choice
                } else {
                    choiceProgress[1] += 1
                    nextChoice()
                }
                
                // ------------------------------------------------------------------------------------------------
            // Endurance
            case 2:
                switch choiceProgress[1] {
                // Type 1, hiit vs steady state
                case 1:
                    // Workout
                    if row == 2 {
                        choiceProgress[1] = 3
                        nextChoice()
                    // Steady state cardio
                    } else if row == 3 {
                        choiceProgress[1] = 5
                        nextChoice()
                    } else {
                        choiceProgress[1] += 1
                        nextChoice()
                    }
                case 3:
                    choiceProgress[1] += 1
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
                        choiceProgress[1] += 1
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
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                    //
                    choiceProgress[1] -= 1
                    nextChoice()
                default:
                    choiceProgress[1] += 1
                    nextChoice()
                }
                
                // ------------------------------------------------------------------------------------------------
            // Toning
            case 3:
                // Cardio
                if choiceProgress[1] == 1 && row == 2 {
                    choiceProgress[1] = 5
                    nextChoice()
                // Final choice workout
                } else if choiceProgress[1] == 4 || choiceProgress[1] == 6 {
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
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                } else {
                    choiceProgress[1] += 1
                    nextChoice()
                }
                
                // ------------------------------------------------------------------------------------------------
            // Muscle Gain
            case 4:
                // Session Choice
                if choiceProgress[1] == 4 {
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
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                } else {
                    choiceProgress[1] += 1
                    nextChoice()
                }
                
                // ------------------------------------------------------------------------------------------------
            // Strength
            case 5:
                // Session Choice
                if choiceProgress[1] == 4 {
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
                    performSegue(withIdentifier: "scheduleSegueOverview", sender: self)
                } else {
                    choiceProgress[1] += 1
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
        selectedSession = sessionData.sortedSessions[selectedChoiceWarmup[0]]![selectedChoiceWarmup[1]][selectedChoiceWarmup[2]][selectedChoiceWarmup[3]][selectedChoiceWarmup[4]][selectedChoiceWarmup[5]]
    }
    // Session
    func selectSession() {
        selectedSession = sessionData.sortedSessions[selectedChoiceSession[0]]![selectedChoiceSession[1]][selectedChoiceSession[2]][selectedChoiceSession[3]][selectedChoiceSession[4]][selectedChoiceSession[5]]
    }
    // Stretching
    func selectStretching() {
        selectedSession = sessionData.sortedSessions[selectedChoiceStretching[0]]![selectedChoiceStretching[1]][selectedChoiceStretching[2]][selectedChoiceStretching[3]][selectedChoiceStretching[4]][selectedChoiceStretching[5]]
    }
    
    //
    // MARK: Update selected choice
    // Look at both sortedGroups & sortedSessions in dataStructures to understand the following
    func updateSelectedChoice(row: Int) {
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Int]]]
        // ------------------------------------------------------------------------------------------------
        if choiceProgress[0] == -1 && row != schedules[0][selectedDay].count {
            // Notes selectedChoiceStretching not always used
            // selectedChoice...[0] to group
            selectedChoiceWarmup[0] = schedules[0][selectedDay][row]
            selectedChoiceSession[0] = schedules[0][selectedDay][row]
            selectedChoiceStretching[0] = schedules[0][selectedDay][row]
        //
        } else {
            // Present next choice or present session
            switch choiceProgress[0] {
            // ------------------------------------------------------------------------------------------------
            // Mind
            case 0:
                // Session Choice
                switch choiceProgress[1] {
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
                switch choiceProgress[1] {
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
                switch choiceProgress[1] {
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
                switch choiceProgress[1] {
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
                switch choiceProgress[1] {
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
                switch choiceProgress[1] {
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
        switch choiceProgress[0] {
        // Mind
        case 0:
            if choiceProgress[1] == 4 {
                return true
            } else {
                return false
            }
        // Flexibility
        case 1:
            if choiceProgress[1] == 4 {
                return true
            } else {
                return false
            }
            
        // Endurance
        case 2:
            if choiceProgress[1] == 4 || choiceProgress[1] == 5 {
                return true
            } else {
                return false
            }
            
        // Toning
        case 3:
            if choiceProgress[1] == 4 || choiceProgress[1] == 6 {
                return true
            } else {
                return false
            }
            
        // Muscle Gain
        case 4:
            if choiceProgress[1] == 4 {
                return true
            } else {
                return false
            }
            
        // Strength
        case 5:
            if choiceProgress[1] == 4 {
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
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Int]]]

        // Day
        if scheduleStyle == 0 {
//            if choiceProgress[0] == -1 {
//                let group = schedules[0][selectedDay][row]
//                if scheduleTrackingArray[selectedDay][group]![0][0] == false {
//                    return false
//                } else {
//                    return true
//                }
//            } else {
//                return false
//            }
        // Week
        } else if scheduleStyle == 1 {
            
        }
        return false
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
            // TODO: GREEN IF ALREADY COMPLETED
            maskView3.backgroundColor = colour4
        }
    }
    
    
    
    //
    // Navigation through days ---------------------------------------------------------------------------------------------------------------------
    //
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if choiceProgress[0] == -1 {
        //
        // Forward 1 day
        if (extraSwipe.direction == .left){
            // Update selected day
            switch selectedDay {
            case 6: selectedDay = 0
            default: selectedDay += 1
            }
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[selectedDay].alpha = 1
            
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
            switch selectedDay {
            case 0: selectedDay = 6
            default: selectedDay -= 1
            }
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[selectedDay].alpha = 1
            selectDay(day: selectedDay)
            
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
    func dayTapHandler(sender: UITapGestureRecognizer) {
        let dayLabel = sender.view as! UILabel
        let index = dayLabel.tag
        //
        // Forward
        if index > selectedDay {
            // Update selected day
            selectedDay = index
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[selectedDay].alpha = 1
            
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
        } else if index < selectedDay {
            // Update selected day
            selectedDay = index
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[selectedDay].alpha = 1
            selectDay(day: selectedDay)
            
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
    // MARK:
    @IBAction func markAsCompleted(_ sender: UILongPressGestureRecognizer) {
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Int]]]

        if sender.state == UIGestureRecognizerState.began {
        // Get Cell
        let cell = sender.view
        let row = cell?.tag
        // Day Table,
        // [0][0] to get bool
        if choiceProgress[0] == -1 {
            let group = schedules[0][selectedDay][row!]
            if scheduleTrackingArray[selectedDay][group]![0][0] == false {
                scheduleTrackingArray[selectedDay][group]![0][0] = true
            } else {
                scheduleTrackingArray[selectedDay][group]![0][0] = false
            }
            
        // Furthur down choices, only take action if final choice
        } else {
            switch choiceProgress[0] {
            // Mind
            case 0:
                break
            // Flexibility
            case 1:
                break
            // Endurance
            case 2:
                break
            // Toning
            case 3:
                break
            // Muscle Gain
            case 4:
                break
            // Strength
            case 5:
                break
            //
            default:
                break
            }
        }
        //
        let indexPathToReload = NSIndexPath(row: row!, section: 0)
        scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
        }
    }
    
    
    
    
    
    
    
    //
    // Edit tap, unused, might be to reorder table
    func editButtonTap() {
        //
    }
}
