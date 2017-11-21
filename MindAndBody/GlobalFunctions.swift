//
//  GlobalFunctions.swift
//  MindAndBody
//
//  Created by Luke Smith on 05.08.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox.AudioServices
import StoreKit
import SystemConfiguration

//
// iPhone
class IPhoneType {
    static var shared = IPhoneType()
    private init () {}
    
    func iPhoneType() -> Int {
        // 0 == iPhone5
        if UIScreen.main.nativeBounds.height < 1334 {
            return 0
        // iPhone X
        } else if UIScreen.main.nativeBounds.height == 2436 {
            return 2
        // Normal
        } else {
            return 1
        }
    }
}

//
// Tracking Helper
class TrackingHelpers {
    static var shared = TrackingHelpers()
    private init () {}
    
    func dateToString(date: Date) -> String {
        // Convert to time interval
        let timeInterval = date.timeIntervalSince1970
        // Convert to string
        let dateAsString = String(timeInterval)
        return dateAsString
    }
    
    func stringToDate(string: String) -> Date {
        let timeInterval = Double(string)
        let stringAsDate = Date(timeIntervalSince1970: timeInterval!)
        return stringAsDate
    }
    
    func convertStringDictToDateDict(stringDict: [[String: Int]]) -> [[Date: Int]] {
        var dateDict: [[Date: Int]] = [[:], [:]]
        //
        for i in 0...stringDict.count - 1 {
            if stringDict[i].count != 0 {
                let keys = stringDict[i].keys.sorted()
                for j in 0...keys.count - 1 {
                    dateDict[i].updateValue(stringDict[i][keys[j]]!, forKey: stringToDate(string: keys[j]))
                }
            }
        }
        //
        return dateDict
    }
    
    func convertDateDictToStringDict(dateDict: [[Date: Int]]) -> [[String: Int]] {
        var stringDict: [[String: Int]] = [[:], [:]]
        //
        for i in 0...dateDict.count - 1 {
            if dateDict[i].count != 0 {
                let keys = dateDict[i].keys.sorted()
                for j in 0...keys.count - 1 {
                    stringDict[i].updateValue(dateDict[i][keys[j]]!, forKey: dateToString(date: keys[j]))
                }
            }
        }
        //
        return stringDict
    }
}

//
// Subscriptions check
class SubscriptionsCheck {
    static var shared = SubscriptionsCheck()
    private init() {}
    
    var isValid = false
    //
    // Check subscriptions
    func checkSubscription() {
        // If internet, check subscription with apple
        if Reachability.isConnectedToNetwork() {
            InAppManager.shared.checkSubscriptionAvailability()
        // If no internet, fall back to userDefaults
        } else {
            Loading.shared.shouldPresentLoading = false
            isValid = UserDefaults.standard.object(forKey: "userHasValidSubscription") as! Bool
        }
    }
}

//
// Loading
class Loading {
    static var shared = Loading()
    private init() {}
    
    var shouldPresentLoading = true
    
    var loadingView = UIView()
    //
    func beginLoading() {
        // Setup Alert
        loadingView.frame = UIScreen.main.bounds
        loadingView.backgroundColor = Colours.colour1
        let loadingImage = UIImageView()
        loadingImage.image = #imageLiteral(resourceName: "Loading")
        loadingImage.sizeToFit()
        loadingImage.center = loadingView.center
        loadingView.addSubview(loadingImage)
        
        // Setup indicator
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 25, y: loadingImage.frame.maxY, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = Colours.colour2
        loadingIndicator.startAnimating()
        loadingView.addSubview(loadingIndicator)
        
        // Present Alert
        UIApplication.shared.keyWindow?.addSubview(loadingView)
    }
    
    func endLoading() {
        loadingView.removeFromSuperview()
    }
}

// Thanks to RAJAMOHAN-S on stack overflow
public class Reachability {
    //
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}

//
// MARK: - Global Function as extensions
//

//
// View Controller
extension UIViewController {
    
    //
    // Add background Image
    func addBackgroundImage(withBlur: Bool, fullScreen: Bool) {
        //
        // Background Image View
        let backgroundImage = UIImageView()
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        // Frame
        if fullScreen == true {
            backgroundImage.frame = UIScreen.main.bounds
        } else {
            backgroundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - (TopBarHeights.statusBarHeight + CGFloat(TopBarHeights.navigationBarHeight)))
        }
        //
        // Background Image
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let backgroundIndex = settings["BackgroundImage"]![0]
        // Background Image/Colour
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            backgroundImage.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
            backgroundImage.image = nil
            backgroundImage.backgroundColor = Colours.colour1
        }
        view.insertSubview(backgroundImage, at: 0)
        //
        // BackgroundBlur/Vibrancpy
        if withBlur == true {
            let backgroundBlur = UIVisualEffectView()
            let backgroundBlurE = UIBlurEffect(style: .dark)
            backgroundBlur.effect = backgroundBlurE
            backgroundBlur.isUserInteractionEnabled = false
            //
            backgroundBlur.frame = backgroundImage.bounds
            //
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
        }
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
        animationView.backgroundColor = Colours.colour2
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
        titleString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "SFUIDisplay-light", size: 22)!, range: NSMakeRange(0, titleString.length))
        //
        let centering = NSMutableParagraphStyle()
        centering.alignment = .center
        titleString.addAttribute(NSAttributedStringKey.paragraphStyle, value: centering, range: NSMakeRange(0, titleString.length))
        
        //
        titleString.append(return2)
        
        //
        // Title Attributes
        let subTitleFont: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font : UIFont(name: "SFUIDisplay-light", size: 22) as Any]
        //
        // Bullet Point Attributes
        let bulletPointFont: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font : UIFont(name: "SFUIDisplay-thin", size: 22) as Any]
        //
        let paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: [:])]
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
            
            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
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
            
            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
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
            
            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
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
        // Reset if last reset wasn't is current week
        ScheduleVariables.shared.resetWeekTracking()
        //
        var trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        // Increment Progress
        trackingProgressDictionary["WeekProgress"] = trackingProgressDictionary["WeekProgress"] as! Int + 1
        UserDefaults.standard.set(trackingProgressDictionary, forKey: "trackingProgress")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["trackingProgress"])
    }
   
    
    // Schedule Tracking
    func updateScheduleTracking(fromSchedule: Bool) {
        if fromSchedule == true {
            let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[[[Any]]]]
            // Day
            if schedules[ScheduleVariables.shared.selectedSchedule][1][1][0] as! Int == 0 {
                // Update day
                var scheduleTracking = UserDefaults.standard.object(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
                scheduleTracking[ScheduleVariables.shared.selectedSchedule][ScheduleVariables.shared.selectedDay][ScheduleVariables.shared.selectedRows[0]][1][ScheduleVariables.shared.selectedRows[1]] = true
                // Set
                UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["trackingProgress"])
                // Reload
                ScheduleVariables.shared.shouldReloadChoice = true
                // Week
            } else if schedules[ScheduleVariables.shared.selectedSchedule][1][1][0] as! Int == 1 {
                // Update week [7]
                var scheduleTracking = UserDefaults.standard.object(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
                scheduleTracking[ScheduleVariables.shared.selectedSchedule][7][ScheduleVariables.shared.selectedRows[0]][1][ScheduleVariables.shared.selectedRows[1]] = true
                // Set
                UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["trackingProgress"])
                // Reload
                ScheduleVariables.shared.shouldReloadChoice = true
            }
        }
    }
    
    // NOTE: Func to reset schedule tracking and week tracking found in globalVariables, Schedule data, as needs to be contained in a class
    // TODO: TURN THIS ENTIRE DOCUMENT INTO SEVERAL CLASSES CONTAINING A SHARED, AND THE FUNCTIONS, SO FUNCTIONS CAN BE CALLED MORE LEGIBLY BY CLASS.SHARED.FUNCTION
    // ----------------------------------------------------------------------------------------------------------------
    // Update Tracking Arrays
    //
    // MARK: Monday  - Sunday
    func updateWeekTracking() {
        let trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        let trackingDictionariesString = UserDefaults.standard.object(forKey: "trackingDictionaries") as! [[String: Int]]
        
        // Convert to [Date: Int]
        var trackingDictionaries: [[Date: Int]] = TrackingHelpers.shared.convertStringDictToDateDict(stringDict: trackingDictionariesString)
        //
        let calendar = Calendar(identifier: .gregorian)
        // Current Date
        let currentDate = Date().currentDate
        // Get Mondays date
        let currentMondayDate = Date().firstMondayInCurrentWeek
        //
        // Week Goal
        let weekProgress: Double = trackingProgressDictionary["WeekProgress"] as! Double
        let weekGoal: Double = trackingProgressDictionary["WeekGoal"] as! Double
        let currentProgressDivision: Double = (weekProgress / weekGoal) * 100.0
        let currentProgress = Int(currentProgressDivision)
        //
        // Keys
        let keys = trackingDictionaries[0].keys.sorted()
        
        //
        // Update
        // Week has already begun
        if keys.contains(currentMondayDate) {
            //
            // Day already started
            if keys.last == currentDate {
                trackingDictionaries[0][currentDate] = currentProgress
                
            //
            // Day is next in line
            } else if keys.last == calendar.date(byAdding: .day, value: -1, to: currentDate) {
                trackingDictionaries[0].updateValue(currentProgress, forKey: currentDate)
                
            //
            // Day isn't next in line
            } else if keys.last! < calendar.date(byAdding: .day, value: -1, to: currentDate)! {
                //
                // Update missed days with 0
                var startDate = keys.last!
                let startValue = trackingDictionaries[0][startDate]!
                let endDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
                // Loop last adding previous value to dates
                while startDate <= endDate {
                    trackingDictionaries[0].updateValue(startValue, forKey: startDate)
                    startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
                }
                // Update today
                trackingDictionaries[0].updateValue(currentProgress, forKey: currentDate)
            }
            
        // Week hasn't begun (should start) / user has't done anything this week
        } else {
            // Clear
            trackingDictionaries[0] = [:]
            // If today is monday, clear array and create monday
            if currentDate == currentMondayDate {
                trackingDictionaries[0].updateValue(currentProgress, forKey: currentMondayDate)
                
            // Today isn't monday
            } else {
                //
                // Update missed days with 0
                var startDate = currentMondayDate
                let endDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
                // Loop adding 0 to dates
                while startDate <= endDate {
                    trackingDictionaries[0].updateValue(0, forKey: startDate)
                    startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
                }
                // Update today
                trackingDictionaries[0].updateValue(currentProgress, forKey: currentDate)
            }
        }
        
        // Convert back to [String: Int]
        let updatedTrackingDictionariesString: [[String: Int]] = TrackingHelpers.shared.convertDateDictToStringDict(dateDict: trackingDictionaries)
        
        // Save
        UserDefaults.standard.set(updatedTrackingDictionariesString, forKey: "trackingDictionaries")
        ICloudFunctions.shared.pushToICloud(toSync: ["trackingDictionaries"])
    }
    
    
    // ----------------------------------------------------------------------------------------------------------------
    // MARK: Week %
    func updateTracking() {
        let trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        let trackingDictionariesString = UserDefaults.standard.object(forKey: "trackingDictionaries") as! [[String: Int]]
        
        // Convert to [Date: Int]
        var trackingDictionaries: [[Date: Int]] = TrackingHelpers.shared.convertStringDictToDateDict(stringDict: trackingDictionariesString)
        //
        let calendar = Calendar(identifier: .gregorian)
        // Get Mondays date
        let currentMondayDate = Date().firstMondayInCurrentWeek
        //
        // Week Goal
        let weekProgress: Double = trackingProgressDictionary["WeekProgress"] as! Double
        let weekGoal: Double = trackingProgressDictionary["WeekGoal"] as! Double
        let currentProgressDivision: Double = (weekProgress / weekGoal) * 100.0
        let currentProgress = Int(currentProgressDivision)
        //
        // Keys
        let keys = trackingDictionaries[1].keys.sorted()
        
        //
        // Note: Weeks defined by their mondays date
        // Current week exists
        if keys.contains(currentMondayDate) {
            // Update current weeks progress
            trackingDictionaries[1][currentMondayDate] = currentProgress
            
        //
        // Current week doesn't exist
        } else {
            // Last updated week was last week |or| first week ever updated
            if keys.count == 0 || keys.last! == calendar.date(byAdding: .weekOfYear, value: -1, to: currentMondayDate) {
                // Create current weeks progress
                trackingDictionaries[1].updateValue(currentProgress, forKey: currentMondayDate)
                
            // Skipped weeks
            } else {
                //
                // Update missed weeks with 0
                var startDate = keys.last!
                // Loop adding 0 to dates
                while startDate < currentMondayDate {
                    trackingDictionaries[1].updateValue(0, forKey: startDate)
                    // For some reason adding a week adds an extra hour here but not in other places, so add on a weeks worth of hours
                    startDate = calendar.date(byAdding: .hour, value: 168, to: startDate)!
                }
                // Update today
                trackingDictionaries[1].updateValue(currentProgress, forKey: currentMondayDate)
            }
        }
        
        // Convert back to [String: Int]
        let updatedTrackingDictionariesString: [[String: Int]] = TrackingHelpers.shared.convertDateDictToStringDict(dateDict: trackingDictionaries)
        
        // Save
        UserDefaults.standard.set(updatedTrackingDictionariesString, forKey: "trackingDictionaries")
        ICloudFunctions.shared.pushToICloud(toSync: ["trackingDictionaries"])
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
        walkthroughHighlight.backgroundColor = Colours.colour1.withAlphaComponent(0.5)
        walkthroughHighlight.layer.borderColor = Colours.colour1.cgColor
        walkthroughHighlight.layer.borderWidth = 1
        
        // Label
        walkthroughLabel.frame = CGRect(x: 13, y: 0, width: view.frame.size.width - 26, height: 0)
        walkthroughLabel.center = view.center
        walkthroughLabel.textAlignment = .center
        walkthroughLabel.numberOfLines = 0
        walkthroughLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        walkthroughLabel.layer.cornerRadius = 13
        walkthroughLabel.clipsToBounds = true
        walkthroughLabel.backgroundColor = Colours.colour1
        walkthroughLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        walkthroughLabel.textColor = Colours.colour2
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
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate) {
            // do what you'd like now that the sound has completed playing
        }
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
// MARK:- Tableview cell
extension UITableViewCell {
    // Get Uncached Image
    func getUncachedImage(named: String) -> UIImage? {
        let imgPath = Bundle.main.path(forResource: named, ofType: "png")
        let imageToReturn = UIImage(contentsOfFile: imgPath!)
        return imageToReturn
    }
}

// MARK:- Date
extension Date {
    
    var currentDate: Date {
        var components = Calendar(identifier: .iso8601).dateComponents([.year, .month, .weekOfMonth, .day], from: self)
        components.timeZone = TimeZone(abbreviation: "UTC")
        // Making a Date from week components gives the first day of the week, hence Monday
        let currentDate = Calendar(identifier: .iso8601).date(from: components)
        return currentDate!
    }
    
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
    var firstDateInMonth: Date {
        var components = Calendar(identifier: .iso8601).dateComponents([.year, .month], from: self)
        components.timeZone = TimeZone(abbreviation: "UTC")
        
        // First day of the month
        let firstDateInCurrentMonth = Calendar(identifier: .iso8601).date(from: components)
        //
        return firstDateInCurrentMonth!
    }
    
    //
    var firstDateInYear: Date {
        var components = Calendar(identifier: .iso8601).dateComponents([.year], from: self)
        components.timeZone = TimeZone(abbreviation: "UTC")
        
        // First day of the month
        let firstDateInCurrentMonth = Calendar(identifier: .iso8601).date(from: components)
        //
        return firstDateInCurrentMonth!
    }
    
}

//
// MARK: String
extension String {
    // MARK: Label height
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        //
        return label.frame.height
    }
//    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
//
//        return ceil(boundingBox.height)
//    }
}

