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
    @IBOutlet weak var bellTitle: UILabel!
    @IBOutlet weak var bellImage: UIImageView!
    
    // Time
    @IBOutlet weak var durationTitle: UILabel!
    @IBOutlet weak var durationIndicator: UILabel!
    @IBOutlet weak var durationDecrease: UIButton!
    @IBOutlet weak var durationIncrease: UIButton!
    
    
    // Detail
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var separator: UIView!
    
    // Discussion
    @IBOutlet weak var discussionScrollView: UIScrollView!
    @IBOutlet weak var discussionTitle: UILabel!
    
    // Passed from previous VC
    //var guidedTitle = String()
    var selectedSessionMeditation = [0, 0]
    
    var fromSchedule = false
    
    //
    // Content Arrays -------------------------------------------------------------------------------------------
    //
    // Sessions Titles
    var practiceDict: [[[String: Any]]] =
    [
        // Introduction
        [
            // Intro 1
            ["title": "introduction1",
             "discussion": "introduction1E",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
            // Intro 2
            ["title": "introduction2",
             "discussion": "introduction2E",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
            // Intro 3
            ["title": "introduction3",
             "discussion": "introduction3E",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
            // Intro 4
            ["title": "introduction4",
             "discussion": "introduction4E",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
        ],
        // Breathing
        [
            // Intro 1
            ["title": "squareBreathing",
             "discussion": "squareBreathingE",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
            // Intro 1
            ["title": "breathCounting",
             "discussion": "breathCountingE",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
            // Intro 1
            ["title": "oxygenPurge",
             "discussion": "oxygenPurgeE",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
            // Intro 1
            ["title": "breathRetention",
             "discussion": "breathRetentionE",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
            // Intro 1
            ["title": "nostrilBreathing",
             "discussion": "nostrilBreathingE",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
        ],
        // Visualisation
        [
            // Intro 1
            ["title": "bodyScan",
             "discussion": "bodyScanE",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
            // Intro 1
            ["title": "tummoInnerFire",
             "discussion": "tummoInnerFireE",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
            // Intro 1
            ["title": "self",
             "discussion": "selfE",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
            // Intro 1
            ["title": "earth",
             "discussion": "earthE",
             "duration": 120,
             "bell": "tibetanChimes",
             "numberOfBells": 10,
             ],
        ],
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
       
        // Navigation Bar Title
        navigationBar.title = NSLocalizedString(practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["title"] as! String, comment: "")
        
        // Setup
        setupView()
        
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
        let attributedText = NSMutableAttributedString(string: NSLocalizedString(practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["discussion"] as! String, comment: ""))
        let paragraphStyleE = NSMutableParagraphStyle()
        paragraphStyleE.alignment = .natural
        paragraphStyleE.lineSpacing = 2
        //
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyleE, range: NSMakeRange(0, attributedText.length))
        //
        discussionLabel.attributedText = attributedText
        //
        discussionLabel.font = UIFont(name: "SFUIDisplay-light", size: 20)
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
    
    func setupView() {
        // View
        detailView.backgroundColor = Colors.dark
        separator.backgroundColor = .black
        separator.alpha = 0.5

        // Duration
        // Title
        durationTitle.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        durationTitle.textColor = Colors.light
        durationTitle.text = NSLocalizedString("duration", comment: "")
        // Indicator
        durationIndicator.font = UIFont(name: "SFUIDisplay-thin", size: 43)
        durationIndicator.textColor = Colors.light
        durationIndicator.text = "00:00"
        //durationTitle.text =
        // Buttons
        durationIncrease.tintColor = Colors.light
        durationDecrease.tintColor = Colors.light
        
        // Bells
        // Title
        bellTitle.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        bellTitle.textColor = Colors.light
        bellTitle.text = NSLocalizedString("bells", comment: "")
        // Image
        bellImage.backgroundColor = Colors.dark
        bellImage.layer.cornerRadius = 3
        bellImage.layer.masksToBounds = true
        bellImage.image = #imageLiteral(resourceName: "Tibetan Bowl Big")
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

