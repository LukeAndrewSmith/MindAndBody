//
//  ScheduleCreatorWeek.swift
//  MindAndBody
//
//  Created by Luke Smith on 09.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
// MARK: Schedule Creator Week Class
class ScheduleCreatorWeek: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //
    // MARK: Outlets --------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var weekTable: UITableView!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    //
    @IBOutlet weak var backButton: UIButton!
    
    //
    var comingFromScheduleEditing = false

    
    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        UIApplication.shared.statusBarStyle = .lightContent
        //
        sectionLabel.text = NSLocalizedString("week", comment: "")
        //
        // Background Image/Colour
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            backgroundImageView.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = Colours.colour1
        }
        // Blur
        // BackgroundBlur/Vibrancy
        let backgroundBlur = UIVisualEffectView()
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        backgroundBlur.frame = backgroundImageView.bounds
        if backgroundIndex > BackgroundImages.backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImageView)
        }
        //
        // Table View
        weekTable.tableFooterView = UIView()
        weekTable.separatorStyle = .none
        weekTable.backgroundColor = .clear
        weekTable.isScrollEnabled = false
        
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
        return weekTable.bounds.height / CGFloat(scheduleDataStructures.groupNames.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleDataStructures.groupNames.count
    }
    
    // ScheduleCreationHelpCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomScheduleWeekCell", for: indexPath) as! CustomScheduleWeekCell
        //
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.row = indexPath.row
        
        //
        return cell
    }
    
    
    //
    // Dismiss View
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
class CustomScheduleWeekCell: UITableViewCell {
    //
    // Outlets
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var sessionsLabel: UILabel!
    
    //
    // Passed data
    var row = Int()
    
    //
    // Layout/data
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        groupLabel.text = NSLocalizedString(scheduleDataStructures.groupNames[row], comment: "")
        //
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        var groupArray = [0,0,0,0,0]
        // Create array of nsession of groups from full week array in schedule ([0][7])
        if schedules[ScheduleVariables.shared.selectedSchedule][0][7].count != 0 {
            for i in 0...schedules[ScheduleVariables.shared.selectedSchedule][0][7].count - 1 {
                groupArray[schedules[ScheduleVariables.shared.selectedSchedule][0][7][i] as! Int] += 1
            }
        }
        sessionsLabel.text = String(groupArray[row])
    }
    
    //
    // Increment Buttons
    @IBAction func increaseButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func decreaseButtonAction(_ sender: Any) {
        
    }
    
    
}
