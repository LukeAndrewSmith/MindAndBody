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
            let snapshot = containerView.viewWithTag(12345)
            else {
                return
        }
        //

        var snapshot2 = UIView()
        var snapshot1 = UIView()
        //
        var toVC = UIViewController()
        //        if MenuVariables.shared.isNewView = true {
        let viewNamesArray: [String] = ["view0", "view1", "view2", "view3", "view4"]
        //
        switch MenuVariables.shared.menuIndex {
        case 0:
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! MindBodyNavigation
        //
        case 1:
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! ScheduleNavigation
        //
        case 2:
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! TrackingNavigation
        //
        case 3:
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! LessonsNavigation
        //
        case 4:
            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! SettingsNavigation
        //
        default: break
        }

        let keyWindow = UIApplication.shared.keyWindow
        //
        snapshot1 = UIScreen.main.snapshotView(afterScreenUpdates: false)
        keyWindow?.addSubview(snapshot1)
        keyWindow?.bringSubview(toFront: snapshot1)

        if MenuVariables.shared.isNewView == false {
            keyWindow?.addSubview(snapshot)
            keyWindow?.bringSubview(toFront: snapshot)
        } else {
            //
            snapshot.removeFromSuperview()
            //
            snapshot2 = toVC.view.snapshotView(afterScreenUpdates: true)!
            snapshot2.center.x += UIScreen.main.bounds.width * 0.75
            snapshot2.layer.shadowOpacity = 1
            snapshot2.layer.shadowRadius = 15
            keyWindow?.addSubview(snapshot2)
            keyWindow?.bringSubview(toFront: snapshot2)
        }

        //
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            if MenuVariables.shared.isNewView == false {
                snapshot.center.x = UIScreen.main.bounds.width * 0.5
            } else {
                snapshot2.center.x = UIScreen.main.bounds.width * 0.5
            }

        }, completion: { _ in
            let didTransitionComplete = !transitionContext.transitionWasCancelled
            if didTransitionComplete {
                // 3
                if MenuVariables.shared.isNewView == false {
                    snapshot.removeFromSuperview()
                    snapshot1.removeFromSuperview()
                } else {
                    toVC.view.layer.shadowRadius = 0
                    snapshot1.removeFromSuperview()
                    snapshot2.removeFromSuperview()
                }
            }
            transitionContext.completeTransition(didTransitionComplete)
        })
    }
}









//class DismissMenuAnimator : NSObject {
//}
//
//extension DismissMenuAnimator : UIViewControllerAnimatedTransitioning {
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.5
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard
//            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
//            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//            else {
//                return
//        }
//        let containerView = transitionContext.containerView
//        let snapshot = containerView.viewWithTag(MenuHelper.snapshotNumber)
//
////        var snapshot2 = UIView()
//        //        var snapshot1 = UIView()
//        //        //
//        //        var toVC = UIViewController()
//        //        //        if MenuVariables.shared.isNewView = true {
//        //        let viewNamesArray: [String] = ["view0", "view1", "view2", "view3", "view4"]
//        //        //
//        //        switch MenuVariables.shared.menuIndex {
//        //        case 0:
//        //            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! MindBodyNavigation
//        //        //
//        //        case 1:
//        //            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! ScheduleNavigation
//        //        //
//        //        case 2:
//        //            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! TrackingNavigation
//        //        //
//        //        case 3:
//        //            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! LessonsNavigation
//        //        //
//        //        case 4:
//        //            toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! SettingsNavigation
//        //        //
//        //        default: break
//        //        }
//        //
//        //        let keyWindow = UIApplication.shared.keyWindow
//        //        //
//        //        snapshot1 = UIScreen.main.snapshotView(afterScreenUpdates: false)
//        //        keyWindow?.addSubview(snapshot1)
//        //        keyWindow?.bringSubview(toFront: snapshot1)
//        //
//        //        if MenuVariables.shared.isNewView == false {
//        //            keyWindow?.addSubview(snapshot)
//        //            keyWindow?.bringSubview(toFront: snapshot)
//        //        } else {
//        //            //
//        //            snapshot.removeFromSuperview()
//        //            //
//        //            snapshot2 = toVC.view.snapshotView(afterScreenUpdates: true)!
//        //            snapshot2.center.x += UIScreen.main.bounds.width * 0.75
//        //            snapshot2.layer.shadowOpacity = 1
//        //            snapshot2.layer.shadowRadius = 15
//        //            keyWindow?.addSubview(snapshot2)
//        //            keyWindow?.bringSubview(toFront: snapshot2)
//        //        }
//
//        // Different animation for button press or pan gesture
//        // Press
//        if MenuVariables.shared.menuInteractionType == 0 {
//            UIView.animate(
//                withDuration: transitionDuration(using: transitionContext),
//                animations: {
//                    snapshot?.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
//            },
//                completion: { _ in
//                    let didTransitionComplete = !transitionContext.transitionWasCancelled
//                    if didTransitionComplete {
//                        containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
//                        snapshot?.removeFromSuperview()
//                    }
//                    transitionContext.completeTransition(didTransitionComplete)
//            })
//        // Pan
//        } else {
////            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
////
////                if MenuVariables.shared.isNewView == false {
////                    snapshot.center.x = UIScreen.main.bounds.width * 0.5
////                } else {
////                    snapshot2.center.x = UIScreen.main.bounds.width * 0.5
////                }
////
////            }, completion: { _ in
////                let didTransitionComplete = !transitionContext.transitionWasCancelled
////                if didTransitionComplete {
////                    // 3
////                    if MenuVariables.shared.isNewView == false {
////                        snapshot.removeFromSuperview()
////                        snapshot1.removeFromSuperview()
////                    } else {
////                        toVC.view.layer.shadowRadius = 0
////                        snapshot1.removeFromSuperview()
////                        snapshot2.removeFromSuperview()
////                    }
////                }
////                transitionContext.completeTransition(didTransitionComplete)
//        }
//    }
//}

