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
    // Look at scheduleDataStructures.profileQA and scheduleDataStructures.defaultDifficultyLevels to understand indexing
    func defaultDifficultyLevels() {
        // Fetch Arrays
        var difficultyLevels = UserDefaults.standard.array(forKey: "difficultyLevels") as! [[Int]]
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        
        // MARK: Straightforward setting data
            // Flexibility - 0
                // Hamstrings
                    difficultyLevels[0][1] = profileAnswers[0][2]
                // Hips
                    difficultyLevels[0][2] = profileAnswers[0][3]
        //
        // MARK: 1: Deductions
            // Flexibility - 0
                // Back Neck - Average of back and neck answers
                    let backNeckAverage = Double((profileAnswers[0][6] + profileAnswers[0][7]) / 2)
                    difficultyLevels[0][3] = conservativeRound(toRound: backNeckAverage)
                // Overall - Average of all stretching questions
                    let flexibilityAverage = Double((profileAnswers[0][2] + profileAnswers[0][3] + profileAnswers[0][4] + profileAnswers[0][5] + profileAnswers[0][6] + profileAnswers[0][7]) / 6)
                    difficultyLevels[0][0] = conservativeRound(toRound: flexibilityAverage)
            // Endurance - 2
                // Endurance Level - Average of 'do you do much cardio' and '5km'
                    let enduranceAverage = Double((profileAnswers[0][11] + profileAnswers[0][15]) / 2)
                    difficultyLevels[2][0] = conservativeRound(toRound: enduranceAverage)
            // Strength - not set in difficultyLevels, but deduced then used below
                // Overall Strength - average of pushup and pullup answers
                    let overallStrength = Double((profileAnswers[0][12] + profileAnswers[0][13]) / 2)
            // Balance
                // Note, answer 0 and 1 hold the same value, 0
                    var balanceAnswer = Int()
                    if profileAnswers[0][8] == 0 {
                        balanceAnswer = 0
                    } else {
                        balanceAnswer = profileAnswers[0][8] - 1
                    }
        //
        // MARK: 2: Deductions that use deductions
            // Yoga - 1
                // Yoga Level - Average of overall flexibility, balance and experience
                let yogaAverage = Double((difficultyLevels[0][0] + balanceAnswer + profileAnswers[0][9]) / 3)
                difficultyLevels[1][0] = conservativeRound(toRound: yogaAverage)
                // Strength Yoga Level - Average of overall strength, balance ??
                let strengthYoga = Double((overallStrength + Double(balanceAnswer)) / 2)
                difficultyLevels[1][1] = conservativeRound(toRound: strengthYoga)
            // Workout
                // Workout Level - Average of overallStrength, endurance, and experience
                let workoutAverage = Double((overallStrength + Double(difficultyLevels[2][0]) + Double(profileAnswers[0][10])) / 3)
                difficultyLevels[3][0] = conservativeRound(toRound: workoutAverage)
                // Workout Level Lower - Average of endurance, and experience
                let workoutAverageLower = Double((overallStrength + Double(difficultyLevels[2][0]) + Double(profileAnswers[0][10])) / 3)
                difficultyLevels[3][1] = conservativeRound(toRound: workoutAverageLower)
    }
    
    func conservativeRound(toRound: Double) -> Int {
        if toRound == 0.5 || toRound == 1.5 {
            return Int(floor(toRound))
        } else {
            return Int(round(toRound))
        }
    }
    
    // MARK: - creatSchedule
    func numberGroups() {
        // Fetch Arrays
        // [mind, flexibility, endurance, toning, muscle gain, strength]
        updatedSessionsArray = [0,0,0,0,0,0,0]
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        
        // MARK: Preliminary Groups, Using 'Me'
            // Time, set preliminary number of sessions
            switch profileAnswers[0][10] {
            case 0:
                updatedSessionsArray[0] = 4
            case 1:
                updatedSessionsArray[0] = 6
            case 2:
                updatedSessionsArray[0] = 9
            default: break
            }
         
        
        // MARK: Update Groups, Using 'Groups'
            //
        
    }
    
    
    
    
}
