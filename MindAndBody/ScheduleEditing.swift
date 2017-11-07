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
    @IBOutlet weak var questionMarkButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var scheduleOverviewTable: UITableView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    //
    var selectedSchedule = Int()
    //
    // App helps create schedule 0 or custom schedule 1
    var scheduleType = Int()
    
    //
    var appChoosesSessionsOnOffSwitch = UISwitch()
    var viewFullWeekSwitch = UISwitch()
    
    //
    let scheduleOverviewArrays: [[String]] =
        [
            // App helps create schedule
                // 1 extra row, for n sessions
            [
                "name",
                "sessionChoosing",
                "viewFullWeek",
                "sessionsOfSchedule",
                "rearrangeSchedule"
            ],
            // Custom schedule
            [
                "name",
                "sessionChoosing",
                "viewFullWeek",
                "schedule"
            ]
    ]
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setVariables()
        //
        layoutView()
    }
    
    // Set Variables
    func setVariables() {
        // Selected Schedule
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        selectedSchedule = settings[7][0]
        
        // Schedule Style
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        schedules[selectedSchedule][11][0] as! Int
    }
    
    // Layout
    func layoutView() {
        //
        view.backgroundColor = Colours.colour2
        //
        // Navigation Bar
        fakeNavigationBarLabel.text = NSLocalizedString("scheduleOverview", comment: "")
        questionMarkButton.tintColor = Colours.colour1
        //
        // Background Image
        // Background Index
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        // Background Image/Colour
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            backgroundImage.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
            backgroundImage.image = nil
            backgroundImage.backgroundColor = Colours.colour1
        }
        //
        // BackgroundBlur/Vibrancy
        let backgroundBlurE = UIBlurEffect(style: .dark)
        let backgroundBlur = UIVisualEffectView()
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        //
        backgroundBlur.frame = backgroundImage.bounds
        //
        if backgroundIndex > BackgroundImages.backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
        }
        
        //
        // TableView
        scheduleOverviewTable.backgroundColor = .clear
        scheduleOverviewTable.tableFooterView = UIView()
        scheduleOverviewTable.separatorColor = Colours.colour1.withAlphaComponent(0.27)
        scheduleOverviewTable.isScrollEnabled = false
        // Switches
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
            // App chooses sessions swithc
            appChoosesSessionsOnOffSwitch.onTintColor = Colours.colour3
            appChoosesSessionsOnOffSwitch.addTarget(self, action: #selector(switchValueChanged), for: UIControlEvents.valueChanged)
            // Set inital value
            // On
            if schedules[selectedSchedule][10][0] as! Int == 0 {
                appChoosesSessionsOnOffSwitch.isOn = true
            // Off
            } else if schedules[selectedSchedule][10][0] as! Int == 1 {
                appChoosesSessionsOnOffSwitch.isOn = false
            }
            // View Full week switch
            viewFullWeekSwitch.onTintColor = Colours.colour3
            viewFullWeekSwitch.addTarget(self, action: #selector(switchValueChanged), for: UIControlEvents.valueChanged)
            // Set inital value
            // On
            if schedules[selectedSchedule][9][0] as! Int == 0 {
                viewFullWeekSwitch.isOn = false
                // Off
            } else if schedules[selectedSchedule][9][0] as! Int == 1 {
                viewFullWeekSwitch.isOn = true
            }
        
        //
        // Done Button
        saveButton.backgroundColor = Colours.colour3.withAlphaComponent(0.25)
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
        header.textLabel?.textColor = Colours.colour1
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        //
        header.backgroundColor = .clear
        header.backgroundView = UIView()
        
        let seperator = CALayer()
        seperator.frame = CGRect(x: 16, y: header.frame.size.height - 1, width: view.frame.size.width - 32, height: 1)
        seperator.backgroundColor = Colours.colour1.cgColor
        seperator.opacity = 0.5
        header.layer.addSublayer(seperator)
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return view.bounds.height / 4
        return 0
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        //
        return scheduleOverviewArrays[scheduleType].count
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        return 72
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        // Text label
        cell.textLabel?.text = NSLocalizedString(scheduleOverviewArrays[scheduleType][indexPath.row], comment: "")
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        cell.textLabel?.textColor = Colours.colour1
        // Detail text label
        cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        cell.detailTextLabel?.textColor = Colours.colour1
        
        //
        // Detail label, shows schedule overview data
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        switch indexPath.row {
        // Name
        case 0:
            cell.detailTextLabel?.text = schedules[selectedSchedule][8][0] as? String
        // Sessions choosing
        case 1:
            // App chooses
            cell.selectionStyle = .none
            cell.addSubview(appChoosesSessionsOnOffSwitch)
            appChoosesSessionsOnOffSwitch.center = CGPoint(x: view.bounds.width - (appChoosesSessionsOnOffSwitch.bounds.width / 2) - 16, y: 72 / 2)

        // View full week
        case 2:
            cell.selectionStyle = .none
            cell.addSubview(viewFullWeekSwitch)
            viewFullWeekSwitch.center = CGPoint(x: view.bounds.width - (viewFullWeekSwitch.bounds.width / 2) - 16, y: 72 / 2)
            
        // N Sessions / Schedule
        case 3:
            // App scheudle, n sessions
            if scheduleType == 0 {
                cell.accessoryType = .disclosureIndicator
            // Custom schedule, schedule
            } else {
                cell.accessoryType = .disclosureIndicator
            }
        // Reorder Schedule
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
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        switch indexPath.row {
        // Name
        case 0:
            // Popup
            // Alert and Functions
            let inputTitle = NSLocalizedString("scheduleInputTitle", comment: "")
            //
            let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
            alert.view.tintColor = Colours.colour2
            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
            //2. Add the text field
            alert.addTextField { (textField: UITextField) in
                textField.text = schedules[self.selectedSchedule][8][0] as? String
                textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
                textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
            }
            // 3. Get the value from the text field, and perform actions upon OK press
            okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                //
                // Update Title
                let textField = alert?.textFields![0]
                let lastIndex = schedules.count - 1
                schedules[lastIndex][8][0] = textField?.text! ?? ""
                //
                // SET NEW ARRAY
                UserDefaults.standard.set(schedules, forKey: "schedules")
                //
                // Update name in table
                cell?.detailTextLabel?.text = schedules[self.selectedSchedule][8][0] as? String
            })
            // Cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
            //
        // N Sessions / Schedule
        case 3:
            // App scheudle, n sessions
            if scheduleType == 0 {
                self.performSegue(withIdentifier: "OverviewSessionsSegue", sender: self)
            // Custom schedule, schedule
            } else {
                self.performSegue(withIdentifier: "OverviewScheduleSegue", sender: self)
            }
        // App schedule: Reorder Schedule
        case 4:
            self.performSegue(withIdentifier: "OverviewScheduleSegue", sender: self)
        default: break
        }
        //
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
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        if sender == appChoosesSessionsOnOffSwitch {
            // App chooses sessions
            if sender.isOn == true {
                schedules[selectedSchedule][10][0] = 0
            // User chooses sessions
            } else {
                schedules[selectedSchedule][10][0] = 1
            }
        } else {
            // Schedule style -> full week
            if sender.isOn == true {
                schedules[selectedSchedule][9][0] = 1
            // Schedule style -> see each day
            } else {
                schedules[selectedSchedule][9][0] = 0
            }
        }
        UserDefaults.standard.set(schedules, forKey: "schedules")
    }
    
    // Save Schedule
    @IBAction func saveButtonAction(_ sender: Any) {
        // Note don't actually need to save anything, name for user experience
        ScheduleVariables.shared.shouldReloadSchedule = true
        self.dismiss(animated: true)
    }
    
    // Delete Schedule
    @IBAction func deleteButtonAction(_ sender: Any) {
        //
        // Alert View asking if you really want to delete
        let title = NSLocalizedString("deleteScheduleWarning", comment: "")
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.view.tintColor = Colours.colour2
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 23)!]), forKey: "attributedTitle")
        
        // Reset app action
        let okAction = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            // Delete Schedule
            var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
            var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
            //
            // Delete if not plus row
            // Update arrays
            schedules.remove(at: self.selectedSchedule)
            scheduleTracking.remove(at: self.selectedSchedule)
            UserDefaults.standard.set(schedules, forKey: "schedules")
            UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
            
            // Select app schedule
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            settings[7][0] = 0
            self.selectedSchedule = 0
            UserDefaults.standard.set(settings, forKey: "userSettings")
            //
            ScheduleVariables.shared.shouldReloadSchedule = true
            self.dismiss(animated: true)
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
    }
    
    // Question mark button = Show walkthrough for view again
    @IBAction func questionMarkButtonAction(_ sender: Any) {
        // Call walkthrough function
    }
    
    //
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Going to schedule creator (profile)
        if segue.identifier == "OverviewSessionsSegue" {
            let destinationVC = segue.destination as? ScheduleCreationHelp
            // indicates that profile irrelevant, only care about creating schedule
        }
    }
    
}

// Edit schedule navigation
class ScheduleEditingNavigation: UINavigationController {
    
}
