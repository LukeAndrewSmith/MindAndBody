//
//  InitialInfoScreen.swift
//  MindAndBody
//
//  Created by Luke Smith on 15.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


class InitialInfoScreen: UIViewController, UNUserNotificationCenterDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //
    // Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    //
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var topSeparator: UIView!
    @IBOutlet weak var infoTable: UITableView!
    
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var appButton: UIButton!
    
    
    //
    // Requestion notifications/icloud
    func requestionOptions() {

        //
        // iCloud popup
        let iCloudTitle = NSLocalizedString("iCloudPopup", comment: "")
        let iCloudMessage = NSLocalizedString("iCloudPopupMessage", comment: "")
        let iCloudAlert = UIAlertController(title: iCloudTitle, message: iCloudMessage, preferredStyle: .alert)
        iCloudAlert.view.tintColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        iCloudAlert.setValue(NSAttributedString(string: iCloudTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        iCloudAlert.setValue(NSAttributedString(string: iCloudMessage, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        // Yes Action
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            var walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
            walkthroughs[0] = true
            UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            //
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            settings[7][0] = 0
            UserDefaults.standard.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: [""])
            //
        }
        // No Action
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            var walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
            walkthroughs[0] = true
            UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            //
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            settings[7][0] = 1
            UserDefaults.standard.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            //
        }
        //
        iCloudAlert.addAction(yesAction)
        iCloudAlert.addAction(noAction)



        
        //
        // Notifications Popup
        let notificationsTitle = NSLocalizedString("notificationsPopup", comment: "")
        let notificationsMessage = NSLocalizedString("notificationsPopupMessage", comment: "")
        let notificationsAlert = UIAlertController(title: notificationsTitle, message: notificationsMessage, preferredStyle: .alert)
        notificationsAlert.view.tintColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        notificationsAlert.setValue(NSAttributedString(string: notificationsTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        //
        let notificationsParagraphStyle = NSMutableParagraphStyle()
        notificationsParagraphStyle.alignment = .natural
        notificationsAlert.setValue(NSAttributedString(string: notificationsMessage, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedStringKey.paragraphStyle: notificationsParagraphStyle]), forKey: "attributedMessage")
        // Ok Action
        let notificationsOkAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            var walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
            walkthroughs[0] = true
            UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["walkthroughs"])
            //
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                self.present(iCloudAlert, animated: true, completion: nil)
            }
        }
        //
        notificationsAlert.addAction(notificationsOkAction)
    
        // Notifications Popup
        let walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
        if walkthroughs[0] == false {
            self.present(notificationsAlert, animated: true, completion: nil)
        }
        
    }
    
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        //
        // Background Image/Colour
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            backgroundImageView.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = Colours.colour1
        }
        // Blur
        // BackgroundBlur/Vibrancy
        let backgroundBlur = UIVisualEffectView()
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        backgroundBlur.frame = backgroundImageView.bounds
        if backgroundIndex > BackgroundImages.backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImageView)
        }
        
        //
        // Subtitle
        subtitleLabel.text = NSLocalizedString("initialInfoSubtitle", comment: "")
        
        //
        // Info Table
        infoTable.tableFooterView = UIView()
        infoTable.delegate = self
        infoTable.dataSource = self
        infoTable.separatorStyle = .none
        infoTable.isScrollEnabled = false
        
        //
        // Buttons
        // Profile
        profileButton.setTitle(NSLocalizedString("initialProfileOption", comment: ""), for: .normal)
        profileButton.layer.cornerRadius = profileButton.bounds.height / 2
        profileButton.layer.masksToBounds = true
        profileButton.backgroundColor = Colours.colour3.withAlphaComponent(0.25)
//        let profileBlur = UIBlurEffect(style: .regular)
//        let profileBlurView = UIVisualEffectView(effect: profileBlur)
//        let profileVibrancy = UIVibrancyEffect(blurEffect: profileBlur)
//        let profileVibrancyView = UIVisualEffectView(effect: profileVibrancy)
//        profileBlurView.addSubview(profileVibrancyView)
//        //
//        profileBlurView.frame = profileButton.bounds
//        profileBlurView.layer.cornerRadius = 15
//        profileBlurView.layer.masksToBounds = true
//        profileBlurView.center = profileButton.center
//        view.insertSubview(profileBlurView, belowSubview: profileButton)
        // App
        appButton.setTitle(NSLocalizedString("initialAppOption", comment: ""), for: .normal)
        appButton.layer.cornerRadius = appButton.bounds.height / 2
        appButton.layer.masksToBounds = true
        appButton.backgroundColor = Colours.colour1.withAlphaComponent(0.25)
//        let appBlur = UIVisualEffectView


    }
    
    //
    // MARK: Info table
    var infoSections: [String] =
        [" ", "features", ""]
    var infoBulletPoints: [[String]] =
        [
            // Overview
            ["initialInfo1", "initialInfo2", "initialInfo3", "initialInfo4", "moreInfo"],
            // Features
            ["scheduleI", "trackingI", "lessonsI", "explanationsI", "warmupI", "stretchingI", "stretchingI2", "workoutsI", "gymI", "bodyweightI", "timedSessionsI", "cardioI", "cardioI2", "yogaI", "timedYogaI", "meditationTimeI", "guidedMeditationI", "customSessionsI"],
            // More info.
            ["initialMoreInfo"],
    ]

    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return infoSections.count
    }

    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(infoSections[section], comment: "")
    }

    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
        header.textLabel?.textColor = Colours.colour1
        //
        header.backgroundColor = .clear
        header.backgroundView = UIView()
        //
        if section == 1 {
            // Create seperator
            let seperator = CALayer()
            seperator.frame = CGRect(x: 15, y: header.frame.size.height - 1, width: topSeparator.bounds.width, height: 1)
            seperator.backgroundColor = Colours.colour1.cgColor
            seperator.opacity = 0.15
            header.layer.addSublayer(seperator)
        }
    }

    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //
        if section != 2 {
            return 37
        } else {
            return 37 / 2
        }
    }


    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return infoBulletPoints[section].count
    }

    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Initial
        if indexPath.section == 0 {
            // Overview
            return (tableView.bounds.height - 47) / 5
        // Features
        } else if indexPath.section == 1 {
            let font = UIFont(name: "SFUIDisplay-thin", size: 21)
            let height = NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: "").height(withConstrainedWidth: infoTable.bounds.width - 32, font: font!)
            //
            if height > 37 {
                return 37 * 2
            } else {
                return 37
            }
        // Overview cell
        } else if indexPath.section == 2 {
            let font = UIFont(name: "SFUIDisplay-thin", size: 21)
            let height = NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: "").height(withConstrainedWidth: infoTable.bounds.width - 32, font: font!)
            return height
        }
        return 0
    }

    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.text = NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: "")
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cell.textLabel?.textColor = Colours.colour1
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        //
        // More info. cell
        if indexPath.section == 0 && indexPath.row == 4 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 15)
            cell.textLabel?.textAlignment = .right
        //
        // Bullet points
            // Long text cell (more information text) has nothing done to it (hence if section != 2)
        } else if indexPath.section != 2 {
            //
            // Keep indentation constant
            let paragraphStyle: NSMutableParagraphStyle
            paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: [:])]
            paragraphStyle.defaultTabInterval = 15
            paragraphStyle.firstLineHeadIndent = 0
            paragraphStyle.headIndent = 15
            // Font
            let bulletPointFont = UIFont(name: "SFUIDisplay-thin", size: 21)
            //
            let attributedString = NSMutableAttributedString(string: NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: ""))
            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            attributedString.addAttributes([NSAttributedStringKey.font: bulletPointFont!], range: NSMakeRange(0, attributedString.length))
            cell.textLabel?.attributedText = attributedString
            //
            // Indent if not overview (if features cells)
            if indexPath.section > 0 {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
            }
        }
        return cell
    }
    
    //
    // Did select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 4 {
            let indexPath = NSIndexPath(row: 0, section: 1)
            infoTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
            infoTable.isScrollEnabled = true
        }
    }
    
    // Mask cells under clear header
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleIndex = infoTable.indexPathsForVisibleRows
        if visibleIndex!.first?.section == 1 {
            for cell in infoTable.visibleCells {
                let hiddenFrameHeight = scrollView.contentOffset.y + 37 - cell.frame.origin.y
                if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
                    maskCell(cell: cell, margin: Float(hiddenFrameHeight))
                }
            }
        }
    }
    func maskCell(cell: UITableViewCell, margin: Float) {
        cell.layer.mask = visibilityMaskForCell(cell: cell, location: (margin / Float(cell.frame.size.height) ))
        cell.layer.masksToBounds = true
    }
    func visibilityMaskForCell(cell: UITableViewCell, location: Float) -> CAGradientLayer {
        let mask = CAGradientLayer()
        mask.frame = cell.bounds
        mask.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        mask.locations = [NSNumber(value: location), NSNumber(value: location)]
        return mask;
    }
    
    //
    // Ensure didCreateNewSchedule == false
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "openInitialCreateScheduleSegueMenu" {
            ScheduleVariables.shared.didCreateNewSchedule = false
        }
    }
    
    //
    // Look around app button
    @IBAction func appButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

// Initial info navigation
class InitialInfoNavigation: UINavigationController {
    
}
