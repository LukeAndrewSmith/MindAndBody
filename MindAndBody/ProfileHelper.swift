//
//  ProfileHelper.swift
//  MindAndBody
//
//  Created by Luke Smith on 09.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
class ProfileFunctions {
    // Initialize
    static var shared = ProfileFunctions()
    private init() {}
    
    
    // Set difficulty levels, determines which sessions the app selects for the user
    // MARK: - userDifficultyLevels
    // !!!!!! -> Look at scheduleDataStructures.profileQA and scheduleDataStructures.defaultDifficultyLevels to understand indexing
    func setDifficultyLevels() {
        // Fetch Arrays
        var difficultyLevels = UserDefaults.standard.array(forKey: "difficultyLevels") as! [[Int]]
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [Int]
        
        // MARK: Straightforward setting data
        // Flexibility - 0
        // Hamstrings - [11]
        difficultyLevels[0][1] = profileAnswers[11]
        // Hips - [12]
        difficultyLevels[0][2] = profileAnswers[12]
        //
        // MARK: 1: Deductions
        // Flexibility - 0
        // Back Neck - Average of back and neck answers - [15], [16], [17]
        let backNeckAverage = Double((profileAnswers[15] + profileAnswers[16] + profileAnswers[17])) / 3
        difficultyLevels[0][3] = conservativeRound(toRound: backNeckAverage)
        // Overall - Average of all stretching questions - [11] - [17]
        let overallFlexibility = Double((profileAnswers[11] + profileAnswers[12] + profileAnswers[13] + profileAnswers[14] + profileAnswers[15] + profileAnswers[16] + profileAnswers[17])) / 7
        difficultyLevels[0][0] = conservativeRound(toRound: overallFlexibility)
        // Endurance - 2
        // Endurance Level - Average of 'do you do much cardio' and '5km' and user self opinion - [4] [5] [6]
        let enduranceAverage = Double((profileAnswers[4] + profileAnswers[5] + profileAnswers[6])) / 3
        difficultyLevels[2][0] = conservativeRound(toRound: enduranceAverage)
        // Strength - not set in difficultyLevels, but deduced then used below
        // Overall Strength - average of pushup, pullup and squat and self opinion [7] [8] [9] [10]
        let overallStrength = Double((profileAnswers[7] + profileAnswers[8] + profileAnswers[9] + profileAnswers[10])) / 4
        // Balance - not set, but used later - [18]
        let balanceAnswer = profileAnswers[18]
        // MARK: 2: Deductions that use deductions
        // Yoga - 1
        // Yoga Level - Average of overall flexibility, balance and experience([2])
        let yogaAverage = Double((difficultyLevels[0][0] + balanceAnswer + profileAnswers[2])) / 3
        difficultyLevels[1][0] = conservativeRound(toRound: yogaAverage)
        // Strength Yoga Level - Average of overall strength, balance
        let strengthYoga = Double((overallStrength + Double(balanceAnswer))) / 2
        difficultyLevels[1][1] = conservativeRound(toRound: strengthYoga)
        // Workout
        // Workout Level - Average of overallStrength, endurance, and experience([3])
        let workoutAverage = Double((overallStrength + Double(difficultyLevels[2][0]) + Double(profileAnswers[3]))) / 3
        difficultyLevels[3][0] = conservativeRound(toRound: workoutAverage)
        // Workout Level Lower - Average of endurance, and experience([3]), and squat([9])
        let workoutAverageLower = Double((difficultyLevels[2][0] + profileAnswers[3] + profileAnswers[9])) / 3
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
}
