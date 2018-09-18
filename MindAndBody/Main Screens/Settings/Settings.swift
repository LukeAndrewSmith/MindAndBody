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
    
    // Reminders choice
    var selectionView = UIView()
    var timePicker = UIPickerView()
    var okButton2 = UIButton()
    var offButton = UIButton()
    
    //
    var actionSheetTable = UITableView()
    
    // switches
    let automaticSessionSwitch = UISwitch()
    let motivationSwitch = UISwitch()
    let customSwitch = UISwitch()
    // Time array
    var timeInDayArray: [[Int]] = [
        // Hours
        [12,1,2,3,4,5,6,7,8,9,10,11],
        // Minutes
        [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59],
        // am/pm
        [0,1],
        ]
    
    //
    var selectedRow = Int()
    var selectedSection = Int()
    
    var presentingWalkthrough = false
    
    //
    let restTimesArray: [Int] = [0, 5, 10, 15, 20, 30, 45, 60, 90, 120]
        
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
        
        // Navigation Bar
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("settings", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)
        // View
        view.backgroundColor = Colors.light
        
        //
        tableView.backgroundColor = Colors.gray
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 24.5)
        headerView.backgroundColor = Colors.gray
        tableView.tableHeaderView = headerView
        let topView = UIView()
        topView.backgroundColor = Colors.gray
        topView.frame = CGRect(x: 0, y: tableView.frame.minY - tableView.bounds.height, width: tableView.bounds.width, height: tableView.bounds.height)
        tableView.addSubview(topView)
        //
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: tableView.sectionFooterHeight)
        footerView.backgroundColor = Colors.gray
        tableView.tableFooterView = footerView
        let bottomView = UIView()
        bottomView.backgroundColor = Colors.gray
        bottomView.frame = CGRect(x: 0, y: tableView.contentSize.height - 24.5, width: tableView.bounds.width, height: tableView.bounds.height)
        tableView.addSubview(bottomView)
        

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
        // Reminders
        // view
        selectionView.backgroundColor = Colors.dark
        selectionView.layer.cornerRadius = 15
        selectionView.layer.masksToBounds = true
        //
        okButton2.backgroundColor = Colors.light
        okButton2.setTitleColor(Colors.green, for: .normal)
        okButton2.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton2.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton2.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        //
        offButton.backgroundColor = Colors.light
        offButton.setTitleColor(Colors.red, for: .normal)
        offButton.setTitle(NSLocalizedString("turnOff", comment: ""), for: .normal)
        offButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        offButton.addTarget(self, action: #selector(offButtonAction(_:)), for: .touchUpInside)
        //
        timePicker.backgroundColor = Colors.dark
        timePicker.delegate = self
        timePicker.dataSource = self
        
        //
        // Switches
        setupSwitch(switchToSetup: automaticSessionSwitch)
        setupSwitch(switchToSetup: motivationSwitch)
        setupSwitch(switchToSetup: customSwitch)
    }
    
    func setupSwitch(switchToSetup: UISwitch) {
        switchToSetup.onTintColor = Colors.green
        switchToSetup.tintColor = Colors.red
        switchToSetup.backgroundColor = Colors.red
        switchToSetup.layer.cornerRadius = switchToSetup.bounds.height / 2
        switchToSetup.clipsToBounds = true
        switchToSetup.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //
        // Walkthrough
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["Settings"] == false {
            if !presentingWalkthrough {
                presentingWalkthrough = true
                walkthroughSettings()
            }
        }
    }
    
    //
    // Ok button action
    @objc func okButtonAction(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        // Rest time
        if sender == okButton {
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            //
            settings["RestTimes"]![selectedRow] = restTimesArray[restTimePicker.selectedRow(inComponent: 0)]
            defaults.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            //
        // Reminders
        } else if sender == okButton2 {
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            // Save
            settings["ReminderNotifications"]![selectedRow] = convertPickerToMinutes(picker: timePicker)
            UserDefaults.standard.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            // Update Indicator
            let indexPath = NSIndexPath(row: selectedRow, section: 0)
            let cell = tableView.cellForRow(at: indexPath as IndexPath)
            cell?.detailTextLabel?.text = convertTimeToString(time: settings["ReminderNotifications"]![selectedRow])
            // Animate
            ActionSheet.shared.animateActionSheetDown()
            //
            // Update notifications
            ReminderNotifications.shared.setNotifications()
        }
        
        ActionSheet.shared.animateActionSheetDown()
        //
        tableView.reloadData()
    }
    
    // Off button action
    @objc func offButtonAction(_ sender: Any) {
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        // Save
        settings["ReminderNotifications"]![selectedRow] = -1
        UserDefaults.standard.set(settings, forKey: "userSettings")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
        // Update Indicator
        let indexPath = NSIndexPath(row: selectedRow, section: selectedSection)
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        cell?.detailTextLabel?.text = NSLocalizedString("off", comment: "")
        cell?.detailTextLabel?.textColor = Colors.red
        // Animate
        ActionSheet.shared.animateActionSheetDown()
        //
        // Update notifications
        ReminderNotifications.shared.setNotifications()
    }
    
    
    //
    // MARK: Settings TableView --------------------------------------------------------------------------------------------------------------------------
    //
    let sectionsArray = [["title": "profile",
                          "rows": 1],
                         ["title": "general",
                          "rows": 2],
                         ["title": "automaticSessions",
                          "rows": 2],
                         ["title": "reminders",
                          "rows": 3],
                         ["title": "restTimes",
                          "rows": 3],
                         ["title": "custom",
                          "rows": 1],
                         ["title": "reset",
                          "rows": 2],
                         ]
    
    // Sections
    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Header
        let header = UIView()
        let headerHeight = CGFloat(24.5)
        header.backgroundColor = Colors.gray
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = Fonts.tinyElementLight!
        label.textColor = UIColor.gray
        label.text = NSLocalizedString(sectionsArray[section]["title"] as! String, comment: "").uppercased()
        label.sizeToFit()
        label.frame = CGRect(x: 16, y: 0, width: label.bounds.width, height: headerHeight)
        header.addSubview(label)
        //
        switch section {
        case 0,2,3,5:
            let explanationButton = UIButton()
            explanationButton.frame = CGRect(x: label.frame.maxX + 8, y: 3.25, width: 18, height: 18)
            explanationButton.center.y = label.center.y
            explanationButton.setImage(#imageLiteral(resourceName: "QuestionMarkMenu"), for: .normal)
            explanationButton.layer.borderColor = UIColor.gray.cgColor
            explanationButton.layer.borderWidth = 0.75
            explanationButton.layer.cornerRadius = explanationButton.bounds.height / 2
            explanationButton.clipsToBounds = true
            explanationButton.tintColor = UIColor.gray
            explanationButton.tag = section
            explanationButton.addTarget(self, action: #selector(helpButtonAction(_:)), for: .touchUpInside)
            header.addSubview(explanationButton)
            // Add extra button to make the area of the question mark larger and easier to press
            let extraButton = UIButton()
            extraButton.frame = CGRect(x: 0, y: 0, width: 49, height: 24.5)
            extraButton.center.x = explanationButton.center.x
            extraButton.tag = section
            extraButton.addTarget(self, action: #selector(helpButtonAction(_:)), for: .touchUpInside)
            header.addSubview(extraButton)
        default: break
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.frame = CGRect.zero
        footer.backgroundColor = Colors.gray
        return footer
    }
    
    // Header Height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24.5
    }

    // Rows
    // Number of rows per section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return sectionsArray[section]["rows"] as! Int
    }
    
    // Row cell customization
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Settings sections
        switch indexPath.section {
        // Profile
        case 0:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.backgroundColor = Colors.light
            
            cell.textLabel?.text = NSLocalizedString("profile", comment: "")
            cell.textLabel?.font = Fonts.regularCell
            cell.accessoryType = .disclosureIndicator
            
            return cell

        // Background / Units
        case 1:
            //
            switch indexPath.row {
            // Background Image
            case 0:
                let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
                cell.backgroundColor = Colors.light
                //
                cell.textLabel?.text = NSLocalizedString("backgroundImage", comment: "")
                cell.textLabel?.font = Fonts.regularCell
                
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
                    backgroundImageView.backgroundColor = Colors.darkGray
                    
                    // If red-orange background
                }
                // Final background image view customization
                backgroundImageView.contentMode = .scaleToFill
                cell.addSubview(backgroundImageView)
                cell.accessoryType = .disclosureIndicator
                
                //
                return cell
                
            // Units
            case 1:
                
                // Units
                let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                cell.backgroundColor = Colors.light
                cell.textLabel?.font = Fonts.regularCell
                cell.detailTextLabel?.font = Fonts.regularCell
                
                cell.textLabel?.text = NSLocalizedString("units", comment: "")
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                let units = settings["Units"]![0]
                if units == 0 {
                    cell.detailTextLabel?.text = NSLocalizedString("metric", comment: "")
                } else {
                    cell.detailTextLabel?.text = NSLocalizedString("imperial", comment: "")
                }
                
                return cell
                
            default: break
            }
            //
            
            
        // Timed sessions
        case 2:
            
            switch indexPath.row {
            // Timed sessions
            case 0:
                //
                // timed schedule sessions
                let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                cell.backgroundColor = Colors.light
                cell.selectionStyle = .none
                //
                cell.textLabel?.text = NSLocalizedString("automaticSessions", comment: "")
                cell.textLabel?.font = Fonts.regularCell
                //
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                let automaticSession = settings["TimeBasedSessions"]![0]
                if automaticSession == 0 {
                    automaticSessionSwitch.isOn = false
                } else {
                    automaticSessionSwitch.isOn = true
                }
                //
                // on off
                cell.addSubview(automaticSessionSwitch)
                automaticSessionSwitch.center = CGPoint(x: view.bounds.width - 16 - (automaticSessionSwitch.bounds.width / 2), y: cell.bounds.height / 2)
                
                //
                return cell
            // Yoga automatic
            case 1:
                //
                let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                //
                cell.textLabel?.text = NSLocalizedString("automaticYoga", comment: "")
                cell.textLabel?.font = Fonts.regularCell
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
                cell.detailTextLabel?.font = Fonts.regularCell
                //
                cell.accessoryType = .disclosureIndicator
                //
                return cell
            default: break
            }
            
        // Reminders
        case 3:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = Colors.light
            cell.textLabel?.font = Fonts.regularCell
            cell.textLabel?.textColor = UIColor.black
            //
            cell.detailTextLabel?.font = Fonts.regularCell
            //
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            
            switch indexPath.row {
            case 0:
                //
                cell.textLabel?.text = NSLocalizedString("morningReminder", comment: "")
                if settings["ReminderNotifications"]![0] == -1 {
                    cell.detailTextLabel?.text = NSLocalizedString("off", comment: "")
                    cell.detailTextLabel?.textColor = Colors.red
                } else {
                    cell.detailTextLabel?.text = convertTimeToString(time: settings["ReminderNotifications"]![0])
                }
            case 1:
                //
                cell.textLabel?.text = NSLocalizedString("afternoonReminder", comment: "")
                if settings["ReminderNotifications"]![1] == -1 {
                    cell.detailTextLabel?.text = NSLocalizedString("off", comment: "")
                    cell.detailTextLabel?.textColor = Colors.red
                } else {
                    cell.detailTextLabel?.text = convertTimeToString(time: settings["ReminderNotifications"]![1])
                }
            case 2:
                cell.textLabel?.text = NSLocalizedString("motivationalMessages", comment: "")
                cell.selectionStyle = .none
                // Select state
                if settings["ReminderNotifications"]![2] == 0 {
                    motivationSwitch.isOn = false
                } else {
                    motivationSwitch.isOn = true
                }
                cell.addSubview(motivationSwitch)
                motivationSwitch.center = CGPoint(x: view.bounds.width - 16 - (motivationSwitch.bounds.width / 2), y: cell.bounds.height / 2)
                
            default: break
            }
            //
            return cell
            
        // Rest Time
        case 4:
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
            cell.textLabel?.font = Fonts.regularCell
            cell.detailTextLabel?.font = Fonts.regularCell
            cell.backgroundColor = Colors.light
            //
            return cell
            
        // Custom Warmup/Stretching
        case 5:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            cell.backgroundColor = Colors.light
            cell.selectionStyle = .none
            //
            cell.textLabel?.text = NSLocalizedString("customWarmupStretching", comment: "")
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = Colors.light
            cell.textLabel?.font = Fonts.regularCell
            //
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            
            // Select state of switch
            if settings["CustomWarmupStretching"]![0] == 0 {
                customSwitch.isOn = false
            } else {
                customSwitch.isOn = true
            }
            cell.addSubview(customSwitch)
            customSwitch.center = CGPoint(x: view.bounds.width - 16 - (motivationSwitch.bounds.width / 2), y: cell.bounds.height / 2)
            return cell
            
        // Reset
        case 6:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            cell.backgroundColor = Colors.light
            cell.textLabel?.font = Fonts.regularCell
            //
            // Reset Walkthrough
            if indexPath.row == 0 {
                cell.textLabel?.text = NSLocalizedString("resetWalkthrough", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = Colors.light
                cell.textLabel?.font = Fonts.regularCell
                return cell
            // Reset App
            } else if indexPath.row == 1 {
                cell.textLabel?.text = NSLocalizedString("resetApp", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = Colors.light
                cell.textLabel?.font = Fonts.regularCell
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
        // Profile
        case 0:
            performSegue(withIdentifier: "ProfileSegue", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)

        // Background
        case 1:
            //
            switch indexPath.row {
            // Background Image
            case 0:
                // Segue to homescreen choice
                performSegue(withIdentifier: "BackgroundImageSegue", sender: nil)
                //
                tableView.deselectRow(at: indexPath, animated: true)
                
            // Units
            case 1:
                let cell = tableView.cellForRow(at: indexPath)
                
                // Units
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
                
            default: break
            }
            //
            
        // Timed sessions
        case 2:
            
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
            
        // Reminders
        case 3:
            // Present time picker
            switch indexPath.row {
            case 0,1:
                //
                var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]

                //
                selectedRow = indexPath.row
                selectedSection = indexPath.section
                timePicker.reloadAllComponents()
                //
                // View
                let selectionWidth = ActionSheet.shared.actionWidth
                let separationHeight = 1
                let selectionHeight = CGFloat(147 + 49 + separationHeight + 49)
                //
                UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
                selectionView.frame = CGRect(x: 10, y: view.frame.maxY, width: selectionWidth, height: selectionHeight)
                self.timePicker.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: 147)
                //
                // PickerView
                selectionView.addSubview(timePicker)
                timePicker.frame = CGRect(x: 0, y: 0, width: selectionView.frame.size.width, height: 147)
                // Select Rows
                if settings["ReminderNotifications"]![indexPath.row] == -1 {
                    selectTimeInPicker(time: 0, picker: timePicker)
                } else {
                    selectTimeInPicker(time: settings["ReminderNotifications"]![indexPath.row], picker: timePicker)
                }
                
                // Ok
                okButton2.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
                selectionView.addSubview(okButton2)
                // Off
                offButton.frame = CGRect(x: 0, y: 147 + 49 + separationHeight, width: Int(selectionView.frame.size.width), height: 49)
                selectionView.addSubview(offButton)
                //
                selectionView.frame = CGRect(x: 0, y: 0, width: selectionWidth, height: selectionHeight)
                
                ActionSheet.shared.setupActionSheet()
                ActionSheet.shared.actionSheet.addSubview(selectionView)
                let heightToAdd = selectionView.bounds.height
                ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
                ActionSheet.shared.resetCancelFrame()
                ActionSheet.shared.animateActionSheetUp()
                
                tableView.deselectRow(at: indexPath, animated: true)

        default: break
        }
            
        // Rest Time
        case 4:
            //
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
      
        // Reset
        case 6:
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
                let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertActionStyle.default) {
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
                let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default) {
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
                let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertActionStyle.default) {
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
                let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default) {
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
        switch sender {
        case automaticSessionSwitch:
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
            
        // Reminders
        case motivationSwitch:
            // Timed sessions
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            
            // off -> on
            if sender.isOn {
                settings["ReminderNotifications"]![2] = 1
                // on -> off
            } else {
                settings["ReminderNotifications"]![2] = 0
            }
            //
            UserDefaults.standard.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            //
            // Update notifications
            ReminderNotifications.shared.setNotifications()
            
        // Custom Warmup/Stretching
        case customSwitch:
            // Timed sessions
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            
            // off -> on
            if sender.isOn {
                settings["CustomWarmupStretching"]![0] = 1
                // on -> off
            } else {
                settings["CustomWarmupStretching"]![0] = 0
            }
            //
            UserDefaults.standard.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            
        default: break
        }
    }
    
    
    //
    // MARK: Picker View ----------------------------------------------------------------------------------------------------
    //
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        case restTimePicker:
            return 1
        case timePicker:
            return 3
        default:
            return 1
        }
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case restTimePicker:
            return restTimesArray.count
        case timePicker:
            return timeInDayArray[component].count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        //
        switch pickerView {
        case timePicker:
            return pickerView.bounds.width / 6
        default:
            return pickerView.bounds.width
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
        case timePicker:
            //
            let timeLabel = UILabel()
            timeLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
            timeLabel.textColor = Colors.light
            //
            // am/pm
            if component == 2 {
                if row == 0 {
                    timeLabel.text = NSLocalizedString("am", comment: "")
                } else if row == 1 {
                    timeLabel.text = NSLocalizedString("pm", comment: "")
                }
            } else if timeInDayArray[component][row] < 10 && component == 1 {
                timeLabel.text = "0" + String(timeInDayArray[component][row])
            } else {
                timeLabel.text = String(timeInDayArray[component][row])
            }
            //
            timeLabel.textAlignment = .center
            return timeLabel
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Remove back button text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = Colors.light
        
        if segue.identifier == "ProfileSegue" {
            let destinationNC = segue.destination as? ProfileNavigation
            let destinationVC = destinationNC?.viewControllers.first as? Profile
            destinationVC?.fromSettings = true
        }
    }
    
    
    // MARK: Helper Funcs
    
    // MARK: Convert times for time picker
    func convertPickerToMinutes(picker: UIPickerView) -> Int {
        var totalMinutes: Int = 0
        var hours = picker.selectedRow(inComponent: 0)
        let minutes = picker.selectedRow(inComponent: 1)
        // pm, shift by 12 hours (0(12)-11 in picker with am/pm)
        let amPm = picker.selectedRow(inComponent: 2)
        if amPm == 1 {
            hours = hours + 12
        }
        totalMinutes = (hours*60) + minutes
        return totalMinutes
    }
    
    func selectTimeInPicker(time: Int, picker: UIPickerView) {
        var hours = Int(time/60)
        if hours < 12 {
            // 00 am == 12 am
            if hours == 0 {
                hours = 12
            }
            // Select am == row 0
            picker.selectRow(0, inComponent: 2, animated: false)
        } else if hours > 11 {
            // 00 pm = 12 pm
            if hours != 12 {
                hours = hours % 12
            }
            // Select pm == row 1
            picker.selectRow(1, inComponent: 2, animated: false)
        }
        //
        if let hoursIndex = timeInDayArray[0].index(of: hours) {
            picker.selectRow(hoursIndex, inComponent: 0, animated: false)
        } else {
            picker.selectRow(0, inComponent: 0, animated: false)
        }
        //
        let minutes = time % 60
        if let minutesIndex = timeInDayArray[1].index(of: minutes) {
            picker.selectRow(minutesIndex, inComponent: 1, animated: false)
        } else {
            picker.selectRow(0, inComponent: 1, animated: false)
        }
    }
    
    func convertTimeToString(time: Int) -> String {
        var timeAsString = String()
        //
        var hours = Int(time/60)
        var amPm = String()
        let am = NSLocalizedString("am", comment: "")
        let pm = NSLocalizedString("pm", comment: "")
        if hours < 12 {
            // 00 am == 12 am
            if hours == 0 {
                hours = 12
            }
            amPm = am
        } else if hours > 11 {
            // 00 pm = 12 pm
            if hours != 12 {
                hours = hours % 12
            }
            amPm = pm
        }
        let minutes = time % 60
        var minutesString = String(minutes)
        if minutes < 10 {
            minutesString = "0" + minutesString
        }
        timeAsString = String(hours) + ":" + minutesString + " " + amPm
        return timeAsString
    }
    
    
    //
    // MARK: Help - question mark handler
    let explanationTexts = ["settings0", "", "settings1", "settings2", "", "settings3", ""]
    
    @objc func helpButtonAction(_ sender: UIButton) {
        
        // Setup
        walkthroughNextButton.addTarget(self, action: #selector(explanationNextAction), for: .touchUpInside)
        //
        walkthroughView = setWalkthrough(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, separator: walkthroughLabelSeparator, nextButton: walkthroughNextButton, backButton: walkthroughBackButton, highlight: walkthroughHighlight, simplePopup: true)

        // Label
        walkthroughLabelTitle.text = NSLocalizedString(explanationTexts[sender.tag] + "T", comment: "")
        
        walkthroughLabel.text = NSLocalizedString(explanationTexts[sender.tag], comment: "")
        walkthroughLabel.frame.size = walkthroughLabel.sizeThatFits(CGSize(width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding, height: .greatestFiniteMagnitude))
        
        walkthroughLabel.frame = CGRect(
            x: WalkthroughVariables.padding,
            y: WalkthroughVariables.topHeight + WalkthroughVariables.padding,
            width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding,
            height: walkthroughLabel.frame.size.height)
        walkthroughLabelView.frame = CGRect(
            x: WalkthroughVariables.viewPadding,
            y: (tabBarController?.tabBar.frame.minY)! - WalkthroughVariables.topHeight - walkthroughLabel.frame.size.height - WalkthroughVariables.viewPadding - WalkthroughVariables.twicePadding,
            width: view.frame.size.width - WalkthroughVariables.twiceViewPadding,
            height: WalkthroughVariables.topHeight + walkthroughLabel.frame.size.height + WalkthroughVariables.twicePadding)
    
        // Colour
        walkthroughView.alpha = 1
        walkthroughLabelView.backgroundColor = Colors.dark
        walkthroughLabel.textColor = Colors.light
        walkthroughLabelTitle.textColor = Colors.light
        walkthroughLabelSeparator.backgroundColor = Colors.light
        walkthroughNextButton.setTitleColor(Colors.light, for: .normal)
        walkthroughBackButton.setTitleColor(Colors.light, for: .normal)
        
        // Highlight - none
        walkthroughHighlight.frame = CGRect.zero
    }
    @objc func explanationNextAction() {
       // Dismiss view
        UIView.animate(withDuration: 0.4, animations: {
            self.walkthroughView.alpha = 0
        }, completion: { finished in
            self.walkthroughView.alpha = 1
            self.walkthroughView.removeFromSuperview()
        })
    }
    
    //
    // MARK: Walkthrough ------------------------------------------------------------------------------------------------------------------
    //
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabelView = UIView()
    var walkthroughLabelTitle = UILabel()
    var walkthroughLabelSeparator = UIView()
    var walkthroughLabel = UILabel()
    var walkthroughNextButton = UIButton()
    var walkthroughBackButton = UIButton()
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["settings0", "settings1"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    @objc func backActionWalkthrough() {
        if walkthroughProgress != 0 && walkthroughProgress != 1 {
            walkthroughProgress -= 2
            walkthroughSettings()
        }
    }
    
    // Walkthrough
    @objc func walkthroughSettings() {
        
        //
        if didSetWalkthrough == false {
            //
            walkthroughNextButton.addTarget(self, action: #selector(walkthroughSettings), for: .touchUpInside)
            walkthroughBackButton.addTarget(self, action: #selector(backActionWalkthrough), for: .touchUpInside)
            
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, separator: walkthroughLabelSeparator, nextButton: walkthroughNextButton, backButton: walkthroughBackButton, highlight: walkthroughHighlight, simplePopup: false)
            didSetWalkthrough = true
        }
        
        //
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Homepage
        case 0:
            
            //
            walkthroughLabelTitle.text = NSLocalizedString(walkthroughTexts[walkthroughProgress] + "T", comment: "")
            
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.frame.size = walkthroughLabel.sizeThatFits(CGSize(width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding, height: .greatestFiniteMagnitude))
            
            walkthroughLabel.frame = CGRect(
                x: WalkthroughVariables.padding,
                y: WalkthroughVariables.topHeight + WalkthroughVariables.padding,
                width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding,
                height: walkthroughLabel.frame.size.height)
            walkthroughLabelView.frame = CGRect(
                x: 13,
                y: (tabBarController?.tabBar.frame.minY)! - WalkthroughVariables.topHeight - walkthroughLabel.frame.size.height - 13 - WalkthroughVariables.twicePadding,
                width: view.frame.size.width - 26,
                height: WalkthroughVariables.topHeight + walkthroughLabel.frame.size.height + WalkthroughVariables.twicePadding)
            
            // Colour
            walkthroughLabelView.backgroundColor = Colors.dark
            walkthroughLabel.textColor = Colors.light
            walkthroughLabelTitle.textColor = Colors.light
            walkthroughLabelSeparator.backgroundColor = Colors.light
            walkthroughNextButton.setTitleColor(Colors.light, for: .normal)
            walkthroughBackButton.setTitleColor(Colors.light, for: .normal)
            walkthroughHighlight.backgroundColor = Colors.dark.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.dark.cgColor
            

            //
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))

            
            // Flash
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.frame = CGRect(x: 8, y: ControlBarHeights.combinedHeight + (cell?.frame.minY)!, width: self.view.bounds.width - 16, height: 44)
                self.walkthroughHighlight.layer.cornerRadius = self.walkthroughHighlight.bounds.height / 4
                
                self.walkthroughHighlight.backgroundColor = Colors.dark.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colors.dark.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Timed Sessions
        case 1:
            
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 2))
            highlightSize = CGSize(width: view.bounds.width - 22, height: 44 * 2)
            highlightCenter = CGPoint(x: view.center.x, y: tableView.frame.minY + (cell?.frame.maxY)!)
            
            highlightCornerRadius = 2
            // iphone5
            if IPhoneType.shared.iPhoneType() == 0 {
                labelFrame = 1
            } else {
                labelFrame = 0
            }

            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light

            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)

            walkthroughProgress = self.walkthroughProgress + 1
          
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                walkthroughs["Settings"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["walkthroughs"])
            })
        }
    }
}

class SettingsNavigation: UINavigationController {

}

