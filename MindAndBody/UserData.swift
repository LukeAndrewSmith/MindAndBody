//
//  UserData.swift
//  MindAndBody
//
//  Created by Luke Smith on 25.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation


//
// MARK: User Data 




//
// Custom Section
struct customData {
    
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


enum customSectionEmtpySessions {
    
    // Empty Session, Warmup, Workout, Workout - circuit - [string],[int],[int],[int]
    static let emptySessionFour: [[Any]] =
    [
        // Name - String
        [],
        // Movements - Int
        [],
        // Sets - Int
        [],
        // Reps - String?
        []
    ]
    
    // Empty Session, Cardio, Stretching, Yoga, - [string],[int],[int]
    static let emptySessionThree: [[Any]] =
    [
        // Name - String
        [],
        // Movements - Int
        [],
        // Rounds - Int
        [],
        // Reps - String?
        []
    ]
    
    //
    static let emptySessionMeditation: [[[Any]]] =
    [
        // Name - String
        [[]],
        // Duration - Int
        [[]],
        // Bells, starting and ending bells go at first and last, interval bells in the middle
        // [Bell, Time] - [Int]
        [[-1,0],[-1,0]],
        // Background Sound - Int
        [[-1]]
    ]

}

