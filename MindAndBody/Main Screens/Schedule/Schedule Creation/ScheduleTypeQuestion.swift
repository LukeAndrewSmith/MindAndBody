//
//  ScheduleTypeQuestion.swift
//  MindAndBody
//
//  Created by Luke Smith on 29.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

// A view for a quick question to the user

//
// Essentially question about app intervention in the schedule
// 1
    // App helps create schedule
    // App chooses session for you based on profile
// 2
    // App helps create schedule
    // You choose sessions
// 3
    // Custom schedule
    // App chooses session for you based on profile
// 4
    // Custom schedule
    // You choose sessions

//
class ScheduleTypeQuestion: UIViewController {
    
    //
    // MARK: Outlets
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var leftItem: UIBarButtonItem!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var scheduleOptionLabel: UILabel!
    @IBOutlet weak var scheduleOptionSwitch: UISwitch!
    @IBOutlet weak var scheduleOptionExplanationLabel: UILabel!
    
    @IBOutlet weak var separator2: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var sessionOptionLabel: UILabel!
    @IBOutlet weak var sessionOptionSwitch: UISwitch!
    @IBOutlet weak var sessionOptionExplanationLabel: UILabel!
    
    @IBOutlet weak var createScheduleButton: UIButton!
    
    
    
    var comingFromSchedule = false
    //
    // Used incase user goes forward and then back, doesn't create another schedule on seconds click of create schedule
    var didCreateNewSchedule = false
    //
    // MARK: View will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        // If going back to this screen, delete schedule that has just been created
        if ScheduleVariables.shared.didCreateNewSchedule {
            ScheduleVariables.shared.didCreateNewSchedule = false
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
        }
        
    }
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Layout
        layoutView()
        
        // Navigation bar
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("scheduleOptions", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)

        // Items
        leftItem.tintColor = Colors.red
        leftItem.image = #imageLiteral(resourceName: "Cross")
        
        // View
        view.backgroundColor = Colors.light
        separator.backgroundColor = Colors.dark.withAlphaComponent(0.72)
        separator2.backgroundColor = Colors.dark.withAlphaComponent(0.72)

        // Title Label
        titleLabel.text = NSLocalizedString("scheduleTypeQuestion", comment: "")
        titleLabel.font = Fonts.mediumElementRegular
        titleLabel.textColor = Colors.dark
    }
    
    // Layout buttons
    func layoutView() {
        
        // Schedule option
        scheduleOptionLabel.text = NSLocalizedString("scheduleOptionText", comment: "")
        scheduleOptionLabel.font = Fonts.mediumElementRegular
        scheduleOptionLabel.textColor = Colors.dark
        scheduleOptionLabel.numberOfLines = 0
        scheduleOptionLabel.lineBreakMode = .byWordWrapping
        
        scheduleOptionSwitch.onTintColor = Colors.green
        scheduleOptionSwitch.isOn = true
        scheduleOptionSwitch.tintColor = Colors.red
        scheduleOptionSwitch.backgroundColor = Colors.red
        scheduleOptionSwitch.layer.cornerRadius = scheduleOptionSwitch.bounds.height / 2
        scheduleOptionSwitch.clipsToBounds = true
    
        scheduleOptionExplanationLabel.text = NSLocalizedString("scheduleOptionExplanation", comment: "")
        scheduleOptionExplanationLabel.font = Fonts.tinyElementLight
        scheduleOptionExplanationLabel.textColor = Colors.dark
        scheduleOptionExplanationLabel.numberOfLines = 0
        scheduleOptionExplanationLabel.lineBreakMode = .byWordWrapping
        
        // Session option
        sessionOptionLabel.text = NSLocalizedString("sessionsOptionText", comment: "")
        sessionOptionLabel.font = Fonts.mediumElementRegular
        sessionOptionLabel.textColor = Colors.dark
        sessionOptionLabel.numberOfLines = 0
        sessionOptionLabel.lineBreakMode = .byWordWrapping
        
        sessionOptionSwitch.onTintColor = Colors.green
        sessionOptionSwitch.isOn = true
        sessionOptionSwitch.tintColor = Colors.red
        sessionOptionSwitch.backgroundColor = Colors.red
        sessionOptionSwitch.layer.cornerRadius = scheduleOptionSwitch.bounds.height / 2
        sessionOptionSwitch.clipsToBounds = true

        sessionOptionExplanationLabel.text = NSLocalizedString("sessionsOptionExplanation", comment: "")
        sessionOptionExplanationLabel.font = Fonts.tinyElementLight
        sessionOptionExplanationLabel.textColor = Colors.dark
        sessionOptionExplanationLabel.numberOfLines = 0
        sessionOptionExplanationLabel.lineBreakMode = .byWordWrapping
    
        // Create schedule button
        createScheduleButton.backgroundColor = Colors.green
        createScheduleButton.setTitle(NSLocalizedString("beginCreating", comment: ""), for: .normal)
        createScheduleButton.titleLabel?.font = Fonts.mediumElementRegular
        createScheduleButton.setTitleColor(Colors.dark, for: .normal)
    }
    
    // Segues
    func performSegueFunction() {
        self.performSegue(withIdentifier: "scheduleCreationPageSegue", sender: self)
    }
    
    // Enable ok alert action func
    @objc func textChanged(_ sender: UITextField) {
        if sender.text == "" {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    
    //
    var okAction = UIAlertAction()
    @IBAction func createScheduleAction(_ sender: Any) {
        //
        // Alert and Functions
        let inputTitle = NSLocalizedString("scheduleInputTitle", comment: "")
        //
        let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: Fonts.mediumElementLight!]), forKey: "attributedTitle")
        //2. Add the text field
        alert.addTextField { (textField: UITextField) in
            textField.text = ""
            textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        }
        // 3. Get the value from the text field, and perform actions upon OK press
        okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { [weak alert] (_) in
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
            //
            // Append new schedule array to schedules
            schedules.append(scheduleDataStructures.emptyWeek)
            //
            // Update selected Schedule
            // Set selected schedule to newly created schedule (last schedule in schedules)
            var selectedSchedule = UserDefaults.standard.integer(forKey: "selectedSchedule")
            selectedSchedule = schedules.count - 1
            ScheduleVariables.shared.selectedSchedule = selectedSchedule
            UserDefaults.standard.set(selectedSchedule, forKey: "selectedSchedule")
            //
            // Update Title
            let textField = alert?.textFields![0]
            let lastIndex = schedules.count - 1
            let title = textField?.text!
            schedules[lastIndex]["scheduleInformation"]![0][0]["title"] = title
            //
            // Update schedule settings settings based on switches
            // Schedule type option option
            if self.scheduleOptionSwitch.isOn {
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] = 0
            } else if self.scheduleOptionSwitch.isOn == false {
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] = 1
            }
            // Sessions choice option
            if self.sessionOptionSwitch.isOn {
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] = 0
            } else if self.sessionOptionSwitch.isOn == false {
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] = 1
            }
            //
            // SET NEW ARRAY
            UserDefaults.standard.set(schedules, forKey: "schedules")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["selectedSchedule", "schedules"])
            //
            // Indicate that new schedule has been created
            ScheduleVariables.shared.didCreateNewSchedule = true
            //
            self.performSegueFunction()
        })
        okAction.isEnabled = false
        alert.addAction(okAction)
        // Cancel action
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alert.addAction(cancelAction)
        // 4. Present the alert
        if didCreateNewSchedule == false {
            self.present(alert, animated: true, completion: nil)
            
        // If schedule just been created but user goes back to change something, doesn;t create new schedule
        } else {
            performSegue(withIdentifier: "scheduleCreationPageSegue", sender: self)
        }
    }
    
    // Back Button
    @IBAction func backButtonAction(_ sender: Any) {
        if comingFromSchedule {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //
    // Override segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scheduleCreationPageSegue" {
            
            let destinationVC = segue.destination as! ScheduleCreationController
            
            // Check if user has filled in profile
            let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [String: Int]
            var userHasFilledInProfile = true
            // Loop profile answers
            for i in 0..<scheduleDataStructures.profileQASorted.count {
                if profileAnswers[scheduleDataStructures.profileQASorted[i]] == -1 {
                    userHasFilledInProfile = false
                    break
                }
            }
            destinationVC.isProfileCompleted = userHasFilledInProfile
            
            var appChoosesSessions = false
            var appHelpsCreateSchedule = false
            print(ScheduleVariables.shared.selectedSchedule)
            
            let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
            // App helps create schedule
            print(schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int)
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSchedule"] as! Int == 0 {
                appHelpsCreateSchedule = true
            }
            print(schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] as! Int)
            // App chooses sessions
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] as! Int == 0 {
                appChoosesSessions = true
            }
            destinationVC.appChoosesSessions = appChoosesSessions
            destinationVC.appHelpsCreateSchedule = appHelpsCreateSchedule
        }
    }
    
}

class ScheduleTypeQuestionNavigation: UINavigationController {
    
}
