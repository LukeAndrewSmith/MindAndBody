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
    
    ///---------------------------------------------------------------------------------
    /// MARK:- Navigation through days
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        
        // Swipe should only be enabled if schedule style is day view, or if swiping back from choices
        let swipeEnabled: Bool = {
            return ScheduleManager.shared.scheduleStyle == "day"
        }()

        //
        if swipeEnabled {
            //
            // Forward 1 day
            if (extraSwipe.direction == .left) && ScheduleManager.shared.selectedDay != 6{
                // Update selected day
                ScheduleManager.shared.selectedDay += 1
                
                // Deselect all ScheduleVariables.shared.indicators
                for i in 0...(stackArray.count - 1) {
                    stackArray[i].font = stackFontUnselected
                }
                // Select ScheduleVariables.shared.indicator
                stackArray[ScheduleManager.shared.selectedDay].font = stackFontSelected
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
            } else if extraSwipe.direction == .right && ScheduleManager.shared.selectedDay != 0 {
                // Update selected day
                ScheduleManager.shared.selectedDay -= 1
                
                // Deselect all indicators
                for i in 0...(stackArray.count - 1) {
                    stackArray[i].font = stackFontUnselected
                }
                // Select indicator
                stackArray[ScheduleManager.shared.selectedDay].font = stackFontSelected
                selectDay(day: ScheduleManager.shared.selectedDay)
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
        if index > ScheduleManager.shared.selectedDay {
            // Update selected day
            ScheduleManager.shared.selectedDay = index
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].font = stackFontUnselected
            }
            // Select indicator
            stackArray[ScheduleManager.shared.selectedDay].font = stackFontSelected
            animateDayIndicatorToDay()
            
            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            snapShot1?.center.y += pageStackHeight.constant
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            snapShot2?.center.y += pageStackHeight.constant
            //
            view.addSubview(snapShot1!)
            view.bringSubviewToFront(snapShot1!)
            //
            snapShot2?.center.x = view.center.x + self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubviewToFront(snapShot2!)
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
        } else if index < ScheduleManager.shared.selectedDay {
            // Update selected day
            ScheduleManager.shared.selectedDay = index
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].font = stackFontUnselected
            }
            // Select indicator
            stackArray[ScheduleManager.shared.selectedDay].font = stackFontSelected
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
            view.bringSubviewToFront(snapShot1!)
            //
            snapShot2?.center.x = view.center.x - self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubviewToFront(snapShot2!)
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
        // ScheduleVariables.shared.getIndexingVariables uses the selectedRows.initial to find the riw, therefore
        let (day, indexInDay) = ScheduleManager.shared.getIndexing(row: row)
        ScheduleManager.shared.updateCompletion(day: day, indexInDay: indexInDay, row: nil)
        
        let indexPathToReload = NSIndexPath(row: row, section: 0)
        scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
        
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            updateDayIndicatorColours()
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
    
    func reloadCompletedRow() {
        if ScheduleManager.shared.shouldReloadInitialChoice {
            ScheduleManager.shared.shouldReloadInitialChoice = false
            
            let indexPathToReload = NSIndexPath(row: ScheduleManager.shared.selectedRows.initial, section: 0)
            scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
            scheduleTable.selectRow(at: indexPathToReload as IndexPath, animated: true, scrollPosition: .none)
            ensureCheckMarkGreen(indexPath: indexPathToReload as IndexPath)
            scheduleTable.deselectRow(at: indexPathToReload as IndexPath, animated: true)
            
            if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                updateDayIndicatorColours()
            }
            
            /// Ask user to rate
            RatingsPrompt.promptRating()
        }
    }
    
    //
    // MARK: Update Day Indicator colours
    func updateDayIndicatorColours() {
        //
        // If scheduleStyle == day update pageStack, if not do nothing
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            for i in 0...6 {
                if ScheduleManager.shared.isDayEmpty(day: i) {
                    
                    // Nothing on day, White
                    (pageStack.arrangedSubviews[i] as! UILabel).textColor = Colors.light
                    
                } else {
                    
                    // Complete, green
                    if ScheduleManager.shared.isDayCompleted(day: i) {
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
        
        var nRows = 0
        // Note: +1 for extra sessions cell
        if ScheduleManager.shared.schedules.count > 0 {
            if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                nRows = (ScheduleManager.shared.schedules[ScheduleManager.shared.selectedScheduleIndex]["schedule"]?[ScheduleManager.shared.selectedDay].count)! + 1
            } else {
                nRows = ScheduleManager.shared.weekArray.count + 1
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
    
    // MARK:- Subscriptions
    // Upon completion of check subscription, perform action
    @objc func subscriptionCheckCompleted() {
        Loading.shared.shouldPresentLoading = false
        Loading.shared.endLoading()
        if !InAppManager.shared.hasValidSubscription {
            self.performSegue(withIdentifier: "SubscriptionsSegue", sender: self)
        }
    }
    
    ///---------------------------------------------------------------------------------
    /// MARK:- View Setup/Layout
    /// MARK: Reload View
    @objc func reloadView() {
        // Reload schedule
        if ScheduleManager.shared.shouldReloadSchedule {
            ScheduleManager.shared.shouldReloadSchedule = false
            ScheduleManager.shared.setScheduleStyle()
            layoutViews()
            scheduleTable.reloadData()
            scheduleChoiceTable.reloadData()
            scheduleTableScrollCheck()
        }
    }
    
    /// MARK: Setup views
    func setupView() {

        ///------------------------------------
        /// Schedule Choice Action Sheet
        
        ///------------------
        /// Heights
        let tableHeight: CGFloat = (47*4.5) + 49 /// 47: height of a row, 49: header
        let buttonHeight: CGFloat = 49 /// Create schedule button
        let elementWidth = ActionSheet.shared.actionWidth
        
        ///------------------
        /// Schedule View
        scheduleView.backgroundColor = Colors.dark
        scheduleView.frame = CGRect(x: 0, y: 0, width: elementWidth, height: tableHeight + buttonHeight)
        scheduleView.layer.cornerRadius = CGFloat(buttonHeight / 2)
        scheduleView.clipsToBounds = true
        scheduleView.layer.borderWidth = 1
        scheduleView.layer.borderColor = Colors.light.cgColor
        /// Important order:
            /// Shadow on editSchedule button in front of scheduleChoiceTable but behind editScheduleButton
        scheduleView.addSubview(scheduleChoiceTable)
        scheduleView.addSubview(createScheduleButton)
        
        ///------------------
        /// Schedule choice table
        scheduleChoiceTable.backgroundColor = Colors.dark
        scheduleChoiceTable.delegate = self
        scheduleChoiceTable.dataSource = self
        scheduleChoiceTable.frame = CGRect(x: 0, y: 0, width: elementWidth, height: tableHeight)
        scheduleChoiceTable.tableFooterView = UIView()
        scheduleChoiceTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scheduleChoiceTable.layer.borderWidth = 1
        scheduleChoiceTable.layer.borderColor = Colors.light.cgColor
        
        ///------------------
        /// Create Schedule Button
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
        
        ///------------------------------------
        /// Header Separator
        separatorTop.constant = separatorY
        separator.backgroundColor = foregroundColor.withAlphaComponent(0.5)
        
        ///------------------------------------
        /// Navigation Bar
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("schedule", comment: ""), separator: false, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)
        
        ///------------------------------------
        /// Status Bar
        UIApplication.shared.statusBarStyle = .lightContent
        
        ///------------------------------------
        /// Schedule TableView
        scheduleTable.backgroundView = UIView()
        scheduleTable.backgroundColor = .clear
        scheduleTable.tableFooterView = UIView()
        scheduleTable.separatorInset = UIEdgeInsets(top: 0, left: tableSpacing, bottom: 0, right: tableSpacing)
    }
    
    func layoutViews() {

        ///------------------------------------
        /// Days or Week schedule layout
        /// Days
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            pageStack.alpha = 1
            pageStack.isUserInteractionEnabled = true
            pageStackHeight.constant = 44
            navigationSeparatorTopConstraint.constant = pageStackHeight.constant
            scheduleTableTopConstraint.constant = pageStackHeight.constant
            separator.center.y = separatorY
            dayIndicator.alpha = 1
        /// Week
        } else if ScheduleManager.shared.scheduleStyle == ScheduleStyle.week.rawValue {
            pageStack.alpha = 0
            pageStack.isUserInteractionEnabled = false
            pageStackHeight.constant = 0
            navigationSeparatorTopConstraint.constant = 0
            scheduleTableTopConstraint.constant = 0
            separator.center.y = separatorY
            dayIndicator.alpha = 0
        }
        
        ///------------------------------------
        /// Week stack setup
        
        ///------------------
        /// Setup
            /// Week stack == Custom 'Page Control' (m,t,w,t,f,s,s) at top of screen
            /// Setup if not already setup (i.e if arrangedSubviews.count == 0)
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue && pageStack.arrangedSubviews.count == 0 {

            for i in 0..<dayArray.count {
                let dayLabel = UILabel()
                dayLabel.textColor = Colors.light
                dayLabel.textAlignment = .center
                dayLabel.font = stackFontUnselected
                dayLabel.text = NSLocalizedString(dayArrayChar[i], comment: "")
                dayLabel.sizeToFit()
                dayLabel.tag = i

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

            /// Add background color
            let backgroundStackView = UIView(frame: pageStack.bounds)
            backgroundStackView.backgroundColor = Colors.dark
            backgroundStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            pageStack.insertSubview(backgroundStackView, at: 0)
        }
        
        ///------------------
        /// Shadow
            /// Done by adding subview that will have the shadow
            /// Shadow subview tag == 723
            /// Add if shadow subview not present
        var shouldAdd = true
        for view in pageStack.subviews {
            if view.tag == 723 { /// Shadow subview present
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
        
        ///------------------
        /// Indicator
            /// move day indicator to correct position
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            ScheduleManager.shared.selectedDay = Date().weekDayFromMonday
            stackArray[ScheduleManager.shared.selectedDay].font = stackFontSelected
            pageStack.layoutSubviews()
            dayIndicatorLeading.constant = stackArray[ScheduleManager.shared.selectedDay].frame.minX
            self.view.layoutIfNeeded()
            
        } else {
            /// 7 indicates week view
            ScheduleManager.shared.selectedDay = 7
        }
        
        /// Ensure day indicator setup
        dayIndicator.frame.size = CGSize(width: view.bounds.width / 7, height: 2)
        dayIndicator.backgroundColor = Colors.light
        /// and added
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            if !view.subviews.contains(dayIndicator) {
                view.addSubview(dayIndicator)
            }
            view.bringSubviewToFront(dayIndicator)
        }
        
        ///------------------------------------
        /// Day Swipes
        daySwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        daySwipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        scheduleTable.addGestureRecognizer(daySwipeLeft)

        daySwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        daySwipeRight.direction = UISwipeGestureRecognizer.Direction.right
        scheduleTable.addGestureRecognizer(daySwipeRight)
        
        ///------------------------------------
        /// Checks
        
        /// Week stack colours
        updateDayIndicatorColours()
        
        /// Check if scroll needs to be enabled
            /// i.e if there are more sessions planned than fit on the screen
        scheduleTableScrollCheck()
    }
    
    //
    @objc func checkSelectedDay() {
        // If see each day
        if ScheduleManager.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            // Only go to new day if initialchoice isn't waiting to be reloaded (as this means coming back from completing a session on a different day)
            if ScheduleManager.shared.lastDayOpened != Date().weekDayFromMonday && !ScheduleManager.shared.shouldReloadInitialChoice {
                // Reload
                ScheduleManager.shared.selectedDay = Date().weekDayFromMonday
                ScheduleManager.shared.shouldReloadSchedule = true
                reloadView()
                ScheduleManager.shared.lastDayOpened = Date().weekDayFromMonday
            }
        }
    }
}
