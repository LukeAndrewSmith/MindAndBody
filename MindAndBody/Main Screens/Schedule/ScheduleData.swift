//
//  ScheduleData.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class ScheduleVariables {
    static var shared = ScheduleVariables()
    private init() {}
    
    // Images
    var groupImageThumbnails: [String: UIImage] = {
        return [
            "workout": #imageLiteral(resourceName: "GroupWorkout").thumbnail(),
            "yoga": #imageLiteral(resourceName: "GroupYoga").thumbnail(),
            "meditation": #imageLiteral(resourceName: "GroupMeditation").thumbnail(),
            "endurance": #imageLiteral(resourceName: "GroupEndurance").thumbnail(),
            "flexibility": #imageLiteral(resourceName: "LessonYoga").thumbnail(),
            ]
    }()
    
    // -------------------------------------------
    // MARK: Schedule Screen
    var selectedDay: Int = 0
    var scheduleStyle = ScheduleStyle.day.rawValue // week or day
    
    // -------------------------------------------
    // MARK: Current Schedule && Functions
    
    // Current Schedule
    var selectedScheduleIndex = Int()
    var schedules: [[String: [[[String: Any]]]]] = []
    
    // Temporary week array
    // If viewed as week, then creates a temporary array of the full week from the schedules sorted to user defaults
        // This array contains dictionaries with fields: group, day, index, so that the relevant group in the schedulesTracking array can be found and updated
        // This avoids the need to store two seperate arrays for week view and day view
    var weekArray: [[String: Any]] = []
    // "group": ""
    // "index0": Int // for indexing in week
    // "index1": Int
    
    // -------------------------------------------
    // MARK:- Initial retreival of data
    
    func setSchedules() {
        schedules = UserDefaults.standard.object(forKey: "schedules") as? [[String: [[[String: Any]]]]] ?? []
        setSelectedScheduleIndex()
        setScheduleStyle()
    }
    
    func setSelectedScheduleIndex() {
        selectedScheduleIndex = UserDefaults.standard.integer(forKey: "selectedScheduleIndex")
        if selectedScheduleIndex >= schedules.count {
            selectedScheduleIndex = 0
        }
    }
    
    func setScheduleStyle() {
        
        if schedules.count > 0 {
            scheduleStyle = (schedules[selectedScheduleIndex]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int).scheduleStyleFromInt()
            if scheduleStyle == ScheduleStyle.day.rawValue {
                createTemporaryWeekViewArray()
            }
        } else {
            scheduleStyle = ScheduleStyle.day.rawValue
        }
    }
    
    // All sessions are stored in schedule week, if schedule is viewed as! full week, temporary array is made to stor them in the correct order to present, saves having extra array in schedule
    func createTemporaryWeekViewArray() {
        
        // Ensure empty
        weekArray = []
        
        // Create array ordered, by first finding and adding all instances of workout, then of yoga, then of meditation etc...
        let orderedGroupArray = ["workout", "yoga", "meditation", "endurance", "flexibility"]
        
        // Loop groups
        for i in 0..<orderedGroupArray.count {
            // Loop week
            for j in 0...6 {
                // If day not empty
                if schedules[selectedScheduleIndex]["schedule"]![j].count != 0 {
                    // Loop day
                    for k in 0..<schedules[selectedScheduleIndex]["schedule"]![j].count {
                        // If correct group
                        if schedules[selectedScheduleIndex]["schedule"]![j][k]["group"] as! String == orderedGroupArray[i] {
                            // Create group dict that references this one
                            let groupDict: [String: Any] = [
                                "group": orderedGroupArray[i],
                                "day": j,
                                "index": k,
                                ]
                            // Append
                            weekArray.append(groupDict)
                        }
                    }
                }
            }
        }
    }
    
    // Current Schedule Functions
    func currentDayCount() -> Int {
        let count = schedules[selectedScheduleIndex]["schedule"]?[selectedDay].count ?? {return 0}()
        return count
    }
    
    // -------------------------------------------
    // MARK:- Session Choice
    var selectedGroup = Groups.none
    var isExtraSession = false
    var choiceProgress: Int = 1
    var selectedRows: (initial: Int, final: Int) = (0,0)
    var shouldPop = false // if user chooses session, need to pop from final choice as well as final choice detail after clicking begin
    var extraSessionCompletion = [false, false, false] // warmup, session, stretching
    // Once session is done, update ticks
    // Final choice tick
    var shouldReloadFinalChoice = false
    var shouldReloadInitialChoice = false
    
    func shouldReloadScheduleTracking() {
        shouldReloadFinalChoice = true
        shouldReloadInitialChoice = true
    }
    
    //
    // Selected Choices
    // Selected choices corrensponds to an array in 'sortedSession' containing (easy, medium, hard) of relevant selection to be chosen by the app based on the profile (arrays containing difficulty level for each group to select)
    // 3 seperate arrays because arrays do not quite correspond in terms of accessing relevant sessions for a number of reasons; not a mistake
    // check sortedSessions array in dataStructures to understand indexing, each session has! the corresponding index written above it
    var selectedChoiceWarmup = ["", "", "", ""]
    var selectedChoiceSession = ["", "", "", ""]
    var selectedChoiceStretching = ["", "", "", ""]
    // Indicators used when making the choice of session, used in updateSelectedChoice()
    var indicator = ""
    var indicator2 = ""
    
    // Called upon selection of group in schedule screen
    func initializeChoice(extraSession: Bool, selectedRow: Int) {
        if extraSession {
            extraSessionCompletion = [false, false, false]
            selectedGroup = Groups.extra
            isExtraSession = true
            choiceProgress = 1
            selectedRows.initial = selectedRow
        } else {
            let groupName: String = {
                if scheduleStyle == "day" {
                    return schedules[selectedScheduleIndex]["schedule"]![selectedDay][selectedRow]["group"] as! String
                } else {
                    return weekArray[selectedRow]["group"] as! String
                }
            }()
            selectedGroup = Groups.init(rawValue: groupName)!
            isExtraSession = false
            print(selectedGroup)
            choiceProgress = 1
            selectedRows.initial = selectedRow
            //
            // selectedChoice...[0] to group
            selectedChoiceWarmup[0] = groupName
            selectedChoiceSession[0] = groupName
            // Notes selectedChoiceStretching not always used but set anyway for all, no harm done
            selectedChoiceStretching[0] = groupName
        }
    }
    
    // MARK: Checks
    // Checks if the group is completed
        // row: the row of the group in the initial schedule screen
        // checkAll:
            // True: checks if all components of group
            // False: checks if parameter "isGroupCompleted" of group in schedule
    func isGroupCompleted(day: Int, indexInDay: Int, checkAll: Bool) -> Bool {
        
        // Extra session
        if isExtraSession {
            return !extraSessionCompletion.contains(false)
            
        // Normal
        } else {
            
            if checkAll {
                // Switch groups
                switch schedules[selectedScheduleIndex]["schedule"]![day][indexInDay]["group"] as! String {
                    
                // Yoga
                case Groups.yoga.rawValue:
                    // Yoga warmup optional, so is completed if session is finished
                    return schedules[selectedScheduleIndex]["schedule"]![day][indexInDay]["1"] as! Bool
                    
                // Meditation
                case Groups.meditation.rawValue:
                    // Either one of timer or guided for it to be completed
                    return schedules[selectedScheduleIndex]["schedule"]![day][indexInDay]["0"] as! Bool  ||  schedules[selectedScheduleIndex]["schedule"]![day][indexInDay]["1"] as! Bool
                    
                // Normal case
                default:
                    // Each group has! fields: "group", and "isGroupCompleted", and components of warmup/session/stretching (index with: 0/1/2)     (See scheduleDataStructures.scheduleGroups)
                    // We only want to check components loop the count-2
                    for i in 0..<(schedules[selectedScheduleIndex]["schedule"]![day][indexInDay].count-2) {
                        if schedules[selectedScheduleIndex]["schedule"]![day][indexInDay][String(i)] as! Bool == false {
                            return false
                        }
                    }
                    return true
                }

            } else {
                return schedules[selectedScheduleIndex]["schedule"]![day][indexInDay]["isGroupCompleted"] as! Bool
            }
        }
    }
    

    // Logic for week/day view indexing
        // Argument takes row
            // If initial choice, row should be indexPath.row
            // If final choice, row should be selectedRows.initial
        // and returns indexing variables for schedule
        // Note if day view, it simply returns selected day and provided row
            // Use more apparent when week view, as finds the indexing variables
    func getIndexing(row: Int) -> (day: Int, indexInDay: Int) {
        let day: Int = {
            if scheduleStyle == ScheduleStyle.day.rawValue {
                return selectedDay
            } else {
                return weekArray[row]["day"] as! Int
            }
        }()
        let indexInDay: Int = {
            if scheduleStyle == ScheduleStyle.day.rawValue {
                return row
            } else {
                return weekArray[row]["index"] as! Int
            }
        }()
        return (day: day, indexInDay: indexInDay)
    }
    
    // Checks if a component of a group (warmup/session/stretching) is completed using the index of the row
        // Only used for final choice screen, schedule screen uses isGroupCompleted
    func isComponentCompleted(day: Int, indexInDay: Int, row: Int) -> Bool {
        if isExtraSession {
            return extraSessionCompletion[row]
        } else {
            return schedules[selectedScheduleIndex]["schedule"]![day][indexInDay][String(row)] as! Bool
            
        }
    }
    
    func isDayCompleted(day: Int) -> Bool {
        for group in schedules[selectedScheduleIndex]["schedule"]![day] {
            if !(group["isGroupCompleted"] as! Bool) {
                return false
            }
        }
        return true
    }
    
    func isDayEmpty(day: Int) -> Bool {
        if schedules.count > 0 {
            return schedules[selectedScheduleIndex]["schedule"]![day].count == 0
        } else {
            return true
        }
    }
    
    func isLastChoice() -> Bool {
        // Present next choice or present session
        switch selectedGroup {
        // Workout
        case Groups.workout:
            if choiceProgress == 6 || choiceProgress == 7 {
                return true
            } else {
                return false
            }
        // Yoga
        case Groups.yoga:
            if choiceProgress == 5 || choiceProgress == 6 {
                return true
            } else {
                return false
            }
            
        // Meditation
        case Groups.meditation:
            if choiceProgress == 1 {
                return true
            } else {
                return false
            }
            
        // Endurance
        case Groups.endurance:
            if choiceProgress == 6 || choiceProgress == 7 || choiceProgress == 9 {
                return true
            } else {
                return false
            }
            
        // Flexibility
        case Groups.flexibility:
            if choiceProgress == 3 || choiceProgress == 4 {
                return true
            } else {
                return false
            }
            
        default:
            return false
        }
    }
    
    // MARK: Updates
    func updateCompletion(day: Int, indexInDay: Int, row: Int?) {
        // Group components
        if isLastChoice() {
            let unWrappedRow = row ?? 0
            if isExtraSession {
                extraSessionCompletion[unWrappedRow] = !extraSessionCompletion[unWrappedRow]
                if isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: true) {
                    // MARK: CHECK
                    incrementExtraSessions()
                    Tracking.shared.updateTracking()
                }

            } else {

                let currentBool = schedules[selectedScheduleIndex]["schedule"]![day][indexInDay][String(unWrappedRow)] as! Bool
                schedules[selectedScheduleIndex]["schedule"]![day][indexInDay][String(unWrappedRow)] = !currentBool
                schedules[selectedScheduleIndex]["schedule"]![day][indexInDay]["isGroupCompleted"] = isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: true)
                saveSchedules()

                if currentBool != isGroupCompleted(day: day, indexInDay: indexInDay, checkAll: true) {
                    let group = schedules[selectedScheduleIndex]["schedule"]![day][indexInDay]["group"] as! String
                    updateGroupForOtherSchedule(markAs: !currentBool, group: group)
                }
                
                ReminderNotifications.shared.updateBadges()
                Tracking.shared.updateWeekProgress()
                Tracking.shared.updateTracking()
            }
            
        // Group
        } else {
            
            // Get day/index in day for the two different schedule styles
            let currentBool = schedules[selectedScheduleIndex]["schedule"]![day][indexInDay]["isGroupCompleted"] as! Bool
            schedules[selectedScheduleIndex]["schedule"]![day][indexInDay]["isGroupCompleted"] = !currentBool
            saveSchedules()
            
            let group = schedules[selectedScheduleIndex]["schedule"]![day][indexInDay]["group"] as! String
            updateGroupForOtherSchedule(markAs: !currentBool, group: group)
            
            ReminderNotifications.shared.updateBadges()
            Tracking.shared.updateWeekProgress()
            Tracking.shared.updateTracking()

        }
    }
    
    func updateGroupForOtherSchedule(markAs: Bool, group: String) {
        
        if schedules.count > 0 {
            // Loop Schedules
            for i in 0..<schedules.count {
                // If not currently selected schedule
                if i != selectedScheduleIndex {
                    // Indicates that group has! been updated so should break week loop as! well
                    var shouldBreak = false
                    // Loop week
                    for j in 0...6 {
                        // If day isn't empty
                        if schedules[i]["schedule"]![j].count != 0 {
                            // Loop day
                            for k in 0..<schedules[i]["schedule"]![j].count {
                                // If correct group and false
                                if schedules[i]["schedule"]![j][k]["group"] as! String == group && schedules[i]["schedule"]![j][k]["isGroupCompleted"] as! Bool == !markAs {
                                    schedules[i]["schedule"]![j][k]["isGroupCompleted"] = markAs
                                    shouldBreak = true
                                    break
                                }
                            }
                        }
                        if shouldBreak {
                            break
                        }
                    }
                }
            }
        }
        saveSchedules()
    }
    
    func incrementExtraSessions() {
        //
        var trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        // Increment
        let currentValue = trackingProgressDictionary["ExtraSessions"] as! Int
        trackingProgressDictionary["ExtraSessions"] = currentValue + 1
        // Save
        UserDefaults.standard.set(trackingProgressDictionary, forKey: "trackingProgress")
    }
    
    // MARK: Save/Create/Delete
    func saveSchedules() {
        UserDefaults.standard.set(schedules, forKey: "schedules")
    }
    
    func createSchedule() {
        // Append new schedule array to schedules
        schedules.append(scheduleDataStructures.emptyWeek)
        
        // Update selected Schedule
        // Set selected schedule to newly created schedule (last schedule in schedules)
        selectedScheduleIndex = schedules.count - 1
        
        saveSelectedScheduleIndex()
        saveSchedules()
    }
    
    func deleteSchedule(at: Int) {
        
        schedules.remove(at: at)
        saveSchedules()
        
        // Update selected schedule index and style
        if schedules.count == 0 {
            selectedScheduleIndex = 0
            scheduleStyle = ScheduleStyle.day.rawValue
        } else {
            if selectedScheduleIndex != 0 {
                selectedScheduleIndex -= 1
            }
            scheduleStyle = (schedules[selectedScheduleIndex]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int).scheduleStyleFromInt()
        }
        saveSelectedScheduleIndex()
        
        if scheduleStyle == ScheduleStyle.day.rawValue {
            selectedDay = Date().weekDayFromMonday
        } else {
            selectedDay = 7
        }
        
        // If week view, create temporary week array
        if schedules.count > 0 && scheduleStyle == ScheduleStyle.week.rawValue {
            createTemporaryWeekViewArray()
        }
        
        // Tracking
        Tracking.shared.updateWeekGoal()
        Tracking.shared.updateWeekProgress()
        Tracking.shared.updateTracking()
        // Set Notifications
        ReminderNotifications.shared.setNotifications()
        
    }
    
    func deleteLastSchedule() {
        deleteSchedule(at: schedules.count-1)
    }
    
    func saveSelectedScheduleIndex() {
        UserDefaults.standard.set(selectedScheduleIndex, forKey: "selectedScheduleIndex")
    }
    
    
    // MARK:- Creation
    // Variables
    // Used in profile, when creating schedule, uses this to create then adds to userdata after (this is so that update schedule can compare new to old to find whats different and tell the user)
    var temporaryNSessions = 0
    // [workout, yoga, meditation, endurance, flexibility]
    var temporarySessionsArray = [0,0,0,0,0]
    // Should reload schedule table
    var shouldReloadSchedule = true
    // Checks if new schedule has! just been created
    var didCreateNewSchedule = false
    
    
    // MARK: Reset Schedule Tracking
    // Last Day
    // Checks if last day on the app was! opened was! yesterday, if so the schedule is animated to the correct day, and this flag is set to today
    // Ensures that on the first open of the app on any day, the correct day on the schedule is presented
    var lastDayOpened = 0
    
    // Func reset schedule tracking
    func resetScheduleTracking() {
        
        // Use lastResetWeek in tracking progress array to reset schedule tracking bools to false and and week progress to 0
        var trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        // Current mondays date in week (is set to midnight in func)
        let currentMondayDate = Date().firstMondayInCurrentWeekCurrentTimeZone
        // Last Reset = monday of last week reset
        let lastReset = trackingProgressDictionary["LastResetWeek"] as! Date
        
        // Reset if last reset wasn't in current week
        if lastReset < currentMondayDate {
            
            // Reset all bools in week tracking to false
            if schedules.count > 0 {
                // Loop schedules
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
            
            trackingProgressDictionary["WeekProgress"] = 0
            trackingProgressDictionary["ExtraSessions"] = 0
            trackingProgressDictionary["LastResetWeek"] = currentMondayDate
            
            saveSchedules()
            UserDefaults.standard.set(trackingProgressDictionary, forKey: "trackingProgress")
            
            shouldReloadSchedule = true
            ReminderNotifications.shared.setNotifications()
        }
    }
    
}

// MARK:-
// MARK:-
enum Groups: String {
    case workout = "workout"
    case yoga = "yoga"
    case meditation = "meditation"
    case endurance = "endurance"
    case flexibility = "flexibility"
    
    case extra = "extra"
    
    case none = "none"
}

enum ScheduleStyle: String {
    case day = "day"
    case week = "week"
}

extension Int {
    func groupFromInt() -> String {
        let groupIntAsString: [Int: String] = [
            0: "workout",
            1: "yoga",
            2: "meditation",
            3: "endurance",
            4: "flexibility"]
        return groupIntAsString[self] ?? "workout"
    }
    
    func scheduleStyleFromInt() -> String {
        let scheduleStyleAsString: [Int: String] = [
            0: "day",
            1: "week"]
        return scheduleStyleAsString[self] ?? "day"
    }
    
}

extension String {
    func groupFromString() -> Int {
        let groupStringAsInt: [String: Int] = [
            "workout": 0,
            "yoga": 1,
            "meditation": 2,
            "endurance": 3,
            "flexibility": 4]
        return groupStringAsInt[self]!
    }
    
    func groupImageFromString() -> UIImage {
        let groupImage: [String: UIImage] = [
            "workout": #imageLiteral(resourceName: "GroupWorkout"),
            "yoga": #imageLiteral(resourceName: "GroupYoga"),
            "meditation": #imageLiteral(resourceName: "GroupMeditation"),
            "endurance": #imageLiteral(resourceName: "GroupEndurance"),
            "flexibility": #imageLiteral(resourceName: "LessonYoga")]
        return groupImage[self]!
    }

}

enum scheduleDataStructures {
    
    // MARK: Profile Data
    //
    // Questions & Answers
    static let profileQA: [String: [String: [String]]] =
        [
            // Gender - GOOD
            "gender": ["Q": ["profileQGender"],
                       "A": ["profileAGender1", "profileAGender2", "profileAGender3"],
                       "image": [""]],
            
            // Strength
            "workoutExperience": ["Q": ["profileQWorkoutExperience"],
                                  "A": ["profileAWorkoutExperience1", "profileAWorkoutExperience2", "profileAWorkoutExperience3"],
                                  "image": [""]],
            "workoutPushup": ["Q": ["profileQWorkoutPushup"],
                              "A": ["profileAWorkoutPushup1", "profileAWorkoutPushup2", "profileAWorkoutPushup3"],
                              "image": ["pushUp"]],
            "workoutPullup": ["Q": ["profileQWorkoutPullup"],
                              "A": ["profileAWorkoutPullup1", "profileAWorkoutPullup2", "profileAWorkoutPullup3"],
                              "image": ["pullUp"]],
            "workoutSquat": ["Q": ["profileQWorkoutSquat"],
                             "A": ["profileAWorkoutSquat1", "profileAWorkoutSquat2", "profileAWorkoutSquat3"],
                             "image": ["bodyweightSquat"]],
            "workoutWeights": ["Q": ["profileQWorkoutWeights"],
                               "A": ["profileAWorkoutWeights1", "profileAWorkoutWeights2", "profileAWorkoutWeights3"],
                               "image": [""]],
            
            // Endurance - GOOD
            "enduranceExperience": ["Q": ["profileQEnduranceExperience"], // How much
                                    "A": ["profileAEnduranceExperience1", "profileAEnduranceExperience2", "profileAEnduranceExperience3"],
                                    "image": [""]],
            "enduranceStairs": ["Q": ["profileQEnduranceStairs"], // Flight of staris
                                 "A": ["profileAEnduranceStairs1", "profileAEnduranceStairs2", "profileAEnduranceStairs3"],
                                 "image": [""]],
            "enduranceAbility": ["Q": ["profileQEnduranceAbility"], // 30 min cardio
                                 "A": ["profileAEnduranceAbility1", "profileAEnduranceAbility2", "profileAEnduranceAbility3"],
                                 "image": [""]],
            
            
            // Yoga - TODO
            "yogaExperience": ["Q": ["profileQYogaExperience"],
                               "A": ["profileAYogaExperience1", "profileAYogaExperience2", "profileAYogaExperience3"],
                               "image": [""]],
            
            // Flexibility - GOOD
            "flexibilityHamstrings": ["Q": ["profileQFlexibilityHamstrings"],
                            "A": ["profileAFlexibilityHamstrings1", "profileAFlexibilityHamstrings2", "profileAFlexibilityHamstrings3"],
                            "image": ["standingHamstring"]],
            "flexibilityHips": ["Q": ["profileQFlexibilityHips"],
                            "A": ["profileAFlexibilityHips1", "profileAFlexibilityHips2", "profileAFlexibilityHips3"],
                            "image": ["butterfly"]],
            "flexibilityHipsAnkles": ["Q": ["profileQFlexibilityHipsAnkles"],
                            "A": ["profileAFlexibilityHipsAnkles1", "profileAFlexibilityHipsAnkles2", "profileAFlexibilityHipsAnkles3"],
                            "image": ["deepSquat"]],
            "flexibilityKnees": ["Q": ["profileQFlexibilityKnees"],
                            "A": ["profileAFlexibilityKnees1", "profileAFlexibilityKnees2", "profileAFlexibilityKnees3"],
                            "image": ["hero"]],
            "flexibilityBackBackward": ["Q": ["profileQFlexibilityBackBackward"],
                            "A": ["profileAFlexibilityBackBackward1", "profileAFlexibilityBackBackward2", "profileAFlexibilityBackBackward3"],
                            "image": ["upwardsDogY"]],
            "flexibilityBackSideways": ["Q": ["profileQFlexibilityBackSideways"],
                            "A": ["profileAFlexibilityBackSideways1", "profileAFlexibilityBackSideways2", "profileAFlexibilityBackSideways3"],
                            "image": ["legDrop"]],
            "flexibilityNeck": ["Q": ["profileQFlexibilityNeck"],
                            "A": ["profileAFlexibilityNeck1", "profileAFlexibilityNeck2", "profileAFlexibilityNeck3"],
                            "image": ["neckRotatorStretch"]],
            // Balance - GOOD
            "flexibilityBalance": ["Q": ["profileQFlexibilityBalance"],
                                   "A": ["profileAFlexibilityBalance1", "profileAFlexibilityBalance2", "profileAFlexibilityBalance3"],
                                   "image": ["tree"]],
        ]
    
    static let profileQASorted: [String] =
        ["gender",
         "workoutExperience", "workoutPushup", "workoutPullup", "workoutSquat", "workoutWeights",
         "enduranceExperience", "enduranceStairs", "enduranceAbility",
         "yogaExperience",
         "flexibilityHamstrings", "flexibilityHips", "flexibilityHipsAnkles", "flexibilityKnees", "flexibilityBackBackward", "flexibilityBackSideways", "flexibilityNeck", "flexibilityBalance",
         ]
    
    
    static let groupNames =
        [
            "workout",
            "yoga",
            "meditation",
            "endurance",
            "flexibility",
        ]
    
    static let shortenedGroupNames =
        [
            // Workout
            "workoutS",
            // Yoga
            "yogaS",
            // Meditation
            "meditationS",
            // Endurance
            "enduranceS",
            // Flexibility
            "flexibilityS",
            ]
    
    //
    // Data
    // Note: All scales 0,1,2
    // Note: All scales default to 1
    // Layer 1, Questions
    // sees profileQASorted above for indexing
    //static let defaultProfileAnswers: [Int] =
    //    [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
    static let defaultProfileAnswers: [String: Int] =
        [
            // Gender - GOOD
            "gender": -1, // Gender
            
            // Strength
            "workoutExperience": -1, // Workout
            "workoutPushup": -1, // Pushup
            "workoutPullup": -1, // Pullup
            "workoutSquat": -1, // Squat
            "workoutWeights": -1, // Strength Experience
            
            // Endurance - GOOD
            "enduranceExperience": -1, // Cardio (Endurance) (Amount)
            "enduranceStairs": -1, // Endurance (Ability)
            "enduranceAbility": -1, // Endurance (Ability)
            
            // Yoga - TODO
            "yogaExperience": -1, // Yoga - 2 - 11
            
            // Flexibility - GOOD
            "flexibilityHamstrings": -1, // Hamstrings - 11
            "flexibilityHips": -1, // Hips - 12
            "flexibilityHipsAnkles": -1, // Hips/Ankles - 13
            "flexibilityKnees": -1, // Knees - 14
            "flexibilityBackBackward": -1, // Back (Backward) - 15
            "flexibilityBackSideways":-1, // Back (Lower - sideways) - 16
            "flexibilityNeck": -1, // Neck - 17
            // Balance - GOOD
            "flexibilityBalance": -1, // Balance - 18
            
            // Meditation - TODO
            // EXTRA
    ]
    //
    static let registerScheduleHelpArray: [[[Int]]] =
        []
    //
    static let defaultScheduleHelpAnswers: [[Int]] =
        []
    
    // Schedule lessons, stores date of first open of app
        // [0] == timeinteravalsince1970 of first date of app opening
        // [1] : 0 == lessons have not been present, 1 == lessons have been presented (i.e is after a week from first monday)
    static let defaultScheduleLessons: [Int] = [0, 0]

    
    // Layer 4: Final
        // Every session has! an average difficulty, and those with only one difficulty call it average, so having the default at 1 (average) should never crash
    // Difficulty:
        // 0 - Easy
        // 1 - Average
        // 2 - Hard
    static let defaultDifficultyLevels: [String: [String: Int]] =
        [
            // Scale of 0 to 3
            // Flexibility
            "flexibility": [
                "overall": 1,
                "hamstrings": 1,
                "hips": 1,
                "backNeck": 1
                // Foam rolling has! one difficulty
            ],
            // Yoga
            "yoga": [
                "yoga": 1,
            ],
            // Endurance
            "endurance": [
                "endurance": 1
            ],
            // Toning/Muscle/Strength
            "workout": [
                "workout": 1,
                "workoutUpper": 1,
                "workoutLower": 1
            ]
    ]
    
    static let difficultyArray =
        [
            "easy",
            "average",
            "hard"
        ]
    
    // Schedules
    static let registerSchedules: [[String: [[[String: Any]]]]] =
        [
    ]
    
    
    // Custom schedules insert this into schedules array
    static let emptyWeek: [String: [[[String: Any]]]] =
        [
            // [0] Schedule --------------------
            "schedule": [
                // CHANGE
                // Monday
                [],
                // Tuesday
                [],
                // Wednesday
                [],
                // Thursday
                [],
                // Friday
                [],
                // Saturday
                [],
                // Sunday
                [],
            ],
            // [1] Information about schedule ------------------
            "scheduleInformation": [
                // Note in array for nesting
                [[
                    "title": "",
                    // Schedule style: day [0] or full week [1], - 1
                    "scheduleStyle": 0,
                    // Schedule type: app helps create schedule [0], custom schedule [1] - 2
                    "customSchedule": 0,
                    // Session choice style: app [0] or user chooses [1] - 3
                    "customSessionChoice": 0,
                    //
                    // Equipment to use - 4
                        // 0 == don't use, 1 == use
                    // Foam Roller
                    "foamRoller": 0,
                    // Pullup Bar
                    "pullupBar": 1,
                ]],
            ],
            // [2] Schedule creation help data --------------------
            "scheduleCreationHelp": [
                // Note: in array for nesting
                [
                    // Goals
                    [
                        "workoutG": 0,
                        "yogaG": 0,
                        "meditationG": 0,
                        "enduranceG": 0,
                        "flexibilityG": 0,
                    ],
                    // Question answers
                    
                    // Time & Commitment
                    ["scheduleQTime": -1,
                     "scheduleQPriority": -1],
                ]
            ]
    ]
    
    // Schedule creation help
    // ENSURE IF CHANGING THAT NAMES OF QUESTIONS ETC ARE THE SAME as! THE INDEXING IN Schedules[..]["ScheduleCreationHelp"]
    static let scheduleCreationHelpSorted: [[[String]]] =
        [
            // Goals - 0
            [
                ["workoutG"], // - 0
                ["yogaG"], // - 1
                ["meditationG"], // - 2
                ["enduranceG"], // - 3
                ["flexibilityG"], // - 4
            ],
            // Schedule creation questions - 1
            [
                // gender
                // Time/Commitment
                ["scheduleQTime", "scheduleATime1", "scheduleATime2", "scheduleATime3", "scheduleATime4"], // // Time - 0
                ["scheduleQPriority", "scheduleAPriority1", "scheduleAPriority2", "scheduleAPriority3"], // Priority - 1
            ],
    ]
    
    //
    // MARK: Schedule Tracking, tracking what youve done each week, putting a tick next to what you've done in schedule if true
    static let scheduleGroups: [Int: [String: Any]] =
        [
            // MARK: Workout
            0: ["group": "workout",
                "isGroupCompleted": false,
                "0": false, // Warmup
                "1": false, // Session
                "2": false], // Stretching
            
            // MARK: Yoga
            1: ["group": "yoga",
                "isGroupCompleted": false,
                "0": false, // Warmup
                "1": false], // Practice
            
            // MARK: Meditation
            2: ["group": "meditation",
                 "isGroupCompleted": false,
                 "0": false, // Timer
                 "1": false], // Guided
            
            // MARK: Endurance
            3: ["group": "endurance",
                "isGroupCompleted": false,
                "0": false, // Warmup
                "1": false, // Session
                "2": false], // Stretching
            
            // Note: Choice = ["title","contents","contents"...]
            // MARK: Flexibility
            4: ["group": "flexibility",
                "isGroupCompleted": false,
                "0": false, // Warmup
                "1": false], // Session
        ]
}

