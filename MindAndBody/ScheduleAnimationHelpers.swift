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
    //
    // MARK: Mask Views
    // Mask view func
    func maskView() {
        // Animate mask view if group selected and mask doesnt already exist
        if choiceProgress[0] != -1 && view.subviews.contains(maskView1) == false {
            createMaskView(alpha: 0)
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                self.maskView1.alpha = 0.72
                self.maskView2.alpha = 0.72
            })
        }
    }
    // Session selection mask
    func maskAction() {
        // Table Counter
        // Return to choice 1 (sessions)
        if choiceProgress[1] > 1 {
            // Cardio has two choice paths
            if choiceProgress[0] == 2 && choiceProgress[1] == 5 {
                choiceProgress[1] = 1
                // Meditation has two choice paths
            } else if choiceProgress[0] == 0 && choiceProgress[1] == 5 {
                choiceProgress[1] = 1
            } else {
                choiceProgress[1] -= 1
            }
            slideRight()
            // Return to choice 0 (groups)
        } else if choiceProgress[1] == 1 {
            choiceProgress[0] = -1
            choiceProgress[1] = 0
            // Enable table scroll & schedule choice button & remove mask view
            scheduleTable.isScrollEnabled = true
            navigationBar.rightBarButtonItem?.isEnabled = true
            removeMaskView()
            slideRight()
        }
    }
    // Open Schedule, check if mask views necessary
    func checkMaskView() {
        if tableCounter[0] != -1 {
            createMaskView(alpha: 0.5)
        }
    }
    // Mask Views -----------------------------------
    // Create Mask Views
    func createMaskView(alpha: CGFloat) {
        // Disable table scroll & schedule choice button
        scheduleTable.isScrollEnabled = false
        navigationBar.rightBarButtonItem?.isEnabled = false
        //
        let screenFrame = UIScreen.main.bounds
        //
        maskView1.addTarget(self, action: #selector(maskAction), for: .touchUpInside)
        maskView2.addTarget(self, action: #selector(maskAction), for: .touchUpInside)
        //
        maskView1.frame = CGRect(x: 0, y: 0, width: screenFrame.width, height: (screenFrame.height - TopBarHeights.combinedHeight - 24.5) / 4)
        maskView2.frame = CGRect(x: 0, y: scheduleTable.frame.maxY, width: screenFrame.width, height: 24.5)
        //
        maskView1.backgroundColor = .black
        maskView1.alpha = alpha
        maskView2.backgroundColor = .black
        maskView2.alpha = alpha
        //
        view.addSubview(maskView1)
        view.addSubview(maskView2)
        //
        maskViewBackButton.image = #imageLiteral(resourceName: "Back Arrow")
        maskViewBackButton.tintColor = colour1
        maskViewBackButton.sizeToFit()
        maskViewBackButton.frame = CGRect(x: 5, y: maskView1.bounds.height - maskViewBackButton.bounds.height - 11, width: maskViewBackButton.bounds.width, height: maskViewBackButton.bounds.height)
        maskView1.addSubview(maskViewBackButton)
    }
    // Remove Mask Views
    func removeMaskView() {
        //
        UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
            self.maskView1.alpha = 0
            self.maskView2.alpha = 0
        }, completion: { finished in
            self.maskView1.removeFromSuperview()
            self.maskView2.removeFromSuperview()
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
        // Mask hides table header so add screenshot
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
        maskTable()
        UIApplication.shared.keyWindow?.insertSubview((snapShot1)!, aboveSubview: self.view)
        UIApplication.shared.keyWindow?.insertSubview((snapShot2)!, aboveSubview: self.view)
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
            self.removeMaskTable()
            self.view.isUserInteractionEnabled = true
        })
    }
    // Tableview slide Right (previous table)
    func slideRight() {
        //
        view.isUserInteractionEnabled = false
        //
        let screenFrame = UIScreen.main.bounds
        let tableHeaderHeight = (screenFrame.height - TopBarHeights.combinedHeight - 24.5) / 4
        //
        // Mask hides table header so add screenshot
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
        maskTable()
        UIApplication.shared.keyWindow?.insertSubview((snapShot1)!, aboveSubview: self.view)
        UIApplication.shared.keyWindow?.insertSubview((snapShot2)!, aboveSubview: self.view)
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
            self.removeMaskTable()
            self.view.isUserInteractionEnabled = true
        })
    }
    // Mask Table
    func maskTable() {
        let screenFrame = UIScreen.main.bounds
        //
        mask.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height)
        let test = mask.frame.minY
        
        //TopBarHeights.combinedHeight + tableHeaderHeight
        mask.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        //
        // Snapshot Header - mask layer covers header so show it
        // SHOULD FIND A BETTER WAY, MASKING ONLY THE NECESSARY CELLS AND NOT THE WHOLE TABLEVIEW WITH HEADER
        // ISSUE: MASK.FRAME DOESNT SEE TO LISTEN TO Y VALUE or y value means something else
        
        //
        scheduleTable.layer.mask = mask
        //
        // MASK LAYER Y = 0 INSTEAD OF TABLEVIEWHEIGHT !!!!
    }
    func removeMaskTable() {
        mask.removeFromSuperlayer()
    }
    
    
    //
    // Mask cells under clear header (unrelated to above functions)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in scheduleTable.visibleCells {
            let hiddenFrameHeight = scrollView.contentOffset.y - cell.frame.origin.y + (view.bounds.height - 24.5) / 4
            if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
                maskCell(cell: cell, margin: Float(hiddenFrameHeight))
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
