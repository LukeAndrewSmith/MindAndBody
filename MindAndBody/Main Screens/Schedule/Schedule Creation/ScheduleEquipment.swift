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
    @IBOutlet weak var sectionLabel: UILabel!
    //
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    // If schedule is being created
    var isScheduleCreation = false
    
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
        //
        UIApplication.shared.statusBarStyle = .lightContent
        //
        sectionLabel.text = NSLocalizedString("equipment", comment: "")
        //
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: true)
        //
        // Table View
        equipmentTable.tableFooterView = UIView()
        equipmentTable.separatorColor = UIColor.white.withAlphaComponent(0.25)
        equipmentTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        equipmentTable.backgroundColor = .clear
        equipmentTable.isScrollEnabled = false
        
        //
        // Done
        doneButton.backgroundColor = Colors.green.withAlphaComponent(0.25)
        doneButton.setTitle(NSLocalizedString("done", comment: ""), for: .normal)
        
        //
        // Back
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
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
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.row = indexPath.row
        cell.selectionStyle = .none
        //
        cell.equipmentLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        cell.equipmentLabel.textColor = Colors.light
        cell.equipmentLabel.text = NSLocalizedString(equiptmentArray[indexPath.row]["name"] as! String, comment: "")
        //
        cell.equipmentDetail.font = UIFont(name: "SFUIDisplay-thin", size: 15)
        cell.equipmentDetail.textColor = Colors.light
        cell.equipmentDetail.numberOfLines = 0
        cell.equipmentDetail.lineBreakMode = .byWordWrapping
        cell.equipmentDetail.text = NSLocalizedString(equiptmentArray[indexPath.row]["description"] as! String, comment: "")
        //
        cell.equipmentImage.image = equiptmentArray[indexPath.row]["image"] as! UIImage
        //
        return cell
    }
    
    //
    // Done
    @IBAction func doneButtonAction(_ sender: Any) {
        // If schedule is being created, dismiss, as this was last question
        if isScheduleCreation {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //
    // Back
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //
    // MARK: Back Swipe
    @IBAction func edgeGestureRight(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "ScheduleHelpCreationSegue" {
            let destinationVC = segue.destination as! ScheduleCreator
            destinationVC.fromScheduleEditing = true
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
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["schedules"])
    }
    
    
}

