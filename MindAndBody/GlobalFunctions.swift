//
//  GlobalFunctions.swift
//  MindAndBody
//
//  Created by Luke Smith on 05.08.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// MARK: - Global Function as extensions
//

//
// View Controller
extension UIViewController {
    
    //
    // MARK: Animate
    //
    // Animate Action Sheet Up
    func animateActionSheetUp(actionSheet:UIView, actionSheetHeight:CGFloat, backgroundView:UIView) {
        //
        let actionSheetWidth = UIScreen.main.bounds.width - 20
        //
        // Initial Conditions
        backgroundView.alpha = 0
        backgroundView.frame = UIScreen.main.bounds
        actionSheet.frame = CGRect(x: 10, y: self.view.frame.maxY, width: actionSheetWidth, height: actionSheetHeight)
        //
        // Animate
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
            //
            actionSheet.frame = CGRect(x: 10, y: self.view.frame.maxY - actionSheetHeight - 10, width: actionSheetWidth, height: actionSheetHeight)
            //
            backgroundView.alpha = 0.5
        }, completion: nil)
    }
    
    
    //
    // Animate Action Sheet Down
    func animateActionSheetDown(actionSheet:UIView, actionSheetHeight:CGFloat, backgroundView:UIView) {
        //
        let actionSheetWidth = UIScreen.main.bounds.width - 20
        //
        // Animate
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            //
            actionSheet.frame = CGRect(x: 10, y: self.view.frame.maxY, width: actionSheetWidth, height: actionSheetHeight)
            backgroundView.alpha = 0
            //
        }, completion: { finished in
            //
            actionSheet.removeFromSuperview()
            backgroundView.removeFromSuperview()
        })
    }
    
    
    //
    // Animate Photo/Explanation Up
    func animateViewUp(animationView:UIImageView, backgroundView:UIButton) {
        //
        // Initial Conditions
        self.navigationItem.setHidesBackButton(true, animated: true)
        //
        let animationViewHeight = UIScreen.main.bounds.height / 2
        let animationViewWidth = UIScreen.main.bounds.width
        //
        // View
        animationView.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: animationViewHeight)
        //
        animationView.backgroundColor = colour2
        animationView.contentMode = .scaleAspectFit
        animationView.isUserInteractionEnabled = true
        //
        // Background View
        backgroundView.frame = UIScreen.main.bounds
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        
        //
        // Animate
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            animationView.frame = CGRect(x: 0, y: animationViewHeight, width: animationViewWidth, height: animationViewHeight)
            backgroundView.alpha = 0.5
        }, completion: nil)
    }
    
    
    //
    // Animate Photo/Explanation Down
    func animateViewDown(animationView:UIImageView, backgroundView:UIButton) {
        //
        // Initial Conditions
        let animationViewHeight = UIScreen.main.bounds.height / 2
        let animationViewWidth = UIScreen.main.bounds.width
        //
        // Animate
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            animationView.frame = CGRect(x: 0, y: self.view.frame.maxY, width: animationViewWidth, height: animationViewHeight)
            backgroundView.alpha = 0
        }, completion: { finished in
            //
            animationView.removeFromSuperview()
            backgroundView.removeFromSuperview()
            self.navigationItem.setHidesBackButton(false, animated: true)
        })
    }
    
    
    //
    // MARK: Format
    //
    // Format Explanation Text
    func formatExplanationText(title:String, howTo:String, toAvoid:String) -> NSAttributedString {
        //
        let return1 = NSMutableAttributedString(string: "\n")
        let return2 = NSMutableAttributedString(string: "\n\n")
        //
        // Title
        let titleString = NSMutableAttributedString(string: title)
        titleString.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-light", size: 22)!, range: NSMakeRange(0, titleString.length))
        //
        let centering = NSMutableParagraphStyle()
        centering.alignment = .center
        titleString.addAttribute(NSParagraphStyleAttributeName, value: centering, range: NSMakeRange(0, titleString.length))
        
        //
        titleString.append(return2)
        
        //
        // Title Attributes
        let subTitleFont = [NSFontAttributeName : UIFont(name: "SFUIDisplay-light", size: 22)]
        //
        // Bullet Point Attributes
        let bulletPointFont = [NSFontAttributeName : UIFont(name: "SFUIDisplay-thin", size: 22)]
        //
        let paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [String : AnyObject])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 15
        
        //
        // How To
        let howToTitle = NSMutableAttributedString(string: NSLocalizedString("howTo", comment: ""))
        howToTitle.addAttributes(subTitleFont, range: NSMakeRange(0, howToTitle.length))
        //
        howToTitle.append(return1)
        //
        //
        let howToString = NSMutableAttributedString(string: "")
        //
        let howToPoints = howTo.components(separatedBy: .newlines)
        for string in howToPoints {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
            howToString.append(attributedString)
        }
        //
        howToString.addAttributes(bulletPointFont, range: NSMakeRange(0, howToString.length))
        //
        howToString.append(return1)
        
        //
        // To Avoid
        let toAvoidTitle = NSMutableAttributedString(string: NSLocalizedString("toAvoid", comment: ""))
        toAvoidTitle.addAttributes(subTitleFont, range: NSMakeRange(0, toAvoidTitle.length))
        //
        toAvoidTitle.append(return1)
        //
        //
        let toAvoidString = NSMutableAttributedString(string: "")
        //
        let toAvoidPoints = toAvoid.components(separatedBy: .newlines)
        for string in toAvoidPoints {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
            toAvoidString.append(attributedString)
        }
        //
        toAvoidString.addAttributes(bulletPointFont, range: NSMakeRange(0, toAvoidString.length))
        //
        toAvoidString.append(return1)
        
        //
        // Return
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(titleString)
        fullString.append(howToTitle)
        fullString.append(howToString)
        fullString.append(toAvoidTitle)
        fullString.append(toAvoidString)
        return fullString
    }
    
    
    //
    // Get Uncached Image
    func getUncachedImage(named: String) -> UIImage? {
        let imgPath = Bundle.main.path(forResource: named, ofType: "png")
        let imageToReturn = UIImage(contentsOfFile: imgPath!)
        return imageToReturn
    }
    
    // ----------------------------------------------------------------------------------------------------------------
    // MARK: Update Tracking Progress
    //
    // Week Tracking
    func updateWeekProgress() {
        //
        let defaults = UserDefaults.standard
        var currentProgress = defaults.integer(forKey: "weekProgress")

        //
        // Get first monday in week
        let currentMondayDate = firstMondayInCurrentWeek()
        // Last Reset = monday of last week reset
        var lastReset = defaults.string(forKey: "lastResetWeek")
        
        // Reset if last reset wasn't is current week
        if lastReset != currentMondayDate  {
            currentProgress = 0
            defaults.set(currentMondayDate, forKey: "lastResetWeek")
        }
        
        // Increment Progress
        currentProgress += 1
        defaults.set(currentProgress, forKey: "weekProgress")
    }
    
    // Month Tracking
    func updateMonthProgress() {
        //
        let defaults = UserDefaults.standard
        var currentProgress = defaults.integer(forKey: "monthProgress")
        
        //
        // Get first monday in month
        let firstMonday = firstMondayInCurrentMonth()
        // Last Reset = first monday in the last month reset
        var lastReset = defaults.string(forKey: "lastResetMonth")
        
        // Reset if last reset wasn't in current month
        if lastReset != firstMonday  {
            currentProgress = 0
            defaults.set(firstMonday, forKey: "lastResetMonth")
        }
        
        // Increment Progress
        currentProgress += 1
        defaults.set(currentProgress, forKey: "monthProgress")
    }
    
    // ---
    // Helper functions
    
    // First monday in week
    func firstMondayInCurrentWeek() -> String? {
        //
        // Get first monday in week
        let dfDay = DateFormatter()
        dfDay.dateFormat = "dd.MM.yyyy"
        // Get Monday
        var mondaysDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let currentMondayDate = dfDay.string(from: mondaysDate)
        return currentMondayDate
    }
    // First monday in month
    func firstMondayInCurrentMonth() -> String? {
        // Get month and year
        // Get Month
        let dfMonth = DateFormatter()
        dfMonth.dateFormat = "MM"
        // Get Month
        var monthsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let month = Int(dfMonth.string(from: monthsDate))
        // Get Year
        let dfYear = DateFormatter()
        dfYear.dateFormat = "yyyy"
        // Get Year
        var yearsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let year = Int(dfYear.string(from: yearsDate))

        
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2 // 2 == Monday
        
        // First monday in month:
        var comps = DateComponents(year: year, month: month,
                                   weekday: calendar.firstWeekday, weekdayOrdinal: 1)
        guard let first = calendar.date(from: comps)  else {
            return nil
        }
        
        // Format Day
        let dfDay = DateFormatter()
        dfDay.dateFormat = "dd.MM.yyyy"
        // Get Monday
        let firstMonday = dfDay.string(from: first)
        
        return firstMonday
    }

    
    
    // ----------------------------------------------------------------------------------------------------------------
    // Update Tracking Arrays
    //
    // Monday  - Sunday
    func updateWeekTracking() {
        // Format Day
        let dfDay = DateFormatter()
        dfDay.dateFormat = "dd"
        // Get Today
        var currentDate = Int(dfDay.string(from: NSDate() as Date))
        // Get Monday
        var mondaysDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let currentMondayDate = Int(dfDay.string(from: mondaysDate))
        
        // Get Month
        let dfMonth = DateFormatter()
        dfMonth.dateFormat = "MM"
        // Get Month
        var monthsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let currentMonth = Int(dfMonth.string(from: monthsDate))
        
        // Format Year
        let dfYear = DateFormatter()
        dfYear.dateFormat = "yyyy"
        // Get Year
        var yearsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let currentYear = Int(dfYear.string(from: yearsDate))

        
        // Week Goal
        let currentProgressDivision: Double = (weekProgress / weekGoal) * 100.0
        let currentProgress = Int(currentProgressDivision)
        
        // Keys
        let keys = weekTrackingDictionary.keys.sorted()
        // Week has already begun
        if keys.contains(currentMondayDate!) {
            // Day is next in line or day has already started
            if keys.last == (currentDate! - 1) || keys.last == currentDate! {
                // Today has already begun
                if weekTrackingDictionary[currentDate!] != nil {
                    weekTrackingDictionary[currentDate!] = currentProgress
                
                    // Today has just started
                } else {
                    weekTrackingDictionary.updateValue(currentProgress, forKey: currentDate!)
                }
                
            // Day isn't next in line
            } else {
                // Update missed days normally
                if currentDate! > currentMondayDate! {
                    for i in keys.last!...currentDate! - 1 {
                            weekTrackingDictionary.updateValue(weekTrackingDictionary[keys.last!]!, forKey: i)
                    }
                // Update missing days across month boundary
                } else {
                    var lastMonth = Int()
                    var year = Int()
                    // If january, last month in last year
                    if currentMonth! == 1 {
                        lastMonth = 12
                        year = currentYear! - 1
                    } else {
                        lastMonth = currentMonth! - 1
                        year = currentYear!
                    }
                    for i in keys.last!...numberOfDaysInMonth(lastMonth, forYear: year)! {
                            weekTrackingDictionary.updateValue(weekTrackingDictionary[keys.last!]!, forKey: i)
                    }
                    for i in 1...(currentDate!) {
                            weekTrackingDictionary.updateValue(weekTrackingDictionary[keys.last!]!, forKey: i)
                    }
                }
                
                // Update today
                weekTrackingDictionary.updateValue(currentProgress, forKey: currentDate!)
            }
            
        // Week hasn't begun (has just started) / user has't done anything this week
        } else {
            // If today is monday, clear array and create monday
            if currentDate == currentMondayDate {
                weekTrackingDictionary = [:]
                weekTrackingDictionary.updateValue(currentProgress, forKey: currentMondayDate!)
                
            // Today isn't monday
            } else {
                // Clear array if necessary (if last array contains values not in current week)(keys.last could be set to any value in the keys array)
                if  weekTrackingDictionary.count != 0 {
                    if keys.last! < currentMondayDate! || keys.last! > currentMondayDate! + 6 {
                        weekTrackingDictionary = [:]
                    }
                }
                // Update missed days normally
                if currentDate! > currentMondayDate! {
                    for i in currentMondayDate!...currentDate! - 1 {
                        weekTrackingDictionary.updateValue(0, forKey: i)
                    }
                // Update missing days across month boundary
                } else {
                    var lastMonth = Int()
                    var year = Int()
                    // If january, last month in last year
                    if currentMonth! == 1 {
                        lastMonth = 12
                        year = currentYear! - 1
                    } else {
                        lastMonth = currentMonth! - 1
                        year = currentYear!
                    }
                    for i in keys.last!...numberOfDaysInMonth(lastMonth, forYear: year)! {
                        weekTrackingDictionary.updateValue(0, forKey: i)
                    }
                    for i in 1...(currentDate!) {
                        weekTrackingDictionary.updateValue(0, forKey: i)
                    }
                }
                // Update today
                weekTrackingDictionary.updateValue(currentProgress, forKey: currentDate!)
            }
        }
        let testDic: [Int:Int] = weekTrackingDictionary
        
        //
        // Need to then save the dictionary somewhere !!!!!!!!!!!!!!!
    }
    
    func numberOfDaysInMonth(_ month: Int, forYear year: Int) -> Int? {
        let dateComponents = DateComponents(year: 2015, month: 7)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
    
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
    
    
    // ----------------------------------------------------------------------------------------------------------------
    // Week %
    func updateTracking() {
        // Format Day
        let dfDay = DateFormatter()
        dfDay.dateFormat = "dd"
        // Get Monday
        var mondaysDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let currentMondayDate = Int(dfDay.string(from: mondaysDate))
        
        // Format Month
        let dfMonth = DateFormatter()
        dfMonth.dateFormat = "MM"
        // Get Month
        var monthsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let currentMonth = Int(dfMonth.string(from: monthsDate))
    
        // Format Year
        let dfYear = DateFormatter()
        dfYear.dateFormat = "yyyy"
        // Get Year
        var yearsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let currentYear = Int(dfYear.string(from: yearsDate))

        // Week Goal
        var currentProgressDivision: Double = (weekProgress / weekGoal) * 100
        var currentProgress = Int(currentProgressDivision)

        
        //
        // If current year doesn't exist, add it
        let keyArrayYear = trackingDictionary.keys.sorted()
        if (keyArrayYear.contains(currentYear!)) == false {
            //
            trackingDictionary.updateValue([:], forKey: currentYear!)
            
            //
            // Check last year exists and is full
            let lastYear = currentYear! - 1
            if trackingDictionary[lastYear] != nil {
                // Check last year number months correct
                let lastYearKeyArray = trackingDictionary[lastYear]?.keys.sorted()
                // numberToCheck = number of months there would be if all from the first month with values were filled in
                let numberToCheck = 13 - (lastYearKeyArray?.first)!
                if trackingDictionary[lastYear]?.count != numberToCheck {
                    let lastYearLastMonth = lastYearKeyArray?.last
                    
                    // Check last month has correct number of mondays
                    if (trackingDictionary[lastYear]?[lastYearLastMonth!]?.count)! != numberOfMondaysInMonth(lastYearLastMonth!, forYear: lastYear)! {
                        let numberOfMondays = numberOfMondaysInMonth(lastYearLastMonth!, forYear: lastYear)!
                        let numberOfMondaysTracking = (trackingDictionary[lastYear]?[lastYearLastMonth!]?.count)!
                        let emptyMondays = numberOfMondays - numberOfMondaysTracking
                        //
                        let firstMonday = firstMondayInMonth(lastYearLastMonth!, forYear: lastYear)
                        let lastFilledInMonday = firstMonday! + ((numberOfMondays - emptyMondays - 1) * 7)
                        for i in 1...emptyMondays {
                            trackingDictionary[lastYear]?[lastYearLastMonth!]?.updateValue(0, forKey: lastFilledInMonday + (7 * i))
                        }
                    }
                    
                    // Fill rest of months with nil for each week
                    let toFillLastYear = numberToCheck - (lastYearKeyArray?.count)!
                    // Fill 0 into last years empty months
                    for i in 1...toFillLastYear {
                        // creat month
                        trackingDictionary[lastYear]?.updateValue([:], forKey: 13 - i)
                        
                        let numberOfMondays = numberOfMondaysInMonth(13 - i, forYear: lastYear)!
                        let firstMonday = firstMondayInMonth(13 - i, forYear: lastYear)

                        // Fill in 0 in all weeks
                        for j in 0...numberOfMondays - 1 {
                            trackingDictionary[lastYear]?[13 - i]?.updateValue(0, forKey: firstMonday! + (7 * j))
                        }
                    }
                }
            }
        }
        
        //
        // Month isn't next in line
        let yearDict = trackingDictionary[currentYear!]
        let keyArray = yearDict?.keys.sorted()
        // Month isn't next in line (also check if year is empty but month is greater than 1)
        if keyArray?.count == 0 && currentMonth! > 1 || currentMonth! > (keyArray?.last)! + 1 {
            //
            var lastMonthUpdated = Int()

            // If array dict values
            if keyArray?.count != 0 {
                lastMonthUpdated = (keyArray?.last)!
                // Check last month has correct number of mondays
                if (trackingDictionary[currentYear!]?[lastMonthUpdated]?.count)! != numberOfMondaysInMonth(lastMonthUpdated, forYear: currentYear!)! {
                    let numberOfMondays = numberOfMondaysInMonth(lastMonthUpdated, forYear: currentYear!)!
                    let numberOfMondaysTracking = (trackingDictionary[currentYear!]?[lastMonthUpdated]?.count)!
                    let emptyMondays = numberOfMondays - numberOfMondaysTracking
                    //
                    let firstMonday = firstMondayInMonth(lastMonthUpdated, forYear: currentYear!)
                    let lastFilledInMonday = firstMonday! + ((numberOfMondays - emptyMondays - 1) * 7)
                    // Fill in last month empty weeks with 0
                    for i in 1...emptyMondays {
                        trackingDictionary[currentYear!]?[lastMonthUpdated]?.updateValue(0, forKey: lastFilledInMonday + (7 * i))
                    }
                }
            } else {
                lastMonthUpdated = 0
            }
            
            // Fill rest of months with 0 for each week up to current month
            let toFillToCurrentYear = currentMonth! - lastMonthUpdated
            // Fill 0 into last years empty months (i is number to add to last month)(-1 so as not to fill in current month)
            for i in 1...toFillToCurrentYear - 1 {
                let numberOfMondays = numberOfMondaysInMonth(lastMonthUpdated + i, forYear: currentYear!)!
                let firstMonday = firstMondayInMonth(lastMonthUpdated + i, forYear: currentYear!)
                
                // Create month
                trackingDictionary[currentYear!]?.updateValue([:], forKey: lastMonthUpdated + i)

                // Fill in 0 in all weeks
                for j in 0...numberOfMondays - 1 {
                    trackingDictionary[currentYear!]?[lastMonthUpdated + i]?.updateValue(0, forKey: firstMonday! + (7 * j))
                }
            }
            
            // Fill current months empty weeks with 0
            let firstMonday = firstMondayInMonth(currentMonth!, forYear: currentYear!)
            let toFillCurrentMonth = ((currentMondayDate! - firstMonday!) / 7)
            // if today isn't first day of month
            if firstMonday != currentMondayDate {
                // Create month
                trackingDictionary[currentYear!]?.updateValue([:], forKey: currentMonth!)
                
                //
                for i in 0...toFillCurrentMonth - 1 {
                    trackingDictionary[currentYear!]?[currentMonth!]?.updateValue(0, forKey: firstMonday! + (7 * i))
                }
            }
        
            if trackingDictionary[currentYear!]?[currentMonth!]?.count == nil {
                trackingDictionary[currentYear!]?.updateValue([:], forKey: currentMonth!)
            }
            // Update current week
            trackingDictionary[currentYear!]?[currentMonth!]?.updateValue(currentProgress, forKey: currentMondayDate!)
            
        // Month is next in line or current Month
        } else {
            // Month Has Begun
            if trackingDictionary[currentYear!]?[currentMonth!] != nil {
                //
                let mondayKeyArray = trackingDictionary[currentYear!]?[(currentMonth)!]?.keys.sorted()
                // Week isnt next in line
                if currentMondayDate! > (mondayKeyArray?.last!)! + 7 {
                    // Fill current months empty weeks with 0
                    let lastMonday = (mondayKeyArray?.last!)!
                    let toFillCurrentMonth = ((currentMondayDate! - lastMonday) / 7)
                    for i in 1...toFillCurrentMonth - 1 {
                        trackingDictionary[currentYear!]?[currentMonth!]?.updateValue(0, forKey: lastMonday + (7 * i))
                    }
                }
                
                // Create current Monday or update it
                if trackingDictionary[currentYear!]?[currentMonth!]?[currentMondayDate!] != nil {
                    // Fill current Week
                    trackingDictionary[currentYear!]?[currentMonth!]?[currentMondayDate!] = currentProgress
                } else {
                    //
                    trackingDictionary[currentYear!]?[currentMonth!]?.updateValue(currentProgress, forKey: currentMondayDate!)
                }

            // Month Hasn't Begun
            } else {
                // Create current month
                trackingDictionary[currentYear!]?.updateValue([:], forKey: currentMonth!)

                // Check weeks are full
                let firstMonday = firstMondayInMonth(currentMonth!, forYear: currentYear!)
                if currentMondayDate! > firstMonday! {
                    // Fill current months empty weeks with 0
                    let toFillCurrentMonth = ((currentMondayDate! - firstMonday!) / 7)
                    for i in 0...toFillCurrentMonth - 1 {
                        trackingDictionary[currentYear!]?[currentMonth!]?.updateValue(0, forKey: firstMonday! + (7 * i))
                    }
                }
                
                // Create current monday or update it
                if trackingDictionary[currentYear!]?[currentMonth!]?[currentMondayDate!] != nil {
                    // Fill current Week
                    trackingDictionary[currentYear!]?[currentMonth!]?[currentMondayDate!] = currentProgress
                } else {
                    //
                    trackingDictionary[currentYear!]?[currentMonth!]?.updateValue(currentProgress, forKey: currentMondayDate!)
                }
            }
        }
        let testDic: [Int:[Int:[Int:Int]]] = trackingDictionary
        
    }
    
    //
    // Week tracking helper functions
    func numberOfMondaysInMonth(_ month: Int, forYear year: Int) -> Int? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2 // 2 == Monday
        
        // First monday in month:
        var comps = DateComponents(year: year, month: month,
                                   weekday: calendar.firstWeekday, weekdayOrdinal: 1)
        guard let first = calendar.date(from: comps)  else {
            return nil
        }
        
        // Last monday in month:
        comps.weekdayOrdinal = -1
        guard let last = calendar.date(from: comps)  else {
            return nil
        }
        
        // Difference in weeks:
        let weeks = calendar.dateComponents([.weekOfMonth], from: first, to: last)
        return weeks.weekOfMonth! + 1
    }
    
    func firstMondayInMonth(_ month: Int, forYear year: Int) -> Int? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2 // 2 == Monday
        
        // First monday in month:
        var comps = DateComponents(year: year, month: month,
                                   weekday: calendar.firstWeekday, weekdayOrdinal: 1)
        guard let first = calendar.date(from: comps)  else {
            return nil
        }
        
        // Format Day
        let dfDay = DateFormatter()
        dfDay.dateFormat = "dd"
        // Get Monday
        let firstMonday = Int(dfDay.string(from: first))
        
        return firstMonday
    }
    
    
    // ----------------------------------------------------------------------------------------------------------------
    // Month %
    func updateMonthTracking() {
        // Format Month
        let dfMonth = DateFormatter()
        dfMonth.dateFormat = "MM"
        // Get Month
        var monthsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let currentMonth = Int(dfMonth.string(from: monthsDate))
        
        // Format Year
        let dfYear = DateFormatter()
        dfYear.dateFormat = "yyyy"
        // Get Year
        var yearsDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        let currentYear = Int(dfYear.string(from: yearsDate))
        
        // Month Goal
        let currentProgressDivision: Double = (monthProgress / monthGoal) * 100
        let currentProgress = Int(currentProgressDivision)
        
        //
        // If current year doesn't exist, add it
        let keyArrayFull = monthTrackingDictionary.keys.sorted()
        if (keyArrayFull.contains(currentYear!)) == false {
            //
            monthTrackingDictionary.updateValue([:], forKey: currentYear!)
            
            // Check last year exists and is full
            if monthTrackingDictionary[currentYear! - 1] != nil {
                let lastYearKeyArray = monthTrackingDictionary[currentYear! - 1]?.keys.sorted()
                let numberToCheck = 13 - (lastYearKeyArray?.first)!
                if monthTrackingDictionary[currentYear! - 1]?.count != numberToCheck {
                    let lastYearLastMonth = lastYearKeyArray?.last
                    let toFillLastYear = numberToCheck - (lastYearKeyArray?.last)!
                    // Fill 0 into last years empty months
                    for i in 1...toFillLastYear {
                        monthTrackingDictionary[currentYear! - 1]?.updateValue(0, forKey: lastYearLastMonth! + i)
                    }
                }
            }
        }
        
        //
        // Month isn't next in line
        let yearDict = monthTrackingDictionary[currentYear!]
        let keyArray = yearDict?.keys.sorted()
        if keyArray?.count == 0 && currentMonth! > 1 || currentMonth! > (keyArray?.last)! + 1  {
            // Fill empty months up to current months with 0
            //
            var lastMonth = Int()
            // If array dict values
            if keyArray?.count != 0 {
                lastMonth = (keyArray?.last)!
            } else {
                lastMonth = 0
            }

            let toFill = (currentMonth! - 1) - lastMonth
            for i in 1...toFill {
                monthTrackingDictionary[currentYear!]?.updateValue(0, forKey: lastMonth + i)
            }
            
            // Update current month
            monthTrackingDictionary[currentYear!]?.updateValue(currentProgress, forKey: currentMonth!)
            
        // Month is next in line or current Month
        } else {
            // Month Has Begun
            if monthTrackingDictionary[currentYear!]?[currentMonth!] != nil {
                monthTrackingDictionary[currentYear!]?[currentMonth!] = currentProgress
            
            // Month Hasn't Begun
            } else {
                monthTrackingDictionary[currentYear!]?.updateValue(currentProgress, forKey: currentMonth!)
            }
        }
        var testDic: [Int:[Int:Int]] = monthTrackingDictionary
        
    }
    
    
    //
    // MARK: Walkthrough
    //
    //
    // Set Initial States
    func setWalkthrough(walkthroughView: UIView, walkthroughLabel: UILabel, walkthroughHighlight: UIView, nextButton: UIButton) -> UIView {
        //
        
        //
        let screenSize = UIScreen.main.bounds
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        
        // View
        walkthroughView.frame = screenSize
        walkthroughView.backgroundColor = .clear
        
        // Highlight
        walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
        walkthroughHighlight.layer.borderColor = colour1.cgColor
        walkthroughHighlight.layer.borderWidth = 1
        
        // Label
        walkthroughLabel.frame = CGRect(x: 13, y: 0, width: view.frame.size.width - 26, height: 0)
        walkthroughLabel.center = view.center
        walkthroughLabel.textAlignment = .center
        walkthroughLabel.numberOfLines = 0
        walkthroughLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        walkthroughLabel.layer.cornerRadius = 13
        walkthroughLabel.clipsToBounds = true
        walkthroughLabel.backgroundColor = colour1
        walkthroughLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        walkthroughLabel.textColor = colour2
        walkthroughLabel.alpha = 0.93
        
        // Button
        nextButton.frame = screenSize
        nextButton.backgroundColor = .clear
        
        //
        walkthroughView.addSubview(walkthroughLabel)
        walkthroughView.addSubview(walkthroughHighlight)
        walkthroughView.addSubview(nextButton)
        UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
        walkthroughView.bringSubview(toFront: nextButton)
        walkthroughView.bringSubview(toFront: walkthroughLabel)
        //
        return walkthroughView
    }

    //
    // view, label, highlight, texts, labelframe, highlightsize, highlightcenter, highlightcornerradius, backgroundColor, textColor, animationTime, walkthroughprogress
    func nextWalkthroughView(walkthroughView: UIView, walkthroughLabel: UILabel, walkthroughHighlight: UIView, walkthroughTexts: [String], walkthroughLabelFrame: Int, highlightSize: CGSize, highlightCenter: CGPoint, highlightCornerRadius: Int, backgroundColor: UIColor, textColor: UIColor, animationTime: Double, walkthroughProgress: Int) {
        
        //
        // Label animation
        // Snapshot 1
        let walkthroughSnapshot1 = walkthroughLabel.snapshotView(afterScreenUpdates: false)
        walkthroughSnapshot1?.center = walkthroughLabel.center
        //
        // Label
        walkthroughLabel.alpha = 0
        walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
        walkthroughLabel.sizeToFit()
        switch walkthroughLabelFrame {
        case 0:
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
        case 1:
            walkthroughLabel.frame = CGRect(x: 13, y: CGFloat(13) + TopBarHeights.statusBarHeight, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
        default:
            break
        }
        walkthroughLabel.center.x += view.bounds.width
        walkthroughLabel.alpha = 0.93
        //
        // Add Snapshot
        UIApplication.shared.keyWindow?.insertSubview(walkthroughSnapshot1!, aboveSubview: walkthroughView)
    
        //
        // Animate Highlight and Label
        UIView.animate(withDuration: animationTime, animations: {
            // Snapshot
            walkthroughSnapshot1?.center.x -= self.view.frame.size.width * 1
            walkthroughLabel.center.x = self.view.center.x
            // Colour
            walkthroughLabel.textColor = textColor
            walkthroughLabel.backgroundColor = backgroundColor
            walkthroughHighlight.backgroundColor = backgroundColor.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = backgroundColor.cgColor
            // Highlight
            walkthroughHighlight.frame.size = highlightSize
            walkthroughHighlight.center = highlightCenter
            switch highlightCornerRadius {
            case 0:
                walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            case 1:
                walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.width / 2
            case 2:
                walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 4
            case 3:
                walkthroughHighlight.layer.cornerRadius = 15
            default:
                break
            }
        }, completion: {finished in
            walkthroughLabel.alpha = 0.93
            walkthroughSnapshot1?.removeFromSuperview()
            
            //
            // Flash
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                walkthroughHighlight.backgroundColor = backgroundColor.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    walkthroughHighlight.backgroundColor = backgroundColor.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            
        })
    }

//
}
