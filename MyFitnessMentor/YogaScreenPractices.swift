//
//  YogaChoiceNormalOrder.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 30.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import UserNotifications



class YogaScreenPractices: UIViewController, UIScrollViewDelegate {
    
    
    
    
    // Warmup Screen Index
    //
    var warmupScreenIndex = 0
    
    
    
    // Initialize Arrays
    // Key Array
    var keyArray = [Int]()
    // Poses Dictrionary
    var poses = [Int: String]()
    
    
    
    
    
    //
    
    // Outlets
    //
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    let navigationTitle = UILabel()
    // Buttons
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    
    
    // Scroll Views
    // Explanation
    @IBOutlet weak var scrollViewExplanation: UIScrollView!
    
    
    // Image View
    @IBOutlet weak var bodyImage: UIImageView!
    // Demonstration Image
    
    // Expand Image
    @IBOutlet weak var imageExpand: UIButton!
    
    
    
    
    
    // Explanation Expand
    @IBOutlet weak var explanationExpand: UIButton!
    
    
    // Progress Bar
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    // Title Labels
    // Sets and Reps
    @IBOutlet weak var setsRepsLabel: UILabel!
    // Demonstration
    @IBOutlet weak var demonstrationLabel: UILabel!
    // Target Area Label
    @IBOutlet weak var targetAreaLabel: UILabel!
    // Explanation Label
    @IBOutlet weak var explanationLabel: UILabel!
    let explanationText = UILabel()
    // Progress Label
    @IBOutlet weak var progressLabel: UILabel!
    
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    
    
    
    
    //
    // View Did Load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        //
        self.view.applyGradient(colours: [colour1, colour2])
        
        backButton.tintColor = colour1
        
        
        
        
        // Body Image View
        bodyImage.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        
        
        
        
        
        
        
        
        // Explanation Text
        explanationText.font = UIFont(name: "SFUIDisplay-light", size: 19)
        explanationText.textColor = .black
        explanationText.textAlignment = .justified
        explanationText.lineBreakMode = NSLineBreakMode.byWordWrapping
        explanationText.numberOfLines = 0
        
        
        // Expand Button
        let origImage1 = UIImage(named: "Plus")
        let tintedImage1 = origImage1?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        explanationExpand.setImage(tintedImage1, for: .normal)
        
        //Image Tint
        explanationExpand.tintColor = colour1
        
        
        
        
        
        
        // Progress Bar
        //
        
        // Thickness
        
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 49, height: self.progressBarView.frame.size.height / 2)
        progressBar.center = progressBarView.center
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3)
        
        // Rounded Edges
        progressBar.layer.cornerRadius = self.progressBar.frame.size.height
        progressBar.clipsToBounds = true
        
        // Initial state
        progressBar.setProgress(0, animated: true)
        
        
        
        // Display Content
        displayContent()
        
        
        
    }
    
    
    
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    

    
    // Display Content Function
    func displayContent() {
        
        
        // Navigation Bar
        navigationTitle.text = NSLocalizedString(poses[keyArray[warmupScreenIndex]]!, comment: "")
        
        // Navigation Title
        navigationTitle.frame = (navigationController?.navigationItem.accessibilityFrame)!
        navigationTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        navigationTitle.center.x = self.view.center.x
        navigationTitle.textColor = colour1
        navigationTitle.font = UIFont(name: "SFUIDisplay-heavy", size: 23)
        navigationTitle.backgroundColor = .clear
        navigationTitle.textAlignment = .center
        navigationTitle.adjustsFontSizeToFitWidth = true
        
        self.navigationController?.navigationBar.topItem?.titleView = navigationTitle
        
        
        
        // Body Image
        //bodyImage.image = targetAreaArray[warmupScreenIndex]
        
        
        
        // Explanation Text and Scroll View
        let attributedExplanation = NSMutableAttributedString(string: NSLocalizedString(poses[keyArray[warmupScreenIndex]]!, comment: ""))
        let paragraphStyleE = NSMutableParagraphStyle()
        paragraphStyleE.alignment = .justified
        paragraphStyleE.hyphenationFactor = 1
        
        attributedExplanation.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyleE, range: NSMakeRange(0, attributedExplanation.length))
        
        explanationText.attributedText = attributedExplanation
        
        explanationText.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 0)
        explanationText.sizeToFit()
        // Scroll View
        scrollViewExplanation.addSubview(explanationText)
        scrollViewExplanation.contentSize = CGSize(width: self.view.frame.size.width, height: explanationText.frame.size.height + 20)
        
        self.scrollViewExplanation.contentOffset.y = 0
        
        
        
        
        
        // Explanation
        self.scrollViewExplanation.contentOffset.y = 0
        
        self.view.bringSubview(toFront: scrollViewExplanation)
        
        
        
        
        
        // Title Labels
        // Sets Reps
        //self.setsRepsLabel.text = (String(setsArray[warmupScreenIndex]) + " x " + repsArray[warmupScreenIndex])
        // Demonstration
//        self.demonstrationLabel.text = NSLocalizedString("demonstration", comment: "")
//        // Target Area
//        self.targetAreaLabel.text = NSLocalizedString("targetArea", comment: "")
        // Explanation
        self.explanationLabel.text = NSLocalizedString("explanation", comment: "")
        // Progress
        self.progressLabel.text = (String(warmupScreenIndex + 1)+"/"+String(keyArray.count))
        
        
        
        // Progress Bar
        let warmupIndexP = Float(warmupScreenIndex)
        let warmupArrayP = Float(self.keyArray.count)
        
        let fractionalProgress = warmupIndexP/warmupArrayP
        
        progressBar.setProgress(fractionalProgress, animated: true)
        
        
    }
    
    
    
    
    
    
    // Flash Screen
    func flashScreen() {
        
        let flash = UIView()
        
        flash.frame = CGRect(x: 0, y: -100, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
            
            flash.alpha = 0
            
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
        
    }
    
    
    
    
    
    
    
    
    
    
    // Next Button
    @IBAction func nextButton(_ sender: Any) {
        
        
        if warmupScreenIndex == keyArray.count - 1 {
            
            warmupScreenIndex = 0
            
            self.dismiss(animated: true)
            
            
            
        } else {
            warmupScreenIndex = warmupScreenIndex + 1
            displayContent()
        }
        
        flashScreen()
        
        
        
    }
    
    
    
    // Back Button
    @IBAction func backButton(_ sender: Any) {
        
        if warmupScreenIndex == 0 {
            
        } else {
            warmupScreenIndex = warmupScreenIndex - 1
            
            flashScreen()
            displayContent()
        }
        
        
    }

    
    

    
    
    // Expand Explanation
    //
    let scrollViewExplanationE = UIScrollView()
    let backgroundViewExplanationE = UIButton()
    let cancelButtonExplanationE = UIButton()
    
    let explanationLabelE = UILabel()
    
    
    
    
    
    
    // Expand Explanation
    //
    @IBAction func expandExplanation(_ sender: Any) {
        
        
        
        // View
        //
        scrollViewExplanationE.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: (view.frame.size.height * (2/3) + 24.5))
        scrollViewExplanationE.center.x = self.view.frame.size.width/2
        scrollViewExplanationE.center.y = self.view.frame.size.height/2
        
        scrollViewExplanationE.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        
        
        // Background View
        //
        backgroundViewExplanationE.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        backgroundViewExplanationE.backgroundColor = .black
        backgroundViewExplanationE.alpha = 0.5
        
        backgroundViewExplanationE.addTarget(self, action: #selector(retractExplanation(_:)), for: .touchUpInside)
        
        
        
        
        // Cancel Button
        //
        cancelButtonExplanationE.frame = CGRect(x: 0, y: 0, width: 49, height: 49)
        cancelButtonExplanationE.center.y = scrollViewExplanationE.frame.minY/2
        cancelButtonExplanationE.center.x = scrollViewExplanationE.frame.maxX - (scrollViewExplanationE.frame.minY/2)
        
        cancelButtonExplanationE.addTarget(self, action: #selector(retractExplanation(_:)), for: .touchUpInside)
        cancelButtonExplanationE.layer.cornerRadius = 24.5
        cancelButtonExplanationE.layer.masksToBounds = true
        
        
        cancelButtonExplanationE.backgroundColor = colour2
        
        let origImage = UIImage(named: "Minus")
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        cancelButtonExplanationE.setImage(tintedImage, for: .normal)
        //Image Tint
        cancelButtonExplanationE.tintColor = colour1
        
        
        
        
        // Contents
        //
        explanationLabelE.font = UIFont(name: "SFUIDisplay-light", size: 19)
        explanationLabelE.textColor = .black
        explanationLabelE.textAlignment = .justified
        explanationLabelE.lineBreakMode = NSLineBreakMode.byWordWrapping
        explanationLabelE.numberOfLines = 0
        
        
        let attributedStringE = NSMutableAttributedString(string: NSLocalizedString(poses[keyArray[warmupScreenIndex]]!, comment: ""))
        let paragraphStyleEE = NSMutableParagraphStyle()
        paragraphStyleEE.alignment = .justified
        paragraphStyleEE.hyphenationFactor = 1
        
        attributedStringE.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyleEE, range: NSMakeRange(0, attributedStringE.length))
        
        explanationLabelE.attributedText = attributedStringE
        
        explanationLabelE.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 0)
        explanationLabelE.sizeToFit()
        
        // Scroll View
        scrollViewExplanationE.addSubview(explanationLabelE)
        scrollViewExplanationE.contentSize = CGSize(width: self.view.frame.size.width, height: explanationLabelE.frame.size.height + 20)
        
        scrollViewExplanationE.contentOffset.y = 0
        
        
        
        
        
        
        // Add Views
        view.addSubview(scrollViewExplanationE)
        view.addSubview(backgroundViewExplanationE)
        view.addSubview(cancelButtonExplanationE)
        
        view.bringSubview(toFront: scrollViewExplanationE)
        view.bringSubview(toFront: cancelButtonExplanationE)
        
        
        nextButton.isEnabled = false
        backButton.isEnabled = false
        
    }
    
    
    
    @IBAction func retractExplanation(_ sender: Any) {
        
        
        scrollViewExplanationE.removeFromSuperview()
        backgroundViewExplanationE.removeFromSuperview()
        cancelButtonExplanationE.removeFromSuperview()
        
        explanationLabelE.removeFromSuperview()
        
        
        nextButton.isEnabled = true
        backButton.isEnabled = true
    }
    
    
    
}
