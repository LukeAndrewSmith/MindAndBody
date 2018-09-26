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

    // Table View ------------------------------------
    // FOR SLIDING THROUGH GROUP CHOICES
    // Tableview slide left (next table)
    // Table View ------------------------------------
    // FOR SLIDING THROUGH GROUP CHOICES
    // Tableview slide left (next table)
    func slideLeft() {
        //
        view.isUserInteractionEnabled = false
        //
        // Table gets hidden but need to keep header so add screenshot
        let tableHeaderFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: headerHeight)
        let snapShotHeader = scheduleTable.resizableSnapshotView(from: tableHeaderFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        snapShotHeader.center.y += pageStackHeight.constant
        view.insertSubview(snapShotHeader, belowSubview: maskView1)
        //
        // Slide across table
        let snapShotFrame = CGRect(x: 0, y: headerHeight, width: view.bounds.width, height: view.bounds.height - headerHeight - pageStackHeight.constant)
        let snapShotY = (separator.frame.maxY + scheduleTable.frame.maxY) / 2
        // Snapshots
        let snapShot1 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: false, withCapInsets: .zero)
        snapShot1?.center = CGPoint(x: view.center.x, y: snapShotY)
        view.insertSubview((snapShot1)!, aboveSubview: self.view)
        //
        scheduleTable.reloadData()
        //
        let snapShot2 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: true, withCapInsets: .zero)
        snapShot2?.center = CGPoint(x: view.center.x + view.frame.size.width, y: snapShotY)
        view.insertSubview((snapShot2)!, belowSubview: snapShot1!)
        //
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
    
    // FOR SLIDING THROUGH GROUP CHOICES
    // Tableview slide Right (previous table)
    func slideRight() {
        //
        view.isUserInteractionEnabled = false
        //
        // Table gets hidden but need to keep header so add screenshot
        let tableHeaderFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: headerHeight)
        let snapShotHeader = scheduleTable.resizableSnapshotView(from: tableHeaderFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        snapShotHeader.center.y += pageStackHeight.constant
        view.insertSubview(snapShotHeader, belowSubview: maskView1)
        //
        // Slide table
        let snapShotFrame = CGRect(x: 0, y: headerHeight, width: view.bounds.width, height: view.bounds.height - headerHeight - pageStackHeight.constant)
        let snapShotY = (separator.frame.maxY + scheduleTable.frame.maxY) / 2
        // Snapshots
        let snapShot1 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: false, withCapInsets: .zero)
        snapShot1?.center = CGPoint(x: view.center.x, y: snapShotY)
        view.insertSubview((snapShot1)!, aboveSubview: self.view)
        //
        scheduleTable.reloadData()
        //
        let snapShot2 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: true, withCapInsets: .zero)
        snapShot2?.center = CGPoint(x: view.center.x - view.frame.size.width, y: snapShotY)
        view.insertSubview((snapShot2)!, belowSubview: snapShot1!)
        
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
                let hiddenFrameHeight = scrollView.contentOffset.y - cell.frame.origin.y + (view.bounds.height - pageStackHeight.constant) / 4
                if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
                    maskCell(cell: cell, margin: Float(hiddenFrameHeight))
                }
            }
            // Animate Separator
            let currentY = scrollView.contentOffset.y
            
            if currentY < 0 {
                //"scrolling down"
                separator.center.y = separatorY - currentY
            // Reset
            } else if currentY > 0 {
                separator.center.y = separatorY
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
