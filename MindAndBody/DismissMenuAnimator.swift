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
        return 0.4
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
    
        var snapshot2 = UIView()
        var snapshot1 = UIView()
        //
        var toVC = UIViewController()
//        if new == true {
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
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! LessonsNavigation
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
        
            
        //
        snapshot1 = UIScreen.main.snapshotView(afterScreenUpdates: false)
        snapshot2 = toVC.view.snapshotView(afterScreenUpdates: true)!
            
        let keyWindow = UIApplication.shared.keyWindow
        // Snapshot 1
        keyWindow?.addSubview(snapshot1)
        keyWindow?.bringSubview(toFront: snapshot1)
        
        // Snapshot 2
        snapshot2.center.x += UIScreen.main.bounds.width * 0.75
        snapshot2.layer.shadowOpacity = 1
        snapshot2.layer.shadowRadius = 15
        keyWindow?.addSubview(snapshot2)
        keyWindow?.bringSubview(toFront: snapshot2)
        
        //
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                snapshot2.center.x = UIScreen.main.bounds.width * 0.5
        },
            completion: { _ in
                let didTransitionComplete = !transitionContext.transitionWasCancelled
                if didTransitionComplete {
                    // 3   
                    //if new == true {
                        toVC.view.layer.shadowRadius = 0
                    //}
                    snapshot1.removeFromSuperview()
                    snapshot2.removeFromSuperview()
                    //
                    snapshot.removeFromSuperview()
                }
                transitionContext.completeTransition(didTransitionComplete)
        })
    }
}

