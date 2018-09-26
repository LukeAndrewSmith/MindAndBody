//
//  ScheduleHelpers.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

extension ScheduleScreen {
    
    // MARK: Schedule Helper Functions
    
    // MARK:- Navigation through days
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        
        // Swipe should only be enabled if schedule style is day view, or if swiping back from choices
        let swipeEnabled: Bool = {
            return ScheduleVariables.shared.scheduleStyle == "day"
        }()

        //
        if swipeEnabled {
            //
            // Forward 1 day
            if (extraSwipe.direction == .left) && ScheduleVariables.shared.selectedDay != 6{
                // Update selected day
                ScheduleVariables.shared.selectedDay += 1
                
                // Deselect all ScheduleVariables.shared.indicators
                for i in 0...(stackArray.count - 1) {
                    stackArray[i].font = stackFontUnselected
                }
                // Select ScheduleVariables.shared.indicator
                stackArray[ScheduleVariables.shared.selectedDay].font = stackFontSelected
                animateDayIndicatorToDay()
                
                // Animate
                // Snapshot before update
                let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
                snapShot1?.center.y += pageStackHeight.constant
                view.insertSubview(snapShot1!, aboveSubview: scheduleTable)
                // Move table and reload
                scheduleTable.center.x = view.center.x + self.view.frame.size.width
                scheduleTable.reloadData()
                //
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
                    self.scheduleTable.center.x = self.view.center.x
                }, completion: { finish in
                    snapShot1?.removeFromSuperview()
                })
                
                //
                // Back 1 day
            } else if extraSwipe.direction == .right && ScheduleVariables.shared.selectedDay != 0 {
                // Update selected day
                ScheduleVariables.shared.selectedDay -= 1
                
                // Deselect all indicators
                for i in 0...(stackArray.count - 1) {
                    stackArray[i].font = stackFontUnselected
                }
                // Select indicator
                stackArray[ScheduleVariables.shared.selectedDay].font = stackFontSelected
                selectDay(day: ScheduleVariables.shared.selectedDay)
                animateDayIndicatorToDay()
                
                // Animate
                //
                // Snapshot before update
                let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
                snapShot1?.center.y += pageStackHeight.constant
                view.insertSubview(snapShot1!, aboveSubview: scheduleTable)
                // Move table and reload
                scheduleTable.center.x = view.center.x - self.view.frame.size.width
                scheduleTable.reloadData()
                //
                UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                    snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
                    self.scheduleTable.center.x = self.view.center.x
                }, completion: { finish in
                    self.scheduleTable.isHidden = false
                    snapShot1?.removeFromSuperview()
                })
                
            }
        }
    }
    
    //
    // Day Tap
    @objc func dayTapHandler(sender: UITapGestureRecognizer) {
        let dayLabel = sender.view as! UILabel
        let index = dayLabel.tag
        //
        // Forward
        if index > ScheduleVariables.shared.selectedDay {
            // Update selected day
            ScheduleVariables.shared.selectedDay = index
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].font = stackFontUnselected
            }
            // Select indicator
            stackArray[ScheduleVariables.shared.selectedDay].font = stackFontSelected
            animateDayIndicatorToDay()
            
            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            snapShot1?.center.y += pageStackHeight.constant
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            snapShot2?.center.y += pageStackHeight.constant
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x + self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            scheduleTable.alpha = 0
            //
            view.isUserInteractionEnabled = false
            //
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.scheduleTable.alpha = 1
                snapShot1?.removeFromSuperview()
                snapShot2?.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
            })
            
            //
            // Back
        } else if index < ScheduleVariables.shared.selectedDay {
            // Update selected day
            ScheduleVariables.shared.selectedDay = index
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].font = stackFontUnselected
            }
            // Select indicator
            stackArray[ScheduleVariables.shared.selectedDay].font = stackFontSelected
            //selectDay(day: ScheduleVariables.shared.selectedDay)
            animateDayIndicatorToDay()
            
            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            snapShot1?.center.y += pageStackHeight.constant
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            snapShot2?.center.y += pageStackHeight.constant
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x - self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            scheduleTable.alpha = 0
            //
            view.isUserInteractionEnabled = false
            //
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.scheduleTable.alpha = 1
                snapShot1?.removeFromSuperview()
                snapShot2?.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
            })
            
        }
    }
    
    //
    // MARK: selectDay
    func selectDay(day: Int) {
        // Select indicator
        stackArray[day].alpha = 1
        
        // Reload table
        scheduleTable.reloadData()
    }
    
   
    // MARK:- Update Schedule Tracking
    //
    // MARK: Mark as completed
        // Handler for the checkmark on the cell, the user can mark as completed themselves
        // Also marks as incomplete if previously comleted, note: rename
    @IBAction func markAsCompleted(_ sender: UIButton) {
        
        // Get indexPath.row
        let row = sender.tag
        ScheduleVariables.shared.updateCompletion(row: row)
        
        let indexPathToReload = NSIndexPath(row: row, section: 0)
        scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)

        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            updateDayIndicatorColours()
        }
    }
    
    // MARK: Mark as completed and animate
        // if shouldReloadChoice == true then this function is executed
        // Once having completed a session from the schedule, this function gets called upon return to the schedule, it reloads the necessary rows and animates back to initial screen if necessary
    func markAsCompletedAndAnimate() {
        // MARK AS COMPLETED
        if ScheduleVariables.shared.shouldReloadChoice && ScheduleVariables.shared.selectedGroup != .none {
            
            ScheduleVariables.shared.shouldReloadChoice = false
            
            // Extra session
            if ScheduleVariables.shared.selectedGroup == Groups.extra.rawValue {
                //
                // Delay so looks nice
                DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                    // Reload the finalChoiceScreen Session after a delay
                    let indexPathToReload = NSIndexPath(row: ScheduleVariables.shared.selectedRows[1] + 1, section: 0)
                    self.scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
                    self.scheduleTable.selectRow(at: indexPathToReload as IndexPath, animated: true, scrollPosition: .none)
                    self.ensureCheckMarkGreen(indexPath: indexPathToReload as IndexPath)
                    self.scheduleTable.deselectRow(at: indexPathToReload as IndexPath, animated: true)
                    //
                    // Check if group is completed for the day
                    if self.isGroupCompleted(checkAll: true) {
                        // Update schedule tracking
                        // Update Tracking
                        self.updateWeekProgress()
                        self.updateTracking()
                        //
                        UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                            self.maskView3.backgroundColor = Colors.green
                            // Slide back to initial choice when completed
                        }, completion: { finished in
                            DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                                // Slide back
                                // Set to false then to true ensures that the tick doesn't get loaded on the initial screen before it has appeared
                                // In schedule table cell for row, checks this variable and doesn't load tick on just completed session until it can animate it
                                ScheduleVariables.shared.shouldReloadChoice = true
                                self.backToBeginning()
                                ScheduleVariables.shared.shouldReloadChoice = false
                            })
                        })
                    }
                })
            
            // Normal session (NOT MEDITATION, = 72 => MEDITATION)
            } else if ScheduleVariables.shared.selectedRows[1] != 72 {
                //
                // Delay so looks nice
                DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                    // Reload the finalChoiceScreen Session after a delay
                    let indexPathToReload = NSIndexPath(row: ScheduleVariables.shared.selectedRows[1] + 1, section: 0)
                    self.scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
                    self.scheduleTable.selectRow(at: indexPathToReload as IndexPath, animated: true, scrollPosition: .none)
                    self.ensureCheckMarkGreen(indexPath: indexPathToReload as IndexPath)
                    self.scheduleTable.deselectRow(at: indexPathToReload as IndexPath, animated: true)
                    //
                    // Check if group is completed for the day
                    if self.isGroupCompleted(checkAll: true) {
                        // Update schedule tracking
                        self.updateGroupTracking()
                        //
                        UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                            self.maskView3.backgroundColor = Colors.green
                        // Slide back to initial choice when completed
                        }, completion: { finished in
                            DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                                ScheduleVariables.shared.choiceProgress = 1
                                
                                // Set to false then to true ensures that the tick doesn't get loaded on the initial screen before it has appeared
                                // In schedule table cell for row, checks this variable and doesn't load tick on just completed session until it can animate it (animation just below)
                                ScheduleVariables.shared.shouldReloadChoice = true
                                self.maskAction()
                                ScheduleVariables.shared.shouldReloadChoice = false
                                
                                // Animate initial choice group completion after slideRight() animation finished
                                let toAdd = AnimationTimes.animationTime1 + AnimationTimes.animationTime2
                                DispatchQueue.main.asyncAfter(deadline: .now() + toAdd, execute: {
                                    let indexPathToReload = NSIndexPath(row: ScheduleVariables.shared.selectedRows[0], section: 0)
                                    self.scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
                                    self.scheduleTable.selectRow(at: indexPathToReload as IndexPath, animated: true, scrollPosition: .none)
                                    self.ensureCheckMarkGreen(indexPath: indexPathToReload as IndexPath)
                                    self.scheduleTable.deselectRow(at: indexPathToReload as IndexPath, animated: true)
                                })
                            })
                        })
                    }
                })
            // Meditation
            } else if ScheduleVariables.shared.selectedRows[1] == 72 {
                //
                // Go to initial choice
                ScheduleVariables.shared.choiceProgress = 1
                // Set to false then to true ensures that the tick doesn't get loaded on the initial screen before it has appeared
                // In schedule table cell for row, checks this variable and doesn't load tick on just completed session until it can animate it (animation just below)
                ScheduleVariables.shared.shouldReloadChoice = true
                maskAction()
                ScheduleVariables.shared.shouldReloadChoice = false

                //
                updateGroupTracking()

                // Animate initial choice group completion after slideRight() animation finished
                let toAdd = AnimationTimes.animationTime1 + AnimationTimes.animationTime2
                DispatchQueue.main.asyncAfter(deadline: .now() + toAdd, execute: {
                    let indexPathToReload = NSIndexPath(row: ScheduleVariables.shared.selectedRows[0], section: 0)
                    self.scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
                    self.scheduleTable.selectRow(at: indexPathToReload as IndexPath, animated: true, scrollPosition: .none)
                    self.ensureCheckMarkGreen(indexPath: indexPathToReload as IndexPath)
                    self.scheduleTable.deselectRow(at: indexPathToReload as IndexPath, animated: true)
                })
                updateDayIndicatorColours()
            }
        }
    }
    
    func ensureCheckMarkGreen(indexPath: IndexPath) {
        if let cell = self.scheduleTable.cellForRow(at: indexPath as IndexPath) {
            for view in (cell.subviews) {
                if view is UIButton {
                    if let image = (view as! UIButton).imageView?.image, image == #imageLiteral(resourceName: "CheckMark") {
                        view.backgroundColor = Colors.green
                    }
                }
            }
        }
    }
    
    //
    // MARK: Update Day Indicator colours
    func updateDayIndicatorColours() {
        //
        // If scheduleStyle == day update pageStack, if not do nothing
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            for i in 0...6 {
                if ScheduleVariables.shared.isDayEmpty(day: i) {
                    
                    // Nothing on day, White
                    (pageStack.arrangedSubviews[i] as! UILabel).textColor = Colors.light
                    
                } else {
                    
                    // Complete, green
                    if ScheduleVariables.shared.isDayCompleted(day: i) {
                        (pageStack.arrangedSubviews[i] as! UILabel).textColor = Colors.green
                        
                    // Incomplete, red
                    } else {
                        (pageStack.arrangedSubviews[i] as! UILabel).textColor = Colors.red
                    }
                }
            }
        }
    }
    

    //
    // Should scroll be enabled
    func scheduleTableScrollCheck() {
        
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        var nRows = 0
        // Note: +1 for extra sessions cell
        if schedules.count != 0 {
            if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                nRows = (ScheduleVariables.shared.selectedSchedule?["schedule"]?[ScheduleVariables.shared.selectedDay].count)! + 1
            } else {
                nRows = ScheduleVariables.shared.weekArray.count + 1
            }
        }
        
        let totalRowHeights = CGFloat(nRows) * cellHeight
        
        // Enabled
        if headerHeight + totalRowHeights <= scheduleTable.bounds.height {
            scheduleTable.isScrollEnabled = false
        } else {
            scheduleTable.isScrollEnabled = true
        }
    }
    
    // Only called for updaing full group, i.e group is completed
        // Updates the tracking of a full group, setting to true
    func updateGroupTracking() {
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        // Indexing variables
        // Differ if last choice or first choice
        let row = ScheduleVariables.shared.selectedRows.inital
        let indexingVariables = getIndexingVariables(row: row, firstChoice: true, checkLastChoice: false)
        // index0 = selected row in initial choice screen (schedule homescreen selected group) i.e index to group in current day in schedule
        let index0 = indexingVariables.0
        // index1 = Selected row in final choice (i.e warmup, session, stretching)
        let index1 = indexingVariables.1
        //
        let day = indexingVariables.2
        
        // Update
        ScheduleVariables.shared.selectedSchedule["schedule"]![day][index0][index1] = true
        // Update Badges
            // currentBool == False as False -> True
        ReminderNotifications.shared.updateBadges()
        // Update Tracking
        updateWeekProgress()
        updateTracking()

        UserDefaults.standard.set(schedules, forKey: "schedules")
        
        // Mark first instance of group in all other schedules as completed
        if isGroupCompleted(checkAll: true) {
            markAsGroupForOtherSchedules(markAs: true)
        }
        //
        updateDayIndicatorColours()
    }
    
    // MARK:- Subscriptions
    // Upon completion of check subscription, perform action
    @objc func subscriptionCheckCompleted() {
        Loading.shared.shouldPresentLoading = false
        Loading.shared.endLoading()
        print(SubscriptionsCheck.shared.isValid)
        if !SubscriptionsCheck.shared.isValid {
            self.performSegue(withIdentifier: "SubscriptionsSegue", sender: self)
        }
    }
    
    // MARK:- View Setup/Layout
    // MARK: Reload View
    // shouldReloadSchedule
    @objc func reloadView() {
        // RELOAD VIEW
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        if ScheduleVariables.shared.shouldReloadSchedule {
            //
            ScheduleVariables.shared.shouldReloadSchedule = false
            //
            layoutViews()
            //
            scheduleTable.reloadData()
            scheduleChoiceTable.reloadData()
            //
            scheduleTableScrollCheck()
        }
    }
    // MARK: Setup views
    func setupViews() {
        // Set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
        //
        // table   // buttons // spaces
        
        let tableHeight: CGFloat = (47*4.5) + 49 // 47 is height of a row in the table - 49 for the header
        let buttonHeight: CGFloat = 49
        
        let elementWidth = ActionSheet.shared.actionWidth
        
        // Schedule View
        scheduleView.backgroundColor = Colors.dark
        scheduleView.frame = CGRect(x: 0, y: 0, width: elementWidth, height: tableHeight + buttonHeight)
        scheduleView.layer.cornerRadius = CGFloat(buttonHeight / 2)
        scheduleView.clipsToBounds = true
        scheduleView.layer.borderWidth = 1
        scheduleView.layer.borderColor = Colors.light.cgColor
        // Important order for the shadow on editSchedule button to be in front of scheduleChoiceTable but behind editScheduleButton
        scheduleView.addSubview(scheduleChoiceTable)
        scheduleView.addSubview(createScheduleButton)
        // Schedule choice
        scheduleChoiceTable.backgroundColor = Colors.dark
        scheduleChoiceTable.delegate = self
        scheduleChoiceTable.dataSource = self
        scheduleChoiceTable.frame = CGRect(x: 0, y: 0, width: elementWidth, height: tableHeight)
        scheduleChoiceTable.tableFooterView = UIView()
        scheduleChoiceTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scheduleChoiceTable.layer.borderWidth = 1
        scheduleChoiceTable.layer.borderColor = Colors.light.cgColor
        
        // Create Schedule
        createScheduleButton.addTarget(self, action: #selector(createScheduleAction), for: .touchUpInside)
        createScheduleButton.setTitle(NSLocalizedString("createSchedule", comment: ""), for: .normal)
        createScheduleButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        createScheduleButton.frame = CGRect(x: 0, y: tableHeight, width: elementWidth, height: buttonHeight)
        createScheduleButton.setTitleColor(Colors.dark, for: .normal)
        createScheduleButton.backgroundColor = Colors.light
        createScheduleButton.setImage(#imageLiteral(resourceName: "Plus"), for: .normal)
        createScheduleButton.tintColor = Colors.dark
        createScheduleButton.layer.shadowColor = UIColor.black.cgColor
        createScheduleButton.layer.shadowOpacity = 0.72
        createScheduleButton.layer.shadowRadius = 8
        createScheduleButton.layer.shadowOffset = CGSize.zero
        //
        
        // Separator
        separator.frame = CGRect(x: tableSpacing, y: separatorY, width: view.bounds.width - 54, height: 1)
        separator.backgroundColor = foregroundColor.withAlphaComponent(0.5)
        view.insertSubview(separator, aboveSubview: scheduleTable)
        
        //
        // Navigation Bar
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("schedule", comment: ""), separator: false, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)
        
        //
        // TableView
        scheduleTable.backgroundView = UIView()
        scheduleTable.backgroundColor = .clear
        scheduleTable.tableFooterView = UIView()
//        scheduleTable.separatorStyle = .none
        scheduleTable.separatorInset = UIEdgeInsets(top: 0, left: tableSpacing, bottom: 0, right: tableSpacing)
        
    }
    
    // Layout views
    func layoutViews() {
        //
        // Present as days or as week
        // days
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            pageStack.alpha = 1
            pageStack.isUserInteractionEnabled = true
            pageStackHeight.constant = 44
            navigationSeparatorTopConstraint.constant = pageStackHeight.constant
            scheduleTableTopConstraint.constant = pageStackHeight.constant
            separator.center.y = separatorY
        // week
        } else if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.week.rawValue {
            pageStack.alpha = 0
            pageStack.isUserInteractionEnabled = false
            pageStackHeight.constant = 0
            navigationSeparatorTopConstraint.constant = 0
            scheduleTableTopConstraint.constant = 0
            separator.center.y = separatorY
        }
        
        // Day indicator
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            dayIndicator.alpha = 1
        } else {
            dayIndicator.alpha = 0
        }
        
        
        // Shadow to page stack
        var shouldAdd = true
        for view in pageStack.subviews {
            if view.tag == 723 {
                shouldAdd = false
            }
        }
        if shouldAdd {
            let backgroundStackView = UIView(frame: pageStack.bounds)
            backgroundStackView.tag = 723
            backgroundStackView.backgroundColor = Colors.dark
            backgroundStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pageStack.insertSubview(backgroundStackView, at: 0)
            
            backgroundStackView.layer.shadowColor = Colors.dark.cgColor
            backgroundStackView.layer.shadowOpacity = 1
            backgroundStackView.layer.shadowOffset = CGSize.zero
            backgroundStackView.layer.shadowRadius = 7
        }
        
        // Set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
                
        //
        // Custom 'Page Control' m,t,w,t,f,s,s for bottom
        // If week is being presented as days, style 1
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue && pageStack.arrangedSubviews.count == 0 {
            
            for i in 0...(dayArray.count - 1) {
                let dayLabel = UILabel()
                dayLabel.textColor = Colors.light
                dayLabel.textAlignment = .center
                dayLabel.font = stackFontUnselected
                dayLabel.text = NSLocalizedString(dayArrayChar[i], comment: "")
                dayLabel.sizeToFit()
                dayLabel.tag = i
                //
                let dayTap = UITapGestureRecognizer()
                dayTap.numberOfTapsRequired = 1
                dayTap.addTarget(self, action: #selector(dayTapHandler))
                dayLabel.isUserInteractionEnabled = true
                dayLabel.addGestureRecognizer(dayTap)
                stackArray.append(dayLabel)
            }
            for i in 0...stackArray.count - 1 {
                pageStack.addArrangedSubview(stackArray[i])
            }
            pageStack.isUserInteractionEnabled = true
            //
            // Add background color to stack view
            let backgroundStackView = UIView(frame: pageStack.bounds)
            backgroundStackView.backgroundColor = Colors.dark
            backgroundStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pageStack.insertSubview(backgroundStackView, at: 0)
            
        }
        
        // Day Swipes (also used for swipe back in choices)
        daySwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        daySwipeLeft.direction = UISwipeGestureRecognizerDirection.left
        scheduleTable.addGestureRecognizer(daySwipeLeft)
        //
        daySwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        daySwipeRight.direction = UISwipeGestureRecognizerDirection.right
        scheduleTable.addGestureRecognizer(daySwipeRight)
        
        // Select Today
        // Get current day as index
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            
            ScheduleVariables.shared.selectedDay = Date().weekDayFromMonday
            stackArray[ScheduleVariables.shared.selectedDay].font = stackFontSelected
            dayIndicatorLeading.constant = stackArray[ScheduleVariables.shared.selectedDay].frame.minX
            self.view.layoutIfNeeded()
            
        } else {
            // 7 implies week view
            ScheduleVariables.shared.selectedDay = 7
        }
        
        dayIndicator.frame.size = CGSize(width: view.bounds.width / 7, height: 2)
        dayIndicator.backgroundColor = Colors.light
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            view.addSubview(dayIndicator)
            view.bringSubview(toFront: dayIndicator)
        }
        
        updateDayIndicatorColours()
        scheduleTableScrollCheck()
    }
    
    //
    @objc func checkSelectedDay() {
        // If see each day
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            //
            if ScheduleVariables.shared.lastDayOpened != Date().weekDayFromMonday {
                // Reload
                ScheduleVariables.shared.selectedDay = Date().weekDayFromMonday
                ScheduleVariables.shared.shouldReloadSchedule = true
                reloadView()
                ScheduleVariables.shared.lastDayOpened = Date().weekDayFromMonday
            }
        }
    }
    
    func setScheduleStyle() {
        // Check wether to present the schedule as :
        // Days
        // The whole week
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        if schedules.count != 0 {
            ScheduleVariables.shared.scheduleStyle = (ScheduleVariables.shared.selectedSchedule!["scheduleInformation"]![0][0]["scheduleStyle"] as! Int).scheduleStyleFromInt()
        } else {
            ScheduleVariables.shared.scheduleStyle = ScheduleStyle.day.rawValue
        }
    }
}
