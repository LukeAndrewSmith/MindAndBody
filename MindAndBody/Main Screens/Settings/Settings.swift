//
//  SettingsTest.swift
//  MindAndBody
//
//  Created by Luke Smith on 15.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Settings Class -------------------------------------------------------------------------------------------------------------------------------
//

class Settings: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //
    // MARK: Outlets ------------------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    // Sets and Reps Choice
    var actionSheetView = UIView()
    var restTimePicker = UIPickerView()
    var okButton = UIButton()
    //
    let secondIndicatorLabel = UILabel()
    //
    
    //
    var actionSheetTable = UITableView()
    
    // switches
    let timedSessionSwitch = UISwitch()
    
    //
    var selectedRow = Int()
    
    //
    let restTimesArray: [Int] = [0, 5, 10, 15, 20, 30, 45, 60, 90, 120]
    
    // Home screen Array
    var homeScreenArray: [String] = ["sessions", "schedule", "menu"]
    var homeScreenPicker = UIPickerView()
    // Use actionSheetView and okButton from above for home screen action sheet
    
    
    // Slide menu
    var slideMenuInteraction = UIScreenEdgePanGestureRecognizer()
    
    
    // View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        //
        // Set TableView Background Colour
        //
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = Colors.light
        //
        self.tableView.backgroundView = backView
        //
        tableView.reloadData()
    }
    
    
    //
    // Rest Time Related -------------------------------------------------------------------------------------------------------------------------
    //
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Slide Menu
        self.tableView.addGestureRecognizer(slideMenuInteraction)
        slideMenuInteraction.addTarget(self, action: #selector(edgePanGesture(sender:)))
        slideMenuInteraction.edges = .left
        
        //
        // Walkthrough
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["Settings"] == false && MenuVariables.shared.secondLoad {
            walkthroughSettings()
            MenuVariables.shared.secondLoad = false
        }
        MenuVariables.shared.secondLoad = true
        
        // Navigation Bar
        //
        self.navigationController?.navigationBar.barTintColor = Colors.dark
        self.navigationController?.navigationBar.tintColor = Colors.light
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        // Navigation Title
        navigationBar.title = NSLocalizedString("settings", comment: "")
        // View
        view.backgroundColor = Colors.light
        
        //
        // Sets Reps Selection (Action Sheet)
        // view
        actionSheetView.backgroundColor = Colors.dark
        actionSheetView.layer.cornerRadius = 15
        actionSheetView.layer.masksToBounds = true
        // picker
        restTimePicker.backgroundColor = Colors.dark
        restTimePicker.delegate = self
        restTimePicker.dataSource = self
        // ok
        okButton.backgroundColor = Colors.light
        okButton.setTitleColor(Colors.green, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        actionSheetView.addSubview(okButton)
        // sets
        secondIndicatorLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        secondIndicatorLabel.textColor = Colors.light
        secondIndicatorLabel.text = "s"
        //
        // Home Screen Action Sheet
        // picker
        homeScreenPicker.backgroundColor = Colors.dark
        homeScreenPicker.delegate = self
        homeScreenPicker.dataSource = self
        
        //
        // Switches
        setupSwitch(switchToSetup: timedSessionSwitch)
    }
    
    func setupSwitch(switchToSetup: UISwitch) {
        switchToSetup.onTintColor = Colors.green
        switchToSetup.tintColor = Colors.red
        switchToSetup.backgroundColor = Colors.red
        switchToSetup.layer.cornerRadius = switchToSetup.bounds.height / 2
        switchToSetup.clipsToBounds = true
        switchToSetup.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    //
    // Ok button action
    @objc func okButtonAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        // Rest time
        if actionSheetView.subviews.contains(restTimePicker) {
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            //
            settings["RestTimes"]![selectedRow] = restTimesArray[restTimePicker.selectedRow(inComponent: 0)]
            defaults.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            //
            // Home Screen
        } else if actionSheetView.subviews.contains(homeScreenPicker) {
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            //
            settings["HomeScreen"]![0] = homeScreenPicker.selectedRow(inComponent: 0)
            //
            defaults.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
        }
        
        
        
        ActionSheet.shared.animateActionSheetDown()
        //
        tableView.reloadData()
    }
    
    
    //
    // MARK: Settings TableView --------------------------------------------------------------------------------------------------------------------------
    //
    
    // Sections
    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    // Section Titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return NSLocalizedString("general", comment: "")
        case 1: return NSLocalizedString("timedSessions", comment: "")
        case 2: return NSLocalizedString("restTimes", comment: "")
        case 3: return NSLocalizedString("sessions", comment: "")
        case 4: return NSLocalizedString("reminders", comment: "")
        case 5: return NSLocalizedString("reset", comment: "")
        default: return ""
        }
    }
    
    // Header Customization
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 17)!
    }
    
    // Header Height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    
    // Rows
    // Number of rows per section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        switch section {
            // General
        case 0: return 2
            // Timed Sessions
        case 1: return 2
            // Rest Times
        case 2: return 3
            // Sessions
        case 3: return 1
            // Reminders
        case 4: return 1
            // Reset
        case 5: return 2
        default: break
        }
        return 0
    }
    
    // Row cell customization
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Settings sections
        switch indexPath.section {
        // Background / Home Screen
        case 0:
            //
            switch indexPath.row {
            // Background Image
            case 0:
                let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
                cell.backgroundColor = Colors.light
                //
                cell.textLabel?.text = NSLocalizedString("backgroundImage", comment: "")
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
                
                // Background ImageView
                let backgroundImageView = UIImageView()
                let height = cell.bounds.height - 10
                backgroundImageView.frame.size = CGSize(width: 9/16 * height, height: height)
                backgroundImageView.center = CGPoint(x: view.bounds.width - 40 - (backgroundImageView.bounds.width / 2), y: cell.bounds.height / 2)
                
                // Retreive background index
                let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                let backgroundIndex = settings["BackgroundImage"]![0]
                // Set image background based on index
                if backgroundIndex < BackgroundImages.backgroundImageArray.count {
                    backgroundImageView.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
                    
                    // If grey background
                } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
                    //
                    backgroundImageView.layer.borderWidth = 1
                    backgroundImageView.layer.borderColor = Colors.dark.cgColor
                    //
                    backgroundImageView.backgroundColor = Colors.light
                    
                    // If red-orange background
                }
                // Final background image view customization
                backgroundImageView.contentMode = .scaleToFill
                cell.addSubview(backgroundImageView)
                cell.accessoryType = .disclosureIndicator
                
                //
                return cell
                
            // Home screen
            case 1:
                //
                let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                //
                cell.textLabel?.text = NSLocalizedString("homePage", comment: "")
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
                
                // Retreive Presentation Style
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                let homeScreen = settings["HomeScreen"]![0]
                cell.detailTextLabel?.text = NSLocalizedString(homeScreenArray[homeScreen], comment: "")
                cell.detailTextLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = Colors.light
                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
                return cell
                
            default: break
            }
            //
            
            
        // Timed sessions
        case 1:
            
            switch indexPath.row {
            // Timed sessions
            case 0:
                //
                // timed schedule sessions
                let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                cell.backgroundColor = Colors.light
                cell.selectionStyle = .none
                //
                cell.textLabel?.text = NSLocalizedString("timedSession", comment: "")
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
                //
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                let timedSession = settings["TimeBasedSessions"]![0]
                if timedSession == 0 {
                    timedSessionSwitch.isOn = false
                } else {
                    timedSessionSwitch.isOn = true
                }
                //
                // on off
                cell.addSubview(timedSessionSwitch)
                timedSessionSwitch.center = CGPoint(x: view.bounds.width - 16 - (timedSessionSwitch.bounds.width / 2), y: cell.bounds.height / 2)
                
                //
                return cell
            // Yoga automatic
            case 1:
                //
                let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                //
                cell.textLabel?.text = NSLocalizedString("automaticYoga", comment: "")
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
                //
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                let automaticYogaArray = settings["AutomaticYoga"]!
                // Retreive Presentation Style
                if automaticYogaArray[0] == 0 {
                    cell.detailTextLabel?.text = NSLocalizedString("off", comment: "")
                    cell.detailTextLabel?.textColor = Colors.red
                } else {
                    cell.detailTextLabel?.text = NSLocalizedString("on", comment: "")
                    cell.detailTextLabel?.textColor = Colors.green
                }
                cell.detailTextLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = Colors.light
                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
                //
                cell.accessoryType = .disclosureIndicator
                //
                return cell
            default: break
            }
            
        // Rest Time
        case 2:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            // Titles
            let restTimeTitles = ["warmup", "workout", "stretching"]
            cell.textLabel?.text = NSLocalizedString(restTimeTitles[indexPath.row], comment: "")
            //
            // Retreive Rest Time
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let restTimes = settings["RestTimes"]!
            cell.detailTextLabel?.text = String(restTimes[indexPath.row]) + " s"
            //
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
            cell.backgroundColor = Colors.light
            //
            return cell
            
        // Session customization
        case 3:
            //
            // Units
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.backgroundColor = Colors.light
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
            //
            cell.textLabel?.text = NSLocalizedString("units", comment: "")
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let units = settings["Units"]![0]
            if units == 0 {
                cell.detailTextLabel?.text = NSLocalizedString("metric", comment: "")
            } else {
                cell.detailTextLabel?.text = NSLocalizedString("imperial", comment: "")
            }
            //
            return cell
            
        // Reminders
        case 4:
            //
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.backgroundColor = Colors.light
            cell.accessoryType = .disclosureIndicator
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
            cell.textLabel?.text = NSLocalizedString("reminders", comment: "")
            //
            return cell
            
        // Reset
        case 5:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            cell.backgroundColor = Colors.light
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
            //
            // Reset Walkthrough
            if indexPath.row == 0 {
                cell.textLabel?.text = NSLocalizedString("resetWalkthrough", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = Colors.light
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
                return cell
            // Reset App
            } else if indexPath.row == 1 {
                cell.textLabel?.text = NSLocalizedString("resetApp", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = Colors.light
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
                return cell
            }
        //
        default: break
        }
        return UITableViewCell()
    }
    
    // Selection handler
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Settings sections
        switch indexPath.section {
        // Background / Home Screen
        case 0:
            //
            switch indexPath.row {
            // Background Image
            case 0:
                // Segue to homescreen choice
                performSegue(withIdentifier: "BackgroundImageSegue", sender: nil)
                //
                tableView.deselectRow(at: indexPath, animated: true)
                
            // Home screen
            case 1:
                //
                if actionSheetView.subviews.contains(restTimePicker) {
                    let i = actionSheetView.subviews.index(of: restTimePicker)
                    actionSheetView.subviews[i!].removeFromSuperview()
                    let j = actionSheetView.subviews.index(of: secondIndicatorLabel)
                    actionSheetView.subviews[j!].removeFromSuperview()
                }
                actionSheetView.addSubview(homeScreenPicker)
                
                //
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                let homeScreen = settings["HomeScreen"]![0]
                // View
                let homeWidth = ActionSheet.shared.actionWidth
                let homeHeight = CGFloat(147 + 49)
                actionSheetView.frame = CGRect(x: 10, y: view.frame.maxY, width: homeWidth, height: homeHeight)
                UIApplication.shared.keyWindow?.insertSubview(actionSheetView, aboveSubview: tableView)
                // selected row
                homeScreenPicker.selectRow(homeScreen, inComponent: 0, animated: false)
                //
                // picker
                homeScreenPicker.frame = CGRect(x: 0, y: 0, width: actionSheetView.frame.size.width, height: 147)
                // ok
                okButton.frame = CGRect(x: 0, y: 147, width: actionSheetView.frame.size.width, height: 49)
                //
                self.actionSheetView.frame = CGRect(x: 0, y: 0, width: homeWidth, height: homeHeight)
                
                // picker
                self.homeScreenPicker.frame = CGRect(x: 0, y: 0, width: self.actionSheetView.frame.size.width, height: 147)
                // ok
                self.okButton.frame = CGRect(x: 0, y: 147, width: self.actionSheetView.frame.size.width, height: 49)
                
                ActionSheet.shared.setupActionSheet()
                ActionSheet.shared.actionSheet.addSubview(actionSheetView)
                let heightToAdd = actionSheetView.bounds.height
                ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
                ActionSheet.shared.resetCancelFrame()
                ActionSheet.shared.animateActionSheetUp()
                
                tableView.deselectRow(at: indexPath, animated: true)
                
            default: break
            }
            //
            
            
        // Timed sessions
        case 1:
            
            switch indexPath.row {
            // Yoga automatic
            case 1:
                //
                // Segue to Automatic yoga settings screen
                performSegue(withIdentifier: "YogaAutomaticSegue", sender: nil)
                //
                tableView.deselectRow(at: indexPath, animated: true)
            //
            default: break
            }
            
        // Rest Time
        case 2:
            //
            if actionSheetView.subviews.contains(homeScreenPicker) {
                let i = actionSheetView.subviews.index(of: homeScreenPicker)
                actionSheetView.subviews[i!].removeFromSuperview()
            }
            actionSheetView.addSubview(restTimePicker)
            actionSheetView.addSubview(secondIndicatorLabel)
            actionSheetView.bringSubview(toFront: secondIndicatorLabel)
            //
            selectedRow = indexPath.row
            //
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let restTimes = settings["RestTimes"]!
            // View
            let restWidth = ActionSheet.shared.actionWidth
            let restHeight = CGFloat(147 + 49)
            actionSheetView.frame = CGRect(x: 10, y: view.frame.maxY, width: restWidth, height: restHeight)
            UIApplication.shared.keyWindow?.insertSubview(actionSheetView, aboveSubview: tableView)
            // selected row
            let rowIndex = restTimesArray.index(of: restTimes[selectedRow])
            restTimePicker.selectRow(rowIndex!, inComponent: 0, animated: false)
            //
            // picker
            restTimePicker.frame = CGRect(x: 0, y: 0, width: actionSheetView.frame.size.width, height: 147)
            // ok
            okButton.frame = CGRect(x: 0, y: 147, width: actionSheetView.frame.size.width, height: 49)
            //
            self.secondIndicatorLabel.frame = CGRect(x: (actionSheetView.frame.size.width / 2 + 30), y: (self.restTimePicker.frame.size.height / 2) - 15, width: 50, height: 30)
            //
            self.actionSheetView.frame = CGRect(x: 0, y: 0, width: restWidth, height: restHeight)
            
            // picker
            self.restTimePicker.frame = CGRect(x: 0, y: 0, width: self.actionSheetView.frame.size.width, height: 147)
            // ok
            self.okButton.frame = CGRect(x: 0, y: 147, width: self.actionSheetView.frame.size.width, height: 49)
            // Sets Indicator Label
            self.secondIndicatorLabel.frame = CGRect(x: (self.actionSheetView.frame.size.width / 2 + 30), y: (self.restTimePicker.frame.size.height / 2) - 15, width: 50, height: 30)
            //
            ActionSheet.shared.setupActionSheet()
            ActionSheet.shared.actionSheet.addSubview(actionSheetView)
            let heightToAdd = actionSheetView.bounds.height
            ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
            ActionSheet.shared.resetCancelFrame()
            ActionSheet.shared.animateActionSheetUp()
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            
        // Session customization
        case 3:
            let cell = tableView.cellForRow(at: indexPath)
            //
            // Units
            //
            // kg --> lb
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let units = settings["Units"]![0]
            if units == 0 {
                cell?.detailTextLabel?.text = NSLocalizedString("imperial", comment: "")
                settings["Units"]![0] = 1
                UserDefaults.standard.set(settings, forKey: "userSettings")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
                // lb --> kg
            } else if units == 1 {
                cell?.detailTextLabel?.text = NSLocalizedString("metric", comment: "")
                settings["Units"]![0] = 0
                UserDefaults.standard.set(settings, forKey: "userSettings")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            }
            tableView.deselectRow(at: indexPath, animated: true)
            //
         
        // Notifications
        case 4:
            // Segue to reminder notifications settings screen
            performSegue(withIdentifier: "RemindersSegue", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
      
        // Reset
        case 5:
            //
            // Reset Walkthrough
            if indexPath.row == 0 {
                //
                // Alert View indicating meaning of resetting the app
                let title = NSLocalizedString("resetWarning", comment: "")
                let message = NSLocalizedString("resetWalkthroughWarningMessage", comment: "")
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.view.tintColor = Colors.dark
                alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .natural
                alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 19)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
                
                
                // Reset app action
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    // Walkthrough
                    // Reset Walkthroughs
                    var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                    let keys = walkthroughs.keys.sorted()
                    for i in 0...(keys.count - 1) {
                        walkthroughs[keys[i]] = false
                    }
                    // Set
                    UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                    // Sync
                    ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
                    
                    //
                    // Alert View indicating need for app reset
                    let title = NSLocalizedString("resetTitle", comment: "")
                    let message = NSLocalizedString("resetMessage", comment: "")
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alert.view.tintColor = Colors.light
                    alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.alignment = .natural
                    alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 19)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
                    
                    // Present alert
                    self.present(alert, animated: true, completion: nil)
                }
                // Cancel reset action
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                }
                // Add Actions
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                
                // Present Alert
                self.present(alert, animated: true, completion: nil)
                //
                tableView.deselectRow(at: indexPath, animated: true)
                
                // Reset App
            } else if indexPath.row == 1 {
                
                // Alert View indicating meaning of resetting the app
                let title = NSLocalizedString("resetWarning", comment: "")
                let message = NSLocalizedString("resetWarningMessage", comment: "")
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.view.tintColor = Colors.dark
                alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .natural
                alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 19)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
                
                
                // Reset app action
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    ICloudFunctions.shared.removeAll()
                    ReminderNotifications.shared.cancelNotifications()
                    
                    // Alert View
                    let title = NSLocalizedString("resetTitle", comment: "")
                    let message = NSLocalizedString("resetMessage", comment: "")
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alert.view.tintColor = Colors.dark
                    alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.alignment = .natural
                    alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 19)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
                    
                    self.present(alert, animated: true, completion: nil)
                }
                // Cancel reset action
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                }
                // Add Actions
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                
                // Present Alert
                self.present(alert, animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        //
        default: break
        }
    }
    
    //
    // MARK: Switch handlers
    @objc func valueChanged(_ sender: UISwitch) {
        // Timed sessions
        if sender == timedSessionSwitch {
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            if sender.isOn {
                settings["TimeBasedSessions"]![0] = 1
            } else {
                settings["TimeBasedSessions"]![0] = 0
            }
            //
            UserDefaults.standard.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
        }
    }
    
    
    //
    // MARK: Picker View ----------------------------------------------------------------------------------------------------
    //
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case restTimePicker:
            return restTimesArray.count
        case homeScreenPicker:
            return homeScreenArray.count
        default:
            return 0
        }
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        switch pickerView {
        case restTimePicker:
            //
            let secondsLabel = UILabel()
            secondsLabel.text = String(restTimesArray[row])
            secondsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
            secondsLabel.textColor = Colors.light
            //
            secondsLabel.textAlignment = .center
            return secondsLabel
        //
        case homeScreenPicker:
            //
            let screenLabel = UILabel()
            screenLabel.text = NSLocalizedString(homeScreenArray[row], comment: "")
            screenLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
            screenLabel.textColor = Colors.light
            //
            screenLabel.textAlignment = .center
            return screenLabel
        //
        default:
            return UIView()
        }
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
    
    
    
    //
    // MARK: Slide Menu ---------------------------------------------------------------------------------------------------------------------
    //
    // Elements
    //
    let interactor = Interactor()
    // Edge pan
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        
        MenuVariables.shared.menuInteractionType = 1

        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .Right)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.performSegue(withIdentifier: "openMenu", sender: nil)
        }
    }
    // Button
    @IBAction func slideMenuButton(_ sender: Any) {
        MenuVariables.shared.menuInteractionType = 0
    }
    
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "openMenu" {
            //
            if let destinationViewController = segue.destination as? SlideMenuView {
                destinationViewController.transitioningDelegate = self
            }
            // Handle changing colour of status bar if button pressed
            if MenuVariables.shared.menuInteractionType == 0 {
                UIApplication.shared.statusBarStyle = .default
            }
        } else {
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    
    
    
    //
    // MARK: Walkthrough ------------------------------------------------------------------------------------------------------------------
    //
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabel = UILabel()
    var nextButton = UIButton()
    
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["settings0", "settings1", "settings2", "settings3"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    // Walkthrough
    @objc func walkthroughSettings() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughSettings), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
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
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = Colors.light
            walkthroughLabel.backgroundColor = Colors.dark
            walkthroughHighlight.backgroundColor = Colors.dark.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.dark.cgColor
            // Highlight

            let section = tableView.rect(forSection: 0)
            walkthroughHighlight.frame = CGRect(x: 8, y: section.minY + 47 + 44, width: view.bounds.width - 16, height: 44)
            walkthroughHighlight.center.y += TopBarHeights.combinedHeight
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 4

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
            
            
        // Timed Sessions
        case 1:
            //
            let section = tableView.rect(forSection: 1)
            highlightSize = CGSize(width: view.bounds.width - 22, height: 44)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: section.minY + 47 + 22)
            highlightCenter?.y += TopBarHeights.combinedHeight
            
            //
            highlightCornerRadius = 2
            //
            // Iphone 5/SE, explanation at top of screen
            if IPhoneType.shared.iPhoneType() == 0 {
                labelFrame = 1
            // Other, explanation at bottom of screen
            } else if IPhoneType.shared.iPhoneType() == 2 {
                labelFrame = 0
            }
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        // Automatic yoga
        case 2:
            //
            let section = tableView.rect(forSection: 1)
            highlightSize = CGSize(width: view.bounds.width - 22, height: 44)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: section.minY + 47 + 44 + 22)
            highlightCenter?.y += TopBarHeights.combinedHeight
            
            //
            highlightCornerRadius = 2
            //
            // Iphone 5/SE, explanation at top of screen
            if IPhoneType.shared.iPhoneType() == 0 {
                labelFrame = 1
                // Other, explanation at bottom of screen
            } else if IPhoneType.shared.iPhoneType() == 2 {
                labelFrame = 0
            }
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        // Reminders
        case 3:
            
            tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .top, animated: false)
            //
            let section = tableView.rect(forSection: 4)
            highlightSize = CGSize(width: view.bounds.width - 22, height: 44)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: section.minY + 47 + 22 - tableView.contentOffset.y)
            highlightCenter?.y += TopBarHeights.combinedHeight
            
            //
            highlightCornerRadius = 2
            //
            // Iphone 5/SE, explanation at top of screen
            if IPhoneType.shared.iPhoneType() == 0 {
                labelFrame = 1
                // Other, explanation at bottom of screen
            } else if IPhoneType.shared.iPhoneType() == 2 {
                labelFrame = 0
            }
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        //
        default:
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                walkthroughs["Settings"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            })
        }
    }
    
    // Get frame
    func frameForRow(row: Int, section: Int) -> CGRect {
        let y = TopBarHeights.combinedHeight + CGFloat(((section + 1) * 47) + (section * 20)) + CGFloat(row * 44)
        let rect = CGRect(x: 8, y: y, width: view.bounds.width - 16, height: 44)
        return rect
    }
    
    
    // QuestionMark, information needed, show walkthrough
    @IBAction func questionMarkButtonAciton(_ sender: Any) {
        walkthroughView.alpha = 1
        didSetWalkthrough = false
        walkthroughProgress = 0
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        walkthroughSettings()
    }
    
    
    //
}


//
// MARK: Slide Menu Extension ------------------------------------------------------------------------------------------------------------------
//

//
// Slide Menu Extension
extension Settings: UIViewControllerTransitioningDelegate {
    
    // Interactive pan
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    //
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    // Button
    // Present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }

    // Dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
}



class SettingsNavigation: UINavigationController {

}

