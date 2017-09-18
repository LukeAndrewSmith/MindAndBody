//
//  DataStructures.swift
//  MindAndBody
//
//  Created by Luke Smith on 17.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation


//
// MARK: Session Data
enum sessionData {
    //
    // MARK: TableView Section Arrays
    static let tableViewSectionArrays: [[String]] =
        [
            // Warmup
            [
                "cardio",
                "jointRotation",
                "foamRoll",
                "glutes",
                "lowerBack",
                "upperBack",
                "shoulder",
                "bandAssisted",
                "generalMobility",
                "dynamicWarmupDrills",
                "accessory"
            ],
            // Workout
            [
                // Gym -----
                "legsQ",
                "legsHG",
                "legsG",
                "calves",
                "pullBa",
                "pullUB",
                "pullRD",
                "pullT",
                "pullB",
                "pullF",
                "pushC",
                "pushS",
                "pushT",
                "fullBody",
                // Bodyweight -----
                "legsG",
                "hamstrings",
                "glutesW",
                "calves",
                "pullBa",
                "pullT",
                "pushC",
                "pushT",
                "pushCT", //!!!!!!!!!
                "pushS",
                "coreAbs",
                // General
                "generalC",
                "generalF",
                "generalU",
                "cardio",
                // Isometric
                "isometricL",
                "isometricU", //!!!!!!!!!
                // Equiptment
                "equiptmentB",
                "equiptmentBa",
                "equiptmentBe"
            ],
            // Cardio
            [
            ],
            // Stretching
            [
                "cardio",
                "jointRotation",
                "foamRoll",
                "backStretch",
                "sides",
                "neck",
                "arms",
                "pecs",
                "shoulders",
                "hipsaGlutes",
                "calves",
                "hamstrings",
                "quads",
                "fullBody"
            ],
            // Yoga
            [
            ]
    ]
    
    //
    // MARK: Full Key Arrays
    static let fullKeyArrays: [[[Int]]] =
        [
            // Warmup
            [
                // Cardio
                [0],
                // Joint Rotations
                [1, 2, 3, 4, 5, 6, 7, 8],
                // Foam/Ball Roll
                [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
                // Glutes
                [21, 22, 23, 24],
                // Lower Back
                [25, 26, 27, 28, 29, 30],
                // Upper Back
                [31, 32, 33],
                // Shoulder
                [34, 35, 36, 37, 38, 39],
                // Band/Bar/Machine Assisted
                [40, 41, 42, 43, 44],
                // General Mobility
                [45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55],
                // Dynamic Warmup Drills
                [56, 57, 58, 59, 60, 61, 62, 63, 64, 65],
                // Accessory
                [66, 67]
            ],
            // Workout
            [
                // Gym ------------------------------------
                // Legs (Quads) ---------
                [0, 1, 2, 3, 4],
                // Legs (Hamstrings/Glutes)
                [5, 6, 7, 8, 9, 10],
                // Legs (General)
                [11, 12, 13],
                // Legs (Calves)
                [14, 15],
                // Pull (Back) ---------
                [16, 17, 18, 19, 20, 21, 22, 23],
                // Pull (Upper Back)
                [24, 25],
                // Pull (Rear Delts)
                [26],
                // Pull (Traps)
                [27],
                // Pull (Biceps)
                [28, 29, 30],
                // Pull (Forearms)
                [31, 32, 33],
                // Push (Chest) ---------
                [34, 35, 36, 37, 38, 39, 40, 41],
                // Push (Shoulders)
                [42, 43, 44, 45],
                // Push (Triceps) // 46: !!!
                [46, 47,48],
                // Full Body ---------
                [49],
                // BodyWeight ------------------------------------
                // Legs (General) ---------
                [50, 51, 52, 53, 54, 55, 56],
                // Legs (Hamstrings)
                [57, 58],
                // Legs (Glutes)
                [59, 60, 61, 62],
                // Legs (Calves)
                [63],
                // Pull (Back) ---------
                [64, 65, 66, 67, 68, 69],
                // Pull (Traps)
                [70],
                // Push (Chest) ---------
                [71],
                // Push (Tricep)
                [72, 73, 74],
                // Push (Chest & Tricep)
                [75],
                // Push (Shoulder)
                [76, 77, 78, 79],
                // Core ---------
                [80, 81, 82, 83, 84, 85, 86, 87, 88],
                // General (Core) ---------
                [89],
                // General (Full Body)
                [90, 91],
                // General (Upper Body)
                [92, 93],
                // General (Cardio)
                [94, 95, 96, 97],
                // Isometric (Legs) ---------
                [98, 99, 100],
                // Isometric (Upper Body)
                [101, 102, 103],
                // Equiptment (Ball) ---------
                [104],
                // Equiptment (Bar)
                [105, 106, 107],
                // Equiptment (Bench/Step)
                [108, 109, 110, 111, 112]
            ],
            // Cardio ??
            [
            ],
            // Stretching
            [
                // Recommended
                [0],
                // Joint Rotations
                [1, 2, 3, 4, 5, 6, 7, 8],
                // Foam/Ball Roll
                [9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
                // Back
                [21, 22, 23, 24, 25, 26, 27, 28, 29, 30],
                // Obliques(Sides)
                [31, 32, 33],
                // Neck
                [34, 35, 36, 37, 38, 39],
                // Arms
                [40, 41, 42],
                // Pecs
                [43],
                // Shoulders
                [44, 45, 46, 47, 48, 49],
                // Hips and Glutes
                [50, 51, 52, 53, 54, 55, 56],
                // Calves
                [57],
                // Hamstrings
                [58, 59, 60, 61, 62],
                // Quads
                [63, 64],
                // Full Body
                [65, 66]
            ],
            // Yoga
            [
            ]
    ]
    
    //
    // MARK: Movements Dictionaries
    static let movementsDictionaries: [[Int : String]] =
        [
            // Warmup
            [
                // Cardio
                0: "5minCardio",
                // Joint Rotations
                1: "wrist",
                2: "elbow",
                3: "shoulderR",
                4: "neckR",
                5: "waist",
                6: "hip",
                7: "knees",
                8: "ankles",
                // Foam/Ball Roll
                9: "backf",
                10: "thoracicSpine",
                11: "lat",
                12: "pecDelt",
                13: "rearDelt",
                14: "quadf",
                15: "adductorf",
                16: "hamstringf",
                17: "glutef",
                18: "calvef",
                19: "itBand",
                20: "standOnBall",
                // Glutes
                21: "gluteBridgewW", ///
                22: "kneelingKickBackW", ///
                23: "legsToSideSquat", ///
                24: "standingGluteKickback", ///
                // Lower Back
                25: "sideLegDrop",
                26: "sideLegKick",
                27: "scorpionKick",
                28: "sideBend",
                29: "catCow",
                30: "legsToSideTwist", ///
                // Upper Back
                31: "upperBackRotation", ///
                32: "latStretch", ///
                33: "lyingSideWindmill", ///
                // Shoulder
                34: "wallSlides",
                35: "wallReaches",
                36: "shoulderRotationW",
                37: "forearmWallSlides135",
                38: "superManShoulder",
                39: "scapulaPushup",
                // Band/Bar/Machine Assisted
                40: "facePull",
                41: "externalRotation",
                42: "internalRotation",
                43: "shoulderDislocation",
                44: "latPullover",
                // General Mobility
                45: "seatedKneeDrop", ///
                46: "mountainClimber",
                47: "groinStretch",
                48: "threadTheNeedle",
                49: "butterflyPose",
                50: "cossakSquat",
                51: "hipHinges",
                52: "lungeTwist",
                53: "sideLegSwings",
                54: "frontLegSwings",
                55: "spiderManHipLiftOverheadReach",
                // Dynamic Warmup Drills
                56: "forefootBounces",
                57: "jumpSquat",
                58: "lunge",
                59: "gluteKicks",
                60: "aSkips",
                61: "bSkips",
                62: "grapeVines",
                63: "lateralBound",
                64: "straightLegBound",
                65: "sprints",
                // Accessory
                66: "pushUp",
                67: "pullUp"
            ],
            // Workout
            [
                // Gym ------------------------------------
                // Legs (Quads) ---------
                0: "squat",
                1: "frontSquat",
                2: "legPress",
                3: "dumbellFrontSquat",
                4: "legExtensions",
                // Legs (Hamstrings/Glutes)
                5: "deadlift",
                6: "romanianDeadlift",
                7: "weightedHipThrust",
                8: "legCurl",
                9: "oneLeggedDeadlift",
                10: "gluteIsolationMachine",
                // Legs (General)
                11: "lungeDumbell",
                12: "bulgarianSplitSquat",
                13: "weightedStepUp",
                // Legs (Calves)
                14: "standingCalfRaise",
                15: "seatedCalfRaise",
                // Pull (Back) ---------
                16: "pullDown",
                17: "kneelingPullDown",
                18: "pullDownMachine",
                19: "bentOverRowBarbell",
                20: "bentOverRowDumbell",
                21: "tBarRow",
                22: "rowMachine",
                23: "latPullover",
                // Pull (Upper Back)
                24: "facePull",
                25: "leaningBackPullDown",
                // Pull (Rear Delts)
                26: "bentOverBarbellRow",
                // Pull (Traps)
                27: "shrugDumbell",
                // Pull (Biceps)
                28: "hammerCurl",
                29: "hammerCurlCable",
                30: "curl",
                // Pull (Forearms)
                31: "farmersCarry",
                32: "reverseBarbellCurl",
                33: "forearmCurl",
                // Push (Chest) ---------
                34: "benchPress",
                35: "benchPressDumbell",
                36: "semiInclineDumbellPress",
                37: "chestPress",
                38: "platePress",
                39: "barbellKneelingPress",
                40: "cableFly",
                41: "dips",
                // Push (Shoulders)
                42: "standingShoulderPressBarbell",
                43: "standingShoulderPressDumbell",
                44: "lateralRaise",
                45: "frontRaise",
                // Push (Triceps)
                46: "closeGripBench",
                47: "cableExtension",
                48: "ropeExtension",
                // Full Body
                49: "cleanPress",
                // BodyWeight ------------------------------------
                // Legs (General) ---------
                50: "bodyweightSquat",
                51: "pistolSquat",
                52: "skaterSquat",
                53: "squatJump",
                54: "sumoSquat",
                55: "lunge",
                56: "lungeJump",
                // Legs (Hamstrings)
                57: "deadlift",
                58: "singleLegDeadlift",
                // Legs (Glutes)
                59: "gluteBridge",
                60: "singleLegGluteBridge",
                61: "kickBack",
                62: "standingKickBack",
                // Legs (Calves)
                63: "calfRaise",
                // Pull (Back) ---------
                64: "contralateralLimbRaises",
                65: "superMan",
                66: "backHyperextension",
                67: "doorFrameRow",
                68: "reverseSnowAngels",
                69: "scapulaPushup",
                // Pull (Traps)
                70: "handStandTrap",
                // Push (Chest) ---------
                71: "pushup",
                // Push (Tricep)
                72: "trianglePushup",
                73: "dolphinPushup",
                74: "tricepExtensionsBodyweight",
                // Push (Chest & Tricep)
                75: "walkingPushup",
                // Push (Shoulder)
                76: "downwardDogPushup",
                77: "wallPushup",
                78: "boxer",
                79: "armCircles",
                // Core ---------
                80: "plank",
                81: "dynamicPlank",
                82: "sidePlankW",
                83: "pushupPlank",
                84: "lSit",
                85: "bicycleCrunch",
                86: "divingHold",
                87: "hipRaise",
                88: "legHold",
                // General (Core) ---------
                89: "mountainClimbers",
                // General (Full Body)
                90: "burpee",
                91: "kickThroughBurpee",
                // General (Upper Body)
                92: "spiderPushup",
                93: "crabWalk",
                // General (Cardio)
                94: "jumpingJacks",
                95: "tuckJump",
                96: "bumKicks",
                97: "kneeRaises",
                // Isometric (Legs) ---------
                98: "wallSit",
                99: "toePress",
                100: "staticLunge",
                // Isometric (Upper Body)
                101: "chestSqueeze",
                102: "pushupHold",
                103: "pullupHold",
                // Equiptment (Ball) ---------
                104: "ballPushup",
                // Equiptment (Bar)
                105: "bodweightRow",
                106: "pullup",
                107: "hangingLegRaise",
                // Equiptment (Bench/Step)
                108: "tricepDip",
                109: "bulgarianSplitSquat",
                110: "boxJump",
                111: "hipThrusts",
                112: "stepUp"
            ],
            // Cardio
            [
                // Rowing
                0: "sprintR",    // Rowing
                1: "fastR",
                2: "mediumR",
                3: "stillR",     // Rowing Pauses
                4: "slowR",
                5: "stretch",
                // Biking
                6: "sprintB",   // Bike
                7: "fastB",
                8: "mediumB",
                9: "stillB",      // Biking Pauses
                10: "slowB",
                11: "stretch",
                // Running
                12: "sprint",   // Running
                13: "run",
                14: "jog",
                15: "still",   // Running Pauses
                16: "slowJog",
                17: "stretch",
                ],
            // Stretching
            [
                // Recommended
                0: "5minCardioL",
                // Joint Rotations
                1: "wrist",
                2: "elbow",
                3: "shoulderR",
                4: "neckR",
                5: "waist",
                6: "hip",
                7: "knees",
                8: "ankles",
                // Foam/Ball Roll
                9: "backf",
                10: "thoracicSpine",
                11: "lat",
                12: "pecDelt",
                13: "rearDelt",
                14: "quadf",
                15: "adductorf",
                16: "hamstringf",
                17: "glutef",
                18: "calvef",
                19: "itBand",
                20: "standOnBall",
                // Back
                21: "catCow",
                22: "upwardsDog",
                23: "extendedPuppy",
                24: "childPose",
                25: "staffPose",
                26: "pelvicTilt",
                27: "kneeToChest",
                28: "legDrop",
                29: "seatedTwist",
                30: "legsWall",
                // Obliques(Sides)
                31: "sideLean",
                32: "extendedSideAngle",
                33: "seatedSide",
                // Neck
                34: "rearNeck",
                35: "rearNeckHand",
                36: "seatedLateral",
                37: "neckRotator",
                38: "scalene",
                39: "headRoll",
                // Arms
                40: "forearmStretch",
                41: "tricepStretch",
                42: "bicepStretch",
                // Pecs
                43: "pecStretch",
                // Shoulders
                44: "shoulderRoll",
                45: "behindBackTouch",
                46: "frontDelt",
                47: "lateralDelt",
                48: "rearDelt",
                49: "rotatorCuff",
                // Hips and Glutes
                50: "squatHold",
                51: "groinStretch",
                52: "butterflyPose",
                53: "lungeStretch",
                54: "threadTheNeedle",
                55: "pigeonPose",
                56: "seatedGlute",
                // Calves
                57: "calveStretch",
                // Hamstrings
                58: "standingHamstring",
                59: "standingOneLegHamstring",
                60: "downWardsDog",
                61: "singleLegHamstring",
                62: "twoLegHamstring",
                // Quads
                63: "lungeStretchWall",
                64: "QuadStretch",
                // Full Body
                65: "sumoSquatTwist",
                66: "tinyFencerStretch",
                ],
            // Yoga
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
                41: "crossLeg",
                42: "lotus",
                43: "fireLog",
                44: "boat",
                45: "cowFace",
                46: "hero",
                47: "butterfly",
                48: "staffPose",
                49: "seatedForwardBend",
                50: "vForwardBend",
                51: "vSideBend",
                52: "halfVForwardBend",
                53: "halfVSideBend",
                54: "marichi1",
                55: "marichi3",
                56: "frontSplit",
                57: "sideSplit",
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
    ]
    
    //
    // MARK: Demonstration Dictionaries
    static let demonstrationDictionaries: [[Int : [String]]] =
        [
            // Warmup
            [
                // Cardio
                0: ["cardioWarmup"],
                // Joint Rotations
                1: ["wristRotations", "wristRotations1", "wristRotations2", "wristRotations1", "wristRotations2", "wristRotations3", "wristRotations4", "wristRotations3", "wristRotations4"],
                2: ["elbowRotations", "elbowRotations1", "elbowRotations2", "elbowRotations3", "elbowRotations4", "elbowRotations3", "elbowRotations2", "elbowRotations1"],
                3: ["shoulderRotations", "shoulderRotations1", "shoulderRotations2", "shoulderRotations3", "shoulderRotations4", "shoulderRotations5", "shoulderRotations6", "shoulderRotations1"],
                4: ["neckRotations", "neckRotations1", "neckRotations2", "neckRotations1", "neckRotations2", "neckRotations3", "neckRotations4", "neckRotations3", "neckRotations4"],
                5: ["waistRotations", "waistRotations1", "waistRotations2", "waistRotations3", "waistRotations4", "waistRotations5", "waistRotations6", "waistRotations1"],
                6: ["hipRotations", "hipRotations", "hipRotations2", "hipRotations3", "hipRotations4", "hipRotations5", "hipRotations6", "hipRotations7", "hipRotations1"],
                7: ["kneeRotations", "kneeRotations1", "kneeRotations2", "kneeRotations3", "kneeRotations2", "kneeRotations1", "kneeRotations4", "kneeRotations5", "kneeRotations4", "kneeRotations1"],
                8: ["ankleRotations", "ankleRotations1", "ankleRotations2", "ankleRotations1", "ankleRotations2", "ankleRotations3", "ankleRotations4", "ankleRotations3", "ankleRotations4"],
                // Foam/Ball Roll
                9: ["backFoam", "backFoam1", "backFoam2", "backFoam3", "backFoam4", "backFoam3", "backFoam2", "backFoam1"],
                10: ["thoracicSpineFoam", "thoracicSpineFoam1", "thoracicSpineFoam2", "thoracicSpineFoam3", "thoracicSpineFoam2", "thoracicSpineFoam1", "thoracicSpineFoam4", "thoracicSpineFoam5", "thoracicSpineFoam4", "thoracicSpineFoam1"],
                11: ["latFoam", "latFoam1", "latFoam2", "latFoam3", "latFoam4", "latFoam3", "latFoam2", "latFoam1"],
                12: ["pecDeltFoam"],
                13: ["rearDeltFoam"],
                14: ["quadFoam", "quadFoam1", "quadFoam2", "quadFoam3", "quadFoam4", "quadFoam3", "quadFoam2", "quadFoam1", "quadFoam5", "quadFoam6", "quadFoam5"],
                15: ["adductorFoam", "adductorFoam1", "adductorFoam2", "adductorFoam3", "adductorFoam2", "adductorFoam1"],
                16: ["hamstringFoam", "hamstringFoam1", "hamstringFoam2", "hamstringFoam3", "hamstringFoam4", "hamstringFoam3", "hamstringFoam2", "hamstringFoam1"],
                17: ["gluteFoam", "gluteFoam1", "gluteFoam2", "gluteFoam3", "gluteFoam4", "gluteFoam3", "gluteFoam2", "gluteFoam1"],
                18: ["calveFoam", "calveFoam1", "calveFoam2", "calveFoam3", "calveFoam2", "calveFoam1", "calveFoam2", "calveFoam3", "calveFoam4", "calveFoam5", "calveFoam4", "calveFoam3", "calveFoam2", "calveFoam1"],
                19: ["itBandFoam", "itBandFoam1", "itBandFoam2", "itBandFoam3", "itBandFoam2", "itBandFoam1"],
                20: ["standingOnBall"],
                // Glutes
                21: ["gluteBridgeW", "gluteBridgeW1", "gluteBridgeW2", "gluteBridgeW3", "gluteBridgeW3", "gluteBridgeW2", "gluteBridgeW1", "gluteBridgeW2", "gluteBridgeW3", "gluteBridgeW3", "gluteBridgeW2", "gluteBridgeW1"],
                22: ["kneelingHipRotations", "kneelingHipRotations1", "kneelingHipRotations2", "kneelingHipRotations3", "kneelingHipRotations2", "kneelingHipRotations1", "kneelingHipRotations4", "kneelingHipRotations5", "kneelingHipRotations6", "kneelingHipRotations7", "kneelingHipRotations1", "kneelingHipRotations8", "kneelingHipRotations9", "kneelingHipRotations10", "kneelingHipRotations9", "kneelingHipRotations8", "kneelingHipRotations1", "kneelingHipRotations7", "kneelingHipRotations6", "kneelingHipRotations5", "kneelingHipRotations4", "kneelingHipRotations1", "kneelingHipRotations2", "kneelingHipRotations3", "kneelingHipRotations2", "kneelingHipRotations1"],
                23: ["legsToSideSquat", "legsToSideSquat1", "legsToSideSquat2", "legsToSideSquat3", "legsToSideSquat4", "legsToSideSquat3", "legsToSideSquat2", "legsToSideSquat1"],
                24: ["standingGluteKickback", "standingGluteKickback1", "standingGluteKickback2", "standingGluteKickback3", "standingGluteKickback3", "standingGluteKickback2", "standingGluteKickback1"],
                // Lower Back
                25: ["legDrop", "legDrop1", "legDrop2", "legDrop1", "legDrop", "legDrop1", "legDrop2", "legDrop1"],
                26: ["sideLegKick", "sideLegKick1", "sideLegKick2", "sideLegKick1", "sideLegKick", "sideLegKick1", "sideLegKick2", "sideLegKick1"],
                27: ["scorpionKick", "scorpionKick1", "scorpionKick2", "scorpionKick1", "scorpionKick", "scorpionKick1", "scorpionKick2", "scorpionKick1"],
                28: ["sideBend", "sideBend1", "sideBend2", "sideBend1", "sideBend", "sideBend1", "sideBend2", "sideBend1"],
                29: ["catCowS", "catCowS1", "catCowS2", "catCowS1", "catCowS3", "catCowS1", "catCowS2", "catCowS1"],
                30: ["legsToSideTwist", "legsToSideTwist1", "legsToSideTwist2", "legsToSideTwist3", "legsToSideTwist4", "legsToSideTwist4", "legsToSideTwist3", "legsToSideTwist2", "legsToSideTwist1", "legsToSideTwist1"],
                // Upper Back
                31: ["upperBackRotation", "upperBackRotation1", "upperBackRotation2", "upperBackRotation1", "upperBackRotation", "upperBackRotation1", "upperBackRotation2", "upperBackRotation1"],
                32: ["latStretch"],
                33: ["lyingSideWindmill", "lyingSideWindmill1", "lyingSideWindmill2", "lyingSideWindmill3", "lyingSideWindmill4", "lyingSideWindmill1", "lyingSideWindmill2", "lyingSideWindmill3", "lyingSideWindmill4"],
                // Shoulder
                34: ["wallSlides", "wallSlides1", "wallSlides2", "wallSlides1", "wallSlides", "wallSlides1", "wallSlides2", "wallSlides1"],
                35: ["wallReaches", "wallReaches1", "wallReaches2", "wallReaches1", "wallReaches", "wallReaches1", "wallReaches2", "wallReaches1"],
                36: ["shoulderRotationW", "shoulderRotationW1", "shoulderRotationW2", "shoulderRotationW1", "shoulderRotationW", "shoulderRotationW1", "shoulderRotationW2", "shoulderRotationW1"],
                37: ["forearmWallSlides135", "forearmWallSlides1351", "forearmWallSlides1352", "forearmWallSlides1351", "forearmWallSlides135", "forearmWallSlides1351", "forearmWallSlides1352", "forearmWallSlides1351"],
                38: ["superManShoulder", "superManShoulder1", "superManShoulder2", "superManShoulder3", "superManShoulder4", "superManShoulder4", "superManShoulder3", "superManShoulder2", "superManShoulder1", "superManShoulder1"],
                39: ["scapulaPushup", "scapulaPushup1", "scapulaPushup", "scapulaPushup1", "scapulaPushup", "scapulaPushup1"],
                // Band/Bar/Machine Assisted
                40: ["facePull", "facePull1", "facePull2", "facePull3", "facePull4", "facePull5", "facePull5", "facePull4", "facePull3", "facePull2", "facePull1"],
                41: ["externalRotation", "externalRotation1", "externalRotation2", "externalRotation3", "externalRotation4", "externalRotation4", "externalRotation3", "externalRotation2", "externalRotation1"],
                42: ["internalRotation", "internalRotation1", "internalRotation2", "internalRotation3", "internalRotation4", "internalRotation4", "internalRotation3", "internalRotation2", "internalRotation1"],
                43: ["shoulderDislocation", "shoulderDislocation1", "shoulderDislocation2", "shoulderDislocation1", "shoulderDislocation", "shoulderDislocation3", "shoulderDislocation", "shoulderDislocation1", "shoulderDislocation2", "shoulderDislocation1", "shoulderDislocation", "shoulderDislocation3"],
                44: ["latPullover", "latPullover1", "latPullover2", "latPullover3", "latPullover2", "latPullover1"],
                // General Mobility
                45: ["seatedKneeDrop", "seatedKneeDrop1", "seatedKneeDrop2", "seatedKneeDrop3", "seatedKneeDrop4", "seatedKneeDrop3", "seatedKneeDrop2", "seatedKneeDrop1"],
                46: ["mountainClimber", "mountainClimber3", "mountainClimber2", "mountainClimber1", "mountainClimber2", "mountainClimber3", "mountainClimber4", "mountainClimber5", "mountainClimber4", "mountainClimber3"],
                47: ["groinStretch"],
                48: ["threadTheNeedleS"],
                49: ["butterflyPoseS"],
                50: ["cossakSquat", "cossakSquat4", "cossakSquat1", "cossakSquat2", "cossakSquat3", "cossakSquat2", "cossakSquat1", "cossakSquat4", "cossakSquat5", "cossakSquat6", "cossakSquat7", "cossakSquat6", "cossakSquat5", "cossakSquat4"],
                51: ["hipHinges", "hipHinges1", "hipHinges2", "hipHinges3", "hipHinges4", "hipHinges4", "hipHinges3", "hipHinges2", "hipHinges1", "hipHinges1"],
                52: ["lungeTwist", "lungeTwist1", "lungeTwist2", "lungeTwist3", "lungeTwist4", "lungeTwist5", "lungeTwist6", "lungeTwist5", "lungeTwist4", "lungeTwist7", "lungeTwist8", "lungeTwist9", "lungeTwist10", "lungeTwist11", "lungeTwist12", "lungeTwist13", "lungeTwist12", "lungeTwist11", "lungeTwist14", "lungeTwist15"],
                53: ["sideLegSwings", "sideLegSwings1", "sideLegSwings2", "sideLegSwings3", "sideLegSwings4", "sideLegSwings3", "sideLegSwings2", "sideLegSwings1", "sideLegSwings5", "sideLegSwings1", "sideLegSwings2", "sideLegSwings3", "sideLegSwings4"],
                54: ["frontLegSwings", "frontLegSwings1", "frontLegSwings2", "frontLegSwings3", "frontLegSwings4", "frontLegSwings3", "frontLegSwings2", "frontLegSwings1", "frontLegSwings5", "frontLegSwings1", "frontLegSwings2", "frontLegSwings3", "frontLegSwings4"],
                55: ["spiderManOverheadReach", "spiderManOverheadReach1", "spiderManOverheadReach2", "spiderManOverheadReach3", "spiderManOverheadReach4", "spiderManOverheadReach5", "spiderManOverheadReach4", "spiderManOverheadReach3", "spiderManOverheadReach6", "spiderManOverheadReach7", "spiderManOverheadReach6", "spiderManOverheadReach3", "spiderManOverheadReach2", "spiderManOverheadReach1"],
                // Dynamic Warmup Drills
                56: ["forefootBounces", "forefootBounces1", "forefootBounces2", "forefootBounces3", "forefootBounces2", "forefootBounces1", "forefootBounces1", "forefootBounces3", "forefootBounces2", "forefootBounces1"],
                57: ["jumpSquat", "jumpSquat1", "jumpSquat2", "jumpSquat3", "jumpSquat4", "jumpSquat5", "jumpSquat4", "jumpSquat3", "jumpSquat2", "jumpSquat1"],
                58: ["lunge", "lunge1", "lunge2", "lunge3", "lunge4", "lunge3", "lunge2", "lunge1", "lunge5", "lunge6", "lunge7", "lunge6", "lunge5", "lunge1"],
                59: ["bumKicks", "bumKicks1", "bumKicks2", "bumKicks3", "bumKicks4", "bumKicks3", "bumKicks2", "bumKicks1"],
                60: ["aSkips", "aSkips1", "aSkips2", "aSkips3", "aSkips2", "aSkips1", "aSkips4", "aSkips5", "aSkips4", "aSkips1"],
                61: ["bSkips", "bSkips1", "bSkips2", "bSkips3", "bSkips4", "bSkips5", "bSkips6", "bSkips7", "bSkips8", "bSkips9", "bSkips10", "bSkips11"],
                62: ["grapeVines"],
                63: ["lateralBound", "lateralBound1", "lateralBound2", "lateralBound3", "lateralBound4", "lateralBound5", "lateralBound", "lateralBound6", "lateralBound7", "lateralBound8", "lateralBound9"],
                64: ["straightLegBound", "straightLegBound1", "straightLegBound2", "straightLegBound3", "straightLegBound4", "straightLegBound", "straightLegBound5", "straightLegBound6", "straightLegBound7", "straightLegBound8"],
                65: ["sprints"],
                // Accessory
                66: ["pushUp", "pushUp1", "pushUp2", "pushUp3", "pushUp4", "pushUp4", "pushUp3", "pushUp2", "pushUp1"],
                67: ["pullUp", "pullUp1", "pullUp2", "pullUp3", "pullUp4", "pullUp4", "pullUp3", "pullUp2", "pullUp1"]
            ],
            // Workout
            [
                // Gym ------------------------------------
                // Legs (Quads) ---------
                0: ["squat", "squat1", "squat2", "squat3", "squat2", "squat1"],
                1: ["frontSquat", "frontSquat1", "frontSquat2", "frontSquat3", "frontSquat2", "frontSquat1"],
                2: ["legPress", "legPress4", "legPress3", "legPress2", "legPress1", "legPress2", "legPress3", "legPress4"],
                3: ["dumbellFrontSquat", "dumbellFrontSquat1", "dumbellFrontSquat", "dumbellFrontSquat1"],
                4: ["legExtensions", "legExtensions1", "legExtensions2", "legExtensions3", "legExtensions2", "legExtensions1"],
                // Legs (Hamstrings/Glutes)
                5: ["deadlift", "deadlift1", "deadlift2", "deadlift3", "deadlift4", "deadlift5", "deadlift6", "deadlift7", "deadlift4", "deadlift2"],
                6: ["romanianDeadlift", "romanianDeadlift1", "romanianDeadlift2", "romanianDeadlift3", "romanianDeadlift2", "romanianDeadlift1"],
                7: ["weightedHipThrust", "weightedHipThrust1", "weightedHipThrust", "weightedHipThrust1"],
                8: ["legCurl", "legCurl1", "legCurl2", "legCurl3", "legCurl2", "legCurl1"],
                9: ["oneLeggedDeadlift", "oneLeggedDeadlift1", "oneLeggedDeadlift2", "oneLeggedDeadlift3", "oneLeggedDeadlift4", "oneLeggedDeadlift3", "oneLeggedDeadlift2", "oneLeggedDeadlift1"],
                10: ["gluteIsolationMachine", "gluteIsolationMachine1", "gluteIsolationMachine", "gluteIsolationMachine1"],
                // Legs (General)
                11: ["lungeDumbell", "lungeDumbell1", "lungeDumbell2", "lungeDumbell3", "lungeDumbell4", "lungeDumbell5", "lungeDumbell6", "lungeDumbell7", "lungeDumbell1", "lungeDumbell8", "lungeDumbell9", "lungeDumbell10", "lungeDumbell11", "lungeDumbell12", "lungeDumbell13", "lungeDumbell1"],
                12: ["bulgarianSplitSquat", "bulgarianSplitSquat1", "bulgarianSplitSquat", "bulgarianSplitSquat1"],
                13: ["stepUp", "stepUp1", "stepUp2", "stepUp3", "stepUp2", "stepUp1"],
                // Legs (Calves)
                14: ["standingCalfRaise", "standingCalfRaise1", "standingCalfRaise", "standingCalfRaise1"],
                15: ["seatedCalfRaise", "seatedCalfRaise1", "seatedCalfRaise", "seatedCalfRaise1"],
                // Pull (Back) ---------
                16: ["pullDown", "pullDown1", "pullDown2", "pullDown3", "pullDown4", "pullDown5", "pullDown5", "pullDown4", "pullDown3", "pullDown2", "pullDown1"],
                17: ["kneelingPullDown", "kneelingPullDown1", "kneelingPullDown2", "kneelingPullDown3", "kneelingPullDown4", "kneelingPullDown4", "kneelingPullDown3", "kneelingPullDown2", "kneelingPullDown1"],
                18: ["pullDownMachine", "pullDownMachine1", "pullDownMachine", "pullDownMachine1"],
                19: ["bentOverRowBarbell", "bentOverRowBarbell1", "bentOverRowBarbell2", "bentOverRowBarbell3", "bentOverRowBarbell4", "bentOverRowBarbell5", "bentOverRowBarbell5", "bentOverRowBarbell4", "bentOverRowBarbell3", "bentOverRowBarbell2"],
                20: ["bentOverRowDumbell", "bentOverRowDumbell1", "bentOverRowDumbell2", "bentOverRowDumbell3", "bentOverRowDumbell4", "bentOverRowDumbell5", "bentOverRowDumbell5", "bentOverRowDumbell4", "bentOverRowDumbell3", "bentOverRowDumbell2"],
                21: ["tBarRow", "tBarRow1", "tBarRow2", "tBarRow3", "tBarRow4", "tBarRow4", "tBarRow3", "tBarRow2", "tBarRow1"],
                22: ["rowMachine", "rowMachine1", "rowMachine2", "rowMachine3", "rowMachine4", "rowMachine4", "rowMachine3", "rowMachine2", "rowMachine1"],
                23: ["latPullover", "latPullover1", "latPullover2", "latPullover3", "latPullover2", "latPullover1"],
                // Pull (Upper Back)
                24: ["facePull", "facePull1", "facePull2", "facePull3", "facePull4", "facePull5", "facePull5", "facePull4", "facePull3", "facePull2", "facePull1"],
                25: ["leaningBackPullDown", "leaningBackPullDown1", "leaningBackPullDown2", "leaningBackPullDown3", "leaningBackPullDown4", "leaningBackPullDown4", "leaningBackPullDown3", "leaningBackPullDown2", "leaningBackPullDown1"],
                // Pull (Rear Delts)
                26: ["bentOverBarbellRow", "bentOverBarbellRow1", "bentOverBarbellRow", "bentOverBarbellRow1"],
                // Pull (Traps)
                27: ["shrugDumbell", "shrugDumbell1", "shrugDumbell", "shrugDumbell1"],
                // Pull (Biceps)
                28: ["hammerCurl", "hammerCurl1", "hammerCurl2", "hammerCurl3", "hammerCurl3", "hammerCurl2", "hammerCurl1", "hammerCurl4", "hammerCurl5", "hammerCurl5", "hammerCurl4", "hammerCurl1"],
                29: ["hammerCurlCable", "hammerCurlCable1", "hammerCurlCable2", "hammerCurlCable3", "hammerCurlCable3", "hammerCurlCable2", "hammerCurlCable1"],
                30: ["curl", "curl1", "curl2", "curl3", "curl3", "curl2", "curl1", "curl4", "curl5", "curl5", "curl4", "curl1"],
                // Pull (Forearms)
                31: ["farmersCarry"],
                32: ["reverseBarbellCurl", "reverseBarbellCurl1", "reverseBarbellCurl", "reverseBarbellCurl1"],
                33: ["forearmCurl", "forearmCurl1", "forearmCurl2", "forearmCurl1", "forearmCurl", "forearmCurl", "forearmCurl1", "forearmCurl2", "forearmCurl1"],
                // Push (Chest) ---------
                34: ["benchPress", "benchPress1", "benchPress2", "benchPress3", "benchPress4", "benchPress5", "benchPress5", "benchPress4", "benchPress3", "benchPress2"],
                35: ["benchPressDumbell", "benchPressDumbell4", "benchPressDumbell3", "benchPressDumbell2", "benchPressDumbell1", "benchPressDumbell1", "benchPressDumbell2", "benchPressDumbell3", "benchPressDumbell4"],
                36: ["semiInclineDumbellPress", "semiInclineDumbellPress4", "semiInclineDumbellPress3", "semiInclineDumbellPress2", "semiInclineDumbellPress1", "semiInclineDumbellPress1", "semiInclineDumbellPress2", "semiInclineDumbellPress3", "semiInclineDumbellPress4"],
                37: ["chestPress", "chestPress1", "chestPress", "chestPress1"],
                38: ["platePress", "platePress1", "platePress", "platePress1"],
                39: ["barbellKneelingPress", "barbellKneelingPress1", "barbellKneelingPress", "barbellKneelingPress1"],
                40: ["cableFly", "cableFly1", "cableFly2", "cableFly3", "cableFly4", "cableFly3", "cableFly2", "cableFly1", "cableFly1"],
                41: ["dips", "dips1", "dips", "dips1"],
                // Push (Shoulders)
                42: ["standingShoulderPressBarbell", "standingShoulderPressBarbell1", "standingShoulderPressBarbell2", "standingShoulderPressBarbell2", "standingShoulderPressBarbell1"],
                43: ["standingShoulderPressDumbell", "standingShoulderPressDumbell1", "standingShoulderPressDumbell2", "standingShoulderPressDumbell2", "standingShoulderPressDumbell1"],
                44: ["lateralRaise", "lateralRaise1", "lateralRaise2", "lateralRaise3", "lateralRaise4", "lateralRaise4", "lateralRaise3", "lateralRaise2", "lateralRaise1"],
                45: ["frontRaise", "frontRaise1", "frontRaise2", "frontRaise3", "frontRaise4", "frontRaise4", "frontRaise3", "frontRaise2", "frontRaise1"],
                // Push (Triceps)
                46: ["closeGripBench", "closeGripBench1", "closeGripBench2", "closeGripBench3", "closeGripBench4", "closeGripBench5", "closeGripBench5", "closeGripBench4", "closeGripBench3", "closeGripBench2"],
                47: ["cableExtension", "cableExtension1", "cableExtension2", "cableExtension3", "cableExtension3", "cableExtension2", "cableExtension1"],
                48: ["ropeExtensions", "ropeExtensions1", "ropeExtensions2", "ropeExtensions3", "ropeExtensions3", "ropeExtensions2", "ropeExtensions1"],
                // Full Body
                49: ["cleanPress", "cleanPress1", "cleanPress2", "cleanPress3", "cleanPress4", "cleanPress5", "cleanPress6", "cleanPress5", "cleanPress4", "cleanPress3", "cleanPress2", "cleanPress1"],
                // BodyWeight ------------------------------------
                // Legs (General) ---------
                50: ["bodyweightSquat", "bodyweightSquat1", "bodyweightSquat2", "bodyweightSquat3", "bodyweightSquat4", "bodyweightSquat5", "bodyweightSquat5", "bodyweightSquat4", "bodyweightSquat3", "bodyweightSquat2", "bodyweightSquat3", "bodyweightSquat4", "bodyweightSquat5", "bodyweightSquat5", "bodyweightSquat4", "bodyweightSquat3", "bodyweightSquat2",],
                51: ["pistolSquat", "pistolSquat1", "pistolSquat2", "pistolSquat3", "pistolSquat4", "pistolSquat5", "pistolSquat5", "pistolSquat4", "pistolSquat3", "pistolSquat2", "pistolSquat1"],
                52: ["skaterSquat", "skaterSquat1", "skaterSquat2", "skaterSquat3", "skaterSquat4", "skaterSquat4", "skaterSquat3", "skaterSquat2", "skaterSquat1"],
                53: ["jumpSquat", "jumpSquat1", "jumpSquat2", "jumpSquat3", "jumpSquat4", "jumpSquat5", "jumpSquat4", "jumpSquat3", "jumpSquat2", "jumpSquat1"],
                54: ["sumoSquat", "sumoSquat1", "sumoSquat2", "sumoSquat3", "sumoSquat4", "sumoSquat4", "sumoSquat3", "sumoSquat2"],
                55: ["lunge", "lunge1", "lunge2", "lunge3", "lunge4", "lunge3", "lunge2", "lunge1", "lunge5", "lunge6", "lunge7", "lunge6", "lunge5", "lunge1"],
                56: ["lungeJump", "lungeJump1", "lungeJump2", "lungeJump3", "lungeJump4", "lungeJump5", "lungeJump6", "lungeJump7", "lungeJump6", "lungeJump5", "lungeJump4", "lungeJump3", "lungeJump2", "lungeJump1"],
                // Legs (Hamstrings)
                57: ["bodyweightDeadlift", "bodyweightDeadlift1", "bodyweightDeadlift2", "bodyweightDeadlift3", "bodyweightDeadlift4", "bodyweightDeadlift3", "bodyweightDeadlift2", "bodyweightDeadlift1", "bodyweightDeadlift1"],
                58: ["singleLegDeadlift", "singleLegDeadlift1", "singleLegDeadlift2", "singleLegDeadlift3", "singleLegDeadlift4", "singleLegDeadlift3", "singleLegDeadlift2", "singleLegDeadlift1"],
                // Legs (Glutes)
                59: ["gluteBridgeW", "gluteBridgeW1", "gluteBridgeW2", "gluteBridgeW3", "gluteBridgeW3", "gluteBridgeW2", "gluteBridgeW1", "gluteBridgeW2", "gluteBridgeW3", "gluteBridgeW3", "gluteBridgeW2", "gluteBridgeW1"],
                60: ["singleLegGluteBridge", "singleLegGluteBridge1", "singleLegGluteBridge2", "singleLegGluteBridge3", "singleLegGluteBridge3", "singleLegGluteBridge2", "singleLegGluteBridge1"],
                61: ["kneelingHipRotations", "kneelingHipRotations8", "kneelingHipRotations9", "kneelingHipRotations10", "kneelingHipRotations10", "kneelingHipRotations9", "kneelingHipRotations8"],
                62: ["standingGluteKickback", "standingGluteKickback1", "standingGluteKickback2", "standingGluteKickback3", "standingGluteKickback3", "standingGluteKickback2", "standingGluteKickback1"],
                // Legs (Calves)
                63: ["calfRaise", "calfRaise1", "calfRaise", "calfRaise1"],
                // Pull (Back) ---------
                64: ["contralateralLimbRaises", "contralateralLimbRaises1", "contralateralLimbRaises2", "contralateralLimbRaises3", "contralateralLimbRaises3", "contralateralLimbRaises2", "contralateralLimbRaises1", "contralateralLimbRaises4", "contralateralLimbRaises5", "contralateralLimbRaises5", "contralateralLimbRaises4", "contralateralLimbRaises1"],
                65: ["superMan"],
                66: ["backHyperextension", "backHyperextension1", "backHyperextension2", "backHyperextension3", "backHyperextension4", "backHyperextension4", "backHyperextension3", "backHyperextension2", "backHyperextension1"],
                67: ["doorFrameRow", "doorFrameRow1", "doorFrameRow2", "doorFrameRow2", "doorFrameRow1"],
                68: ["reverseSnowAngels", "reverseSnowAngels1", "reverseSnowAngels2", "reverseSnowAngels3", "reverseSnowAngels4", "reverseSnowAngels4", "reverseSnowAngels3", "reverseSnowAngels2", "reverseSnowAngels1"],
                69: ["scapulaPushup", "scapulaPushup1", "scapulaPushup", "scapulaPushup1", "scapulaPushup", "scapulaPushup1"],
                // Pull (Traps)
                70: ["handStandTrap", "handStandTrap1", "handStandTrap", "handStandTrap1"],
                // Push (Chest) ---------
                71: ["pushUp", "pushUp1", "pushUp2", "pushUp3", "pushUp4", "pushUp4", "pushUp3", "pushUp2", "pushUp1"],
                // Push (Tricep)
                72: ["trianglePushup", "trianglePushup1", "trianglePushup2", "trianglePushup3", "trianglePushup4", "trianglePushup4", "trianglePushup3", "trianglePushup2", "trianglePushup1"],
                73: ["dolphinPushup", "dolphinPushup1", "dolphinPushup2", "dolphinPushup3", "dolphinPushup4", "dolphinPushup3", "dolphinPushup2", "dolphinPushup1"],
                74: ["tricepExtensionsBodyweight", "tricepExtensionsBodyweight1", "tricepExtensionsBodyweight", "tricepExtensionsBodyweight1"],
                // Push (Chest & Tricep)
                75: ["walkingPushup", "walkingPushup1", "walkingPushup2", "walkingPushup1", "walkingPushup3", "walkingPushup4", "walkingPushup5", "walkingPushup4", "walkingPushup3", "walkingPushup1", "walkingPushup2", "walkingPushup1", "walkingPushup6", "walkingPushup7", "walkingPushup8", "walkingPushup7", "walkingPushup6", "walkingPushup1", "walkingPushup2", "walkingPushup1"],
                // Push (Shoulder)
                76: ["downwardDogPushup", "downwardDogPushup1", "downwardDogPushup2", "downwardDogPushup3", "downwardDogPushup4", "downwardDogPushup5", "downwardDogPushup6", "downwardDogPushup7", "downwardDogPushup8", "downwardDogPushup1"],
                77: ["handStandTrap1"],
                78: ["boxer2", "boxer", "boxer1", "boxer2", "boxer1", "boxer", "boxer3", "boxer4", "boxer3", "boxer1"],
                79: ["armCircles"],
                // Core ---------
                80: ["plank"],
                81: ["dynamicPlank", "dynamicPlank1", "dynamicPlank", "dynamicPlank1"],
                82: ["sidePlankW"],
                83: ["pushupPlank"],
                84: ["lSit"],
                85: ["bicycleCrunch", "bicycleCrunch1", "bicycleCrunch2", "bicycleCrunch3", "bicycleCrunch4", "bicycleCrunch3", "bicycleCrunch2", "bicycleCrunch1"],
                86: ["divingHold"],
                87: ["hipRaise", "hipRaise1", "hipRaise", "hipRaise1"],
                88: ["legHold"],
                // General (Core) ---------
                89: ["mountainClimber", "mountainClimber3", "mountainClimber2", "mountainClimber1", "mountainClimber2", "mountainClimber3", "mountainClimber4", "mountainClimber5", "mountainClimber4", "mountainClimber3"],
                // General (Full Body)
                90: ["burpee3", "burpee2", "burpee1", "burpee", "burpee1", "burpee2", "burpee3", "burpee4", "burpee5", "burpee6", "burpee5", "burpee4", "burpee3", "burpee2"],
                91: ["kickThroughBurpee7", "kickThroughBurpee2", "kickThroughBurpee1", "kickThroughBurpee", "kickThroughBurpee1", "kickThroughBurpee2", "kickThroughBurpee3", "kickThroughBurpee4", "kickThroughBurpee5", "kickThroughBurpee4", "kickThroughBurpee6", "kickThroughBurpee7", "kickThroughBurpee6", "kickThroughBurpee4", "kickThroughBurpee8", "kickThroughBurpee9", "kickThroughBurpee8", "kickThroughBurpee4", "kickThroughBurpee3", "kickThroughBurpee2"],
                // General (Upper Body)
                92: ["spiderPushup4", "spiderPushup", "spiderPushup1", "spiderPushup2", "spiderPushup3", "spiderPushup4", "spiderPushup3", "spiderPushup2", "spiderPushup1", "spiderPushup", "spiderPushup1", "spiderPushup2", "spiderPushup5", "spiderPushup6", "spiderPushup5", "spiderPushup2", "spiderPushup1", "spiderPushup"],
                93: ["crabWalk", "crabWalk1", "crabWalk2", "crabWalk3", "crabWalk4", "crabWalk5", "crabWalk6"],
                // General (Cardio)
                94: ["jumpingJacks3", "jumpingJacks", "jumpingJacks1", "jumpingJacks2", "jumpingJacks3", "jumpingJacks4", "jumpingJacks3", "jumpingJacks2", "jumpingJacks1", "jumpingJacks"],
                95: ["tuckJump3", "tuckJump", "tuckJump1", "tuckJump2", "tuckJump3", "tuckJump2", "tuckJump1", "tuckJump"],
                96: ["bumKicks", "bumKicks1", "bumKicks2", "bumKicks3", "bumKicks4", "bumKicks3", "bumKicks2", "bumKicks1"],
                97: ["kneeRaises", "kneeRaises1", "kneeRaises2", "kneeRaises3", "kneeRaises4", "kneeRaises3", "kneeRaises2", "kneeRaises1"],
                // Isometric (Legs) ---------
                98: ["wallSit"],
                99: ["toePress"],
                100: ["lungeJump"],
                // Isometric (Upper Body)
                101: ["chestSqueeze"],
                102: ["pushupHold"],
                103: ["pullUp"],
                // Equiptment (Ball) ---------
                104: ["ballPushup", "ballPushup1", "ballPushup", "ballPushup1"],
                // Equiptment (Bar)
                105: ["bodyweightRow", "bodyweightRow1", "bodyweightRow", "bodyweightRow1"],
                106: ["pullUp", "pullUp1", "pullUp2", "pullUp3", "pullUp4", "pullUp4", "pullUp3", "pullUp2", "pullUp1"],
                107: ["hangingLegRaises", "hangingLegRaises1", "hangingLegRaises2", "hangingLegRaises3", "hangingLegRaises4", "hangingLegRaises3", "hangingLegRaises2", "hangingLegRaises1"],
                // Equiptment (Bench/Step)
                108: ["tricepDip", "tricepDip1", "tricepDip2", "tricepDip3", "tricepDip4", "tricepDip3", "tricepDip2", "tricepDip1"],
                109: ["bulgarianSplitSquat", "bulgarianSplitSquat1", "bulgarianSplitSquat", "bulgarianSplitSquat1"],
                110: ["boxJump"],
                111: ["hipThrusts", "hipThrusts1", "hipThrusts", "hipThrusts1"],
                112: ["stepUp", "stepUp1", "stepUp2", "stepUp3", "stepUp2", "stepUp1"]
            ],
            // Cardio
            [
                // Running
                0: ["rowing"],    // Rowing
                1: ["rowing"],
                2: ["rowing"],
                3: ["Pause"],     // Rowing Pauses
                4: ["Pause"],
                5: ["Pause"],
                // Biking
                6: ["rowing"],   // Bike
                7: ["rowing"],
                8: ["rowing"],
                9: ["Pause"],      // Biking Pauses
                10: ["Pause"],
                11: ["Pause"],
                // Running
                12: ["running"],   // Running
                13: ["running"],
                14: ["running"],
                15: ["Pause"],   // Running Pauses
                16: ["Pause"],
                17: ["Pause"],
                ],
            // Stretching
            [
                // Cardio
                0: ["cardioWarmup"],
                // Joint Rotations
                1: ["wristRotations", "wristRotations1", "wristRotations2", "wristRotations1", "wristRotations2", "wristRotations3", "wristRotations4", "wristRotations3", "wristRotations4"],
                2: ["elbowRotations", "elbowRotations1", "elbowRotations2", "elbowRotations3", "elbowRotations4", "elbowRotations3", "elbowRotations2", "elbowRotations1"],
                3: ["shoulderRotations", "shoulderRotations1", "shoulderRotations2", "shoulderRotations3", "shoulderRotations4", "shoulderRotations5", "shoulderRotations6", "shoulderRotations1"],
                4: ["neckRotations", "neckRotations1", "neckRotations2", "neckRotations1", "neckRotations2", "neckRotations3", "neckRotations4", "neckRotations3", "neckRotations4"],
                5: ["waistRotations", "waistRotations1", "waistRotations2", "waistRotations3", "waistRotations4", "waistRotations5", "waistRotations6", "waistRotations1"],
                6: ["hipRotations", "hipRotations", "hipRotations2", "hipRotations3", "hipRotations4", "hipRotations5", "hipRotations6", "hipRotations7", "hipRotations1"],
                7: ["kneeRotations", "kneeRotations1", "kneeRotations2", "kneeRotations3", "kneeRotations2", "kneeRotations1", "kneeRotations4", "kneeRotations5", "kneeRotations4", "kneeRotations1"],
                8: ["ankleRotations", "ankleRotations1", "ankleRotations2", "ankleRotations1", "ankleRotations2", "ankleRotations3", "ankleRotations4", "ankleRotations3", "ankleRotations4"],
                // Foam/Ball Roll
                9: ["backFoam", "backFoam1", "backFoam2", "backFoam3", "backFoam4", "backFoam3", "backFoam2", "backFoam1"],
                10: ["thoracicSpineFoam", "thoracicSpineFoam1", "thoracicSpineFoam2", "thoracicSpineFoam3", "thoracicSpineFoam2", "thoracicSpineFoam1", "thoracicSpineFoam4", "thoracicSpineFoam5", "thoracicSpineFoam4", "thoracicSpineFoam1"],
                11: ["latFoam", "latFoam1", "latFoam2", "latFoam3", "latFoam4", "latFoam3", "latFoam2", "latFoam1"],
                12: ["pecDeltFoam"],
                13: ["rearDeltFoam"],
                14: ["quadFoam", "quadFoam1", "quadFoam2", "quadFoam3", "quadFoam4", "quadFoam3", "quadFoam2", "quadFoam1", "quadFoam5", "quadFoam6", "quadFoam5"],
                15: ["adductorFoam", "adductorFoam1", "adductorFoam2", "adductorFoam3", "adductorFoam2", "adductorFoam1"],
                16: ["hamstringFoam", "hamstringFoam1", "hamstringFoam2", "hamstringFoam3", "hamstringFoam4", "hamstringFoam3", "hamstringFoam2", "hamstringFoam1"],
                17: ["gluteFoam", "gluteFoam1", "gluteFoam2", "gluteFoam3", "gluteFoam4", "gluteFoam3", "gluteFoam2", "gluteFoam1"],
                18: ["calveFoam", "calveFoam1", "calveFoam2", "calveFoam3", "calveFoam2", "calveFoam1", "calveFoam2", "calveFoam3", "calveFoam4", "calveFoam5", "calveFoam4", "calveFoam3", "calveFoam2", "calveFoam1"],
                19: ["itBandFoam", "itBandFoam1", "itBandFoam2", "itBandFoam3", "itBandFoam2", "itBandFoam1"],
                20: ["standingOnBall"],
                // Back
                21: ["catCowS", "catCowS1", "catCowS2", "catCowS1", "catCowS3", "catCowS1", "catCowS2", "catCowS1"],
                22: ["upwardsDogS"],
                23: ["extendedPuppyS"],
                24: ["childPoseS"],
                25: ["staffPoseS"],
                26: ["pelvicTilt", "pelvicTilt1", "pelvicTilt", "pelvicTilt1", "pelvicTilt", "pelvicTilt1", "pelvicTilt"],
                27: ["kneeToChest"],
                28: ["legDrop", "legDrop1", "legDrop2", "legDrop1", "legDrop", "legDrop1", "legDrop2", "legDrop1"],
                29: ["seatedTwist"],
                30: ["legsWall"],
                // Obliques(Sides)
                31: ["sideLean"],
                32: ["extendedSideAngleS"],
                33: ["seatedSide"],
                // Neck
                34: ["rearNeckStretch"],
                35: ["rearNeckHand"],
                36: ["seatedLateral"],
                37: ["neckRotatorStretch"],
                38: ["scalene"],
                39: ["headRoll"],
                // Arms
                40: ["forearmStretch"],
                41: ["tricepStretch"],
                42: ["bicepStretch"],
                // Pecs
                43: ["pecStretch"],
                // Shoulders
                44: ["shoulderRoll", "shoulderRoll1", "shoulderRoll2", "shoulderRoll3", "shoulderRoll", "shoulderRoll1", "shoulderRoll2", "shoulderRoll3"],
                45: ["behindBackTouch"],
                46: ["frontDeltStretch"],
                47: ["lateralDeltStretch"],
                48: ["rearDeltStretch"],
                49: ["rotatorCuff"],
                // Hips and Glutes
                50: ["squatHold"],
                51: ["groinStretch"],
                52: ["butterflyPoseS"],
                53: ["lungeStretch"],
                54: ["threadTheNeedleS"],
                55: ["pigeonPoseS"],
                56: ["seatedGlute"],
                // Calves
                57: ["calveStretch"],
                // Hamstrings
                58: ["standingHamstring"],
                59: ["standingSingleLegHamstring"],
                60: ["downWardsDogS"],
                61: ["singleLegHamstring"],
                62: ["twoLegHamstring"],
                // Quads
                63: ["lungeStretchWall"],
                64: ["quadStretch"],
                // Full Body
                65: ["sumoSquatTwist"],
                66: ["tinyFencerStretch"]
            ],
            // Yoga
            [
                // Standing
                0: ["upwardSalute"],
                1: ["mountain"],
                2: ["tree", "tree1", "tree2", "tree3", "tree4", "tree5", "tree6"],
                3: ["extendedToeGrab", "extendedToeGrab1", "extendedToeGrab2", "extendedToeGrab3", "extendedToeGrab4", "extendedToeGrab5"],
                4: ["eagle", "eagle1", "eagle2", "eagle3", "eagle4", "eagle5", "eagle6", "eagle7"],
                5: ["chair", "chair1", "chair2", "chair3", "chair4", "chair5"],
                6: ["lordOfDance", "lordOfDance1", "lordOfDance2", "lordOfDance3", "lordOfDance4", "lordOfDance5", "lordOfDance6", "lordOfDance7"],
                7: ["warrior1", "warrior11", "warrior12", "warrior13", "warrior14", "warrior15"],
                8: ["warrior2", "warrior21", "warrior22", "warrior23", "warrior24", "warrior25"],
                9: ["warrior3", "warrior31", "warrior32", "warrior33", "warrior34", "warrior35", "warrior36"],
                10: ["halfMoon", "halfMoon1", "halfMoon2", "halfMoon3", "halfMoon4", "halfMoon5", "halfMoon6", "halfMoon7"],
                11: ["extendedTriangle", "extendedTriangle1", "extendedTriangle2", "extendedTriangle3", "extendedTriangle4", "extendedTriangle5"],
                12: ["extendedSideAngle", "extendedSideAngle1", "extendedSideAngle2", "extendedSideAngle3", "extendedSideAngle4", "extendedSideAngle5", "extendedSideAngle6"],
                13: ["revolvedSideAngle", "revolvedSideAngle1", "revolvedSideAngle2", "revolvedSideAngle3", "revolvedSideAngle4", "revolvedSideAngle5", "revolvedSideAngle6"],
                14: ["revolvedTriangle", "revolvedTriangle1", "revolvedTriangle2", "revolvedTriangle3", "revolvedTriangle4", "revolvedTriangle5", "revolvedTriangle6"],
                15: ["halfForwardBend", "halfForwardBend1", "halfForwardBend2", "halfForwardBend3", "halfForwardBend4", "halfForwardBend5", "halfForwardBend6", "halfForwardBend7"],
                16: ["forwardBend", "forwardBend1", "forwardBend2", "forwardBend3", "forwardBend4", "forwardBend5", "forwardBend6", "forwardBend7"],
                17: ["wideLeggedForwardBend", "wideLeggedForwardBend1", "wideLeggedForwardBend2", "wideLeggedForwardBend3", "wideLeggedForwardBend4", "wideLeggedForwardBend5", "wideLeggedForwardBend6"],
                18: ["intenseSide", "intenseSide1", "intenseSide2", "intenseSide3", "intenseSide4", "intenseSide5"],
                19: ["gate"],
                20: ["highLunge", "highLunge1", "highLunge2", "highLunge3", "highLunge4", "highLunge5", "highLunge6"],
                21: ["lowLunge", "lowLunge1", "lowLunge2", "lowLunge3", "lowLunge4", "lowLunge5", "lowLunge6"],
                22: ["deepSquat", "deepSquat1", "deepSquat2", "deepSquat3", "deepSquat4", "deepSquat5"],
                // Hand/Elbows and Feet/Knees
                23: ["dolphin", "dolphin1", "dolphin2", "dolphin3"],
                24: ["downwardDog", "downwardDog1", "downwardDog2", "downwardDog3", "downwardDog4"],
                25: ["halfDownwardDog", "halfDownwardDog1", "halfDownwardDog2", "halfDownwardDog3", "halfDownwardDog4"],
                26: [""], //// UNUSED!!!!!!!
                27: ["dolphinPlank"],
                28: ["fourLimbedStaff"],
                29: ["sidePlank", "sidePlank1", "sidePlank2", "sidePlank3", "sidePlank4"],
                30: ["cat"],
                31: ["cow"],
                32: ["cat", "catCow1", "catCow2", "catCow1", "catCow3", "catCow1"],
                33: ["halfMonkey", "halfMonkey1", "halfMonkey2", "halfMonkey3", "halfMonkey4"],
                34: ["childPose", "childPose1", "childPose2", "childPose3"],
                35: ["wildThing", "wildThing1", "wildThing2", "wildThing3", "wildThing4", "wildThing5", "wildThing6"],
                36: ["upwardBow", "upwardBow1", "upwardBow2", "upwardBow3", "upwardBow4", "upwardBow5"],
                37: ["bridge", "bridge1", "bridge2", "bridge3"],
                38: ["upwardPlank", "upwardPlank1", "upwardPlank2", "upwardPlank3", "upwardPlank4", "upwardPlank5"],
                39: ["extendedPuppy", "extendedPuppy1", "extendedPuppy2", "extendedPuppy3", "extendedPuppy4", "extendedPuppy5"],
                40: ["upwardDog", "upwardDog1", "upwardDog2", "upwardDog3", "upwardDog4"],
                // Seated
                41: ["crossLegged"],
                42: ["lotus"],
                43: ["fireLog"],
                44: ["boat"],
                45: ["cowFace"],
                46: ["hero"],
                47: ["butterfly"],
                48: ["staff"],
                49: ["seatedForwardBend"],
                50: ["vForwardBend"],
                51: ["vSideBend", "vSideBend1", "vSideBend2", "vSideBend3", "vSideBend4", "vSideBend5"],
                52: ["halfVForwardBend", "halfVForwardBend1", "halfVForwardBend2", "halfVForwardBend3", "halfVForwardBend4", "halfVForwardBend5", "halfVForwardBend6"],
                53: ["halfVSideBend", "halfVSideBend1", "halfVSideBend2", "halfVSideBend3", "halfVSideBend4", "halfVSideBend5"],
                54: ["marichi1", "marichi11", "marichi12", "marichi13", "marichi14", "marichi15", "marichi16", "marichi17"],
                55: ["marichi3", "marichi31", "marichi32", "marichi33", "marichi34", "marichi35", "marichi36", "marichi37"],
                56: ["frontSplit"],
                57: ["sideSplit"],
                // Lying
                58: ["corpse"],
                59: ["fish", "fish1", "fish2", "fish3", "fish4", "fish5"],
                60: ["happyBaby"],
                61: ["lyingButterfly", "lyingButterfly1", "lyingButterfly2", "lyingButterfly3", "lyingButterfly4"],
                62: ["legRaiseToe"],
                63: ["threadTheNeedle", "threadTheNeedle1", "threadTheNeedle2", "threadTheNeedle3", "threadTheNeedle4", "threadTheNeedle5"],
                64: ["shoulderStand", "shoulderStand1", "shoulderStand2", "shoulderStand3", "shoulderStand4", "shoulderStand5", "shoulderStand6", "shoulderStand7"],
                65: ["plow", "plow1", "plow2", "plow3", "plow4"],
                66: ["cobra", "cobra1", "cobra2", "cobra3", "cobra4"],
                67: ["sphinx"],
                68: ["pigeon", "pigeon1", "pigeon2", "pigeon3", "pigeon4", "pigeon5", "pigeon6", "pigeon7", "pigeon8"],
                69: ["spineRolling", "spineRolling1", "spineRolling2", "spineRolling3", "spineRolling2", "spineRolling4", "spineRolling2", "spineRolling3", "spineRolling2", "spineRolling4"],
                // Hand Stands
                70: ["handStand", "handStand1", "handStand2", "handStand3", "handStand4", "handStand5", "handStand6", "handStand7", "handStand8"],
                71: ["headStand", "headStand1", "headStand2", "headStand3", "headStand4", "headStand5", "headStand6", "headStand7", "headStand8"],
                72: ["forearmStand", "forearmStand1", "forearmStand2", "forearmStand3", "forearmStand4", "forearmStand5", "forearmStand6"]
            ]
    ]
    
    
    //
    // MARK: Target Area Dictionaries
    static let targetAreaDictionaries: [[Int: String]] =
        [
            // Warmup
            [
                // Cardio
                0: "heart",
                // Joint Rotations
                1: "wrist",
                2: "elbow",
                3: "shoulder",
                4: "neckJoint",
                5: "waist",
                6: "hip",
                7: "knee",
                8: "ankle",
                // Foam/Ball Roll
                9: "thoracic",
                10: "thoracic",
                11: "latDelt",
                12: "pecFrontDelt",
                13: "rearDelt",
                14: "quad",
                15: "adductor",
                16: "hamstring",
                17: "glute",
                18: "calf",
                19: "calf",
                20: "calf",
                // Glutes
                21: "glute",
                22: "glute",
                23: "glute",
                24: "glute",
                // Lower Back
                25: "core",
                26: "core",
                27: "core",
                28: "core",
                29: "spine",
                30: "core",
                // Upper Back
                31: "upperBackShoulder",
                32: "lat",
                33: "upperBackShoulder",
                // Shoulder
                34: "shouler",
                35: "shouler",
                36: "shouler",
                37: "shouler",
                38: "backShoulder",
                39: "serratus",
                // Band/Bar/Machine Assisted
                40: "upperBackShoulder",
                41: "rearDelt",
                42: "rearDelt",
                43: "shoulder",
                44: "back",
                // General Mobility
                45: "hipArea",
                46: "hipArea",
                47: "quadHamstringGluteStretch",
                48: "adductor",
                49: "hamstringLowerBack",
                50: "piriformis",
                51: "adductor",
                52: "quadHamstringGluteStretch",
                53: "hamstringGlute",
                54: "quadHamstringGluteStretch",
                55: "quadHamstringGluteStretch",
                // Dynamic Warm Up Drills
                56: "calf",
                57: "squatBody",
                58: "squatBody",
                59: "squatBody",
                60: "squatBody",
                61: "squatBody",
                62: "squatBody",
                63: "squatBody",
                64: "squatBody",
                65: "squatBody",
                // Accessory
                66: "chestFrontDeltTricep",
                67: "backBicep"
            ],
            // Workout
            [
                // Gym ------------------------------------
                // Legs (Quads) ---------
                0: "squatBody",
                1: "squatBody",
                2: "squatBody",
                3: "squatBody",
                4: "squatBody",
                // Legs (Hamstrings/Glutes)
                5: "deadlift",
                6: "deadlift",
                7: "deadlift",
                8: "deadlift",
                9: "rearThigh",
                10: "glute",
                // Legs (General)
                11: "squatBody",
                12: "squatBody",
                13: "squatBody",
                // Legs (Calves)
                14: "calf",
                15: "calf",
                // Pull (Back) ---------
                16: "backBicep",
                17: "backBicep",
                18: "backBicep",
                19: "backBicep",
                20: "backBicepErector",
                21: "backBicepErector",
                22: "backBicepErector",
                23: "backBicep",
                // Pull (Upper Back)
                24: "upperBackShoulder",
                25: "upperBackShoulder",
                // Pull (Rear Delts)
                26: "rearDelt",
                // Pull (Traps)
                27: "trap",
                // Pull (Biceps)
                28: "bicep",
                29: "bicep",
                30: "bicep",
                // Pull (Forearms)
                31: "forearm",
                32: "forearm",
                33: "forearm",
                // Push (Chest) ---------
                34: "chestFrontDeltTricep",
                35: "chestFrontDeltTricep",
                36: "chestFrontDeltTricep",
                37: "chestFrontDeltTricep",
                38: "chestFrontDeltTricep",
                39: "pecFrontDelt",
                40: "pecFrontDelt",
                41: "pecFrontDelt",
                // Push (Shoulders)
                42: "shoulder",
                43: "shoulder",
                44: "shoulder",
                45: "shoulder",
                // Push (Triceps)
                46: "tricep",
                47: "tricep",
                48: "tricep",
                // Full Body
                49: "squatBody",
                // BodyWeight ------------------------------------
                // Legs (General) ---------
                50: "squatBody",
                51: "squatBody",
                52: "squatBody",
                53: "squatBody",
                54: "squatBody",
                55: "squatBody",
                56: "squatBody",
                // Legs (Hamstrings)
                57: "squatBody",
                58: "squatBody",
                // Legs (Glutes)
                59: "squatBody",
                60: "squatBody",
                61: "squatBody",
                62: "squatBody",
                // Legs (Calves)
                63: "squatBody",
                // Pull (Back) ---------
                64: "squatBody",
                65: "squatBody",
                66: "squatBody",
                67: "squatBody",
                68: "squatBody",
                69: "squatBody",
                // Pull (Traps)
                70: "squatBody",
                // Push (Chest) ---------
                71: "squatBody",
                // Push (Tricep)
                72: "squatBody",
                73: "squatBody",
                74: "squatBody",
                // Push (Chest & Tricep)
                75: "squatBody",
                // Push (Shoulder)
                76: "squatBody",
                77: "squatBody",
                78: "squatBody",
                79: "squatBody",
                // Core ---------
                80: "squatBody",
                81: "squatBody",
                82: "squatBody",
                83: "squatBody",
                84: "squatBody",
                85: "squatBody",
                86: "squatBody",
                87: "squatBody",
                88: "squatBody",
                // General (Core) ---------
                89: "squatBody",
                // General (Full Body)
                90: "squatBody",
                91: "squatBody",
                // General (Upper Body)
                92: "squatBody",
                93: "squatBody",
                // General (Cardio)
                94: "squatBody",
                95: "squatBody",
                96: "squatBody",
                97: "squatBody",
                // Isometric (Legs) ---------
                98: "squatBody",
                99: "squatBody",
                100: "squatBody",
                // Isometric (Upper Body)
                101: "squatBody",
                102: "squatBody",
                103: "squatBody",
                // Equiptment (Ball) ---------
                104: "squatBody",
                // Equiptment (Bar)
                105: "squatBody",
                106: "squatBody",
                107: "squatBody",
                // Equiptment (Bench/Step)
                108: "squatBody",
                109: "squatBody",
                110: "squatBody",
                111: "squatBody",
                112: "squatBody"
            ],
            // Cardio
            [:],
            // Stretching
            [
                // Cardio
                0: "heart",
                // Joint Rotations
                1: "wrist",
                2: "elbow",
                3: "shoulder",
                4: "neckJoint",
                5: "waist",
                6: "hip",
                7: "knee",
                8: "ankle",
                // Foam/Ball Roll
                9: "thoracic",
                10: "thoracic",
                11: "latDelt",
                12: "pecFrontDelt",
                13: "rearDelt",
                14: "quad",
                15: "adductor",
                16: "hamstring",
                17: "glute",
                18: "calf",
                19: "calf",
                20: "calf",
                // Back
                21: "spine",
                22: "spineCore",
                23: "spine",
                24: "spine",
                25: "hamstringLowerBack",
                26: "core",
                27: "spine",
                28: "core",
                29: "core",
                30: "hamstringLowerBack",
                // Obliques(Sides)
                31: "oblique",
                32: "oblique",
                33: "oblique",
                // Neck
                34: "rearNeck",
                35: "rearNeck",
                36: "lateralNeck",
                37: "neckRotator",
                38: "neckRotator",
                39: "neck",
                // Arms
                40: "forearm",
                41: "tricep",
                42: "bicep",
                // Pecs
                43: "pec",
                // Shoulders
                44: "shoulderJoint",
                45: "shoulderJoint",
                46: "frontDelt",
                47: "lateralNeck",
                48: "rearDelt",
                49: "rearDelt",
                // Hips and Glutes
                50: "hip",
                51: "adductor",
                52: "adductor",
                53: "hipArea",
                54: "piriformis",
                55: "glute",
                56: "glute",
                // Calves
                57: "calf",
                // Hamstrings
                58: "hamstring",
                59: "hamstring",
                60: "hamstring",
                61: "hamstring",
                62: "hamstring",
                // Quads
                63: "quad",
                64: "quad",
                // Full Body
                65: "squatBody",
                66: "squatBody"
            ],
            // Yoga
            [:]
    ]
    
    //
    // MARK: Explanation Dictionaries
    static let explanationDictionaries: [[Int : String]] =
        [
            // Warmup
            [
                // Cardio
                0: "5minCardioL",
                // Joint Rotations
                1: "wristE",
                2: "elbowE",
                3: "shoulderE",
                4: "neckE",
                5: "waistE",
                6: "hipE",
                7: "kneesE",
                8: "anklesE",
                // Foam/Ball Roll
                9: "backfE",
                10: "thoracicSpineE",
                11: "latE",
                12: "pecDeltE",
                13: "rearDeltE",
                14: "quadfE",
                15: "adductorfE",
                16: "hamstringfE",
                17: "glutefE",
                18: "calvefE",
                19: "itBandE",
                20: "standOnBallE",
                // Glutes
                21: "gluteBridgewWE", ///
                22: "kneelingKickBackWE", ///
                23: "legsToSideSquatE", ///
                24: "standingGluteKickbackE", ///
                // Lower Back
                25: "sideLegDropE",
                26: "sideLegKickE",
                27: "scorpionKickE",
                28: "sideBendE",
                29: "catCowE",
                30: "legsToSideTwistE", ///
                // Upper Back
                31: "upperBackRotationE", ///
                32: "latStretchE", ///
                33: "lyingSideWindmillE", ///
                // Shoulder
                34: "wallSlidesE",
                35: "wallReachesE",
                36: "shoulderRotationWE",
                37: "forearmWallSlides135E",
                38: "superManShoulderE",
                39: "scapulaPushupE",
                // Band/Bar/Machine Assisted
                40: "facePullE",
                41: "externalRotationE",
                42: "internalRotationE",
                43: "shoulderDislocationE",
                44: "latPulloverE",
                // General Mobility
                45: "seatedKneeDropE", ///
                46: "mountainClimberE",
                47: "groinStretchE",
                48: "threadTheNeedleE",
                49: "butterflyPoseE",
                50: "cossakSquatE",
                51: "hipHingesE",
                52: "lungeTwistE",
                53: "sideLegSwingsE",
                54: "frontLegSwingsE",
                55: "spiderManHipLiftOverheadReachE",
                // Dynamic Warmup Drills
                56: "forefootBouncesE",
                57: "jumpSquatE",
                58: "lungeE",
                59: "gluteKicksE",
                60: "aSkipsE",
                61: "bSkipsE",
                62: "grapeVinesE",
                63: "lateralBoundE",
                64: "straightLegBoundE",
                65: "sprintsE",
                // Accessory
                66: "pushUpE",
                67: "pullUpE"
            ],
            // Workout
            [
                // Gym ------------------------------------
                // Legs (Quads) ---------
                0: "squatE",
                1: "frontSquatE",
                2: "legPressE",
                3: "dumbellFrontSquatE",
                4: "legExtensionsE",
                // Legs (Hamstrings/Glutes)
                5: "deadliftE",
                6: "romanianDeadliftE",
                7: "weightedHipThrustE",
                8: "legCurlE",
                9: "oneLeggedDeadliftE",
                10: "gluteIsolationMachineE",
                // Legs (General)
                11: "lungeDumbellE",
                12: "bulgarianSplitSquatE",
                13: "weightedStepUpE",
                // Legs (Calves)
                14: "standingCalfRaiseE",
                15: "seatedCalfRaiseE",
                // Pull (Back) ---------
                16: "pullDownE",
                17: "kneelingPullDownE",
                18: "pullDownMachineE",
                19: "bentOverRowBarbellE",
                20: "bentOverRowDumbellE",
                21: "tBarRowE",
                22: "rowMachineE",
                23: "latPulloverE",
                // Pull (Upper Back)
                24: "facePullE",
                25: "leaningBackPullDownE",
                // Pull (Rear Delts)
                26: "bentOverBarbellRowE",
                // Pull (Traps)
                27: "shrugDumbellE",
                // Pull (Biceps)
                28: "hammerCurlE",
                29: "hammerCurlCableE",
                30: "curlE",
                // Pull (Forearms)
                31: "farmersCarryE",
                32: "reverseBarbellCurlE",
                33: "forearmCurlE",
                // Push (Chest) ---------
                34: "benchPressE",
                35: "benchPressDumbellE",
                36: "semiInclineDumbellPressE",
                37: "chestPressE",
                38: "platePressE",
                39: "barbellKneelingPressE",
                40: "cableFlyE",
                41: "dipsE",
                // Push (Shoulders)
                42: "standingShoulderPressBarbellE",
                43: "standingShoulderPressDumbellE",
                44: "lateralRaiseE",
                45: "frontRaiseE",
                // Push (Triceps)
                46: "closeGripBenchE",
                47: "cableExtensionE",
                48: "ropeExtensionE",
                // Full Body
                49: "cleanPressE",
                // BodyWeight ------------------------------------
                // Legs (General) ---------
                50: "bodyweightSquatE",
                51: "pistolSquatE",
                52: "skaterSquatE",
                53: "squatJumpE",
                54: "sumoSquatE",
                55: "lungeE",
                56: "lungeJumpE",
                // Legs (Hamstrings)
                57: "deadliftE",
                58: "singleLegDeadliftE",
                // Legs (Glutes)
                59: "gluteBridgeE",
                60: "singleLegGluteBridgeE",
                61: "kickBackE",
                62: "standingKickBackE",
                // Legs (Calves)
                63: "calfRaiseE",
                // Pull (Back) ---------
                64: "contralateralLimbRaisesE",
                65: "superManE",
                66: "backHyperextensionE",
                67: "doorFrameRowE",
                68: "reverseSnowAngelsE",
                69: "scapulaPushupE",
                // Pull (Traps)
                70: "handStandTrapE",
                // Push (Chest) ---------
                71: "pushupE",
                // Push (Tricep)
                72: "trianglePushupE",
                73: "dolphinPushupE",
                74: "tricepExtensionsBodyweightE",
                // Push (Chest & Tricep)
                75: "walkingPushupE",
                // Push (Shoulder)
                76: "downwardDogPushupE",
                77: "wallPushupE",
                78: "boxerE",
                79: "armCirclesE",
                // Core ---------
                80: "plankE",
                81: "dynamicPlankE",
                82: "sidePlankWE",
                83: "pushupPlankE",
                84: "lSitE",
                85: "bicycleCrunchE",
                86: "divingHoldE",
                87: "hipRaiseE",
                88: "legHoldE",
                // General (Core) ---------
                89: "mountainClimbersE",
                // General (Full Body)
                90: "burpeeE",
                91: "kickThroughBurpeeE",
                // General (Upper Body)
                92: "spiderPushupE",
                93: "crabWalkE",
                // General (Cardio)
                94: "jumpingJacksE",
                95: "tuckJumpE",
                96: "bumKicksE",
                97: "kneeRaisesE",
                // Isometric (Legs) ---------
                98: "wallSitE",
                99: "toePressE",
                100: "staticLungeE",
                // Isometric (Upper Body)
                101: "chestSqueezeE",
                102: "pushupHoldE",
                103: "pullupHoldE",
                // Equiptment (Ball) ---------
                104: "ballPushupE",
                // Equiptment (Bar)
                105: "bodweightRowE",
                106: "pullupE",
                107: "hangingLegRaiseE",
                // Equiptment (Bench/Step)
                108: "tricepDipE",
                109: "bulgarianSplitSquatE",
                110: "boxJumpE",
                111: "hipThrustsE",
                112: "stepUpE"
            ],
            // Cardio
            [:],
            // Stretching
            [
                // Recommended
                0: "5minCardioLE",
                // Joint Rotations
                1: "wristE",
                2: "elbowE",
                3: "shoulderRE",
                4: "neckRE",
                5: "waistE",
                6: "hipE",
                7: "kneesE",
                8: "anklesE",
                // Foam/Ball Roll
                9: "backfE",
                10: "thoracicSpineE",
                11: "latE",
                12: "pecDeltE",
                13: "rearDeltE",
                14: "quadfE",
                15: "adductorfE",
                16: "hamstringfE",
                17: "glutefE",
                18: "calvefE",
                19: "itBandE",
                20: "standOnBallE",
                // Back
                21: "catCowE",
                22: "upwardsDogE",
                23: "extendedPuppyE",
                24: "childPoseE",
                25: "staffPoseE",
                26: "pelvicTiltE",
                27: "kneeToChestE",
                28: "legDropE",
                29: "seatedTwistE",
                30: "legsWallE",
                // Obliques(Sides)
                31: "sideLeanE",
                32: "extendedSideAngleE",
                33: "seatedSideE",
                // Neck
                34: "rearNeckE",
                35: "rearNeckHandE",
                36: "seatedLateralE",
                37: "neckRotatorE",
                38: "scaleneE",
                39: "headRollE",
                // Arms
                40: "forearmStretchE",
                41: "tricepStretchE",
                42: "bicepStretchE",
                // Pecs
                43: "pecStretchE",
                // Shoulders
                44: "shoulderRollE",
                45: "behindBackTouchE",
                46: "frontDeltE",
                47: "lateralDeltE",
                48: "rearDeltE",
                49: "rotatorCuffE",
                // Hips and Glutes
                50: "squatHoldE",
                51: "groinStretchE",
                52: "butterflyPoseE",
                53: "lungeStretchE",
                54: "threadTheNeedleE",
                55: "pigeonPoseE",
                56: "seatedGluteE",
                // Calves
                57: "calveStretchE",
                // Hamstrings
                58: "standingHamstringE",
                59: "standingOneLegHamstringE",
                60: "downWardsDogE",
                61: "singleLegHamstringE",
                62: "twoLegHamstringE",
                // Quads
                63: "lungeStretchWallE",
                64: "QuadStretchE",
                // Full Body
                65: "sumoSquatTwistE",
                66: "tinyFencerStretchE"
            ],
            // Yoga
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
    ]
    
    //
    // MARK: Preset Dictionaries
    // [Warmup, Workout, Cardio, Stretching, Yoga]
    static let presetsDictionaries: [[[[Int: [[Any]]]]]] =
        [
            // ---------------------------------------------------------------------------------------------------
            // Warmup = 0
            // Session: [[name], [movements], [sets], [reps]]
            [
                // Warmup - Full Body
                [
                    // Sessions
                    [
                        0: [
                            ["All Movements"],
                            [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67],
                        [1,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2,1,1,2,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps","10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                            ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                            ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                            ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Warmup - Upper Body
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                            ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                            ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Warmup - Lower Body
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Warmup - Cardio
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ]
            ],
            // ---------------------------------------------------------------------------------------------------
            // Workout = 1
            // Classic Session: [[name], [movements], [sets], [reps]]
            // Circuit Session: [[name], [movements], [rounds], [reps]]
            [
                // -----------------------------------------------------------------------------------------------
                // Classic Gym - Full Body = 0
                [
                    // Sessions
                    [
                        0: [
                            ["All Movements"],
                            [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,112],
                            [1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                            ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                            ]
                    ],
                    // Sessions in Sections for final choice presets table. with their titles
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]

                ],
                // Classic Gym - Upper Body = 1
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Classic Gym - Lower Body = 2
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Classic Gym - Legs = 3
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Classic Gym - Pull = 4
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Classic Gym - Push = 5
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // -----------------------------------------------------------------------------------------------
                // Classic Gym - 5 x 5 = 6
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // -----------------------------------------------------------------------------------------------
                // Circuit Gym - Full Body = 7
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps", // Round 1
                             "20 reps", "20 reps", "20 reps", // Round 2
                             "10 reps", "10 reps", "10 reps"] // Round 3
                        ],
                        1: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps",
                             "20 reps", "20 reps", "20 reps",
                             "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Circuit Gym - Upper Body = 8
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps",
                            "20 reps", "20 reps", "20 reps",
                            "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps",
                             "20 reps", "20 reps", "20 reps",
                             "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Circuit Gym - Lower Body = 9
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps",
                             "20 reps", "20 reps", "20 reps",
                             "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps",
                             "20 reps", "20 reps", "20 reps",
                             "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // -----------------------------------------------------------------------------------------------
                // Bodyweight - Full Body = 10
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Bodyweight - Upper Body = 11
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Bodyweight - Lower Body = 12
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [1,2,1,2,1,2,1,2,1,2],
                            ["10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // -----------------------------------------------------------------------------------------------
                // Bodyweight Circuit - Full Body = 13
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps",
                             "20 reps", "20 reps", "20 reps",
                             "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps",
                             "20 reps", "20 reps", "20 reps",
                             "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Bodyweight Circuit - Upper Body = 14
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps",
                             "20 reps", "20 reps", "20 reps",
                             "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps",
                             "20 reps", "20 reps", "20 reps",
                             "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Bodyweight Circuit - Lower Body = 15
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps",
                             "20 reps", "20 reps", "20 reps",
                             "10 reps", "10 reps", "10 reps"]
                        ],
                        1: [
                            ["session"],
                            [0,1,2],
                            [3],
                            ["30 reps", "30 reps", "30 reps",
                             "20 reps", "20 reps", "20 reps",
                             "10 reps", "10 reps", "10 reps"]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ]
            ],
            // ---------------------------------------------------------------------------------------------------
            // Cardio = 2
            // Session: [[name], [movement], [time/distance]]
            [
                // Rowing - Full Body
                [
                    // Sessions
                    [
                        0: [
                            ["timeBasedTest"],
                            [0,4,0,4,0,4],
                            [5,10,5,10,5,10],
                        ],
                        1: [
                            ["distanceBasedTest"],
                            [0,4,0,4,0,4],
                            [200,10,100,5,200,5,100,5],
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Biking - Upper Body
                [
                    // Sessions
                    [
                        0: [
                            ["timeBasedTest"],
                            [6,10,6,10,6,10],
                            [5,10,5,10,5,10],
                        ],
                        1: [
                            ["distanceBasedTest"],
                            [6,10,6,10,6,10],
                            [200,10,100,5,200,5,100,5],
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Running - Lower Body
                [
                    // Sessions
                    [
                        0: [
                            ["timeBasedTest"],
                            [12,16,12,16,12,16],
                            [5,10,5,10,5,10],
                        ],
                        1: [
                            ["distanceBasedTest"],
                            [12,16,12,16,12,16],
                            [200,10,100,5,200,5,100,5],
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
            ],
            // ---------------------------------------------------------------------------------------------------
            // Stretching = 3
            // Session: [[name], [stretches], [breaths]]
            [
                // Stretching - General
                [
                    // Sessions
                    [
                        0: [
                            ["All Stretches"],
                            [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64],
                            [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [10,10,10,10,10,10,10,10,10,10]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Stretching - Post Workout
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [10,10,10,10,10,10,10,10,10,10]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [10,10,10,10,10,10,10,10,10,10]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ],
                // Stretching - Post Cardio
                [
                    // Sessions
                    [
                        0: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [10,10,10,10,10,10,10,10,10,10]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [10,10,10,10,10,10,10,10,10,10]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ]
            ],
            // ---------------------------------------------------------------------------------------------------
            // Yoga = 4
            // Session: [[name], [poses], [breaths]]
            [
                // Yoga - Practices
                [
                    // Sessions
                    [
                        0: [
                            ["All Poses"],
                            [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72],
                            [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72]
                        ],
                        1: [
                            ["session"],
                            [0,1,2,3,4,5,6,7,8,9],
                            [0,1,2,3,4,5,6,7,8,9]
                        ]
                    ],
                    // Session in Sections for final choice presets table
                    [
                        0: [
                            ["testTitle"],
                            ["testTitle2"]
                        ],
                        1: [
                            [0],
                            [1]
                        ]
                    ]
                ]
            ]
    ]
    
    
    // 
    // MARK: Final Choice Navigation Titles
    static let navigationTitles: [[String]] =
    [
        // Warmup
        ["fullBody",
         "upperBody",
         "lowerBody",
         "cardio"],
        // Workout
        ["fullBody",
         "upperBody",
         "lowerBody",
         "legs",
         "pull",
         "push",
         "fullBody",
         "upperBody",
         "lowerBody",
         "5x5",
         "fullBody",
         "upperBody",
         "lowerBody",
         "fullBody",
         "upperBody",
         "lowerBody"],
        // Cardio
        ["rowing",
         "biking",
         "running"],
        // Stretching
        ["general",
        "postWorkout",
        "postCardio"],
        // Yoga
        ["practices"]
    ]

}














