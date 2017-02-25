//
//  MeditationGuided.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 24.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

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
    
    
    
    // Content Arrays
    
    // Sessions Titles
    let guidedSessions =
        [
            ["introduction", "breathing"],
            ["scale", "perspective"],
            ["lettingGo", "acceptance", "wandering", "oneness", "duality"],
            ["bodyScan", "unwind"]
        ]
    
    // Theme
    let themeArray =
        [
            ["introduction", "breathing"],
            ["scale", "perspective"],
            ["lettingGo", "acceptance", "wandering", "oneness", "duality"],
            ["bodyScan", "unwind"]
        ]
    
    // Aim
    let aimArray =
        [
            ["comprehension", "calm"],
            ["comfort", "creativity"],
            ["relaxation", "relaxation", "recreation", "harmony", "harmony"],
            ["trance", "disentangle"]
    ]
    
    // Focus
    let focusArray =
        [
            ["understanding", "body"],
            ["conscious", "subconscious"],
            ["freedom", "relaxation", "recreation", "individuality", "interdependence"],
            ["admission", "clarity"]
    ]
    
    // Duration
    let durationArray =
        [
            ["12min", "10min"],
            ["13min", "8min"],
            ["20min", "12min", "10min", "10min", "10min"],
            ["20min", "10min"]
    ]
    
    // Image
    
    
    // Discussion
    let discussionArray =
        [
            ["introductionD", "breathingD"],
            ["scaleD", "perspectiveD"],
            ["lettingGoD", "acceptanceD", "wanderingD", "onenessD", "dualityD"],
            ["bodyScanD", "unwindD"]
    ]
    
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour3 = UserDefaults.standard.color(forKey: "colour3")!
    let colour4 = UserDefaults.standard.color(forKey: "colour4")!
    let colour5 = UserDefaults.standard.color(forKey: "colour5")!
    let colour6 = UserDefaults.standard.color(forKey: "colour6")!
    let colour7 = UserDefaults.standard.color(forKey: "colour7")!
    let colour8 = UserDefaults.standard.color(forKey: "colour8")!
    
    


    
    
    
    //
    // ViewDidLoad
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough2y") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough2y")
        }
        
        
        
        // Colour
        self.view.applyGradient(colours: [colour1, colour2])
        
        
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.setTitleColor(colour8, for: .normal)
        
        
        
        
        
        // View Elements
        //
        // Discription
        detailView.backgroundColor = colour7
        
        detailTitle.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        detailTitle.text = NSLocalizedString("detail", comment: "")
        
        
        //
        imageView.backgroundColor = colour7
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        
        imageView.image = #imageLiteral(resourceName: "TestG")
        
        
        
        
        
        
        
        
        
        //
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
        
        
        discussionTitle.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        discussionTitle.textColor = colour7
        discussionTitle.text = NSLocalizedString("discussion", comment: "")
        
        
        // Text
        let discussionLabel = UILabel()
        let attributedText = NSMutableAttributedString(string: NSLocalizedString(discussionArray[selectedSession[0]][selectedSession[1]], comment: ""))
        let paragraphStyleE = NSMutableParagraphStyle()
        paragraphStyleE.alignment = .justified
        paragraphStyleE.hyphenationFactor = 1
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyleE, range: NSMakeRange(0, attributedText.length))
        
        discussionLabel.attributedText = attributedText
        
        discussionLabel.font = UIFont(name: "SFUIDisplay-light", size: 19)
        discussionLabel.textColor = .black
        discussionLabel.textAlignment = .justified
        discussionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        discussionLabel.numberOfLines = 0
        discussionLabel.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 0)
        discussionLabel.sizeToFit()
        
        // Scroll View
        discussionScrollView.addSubview(discussionLabel)
        discussionScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: discussionLabel.frame.size.height + 20)
        
        self.discussionScrollView.contentOffset.y = 0
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        
        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            
            _ = self.navigationController?.popToRootViewController(animated: false)
            
        }
        
    }
    
    
    
    
    // Pass Array to next ViewController
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "warmupUpper") {
            
            
            
            let destinationNC = segue.destination as! UINavigationController
            
            let destinationVC = destinationNC.viewControllers.first as! YogaScreenPractices
            
            //destinationVC.keyArray = selectedArray
            //destinationVC.poses = posesDictionary
            
        }
    }
    
    
    
    
   
    

    
    
    
    
    
    
    
    
    
    
//---------------------------------------------------------------------------------------------------------------
    
    
    var  viewNumber = 0
    let walkthroughView = UIView()
    let label = UILabel()
    let nextButton = UIButton()
    let backButton = UIButton()
    
    
    // Walkthrough
    func walkthroughMindBody() {
        
        //
        let screenSize = UIScreen.main.bounds
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        //
        walkthroughView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        walkthroughView.backgroundColor = .black
        walkthroughView.alpha = 0.72
        walkthroughView.clipsToBounds = true
        //
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        label.center = view.center
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "SFUIDisplay-light", size: 22)
        label.textColor = .white
        //
        nextButton.frame = screenSize
        nextButton.backgroundColor = .clear
        nextButton.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
        //
        backButton.frame = CGRect(x: 3, y: UIApplication.shared.statusBarFrame.height, width: 50, height: navigationBarHeight)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.textAlignment = .left
        backButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        backButton.titleLabel?.textColor = .white
        backButton.addTarget(self, action: #selector(backWalkthroughView(_:)), for: .touchUpInside)
        
        
        
        
        switch viewNumber {
        case 0:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: view.frame.size.width/2 - 80, y: UIApplication.shared.statusBarFrame.height, width: 160, height: 40))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("choiceScreen21", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            
            
        //
        case 1:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width * 0.917, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("choiceScreen26", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        default: break
            
            
        }
        
        
    }
    
    
    
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    
    
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
        
    }
    
    
    
}
