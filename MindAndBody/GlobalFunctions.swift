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
// Mark: - Global Function as extensions
//

//
// View Controller
extension UIViewController {
    
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
        UIView.animate(withDuration: animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
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
        UIView.animate(withDuration: animationTime2, animations: {
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
        UIView.animate(withDuration: animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
        UIView.animate(withDuration: animationTime2, animations: {
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
    //
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
    
    
    
    //
    // Update Tracking
    //
    // Monday  - Sunday
    func updateWeekTracking() {
        // Format Day
        let dfDay = DateFormatter()
        dfDay.dateFormat = "dd"
        
        // Get Today
        var currentDate = Int(dfDay.string(from: NSDate() as Date))
        
        // Week Goal
        var currentProgress = weekProgress / weekGoal
       
        // Week has already begun
        if weekTrackingDictionary.count != 0 {
            // Today has already begun
            if weekTrackingDictionary[currentDate!] != nil {
                weekTrackingDictionary[currentDate!] = currentProgress
                
            // Today has just started
            } else {
                weekTrackingDictionary.updateValue(currentProgress, forKey: currentDate!)
            }
            
        // Week hasn't begun / user has't done anything this week
        } else {
            // Get Monday
            var mondaysDate: Date {
                return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
            }
            let currentMondayDate = Int(dfDay.string(from: mondaysDate))
            
            // Today is monday
            if currentDate == currentMondayDate {
                weekTrackingDictionary.updateValue(currentProgress, forKey: currentMondayDate!)
                
            // Today isn't monday
            } else {
                // Update empty days
                for i in currentMondayDate!...currentDate! - 1 {
                    weekTrackingDictionary.updateValue(0, forKey: i)
                }
                // Update today
                weekTrackingDictionary.updateValue(currentProgress, forKey: currentDate!)
            }
        }
    }
    
    
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
        var currentProgress = weekProgress / weekGoal
        
//        // Year isn't next in line
//        if trackingDictionary[currentYear!] == nil {
//            trackingDictionary.updateValue([:], forKey: currentYear!)
//            // Check last year is full
//            if trackingDictionary[currentYear! - 1] != nil {
//                // Fill last years unfinished weeks
//                let yearDict = trackingDictionary[currentYear!]
//                let keyArray = yearDict?.keys.sorted()
//                let toFill = 12 - keyArray.count
//                let lastMonth = keyArray?.last
//                for i in 1...toFill {
//                    monthTrackingDictionary[currentYear!]?.updateValue(0, forKey: lastMonth! + i)
//                }
//            }
//        }
//        
//        // Week isn't next in line
//        let monthDict = trackingDictionary[currentMonth!]
//        let keyArray = monthDict?.keys.sorted()
//        
//        if keyArray?.count != 0 && currentMondayDate! != (keyArray?.last)! + 7 {
//        
//            // Check last month exists and is full
//            if trackingDictionary[currentMonth! - 1] != nil {
//                if trackingDictionary[currentMonth! - 1]?.count != 12 {
//                    let lastYearKeyArray = trackingDictionary[currentMonth! - 1]?.keys.sorted()
//                    let lastYearLastMonth = lastYearKeyArray?.last
//                    let toFillLastYear = 12 - (lastYearKeyArray?.last)!
//                    // Fill 0 into last years empty months
//                    for i in 1...toFillLastYear {
//                        trackingDictionary[currentMondayDate! - 1]?.updateValue(0, forKey: lastYearLastMonth! + i)
//                    }
//                }
//            }
//            
//            // Fill empty months up to current months with 0
//            let toFill = (currentMonth! - 1) - (keyArray?.last)!
//            let lastMonth = keyArray?.last
//            for i in 1...toFill {
//                monthTrackingDictionary[currentYear!]?.updateValue(0, forKey: lastMonth! + i)
//            }
//            
//            // Update current month
//            monthTrackingDictionary[currentMonth!]?.updateValue(currentProgress, forKey: currentMonth!)
//            
//            
//        // Year is correct
//        // Week is next in line
//        } else {
//            // Week has already begun
//            if trackingDictionary[currentMondayDate!] != nil {
//                // Today has already begun
//                trackingDictionary[currentMonth!]?[currentMondayDate!] = currentProgress
//            
//            // Week hasn't begun / user has't done anything this week
//            } else {
//                //
//                trackingDictionary[currentMonth!]?.updateValue(currentProgress, forKey: currentMondayDate!)
//                
//            }
//        }
    }
    
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
        let currentProgress = monthProgress / monthGoal
        
        //
        // If current year doesn't exist, add it
        let keyArrayFull = monthTrackingDictionary.keys.sorted()
        if (keyArrayFull.contains(currentYear!)) == false {
            //
            monthTrackingDictionary.updateValue([:], forKey: currentYear!)
            
            // Check last year exists and is full
            if monthTrackingDictionary[currentYear! - 1] != nil {
                if monthTrackingDictionary[currentYear! - 1]?.count != 12 {
                    let lastYearKeyArray = monthTrackingDictionary[currentYear! - 1]?.keys.sorted()
                    let lastYearLastMonth = lastYearKeyArray?.last
                    let toFillLastYear = 12 - (lastYearKeyArray?.last)!
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
        if keyArray?.count != nil && currentMonth! > (keyArray?.last)! + 1 {
            // Fill empty months up to current months with 0
            let toFill = (currentMonth! - 1) - (keyArray?.last)!
            let lastMonth = keyArray?.last
            for i in 1...toFill {
                monthTrackingDictionary[currentYear!]?.updateValue(0, forKey: lastMonth! + i)
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
    }
    
}
