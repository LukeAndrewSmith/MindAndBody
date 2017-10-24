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
    
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // Background Image/Colour
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        if backgroundIndex < backgroundImageArray.count {
            backgroundImage.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImage.image = nil
            backgroundImage.backgroundColor = colour1
        }
        // Blur
        // BackgroundBlur/Vibrancy
        let backgroundBlur = UIVisualEffectView()
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        backgroundBlur.frame = backgroundImage.bounds
        if backgroundIndex > backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
        }
        
        //
        // Title Label
        titleLabel.text = NSLocalizedString("scheduleView", comment: "")
        titleLabel.textColor = colour1
        //
        // Buttons
        dayViewButton.titleLabel?.lineBreakMode = .byWordWrapping
        dayViewButton.setTitle(NSLocalizedString("scheduleView1", comment: ""), for: .normal)
        dayViewButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        dayViewButton.setTitleColor(colour1, for: .normal)
        //
        weekViewButton.titleLabel?.lineBreakMode = .byWordWrapping
        weekViewButton.setTitle(NSLocalizedString("scheduleView2", comment: ""), for: .normal)
        weekViewButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        weekViewButton.setTitleColor(colour1, for: .normal)
        
        //
        // Back
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
    }
    
    //
    // MARK: Button actions
    // Day
    @IBAction func dayButtonAction(_ sender: Any) {
        
        
    }
    
    // Week
    @IBAction func weekButtonAction(_ sender: Any) {
        
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
    
}
