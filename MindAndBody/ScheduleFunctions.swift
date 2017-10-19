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
    
    
    // MARK: - userDifficultyLevels
    // !!!!!! -> Look at scheduleDataStructures.profileQA and scheduleDataStructures.defaultDifficultyLevels to understand indexing
    func setDifficultyLevels() {
        // Fetch Arrays
        var difficultyLevels = UserDefaults.standard.array(forKey: "difficultyLevels") as! [[Int]]
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        
        // MARK: Straightforward setting data
            // Flexibility - 0
                // Hamstrings - [11]
                    difficultyLevels[0][1] = profileAnswers[0][11]
                // Hips - [12]
                    difficultyLevels[0][2] = profileAnswers[0][12]
        //
        // MARK: 1: Deductions
            // Flexibility - 0
                // Back Neck - Average of back and neck answers - [15], [16], [17]
                    let backNeckAverage = Double((profileAnswers[0][15] + profileAnswers[0][16] + profileAnswers[0][17]) / 3)
                    difficultyLevels[0][3] = conservativeRound(toRound: backNeckAverage)
                // Overall - Average of all stretching questions - [11] - [17]
                    let overallFlexibility = Double((profileAnswers[0][11] + profileAnswers[0][12] + profileAnswers[0][13] + profileAnswers[0][14] + profileAnswers[0][15] + profileAnswers[0][16] + profileAnswers[0][17]) / 7)
                    difficultyLevels[0][0] = conservativeRound(toRound: overallFlexibility)
            // Endurance - 2
                // Endurance Level - Average of 'do you do much cardio' and '5km' and user self opinion - [4] [5] [6]
                    let enduranceAverage = Double((profileAnswers[0][4] + profileAnswers[0][5] + profileAnswers[0][6]) / 3)
                    difficultyLevels[2][0] = conservativeRound(toRound: enduranceAverage)
            // Strength - not set in difficultyLevels, but deduced then used below
                // Overall Strength - average of pushup, pullup and squat and self opinion [7] [8] [9] [10]
                    let overallStrength = Double((profileAnswers[0][7] + profileAnswers[0][8] + profileAnswers[0][9] + profileAnswers[0][10]) / 4)
            // Balance - not set, but used later - [18]
                    let balanceAnswer = profileAnswers[0][18]
        // MARK: 2: Deductions that use deductions
            // Yoga - 1
                // Yoga Level - Average of overall flexibility, balance and experience([2])
                let yogaAverage = Double((difficultyLevels[0][0] + balanceAnswer + profileAnswers[0][2]) / 3)
                difficultyLevels[1][0] = conservativeRound(toRound: yogaAverage)
                // Strength Yoga Level - Average of overall strength, balance
                let strengthYoga = Double((overallStrength + Double(balanceAnswer)) / 2)
                difficultyLevels[1][1] = conservativeRound(toRound: strengthYoga)
            // Workout
                // Workout Level - Average of overallStrength, endurance, and experience([3])
                let workoutAverage = Double((overallStrength + Double(difficultyLevels[2][0]) + Double(profileAnswers[0][3])) / 3)
                difficultyLevels[3][0] = conservativeRound(toRound: workoutAverage)
                // Workout Level Lower - Average of endurance, and experience([3]), and squat([9])
                let workoutAverageLower = Double((difficultyLevels[2][0] + profileAnswers[0][3] + profileAnswers[0][9]) / 3)
                difficultyLevels[3][1] = conservativeRound(toRound: workoutAverageLower)
        
        // Set new difficulty levels
        UserDefaults.standard.set(difficultyLevels, forKey: "difficultyLevels")
    }
    
    // Round down from .5
    func conservativeRound(toRound: Double) -> Int {
        if toRound == 0.5 || toRound == 1.5 {
            return Int(floor(toRound))
        } else {
            return Int(round(toRound))
        }
    }
    
    // MARK: - Determine Number of Sessions
    func setNumberOfSessions(updating: Bool) {
        // Create/Fetch Arrays
        // Deduce number of sessions using '''updatedSessionsArray''', then let user edit, then set to defaults;  this is so if user is updating profile the new array can be checked against the existing schedule to see the difference
        // [nSessions, mind, flexibility, endurance, toning, muscle gain, strength]
        updatedSessionsArray =  [0,0,0,0,0,0,0] // Will be set to profileAnswers[2]
        // Range of total n session and specific group sessions
        var rangeArray = [
            // N Sessions
            [0,0],
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
            // ratios indexing == [mind, flexibility, endurance, toning, muscle gain, strength]
        var ratios: [Double] = [0,0,0,0,0,0]
        // User answers
        var profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        
        // --------------------------------------------------------------------------------------------
        // MARK: Determine Ratios
                // --------------------------------------------------------------------------------------------
        // Mind number -- (before determin ratios, determine ratios just below, uses mindNumber found here)
            // Essentially the same as the other goals's answers, determined differently as split into several goals (mindfulness, calmness, contentedness, yoga [0] - [3] and given on a scale 0 - 4, as mind includes yoga and meditation and is half of the app, the weighting is increased to increase the number of sessions accordingly
        // Increase mind number based on if the mind goal is a selected goal [0] [1] [2]
            // Can go up to 3 (even though others on scale to 2) if the user sets all three mind goals as possibilities
                // Therefore this does not depend on what the user actually set, just how much they set
            var mindNumber = 0
            for i in 0...3 {
                if profileAnswers[1][i] != 0 {
                    mindNumber += 1
                }
            }
                // This gives a result 0 - 4
                // Edit result based on user answer (0-2) for specific cases
            // Switch mind number for specific cases
                // Can for loop mind answers (0...3), as all irrelevent answers will be 0, and only check 1,2 so only relevant answers will have any effect
            switch mindNumber {
            // case 0: do nothing
            case 1:
                // If mindNumber == 1, but the goal is primary == 2, then increase to 2, otherwise leave the same
                for i in 0...3 {
                    if profileAnswers[1][i] == 2 {
                        mindNumber += 1
                    }
                }
            case 2:
                // If mind number == 2, and both goals primary == 2 (!= 1), increase to 3
                var increase = true
                for i in 0...3 {
                    if profileAnswers[1][i] == 1 {
                        increase = false
                    }
                }
                if increase == true {
                    mindNumber += 1
                }
            case 3:
                // If mindNumber == 3, but all goals are secondary == 1 (!= 2), then decrease
                var decrease = true
                for i in 0...3 {
                    if profileAnswers[1][i] == 2 {
                        decrease = false
                    }
                }
                if decrease == true {
                    mindNumber -= 1
                }
                // If mindNumber == 3, and all goals are primary == 2 (!= 1), then increase
                var increase = true
                for i in 0...3 {
                    if profileAnswers[1][i] == 1 {
                        increase = false
                    }
                }
                if increase == true {
                    mindNumber += 1
                }
            //
            case 4:
                // If mindNumber == 3, but 3 secondary, then decrease to 3
                    // Use counter as checking if specific number equal to value, (rather than if all are equal to the same value as in above cases)
                var decrease = 0
                for i in 0...3 {
                    if profileAnswers[1][i] == 1 {
                        decrease += 1
                    }
                }
                if decrease > 2 {
                    mindNumber -= 1
                }
                
            default:
                break
            }
        
        
                // --------------------------------------------------------------------------------------------
        // Find the total number goals (sum of all goals weightings (0-2)), the denominator when finding the ratios
        var totalNGoals = 0
        for i in 0...profileAnswers[1].count - 1 {
            totalNGoals += profileAnswers[1][i]
        }
        
                // --------------------------------------------------------------------------------------------
        // Determind ratios: goal answer / total goals
            // Add up all goal answer (scale 0-2 or 0-4 for mind) and divide by total of goal answers. Ratio is then determined by specific goal answer (e.g toning) divided by the total goal answers -> (2/7)
        ratios[0] = Double(mindNumber/totalNGoals)
            // 4 as 0-3 are mind goals used above
        for i in 4...profileAnswers[1].count - 1 {
                // i - 3 for ratios as e.g flexibility == profileAnswer[1][4] && ratios[1] -> -3
            ratios[i - 3] = Double(profileAnswers[1][i]/mindNumber)
        }
        
                // --------------------------------------------------------------------------------------------
        // Now we have a preliminary number of goals, we can create n sessions
            // Encorporating age, gender, and last two 'Me' questions
        
        
        // --------------------------------------------------------------------------------------------
        // MARK: Preliminary Number Groups Range, Using last 2 'Me' questions
        // Switch amount of Time  [22]
        switch profileAnswers[0][22] {
            // Time case :
            // -> Check against committment question [23]
        // 1-2 days
        case 0:
            // Do a little 1 - 2
            if profileAnswers[0][23] == 0 {
                rangeArray[0][0] = 1
                rangeArray[0][1] = 2
            // Take it easy, 1 - 3 sessions
            } else if profileAnswers[0][23] == 1 {
                rangeArray[0][0] = 1
                rangeArray[0][1] = 3
            // Routine, 2 - 3 sessions
            } else if profileAnswers[0][23] == 2  {
                rangeArray[0][0] = 2
                rangeArray[0][1] = 4
            }
        // 3-4 days
        case 1:
            // Do a little, 2 - 4 sessions
            if profileAnswers[0][23] == 0 {
                rangeArray[0][0] = 2
                rangeArray[0][1] = 4
            // take it easy, 3 - 5 sessions
            } else if profileAnswers[0][23] == 1 {
                rangeArray[0][0] = 3
                rangeArray[0][1] = 5
                // Routine, 4 - 6 sessions
            } else if profileAnswers[0][23] == 2 {
                rangeArray[0][0] = 4
                rangeArray[0][1] = 6
            }
        // 5-7 days
        case 2:
            // Do a little, 5 sessions
            if profileAnswers[0][23] == 0 {
                rangeArray[0][0] = 3
                rangeArray[0][1] = 5
                // take it easy, 6 sessions
            } else if profileAnswers[0][23] == 1 {
                rangeArray[0][0] = 4
                rangeArray[0][1] = 7
                // Routine, 7 sessions
            } else if profileAnswers[0][23] == 2 {
                rangeArray[0][0] = 6
                rangeArray[0][1] = 10
            }
        default: break
        }
        
        // -------------------------------------------------------------------------
        // MARK: Number of sessions
            // Currently simply set number of sessions to middle of range
        updatedSessionsArray[0] = Int(round(Double((rangeArray[0][0] + rangeArray[0][1]) / 2)))
        
        
        // -------------------------------------------------------------------------
        // MARK: Edit ratios
        // Check difference between number of goals and number of sessions, if difference great, goals have to be edited accordingly (or number of sessions)
            //
        // Their number of goals is 2 or more greater than the number of sessions
            // -> multiple goals must be achieved by 1 group
        if totalNGoals > updatedSessionsArray[0] + 1 {
            //
            // Create array of primary and secondary goals,
                // 0 or 1
            var primarySecondaryArray =
                [
                    // [mind, flexibility, endurance, toning, muscle gain, strength]
                    // Primary
                    [0,0,0,0,0,0],
                    // Secondary
                    [0,0,0,0,0,0]
            ]
            if mindNumber > 1 {
                primarySecondaryArray[0][0] = 1
            }
            for i in 4...profileAnswers[1].count - 1 {
                // i - 3 for primarySecondaryArray as e.g flexibility == profileAnswer[1][4] && primarySecondaryArray[1] -> -3
                // Primary goals
                if profileAnswers[0][i] == 2 {
                    primarySecondaryArray[0][i - 3] = 1
                    // Secondary goals
                } else if profileAnswers[0][i] == 1 {
                    primarySecondaryArray[1][i - 3] = 1
                }
            }
            
            
            // ----------------------------------------------------------------------------------------------------
            // Reduce workout goals
                // -> check goal count (using ratios) against n sessions
            // Reduce mind & flexibility to mind
                // -> check goal count (using ratios) against n sessions
            
            // Workout Ratios
            // Strength workouts are more specific, they should only be presented if the user sets strength to primary goal and other goals as secondary
            // Determine how many workout goals are primary
            var primaryWorkoutGoals = [0,0,0]
                // 0 or 1
            var nPrimaryWorkoutGoals = 0
            for i in 3...5 {
                // if primary goal, + 1
                if primarySecondaryArray[0][i] == 1 {
                    // -3 as starts at 0
                    nPrimaryWorkoutGoals += 1
                    primaryWorkoutGoals[i - 3] = 1
                }
            }
            // Determine how many workout goals are secondary
            var secondaryWorkoutGoals = [0,0,0]
                // 0 or 1
            var nSecondaryWorkoutGoals = 0
            for i in 3...5 {
                // if secondary goal, + 1
                if primarySecondaryArray[1][i] == 1 {
                    nSecondaryWorkoutGoals += 1
                    secondaryWorkoutGoals[i - 3] = 1
                }
            }
            // ------------------------------------------------------------------
            // Switch total number of workout goals
            let toalNWorkoutGoals = nPrimaryWorkoutGoals + nSecondaryWorkoutGoals
            switch toalNWorkoutGoals {
            // 2 goals ------------------------------------------------------------------
            case 2:
                switch nPrimaryWorkoutGoals {
                    
                // If 1 primary, 1 secondary, set groups only to primary by adding ratios together and setting to primary
                case 1:
                    // + 3 as offset by 3
                    let primaryIndex = primaryWorkoutGoals.index(of: 1)! + 3
                    let secondaryIndex = secondaryWorkoutGoals.index(of: 1)! + 3
                    let totalRatio = ratios[primaryIndex] + ratios[secondaryIndex]
                    ratios[secondaryIndex] = 0
                    ratios[primaryIndex] = totalRatio
                    
                // If 0 or 2, then 2 primary, 2 secondary, find which is most suitable to user and set group only to that by adding ratios and setting to better goal
                case 0,2:
                    // Primary or Secondary
                    var workoutGoals = [Int]()
                    if nPrimaryWorkoutGoals == 0 {
                        workoutGoals = secondaryWorkoutGoals
                    } else {
                        workoutGoals = primaryWorkoutGoals
                    }
                    // Determine the indexes of the goals
                    var indexes = [0,0]
                    for i in 0...2 {
                        if workoutGoals[i] == 1 {
                            if indexes[0] == 0 {
                                // as offset of 3 between ratios and workout goals
                                indexes[0] = i + 3
                            } else {
                                indexes[1] = i + 3
                            }
                        }
                    }
                    
                    // Strength
                        // if man, set to strength
                        // if woman (or other), set to other
                    if indexes.contains(5) {
                        // If male
                            // me questions gender
                        if profileAnswers[0][1] == 0 {
                            // index 1 is strength as strength is last goal
                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]]
                            ratios[indexes[0]] = 0
                            ratios[indexes[1]] = totalRatio
                        } else {
                            // index 1 is strength as strength is last goal
                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]]
                            ratios[indexes[0]] = totalRatio
                            ratios[indexes[1]] = 0
                        }
                    // Else toning and muscle gain
                        // If man, set to muscle gain, if woman, set to toning
                    } else {
                        // If male
                            // me questions gender
                        if profileAnswers[0][1] == 0 {
                            // index 1 is strength as strength is last goal
                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]]
                            ratios[indexes[0]] = 0
                            ratios[indexes[1]] = totalRatio
                        } else {
                            // index 1 is strength as strength is last goal
                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]]
                            ratios[indexes[0]] = totalRatio
                            ratios[indexes[1]] = 0
                        }
                    }
                    
                //
                default:
                        break
                }
                
                //
                
                    
            // 3 goals ------------------------------------------------------------------
            case 3:
                switch nPrimaryWorkoutGoals {
                    
                // If 1 primary, set groups only to primary by adding ratios together and setting to primary
                case 1:
                    // workouts are last three indexes of array of 6 elements
                    let totalRatio = ratios[3] + ratios[4] + ratios[5]
                    // + 3 as offset by 3
                    let primaryIndex = primaryWorkoutGoals.index(of: 1)! + 3
                    for i in 3...5 {
                        if i == primaryIndex {
                            ratios[i] = totalRatio
                        } else {
                            ratios[i] = 0
                        }
                    }
                    
                // If 2, find which is most suitable to user and set group only to that by adding ratios and setting to better goal
                case 2:
                    // Determine the indexes of the primary goals
                    var indexes = [0,0]
                    for i in 0...2 {
                        if primaryWorkoutGoals[i] == 1 {
                            if indexes[0] == 0 {
                                // as offset of 3 between ratios and workout goals
                                indexes[0] = i + 3
                            } else if indexes[1] == 0 {
                                indexes[1] = i + 3
                            } else {
                                indexes[2] = i + 3
                            }
                        }
                    }
                    
                    // Strength and toning
                        // if man, set to strength
                        // if woman (or other), set to other
                    if indexes.contains(5) && indexes.contains(3) {
                        // If male
                        // me questions gender
                        if profileAnswers[0][1] == 0 {
                            // index 1 is strength as strength is last goal
                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
                            ratios[3] = 0
                            ratios[4] = 0
                            ratios[5] = totalRatio
                        } else {
                            // index 1 is strength as strength is last goal
                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
                            ratios[3] = totalRatio
                            ratios[4] = 0
                            ratios[5] = 0
                        }
                    // Strength and muscle gain
                        // for both set to muscle gain
                    } else if indexes.contains(5) && indexes.contains(4) {
                        // index 1 is strength as strength is last goal
                        let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
                        ratios[3] = 0
                        ratios[4] = totalRatio
                        ratios[5] = 0
                    //
                    // Toning and muscle gain
                        // If man, set to muscle gain
                        // if woman, set to toning
                    } else {
                        // If male
                            // me questions gender
                        if profileAnswers[0][1] == 0 {
                            // index 1 is strength as strength is last goal
                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
                            ratios[3] = 0
                            ratios[4] = totalRatio
                            ratios[5] = 0
                        } else {
                            // index 1 is strength as strength is last goal
                            let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
                            ratios[3] = totalRatio
                            ratios[4] = 0
                            ratios[5] = 0
                        }
                    }
                    
                // 0, 3
                case 3:
                    // Primary or Secondary
                    var workoutGoals = [Int]()
                    if nPrimaryWorkoutGoals == 0 {
                        workoutGoals = secondaryWorkoutGoals
                    } else {
                        workoutGoals = primaryWorkoutGoals
                    }
                    // Determine the indexes of the goals
                    var indexes = [0,0,0]
                    for i in 0...2 {
                        if workoutGoals[i] == 1 {
                            if indexes[0] == 0 {
                                // as offset of 3 between ratios and workout goals
                                indexes[0] = i + 3
                            } else if indexes[1] == 0 {
                                indexes[1] = i + 3
                            } else {
                                indexes[2] = i + 3
                            }
                        }
                    }
                    
                    // if man, set to muscle gain ([1])
                    // if woman (or other), set to toning ([0])
                    // If male
                        // me questions gender
                    if profileAnswers[0][1] == 0 {
                        // index 1 is strength as strength is last goal
                        let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
                        ratios[indexes[0]] = 0
                        ratios[indexes[2]] = 0
                        ratios[indexes[1]] = totalRatio
                    } else {
                        // index 1 is strength as strength is last goal
                        let totalRatio = ratios[indexes[0]] + ratios[indexes[1]] + ratios[indexes[2]]
                        ratios[indexes[1]] = 0
                        ratios[indexes[2]] = 0
                        ratios[indexes[0]] = totalRatio
                    }
                //
                default:
                    break
                }
                
            // leave as is if 0 or 1 goals
            default:
                break
            }
            
            
            // ------------------------------------------------------------------
            // Check goals (found by n ratios != 0) against sessions
            var nGoals2 = 0
            for i in 0...ratios.count - 1 {
                if ratios[i] != 0 {
                    nGoals2 += 1
                }
            }
            // if 1 more than sessions, add 1 session
            if nGoals2 == updatedSessionsArray[0] + 1 {
                updatedSessionsArray[0] += 1
            // if goals still to high, reduce further
            } else if nGoals2 > updatedSessionsArray[0] + 1 {
                // Flexibility && Mind -> Mind
                // index 1 is strength as strength is last goal
                let totalRatio = ratios[0] + ratios[1]
                ratios[0] = totalRatio
                ratios[1] = 0
            }
            // do nothing if goals are now less than or equal to sessions
            
        // Their  their n goals is similar to number of sessions, in a range of 2 about goals
            // -> Do nothing except if goals are greater than
                // Still checking range and not just +1 incase I want to do something more one day
        } else if totalNGoals < updatedSessionsArray[0] + 2 && totalNGoals > updatedSessionsArray[0] - 2{
            // If goals is 1 greater than sessions, increase sessions, if not leave sessions as is
            if totalNGoals == updatedSessionsArray[0] + 1 {
                totalNGoals += 1
            }
            
        // Their n goals is lower than preliminary number of sessions lower range
        } else if totalNGoals < rangeArray[0][1] - 1 {
            // Do nothing for the moment
        }
        
        // -------------------------------------------------------------------------
        // MARK: Number of sessions
        // Set number of sessions of each group based on ratios, then limit maximum number of sessions
        
        // Set number of sessions of each group to ratio*nsessions
        for i in 0...ratios.count {
            //
            // Round normally, exept up from less than 0.5, to ensure that all goals have at least 1 session, no matter the ratio
                // + 1 as updatedsessionsArray includes total n sessions
            let nSessions = ratios[i] * Double(updatedSessionsArray[0])
            if nSessions < 0.5 {
                updatedSessionsArray[i + 1] = 1
            } else {
                updatedSessionsArray[i + 1] = Int(round(nSessions))
            }
        }
        // ----------------------------------------------
        // Limit max n sessions of certain groups
                // Possible, currently trying without
        
        // ----------------------------------------------
        // MARK: Final check n sessions
        // CHECK CURRENTLY UNUSED, to be put it if edge cases are vary bad (i.e nsessions = 2, new nsessions = 4)
        var newNSessions = 0
        for i in 1...updatedSessionsArray.count - 1 {
            newNSessions += updatedSessionsArray[i]
        }
//            // If nSessions (total of all sessions)[1]+...+[6] 2 or more greater than nSessions (total sessions)[0], edit
//            if newNSessions > updatedSessionsArray[0] + 1 {
//
//            // New n sessions is sensible, reset n sessions to new
//            } else {
//                updatedSessionsArray[0] = newNSessions
//            }
        
        updatedSessionsArray[0] = newNSessions

        
        
        // ----------------------------------------------
        // MARK: Update ranges
        // Total N sessions range
        profileAnswers[3][0] = rangeArray[0][0]
        profileAnswers[3][1] = rangeArray[0][1]
        // Session ranges
        for i in 1...updatedSessionsArray.count {
            // lower range: i*2
            // upper range: i*2 + 1
            let index = 2 * i
            profileAnswers[3][index] = updatedSessionsArray[i] - 1
            profileAnswers[3][index + 1] = updatedSessionsArray[i] + 1
        }
        
        
        
        // MARK: Set new arrays
            // NOTE IF UPDATING SESSION, THE ARRAYS SHOULDN'T BE SET HERE THE USER SHOULD BE PRESENTED THE NEW ARRAYS AND THEY DECIDE THEN
        if update == false {
            profileAnswers[2] = updatedSessionsArray
            UserDefaults.standard.set(profileAnswers, forKey: "profileAnswers")
        } else {
            
        }
        
        
        
        
//    Tests of what it should present
//    //
//    // Goals > prelim sessions
//    preliminary 4
//    3 mind, 1 flexibility, 2 muscle gain
//    -> 2 mind, 1 flexibility, 2 muscle gain,
//
//    preliminary 2
//    3 mind, 2 flexibility, 2 endurance, 2 toning, 2 strength
//    -> 1 mind, 1 endurance, 1 strength
//
//    preliminary 3
//    2 mind, 1 flexibility, 1 endurance, 2 toning
//    -> 2 mind, 1 endurance, 1 toning
//
//    //
//    // Goals -- prelim sessions
//    preliminary 7
//    3 mind, 2 flexibiity, 1 endurance, 2 muscle gain
//    -> 3 mind, 2 flexibiity, 1 endurance, 2 muscle gain
//
//    preliminary 6
//    3 mind, 3 strength
//    -> 3 mind 3 strength
//
//    //
//    // Goals < prelim sessions
//    preliminary 5
//    2 mind
//    -> 3 mind
//
//    preliminary 7
//    3 mind, 2 toning
//    -> 3 mind, 2 toning
        
    }
    
}
