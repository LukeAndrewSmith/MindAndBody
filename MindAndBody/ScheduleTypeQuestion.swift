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

// TODO: DONT FORGET IMPORTANT NOTE ON HOW THE PROFILE WORKS!!!!

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
class ScheduleTypeQuestion: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    //
    @IBOutlet weak var ScheduleTypeQuestionTable: UITableView!
    var scheduleOptionSwitch = UISwitch()
    var sessionsOptionSwitch = UISwitch()
    //
    @IBOutlet weak var backButton: UIButton!
    
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
            var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[[[Any]]]]
            var scheduleTracking = UserDefaults.standard.object(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
            //
            // Delete if not plus row
            // Update arrays
            schedules.remove(at: ScheduleVariables.shared.selectedSchedule)
            scheduleTracking.remove(at: ScheduleVariables.shared.selectedSchedule)
            UserDefaults.standard.set(schedules, forKey: "schedules")
            UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
            
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
            ICloudFunctions.shared.pushToICloud(toSync: ["schedules", "scheduleTracking", "selectedSchedule"])
        }
        
    }
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Layout
        layoutView()
        //
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: true)
        
        //
        // Title Label
        titleLabel.text = NSLocalizedString("scheduleTypeQuestion", comment: "")
        titleLabel.textColor = Colors.light
        
        //
        // Back
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
        
        if comingFromSchedule {
            backButton.imageView?.image = #imageLiteral(resourceName: "Down")
            backButton.tintColor = Colors.red
        } else {
            backButton.imageView?.image = #imageLiteral(resourceName: "Back Arrow")
            backButton.tintColor = Colors.red
        }
    }
    
    //
    // MARK: tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Create Schedule Row
        if indexPath.row == 2 {
            return 49
        // Option rows
        } else {
            return (ScheduleTypeQuestionTable.bounds.height - 49) / 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let cellHeight = (ScheduleTypeQuestionTable.bounds.height - 49) / 2
        // Schedule Option
        if indexPath.row == 0 {
            cell.backgroundColor = .clear
            cell.backgroundView = UIView()
            cell.selectionStyle = .none
            let titleLabel = UILabel()
            titleLabel.text = NSLocalizedString("scheduleOptionText", comment: "")
            titleLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            titleLabel.textColor = Colors.light
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.frame = CGRect(x: 24, y: 0, width: cell.bounds.width - 24 - scheduleOptionSwitch.bounds.width - 16 - 8, height: cellHeight)
            cell.addSubview(titleLabel)
            //
            cell.addSubview(scheduleOptionSwitch)
            scheduleOptionSwitch.center = CGPoint(x: view.bounds.width - (scheduleOptionSwitch.bounds.width / 2) - 16, y: cellHeight / 2)
            // Separator
            let separator = UIView()
            separator.backgroundColor = Colors.light.withAlphaComponent(0.5)
            separator.frame.size = CGSize(width: view.bounds.width - 32, height: 1)
            separator.center = CGPoint(x: view.center.x, y: cellHeight)
            cell.addSubview(separator)
            
        // Sessions Option
        } else if indexPath.row == 1 {
            cell.backgroundColor = .clear
            cell.backgroundView = UIView()
            cell.selectionStyle = .none
            let titleLabel = UILabel()
            titleLabel.text = NSLocalizedString("sessionsOptionText", comment: "")
            titleLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            titleLabel.textColor = Colors.light
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.frame = CGRect(x: 24, y: 0, width: cell.bounds.width - 24 - scheduleOptionSwitch.bounds.width - 16 - 8, height: cellHeight)
            cell.addSubview(titleLabel)
            //
            cell.addSubview(sessionsOptionSwitch)
            sessionsOptionSwitch.center = CGPoint(x: view.bounds.width - (scheduleOptionSwitch.bounds.width / 2) - 16, y: cellHeight / 2)
        // Create Schedule Row
        } else if indexPath.row == 2 {
            cell.backgroundColor = Colors.green.withAlphaComponent(0.25)
            cell.textLabel?.text = NSLocalizedString("createSchedule", comment: "")
            cell.textLabel?.textColor = Colors.light
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            cell.textLabel?.textAlignment = .center
        }
        return cell
    }
    
    //
    var okAction = UIAlertAction()
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        if indexPath.row == 2 {
            //
            // Alert and Functions
            let inputTitle = NSLocalizedString("scheduleInputTitle", comment: "")
            //
            let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
            alert.view.tintColor = Colors.dark
            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
            //2. Add the text field
            alert.addTextField { (textField: UITextField) in
                textField.text = " "
                textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
                textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
            }
            // 3. Get the value from the text field, and perform actions upon OK press
            okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[[[Any]]]]
                var scheduleTracking = UserDefaults.standard.object(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
                //
                // Append new schedule array to schedules
                schedules.append(scheduleDataStructures.emptyWeek)
                scheduleTracking.append(scheduleDataStructures.emptyTrackingWeek)
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
                schedules[lastIndex][1][0][0] = title
                //
                // Update schedule settings settings based on switches
                // Schedule type option option
                if self.scheduleOptionSwitch.isOn {
                    schedules[ScheduleVariables.shared.selectedSchedule][1][3][0] = 0
                } else if self.scheduleOptionSwitch.isOn == false {
                    schedules[ScheduleVariables.shared.selectedSchedule][1][3][0] = 1
                }
                // Sessions choice option
                if self.sessionsOptionSwitch.isOn {
                    schedules[ScheduleVariables.shared.selectedSchedule][1][2][0] = 0
                } else if self.sessionsOptionSwitch.isOn == false {
                    schedules[ScheduleVariables.shared.selectedSchedule][1][2][0] = 1
                }
                //
                // SET NEW ARRAY
                UserDefaults.standard.set(schedules, forKey: "schedules")
                UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["selectedSchedule", "schedules", "scheduleTracking"])
                //
                // Indicate that new schedule has been created
                ScheduleVariables.shared.didCreateNewSchedule = true
                //                 
                self.performSegueFunction()
            })
            okAction.isEnabled = false
            alert.addAction(okAction)
            // Cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alert.addAction(cancelAction)
            // 4. Present the alert
            if didCreateNewSchedule == false {
                self.present(alert, animated: true, completion: nil)
            //
            // If schedule just been created but user goes back to change something, doesn;t create new schedule
            } else {
               performSegueFunction()
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Segues
    func performSegueFunction() {
        // Check if user has filled in profile
        let profileAnswers = UserDefaults.standard.object(forKey: "profileAnswers") as! [Int]
        var userHasFilledInProfile = true
        // Loop profile answers
        for i in 0...profileAnswers.count - 1 {
            if profileAnswers[i] == -1 {
                userHasFilledInProfile = false
                break
            }
        }
        // Perform relevant segue
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[[[Any]]]]
        // PERFORM SEGUE
        // App helps create schedule
        if schedules[ScheduleVariables.shared.selectedSchedule][1][3][0] as! Int == 0 {
            // App chooses sessions
            if schedules[ScheduleVariables.shared.selectedSchedule][1][2][0] as! Int == 0 && userHasFilledInProfile == false {
                // Goes to profile
                self.performSegue(withIdentifier: "ScheduleQuestionProfileSegue", sender: self)
            // User chooses sessions
            } else {
                // Goes to schedule creation help
                self.performSegue(withIdentifier: "ScheduleQuestionHelpSegue", sender: self)
            }
        // Custom Schedule
        } else if schedules[ScheduleVariables.shared.selectedSchedule][1][3][0] as! Int == 1 {
            // App chooses sessions
            if schedules[ScheduleVariables.shared.selectedSchedule][1][2][0] as! Int == 0 && userHasFilledInProfile == false {
                // Goes to profile
                self.performSegue(withIdentifier: "ScheduleQuestionProfileSegue", sender: self)
            // User chooses sessions
            } else {
                // Goes to schedule view type question
                self.performSegue(withIdentifier: "ScheduleQuestionCustomSegue", sender: self)
            }
            
        }
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
    // Layout buttons
    func layoutView() {
        // Table
        ScheduleTypeQuestionTable.backgroundView = UIView()
        ScheduleTypeQuestionTable.backgroundColor = .clear
        ScheduleTypeQuestionTable.separatorStyle = .none
        ScheduleTypeQuestionTable.isScrollEnabled = false
        // Switches
        scheduleOptionSwitch.onTintColor = Colors.green
        scheduleOptionSwitch.isOn = true
        scheduleOptionSwitch.tintColor = Colors.red
        scheduleOptionSwitch.backgroundColor = Colors.red
        scheduleOptionSwitch.layer.cornerRadius = scheduleOptionSwitch.bounds.height / 2
        scheduleOptionSwitch.clipsToBounds = true
        sessionsOptionSwitch.onTintColor = Colors.green
        sessionsOptionSwitch.isOn = true
        sessionsOptionSwitch.tintColor = Colors.red
        sessionsOptionSwitch.backgroundColor = Colors.red
        sessionsOptionSwitch.layer.cornerRadius = scheduleOptionSwitch.bounds.height / 2
        sessionsOptionSwitch.clipsToBounds = true
    }
    
    //
    //
    // Back Button
    @IBAction func backButtonAction(_ sender: Any) {
        if comingFromSchedule {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    //
    // MARK: Back Swipe
    @IBAction func edgeGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //
    // Override segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }
    
}

class ScheduleTypeQuestionNavigation: UINavigationController {
    
}
