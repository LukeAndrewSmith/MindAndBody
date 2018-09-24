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
    
    // Outlets
    @IBOutlet weak var leftItem: UIBarButtonItem!
    @IBOutlet weak var rightItem: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var editScheduleTable: UITableView!
    
    // App helps create schedule 0 or custom schedule 1
    var scheduleType = Int()
    
    var appChoosesSessionsSwitch = UISwitch()
    var scheduleStyleSegment = UISegmentedControl()
    
    var heightForRow = CGFloat()
    
    let editScheduleSections: [[String]] =
        [
            ["name",],
            ["sessionChoosing",
            "view",],
            ["equipment",
            "editSchedule"],
        ]
    let editScheduleSectionTitles: [String] =
        [
            "name",
            "style",
            "content",
        ]
    
    
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
            }
        }
    }

    // func check profile
    func isProfileComplete() -> Bool {
        
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
        
        setVariables()
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
        
        view.backgroundColor = Colors.gray

        // Navigation Bar
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("editSchedule", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)
        // Items
        leftItem.tintColor = Colors.light
        leftItem.title = NSLocalizedString("done", comment: "")
        leftItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBarButton!], for: .normal)
        rightItem.tintColor = Colors.red
        rightItem.image = #imageLiteral(resourceName: "Bin")

        // TableView
        editScheduleTable.tableFooterView = UIView()
        editScheduleTable.backgroundColor = Colors.gray
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 24.5)
        headerView.backgroundColor = Colors.gray
        editScheduleTable.tableHeaderView = headerView
        let topView = UIView()
        topView.backgroundColor = Colors.gray
        editScheduleTable.frame = CGRect(x: 0, y: editScheduleTable.frame.minY - editScheduleTable.bounds.height, width: editScheduleTable.bounds.width, height: editScheduleTable.bounds.height)
        editScheduleTable.addSubview(topView)
        //
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: editScheduleTable.sectionFooterHeight)
        footerView.backgroundColor = Colors.gray
        editScheduleTable.tableFooterView = footerView
        let bottomView = UIView()
        bottomView.backgroundColor = Colors.gray
        bottomView.frame = CGRect(x: 0, y: editScheduleTable.contentSize.height - 24.5, width: editScheduleTable.bounds.width, height: editScheduleTable.bounds.height)
        editScheduleTable.addSubview(bottomView)
        
        // App chooses sessions switch
        appChoosesSessionsSwitch.onTintColor = Colors.green
        appChoosesSessionsSwitch.tintColor = Colors.red
        appChoosesSessionsSwitch.backgroundColor = Colors.red
        appChoosesSessionsSwitch.layer.cornerRadius = appChoosesSessionsSwitch.bounds.height / 2
        appChoosesSessionsSwitch.clipsToBounds = true
        appChoosesSessionsSwitch.addTarget(self, action: #selector(switchValueChanged), for: UIControlEvents.valueChanged)
        // Set inital value
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
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
        scheduleStyleSegment.setTitleTextAttributes([NSAttributedStringKey.font : Fonts.regularCell!, NSAttributedStringKey.foregroundColor: Colors.dark], for: .normal)
        scheduleStyleSegment.layer.borderWidth = 1
        scheduleStyleSegment.layer.borderColor = Colors.dark.withAlphaComponent(0.93).cgColor
        scheduleStyleSegment.clipsToBounds = true
        scheduleStyleSegment.backgroundColor = Colors.light
//            .withAlphaComponent(0.72)
//            Colors.dark.withAlphaComponent(0.72)
        scheduleStyleSegment.tintColor = Colors.green.withAlphaComponent(0.93)
//            Colors.dark.withAlphaComponent(0.72)
//            Colors.green
//            Colors.dark.withAlphaComponent(0.72)
        scheduleStyleSegment.addTarget(self, action: #selector(segmentHandler), for: .valueChanged)
        //
        // Schedule style = Day
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int == 0 {
            scheduleStyleSegment.selectedSegmentIndex = 1
        // Schedule style = Week
        } else if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int == 1 {
            scheduleStyleSegment.selectedSegmentIndex = 0
        }
    }
    
    //
    // MARK: TableView ------------------------------------------------------------------------------------
    //
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return editScheduleSections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Header
        let header = UIView()
        let headerHeight = CGFloat(24.5)
        header.backgroundColor = Colors.gray
        let label = UILabel()
        label.font = Fonts.tinyElementLight!
        label.textColor = UIColor.gray
        label.text = NSLocalizedString(editScheduleSectionTitles[section], comment: "").uppercased()
        label.sizeToFit()
        label.frame = CGRect(x: 16, y: 0, width: label.bounds.width, height: headerHeight)
        header.addSubview(label)
        //
        switch section {
        case 1,2:
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
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24.5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.frame = CGRect.zero
        footer.backgroundColor = Colors.gray
        return footer
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return editScheduleSections[section].count
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        // Text label
        cell.textLabel?.text = NSLocalizedString(editScheduleSections[indexPath.section][indexPath.row], comment: "")
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.backgroundColor = Colors.light
        cell.backgroundView = UIView()
        cell.textLabel?.font = Fonts.regularCell
        // Detail text label
        cell.detailTextLabel?.font = Fonts.regularCell
        
        //
        // Detail label, shows schedule overview data
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        switch indexPath.section {
        // Name
        case 0:
            cell.detailTextLabel?.text = schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["title"] as? String
        // View
        case 1:
            switch indexPath.row {
            // Sessions choosing
            case 0:
                // App chooses
                cell.selectionStyle = .none
                cell.addSubview(appChoosesSessionsSwitch)
                appChoosesSessionsSwitch.center = CGPoint(x: view.bounds.width - (appChoosesSessionsSwitch.bounds.width / 2) - 16, y: cell.bounds.height / 2)

            // View full week
            case 1:
                cell.selectionStyle = .none
                cell.layoutIfNeeded()
                
                // minX good for
                let minX = cell.textLabel?.frame.maxX
                var width = view.bounds.width - 32 - 16 - minX!
                if width > 223 {
                    width = 223
                }
                scheduleStyleSegment.frame = CGRect(x: view.frame.maxX - width - 16, y: cell.bounds.height * (1/6), width: width, height: cell.bounds.height * (2/3))
                scheduleStyleSegment.layer.cornerRadius = scheduleStyleSegment.bounds.height / 2
                scheduleStyleSegment.clipsToBounds = true
                cell.addSubview(scheduleStyleSegment)
            default: break
            }
        // Content
        case 2:
            switch indexPath.row {
            // Equiptment
            case 0:
                cell.accessoryType = .disclosureIndicator
            // Schedule
            case 1:
                cell.accessoryType = .disclosureIndicator
            default: break
            }
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
        switch indexPath.section {
        // Name
        case 0:
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
            default: break
            }
        // case 1: no selection possible
        // Content
        case 2:
            switch indexPath.row {
            // Equipment
            case 0:
                self.performSegue(withIdentifier: "EquipmentSegue", sender: self)
            // N Sessions / Schedule
            case 1:
                // View each day
                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["scheduleStyle"] as! Int == 0 {
                    self.performSegue(withIdentifier: "OverviewScheduleSegue", sender: self)
                // View full week
                } else {
                    self.performSegue(withIdentifier: "OverviewScheduleWeekSegue", sender: self)
                }
            default: break
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
            
            // Reset notifications
            ReminderNotifications.shared.setNotifications()
        }
    }
    
    // Save Schedule
    @IBAction func saveButtonAction(_ sender: Any) {
        // Ensure notifications correct
        ReminderNotifications.shared.setNotifications()
        updateWeekGoal()
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
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: Fonts.navigationBar]), forKey: "attributedTitle")
        
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
        case "EquipmentSegue":
            let destinationVC = segue.destination as! ScheduleEquipment
            destinationVC.fromScheduleEditing = true
        default: break
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = Colors.light
        navigationItem.backBarButtonItem = backItem
    }
    
    
    // MARK: Help - question mark handler
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
    let explanationTexts = ["", "editSchedule1", "editSchedule2"]
    
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
            y: view.frame.maxY - WalkthroughVariables.topHeight - walkthroughLabel.frame.size.height - WalkthroughVariables.viewPadding - WalkthroughVariables.twicePadding,
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
    
}

// Edit schedule navigation
class ScheduleEditingNavigation: UINavigationController {
    
}
