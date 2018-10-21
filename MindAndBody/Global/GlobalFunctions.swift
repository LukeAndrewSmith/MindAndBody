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
//
class UserData {
    static var shared = UserData()
    private init() {}
    
    // Updates if necessary
    func checkStoredDefaults() {
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let keys = settings.keys.sorted()
        for i in 0..<settings.keys.count {
            let key = keys[i]
            if settings[key] != Register.defaultSettings[key] {
                settings[key] = Register.defaultSettings[key]
            }
        }
        UserDefaults.standard.set(settings, forKey: "userSettings")
    }
    
}

//
// iPhone
class IPhoneType {
    static var shared = IPhoneType()
    private init() {}
    
    func iPhoneType() -> IPhone {
        // Device
        switch UIDevice.current.userInterfaceIdiom {
        // Phone
        case .phone:
            // 0 == iPhone5
            if UIScreen.main.nativeBounds.height < 1334 {
                return IPhone.little
            // 2 == iPhoneX
            } else if UIScreen.main.nativeBounds.height == 2436 {
                return IPhone.big
            // 1 == normal
            } else {
                return IPhone.average
            }
        // iPad
        case .pad:
            return IPhone.pad
        // Uh, oh! What could it be?
        default:
            return IPhone.average
        }
    }
}

enum IPhone {
    case average
    case little
    case big
    case pad
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
    
    private let motivatingComments: [String] = ["motivation1", "motivation2", "motivation3", "motivation4", "motivation5", "motivation6", "motivation7", "motivation8", "motivation9", "motivation10"]
    
    // Sets morning and/or everning repeating notifiations
        // Could be called reset, as clears before setting
    func setNotifications() {
        // Reset
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        //
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let cal: Calendar = Calendar.current
        
        //
        if ScheduleVariables.shared.schedules.count > 0 {
            // Day view: set notifications for each day something is planned
            let scheduleStyle = ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int
            if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                // Loop week
                for i in 0...6 {
                    // Check day
//                    let dayCount = ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count
                    // Count whats left instead of .count for the day, incase something has been done in advance
                    var dayCount = 0
                    for j in 0..<ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count {
                        if !(ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i][j]["isGroupCompleted"] as! Bool) {
                            dayCount += 1
                        }
                    }
                    
                    if dayCount != 0 {
                        //
                        // Set morning notifications if on
                        if settings["ReminderNotifications"]![0] != -1 {
                            let morningContent = UNMutableNotificationContent()
                            morningContent.title = NSLocalizedString("mindBodySchedule", comment: "")
                            // Motivating comments (if on)
                            var motivatingComment = ""
                            if settings["ReminderNotifications"]![2] == 1 {
                                let random = Int(arc4random_uniform(UInt32(motivatingComments.count)))
                                motivatingComment = "\n" + NSLocalizedString(motivatingComments[random], comment: "")
                            }
                            // Session - not plural
                            if dayCount == 1 {
                                morningContent.body = NSLocalizedString("morningNotification1", comment: "") + String(dayCount) + NSLocalizedString("morningNotification21", comment: "") + motivatingComment
                            // Sessions - plural
                            } else {
                                morningContent.body = NSLocalizedString("morningNotification1", comment: "") + String(dayCount) + NSLocalizedString("morningNotification2", comment: "") + motivatingComment
                            }
                            // Sound
                            morningContent.sound = UNNotificationSound.default()
                            // App Badge Counter
                            morningContent.badge = dayCount as NSNumber
                            // Get day of week
                            let morningDate = Date().firstMondayInCurrentWeek
                            let morningDateToSchedule = cal.date(byAdding: .day, value: i, to: morningDate)
                            // Get time
                            let totalMinutes = settings["ReminderNotifications"]![0]
                            let hour = Int(totalMinutes/60)
                            let minute = totalMinutes % 60
                            let dateToScheduleWithTime: Date = cal.date(bySettingHour: hour, minute: minute, second: 0, of: morningDateToSchedule!)!
                            // Get trigger date
                            let triggerDate =  Calendar.current.dateComponents([.weekday,.hour,.minute], from: dateToScheduleWithTime)
                            // Set trigger
                            let morningTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                            let identifier = "morningReminderNotification" + String(i)
                            let morningRequest = UNNotificationRequest(identifier: identifier, content: morningContent, trigger: morningTrigger)
                            UNUserNotificationCenter.current().add(morningRequest, withCompletionHandler: nil)
                        }
                        //
                        // Set Afternoon Notification (if on)
                        if settings["ReminderNotifications"]![1] != -1 {
                            var shouldPresentNotification = false
                            // See whats left
                            var unfinishedCount = 0
                            for j in 0..<ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count {
                                if !(ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i][j]["isGroupCompleted"] as! Bool) {
                                    unfinishedCount += 1
                                }
                            }
                            // Set notification
                            let afternoonContent = UNMutableNotificationContent()
                            afternoonContent.title = NSLocalizedString("mindBodySchedule", comment: "")
                            // Content
                            // Finished session for today notification
                            if unfinishedCount == 0 {
                                // If motivational comment are on and finished -> congratulate (e.g well done)
                                if settings["ReminderNotifications"]![2] != -1 {
                                    afternoonContent.body = NSLocalizedString("afternoonFinishedComment", comment: "")
                                    shouldPresentNotification = true
                                }
                                // No motivational comment and finished -> leave them to it (shouldPresentNotification = false)(defaults to false)
                            // Something left for today notification
                            } else {
                                // Motivating comments (if on)
                                var motivatingComment = ""
                                if settings["ReminderNotifications"]![2] == 1 {
                                    let random = Int(arc4random_uniform(UInt32(motivatingComment.count)))
                                    motivatingComment = "\n" + NSLocalizedString(motivatingComments[random], comment: "")
                                }
                                // Session - not plural
                                if unfinishedCount == 1 {
                                    afternoonContent.body = NSLocalizedString("afternoonNotification1", comment: "") + String(unfinishedCount) + NSLocalizedString("afternoonNotification21", comment: "") +  motivatingComment
                                // Sessions - plural
                                } else {
                                    afternoonContent.body = NSLocalizedString("afternoonNotification1", comment: "") + String(unfinishedCount) + NSLocalizedString("afternoonNotification2", comment: "") + motivatingComment
                                }
                                //
                                shouldPresentNotification = true
                            }
                            // Present
                            if shouldPresentNotification {
                                // Sound
                                afternoonContent.sound = UNNotificationSound.default()
                                // App Badge Counter
                                afternoonContent.badge = dayCount as NSNumber
                                // Get day of week
                                let afternoonDate = Date().firstMondayInCurrentWeek
                                let afternoonDateToSchedule = cal.date(byAdding: .day, value: i, to: afternoonDate)
                                // Get time
                                let totalMinutes = settings["ReminderNotifications"]![1]
                                let hour = Int(totalMinutes/60)
                                let minute = totalMinutes % 60
                                let dateToScheduleWithTime: Date = cal.date(bySettingHour: hour, minute: minute, second: 0, of: afternoonDateToSchedule!)!
                                // Get trigger date
                                let triggerDate =  Calendar.current.dateComponents([.weekday,.hour,.minute], from: dateToScheduleWithTime)
                                // Set trigger
                                let afternoonTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                                let identifier = "afternoonReminderNotification" + String(i)
                                let afternoonRequest = UNNotificationRequest(identifier: identifier, content: afternoonContent, trigger: afternoonTrigger)
                                UNUserNotificationCenter.current().add(afternoonRequest, withCompletionHandler: nil)
                            }
                        }
                    }
                    
                    // ----
                    // Set Sunday notification
                    let sundayContent = UNMutableNotificationContent()
                    sundayContent.title = NSLocalizedString("mindBodySchedule", comment: "")
                    sundayContent.body = NSLocalizedString("sundayNotification", comment: "")
                    sundayContent.sound = UNNotificationSound.default()
                    // Get day of week
                    let mondayDate = Date().firstMondayInCurrentWeek
                    let sundayDateToSchedule = cal.date(byAdding: .day, value: 6, to: mondayDate)
                    // Get 7pm in sunday
                    let sundayDateToScheduleWithTime: Date = cal.date(bySettingHour: 19, minute: 0, second: 0, of: sundayDateToSchedule!)!
                    // Get trigger day
                    let sundayTriggerDate =  Calendar.current.dateComponents([.weekday,.hour,.minute], from: sundayDateToScheduleWithTime)
                    // Set trigger
                    let sundayTrigger = UNCalendarNotificationTrigger(dateMatching: sundayTriggerDate, repeats: true)
                    let sundayRequest = UNNotificationRequest(identifier: "sundayReminderNotification", content: sundayContent, trigger: sundayTrigger)
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
                    count += ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count
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
            if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                let currentDay = Date().weekDayFromMonday
                var currentCount: Int = 0
                // Loop current day counting how much has been done
                if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![currentDay].count != 0 {
                    for j in 0..<ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![currentDay].count {
                        if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![currentDay][j]["isGroupCompleted"] as! Bool == false {
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
                    if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count != 0 {
                        // Loop day counting how much has been done
                        for j in 0..<ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count {
                            if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i][j]["isGroupCompleted"] as! Bool == false {
                                currentCount += 1
                            }
                            
                        }
                    }
                }
                UIApplication.shared.applicationIconBadgeNumber = currentCount
            }
            
        } // end schedules.count
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
    func updateBadges() {
        
        
        // Get schedule style
        var scheduleStyle = Int()
        if ScheduleVariables.shared.schedules.count > 0 {
            scheduleStyle = ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int
        } else {
            scheduleStyle = 0
        }
        
        // Get current day
        let day = Date().weekDayFromMonday
        
        // Day view
        if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
            var dayCount = 0
            // Loop day counting whats left
            for j in 0..<ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![day].count {
                if !(ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![day][j]["isGroupCompleted"] as! Bool) {
                    dayCount += 1
                }
            }
            setBadgeCounter(value: dayCount)
            
        // Week view
        } else {
            var weekCount = 0
            // Loop week counting whats left
            for i in 0..<6 {
                for j in 0..<ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i].count {
                    if !(ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["schedule"]![i][j]["isGroupCompleted"] as! Bool) {
                        weekCount += 1
                    }
                }
            }
            setBadgeCounter(value: weekCount)
            
        }
    }
   
    func setBadgeCounter(value: Int) {
        if value >= 0 {
            UIApplication.shared.applicationIconBadgeNumber = value
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
    
    // Also scales above 100&
    func convertStringDictToDateDict(stringDict: [String: Int]) -> [Date: Int] {
        
        var dateDict: [Date: Int] = [:]
        if stringDict.count != 0 {
            let keys = stringDict.keys.sorted()
            for i in 0...keys.count - 1 {
                // If under 100%, linear scaling
                if stringDict[keys[i]]! < 100 {
                    dateDict.updateValue(stringDict[keys[i]]!, forKey: stringToDate(string: keys[i]))
                // If over 100%, linear scaling but faster by factor of 4, the 25% extra == 100%
                    // => if greater than 200% then off the screen
                    // For the label of the data point, the percentage is descaled and the correct percentage is presented, see TrackingClasses -> marker class
                } else {
                    let extra = Double(stringDict[keys[i]]! - 100)
                    let extraScaled = extra/4
                    let scaled = 100 + extraScaled
                    dateDict.updateValue(Int(scaled), forKey: stringToDate(string: keys[i]))
                }
            }
        }
        
        return dateDict
    }
    
    func convertDateDictToStringDict(dateDict: [Date: Int]) -> [String: Int] {
        
        var stringDict: [String: Int] = [:]
        
            if dateDict.count != 0 {
                let keys = dateDict.keys.sorted()
                for i in 0...keys.count - 1 {
                    stringDict.updateValue(dateDict[keys[i]]!, forKey: dateToString(date: keys[i]))
                }
            }
        
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
        // MARK: NOTE TESTING, FOR TESTERS ONLY CHECK THE USERDEAULTS
        if Reachability.isConnectedToNetwork() {
            InAppManager.shared.checkIfUserHasSubscription()
        // If no internet, fall back to userDefaults
        } else {
            Loading.shared.shouldPresentLoading = false
            let isValid = UserDefaults.standard.object(forKey: "userHasValidSubscription") as! Bool
            let expiryDate = UserDefaults.standard.object(forKey: "userSubscriptionExpiryDate") as! String
            if isValid && InAppManager.shared.isValidExpiryDate(expiryDate: expiryDate) {
                NotificationCenter.default.post(name: SubscriptionNotifiations.didCheckSubscription, object: nil)
                NotificationCenter.default.post(name: SubscriptionNotifiations.canPresentWalkthrough, object: nil)
            } else {
                // Call didChecksubscriptions, this calls a func which also checks the .isValid variable and present the subscription screen if not
                NotificationCenter.default.post(name: SubscriptionNotifiations.didCheckSubscription, object: nil)
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
class MeditationSounds {
    
    static var shared = MeditationSounds()
    private init() {}
    
    // Duration Array
    let durationTimeArray: [[Int]] =
        [
            [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23], // ours
            [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 58, 59], // Minutes
            [00, 10, 20, 30, 40, 50] // Seconds
    ]
    
    let bellsArray: [String] =
        ["tibetanBowlL", "tibetanBowlL4", "tibetanBowlLS", "tibetanBowlH", "tibetanBowlH4", "tibetanBowlHS", "tibetanChimes", "rainStick", "rainStick2", "rainStick2S", "windChimes", "gambangWU", "gambangWD", "gambangM", "indonesianFrog", "cowBellS", "cowBellB"]
    
    let conversionDictBells: [String: UIImage] =
        ["tibetanBowlL": #imageLiteral(resourceName: "Tibetan Bowl Big"),
         "tibetanBowlL4":#imageLiteral(resourceName: "Tibetan Bowl Big"),
         "tibetanBowlLS":#imageLiteral(resourceName: "Tibetan Bowl Big"),
         "tibetanBowlH":#imageLiteral(resourceName: "Tibetan Bowl Small"),
         "tibetanBowlH4":#imageLiteral(resourceName: "Tibetan Bowl Small"),
         "tibetanBowlHS":#imageLiteral(resourceName: "Tibetan Bowl Small"),
         "tibetanChimes": #imageLiteral(resourceName: "Tibetan Chimes"),
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
    
    let bellsImageArray: [UIImage] =
        [#imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Tibetan Bowl Small") , #imageLiteral(resourceName: "Tibetan Chimes"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Wind Chimes"), #imageLiteral(resourceName: "Indonesian Xylophone Big"), #imageLiteral(resourceName: "Indonesian Xylophone Big"), #imageLiteral(resourceName: "Indonesian Xylophone Small"), #imageLiteral(resourceName: "Indonesian Frog"), #imageLiteral(resourceName: "Cow Bell"), #imageLiteral(resourceName: "Cow Bell Big")]
    
    // Get Image from bell name
    func bellToImage(name: String) -> UIImage {
        return conversionDictBells[name] ?? #imageLiteral(resourceName: "Tibetan Bowl Big")
    }
    
    let backgroundSoundsArray: [String] =
        ["MountainStream", "LakeTiticaca", "ForestStream", "SwissCows"]
    
    let conversionDictBackgroundSound: [String: UIImage] =
        ["MountainStream": #imageLiteral(resourceName: "MountainStream"),
         "LakeTiticaca": #imageLiteral(resourceName: "LakeTiticaca"),
         "ForestStream": #imageLiteral(resourceName: "ForestStream"),
         "SwissCows": #imageLiteral(resourceName: "SwissCows")]
    
    let backgroundSoundsImageArray: [UIImage] = [#imageLiteral(resourceName: "MountainStream"), #imageLiteral(resourceName: "LakeTiticaca") ,#imageLiteral(resourceName: "ForestStream"), #imageLiteral(resourceName: "SwissCows")]
    
    // Get Image from backgrounds sound name
    func backgroundSoundToImage(name: String) -> UIImage {
        return conversionDictBackgroundSound[name] ?? #imageLiteral(resourceName: "MountainStream")
    }
    
}

// MARK: Update Profile
class UpdateProfile {
    
    static var shared = UpdateProfile()
    private init() {}

    func checkUpdateProfile() {
        
        if let lastResetDate = UserDefaults.standard.object(forKey: "lastProfileUpdateAlert") as? Date {
            var calendar = Calendar(identifier: .iso8601)
            calendar.timeZone = TimeZone(abbreviation: "UTC")!
            if let date = calendar.date(byAdding: .month, value: 1, to: lastResetDate), date <= Date().setToMidnightUTC() {
                updateProfileAlert()
            }
        }
    }
    
    func updateProfileAlert() {
        // Alert View
        let title = NSLocalizedString("updateProfileNotificationTitle", comment: "")
        let message = NSLocalizedString("updateProfileNotificationMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
        // Action
        let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            UserDefaults.standard.set(Date().setToMidnightUTC(), forKey: "lastProfileUpdateAlert")
        }
        alert.addAction(okAction)

        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}

//
// MARK: - Global Function as extensions
//

//
// View Controller
extension UIViewController {
    
    // Setup navigation bar
    func setupNavigationBar(navBar: UINavigationItem, title: String, separator: Bool, tintColor: UIColor, textColor: UIColor, font: UIFont, shadow: Bool) {
        
        navBar.title = title
        self.navigationController?.navigationBar.barTintColor = tintColor
        self.navigationController?.navigationBar.backgroundColor = tintColor
        self.navigationController?.view.backgroundColor = tintColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: textColor, NSAttributedStringKey.font: font]

        if !separator {
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        if shadow {
            self.navigationController?.navigationBar.addShadow()
        } else {
            self.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        }
    }
    
    //
    // Add background Image
    func addBackgroundImage(withBlur: Bool, fullScreen: Bool, image: String) {
        
        // Get correct background image to compare to presented one (if one is presented)
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        
        let backgroundIndex = settings["BackgroundImage"]![0]
        var currentBackgroundIndex = -1
        var backgroundImageSubview = UIImageView()
        
        // Check if view contains background image
        var containsBackgroundImage = false
        for subview in view.subviews {
            if subview is UIImageView {
                // Enure background image within range of possible images
                if subview.tag >= BackgroundImages.backgroundImageArray.count {
                    print(subview.tag)
                    print(BackgroundImages.backgroundImageArray.count)
                    backgroundImageSubview = subview as! UIImageView
                    containsBackgroundImage = true
                    currentBackgroundIndex = subview.tag % BackgroundImages.backgroundImageArray.count
                }
            }
        }
    
        
        // If view doesn't already contain background image then add the image
        if !containsBackgroundImage {
            //
            // Background Image View
            let backgroundImage = UIImageView()
            // this number enables us to find the index of the background image, we can check if the number is greater than or equal to the count of the image array (implies the image is set, default tag might be 0 so need a number greater than 0), then mod the count to find the image index
            backgroundImage.tag = BackgroundImages.backgroundImageArray.count + backgroundIndex
            backgroundImage.contentMode = .scaleAspectFill
            backgroundImage.clipsToBounds = true
            // Frame
            if fullScreen {
                backgroundImage.frame = UIScreen.main.bounds
            } else {
                backgroundImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - (ElementHeights.statusBarHeight + CGFloat(ElementHeights.navigationBarHeight)))
            }
            //
            // Background Image/Colour
            if MeditationSounds.shared.backgroundSoundsArray.contains(image) {
                backgroundImage.image = UIImage(named: image)
            } else if image != "" {
                backgroundImage.image = getUncachedImage(named: image)
            } else if backgroundIndex < BackgroundImages.backgroundImageArray.count {
                backgroundImage.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
            }
            view.insertSubview(backgroundImage, at: 0)
            //
            // BackgroundBlur/Vibrancy
                // None if no background image
            if withBlur {
                let backgroundBlur = UIVisualEffectView()
                let backgroundBlurE = UIBlurEffect(style: .dark)
                backgroundBlur.effect = backgroundBlurE
                backgroundBlur.isUserInteractionEnabled = false
                backgroundBlur.tag = 723
                //
                backgroundBlur.frame = backgroundImage.bounds
                //
                view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
            }
        
        // If wrong background presented, then update the background
        } else if backgroundIndex != currentBackgroundIndex && currentBackgroundIndex != -1 {
            backgroundImageSubview.tag = BackgroundImages.backgroundImageArray.count + backgroundIndex
            // Background Image/Colour
            if MeditationSounds.shared.backgroundSoundsArray.contains(image) {
                backgroundImageSubview.image = UIImage(named: image)
            } else if image != "" {
                backgroundImageSubview.image = getUncachedImage(named: image)
            } else if backgroundIndex < BackgroundImages.backgroundImageArray.count {
                backgroundImageSubview.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
            }
            
            // if no blur
            var found = false
            for sub in view.subviews {
                // remove subview if no background image
                if sub.tag == 723 {
                    if backgroundIndex == BackgroundImages.backgroundImageArray.count {
                        sub.removeFromSuperview()
                    } else {
                        found = true
                    }
                }
            }
            //
            // If should have a blur, add one
            if withBlur && !found {
                // BackgroundBlur/Vibrancy
                // None if no background image
                let backgroundBlur = UIVisualEffectView()
                let backgroundBlurE = UIBlurEffect(style: .dark)
                backgroundBlur.effect = backgroundBlurE
                backgroundBlur.isUserInteractionEnabled = false
                backgroundBlur.tag = 723
                //
                backgroundBlur.frame = backgroundImageSubview.bounds
                //
                view.insertSubview(backgroundBlur, aboveSubview: backgroundImageSubview)
            }
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
        titleString.addAttribute(NSAttributedStringKey.font, value: Fonts.explanationTitle!, range: NSMakeRange(0, titleString.length))
        //
        let centering = NSMutableParagraphStyle()
        centering.alignment = .left
        titleString.addAttribute(NSAttributedStringKey.paragraphStyle, value: centering, range: NSMakeRange(0, titleString.length))
        
        //
        titleString.append(return2)
        
        //
        // Title Attributes
        let subTitleFont: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font : Fonts.explanationTitle as Any]
        //
        // Bullet Point Attributes
        let bulletPointFont: [NSAttributedStringKey: Any] = [NSAttributedStringKey.font : Fonts.lessonText as Any]
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
        let imgPathUnwrapped = Bundle.main.path(forResource: named, ofType: "png")
        if let imagePath = imgPathUnwrapped {
            let imageToReturn = UIImage(contentsOfFile: imagePath)
            return imageToReturn
        } else {
            return #imageLiteral(resourceName: "Mind&Body")
        }
        
    }
    
    func getIndexingVariablesForSession() -> (Int, String, Int) {
        
        // Indexing variables
        // index0 = selected row in initial choice screen (schedule homescreen selected group) i.e index to group in current day in schedule
        var index0 = Int()
        // index1 = Selected row in final choice (i.e warmup, session, stretching)
        var index1 = String()
        //
        var selectedDay = Int()
        // Nina
        index0 = ScheduleVariables.shared.selectedRows.initial
        // Day view - index is simply row
        if ScheduleVariables.shared.schedules[ScheduleVariables.shared.selectedScheduleIndex]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int == 0 {
            index0 = ScheduleVariables.shared.selectedRows.initial
            selectedDay = ScheduleVariables.shared.selectedDay
        // Week view -  find stored index to schedule week using temporary full week array
        } else {
            index0 = ScheduleVariables.shared.weekArray[ScheduleVariables.shared.selectedRows.initial]["index"] as! Int
            selectedDay = ScheduleVariables.shared.weekArray[ScheduleVariables.shared.selectedRows.initial]["day"] as! Int
        }
        print(index0)
        //
        index1 = String(ScheduleVariables.shared.selectedRows.final)
        return (index0, index1, selectedDay)
    }
    
    
    
    // MARK: ---------
    // MARK: Walkthrough
    //
    //
    // Set Initial States
    func setWalkthrough(walkthroughView: UIView, labelView: UIView, label: UILabel, title: UILabel, separator: UIView, nextButton: UIButton, backButton: UIButton, highlight: UIView, simplePopup: Bool) -> UIView {
        
        let screenSize = UIScreen.main.bounds
        walkthroughView.frame = screenSize
        walkthroughView.backgroundColor = .clear
        
        highlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
        highlight.layer.borderColor = Colors.light.cgColor
        highlight.layer.borderWidth = 1
        highlight.isUserInteractionEnabled = false
        
        labelView.frame = CGRect(x: WalkthroughVariables.viewPadding, y: 0, width: view.frame.size.width - 26, height: 0)
        labelView.backgroundColor = Colors.light
        labelView.layer.cornerRadius = WalkthroughVariables.viewPadding
        labelView.clipsToBounds = true
        
        title.font = UIFont(name: "SFUIDisplay-light", size: 20)
        title.frame = CGRect(x: 0, y: 0, width: labelView.bounds.width, height: WalkthroughVariables.topHeight)
        title.textAlignment = .center
        title.backgroundColor = .clear
        labelView.addSubview(title)
        
        separator.frame = CGRect(x: 0, y: WalkthroughVariables.topHeight, width: labelView.bounds.width, height: 1)
        separator.backgroundColor = Colors.dark
        labelView.addSubview(separator)
        
        label.frame = CGRect(x: WalkthroughVariables.viewPadding, y: 0, width: view.frame.size.width - 26, height: 0)
        label.center = view.center
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.backgroundColor = .clear
        label.font = UIFont(name: "SFUIDisplay-light", size: 20)
        label.textColor = Colors.dark
        labelView.addSubview(label)
        
        nextButton.frame = CGRect(x: labelView.bounds.width - 49 - 4, y: 0, width: 49, height: WalkthroughVariables.topHeight)
        nextButton.setTitleColor(Colors.dark, for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 17)
        nextButton.backgroundColor = UIColor.clear
        nextButton.layer.cornerRadius = 8
        labelView.addSubview(nextButton)
        
        // Simple popup => only ok button, no back button, as only one walkthorugh
        if !simplePopup {
            nextButton.setTitle(NSLocalizedString("next", comment: ""), for: .normal)

            backButton.alpha = 1
            backButton.isUserInteractionEnabled = true
            
            backButton.frame = CGRect(x: 4, y: 0, width: 49, height: WalkthroughVariables.topHeight)
            backButton.setTitle(NSLocalizedString("back", comment: ""), for: .normal)
            backButton.setTitleColor(Colors.dark, for: .normal)
            backButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 17)
            backButton.backgroundColor = UIColor.clear
            backButton.layer.cornerRadius = 8
            labelView.addSubview(backButton)
        } else {
            nextButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
            
            backButton.alpha = 0
            backButton.isUserInteractionEnabled = false
        }
        
        walkthroughView.addSubview(highlight)
        walkthroughView.addSubview(labelView)
        
        UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
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
        walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
        walkthroughLabel.sizeToFit()
        switch walkthroughLabelFrame {
        case 0:
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13 - ElementHeights.bottomSafeAreaInset, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
        case 1:
            walkthroughLabel.frame = CGRect(x: 13, y: CGFloat(13) + ElementHeights.statusBarHeight, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
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
    
    func nextWalkthroughViewTest(walkthroughView: UIView, labelView: UIView, label: UILabel, title: UILabel, highlight: UIView, walkthroughTexts: [String], walkthroughLabelFrame: Int, highlightSize: CGSize, highlightCenter: CGPoint, highlightCornerRadius: Int, backgroundColor: UIColor, textColor: UIColor, highlightColor: UIColor, animationTime: Double, walkthroughProgress: Int) {
        
        // Label
        title.text = NSLocalizedString(walkthroughTexts[walkthroughProgress] + "T", comment: "")
        
        label.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
        label.frame.size = label.sizeThatFits(CGSize(width: labelView.bounds.width - WalkthroughVariables.twicePadding, height: .greatestFiniteMagnitude))
        
        label.frame = CGRect(
            x: WalkthroughVariables.padding,
            y: WalkthroughVariables.topHeight + WalkthroughVariables.padding,
            width: labelView.bounds.width - WalkthroughVariables.twicePadding,
            height: label.frame.size.height)
        
        
        switch walkthroughLabelFrame {
        case 0:
            labelView.frame = CGRect(
                x: 13,
                y: view.frame.maxY - WalkthroughVariables.topHeight - label.frame.size.height - 13 - WalkthroughVariables.twicePadding,
                width: view.frame.size.width - 26,
                height: WalkthroughVariables.topHeight + label.frame.size.height + WalkthroughVariables.twicePadding)
        case 1:
            labelView.frame = CGRect(
                x: 13,
                y: 13 + ElementHeights.combinedHeight,
                width: view.frame.size.width - WalkthroughVariables.twiceViewPadding,
                height: WalkthroughVariables.topHeight + label.frame.size.height + WalkthroughVariables.twicePadding)
        default:
            labelView.frame = CGRect(
                x: 13,
                y: view.frame.maxY - WalkthroughVariables.topHeight - label.frame.size.height - 13 - WalkthroughVariables.twicePadding,
                width: view.frame.size.width - 26,
                height: WalkthroughVariables.topHeight + label.frame.size.height + WalkthroughVariables.twicePadding)
        }
        
        // Animate Highlight and Label
        UIView.animate(withDuration: animationTime, animations: {
            
            if highlightColor != .clear {
                highlight.backgroundColor = highlightColor.withAlphaComponent(0.5)
                highlight.layer.borderColor = highlightColor.cgColor
            } else {
                highlight.backgroundColor = nil
                highlight.layer.borderColor = nil
            }
            highlight.frame.size = highlightSize
            highlight.center = highlightCenter
            switch highlightCornerRadius {
            case 0:
                highlight.layer.cornerRadius = highlight.bounds.height / 2
            case 1:
                highlight.layer.cornerRadius = highlight.bounds.width / 2
            case 2:
                highlight.layer.cornerRadius = highlight.bounds.height / 4
            case 3:
                highlight.layer.cornerRadius = 15
            default:
                break
            }
            
        }, completion: {finished in

            // Flash
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                //
                if highlightColor != .clear {
                    highlight.backgroundColor = highlightColor.withAlphaComponent(1)
                }
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.1, animations: {
                    //
                    if highlightColor != .clear {
                        highlight.backgroundColor = highlightColor.withAlphaComponent(0.5)
                    }
                }, completion: nil)
            })
        })
    }
    
}

class TriangleLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var triangleColor = Colors.dark
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let halfHeight = rect.height / 2
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX - halfHeight, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + halfHeight))
        context.addLine(to: CGPoint(x: rect.maxX - halfHeight, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        context.closePath()
        
        context.setFillColor(triangleColor.cgColor)
        context.fillPath()
    }
}


//
// MARK: UIView Extension
//
extension UIView {
    
    // Shadow
    func addShadow() {
        self.layer.shadowColor = Colors.dark.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 4 // 7
    }
}

// MARK: UIImage Extension
extension UIImage {
    
    func thumbnail() -> UIImage {
        let imageData = UIImagePNGRepresentation(self)!
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: 300] as CFDictionary
        let source = CGImageSourceCreateWithData(imageData as CFData, nil)!
        let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options)!
        let thumbnail = UIImage(cgImage: imageReference)
        return thumbnail
    }
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
        if let imageToReturn = UIImage(contentsOfFile: imgPath!) {
            return imageToReturn
        } else {
            return #imageLiteral(resourceName: "QuestionMarkMenu")
        }
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
    
    // First Monday in current week as Date
    var firstMondayInCurrentWeekCurrentTimeZone: Date {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone.current

        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        components.timeZone = TimeZone.current
        // Making a Date from week components in current time zone gives the first day of the week, considered sunday, hence +1 = Monday
        let sundaysDate = calendar.date(from: components)?.setToMidnightUTC()
        let mondaysDate = calendar.date(byAdding: .day, value: 1, to: sundaysDate!)
        return mondaysDate!
    }
    
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
}


