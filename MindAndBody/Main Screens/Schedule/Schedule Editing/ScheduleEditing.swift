//
// ScheduleEditing.swift
//  MindAndBody
//
//  Created by Luke Smith on 06.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class ScheduleEditing: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //
    // Using fake navigation bar as can;t get hiding the navigation bar on subsequent screens to work as desired
    @IBOutlet weak var fakeNavigationBarLabel: UILabel!
    @IBOutlet weak var scheduleOverviewTable: UITableView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    //
    // App helps create schedule 0 or custom schedule 1
    var scheduleType = Int()
    
    //
    var appChoosesSessionsSwitch = UISwitch()
    var scheduleStyleSegment = UISegmentedControl()
    
    var heightForRow = CGFloat()
    
    //
    let scheduleOverviewArrays: [String] =
        [
            "name",
            "sessionChoosing",
            "view",
            "equipment",
            "editSchedule",
        ]
    
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Ensure app chooses sessions only if profile is complete
        if !isProfileComplete() {
            // If app chooses sessions, revert
            if appChoosesSessionsSwitch.isOn {
                var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] = 1
                appChoosesSessionsSwitch.isOn = false
                // Update
                UserDefaults.standard.set(schedules, forKey: "schedules")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
            }
        }
    }

    // func check profile
    func isProfileComplete() -> Bool {
        //
        // Check if profile is complete
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [String: Int]
        var isComplete = true
        for i in 0..<scheduleDataStructures.profileQASorted.count {
            if profileAnswers[scheduleDataStructures.profileQASorted[i]]! == -1 {
                isComplete = false
                break
            }
        }
        return isComplete
    }
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setVariables()
        //
        layoutView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Set Variables
    func setVariables() {
        // Schedule Type
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        scheduleType = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int
    }
    
    // Layout
    func layoutView() {
        //
        view.backgroundColor = Colors.dark
        //
        // Navigation Bar
        fakeNavigationBarLabel.text = NSLocalizedString("scheduleOverview", comment: "")
        //
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: true)
        
        //
        // TableView
        scheduleOverviewTable.backgroundColor = .clear
        scheduleOverviewTable.tableFooterView = UIView()
        scheduleOverviewTable.separatorColor = Colors.light.withAlphaComponent(0.27)
        scheduleOverviewTable.isScrollEnabled = false
        
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        
        // App chooses sessions switch
        appChoosesSessionsSwitch.onTintColor = Colors.green
        appChoosesSessionsSwitch.tintColor = Colors.red
        appChoosesSessionsSwitch.backgroundColor = Colors.red
        appChoosesSessionsSwitch.layer.cornerRadius = appChoosesSessionsSwitch.bounds.height / 2
        appChoosesSessionsSwitch.clipsToBounds = true
        appChoosesSessionsSwitch.addTarget(self, action: #selector(switchValueChanged), for: UIControlEvents.valueChanged)
        // Set inital value
        // On
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] as! Int == 0 {
            appChoosesSessionsSwitch.isOn = true
        // Off
        } else if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] as! Int == 1 {
            appChoosesSessionsSwitch.isOn = false
        }
    
        // Schedule Style Segmented Control
         let week = NSLocalizedString("weekStyle", comment: "")
        let day = NSLocalizedString("dayStyle", comment: "")
        let items = [week, day]
        scheduleStyleSegment = UISegmentedControl(items: items)
        scheduleStyleSegment.setTitleTextAttributes([NSAttributedStringKey.font : UIFont(name: "SFUIDisplay-thin", size: 23), NSAttributedStringKey.foregroundColor: Colors.light], for: .normal)
        scheduleStyleSegment.layer.borderWidth = 1
        scheduleStyleSegment.layer.borderColor = Colors.light.withAlphaComponent(0.72).cgColor
        scheduleStyleSegment.backgroundColor = Colors.dark.withAlphaComponent(0.23)
        scheduleStyleSegment.tintColor = Colors.light.withAlphaComponent(0.72)
        scheduleStyleSegment.addTarget(self, action: #selector(segmentHandler), for: .valueChanged)
        //
        // Schedule style = Day
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int == 0 {
            scheduleStyleSegment.selectedSegmentIndex = 1
        // Schedule style = Week
        } else if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int == 1 {
            scheduleStyleSegment.selectedSegmentIndex = 0
        }
        
        //
        // Done Button
        saveButton.backgroundColor = Colors.green.withAlphaComponent(0.25)
        saveButton.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        //
    }
    
    //
    // MARK: TableView ------------------------------------------------------------------------------------
    //
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)!
        header.textLabel?.textColor = Colors.light
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        //
        header.backgroundColor = .clear
        header.backgroundView = UIView()
        
        let separator = CALayer()
        separator.frame = CGRect(x: 16, y: header.frame.size.height - 1, width: view.frame.size.width - 32, height: 1)
        separator.backgroundColor = Colors.light.cgColor
        separator.opacity = 0.5
        header.layer.addSublayer(separator)
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return view.bounds.height / 4
        return 0
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return scheduleOverviewArrays.count
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        // Iphone 5/SE layout
        if IPhoneType.shared.iPhoneType() == 0 {
            heightForRow = 52
            return heightForRow
        } else {
            heightForRow = 62
            return heightForRow
        }
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        // Text label
        cell.textLabel?.text = NSLocalizedString(scheduleOverviewArrays[indexPath.row], comment: "")
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        cell.textLabel?.textColor = Colors.light
        // Detail text label
        cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        cell.detailTextLabel?.textColor = Colors.light
        
        //
        // Detail label, shows schedule overview data
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        switch indexPath.row {
        // Name
        case 0:
            cell.detailTextLabel?.text = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["title"] as? String
        // Sessions choosing
        case 1:
            // App chooses
            cell.selectionStyle = .none
            cell.addSubview(appChoosesSessionsSwitch)
            if IPhoneType.shared.iPhoneType() == 0 {
                appChoosesSessionsSwitch.center = CGPoint(x: view.bounds.width - (appChoosesSessionsSwitch.bounds.width / 2) - 16, y: 52 / 2)
            } else {
                appChoosesSessionsSwitch.center = CGPoint(x: view.bounds.width - (appChoosesSessionsSwitch.bounds.width / 2) - 16, y: 62 / 2)
            }

        // View full week
        case 2:
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            
            // minX good for
            let minX = cell.textLabel?.frame.maxX
            let labelHeight = cell.textLabel?.bounds.height
            var width = view.bounds.width - 32 - 16 - minX!
            if width > 323 {
                width = 323
            }
            scheduleStyleSegment.frame = CGRect(x: view.frame.maxX - width - 16, y: (heightForRow - labelHeight!) / 2, width: width, height: labelHeight!)
            // heightForRow - 32
            scheduleStyleSegment.layer.cornerRadius = (heightForRow - 32) * (1/4)
            scheduleStyleSegment.clipsToBounds = true
            cell.addSubview(scheduleStyleSegment)
            
        // Equiptment
        case 3:
            cell.accessoryType = .disclosureIndicator
        // Schedule
        case 4:
            cell.accessoryType = .disclosureIndicator
        default: break
        }
        //
        return cell
    }
    
    //
    var okAction = UIAlertAction()
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        //
        // Detail label, shows schedule overview data
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        switch indexPath.row {
        // Name
        case 0:
            // Popup
            // Alert and Functions
            let inputTitle = NSLocalizedString("scheduleInputTitle", comment: "")
            //
            let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
            alert.view.tintColor = Colors.dark
            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
            //2. Add the text field
            alert.addTextField { (textField: UITextField) in
                textField.text = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["title"] as? String
                textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
                textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
            }
            // 3. Get the value from the text field, and perform actions upon OK press
            okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { [weak alert] (_) in
                //
                // Update Title
                let textField = alert?.textFields![0]
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["title"] = textField?.text! ?? ""
                //
                // SET NEW ARRAY
                UserDefaults.standard.set(schedules, forKey: "schedules")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
                
                // Update name in table
                cell?.detailTextLabel?.text = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["title"] as? String
            })
            // Cancel action
            let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
            //
        // Equipment
        case 3:
            self.performSegue(withIdentifier: "EquipmentSegue", sender: self)
        // N Sessions / Schedule
        case 4:
            // View each day
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int == 0 {
                self.performSegue(withIdentifier: "OverviewScheduleSegue", sender: self)
            // View full week
            } else {
                self.performSegue(withIdentifier: "OverviewScheduleWeekSegue", sender: self)
            }
        default: break
        }
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Change title alert check, only enable name if text is there
    // Enable ok alert action func
    @objc func textChanged(_ sender: UITextField) {
        if sender.text == "" {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    
    //
    // Watch for switch changed
    @objc func switchValueChanged(sender: UISwitch) {
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        if sender == appChoosesSessionsSwitch {
            // App chooses sessions
            if sender.isOn {
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] = 0
                // If profile is not completed, go to profile
                // Profile not complete if one of the answers is still the default -1
                if !isProfileComplete() {
                    // Alert View
                    let title = NSLocalizedString("profile", comment: "")
                    let message = NSLocalizedString("appChoosesSessionsWarning", comment: "")
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alert.view.tintColor = Colors.dark
                    alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
                    //
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.alignment = .natural
                    alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
                    // Action
                    let okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: UIAlertActionStyle.default) {
                        UIAlertAction in
                        // Go to profile
                        self.performSegue(withIdentifier: "OverviewProfileSegue", sender: self)
                    }
                    alert.addAction(okAction)
                    //
                    self.present(alert, animated: true, completion: nil)
                }
            // User chooses sessions
            } else {
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] = 1
            }
        }
        UserDefaults.standard.set(schedules, forKey: "schedules")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
    }
    
    @objc func segmentHandler(sender: UISegmentedControl) {
        if sender == scheduleStyleSegment {
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
            switch sender.selectedSegmentIndex {
                // Week selected
                case 0:
                    schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] = 1
                // Day selected
                case 1:
                    schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] = 0
                default:
                    break
            }
            UserDefaults.standard.set(schedules, forKey: "schedules")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
            
            // Reset notifications
            ReminderNotifications.shared.setNotifications()
        }
    }
    
    // Save Schedule
    @IBAction func saveButtonAction(_ sender: Any) {
        // Note don't actually need to save anything, name for user experience
        // Ensure notifications correct
        ReminderNotifications.shared.setNotifications()
        updateWeekProgress()
        updateTracking()
        self.dismiss(animated: true)
    }
    
    // Delete Schedule
    @IBAction func deleteButtonAction(_ sender: Any) {
        //
        // Alert View asking if you really want to delete
        let title = NSLocalizedString("deleteScheduleWarning", comment: "")
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 23)!]), forKey: "attributedTitle")
        
        // Delete schedule action
        let okAction = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            // Delete Schedule
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
                //
            // Delete if not plus row
            // Update arrays
            schedules.remove(at: ScheduleVariables.shared.selectedSchedule)
            UserDefaults.standard.set(schedules, forKey: "schedules")
                
            // Select previous schedule last schedule
            var selectedSchedule = UserDefaults.standard.integer(forKey: "selectedSchedule")
            if schedules.count == 0 || selectedSchedule == 0 {
                selectedSchedule = 0
            } else {
                selectedSchedule -= 1
            }
            ScheduleVariables.shared.selectedSchedule = selectedSchedule
            UserDefaults.standard.set(selectedSchedule, forKey: "selectedSchedule")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["schedules", "selectedSchedule"])
            //
            self.updateWeekProgress()
            self.updateTracking()
            self.dismiss(animated: true)
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
    }
    
    //
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        // Going to schedule creator
        case "OverviewSessionsSegue":
            let destinationVC = segue.destination as? ScheduleCreationHelp
            destinationVC?.comingFromScheduleEditing = true
        // Goin to profile (before schedule creator as not filled in yet)
        case "OverviewProfileSegue":
            let destinationVC = segue.destination as? Profile
            destinationVC?.comingFromScheduleEditing = true
        case "OverviewScheduleSegue":
            let destinationVC = segue.destination as? ScheduleCreator
            destinationVC?.fromScheduleEditing = true
        case "OverviewScheduleWeekSegue":
            let destinationVC = segue.destination as! ScheduleCreatorWeek
            destinationVC.comingFromScheduleEditing = true
        default: break
        }
    }
    
}

// Edit schedule navigation
class ScheduleEditingNavigation: UINavigationController {
    
}
