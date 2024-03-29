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
    static let light = UIColor.white
//        UIColor.white
    static let gray = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
//    UIColor(red:0.90, green:0.89, blue:0.89, alpha:1.0)
//        UIColor(red:0.92, green:0.91, blue:0.91, alpha:1.0)
//        UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0) // Original gray color!!!!!
    // Dark gray
    static let darkGray = UIColor(white: 0.43, alpha: 1)
    // Dark
    static let dark = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
//        UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
    static let orange = UIColor(red:0.90, green:0.38, blue:0.23, alpha:1.0)
    
    
    // Green
    static let green = UIColor(red:0.15, green:0.65, blue:0.36, alpha:1.0)
    // Red
    static let red = UIColor(red:0.74, green:0.25, blue:0.20, alpha:1.0)
    
}

//
// Fonts ---------------------------------------------------------------------------------------------------------------------
enum Fonts {
    // Navigation bar
    static let navigationBar = UIFont(name: "SFUIDisplay-light", size: 19)
    static let navigationBarButton = UIFont(name: "SFUIDisplay-light", size: 17)
    
    // Cells
    static let bigTitle = UIFont(name: "SFUIDisplay-light", size: 27) // 30
    static let bigCell = UIFont(name: "SFUIDisplay-light", size: 22) // 23
    static let regularCell = UIFont(name: "SFUIDisplay-regular", size: 18)
    
    static let scheduleCell = UIFont(name: "SFUIDisplay-regular", size: 23)
    static let scheduleTitle = UIFont(name: "SFUIDisplay-medium", size: 23)
    
    
    // Various Elements
    static let veryLargeElementRegular = UIFont(name: "SFUIDisplay-regular", size: 27)
    
    static let largeElementRegular = UIFont(name: "SFUIDisplay-regular", size: 23)
    
    static let mediumElementRegular = UIFont(name: "SFUIDisplay-regular", size: 21)
    static let mediumElementLight = UIFont(name: "SFUIDisplay-light", size: 21)
    
    static let smallElementRegular = UIFont(name: "SFUIDisplay-regular", size: 19)
    static let smallElementLight = UIFont(name: "SFUIDisplay-light", size: 19)
    
    static let verySmallElementLight = UIFont(name: "SFUIDisplay-light", size: 15)
    static let verySmallElementRegular = UIFont(name: "SFUIDisplay-regular", size: 15)
    
    static let tinyElementLight = UIFont(name: "SFUIDisplay-light", size: 13)
    
    // Buttons
    static let bottomButton = UIFont(name: "SFUIDisplay-regular", size: 23)

    // Lessons
    static let lessonTitle = UIFont(name: "SFUIDisplay-bold", size: 37)
    static let lessonSubtitle = UIFont(name: "SFUIDisplay-bold", size: 27)
    static let lessonsImageTitle = UIFont(name: "SFUIDisplay-medium", size: 23)
    static let lessonText = UIFont(name: "SFUIDisplay-regular", size: 19)
    
    // Explanations
    static let explanationTitle = UIFont(name: "SFUIDisplay-bold", size: 21)
    static let explanationSubHeader = UIFont(name: "SFUIDisplay-semibold", size: 19)
    
    // Guided meditation
    static let meditationTitle = UIFont(name: "SFUIDisplay-bold", size: 21)
    static let meditationTitleSmall = UIFont(name: "SFUIDisplay-bold", size: 18)
    
    
}

// Old bigger text
//// Navigation bar
//static let navigationBar = UIFont(name: "SFUIDisplay-light", size: 19)
//static let navigationBarButton = UIFont(name: "SFUIDisplay-light", size: 17)
//
//static let bigTitle = UIFont(name: "SFUIDisplay-light", size: 30)
//
//static let regularCell = UIFont(name: "SFUIDisplay-regular", size: 19)
//static let bigCell = UIFont(name: "SFUIDisplay-light", size: 23)
//
//static let bottomButton = UIFont(name: "SFUIDisplay-regular", size: 23)
//
//static let veryLargeElementRegular = UIFont(name: "SFUIDisplay-regular", size: 27)
//
//static let largeElementRegular = UIFont(name: "SFUIDisplay-regular", size: 23)
//
//static let mediumElementRegular = UIFont(name: "SFUIDisplay-regular", size: 21)
//static let mediumElementLight = UIFont(name: "SFUIDisplay-light", size: 21)
//
//static let smallElementRegular = UIFont(name: "SFUIDisplay-regular", size: 19)
//static let smallElementLight = UIFont(name: "SFUIDisplay-light", size: 19)
//
//static let verySmallElementLight = UIFont(name: "SFUIDisplay-light", size: 15)
//
//static let tinyElementLight = UIFont(name: "SFUIDisplay-light", size: 13)

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
// Walkthrough ---------------------------------------------------------------------------------------------------------------
enum WalkthroughVariables {
    // Title bar height
    static let topHeight: CGFloat = 49 * (3/4)
    // Label padding
    static let padding: CGFloat = 8
    static let twicePadding: CGFloat = padding * 2
    // View padding
    static let viewPadding: CGFloat = 13
    static let twiceViewPadding: CGFloat = viewPadding * 2
}

//
// Navigation + Status height ---------------------------------------------------------------------------------------------------------------
enum ElementHeights {
    // Shouldn't be hard coded!!!! (but currently not in a view controller so not sure how to access them at run time)
    
    // Navigation bar
    static let navigationBarHeight = 44
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let combinedHeight = 44 + UIApplication.shared.statusBarFrame.height
    // Tab bar
    static let tabBarHeight: CGFloat = 49
    
    //
    static let bottomSafeAreaInset: CGFloat =  {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        // Fallback on earlier versions
        } else {
            return UIScreen.main.bounds.height
        }
    }()
    
    static let topSafeAreaInset: CGFloat =  {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            // Fallback on earlier versions
        } else {
            return UIScreen.main.bounds.height
        }
    }()
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
// Tab bar
// Variable that check if tab bar is returning to schedule, if so and user is choosing session, remove navigation bar without animation
class TabBarChanged {
    static var shared = TabBarChanged()
    private init() {}

    // Name possibly misleading, as also used for background sounds in meditation timer
    var returningToSchedule = false
}
