//
//  WarmupScreenUpper2.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 08.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class WarmupScreenUpper: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    // Warmup Screen Inde
    //
    var warmupScreenIndex = 0
    
    
    
    // Initialize Arrays
    
    var warmupMovementsArray: [[String]] = [[]]
    
    var warmupMovementsSelectedArray: [[Int]] = [[]]
    
    var warmupArray: [String] = []
    
    var setsRepsArray: [String] = []
    
    
    func createArrays() {
        
        // Warmup Array
        self.warmupArray = zip(warmupMovementsArray.flatMap{$0},warmupMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
    
        // Sets and Reps Array
        
    }
    
    
    
    //
    
    // Outlets
    //
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
        // Buttons
        @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    
    
    // Views
    @IBOutlet weak var setRepView: UIView!
    
    // Buttons
    @IBOutlet weak var testButton: UIButton!
    
    // Scroll Views
        // Demonstration
        @IBOutlet weak var scrollViewDemonstration: UIScrollView!
        // Explanation
        @IBOutlet weak var scrollViewExplanation: UIScrollView!
    
    
    // Image View
    @IBOutlet weak var bodyImage: UIImageView!
    
    
    
  
    
    // Progress Bar
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    // Title Labels
        // Sets and Reps
        @IBOutlet weak var setsRepsLabel: UILabel!
        // Demonstration
        @IBOutlet weak var demonstrationLabel: UILabel!
        // Worked Area Label
        @IBOutlet weak var workedAreaLabel: UILabel!
        // Explanation Label
        @IBOutlet weak var explanationLabel: UILabel!
        // Progress Label
        @IBOutlet weak var progressLabel: UILabel!
    
    
    
    // ExtraInformation
        // Label
        @IBOutlet weak var extraInformationLabel: UILabel!
        // ScrollView
        @IBOutlet weak var extraInformationView: UIScrollView!
        // Information Label Button
        let informationLabelButton = UIButton()
        // Information Button
        @IBOutlet weak var extraInformationButton: UIButton!
    
    
    
    
    
    // 
    // View Did Load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Create Arrays
        //
        createArrays()
        
        
        // Background Gradient
        //
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        // Navigation Bar
        //
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        
        
        
        
        
        // Test Button
        
        testButton.layer.borderWidth = 10
        testButton.layer.borderColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0).cgColor
        testButton.layer.cornerRadius = self.testButton.frame.size.height / 2
        
        
        
        
        
        
        
        
        
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
        
        
        
        
        
        // Extra Information   
            // Title Label
            self.extraInformationLabel.frame = CGRect(x: 0, y: self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.width, height: 49)
            self.extraInformationLabel.isUserInteractionEnabled = true
        
            self.extraInformationLabel.text = NSLocalizedString("extraInformation", comment: "")
        
        
            view.bringSubview(toFront: extraInformationLabel)
        
            // Scroll View
            self.extraInformationView.frame = CGRect(x: 0, y: self.view.frame.size.height + 49 - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
    
            view.bringSubview(toFront: extraInformationView)
        
        
            // Swipe Down Button
        
            informationLabelButton.frame = CGRect(x: self.view.frame.size.width - 49, y: self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height, width: 49, height: 49)
            informationLabelButton.setTitle("?", for: .normal)
            informationLabelButton.titleLabel?.font = UIFont(name: "SFUIDisplay-medium", size: 20)
            informationLabelButton.setTitleColor(UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), for: .normal)
            informationLabelButton.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
            informationLabelButton.addTarget(self, action: #selector(informationLabelButtonAction(_:)), for: .touchUpInside)
        
        
            view.addSubview(informationLabelButton)
            view.bringSubview(toFront: informationLabelButton)
        
        
            extraInformationButton.setTitleColor(UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0), for: .normal)
            extraInformationLabel.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
        
        
        
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        extraInformationLabel.addGestureRecognizer(downSwipe)
        extraInformationLabel.isUserInteractionEnabled = true
        
        
        
        
        
        
        // Display Content
        displayContent()
        
        
        
    }
    
    
    
    // Display Content Function
    func displayContent() {
        
        
        // Navigation Bar
        self.navigationItem.title = NSLocalizedString(warmupArray[warmupScreenIndex], comment: "")
        
        
        
        
    
        // Body Image
        bodyImage.image = #imageLiteral(resourceName: "BodyImage")
        
        
        
        
        // Explanation Label
        
        
        
        
        
        
        // Demonstration Image
        
        
        
        
        
        
        // Extra Information Label
        
        
        
        
        // Title Labels
        //self.setsRepsLabel.text = ""
        
        self.demonstrationLabel.text = NSLocalizedString("demonstration", comment: "")
        
        self.workedAreaLabel.text = NSLocalizedString("workedArea", comment: "")
        
        self.progressLabel.text = (String(warmupScreenIndex + 1)+"/"+String(warmupArray.count))
       
        
        
        // Progress Bar
        let warmupIndex = Float(warmupScreenIndex)
        let warmupArray = Float(self.warmupArray.count)

        let fractionalProgress = warmupIndex/warmupArray
    
        progressBar.setProgress(fractionalProgress, animated: true)
        
        
        
    }

    
    
    
    // Flash Screen
    func flashScreen() {
        
        let flash = UIView()
        
        flash.frame = CGRect(x: 0, y: -100, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0)
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
            
            flash.alpha = 0
            
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
        
    }

    
    
    
    
    
    @IBAction func testButtonAction(_ sender: Any) {
        
        self.testButton.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
        self.testButton.isEnabled = false
        
    }
    
    
    
    
    
    
    
    //
    // Button Actions
    //
    // Next Button
    @IBAction func nextButton(_ sender: Any) {
    
        if warmupScreenIndex == warmupArray.count - 1 {
            
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
    
    
    
    
    
    // ExtraInformation
    
    @IBAction func extraInformationButton(_ sender: Any) {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.extraInformationLabel.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
            }, completion: nil)
            
            UIButton.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                self.informationLabelButton.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
            }, completion: nil)
            
            self.extraInformationView.contentOffset.y = 0
        
        
        
        // Disable Navigation Buttons
        backButton.isEnabled = false
        nextButton.isEnabled = false
        
        
        
    }
    
    
    @IBAction func informationLabelButtonAction(_ sender: Any) {
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            
            self.extraInformationLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            
        }, completion: nil)
        UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            
            self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
        
        UIButton.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
            
            self.informationLabelButton.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
        
        // Enable Navigation Buttons
        backButton.isEnabled = true
        nextButton.isEnabled = true

        
    }
    
    
    
    
    
    // Handle Swipe
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.extraInformationLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            
            UIButton.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                self.informationLabelButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            
            // Enable Navigation Buttons
            backButton.isEnabled = true
            nextButton.isEnabled = true
        
        }

    }
    
    
    
    
    
    
    
    // Picker Views
    //
    
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        return UIView()
    }
    
    
}
