//
//  YogaChoiceFinal.swift
//  MindAndBody
//
//  Created by Luke Smith on 23.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Warmup Choice Class -------------------------------------------------------------------------------------------------------------
//
class YogaChoiceFinal: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Selected Preset
    //
    var selectedPreset: [Int] = [0, 0]
    
    //
    // Arrays ------------------------------------------------------------------------------------------------------------------------------
    
    //
    // Picker View Array
    //
    
    // Arrays to be set and used (Screen arrays)
    // Pses Array
    var yogaArray: [String] = []
    
    
    // Demonstration Array
    var demonstrationArray: [[UIImage]] = []
    
    // Target Area Array
    var targetAreaArray: [UIImage] = []
    
    // Explanation Array
    var explanationArray: [String] = []
    
    
    // Yoga Poses
    let yogaPosesDictionary: [Int: String] =
        [
            // Standing
            0: "upwardsSalute",
            1: "mountain",
            2: "tree",
            3: "extendedToeGrab",
            4: "eagle",
            5: "chair",
            6: "lordOfDance",
            7: "warrior1",
            8: "warrior2",
            9: "warrior3",
            10: "halfMoon",
            11: "extendedTriangle",
            12: "extendedSideAngleY",
            13: "revolvedSideAngle",
            14: "revolvedTriangle",
            15: "halfForwardBend",
            16: "forwardBend",
            17: "wideLeggedForwardBend",
            18: "intenseSide",
            19: "gate",
            20: "highLunge",
            21: "lowLungeY",
            22: "deepSquat",
            // Hand/Elbows and Feet/Knees
            23: "dolphin",
            24: "downwardDog",
            25: "halfDownwardDog",
            26: "plank", //// UNUSED
            27: "dolphinPlank",
            28: "fourLimbedStaff",
            29: "sidePlank",
            30: "cat",
            31: "cow",
            32: "catCow",
            33: "halfMonkey",
            34: "childPose",
            35: "wildThing",
            36: "upwardBow",
            37: "bridge",
            38: "upwardPlank",
            39: "extendedPuppy",
            40: "upwardDog",
            // Seated
            41: "crossLeg", // Pic Only
            42: "lotus", // Pic Only
            43: "fireLog",  // Pic Only
            44: "boat",
            45: "cowFace", // Pic Only
            46: "hero", // Pic Only
            47: "butterfly", // Pic Only
            48: "staffPose", // Pic Only
            49: "seatedForwardBend", // Pic Only
            50: "vForwardBend",
            51: "vSideBend",
            52: "halfVForwardBend",
            53: "halfVSideBend",
            54: "marichi1",
            55: "marichi3",
            56: "frontSplit", // Pic Only
            57: "sideSplit", // Pic Only
            // Lying
            58: "corpse",
            59: "fish",
            60: "happyBaby",
            61: "lyingButterfly",
            62: "legRaiseToe",
            63: "threadTheNeedle",
            64: "shoulderStand",
            65: "plow",
            66: "cobra",
            67: "sphinx",
            68: "pigeon",
            69: "spineRolling",
            // Hand Stands
            70: "handstand",
            71: "headstand",
            72: "forearmStand"
        ]
    
    
    // Explanation Dictionary
    let explanationDictionary: [Int: String] =
        [
            // Standing
            0: "upwardsSaluteE",
            1: "mountainE",
            2: "treeE",
            3: "extendedToeGrabE",
            4: "eagleE",
            5: "chairE",
            6: "lordOfDanceE",
            7: "warrior1E",
            8: "warrior2E",
            9: "warrior3E",
            10: "halfMoonE",
            11: "extendedTriangleE",
            12: "extendedSideAngleYE",
            13: "revolvedSideAngleE",
            14: "revolvedTriangleE",
            15: "halfForwardBendE",
            16: "forwardBendE",
            17: "wideLeggedForwardBendE",
            18: "intenseSideE",
            19: "gateE",
            20: "highLungeE",
            21: "lowLungeYE",
            22: "deepSquatE",
            // Hand/Elbows and Feet/Knees
            23: "dolphinE",
            24: "downwardDogE",
            25: "halfDownwardDogE",
            26: "plankE", //// UNUSED
            27: "dolphinPlankE",
            28: "fourLimbedStaffE",
            29: "sidePlankE",
            30: "catE",
            31: "cowE",
            32: "catCowE",
            33: "halfMonkeyE",
            34: "childPoseE",
            35: "wildThingE",
            36: "upwardBowE",
            37: "bridgeE",
            38: "upwardPlankE",
            39: "extendedPuppyE",
            40: "upwardDogE",
            // Seated
            41: "crossLegE",
            42: "lotusE",
            43: "fireLogE",
            44: "boatE",
            45: "cowFaceE",
            46: "heroE",
            47: "butterflyE",
            48: "staffPoseE",
            49: "seatedForwardBendE",
            50: "vForwardBendE",
            51: "vSideBend",
            52: "halfVForwardBendE",
            53: "halfVSideBendE",
            54: "marichi1E",
            55: "marichi3E",
            56: "frontSplitE",
            57: "sideSplitE",
            // Lying
            58: "corpseE",
            59: "fishE",
            60: "happyBabyE",
            61: "lyingButterflyE",
            62: "legRaiseToeE",
            63: "threadTheNeedleE",
            64: "shoulderStandE",
            65: "plowE",
            66: "cobraE",
            67: "sphinxE",
            68: "pigeonE",
            69: "spineRollingE",
            // Hand Stands
            70: "handstandE",
            71: "headstandE",
            72: "forearmStandE"
        ]
    
    
    // Demonstration Poses
    let demonstrationDictionary: [Int: [UIImage]] =
        [
            // Standing
            0: [#imageLiteral(resourceName: "upwardSalute")],
            1: [#imageLiteral(resourceName: "mountain")],
            2: [#imageLiteral(resourceName: "tree"), #imageLiteral(resourceName: "tree1"), #imageLiteral(resourceName: "tree2"), #imageLiteral(resourceName: "tree3"), #imageLiteral(resourceName: "tree4"), #imageLiteral(resourceName: "tree5"), #imageLiteral(resourceName: "tree6")],
            3: [#imageLiteral(resourceName: "extendedToeGrab"), #imageLiteral(resourceName: "extendedToeGrab1"), #imageLiteral(resourceName: "extendedToeGrab2"), #imageLiteral(resourceName: "extendedToeGrab3"), #imageLiteral(resourceName: "extendedToeGrab4"), #imageLiteral(resourceName: "extendedToeGrab5")],
            4: [#imageLiteral(resourceName: "eagle"), #imageLiteral(resourceName: "eagle1"), #imageLiteral(resourceName: "eagle2"), #imageLiteral(resourceName: "eagle3"), #imageLiteral(resourceName: "eagle4"), #imageLiteral(resourceName: "eagle5"), #imageLiteral(resourceName: "eagle6"), #imageLiteral(resourceName: "eagle7")],
            5: [#imageLiteral(resourceName: "chair"), #imageLiteral(resourceName: "chair1"), #imageLiteral(resourceName: "chair2"), #imageLiteral(resourceName: "chair3"), #imageLiteral(resourceName: "chair4"), #imageLiteral(resourceName: "chair5")],
            6: [#imageLiteral(resourceName: "lordOfDance"), #imageLiteral(resourceName: "lordOfDance1"), #imageLiteral(resourceName: "lordOfDance2"), #imageLiteral(resourceName: "lordOfDance3"), #imageLiteral(resourceName: "lordOfDance4"), #imageLiteral(resourceName: "lordOfDance5"), #imageLiteral(resourceName: "lordOfDance6"), #imageLiteral(resourceName: "lordOfDance7")],
            7: [#imageLiteral(resourceName: "warrior1"), #imageLiteral(resourceName: "warrior11"), #imageLiteral(resourceName: "warrior12"), #imageLiteral(resourceName: "warrior13"), #imageLiteral(resourceName: "warrior14"), #imageLiteral(resourceName: "warrior15")],
            8: [#imageLiteral(resourceName: "warrior2"), #imageLiteral(resourceName: "warrior21"), #imageLiteral(resourceName: "warrior22"), #imageLiteral(resourceName: "warrior23"), #imageLiteral(resourceName: "warrior24"), #imageLiteral(resourceName: "warrior25")],
            9: [#imageLiteral(resourceName: "warrior3"), #imageLiteral(resourceName: "warrior31"), #imageLiteral(resourceName: "warrior32"), #imageLiteral(resourceName: "warrior33"), #imageLiteral(resourceName: "warrior34"), #imageLiteral(resourceName: "warrior35"), #imageLiteral(resourceName: "warrior36")],
            10: [#imageLiteral(resourceName: "halfMoon"), #imageLiteral(resourceName: "halfMoon1"), #imageLiteral(resourceName: "halfMoon2"), #imageLiteral(resourceName: "halfMoon3"), #imageLiteral(resourceName: "halfMoon4"), #imageLiteral(resourceName: "halfMoon5"), #imageLiteral(resourceName: "halfMoon6"), #imageLiteral(resourceName: "halfMoon7")],
            11: [#imageLiteral(resourceName: "extendedTriangle"), #imageLiteral(resourceName: "extendedTriangle1"), #imageLiteral(resourceName: "extendedTriangle2"), #imageLiteral(resourceName: "extendedTriangle3"), #imageLiteral(resourceName: "extendedTriangle4"), #imageLiteral(resourceName: "extendedTriangle5")],
            12: [#imageLiteral(resourceName: "extendedSideAngle"), #imageLiteral(resourceName: "extendedSideAngle1"), #imageLiteral(resourceName: "extendedSideAngle2"), #imageLiteral(resourceName: "extendedSideAngle3"), #imageLiteral(resourceName: "extendedSideAngle4"), #imageLiteral(resourceName: "extendedSideAngle5"), #imageLiteral(resourceName: "extendedSideAngle6")],
            13: [#imageLiteral(resourceName: "revolvedSideAngle"), #imageLiteral(resourceName: "revolvedSideAngle1"), #imageLiteral(resourceName: "revolvedSideAngle2"), #imageLiteral(resourceName: "revolvedSideAngle3"), #imageLiteral(resourceName: "revolvedSideAngle4"), #imageLiteral(resourceName: "revolvedSideAngle5"), #imageLiteral(resourceName: "revolvedSideAngle6")],
            14: [#imageLiteral(resourceName: "revolvedTriangle"), #imageLiteral(resourceName: "revolvedTriangle1"), #imageLiteral(resourceName: "revolvedTriangle2"), #imageLiteral(resourceName: "revolvedTriangle3"), #imageLiteral(resourceName: "revolvedTriangle4"), #imageLiteral(resourceName: "revolvedTriangle5"), #imageLiteral(resourceName: "revolvedTriangle6")],
            15: [#imageLiteral(resourceName: "halfForwardBend"), #imageLiteral(resourceName: "halfForwardBend1"), #imageLiteral(resourceName: "halfForwardBend2"), #imageLiteral(resourceName: "halfForwardBend3"), #imageLiteral(resourceName: "halfForwardBend4"), #imageLiteral(resourceName: "halfForwardBend5"), #imageLiteral(resourceName: "halfForwardBend6"), #imageLiteral(resourceName: "halfForwardBend7")],
            16: [#imageLiteral(resourceName: "forwardBend"), #imageLiteral(resourceName: "forwardBend1"), #imageLiteral(resourceName: "forwardBend2"), #imageLiteral(resourceName: "forwardBend3"), #imageLiteral(resourceName: "forwardBend4"), #imageLiteral(resourceName: "forwardBend5"), #imageLiteral(resourceName: "forwardBend6"), #imageLiteral(resourceName: "forwardBend7")],
            17: [#imageLiteral(resourceName: "wideLeggedForwardBend"), #imageLiteral(resourceName: "wideLeggedForwardBend1"), #imageLiteral(resourceName: "wideLeggedForwardBend2"), #imageLiteral(resourceName: "wideLeggedForwardBend3"), #imageLiteral(resourceName: "wideLeggedForwardBend4"), #imageLiteral(resourceName: "wideLeggedForwardBend5"), #imageLiteral(resourceName: "wideLeggedForwardBend6")],
            18: [#imageLiteral(resourceName: "intenseSide"), #imageLiteral(resourceName: "intenseSide1"), #imageLiteral(resourceName: "intenseSide2"), #imageLiteral(resourceName: "intenseSide3"), #imageLiteral(resourceName: "intenseSide4"), #imageLiteral(resourceName: "intenseSide5")],
            19: [#imageLiteral(resourceName: "gate")],
            20: [#imageLiteral(resourceName: "highLunge"), #imageLiteral(resourceName: "highLunge1"), #imageLiteral(resourceName: "highLunge2"), #imageLiteral(resourceName: "highLunge3"), #imageLiteral(resourceName: "highLunge4"), #imageLiteral(resourceName: "highLunge5"), #imageLiteral(resourceName: "highLunge6")],
            21: [#imageLiteral(resourceName: "lowLunge"), #imageLiteral(resourceName: "lowLunge1"), #imageLiteral(resourceName: "lowLunge2"), #imageLiteral(resourceName: "lowLunge3"), #imageLiteral(resourceName: "lowLunge4"), #imageLiteral(resourceName: "lowLunge5"), #imageLiteral(resourceName: "lowLunge6")],
            22: [#imageLiteral(resourceName: "deepSquat"), #imageLiteral(resourceName: "deepSquat1"), #imageLiteral(resourceName: "deepSquat2"), #imageLiteral(resourceName: "deepSquat3"), #imageLiteral(resourceName: "deepSquat4"), #imageLiteral(resourceName: "deepSquat5")],
            // Hand/Elbows and Feet/Knees
            23: [#imageLiteral(resourceName: "dolphin"), #imageLiteral(resourceName: "dolphin1"), #imageLiteral(resourceName: "dolphin2"), #imageLiteral(resourceName: "dolphin3")],
            24: [#imageLiteral(resourceName: "downwardDog"), #imageLiteral(resourceName: "downwardDog1"), #imageLiteral(resourceName: "downwardDog2"), #imageLiteral(resourceName: "downwardDog3"), #imageLiteral(resourceName: "downwardDog4")],
            25: [#imageLiteral(resourceName: "halfDownwardDog"), #imageLiteral(resourceName: "halfDownwardDog1"), #imageLiteral(resourceName: "halfDownwardDog2"), #imageLiteral(resourceName: "halfDownwardDog3"), #imageLiteral(resourceName: "halfDownwardDog4")],
            26: [#imageLiteral(resourceName: "Test 2")], //// UNUSED
            27: [#imageLiteral(resourceName: "dolphinPlank")],
            28: [#imageLiteral(resourceName: "fourLimbedStaff")],
            29: [#imageLiteral(resourceName: "sidePlank"), #imageLiteral(resourceName: "sidePlank1"), #imageLiteral(resourceName: "sidePlank2"), #imageLiteral(resourceName: "sidePlank3"), #imageLiteral(resourceName: "sidePlank4")],
            30: [#imageLiteral(resourceName: "Cat")],
            31: [#imageLiteral(resourceName: "Cow")],
            32: [#imageLiteral(resourceName: "catCow"), #imageLiteral(resourceName: "catCow1"), #imageLiteral(resourceName: "catCow2"), #imageLiteral(resourceName: "catCow1"), #imageLiteral(resourceName: "catCow3"), #imageLiteral(resourceName: "catCow1")],
            33: [#imageLiteral(resourceName: "halfMonkey"), #imageLiteral(resourceName: "halfMonkey1"), #imageLiteral(resourceName: "halfMonkey2"), #imageLiteral(resourceName: "halfMonkey3"), #imageLiteral(resourceName: "halfMonkey4")],
            34: [#imageLiteral(resourceName: "childPose"), #imageLiteral(resourceName: "childPose1"), #imageLiteral(resourceName: "childPose2"), #imageLiteral(resourceName: "childPose3")],
            35: [#imageLiteral(resourceName: "wildThing"), #imageLiteral(resourceName: "wildThing1"), #imageLiteral(resourceName: "wildThing2"), #imageLiteral(resourceName: "wildThing3"), #imageLiteral(resourceName: "wildThing4"), #imageLiteral(resourceName: "wildThing5"), #imageLiteral(resourceName: "wildThing6")],
            36: [#imageLiteral(resourceName: "upwardBow"), #imageLiteral(resourceName: "upwardBow1"), #imageLiteral(resourceName: "upwardBow2"), #imageLiteral(resourceName: "upwardBow3"), #imageLiteral(resourceName: "upwardBow4"), #imageLiteral(resourceName: "upwardBow5")],
            37: [#imageLiteral(resourceName: "bridge"), #imageLiteral(resourceName: "bridge1"), #imageLiteral(resourceName: "bridge2"), #imageLiteral(resourceName: "bridge3")],
            38: [#imageLiteral(resourceName: "upwardPlank"), #imageLiteral(resourceName: "upwardPlank1"), #imageLiteral(resourceName: "upwardPlank2"), #imageLiteral(resourceName: "upwardPlank3"), #imageLiteral(resourceName: "upwardPlank4"), #imageLiteral(resourceName: "upwardPlank5")],
            39: [#imageLiteral(resourceName: "extendedPuppy"), #imageLiteral(resourceName: "extendedPuppy1"), #imageLiteral(resourceName: "extendedPuppy2"), #imageLiteral(resourceName: "extendedPuppy3"), #imageLiteral(resourceName: "extendedPuppy4"), #imageLiteral(resourceName: "extendedPuppy5")],
            40: [#imageLiteral(resourceName: "upwardDog"), #imageLiteral(resourceName: "upwardDog1"), #imageLiteral(resourceName: "upwardDog2"), #imageLiteral(resourceName: "upwardDog3"), #imageLiteral(resourceName: "upwardDog4")],
            // Seated
            41: [#imageLiteral(resourceName: "crossLegged")],
            42: [#imageLiteral(resourceName: "Lotus")],
            43: [#imageLiteral(resourceName: "fireLog")],
            44: [#imageLiteral(resourceName: "boat")],
            45: [#imageLiteral(resourceName: "cowFace")],
            46: [#imageLiteral(resourceName: "hero")],
            47: [#imageLiteral(resourceName: "butterfly")],
            48: [#imageLiteral(resourceName: "staff")],
            49: [#imageLiteral(resourceName: "seatedForwardBend")],
            50: [#imageLiteral(resourceName: "vForwardBend")],
            51: [#imageLiteral(resourceName: "vSideBend"), #imageLiteral(resourceName: "vSideBend1"), #imageLiteral(resourceName: "vSideBend2"), #imageLiteral(resourceName: "vSideBend3"), #imageLiteral(resourceName: "vSideBend4"), #imageLiteral(resourceName: "vSideBend5")],
            52: [#imageLiteral(resourceName: "halfVForwardBend"), #imageLiteral(resourceName: "halfVForwardBend1"), #imageLiteral(resourceName: "halfVForwardBend2"), #imageLiteral(resourceName: "halfVForwardBend3"), #imageLiteral(resourceName: "halfVForwardBend4"), #imageLiteral(resourceName: "halfVForwardBend5"), #imageLiteral(resourceName: "halfVForwardBend6")],
            53: [#imageLiteral(resourceName: "halfVSideBend"), #imageLiteral(resourceName: "halfVSideBend1"),
                 #imageLiteral(resourceName: "halfVSideBend2"), #imageLiteral(resourceName: "halfVSideBend3"), #imageLiteral(resourceName: "halfVSideBend4"), #imageLiteral(resourceName: "halfVSideBend5")],
            54: [#imageLiteral(resourceName: "marichi1"), #imageLiteral(resourceName: "marichi11"), #imageLiteral(resourceName: "marichi12"), #imageLiteral(resourceName: "marichi13"), #imageLiteral(resourceName: "marichi14"), #imageLiteral(resourceName: "marichi15"), #imageLiteral(resourceName: "marichi16"), #imageLiteral(resourceName: "marichi17")],
            55: [#imageLiteral(resourceName: "marichi3"), #imageLiteral(resourceName: "marichi31"), #imageLiteral(resourceName: "marichi32"), #imageLiteral(resourceName: "marichi33"), #imageLiteral(resourceName: "marichi34"), #imageLiteral(resourceName: "marichi35"), #imageLiteral(resourceName: "marichi36"), #imageLiteral(resourceName: "marichi37")],
            56: [#imageLiteral(resourceName: "frontSplit")],
            57: [#imageLiteral(resourceName: "sideSplit")],
            // Lying
            58: [#imageLiteral(resourceName: "corpse")],
            59: [#imageLiteral(resourceName: "fish"), #imageLiteral(resourceName: "fish1"), #imageLiteral(resourceName: "fish2"), #imageLiteral(resourceName: "fish3"), #imageLiteral(resourceName: "fish4"), #imageLiteral(resourceName: "fish5")],
            60: [#imageLiteral(resourceName: "happyBaby")],
            61: [#imageLiteral(resourceName: "lyingButterfly"), #imageLiteral(resourceName: "lyingButterfly1"), #imageLiteral(resourceName: "lyingButterfly2"), #imageLiteral(resourceName: "lyingButterfly3"), #imageLiteral(resourceName: "lyingButterfly4")],
            62: [#imageLiteral(resourceName: "legRaiseToe")],
            63: [#imageLiteral(resourceName: "threadTheNeedle"), #imageLiteral(resourceName: "threadTheNeedle1"), #imageLiteral(resourceName: "threadTheNeedle2"), #imageLiteral(resourceName: "threadTheNeedle3"), #imageLiteral(resourceName: "threadTheNeedle4"), #imageLiteral(resourceName: "threadTheNeedle5")],
            64: [#imageLiteral(resourceName: "shoulderStand"), #imageLiteral(resourceName: "shoulderStand1"), #imageLiteral(resourceName: "shoulderStand2"), #imageLiteral(resourceName: "shoulderStand3"), #imageLiteral(resourceName: "shoulderStand4"), #imageLiteral(resourceName: "shoulderStand5"), #imageLiteral(resourceName: "shoulderStand6"), #imageLiteral(resourceName: "shoulderStand7")],
            65: [#imageLiteral(resourceName: "plow"), #imageLiteral(resourceName: "plow1"), #imageLiteral(resourceName: "plow2"), #imageLiteral(resourceName: "plow3"), #imageLiteral(resourceName: "plow4")],
            66: [#imageLiteral(resourceName: "cobra"), #imageLiteral(resourceName: "cobra1"), #imageLiteral(resourceName: "cobra2"), #imageLiteral(resourceName: "cobra3"), #imageLiteral(resourceName: "cobra4")],
            67: [#imageLiteral(resourceName: "sphinx")],
            68: [#imageLiteral(resourceName: "pigeon"), #imageLiteral(resourceName: "pigeon1"), #imageLiteral(resourceName: "pigeon2"), #imageLiteral(resourceName: "pigeon3"), #imageLiteral(resourceName: "pigeon4"), #imageLiteral(resourceName: "pigeon5"), #imageLiteral(resourceName: "pigeon6"), #imageLiteral(resourceName: "pigeon7"), #imageLiteral(resourceName: "pigeon8")],
            69: [#imageLiteral(resourceName: "spineRolling"), #imageLiteral(resourceName: "spineRolling1"), #imageLiteral(resourceName: "spineRolling2"), #imageLiteral(resourceName: "spineRolling3"), #imageLiteral(resourceName: "spineRolling2"), #imageLiteral(resourceName: "spineRolling4"), #imageLiteral(resourceName: "spineRolling2"), #imageLiteral(resourceName: "spineRolling3"), #imageLiteral(resourceName: "spineRolling2"), #imageLiteral(resourceName: "spineRolling4")],
            // Hand Stands
            70: [#imageLiteral(resourceName: "handStand"), #imageLiteral(resourceName: "handStand1"), #imageLiteral(resourceName: "handStand2"), #imageLiteral(resourceName: "handStand3"), #imageLiteral(resourceName: "handStand4"), #imageLiteral(resourceName: "handStand5"), #imageLiteral(resourceName: "handStand6"), #imageLiteral(resourceName: "handStand7"), #imageLiteral(resourceName: "handStand8")],
            71: [#imageLiteral(resourceName: "headStand"), #imageLiteral(resourceName: "headStand1"), #imageLiteral(resourceName: "headStand2"), #imageLiteral(resourceName: "headStand3"), #imageLiteral(resourceName: "headStand4"), #imageLiteral(resourceName: "headStand5"), #imageLiteral(resourceName: "headStand6"), #imageLiteral(resourceName: "headStand7"), #imageLiteral(resourceName: "headStand8")],
            72: [#imageLiteral(resourceName: "forearmStand"), #imageLiteral(resourceName: "forearmStand1"), #imageLiteral(resourceName: "forearmStand2"), #imageLiteral(resourceName: "forearmStand3"), #imageLiteral(resourceName: "forearmStand4"), #imageLiteral(resourceName: "forearmStand5"), #imageLiteral(resourceName: "forearmStand6")]
        ]
   
    
    // Practice Section Title
    let practiceSectionTitles: [String] =
            // Test
            ["test",
            // Meditation
            "yogaMeditation"]
    
    
    // Preset Arrays
    let practiceTitlesArray: [[String]] =
        [
            // Test
            // Relaxing
            ["lit", "lit", "test"],
            // Yoga Meditation
            ["lettingGo", "breathing"]
    ]
    
    
     //// 26 UNUSED
    
    // Practice Content Array
    let practiceArray: [[[Int]]] =
        [
        // 5 min
            // Relaxing
            [
                //0,1
                [ 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72],
                [2,3,4,5,6,9,12,13],
                [2,3,4]
            ],
        // Meditation
            [
                [33,33,33],
                [66,66,66]
            ]
        ]
    
    // Breaths Array
    var breathsArray: [[[Int]]] =
        [
            // 5 min
            // Relaxing
            [
                [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72],
                [1,1,1,1,1,1,1,1],
                [1,1,1]
            ],
            // Meditation
            [
                [5,5,5],
                [5,5,5]
            ]
    ]
    
    
    
    // Selected Array
    var selectedArray: [Int] = []
    
    // Selected Title
    var selectedTitle = Int()
    
    
    
    //
    // Outlets ------------------------------------------------------------------------------------------------------------------------------
    //
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    // Movements Table View
    @IBOutlet weak var posesTableView: UITableView!
    
    // Presets Button
    @IBOutlet weak var presetsButton: UIButton!
    
    //
    @IBOutlet weak var presetsConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableConstraint1: NSLayoutConstraint!
    
    @IBOutlet weak var tableConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var beginConstraint: NSLayoutConstraint!
    
    
    
    let emptyString = ""
    
    // Presets Table
    //
    // Select Prest
    var presetsTableView = UITableView()
    var backgroundViewExpanded = UIButton()
    
    
    // Flash Screen
    func flashScreen() {
        //
        let flash = UIView()
        //
        flash.frame = CGRect(x: 0, y: presetsButton.frame.maxY, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        //
        UIView.animate(withDuration: 0.3, animations: {
            flash.alpha = 0
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
    }
    
    //
    // View will appear
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presetsButton.setTitle(NSLocalizedString("selectPractice", comment: ""), for: .normal)
    }
    
    //
    // View did load ------------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colour
        view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("practices", comment: ""))
        
        //
        presetsButton.backgroundColor = colour2
        presetsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //
        posesTableView.tableFooterView = UIView()
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = colour3
        beginButton.setTitleColor(colour2, for: .normal)
        
        
        
        
        
        
        // Initial Element Positions
        //
        presetsConstraint.constant = 0
        //
        tableConstraint1.constant = view.frame.size.height
        tableConstraint.constant = -49.25
        //
        beginConstraint.constant = -49
        
        
        
        //
        // TableView Backgrounds
        //
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.posesTableView.frame.size.width, height: self.posesTableView.frame.size.height)
        //
        posesTableView.backgroundView = tableViewBackground
        
        //
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = colour2
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        
        presetsTableView.tableFooterView = UIView()
        
        
        // TableView Cell action items
        //
        // Movement table
        presetsTableView.backgroundColor = colour2
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        presetsTableView.layer.cornerRadius = 15
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        presetsTableView.layer.borderColor = colour1.cgColor
        presetsTableView.layer.borderWidth = 1
        //
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //
        
    }
    
    
    //
    // TableView -----------------------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case posesTableView:
            return 1
        case presetsTableView:
            return 2
        default: break
        }
        return 0
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case posesTableView:
            return ""
        case presetsTableView:
            return NSLocalizedString(practiceSectionTitles[section], comment: "")
        default: break
        }
        return ""
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        switch tableView {
        case presetsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        default: break
        }
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case posesTableView:
            return practiceArray[selectedPreset[0]][selectedPreset[1]].count
        case presetsTableView:
            return practiceTitlesArray[section].count
        default: break
        }
        return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        //
        case posesTableView:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            cell.selectionStyle = .none
            //
            cell.textLabel?.text = NSLocalizedString(yogaPosesDictionary[practiceArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]]!, comment: "")
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            // Cell Image
            cell.imageView?.image = demonstrationDictionary[practiceArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]]?[0]
            cell.imageView?.isUserInteractionEnabled = true
            //
            cell.imageView?.tag = practiceArray[selectedPreset[0]][selectedPreset[1]][indexPath.row]
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleTap))
            cell.imageView?.addGestureRecognizer(imageTap)
            //
            return cell
        //
        case presetsTableView:
            //
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            cell.textLabel?.text = "- " + NSLocalizedString(practiceTitlesArray[indexPath.section][indexPath.row], comment: "") + " -"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.backgroundColor = colour1
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            return cell
        default: break
        }
        return UITableViewCell()
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case posesTableView:
            return 72
        case presetsTableView:
            return 44
        default: break
        }
        return 0
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        //
        case posesTableView:
            break
        //
        case presetsTableView:
            //
            selectedPreset[0] = indexPath.section
            selectedPreset[1] = indexPath.row
            //
            
            
            presetsButton.setTitle("- " + NSLocalizedString(practiceTitlesArray[indexPath.section][indexPath.row], comment: "") + " -", for: .normal)
            presetsTableView.deselectRow(at: indexPath, animated: true)
            
            //
            let tableHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            let tableWidth = UIScreen.main.bounds.width - 20
            //
            // Dismiss Presets Table
            //
            UIView.animate(withDuration: animationTime2, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: tableWidth, height: tableHeight)
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
            // Animate new Elements up
            UIView.animate(withDuration: animationTime3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.posesTableView.reloadData()
                let indexPath2 = NSIndexPath(row: 0, section: 0)
                self.posesTableView.scrollToRow(at: indexPath2 as IndexPath, at: .top, animated: true)
                //
                self.tableConstraint1.constant = 73.75
                self.tableConstraint.constant = 49.75
                //
                self.presetsConstraint.constant = self.view.frame.size.height - 73.25
                //
                self.beginConstraint.constant = 0
                self.view.layoutIfNeeded()
            }, completion: { finished in
                //
                if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2") == false {
                    self.walkthroughMindBody()
                    UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2")
                }
            })
            
        default: break
        }
        
    }
    
    
    //
    // Presets Button Action -----------------------------------------------------------------------------------------------------------------
    //
    @IBAction func presetsButtonAction(_ sender: Any) {
        //
        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: presetsTableView)
        //
        animateActionSheetUp(actionSheet: presetsTableView, actionSheetHeight: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88, backgroundView: backgroundViewExpanded)
    }
    
    
    // Dismiss presets table
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        animateActionSheetDown(actionSheet: presetsTableView, actionSheetHeight: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88, backgroundView: backgroundViewExpanded)
    }
    
    
    //
    // Expand image actions ----------------------------------------------------------------------------------------------------------------
    //
    // Handle Tap
    let expandedImage = UIImageView()
    let backgroundViewImage = UIButton()
    var imageIndex = Int()
    //
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        //
        // Get Array index
        let sender = extraTap.view as! UIImageView
        let demonstrationIndex = sender.tag
        imageIndex = demonstrationIndex
        //
        // Animation
        expandedImage.image = demonstrationDictionary[demonstrationIndex]?[0]
        expandedImage.animationImages = demonstrationDictionary[demonstrationIndex]
        expandedImage.animationDuration = Double(demonstrationDictionary[demonstrationIndex]!.count) * 0.5
        expandedImage.animationImages?.removeFirst()
        expandedImage.animationRepeatCount = 1
        // Play
        let imagePress = UITapGestureRecognizer(target: self, action: #selector(imageSequenceAnimation))
        expandedImage.addGestureRecognizer(imagePress)
        //
        // Animate
        backgroundViewImage.addTarget(self, action: #selector(retractImage(_:)), for: .touchUpInside)
        //
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewImage, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(expandedImage, aboveSubview: backgroundViewImage)
        //
        animateViewUp(animationView: expandedImage, backgroundView: backgroundViewImage)
    }
    
    // Retract image
    @IBAction func retractImage(_ sender: Any) {
        //
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        //
        UIView.animate(withDuration: animationTime2, animations: {
            self.expandedImage.center.y = (height/2) * 2.5
            self.backgroundViewImage.alpha = 0
        }, completion: { finished in
            //
            self.expandedImage.removeFromSuperview()
            self.backgroundViewImage.removeFromSuperview()
            self.navigationItem.setHidesBackButton(false, animated: true)
        })
    }
    
    //
    // Play Image Sequence
    @IBAction func imageSequenceAnimation() {
        //
        if demonstrationDictionary[imageIndex]?.count != 1 {
            expandedImage.startAnimating()
        }
    }
    
    
    //
    // Begin Button ---------------------------------------------------------------------------------------------------------------------------
    //
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        //
        // Return background to homescreen
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            _ = self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    
    //
    // Pass Arrays ---------------------------------------------------------------------------------------------------------------------------
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "yogaSessionSegue") {
            //
            let destinationVC = segue.destination as! YogaScreen
            
            // Ensure array in ascending order
            // Compress Arrays
            for i in practiceArray[selectedPreset[0]][selectedPreset[1]] {
                //
                yogaArray.append(yogaPosesDictionary[i]!)
                //
                demonstrationArray.append(demonstrationDictionary[i]!)
                //
                //targetAreaArray.append(targetAreaDictionary[i]!)
                //
                explanationArray.append(explanationDictionary[i]!)
            }
            //
            destinationVC.sessionArray = yogaArray
            destinationVC.breathsArray = breathsArray[selectedPreset[0]][selectedPreset[1]]
            destinationVC.demonstrationArray = demonstrationArray
            //destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionTitle = practiceTitlesArray[selectedPreset[0]][selectedPreset[1]]
        }
    }
    
    
    //
    // Walkthrough --------------------------------------------------------------------------------------------------------
    //
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
        
        //
        switch viewNumber {
        case 0:
            //
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight, width: self.view.frame.size.width, height: 73.5))
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
            
            //
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            //
            label.text = NSLocalizedString("choiceScreen2W", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
        //
        case 1:
            //
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 73.5, width: self.view.frame.size.width, height: posesTableView.frame.size.height))
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
            
            //
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            //
            label.center.y = presetsButton.center.y + UIApplication.shared.statusBarFrame.height + navigationBarHeight
            label.text = NSLocalizedString("choiceScreen21", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
            //
        //
        case 2:
            //
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 73.5 + posesTableView.frame.size.height, width: self.view.frame.size.width, height: 49))
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
            
            //
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            //
            label.center = posesTableView.center
            label.text = NSLocalizedString("choiceScreen22", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
        //
        default: break
        }
    }
    
    //
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        label.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    
    //
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            label.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
    }
    //
    //
}
