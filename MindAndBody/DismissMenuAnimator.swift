//
//  DismissMenuAnimator.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import UIKit

class DismissMenuAnimator : NSObject {
}

extension DismissMenuAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC2 = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let snapshot = containerView.viewWithTag(12345)
            else {
                return
        }
        //
    
        var toVC = UIViewController()
        var newSnapshot = UIView()
        if new == true {
        let viewNamesArray: [String] = ["view0", "view1", "view2", "view3", "view4", "view5"]
        //
        switch tabBarIndex {
        case 0:
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! MindBodyNavigation
        //
        case 1:
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! CalendarNavigation
        //
        case 2:
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! TrackingNavigation
        //
        case 3:
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! InformationNavigation
        //
        case 4:
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! ProfileNavigation
        //
        case 5:
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! SettingsNavigation
        //
        default: break
        }
    
        // Load new view
        snapshot.removeFromSuperview()
        containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
        toVC.view.center.x += UIScreen.main.bounds.width * 0.75
        toVC.view.layer.shadowOpacity = 1
        toVC.view.layer.shadowRadius = 15
        
        //
        newSnapshot = toVC.view.snapshotView(afterScreenUpdates: true)!
        toVC2.view.addSubview(newSnapshot)
        }
        

        //
        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            animations: {
                //
                if new == true {
                    toVC.view.center.x = UIScreen.main.bounds.width * 0.5
                } else {
                    snapshot.center.x = UIScreen.main.bounds.width * 0.5
                }
        },
            completion: { _ in
                let didTransitionComplete = !transitionContext.transitionWasCancelled
                if didTransitionComplete {
                    // 3   
                    if new == true {
                        toVC.view.layer.shadowRadius = 0
                        fromVC.dismiss(animated: true)
                        toVC.dismiss(animated:true)
                        //toVC2.present(toVC, animated: false, completion: nil)
                        //
                        let delayInSeconds = 0.5
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                            toVC2.present(toVC, animated: false, completion: { finished in
                                newSnapshot.removeFromSuperview()
                            })
                        }
                    }
                    snapshot.removeFromSuperview()
                }
                transitionContext.completeTransition(didTransitionComplete)
        })
    }
}

