//
//  ScheduleCreator.swift
//  MindAndBody
//
//  Created by Luke Smith on 11.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
// MARK: Custom Schedule Creator Day Cell
class DayCell: UITableViewCell {
    
    
    
}

//
// MARK: Schedule Creator Class
class ScheduleCreator: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var dayTable: UITableView!
    //
    let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
    var backgroundIndex = Int()
    let backgroundImageView = UIImageView()
    let backgroundBlur = UIVisualEffectView()
    
    //
    // Stack Views
    @IBOutlet weak var groupStack1: UIStackView!
    @IBOutlet weak var groupStack2: UIStackView!
    
    
    //
    // Arrays
    // The number of groups
    var nGroups = 0
    // Indicates which groups are relevant
        // GROUP INDEXES
    var groupIndexes = [Int]()
    // Both used to determin when the user has chosen a time for all sessions
    var nSessions = 0
    var sessionProgress = 0
    
    let dayArray = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday",]
    
    //
    // View did load --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setVariables()
        
        backgroundIndex = settings[0][0]
        //
        // Background Image
        backgroundImageView.frame = UIScreen.main.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        //
        if backgroundIndex < backgroundImageArray.count {
            backgroundImageView.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = colour1
        }
        //
        self.view.addSubview(backgroundImageView)
        self.view.sendSubview(toBack: backgroundImageView)
        //
        // BackgroundBlur/Vibrancy
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        //
        backgroundBlur.frame = backgroundImageView.bounds
        //
        view.insertSubview(backgroundBlur, aboveSubview: backgroundImageView)
        
        //
        // Tables
        // Day Table
        dayTable.tableFooterView = UIView()
        dayTable.separatorStyle = .singleLine
        dayTable.separatorColor = colour1.withAlphaComponent(0.15)
        dayTable.backgroundColor = .clear
        dayTable.isScrollEnabled = false
        
        
        //
        // Test tap, just there to dismiss view when testing
        let testTap = UITapGestureRecognizer()
        testTap.addTarget(self, action: #selector(dismissView))
        view.addGestureRecognizer(testTap)
    }
    
    
    //
    // Table View --------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Days
        return 7
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        //
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        cell.textLabel?.textColor = colour1
        cell.textLabel?.text = NSLocalizedString(dayArray[indexPath.row], comment: "")
        //
        // If friday, hide separayor
        if indexPath.row == 6 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //
        // Selected goal
        // Schedules
            // Note: app schedule = schedulesArray[0]
//        let schedulesArray = UserDefaults.standard.object(forKey: "schedules") as! [[[Int]]]
//        schedulesArray[0][selectedRow]
        
        // TODO: didSelectRow, set session to day
//        difficulties:
//        if i just put in ints indicating the groups into the schedules array, it might be difficult to loop through when wanting to remove a group from a day
        
    }
    
    
    //
    // MARK: Helper functions
    func setVariables() {
        let profileAnswers = UserDefaults.standard.array(forKey: "profileAnswers") as! [[Int]]
        // nGroups, groupsIndexes, nSessions
        for i in 1...profileAnswers[2].count - 1 {
            if profileAnswers[2][i] != 0 {
                nGroups += 1
                // i - 1 as totalnsession included in array
                groupIndexes.append(i - 1)
                //
                nSessions += profileAnswers[2][i]
            }
        }
    }
    
    //
    //
    func dismissView() {
        self.dismiss(animated: true)
    }

    //
    // Back Button Action
    func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
