//
//  ScheduleData.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Schedule Variabls ---------------------------------------------------------------------------------------------------------------
class ScheduleVariables {
    static var shared = ScheduleVariables()
    private init() {}
    
    // -------------------------------------------
    // MARK: Schedule Screen
    var selectedDay: Int = 0
    
    // -------------------------------------------
    // MARK: Current Schedule && Functions
    
    // Current Schedule
    var selectedScheduleIndex = Int()
    var selectedSchedule: [String: [[[String: Any]]]]?
    
    // Temporary week array
    // If viewed as week, then creates a temporary array of the full week from the schedules sorted to user defaults
    // This array contains dictionaries with fields: group, day, index, so that the relevant group in the schedulesTracking array can be found and updated
    // This avoids the need to store two seperate arrays for week view and day view
    var weekArray: [[String: Any]] = []
    // "group": ""
    // "index0": Int // for indexing in week
    // "index1": Int
    
    // All sessions are stored in schedule week, if schedule is viewed as full week, temporary array is made to stor them in the correct order to present, saves having extra array in schedule
    func createTemporaryWeekViewArray() {
        
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        // Ensure empty
        TemporaryWeekArray.shared.weekArray = []
        
        // Create array ordered, by first finding and adding all instances of workout, then of yoga, then of meditation etc...
        let orderedGroupArray = ["workout", "yoga", "meditation", "endurance", "flexibility"]
        
        // Loop groups
        for i in 0..<orderedGroupArray.count {
            // Loop week
            for j in 0...6 {
                // If day not empty
                if ScheduleVariables.shared.selectedSchedule["schedule"]![j].count != 0 {
                    // Loop day
                    for k in 0..<ScheduleVariables.shared.selectedSchedule["schedule"]![j].count {
                        // If correct group
                        if ScheduleVariables.shared.selectedSchedule["schedule"]![j][k]["group"] as! String == orderedGroupArray[i] {
                            // Create group dict that references this one
                            let groupDict: [String: Any] = [
                                "group": orderedGroupArray[i],
                                "day": j,
                                "index": k,
                                ]
                            // Append
                            TemporaryWeekArray.shared.weekArray.append(groupDict)
                        }
                    }
                }
            }
        }
    }
    
    // Current Schedule Functions
    func currentDayCount() -> Int {
        let count = selectedSchedule["schedule"]?[ScheduleVariables.shared.selectedDay].count ?? {return 0}
        return count
    }
    
    // -------------------------------------------
    // MARK: Session Choice
    var selectedGroup = Groups.workout
    var choiceProgress: Int = 0
    var selectedRows: (inital: Int, final: Int) = (0,0)
    
    var extraSessionCompletion = [false, false, false] // warmup, session, stretching
    
    // Called upon selection of group in schedule screen
    func initializeChoice(extraSession: Bool, selectedRow: Int) {
        if extraSession {
            isExtraSession = true
            extraSessionCompletion = [false, false, false]
            selectedGroup = Groups.extra
            choiceProgress = 0
            selectedRows.initial = selectedRow
        } else {
            isExtraSession = false
            let groupName: String = {
                if scheduleStyle == "day" {
                    return ScheduleVariables.shared.selectedSchedule["schedule"][selectedDay][selectedRow]["group"] as String
                } else {
                    return weekArray[selectedRow]["group"] as String
                }
            }
            selectedGroup = groupName
            choiceProgress = 0
            selectedRows.initial = selectedRow
        }
    }
    
    // Checks if the group is completed
        // row: the row of the group in the initial schedule screen
        // checkAll:
            // True: checks if all components of group
            // False: checks if parameter "isGroupCompleted" of group in schedule
    func isGroupCompleted(row: Int, checkAll: Bool) -> Bool {
        
        // Extra session
        if ScheduleVariables.shared.selectedGroup == Groups.extra {

            return !ScheduleVariables.shared.extraSessionCompletion.contains(false)
            
        // Normal
        } else {
            
            // Get day/index in day for the two different schedule styles
            let (day, indexInDay) = getDayIndexingVariables()
            
            if checkAll {
                // Switch groups
                switch selectedSchedule["schedule"][day][indexInDay]["group"] as! String {
                    
                // Yoga
                case "yoga":
                    // Yoga warmup optional, so is completed if session is finished
                    return selectedSchedule["schedule"][day][indexInDay]["1"] as Bool
                    
                // Meditation
                case "meditation":
                    // Either one of timer or guided for it to be completed
                    return selectedSchedule["schedule"][day][indexInDay]["0"] as Bool  ||  selectedSchedule["schedule"]![day][indexInDay]["1"] as Bool
                    
                // Normal case
                default:
                    // Each group has fields: "group", and "isGroupCompleted", and components of warmup/session/stretching (index with: 0/1/2)     (See scheduleDataStructures.scheduleGroups)
                    // We only want to check components loop the count-2
                    for i in 0..<(selectedSchedule["schedule"][day][indexInDay].count-2) {
                        if selectedSchedule["schedule"][day][indexInDay][String(i)] as Bool == false {
                            return false
                        }
                    }
                    return true
                }

            } else {
                return ScheduleVariables.shared.selectedSchedule["schedule"][day][indexInDay]["isGroupCompleted"] as Bool
            }
        }
    }
    
    func getDayIndexingVariables() -> (day: Int, indexInDay: Int) {
        // Get day/index in day for the two different schedule styles
        let day: Int = {
            if scheduleStyle == "day" {
                return selectedDay
            } else {
                return weekArray[selectedRows[0]]["day"] as Int ?? 0
            }
        }
        let indexInDay: Int = {
            if scheduleStyle == "day" {
                return selectedRows.inital
            } else {
                return weekArray[SselectedRows[0]]["index"] as Int ?? 0
            }
        }
        return (day: day, indexInDay: indexInDay)
    }
    
    // Checks if a component of a group (warmup/session/stretching) is completed using the index of the row
        // Only used for final choice screen, schedule screen uses isGroupCompleted
    func isComponentCompleted(row: Int) -> Bool {
        
        // Extra session
        if selectedGroup == Groups.extra {
            
            return extraSessionCompletion[row]
            
        // Normal
        } else {
            
            // Get day/index in day for the two different schedule styles
            let (day, indexInDay) = getDayIndexingVariables()
            return selectedSchedule["schedule"]![day][indexInDay][row] as Bool
            
        }
    }
    
    func isDayCompleted(day: Int) -> Bool {
        for group in selectedSchedule["schedule"][day] as [String: Any] {
            if !(group["isGroupCompleted"] as Bool) {
                return false
            }
        }
        return true
    }
    
    func isDayEmpty(day: Int) -> Bool {
        return selectedSchedule["schedule"][day].count
    }
    
    // MARK: Update completions functions
    func updateCompletion(row: Int) {
        // Group components
        if isLastChoice() {
            if selectedGroup == Groups.extra {
                extraSessionCompletion[row] = !extraSessionCompletion[row]
                if isGroupCompleted(row: row, checkAll: true) {
                    // MARK: CHECK
                    incrementExtraSessions()
                    updateTracking()
                }

            } else {
                
                // Get day/index in day for the two different schedule styles
                let (day, indexInDay) = getDayIndexingVariables()
                
                let currentBool = selectedSchedule["schedule"][day][indexInDay][row] as Bool
                selectedSchedule["schedule"][day][indexInDay][row] = !currentBool
                selectedSchedule["schedule"][day][indexInDay]["isGroupCompleted"] = isGroupCompleted(row: indexInDay, checkAll: true)
                
                if currentBool != isGroupCompleted(row: indexInDay, checkAll: true) {
                    markAsGroupForOtherSchedules(markAs: !currentBool)
                }
            }
            
        // Group
        } else {
            
            // Get day/index in day for the two different schedule styles
            let (day, _) = getDayIndexingVariables()
            let currentBool = selectedSchedule["schedule"][day][row]["isGroupCompleted"] as Bool
            selectedSchedule["schedule"][day][row]["isGroupCompleted"] = !currentBool
            markAsGroupForOtherSchedules(markAs: !currentBool)
            
            // Maybe should be set after schedule updated to userdefaults!!!!!!!
            ReminderNotifications.shared.updateBadges()
            updateWeekProgress()
            updateTracking()

        }
        
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        schedules[ScheduleVariables.shared.selectedScheduleIndex] = selectedSchedule?
        UserDefaults.standard.set(schedules, forKey: "schedules")
    }
    
    func updateGroupForOtherSchedule(markAs: Bool, group: String) {
        
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        if schedules.count != 0 {
            // Loop Schedules
            for i in 0..<schedules.count {
                // If not currently selected schedule
                if i != selectedScheduleIndex {
                    // Indicates that group has been updated so should break week loop as well
                    var shouldBreak = false
                    // Loop week
                    for j in 0...6 {
                        // If day isn't empty
                        if schedules[i]["schedule"]![j].count != 0 {
                            // Loop day
                            for k in 0..<schedules[i]["schedule"]![j].count {
                                // If correct group and false
                                if schedules[i]["schedule"]![j][k]["group"] as! String == selectedGroup && schedules[i]["schedule"]![j][k]["isGroupCompleted"] as! Bool == !markAs {
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
        
        schedules[ScheduleVariables.shared.selectedScheduleIndex] = selectedSchedule?
        UserDefaults.standard.set(schedules, forKey: "schedules")
    }
    
    
    func isLastChoice() -> Bool {
        return false
    }
    
    
    // Select
    
    // -------------------------------------------

    
    
    //
    // Variables
    // Used in profile, when creating schedule, uses this to create then adds to userdata after (this is so that update schedule can compare new to old to find whats different and tell the user)
    var temporaryNSessions = 0
    // [workout, yoga, meditation, endurance, flexibility]
    var temporarySessionsArray = [0,0,0,0,0]
    // ScheduleVariables.shared.choiceProgress Indicated progress through the choices to select a session
    // Note: ScheduleVariables.shared.choiceProgress[0] = -1 if first screen (i.e groups of the day/week being shown), != 0 choices being displayed and the int indicates the index of the group selected, ---- ScheduleVariables.shared.choiceProgress == progress through choices
//    var choiceProgress = [-1,0]
    // Indicates which row was selected on inital choice screen, and which row was selected on final choice screen (note: row of final choice is stored as row even though title included as row 0 so offset by 1, take into account when using)
//    var selectedRows = [0,0]
//    var selectedDay = Int()
//    var selectedSchedule = Int()
    // Should reload schedule table
    var shouldReloadSchedule = true
    // Should reload choice (once done session, reload to update tick if done)
    var shouldReloadChoice = false
    // Schedule Style: week or day
    var scheduleStyle = "day"
    
    // Checks if new schedule has just been created
    var didCreateNewSchedule = false
    
    // Extra Session variables
    // Indicator for weather the user is completing an extra session, used for didSelectRow, and maskAction to present correct choices
//    var isExtraSession = false
//    var extraSessionCompletion = [false, false, false] // warmup, session, stretching

    
    
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
    var lastDayOpened = 0
    
    // Note, this function should be somewhere else
    // Func reset schedule tracking and week tracking
    func resetWeekTracking() {
        // Use lastResetWeek in tracking progress array to reset schedule tracking bools to false and and week progress to 0
        //
        var trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        // Current mondays date in week (is set to midnight in func)
        let currentMondayDate = Date().firstMondayInCurrentWeekCurrentTimeZone
        // Last Reset = monday of last week reset
        let lastReset = trackingProgressDictionary["LastResetWeek"] as! Date
        
        // Reset if last reset wasn't in current week
        if lastReset < currentMondayDate {
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
            // Set extra sessions to 0
            trackingProgressDictionary["ExtraSessions"] = 0
            // Set Last Reset
            trackingProgressDictionary["LastResetWeek"] = currentMondayDate
            // Update
            UserDefaults.standard.set(schedules, forKey: "schedules")
            UserDefaults.standard.set(trackingProgressDictionary, forKey: "trackingProgress")
            // Reload schedule
            ScheduleVariables.shared.shouldReloadSchedule = true
            // Reset notifications
            ReminderNotifications.shared.setNotifications()
        }
    }
    
}

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
        // Every session has an average difficulty, and those with only one difficulty call it average, so having the default at 1 (average) should never crash
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
                // Foam rolling has one difficulty
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
    // ENSURE IF CHANGING THAT NAMES OF QUESTIONS ETC ARE THE SAME AS THE INDEXING IN Schedules[..]["ScheduleCreationHelp"]
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

