 //
//  ScheduleAnimationHelpers.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

extension ScheduleScreen {
    //
    // MARK: Helper Functions View layout/slides etc.
    //
    // MARK: Day Indicator
    func animateDayIndicatorToDay() {
        // Animate
        dayIndicatorLeading.constant = self.stackArray[ScheduleVariables.shared.selectedDay].frame.minX
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            self.view.layoutIfNeeded()
        })
    }
    
    //
    // MARK: Mask Views
    // Mask view func
    func maskView(animated: Bool) {
        // Animate mask view if group selected and mask doesnt already exist
        if ScheduleVariables.shared.choiceProgress[0] != -1 && view.subviews.contains(maskView1) == false {
            createMaskView(alpha: 0)
            if animated {
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    self.maskView1.alpha = 0.72
                    self.maskView2.alpha = 0.72
                    self.maskView3.alpha = 0.72
                })
            } else {
                self.maskView1.alpha = 0.72
                self.maskView2.alpha = 0.72
                self.maskView3.alpha = 0.72
            }
        }
    }
    // Session selection mask
        // Previous Question!!!!
    @objc func maskAction() {
        // Table Counter
        // Return to choice 1 (sessions)
        if ScheduleVariables.shared.choiceProgress[1] > 1 {
            // Workout has 2 choice paths for the length
            if ScheduleVariables.shared.choiceProgress[0] == 0 {
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Go back from final choice
                case 6:
                    // Go back to length 1
                    if indicator == "gym" && indicator2 == "classic" {
                        ScheduleVariables.shared.choiceProgress[1] = 4
                        // Go back to length 2
                    } else {
                        ScheduleVariables.shared.choiceProgress[1] = 5
                    }
                // Go back from length choice
                case 5:
                    // Go back to chioce 3
                    ScheduleVariables.shared.choiceProgress[1] = 3
                default:
                    ScheduleVariables.shared.choiceProgress[1] -= 1
                }
            // Yoga has 3 choice paths for the length
            } else if ScheduleVariables.shared.choiceProgress[0] == 1 {
                switch ScheduleVariables.shared.choiceProgress[1] {
                // Go back from final choice
                case 5:
                    // Go back to length 1
                    switch indicator {
                    case "relaxing":
                        ScheduleVariables.shared.choiceProgress[1] = 2
                    case "neutral":
                        ScheduleVariables.shared.choiceProgress[1] = 3
                    case "stimulating":
                        ScheduleVariables.shared.choiceProgress[1] = 4
                    default: break
                    }
                // Go back from length choice
                case 4,3:
                    // Go back to chioce 3
                    ScheduleVariables.shared.choiceProgress[1] = 1
                default:
                    ScheduleVariables.shared.choiceProgress[1] -= 1
                }
            // Endurance has 3 choice paths
            } else if ScheduleVariables.shared.choiceProgress[0] == 2 && ScheduleVariables.shared.choiceProgress[1] == 5 || ScheduleVariables.shared.choiceProgress[0] == 2 && ScheduleVariables.shared.choiceProgress[1] == 3 {
            // TODO: && selectedChoiceWarmup[3] == 3 { ??
                ScheduleVariables.shared.choiceProgress[1] = 1
            } else {
                ScheduleVariables.shared.choiceProgress[1] -= 1
            }
            slideRight()
            maskView3.backgroundColor = .black
        // Return to choice 0 (groups)
        } else if ScheduleVariables.shared.choiceProgress[1] == 1 {
            backToBeginning()
        }
    }
    // Return to choice 0 (groups)
    @objc func backToBeginning() {
        // Return to choice 0 (groups)
        ScheduleVariables.shared.choiceProgress[0] = -1
        ScheduleVariables.shared.choiceProgress[1] = 0
        // Enable table scroll & schedule choice button & remove mask view
        scheduleTableScrollCheck()
        navigationBar.rightBarButtonItem?.isEnabled = true
        removeMaskView()
        slideRight()
    }
    // Open Schedule, check if mask views necessary
    func checkMaskView() {
        if ScheduleVariables.shared.choiceProgress[0] != -1 {
            createMaskView(alpha: 0.72)
        }
    }
    // Mask Views -----------------------------------
    // Create Mask Views
    func createMaskView(alpha: CGFloat) {
        // Disable table scroll & schedule choice button
        scheduleTableScrollCheck()
        navigationBar.rightBarButtonItem?.isEnabled = false
        //
        let screenFrame = UIScreen.main.bounds
        //
        maskView1.addTarget(self, action: #selector(maskAction), for: .touchUpInside)
        maskView2.addTarget(self, action: #selector(maskAction), for: .touchUpInside)
        //
        maskView1.frame = CGRect(x: 0, y: 0, width: screenFrame.width, height: (screenFrame.height - TopBarHeights.combinedHeight - pageStack.bounds.height) / 4)
        maskView2.frame = CGRect(x: 0, y: scheduleTable.frame.maxY, width: screenFrame.width, height: pageStack.bounds.height)
        //
        maskView1.backgroundColor = .black
        maskView1.alpha = alpha
        maskView2.backgroundColor = .black
        maskView2.alpha = alpha
        //
        maskView3.isUserInteractionEnabled = false
        maskView3.backgroundColor = .black
        maskView3.alpha = alpha
        maskView3.frame = CGRect(x: 0, y: maskView1.frame.maxY, width: view.frame.size.width, height: maskView2.frame.minY - maskView1.frame.maxY)
        // Clear Section
        let path = CGMutablePath()
//        path.addRect(CGRect(x: 1, y: 1, width: view.frame.size.width - 2, height: maskView3.bounds.height - 2))
        path.addRoundedRect(in: CGRect(x: 2, y: 1, width: view.frame.size.width - 4, height: maskView3.bounds.height - 2), cornerWidth: 15, cornerHeight: 15)
        path.addRect(screenFrame)
        //
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = kCAFillRuleEvenOdd
        //
        maskView3.layer.mask = maskLayer
        maskView3.clipsToBounds = true
        //
        view.addSubview(maskView1)
        view.addSubview(maskView2)
        view.addSubview(maskView3)
        // Back
        maskViewBackButton.image = #imageLiteral(resourceName: "Back Arrow")
        maskViewBackButton.tintColor = Colors.light
        maskViewBackButton.sizeToFit()
        maskViewBackButton.frame = CGRect(x: 5, y: maskView1.bounds.height - maskViewBackButton.bounds.height - 11, width: maskViewBackButton.bounds.width, height: maskViewBackButton.bounds.height)
        maskView1.addSubview(maskViewBackButton)
        // Back all the way to the beginning
        maskViewBackToBeginningButton.setImage(#imageLiteral(resourceName: "Double Back Arrow"), for: .normal)
        maskViewBackToBeginningButton.alpha = 0.25
        maskViewBackToBeginningButton.tintColor = Colors.light
        maskViewBackToBeginningButton.sizeToFit()
        maskViewBackToBeginningButton.frame = CGRect(x: 5, y: (maskView1.bounds.height / 2) - (maskViewBackButton.bounds.height / 2), width: maskViewBackToBeginningButton.bounds.width, height: maskViewBackToBeginningButton.bounds.height)
        maskViewBackToBeginningButton.isUserInteractionEnabled = true
        maskViewBackToBeginningButton.addTarget(self, action: #selector(backToBeginning), for: .touchUpInside)
        maskView1.addSubview(maskViewBackToBeginningButton)
        maskView1.bringSubview(toFront: maskViewBackToBeginningButton)
    }
    // Remove Mask Views
    func removeMaskView() {
        //
        UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
            self.maskView1.alpha = 0
            self.maskView2.alpha = 0
            self.maskView3.alpha = 0
        }, completion: { finished in
            self.maskView1.removeFromSuperview()
            self.maskView2.removeFromSuperview()
            self.maskView3.removeFromSuperview()
        })
    }
    // Table View ------------------------------------
    // Tableview slide left (next table)
    func slideLeft() {
        //
        view.isUserInteractionEnabled = false
        //
        let screenFrame = UIScreen.main.bounds
        let tableHeaderHeight = (screenFrame.height - TopBarHeights.combinedHeight - 24.5) / 4
        //
        // Table gets hidden but need to keep header so add screenshot
        let tableHeaderFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: tableHeaderHeight)
        let snapShotHeader = scheduleTable.resizableSnapshotView(from: tableHeaderFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        view.insertSubview(snapShotHeader, belowSubview: maskView1)
        //
        // Slide across table
        let snapShotFrame = CGRect(x: 0, y: tableHeaderHeight, width: view.bounds.width, height: view.bounds.height - tableHeaderHeight - 24.5)
        let snapShotY = TopBarHeights.combinedHeight + tableHeaderHeight + ((view.bounds.height - tableHeaderHeight - 24.5) / 2)
        // Snapshots
        let snapShot1 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: false, withCapInsets: .zero)
        //
        scheduleTable.reloadData()
        //
        let snapShot2 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: true, withCapInsets: .zero)
        //
        snapShot1?.center = CGPoint(x: view.center.x, y: snapShotY)
        snapShot2?.center = CGPoint(x: view.center.x + view.frame.size.width, y: snapShotY)
        //
        UIApplication.shared.keyWindow?.insertSubview((snapShot1)!, aboveSubview: self.view)
        UIApplication.shared.keyWindow?.insertSubview((snapShot2)!, aboveSubview: self.view)
        scheduleTable.isHidden = true
        // Animate new and old image to left
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
            snapShot2?.center.x = self.view.center.x
            //
        }, completion: { finished in
            snapShot1?.removeFromSuperview()
            snapShot2?.removeFromSuperview()
            snapShotHeader.removeFromSuperview()
            self.scheduleTable.isHidden = false
            self.view.isUserInteractionEnabled = true
        })
        //
    }
    // Tableview slide Right (previous table)
    func slideRight() {
        //
        view.isUserInteractionEnabled = false
        //
        let screenFrame = UIScreen.main.bounds
        let tableHeaderHeight = (screenFrame.height - TopBarHeights.combinedHeight - 24.5) / 4
        //
        // Table gets hidden but need to keep header so add screenshot
        let tableHeaderFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: tableHeaderHeight)
        let snapShotHeader = scheduleTable.resizableSnapshotView(from: tableHeaderFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        view.insertSubview(snapShotHeader, belowSubview: maskView1)
        //
        // Slide table
        let snapShotFrame = CGRect(x: 0, y: tableHeaderHeight, width: view.bounds.width, height: view.bounds.height - tableHeaderHeight - 24.5)
        let snapShotY = TopBarHeights.combinedHeight + tableHeaderHeight + ((view.bounds.height - tableHeaderHeight - 24.5) / 2)
        // Snapshots
        let snapShot1 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: false, withCapInsets: .zero)
        //
        scheduleTable.reloadData()
        //
        let snapShot2 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: true, withCapInsets: .zero)
        //
        snapShot1?.center = CGPoint(x: view.center.x, y: snapShotY)
        snapShot2?.center = CGPoint(x: view.center.x - view.frame.size.width, y: snapShotY)
        //
        UIApplication.shared.keyWindow?.insertSubview((snapShot1)!, aboveSubview: self.view)
        UIApplication.shared.keyWindow?.insertSubview((snapShot2)!, aboveSubview: self.view)
        scheduleTable.isHidden = true
        //
        // Animate new and old image to left
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
            snapShot2?.center.x = self.view.center.x
            //
        }, completion: { finished in
            snapShot1?.removeFromSuperview()
            snapShot2?.removeFromSuperview()
            snapShotHeader.removeFromSuperview()
            self.scheduleTable.isHidden = false
            self.view.isUserInteractionEnabled = true
        })
    }

    
    //
    // Mask cells under clear header (unrelated to above functions)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scheduleTable {
            for cell in scheduleTable.visibleCells {
                let hiddenFrameHeight = scrollView.contentOffset.y - cell.frame.origin.y + (view.bounds.height - 24.5) / 4
                if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
                    maskCell(cell: cell, margin: Float(hiddenFrameHeight))
                }
            }
        }
    }
    func maskCell(cell: UITableViewCell, margin: Float) {
        cell.layer.mask = visibilityMaskForCell(cell: cell, location: (margin / Float(cell.frame.size.height) ))
        cell.layer.masksToBounds = true
    }
    func visibilityMaskForCell(cell: UITableViewCell, location: Float) -> CAGradientLayer {
        let mask = CAGradientLayer()
        mask.frame = cell.bounds
        mask.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        mask.locations = [NSNumber(value: location), NSNumber(value: location)]
        return mask;
    }
}
