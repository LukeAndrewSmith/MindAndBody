//
//  PresentMenuAnimator.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import UIKit

class PresentMenuAnimator : NSObject {
}

extension PresentMenuAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        // replace main view with snapshot
        if let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false) {
            snapshot.tag = MenuHelper.snapshotNumber
            snapshot.isUserInteractionEnabled = false
            snapshot.layer.shadowOpacity = 1
            snapshot.layer.shadowRadius = 15
            
            containerView.insertSubview(snapshot, aboveSubview: toVC.view)
            fromVC.view.isHidden = true
            
            // Different animation for button press or pan gesture
            //
            // Press
            if MenuVariables.shared.menuInteractionType == 0 {
                UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    snapshot.center.x += UIScreen.main.bounds.width * MenuHelper.menuWidth
                },
                               completion: { _ in
                                fromVC.view.isHidden = false
                                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            //
            // Pan
            } else {
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    snapshot.center.x += UIScreen.main.bounds.width * MenuHelper.menuWidth
                },
                               completion: { _ in
                                fromVC.view.isHidden = false
                                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        }
    }
}
