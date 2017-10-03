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
        updateSelectedChoice(row: row)
        // ------------------------------------------------------------------------------------------------
        // Next Choice Function
        if choiceProgress[0] == -1 && row != daySessionsArray[selectedDay].count {
            choiceProgress[0] = daySessionsArray[selectedDay][row]
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
                        selectedSession = sessionData.sortedSessions[selectedChoiceWarmup[0]]![selectedChoiceWarmup[1]][selectedChoiceWarmup[2]][selectedChoiceWarmup[3]][selectedChoiceWarmup[4]][selectedChoiceWarmup[5]]
                    } else if row == 2 {
                        selectedSession = sessionData.sortedSessions[selectedChoiceSession[0]]![selectedChoiceSession[1]][selectedChoiceSession[2]][selectedChoiceSession[3]][selectedChoiceSession[4]][selectedChoiceSession[5]]
                    }
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
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
                // Session Choice
                if choiceProgress[1] == 4 {
                    // Test
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
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
                    if row == 2 {
                        choiceProgress[1] = 5
                        nextChoice()
                    } else {
                        choiceProgress[1] += 1
                        nextChoice()
                    }
                // Session Choice
                case 4:
                    // Test
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
                case 5:
                    if row == 2 {
                        // TODO: Popup saying go do cardio - run, bike, row, swim
                    } else {
                        choiceProgress[1] += 1
                        nextChoice()
                    }
                // Session Choice
                case 6:
                    // Test
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
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
                if choiceProgress[1] == 4 {
                    // Test
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
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
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
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
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
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
    // MARK: Update selected choice
    // Look at both sortedGroups & sortedSessions in dataStructures to understand the following
    func updateSelectedChoice(row: Int) {
        // ------------------------------------------------------------------------------------------------
        if choiceProgress[0] == -1 && row != daySessionsArray[selectedDay].count {
            // Notes selectedChoiceStretching not always used
            // selectedChoice...[0] to group
            selectedChoiceWarmup[0] = daySessionsArray[selectedDay][row]
            selectedChoiceSession[0] = daySessionsArray[selectedDay][row]
            selectedChoiceStretching[0] = daySessionsArray[selectedDay][row]
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
                        // selectedChoiceWarmup[1-3] 0
                        selectedChoiceWarmup[1] = 0
                        selectedChoiceWarmup[2] = 0
                        selectedChoiceWarmup[3] = 0
                        // selectedChoiceSession[1] to 1 (session),
                        selectedChoiceSession[1] = 1
                    }
                // Focus
                case 2:
                    // selectedChoiceSession[2] = 0 in this case due to nesting
                    selectedChoiceSession[2] = 0
                    // selectedchoiceSession[3] = row - 1 == focus (row - 1 as row is 1 too large due to title row)
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
                // Session Choice
                if choiceProgress[1] == 4 {
                    // Test
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
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
                    if row == 2 {
                        choiceProgress[1] = 5
                        nextChoice()
                    } else {
                        choiceProgress[1] += 1
                        nextChoice()
                    }
                // Session Choice
                case 4:
                    // Test
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
                case 5:
                    if row == 2 {
                        // TODO: Popup saying go do cardio - run, bike, row, swim
                    } else {
                        choiceProgress[1] += 1
                        nextChoice()
                    }
                // Session Choice
                case 6:
                    // Test
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
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
                if choiceProgress[1] == 4 {
                    // Test
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
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
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
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
                    selectedSession = [1,0,0]
                    performSegue(withIdentifier: "scheduleSessionSegue", sender: self)
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
    // MARK: isLastChoice()
    // Last choice, i.e session choice
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
            if choiceProgress[1] == 4 {
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
    func isCompleted() -> Bool {
        return false
    }
    
    //
    // MARK: Choice Functions
    func nextChoice() {
        //
        
        
        //
        // Mask View
        maskView()
        // Next Table info
        slideLeft()
    }
    
    
    
    //
    // Navigation through days ---------------------------------------------------------------------------------------------------------------------
    //
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
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
    // MARK:
    
    //
    // MARK: Slide menu swipe
    func swipeGestureRight() {
        performSegue(withIdentifier: "openMenu", sender: self)
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
    // Edit tap, unused, might be to reorder table
    func editButtonTap() {
        //
    }
}
