//
//  FinalChoiceCustom.swift
//  MindAndBody
//
//  Created by Luke Smith on 18.08.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class CustomChoice: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var comingFromSchedule = false
    
    
    
    
    // Navigation bar titles
    let navigationBarTitles: [String: String] = [
        "warmup": "customWarmup",
        "workout": "customWorkout",
        "cardio": "customHIITCardioSession",
        "stretching": "customStretchingSession",
        "yoga": "customYogaPractice"
    ]
    
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    //
    // MARK: Table View
    //
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        return 1
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        return customSessionsArray[SelectedSession.shared.selectedSession[0]]!.count + 1
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        var cell = UITableViewCell()
        cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        //
        // Retreive Preset Sessions
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = Colors.light
        cell.textLabel?.textColor = Colors.dark
        cell.tintColor = Colors.dark
        //
        cell.textLabel?.text = customSessionsArray[SelectedSession.shared.selectedSession[0]]![indexPath.row]["name"]![0] as? String
        //
        return cell
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        return 144
    }
    
    //
    var okAction = UIAlertAction()
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
//        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
//        
//        //
//        // Add Custom Workout
//        if indexPath.row == customSessionsArray[SelectedSession.shared.selectedSession[0]]?.count {
//            
//            ActionSheet.shared.actionSheetBackgroundView.isHidden = true
//            
//            // Alert and Functions
//            //
//            let inputTitle = NSLocalizedString("sessionInputTitle", comment: "")
//            //
//            let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
//            alert.view.tintColor = Colors.dark
//            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
//            //2. Add the text field
//            alert.addTextField { (textField: UITextField) in
//                textField.text = " "
//                textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
//                textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
//            }
//            // 3. Get the value from the text field, and perform actions upon OK press
//            okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//                //
//                // Append relevant (to SelectedSession.shared.selectedSession[0]) new array to customSessionsArray
//                switch SelectedSession.shared.selectedSession[0] {
//                // Warmup, Workout,
//                case "warmup", "workout":
//                    customSessionsArray[SelectedSession.shared.selectedSession[0]]!.append(Register.emptySessionFour)
//                case "cardio", "stretching", "yoga":
//                    customSessionsArray[SelectedSession.shared.selectedSession[0]]!.append(Register.emptySessionThree)
//                //
//                default:
//                    break
//                }
//                //
//                // Update Title
//                let textField = alert?.textFields![0]
//                let lastIndex = (customSessionsArray[SelectedSession.shared.selectedSession[0]]?.count)! - 1
//                let title = textField?.text!
//                customSessionsArray[SelectedSession.shared.selectedSession[0]]![lastIndex]["name"]![0] = title
//                //
//                // Default mumber of rounds if relevant
//                if SelectedSession.shared.selectedSession[0] == "workout" {
//                    self.nRoundsButton.setTitle(NSLocalizedString("numberOfRounds", comment: "") + "1", for: .normal)
//                }
//                //
//                // SET NEW ARRAY
//                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
//                // Sync
//                ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
//                //
//                // Select new session and dismiss
//                let selectedIndexPath = NSIndexPath(row: lastIndex, section: 0)
//                self.presetsTableView.selectRow(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
//                self.selectedPreset = lastIndex
//                //
//                //
//                // Presets title
//                let string = customSessionsArray[SelectedSession.shared.selectedSession[0]]![self.selectedPreset]["name"]![0] as! String
//                self.presetsButton.setTitle("- " + string + " -", for: .normal)
//                
//                //
//                self.presetsTableView.reloadData()
//                //
//                tableView.deselectRow(at: indexPath, animated: true)
//                // Reload
//                self.customTableView.reloadData()
//                self.beginButtonEnabled()
//                //
//                // Element Positions
//                if IPhoneType.shared.iPhoneType() == 2 {
//                    self.presetsBottom.constant = self.view.frame.size.height - 73.5 - ControlBarHeights.homeIndicatorHeight
//                } else {
//                    self.presetsBottom.constant = self.view.frame.size.height - 73.5
//                }
//                self.tableViewConstraintTop.constant = 122.5
//                self.tableViewConstraintBottom.constant = 49
//                self.beginButtonConstraint.constant = 0
//                //
//                // Dismiss presets table
//                ActionSheet.shared.actionSheetBackgroundView.isHidden = false
//                ActionSheet.shared.actionSheetBackgroundView.removeFromSuperview()
//                //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
//                //                        ActionSheet.shared.animateActionSheetDown()
//                UIView.animate(withDuration: AnimationTimes.animationTime3, animations: {
//                    self.view.layoutIfNeeded()
//                }, completion: nil)
//                //                    })
//            })
//            okAction.isEnabled = false
//            alert.addAction(okAction)
//            // Cancel reset action
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
//                UIAlertAction in
//                //
//                ActionSheet.shared.actionSheetBackgroundView.isHidden = false
//            }
//            alert.addAction(cancelAction)
//            // 4. Present the alert.
//            self.present(alert, animated: true, completion: nil)
//            //
//            //
//            // Select Custom Workout
//        } else {
//            //
//            selectedPreset = indexPath.row
//            //
//            // NUMBER OF ROUNDS title
//            if SelectedSession.shared.selectedSession[0] == "workout" {
//                // Rounds
//                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedPreset]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedPreset]["setsBreathsTime"]![1] as! Int == -1 {
//                    //
//                    nRoundsButton.setTitle(NSLocalizedString("numberOfRounds", comment: "") + String(customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedPreset]["setsBreathsTime"]![0] as! Int), for: .normal)
//                    // No rounds
//                } else {
//                    nRoundsButton.setTitle(NSLocalizedString("numberOfRounds", comment: "") + "1", for: .normal)
//                }
//            }
//            //
//            if selectedPreset == -1 {
//                self.presetsButton.setTitle(NSLocalizedString(self.presetsButtonTitles[SelectedSession.shared.selectedSession[0]]!, comment: ""), for: .normal)
//            } else {
//                let string = customSessionsArray[SelectedSession.shared.selectedSession[0]]![self.selectedPreset]["name"]![0] as! String
//                self.presetsButton.setTitle("- " + string + " -", for: .normal)
//                
//            }
//            //
//            tableView.deselectRow(at: indexPath, animated: true)
//            //
//            customTableView.reloadData()
//            //
//        }
//        //
        //
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
    // MARK: TableView Editing
    //
    // Can edit row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        switch tableView {
        case presetsTableView:
            
            //
            if indexPath.row < (customSessionsArray[SelectedSession.shared.selectedSession[0]]?.count)! {
                return true
            }
        case movementsTableView: return false
        case customTableView:
            //
            if customSessionsArray[SelectedSession.shared.selectedSession[0]]?.count == 0 || customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedPreset]["movements"]!.count == 0 {
                return false
            } else {
                if indexPath.row == customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedPreset]["movements"]!.count {
                    return false
                } else {
                    return true
                }
            }
        default: return false
        }
        return false
    }
    
    // Delete button title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        //
        if tableView == customTableView {
            return NSLocalizedString("remove", comment: "")
        } else {
            return NSLocalizedString("delete", comment: "")
        }
    }
    
    // Commit editing style
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        if editingStyle == UITableViewCellEditingStyle.delete {
            
                // New array
                customSessionsArray[SelectedSession.shared.selectedSession[0]]!.remove(at: indexPath.row)
                UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
                //
                UIView.animate(withDuration: 0.2, animations: {
                    self.presetsTableView.reloadData()
                })
                //
                self.selectedPreset = -1
                self.customTableView.reloadData()
                self.beginButtonEnabled()
                //
                UIView.animate(withDuration: 0.2, animations: {
                    self.presetsTableView.reloadData()
                    //
                    if self.selectedPreset == -1 {
                        self.presetsButton.setTitle(NSLocalizedString(self.presetsButtonTitles[SelectedSession.shared.selectedSession[0]]!, comment: ""), for: .normal)
                    } else {
                        let string = customSessionsArray[SelectedSession.shared.selectedSession[0]]![self.selectedPreset]["name"]![0] as! String
                        self.presetsButton.setTitle("- " + string + " -", for: .normal)
                    }
                })
                //
                self.presetsTableView.isHidden = false
                //
                self.presetsTableView.reloadData()
                //
                // Reload Data
                self.customTableView.reloadData()
                self.beginButtonEnabled()
                //
                // Initial Element Positions
                if IPhoneType.shared.iPhoneType() == 2 {
                    presetsBottom.constant = -ControlBarHeights.homeIndicatorHeight
                } else {
                    presetsBottom.constant = 0
                }
                
                self.tableViewConstraintTop.constant = self.view.frame.size.height + ControlBarHeights.homeIndicatorHeight
                self.tableViewConstraintBottom.constant = -49 - ControlBarHeights.homeIndicatorHeight
                self.beginButtonConstraint.constant = -49 - ControlBarHeights.homeIndicatorHeight
                
        }
    }
    
}
