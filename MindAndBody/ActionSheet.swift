//
//  ActionSheets.swift
//  MindAndBody
//
//  Created by Luke Smith on 15.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
// Elements
//
// Action sheet cancel
class ActionSheet {
    static var shared = ActionSheet()
    private init() {}
    //
    //
    var actionSheet = UIView()
    var actionSheetBackgroundView = UIButton()
    var cancelButton = UIButton()
    
    //
    func setupActionSheet() {
        if actionSheet.subviews.count != 0 {
            for i in 0...actionSheet.subviews.count - 1 {
                actionSheet.subviews[i].removeFromSuperview()
            }
        }
        //
        actionSheetBackgroundView.frame = UIScreen.main.bounds
        actionSheetBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        //
        cancelButton.backgroundColor = Colours.colour1
        cancelButton.setTitleColor(Colours.colour4, for: .normal)
        cancelButton.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        cancelButton.layer.cornerRadius = cancelButton.bounds.height / 2
        cancelButton.clipsToBounds = true
        actionSheet.addSubview(cancelButton)
        actionSheetBackgroundView.addSubview(actionSheet)
        //
        actionSheet.frame.size = CGSize(width: UIScreen.main.bounds.width - 20, height: 49 + 20)
        cancelButton.frame = CGRect(x: 0, y: actionSheet.bounds.height - 20, width: actionSheet.bounds.width, height: 49)
        cancelButton.addTarget(self, action: #selector(animateActionSheetDown), for: .touchUpInside)
        actionSheetBackgroundView.addTarget(self, action: #selector(animateActionSheetDown), for: .touchUpInside)
    }
    
    func resetCancelFrame() {
        cancelButton.frame = CGRect(x: 0, y: actionSheet.bounds.height - 49, width: actionSheet.bounds.width, height: 49)
        cancelButton.layer.cornerRadius = cancelButton.bounds.height / 2
        cancelButton.clipsToBounds = true
    }
    
    func animateActionSheetUp() {
        //
        // Initial Conditions
        actionSheetBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0)
        actionSheet.frame = CGRect(x: 10, y: UIScreen.main.bounds.height, width: actionSheet.bounds.width, height: actionSheet.bounds.height)
        UIApplication.shared.keyWindow?.addSubview(actionSheetBackgroundView)
        UIApplication.shared.keyWindow?.bringSubview(toFront: actionSheetBackgroundView)
        //
        // Animate
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
            //
            // iPhone X
            if UIScreen.main.nativeBounds.height == 2436 {
                self.actionSheet.frame = CGRect(x: 10, y: UIScreen.main.bounds.height - self.actionSheet.bounds.height - 10 - TopBarHeights.homeIndicatorHeight, width: self.actionSheet.bounds.width, height: self.actionSheet.bounds.height)
            } else {
                self.actionSheet.frame = CGRect(x: 10, y: UIScreen.main.bounds.height - self.actionSheet.bounds.height - 10, width: self.actionSheet.bounds.width, height: self.actionSheet.bounds.height)
            }
            //
            self.actionSheetBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }, completion: nil)
    }
    
    @objc func animateActionSheetDown() {
        //
        // Animate
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            //
            self.actionSheet.frame = CGRect(x: 10, y: UIScreen.main.bounds.height, width: self.actionSheet.bounds.width, height: self.actionSheet.bounds.height)
                self.actionSheetBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0)
            //
        }, completion: { finished in
            //
            self.actionSheetBackgroundView.removeFromSuperview()
        })
    }
    
    
//    //
//    ActionSheet.shared.setupActionSheet()
//    ActionSheet.shared.actionSheet.addSubview(scheduleChoiceTable)
//    ActionSheet.shared.actionSheet.addSubview(editScheduleButton)
//    ActionSheet.shared.actionSheet.addSubview(editProfileButton)
//    let heightToAdd = scheduleChoiceTable.bounds.height + 20 + editScheduleButton.bounds.height + 20 + editProfileButton.bounds.height
//    ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
//    ActionSheet.shared.resetCancelFrame()
//
//
//    ActionSheet.shared.animateActionSheetDown()

}
