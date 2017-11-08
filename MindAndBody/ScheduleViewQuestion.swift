//
//  ScheduleView.swift
//  MindAndBody
//
//  Created by Luke Smith on 23.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

// A view for a quick question asking wether the user would like to see their

// I would like to:
    // Create a weekly schedule, and each day of the week see the current day and what I have planned to do on that day
    // See the whole week as a list of my planned weekly sessions

class ScheduleViewQuestion: UIViewController {
    
    //
    // MARK: Outlets
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayViewButton: UIButton!
    @IBOutlet weak var weekViewButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var comingFromSchedule = false
    
    var selectedSchedule = 0
    
    var wasDayView = false
        
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
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
        titleLabel.text = NSLocalizedString("scheduleView", comment: "")
        titleLabel.textColor = Colours.colour1
        //
        // Buttons
        dayViewButton.titleLabel?.lineBreakMode = .byWordWrapping
        dayViewButton.setTitle(NSLocalizedString("scheduleView1", comment: ""), for: .normal)
        dayViewButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        dayViewButton.setTitleColor(Colours.colour1, for: .normal)
        //
        weekViewButton.titleLabel?.lineBreakMode = .byWordWrapping
        weekViewButton.setTitle(NSLocalizedString("scheduleView2", comment: ""), for: .normal)
        weekViewButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        weekViewButton.setTitleColor(Colours.colour1, for: .normal)
        
        // Selected schedule
        selectedSchedule = settings[7][0]
        
        //
        // Back
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
        
        if comingFromSchedule == true {
            backButton.alpha = 0
            backButton.isEnabled = false
        }
    }
    
    //
    // MARK: Button actions
    // Day
    @IBAction func dayButtonAction(_ sender: Any) {
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        // Set user settings for schedule style to week
        schedules[selectedSchedule][1][1][0] = 0
        UserDefaults.standard.set(schedules, forKey: "schedules")
        self.performSegue(withIdentifier: "ScheduleCreatorSegue", sender: self)
    }
    
    // Week
    @IBAction func weekButtonAction(_ sender: Any) {
        // If app schedule, go to week
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[[Any]]]]
        // Check if it was day view before
        if schedules[selectedSchedule][1][1][0] as! Int == 0 {
            wasDayView = true
        } else if schedules[selectedSchedule][1][1][0] as! Int == 1 {
            wasDayView = false
        }
        // Set user settings for schedule style to week
        schedules[selectedSchedule][1][1][0] = 1
        UserDefaults.standard.set(schedules, forKey: "schedules")
        if selectedSchedule == 0 {
            //
            ScheduleVariables.shared.shouldReloadSchedule = true
            self.dismiss(animated: true)
        // If custom schedule, go to schedule creator
        } else {
            self.performSegue(withIdentifier: "ScheduleCreatorSegue", sender: self)
        }
    }
    
    //
    // Back Button
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "ScheduleCreatorSegue" {
            let destinationVC = segue.destination as? ScheduleCreator
            destinationVC?.wasDayView = wasDayView
            //
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
    
}
