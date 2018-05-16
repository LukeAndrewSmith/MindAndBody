//
//  MeditationGuided.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 24.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Meditation Guided Class ------------------------------------------------------------------------------------
//
class MeditationGuided: UIViewController {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    // Image
    @IBOutlet weak var imageView: UIImageView!
    
    // Detail
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailTitle: UILabel!
    
    // Discussion
    @IBOutlet weak var discussionScrollView: UIScrollView!
    @IBOutlet weak var discussionTitle: UILabel!
    
    // Details
    //
    // Theme
    @IBOutlet weak var themeTitle: UILabel!
    @IBOutlet weak var theme: UILabel!
    // Aim
    @IBOutlet weak var aimTitle: UILabel!
    @IBOutlet weak var aim: UILabel!
    // Focus
    @IBOutlet weak var focusTitle: UILabel!
    @IBOutlet weak var focus: UILabel!
    // Duration
    @IBOutlet weak var durationTitle: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    
    // Passed from previous VC
    //var guidedTitle = String()
    var selectedSessionMeditation = [0, 0]
    
    var fromSchedule = false
    
    //
    // Content Arrays -------------------------------------------------------------------------------------------
    //
    // Sessions Titles
    let guidedSessions =
        [
            ["introduction1", "introduction2", "introduction3", "introduction4"],
            ["squareBreathing", "breathCounting", "oxygenPurge", "breathRetention", "nostrilBreathing"],
            ["bodyScan", "tummoInnerFire", "self", "earth"],
        ]
    // Theme
    let themeArray =
        [
            ["introduction1", "introduction2", "introduction3", "introduction4"],
            ["squareBreathing", "breathCounting", "oxygenPurge", "breathRetention", "nostrilBreathing"],
            ["bodyScan", "tummoInnerFire", "self", "earth"],
        ]
    // Aim
    let aimArray =
        [
            ["introduction1", "introduction2", "introduction3", "introduction4"],
            ["squareBreathing", "breathCounting", "oxygenPurge", "breathRetention", "nostrilBreathing"],
            ["bodyScan", "tummoInnerFire", "self", "earth"],
            ]
    // Focus
    let focusArray =
        [
            ["introduction1", "introduction2", "introduction3", "introduction4"],
            ["squareBreathing", "breathCounting", "oxygenPurge", "breathRetention", "nostrilBreathing"],
            ["bodyScan", "tummoInnerFire", "self", "earth"],
            ]
    // Duration
    let durationArray =
        [
            ["introduction1", "introduction2", "introduction3", "introduction4"],
            ["squareBreathing", "breathCounting", "oxygenPurge", "breathRetention", "nostrilBreathing"],
            ["bodyScan", "tummoInnerFire", "self", "earth"],
            ]
    // Image
    
    
    // Discussion
    let discussionArray =
        [
            ["introduction1E", "introduction2E", "introduction3E", "introduction4E"],
            ["squareBreathingE", "breathCountingE", "oxygenPurgeE", "breathRetentionE", "nostrilBreathingE"],
            ["bodyScanE", "tummoInnerFireE", "selfE", "earthE"],
            ]
    
    
    //
    // View did load -------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.light
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = Colors.green
        beginButton.setTitleColor(Colors.dark, for: .normal)
        
        // View Elements
        //
        // Description
        detailView.backgroundColor = Colors.dark
        //
        detailTitle.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        detailTitle.text = NSLocalizedString("detail", comment: "")
        //
        imageView.backgroundColor = Colors.dark
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        //
        imageView.image = #imageLiteral(resourceName: "TestG")
        
        
        // Content
        //
        
        // Navigation Bar Title
        navigationBar.title = NSLocalizedString(guidedSessions[selectedSessionMeditation[0]][selectedSessionMeditation[1]], comment: "")
        
        // Details
        //
        // Theme
        //
        themeTitle.text = NSLocalizedString("theme", comment: "")
        //
        theme.text = NSLocalizedString(themeArray[selectedSessionMeditation[0]][selectedSessionMeditation[1]], comment: "")
        theme.adjustsFontSizeToFitWidth = true
        
        // Aim
        //
        aimTitle.text = NSLocalizedString("aim", comment: "")
        //
        aim.text = NSLocalizedString(aimArray[selectedSessionMeditation[0]][selectedSessionMeditation[1]], comment: "")
        aim.adjustsFontSizeToFitWidth = true
        
        // Focus
        //
        focusTitle.text = NSLocalizedString("focus", comment: "")
        //
        focus.text = NSLocalizedString(focusArray[selectedSessionMeditation[0]][selectedSessionMeditation[1]], comment: "")
        focus.adjustsFontSizeToFitWidth = true
        
        // Duration
        //
        durationTitle.text = NSLocalizedString("duration", comment: "")
        //
        duration.text = NSLocalizedString(durationArray[selectedSessionMeditation[0]][selectedSessionMeditation[1]], comment: "")
        duration.adjustsFontSizeToFitWidth = true
        
        // Image
        //
        
        
        // Discussion
        //
        // Scroll
        discussionScrollView.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        //
        discussionTitle.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        discussionTitle.textColor = Colors.dark
        discussionTitle.text = NSLocalizedString("discussion", comment: "")
        
        // Text
        let discussionLabel = UILabel()
        let attributedText = NSMutableAttributedString(string: NSLocalizedString(discussionArray[selectedSessionMeditation[0]][selectedSessionMeditation[1]], comment: ""))
        let paragraphStyleE = NSMutableParagraphStyle()
        paragraphStyleE.alignment = .natural
        paragraphStyleE.lineSpacing = 2
        //
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyleE, range: NSMakeRange(0, attributedText.length))
        //
        discussionLabel.attributedText = attributedText
        //
        discussionLabel.font = UIFont(name: "SFUIDisplay-light", size: 19)
        discussionLabel.textColor = .black
        discussionLabel.textAlignment = .natural
        discussionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        discussionLabel.numberOfLines = 0
        discussionLabel.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 0)
        discussionLabel.sizeToFit()
        // Scroll View
        discussionScrollView.addSubview(discussionLabel)
        discussionScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: discussionLabel.frame.size.height + 20)
        //
        self.discussionScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    
    //
    // Begin Button ----------------------------------------------------------------------------------
    //
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        //
        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            _ = self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    
    //
    // Pass arrays to next View controller -------------------------------------------------------------------------------------------
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Info
        //        if (segue.identifier == "meditationGuided") {
        //            let destinationVC = segue.destination as! MeditationScreen
        //            //
        //            destinationVC.selectedSessionMeditation = selectedSessionMeditation
        // destinationVC.fromSchedule = fromSchedule
        //        }
    }
    //
}

