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
import UserNotifications

//
// iPhone
class IPhoneType {
    static var shared = IPhoneType()
    private init() {}
    
    func iPhoneType() -> Int {
        // Device
        switch UIDevice.current.userInterfaceIdiom {
        // Phone
        case .phone:
            // 0 == iPhone5
            if UIScreen.main.nativeBounds.height < 1334 {
                return 0
            // 2 == iPhoneX
            } else if UIScreen.main.nativeBounds.height == 2436 {
                return 2
            // 1 == normal
            } else {
                return 1
            }
        // iPad
        case .pad:
            return 3
        // Uh, oh! What could it be?
        default:
            return 1
        }
    }
}

// Vibrate
class Vibrate {
    static var shared = Vibrate()
    private init() {}
    
    //
    // Vibrate Phone
    func vibratePhone() {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate) {
            // do what you'd like now that the sound has completed playing
        }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

// Notification
class ReminderNotifications {
    static var shared = ReminderNotifications()
    private init() {}
    
    // Sets morning and/or everning repeating notifiations
        // Could be called reset, as clears before setting
    func setNotifications() {
        // Reset
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        //
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let notificationSettings = settings["ReminderNotifications"]
        //
        let cal: Calendar = Calendar.current
        //
        // Double check notifications are on
        if notificationSettings![0] == 1 {
            //
            let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]

            if schedules.count != 0 {
                // Day view: set notifications for each day something is planned
                let scheduleStyle = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int
                if scheduleStyle == 0 {
                    // Loop week
                    for i in 0...6 {
                        // Check day
                        let dayCount = schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i].count
                        if dayCount != 0 {
                            //
                            // Set morning notifications
                            let morningContent = UNMutableNotificationContent()
                            morningContent.title = NSLocalizedString("mindBodySchedule", comment: "")
                            // Session not plural
                            if dayCount == 1 {
                                morningContent.body = NSLocalizedString("morningNotification1", comment: "") + String(schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i].count) + NSLocalizedString("morningNotification21", comment: "")
                            // Sessions plural
                            } else {
                                morningContent.body = NSLocalizedString("morningNotification1", comment: "") + String(schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i].count) + NSLocalizedString("morningNotification2", comment: "")
                            }
                            
                            // Sound
                            morningContent.sound = UNNotificationSound.default()
                            
                            // App Badge Counter
                            morningContent.badge = dayCount as NSNumber
                            
                            // Get day of week
                            let morningDate = Date().firstMondayInCurrentWeek
                            let morningDateToSchedule = cal.date(byAdding: .day, value: i, to: morningDate)
                            // Get 7 in morning
                            let dateToScheduleWithTime: Date = cal.date(bySettingHour: 7, minute: 0, second: 0, of: morningDateToSchedule!)!

                            
                            // Get trigger daye
                            let triggerDate =  Calendar.current.dateComponents([.weekday,.hour,.minute], from: dateToScheduleWithTime)
                            
                            // Set trigger
                            let morningTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                            let identifier = "morningReminderNotification" + String(i)
                            let morningRequest = UNNotificationRequest(identifier: identifier, content: morningContent, trigger: morningTrigger)
                            
                            //
                            UNUserNotificationCenter.current().add(morningRequest, withCompletionHandler: nil)
                        }
                        
                        //

                        //
                        // Set sunday notification
                        let sundayContent = UNMutableNotificationContent()
                        sundayContent.title = NSLocalizedString("mindBodySchedule", comment: "")
                        sundayContent.body = NSLocalizedString("sundayNotification", comment: "")
                        
                        sundayContent.sound = UNNotificationSound.default()
                        
                        // Get day of week
                        let mondayDate = Date().firstMondayInCurrentWeek
                        let sundayDateToSchedule = cal.date(byAdding: .day, value: 6, to: mondayDate)
                        // Get 7 in sunday
                        let sundayDateToScheduleWithTime: Date = cal.date(bySettingHour: 19, minute: 0, second: 0, of: sundayDateToSchedule!)!
                        
                        // Get trigger day
                        let sundayTriggerDate =  Calendar.current.dateComponents([.weekday,.hour,.minute], from: sundayDateToScheduleWithTime)
                        
                        // Set trigger
                        let sundayTrigger = UNCalendarNotificationTrigger(dateMatching: sundayTriggerDate, repeats: true)
                        let sundayRequest = UNNotificationRequest(identifier: "sundayReminderNotification", content: sundayContent, trigger: sundayTrigger)
                        //
                        UNUserNotificationCenter.current().add(sundayRequest, withCompletionHandler: nil)
                    }
                // Week view: set notifications for each day ??
                } else {
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    //
                    // Set monday notification
                    let mondayContent = UNMutableNotificationContent()
                    mondayContent.title = NSLocalizedString("mindBodySchedule", comment: "")
                    //
                    var count = Int()
                    // Loop week
                    for i in 0...6 {
                        count += schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i].count
                    }
                    mondayContent.body = NSLocalizedString("morningNotification1", comment: "") + String(count) + NSLocalizedString("weekNotification2", comment: "")
                    mondayContent.sound = UNNotificationSound.default()
                    
                    // App Badge Counter
                    mondayContent.badge = count as NSNumber
                    
                    // Get day of week
                    let mondayDate = Date().firstMondayInCurrentWeek
                    // Get 7 in monday
                    let mondayDateToScheduleWithTime: Date = cal.date(bySettingHour: 7, minute: 0, second: 0, of: mondayDate)!
                    // Get trigger day
                    let triggerDate =  Calendar.current.dateComponents([.weekday,.hour,.minute], from: mondayDateToScheduleWithTime)

                    
                    // Set trigger
                    let mondayTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                    let mondayRequest = UNNotificationRequest(identifier: "mondayReminderNotification", content: mondayContent, trigger: mondayTrigger)
                    //
                    UNUserNotificationCenter.current().add(mondayRequest, withCompletionHandler: nil)
                    
                    //
                    // Set sunday notification
                    let sundayContent = UNMutableNotificationContent()
                    sundayContent.title = NSLocalizedString("mindBodySchedule", comment: "")
                    sundayContent.body = NSLocalizedString("sundayNotification", comment: "")
                    
                    sundayContent.sound = UNNotificationSound.default()
                    mondayContent.badge = 0

                    // Get day of week
                    let sundayDateToSchedule = cal.date(byAdding: .day, value: 6, to: mondayDate)
                    // Get 7 in sunday
                    let sundayDateToScheduleWithTime: Date = cal.date(bySettingHour: 19, minute: 0, second: 0, of: sundayDateToSchedule!)!
                    
                    // Get trigger day
                    let sundayTriggerDate =  Calendar.current.dateComponents([.weekday,.hour,.minute], from: sundayDateToScheduleWithTime)
                    
                    // Set trigger
                    let sundayTrigger = UNCalendarNotificationTrigger(dateMatching: sundayTriggerDate, repeats: true)
                    let sundayRequest = UNNotificationRequest(identifier: "sundayReminderNotification", content: sundayContent, trigger: sundayTrigger)
                    //
                    UNUserNotificationCenter.current().add(sundayRequest, withCompletionHandler: nil)
                }
                
                
                // Update current badge count, only useful if user switches between scheduleStyles, i.e from view full week to view each day and vice versa, or for when this gets reset in the middle of a day
                // View each day
                if scheduleStyle == 0 {
                    let currentDay = Date().weekDayFromMonday
                    var currentCount: Int = 0
                    // Loop current day counting how much has been done
                    if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![currentDay].count != 0 {
                        for j in 0..<schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![currentDay].count {
                            if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![currentDay][j]["isGroupCompleted"] as! Bool == false {
                                currentCount += 1
                            }

                        }
                    }
                    UIApplication.shared.applicationIconBadgeNumber = currentCount
                // View full week
                } else {
                    var currentCount: Int = 0
                    // Loop week
                    for i in 0...6 {
                        // If day not empty
                        if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i].count != 0 {
                            // Loop day counting how much has been done
                            for j in 0..<schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i].count {
                                if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i][j]["isGroupCompleted"] as! Bool == false {
                                    currentCount += 1
                                }
                                
                            }
                        }
                    }
                    UIApplication.shared.applicationIconBadgeNumber = currentCount
                }
                
            } // end schedules.count
        } // end notificationSettings![0] == 1
    }
    
    // removes all pending notifications (as there should only be repeating notifications that are pending, if ever notifications used more, this should be changed to only cancel repeating notifiations
    func cancelNotifications() {
        // Cancel Notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        // Remove badges
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    // Update badges func
        // Note
            // Current Bool = False if False -> True, True if True -> False
    func updateBadges(day: Int, currentBool: Bool) {
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // Get schedule style
        var scheduleStyle = Int()
        if schedules.count != 0 {
            scheduleStyle = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int
        } else {
            scheduleStyle = 0
        }

        // Update badge
        // Day View, scheduleStyle 0
        if scheduleStyle == 0 {
            // If current day
            if day == (Date().weekDayFromMonday) {
                // True -> False, increment badge
                if currentBool {
                    updateBadgeCounter(increment: true)
                // False -> True, decrement badge
                } else {
                    updateBadgeCounter(increment: false)
                }
            // If not current day but current day is empty (Description below)
            } else if day != (Date().weekDayFromMonday) && schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![(Date().weekDayFromMonday)].count == 0 {
                // If not current day but current day is empty:
                // This indicates that if something is completed, the user has probably missed a day and is doing it the next day on the empty day, only allow decrementing
                // The badges are set in the morning of a day when there is something to be done, and updated throughout the day. If the user does nothing the badges stay there until the next day there is something and the badges are updated in the morning, or if they do something on an empty day as described above.
                // This is not perfect but its ok for now
                
                // False -> True, decrement badge
                if !currentBool {
                    updateBadgeCounter(increment: false)
                }
            }
        // Week View, scheduleStyle 1
        } else {
            // True -> False, increment badge
            if currentBool {
                updateBadgeCounter(increment: true)
                // False -> True, decrement badge
            } else {
                updateBadgeCounter(increment: false)
            }
        }
    }
    
    // Update Badge Counter
    func updateBadgeCounter(increment: Bool) {
        // Increment
        if increment {
            UIApplication.shared.applicationIconBadgeNumber += 1
            // Decrement
        } else {
            if UIApplication.shared.applicationIconBadgeNumber < 2 {
                UIApplication.shared.applicationIconBadgeNumber = 0
            } else {
                UIApplication.shared.applicationIconBadgeNumber -= 1
            }
        }
    }
}

//
// Tracking Helper
class TrackingHelpers {
    static var shared = TrackingHelpers()
    private init() {}
    
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
    // Check subscriptions, called from AppDelegate when first opening, to see if need to present subscription screen
    func checkSubscription() {
        // If internet, check subscription with apple
        if Reachability.isConnectedToNetwork() {
            InAppManager.shared.checkSubscriptionAvailability()
        // If no internet, fall back to userDefaults
        } else {
            Loading.shared.shouldPresentLoading = false
            isValid = UserDefaults.standard.object(forKey: "userHasValidSubscription") as! Bool
            if isValid {
                DispatchQueue.main.async {
                    // nina
                    NotificationCenter.default.post(name: SubscriptionNotifiations.didCheckSubscription, object: nil)
                    NotificationCenter.default.post(name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
                }
            } else {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: SubscriptionNotifiations.didCheckSubscription, object: nil)
                }
            }
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
        loadingView.backgroundColor = Colors.light
        let loadingImage = UIImageView()
        loadingImage.image = #imageLiteral(resourceName: "Loading")
        loadingImage.sizeToFit()
        loadingImage.center = loadingView.center
        loadingView.addSubview(loadingImage)
        
        // Setup indicator
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 25, y: loadingImage.frame.maxY, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = Colors.dark
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

// Bells -> Images
class BellsFunctions {
    
    static var shared = BellsFunctions()
    private init() {}
    
    let bellsArray: [String] =
        ["tibetanChimes", "tibetanBowlL", "tibetanBowlL4", "tibetanBowlLS", "tibetanBowlH", "tibetanBowlH4", "tibetanBowlHS", "rainStick", "rainStick2", "rainStick2S", "windChimes", "gambangWU", "gambangWD", "gambangM", "indonesianFrog", "cowBellS", "cowBellB"]
    
    let conversionDict: [String: UIImage] =
        ["tibetanChimes": #imageLiteral(resourceName: "Tibetan Chimes"),
         "tibetanBowlL": #imageLiteral(resourceName: "Tibetan Bowl Big"),
         "tibetanBowlL4":#imageLiteral(resourceName: "Tibetan Bowl Big"),
         "tibetanBowlLS":#imageLiteral(resourceName: "Tibetan Bowl Big"),
         "tibetanBowlH":#imageLiteral(resourceName: "Tibetan Bowl Small"),
         "tibetanBowlH4":#imageLiteral(resourceName: "Tibetan Bowl Small"),
         "tibetanBowlHS":#imageLiteral(resourceName: "Tibetan Bowl Small"),
         "rainStick":#imageLiteral(resourceName: "Australian Rain Stick"),
         "rainStick2":#imageLiteral(resourceName: "Australian Rain Stick"),
         "rainStick2S":#imageLiteral(resourceName: "Australian Rain Stick"),
         "windChimes":#imageLiteral(resourceName: "Wind Chimes"),
         "gambangWU":#imageLiteral(resourceName: "Indonesian Xylophone Big"),
         "gambangWD":#imageLiteral(resourceName: "Indonesian Xylophone Big"),
         "gambangM":#imageLiteral(resourceName: "Indonesian Xylophone Small"),
         "indonesianFrog":#imageLiteral(resourceName: "Indonesian Frog"),
         "cowBellS":#imageLiteral(resourceName: "Cow Bell"),
         "cowBellB":#imageLiteral(resourceName: "Cow Bell Big")]
    
    // Get Image from bell name
    func bellToImage(name: String) -> UIImage {
        return conversionDict[name]!
    }
}

// For initial choice question from Sessions screen, as this is where the 'C' button from which you can create custom sessions is found on multiple screens
    // Walkthrough used by multiple screens so put in seperate class
class CustomWalkthrough {
    
    static var shared = CustomWalkthrough()
    private init() {}
    
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabel = UILabel()
    var nextButton = UIButton()
    
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["customWalkthrough"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    //
    // Walkthrough
    func beginWalkthrough(viewController: UIViewController, customButton: UIButton) {
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["CustomSessions"] == false {
            walkthroughCustom(viewController: viewController, customButton: customButton)
        }
    }
    
    // Walkthrough
    @objc func walkthroughCustom(viewController: UIViewController, customButton: UIButton) {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughCustom), for: .touchUpInside)
            walkthroughView = viewController.setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Homepage
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: viewController.view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: viewController.view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            walkthroughLabel.center.y -= TopBarHeights.combinedHeight
            
            // Colour
            walkthroughLabel.textColor = Colors.light
            walkthroughLabel.backgroundColor = Colors.dark
            walkthroughHighlight.backgroundColor = Colors.dark.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.dark.cgColor
            // Highlight
            walkthroughHighlight.frame = customButton.frame
            walkthroughHighlight.center = customButton.center
            walkthroughHighlight.center.y += TopBarHeights.combinedHeight
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = Colors.dark.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colors.dark.withAlphaComponent(0.5)
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
                walkthroughs["CustomSessions"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            })
        }
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
        if fullScreen {
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
            backgroundImage.backgroundColor = Colors.light
        }
        view.insertSubview(backgroundImage, at: 0)
        //
        // BackgroundBlur/Vibrancpy
        if withBlur {
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
        animationView.backgroundColor = Colors.dark
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
    // MARK: Update Tracking ---------
    //
    // MARK: Week Progress
    func updateWeekProgress() {
        // Reset if last reset wasn't in current week
        ScheduleVariables.shared.resetWeekTracking()
        //
        var trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        // Increment Progress
        
        // Recalculate progress each time to be absolutely sure!!!
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        var completedCount: Int = 0
        if schedules.count != 0 {
            // Loop week
            for i in 0...6 {
                // If day isn't empty
                if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i].count != 0 {
                    // Loop day
                    for j in 0..<schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i].count {
                        //
                        if schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i][j]["isGroupCompleted"] as! Bool == true {
                            completedCount += 1
                        }
                    }
                }
            }
        }
        // Update value
        trackingProgressDictionary["WeekProgress"] = completedCount
        // Updates
        UserDefaults.standard.set(trackingProgressDictionary, forKey: "trackingProgress")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["trackingProgress"])
    }
    
    //
    // MARK: Week goal
    func updateWeekGoal() {
        //
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        var trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        // Find goal = number of groups planned = fullWeekArray.count
        var goal = Int()
        if schedules.count != 0 {
            // Loop week
            for i in 0...6 {
                goal += schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![i].count
            }
        } else {
            goal = 1
        }
        // SetWeekGoal
        if goal != 0 {
            trackingProgressDictionary["WeekGoal"] = goal
        } else {
            trackingProgressDictionary["WeekGoal"] = 1
        }
        //
        UserDefaults.standard.set(trackingProgressDictionary, forKey: "trackingProgress")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["trackingProgress"])
    }
    
    // MARK: Schedule Tracking
        // Updates the 'finalChoice' of the group
    func updateScheduleTracking(fromSchedule: Bool) {
        // Only relevant if coming from schedule, check here because only need to code this once instead of every time the function is called
        if fromSchedule {
            //
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
            
            // Indexing variables
            // Differ if last choice or first choice
            let indexingVariables = getIndexingVariablesForSession()
            // index0 = selected row in initial choice screen (schedule homescreen selected group) i.e index to group in current day in schedule
            let index0 = indexingVariables.0
            // index1 = Selected row in final choice (i.e warmup, session, stretching)
            let index1 = indexingVariables.1
            // day
            let day = indexingVariables.2
            
            // Update
            schedules[ScheduleVariables.shared.selectedSchedule]["schedule"]![day][index0][index1] = true
            // Update Badges
                // currentBool == False as False -> True
            ReminderNotifications.shared.updateBadges(day: day, currentBool: false)
            // Set
            UserDefaults.standard.set(schedules, forKey: "schedules")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["trackingProgress"])
            // Reload
            ScheduleVariables.shared.shouldReloadChoice = true
        }
    }
    
    func getIndexingVariablesForSession() -> (Int, String, Int) {
        //
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]

        // Indexing variables
        // index0 = selected row in initial choice screen (schedule homescreen selected group) i.e index to group in current day in schedule
        var index0 = Int()
        // index1 = Selected row in final choice (i.e warmup, session, stretching)
        var index1 = String()
        //
        var selectedDay = Int()
        
        // Day view - index is simply row
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int == 0 {
            index0 = ScheduleVariables.shared.selectedRows[0]
            selectedDay = ScheduleVariables.shared.selectedDay
        // Week view -  find stored index to schedule week using temporary full week array
        } else {
            index0 = TemporaryWeekArray.shared.weekArray[ScheduleVariables.shared.selectedRows[0]]["index"] as! Int
            selectedDay = TemporaryWeekArray.shared.weekArray[ScheduleVariables.shared.selectedRows[0]]["day"] as! Int
        }
        //
        index1 = String(ScheduleVariables.shared.selectedRows[1])
        return (index0, index1, selectedDay)
    }
    
    // NOTE: Func to reset schedule tracking and week tracking found in globalVariables, Schedule data, as needs to be contained in a class
    // TODO: TURN THIS ENTIRE DOCUMENT INTO SEVERAL CLASSES CONTAINING A SHARED, AND THE FUNCTIONS, SO FUNCTIONS CAN BE CALLED MORE LEGIBLY BY CLASS.SHARED.FUNCTION
    // ----------------------------------------------------------------------------------------------------------------
    // MARK: Update Tracking Arrays ---------
    //
    // MARK: Monday  - Sunday
    func updateWeekTracking() {
        let trackingProgressDictionary = UserDefaults.standard.object(forKey: "trackingProgress") as! [String: Any]
        let trackingDictionariesString = UserDefaults.standard.object(forKey: "trackingDictionaries") as! [[String: Int]]
        
        // Convert to [Date: Int]
        var trackingDictionaries: [[Date: Int]] = TrackingHelpers.shared.convertStringDictToDateDict(stringDict: trackingDictionariesString)
        //
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        // Current Date
        let currentDate = Date().setToMidnightUTC()
        // Get Mondays date
        let currentMondayDate = Date().firstMondayInCurrentWeek
        //
        // Week Goal
        let weekProgress: Double = trackingProgressDictionary["WeekProgress"] as! Double
        let weekGoal: Double = trackingProgressDictionary["WeekGoal"] as! Double
        let currentProgressDivision: Double = (weekProgress / weekGoal) * 100.0
        var currentProgress = Int(currentProgressDivision)
        // Limit to 100
        if currentProgress > 100 {
            currentProgress = 100
        }
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
                let endDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!.setToMidnightUTC()
                // Loop last adding previous value to dates
                while startDate <= endDate {
                    trackingDictionaries[0].updateValue(startValue, forKey: startDate)
                    // Increment and ensure that midnight utc
                    startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!.setToMidnightUTC()
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
                let endDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!.setToMidnightUTC()
                // Loop adding 0 to dates
                while startDate <= endDate {
                    trackingDictionaries[0].updateValue(0, forKey: startDate)
                    startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!.setToMidnightUTC()
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
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        // Get Mondays date
        let currentMondayDate = Date().firstMondayInCurrentWeek
        //
        // Week Goal
        let weekProgress: Double = trackingProgressDictionary["WeekProgress"] as! Double
        let weekGoal: Double = trackingProgressDictionary["WeekGoal"] as! Double
        let currentProgressDivision: Double = (weekProgress / weekGoal) * 100.0
        var currentProgress = Int(currentProgressDivision)
        // Limit to 100
        if currentProgress > 100 {
            currentProgress = 100
        }
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
            if keys.count == 0 || keys.last! == calendar.date(byAdding: .weekOfYear, value: -1, to: currentMondayDate)?.setToMidnightUTC() {
                // Create current weeks progress
                trackingDictionaries[1].updateValue(currentProgress, forKey: currentMondayDate)
                
            // Skipped weeks
            } else {
                //
                // Update missed weeks with 0, starting with week after last updated value
                var startDate = calendar.date(byAdding: .weekOfYear, value: 1, to: keys.last!)!.setToMidnightUTC()

                // Loop adding 0 to dates
                while startDate < currentMondayDate {
                    trackingDictionaries[1].updateValue(0, forKey: startDate)
                    // For some reason adding a week adds an extra hour here but not in other places, so add on a weeks worth of hours
                    startDate = calendar.date(byAdding: .weekOfYear, value: 1, to: startDate)!.setToMidnightUTC()
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
    
    
    
    // MARK: ---------
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
        walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
        walkthroughHighlight.layer.borderColor = Colors.light.cgColor
        walkthroughHighlight.layer.borderWidth = 1
        
        // Label
        walkthroughLabel.frame = CGRect(x: 13, y: 0, width: view.frame.size.width - 26, height: 0)
        walkthroughLabel.center = view.center
        walkthroughLabel.textAlignment = .center
        walkthroughLabel.numberOfLines = 0
        walkthroughLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        walkthroughLabel.layer.cornerRadius = 13
        walkthroughLabel.clipsToBounds = true
        walkthroughLabel.backgroundColor = Colors.light
        walkthroughLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        walkthroughLabel.textColor = Colors.dark
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
            // Iphone X
            if IPhoneType.shared.iPhoneType() == 2 {
                walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13 - TopBarHeights.homeIndicatorHeight, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            } else {
                walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            }
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
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                //
                if highlightColor != .clear {
                    walkthroughHighlight.backgroundColor = highlightColor.withAlphaComponent(1)
                }
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.1, animations: {
                    //
                    if highlightColor != .clear {
                        walkthroughHighlight.backgroundColor = highlightColor.withAlphaComponent(0.5)
                    }
                }, completion: nil)
            })
            
        })
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
    
    // Ensure date is set to midnight UTC
    func setToMidnightUTC() -> Date {
        // Get date to set to midnight
        var dateAtMidnight = self
        // Set to midnight
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        dateAtMidnight = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: dateAtMidnight)!
        // Return
        return dateAtMidnight
    }
    
    //
    // Day in week of date from monday, monday being 1
    var weekDayFromMonday: Int {
        var calendar = Calendar(identifier: .iso8601)
        // Only time we don't use "UTC" time zone as we want users current day in week
        calendar.timeZone = TimeZone.current
        // component gives us 1 for sunday through to 7 for monday, we want 0 for monday so shift
        var currentWeekDay = calendar.component(.weekday, from: self)
        // 2 is monday but we want 0 and monday so shift by 2
        if currentWeekDay == 1 {
            currentWeekDay = 6
        } else if currentWeekDay > 1 {
            currentWeekDay -= 2
        }
        return currentWeekDay
    }
    
    //
    // First Monday in current week as Date
    var firstMondayInCurrentWeek: Date {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        components.timeZone = TimeZone(abbreviation: "UTC")
        // Making a Date from week components gives the first day of the week, hence Monday
        let mondaysDate = calendar.date(from: components)?.setToMidnightUTC()
        return mondaysDate!
    }
    
    //
    // First Monday in current week as Date
    var firstMondayInCurrentWeekCurrentTimeZone: Date {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone.current

        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        components.timeZone = TimeZone.current
        // Making a Date from week components gives the first day of the week, hence Monday
        let mondaysDate = calendar.date(from: components)?.setToMidnightUTC()
        return mondaysDate!
    }
    
    //
    // First MONDAY in month
    var firstMondayInMonth: Date {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        var components = calendar.dateComponents([.year, .month], from: self)
        components.timeZone = TimeZone(abbreviation: "UTC")
        
        // First day of the month
        let firstDate = calendar.date(from: components)
        let firstComponents = calendar.dateComponents([.year, .month, .weekday], from: firstDate!)
        
        // Convert from Sunday=1 to Monday=1 day numbering
        let addWeekdays = 7 - ((firstComponents.weekday! + 5) % 7)
        // Jump forwards to next Monday if we arent already there
        var mondaysDate = firstDate
        if addWeekdays != 7 {
            mondaysDate = calendar.date(byAdding: .day, value: addWeekdays, to: firstDate!)
        }
        mondaysDate = mondaysDate?.setToMidnightUTC()
        return mondaysDate!
    }
    
    //
    // Number of Mondays in month
    var numberOfMondaysInCurrentMonth: Int {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        var components = calendar.dateComponents([.year, .month], from: self)
       
        // First monday in month:
        components.weekday = 2
        components.weekdayOrdinal = 1
        let first = calendar.date(from: components)
        
        // Last monday in month:
        components.weekdayOrdinal = -1
        let last = calendar.date(from: components)
        
        // Difference in weeks:
        let weeks = calendar.dateComponents([.weekOfMonth], from: first!, to: last!)
        return weeks.weekOfMonth! + 1
    }
    
    //
    // First day in month
    var firstDateInMonth: Date {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        var components = calendar.dateComponents([.year, .month], from: self)
        components.timeZone = TimeZone(abbreviation: "UTC")
        
        // First day of the month
        var firstDateInCurrentMonth = calendar.date(from: components)
        firstDateInCurrentMonth = firstDateInCurrentMonth?.setToMidnightUTC()
        //
        return firstDateInCurrentMonth!
    }
    
    //
    var firstDateInYear: Date {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        var components = calendar.dateComponents([.year], from: self)
        components.timeZone = TimeZone(abbreviation: "UTC")
        
        // First day of the year
        var firstDateInCurrentYear = calendar.date(from: components)
        firstDateInCurrentYear = firstDateInCurrentYear?.setToMidnightUTC()
        //
        return firstDateInCurrentYear!
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

