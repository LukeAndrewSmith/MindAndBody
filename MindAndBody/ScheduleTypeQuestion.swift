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
class ScheduleTypeQuestion: UIViewController {
    
    //
    // MARK: Outlets
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    // Options
        // first app/custom = does the app help you create the schedule
        // seconds app/custom = does that app select the sessions for you
    @IBOutlet weak var appAppButton: UIButton!
    @IBOutlet weak var appCustomButton: UIButton!
    @IBOutlet weak var customAppButton: UIButton!
    @IBOutlet weak var customCustomButton: UIButton!
    //
    @IBOutlet weak var backButton: UIButton!
    
    var comingFromSchedule = false
    
    var selectedSchedule = 0
    
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Layout
        layoutButtons()
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
        
        // Selected schedule
        // TODO: IS THIS CORRECT?????
            // Not sure should be called here anymore
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
    // Layou buttons
    func layoutButtons() {
        //
        // Titles
        // appApp
        appAppButton.titleLabel?.lineBreakMode = .byWordWrapping
        appAppButton.setTitle(NSLocalizedString("appApp", comment: ""), for: .normal)
        appAppButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        appAppButton.setTitleColor(Colours.colour1, for: .normal)
        appAppButton.contentHorizontalAlignment = .left
        appAppButton.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0)
        // appCustom
        appCustomButton.titleLabel?.lineBreakMode = .byWordWrapping
        appCustomButton.setTitle(NSLocalizedString("appCustom", comment: ""), for: .normal)
        appCustomButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        appCustomButton.setTitleColor(Colours.colour1, for: .normal)
        appCustomButton.contentHorizontalAlignment = .left
        appCustomButton.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0)
        // customApp
        customAppButton.titleLabel?.lineBreakMode = .byWordWrapping
        customAppButton.setTitle(NSLocalizedString("customApp", comment: ""), for: .normal)
        customAppButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        customAppButton.setTitleColor(Colours.colour1, for: .normal)
        customAppButton.contentHorizontalAlignment = .left
        customAppButton.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0)
        // customCustom
        customCustomButton.titleLabel?.lineBreakMode = .byWordWrapping
        customCustomButton.setTitle(NSLocalizedString("customCustom", comment: ""), for: .normal)
        customCustomButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        customCustomButton.setTitleColor(Colours.colour1, for: .normal)
        customCustomButton.contentHorizontalAlignment = .left
        customCustomButton.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0)

    }
    
    //
    // MARK: Button actions
    // appApp
    @IBAction func appAppButtonAction(_ sender: Any) {
        // Set app style
        self.performSegue(withIdentifier: "ScheduleCreationProfileSegue", sender: self)
    }
    
    // appCustom
    @IBAction func appCustomButtonAction(_ sender: Any) {
        // Set app style
        self.performSegue(withIdentifier: "ScheduleCreationProfileSegue", sender: self)
    }
    
    // customApp
    @IBAction func customAppButtonAction(_ sender: Any) {
        // Set app style
        self.performSegue(withIdentifier: "ScheduleCreationCustomSegue", sender: self)
    }
    
    // customCustom
    @IBAction func customCustomButtonAction(_ sender: Any) {
        // Set app style
        self.performSegue(withIdentifier: "ScheduleCreationCustomSegue", sender: self)
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
        if segue.identifier == "ProfileSegue" {
            let destinationVC = segue.destination as! Profile
            if comingFromSchedule == true {
                destinationVC.comingFromSchedule = true
            }
        }
        
    }
    
}
