//
//  GlobalVariables.swift
//  MindAndBody
//
//  Created by Luke Smith on 02.08.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


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
    var selectedSession: [String] = ["warmup", "full", ""]
}

//
// Colours ---------------------------------------------------------------------------------------------------------------------
enum Colors {
    // Light
    static let light = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    // Dark
    static let dark = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    // Green
    static let green = UIColor(red:0.15, green:0.65, blue:0.36, alpha:1.0)
    // Red
    static let red = UIColor(red:0.74, green:0.25, blue:0.20, alpha:1.0)
}

//
// Animation Times ---------------------------------------------------------------------------------------------------------------
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
enum TopBarHeights {
    // Navigation bar
    static let navigationBarHeight = 44
    //
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    //
    static let combinedHeight = 44 + UIApplication.shared.statusBarFrame.height
    //
    // Not in fitting with enum name....
    static let homeIndicatorHeight: CGFloat = 34
}

//
// Sound player
class BellPlayer {
    static var shared = BellPlayer()
    private init() {}
    //
    // Name possibly misleading, as also used for background sounds in meditation timer
    var bellPlayer: AVAudioPlayer?
    
    // Meditation Timer didSetEndTime
    var didSetEndTime = false
}

//
// Menu Variables ---------------------------------------------------------------------------------------------------------------
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
    // Menu interaction type
        // 0 == slide, 1 == press
    var menuInteractionType = 0
    
    // Each time going to screen from menu, view loads twice, causes little design issue for walkthough so this variables ensures walkthrough is only presented on the seconds load
        // Issue is that the walkthrough is presented before the view has animated into the right place
        // Only used in settings as only place the issue is noticable due to black walkthrough screen, and seeing as viewdidload might be called many times, this isn't the safest fix but works for now
    var secondLoad = false
}

//
// Tracking Variables {
class TrackingVariables {
    static var shared = TrackingVariables()
    private init() {}
    
    //
    var minTime = Double()
}

//
// Schedule Variabls ---------------------------------------------------------------------------------------------------------------
class ScheduleVariables {
    static var shared = ScheduleVariables()
    private init() {}
    //
    // Variables
    // Used in profile, when creating schedule, uses this to create then adds to userdata after (this is so that update schedule can compare new to old to find whats different and tell the user)
    var temporaryNSessions = 0
    // [workout, yoga, meditation, endurance, flexibility]
    var temporarySessionsArray = [0,0,0,0,0]
    // ScheduleVariables.shared.choiceProgress Indicated progress through the choices to select a session
    // Note: ScheduleVariables.shared.choiceProgress[0] = -1 if first screen (i.e groups of the day/week being shown), != 0 choices being displayed and the int indicates the index of the group selected, ---- ScheduleVariables.shared.choiceProgress[1] == progress through choices
    var choiceProgress = [-1,0]
    // Indicates which row was selected on inital choice screen, and which row was selected on final choice screen (note: row of final choice is stored as row even though title included as row 0 so offset by 1, take into account when using)
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
    
    
    //
    // Selected Choices
    // Selected choices corrensponds to an array in 'sortedSession' containing (easy, medium, hard) of relevant selection to be chosen by the app based on the profile (arrays containing difficulty level for each group to select)
    // 3 seperate arrays because arrays do not quite correspond in terms of accessing relevant sessions for a number of reasons; not a mistake
    // check sortedSessions array in dataStructures to understand indexing, each session has the corresponding index written above it
    var selectedChoiceWarmup = ["", "", "", ""]
    var selectedChoiceSession = ["", "", "", ""]
    var selectedChoiceStretching = ["", "", "", ""]
    // Indicators used when making the choice of session, used in updateSelectedChoice()
    var indicator = ""
    var indicator2 = ""
    
    
    //
    // Last Day
    // Checks if last day on the app was opened was yesterday, if so the schedule is animated to the correct day, and this flag is set to today
    // Ensures that on the first open of the app on any day, the correct day on the schedule is presented
    var lastDayOpened: Date? = nil
    //Date().firstMondayInCurrentWeek
    
    
    // Note, this function should be somewhere else
    // Func reset schedule tracking and week tracking
    func resetWeekTracking() {
        // Use lastResetWeek in tracking progress array to reset schedule tracking bools to false and and week progress to 0
        //
        var trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        // Current mondays date in week
        let currentMondayDate = Date().firstMondayInCurrentWeek
        // Last Reset = monday of last week reset
        let lastReset = trackingProgressDictionary["LastResetWeek"] as! Date
        
        // Reset if last reset wasn't in current week
        if lastReset != currentMondayDate {
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
            // Reset all bools in week tracking to false
            if schedules.count != 0 {
                // Loop scheduleTracking
                for i in 0..<schedules.count {
                    // Loop week
                    for j in 0...6 {
                        // If day not empty
                        if schedules[i]["schedule"]![j].count != 0 {
                            // Loop day
                            for k in 0..<schedules[i]["schedule"]![j].count {
                                // Set all to false
                                schedules[i]["schedule"]![j][k]["isGroupCompleted"] = false
                                schedules[i]["schedule"]![j][k]["0"] = false
                                schedules[i]["schedule"]![j][k]["1"] = false
                                
                                // Check if stretching part of group
                                if schedules[i]["schedule"]![j][k]["2"] != nil {
                                    schedules[i]["schedule"]![j][k]["2"] = false
                                }
                            }
                        }
                    }
                }
            }
            // Set week progress to 0
            trackingProgressDictionary["WeekProgress"] = 0
            // Set Last Reset
            trackingProgressDictionary["LastResetWeek"] = currentMondayDate
            // Update
            UserDefaults.standard.set(schedules, forKey: "schedules")
            UserDefaults.standard.set(trackingProgressDictionary, forKey: "trackingProgress")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["trackingProgress", "schedules"])
        }
    }
    
}
