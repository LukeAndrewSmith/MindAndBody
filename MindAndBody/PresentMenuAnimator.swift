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
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
            else {
                return
        }
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        // replace main view with snapshot
        
        snapshot.tag = MenuHelper.snapshotNumber
        snapshot.isUserInteractionEnabled = false
        snapshot.layer.shadowOpacity = 1
        snapshot.layer.shadowRadius = 15
        containerView.insertSubview(snapshot, aboveSubview: toVC.view)
        fromVC.view.isHidden = true
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                snapshot.center.x += UIScreen.main.bounds.width * MenuHelper.menuWidth
        },
            completion: { _ in
                fromVC.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        )
    }
}
