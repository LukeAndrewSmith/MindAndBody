//
//  ReminderNotifications.swift
//  MindAndBody
//
//  Created by Luke Smith on 22.06.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


//
// Reminder Notification Settings Class --------------------------------------------------------------------------------------------------
//
class ReminderNotificationsSettings: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //
    // Outlets --------------------------------------------------------------------------------------------------
    //
    //
    @IBOutlet weak var remindersTable: UITableView!
    
    //
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    //
    var motivationSwitch = UISwitch()
    
    //
    // Arrays --------------------------------------------------------------------------------------------------
    //
    // Section Headers
    var sectionHeaderArray: [String] = ["notifications", "content"]
    var sectionArray: [[String]] = [
            // Notifications
            ["morningReminder", "afternoonReminder"],
            // Content
            ["motivationalMessages"]]
    
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
    // Selection Items
    let selectionView = UIView()
    let okButton = UIButton()
    let offButton = UIButton()
    var selectedRow = 0
    //
    // Lengths
    let pickerView = UIPickerView()
    //
    
    //
    // View did load --------------------------------------------------------------------------------------------------
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        // Set TableView Background Colour
        //
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = Colors.light
        //
        self.remindersTable.backgroundView = backView
    }
    
    
    //
    // View did load --------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar
        navigationBar.title = NSLocalizedString("reminders", comment: "")
        
        // Table View
        remindersTable.tableFooterView = UIView()
        
        // Selection Items
        // view
        selectionView.backgroundColor = Colors.dark
        selectionView.layer.cornerRadius = 15
        selectionView.layer.masksToBounds = true
        
        //
        okButton.backgroundColor = Colors.light
        okButton.setTitleColor(Colors.green, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        //
        offButton.backgroundColor = Colors.light
        offButton.setTitleColor(Colors.red, for: .normal)
        offButton.setTitle(NSLocalizedString("turnOff", comment: ""), for: .normal)
        offButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        offButton.addTarget(self, action: #selector(offButtonAction(_:)), for: .touchUpInside)
        
        // Picker
        pickerView.backgroundColor = Colors.dark
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //
        // Switch
        motivationSwitch.onTintColor = Colors.green
        motivationSwitch.tintColor = Colors.red
        motivationSwitch.backgroundColor = Colors.red
        motivationSwitch.layer.cornerRadius = motivationSwitch.bounds.height / 2
        motivationSwitch.clipsToBounds = true
        motivationSwitch.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    //
    // Table View --------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(sectionHeaderArray[section], comment: "")
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 17)!
        //
        header.contentView.backgroundColor = Colors.light
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray[section].count
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        //
        //
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.backgroundColor = Colors.light
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        //
        cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        //
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        //
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = NSLocalizedString(sectionArray[indexPath.section][indexPath.row], comment: "")
            cell.selectionStyle = .none
            
            switch indexPath.row {
            case 0:
                //
                if settings["ReminderNotifications"]![0] == -1 {
                    cell.detailTextLabel?.text = NSLocalizedString("off", comment: "")
                } else {
                    cell.detailTextLabel?.text = convertTimeToString(time: settings["ReminderNotifications"]![0])
                }
            case 1:
                //
                if settings["ReminderNotifications"]![1] == -1 {
                    cell.detailTextLabel?.text = NSLocalizedString("off", comment: "")
                } else {
                    cell.detailTextLabel?.text = convertTimeToString(time: settings["ReminderNotifications"]![1])
                }
            default: break
            }
            
        case 1:
            cell.textLabel?.text = NSLocalizedString(sectionArray[indexPath.section][indexPath.row], comment: "")
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
            
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        //
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        
        //
        if indexPath.section == 0 {
            //
            selectedRow = indexPath.row
            pickerView.reloadAllComponents()
            //
            // View
            let selectionWidth = ActionSheet.shared.actionWidth
            let separationHeight = 1
            let selectionHeight = CGFloat(147 + 49 + separationHeight + 49)
            //
            UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
            selectionView.frame = CGRect(x: 10, y: view.frame.maxY, width: selectionWidth, height: selectionHeight)
            self.pickerView.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: 147)
            //
            // PickerView
            selectionView.addSubview(pickerView)
            pickerView.frame = CGRect(x: 0, y: 0, width: selectionView.frame.size.width, height: 147)
            // Select Rows
            if settings["ReminderNotifications"]![indexPath.row] == -1 {
                selectTimeInPicker(time: 0, picker: pickerView)
            } else {
                selectTimeInPicker(time: settings["ReminderNotifications"]![indexPath.row], picker: pickerView)
            }
            
            // Ok
            okButton.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
            selectionView.addSubview(okButton)
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
        }
        
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    //
    // Picker View ----------------------------------------------------------------------------------------------------
    //
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeInDayArray[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.bounds.width / 6
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
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
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
    
    
    // MARK: Helpers
    // MARK: Convert times
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
    // MARK: Selection Related actions ------------------------------------------------------------------------------------------------
    
    
    // Ok button action
    @objc func okButtonAction(_ sender: Any) {
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        // Save
        settings["ReminderNotifications"]![selectedRow] = convertPickerToMinutes(picker: pickerView)
        UserDefaults.standard.set(settings, forKey: "userSettings")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
        // Update Indicator
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = remindersTable.cellForRow(at: indexPath as IndexPath)
        cell?.detailTextLabel?.text = convertTimeToString(time: settings["ReminderNotifications"]![selectedRow])
        // Animate
        ActionSheet.shared.animateActionSheetDown()
        //
        // Update notifications
        ReminderNotifications.shared.setNotifications()

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
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = remindersTable.cellForRow(at: indexPath as IndexPath)
        cell?.detailTextLabel?.text = NSLocalizedString("off", comment: "")
        // Animate
        ActionSheet.shared.animateActionSheetDown()
        //
        // Update notifications
        ReminderNotifications.shared.setNotifications()
    }
    
    //
    // MARK: Switch handlers
    @objc func valueChanged(_ sender: UISwitch) {
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
    }
}

