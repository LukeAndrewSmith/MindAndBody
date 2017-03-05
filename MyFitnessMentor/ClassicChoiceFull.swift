//
//  ClassicFull.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 22.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class ClassicChoiceFull: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    
    // Information View
    @IBOutlet weak var informationView: UIScrollView!
    
    // Information Title Label
    @IBOutlet weak var informationTitle: UILabel!
    
    // PickerViews
    @IBOutlet weak var pickerView: UIPickerView!
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    // Titles
    @IBOutlet weak var presetTitle: UILabel!
    
    @IBOutlet weak var tableTitle: UILabel!
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour3 = UserDefaults.standard.color(forKey: "colour3")!
    let colour4 = UserDefaults.standard.color(forKey: "colour4")!
    let colour5 = UserDefaults.standard.color(forKey: "colour5")!
    let colour6 = UserDefaults.standard.color(forKey: "colour6")!
    let colour7 = UserDefaults.standard.color(forKey: "colour7")!
    let colour8 = UserDefaults.standard.color(forKey: "colour8")!
    
    
    
    
    
    
    
    // Add Preset
    @IBOutlet weak var addPreset: UIButton!
    @IBOutlet weak var removePreset: UIButton!
    
    var presetTexts = ["", "", ""]
    
    let emptyString = ""
    
    let emptyArray =
        [
            // Legs (Quads)
            [0,
             0,
             0,
             0,
             0,
             0],
            // Legs (Hamstrings/Glutes)
            [0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Legs (General)
            [0,
             0,
             0,
             0],
            
            // Pull (Back)
            [0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Pull (Upper Back)
            [0,
             0,
             0,
             0],
            // Pull (Rear Delts)
            [0],
            // Pull (Traps)
            [0,
             0],
            // Pull (Biceps)
            [0,
             0,
             0,
             0],
            // Pull (Forearms)
            [0,
             0,
             0],
            
            // Push (Chest)
            [0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Push (Shoulders)
            [0,
             0,
             0,
             0],
            // Push (Triceps)
            [0,
             0,
             0,
             0,
             0],
            
            // Calves
            [0,
             0],
            // Abs/Core
            [0,
             0,
             0,
             0,
             0]
    ]
    
    var workoutFullPresets =
        [
            [
                // Legs (Quads)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Legs (Hamstrings/Glutes)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Legs (General)
                [0,
                 0,
                 0,
                 0],
                
                // Pull (Back)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Pull (Upper Back)
                [0,
                 0,
                 0,
                 0],
                // Pull (Rear Delts)
                [0],
                // Pull (Traps)
                [0,
                 0],
                // Pull (Biceps)
                [0,
                 0,
                 0,
                 0],
                // Pull (Forearms)
                [0,
                 0,
                 0],
                
                // Push (Chest)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Push (Shoulders)
                [0,
                 0,
                 0,
                 0],
                // Push (Triceps)
                [0,
                 0,
                 0,
                 0,
                 0],
                
                // Calves
                [0,
                 0],
                // Abs/Core
                [0,
                 0,
                 0,
                 0,
                 0]
            ],
            [
                // Legs (Quads)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Legs (Hamstrings/Glutes)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Legs (General)
                [0,
                 0,
                 0,
                 0],
                
                // Pull (Back)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Pull (Upper Back)
                [0,
                 0,
                 0,
                 0],
                // Pull (Rear Delts)
                [0],
                // Pull (Traps)
                [0,
                 0],
                // Pull (Biceps)
                [0,
                 0,
                 0,
                 0],
                // Pull (Forearms)
                [0,
                 0,
                 0],
                
                // Push (Chest)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Push (Shoulders)
                [0,
                 0,
                 0,
                 0],
                // Push (Triceps)
                [0,
                 0,
                 0,
                 0,
                 0],
                
                // Calves
                [0,
                 0],
                // Abs/Core
                [0,
                 0,
                 0,
                 0,
                 0]
            ],
            [
                // Legs (Quads)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Legs (Hamstrings/Glutes)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Legs (General)
                [0,
                 0,
                 0,
                 0],
                
                // Pull (Back)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Pull (Upper Back)
                [0,
                 0,
                 0,
                 0],
                // Pull (Rear Delts)
                [0],
                // Pull (Traps)
                [0,
                 0],
                // Pull (Biceps)
                [0,
                 0,
                 0,
                 0],
                // Pull (Forearms)
                [0,
                 0,
                 0],
                
                // Push (Chest)
                [0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0],
                // Push (Shoulders)
                [0,
                 0,
                 0,
                 0],
                // Push (Triceps)
                [0,
                 0,
                 0,
                 0,
                 0],
                
                // Calves
                [0,
                 0],
                // Abs/Core
                [0,
                 0,
                 0,
                 0,
                 0]
            ]
    ]
    
    
    
    // Workout Cardio Array
    var workoutFullArray =
        [
            // Legs (Quads)
            ["squat",
             "frontSquat",
             "hackSquat",
             "legPress",
             "dumbellFrontSquat",
             "legExtensions"],
            // Legs (Hamstrings/Glutes)
            ["deadlift",
             "romanianDeadlift",
             "dumbellRomanianDeadlift",
             "weightedHipThrust",
             "legCurl",
             "oneLeggedDeadlift",
             "gluteIsolationMachine"],
            // Legs (General)
            ["lungeBarbell",
             "lungeDumbell",
             "bulgarianSplitSquat",
             "stepUp"],
            
            // Pull (Back)
            ["pullUp",
             "pullDown",
             "pullDownMachine",
             "hammerStrengthPullDown",
             "kneelingPullDown",
             "bentOverRowBarbell",
             "bentOverRowDumbell",
             "tBarRow",
             "rowMachine",
             "hammerStrengthRow"],
            // Pull (Upper Back)
            ["facePull",
             "smithMachinePullUp",
             "leaningBackPullDown",
             "seatedMachineRow"],
            // Pull (Rear Delts)
            ["bentOverBarbellRow"],
            // Pull (Traps)
            ["shrugBarbell",
             "shrugDumbell"],
            // Pull (Biceps)
            ["hamerCurl",
             "hammerCurlCable",
             "cableCurl",
             "curl"],
            // Pull (Forearms)
            ["farmersCarry",
             "reverseBarbellCurl",
             "forearmCurl"],
            
            // Push (Chest)
            ["pushUp",
             "benchPress",
             "benchPressDumbell",
             "semiInclineDumbellPress",
             "hammerStrengthPress",
             "chestPress",
             "platePress",
             "barbellKneelingPress",
             "cableFly"],
            // Push (Shoulders)
            ["standingShoulderPressBarbell",
             "standingShoulderPressDumbell",
             "lateralRaise",
             "frontRaise"],
            // Push (Triceps)
            ["ballPushUp",
             "trianglePushUp",
             "closeGripBench",
             "cableExtension",
             "ropeExtension"],
            
            // Calves
            ["standingCalfRaise",
             "seatedCalfRaise"],
            // Abs/Core
            ["hangingLegRaise",
             "hangingLegTwist",
             "plank",
             "sideLegDrop",
             "abRollout"]
    ]
    
    
    // Default Workout Selected Array
    var workoutSelectedArray =
        [
            // Legs (Quads)
            [0,
             0,
             0,
             0,
             0,
             0],
            // Legs (Hamstrings/Glutes)
            [0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Legs (General)
            [0,
             0,
             0,
             0],
            
            // Pull (Back)
            [0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Pull (Upper Back)
            [0,
             0,
             0,
             0],
            // Pull (Rear Delts)
            [0],
            // Pull (Traps)
            [0,
             0],
            // Pull (Biceps)
            [0,
             0,
             0,
             0],
            // Pull (Forearms)
            [0,
             0,
             0],
            
            // Push (Chest)
            [0,
             0,
             0,
             0,
             0,
             0,
             0,
             0,
             0],
            // Push (Shoulders)
            [0,
             0,
             0,
             0],
            // Push (Triceps)
            [0,
             0,
             0,
             0,
             0],
            
            // Calves
            [0,
             0],
            // Abs/Core
            [0,
             0,
             0,
             0,
             0]
    ]
    
    
    
    
    
    // Sets Dictionary
    let setsDictionary =
    [
        0:
        [
            // Legs (Quads)
            [5, 2, 2, 2, 2, 2],
            // Legs (Hamstrings/Glutes)
            [1, 1, 1, 1, 1, 1, 1],
            // Legs (General)
            [1, 1, 1, 1],
        
            // Pull (Back)
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Pull (Upper Back)
            [1, 1, 1, 1],
            // Pull (Rear Delts)
            [1],
            // Pull (Traps)
            [1, 1],
            // Pull (Biceps)
            [1, 1, 1, 1],
            // Pull (Forearms)
            [1, 1, 1],
        
            // Push (Chest)
            [1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Push (Shoulders)
            [1, 1, 1, 1],
            // Push (Triceps)
            [1, 1, 1, 1, 1],
        
            // Calves
            [1, 1],
            // Abs/Core
            [1, 1, 1, 1, 1]
        ],
        1:
        [
            // Legs (Quads)
            [3, 3, 3, 3, 3, 3],
            // Legs (Hamstrings/Glutes)
            [1, 1, 1, 1, 1, 1, 1],
            // Legs (General)
            [1, 1, 1, 1],
            
            // Pull (Back)
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Pull (Upper Back)
            [1, 1, 1, 1],
            // Pull (Rear Delts)
            [1],
            // Pull (Traps)
            [1, 1],
            // Pull (Biceps)
            [1, 1, 1, 1],
            // Pull (Forearms)
            [1, 1, 1],
            
            // Push (Chest)
            [1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Push (Shoulders)
            [1, 1, 1, 1],
            // Push (Triceps)
            [1, 1, 1, 1, 1],
            
            // Calves
            [1, 1],
            // Abs/Core
            [1, 1, 1, 1, 1]
        ],
        2:
        [
            // Legs (Quads)
            [1, 1, 1, 1, 1, 1],
            // Legs (Hamstrings/Glutes)
            [1, 1, 1, 1, 1, 1, 1],
            // Legs (General)
            [1, 1, 1, 1],
            
            // Pull (Back)
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Pull (Upper Back)
            [1, 1, 1, 1],
            // Pull (Rear Delts)
            [1],
            // Pull (Traps)
            [1, 1],
            // Pull (Biceps)
            [1, 1, 1, 1],
            // Pull (Forearms)
            [1, 1, 1],
            
            // Push (Chest)
            [1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Push (Shoulders)
            [1, 1, 1, 1],
            // Push (Triceps)
            [1, 1, 1, 1, 1],
            
            // Calves
            [1, 1],
            // Abs/Core
            [1, 1, 1, 1, 1]
        ],
        3:
        [
            // Legs (Quads)
            [1, 1, 1, 1, 1, 1],
            // Legs (Hamstrings/Glutes)
            [1, 1, 1, 1, 1, 1, 1],
            // Legs (General)
            [1, 1, 1, 1],
            
            // Pull (Back)
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Pull (Upper Back)
            [1, 1, 1, 1],
            // Pull (Rear Delts)
            [1],
            // Pull (Traps)
            [1, 1],
            // Pull (Biceps)
            [1, 1, 1, 1],
            // Pull (Forearms)
            [1, 1, 1],
            
            // Push (Chest)
            [1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Push (Shoulders)
            [1, 1, 1, 1],
            // Push (Triceps)
            [1, 1, 1, 1, 1],
            
            // Calves
            [1, 1],
            // Abs/Core
            [1, 1, 1, 1, 1]
        ],
        4:
        [
            // Legs (Quads)
            [1, 1, 1, 1, 1, 1],
            // Legs (Hamstrings/Glutes)
            [1, 1, 1, 1, 1, 1, 1],
            // Legs (General)
            [1, 1, 1, 1],
            
            // Pull (Back)
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Pull (Upper Back)
            [1, 1, 1, 1],
            // Pull (Rear Delts)
            [1],
            // Pull (Traps)
            [1, 1],
            // Pull (Biceps)
            [1, 1, 1, 1],
            // Pull (Forearms)
            [1, 1, 1],
        
            // Push (Chest)
            [1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Push (Shoulders)
            [1, 1, 1, 1],
            // Push (Triceps)
            [1, 1, 1, 1, 1],
            
            // Calves
            [1, 1],
            // Abs/Core
            [1, 1, 1, 1, 1]
        ],
        5:
        [
            // Legs (Quads)
            [1, 1, 1, 1, 1, 1],
            // Legs (Hamstrings/Glutes)
            [1, 1, 1, 1, 1, 1, 1],
            // Legs (General)
            [1, 1, 1, 1],
            
            // Pull (Back)
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Pull (Upper Back)
            [1, 1, 1, 1],
            // Pull (Rear Delts)
            [1],
            // Pull (Traps)
            [1, 1],
            // Pull (Biceps)
            [1, 1, 1, 1],
            // Pull (Forearms)
            [1, 1, 1],
            
            // Push (Chest)
            [1, 1, 1, 1, 1, 1, 1, 1, 1],
            // Push (Shoulders)
            [1, 1, 1, 1],
            // Push (Triceps)
            [1, 1, 1, 1, 1],
            
            // Calves
            [1, 1],
            // Abs/Core
            [1, 1, 1, 1, 1]
        ],
    ]
    
    
    // Reps Array
    let repsDictionary =
        [
            0:
                [
                    // Legs (Quads)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "15-20 reps", "15-25 reps", "10-20 reps"],
                    // Legs (Hamstrings/Glutes)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps", "10-20 reps"],
                    // Legs (General)
                    ["10-20 reps", "10-20 reps", "10-15 reps", "10-20 reps"],
                    
                    // Pull (Back)
                    ["5-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Upper Back)
                    ["10-15 reps", "5-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Rear Delts)
                    ["10-20 reps"],
                    // Pull (Traps)
                    ["10-20 reps", "10-20 reps"],
                    // Pull (Biceps)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Forearms)
                    ["15-30s", "10-20 reps", "10-20 reps"],
                    
                    // Push (Chest)
                    ["5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Push (Shoulders)
                    ["10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps"],
                    // Push (Triceps)
                    ["5-15 reps", "5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    
                    // Calves
                    ["15-25 reps", "15-25 reps"],
                    // Abs/Core
                    ["5-20 reps", "5-20 reps", "30-120s", "10-15 reps", "5-10 reps"]
            ],
            1:
                [
                    // Legs (Quads)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "15-20 reps", "15-25 reps", "10-20 reps"],
                    // Legs (Hamstrings/Glutes)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps", "10-20 reps"],
                    // Legs (General)
                    ["10-20 reps", "10-20 reps", "10-15 reps", "10-20 reps"],
                    
                    // Pull (Back)
                    ["5-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Upper Back)
                    ["10-15 reps", "5-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Rear Delts)
                    ["10-20 reps"],
                    // Pull (Traps)
                    ["10-20 reps", "10-20 reps"],
                    // Pull (Biceps)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Forearms)
                    ["15-30s", "10-20 reps", "10-20 reps"],
                    
                    // Push (Chest)
                    ["5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Push (Shoulders)
                    ["10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps"],
                    // Push (Triceps)
                    ["5-15 reps", "5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    
                    // Calves
                    ["15-25 reps", "15-25 reps"],
                    // Abs/Core
                    ["5-20 reps", "5-20 reps", "30-120s", "10-15 reps", "5-10 reps"]
            ],
            2:
                [
                    // Legs (Quads)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "15-20 reps", "15-25 reps", "10-20 reps"],
                    // Legs (Hamstrings/Glutes)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps", "10-20 reps"],
                    // Legs (General)
                    ["10-20 reps", "10-20 reps", "10-15 reps", "10-20 reps"],
                    
                    // Pull (Back)
                    ["5-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Upper Back)
                    ["10-15 reps", "5-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Rear Delts)
                    ["10-20 reps"],
                    // Pull (Traps)
                    ["10-20 reps", "10-20 reps"],
                    // Pull (Biceps)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Forearms)
                    ["15-30s", "10-20 reps", "10-20 reps"],
                    
                    // Push (Chest)
                    ["5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Push (Shoulders)
                    ["10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps"],
                    // Push (Triceps)
                    ["5-15 reps", "5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    
                    // Calves
                    ["15-25 reps", "15-25 reps"],
                    // Abs/Core
                    ["5-20 reps", "5-20 reps", "30-120s", "10-15 reps", "5-10 reps"]
            ],
            3:
                [
                    // Legs (Quads)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "15-20 reps", "15-25 reps", "10-20 reps"],
                    // Legs (Hamstrings/Glutes)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps", "10-20 reps"],
                    // Legs (General)
                    ["10-20 reps", "10-20 reps", "10-15 reps", "10-20 reps"],
                    
                    // Pull (Back)
                    ["5-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Upper Back)
                    ["10-15 reps", "5-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Rear Delts)
                    ["10-20 reps"],
                    // Pull (Traps)
                    ["10-20 reps", "10-20 reps"],
                    // Pull (Biceps)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Forearms)
                    ["15-30s", "10-20 reps", "10-20 reps"],
                    
                    // Push (Chest)
                    ["5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Push (Shoulders)
                    ["10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps"],
                    // Push (Triceps)
                    ["5-15 reps", "5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    
                    // Calves
                    ["15-25 reps", "15-25 reps"],
                    // Abs/Core
                    ["5-20 reps", "5-20 reps", "30-120s", "10-15 reps", "5-10 reps"]
            ],
            4:
                [
                    // Legs (Quads)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "15-20 reps", "15-25 reps", "10-20 reps"],
                    // Legs (Hamstrings/Glutes)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps", "10-20 reps"],
                    // Legs (General)
                    ["10-20 reps", "10-20 reps", "10-15 reps", "10-20 reps"],
                    
                    // Pull (Back)
                    ["5-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Upper Back)
                    ["10-15 reps", "5-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Rear Delts)
                    ["10-20 reps"],
                    // Pull (Traps)
                    ["10-20 reps", "10-20 reps"],
                    // Pull (Biceps)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Forearms)
                    ["15-30s", "10-20 reps", "10-20 reps"],
                    
                    // Push (Chest)
                    ["5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Push (Shoulders)
                    ["10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps"],
                    // Push (Triceps)
                    ["5-15 reps", "5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    
                    // Calves
                    ["15-25 reps", "15-25 reps"],
                    // Abs/Core
                    ["5-20 reps", "5-20 reps", "30-120s", "10-15 reps", "5-10 reps"]
            ],
            5:
                [
                    // Legs (Quads)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "15-20 reps", "15-25 reps", "10-20 reps"],
                    // Legs (Hamstrings/Glutes)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps", "10-20 reps"],
                    // Legs (General)
                    ["10-20 reps", "10-20 reps", "10-15 reps", "10-20 reps"],
                    
                    // Pull (Back)
                    ["5-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Upper Back)
                    ["10-15 reps", "5-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Rear Delts)
                    ["10-20 reps"],
                    // Pull (Traps)
                    ["10-20 reps", "10-20 reps"],
                    // Pull (Biceps)
                    ["10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Pull (Forearms)
                    ["15-30s", "10-20 reps", "10-20 reps"],
                    
                    // Push (Chest)
                    ["5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-20 reps", "10-15 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    // Push (Shoulders)
                    ["10-15 reps", "10-15 reps", "10-20 reps", "10-20 reps"],
                    // Push (Triceps)
                    ["5-15 reps", "5-20 reps", "10-15 reps", "10-15 reps", "10-15 reps"],
                    
                    // Calves
                    ["15-25 reps", "15-25 reps"],
                    // Abs/Core
                    ["5-20 reps", "5-20 reps", "30-120s", "10-15 reps", "5-10 reps"]
            ],
            ]
    

    // Weight Array
    let weightDictionaryKG =
        [
            0:
                [
                    // Legs (Quads)
                    [5, 2, 2, 2, 2, 2],
                    // Legs (Hamstrings/Glutes)
                    [1, 1, 1, 1, 1, 1, 1],
                    // Legs (General)
                    [1, 1, 1, 1],
                    
                    // Pull (Back)
                    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
                    // Pull (Upper Back)
                    [1, 1, 1, 1],
                    // Pull (Rear Delts)
                    [1],
                    // Pull (Traps)
                    [1, 1],
                    // Pull (Biceps)
                    [1, 1, 1, 1],
                    // Pull (Forearms)
                    [1, 1, 1],
                    
                    // Push (Chest)
                    [1, 1, 1, 1, 1, 1, 1, 1, 1],
                    // Push (Shoulders)
                    [1, 1, 1, 1],
                    // Push (Triceps)
                    [1, 1, 1, 1, 1],
                    
                    // Calves
                    [1, 1],
                    // Abs/Core
                    [1, 1, 1, 1, 1]
            ],
            1:
                [
                    // Legs (Quads)
                    [3, 3, 3, 3, 3, 3],
                    // Legs (Hamstrings/Glutes)
                    [1, 1, 1, 1, 1, 1, 1],
                    // Legs (General)
                    [1, 1, 1, 1],
                    
                    // Pull (Back)
                    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
                    // Pull (Upper Back)
                    [1, 1, 1, 1],
                    // Pull (Rear Delts)
                    [1],
                    // Pull (Traps)
                    [1, 1],
                    // Pull (Biceps)
                    [1, 1, 1, 1],
                    // Pull (Forearms)
                    [1, 1, 1],
                    
                    // Push (Chest)
                    [1, 1, 1, 1, 1, 1, 1, 1, 1],
                    // Push (Shoulders)
                    [1, 1, 1, 1],
                    // Push (Triceps)
                    [1, 1, 1, 1, 1],
                    
                    // Calves
                    [1, 1],
                    // Abs/Core
                    [1, 1, 1, 1, 1]
            ],
        ]
    
    // Weight Array
    let weightDictionaryLB =
        [
            0:
                [
                    // Legs (Quads)
                    [5, 2, 2, 2, 2, 2],
                    // Legs (Hamstrings/Glutes)
                    [1, 1, 1, 1, 1, 1, 1],
                    // Legs (General)
                    [1, 1, 1, 1],
                    
                    // Pull (Back)
                    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
                    // Pull (Upper Back)
                    [1, 1, 1, 1],
                    // Pull (Rear Delts)
                    [1],
                    // Pull (Traps)
                    [1, 1],
                    // Pull (Biceps)
                    [1, 1, 1, 1],
                    // Pull (Forearms)
                    [1, 1, 1],
                    
                    // Push (Chest)
                    [1, 1, 1, 1, 1, 1, 1, 1, 1],
                    // Push (Shoulders)
                    [1, 1, 1, 1],
                    // Push (Triceps)
                    [1, 1, 1, 1, 1],
                    
                    // Calves
                    [1, 1],
                    // Abs/Core
                    [1, 1, 1, 1, 1]
            ],
            1:
                [
                    // Legs (Quads)
                    [3, 3, 3, 3, 3, 3],
                    // Legs (Hamstrings/Glutes)
                    [1, 1, 1, 1, 1, 1, 1],
                    // Legs (General)
                    [1, 1, 1, 1],
                    
                    // Pull (Back)
                    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
                    // Pull (Upper Back)
                    [1, 1, 1, 1],
                    // Pull (Rear Delts)
                    [1],
                    // Pull (Traps)
                    [1, 1],
                    // Pull (Biceps)
                    [1, 1, 1, 1],
                    // Pull (Forearms)
                    [1, 1, 1],
                    
                    // Push (Chest)
                    [1, 1, 1, 1, 1, 1, 1, 1, 1],
                    // Push (Shoulders)
                    [1, 1, 1, 1],
                    // Push (Triceps)
                    [1, 1, 1, 1, 1],
                    
                    // Calves
                    [1, 1],
                    // Abs/Core
                    [1, 1, 1, 1, 1]
            ],
            ]
    
    
    
    
    // Picker View Array
    var pickerViewArray =
        [
            "default",
            "beginner",
            "bodyWeight",
            "bodybuilding",
            "strength",
            "highIntensity",
            "quick"
        ]
    
    // Table View Section Title Array
    var tableViewSectionArray =
        [
            "legsQ",
            "legsHG",
            "legsG",
            "pullBa",
            "pullUB",
            "pullRD",
            "pullT",
            "pullB",
            "pullF",
            "pushC",
            "pushS",
            "pushT",
            "calves",
            "coreAbs"
    ]
    
    
    // Flash Screen
    func flashScreen() {
        
        let flash = UIView()
        
        flash.frame = CGRect(x: 0, y: pickerView.frame.maxY, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
            
            flash.alpha = 0
            
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
        
    }
    
    
    
    
    
    //
    // ViewDidLoad
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2")
        }
        
        
        // Colours
        self.view.applyGradient(colours: [colour1, colour2])
        questionMark.tintColor = colour1
        
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("fullBody", comment: ""))
        
        
        // Titles
        presetTitle.text = NSLocalizedString("presetWorkouts", comment: "")
        tableTitle.text = NSLocalizedString("workoutTableTitle", comment: "")
        presetTitle.textColor = colour3
        tableTitle.textColor = colour3
        
        
        
        
        // Plus Button Colour
        let origImage1 = UIImage(named: "Plus")
        let tintedImage1 = origImage1?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        addPreset.setImage(tintedImage1, for: .normal)
        
        //Image Tint
        addPreset.tintColor = colour3
        
        
        
        // Minus Button Colour
        let origImage2 = UIImage(named: "Minus")
        let tintedImage2 = origImage2?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        removePreset.setImage(tintedImage2, for: .normal)
        
        //Image Tint
        removePreset.tintColor = colour3
        
        
        
        
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.setTitleColor(colour8, for: .normal)
        
        
        
        
        
        
        
        // Information
        // Scroll View Frame
        self.informationView.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        
        
        view.bringSubview(toFront: informationView)
        
        
        // Information Text
        //
        // Information Text Frame
        let informationText = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationView.frame.size.width - 40, height: 0))
        
        
        
        
        
        // Information Text Frame
        self.informationTitle.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 49)
        informationTitle.text = (NSLocalizedString("information", comment: ""))
        informationTitle.textAlignment = .center
        informationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitle.textColor = colour2
        informationTitle.backgroundColor = colour7
        
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationTitle.addGestureRecognizer(downSwipe)
        informationTitle.isUserInteractionEnabled = true
        
        
        
        self.view.addSubview(informationTitle)
        
        
        
        // Information Text and Attributes
        //
        // String
        let informationLabelString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("workoutChoiceText", comment: "")))
        
        // Range of String
        let textRangeString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("workoutChoiceText", comment: "")))
        let textRange = (informationLabelString as NSString).range(of: textRangeString)
        
        
        // Range of Titles
        let titleRangeString = (NSLocalizedString("movements", comment: ""))
        let titleRange1 = (informationLabelString as NSString).range(of: titleRangeString)
        
        
        // Line Spacing
        let lineSpacing = NSMutableParagraphStyle()
        lineSpacing.lineSpacing = 1.6
        lineSpacing.hyphenationFactor = 1
        
        
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-thin", size: 21)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 21)!, range: titleRange1)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        
        
        
        // Final Text Editing
        informationText.attributedText = informationLabelText
        informationText.textAlignment = .justified
        informationText.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationText.numberOfLines = 0
        informationText.sizeToFit()
        self.informationView.addSubview(informationText)
        
        
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationText.frame.size.height + informationTitle.frame.size.height + 20)
        
        
        
        // TableView Background
        if String(describing: colour7) == String(describing: UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)) {
        
        let tableViewBackground = UIView()
    
        tableViewBackground.backgroundColor = colour7
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        
        tableView.backgroundView = tableViewBackground
        }
        
        
        
        //
        // Preset Workouts
        //
        let defaults = UserDefaults.standard
        
        defaults.register(defaults: ["workoutFullPresets" : workoutFullPresets])
        defaults.register(defaults: ["workoutFullPresetTexts" : presetTexts])
        defaults.register(defaults: ["workoutFullPresetNumber" : 0])
        
        defaults.synchronize()
        
        
        beginButtonEnabled()
        
        
    }
    
    
    // Button Enabled
    func beginButtonEnabled() {
        // Begin Button
        for item in workoutSelectedArray {
            if item.contains(1) {
                beginButton.isEnabled = true
                break
            } else {
                beginButton.isEnabled = false
            }
        }
    }
    
    
    
    
    
    
    
    
    // Set Personalized Preset
    //
    @IBAction func addPreset(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let number = defaults.integer(forKey: "workoutFullPresetNumber")
        var workoutPreset = defaults.object(forKey: "workoutFullPresets") as! [Array<Array<Int>>]
        var presetTextArray = defaults.object(forKey: "workoutFullPresetTexts") as! [String]
        
        
        // Set Preset
        if number < 3 {
            
            
            
            // Alert and Functions
            //
            let inputTitle = NSLocalizedString("workoutInputTitle", comment: "")
            //
            let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
            alert.view.tintColor = colour7
            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.text = " "
                textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
            }
            
            // 3. Get the value from the text field, and perform actions when OK clicked.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0]
                
                
                
                
                // Update Preset Text Arrays
                presetTextArray[number] = (textField?.text)!
                defaults.set(presetTextArray, forKey: "workoutFullPresetTexts")
                defaults.synchronize()
                
                
                
                
                
                // Set new Preset Array
                //
                workoutPreset[number] = self.workoutSelectedArray
                defaults.set(workoutPreset, forKey: "workoutFullPresets")
                
                defaults.synchronize()
                
                
                // Increase Preset Counter
                //
                let newNumber = number + 1
                
                defaults.set(newNumber, forKey: "workoutFullPresetNumber")
                defaults.synchronize()
                
                
                
                // Flash Screen
                self.flashScreen()
                self.pickerView.reloadAllComponents()
                self.tableView.reloadData()
                
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
            
            
            
            
            
            
        } else {
            
        }
    }
    
    
    
    
    // Remove Personalized Preset
    @IBAction func removePreset(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        let number = defaults.integer(forKey: "workoutFullPresetNumber")
        var workoutPreset = defaults.object(forKey: "workoutFullPresets") as! [Array<Array<Int>>]
        var presetTextArray = defaults.object(forKey: "workoutFullPresetTexts") as! [String]
        
        
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let index = (selectedRow) - (pickerViewArray.count + 1)
        
        
        if index > -1 {
            
            workoutPreset.remove(at: index)
            workoutPreset.append(emptyArray)
            
            defaults.set(workoutPreset, forKey: "workoutFullPresets")
            
            
            presetTextArray.remove(at: index)
            presetTextArray.append(emptyString)
            
            defaults.set(presetTextArray, forKey: "workoutFullPresetTexts")
            
            
            if number > 0 {
                let newNumber = number - 1
                defaults.set(newNumber, forKey: "workoutFullPresetNumber")
            } else {
                
            }
            
            
            
            
            defaults.synchronize()
            
            
            
            
            // Flash Screen
            self.flashScreen()
            self.pickerView.reloadAllComponents()
            self.tableView.reloadData()
            
        } else {
            
        }
    }
    
    
    
    
    
    
    // Picker Views
    //
    
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerViewArray.count + 4
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if row < pickerViewArray.count {
            let rowLabel = UILabel()
            let titleData = NSLocalizedString(pickerViewArray[row], comment: "")
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 20)!,NSForegroundColorAttributeName:UIColor.black])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
        } else if row == pickerViewArray.count {
            
            let line = UILabel()
            line.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width / 2, height: 1)
            line.backgroundColor = .black
            line.isEnabled = false
            return line
            
            
        } else if row == pickerViewArray.count + 1 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: "workoutFullPresetTexts") as! [String]
            let titleData = titleDataArray[0]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 20)!,NSForegroundColorAttributeName:UIColor.black])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
            
            
        } else if row == pickerViewArray.count + 2 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: "workoutFullPresetTexts") as! [String]
            let titleData = titleDataArray[1]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 20)!,NSForegroundColorAttributeName:UIColor.black])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
            
            
        } else if row == pickerViewArray.count + 3 {
            let rowLabel = UILabel()
            let titleDataArray = UserDefaults.standard.object(forKey: "workoutFullPresetTexts") as! [String]
            let titleData = titleDataArray[2]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 20)!,NSForegroundColorAttributeName:UIColor.black])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
        }
        
        return UIView()
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let defaults = UserDefaults.standard
        
        switch row {
            
        case 0:
            workoutSelectedArray =
                [
                    // Legs (Quads)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (Hamstrings/Glutes)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (General)
                    [0,
                     0,
                     0,
                     0],
                    
                    // Pull (Back)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Pull (Upper Back)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Rear Delts)
                    [0],
                    // Pull (Traps)
                    [0,
                     0],
                    // Pull (Biceps)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Forearms)
                    [0,
                     0,
                     0],
                    
                    // Push (Chest)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Push (Shoulders)
                    [0,
                     0,
                     0,
                     0],
                    // Push (Triceps)
                    [0,
                     0,
                     0,
                     0,
                     0],
                    
                    // Calves
                    [0,
                     0],
                    // Abs/Core
                    [0,
                     0,
                     0,
                     0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 1:
            workoutSelectedArray =
                [
                    // Legs (Quads)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (Hamstrings/Glutes)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (General)
                    [0,
                     0,
                     0,
                     0],
                    
                    // Pull (Back)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Pull (Upper Back)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Rear Delts)
                    [0],
                    // Pull (Traps)
                    [0,
                     0],
                    // Pull (Biceps)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Forearms)
                    [0,
                     0,
                     0],
                    
                    // Push (Chest)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Push (Shoulders)
                    [0,
                     0,
                     0,
                     0],
                    // Push (Triceps)
                    [0,
                     0,
                     0,
                     0,
                     0],
                    
                    // Calves
                    [0,
                     0],
                    // Abs/Core
                    [0,
                     0,
                     0,
                     0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 2:
            workoutSelectedArray =
                [
                    // Legs (Quads)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (Hamstrings/Glutes)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (General)
                    [0,
                     0,
                     0,
                     0],
                    
                    // Pull (Back)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Pull (Upper Back)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Rear Delts)
                    [0],
                    // Pull (Traps)
                    [0,
                     0],
                    // Pull (Biceps)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Forearms)
                    [0,
                     0,
                     0],
                    
                    // Push (Chest)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Push (Shoulders)
                    [0,
                     0,
                     0,
                     0],
                    // Push (Triceps)
                    [0,
                     0,
                     0,
                     0,
                     0],
                    
                    // Calves
                    [0,
                     0],
                    // Abs/Core
                    [0,
                     0,
                     0,
                     0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 3:
            workoutSelectedArray =
                [
                    // Legs (Quads)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (Hamstrings/Glutes)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (General)
                    [0,
                     0,
                     0,
                     0],
                    
                    // Pull (Back)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Pull (Upper Back)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Rear Delts)
                    [0],
                    // Pull (Traps)
                    [0,
                     0],
                    // Pull (Biceps)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Forearms)
                    [0,
                     0,
                     0],
                    
                    // Push (Chest)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Push (Shoulders)
                    [0,
                     0,
                     0,
                     0],
                    // Push (Triceps)
                    [0,
                     0,
                     0,
                     0,
                     0],
                    
                    // Calves
                    [0,
                     0],
                    // Abs/Core
                    [0,
                     0,
                     0,
                     0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 4:
            workoutSelectedArray =
                [
                    // Legs (Quads)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (Hamstrings/Glutes)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (General)
                    [0,
                     0,
                     0,
                     0],
                    
                    // Pull (Back)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Pull (Upper Back)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Rear Delts)
                    [0],
                    // Pull (Traps)
                    [0,
                     0],
                    // Pull (Biceps)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Forearms)
                    [0,
                     0,
                     0],
                    
                    // Push (Chest)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Push (Shoulders)
                    [0,
                     0,
                     0,
                     0],
                    // Push (Triceps)
                    [0,
                     0,
                     0,
                     0,
                     0],
                    
                    // Calves
                    [0,
                     0],
                    // Abs/Core
                    [0,
                     0,
                     0,
                     0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 5:
            workoutSelectedArray =
                [
                    // Legs (Quads)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (Hamstrings/Glutes)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (General)
                    [0,
                     0,
                     0,
                     0],
                    
                    // Pull (Back)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Pull (Upper Back)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Rear Delts)
                    [0],
                    // Pull (Traps)
                    [0,
                     0],
                    // Pull (Biceps)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Forearms)
                    [0,
                     0,
                     0],
                    
                    // Push (Chest)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Push (Shoulders)
                    [0,
                     0,
                     0,
                     0],
                    // Push (Triceps)
                    [0,
                     0,
                     0,
                     0,
                     0],
                    
                    // Calves
                    [0,
                     0],
                    // Abs/Core
                    [0,
                     0,
                     0,
                     0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 6:
            workoutSelectedArray =
                [
                    // Legs (Quads)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (Hamstrings/Glutes)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Legs (General)
                    [0,
                     0,
                     0,
                     0],
                    
                    // Pull (Back)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Pull (Upper Back)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Rear Delts)
                    [0],
                    // Pull (Traps)
                    [0,
                     0],
                    // Pull (Biceps)
                    [0,
                     0,
                     0,
                     0],
                    // Pull (Forearms)
                    [0,
                     0,
                     0],
                    
                    // Push (Chest)
                    [0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0,
                     0],
                    // Push (Shoulders)
                    [0,
                     0,
                     0,
                     0],
                    // Push (Triceps)
                    [0,
                     0,
                     0,
                     0,
                     0],
                    
                    // Calves
                    [0,
                     0],
                    // Abs/Core
                    [0,
                     0,
                     0,
                     0,
                     0]
            ]
            
            self.tableView.reloadData()
            flashScreen()
            
        case 7:
            break
            
        case 8:
            let fullArray = defaults.object(forKey: "workoutFullPresets") as! [Array<Array<Int>>]
            let array = fullArray[0]
            workoutSelectedArray = array
            
            
            self.tableView.reloadData()
            flashScreen()
            
        case 9:
            let fullArray = defaults.object(forKey: "workoutFullPresets") as! [Array<Array<Int>>]
            let array = fullArray[1]
            workoutSelectedArray = array
            
            
            self.tableView.reloadData()
            flashScreen()
            
        case 10:
            let fullArray = defaults.object(forKey: "workoutFullPresets") as! [Array<Array<Int>>]
            let array = fullArray[2]
            workoutSelectedArray = array
            
            
            self.tableView.reloadData()
            flashScreen()
            
        default:
            break
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    // Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return workoutFullArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(tableViewSectionArray[section], comment: "")
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)!
        header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        header.contentView.backgroundColor = colour7
        //
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutFullArray[section].count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.textLabel?.text = NSLocalizedString(workoutFullArray[indexPath.section][indexPath.row], comment: "")
        
        
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        cell.textLabel?.textColor = .black
        cell.tintColor = .black
        //
        
        if workoutSelectedArray[indexPath.section][indexPath.row] == 1 {
            cell.layer.borderColor = colour7.cgColor
            cell.layer.borderWidth = 2
            
            cell.accessoryType = .checkmark
            

        } else {
            cell.accessoryType = .none
            
        }
        
        
        if cell.textLabel?.text == NSLocalizedString("wristAnkleRotation", comment: "") {
            cell.isUserInteractionEnabled = false
        }
        
        
        // Cell Image
        cell.imageView?.image = #imageLiteral(resourceName: "Test")
        
        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 72
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            workoutSelectedArray[indexPath.section][indexPath.row] = 0
            tableView.reloadData()
        } else {
            cell?.accessoryType = .checkmark
            workoutSelectedArray[indexPath.section][indexPath.row] = 1
            tableView.reloadData()
        }
        
        beginButtonEnabled()

    }
    
    
    
    
    
    
    
    
    
    
    // QuestionMark Button Action
    @IBAction func informationButtonAction(_ sender: Any) {
        
        if self.informationView.frame.minY < self.view.frame.maxY {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            self.informationView.contentOffset.y = 0
            
            
        } else {
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            self.informationView.contentOffset.y = 0
            
            
        }
        
    }
    
    
    
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.informationView.frame.minY < self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
                UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
                
            }
        }
    }
    
    
    
    
    
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        
        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            
            _ = self.navigationController?.popToRootViewController(animated: false)
            
        }
        
    }
    
    
    
    
    // Pass Array to next ViewController
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "workoutFull") {
            
            
            let destinationNC = segue.destination as! UINavigationController
            
            let destinationVC = destinationNC.viewControllers.first as! ClassicScreenFull
            
            destinationVC.workoutMovementsArray = workoutFullArray
            destinationVC.workoutMovementsSelectedArray = workoutSelectedArray
            destinationVC.setsArrayF = setsDictionary[pickerView.selectedRow(inComponent: 0)]!
            destinationVC.repsArrayF = repsDictionary[pickerView.selectedRow(inComponent: 0)]!
            
            
            // Weight
            if UserDefaults.standard.string(forKey: "units") == "kg" {
                destinationVC.weightArrayF = weightDictionaryKG[pickerView.selectedRow(inComponent: 0)]!
            } else {
                destinationVC.weightArrayF = weightDictionaryLB[pickerView.selectedRow(inComponent: 0)]!
            }
        }
    }
    
//---------------------------------------------------------------------------------------------------------------
    
    
    var  viewNumber = 0
    let walkthroughView = UIView()
    let label = UILabel()
    let nextButton = UIButton()
    let backButton = UIButton()
    
    
    // Walkthrough
    func walkthroughMindBody() {
        
        //
        let screenSize = UIScreen.main.bounds
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        //
        walkthroughView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        walkthroughView.backgroundColor = .black
        walkthroughView.alpha = 0.72
        walkthroughView.clipsToBounds = true
        //
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        label.center = view.center
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "SFUIDisplay-light", size: 22)
        label.textColor = .white
        //
        nextButton.frame = screenSize
        nextButton.backgroundColor = .clear
        nextButton.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
        //
        backButton.frame = CGRect(x: 3, y: UIApplication.shared.statusBarFrame.height, width: 50, height: navigationBarHeight)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.textAlignment = .left
        backButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        backButton.titleLabel?.textColor = .white
        backButton.addTarget(self, action: #selector(backWalkthroughView(_:)), for: .touchUpInside)
        
        
        
        
        switch viewNumber {
        case 0:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49, width: self.view.frame.size.width, height: pickerView.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("choiceScreen22", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        case 1:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 98 + pickerView.frame.size.height, width: self.view.frame.size.width, height: tableView.frame.size.height))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            label.center = pickerView.center
            label.center.y = tableView.frame.maxY - 49
            label.center.y = 24.5 + (UIApplication.shared.statusBarFrame.height/2) + pickerView.frame.size.height
            label.text = NSLocalizedString("choiceScreen23", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        case 2:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: self.view.frame.size.width - 98, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 49 + pickerView.frame.size.height, width: 98, height: 49))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            label.center = tableView.center
            label.center.y = tableView.frame.maxY - 49
            label.text = NSLocalizedString("choiceScreen24", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
        //
        case 3:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 98 + pickerView.frame.size.height + tableView.frame.size.height, width: self.view.frame.size.height, height: 49))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("choiceScreen25", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        case 4:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width * 0.917, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("choiceScreen26", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        default: break
            
            
        }
        
        
    }
    
    
    
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    
    
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
        
    }
    
    
    
}
