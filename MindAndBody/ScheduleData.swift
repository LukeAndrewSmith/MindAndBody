//
//  ScheduleData.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation

//
// Custom Section
struct scheduleData {
    
    // Warmup, Workout, Cardio, Stretching, Yoga
    var customSession: [[[Any]]] =
        [
            // Warmup
            // [name] - string, [movements] - int, [sets] - int, [reps] - string
            [],
            // Workout
            // [name] - string, [movements] - int, [sets] - int, [reps] - string
            [],
            // Workout - Circuit
            // [name] - string, [movements] - int, [rounds] - int, [reps] - string
            [],
            // Cardio
            // [name] - string, [movements] - int, [time/distance] - int
            [],
            // Stretching
            // [name] - string, [stretches] - int, [breaths] - int
            [],
            // Yoga
            // [name] - string, [stretches] - int, [poses] - int
            []
    ]
    
    // Meditation
    var meditationArray: [[[[Any]]]] = []
    
}


enum scheduleDataStructures {
    
    //
    // MARK: Schedule Tracking, tracking what youve done each week, putting a tick next to what you've done in schedule if true
    static let scheduleTrackingArrays: [Int:[[Bool]]] =
        [
            // MARK: Mind
            0:
                [
                    // 0
                    [false],
                    // Yoga, Meditation Walk
                    [
                        false,
                        false,
                        false
                    ],
                    // 4 | To Do Yoga - Warmup, Practice
                    [
                        false,
                        false
                    ]
            ],
            
            // Note: Choice = ["title","contents","contents"...]
            // MARK: Flexibility
            1:
                [
                    // 0
                    [false],
                    // 4 | To Do Flexibility - Warmup, Session
                    [
                        false,
                        false
                    ]
            ],
            
            // MARK: Endurance
            2:
                [
                    // 0
                    [false],
                    // Type - High Intesnsity, Steady State
                    [
                        false,
                        false
                    ],
                    // --------------
                    // 4 | High Intensity To Do - warmup, cardio, stretching
                    [
                        false,
                        false,
                        false
                    ],
                    // ------------
                    // Steady State
                    // 5 | Steady State To Do 2 - 2 - To Do
                    [
                        false,
                        false,
                        false,
                        ]
            ],
            // MARK: Toning
            3:
                [
                    // 0
                    [false],
                    // 3 | Toning To Do, warmup, session, stretching
                    [
                        false,
                        false,
                        false
                    ]
            ],
            
            // MARK: Muscle Gain
            4:
                [
                    // 0
                    [false],
                    // 4 | Muscle Gain To Do - Warmup, session, stretching
                    [
                        false,
                        false,
                        false
                    ]
            ],
            
            // MARK: Strength
            5:
                [
                    // 0
                    [false],
                    // 4 | Strength To Do, Warmup, Session, Stretching
                    [
                        false,
                        false,
                        false
                    ]
            ]
    ]
    
}

