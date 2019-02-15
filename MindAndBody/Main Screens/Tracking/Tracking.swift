//
//  Tracking.swift
//  MindAndBody
//
//  Created by Luke Smith on 28.09.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class Tracking {
    static var shared = Tracking()
    private init() {}

    func beginNewWeek() {
        
    }

    
    func updateTracking() {
        let trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        let trackingDictionaryString = UserDefaults.standard.object(forKey: "trackingDictionary") as! [String: Int]
        
        // Convert to [Date: Int]
        var trackingDictionary: [Date: Int] = TrackingHelpers.shared.convertStringDictToDateDict(stringDict: trackingDictionaryString)
        //
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        // Get Mondays date
        let currentMondayDate = Date().firstMondayInCurrentWeekCurrentTimeZone.setToMidnightUTC()

        // Week Goal
        let weekProgress = trackingProgressDictionary["WeekProgress"] as! Double
        let extraSessions = trackingProgressDictionary["ExtraSessions"] as! Double
        let weekGoal = trackingProgressDictionary["WeekGoal"] as! Double
        let currentProgressDivision: Double = ((weekProgress + extraSessions) / weekGoal) * 100.0
        let currentProgress = Int(currentProgressDivision)

        // Keys
        let keys = trackingDictionary.keys.sorted()
        
        // Note: Weeks defined by their mondays date
        // Current week exists
        if keys.contains(currentMondayDate) {
            // Update current weeks progress
            trackingDictionary[currentMondayDate] = currentProgress
            
        // Current week doesn't exist
        } else {
            // Last updated week was last week |or| first week ever updated
            if keys.count == 0 || keys.last! == calendar.date(byAdding: .weekOfYear, value: -1, to: currentMondayDate)?.setToMidnightUTC() {
                // Create current weeks progress
                trackingDictionary.updateValue(currentProgress, forKey: currentMondayDate)
                
            // Skipped weeks
            } else {
                // Update missed weeks with 0, starting with week after last updated value
                var startDate = calendar.date(byAdding: .weekOfYear, value: 1, to: keys.last!)!.setToMidnightUTC()
                
                // Loop adding 0 to dates
                while startDate < currentMondayDate {
                    trackingDictionary.updateValue(0, forKey: startDate)
                    // For some reason adding a week adds an extra hour here but not in other places, so add on a weeks worth of hours
                    startDate = calendar.date(byAdding: .weekOfYear, value: 1, to: startDate)!.setToMidnightUTC()
                }
                // Update today
                trackingDictionary.updateValue(currentProgress, forKey: currentMondayDate)
            }
        }
        
        // Convert back to [String: Int]
        let updatedtrackingDictionaryString: [String: Int] = TrackingHelpers.shared.convertDateDictToStringDict(dateDict: trackingDictionary)
        
        // Save
        UserDefaults.standard.set(updatedtrackingDictionaryString, forKey: "trackingDictionary")
    }
    
    
    // ----------------------------------------------------------------------------------------------------------------
    // MARK: Update Tracking ---------
    //
    // MARK: Week Progress
    func updateWeekProgress() {
        //
        var trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        
        // Recalculate progress each time to be absolutely sure!!!
        
        var completedCount: Int = 0
        if ScheduleManager.shared.schedules.count > 0 {
            // Loop week
            for i in 0...6 {
                // If day isn't empty
                if ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["schedule"]![i].count != 0 {
                    // Loop day
                    for j in 0..<ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["schedule"]![i].count {
                        //
                        if ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["schedule"]![i][j]["isGroupCompleted"] as! Bool == true {
                            completedCount += 1
                        }
                    }
                }
            }
        }
        // Update value
        trackingProgressDictionary["WeekProgress"] = completedCount
        // Update
        UserDefaults.standard.set(trackingProgressDictionary, forKey: "trackingProgress")
    }
    
    //
    // MARK: Week goal
    func updateWeekGoal() {
        //
        var trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        // Find goal = number of groups planned = fullWeekArray.count
        var goal = Int()
        if ScheduleManager.shared.schedules.count > 0 {
            // Loop week
            for i in 0...6 {
                goal += ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["schedule"]![i].count
            }
        } else {
            goal = 1
        }
        // SetWeekGoal
        if goal != 0 {
            trackingProgressDictionary["WeekGoal"] = goal
        } else {
            trackingProgressDictionary["WeekGoal"] = 1
        }
        //
        UserDefaults.standard.set(trackingProgressDictionary, forKey: "trackingProgress")
    }
}
