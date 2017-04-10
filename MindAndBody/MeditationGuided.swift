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
    var selectedSession = [0, 0]
    
    
//
// Content Arrays -------------------------------------------------------------------------------------------
//
    // Sessions Titles
    let guidedSessions =
        [
            ["introduction", "breathing"],
            ["scale", "perspective"],
            ["lettingGo", "acceptance", "wandering", "oneness", "duality", "effort"],
            ["bodyScan", "unwind"],
            ["lotusStretch", "generalStretch"]
        ]
    // Theme
    let themeArray =
        [
            ["introduction", "breathing"],
            ["scale", "perspective"],
            ["lettingGo", "acceptance", "wandering", "oneness", "duality", "effort"],
            ["bodyScan", "unwind"],
            ["lotusStretch", "generalStretch"]
        ]
    // Aim
    let aimArray =
        [
            ["comprehension", "calm"],
            ["comfort", "creativity"],
            ["relaxation", "relaxation", "recreation", "harmony", "harmony", "motivation"],
            ["trance", "disentangle"],
            ["relaxation", "relaxation"]
    ]
    // Focus
    let focusArray =
        [
            ["understanding", "body"],
            ["conscious", "subconscious"],
            ["freedom", "relaxation", "recreation", "individuality", "interdependence", "energy"],
            ["admission", "clarity"],
            ["acceptance", "acceptance"]
    ]
    // Duration
    let durationArray =
        [
            ["12min", "10min"],
            ["13min", "8min"],
            ["20min", "12min", "10min", "10min", "10min", "10min"],
            ["20min", "10min"],
            ["20min", "20min"]
    ]
    // Image
    
    
    // Discussion
    let discussionArray =
        [
            ["introductionD", "breathingD"],
            ["scaleD", "perspectiveD"],
            ["lettingGoD", "acceptanceD", "wanderingD", "onenessD", "dualityD", "effortD"],
            ["bodyScanD", "unwindD"],
            ["lotusStretchD", "generalStretchD"]
    ]
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
    
//
// View did load -------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colour
        self.view.applyGradient(colours: [colour1, colour1])
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.setTitleColor(colour2, for: .normal)
        
        // View Elements
        //
        // Description
        detailView.backgroundColor = colour2
        //
        detailTitle.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        detailTitle.text = NSLocalizedString("detail", comment: "")
        //
        imageView.backgroundColor = colour2
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        //
        imageView.image = #imageLiteral(resourceName: "TestG")
        
        
        // Content
        //
        
        // Navigation Bar Title
        navigationBar.title = NSLocalizedString(guidedSessions[selectedSession[0]][selectedSession[1]], comment: "")
        
        // Details
        //
        // Theme
            //
            themeTitle.text = NSLocalizedString("theme", comment: "")
            //
            theme.text = NSLocalizedString(themeArray[selectedSession[0]][selectedSession[1]], comment: "")
            theme.adjustsFontSizeToFitWidth = true
        
        // Aim
            //
            aimTitle.text = NSLocalizedString("aim", comment: "")
            //
            aim.text = NSLocalizedString(aimArray[selectedSession[0]][selectedSession[1]], comment: "")
            aim.adjustsFontSizeToFitWidth = true

        // Focus
            //
            focusTitle.text = NSLocalizedString("focus", comment: "")
            //
            focus.text = NSLocalizedString(focusArray[selectedSession[0]][selectedSession[1]], comment: "")
            focus.adjustsFontSizeToFitWidth = true

        // Duration
            //
            durationTitle.text = NSLocalizedString("duration", comment: "")
            //
            duration.text = NSLocalizedString(durationArray[selectedSession[0]][selectedSession[1]], comment: "")
            duration.adjustsFontSizeToFitWidth = true

        // Image
        //
        
    
        // Discussion
        //
        // Scroll
        discussionScrollView.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        //
        discussionTitle.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        discussionTitle.textColor = colour2
        discussionTitle.text = NSLocalizedString("discussion", comment: "")
        
        // Text
        let discussionLabel = UILabel()
        let attributedText = NSMutableAttributedString(string: NSLocalizedString(discussionArray[selectedSession[0]][selectedSession[1]], comment: ""))
        let paragraphStyleE = NSMutableParagraphStyle()
        paragraphStyleE.alignment = .justified
        //
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyleE, range: NSMakeRange(0, attributedText.length))
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
        if (segue.identifier == "meditationGuided") {
            let destinationNC = segue.destination as! UINavigationController
            let destinationVC = destinationNC.viewControllers.first as! MeditationScreenGuided
            //
            destinationVC.selectedSession = selectedSession
        }
    }
//
}
