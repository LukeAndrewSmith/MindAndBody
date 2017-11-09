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
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    //
    @IBOutlet weak var ScheduleTypeQuestionTable: UITableView!
    var scheduleOptionSwitch = UISwitch()
    var sessionsOptionSwitch = UISwitch()
    //
    @IBOutlet weak var backButton: UIButton!
    
    var comingFromSchedule = false
        
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Layout
        layoutView()
        //
        // Background Image/Colour
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            backgroundImage.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
            //
            backgroundImage.image = nil
            backgroundImage.backgroundColor = Colours.colour1
        }
        // Blur
        // BackgroundBlur/Vibrancy
        let backgroundBlur = UIVisualEffectView()
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        backgroundBlur.frame = backgroundImage.bounds
        if backgroundIndex > BackgroundImages.backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
        }
        
        //
        // Title Label
        titleLabel.text = NSLocalizedString("scheduleTypeQuestion", comment: "")
        titleLabel.textColor = Colours.colour1
        
        // Selected schedule
        ScheduleVariables.shared.selectedSchedule = settings[7][0]
        
        //
        // Back
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
        
        if comingFromSchedule == true {
            backButton.imageView?.image = #imageLiteral(resourceName: "Down")
            backButton.tintColor = Colours.colour4
        } else {
            backButton.imageView?.image = #imageLiteral(resourceName: "Back Arrow")
            backButton.tintColor = Colours.colour4
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
            titleLabel.textColor = Colours.colour1
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.frame = CGRect(x: 24, y: 0, width: cell.bounds.width - 24 - scheduleOptionSwitch.bounds.width - 16 - 8, height: cellHeight)
            cell.addSubview(titleLabel)
            //
            cell.addSubview(scheduleOptionSwitch)
            scheduleOptionSwitch.center = CGPoint(x: view.bounds.width - (scheduleOptionSwitch.bounds.width / 2) - 16, y: cellHeight / 2)
            // Separator
            let separator = UIView()
            separator.backgroundColor = Colours.colour1.withAlphaComponent(0.5)
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
            titleLabel.textColor = Colours.colour1
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.frame = CGRect(x: 24, y: 0, width: cell.bounds.width - 24 - scheduleOptionSwitch.bounds.width - 16 - 8, height: cellHeight)
            cell.addSubview(titleLabel)
            //
            cell.addSubview(sessionsOptionSwitch)
            sessionsOptionSwitch.center = CGPoint(x: view.bounds.width - (scheduleOptionSwitch.bounds.width / 2) - 16, y: cellHeight / 2)
        // Create Schedule Row
        } else if indexPath.row == 2 {
            cell.backgroundColor = Colours.colour3.withAlphaComponent(0.25)
            cell.textLabel?.text = NSLocalizedString("createSchedule", comment: "")
            cell.textLabel?.textColor = Colours.colour1
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            cell.textLabel?.textAlignment = .center
        }
        return cell
    }
    
    //
    var okAction = UIAlertAction()
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Check if user has filled in profile
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [Int]
        var userHasFilledInProfile = true
        // Loop profile answers
        for i in 0...profileAnswers.count - 1 {
            if profileAnswers[i] == -1 {
                userHasFilledInProfile = false
            }
        }
        
        //
        if indexPath.row == 2 {
            //
            // Alert and Functions
            let inputTitle = NSLocalizedString("scheduleInputTitle", comment: "")
            //
            let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
            alert.view.tintColor = Colours.colour2
            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
            //2. Add the text field
            alert.addTextField { (textField: UITextField) in
                textField.text = " "
                textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
                textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
            }
            // 3. Get the value from the text field, and perform actions upon OK press
            okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
                var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
                //
                // Append new schedule array to schedules
                schedules.append(scheduleDataStructures.emptyWeek)
                scheduleTracking.append(scheduleDataStructures.emptyTrackingWeek)
                //
                // Update Title
                let textField = alert?.textFields![0]
                let lastIndex = schedules.count - 1
                schedules[lastIndex][1][0][0] = textField?.text!
                //
                // SET NEW ARRAY
                UserDefaults.standard.set(schedules, forKey: "schedules")
                UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
                
                // Set selected schedule to newly created schedule (last schedule in schedules)
                var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                settings[7][0] = schedules.count - 1
                ScheduleVariables.shared.selectedSchedule = settings[7][0]
                UserDefaults.standard.set("userSettings", forKey: "")
                
                //
                ScheduleVariables.shared.shouldReloadSchedule = true
                 
                // PERFORM SEGUE
                //
                // App helps create schedule
                if schedules[ScheduleVariables.shared.selectedSchedule][1][3][0] as! Int == 0 {
                    if userHasFilledInProfile == false {
                        self.performSegue(withIdentifier: "ScheduleQuestionProfileSegue", sender: self)
                    } else {
                        self.performSegue(withIdentifier: "ScheduleQuestionHelpSegue", sender: self)
                    }
                // Custom Schedule
                } else if schedules[ScheduleVariables.shared.selectedSchedule][1][3][0] as! Int == 1 {
                    self.performSegue(withIdentifier: "ScheduleQuestionCustomSegue", sender: self)
                }
            })
            okAction.isEnabled = false
            alert.addAction(okAction)
            // Cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alert.addAction(cancelAction)
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
        scheduleOptionSwitch.onTintColor = Colours.colour3
        scheduleOptionSwitch.addTarget(self, action: #selector(scheduleOptionSwitchAction), for: .valueChanged)
        scheduleOptionSwitch.isOn = true
        sessionsOptionSwitch.onTintColor = Colours.colour3
        sessionsOptionSwitch.addTarget(self, action: #selector(sessionsOptionSwitchAction), for: .valueChanged)
        sessionsOptionSwitch.isOn = true
    }
    
    //
    // Switch handlers
    // Schedule option
    @objc func scheduleOptionSwitchAction(_ sender: UISwitch) {
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        if sender.isOn == true {
            schedules[ScheduleVariables.shared.selectedSchedule][1][3][0] = 0
        } else if sender.isOn == false {
            schedules[ScheduleVariables.shared.selectedSchedule][1][3][0] = 1
        }
        UserDefaults.standard.set(schedules, forKey: "schedules")
    }
    // Sessions option
    @objc func sessionsOptionSwitchAction(_ sender: UISwitch) {
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        if sender.isOn == true {
            schedules[ScheduleVariables.shared.selectedSchedule][1][2][0] = 0
        } else if sender.isOn == false {
            schedules[ScheduleVariables.shared.selectedSchedule][1][2][0] = 1
        }
        UserDefaults.standard.set(schedules, forKey: "schedules")
    }

    //
    // Back Button
    @IBAction func backButtonAction(_ sender: Any) {
        if comingFromSchedule == false {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
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
