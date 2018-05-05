
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
        var difficultyLevels = UserDefaults.standard.object(forKey: "difficultyLevels") as! [String: [String: Int]]
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [String: Int]
        
        // MARK: Straightforward setting data
        // Flexibility - 0
        // Hamstrings - ["flexibilityHamstrings"]
        difficultyLevels["flexibility"]!["hamstrings"] = profileAnswers["flexibilityHamstrings"]
        // Hips - ["flexibilityHips"]
        difficultyLevels["flexibility"]!["hips"] = profileAnswers["flexibilityHips"]
        //
        // MARK: 1: Deductions
        // Flexibility - 0
        // Back Neck - Average of back and neck answers - ["flexibilityBackBackward"], ["flexibilityBackSideways"], ["flexibilityNeck"]
        let backNeckAverage = Double((profileAnswers["flexibilityBackBackward"]! + profileAnswers["flexibilityBackSideways"]! + profileAnswers["flexibilityNeck"]!)) / 3
        difficultyLevels["flexibility"]!["backNeck"] = conservativeRound(toRound: backNeckAverage)
        // Overall - Average of all stretching questions - ["flexibilityHamstrings"] - ["flexibilityNeck"]
            // Seperate otherwise too complex to be resolved in reasonable time
        let sum1 = profileAnswers["flexibilityHamstrings"]! + profileAnswers["flexibilityHips"]! + profileAnswers["flexibilityHipsAnkles"]! + profileAnswers["flexibilityKnees"]!
        let overallFlexibility = Double((sum1 + profileAnswers["flexibilityBackBackward"]! + profileAnswers["flexibilityBackSideways"]! + profileAnswers["flexibilityNeck"]!)) / 7
        difficultyLevels["flexibility"]!["overall"] = conservativeRound(toRound: overallFlexibility)
        // Endurance - 2
        // Endurance Level - Average of 'do you do much cardio', 'stairs', '30 min cardio' and user self opinion - ["enduranceExperience"] ["enduranceStairs"] ["enduranceAbility"] ["enduranceOpinion"]
        let enduranceAverage = Double((profileAnswers["enduranceExperience"]! + profileAnswers["enduranceStairs"]! + profileAnswers["enduranceAbility"]! + profileAnswers["enduranceOpinion"]!)) / 3
        difficultyLevels["endurance"]!["endurance"] = conservativeRound(toRound: enduranceAverage)
        // Strength - not set in difficultyLevels, but deduced then used below
        // Overall Strength - average of pushup, pullup and squat and self opinion ["workoutPushup"] ["workoutPullup"] ["workoutSquat"] ["workoutOpinion"]
        let overallStrength = Double((profileAnswers["workoutPushup"]! + profileAnswers["workoutPullup"]! + profileAnswers["workoutSquat"]! + profileAnswers["workoutOpinion"]!)) / 4
        // Balance - not set, but used later - ["flexibilityBalance"]
        let balanceAnswer = profileAnswers["flexibilityBalance"]
        // MARK: 2: Deductions that use deductions
        // Yoga - 1
        // Yoga Level - Average of overall flexibility, balance and experience(["yogaExperience"])
        let yogaAverage = Double((difficultyLevels["flexibility"]!["overall"]! + balanceAnswer! + profileAnswers["yogaExperience"]!)) / 3
        difficultyLevels["yoga"]!["yoga"] = conservativeRound(toRound: yogaAverage)
        // Workout
        // Workout Level - Average of overallStrength, endurance, and experience(["workoutExperience"])
        let workoutAverage = Double((overallStrength + Double(difficultyLevels["endurance"]!["endurance"]!) + Double(profileAnswers["workoutExperience"]!))) / 3
        difficultyLevels["workout"]!["workout"] = conservativeRound(toRound: workoutAverage)
        // Workout Level Lower - Average of endurance, and experience(["workoutExperience"]), and squat(["workoutSquat"])
        let workoutAverageLower = Double((difficultyLevels["endurance"]!["endurance"]! + profileAnswers["workoutExperience"]! + profileAnswers["workoutSquat"]!)) / 3
        difficultyLevels["workout"]!["workoutLower"] = conservativeRound(toRound: workoutAverageLower)
        // Workout Level Upper - Average of and experience(["workoutExperience"]), pushup(["workoutPushup"]) and pullup(["workoutPullup"])
        let workoutAverageUpper = Double((profileAnswers["workoutExperience"]! + profileAnswers["workoutPushup"]! + profileAnswers["workoutPullup"]!)) / 3
        difficultyLevels["workout"]!["workoutUpper"] = conservativeRound(toRound: workoutAverageUpper)
        
        // Set new difficulty levels
        UserDefaults.standard.set(difficultyLevels, forKey: "difficultyLevels")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["difficultyLevels"])
        
        
        // Check for setting weight suggestions
        
        // Weights
        let movementWeights = UserDefaults.standard.object(forKey: "movementWeights") as! [String: Int]
        let weightRegister = Register.weightRegister()
        // If weighted movements default, i.e user has not changed them, set based on profile
        if movementWeights == weightRegister {
            // select correct row
            var lower: [String: Int] = [:]
            var upper: [String: Int] = [:]
            // Male
            if profileAnswers["gender"] == 0 {
                // Lower
                switch difficultyLevels["workout"]!["workoutLower"] {
                case 0:
                    lower = Register.WRML1
                case 1:
                    lower = Register.WRML2
                case 2:
                    if profileAnswers["workoutExperience"] != 2 {
                        lower = Register.WRML2
                    } else {
                        lower = Register.WRML3
                    }
                default: break
                }
                // Upper
                switch difficultyLevels["workout"]!["workoutUpper"] {
                case 0:
                    upper = Register.WRMU1
                case 1:
                    upper = Register.WRMU2
                case 2:
                    if profileAnswers["workoutExperience"] != 2 {
                        upper = Register.WRMU2
                    } else {
                        upper = Register.WRMU3
                    }
                default: break
                }
            // Female/Other
            } else {
                // Lower
                switch difficultyLevels["workout"]!["workoutLower"] {
                case 0:
                    lower = Register.WRML1
                case 1:
                    lower = Register.WRML2
                case 2:
                    if profileAnswers["workoutExperience"] != 2 {
                        lower = Register.WRML2
                    } else {
                        lower = Register.WRML3
                    }
                default: break
                }
                // Upper
                switch difficultyLevels["workout"]!["workoutUpper"] {
                case 0:
                    upper = Register.WRMU1
                case 1:
                    upper = Register.WRMU2
                case 2:
                    if profileAnswers["workoutExperience"] != 2 {
                        upper = Register.WRMU2
                    } else {
                        upper = Register.WRMU3
                    }
                default: break
                }
            }
            //
            let newWeightDict = lower.merging(upper) { (current, _) in current }
            //
            UserDefaults.standard.set(newWeightDict, forKey: "movementWeights")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["movementWeights"])
        }
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
