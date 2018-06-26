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
    
    // Walkthrough long press note
    @objc func walkthroughScheduleLongPressNote() {
        // If theres actually a session to explain the long press for
        if scheduleTable.numberOfRows(inSection: 0) > 0 {
            //
            if didSetWalkthrough == false {
                //
                nextButton.addTarget(self, action: #selector(walkthroughScheduleLongPressNote), for: .touchUpInside)
                walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
                didSetWalkthrough = true
            }
            
            //
            switch walkthroughProgress {
                // First has to be done differently
            // Walkthrough explanation
            case 0:
                let cell = scheduleTable.cellForRow(at: IndexPath(row: 0, section: 0))
                //
                walkthroughLabel.text = NSLocalizedString("longPressNoteWalkthrough", comment: "")
                walkthroughLabel.sizeToFit()
                walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
                
                // Colour
                walkthroughLabel.textColor = Colors.dark
                walkthroughLabel.backgroundColor = Colors.light
                walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
                walkthroughHighlight.layer.borderColor = Colors.light.cgColor
                // Highlight
                walkthroughHighlight.frame.size = CGSize(width: scheduleTable.bounds.width - 32, height: (cell?.bounds.height)!)
                walkthroughHighlight.center = cell!.center
                walkthroughHighlight.center.y += TopBarHeights.combinedHeight
                walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 4
                
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
            //
            default:
                UIView.animate(withDuration: 0.4, animations: {
                    self.walkthroughView.alpha = 0
                }, completion: { finished in
                    self.walkthroughView.removeFromSuperview()
                    var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                    walkthroughs["LongPressScheduleNote"] = true
                    UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                    // Sync
                    ICloudFunctions.shared.pushToICloud(toSync: ["walkthroughs"])
                })
            }
        }
    }
    
    
    // Walkthrough
    @objc func walkthroughSchedule() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughSchedule), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Walkthrough explanation
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = Colors.dark
            walkthroughLabel.backgroundColor = Colors.light
            walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.light.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: 172, height: 33)
            walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: ((self.navigationController?.navigationBar.frame.height)! / 2) + TopBarHeights.statusBarHeight)
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
            highlightCenter = CGPoint(x: view.frame.size.width / 2, y: ((self.navigationController?.navigationBar.frame.height)! / 2) + TopBarHeights.statusBarHeight)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Custom Schedules
        case 2:
            //
            highlightSize = CGSize(width: 36, height: 36)
            highlightCenter = CGPoint(x: view.bounds.width * (91.5/100), y: ((self.navigationController?.navigationBar.frame.height)! / 2) + TopBarHeights.statusBarHeight)
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Menu Button
        case 3:
            //
            highlightSize = CGSize(width: 36, height: 36)
            highlightCenter = CGPoint(x: 35, y: ((self.navigationController?.navigationBar.frame.height)! / 2) + TopBarHeights.statusBarHeight)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        // Sessions
        case 4:
            //
            self.performSegue(withIdentifier: "openMenu", sender: nil)
            //
            // (72 is row height for slide menu)
            highlightSize = CGSize(width: 44, height: 44)
            highlightCenter = CGPoint(x: CGFloat(30), y: TopBarHeights.combinedHeight + (72 / 2))
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Schedule
        case 5:
            //
            highlightSize = CGSize(width: 44, height: 44)
            highlightCenter = CGPoint(x: CGFloat(30), y: TopBarHeights.combinedHeight + (72 * 1.5))
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // TRACKING CURRENTLY
        // Lessons
        case 6:
            //
            highlightSize = CGSize(width: 44, height: 44)
            highlightCenter = CGPoint(x: CGFloat(30), y: TopBarHeights.combinedHeight + (72 * 2.5))
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Lessons
        case 7:
            //
            highlightSize = CGSize(width: 44, height: 44)
            highlightCenter = CGPoint(x: CGFloat(30), y: TopBarHeights.combinedHeight + (72 * 3.5))
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Settings
        case 8:
            //
            highlightSize = CGSize(width: 44, height: 44)
            highlightCenter = CGPoint(x: CGFloat(30), y: TopBarHeights.combinedHeight + (72 * 4.5))
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // What now
        case 9:
            
            // Reset colors to white theme
            walkthroughLabel.textColor = Colors.dark
            walkthroughLabel.backgroundColor = Colors.light
            walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.light.cgColor
            
            //
            MenuVariables.shared.menuInteractionType = 0
            UIApplication.shared.statusBarStyle = .lightContent
            MenuVariables.shared.isNewView = false
            self.dismiss(animated: true)
            
            UIApplication.shared.keyWindow?.bringSubview(toFront: walkthroughView)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
                //
                UIApplication.shared.keyWindow?.bringSubview(toFront: self.walkthroughView)
                //
                self.highlightSize = CGSize(width: 36, height: 36)
                self.highlightCenter = CGPoint(x: self.view.bounds.width * (91.5/100), y: ((self.navigationController?.navigationBar.frame.height)! / 2) + TopBarHeights.statusBarHeight)
                self.highlightCornerRadius = 1
                //
                self.labelFrame = 0
                //
                self.walkthroughBackgroundColor = Colors.light
                self.walkthroughTextColor = Colors.dark
                //
                self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                
                //
                self.walkthroughProgress = self.walkthroughProgress + 1
            }
            
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
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["walkthroughs"])
            })
        }
    }
}
