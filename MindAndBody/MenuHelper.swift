//
//  MenuHelper.swift
//  MindAndBody
//
//  Created by Luke Smith on 07.02.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

enum Direction {
    case Up
    case Down
    case Left
    case Right
}

struct MenuHelper {
    
    static let menuWidth:CGFloat = 0.75
    
    static let percentThreshold:CGFloat = 0.3
    
    static let snapshotNumber = 12345
    
    static func calculateProgress(_ translationInView:CGPoint, viewBounds:CGRect, direction:Direction) -> CGFloat {
        // Direction
        switch direction {
        case .Right: // positive
            let percentageProgress = translationInView.x / (viewBounds.width * menuWidth)
            if percentageProgress > 0.3 {
                UIApplication.shared.statusBarStyle = .default
            } else {
                UIApplication.shared.statusBarStyle = .lightContent
            }
            return percentageProgress
        case .Left: // negative
            // -1 as translation is negative
            let percentageProgress = (-1 * translationInView.x) / (viewBounds.width * menuWidth)
            return percentageProgress
        default: return 0
        }
    }
    
    static func mapGestureStateToInteractor(_ gestureState:UIGestureRecognizerState, progress:CGFloat, interactor: Interactor?, triggerSegue: () -> ()){
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
