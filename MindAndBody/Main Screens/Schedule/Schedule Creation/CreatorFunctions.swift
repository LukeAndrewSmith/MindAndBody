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
        // ratios of goal (weighting/importance)
        // ratios indexing == [workout, yoga, meditation, endurance, flexibility]
        var ratios: [Double] = [0,0,0,0,0]
        var goals: [Int] = [0,0,0,0,0]
    
        
        // Create goals
        for i in 0..<goals.count {
            goals[i] = ScheduleVariables.shared.selectedSchedule!["scheduleCreationHelp"]![0][0][scheduleDataStructures.scheduleCreationHelpSorted[0][i][0]] as! Int
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
        
        
        switch ScheduleVariables.shared.selectedSchedule!["scheduleCreationHelp"]![0][1]["scheduleQTime"] as! Int {
        // 1 - 2 days
        case 0:
            switch ScheduleVariables.shared.selectedSchedule!["scheduleCreationHelp"]![0][1]["scheduleQPriority"] as! Int {
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
            switch ScheduleVariables.shared.selectedSchedule!["scheduleCreationHelp"]![0][1]["scheduleQPriority"] as! Int {
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
            switch ScheduleVariables.shared.selectedSchedule!["scheduleCreationHelp"]![0][1]["scheduleQPriority"] as! Int {
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
            switch ScheduleVariables.shared.selectedSchedule!["scheduleCreationHelp"]![0][1]["scheduleQPriority"] as! Int {
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
                    ScheduleVariables.shared.temporaryNSessions = 8
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 6
                }
            // Routine, 10 sessions
            case 2:
                if lotsOfGoals {
                    ScheduleVariables.shared.temporaryNSessions = 10
                } else {
                    ScheduleVariables.shared.temporaryNSessions = 8
                }
            default: break
            }
            
        default: break
        }
        
        // --------------------------------------------------------------------------------------------
        // Now we have a preliminary total number of session, we can create n sessions for each goal
        // Encorporating age, gender, and last two 'Me' questions ------ not done yet
        
        ScheduleVariables.shared.temporarySessionsArray = [0,0,0,0,0]
        var temporaryTemporaySessionsArray: [Double] = [0,0,0,0,0]
        
        // Number of sessions is equal to the total number of sessions * the ratio, then rounded to a sensible number
        for i in 0..<ratios.count {
            // Avoid /0
            temporaryTemporaySessionsArray[i] = Double(ScheduleVariables.shared.temporaryNSessions) * ratios[i]
        }
        
        
        
        // -------------------------------------------------------------------------
        // MARK: Round number of sessions
        for i in 0..<temporaryTemporaySessionsArray.count {
            // Round up for yoga or flexibility, from .25
            if (i == 1 || i == 4) && temporaryTemporaySessionsArray[i].truncatingRemainder(dividingBy: 1) >= 0.25 {
                ScheduleVariables.shared.temporarySessionsArray[i] = Int(ceil(temporaryTemporaySessionsArray[i]))
            } else {
                ScheduleVariables.shared.temporarySessionsArray[i] = Int(temporaryTemporaySessionsArray[i].rounded())
            }
        }
    }
    
}


