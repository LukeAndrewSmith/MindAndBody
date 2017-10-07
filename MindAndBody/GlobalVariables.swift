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
let backgroundImageArray: [String] =
    ["iceland", "sunWater", "purpleTree", "water", "mountainsRedBlue", "magicWood", "mountains"]

//
// Selected Session ---------------------------------------------------------------------------------------------------------------------
//
// e.g [Warmup, UpperBody, Session]
// or e.g [Workout, Bodyweight/Circuit/FullBody, Session]
var selectedSession: [Int] = [0,0,-1]

//
// Colours ---------------------------------------------------------------------------------------------------------------------
//
// Grey
let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
// Black
let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
// Green
let colour3 = UIColor(red:0.15, green:0.65, blue:0.36, alpha:1.0)
// Red
let colour4 = UIColor(red:0.74, green:0.25, blue:0.20, alpha:1.0)
//
let colour5 = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)

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
// Menu Index (ensures initial screen is home screen), variable misnamed tabBarIndex ---------------------------------------------------------------------------------------------------------------
//
var tabBarIndex = Int()
var new = Bool()
// Check if app opening for the first time (in a session of the app)
var isInitialAppOpen = true

//
// Schedule Variabls ---------------------------------------------------------------------------------------------------------------
//
// Used in profile, when creating schedule, uses this to create then adds to userdata after (this is so that update schedule can compare new to old to find whats different and tell the user)
var updatedSessionsArray = [0,0,0,0,0,0,0]
//
// choiceProgress Indicated progress through the choices to select a session
// Note: choiceProgress[0] = -1 if first screen, i.e choices being displayed
var choiceProgress = [-1,0]
//
// Automatic choice from schedule variables ---------------------------------------------------------------------------------------------------------------
//
// View to disable interaction
var noInteractionView = UIView()
// Variable to indicate automatic selection is happening
var automaticSelectionIsHappening = false
// Array to indicate selection
var automaticSelectionArray: [Int] = []
// Int to indicate progress through selection
var automaticSelectionProgress = 0

// Schedule table selection
// [0] = selected group, [1] = selected sessions (e.g workout -> warmup, workout, stretching)(wont always be any)
// [0] = Choice 1 (group1, group2, group3 etc..), [1] = Choice 2 (workout(3 items), yoga(2 items))
var tableCounter = [-1,-1]

//
// Walkthrough aids
//
var didSetFinalChoiceWalkthrough = false
var walkthroughProgressFinalChoice = 0



//
// Tracking Variables ---------------------------------------------------------------------------------------------------------------
//
// Goals
var weekGoal = 72.0
    //Int()
var monthGoal = 72.0

// Progress
var weekProgress = 36.0
    //Int()
var monthProgress = 36.0

// Monday - Sunday
var weekTrackingDictionary: [Date: Int] = [:]


// Monday - Sunday
//var weekTrackingDictionary: [Int:Int] =
// Testing update funcs
    // Testing updating today - Works
//        [2:10,
//         3:15,
//         4:25,
//         5:27]
    // Testing across year boundary - Works
//    [26:10,
//     27:15,
//     28:25]
    // Testing if week to fill crosses month boundary (currentMondaysDate = 28, current date = 3) - Works
//    [28:10,
//     29:15,
//     30:25]
    // Testing start a new week normally, + having stopped halfway though the last - Works + Works
//    [28:10,
//     29:15,
//     30:25,
//     31:40]
//    [28:10,
//    29:15,
//    30:25,
//    31:40,
//    1:60,
//    2: 80,
//    3: 97]
    // Testing start at begginning of week with + without values (change current date to current mondays date to test) - Works + Works
//    [:]
//    [4:20]
    // Testing no days - Works
//    [:]
    // Testing skipped days (current date = 7) + starting mid way through week - Works +
//    [04:10,
//    05:15]

    // Test
//    [07:10,
//    08:15,
//    09:25,
//    10:40,
//    11:60]


// All tracking in % of weeks
var trackingDictionary: [Date:Int] = [:]
//var trackingDictionary: [Int:[Int:[Int:Int]]] =
    // Testing update funcs
    // Week tracking, starting new year, + skipping months last year (+ weeks), + skipping weeks last year - Works + Works + Works
//    [2016:  [09: [5: 90,
//                  12: 85,
//                  19: 90,
//                  26: 100],
//             10: [3: 70,
//                  10: 80,
//                  17: 90,
//                  24: 50,
//                  31: 110],
//             11: [7: 97,
//                  14: 86,
//                  21: 94,
//                  28: 91
//                    ],
//             12: [5: 90,
//                  12: 95,
//                  19: 90,
//                  26: 95
//                    ]
//            ],
//    ]
    // Week tracking starting new month, and continuing in new month - Works + Works
//    [2017:  [06: [5: 70,
//                  12: 75,
//                  19: 80,
//                  26: 85],
//             07: [3: 70,
//                  10: 75,
//                  17: 80,
//                  24: 85,
//                  31: 90],
//            08: [7: 90,
//                 14: 95,
//                 21: 70,
//                 28: 80],
//          09: [04: 100,
////              11: 100,
////              18: 97
//                ]
//        ]
//]
    // Week tracking skipped months and didnt finish last month - Works + Works
//    [2017:  [06: [5: 70,
//                  12: 75,
//                  19: 80,
//                  26: 85],
//             07: [3: 70,
//                  10: 75,
//                  17: 80,
////                  24: 85,
////                  31: 90
//                ],
//            ]
//        ]
    // Week tracking, starting new month normally, + skipping week in month, + continuing in month, + updating same week in month - Works + Works + Works + Works
//        [2017:  [06: [5: 70,
//                      12: 75,
//                      19: 80,
//                      26: 85],
//                 07: [3: 70,
//                      10: 75,
//                      17: 80,
//                      24: 85,
//                      31: 90],
//                 08: [7: 90,
//                      14: 95,
//                      21: 70,
//                      28: 80],
//                 09: [04: 100,
//                      11: 25,
//                    ]
//                ]
//            ]

    
//
//    //=  [:]
//    // Test
//    [2017:  [06: [5: 70,
//                  12: 75,
//                  19: 80,
//                  26: 85],
//            07: [3: 70,
//                  10: 75,
//                  17: 80,
//                  24: 85,
//                  31: 90],
//            08: [7: 90,
//                   14: 95,
//                   21: 70,
//                   28: 80],
//            09: [04: 100,
//                   11: 100,
//                   18: 97]
//            ]
//    ]
    // Test 2
//    [2016:  [12: [05: 70,
//                  12: 75,
//                  19: 80,
//                  26: 85],
//            ],
//    2017:  [01: [2: 70,
//                  09: 75,
//                  16: 80,
//                  23: 85,
//                  30: 85],
//             02: [06: 90,
////                  13: 95,
////                  20: 70,
////                  27: 80
//        ]
//            ]
//    ]
// Test 3
//    [2016:  [
//        10: [03: 70,
//             10: 75,
//             17: 80,
//             24: 85,
//             31: 90],
//        11: [07: 70,
//                  14: 75,
//                  21: 80,
//                  28: 85],
//        12: [05: 70,
//              12: 75,
//              19: 80,
//              26: 85]
//        ],
// 2017:  [01: [2: 70,
//              09: 75,
//              16: 80,
//              23: 85,
//              30: 85],
//         02: [06: 90,
//              13: 95,
//              20: 70,
//              27: 80],
//         03: [06: 90,
//              13: 95]
//        ]
//]
    // All tracking in % of months
var monthTrackingDictionary: [Date:Int] = [:]
//var monthTrackingDictionary: [Int:[Int:Int]] =
    // Testing update funcs starting new year skipping months and starting new year - Works + Works
//     [2016:[01: 70,
//           02: 75,
//           03: 80,
//           04: 85,
//           05: 70,
//           06: 75,
//           07: 80,
//           08: 85,
//           09: 70,
//           10: 75,
//           11: 80,
//           12: 85
//        ]
//    ]

    // Skipping months + starting new months + updating months - Works + Works + Works
//    [2017:[01: 70,
//           02: 75,
//           03: 80,
//           04: 85,
//           05: 70,
//           06: 75,
//           07: 80,
//           08: 85,
//           09: 25,
//        ]
//    ]

    
    
    
    
    //=  [:]
//    // Test
//    [2015:[01: 70,
//           02: 75,
//           03: 80,
//           04: 85,
//           05: 70,
//           06: 75,
//           07: 80,
//           08: 85,
//           09: 70,
//           10: 75,
//           11: 80,
//           12: 85],
//    2016:[01: 70,
//           02: 75,
//           03: 80,
//           04: 85,
//           05: 70,
//           06: 75,
//           07: 80,
//           08: 85,
//           09: 70,
//           10: 75,
//           11: 80,
//           12: 85],
//     2017:[01: 70,
//           02: 75,
//           03: 80,
//           04: 85,
//           05: 70,
//           06: 75,
//           07: 80,
//           08: 85,
//           09: 70,
//           10: 75,
//           11: 80,
//           12: 85]
//    ]
// Test 2
//[2016:[
//       12: 85],
// 2017:[01: 70,
//       02: 75,
//       03: 80,
//       04: 85,
//       05: 70,
//       06: 75,
//       07: 80,
//       08: 85,
//       09: 70]
//]



