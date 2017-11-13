//
//  GlobalVariables.swift
//  MindAndBody
//
//  Created by Luke Smith on 02.08.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Global Variables ---------------------------------------------------------------------------------------------------------------
//
// Background Images Array ---------------------------------------------------------------------------------------------------------------
//
enum BackgroundImages {
    static let backgroundImageArray: [String] =
        ["iceland", "sunWater", "purpleTree", "water", "mountainsRedBlue", "magicWood", "mountains"]
}

//
// Selected Session ---------------------------------------------------------------------------------------------------------------------
//
// e.g [Warmup, UpperBody, Session]
// [0]; 0 = warmup, 1 = workout, 2 = cardio, 3 = stretching, 4 = yoga
// [1];
// warmup: 0 = full, 1 = upper, 2 = lower, 3 = cardio
// workout
// gym
// workout classic; 0-5, 0 = full, 1 = upper, 2 = lower, 3 = legs, 4 = pull, 5 = push
// workout strength; 6 = 5x5
// workout circuit; 7-9, 7 = full, 8 = upper, 9 = lower
// bodyweight
// workout bodyweight; 10-12, 10 = full, 11 = upper, 12 = lower
// workout bodyweight circuit; 13-15, 13 = full, 14 = upper, 15 = lower
// cardio: 0 = rowing, 1 = biking, 2 = rowing
class SelectedSession {
    static let shared = SelectedSession()
    private init() {}
    //
    // Variables
    // Selected Session
    var selectedSession: [Int] = [0,0,-1]
}

//
// Colours ---------------------------------------------------------------------------------------------------------------------
enum Colours {
    //
    // Grey
    static let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    // Black
    static let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    // Green
    static let colour3 = UIColor(red:0.15, green:0.65, blue:0.36, alpha:1.0)
    // Red
    static let colour4 = UIColor(red:0.74, green:0.25, blue:0.20, alpha:1.0)
    //
    static let colour5 = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
}

//
// Animation Times ---------------------------------------------------------------------------------------------------------------
//
enum AnimationTimes {
    // View slide up
    static let animationTime1 = 0.5
    // View slide down
    static let animationTime2 = 0.15
    // Final choice screen element animation
    static let animationTime3 = 0.7
    // Automatic selection
    static let animationTime4 = 0.05
    // Walkthrough
    static let animationTime5 = 0.4
}

//
// Navigation + Status height ---------------------------------------------------------------------------------------------------------------
//
enum TopBarHeights {
    // Navigation bar
    static let navigationBarHeight = 44
    //
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    //
    static let combinedHeight = 44 + UIApplication.shared.statusBarFrame.height
}

//
// Menu Variables ---------------------------------------------------------------------------------------------------------------
//
class MenuVariables {
    static var shared = MenuVariables()
    private init() {}
    //
    // Variables
    // The index of the menu
    var menuIndex = Int()
    // When selecting a  view in the menu, this determines wether it's new or not
    var isNewView = Bool()
    // Check if app opening for the first time (in a session of the app)
    var isInitialAppOpen = true
}

//
// Schedule Variabls ---------------------------------------------------------------------------------------------------------------
//
class ScheduleVariables {
    static var shared = ScheduleVariables()
    private init() {}
    //
    // Variables
    // Used in profile, when creating schedule, uses this to create then adds to userdata after (this is so that update schedule can compare new to old to find whats different and tell the user)
    var updatedSessionsArray = [0,0,0,0,0,0,0]
    // ScheduleVariables.shared.choiceProgress Indicated progress through the choices to select a session
    // Note: ScheduleVariables.shared.choiceProgress[0] = -1 if first screen (i.e groups of the day/week being shown), != 0 choices being displayed and the int indicates the index of the group selected, ---- ScheduleVariables.shared.choiceProgress[1] == progress through choices
    var choiceProgress = [-1,0]
    // Indicates which row was selected on inital choice screen, and which row was selected on final choice screen
    var selectedRows = [0,0]
    // Selected day
    var selectedDay = Int()
    // Selected schedule
    var selectedSchedule = Int()
    // Should reload schedule table
    var shouldReloadSchedule = true
    // Should reload choice (once done session, reload to update tick if done)
    var shouldReloadChoice = false
    
    // Checks if new schedule has just been created
    var didCreateNewSchedule = false
    
    
    // Note, this function should be somewhere else
    // Func reset schedule tracking and week tracking
    func resetWeekTracking() {
        // Use lastResetWeek in tracking progress array to reset schedule tracking bools to false and and week progress to 0
        var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
        var trackingProgressArray = UserDefaults.standard.object(forKey: "trackingProgress") as! [Any]
        //
        // Current mondays date in week
        let currentMondayDate = Date().firstMondayInCurrentWeek
        // Last Reset = monday of last week reset
        let lastReset = trackingProgressArray[2] as! Date
        
        // Reset if last reset wasn't in current week
        if lastReset != currentMondayDate {
            // Reset all bools in week tracking to false
            if scheduleTracking.count != 0 {
                // Loop scheduleTracking
                for i in 0...scheduleTracking.count - 1 {
                    // Loop schedule (week containing days/ full week)
                    for j in 0...scheduleTracking[i].count - 1 {
                        // If day/full week not empty
                        if scheduleTracking[i][j].count != 0 {
                            // Loop day/full week
                            for k in 0...scheduleTracking[i][j].count - 1 {
                                // Loop groups (should always be 0...1, see SchedulDataStructures.scheduleTrackingArrays)
                                for l in 0...scheduleTracking[i][j][k].count - 1 {
                                    // Will always contain something, check SchedulDataStructures.scheduleTrackingArrays
                                    for m in 0...scheduleTracking[i][j][k][l].count - 1 {
                                        scheduleTracking[i][j][k][l][m] = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // Set week progress to 0
            trackingProgressArray[0] = 0
            // Set Last Reset
            trackingProgressArray[2] = currentMondayDate
            // Indicate has been reset, to indicate if this func called again on a monday that it already has been reset
            trackingProgressArray[3] = true
            //
            UserDefaults.standard.set(trackingProgressArray, forKey: "trackingProgress")
            UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["trackingProgress", "scheduleTracking"])
        }
    }
}
