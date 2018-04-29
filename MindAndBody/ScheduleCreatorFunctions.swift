//
//  ScheduleFunctions.swift
//  MindAndBody
//
//  Created by Luke Smith on 05.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


// Extension of uiviewcontroller so that they can be accessed from initial app popup
extension UIViewController {
    
    // MARK: - Determine Number of Sessions
    func setNumberOfSessions(updating: Bool) {
        
        // Create/Fetch Arrays
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        // Initialise arrays
        // [workout, yoga, meditation, endurance, flexibility]
        ScheduleVariables.shared.temporarySessionsArray = [0,0,0,0,0]
        // Range of total n session and specific group sessions
        var rangeArray = [
            // Mind
            [0,0],
            // Flexibility
            [0,0],
            // Endurance
            [0,0],
            // Toning
            [0,0],
            // Muscle Gain
            [0,0],
            // Strength
            [0,0],
        ]
        // ratios of goal (weighting/importance)
        // ratios indexing == [workout, yoga, meditation, endurance, flexibility]
        var ratios: [Double] = [0,0,0,0,0]
        var goals: [Int] = [0,0,0,0,0]
        
        // MARK: Determind Goals as groups:
        // --------------------------------------------------------------------------------------------
        // Find the total number goals (sum of all goals weightings(0-2(6 in case of mind)), the denominator when finding the ratios
//        var goalsNumbersArray: [Int] = [0,0,0,0,0]
//        for i in 0..<ratios.count {
//            switch i {
//            // Workout
//            case 0:
//                // Create array of goals related to workout
//                    // Use this array to determine the what to set the goal for the workout group to be
//                goalsNumbersArray = [
//                    // Muscle gain
//                    schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][1][0]] as! Int,
//                    // Toning
//                    schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][2][0]] as! Int,
//                    // Strength
//                    schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][3][0]] as! Int]
//                // If max is 3, set to 3
//                if goalsNumbersArray.max()! == 3 {
//                    goals[i] = goalsNumbersArray.max()!
//                // If max isn't 3
//                } else if goalsNumbersArray.max()! != 0 {
//                    // Check number of ones
//                    var nOnes = 0
//                    for i in 0..<goalsNumbersArray.count {
//                        if goals[i] == 1 {
//                            nOnes += 1
//                        }
//                    }
//                    // If number of ones is >= 3, set goal to 3, if not set to one
//                        // As if this is the case then 3 goals are related to workout, so the workout goal should be increased
//                    if nOnes >= 3 {
//                        goals[i] = 3
//                    } else {
//                        goals[i] = 1
//                    }
//
//                }
//            // Yoga
//            case 1:
//                // TODO: NOTE SURE, COULD JUST SET TO YOGAGOAL
//                let yogaGoal = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][7][0]] as! Int
//                let mindGoal = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][8][0]] as! Int
//                // If yoga goal is 3, set yoga straight to 3
//                if yogaGoal == 3 {
//                    goals[i] = 3
//                // Else, check what it should be
//                } else {
//                    // If yoga 1 and mind 1 or 3, set to 3
//                    if yogaGoal == 1 && mindGoal > 0 {
//                        goals[i] = 3
//                    // Else set to
//                    } else {
//                        goals[i] = yogaGoal
//                    }
//                }
//            // Meditation
//            case 2:
//                // Set straight to mind goal
//                goals[i] = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][8][0]] as! Int
//            // Endurance
//            case 3:
//                // Create array of goals related to endurance
//                // Use this array to determine the what to set the goal for the workout group to be
//                goalsNumbersArray = [
//                    // Weight Loss
//                    schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][1][0]] as! Int,
//                    // Endurance
//                    schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][2][0]] as! Int]
//                // If max is 3, set to 3
//                if goalsNumbersArray.max()! == 3 {
//                    goals[i] = goalsNumbersArray.max()!
//                // If max isn't 3
//                } else if goalsNumbersArray.max()! != 0 {
//                    // Check number of ones
//                    var nOnes = 0
//                    for i in 0..<goalsNumbersArray.count {
//                        if goals[i] == 1 {
//                            nOnes += 1
//                        }
//                    }
//                    // If number of ones is >= 3, set goal to 3, if not set to one
//                        // As if this is the case then 3 goals are related to endurance, so the workout goal should be increased
//                    if nOnes >= 3 {
//                        goals[i] = 3
//                    } else {
//                        goals[i] = 1
//                    }
//                }
//            // Flexibility
//            case 4:
//                let yoga = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][7][0]] as! Int
//                let mind = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][8][0]] as! Int
//                let flexibility = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][6][0]] as! Int
//                // If yoga & mind >= 3, & flexibility 3, set to 1
//                if yoga + mind >= 3 && flexibility == 3 {
//                    goals[i] = 1
//                // Else set to flexibility
//                } else {
//                    goals[i] = flexibility
//                }
//            default: break
//            }
//        }
//
//        // Workout/Endurance: general fitness goal edit
//            // If general fitness is a goal, check/edit workout/endurance
//        let generalFitness = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][0][0]] as! Int
//        // If general fitness is a goal and workout or endurance is 0, check if should increase
//        if generalFitness != 0 && (ScheduleVariables.shared.temporarySessionsArray[0] == 0 || ScheduleVariables.shared.temporarySessionsArray[3] == 0) {
//            // If both are zero
//                // Set both to 1 if general fitness goal == 3
//                // If general fitness goal == 1, do the same for now
//            if ScheduleVariables.shared.temporarySessionsArray[0] == 0 && ScheduleVariables.shared.temporarySessionsArray[3] == 0 {
//                // Set both to 1 if general fitness goal == 3
//                if generalFitness == 3 {
//                    ScheduleVariables.shared.temporarySessionsArray[0] = 1
//                    ScheduleVariables.shared.temporarySessionsArray[3] = 1
//                // If general fitness goal == 1, do the same for now
//                } else {
//                    // TODO: COULD CHOOSE RANDOM
//                    ScheduleVariables.shared.temporarySessionsArray[0] = 1
//                    ScheduleVariables.shared.temporarySessionsArray[3] = 1
//                }
//            // If only one is 0
//                // increase
//            } else {
//                if ScheduleVariables.shared.temporarySessionsArray[0] == 0 {
//                    ScheduleVariables.shared.temporarySessionsArray[0] = 1
//                } else if ScheduleVariables.shared.temporarySessionsArray[3] == 0 {
//                    ScheduleVariables.shared.temporarySessionsArray[3] = 1
//                }
//            }
//        }
        
        // Create goals
        for i in 0..<goals.count {
            goals[i] = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][i][0]] as! Int
        }
       
        // MARK: Determind ratios: goal answer / total goals
        // --------------------------------------------------------------------------------------------
        // Find the total number goals (sum of all goals weightings, this is the denominator when finding the ratios
        var totalNGoals = 0
        for i in 0..<goals.count {
            totalNGoals += goals[i]
        }
        // --------------------------------------------------------------------------------------------
        // Find ratios: goal/total goals
        for i in 0..<ratios.count {
            // Avoid /0
            if goals[i] == 0 {
                ratios[i] = 0
            } else {
                ratios[i] = Double(goals[i]) / Double(totalNGoals)
            }
        }
        
        // Meditation can be done more often, adapt ratio based on weighting of mind goal
        let mind = goals[2]
        // If mind goal == 3, 1.5* the ratio
        if mind == 3 {
            ratios[2] = ratios[2] * 1.5
        }
        
        // --------------------------------------------------------------------------------------------
        // MARK: Preliminary Number Groups
        // Using last 2 'Me' questions
        // Switch amount of Time
            // For each amount of time, switch commitment
                // For each commitment, set taking account number of goals (if more goals, more sessions are required)
        
        // Determine wether number of goals is high or not
            // Largest possible number of goals: 3*5=15
        let numberOfGoals = goals.reduce(0, +)
        var lotsOfGoals = false
        // Lots of goals: 11-15
        if numberOfGoals > 10 {
            lotsOfGoals = true
        } else {
            lotsOfGoals = false
        }
        
        
        switch schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][1]["scheduleQTime"] as! Int {
        // 1 - 2 days
        case 0:
            switch schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][1]["scheduleQPriority"] as! Int {
            // Do a little 1 - 2
            case 0:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 2
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 1
                }
                // Take it easy, 1 - 3 sessions
            case 1:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 3
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 2
                }
            // Routine, 2 - 4 sessions
            case 2:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 4
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 3
                }
            default: break
            }
        // 2 - 3 days
        case 1:
            switch schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][1]["scheduleQPriority"] as! Int {
            // Do a little 2 - 4
            case 0:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 4
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 3
                }
            // Take it easy, 3 - 5 sessions
            case 1:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 4
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 3
                }
            // Routine, 4 - 6 sessions
            case 2:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 5
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 4
                }
            default: break
            }
            
        // 3 - 5 days
        case 2:
            switch schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][1]["scheduleQPriority"] as! Int {
            // Do a little 2 - 4
            case 0:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 4
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 3
                }
            // Take it easy, 3 - 5 sessions
            case 1:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 5
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 4
                }
            // Routine, 4 - 6 sessions
            case 2:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 6
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 5
                }
            default: break
            }
            
        // 5 - 7 days
        case 3:
            switch schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![0][1]["scheduleQPriority"] as! Int {
            // Do a little 5
            case 0:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 6
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 5
                }
            // Take it easy, 7 sessions
            case 1:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 9
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 7
                }
            // Routine, 10 sessions
            case 2:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 13
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 10
                }
            default: break
            }
            
        default: break
        }
        
        // --------------------------------------------------------------------------------------------
        // Now we have a preliminary total number of session, we can create n sessions for each goal
        // Encorporating age, gender, and last two 'Me' questions ------ not done yet
        
        ScheduleVariables.shared.temporarySessionsArray = [0,0,0,0,0] // which one to use
        var temporaryTemporaySessionsArray: [Double] = [0,0,0,0,0]
        
        // Number of sessions is equal to the total number of sessions * the ratio, then rounded to a sensible number
        for i in 0..<ratios.count {
            // Avoid /0
            //ScheduleVariables.shared.temporarySessionsArray[i]
            temporaryTemporaySessionsArray[i] = Double(ScheduleVariables.shared.temporaryNSessions) * ratios[i]
        }
        
        
        
        // -------------------------------------------------------------------------
        // MARK: Round number of sessions
        for i in 0..<temporaryTemporaySessionsArray.count {
            // Round up for yoga or flexibility, from 1.25
            if i == 1 || i == 4 && floor(temporaryTemporaySessionsArray[i]) >= 0.25 {
                temporaryTemporaySessionsArray[i] = ceil(temporaryTemporaySessionsArray[i])
            }
            temporaryTemporaySessionsArray[i] = temporaryTemporaySessionsArray[i].rounded()
        }
        
        // Round up for yoga, flexibility from .25
        
        
        
        
        
        
        
        
        
//        // -------------------------------------------------------------------------
//        // MARK: Edit N Sessions and Ratios for edge cases
//        // Check difference between number of goals (not if primary or secondary. just if goal) and number of sessions, if difference great, goals have to be edited accordingly (or number of sessions)
//        //
//        var goalCount = 0
////        if mindNumber != 0 {
////            goalCount += 1
////        }
//        for i in 2...schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1].count - 1 {
//            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1][i] as! Int != 0 {
//                goalCount += 1
//            }
//        }
//        // Their number of goals is 2 or more greater than the number of sessions
//        // -> multiple goals must be achieved by 1 group
//        
//        
//        // TEST: EVERYTHING GOES THROUGH WORKOUT REDUCTION
//        if goalCount > rangeArray[0][1] - 1 {
//            //        if goalCount > ScheduleVariables.shared.temporaryNSessions + 1 {
//            //
//            // Create array of primary and secondary goals,
//            // 0 or 1
//            var primarySecondaryArray =
//                [
//                    // [mind, flexibility, endurance, toning, muscle gain, strength]
//                    // Primary
//                    [0,0,0,0,0,0],
//                    // Secondary
//                    [0,0,0,0,0,0]
//            ]
////            if mindNumber > 1 {
////                primarySecondaryArray[0][0] = 1
////            }
//            for i in 2...schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1].count - 1 {
//                // i - 1 for primarySecondaryArray as e.g flexibility == profileAnswer[1][4] && primarySecondaryArray[1] -> -3
//                // Primary goals
//                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1][i] as! Int == 2 {
//                    primarySecondaryArray[0][i - 1] = 1
//                    // Secondary goals
//                } else if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1][i] as! Int == 1 {
//                    primarySecondaryArray[1][i - 1] = 1
//                }
//            }
//            
//            
//            // ----------------------------------------------------------------------------------------------------
//            // Reduce workout goals
//            // -> check goal count (using ratios) against n sessions
//            // Reduce mind & flexibility to mind
//            // -> check goal count (using ratios) against n sessions
//            
//            // Workout Ratios
//            // Strength workouts are more specific, they should only be presented if the user sets strength to primary goal and other goals as secondary
//            // Determine how many workout goals are primary
//            var primaryWorkoutGoals = [0,0,0]
//            // 0 or 1
//            var nPrimaryWorkoutGoals = 0
//            for i in 3...5 {
//                // if primary goal, + 1
//                if primarySecondaryArray[0][i] == 1 {
//                    // -3 as starts at 3
//                    nPrimaryWorkoutGoals += 1
//                    primaryWorkoutGoals[i - 3] = 1
//                }
//            }
//            // Determine how many workout goals are secondary
//            var secondaryWorkoutGoals = [0,0,0]
//            // 0 or 1
//            var nSecondaryWorkoutGoals = 0
//            for i in 3...5 {
//                // if secondary goal, + 1
//                if primarySecondaryArray[1][i] == 1 {
//                    nSecondaryWorkoutGoals += 1
//                    secondaryWorkoutGoals[i - 3] = 1
//                }
//            }
//            // ------------------------------------------------------------------
//            // Switch total number of workout goals
//            let toalNWorkoutGoals = nPrimaryWorkoutGoals + nSecondaryWorkoutGoals
//            switch toalNWorkoutGoals {
//            // 2 goals ------------------------------------------------------------------
//            case 2:
//                switch nPrimaryWorkoutGoals {
//                    
//                // If 1 primary, 1 secondary, set groups only to primary by adding ratios together and setting to primary
//                case 1:
//                    // + 1 as offset by 1
//                    let primaryIndex = primaryWorkoutGoals.index(of: 1)! + 1
//                    let secondaryIndex = secondaryWorkoutGoals.index(of: 1)! + 1
//                    let totalRatio = ratios[primaryIndex] + ratios[secondaryIndex]
//                    ratios[secondaryIndex] = 0
//                    ratios[primaryIndex] = totalRatio
//                    
//                // If 0 or 2, then 2 primary, 2 secondary, find which is most suitable to user and set group only to that by adding ratios and setting to better goal
//                case 0,2:
//                    // Primary or Secondary
//                    var workoutGoals = [Int]()
//                    if nPrimaryWorkoutGoals == 0 {
//                        workoutGoals = secondaryWorkoutGoals
//                    } else {
//                        workoutGoals = primaryWorkoutGoals
//                    }
//                    // Determine the indexes of the goals
//                    var indexes = [0,0]
//                    for i in 0...2 {
//                        if workoutGoals[i] == 1 {
//                            if indexes[0] == 0 {
//                                // as offset of 3 between ratios and workout goals
//                                indexes[0] = i + 1
//                            } else {
//                                indexes[1] = i + 1
//                            }
//                        }
//                    }
//                    
//                    // TODO: USES GENDER!!!!!!!!!!!!!!!!!!!!!!!! FIX NOW!!!!
//                    
//                    // Strength
//                    // if man, set to strength
//                    // if woman (or other), set to other
//                    if indexes.contains(5) {
//                        // If male
//                        // me questions gender
//                        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1] as! Int == 0 {
//                            // index 1 is strength as strength is last goal
//                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]]
//                            ratios[indexes[0]] = 0
//                            ratios[indexes[1]] = totalRatio
//                        } else {
//                            // index 1 is strength as strength is last goal
//                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]]
//                            ratios[indexes[0]] = totalRatio
//                            ratios[indexes[1]] = 0
//                        }
//                        // Else toning and muscle gain
//                        // If man, set to muscle gain, if woman, set to toning
//                    } else {
//                        // If male
//                        // me questions gender
//                        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1] as! Int == 0 {
//                            // index 1 is strength as strength is last goal
//                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]]
//                            ratios[indexes[0]] = 0
//                            ratios[indexes[1]] = totalRatio
//                        } else {
//                            // index 1 is strength as strength is last goal
//                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]]
//                            ratios[indexes[0]] = totalRatio
//                            ratios[indexes[1]] = 0
//                        }
//                    }
//                    
//                //
//                default:
//                    break
//                }
//                
//                //
//                
//            // 3 goals ------------------------------------------------------------------
//            case 3:
//                switch nPrimaryWorkoutGoals {
//                    
//                // If 1 primary, set groups only to primary by adding ratios together and setting to primary
//                case 1:
//                    // workouts are last three indexes of array of 6 elements
//                    let totalRatio = ratios[3] + ratios[4] + ratios[5]
//                    // + 1 as offset by 1
//                    let primaryIndex = primaryWorkoutGoals.index(of: 1)! + 1
//                    for i in 3...5 {
//                        if i == primaryIndex {
//                            ratios[i] = totalRatio
//                        } else {
//                            ratios[i] = 0
//                        }
//                    }
//                    
//                // If 2, find which is most suitable to user and set group only to that by adding ratios and setting to better goal
//                case 2:
//                    // Determine the indexes of the primary goals
//                    var indexes = [0,0]
//                    for i in 0...2 {
//                        if primaryWorkoutGoals[i] == 1 {
//                            if indexes[0] == 0 {
//                                // as offset of 3 between ratios and workout goals
//                                indexes[0] = i + 1
//                            } else if indexes[1] == 0 {
//                                indexes[1] = i + 1
//                            } else {
//                                indexes[2] = i + 1
//                            }
//                        }
//                    }
//                    
//                    // Strength and toning
//                    // if man, set to strength
//                    // if woman (or other), set to other
//                    if indexes.contains(5) && indexes.contains(3) {
//                        // If male
//                        // me questions gender
//                        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1] as! Int == 0 {
//                            // index 1 is strength as strength is last goal
//                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
//                            ratios[3] = 0
//                            ratios[4] = 0
//                            ratios[5] = totalRatio
//                        } else {
//                            // index 1 is strength as strength is last goal
//                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
//                            ratios[3] = totalRatio
//                            ratios[4] = 0
//                            ratios[5] = 0
//                        }
//                        // Strength and muscle gain
//                        // for both set to muscle gain
//                    } else if indexes.contains(5) && indexes.contains(4) {
//                        // index 1 is strength as strength is last goal
//                        let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
//                        ratios[3] = 0
//                        ratios[4] = totalRatio
//                        ratios[5] = 0
//                        //
//                        // Toning and muscle gain
//                        // If man, set to muscle gain
//                        // if woman, set to toning
//                    } else {
//                        // If male
//                        // me questions gender
//                        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1] as! Int == 0 {
//                            // index 1 is strength as strength is last goal
//                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
//                            ratios[3] = 0
//                            ratios[4] = totalRatio
//                            ratios[5] = 0
//                        } else {
//                            // index 1 is strength as strength is last goal
//                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
//                            ratios[3] = totalRatio
//                            ratios[4] = 0
//                            ratios[5] = 0
//                        }
//                    }
//                    
//                // 0, 3
//                case 3:
//                    // Primary or Secondary
//                    var workoutGoals = [Int]()
//                    if nPrimaryWorkoutGoals == 0 {
//                        workoutGoals = secondaryWorkoutGoals
//                    } else {
//                        workoutGoals = primaryWorkoutGoals
//                    }
//                    // Determine the indexes of the goals
//                    var indexes = [0,0,0]
//                    for i in 0...2 {
//                        if workoutGoals[i] == 1 {
//                            if indexes[0] == 0 {
//                                // as offset of 3 between ratios and workout goals
//                                indexes[0] = i + 1
//                            } else if indexes[1] == 0 {
//                                indexes[1] = i + 1
//                            } else {
//                                indexes[2] = i + 1
//                            }
//                        }
//                    }
//                    
//                    // if man, set to muscle gain ([1])
//                    // if woman (or other), set to toning ([0])
//                    // If male
//                    // me questions gender
//                    if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1] as! Int == 0 {
//                        // index 1 is strength as strength is last goal
//                        let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
//                        ratios[indexes[0]] = 0
//                        ratios[indexes[2]] = 0
//                        ratios[indexes[1]] = totalRatio
//                    } else {
//                        // index 1 is strength as strength is last goal
//                        let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
//                        ratios[indexes[1]] = 0
//                        ratios[indexes[2]] = 0
//                        ratios[indexes[0]] = totalRatio
//                    }
//                //
//                default:
//                    break
//                }
//                
//            // leave as is if 0 or 1 goals
//            default:
//                break
//            }
//            
//            
//            // ------------------------------------------------------------------
//            // Check goals (found by n ratios != 0) against sessions
//            var nGoals2 = 0
//            for i in 0...ratios.count - 1 {
//                if ratios[i] != 0 {
//                    nGoals2 += 1
//                }
//            }
//            // if 1 more than sessions, add 1 session
//            if nGoals2 == ScheduleVariables.shared.temporaryNSessions + 1 {
//                ScheduleVariables.shared.temporaryNSessions += 1
//                // if goals still to high, reduce further
//            } else if nGoals2 > ScheduleVariables.shared.temporaryNSessions + 1 {
//                // Flexibility && Mind -> Mind
//                // index 1 is strength as strength is last goal
//                let totalRatio = ratios[0] + ratios[1]
//                ratios[0] = totalRatio
//                ratios[1] = 0
//            }
//            // do nothing if goals are now less than or equal to sessions
//            
//            // Their  their n goals is similar to number of sessions, in a range of 2 about goals
//            // -> Do nothing except if goals are greater than
//            // Still checking range and not just +1 incase I want to do something more one day
//        } else if goalCount < ScheduleVariables.shared.temporaryNSessions + 2 && goalCount > ScheduleVariables.shared.temporaryNSessions - 2{
//            // If goals is 1 greater than sessions, increase sessions, if not leave sessions as is
//            if goalCount == ScheduleVariables.shared.temporaryNSessions + 1 {
//                ScheduleVariables.shared.temporaryNSessions += 1
//            }
//            
//            // Their n goals is lower than preliminary number of sessions lower range
//        } else if goalCount < rangeArray[0][1] - 1 {
//            // Do nothing for the moment
//        }
//        
//        
//        
//        
//        
//        
//        
//        //        //
//        //        // MARK: Double check workout goals
//        //        // TODO:
//        //
//        //
//        //        find n workout goals
//        //
//        //
//        //        var nWorkoutGoals = 0
//        //        var workoutGoals: [Int] = []
//        //        for i in 4...6 {
//        //            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1][i] != 0 {
//        //                nWorkoutGoals += 1
//        //                nWorkoutGoals.append(i)
//        //            }
//        //        }
//        //
//        //
//        //        //
//        //        // Edit strength, as strength is more specific
//        //        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1][6] == 1 {
//        //            // If srength if the only workout goal, do nothing, else do something
//        //            if nWorkoutGoals != 1 {
//        //                if woman don't do strength workout
//        //                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1][1] > 0 {
//        //
//        //                    if nWorkoutGoals == 2 {
//        //                        // Add workout ratios together and set to other
//        //                            // workoutGoals[0] as strength will always be [1] if 2 workout goals
//        //                                // - 1 as goals has extra index at beginning compared to ratios
//        //                        let totalRatio = ratios[workoutGoals[0] - 1] + ratios[6 - 1]
//        //                        ratios[workoutGoals[0] - 1] = totalRatio
//        //                        ratios[6 - 1] = 0
//        //                    } else {
//        //                        if
//        //                    }
//        //                }
//        //            }
//        //        //
//        //        } else if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![1][6] == 2 {
//        //
//        //        }
//        ////        edit workouts for all users
//        ////            mainly focus on strength, this is not for everyone
//        //        //
//        //        // If woman, set strength, workout experience low, don't set strength,
//        
//        
//        
//        // -------------------------------------------------------------------------
//        // MARK: Number of sessions
//        // Set number of sessions of each group based on ratios, then limit maximum number of sessions
//        // Set number of sessions of each group to ratio*nsessions
//        for i in 0...ratios.count - 1 {
//            //
//            // Round normally, exept up from less than 0.5, to ensure that all goals have at least 1 session, no matter the ratio
//            // + 1 as ScheduleVariables.shared.temporarySessionsArray includes total n sessions
//            let nSessions = ratios[i] * Double(ScheduleVariables.shared.temporaryNSessions)
//            if ratios[i] == 0 {
//                ScheduleVariables.shared.temporarySessionsArray[i + 1] = 0
//            } else if ratios[i] != 0 && nSessions < 0.5 {
//                ScheduleVariables.shared.temporarySessionsArray[i + 1] = 1
//            } else {
//                ScheduleVariables.shared.temporarySessionsArray[i + 1] = Int(round(nSessions))
//            }
//        }
//        
//        // ----------------------------------------------
//        // Limit max n sessions of certain groups
//        // Possible, currently trying without
//        
//        // ----------------------------------------------
//        // MARK: Final check n sessions
//        // CHECK CURRENTLY UNUSED, to be put it if edge cases are vary bad (i.e nsessions = 2, new nsessions = 4)
//        var newNSessions = 0
//        for i in 1...ScheduleVariables.shared.temporarySessionsArray.count - 1 {
//            newNSessions += ScheduleVariables.shared.temporarySessionsArray[i]
//        }
//        //            // If nSessions (total of all sessions)[1]+...+[6] 2 or more greater than nSessions (total sessions)[0], edit
//        //            if newNSessions > ScheduleVariables.shared.temporaryNSessions + 1 {
//        //
//        //            // New n sessions is sensible, reset n sessions to new
//        //            } else {
//        //                ScheduleVariables.shared.temporaryNSessions = newNSessions
//        //            }
//        
//        ScheduleVariables.shared.temporaryNSessions = newNSessions
//        
//        
//        
//        // ----------------------------------------------
//        // MARK: Update ranges
//        // Session ranges
//        // TODO: UPDATE RANGES!!!!!
//        for i in 1...ScheduleVariables.shared.temporarySessionsArray.count - 1 {
//            // i - 1 as ScheduleVariables.shared.temporarySessionsArray contains total n sessions, but schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![3] does not
//            // lower range: i*2
//            // upper range: i*2 + 1
//            let index = 2 * (i - 1)
//            if ScheduleVariables.shared.temporarySessionsArray[i] != 0 {
//                // Lower Range
//                // 1 if 1, -1 if > 1
//                if ScheduleVariables.shared.temporarySessionsArray[i] > 1 {
////                    schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![3][index] = ScheduleVariables.shared.temporarySessionsArray[i] - 1
//                } else {
////                    schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![3][index] = ScheduleVariables.shared.temporarySessionsArray[i]
//                }
//                // Upper range
//                // If mind set upper range higher
//                if index == 0 {
////                    schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![3][index + 1] = ScheduleVariables.shared.temporarySessionsArray[i] + 3
//                    // If mind set upper range higher
//                } else {
////                    schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![3][index + 1] = ScheduleVariables.shared.temporarySessionsArray[i] + 2
//                }
//            } else {
////                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![3][index] = 0
////                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![3][index + 1] = 0
//            }
//        }
//        
//        
//        // MARK: Set new arrays
//        // TODO: BETTER EXPLANATIONS
//        // NOTE IF UPDATING SESSION, THE ARRAYS SHOULDN'T BE SET HERE THE USER SHOULD BE PRESENTED THE NEW ARRAYS AND THEY DECIDE THEN
//        if updating == false {
////            schedules[ScheduleVariables.shared.selectedSchedule]["scheduleCreationHelp"]![2] = ScheduleVariables.shared.temporarySessionsArray
//            UserDefaults.standard.set(schedules, forKey: "schedules")
//            // Sync
//            ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
//        } else {
//            
//        }
//        UserDefaults.standard.synchronize()
//        
//        
//        
//        //    Tests of what it should present
//        //    //
//        //    // Goals > prelim sessions
//        //    preliminary 4
//        //    3 mind, 1 flexibility, 2 muscle gain
//        //    -> 2 mind, 1 flexibility, 2 muscle gain,
//        //
//        //    preliminary 2
//        //    3 mind, 2 flexibility, 2 endurance, 2 toning, 2 strength
//        //    -> 1 mind, 1 endurance, 1 strength
//        //
//        //    preliminary 3
//        //    2 mind, 1 flexibility, 1 endurance, 2 toning
//        //    -> 2 mind, 1 endurance, 1 toning
//        //
//        //    //
//        //    // Goals -- prelim sessions
//        //    preliminary 7
//        //    3 mind, 2 flexibiity, 1 endurance, 2 muscle gain
//        //    -> 3 mind, 2 flexibiity, 1 endurance, 2 muscle gain
//        //
//        //    preliminary 6
//        //    3 mind, 3 strength
//        //    -> 3 mind 3 strength
//        //
//        //    //
//        //    // Goals < prelim sessions
//        //    preliminary 5
//        //    2 mind
//        //    -> 3 mind
//        //
//        //    preliminary 7
//        //    3 mind, 2 toning
//        //    -> 3 mind, 2 toning
        
    }
    
}


