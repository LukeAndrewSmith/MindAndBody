//
//  Movements.swift
//  MindAndBody
//
//  Created by Luke Smith on 04.12.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation

extension sessionData {
    
    // MARK:- Full Key Arrays
    static let fullKeyArrays: [String: [[String]]] =
        [
            "warmup":
                [
                    // Cardio
                    ["lightCardio"],
                    // Joint Rotations
                    ["wrist", "elbow", "shoulderR", "neckR", "waist", "hip", "knees", "ankles"],
                    // Foam/Ball Roll
                    ["backf", "thoracicSpine", "lat", "pecDelt", "rearDelt", "quadf", "adductorf", "hamstringf", "glutef", "calff", "itBand", "standOnBall"],
                    // Glutes
                    ["gluteBridge", "kneelingKickBackW", "legsToSideSquat", "standingGluteKickback"],
                    // Lower Back
                    ["legDrop", "sideLegKick", "scorpionKick", "sideBend", "catCow", "legsToSideTwist", "plank"],
                    // Upper Back
                    ["upperBackRotation", "latStretch"],
                    // Shoulder
                    ["wallSlides", "wallReaches", "shoulderRotationW", "forearmWallSlides135", "superManShoulder"],
                    // Band/Bar/Machine Assisted
                    ["facePull", "externalRotation", "internalRotation", "shoulderDislocation", "latPullover"],
                    // General Mobility
                    ["seatedKneeDrop", "groinStretch", "threadTheNeedle", "butterflyPose", "cossakSquat", "hipHinges", "lungeTwist", "sideLegSwings", "frontLegSwings", "hipLiftOverheadReach"],
                    // Dynamic Warmup Drills
                    ["forefootBounces", "jumpSquat", "lunge", "gluteKicks", "aSkips", "bSkips", "grapeVines", "lateralBound", "straightLegBound", "sprints"],
                    // Accessory
                    ["pushUp", "pullUp"]
            ],
            "workout":
                [
                    // Gym ------------------------------------
                    // Legs (Quads) ---------
                    ["squat", "frontSquat", "legPress", "dumbellFrontSquat", "legExtensions"],
                    // Legs (Hamstrings/Glutes)
                    ["deadlift", "romanianDeadlift", "weightedHipThrust", "legCurl", "oneLeggedDeadlift"],
                    // Legs (General)
                    ["lungeDumbell", "bulgarianSplitSquat", "weightedStepUp"],
                    // Legs (calves)
                    ["standingCalfRaise", "seatedCalfRaise"],
                    // Pull (Back) ---------
                    ["pullDown", "kneelingPullDown", "bentOverRowDumbell", "tBarRow", "rowMachine", "latPullover"],
                    // Pull (Upper Back)
                    ["facePull", "leaningBackPullDown"],
                    // Pull (Rear Delts)
                    ["bentOverBarbellRow"],
                    // Pull (Traps)
                    ["shrugDumbell"],
                    // Pull (Biceps)
                    ["hammerCurl", "hammerCurlCable", "curl"],
                    // Pull (Forearms)
                    ["farmersCarry", "reverseBarbellCurl"],
                    // Push (Chest) ---------
                    ["benchPress", "benchPressDumbell", "semiInclineDumbellPress", "platePress", "barbellKneelingPress", "dips"],
                    // Push (Shoulders)
                    ["standingShoulderPressBarbell", "standingShoulderPressDumbell", "lateralRaise", "frontRaise"],
                    // Push (Triceps) //
                    ["closeGripBench", "cableExtension", "ropeExtension"],
                    // Full Body ---------
                    ["cleanPress"],
                    // BodyWeight ------------------------------------
                    // Legs (General) ---------
                    ["bodyweightSquat", "jumpSquat", "pistolSquat", "skaterSquat", "lunge", "lungeJump"],
                    // Legs (Hamstrings)
                    ["bodyweightDeadlift", "singleLegDeadlift"],
                    // Legs (Glutes)
                    ["gluteBridge", "singleLegGluteBridge", "kickBack", "standingKickBack"],
                    // Legs (calves)
                    ["calfRaise"],
                    // Pull (Back) ---------
                    ["contralateralLimbRaises", "superMan", "backHyperextension", "doorFrameRow", "reverseSnowAngels"],
                    // Pull (Traps)
                    ["handStandTrap"],
                    // Push (Chest) ---------
                    ["pushUp"],
                    // Push (Tricep)
                    ["trianglePushUp", "dolphinPushup", "tricepExtensionsBodyweight"],
                    // Push (Chest & Tricep)
                    ["walkingPushup"],
                    // Push (Shoulder)
                    ["downwardDogPushup", "wallpushUp", "boxer", "armCircles"],
                    // Core ---------
                    ["plank", "dynamicPlank", "sidePlankW", "pushupPlank", "lSit", "bicycleCrunch", "divingHold", "hipRaise", "legHold", "legDrop"],
                    // General (Core) ---------
                    ["mountainClimbers"],
                    // General (Full Body)
                    ["burpee", "kickThroughBurpee"],
                    // General (Upper Body)
                    ["spiderPushup", "crabWalk"],
                    // General (Cardio)
                    ["jumpingJacks", "tuckJump", "bumKicks", "kneeRaises"],
                    // Isometric (Legs) ---------
                    ["wallSit", "toePress", "staticLunge"],
                    // Isometric (Upper Body)
                    ["pushupHold", "pullupHold"],
                    // Equipment (Ball) ---------
                    ["ballPushup"],
                    // Equipment (Bar)
                    ["bodyweightRow", "pullup", "hangingLegRaise"],
                    // Equipment (Bench/Step)
                    ["bulgarianSplitSquat", "boxJump", "hipThrusts", "stepUp"]
            ],
            "endurance":
                [
                    ["highIntensity", "lowIntensity"],
                    // Running
                    ["sprint", "run", "jog", "still", "slowJog", "stretch"],
                    // Biking
                    ["sprintB", "fastB", "mediumB", "stillB", "slowB", "stretch"],
                    // Rowing
                    ["sprintR", "fastR", "mediumR", "stillR", "slowR", "stretch"]
            ],
            "stretching":
                [
                    // Recommended
                    ["lightCardio"],
                    // Joint Rotations
                    ["wrist", "elbow", "shoulderR", "neckR", "waist", "hip", "knees", "ankles"],
                    // Foam/Ball Roll
                    ["backf", "thoracicSpine", "lat", "pecDelt", "rearDelt", "quadf", "adductorf", "hamstringf", "glutef", "calff", "itBand", "standOnBall"],
                    // Back
                    ["catCow", "upwardsDog", "extendedPuppy", "childPose", "staffPose", "pelvicTilt", "kneeToChest", "legDrop", "seatedTwist", "legsWall"],
                    // Obliques(Sides)
                    ["sideLean", "extendedSideAngle", "seatedSide"],
                    // Neck
                    ["rearNeck", "rearNeckHand", "seatedLateral", "neckRotator", "scalene", "headRoll"],
                    // Arms
                    ["forearmStretch", "tricepStretch", "bicepStretch"],
                    // Pecs
                    ["pecStretch"],
                    // Shoulders
                    ["shoulderRoll", "behindBackTouch", "frontDelt", "lateralDelt", "rearDeltStretch"],
                    // Hips and Glutes
                    ["squatHold", "groinStretch", "butterflyPose", "lungeStretch", "threadTheNeedle", "pigeonPose", "seatedGlute"],
                    // calves
                    ["calfStretch"],
                    // Hamstrings
                    ["standingHamstring", "downWardsDog", "singleLegHamstring", "twoLegHamstring"],
                    // Quads
                    ["lungeStretchWall", "quadStretch"]
            ],
            "yoga":
                [
                    // Standing
                    ["upwardsSalute", "mountain", "treeL", "treeR", "extendedToeGrabL", "extendedToeGrabR", "eagleL", "eagleR", "chair", "lordOfDanceL", "lordOfDanceR", "warrior1L", "warrior1R", "warrior2L", "warrior2R", "warrior3L", "warrior3R", "halfMoonL", "halfMoonR", "extendedTriangleL", "extendedTriangleR", "extendedSideAngleYL", "extendedSideAngleYR", "revolvedSideAngleL", "revolvedSideAngleR", "revolvedTriangleL", "revolvedTriangleR", "halfForwardBend", "forwardBend", "wideLeggedForwardBend", "intenseSideL", "intenseSideR", "gateL", "gateR", "highLungeL", "highLungeR", "lowLungeYL", "lowLungeYR", "deepSquat"],
                    // Hand/Elbows and Feet/Knees
                    ["dolphin", "downwardDog", "halfDownwardDogL", "halfDownwardDogR", "dolphinPlank", "fourLimbedStaff", "sidePlankL", "sidePlankR", "cat", "cow", "catCow", "halfMonkeyL", "halfMonkeyR", "childPose", "wildThingL", "wildThingR", "upwardBow", "bridge", "upwardPlank", "extendedPuppy", "upwardsDogY"],
                    // Seated
                    ["crossLeg", "lotus", "fireLogL", "fireLogR", "boat", "cowFaceL", "cowFaceR", "hero", "butterfly", "staffPose", "seatedForwardBend", "vForwardBend", "vSideBendL", "vSideBendR", "halfVForwardBendL", "halfVForwardBendR", "halfVSideBendL", "halfVSideBendR", "marichi1L", "marichi1R", "marichi3L", "marichi3R", "frontSplitL", "frontSplitR", "sideSplit"],
                    // Lying
                    ["corpse", "fish", "happyBaby", "lyingButterfly", "legRaiseToeL", "legRaiseToeR", "threadTheNeedleYL", "threadTheNeedleYR", "shoulderStand", "plow", "cobra", "sphinx", "pigeonL", "pigeonR", "spineRolling"],
                    // Hand Stands
                    ["handstand", "headstand", "forearmStand"]
            ]
    ]
    
    
    static let maxWeight = 120
    // Weights
    static let weightsMetric = { () -> [Float] in
        let weightArrayInt = Array(0...maxWeight)
        let weightArray = weightArrayInt.map { Float($0) * 2.5 }
        return weightArray
    }
    //
    static let weightsImperial = { () -> [Float] in
        let weightArrayInt = Array(0...maxWeight)
        let weightArray = weightArrayInt.map { Float($0) * 5 }
        return weightArray
    }
    

    //
    // MARK:- Movements Dictionaries
    // Notes:
        // attributes: a = asymmetric, w = weighted
            // a for yoga indicates which images to fliplr
    static let movements: [String: [String: [String : [String]]]] =
        [
            // MARK: Warmup
            "warmup":
                [
                    // Cardio
                    "lightCardio":
                        [
                            "name": ["lightCardio"],
                            "demonstration": ["cardioWarmup"],
                            "explanation": ["lightCardioEH", "lightCardioEA", "lightCardioEF"],
                            "targetArea": ["heart"],
                            "attributes": [""]
                    ],
                    // Joint Rotations
                    "wrist":
                        [
                            "name": ["wrist"],
                            "demonstration": ["wristRotations", "wristRotations1", "wristRotations2", "wristRotations1", "wristRotations2", "wristRotations3", "wristRotations4", "wristRotations3", "wristRotations4"],
                            "explanation": ["wristEH", "wristEA", "wristEF"],
                            "targetArea": ["wrist"],
                            "attributes": [""]
                    ],
                    "elbow":
                        [
                            "name": ["elbow"],
                            "demonstration": ["elbowRotations", "elbowRotations1", "elbowRotations2", "elbowRotations3", "elbowRotations4", "elbowRotations3", "elbowRotations2", "elbowRotations1"],
                            "explanation": ["elbowEH", "elbowEA", "elbowEF"],
                            "targetArea": ["elbow"],
                            "attributes": ["a"]
                    ],
                    "shoulderR":
                        [
                            "name": ["shoulderR"],
                            "demonstration": ["shoulderRotations", "shoulderRotations1", "shoulderRotations2", "shoulderRotations3", "shoulderRotations4", "shoulderRotations5", "shoulderRotations6", "shoulderRotations1"],
                            "explanation": ["shoulderREH", "shoulderREA", "shoulderREF"],
                            "targetArea": ["shoulder"],
                            "attributes": ["a"]
                    ],
                    "neckR":
                        [
                            "name": ["neckR"],
                            "demonstration": ["neckRotations", "neckRotations1", "neckRotations2", "neckRotations1", "neckRotations2", "neckRotations3", "neckRotations4", "neckRotations3", "neckRotations4"],
                            "explanation": ["neckREH", "neckREA", "neckREF"],
                            "targetArea": ["neckJoint"],
                            "attributes": [""]
                    ],
                    "waist":
                        [
                            "name": ["waist"],
                            "demonstration": ["waistRotations", "waistRotations1", "waistRotations2", "waistRotations3", "waistRotations4", "waistRotations5", "waistRotations6", "waistRotations1"],
                            "explanation": ["waistEH", "waistEA", "waistEF"],
                            "targetArea": ["waist"],
                            "attributes": ["a"]
                    ],
                    "hip":
                        [
                            "name": ["hip"],
                            "demonstration": ["hipRotations", "hipRotations", "hipRotations2", "hipRotations3", "hipRotations4", "hipRotations5", "hipRotations6", "hipRotations7", "hipRotations1"],
                            "explanation": ["hipEH", "hipEA", "hipEF"],
                            "targetArea": ["hip"],
                            "attributes": ["a"]
                    ],
                    "knees":
                        [
                            "name": ["knees"],
                            "demonstration": ["kneeRotations", "kneeRotations1", "kneeRotations2", "kneeRotations3", "kneeRotations2", "kneeRotations1", "kneeRotations4", "kneeRotations5", "kneeRotations4", "kneeRotations1"],
                            "explanation": ["kneesEH", "kneesEA", "kneesEF"],
                            "targetArea": ["knee"],
                            "attributes": ["a"]
                    ],
                    "ankles":
                        [
                            "name": ["ankles"],
                            "demonstration": ["ankleRotations", "ankleRotations1", "ankleRotations2", "ankleRotations1", "ankleRotations2",
                                "ankleRotations1",
                                "ankleRotations2",],
                            "explanation": ["anklesEH", "anklesEA", "anklesEF"],
                            "targetArea": ["ankle"],
                            "attributes": ["a"]
                    ],
                    // Foam/Ball Roll
                    "backf":
                        [
                            "name": ["backf"],
                            "demonstration": ["backFoam", "backFoam1", "backFoam2", "backFoam3", "backFoam4", "backFoam3", "backFoam2", "backFoam1"],
                            "explanation": ["backfEH", "backfEA", "backfEF"],
                            "targetArea": ["thoracic"],
                            "attributes": [""]
                    ],
                    "thoracicSpine":
                        [
                            "name": ["thoracicSpine"],
                            "demonstration": ["thoracicSpineFoam", "thoracicSpineFoam1", "thoracicSpineFoam2", "thoracicSpineFoam3", "thoracicSpineFoam2", "thoracicSpineFoam1", "thoracicSpineFoam4", "thoracicSpineFoam5", "thoracicSpineFoam4", "thoracicSpineFoam1"],
                            "explanation": ["thoracicSpineEH", "thoracicSpineEA", "thoracicSpineEF"],
                            "targetArea": ["thoracic"],
                            "attributes": [""]
                    ],
                    "lat":
                        [
                            "name": ["lat"],
                            "demonstration": ["latFoam", "latFoam1", "latFoam2", "latFoam3", "latFoam4", "latFoam3", "latFoam2", "latFoam1"],
                            "explanation": ["latEH", "latEA", "latEF"],
                            "targetArea": ["latDelt"],
                            "attributes": ["a"]
                    ],
                    "pecDelt":
                        [
                            "name": ["pecDelt"],
                            "demonstration": ["pecDeltFoam"],
                            "explanation": ["pecDeltEH", "pecDeltEA", "pecDeltEF"],
                            "targetArea": ["pecFrontDelt"],
                            "attributes": ["a"]
                    ],
                    "rearDelt":
                        [
                            "name": ["rearDelt"],
                            "demonstration": ["rearDeltFoam"],
                            "explanation": ["rearDeltEH", "rearDeltEA", "rearDeltEF"],
                            "targetArea": ["rearDelt"],
                            "attributes": ["a"]
                    ],
                    "quadf":
                        [
                            "name": ["quadf"],
                            "demonstration": ["quadFoam", "quadFoam1", "quadFoam2", "quadFoam3", "quadFoam4", "quadFoam3", "quadFoam2", "quadFoam1", "quadFoam5", "quadFoam6", "quadFoam5"],
                            "explanation": ["quadfEH", "quadfEA", "quadfEF"],
                            "targetArea": ["quad"],
                            "attributes": ["a"]
                    ],
                    "adductorf":
                        [
                            "name": ["adductorf"],
                            "demonstration": ["adductorFoam", "adductorFoam1", "adductorFoam2", "adductorFoam3", "adductorFoam2", "adductorFoam1"],
                            "explanation": ["adductorfEH", "adductorfEA", "adductorfEF"],
                            "targetArea": ["adductor"],
                            "attributes": ["a"]
                    ],
                    "hamstringf":
                        [
                            "name": ["hamstringf"],
                            "demonstration": ["hamstringFoam", "hamstringFoam1", "hamstringFoam2", "hamstringFoam3", "hamstringFoam4", "hamstringFoam3", "hamstringFoam2", "hamstringFoam1"],
                            "explanation": ["hamstringfEH", "hamstringfEA", "hamstringfEF"],
                            "targetArea": ["hamstring"],
                            "attributes": ["a"]
                    ],
                    "glutef":
                        [
                            "name": ["glutef"],
                            "demonstration": ["gluteFoam", "gluteFoam1", "gluteFoam2", "gluteFoam3", "gluteFoam4", "gluteFoam3", "gluteFoam2", "gluteFoam1"],
                            "explanation": ["glutefEH", "glutefEA", "glutefEF"],
                            "targetArea": ["glute"],
                            "attributes": ["a"]
                    ],
                    "calff":
                        [
                            "name": ["calff"],
                            "demonstration": ["calfFoam", "calfFoam1", "calfFoam2", "calfFoam3", "calfFoam2", "calfFoam1", "calfFoam2", "calfFoam3", "calfFoam4", "calfFoam5", "calfFoam4", "calfFoam3", "calfFoam2", "calfFoam1"],
                            "explanation": ["calffEH", "calffEA", "calffEF"],
                            "targetArea": ["calf"],
                            "attributes": ["a"]
                    ],
                    "itBand":
                        [
                            "name": ["itBand"],
                            "demonstration": ["itBandFoam", "itBandFoam1", "itBandFoam2", "itBandFoam3", "itBandFoam2", "itBandFoam1"],
                            "explanation": ["itBandEH", "itBandEA", "itBandEF"],
                            "targetArea": ["ITBand"],
                            "attributes": ["a"]
                    ],
                    "standOnBall":
                        [
                            "name": ["standOnBall"],
                            "demonstration": ["standingOnBall"],
                            "explanation": ["standOnBallEH", "standOnBallEA", "standOnBallEF"],
                            "targetArea": ["foot"],
                            "attributes": ["a"]
                    ],
                    // Glutes
                    "gluteBridge":
                        [
                            "name": ["gluteBridge"],
                            "demonstration": ["gluteBridge", "gluteBridge1", "gluteBridge2", "gluteBridge3", "gluteBridge3", "gluteBridge2", "gluteBridge1", "gluteBridge2", "gluteBridge3", "gluteBridge3", "gluteBridge2", "gluteBridge1"],
                            "explanation": ["gluteBridgeEH", "gluteBridgeEA", "gluteBridgeEF"],
                            "targetArea": ["hamstringGlute"],
                            "attributes": [""]
                    ], ///
                    "kneelingKickBackW":
                        [
                            "name": ["kneelingKickBackW"],
                            "demonstration": ["kneelingHipRotations", "kneelingHipRotations1", "kneelingHipRotations2", "kneelingHipRotations3", "kneelingHipRotations2", "kneelingHipRotations1", "kneelingHipRotations4", "kneelingHipRotations5", "kneelingHipRotations6", "kneelingHipRotations7", "kneelingHipRotations1", "kneelingHipRotations8", "kneelingHipRotations9", "kneelingHipRotations10", "kneelingHipRotations9", "kneelingHipRotations8", "kneelingHipRotations1", "kneelingHipRotations7", "kneelingHipRotations6", "kneelingHipRotations5", "kneelingHipRotations4", "kneelingHipRotations1", "kneelingHipRotations2", "kneelingHipRotations3", "kneelingHipRotations2", "kneelingHipRotations1"],
                            "explanation": ["kneelingKickBackWEH", "kneelingKickBackWEA", "kneelingKickBackWEF"],
                            "targetArea": ["glute"],
                            "attributes": ["a"]
                    ], ///
                    "legsToSideSquat":
                        [
                            "name": ["legsToSideSquat"],
                            "demonstration": ["legsToSideSquat", "legsToSideSquat1", "legsToSideSquat2", "legsToSideSquat3", "legsToSideSquat4", "legsToSideSquat3", "legsToSideSquat2", "legsToSideSquat1"],
                            "explanation": ["legsToSideSquatEH", "legsToSideSquatEA", "legsToSideSquatEF"],
                            "targetArea": ["glute"],
                            "attributes": [""]
                    ], ///
                    "standingGluteKickback":
                        [
                            "name": ["standingGluteKickback"],
                            "demonstration": ["standingGluteKickback", "standingGluteKickback1", "standingGluteKickback2", "standingGluteKickback3", "standingGluteKickback3", "standingGluteKickback2", "standingGluteKickback1"],
                            "explanation": ["standingGluteKickbackEH", "standingGluteKickbackEA", "standingGluteKickbackEF"],
                            "targetArea": ["glute"],
                            "attributes": ["a"]
                    ], ///
                    // Lower Back
                    "legDrop":
                        [
                            "name": ["legDrop"],
                            "demonstration": ["legDrop", "legDrop1", "legDrop2", "legDrop1", "legDrop", "legDrop1", "legDrop2", "legDrop1"],
                            "explanation": ["legDropEH", "legDropEA", "legDropEF"],
                            "targetArea": ["core"],
                            "attributes": [""]
                    ],
                    "sideLegKick":
                        [
                            "name": ["sideLegKick"],
                            "demonstration": ["sideLegKick", "sideLegKick1", "sideLegKick2", "sideLegKick1", "sideLegKick", "sideLegKick1", "sideLegKick2", "sideLegKick1"],
                            "explanation": ["sideLegKickEH", "sideLegKickEA", "sideLegKickEF"],
                            "targetArea": ["core"],
                            "attributes": [""]
                    ],
                    "scorpionKick":
                        [
                            "name": ["scorpionKick"],
                            "demonstration": ["scorpionKick", "scorpionKick1", "scorpionKick2", "scorpionKick1", "scorpionKick", "scorpionKick1", "scorpionKick2", "scorpionKick1"],
                            "explanation": ["scorpionKickEH", "scorpionKickEA", "scorpionKickEF"],
                            "targetArea": ["core"],
                            "attributes": [""]
                    ],
                    "sideBend":
                        [
                            "name": ["sideBend"],
                            "demonstration": ["sideBend", "sideBend1", "sideBend2", "sideBend1", "sideBend", "sideBend1", "sideBend2", "sideBend1"],
                            "explanation": ["sideBendEH", "sideBendEA", "sideBendEF"],
                            "targetArea": ["core"],
                            "attributes": [""]
                    ],
                    "catCow":
                        [
                            "name": ["catCow"],
                            "demonstration": ["catCowS", "catCowS1", "catCowS2", "catCowS1", "catCowS3", "catCowS1", "catCowS2", "catCowS1"],
                            "explanation": ["catCowEH", "catCowEA", "catCowEF"],
                            "targetArea": ["spine"],
                            "attributes": [""]
                    ],
                    "legsToSideTwist":
                        [
                            "name": ["legsToSideTwist"],
                            "demonstration": ["legsToSideTwist", "legsToSideTwist1", "legsToSideTwist2", "legsToSideTwist3", "legsToSideTwist4", "legsToSideTwist4", "legsToSideTwist3", "legsToSideTwist2", "legsToSideTwist1", "legsToSideTwist1"],
                            "explanation": ["legsToSideTwistEH", "legsToSideTwistEA", "legsToSideTwistEF"],
                            "targetArea": ["core"],
                            "attributes": ["a"]
                    ], ///
                    "plank":
                        [
                            "name": ["plank"],
                            "demonstration": ["plank"],
                            "explanation": ["plankEH", "plankEA", "plankEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    // Upper Back
                    "upperBackRotation":
                        [
                            "name": ["upperBackRotation"],
                            "demonstration": ["upperBackRotation", "upperBackRotation1", "upperBackRotation2", "upperBackRotation1", "upperBackRotation", "upperBackRotation1", "upperBackRotation2", "upperBackRotation1"],
                            "explanation": ["upperBackRotationEH", "upperBackRotationEA", "upperBackRotationEF"],
                            "targetArea": ["backShoulder"],
                            "attributes": ["a"]
                    ], ///
                    "latStretch":
                        [
                            "name": ["latStretch"],
                            "demonstration": ["latStretch"],
                            "explanation": ["latStretchEH", "latStretchEA", "latStretchEF"],
                            "targetArea": ["lat"],
                            "attributes": ["a"]
                    ], ///
                    // Shoulder
                    "wallSlides":
                        [
                            "name": ["wallSlides"],
                            "demonstration": ["wallSlides", "wallSlides1", "wallSlides2", "wallSlides1", "wallSlides", "wallSlides1", "wallSlides2", "wallSlides1"],
                            "explanation": ["wallSlidesEH", "wallSlidesEA", "wallSlidesEF"],
                            "targetArea": ["shoulder"],
                            "attributes": [""]
                    ],
                    "wallReaches":
                        [
                            "name": ["wallReaches"],
                            "demonstration": ["wallReaches", "wallReaches1", "wallReaches2", "wallReaches1", "wallReaches", "wallReaches1", "wallReaches2", "wallReaches1"],
                            "explanation": ["wallReachesEH", "wallReachesEA", "wallReachesEF"],
                            "targetArea": ["shoulder"],
                            "attributes": [""]
                    ],
                    "shoulderRotationW":
                        [
                            "name": ["shoulderRotationW"],
                            "demonstration": ["shoulderRotationW", "shoulderRotationW1", "shoulderRotationW2", "shoulderRotationW1", "shoulderRotationW", "shoulderRotationW1", "shoulderRotationW2", "shoulderRotationW1"],
                            "explanation": ["shoulderRotationWEH", "shoulderRotationWEA", "shoulderRotationWEF"],
                            "targetArea": ["shoulder"],
                            "attributes": ["a"]
                    ],
                    "forearmWallSlides135":
                        [
                            "name": ["forearmWallSlides135"],
                            "demonstration": ["forearmWallSlides135", "forearmWallSlides1351", "forearmWallSlides1352", "forearmWallSlides1351", "forearmWallSlides135", "forearmWallSlides1351", "forearmWallSlides1352", "forearmWallSlides1351"],
                            "explanation": ["forearmWallSlides135EH", "forearmWallSlides135EA", "forearmWallSlides135EF"],
                            "targetArea": ["shoulder"],
                            "attributes": [""]
                    ],
                    "superManShoulder":
                        [
                            "name": ["superManShoulder"],
                            "demonstration": ["superManShoulder", "superManShoulder1", "superManShoulder2", "superManShoulder3", "superManShoulder4", "superManShoulder4", "superManShoulder3", "superManShoulder2", "superManShoulder1", "superManShoulder1"],
                            "explanation": ["superManShoulderEH", "superManShoulderEA", "superManShoulderEF"],
                            "targetArea": ["backShoulder"],
                            "attributes": [""]
                    ],
                    // Band/Bar/Machine Assisted
                    "facePull":
                        [
                            "name": ["facePull"],
                            "demonstration": ["facePull", "facePull1", "facePull2", "facePull3", "facePull4", "facePull5", "facePull5", "facePull4", "facePull3", "facePull2", "facePull1"],
                            "explanation": ["facePullEH", "facePullEA", "facePullEF"],
                            "targetArea": ["upperBackShoulder"],
                            "attributes": [""]
                    ],
                    "externalRotation":
                        [
                            "name": ["externalRotation"],
                            "demonstration": ["externalRotation", "externalRotation1", "externalRotation2", "externalRotation3", "externalRotation4", "externalRotation4", "externalRotation3", "externalRotation2", "externalRotation1"],
                            "explanation": ["externalRotationEH", "externalRotationEA", "externalRotationEF"],
                            "targetArea": ["shoulderJoint"],
                            "attributes": ["a"]
                    ],
                    "internalRotation":
                        [
                            "name": ["internalRotation"],
                            "demonstration": ["internalRotation", "internalRotation1", "internalRotation2", "internalRotation3", "internalRotation4", "internalRotation4", "internalRotation3", "internalRotation2", "internalRotation1"],
                            "explanation": ["internalRotationEH", "internalRotationEA", "internalRotationEF"],
                            "targetArea": ["shoulderJoint"],
                            "attributes": ["a"]
                    ],
                    "shoulderDislocation":
                        [
                            "name": ["shoulderDislocation"],
                            "demonstration": ["shoulderDislocation", "shoulderDislocation1", "shoulderDislocation2", "shoulderDislocation1", "shoulderDislocation", "shoulderDislocation3", "shoulderDislocation", "shoulderDislocation1", "shoulderDislocation2", "shoulderDislocation1", "shoulderDislocation", "shoulderDislocation3"],
                            "explanation": ["shoulderDislocationEH", "shoulderDislocationEA", "shoulderDislocationEF"],
                            "targetArea": ["shoulder"],
                            "attributes": [""]
                    ],
                    "latPullover":
                        [
                            "name": ["latPullover"],
                            "demonstration": ["latPullover", "latPullover1", "latPullover2", "latPullover3", "latPullover2", "latPullover1"],
                            "explanation": ["latPulloverEH", "latPulloverEA", "latPulloverEF"],
                            "targetArea": ["back"],
                            "attributes": [""]
                    ],
                    // General Mobility
                    "seatedKneeDrop":
                        [
                            "name": ["seatedKneeDrop"],
                            "demonstration": ["seatedKneeDrop", "seatedKneeDrop1", "seatedKneeDrop2", "seatedKneeDrop3", "seatedKneeDrop4", "seatedKneeDrop3", "seatedKneeDrop2", "seatedKneeDrop1"],
                            "explanation": ["seatedKneeDropEH", "seatedKneeDropEA", "seatedKneeDropEF"],
                            "targetArea": ["hip"],
                            "attributes": ["a"]
                    ], ///
                    "mountainClimber":
                        [
                            "name": ["mountainClimbers"],
                            "demonstration": ["mountainClimber", "mountainClimber3", "mountainClimber2", "mountainClimber1", "mountainClimber2", "mountainClimber3", "mountainClimber4", "mountainClimber5", "mountainClimber4", "mountainClimber3"],
                            "explanation": ["mountainClimbersEH", "mountainClimbersEA", "mountainClimbersEF"],
                            "targetArea": ["core"],
                            "attributes": [""]
                    ],
                    "groinStretch":
                        [
                            "name": ["groinStretch"],
                            "demonstration": ["groinStretch"],
                            "explanation": ["groinStretchEH", "groinStretchEA", "groinStretchEF"],
                            "targetArea": ["adductor"],
                            "attributes": [""]
                    ],
                    "threadTheNeedle":
                        [
                            "name": ["threadTheNeedle"],
                            "demonstration": ["threadTheNeedleS"],
                            "explanation": ["threadTheNeedleEH", "threadTheNeedleEA", "threadTheNeedleEF"],
                            "targetArea": ["glute"],
                            "attributes": ["a"]
                    ],
                    "butterflyPose":
                        [
                            "name": ["butterflyPose"],
                            "demonstration": ["butterflyPoseS"],
                            "explanation": ["butterflyPoseEH", "butterflyPoseEA", "butterflyPoseEF"],
                            "targetArea": ["adductor"],
                            "attributes": [""]
                    ],
                    "cossakSquat":
                        [
                            "name": ["cossakSquat"],
                            "demonstration": ["cossakSquat", "cossakSquat4", "cossakSquat1", "cossakSquat2", "cossakSquat3", "cossakSquat2", "cossakSquat1", "cossakSquat4", "cossakSquat5", "cossakSquat6", "cossakSquat7", "cossakSquat6", "cossakSquat5", "cossakSquat4"],
                            "explanation": ["cossakSquatEH", "cossakSquatEA", "cossakSquatEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    "hipHinges":
                        [
                            "name": ["hipHinges"],
                            "demonstration": ["hipHinges", "hipHinges1", "hipHinges2", "hipHinges3", "hipHinges4", "hipHinges4", "hipHinges3", "hipHinges2", "hipHinges1", "hipHinges1"],
                            "explanation": ["hipHingesEH", "hipHingesEA", "hipHingesEF"],
                            "targetArea": ["hamstringLowerBack"],
                            "attributes": [""]
                    ],
                    "lungeTwist":
                        [
                            "name": ["lungeTwist"],
                            "demonstration": ["lungeTwist", "lungeTwist1", "lungeTwist2", "lungeTwist3", "lungeTwist4", "lungeTwist5", "lungeTwist6", "lungeTwist5", "lungeTwist4", "lungeTwist7", "lungeTwist8", "lungeTwist9", "lungeTwist10", "lungeTwist11", "lungeTwist12", "lungeTwist13", "lungeTwist12", "lungeTwist11", "lungeTwist14", "lungeTwist15"],
                            "explanation": ["lungeTwistEH", "lungeTwistEA", "lungeTwistEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    "sideLegSwings":
                        [
                            "name": ["sideLegSwings"],
                            "demonstration": ["sideLegSwings", "sideLegSwings1", "sideLegSwings2", "sideLegSwings3", "sideLegSwings4", "sideLegSwings3", "sideLegSwings2", "sideLegSwings1", "sideLegSwings5", "sideLegSwings1", "sideLegSwings2", "sideLegSwings3", "sideLegSwings4"],
                            "explanation": ["sideLegSwingsEH", "sideLegSwingsEA", "sideLegSwingsEF"],
                            "targetArea": ["quadHamstringGluteStretch"],
                            "attributes": ["a"]
                    ],
                    "frontLegSwings":
                        [
                            "name": ["frontLegSwings"],
                            "demonstration": ["frontLegSwings", "frontLegSwings1", "frontLegSwings2", "frontLegSwings3", "frontLegSwings4", "frontLegSwings3", "frontLegSwings2", "frontLegSwings1", "frontLegSwings5", "frontLegSwings1", "frontLegSwings2", "frontLegSwings3", "frontLegSwings4"],
                            "explanation": ["frontLegSwingsEH", "frontLegSwingsEA", "frontLegSwingsEF"],
                            "targetArea": ["quadHamstringGluteStretch"],
                            "attributes": ["a"]
                    ],
                    "hipLiftOverheadReach":
                        [
                            "name": ["hipLiftOverheadReach"],
                            "demonstration": ["spiderManOverheadReach", "spiderManOverheadReach1", "spiderManOverheadReach2", "spiderManOverheadReach3", "spiderManOverheadReach4", "spiderManOverheadReach5", "spiderManOverheadReach4", "spiderManOverheadReach3", "spiderManOverheadReach6", "spiderManOverheadReach7", "spiderManOverheadReach6", "spiderManOverheadReach3", "spiderManOverheadReach2", "spiderManOverheadReach1"],
                            "explanation": ["hipLiftOverheadReachEH", "hipLiftOverheadReachEA", "hipLiftOverheadReachEF"],
                            "targetArea": ["quadHamstringGluteStretch"],
                            "attributes": [""]
                    ],
                    // Dynamic Warmup Drills
                    "forefootBounces":
                        [
                            "name": ["forefootBounces"],
                            "demonstration": ["forefootBounces", "forefootBounces1", "forefootBounces2", "forefootBounces3", "forefootBounces2", "forefootBounces1", "forefootBounces1", "forefootBounces3", "forefootBounces2", "forefootBounces1"],
                            "explanation": ["forefootBouncesEH", "forefootBouncesEA", "forefootBouncesEF"],
                            "targetArea": ["calf"],
                            "attributes": [""]
                    ],
                    "jumpSquat":
                        [
                            "name": ["jumpSquat"],
                            "demonstration": ["jumpSquat", "jumpSquat1", "jumpSquat2", "jumpSquat3", "jumpSquat4", "jumpSquat5", "jumpSquat4", "jumpSquat3", "jumpSquat2", "jumpSquat1"],
                            "explanation": ["jumpSquatEH", "jumpSquatEA", "jumpSquatEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    "lunge":
                        [
                            "name": ["lunge"],
                            "demonstration": ["lunge", "lunge1", "lunge2", "lunge3", "lunge4", "lunge3", "lunge2", "lunge1", "lunge5", "lunge6", "lunge7", "lunge6", "lunge5", "lunge1"],
                            "explanation": ["lungeEH", "lungeEA", "lungeEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    "gluteKicks":
                        [
                            "name": ["gluteKicks"],
                            "demonstration": ["bumKicks", "bumKicks1", "bumKicks2", "bumKicks3", "bumKicks4", "bumKicks3", "bumKicks2", "bumKicks1"],
                            "explanation": ["gluteKicksEH", "gluteKicksEA", "gluteKicksEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    "aSkips":
                        [
                            "name": ["aSkips"],
                            "demonstration": ["aSkips", "aSkips1", "aSkips2", "aSkips3", "aSkips2", "aSkips1", "aSkips4", "aSkips5", "aSkips4", "aSkips1"],
                            "explanation": ["aSkipsEH", "aSkipsEA", "aSkipsEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    "bSkips":
                        [
                            "name": ["bSkips"],
                            "demonstration": ["bSkips", "bSkips1", "bSkips2", "bSkips3", "bSkips4", "bSkips5", "bSkips6", "bSkips7", "bSkips8", "bSkips9", "bSkips10", "bSkips11"],
                            "explanation": ["bSkipsEH", "bSkipsEA", "bSkipsEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    "grapeVines":
                        [
                            "name": ["grapeVines"],
                            "demonstration": ["grapeVines"],
                            "explanation": ["grapeVinesEH", "grapeVinesEA", "grapeVinesEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    "lateralBound":
                        [
                            "name": ["lateralBound"],
                            "demonstration": ["lateralBound", "lateralBound1", "lateralBound2", "lateralBound3", "lateralBound4", "lateralBound5", "lateralBound", "lateralBound6", "lateralBound7", "lateralBound8", "lateralBound9"],
                            "explanation": ["lateralBoundEH", "lateralBoundEA", "lateralBoundEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    "straightLegBound":
                        [
                            "name": ["straightLegBound"],
                            "demonstration": ["straightLegBound", "straightLegBound1", "straightLegBound2", "straightLegBound3", "straightLegBound4", "straightLegBound", "straightLegBound5", "straightLegBound6", "straightLegBound7", "straightLegBound8"],
                            "explanation": ["straightLegBoundEH", "straightLegBoundEA", "straightLegBoundEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    "sprints":
                        [
                            "name": ["sprints"],
                            "demonstration": ["sprints"],
                            "explanation": ["sprintsEH", "sprintsEA", "sprintsEF"],
                            "targetArea": ["squatBody"],
                            "attributes": [""]
                    ],
                    // Accessory
                    "pushUp":
                        [
                            "name": ["pushUp"],
                            "demonstration": ["pushUp", "pushUp1", "pushUp2", "pushUp3", "pushUp4", "pushUp4", "pushUp3", "pushUp2", "pushUp1"],
                            "explanation": ["pushUpEH", "pushUpEA", "pushUpEF"],
                            "targetArea": ["chestFrontDeltTricep"],
                            "attributes": [""]
                    ],
                    "pullUp":
                        [
                            "name": ["pullUp"],
                            "demonstration": ["pullUp", "pullUp1", "pullUp2", "pullUp3", "pullUp4", "pullUp4", "pullUp3", "pullUp2", "pullUp1"],
                            "explanation": ["pullUpEH", "pullUpEA", "pullUpEF"],
                            "targetArea": ["backBicep"],
                            "attributes": [""]
                    ]
            ],
            // MARK: Workout
            "workout": [
                // Gym ------------------------------------
                // Legs (Quads) ---------
                "squat":
                    [
                        "name": ["squat"],
                        "demonstration": ["squat", "squat1", "squat2", "squat3", "squat2", "squat1"],
                        "explanation": ["squatEH", "squatEA", "squatEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["w"]
                ],
                "frontSquat":
                    [
                        "name": ["frontSquat"],
                        "demonstration": ["frontSquat", "frontSquat1", "frontSquat2", "frontSquat3", "frontSquat2", "frontSquat1"],
                        "explanation": ["frontSquatEH", "frontSquatEA", "frontSquatEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["w"]
                ],
                "legPress":
                    [
                        "name": ["legPress"],
                        "demonstration": ["legPress", "legPress4", "legPress3", "legPress2", "legPress1", "legPress2", "legPress3", "legPress4"],
                        "explanation": ["legPressEH", "legPressEA", "legPressEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["w"]
                ],
                "dumbellFrontSquat":
                    [
                        "name": ["dumbellFrontSquat"],
                        "demonstration": ["dumbellFrontSquat", "dumbellFrontSquat1", "dumbellFrontSquat", "dumbellFrontSquat1"],
                        "explanation": ["dumbellFrontSquatEH", "dumbellFrontSquatEA", "dumbellFrontSquatEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["w"]
                ],
                "legExtensions":
                    [
                        "name": ["legExtensions"],
                        "demonstration": ["legExtensions", "legExtensions1", "legExtensions2", "legExtensions3", "legExtensions2", "legExtensions1"],
                        "explanation": ["legExtensionsEH", "legExtensionsEA","legExtensionsEF"],
                        "targetArea": ["quad"],
                        "attributes": ["w"]
                ],
                // Legs (Hamstrings/Glutes)
                "deadlift":
                    [
                        "name": ["deadlift"],
                        "demonstration": ["deadlift", "deadlift1", "deadlift2", "deadlift3", "deadlift4", "deadlift5", "deadlift6", "deadlift7", "deadlift4", "deadlift2"],
                        "explanation": ["deadliftEH", "deadliftEA", "deadliftEF"],
                        "targetArea": ["deadliftBody"],
                        "attributes": ["w"]
                ],
                "romanianDeadlift":
                    [
                        "name": ["romanianDeadlift"],
                        "demonstration": ["romanianDeadlift", "romanianDeadlift1", "romanianDeadlift2", "romanianDeadlift3", "romanianDeadlift2", "romanianDeadlift1"],
                        "explanation": ["romanianDeadliftEH", "romanianDeadliftEA", "romanianDeadliftEF"],
                        "targetArea": ["deadliftBody"],
                        "attributes": ["w"]
                ],
                "weightedHipThrust":
                    [
                        "name": ["weightedHipThrust"],
                        "demonstration": ["weightedHipThrust", "weightedHipThrust1", "weightedHipThrust", "weightedHipThrust1"],
                        "explanation": ["weightedHipThrustEH", "weightedHipThrustEA", "weightedHipThrustEF"],
                        "targetArea": ["deadliftBody"],
                        "attributes": ["w"]
                ],
                "legCurl":
                    [
                        "name": ["legCurl"],
                        "demonstration": ["legCurl", "legCurl1", "legCurl2", "legCurl3", "legCurl2", "legCurl1"],
                        "explanation": ["legCurlEH", "legCurlEA", "legCurlEF"],
                        "targetArea": ["hamstring"],
                        "attributes": ["w"]
                ],
                "oneLeggedDeadlift":
                    [
                        "name": ["oneLeggedDeadlift"],
                        "demonstration": ["oneLeggedDeadlift", "oneLeggedDeadlift1", "oneLeggedDeadlift2", "oneLeggedDeadlift3", "oneLeggedDeadlift4", "oneLeggedDeadlift3", "oneLeggedDeadlift2", "oneLeggedDeadlift1"],
                        "explanation": ["oneLeggedDeadliftEH", "oneLeggedDeadliftEA", "oneLeggedDeadliftEF"],
                        "targetArea": ["deadliftBody"],
                        "attributes": ["aw"]
                ],
                // Legs (General)
                "lungeDumbell":
                    [
                        "name": ["lungeDumbell"],
                        "demonstration": ["lungeDumbell", "lungeDumbell1", "lungeDumbell2", "lungeDumbell3", "lungeDumbell4", "lungeDumbell5", "lungeDumbell6", "lungeDumbell7", "lungeDumbell1", "lungeDumbell8", "lungeDumbell9", "lungeDumbell10", "lungeDumbell11", "lungeDumbell12", "lungeDumbell13", "lungeDumbell1"],
                        "explanation": ["lungeDumbellEH", "lungeDumbellEA", "lungeDumbellEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["w"]
                ],
                "bulgarianSplitSquat":
                    [
                        "name": ["bulgarianSplitSquat"],
                        "demonstration": ["bulgarianSplitSquat", "bulgarianSplitSquat1", "bulgarianSplitSquat", "bulgarianSplitSquat1"],
                        "explanation": ["bulgarianSplitSquatEH", "bulgarianSplitSquatEA", "bulgarianSplitSquatEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["aw"]
                ],
                "weightedStepUp":
                    [
                        "name": ["weightedStepUp"],
                        "demonstration": ["stepUp", "stepUp1", "stepUp2", "stepUp3", "stepUp2", "stepUp1"],
                        "explanation": ["weightedStepUpEH", "weightedStepUpEA", "weightedStepUpEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["aw"]
                ],
                // Legs (calves)
                "standingCalfRaise":
                    [
                        "name": ["standingCalfRaise"],
                        "demonstration": ["standingCalfRaise", "standingCalfRaise1", "standingCalfRaise", "standingCalfRaise1"],
                        "explanation": ["standingCalfRaiseEH", "standingCalfRaiseEA", "standingCalfRaiseEF"],
                        "targetArea": ["calf"],
                        "attributes": ["w"]
                ],
                "seatedCalfRaise":
                    [
                        "name": ["seatedCalfRaise"],
                        "demonstration": ["seatedCalfRaise", "seatedCalfRaise1", "seatedCalfRaise", "seatedCalfRaise1"],
                        "explanation": ["seatedCalfRaiseEH", "seatedCalfRaiseEA", "seatedCalfRaiseEF"],
                        "targetArea": ["calf"],
                        "attributes": ["aw"]
                ],
                // Pull (Back) ---------
                "pullDown":
                    [
                        "name": ["pullDown"],
                        "demonstration": ["pullDown", "pullDown1", "pullDown2", "pullDown3", "pullDown4", "pullDown5", "pullDown5", "pullDown4", "pullDown3", "pullDown2", "pullDown1"],
                        "explanation": ["pullDownEH", "pullDownEA", "pullDownEF"],
                        "targetArea": ["backBicep"],
                        "attributes": ["w"]
                ],
                "kneelingPullDown":
                    [
                        "name": ["kneelingPullDown"],
                        "demonstration": ["kneelingPullDown", "kneelingPullDown1", "kneelingPullDown2", "kneelingPullDown3", "kneelingPullDown4", "kneelingPullDown4", "kneelingPullDown3", "kneelingPullDown2", "kneelingPullDown1"],
                        "explanation": ["kneelingPullDownEH", "kneelingPullDownEA", "kneelingPullDownEF"],
                        "targetArea": ["backBicep"],
                        "attributes": ["w"]
                ],
                "bentOverRowDumbell":
                    [
                        "name": ["bentOverRowDumbell"],
                        "demonstration": ["bentOverRowDumbell", "bentOverRowDumbell1", "bentOverRowDumbell2", "bentOverRowDumbell3", "bentOverRowDumbell4", "bentOverRowDumbell5", "bentOverRowDumbell5", "bentOverRowDumbell4", "bentOverRowDumbell3", "bentOverRowDumbell2"],
                        "explanation": ["bentOverRowDumbellEH", "bentOverRowDumbellEA", "bentOverRowDumbellEF"],
                        "targetArea": ["backBicepErector"],
                        "attributes": ["w"]
                ],
                "tBarRow":
                    [
                        "name": ["tBarRow"],
                        "demonstration": ["tBarRow", "tBarRow1", "tBarRow2", "tBarRow3", "tBarRow4", "tBarRow4", "tBarRow3", "tBarRow2", "tBarRow1"],
                        "explanation": ["tBarRowEH", "tBarRowEA", "tBarRowEF"],
                        "targetArea": ["backBicepErector"],
                        "attributes": ["w"]
                ],
                "rowMachine":
                    [
                        "name": ["rowMachine"],
                        "demonstration": ["rowMachine", "rowMachine1", "rowMachine2", "rowMachine3", "rowMachine4", "rowMachine4", "rowMachine3", "rowMachine2", "rowMachine1"],
                        "explanation": ["rowMachineEH", "rowMachineEA", "rowMachineEF"],
                        "targetArea": ["backBicep"],
                        "attributes": ["w"]
                ],
                "latPullover":
                    [
                        "name": ["latPullover"],
                        "demonstration": ["latPullover", "latPullover1", "latPullover2", "latPullover3", "latPullover2", "latPullover1"],
                        "explanation": ["latPulloverEH", "latPulloverEA", "latPulloverEF"],
                        "targetArea": ["backBicep"],
                        "attributes": ["w"]
                ],
                // Pull (Upper Back)
                "facePull":
                    [
                        "name": ["facePull"],
                        "demonstration": ["facePull", "facePull1", "facePull2", "facePull3", "facePull4", "facePull5", "facePull5", "facePull4", "facePull3", "facePull2", "facePull1"],
                        "explanation": ["facePullEH", "facePullEA", "facePullEF"],
                        "targetArea": ["upperBackShoulder"],
                        "attributes": ["w"]
                ],
                "leaningBackPullDown":
                    [
                        "name": ["leaningBackPullDown"],
                        "demonstration": ["leaningBackPullDown", "leaningBackPullDown1", "leaningBackPullDown2", "leaningBackPullDown3", "leaningBackPullDown4", "leaningBackPullDown4", "leaningBackPullDown3", "leaningBackPullDown2", "leaningBackPullDown1"],
                        "explanation": ["leaningBackPullDownEH", "leaningBackPullDownEA", "leaningBackPullDownEF"],
                        "targetArea": ["upperBackShoulder"],
                        "attributes": ["w"]
                ],
                // Pull (Rear Delts)
                "bentOverBarbellRow":
                    [
                        "name": ["bentOverBarbellRow"],
                        "demonstration": ["bentOverBarbellRow", "bentOverBarbellRow1", "bentOverBarbellRow", "bentOverBarbellRow1"],
                        "explanation": ["bentOverBarbellRowEH", "bentOverBarbellRowEA", "bentOverBarbellRowEF"],
                        "targetArea": ["rearDelt"],
                        "attributes": ["w"]
                ],
                // Pull (Traps)
                "shrugDumbell":
                    [
                        "name": ["shrugDumbell"],
                        "demonstration": ["shrugDumbell", "shrugDumbell1", "shrugDumbell", "shrugDumbell1"],
                        "explanation": ["shrugDumbellEH", "shrugDumbellEA", "shrugDumbellEF"],
                        "targetArea": ["trap"],
                        "attributes": ["w"]
                ],
                // Pull (Biceps)
                "hammerCurl":
                    [
                        "name": ["hammerCurl"],
                        "demonstration": ["hammerCurl", "hammerCurl1", "hammerCurl2", "hammerCurl3", "hammerCurl3", "hammerCurl2", "hammerCurl1", "hammerCurl4", "hammerCurl5", "hammerCurl5", "hammerCurl4", "hammerCurl1"],
                        "explanation": ["hammerCurlEH", "hammerCurlEA", "hammerCurlEF"],
                        "targetArea": ["bicep"],
                        "attributes": ["w"]
                ],
                "hammerCurlCable":
                    [
                        "name": ["hammerCurlCable"],
                        "demonstration": ["hammerCurlCable", "hammerCurlCable1", "hammerCurlCable2", "hammerCurlCable3", "hammerCurlCable3", "hammerCurlCable2", "hammerCurlCable1"],
                        "explanation": ["hammerCurlCableEH", "hammerCurlCableEA", "hammerCurlCableEF"],
                        "targetArea": ["bicep"],
                        "attributes": ["aw"]
                ],
                "curl":
                    [
                        "name": ["curl"],
                        "demonstration": ["curl", "curl1", "curl2", "curl3", "curl3", "curl2", "curl1", "curl4", "curl5", "curl5", "curl4", "curl1"],
                        "explanation": ["curlEH", "curlEA", "curlEF"],
                        "targetArea": ["bicep"],
                        "attributes": ["w"]
                ],
                // Pull (Forearms)
                "farmersCarry":
                    [
                        "name": ["farmersCarry"],
                        "demonstration": ["farmersCarry"],
                        "explanation": ["farmersCarryEH", "farmersCarryEA", "farmersCarryEF"],
                        "targetArea": ["forearm"],
                        "attributes": ["w"]
                ],
                "reverseBarbellCurl":
                    [
                        "name": ["reverseBarbellCurl"],
                        "demonstration": ["reverseBarbellCurl", "reverseBarbellCurl1", "reverseBarbellCurl", "reverseBarbellCurl1"],
                        "explanation": ["reverseBarbellCurlEH", "reverseBarbellCurlEA", "reverseBarbellCurlEF"],
                        "targetArea": ["forearm"],
                        "attributes": ["w"]
                ],
                "forearmCurl":
                    [
                        "name": ["forearmCurl"],
                        "demonstration": ["forearmCurl", "forearmCurl1", "forearmCurl2", "forearmCurl1", "forearmCurl", "forearmCurl", "forearmCurl1", "forearmCurl2", "forearmCurl1"],
                        "explanation": ["forearmCurlEH", "forearmCurlEA", "forearmCurlEF"],
                        "targetArea": ["forearm"],
                        "attributes": ["w"]
                ],
                // Push (Chest) ---------
                "benchPress":
                    [
                        "name": ["benchPress"],
                        "demonstration": ["benchPress", "benchPress1", "benchPress2", "benchPress3", "benchPress4", "benchPress5", "benchPress5", "benchPress4", "benchPress3", "benchPress2"],
                        "explanation": ["benchPressEH", "benchPressEA", "benchPressEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": ["w"]
                ],
                "benchPressDumbell":
                    [
                        "name": ["benchPressDumbell"],
                        "demonstration": ["benchPressDumbell", "benchPressDumbell4", "benchPressDumbell3", "benchPressDumbell2", "benchPressDumbell1", "benchPressDumbell1", "benchPressDumbell2", "benchPressDumbell3", "benchPressDumbell4"],
                        "explanation": ["benchPressDumbellEH", "benchPressDumbellEA", "benchPressDumbellEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": ["w"]
                ],
                "semiInclineDumbellPress":
                    [
                        "name": ["semiInclineDumbellPress"],
                        "demonstration": ["semiInclineDumbellPress", "semiInclineDumbellPress4", "semiInclineDumbellPress3", "semiInclineDumbellPress2", "semiInclineDumbellPress1", "semiInclineDumbellPress1", "semiInclineDumbellPress2", "semiInclineDumbellPress3", "semiInclineDumbellPress4"],
                        "explanation": ["benchPressDumbellEH", "benchPressDumbellEA", "benchPressDumbellEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": ["w"]
                ],
                "platePress":
                    [
                        "name": ["platePress"],
                        "demonstration": ["platePress", "platePress1", "platePress", "platePress1"],
                        "explanation": ["platePressEH", "platePressEA", "platePressEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": ["w"]
                ],
                "barbellKneelingPress":
                    [
                        "name": ["barbellKneelingPress"],
                        "demonstration": ["barbellKneelingPress", "barbellKneelingPress1", "barbellKneelingPress", "barbellKneelingPress1"],
                        "explanation": ["barbellKneelingPressEH", "barbellKneelingPressEA", "barbellKneelingPressEF"],
                        "targetArea": ["pecFrontDelt"],
                        "attributes": ["w"]
                ],
                "dips":
                    [
                        "name": ["dips"],
                        "demonstration": ["dips", "dips1", "dips", "dips1"],
                        "explanation": ["dipsEH", "dipsEA", "dipsEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": [""]
                ],
                // Push (Shoulders)
                "standingShoulderPressBarbell":
                    [
                        "name": ["standingShoulderPressBarbell"],
                        "demonstration": ["standingShoulderPressBarbell", "standingShoulderPressBarbell1", "standingShoulderPressBarbell2", "standingShoulderPressBarbell2", "standingShoulderPressBarbell1"],
                        "explanation": ["standingShoulderPressBarbellEH", "standingShoulderPressBarbellEA", "standingShoulderPressBarbellEF"],
                        "targetArea": ["shoulder"],
                        "attributes": ["w"]
                ],
                "standingShoulderPressDumbell":
                    [
                        "name": ["standingShoulderPressDumbell"],
                        "demonstration": ["standingShoulderPressDumbell", "standingShoulderPressDumbell1", "standingShoulderPressDumbell2", "standingShoulderPressDumbell2", "standingShoulderPressDumbell1"],
                        "explanation": ["standingShoulderPressDumbellEH", "standingShoulderPressDumbellEA", "standingShoulderPressDumbellEF"],
                        "targetArea": ["shoulder"],
                        "attributes": ["w"]
                ],
                "lateralRaise":
                    [
                        "name": ["lateralRaise"],
                        "demonstration": ["lateralRaise", "lateralRaise1", "lateralRaise2", "lateralRaise3", "lateralRaise4", "lateralRaise4", "lateralRaise3", "lateralRaise2", "lateralRaise1"],
                        "explanation": ["lateralRaiseEH", "lateralRaiseEA", "lateralRaiseEF"],
                        "targetArea": ["shoulder"],
                        "attributes": ["w"]
                ],
                "frontRaise":
                    [
                        "name": ["frontRaise"],
                        "demonstration": ["frontRaise", "frontRaise1", "frontRaise2", "frontRaise3", "frontRaise4", "frontRaise4", "frontRaise3", "frontRaise2", "frontRaise1"],
                        "explanation": ["frontRaiseEH", "frontRaiseEA","frontRaiseEF"],
                        "targetArea": ["shoulder"],
                        "attributes": ["w"]
                ],
                // Push (Triceps)
                "closeGripBench":
                    [
                        "name": ["closeGripBench"],
                        "demonstration": ["closeGripBench", "closeGripBench1", "closeGripBench2", "closeGripBench3", "closeGripBench4", "closeGripBench5", "closeGripBench5", "closeGripBench4", "closeGripBench3", "closeGripBench2"],
                        "explanation": ["closeGripBenchEH", "closeGripBenchEA", "closeGripBenchEF"],
                        "targetArea": ["tricep"],
                        "attributes": ["w"]
                ],
                "cableExtension":
                    [
                        "name": ["cableExtension"],
                        "demonstration": ["cableExtension", "cableExtension1", "cableExtension2", "cableExtension3", "cableExtension3", "cableExtension2", "cableExtension1"],
                        "explanation": ["cableExtensionEH", "cableExtensionEA", "cableExtensionEF"],
                        "targetArea": ["tricep"],
                        "attributes": ["aw"]
                ],
                "ropeExtension":
                    [
                        "name": ["ropeExtension"],
                        "demonstration": ["ropeExtensions", "ropeExtensions1", "ropeExtensions2", "ropeExtensions3", "ropeExtensions3", "ropeExtensions2", "ropeExtensions1"],
                        "explanation": ["ropeExtensionEH", "ropeExtensionEA", "ropeExtensionEF"],
                        "targetArea": ["tricep"],
                        "attributes": ["w"]
                ],
                // Full Body
                "cleanPress":
                    [
                        "name": ["cleanPress"],
                        "demonstration": ["cleanPress", "cleanPress1", "cleanPress2", "cleanPress3", "cleanPress4", "cleanPress5", "cleanPress6", "cleanPress5", "cleanPress4", "cleanPress3", "cleanPress2", "cleanPress1"],
                        "explanation": ["cleanPressEH", "cleanPressEA", "cleanPressEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["w"]
                ],
                // BodyWeight ------------------------------------
                // Legs (General) ---------
                "bodyweightSquat":
                    [
                        "name": ["bodyweightSquat"],
                        "demonstration": ["bodyweightSquat", "bodyweightSquat1", "bodyweightSquat2", "bodyweightSquat3", "bodyweightSquat4", "bodyweightSquat5", "bodyweightSquat5", "bodyweightSquat4", "bodyweightSquat3", "bodyweightSquat2", "bodyweightSquat3", "bodyweightSquat4", "bodyweightSquat5", "bodyweightSquat5", "bodyweightSquat4", "bodyweightSquat3", "bodyweightSquat2",],
                        "explanation": ["bodyweightSquatEH", "bodyweightSquatEA", "bodyweightSquatEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "pistolSquat":
                    [
                        "name": ["pistolSquat"],
                        "demonstration": ["pistolSquat", "pistolSquat1", "pistolSquat2", "pistolSquat3", "pistolSquat4", "pistolSquat5", "pistolSquat5", "pistolSquat4", "pistolSquat3", "pistolSquat2", "pistolSquat1"],
                        "explanation": ["pistolSquatEH", "pistolSquatEA", "pistolSquatEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["a"]
                ],
                "skaterSquat":
                    [
                        "name": ["skaterSquat"],
                        "demonstration": ["skaterSquat", "skaterSquat1", "skaterSquat2", "skaterSquat3", "skaterSquat4", "skaterSquat4", "skaterSquat3", "skaterSquat2", "skaterSquat1"],
                        "explanation": ["skaterSquatEH", "skaterSquatEA", "skaterSquatEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["a"]
                ],
                "jumpSquat":
                    [
                        "name": ["jumpSquat"],
                        "demonstration": ["jumpSquat", "jumpSquat1", "jumpSquat2", "jumpSquat3", "jumpSquat4", "jumpSquat5", "jumpSquat4", "jumpSquat3", "jumpSquat2", "jumpSquat1"],
                        "explanation": ["jumpSquatEH", "jumpSquatEA", "jumpSquatEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "lunge":
                    [
                        "name": ["lunge"],
                        "demonstration": ["lunge", "lunge1", "lunge2", "lunge3", "lunge4", "lunge3", "lunge2", "lunge1", "lunge5", "lunge6", "lunge7", "lunge6", "lunge5", "lunge1"],
                        "explanation": ["lungeEH", "lungeEA", "lungeEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "lungeJump":
                    [
                        "name": ["lungeJump"],
                        "demonstration": ["lungeJump", "lungeJump1", "lungeJump2", "lungeJump3", "lungeJump4", "lungeJump5", "lungeJump6", "lungeJump7", "lungeJump6", "lungeJump5", "lungeJump4", "lungeJump3", "lungeJump2", "lungeJump1"],
                        "explanation": ["lungeJumpEH", "lungeJumpEA", "lungeJumpEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                // Legs (Hamstrings)
                "bodyweightDeadlift":
                    [
                        "name": ["deadlift"],
                        "demonstration": ["bodyweightDeadlift", "bodyweightDeadlift1", "bodyweightDeadlift2", "bodyweightDeadlift3", "bodyweightDeadlift4", "bodyweightDeadlift3", "bodyweightDeadlift2", "bodyweightDeadlift1", "bodyweightDeadlift1"],
                        "explanation": ["deadliftEH", "deadliftEA", "deadliftEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "singleLegDeadlift":
                    [
                        "name": ["singleLegDeadlift"],
                        "demonstration": ["singleLegDeadlift", "singleLegDeadlift1", "singleLegDeadlift2", "singleLegDeadlift3", "singleLegDeadlift4", "singleLegDeadlift3", "singleLegDeadlift2", "singleLegDeadlift1"],
                        "explanation": ["singleLegDeadliftEH", "singleLegDeadliftEA", "singleLegDeadliftEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["a"]
                ],
                // Legs (Glutes)
                "gluteBridge":
                    [
                        "name": ["gluteBridge"],
                        "demonstration": ["gluteBridge", "gluteBridge1", "gluteBridge2", "gluteBridge3", "gluteBridge3", "gluteBridge2", "gluteBridge1", "gluteBridge2", "gluteBridge3", "gluteBridge3", "gluteBridge2", "gluteBridge1"],
                        "explanation": ["gluteBridgeEH", "gluteBridgeEA", "gluteBridgeEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "singleLegGluteBridge":
                    [
                        "name": ["singleLegGluteBridge"],
                        "demonstration": ["singleLegGluteBridge", "singleLegGluteBridge1", "singleLegGluteBridge2", "singleLegGluteBridge3", "singleLegGluteBridge3", "singleLegGluteBridge2", "singleLegGluteBridge1"],
                        "explanation": ["singleLegGluteBridgeEH", "singleLegGluteBridgeEA", "singleLegGluteBridgeEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["a"]
                ],
                "kickBack":
                    [
                        "name": ["kickBack"],
                        "demonstration": ["kneelingHipRotations", "kneelingHipRotations8", "kneelingHipRotations9", "kneelingHipRotations10", "kneelingHipRotations10", "kneelingHipRotations9", "kneelingHipRotations8"],
                        "explanation": ["kickBackEH", "kickBackEA", "kickBackEF"],
                        "targetArea": ["glute"],
                        "attributes": ["a"]
                ],
                "standingKickBack":
                    [
                        "name": ["standingKickBack"],
                        "demonstration": ["standingGluteKickback", "standingGluteKickback1", "standingGluteKickback2", "standingGluteKickback3", "standingGluteKickback3", "standingGluteKickback2", "standingGluteKickback1"],
                        "explanation": ["standingKickBackEH", "standingKickBackEA", "standingKickBackEF"],
                        "targetArea": ["glute"],
                        "attributes": ["a"]
                ],
                // Legs (calves)
                "calfRaise":
                    [
                        "name": ["calfRaise"],
                        "demonstration": ["calfRaise", "calfRaise1", "calfRaise", "calfRaise1"],
                        "explanation": ["calfRaiseEH", "calfRaiseEA", "calfRaiseEF"],
                        "targetArea": ["calf"],
                        "attributes": ["a"]
                ],
                // Pull (Back) ---------
                "contralateralLimbRaises":
                    [
                        "name": ["contralateralLimbRaises"],
                        "demonstration": ["contralateralLimbRaises", "contralateralLimbRaises1", "contralateralLimbRaises2", "contralateralLimbRaises3", "contralateralLimbRaises3", "contralateralLimbRaises2", "contralateralLimbRaises1", "contralateralLimbRaises4", "contralateralLimbRaises5", "contralateralLimbRaises5", "contralateralLimbRaises4", "contralateralLimbRaises1"],
                        "explanation": ["contralateralLimbRaisesEH", "contralateralLimbRaisesEA", "contralateralLimbRaisesEF"],
                        "targetArea": ["backGlute"],
                        "attributes": [""]
                ],
                "superMan":
                    [
                        "name": ["superMan"],
                        "demonstration": ["superMan"],
                        "explanation": ["superManEH", "superManEA", "superManEF"],
                        "targetArea": ["backGlute"],
                        "attributes": [""]
                ],
                "backHyperextension":
                    [
                        "name": ["backHyperextension"],
                        "demonstration": ["backHyperextension", "backHyperextension1", "backHyperextension2", "backHyperextension3", "backHyperextension4", "backHyperextension4", "backHyperextension3", "backHyperextension2", "backHyperextension1"],
                        "explanation": ["backHyperextensionEH", "backHyperextensionEA", "backHyperextensionEF"],
                        "targetArea": ["backGlute"],
                        "attributes": [""]
                ],
                "doorFrameRow":
                    [
                        "name": ["doorFrameRow"],
                        "demonstration": ["doorFrameRow", "doorFrameRow1", "doorFrameRow2", "doorFrameRow2", "doorFrameRow1"],
                        "explanation": ["doorFrameRowEH", "doorFrameRowEA", "doorFrameRowEF"],
                        "targetArea": ["backBicep"],
                        "attributes": ["a"]
                ],
                "reverseSnowAngels":
                    [
                        "name": ["reverseSnowAngels"],
                        "demonstration": ["reverseSnowAngels", "reverseSnowAngels1", "reverseSnowAngels2", "reverseSnowAngels3", "reverseSnowAngels4", "reverseSnowAngels4", "reverseSnowAngels3", "reverseSnowAngels2", "reverseSnowAngels1"],
                        "explanation": ["reverseSnowAngelsEH", "reverseSnowAngelsEA", "reverseSnowAngelsEF"],
                        "targetArea": ["backGlute"],
                        "attributes": [""]
                ],
                // Pull (Traps)
                "handStandTrap":
                    [
                        "name": ["handStandTrap"],
                        "demonstration": ["handStandTrap", "handStandTrap1", "handStandTrap", "handStandTrap1"],
                        "explanation": ["handStandTrapEH", "handStandTrapEA", "handStandTrapEF"],
                        "targetArea": ["trap"],
                        "attributes": [""]
                ],
                // Push (Chest) ---------
                "pushUp":
                    [
                        "name": ["pushUp"],
                        "demonstration": ["pushUp", "pushUp1", "pushUp2", "pushUp3", "pushUp4", "pushUp4", "pushUp3", "pushUp2", "pushUp1"],
                        "explanation": ["pushUpEH", "pushUpEA", "pushUpEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": [""]
                ],
                // Push (Tricep)
                "trianglePushUp":
                    [
                        "name": ["trianglePushUp"],
                        "demonstration": ["trianglePushUp", "trianglePushUp1", "trianglePushUp2", "trianglePushUp3", "trianglePushUp4", "trianglePushUp4", "trianglePushUp3", "trianglePushUp2", "trianglePushUp1"],
                        "explanation": ["trianglePushUpEH", "trianglePushUpEA", "trianglePushUpEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": [""]
                ],
                "dolphinPushup":
                    [
                        "name": ["dolphinPushup"],
                        "demonstration": ["dolphinPushup", "dolphinPushup1", "dolphinPushup2", "dolphinPushup3", "dolphinPushup4", "dolphinPushup3", "dolphinPushup2", "dolphinPushup1"],
                        "explanation": ["dolphinPushupEH", "dolphinPushupEA", "dolphinPushupEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": [""]
                ],
                "tricepExtensionsBodyweight":
                    [
                        "name": ["tricepExtensionsBodyweight"],
                        "demonstration": ["tricepExtensionsBodyweight", "tricepExtensionsBodyweight1", "tricepExtensionsBodyweight", "tricepExtensionsBodyweight1"],
                        "explanation": ["tricepExtensionsBodyweightEH", "tricepExtensionsBodyweightEA", "tricepExtensionsBodyweightEF"],
                        "targetArea": ["tricep"],
                        "attributes": [""]
                ],
                // Push (Chest & Tricep)
                "walkingPushup":
                    [
                        "name": ["walkingPushup"],
                        "demonstration": ["walkingPushup", "walkingPushup1", "walkingPushup2", "walkingPushup1", "walkingPushup3", "walkingPushup4", "walkingPushup5", "walkingPushup4", "walkingPushup3", "walkingPushup1", "walkingPushup2", "walkingPushup1", "walkingPushup6", "walkingPushup7", "walkingPushup8", "walkingPushup7", "walkingPushup6", "walkingPushup1", "walkingPushup2", "walkingPushup1"],
                        "explanation": ["walkingPushupEH", "walkingPushupEA", "walkingPushupEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": [""]
                ],
                // Push (Shoulder)
                "downwardDogPushup":
                    [
                        "name": ["downwardDogPushup"],
                        "demonstration": ["downwardDogPushup", "downwardDogPushup1", "downwardDogPushup2", "downwardDogPushup3", "downwardDogPushup3", "downwardDogPushup2", "downwardDogPushup1"],
                        "explanation": ["downwardDogPushupEH", "downwardDogPushupEA", "downwardDogPushupEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": [""]
                ],
                "wallpushUp":
                    [
                        "name": ["wallpushUp"],
                        "demonstration": ["handStandTrap1"],
                        "explanation": ["wallpushUpEH", "wallpushUpEA", "wallpushUpEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": [""]
                ],
                "boxer":
                    [
                        "name": ["boxer"],
                        "demonstration": ["boxer2", "boxer", "boxer1", "boxer2", "boxer1", "boxer", "boxer3", "boxer4", "boxer3", "boxer1"],
                        "explanation": ["boxerEH", "boxerEA", "boxerEF"],
                        "targetArea": ["rearDelt"],
                        "attributes": [""]
                ],
                "armCircles":
                    [
                        "name": ["armCircles"],
                        "demonstration": ["armCircles"],
                        "explanation": ["armCirclesEH", "armCirclesEA", "armCirclesEF"],
                        "targetArea": ["shoulder"],
                        "attributes": [""]
                ],
                // Core ---------
                "plank":
                    [
                        "name": ["plank"],
                        "demonstration": ["plank"],
                        "explanation": ["plankEH", "plankEA", "plankEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                "dynamicPlank":
                    [
                        "name": ["dynamicPlank"],
                        "demonstration": ["dynamicPlank", "dynamicPlank1", "dynamicPlank", "dynamicPlank1"],
                        "explanation": ["dynamicPlankEH", "dynamicPlankEA", "dynamicPlankEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                "sidePlankW":
                    [
                        "name": ["sidePlankW"],
                        "demonstration": ["sidePlankW"],
                        "explanation": ["sidePlankWEH", "sidePlankWEA", "sidePlankWEF"],
                        "targetArea": ["core"],
                        "attributes": ["a"]
                ],
                "pushupPlank":
                    [
                        "name": ["pushupPlank"],
                        "demonstration": ["pushupPlank"],
                        "explanation": ["pushupPlankEH", "pushupPlankEA", "pushupPlankEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                "lSit":
                    [
                        "name": ["lSit"],
                        "demonstration": ["lSit"],
                        "explanation": ["lSitEH", "lSitEA", "lSitEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "bicycleCrunch":
                    [
                        "name": ["bicycleCrunch"],
                        "demonstration": ["bicycleCrunch", "bicycleCrunch1", "bicycleCrunch2", "bicycleCrunch3", "bicycleCrunch4", "bicycleCrunch3", "bicycleCrunch2", "bicycleCrunch1"],
                        "explanation": ["bicycleCrunchEH", "bicycleCrunchEA", "bicycleCrunchEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                "divingHold":
                    [
                        "name": ["divingHold"],
                        "demonstration": ["divingHold"],
                        "explanation": ["divingHoldEH", "divingHoldEA", "divingHoldEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                "hipRaise":
                    [
                        "name": ["hipRaise"],
                        "demonstration": ["hipRaise", "hipRaise1", "hipRaise", "hipRaise1"],
                        "explanation": ["hipRaiseEH", "hipRaiseEA", "hipRaiseEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                "legHold":
                    [
                        "name": ["legHold"],
                        "demonstration": ["legHold"],
                        "explanation": ["legHoldEH", "legHoldEA", "legHoldEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                "legDrop":
                    [
                        "name": ["legDrop"],
                        "demonstration": ["legDrop", "legDrop1", "legDrop2", "legDrop1", "legDrop", "legDrop1", "legDrop2", "legDrop1"],
                        "explanation": ["legDropEH", "legDropEA", "legDropEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                // General (Core) ---------
                "mountainClimbers":
                    [
                        "name": ["mountainClimbers"],
                        "demonstration": ["mountainClimber", "mountainClimber3", "mountainClimber2", "mountainClimber1", "mountainClimber2", "mountainClimber3", "mountainClimber4", "mountainClimber5", "mountainClimber4", "mountainClimber3"],
                        "explanation": ["mountainClimbersEH", "mountainClimbersEA", "mountainClimbersEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                // General (Full Body)
                "burpee":
                    [
                        "name": ["burpee"],
                        "demonstration": ["burpee3", "burpee2", "burpee1", "burpee", "burpee1", "burpee2", "burpee3", "burpee4", "burpee5", "burpee6", "burpee5", "burpee4", "burpee3", "burpee2"],
                        "explanation": ["burpeeEH", "burpeeEA", "burpeeEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "kickThroughBurpee":
                    [
                        "name": ["kickThroughBurpee"],
                        "demonstration": ["kickThroughBurpee7", "kickThroughBurpee2", "kickThroughBurpee1", "kickThroughBurpee", "kickThroughBurpee1", "kickThroughBurpee2", "kickThroughBurpee3", "kickThroughBurpee4", "kickThroughBurpee5", "kickThroughBurpee4", "kickThroughBurpee6", "kickThroughBurpee7", "kickThroughBurpee6", "kickThroughBurpee4", "kickThroughBurpee8", "kickThroughBurpee9", "kickThroughBurpee8", "kickThroughBurpee4", "kickThroughBurpee3", "kickThroughBurpee2"],
                        "explanation": ["kickThroughBurpeeEH", "kickThroughBurpeeEA", "kickThroughBurpeeEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                // General (Upper Body)
                "spiderPushup":
                    [
                        "name": ["spiderPushup"],
                        "demonstration": ["spiderPushup4", "spiderPushup", "spiderPushup1", "spiderPushup2", "spiderPushup3", "spiderPushup4", "spiderPushup3", "spiderPushup2", "spiderPushup1", "spiderPushup", "spiderPushup1", "spiderPushup2", "spiderPushup5", "spiderPushup6", "spiderPushup5", "spiderPushup2", "spiderPushup1", "spiderPushup"],
                        "explanation": ["spiderPushupEH", "spiderPushupEA", "spiderPushupEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": [""]
                ],
                "crabWalk":
                    [
                        "name": ["crabWalk"],
                        "demonstration": ["crabWalk", "crabWalk1", "crabWalk2", "crabWalk3", "crabWalk4", "crabWalk5", "crabWalk6"],
                        "explanation": ["crabWalkEH", "crabWalkEA", "crabWalkEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                // General (Cardio)
                "jumpingJacks":
                    [
                        "name": ["jumpingJacks"],
                        "demonstration": ["jumpingJacks3", "jumpingJacks", "jumpingJacks1", "jumpingJacks2", "jumpingJacks3", "jumpingJacks4", "jumpingJacks3", "jumpingJacks2", "jumpingJacks1", "jumpingJacks"],
                        "explanation": ["jumpingJacksEH", "jumpingJacksEA", "jumpingJacksEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "tuckJump":
                    [
                        "name": ["tuckJump"],
                        "demonstration": ["tuckJump3", "tuckJump", "tuckJump1", "tuckJump2", "tuckJump3", "tuckJump2", "tuckJump1", "tuckJump"],
                        "explanation": ["tuckJumpEH", "tuckJumpEA", "tuckJumpEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "bumKicks":
                    [
                        "name": ["bumKicks"],
                        "demonstration": ["bumKicks", "bumKicks1", "bumKicks2", "bumKicks3", "bumKicks4", "bumKicks3", "bumKicks2", "bumKicks1"],
                        "explanation": ["bumKicksEH", "bumKicksEA", "bumKicksEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "kneeRaises":
                    [
                        "name": ["kneeRaises"],
                        "demonstration": ["kneeRaises", "kneeRaises1", "kneeRaises2", "kneeRaises3", "kneeRaises4", "kneeRaises3", "kneeRaises2", "kneeRaises1"],
                        "explanation": ["kneeRaisesEH", "kneeRaisesEA", "kneeRaisesEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                // Isometric (Legs) ---------
                "wallSit":
                    [
                        "name": ["wallSit"],
                        "demonstration": ["wallSit"],
                        "explanation": ["wallSitEH", "wallSitEA", "wallSitEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "toePress":
                    [
                        "name": ["toePress"],
                        "demonstration": ["toePress"],
                        "explanation": ["toePressEH", "toePressEA", "toePressEF"],
                        "targetArea": ["adductor"],
                        "attributes": [""]
                ],
                "staticLunge":
                    [
                        "name": ["staticLunge"],
                        "demonstration": ["lungeJump"],
                        "explanation": ["staticLungeE"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                // Isometric (Upper Body)
                "pushupHold":
                    [
                        "name": ["pushupHold"],
                        "demonstration": ["pushupHold"],
                        "explanation": ["pushupHoldEH", "pushupHoldEA", "pushupHoldEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": [""]
                ],
                "pullupHold":
                    [
                        "name": ["pullupHold"],
                        "demonstration": ["pullUp"],
                        "explanation": ["pullupHoldEH", "pullupHoldEA", "pullupHoldEF"],
                        "targetArea": ["backBicep"],
                        "attributes": [""]
                ],
                // Equipment (Ball) ---------
                "ballPushup":
                    [
                        "name": ["ballPushup"],
                        "demonstration": ["ballPushup", "ballPushup1", "ballPushup", "ballPushup1"],
                        "explanation": ["ballPushupEH", "ballPushupEA", "ballPushupEF"],
                        "targetArea": ["chestFrontDeltTricep"],
                        "attributes": [""]
                ],
                // Equipment (Bar)
                "bodyweightRow":
                    [
                        "name": ["bodyweightRow"],
                        "demonstration": ["bodyweightRow", "bodyweightRow1", "bodyweightRow", "bodyweightRow1"],
                        "explanation": ["bodyweightRowEH", "bodyweightRowEA", "bodyweightRowEF"],
                        "targetArea": ["backBicep"],
                        "attributes": [""]
                ],
                "pullup":
                    [
                        "name": ["pullup"],
                        "demonstration": ["pullUp", "pullUp1", "pullUp2", "pullUp3", "pullUp4", "pullUp4", "pullUp3", "pullUp2", "pullUp1"],
                        "explanation": ["pullupEH", "pullupEA", "pullupEF"],
                        "targetArea": ["backBicep"],
                        "attributes": [""]
                ],
                "hangingLegRaise":
                    [
                        "name": ["hangingLegRaise"],
                        "demonstration": ["hangingLegRaises", "hangingLegRaises1", "hangingLegRaises2", "hangingLegRaises3", "hangingLegRaises4", "hangingLegRaises3", "hangingLegRaises2", "hangingLegRaises1"],
                        "explanation": ["hangingLegRaiseEH", "hangingLegRaiseEA", "hangingLegRaiseEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                // Equipment (Bench/Step)
                "bodyweightBulgarianSplitSquat":
                    [
                        "name": ["bulgarianSplitSquat"],
                        "demonstration": ["bulgarianSplitSquat", "bulgarianSplitSquat1", "bulgarianSplitSquat", "bulgarianSplitSquat1"],
                        "explanation": ["bulgarianSplitSquatEH", "bulgarianSplitSquatEA", "bulgarianSplitSquatEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["a"]
                ],
                "boxJump":
                    [
                        "name": ["boxJump"],
                        "demonstration": ["boxJump"],
                        "explanation": ["boxJumpEH", "boxJumpEA", "boxJumpEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "hipThrusts":
                    [
                        "name": ["hipThrusts"],
                        "demonstration": ["hipThrusts", "hipThrusts1", "hipThrusts", "hipThrusts1"],
                        "explanation": ["hipThrustsEH", "hipThrustsEA", "hipThrustsEF"],
                        "targetArea": ["squatBody"],
                        "attributes": [""]
                ],
                "stepUp":
                    [
                        "name": ["stepUp"],
                        "demonstration": ["stepUp", "stepUp1", "stepUp2", "stepUp3", "stepUp2", "stepUp1"],
                        "explanation": ["stepUpEH", "stepUpEA", "stepUpEF"],
                        "targetArea": ["squatBody"],
                        "attributes": ["a"]
                ]
            ],
            // MARK: Cardio
            "endurance": [
                // All
                "highIntensity":
                    [
                        "name": ["highIntensity"],
                        "demonstration": ["running"],
                        "isMovement": ["true"]
                ],
                "lowIntensity":
                    [
                        "name": ["lowIntensity"],
                        "demonstration": ["Pause"],
                        "isMovement": ["true"]
                ],
                // Running
                "sprint":
                    [
                        "name": ["sprint"],
                        "demonstration": ["running"],
                        "isMovement": ["true"]
                ],   // Running
                "run":
                    [
                        "name": ["run"],
                        "demonstration": ["running"],
                        "isMovement": ["true"]
                ],
                "jog":
                    [
                        "name": ["jog"],
                        "demonstration": ["running"],
                        "isMovement": ["true"]
                ],
                "still":
                    [
                        "name": ["still"],
                        "demonstration": ["Pause"],
                        "isMovement": ["false"]
                ],   // Running Pauses
                "slowJog":
                    [
                        "name": ["slowJog"],
                        "demonstration": ["Pause"],
                        "isMovement": ["false"]
                ],
                "stretch":
                    [
                        "name": ["stretch"],
                        "demonstration": ["Pause"],
                        "isMovement": ["false"]
                ],
                // Biking
                "sprintB":
                    [
                        "name": ["sprintB"],
                        "demonstration": ["biking"],
                        "isMovement": ["true"]
                ],   // Bike
                "fastB":
                    [
                        "name": ["fastB"],
                        "demonstration": ["biking"],
                        "isMovement": ["true"]
                ],
                "mediumB":
                    [
                        "name": ["mediumB"],
                        "demonstration": ["biking"],
                        "isMovement": ["true"]
                ],
                "stillB":
                    [
                        "name": ["stillB"],
                        "demonstration": ["Pause"],
                        "isMovement": ["false"]
                ],      // Biking Pauses
                "slowB":
                    [
                        "name": ["slowB"],
                        "demonstration": ["Pause"],
                        "isMovement": ["false"]
                ],
                "stretchB":
                    [
                        "name": ["stretch"],
                        "demonstration": ["Pause"],
                        "isMovement": ["false"]
                ],
                // Rowing
                "sprintR":
                    [
                        "name": ["sprintR"],
                        "demonstration": ["rowing"],
                        "isMovement": ["true"]
                ],    // Rowing
                "fastR":
                    [
                        "name": ["fastR"],
                        "demonstration": ["rowing"],
                        "isMovement": ["true"]
                ],
                "mediumR":
                    [
                        "name": ["mediumR"],
                        "demonstration": ["rowing"],
                        "isMovement": ["true"]
                ],
                "stillR":
                    [
                        "name": ["stillR"],
                        "demonstration": ["Pause"],
                        "isMovement": ["false"]
                ],     // Rowing Pauses
                "slowR":
                    [
                        "name": ["slowR"],
                        "demonstration": ["Pause"],
                        "isMovement": ["false"]
                ],
                "stretchR":
                    [
                        "name": ["stretch"],
                        "demonstration": ["Pause"],
                        "isMovement": ["false"]
                ],
            ],
            // MARK: Stretching
            "stretching": [
                // Recommended
                "lightCardio":
                    [
                        "name": ["lightCardio"],
                        "demonstration": ["cardioWarmup"],
                        "explanation": ["lightCardioEH", "lightCardioEA", "lightCardioEF"],
                        "targetArea": ["heart"],
                        "attributes": [""]
                ],
                // Joint Rotations
                "wrist":
                    [
                        "name": ["wrist"],
                        "demonstration": ["wristRotations", "wristRotations1", "wristRotations2", "wristRotations1", "wristRotations2", "wristRotations3", "wristRotations4", "wristRotations3", "wristRotations4"],
                        "explanation": ["wristEH", "wristEA", "wristEF"],
                        "targetArea": ["wrist"],
                        "attributes": [""]
                ],
                "elbow":
                    [
                        "name": ["elbow"],
                        "demonstration": ["elbowRotations", "elbowRotations1", "elbowRotations2", "elbowRotations3", "elbowRotations4", "elbowRotations3", "elbowRotations2", "elbowRotations1"],
                        "explanation": ["elbowEH", "elbowEA", "elbowEF"],
                        "targetArea": ["elbow"],
                        "attributes": ["a"]
                ],
                "shoulderR":
                    [
                        "name": ["shoulderR"],
                        "demonstration": ["shoulderRotations", "shoulderRotations1", "shoulderRotations2", "shoulderRotations3", "shoulderRotations4", "shoulderRotations5", "shoulderRotations6", "shoulderRotations1"],
                        "explanation": ["shoulderREH", "shoulderREA", "shoulderREF"],
                        "targetArea": ["shoulder"],
                        "attributes": ["a"]
                ],
                "neckR":
                    [
                        "name": ["neckR"],
                        "demonstration": ["neckRotations", "neckRotations1", "neckRotations2", "neckRotations1", "neckRotations2", "neckRotations3", "neckRotations4", "neckRotations3", "neckRotations4"],
                        "explanation": ["neckREH", "neckREA", "neckREF"],
                        "targetArea": ["neckJoint"],
                        "attributes": ["a"]
                ],
                "waist":
                    [
                        "name": ["waist"],
                        "demonstration": ["waistRotations", "waistRotations1", "waistRotations2", "waistRotations3", "waistRotations4", "waistRotations5", "waistRotations6", "waistRotations1"],
                        "explanation": ["waistEH", "waistEA", "waistEF"],
                        "targetArea": ["waist"],
                        "attributes": ["a"]
                ],
                "hip":
                    [
                        "name": ["hip"],
                        "demonstration": ["hipRotations", "hipRotations", "hipRotations2", "hipRotations3", "hipRotations4", "hipRotations5", "hipRotations6", "hipRotations7", "hipRotations1"],
                        "explanation": ["hipEH", "hipEA", "hipEF"],
                        "targetArea": ["hip"],
                        "attributes": ["a"]
                ],
                "knees":
                    [
                        "name": ["knees"],
                        "demonstration": ["kneeRotations", "kneeRotations1", "kneeRotations2", "kneeRotations3", "kneeRotations2", "kneeRotations1", "kneeRotations4", "kneeRotations5", "kneeRotations4", "kneeRotations1"],
                        "explanation": ["kneesEH", "kneesEA", "kneesEF"],
                        "targetArea": ["knee"],
                        "attributes": ["a"]
                ],
                "ankles":
                    [
                        "name": ["ankles"],
                        "demonstration": ["ankleRotations", "ankleRotations1", "ankleRotations2", "ankleRotations1", "ankleRotations2","ankleRotations1", "ankleRotations2",],
                        "explanation": ["anklesEH", "anklesEA", "anklesEF"],
                        "targetArea": ["ankle"],
                        "attributes": ["a"]
                ],
                // Foam/Ball Roll
                "backf":
                    [
                        "name": ["backf"],
                        "demonstration": ["backFoam", "backFoam1", "backFoam2", "backFoam3", "backFoam4", "backFoam3", "backFoam2", "backFoam1"],
                        "explanation": ["backfEH", "backfEA", "backfEF"],
                        "targetArea": ["thoracic"],
                        "attributes": [""]
                ],
                "thoracicSpine":
                    [
                        "name": ["thoracicSpine"],
                        "demonstration": ["thoracicSpineFoam", "thoracicSpineFoam1", "thoracicSpineFoam2", "thoracicSpineFoam3", "thoracicSpineFoam2", "thoracicSpineFoam1", "thoracicSpineFoam4", "thoracicSpineFoam5", "thoracicSpineFoam4", "thoracicSpineFoam1"],
                        "explanation": ["thoracicSpineEH", "thoracicSpineEA", "thoracicSpineEF"],
                        "targetArea": ["thoracic"],
                        "attributes": [""]
                ],
                "lat":
                    [
                        "name": ["lat"],
                        "demonstration": ["latFoam", "latFoam1", "latFoam2", "latFoam3", "latFoam4", "latFoam3", "latFoam2", "latFoam1"],
                        "explanation": ["latEH", "latEA", "latEF"],
                        "targetArea": ["latDelt"],
                        "attributes": ["a"]
                ],
                "pecDelt":
                    [
                        "name": ["pecDelt"],
                        "demonstration": ["pecDeltFoam"],
                        "explanation": ["pecDeltEH", "pecDeltEA", "pecDeltEF"],
                        "targetArea": ["pecFrontDelt"],
                        "attributes": ["a"]
                ],
                "rearDelt":
                    [
                        "name": ["rearDelt"],
                        "demonstration": ["rearDeltFoam"],
                        "explanation": ["rearDeltEH", "rearDeltEA", "rearDeltEF"],
                        "targetArea": ["rearDelt"],
                        "attributes": ["a"]
                ],
                "quadf":
                    [
                        "name": ["quadf"],
                        "demonstration": ["quadFoam", "quadFoam1", "quadFoam2", "quadFoam3", "quadFoam4", "quadFoam3", "quadFoam2", "quadFoam1", "quadFoam5", "quadFoam6", "quadFoam5"],
                        "explanation": ["quadfEH", "quadfEA", "quadfEF"],
                        "targetArea": ["quad"],
                        "attributes": ["a"]
                ],
                "adductorf":
                    [
                        "name": ["adductorf"],
                        "demonstration": ["adductorFoam", "adductorFoam1", "adductorFoam2", "adductorFoam3", "adductorFoam2", "adductorFoam1"],
                        "explanation": ["adductorfEH", "adductorfEA", "adductorfEF"],
                        "targetArea": ["adductor"],
                        "attributes": ["a"]
                ],
                "hamstringf":
                    [
                        "name": ["hamstringf"],
                        "demonstration": ["hamstringFoam", "hamstringFoam1", "hamstringFoam2", "hamstringFoam3", "hamstringFoam4", "hamstringFoam3", "hamstringFoam2", "hamstringFoam1"],
                        "explanation": ["hamstringfEH", "hamstringfEA", "hamstringfEF"],
                        "targetArea": ["hamstring"],
                        "attributes": ["a"]
                ],
                "glutef":
                    [
                        "name": ["glutef"],
                        "demonstration": ["gluteFoam", "gluteFoam1", "gluteFoam2", "gluteFoam3", "gluteFoam4", "gluteFoam3", "gluteFoam2", "gluteFoam1"],
                        "explanation": ["glutefEH", "glutefEA", "glutefEF"],
                        "targetArea": ["glute"],
                        "attributes": ["a"]
                ],
                "calff":
                    [
                        "name": ["calff"],
                        "demonstration": ["calfFoam", "calfFoam1", "calfFoam2", "calfFoam3", "calfFoam2", "calfFoam1", "calfFoam2", "calfFoam3", "calfFoam4", "calfFoam5", "calfFoam4", "calfFoam3", "calfFoam2", "calfFoam1"],
                        "explanation": ["calffEH", "calffEA", "calffEF"],
                        "targetArea": ["calf"],
                        "attributes": ["a"]
                ],
                "itBand":
                    [
                        "name": ["itBand"],
                        "demonstration": ["itBandFoam", "itBandFoam1", "itBandFoam2", "itBandFoam3", "itBandFoam2", "itBandFoam1"],
                        "explanation": ["itBandEH", "itBandEA", "itBandEF"],
                        "targetArea": ["ITBand"],
                        "attributes": ["a"]
                ],
                "standOnBall":
                    [
                        "name": ["standOnBall"],
                        "demonstration": ["standingOnBall"],
                        "explanation": ["standOnBallEH", "standOnBallEA", "standOnBallEF"],
                        "targetArea": ["foot"],
                        "attributes": ["a"]
                ],
                // Back
                "catCow":
                    [
                        "name": ["catCow"],
                        "demonstration": ["catCowS", "catCowS1", "catCowS2", "catCowS1", "catCowS3", "catCowS1", "catCowS2", "catCowS1"],
                        "explanation": ["catCowEH", "catCowEA", "catCowEF"],
                        "targetArea": ["spine"],
                        "attributes": [""]
                ],
                "upwardsDog":
                    [
                        "name": ["upwardsDog"],
                        "demonstration": ["upwardsDogS"],
                        "explanation": ["upwardsDogEH", "upwardsDogEA", "upwardsDogEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                "extendedPuppy":
                    [
                        "name": ["extendedPuppy"],
                        "demonstration": ["extendedPuppyS"],
                        "explanation": ["extendedPuppyEH", "extendedPuppyEA", "extendedPuppyEF"],
                        "targetArea": ["spineCore"],
                        "attributes": [""]
                ],
                "childPose":
                    [
                        "name": ["childPose"],
                        "demonstration": ["childPoseS"],
                        "explanation": ["childPoseEH", "childPoseEA", "childPoseEF"],
                        "targetArea": ["backGlute"],
                        "attributes": [""]
                ],
                "staffPose":
                    [
                        "name": ["staffPose"],
                        "demonstration": ["staffPoseS"],
                        "explanation": ["staffPoseEH", "staffPoseEA", "staffPoseEF"],
                        "targetArea": ["hamstringLowerBack"],
                        "attributes": [""]
                ],
                "pelvicTilt":
                    [
                        "name": ["pelvicTilt"],
                        "demonstration": ["pelvicTilt", "pelvicTilt1", "pelvicTilt", "pelvicTilt1", "pelvicTilt", "pelvicTilt1", "pelvicTilt"],
                        "explanation": ["pelvicTiltEH", "pelvicTiltEA", "pelvicTiltEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                "kneeToChest":
                    [
                        "name": ["kneeToChest"],
                        "demonstration": ["kneeToChest"],
                        "explanation": ["kneeToChestEH", "kneeToChestEA", "kneeToChestEF"],
                        "targetArea": ["hipArea"],
                        "attributes": [""]
                ],
                "legDrop":
                    [
                        "name": ["legDrop"],
                        "demonstration": ["legDrop", "legDrop1", "legDrop2", "legDrop1", "legDrop", "legDrop1", "legDrop2", "legDrop1"],
                        "explanation": ["legDropEH", "legDropEA", "legDropEF"],
                        "targetArea": ["core"],
                        "attributes": [""]
                ],
                "seatedTwist":
                    [
                        "name": ["seatedTwist"],
                        "demonstration": ["seatedTwist"],
                        "explanation": ["seatedTwistEH", "seatedTwistEA", "seatedTwistEF"],
                        "targetArea": ["core"],
                        "attributes": ["a"]
                ],
                "legsWall":
                    [
                        "name": ["legsWall"],
                        "demonstration": ["legsWall"],
                        "explanation": ["legsWallEH", "legsWallEA", "legsWallEF"],
                        "targetArea": ["hamstringLowerBack"],
                        "attributes": [""]
                ],
                // Obliques(Sides)
                "sideLean":
                    [
                        "name": ["sideLean"],
                        "demonstration": ["sideLean"],
                        "explanation": ["sideLeanEH", "sideLeanEA", "sideLeanEF"],
                        "targetArea": ["oblique"],
                        "attributes": ["a"]
                ],
                "extendedSideAngle":
                    [
                        "name": ["extendedSideAngle"],
                        "demonstration": ["extendedSideAngleS"],
                        "explanation": ["extendedSideAngleEH", "extendedSideAngleEA", "extendedSideAngleEF"],
                        "targetArea": ["extendedSide"],
                        "attributes": ["a"]
                ],
                "seatedSide":
                    [
                        "name": ["seatedSide"],
                        "demonstration": ["seatedSide"],
                        "explanation": ["seatedSideEH", "seatedSideEA", "seatedSideEF"],
                        "targetArea": ["hamstringGlute"],
                        "attributes": ["a"]
                ],
                // Neck
                "rearNeck":
                    [
                        "name": ["rearNeck"],
                        "demonstration": ["rearNeckStretch"],
                        "explanation": ["rearNeckEH", "rearNeckEA", "rearNeckEF"],
                        "targetArea": ["rearNeck"],
                        "attributes": [""]
                ],
                "rearNeckHand":
                    [
                        "name": ["rearNeckHand"],
                        "demonstration": ["rearNeckHand"],
                        "explanation": ["rearNeckHandEH", "rearNeckHandEA", "rearNeckHandEF"],
                        "targetArea": ["rearNeck"],
                        "attributes": [""]
                ],
                "seatedLateral":
                    [
                        "name": ["seatedLateral"],
                        "demonstration": ["seatedLateral"],
                        "explanation": ["seatedLateralEH", "seatedLateralEA", "seatedLateralEF"],
                        "targetArea": ["lateralNeck"],
                        "attributes": ["a"]
                ],
                "neckRotator":
                    [
                        "name": ["neckRotator"],
                        "demonstration": ["neckRotatorStretch"],
                        "explanation": ["neckRotatorEH", "neckRotatorEA", "neckRotatorEF"],
                        "targetArea": ["neckRotator"],
                        "attributes": ["a"]
                ],
                "scalene":
                    [
                        "name": ["scalene"],
                        "demonstration": ["scalene"],
                        "explanation": ["scaleneEH", "scaleneEA", "scaleneEF"],
                        "targetArea": ["neckRotator"],
                        "attributes": ["a"]
                ],
                "headRoll":
                    [
                        "name": ["headRoll"],
                        "demonstration": ["headRoll"],
                        "explanation": ["headRollEH", "headRollEA", "headRollEF"],
                        "targetArea": ["neck"],
                        "attributes": ["a"]
                ],
                // Arms
                "forearmStretch":
                    [
                        "name": ["forearmStretch"],
                        "demonstration": ["forearmStretch"],
                        "explanation": ["forearmStretchEH", "forearmStretchEA", "forearmStretchEF"],
                        "targetArea": ["forearm"],
                        "attributes": ["a"]
                ],
                "tricepStretch":
                    [
                        "name": ["tricepStretch"],
                        "demonstration": ["tricepStretch"],
                        "explanation": ["tricepStretchEH", "tricepStretchEA", "tricepStretchEF"],
                        "targetArea": ["tricep"],
                        "attributes": ["a"]
                ],
                "bicepStretch":
                    [
                        "name": ["bicepStretch"],
                        "demonstration": ["bicepStretch"],
                        "explanation": ["bicepStretchEH", "bicepStretchEA", "bicepStretchEF"],
                        "targetArea": ["bicep"],
                        "attributes": ["a"]
                ],
                // Pecs
                "pecStretch":
                    [
                        "name": ["pecStretch"],
                        "demonstration": ["pecStretch"],
                        "explanation": ["pecStretchEH", "pecStretchEA", "pecStretchEF"],
                        "targetArea": ["pec"],
                        "attributes": ["a"]
                ],
                // Shoulders
                "shoulderRoll":
                    [
                        "name": ["shoulderRoll"],
                        "demonstration": ["shoulderRoll", "shoulderRoll1", "shoulderRoll2", "shoulderRoll3", "shoulderRoll", "shoulderRoll1", "shoulderRoll2", "shoulderRoll3"],
                        "explanation": ["shoulderRollEH", "shoulderRollEA", "shoulderRollEF"],
                        "targetArea": ["shoulderJoint"],
                        "attributes": [""]
                ],
                "behindBackTouch":
                    [
                        "name": ["behindBackTouch"],
                        "demonstration": ["behindBackTouch"],
                        "explanation": ["behindBackTouchEH", "behindBackTouchEA", "behindBackTouchEF"],
                        "targetArea": ["shoulderJoint"],
                        "attributes": ["a"]
                ],
                "frontDelt":
                    [
                        "name": ["frontDelt"],
                        "demonstration": ["frontDeltStretch"],
                        "explanation": ["frontDeltEH", "frontDeltEA", "frontDeltEF"],
                        "targetArea": ["frontDelt"],
                        "attributes": ["a"]
                ],
                "lateralDelt":
                    [
                        "name": ["lateralDelt"],
                        "demonstration": ["lateralDeltStretch"],
                        "explanation": ["lateralDeltEH", "lateralDeltEA", "lateralDeltEF"],
                        "targetArea": ["lateralDelt"],
                        "attributes": ["a"]
                ],
                "rearDeltStretch":
                    [
                        "name": ["rearDeltStretch"],
                        "demonstration": ["rearDeltStretch"],
                        "explanation": ["rearDeltStretchEH", "rearDeltStretchEA", "rearDeltStretchEF"],
                        "targetArea": ["rearDelt"],
                        "attributes": ["a"]
                ],
                // Hips and Glutes
                "squatHold":
                    [
                        "name": ["squatHold"],
                        "demonstration": ["squatHold"],
                        "explanation": ["squatHoldEH", "squatHoldEA", "squatHoldEF"],
                        "targetArea": ["hip"],
                        "attributes": [""]
                ],
                "groinStretch":
                    [
                        "name": ["groinStretch"],
                        "demonstration": ["groinStretch"],
                        "explanation": ["groinStretchEH", "groinStretchEA", "groinStretchEF"],
                        "targetArea": ["adductor"],
                        "attributes": [""]
                ],
                "butterflyPose":
                    [
                        "name": ["butterflyPose"],
                        "demonstration": ["butterflyPoseS"],
                        "explanation": ["butterflyPoseEH", "butterflyPoseEA", "butterflyPoseEF"],
                        "targetArea": ["adductor"],
                        "attributes": [""]
                ],
                "lungeStretch":
                    [
                        "name": ["lungeStretch"],
                        "demonstration": ["lungeStretch"],
                        "explanation": ["lungeStretchEH", "lungeStretchEA", "lungeStretchEF"],
                        "targetArea": ["hipArea"],
                        "attributes": ["a"]
                ],
                "threadTheNeedle":
                    [
                        "name": ["threadTheNeedle"],
                        "demonstration": ["threadTheNeedleS"],
                        "explanation": ["threadTheNeedleEH", "threadTheNeedleEA", "threadTheNeedleEF"],
                        "targetArea": ["glute"],
                        "attributes": ["a"]
                ],
                "pigeonPose":
                    [
                        "name": ["pigeonPose"],
                        "demonstration": ["pigeonPoseS"],
                        "explanation": ["pigeonPoseEH", "pigeonPoseEA", "pigeonPoseEF"],
                        "targetArea": ["glute"],
                        "attributes": ["a"]
                ],
                "seatedGlute":
                    [
                        "name": ["seatedGlute"],
                        "demonstration": ["seatedGlute"],
                        "explanation": ["seatedGluteEH", "seatedGluteEA", "seatedGluteEF"],
                        "targetArea": ["glute"],
                        "attributes": ["a"]
                ],
                // calves
                "calfStretch":
                    [
                        "name": ["calfStretch"],
                        "demonstration": ["calfStretch"],
                        "explanation": ["calfStretchEH", "calfStretchEA", "calfStretchEF"],
                        "targetArea": ["calf"],
                        "attributes": ["a"]
                ],
                // Hamstrings
                "standingHamstring":
                    [
                        "name": ["standingHamstring"],
                        "demonstration": ["standingHamstring"],
                        "explanation": ["standingHamstringEH", "standingHamstringEA", "standingHamstringEF"],
                        "targetArea": ["hamstring"],
                        "attributes": [""]
                ],
                "downWardsDog":
                    [
                        "name": ["downWardsDog"],
                        "demonstration": ["downWardsDogS"],
                        "explanation": ["downWardsDogEH", "downWardsDogEA", "downWardsDogEF"],
                        "targetArea": ["hamstring"],
                        "attributes": [""]
                ],
                "singleLegHamstring":
                    [
                        "name": ["singleLegHamstring"],
                        "demonstration": ["singleLegHamstring"],
                        "explanation": ["singleLegHamstringEH", "singleLegHamstringEA", "singleLegHamstringEF"],
                        "targetArea": ["hamstring"],
                        "attributes": ["a"]
                ],
                "twoLegHamstring":
                    [
                        "name": ["twoLegHamstring"],
                        "demonstration": ["twoLegHamstring"],
                        "explanation": ["twoLegHamstringEH", "twoLegHamstringEA", "twoLegHamstringEF"],
                        "targetArea": ["hamstring"],
                        "attributes": [""]
                ],
                // Quads
                "lungeStretchWall":
                    [
                        "name": ["lungeStretchWall"],
                        "demonstration": ["lungeStretchWall"],
                        "explanation": ["lungeStretchWallEH", "lungeStretchWallEA", "lungeStretchWallEF"],
                        "targetArea": ["quad"],
                        "attributes": ["a"]
                ],
                "quadStretch":
                    [
                        "name": ["quadStretch"],
                        "demonstration": ["quadStretch"],
                        "explanation": ["quadStretchEH", "quadStretchEA", "quadStretchEF"],
                        "targetArea": ["quad"],
                        "attributes": ["a"]
                ],
            ],
            // MARK: Yoga
            "yoga": [
                // Standing
                "upwardsSalute":
                    [
                        "name": ["upwardsSalute"],
                        "demonstration": ["upwardSalute"],
                        "explanation": ["upwardsSaluteEH", "upwardsSaluteEA", "upwardsSaluteEF"],
                        "attributes": [""]
                ],
                "mountain":
                    [
                        "name": ["mountain"],
                        "demonstration": ["mountain"],
                        "explanation": ["mountainEH", "mountainEA", "mountainEF"],
                        "attributes": [""]
                ],
                "treeL":
                    [
                        "name": ["treeL"],
                        "demonstration": ["tree"], // "tree1", "tree2", "tree3", "tree4", "tree5", "tree6"],
                        "explanation": ["treeEH", "treeEA", "treeEF"],
                        "attributes": [""]
                ], //
                "treeR":
                    [
                        "name": ["treeR"],
                        "demonstration": ["tree"], //, "tree1", "tree2", "tree3", "tree4", "tree5", "tree6"],
                        "explanation": ["treeEH", "treeEA", "treeEF"],
                        "attributes": ["a"]
                ],
                "extendedToeGrabL":
                    [
                        "name": ["extendedToeGrabL"],
                        "demonstration": ["extendedToeGrab"],// "extendedToeGrab1", "extendedToeGrab2", "extendedToeGrab3", "extendedToeGrab4", "extendedToeGrab5"],
                        "explanation": ["extendedToeGrabEH", "extendedToeGrabEA", "extendedToeGrabEF"],
                        "attributes": ["a"]
                ], //
                "extendedToeGrabR":
                    [
                        "name": ["extendedToeGrabR"],
                        "demonstration": ["extendedToeGrab"],// "extendedToeGrab1", "extendedToeGrab2", "extendedToeGrab3", "extendedToeGrab4", "extendedToeGrab5"],
                        "explanation": ["extendedToeGrabEH", "extendedToeGrabEA", "extendedToeGrabEF"],
                        "attributes": [""]
                ],
                "eagleL":
                    [
                        "name": ["eagleL"],
                        "demonstration": ["eagle"], // "eagle1", "eagle2", "eagle3", "eagle4", "eagle5", "eagle6", "eagle7"],
                        "explanation": ["eagleEH", "eagleEA", "eagleEF"],
                        "attributes": ["a"]
                ], //
                "eagleR":
                    [
                        "name": ["eagleR"],
                        "demonstration": ["eagle"], // "eagle1", "eagle2", "eagle3", "eagle4", "eagle5", "eagle6", "eagle7"],
                        "explanation": ["eagleEH", "eagleEA", "eagleEF"],
                        "attributes": [""]
                ],
                "chair":
                    [
                        "name": ["chair"],
                        "demonstration": ["chair"], // "chair1", "chair2", "chair3", "chair4", "chair5"],
                        "explanation": ["chairEH", "chairEA", "chairEF"],
                        "attributes": [""]
                ],
                "lordOfDanceL":
                    [
                        "name": ["lordOfDanceL"],
                        "demonstration": ["lordOfDance"], // "lordOfDance1", "lordOfDance2", "lordOfDance3", "lordOfDance4", "lordOfDance5", "lordOfDance6", "lordOfDance7"],
                        "explanation": ["lordOfDanceEH", "lordOfDanceEA", "lordOfDanceEF"],
                        "attributes": [""]
                ], //
                "lordOfDanceR":
                    [
                        "name": ["lordOfDanceR"],
                        "demonstration": ["lordOfDance"], // "lordOfDance1", "lordOfDance2", "lordOfDance3", "lordOfDance4", "lordOfDance5", "lordOfDance6", "lordOfDance7"],
                        "explanation": ["lordOfDanceEH", "lordOfDanceEA", "lordOfDanceEF"],
                        "attributes": ["a"]
                ],
                "warrior1L":
                    [
                        "name": ["warrior1L"],
                        "demonstration": ["warrior1"], // "warrior11", "warrior12", "warrior13", "warrior14", "warrior15"],
                        "explanation": ["warrior1EH", "warrior1EA", "warrior1EF"],
                        "attributes": [""]
                ], //
                "warrior1R":
                    [
                        "name": ["warrior1R"],
                        "demonstration": ["warrior1"], // "warrior11", "warrior12", "warrior13", "warrior14", "warrior15"],
                        "explanation": ["warrior1EH", "warrior1EA", "warrior1EF"],
                        "attributes": ["a"]
                ],
                "warrior2L":
                    [
                        "name": ["warrior2L"],
                        "demonstration": ["warrior2"], // "warrior21", "warrior22", "warrior23", "warrior24", "warrior25"],
                        "explanation": ["warrior2EH", "warrior2EA", "warrior2EF"],
                        "attributes": [""]
                ], //
                "warrior2R":
                    [
                        "name": ["warrior2R"],
                        "demonstration": ["warrior2"], // "warrior21", "warrior22", "warrior23", "warrior24", "warrior25"],
                        "explanation": ["warrior2EH", "warrior2EA", "warrior2EF"],
                        "attributes": ["a"]
                ],
                "warrior3L":
                    [
                        "name": ["warrior3L"],
                        "demonstration": ["warrior3"], // "warrior31", "warrior32", "warrior33", "warrior34", "warrior35", "warrior36"],
                        "explanation": ["warrior3EH", "warrior3EA", "warrior3EF"],
                        "attributes": ["a"]
                ], //
                "warrior3R":
                    [
                        "name": ["warrior3R"],
                        "demonstration": ["warrior3"], // "warrior31", "warrior32", "warrior33", "warrior34", "warrior35", "warrior36"],
                        "explanation": ["warrior3EH", "warrior3EA", "warrior3EF"],
                        "attributes": [""]
                ],
                "halfMoonL":
                    [
                        "name": ["halfMoonL"],
                        "demonstration": ["halfMoon"], // "halfMoon1", "halfMoon2", "halfMoon3", "halfMoon4", "halfMoon5", "halfMoon6", "halfMoon7"],
                        "explanation": ["halfMoonEH", "halfMoonEA", "halfMoonEF"],
                        "attributes": [""]
                ], //
                "halfMoonR":
                    [
                        "name": ["halfMoonR"],
                        "demonstration": ["halfMoon"], // "halfMoon1", "halfMoon2", "halfMoon3", "halfMoon4", "halfMoon5", "halfMoon6", "halfMoon7"],
                        "explanation": ["halfMoonEH", "halfMoonEA", "halfMoonEF"],
                        "attributes": ["a"]
                ],
                "extendedTriangleL":
                    [
                        "name": ["extendedTriangleL"],
                        "demonstration": ["extendedTriangle"], // "extendedTriangle1", "extendedTriangle2", "extendedTriangle3", "extendedTriangle4", "extendedTriangle5"],
                        "explanation": ["extendedTriangleEH", "extendedTriangleEA", "extendedTriangleEF"],
                        "attributes": [""]
                ], //
                "extendedTriangleR":
                    [
                        "name": ["extendedTriangleR"],
                        "demonstration": ["extendedTriangle"], // "extendedTriangle1", "extendedTriangle2", "extendedTriangle3", "extendedTriangle4", "extendedTriangle5"],
                        "explanation": ["extendedTriangleEH", "extendedTriangleEA", "extendedTriangleEF"],
                        "attributes": ["a"]
                ],
                "extendedSideAngleYL":
                    [
                        "name": ["extendedSideAngleYL"],
                        "demonstration": ["extendedSideAngle"], // "extendedSideAngle1", "extendedSideAngle2", "extendedSideAngle3", "extendedSideAngle4", "extendedSideAngle5", "extendedSideAngle6"],
                        "explanation": ["extendedSideAngleYEH", "extendedSideAngleYEA", "extendedSideAngleYEF"],
                        "attributes": [""]
                ], //
                "extendedSideAngleYR":
                    [
                        "name": ["extendedSideAngleYR"],
                        "demonstration": ["extendedSideAngle"], // "extendedSideAngle1", "extendedSideAngle2", "extendedSideAngle3", "extendedSideAngle4", "extendedSideAngle5", "extendedSideAngle6"],
                        "explanation": ["extendedSideAngleYEH", "extendedSideAngleYEA", "extendedSideAngleYEF"],
                        "attributes": ["a"]
                ],
                "revolvedSideAngleL":
                    [
                        "name": ["revolvedSideAngleL"],
                        "demonstration": ["revolvedSideAngle"], // "revolvedSideAngle1", "revolvedSideAngle2", "revolvedSideAngle3", "revolvedSideAngle4", "revolvedSideAngle5", "revolvedSideAngle6"],
                        "explanation": ["revolvedSideAngleEH", "revolvedSideAngleEA", "revolvedSideAngleEF"],
                        "attributes": [""]
                ], //
                "revolvedSideAngleR":
                    [
                        "name": ["revolvedSideAngleR"],
                        "demonstration": ["revolvedSideAngle"], // "revolvedSideAngle1", "revolvedSideAngle2", "revolvedSideAngle3", "revolvedSideAngle4", "revolvedSideAngle5", "revolvedSideAngle6"],
                        "explanation": ["revolvedSideAngleEH", "revolvedSideAngleEA", "revolvedSideAngleEF"],
                        "attributes": ["a"]
                ],
                "revolvedTriangleL":
                    [
                        "name": ["revolvedTriangleL"],
                        "demonstration": ["revolvedTriangle"], // "revolvedTriangle1", "revolvedTriangle2", "revolvedTriangle3", "revolvedTriangle4", "revolvedTriangle5", "revolvedTriangle6"],
                        "explanation": ["revolvedTriangleEH", "revolvedTriangleEA", "revolvedTriangleEF"],
                        "attributes": ["a"]
                ], //
                "revolvedTriangleR":
                    [
                        "name": ["revolvedTriangleR"],
                        "demonstration": ["revolvedTriangle"], // "revolvedTriangle1", "revolvedTriangle2", "revolvedTriangle3", "revolvedTriangle4", "revolvedTriangle5", "revolvedTriangle6"],
                        "explanation": ["revolvedTriangleEH", "revolvedTriangleEA", "revolvedTriangleEF"],
                        "attributes": [""]
                ],
                "halfForwardBend":
                    [
                        "name": ["halfForwardBend"],
                        "demonstration": ["halfForwardBend"], // "halfForwardBend1", "halfForwardBend2", "halfForwardBend3", "halfForwardBend4", "halfForwardBend5", "halfForwardBend6", "halfForwardBend7"],
                        "explanation": ["halfForwardBendEH", "halfForwardBendEA", "halfForwardBendEF"],
                        "attributes": [""]
                ],
                "forwardBend":
                    [
                        "name": ["forwardBend"],
                        "demonstration": ["forwardBend"], // "forwardBend1", "forwardBend2", "forwardBend3", "forwardBend4", "forwardBend5", "forwardBend6", "forwardBend7"],
                        "explanation": ["forwardBendEH", "forwardBendEA", "forwardBendEF"],
                        "attributes": [""]
                ],
                "wideLeggedForwardBend":
                    [
                        "name": ["wideLeggedForwardBend"],
                        "demonstration": ["wideLeggedForwardBend"], // "wideLeggedForwardBend1", "wideLeggedForwardBend2", "wideLeggedForwardBend3", "wideLeggedForwardBend4", "wideLeggedForwardBend5", "wideLeggedForwardBend6"],
                        "explanation": ["wideLeggedForwardBendEH", "wideLeggedForwardBendEA", "wideLeggedForwardBendEF"],
                        "attributes": [""]
                ],
                "intenseSideL":
                    [
                        "name": ["intenseSideL"],
                        "demonstration": ["intenseSide"], // "intenseSide1", "intenseSide2", "intenseSide3", "intenseSide4", "intenseSide5"],
                        "explanation": ["intenseSideEH", "intenseSideEA", "intenseSideEF"],
                        "attributes": [""]
                ], //
                "intenseSideR":
                    [
                        "name": ["intenseSideR"],
                        "demonstration": ["intenseSide"], // "intenseSide1", "intenseSide2", "intenseSide3", "intenseSide4", "intenseSide5"],
                        "explanation": ["intenseSideEH", "intenseSideEA", "intenseSideEF"],
                        "attributes": ["a"]
                ],
                "gateL":
                    [
                        "name": ["gateL"],
                        "demonstration": ["gate"],
                        "explanation": ["gateEH", "gateEA", "gateEF"],
                        "attributes": [""]
                ], //
                "gateR":
                    [
                        "name": ["gateR"],
                        "demonstration": ["gate"],
                        "explanation": ["gateEH", "gateEA", "gateEF"],
                        "attributes": ["a"]
                ],
                "highLungeL":
                    [
                        "name": ["highLungeL"],
                        "demonstration": ["highLunge"], // "highLunge1", "highLunge2", "highLunge3", "highLunge4", "highLunge5", "highLunge6"],
                        "explanation": ["highLungeEH", "highLungeEA", "highLungeEF"],
                        "attributes": [""]
                ], //
                "highLungeR":
                    [
                        "name": ["highLungeR"],
                        "demonstration": ["highLunge"], // "highLunge1", "highLunge2", "highLunge3", "highLunge4", "highLunge5", "highLunge6"],
                        "explanation": ["highLungeEH", "highLungeEA", "highLungeEF"],
                        "attributes": ["a"]
                ],
                "lowLungeYL":
                    [
                        "name": ["lowLungeYL"],
                        "demonstration": ["lowLunge"], // "lowLunge1", "lowLunge2", "lowLunge3", "lowLunge4", "lowLunge5", "lowLunge6"],
                        "explanation": ["lowLungeYEH", "lowLungeYEA", "lowLungeYEF"],
                        "attributes": [""]
                ], //
                "lowLungeYR":
                    [
                        "name": ["lowLungeYR"],
                        "demonstration": ["lowLunge"], // "lowLunge1", "lowLunge2", "lowLunge3", "lowLunge4", "lowLunge5", "lowLunge6"],
                        "explanation": ["lowLungeYEH", "lowLungeYEA", "lowLungeYEF"],
                        "attributes": ["a"]
                ],
                "deepSquat":
                    [
                        "name": ["deepSquat"],
                        "demonstration": ["deepSquat"], // "deepSquat1", "deepSquat2", "deepSquat3", "deepSquat4", "deepSquat5"],
                        "explanation": ["deepSquatEH", "deepSquatEA", "deepSquatEF"],
                        "attributes": [""]
                ],
                // Hand/Elbows and Feet/Knees
                "dolphin":
                    [
                        "name": ["dolphin"],
                        "demonstration": ["dolphin"], // "dolphin1", "dolphin2", "dolphin3"],
                        "explanation": ["dolphinEH", "dolphinEA", "dolphinEF"],
                        "attributes": [""]
                ],
                "downwardDog":
                    [
                        "name": ["downwardDog"],
                        "demonstration": ["downwardDog"], // "downwardDog1", "downwardDog2", "downwardDog3", "downwardDog4"],
                        "explanation": ["downwardDogEH", "downwardDogEA", "downwardDogEF"],
                        "attributes": [""]
                ],
                "halfDownwardDogL":
                    [
                        "name": ["halfDownwardDogL"],
                        "demonstration": ["halfDownwardDog"], // "halfDownwardDog1", "halfDownwardDog2", "halfDownwardDog3", "halfDownwardDog4"],
                        "explanation": ["halfDownwardDogEH", "halfDownwardDogEA", "halfDownwardDogEF"],
                        "attributes": [""]
                ], //
                "halfDownwardDogR":
                    [
                        "name": ["halfDownwardDogR"],
                        "demonstration": ["halfDownwardDog"], // "halfDownwardDog1", "halfDownwardDog2", "halfDownwardDog3", "halfDownwardDog4"],
                        "explanation": ["halfDownwardDogEH", "halfDownwardDogEA", "halfDownwardDogEF"],
                        "attributes": ["a"]
                ],
                "dolphinPlank":
                    [
                        "name": ["dolphinPlank"],
                        "demonstration": ["dolphinPlank"],
                        "explanation": ["dolphinPlankEH", "dolphinPlankEA", "dolphinPlankEF"],
                        "attributes": [""]
                ],
                "fourLimbedStaff":
                    [
                        "name": ["fourLimbedStaff"],
                        "demonstration": ["fourLimbedStaff"],
                        "explanation": ["fourLimbedStaffEH", "fourLimbedStaffEA", "fourLimbedStaffEF"],
                        "attributes": [""]
                ],
                "sidePlankL":
                    [
                        "name": ["sidePlankL"],
                        "demonstration": ["sidePlank"], // "sidePlank1", "sidePlank2", "sidePlank3", "sidePlank4"],
                        "explanation": ["sidePlankEH", "sidePlankEA", "sidePlankEF"],
                        "attributes": [""]
                ], //
                "sidePlankR":
                    [
                        "name": ["sidePlankR"],
                        "demonstration": ["sidePlank"], // "sidePlank1", "sidePlank2", "sidePlank3", "sidePlank4"],
                        "explanation": ["sidePlankEH", "sidePlankEA", "sidePlankEF"],
                        "attributes": ["a"]
                ],
                "cat":
                    [
                        "name": ["cat"],
                        "demonstration": ["cat"],
                        "explanation": ["catEH", "catEA", "catEF"],
                        "attributes": [""]
                ],
                "cow":
                    [
                        "name": ["cow"],
                        "demonstration": ["cow"],
                        "explanation": ["cowEH", "cowEA", "cowEF"],
                        "attributes": [""]
                ],
                "catCow":
                    [
                        "name": ["catCow"],
                        "demonstration": ["cat"], // "catCow1", "catCow2", "catCow1", "catCow3", "catCow1"],
                        "explanation": ["catCowEH", "catCowEA", "catCowEF"],
                        "attributes": [""]
                ],
                "halfMonkeyL":
                    [
                        "name": ["halfMonkeyL"],
                        "demonstration": ["halfMonkey"], // "halfMonkey1", "halfMonkey2", "halfMonkey3", "halfMonkey4"],
                        "explanation": ["halfMonkeyEH", "halfMonkeyEA", "halfMonkeyEF"],
                        "attributes": [""]
                ], //
                "halfMonkeyR":
                    [
                        "name": ["halfMonkeyR"],
                        "demonstration": ["halfMonkey"], // "halfMonkey1", "halfMonkey2", "halfMonkey3", "halfMonkey4"],
                        "explanation": ["halfMonkeyEH", "halfMonkeyEA", "halfMonkeyEF"],
                        "attributes": ["a"]
                ],
                "childPose":
                    [
                        "name": ["childPose"],
                        "demonstration": ["childPose"], // "childPose1", "childPose2", "childPose3"],
                        "explanation": ["childPoseEH", "childPoseEA", "childPoseEF"],
                        "attributes": [""]
                ],
                "wildThingL":
                    [
                        "name": ["wildThingL"],
                        "demonstration": ["wildThing"], // "wildThing1", "wildThing2", "wildThing3", "wildThing4", "wildThing5", "wildThing6"],
                        "explanation": ["wildThingEH", "wildThingEA", "wildThingEF"],
                        "attributes": ["a"]
                ], //
                "wildThingR":
                    [
                        "name": ["wildThingR"],
                        "demonstration": ["wildThing"], // "wildThing1", "wildThing2", "wildThing3", "wildThing4", "wildThing5", "wildThing6"],
                        "explanation": ["wildThingEH", "wildThingEA", "wildThingEF"],
                        "attributes": [""]
                ],
                "upwardBow":
                    [
                        "name": ["upwardBow"],
                        "demonstration": ["upwardBow"], // "upwardBow1", "upwardBow2", "upwardBow3", "upwardBow4", "upwardBow5"],
                        "explanation": ["upwardBowEH", "upwardBowEA", "upwardBowEF"],
                        "attributes": [""]
                ],
                "bridge":
                    [
                        "name": ["bridge"],
                        "demonstration": ["bridge"], // "bridge1", "bridge2", "bridge3"],
                        "explanation": ["bridgeEH", "bridgeEA", "bridgeEF"],
                        "attributes": [""]
                ],
                "upwardPlank":
                    [
                        "name": ["upwardPlank"],
                        "demonstration": ["upwardPlank"], // "upwardPlank1", "upwardPlank2", "upwardPlank3", "upwardPlank4", "upwardPlank5"],
                        "explanation": ["upwardPlankEH", "upwardPlankEA", "upwardPlankEF"],
                        "attributes": [""]
                ],
                "extendedPuppy":
                    [
                        "name": ["extendedPuppy"],
                        "demonstration": ["extendedPuppy"], // "extendedPuppy1", "extendedPuppy2", "extendedPuppy3", "extendedPuppy4", "extendedPuppy5"],
                        "explanation": ["extendedPuppyEH", "extendedPuppyEA", "extendedPuppyEF"],
                        "attributes": [""]
                ],
                "upwardsDogY":
                    [
                        "name": ["upwardsDogY"],
                        "demonstration": ["upwardsDogY"], // "upwardsDogY1", "upwardsDogY2", "upwardsDogY3", "upwardsDogY4"],
                        "explanation": ["upwardsDogYEH", "upwardsDogYEA", "upwardsDogYEF"],
                        "attributes": [""]
                ],
                // Seated
                "crossLeg":
                    [
                        "name": ["crossLeg"],
                        "demonstration": ["crossLegged"],
                        "explanation": ["crossLegEH", "crossLegEA", "crossLegEF"],
                        "attributes": [""]
                ],
                "lotus":
                    [
                        "name": ["lotus"],
                        "demonstration": ["lotus"],
                        "explanation": ["lotusEH", "lotusEA", "lotusEF"],
                        "attributes": [""]
                ],
                "fireLogL":
                    [
                        "name": ["fireLogL"],
                        "demonstration": ["fireLog"],
                        "explanation": ["fireLogEH", "fireLogEA", "fireLogEF"],
                        "attributes": [""]
                ], //
                "fireLogR":
                    [
                        "name": ["fireLogR"],
                        "demonstration": ["fireLog"],
                        "explanation": ["fireLogEH", "fireLogEA", "fireLogEF"],
                        "attributes": ["a"]
                ],
                "boat":
                    [
                        "name": ["boat"],
                        "demonstration": ["boat"],
                        "explanation": ["boatEH", "boatEA", "boatEF"],
                        "attributes": [""]
                ],
                "cowFaceL":
                    [
                        "name": ["cowFaceL"],
                        "demonstration": ["cowFace"],
                        "explanation": ["cowFaceEH", "cowFaceEA", "cowFaceEF"],
                        "attributes": ["a"]
                ], //
                "cowFaceR":
                    [
                        "name": ["cowFaceR"],
                        "demonstration": ["cowFace"],
                        "explanation": ["cowFaceEH", "cowFaceEA", "cowFaceEF"],
                        "attributes": [""]
                ],
                "hero":
                    [
                        "name": ["hero"],
                        "demonstration": ["hero"],
                        "explanation": ["heroEH", "heroEA", "heroEF"],
                        "attributes": [""]
                ],
                "butterfly":
                    [
                        "name": ["butterfly"],
                        "demonstration": ["butterfly"],
                        "explanation": ["butterflyEH", "butterflyEA", "butterflyEF"],
                        "attributes": [""]
                ],
                "staffPose":
                    [
                        "name": ["staffPose"],
                        "demonstration": ["staff"],
                        "explanation": ["staffPoseEH", "staffPoseEA", "staffPoseEF"],
                        "attributes": [""]
                ],
                "seatedForwardBend":
                    [
                        "name": ["seatedForwardBend"],
                        "demonstration": ["seatedForwardBend"],
                        "explanation": ["seatedForwardBendEH", "seatedForwardBendEA", "seatedForwardBendEF"],
                        "attributes": [""]
                ],
                "vForwardBend":
                    [
                        "name": ["vForwardBend"],
                        "demonstration": ["vForwardBend"],
                        "explanation": ["vForwardBendEH", "vForwardBendEA", "vForwardBendEF"],
                        "attributes": [""]
                ],
                "vSideBendL":
                    [
                        "name": ["vSideBendL"],
                        "demonstration": ["vSideBend"], // "vSideBend1", "vSideBend2", "vSideBend3", "vSideBend4", "vSideBend5"],
                        "explanation": ["vSideBendH", "vSideBendA", "vSideBendF"],
                        "attributes": [""]
                ], //
                "vSideBendR":
                    [
                        "name": ["vSideBendR"],
                        "demonstration": ["vSideBend"], //, "vSideBend1", "vSideBend2", "vSideBend3", "vSideBend4", "vSideBend5"],
                        "explanation": ["vSideBendH", "vSideBendA", "vSideBendF"],
                        "attributes": ["a"]
                ],
                "halfVForwardBendL":
                    [
                        "name": ["halfVForwardBendL"],
                        "demonstration": ["halfVForwardBend"], // "halfVForwardBend1", "halfVForwardBend2", "halfVForwardBend3", "halfVForwardBend4", "halfVForwardBend5", "halfVForwardBend6"],
                        "explanation": ["halfVForwardBendEH", "halfVForwardBendEA", "halfVForwardBendEF"],
                        "attributes": [""]
                ], //
                "halfVForwardBendR":
                    [
                        "name": ["halfVForwardBendR"],
                        "demonstration": ["halfVForwardBend"], // "halfVForwardBend1", "halfVForwardBend2", "halfVForwardBend3", "halfVForwardBend4", "halfVForwardBend5", "halfVForwardBend6"],
                        "explanation": ["halfVForwardBendEH", "halfVForwardBendEA", "halfVForwardBendEF"],
                        "attributes": ["a"]
                ],
                "halfVSideBendL":
                    [
                        "name": ["halfVSideBendL"],
                        "demonstration": ["halfVSideBend"], // "halfVSideBend1", "halfVSideBend2", "halfVSideBend3", "halfVSideBend4", "halfVSideBend5"],
                        "explanation": ["halfVSideBendEH", "halfVSideBendEA", "halfVSideBendEF"],
                        "attributes": [""]
                ],
                "halfVSideBendR":
                    [
                        "name": ["halfVSideBendR"],
                        "demonstration": ["halfVSideBend"], // "halfVSideBend1", "halfVSideBend2", "halfVSideBend3", "halfVSideBend4", "halfVSideBend5"],
                        "explanation": ["halfVSideBendEH", "halfVSideBendEA", "halfVSideBendEF"],
                        "attributes": ["a"]
                ],
                "marichi1L":
                    [
                        "name": ["marichi1L"],
                        "demonstration": ["marichi1"], // "marichi11", "marichi12", "marichi13", "marichi14", "marichi15", "marichi16", "marichi17"],
                        "explanation": ["marichi1EH", "marichi1EA", "marichi1EF"],
                        "attributes": ["a"]
                ], //
                "marichi1R":
                    [
                        "name": ["marichi1R"],
                        "demonstration": ["marichi1"], // "marichi11", "marichi12", "marichi13", "marichi14", "marichi15", "marichi16", "marichi17"],
                        "explanation": ["marichi1EH", "marichi1EA", "marichi1EF"],
                        "attributes": [""]
                ],
                "marichi3L":
                    [
                        "name": ["marichi3L"],
                        "demonstration": ["marichi3"], // "marichi31", "marichi32", "marichi33", "marichi34", "marichi35", "marichi36", "marichi37"],
                        "explanation": ["marichi3EH", "marichi3EA", "marichi3EF"],
                        "attributes": ["a"]
                ], //
                "marichi3R":
                    [
                        "name": ["marichi3R"],
                        "demonstration": ["marichi3"], // "marichi31", "marichi32", "marichi33", "marichi34", "marichi35", "marichi36", "marichi37"],
                        "explanation": ["marichi3EH", "marichi3EA", "marichi3EF"],
                        "attributes": [""]
                ],
                "frontSplitL":
                    [
                        "name": ["frontSplitL"],
                        "demonstration": ["frontSplit"],
                        "explanation": ["frontSplitEH", "frontSplitEA", "frontSplitEF"],
                        "attributes": [""]
                ], //
                "frontSplitR":
                    [
                        "name": ["frontSplitR"],
                        "demonstration": ["frontSplit"],
                        "explanation": ["frontSplitEH", "frontSplitEA", "frontSplitEF"],
                        "attributes": ["a"]
                ],
                "sideSplit":
                    [
                        "name": ["sideSplit"],
                        "demonstration": ["sideSplit"],
                        "explanation": ["sideSplitEH", "sideSplitEA", "sideSplitEF"],
                        "attributes": [""]
                ],
                // Lying
                "corpse":
                    [
                        "name": ["corpse"],
                        "demonstration": ["corpse"],
                        "explanation": ["corpseEH", "corpseEA", "corpseEF"],
                        "attributes": [""]
                ],
                "fish":
                    [
                        "name": ["fish"],
                        "demonstration": ["fish"], // "fish1", "fish2", "fish3", "fish4", "fish5"],
                        "explanation": ["fishEH", "fishEA", "fishEF"],
                        "attributes": [""]
                ],
                "happyBaby":
                    [
                        "name": ["happyBaby"],
                        "demonstration": ["happyBaby"],
                        "explanation": ["happyBabyEH", "happyBabyEA", "happyBabyEF"],
                        "attributes": [""]
                ],
                "lyingButterfly":
                    [
                        "name": ["lyingButterfly"],
                        "demonstration": ["lyingButterfly"], // "lyingButterfly1", "lyingButterfly2", "lyingButterfly3", "lyingButterfly4"],
                        "explanation": ["lyingButterflyEH", "lyingButterflyEA", "lyingButterflyEF"],
                        "attributes": [""]
                ],
                "legRaiseToeL":
                    [
                        "name": ["legRaiseToeL"],
                        "demonstration": ["legRaiseToe"],
                        "explanation": ["legRaiseToeEH", "legRaiseToeEA", "legRaiseToeEF"],
                        "attributes": ["a"]
                ], //
                "legRaiseToeR":
                    [
                        "name": ["legRaiseToeR"],
                        "demonstration": ["legRaiseToe"],
                        "explanation": ["legRaiseToeEH", "legRaiseToeEA", "legRaiseToeEF"],
                        "attributes": [""]
                ],
                "threadTheNeedleYL":
                    [
                        "name": ["threadTheNeedleYL"],
                        "demonstration": ["threadTheNeedle"], // "threadTheNeedle1", "threadTheNeedle2", "threadTheNeedle3", "threadTheNeedle4", "threadTheNeedle5"],
                        "explanation": ["threadTheNeedleEH", "threadTheNeedleEA", "threadTheNeedleEF"],
                        "attributes": ["a"]
                ], //
                "threadTheNeedleYR":
                    [
                        "name": ["threadTheNeedleYR"],
                        "demonstration": ["threadTheNeedle"], // "threadTheNeedle1", "threadTheNeedle2", "threadTheNeedle3", "threadTheNeedle4", "threadTheNeedle5"],
                        "explanation": ["threadTheNeedleEH", "threadTheNeedleEA", "threadTheNeedleEF"],
                        "attributes": [""]
                ],
                "shoulderStand":
                    [
                        "name": ["shoulderStand"],
                        "demonstration": ["shoulderStand"], // "shoulderStand1", "shoulderStand2", "shoulderStand3", "shoulderStand4", "shoulderStand5", "shoulderStand6", "shoulderStand7"],
                        "explanation": ["shoulderStandEH", "shoulderStandEA", "shoulderStandEF"],
                        "attributes": [""]
                ],
                "plow":
                    [
                        "name": ["plow"],
                        "demonstration": ["plow"], // "plow1", "plow2", "plow3", "plow4"],
                        "explanation": ["plowEH", "plowEA", "plowEF"],
                        "attributes": [""]
                ],
                "cobra":
                    [
                        "name": ["cobra"],
                        "demonstration": ["cobra"], // "cobra1", "cobra2", "cobra3", "cobra4"],
                        "explanation": ["cobraEH", "cobraEA", "cobraEF"],
                        "attributes": [""]
                ],
                "sphinx":
                    [
                        "name": ["sphinx"],
                        "demonstration": ["sphinx"],
                        "explanation": ["sphinxEH", "sphinxEA", "sphinxEF"],
                        "attributes": [""]
                ],
                "pigeonL":
                    [
                        "name": ["pigeonL"],
                        "demonstration": ["pigeon"], // "pigeon1", "pigeon2", "pigeon3", "pigeon4", "pigeon5", "pigeon6", "pigeon7", "pigeon8"],
                        "explanation": ["pigeonEH", "pigeonEA", "pigeonEF"],
                        "attributes": [""]
                ], //
                "pigeonR":
                    [
                        "name": ["pigeonR"],
                        "demonstration": ["pigeon"], // "pigeon1", "pigeon2", "pigeon3", "pigeon4", "pigeon5", "pigeon6", "pigeon7", "pigeon8"],
                        "explanation": ["pigeonEH", "pigeonEA", "pigeonEF"],
                        "attributes": ["a"]
                ],
                "spineRolling":
                    [
                        "name": ["spineRolling"],
                        "demonstration": ["spineRolling"], // "spineRolling1", "spineRolling2", "spineRolling3", "spineRolling2", "spineRolling4", "spineRolling2", "spineRolling3", "spineRolling2", "spineRolling4"],
                        "explanation": ["spineRollingEH", "spineRollingEA", "spineRollingEF"],
                        "attributes": [""]
                ],
                // Hand Stands
                "handstand":
                    [
                        "name": ["handstand"],
                        "demonstration": ["handStand"], // "handStand1", "handStand2", "handStand3", "handStand4", "handStand5", "handStand6", "handStand7", "handStand8"],
                        "explanation": ["handstandEH", "handstandEA", "handstandEF"],
                        "attributes": [""]
                ],
                "headstand":
                    [
                        "name": ["headstand"],
                        "demonstration": ["headStand"], // "headStand1", "headStand2", "headStand3", "headStand4", "headStand5", "headStand6", "headStand7", "headStand8"],
                        "explanation": ["headstandEH", "headstandEA", "headstandEF"],
                        "attributes": [""]
                ],
                "forearmStand":
                    [
                        "name": ["forearmStand"],
                        "demonstration": ["forearmStand"], // "forearmStand1", "forearmStand2", "forearmStand3", "forearmStand4", "forearmStand5", "forearmStand6"],
                        "explanation": ["forearmStandEH", "forearmStandEA", "forearmStandEF"],
                        "attributes": [""]
                ]
            ]
    ]
    
}
