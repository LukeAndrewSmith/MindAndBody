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
    func formatExplanationText(title:String, howTo:String, toAvoid:String, focusOn:String) -> NSAttributedString {
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
        // Avoid
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
        // Focus on
        let focusOnTitle = NSMutableAttributedString(string: NSLocalizedString("focusOn", comment: ""))
        focusOnTitle.addAttributes(subTitleFont, range: NSMakeRange(0, focusOnTitle.length))
        //
        focusOnTitle.append(return1)
        //
        //
        let focusOnString = NSMutableAttributedString(string: "")
        //
        let focusOnPoints = focusOn.components(separatedBy: .newlines)
        for string in focusOnPoints {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
            focusOnString.append(attributedString)
        }
        //
        focusOnString.addAttributes(bulletPointFont, range: NSMakeRange(0, focusOnString.length))
        //
        focusOnString.append(return1)
        
        //
        // Return
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(titleString)
        fullString.append(howToTitle)
        fullString.append(howToString)
        if toAvoid != "" {
            fullString.append(toAvoidTitle)
            fullString.append(toAvoidString)
        }
        if focusOn != "" {
            fullString.append(focusOnTitle)
            fullString.append(focusOnString)
        }
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
    // Week Progress
    func updateWeekProgress() {
        var trackingProgressArray = UserDefaults.standard.array(forKey: "trackingProgress") as! [[Any]]
        //
        let defaults = UserDefaults.standard
        var currentProgress = trackingProgressArray[0][0] as! Int
        //
        // Current mondays date in week
        let currentMondayDate = Date().firstMondayInCurrentWeek
        // Last Reset = monday of last week reset
        var lastReset = trackingProgressArray[0][1] as! Date
        
        // Reset if last reset wasn't is current week
        if lastReset != currentMondayDate {
            currentProgress = 0
            trackingProgressArray[0][1] = currentMondayDate
            defaults.set(trackingProgressArray, forKey: "trackingProgress")
        }
        
        // Increment Progress
        currentProgress += 1
        trackingProgressArray[0][0] = currentProgress
        defaults.set(trackingProgressArray, forKey: "trackingProgress")
    }
    
    // Month Progress
    func updateMonthProgress() {
        var trackingProgressArray = UserDefaults.standard.array(forKey: "trackingProgress") as! [[Any]]
        //
        var currentProgress = trackingProgressArray[1][0] as! Int
        
        //
        // Get first date in month
        let firstMonday = Date().firstDateInCurrentMonth
        // Last Reset = first monday in the last month reset
        var lastReset = trackingProgressArray[1][1] as! Date
        
        // Reset if last reset wasn't in current month
        if lastReset != firstMonday  {
            currentProgress = 0
            trackingProgressArray[1][1] = firstMonday
            UserDefaults.standard.set(trackingProgressArray, forKey: "trackingProgress")
        }
        
        // Increment Progress
        currentProgress += 1
        trackingProgressArray[1][0] = currentProgress
        UserDefaults.standard.set(trackingProgressArray, forKey: "trackingProgress")
    }
    
    
    // ----------------------------------------------------------------------------------------------------------------
    // Update Tracking Arrays
    //
    // MARK: Monday  - Sunday
    func updateWeekTracking() {
        //
        let calendar = Calendar(identifier: .gregorian)
        // Current Date
        let currentDate = Date()
        // Get Mondays date
        let currentMondayDate = Date().firstMondayInCurrentWeek
        //
        // Week Goal
        let currentProgressDivision: Double = (weekProgress / weekGoal) * 100.0
        let currentProgress = Int(currentProgressDivision)
        //
        // Keys
        let keys = weekTrackingDictionary.keys.sorted()
        
        //
        // Update
        //
        // Week has already begun
        if keys.contains(currentMondayDate) {
            //
            // Day already started
            if keys.last == currentDate {
                weekTrackingDictionary[currentDate] = currentProgress
                
            //
            // Day is next in line
            } else if keys.last == calendar.date(byAdding: .day, value: -1, to: currentDate) {
                weekTrackingDictionary.updateValue(currentProgress, forKey: currentDate)
                
            //
            // Day isn't next in line
            } else if keys.last! < calendar.date(byAdding: .day, value: -1, to: currentDate)! {
                //
                // Update missed days with 0
                var startDate = keys.last!
                let endDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
                // Loop adding 0 to dates
                while startDate <= endDate {
                    weekTrackingDictionary.updateValue(0, forKey: startDate)
                    startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
                }
                // Update today
                weekTrackingDictionary.updateValue(currentProgress, forKey: currentDate)
            }
            
        // Week hasn't begun (should start) / user has't done anything this week
        } else {
            //
            // If today is monday, clear array and create monday
            if currentDate == currentMondayDate {
                weekTrackingDictionary = [:]
                weekTrackingDictionary.updateValue(currentProgress, forKey: currentMondayDate)
                
            //
            // Today isn't monday
            } else {
                //
                // Clear array if necessary (if last key is less than current monday date)
                if  weekTrackingDictionary.count != 0 {
                    if keys.last! < currentMondayDate {
                        weekTrackingDictionary = [:]
                    }
                }
                // Update missed days
                if currentDate > currentMondayDate {
                    //
                    // Update missed days with 0
                    var startDate = currentMondayDate
                    let endDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
                    // Loop adding 0 to dates
                    while startDate <= endDate {
                        weekTrackingDictionary.updateValue(0, forKey: startDate)
                        startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
                    }
                    // Update today
                    weekTrackingDictionary.updateValue(currentProgress, forKey: currentDate)
                }
            }
        }
        //
        let testDic: [Date:Int] = weekTrackingDictionary
        
        //
        // Need to then save the dictionary somewhere !!!!!!!!!!!!!!!
    }
    
    
    // ----------------------------------------------------------------------------------------------------------------
    // MARK: Week %
    func updateTracking() {
        //
        let calendar = Calendar(identifier: .gregorian)
        // Get Mondays date
        let currentMondayDate = Date().firstMondayInCurrentWeek
        //
        // Week Goal
        let currentProgressDivision: Double = (weekProgress / weekGoal) * 100
        let currentProgress = Int(currentProgressDivision)
        //
        // Keys
        let keys = trackingDictionary.keys.sorted()
        
        // Note: Weeks defined by their mondays date
        //
        // Current week exists
        if keys.contains(currentMondayDate) {
            // Update current weeks progress
            trackingDictionary[currentMondayDate] = currentProgress
            
        //
        // Current week doesn't exist
        } else {
            // Last updated week was last week |or| first week ever updated
            if keys.count == 0 || keys.last! == calendar.date(byAdding: .weekOfYear, value: -1, to: currentMondayDate) {
                // Create current weeks progress
                trackingDictionary.updateValue(currentProgress, forKey: currentMondayDate)
                
            // Skipped weeks
            } else {
                //
                // Update missed weeks with 0
                var startDate = keys.last!
                let endDate = calendar.date(byAdding: .day, value: -1, to: currentMondayDate)!
                // Loop adding 0 to dates
                while startDate <= endDate {
                    trackingDictionary.updateValue(0, forKey: startDate)
                    startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
                }
                // Update today
                trackingDictionary.updateValue(currentProgress, forKey: currentMondayDate)
            }
        }
        
        let testDic: [Date:Int] = trackingDictionary
        
    }
    
    // ----------------------------------------------------------------------------------------------------------------
    // MARK: Month %
    func updateMonthTracking() {
        //
        let calendar = Calendar(identifier: .gregorian)
        // Get Mondays date
        let firstDateInCurrentMonth = Date().firstDateInCurrentMonth
        //
        // Month Goal
        let currentProgressDivision: Double = (monthProgress / monthGoal) * 100
        let currentProgress = Int(currentProgressDivision)
        //
        // Keys
        let keys = monthTrackingDictionary.keys.sorted()
        
        // Note: Months defined by their first date
        //
        // Current week exists
        if keys.contains(firstDateInCurrentMonth) {
            // Update current weeks progress
            monthTrackingDictionary[firstDateInCurrentMonth] = currentProgress
            
            //
            // Current week doesn't exist
        } else {
            // Last updated week was last week |or| first week ever updated
            if keys.count == 0 || keys.last! == calendar.date(byAdding: .weekOfYear, value: -1, to: firstDateInCurrentMonth) {
                // Create current weeks progress
                monthTrackingDictionary.updateValue(currentProgress, forKey: firstDateInCurrentMonth)
                
                // Skipped weeks
            } else {
                //
                // Update missed weeks with 0
                var startDate = keys.last!
                let endDate = calendar.date(byAdding: .day, value: -1, to: firstDateInCurrentMonth)!
                // Loop adding 0 to dates
                while startDate <= endDate {
                    monthTrackingDictionary.updateValue(0, forKey: startDate)
                    startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
                }
                // Update today
                monthTrackingDictionary.updateValue(currentProgress, forKey: firstDateInCurrentMonth)
            }
        }
        //
        var testDic: [Date:Int] = monthTrackingDictionary
       
        
    }
    
    
    //
    // MARK: Walkthrough
    //
    //
    // Set Initial States
    func setWalkthrough(walkthroughView: UIView, walkthroughLabel: UILabel, walkthroughHighlight: UIView, nextButton: UIButton) -> UIView {
        //
        let screenSize = UIScreen.main.bounds
        
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
    func nextWalkthroughView(walkthroughView: UIView, walkthroughLabel: UILabel, walkthroughHighlight: UIView, walkthroughTexts: [String], walkthroughLabelFrame: Int, highlightSize: CGSize, highlightCenter: CGPoint, highlightCornerRadius: Int, backgroundColor: UIColor, textColor: UIColor, highlightColor: UIColor, animationTime: Double, walkthroughProgress: Int) {
        
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
            if highlightColor != .clear {
                walkthroughHighlight.backgroundColor = highlightColor.withAlphaComponent(0.5)
                walkthroughHighlight.layer.borderColor = highlightColor.cgColor
            } else {
                walkthroughHighlight.backgroundColor = nil
                walkthroughHighlight.layer.borderColor = nil
            }
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
                if highlightColor != .clear {
                    walkthroughHighlight.backgroundColor = highlightColor.withAlphaComponent(1)
                }
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    if highlightColor != .clear {
                        walkthroughHighlight.backgroundColor = highlightColor.withAlphaComponent(0.5)
                    }
                }, completion: nil)
            })
            
            
        })
    }

    //
    // Vibrate Phone
    func vibratePhone() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
//
}



//
// MARK: Button Extension
// UNUSED BUT MIGHT BE USED ONE DAY
extension UIButton {
    // Pulsate
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash(color: UIColor) {
        
        UIView.animate(withDuration: 0.05, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.backgroundColor = color.withAlphaComponent(0.5)
        }, completion: { finished in
            UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.backgroundColor = color.withAlphaComponent(0)
            }, completion: { finished in
                self.backgroundColor = nil
            })
        })
    }
}


//
extension Date {
    
    //
    // Day in week of date from monday, monday being 1
    var currentWeekDayFromMonday: Int {
        var currentWeekDay = Calendar(identifier: .gregorian).component(.weekday, from: Date())
        if currentWeekDay == 1 {
            currentWeekDay = 7
        } else if currentWeekDay > 1 {
            currentWeekDay -= 1
        }
        return currentWeekDay
    }
    
    //
    // First Monday in current week as Date
    var firstMondayInCurrentWeek: Date {
        var components = Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        components.timeZone = TimeZone(abbreviation: "UTC")
        // Making a Date from week components gives the first day of the week, hence Monday
        let mondaysDate = Calendar(identifier: .iso8601).date(from: components)
        return mondaysDate!
    }
    
    //
    // First Monday in month
    var firstMondayInMonth: Date {
        var components = Calendar(identifier: .iso8601).dateComponents([.year, .month], from: self)
        components.timeZone = TimeZone(abbreviation: "UTC")
        
        // First day of the month
        let firstDate = Calendar(identifier: .iso8601).date(from: components)
        let firstComponents = Calendar(identifier: .iso8601).dateComponents([.year, .month, .weekday], from: firstDate!)
        
        // Convert from Sunday=1 to Monday=1 day numbering
        let addWeekdays = 7 - ((firstComponents.weekday! + 5) % 7)
        // Jump forwards to next Monday if we arent already there
        var mondaysDate = firstDate
        if addWeekdays != 7 {
            mondaysDate = Calendar(identifier: .iso8601).date(byAdding: .day, value: addWeekdays, to: firstDate!)
        }
        return mondaysDate!
    }
    
    //
    // Number of Mondays in month
    var numberOfMondaysInCurrentMonth: Int {
        var components = Calendar(identifier: .iso8601).dateComponents([.year, .month], from: self)
        
        // First monday in month:
        components.weekday = 2
        components.weekdayOrdinal = 1
        let first = Calendar(identifier: .iso8601).date(from: components)
        
        // Last monday in month:
        components.weekdayOrdinal = -1
        let last = Calendar(identifier: .iso8601).date(from: components)
        
        // Difference in weeks:
        let weeks = Calendar(identifier: .iso8601).dateComponents([.weekOfMonth], from: first!, to: last!)
        return weeks.weekOfMonth! + 1
    }
    
    //
    // First day in month
    var firstDateInCurrentMonth: Date {
        var components = Calendar(identifier: .iso8601).dateComponents([.year, .month], from: self)
        components.timeZone = TimeZone(abbreviation: "UTC")
        
        // First day of the month
        let firstDateInCurrentMonth = Calendar(identifier: .iso8601).date(from: components)
        //
        return firstDateInCurrentMonth!
    }
    
}

