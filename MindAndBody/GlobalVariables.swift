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
// View slide up
let animationTime1 = 0.5
// View slide down
let animationTime2 = 0.15
// Final choice screen element animation
let animationTime3 = 0.7


//
// Menu Index (ensures initial screen is home screen), variable misnamed tabBarIndex ---------------------------------------------------------------------------------------------------------------
//
var tabBarIndex = 0
var new = Bool()

//


//
// Tracking Variables ---------------------------------------------------------------------------------------------------------------
//
// Goals
var weekGoal = Int()
var monthGoal = Int()

// Progress
var weekProgress = Int()
var monthProgress = Int()

// Monday - Sunday
var weekTrackingDictionary: [Int:Int] = [:]
// All tracking in % of weeks
var trackingDictionary: [Int:[Int:[Int:Int]]] = [:]
// All tracking in % of months
var monthTrackingDictionary: [Int:[Int:Int]] = [:]
