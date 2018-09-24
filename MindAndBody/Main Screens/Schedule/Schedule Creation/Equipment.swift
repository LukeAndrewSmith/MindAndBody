//
//  ScheduleEquipment.swift
//  MindAndBody
//
//  Created by Luke Smith on 22.04.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
// MARK: Schedule Creator Week Class
class ScheduleEquipment: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //
    // MARK: Outlets --------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var equipmentTable: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonHeight: NSLayoutConstraint!
    
    // Editing
    var fromScheduleEditing = false
    
    // Stored here and not in scheudle data as images didnt want to be stored in an array
    let equiptmentArray: [[String: Any]] =
        [
            ["name": "foamRoller",
             "description": "forStretching",
             "image": #imageLiteral(resourceName: "backFoam.png")],
            ["name": "pullupBar",
             "description": "forBodyweight",
             "image": #imageLiteral(resourceName: "pullUp.png")],
            ]

    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.light
        
        setupNextButton()
        
        // Navigation Bar
        
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("equipment", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)
        
        // Table View
        equipmentTable.tableFooterView = UIView()
        equipmentTable.separatorStyle = .singleLine
        equipmentTable.separatorColor = Colors.dark
        equipmentTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    func setupNextButton() {
        // Not from schedule editing => schedule creation
        if !fromScheduleEditing {
            nextButton.backgroundColor = Colors.green
            nextButton.setTitle(NSLocalizedString("next", comment: ""), for: .normal)
            nextButton.setTitleColor(Colors.dark, for: .normal)
            nextButton.titleLabel?.font = UIFont(name: "SFUIDisplay-regular", size: 23)
            nextButton.isEnabled = true
            nextButton.alpha = 1
            nextButtonHeight.constant = 49
            
        // Schedule editing, hide button
        } else {
            nextButton.isEnabled = false
            nextButton.alpha = 0
            nextButtonHeight.constant = 0
        }
    }
    
    //
    // Table View --------------------------------------------------------------------------------------------------------
    //
    // Answers tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return equipmentTable.bounds.height / 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equiptmentArray.count
    }
    
    // ScheduleCreationHelpCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomScheduleEquipmentCell", for: indexPath) as! CustomScheduleEquipmentCell
        //
        cell.row = indexPath.row
        cell.selectionStyle = .none
        //
        // Iphone 5/SE layout
        if IPhoneType.shared.iPhoneType() == 0 {
            cell.equipmentLabel.font = UIFont(name: "SFUIDisplay-regular", size: 21)
            cell.equipmentDetail.font = Fonts.tinyElementLight
        } else {
            cell.equipmentLabel.font = UIFont(name: "SFUIDisplay-regular", size: 23)
            cell.equipmentDetail.font = UIFont(name: "SFUIDisplay-light", size: 15)
        }
        cell.equipmentLabel.textColor = Colors.dark
        cell.equipmentLabel.text = NSLocalizedString(equiptmentArray[indexPath.row]["name"] as! String, comment: "")
        //
        cell.equipmentDetail.textColor = Colors.dark
        cell.equipmentDetail.numberOfLines = 0
        cell.equipmentDetail.lineBreakMode = .byWordWrapping
        cell.equipmentDetail.text = NSLocalizedString(equiptmentArray[indexPath.row]["description"] as! String, comment: "")
        //
        cell.equipmentImage.image = equiptmentArray[indexPath.row]["image"] as? UIImage
        //
        cell.separator.backgroundColor = Colors.dark.withAlphaComponent(0.43)
        //
        return cell
    }
    
    // Finished
    @IBAction func nextButtonAction(_ sender: Any) {
        if let parentVC = self.parent as? ScheduleCreationPageController {
            parentVC.nextViewController()
        }
    }
}


//
class CustomScheduleEquipmentCell: UITableViewCell {
    //
    // Outlets
    @IBOutlet weak var equipmentImage: UIImageView!
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var equipmentDetail: UILabel!
    @IBOutlet weak var equipmentSwitch: UISwitch!
    // Custom separator set in storyboard as separators dissapear for some reason when using custom cells layoutsubviews method
    @IBOutlet weak var separator: UIView!
    
    //
    // Passed data
    // Row = indexpath.row of cell = groupIndex
    var row = Int()
    
    override func layoutSubviews() {
        // App chooses sessions switch
        equipmentSwitch.onTintColor = Colors.green
        equipmentSwitch.tintColor = Colors.red
        equipmentSwitch.backgroundColor = Colors.red
        equipmentSwitch.layer.cornerRadius = equipmentSwitch.bounds.height / 2
        equipmentSwitch.clipsToBounds = true
        //
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // Set inital value
        switch row {
        // Foam Roller
        case 0:
            // Off
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["foamRoller"] as! Int == 0 {
                equipmentSwitch.isOn = false
                // On
            } else if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["foamRoller"] as! Int == 1 {
                equipmentSwitch.isOn = true
            }
        // Pullup Bar
        case 1:
            // Off
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["pullupBar"] as! Int == 0 {
                equipmentSwitch.isOn = false
                // On
            } else if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["pullupBar"] as! Int == 1 {
                equipmentSwitch.isOn = true
            }
        default: break
        }
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        var schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        //
        switch row {
        // Foam Roller
        case 0:
            // Use
            if sender.isOn {
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["foamRoller"] = 1
            // Don't Use
            } else {
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["foamRoller"] = 0
            }
        // Pullup Bar
        case 1:
            // Use
            if sender.isOn {
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["pullupBar"] = 1
            // Don't Use
            } else {
                schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["pullupBar"] = 0
            }
        default: break
        }
        
        // Save
        UserDefaults.standard.set(schedules, forKey: "schedules")
    }
    
    
}

