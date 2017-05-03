//
//  MenuHelper.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

enum Direction {
    case Up
    case Down
    case Left
    case Right
}

//
struct MenuHelper {
    // Width of Slide out menu
    static let menuWidth:CGFloat = 0.8
    // Distance needed to slide before menu changes states
    static let percentThreshold:CGFloat = 0.3
    // tag snapshot
    static let snapshotNumber = 12345
    
    
    // Translation = users touch coordinates
    // view bounds = screen dimensions
    // Direction = direction of slide out menu
    static func calculateProgress(translationInView:CGPoint, viewBounds:CGRect, direction:Direction) -> CGFloat {
        let pointOnAxis:CGFloat
        let axisLength:CGFloat
        switch direction {
        case .Up, .Down:
            pointOnAxis = translationInView.y
            axisLength = viewBounds.height
        case .Left, .Right:
            pointOnAxis = translationInView.x
            axisLength = viewBounds.width
        }
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis:Float
        let positiveMovementOnAxisPercent:Float
        switch direction {
        case .Right, .Down: // positive
            positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
            return CGFloat(positiveMovementOnAxisPercent)
        case .Up, .Left: // negative
            positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fmaxf(positiveMovementOnAxis, -1.0)
            return CGFloat(-positiveMovementOnAxisPercent)
        }
    }
    
    // gestureState = State of Pan
    // progress = progress of pan
    // interactor = perccent driven interactor
    // trigger segue = initiate transition
    static func mapGestureStateToInteractor(gestureState:UIGestureRecognizerState, progress:CGFloat, interactor: Interactor?, triggerSegue: () -> Void){
        guard let interactor = interactor else { return }
        switch gestureState {
        case .began:
            interactor.hasStarted = true
            triggerSegue()
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
    }
}
