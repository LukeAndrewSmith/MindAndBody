//
//  InitialProfileQuestion.swift
//  MindAndBody
//
//  Created by Luke Smith on 29.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

// A view for a quick question to the user

// TODO: DONT FORGET IMPORTANT NOTE ON HOW THE PROFILE WORKS!!!!

// I would like to:
// Fill in a profile and
// See the whole week as a list of my planned weekly sessions

class InitialProfileQuestion: UIViewController {
    
    //
    // MARK: Outlets
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fillInProfileButton: UIButton!
    @IBOutlet weak var chooseDifficultiesButton: UIButton!
    @IBOutlet weak var chooseSessionsButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var comingFromSchedule = false
    
    var selectedSchedule = 0
    
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
        titleLabel.text = NSLocalizedString("profileQuestion", comment: "")
        titleLabel.textColor = Colours.colour1
        //
        // Buttons
        fillInProfileButton.titleLabel?.lineBreakMode = .byWordWrapping
        fillInProfileButton.setTitle(NSLocalizedString("profileQuestion1", comment: ""), for: .normal)
        fillInProfileButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        fillInProfileButton.setTitleColor(Colours.colour1, for: .normal)
        //
        chooseDifficultiesButton.titleLabel?.lineBreakMode = .byWordWrapping
        chooseDifficultiesButton.setTitle(NSLocalizedString("profileQuestion2", comment: ""), for: .normal)
        chooseDifficultiesButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        chooseDifficultiesButton.setTitleColor(Colours.colour1, for: .normal)
        //
        chooseSessionsButton.titleLabel?.lineBreakMode = .byWordWrapping
        chooseSessionsButton.setTitle(NSLocalizedString("profileQuestion3", comment: ""), for: .normal)
        chooseSessionsButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        chooseSessionsButton.setTitleColor(Colours.colour1, for: .normal)
        
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
    @IBAction func fillInProfileButtonAction(_ sender: Any) {
        //        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        //        // Set user settings for schedule style to week
        //        schedules[selectedSchedule][9][0] = 0
        //        UserDefaults.standard.set(schedules, forKey: "schedules")
        self.performSegue(withIdentifier: "InitialProfileSegue", sender: self)
    }
    
    // Week
    @IBAction func chooseDifficultiesButtonAction(_ sender: Any) {
        // If app schedule, go to week
        //        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        //        // Set user settings for schedule style to week
        //        schedules[selectedSchedule][9][0] = 1
        //        UserDefaults.standard.set(schedules, forKey: "schedules")
        //        if selectedSchedule == 0 {
        //            //
        //            ScheduleVariables.shared.shouldReloadSchedule = true
        //            self.dismiss(animated: true)
        //            // If custom schedule, go to schedule creator
        //        } else {
        self.performSegue(withIdentifier: "InitialProfileSegue", sender: self)
        //        }
    }
    
    @IBAction func chooseSessionsButtonAction(_ sender: Any) {
        //
        self.dismiss(animated: true)
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
    
    //
    // Override segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "InitialProfileSegue" {
            let destinationVC = segue.destination as! InitialProfile
            if comingFromSchedule == true {
                destinationVC.comingFromSchedule = true
            }
        }
        
    }
    
}


class InitialProfileNavigation: UINavigationController {
    
}

