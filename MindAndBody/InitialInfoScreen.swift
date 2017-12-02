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
    @IBOutlet weak var topSeparator: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var infoTable: UITableView!
    
    
    @IBOutlet weak var followPlanButton: UIButton!
    @IBOutlet weak var createScheduleButton: UIButton!
    @IBOutlet weak var lookAroundAppButton: UIButton!
    
    
    //
    // Request notifications/icloud
    func requestOptions() {

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
        let yesAction = UIAlertAction(title: "On", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
            walkthroughs["NotificationsPopup"] = true
            UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            //
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            settings["iCloud"]![0] = 1
            UserDefaults.standard.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: [""])
            //
        }
        // No Action
        let noAction = UIAlertAction(title: "Off", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
            walkthroughs["NotificationsPopup"] = true
            UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            //
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            settings["iCloud"]![0] = 0
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
            var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
            walkthroughs["NotificationsPopup"] = true
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
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["NotificationsPopup"] == false {
            self.present(notificationsAlert, animated: true, completion: nil)
        }
        
    }
    
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        //
        requestOptions()
        
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: true)
        
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
        // Plan
        followPlanButton.setTitle(NSLocalizedString("followPlanOption", comment: ""), for: .normal)
        followPlanButton.layer.cornerRadius = followPlanButton.bounds.height / 2
        followPlanButton.layer.masksToBounds = true
        followPlanButton.backgroundColor = Colours.colour3.withAlphaComponent(0.25)
        // Schedule
        createScheduleButton.setTitle(NSLocalizedString("initialProfileOption", comment: ""), for: .normal)
        createScheduleButton.layer.cornerRadius = createScheduleButton.bounds.height / 2
        createScheduleButton.layer.masksToBounds = true
        createScheduleButton.backgroundColor = Colours.colour3.withAlphaComponent(0.25)
        // App
        lookAroundAppButton.setTitle(NSLocalizedString("initialAppOption", comment: ""), for: .normal)
        lookAroundAppButton.layer.cornerRadius = lookAroundAppButton.bounds.height / 2
        lookAroundAppButton.layer.masksToBounds = true
        lookAroundAppButton.backgroundColor = Colours.colour1.withAlphaComponent(0.25)
//        let appBlur = UIVisualEffectView


    }
    
    //
    // MARK: Info table
    var infoSections: [String] =
        ["plans", "schedules"]
    var infoBulletPoints: [[String]] =
        [
            // Overview
            ["plansAim", ""],
            // Features
            ["schedulesAim"],
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
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
        header.textLabel?.textColor = Colours.colour1
        header.textLabel?.textAlignment = .left
        //
        header.backgroundColor = .clear
        header.backgroundView = UIView()
        //
        // Seperator
        let seperator = UIView()
        seperator.frame = CGRect(x: 15, y: header.frame.height
             - 1, width: infoTable.bounds.width / 3, height: 1)
        seperator.backgroundColor = Colours.colour1
        seperator.alpha = 0.15
        header.addSubview(seperator)
    }

    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //
        return 37
    }


    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return infoBulletPoints[section].count
    }

    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellFont = UIFont(name: "SFUIDisplay-thin", size: 21)
        let height = NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: "").height(withConstrainedWidth: infoTable.bounds.width, font: cellFont!)
        return height
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
        cell.textLabel?.text = NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: "")
        
        //
        // More info. cell
//        if indexPath.section == 0 && indexPath.row == 4 {
//            cell.separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
//            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 15)
//            cell.textLabel?.textAlignment = .right
        //
        // Bullet points
            // Long text cell (more information text) has nothing done to it (hence if section != 2)
//        } else if indexPath.section != 2 {
            //
            // Keep indentation constant
//            let paragraphStyle: NSMutableParagraphStyle
//            paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
//            paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: [:])]
//            paragraphStyle.defaultTabInterval = 15
//            paragraphStyle.firstLineHeadIndent = 0
//            paragraphStyle.headIndent = 15
//            // Font
//            let bulletPointFont = UIFont(name: "SFUIDisplay-thin", size: 21)
//            //
//            let attributedString = NSMutableAttributedString(string: NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: ""))
//            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
//            attributedString.addAttributes([NSAttributedStringKey.font: bulletPointFont!], range: NSMakeRange(0, attributedString.length))
//            cell.textLabel?.attributedText = attributedString
            //
            // Indent if not overview (if features cells)
//            if indexPath.section > 0 {
//                cell.separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
//            }
//        }
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
