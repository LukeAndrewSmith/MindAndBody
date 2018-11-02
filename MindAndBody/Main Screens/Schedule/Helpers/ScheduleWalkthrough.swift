//
//  ScheduleWalkthrough.swift
//  MindAndBody
//
//  Created by Luke Smith on 22.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

extension ScheduleScreen {
    
    @objc func backActionWalkthrough() {
        if walkthroughProgress != 0 && walkthroughProgress != 1 {
            walkthroughProgress -= 2
            walkthroughSchedule()
        }
    }
    
    // Walkthrough
    @objc func walkthroughSchedule() {
        
        //
        if didSetWalkthrough == false {
            //
            walkthroughNextButton.addTarget(self, action: #selector(walkthroughSchedule), for: .touchUpInside)
            walkthroughBackButton.addTarget(self, action: #selector(backActionWalkthrough), for: .touchUpInside)

            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, separator: walkthroughLabelSeparator, nextButton: walkthroughNextButton, backButton: walkthroughBackButton, highlight: walkthroughHighlight, simplePopup: false)

            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Walkthrough explanation
        case 0:
            //
            walkthroughLabelTitle.text = NSLocalizedString(walkthroughTexts[walkthroughProgress] + "T", comment: "")
            
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.frame.size = walkthroughLabel.sizeThatFits(CGSize(width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding, height: .greatestFiniteMagnitude))

            walkthroughLabel.frame = CGRect(
                x: WalkthroughVariables.padding,
                y: WalkthroughVariables.topHeight + WalkthroughVariables.padding,
                width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding,
                height: walkthroughLabel.frame.size.height)
            walkthroughLabelView.frame = CGRect(
                x: WalkthroughVariables.viewPadding,
                y: (tabBarController?.tabBar.frame.minY)! - WalkthroughVariables.topHeight - walkthroughLabel.frame.size.height - WalkthroughVariables.viewPadding - WalkthroughVariables.twicePadding,
                width: view.frame.size.width - WalkthroughVariables.twiceViewPadding,
                height: WalkthroughVariables.topHeight + walkthroughLabel.frame.size.height + WalkthroughVariables.twicePadding)

            // Colour
            walkthroughView.alpha = 1
            walkthroughLabelView.backgroundColor = Colors.dark
            walkthroughLabel.textColor = Colors.light
            walkthroughLabelTitle.textColor = Colors.light
            walkthroughLabelSeparator.backgroundColor = Colors.light
            walkthroughNextButton.setTitleColor(Colors.light, for: .normal)
            walkthroughBackButton.setTitleColor(Colors.light, for: .normal)
            
            // Colour
            walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.light.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: 172, height: 33)
            walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: ((self.navigationController?.navigationBar.frame.height)! / 2) + ElementHeights.statusBarHeight)
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        // Schedule Screen
        case 1:
            //
            highlightSize = CGSize(width: 172, height: 33)
            highlightCenter = CGPoint(x: view.frame.size.width / 2, y: ((self.navigationController?.navigationBar.frame.height)! / 2) + ElementHeights.statusBarHeight)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: Colors.light, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Custom Schedules
        case 2:
            //
            highlightSize = CGSize(width: 36, height: 36)
            highlightCenter = CGPoint(x: view.bounds.width * (91.5/100), y: ((self.navigationController?.navigationBar.frame.height)! / 2) + ElementHeights.statusBarHeight)
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: Colors.light, animationTime: 0.4, walkthroughProgress: walkthroughProgress)

            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Tracking
        case 3:
            //
            highlightSize = CGSize(width: 46, height: 46)
            highlightCenter = CGPoint(x: view.bounds.width * (3/8), y: (tabBarController?.tabBar.center.y)!)
            highlightCornerRadius = 2
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: Colors.light, animationTime: 0.4, walkthroughProgress: walkthroughProgress)

            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        // Lessons
        case 4:
            //
            highlightSize = CGSize(width: 46, height: 46)
            highlightCenter = CGPoint(x: view.bounds.width * (5/8), y: (tabBarController?.tabBar.center.y)!)
            highlightCornerRadius = 2
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: Colors.light, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Settings
        case 5:
            //
            highlightSize = CGSize(width: 46, height: 46)
            highlightCenter = CGPoint(x: view.bounds.width * (7/8), y: (tabBarController?.tabBar.center.y)!)
            highlightCornerRadius = 2
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: Colors.light, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // What next
        case 6:
            //
            highlightSize = CGSize(width: 36, height: 36)
            highlightCenter = CGPoint(x: view.bounds.width * (91.5/100), y: ((self.navigationController?.navigationBar.frame.height)! / 2) + ElementHeights.statusBarHeight)
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: Colors.light, animationTime: 0.4, walkthroughProgress: walkthroughProgress)

            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.didSetWalkthrough = false
                self.walkthroughView.removeFromSuperview()
                var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                walkthroughs["Schedule"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            })
        }
    }
}
