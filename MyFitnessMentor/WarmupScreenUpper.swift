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
    // Warmup Choice Arrays
        // Warmup Choice Movement Array
        var warmupMovementsArray: [[String]] = [[]]
        // Warmup Choice Selected Array
        var warmupMovementsSelectedArray: [[Int]] = [[]]
    
    // Warmup Arrays
        // Movement Array
        var warmupArray: [String] = []
        // Sets Array
        var setsArrayF =
            [
                // Mandatory
                [1,
                 1],
                // Foam/Ball Roll
                [1,
                 3,
                 1,
                 1,
                 1],
                // Lower Back
                [1,
                1,
                1,
                1,
                1,
                1],
                // Shoulder
                [2,
                 1,
                 1,
                 1],
                // Band/Bar/Machine Assisted
                [2,
                 1,
                 1,
                 1,
                 1,
                 1],
                // Accessory
                [1,
                 1,
                 1]
            ]
        var setsArray: [Int] = []
        // Sets Array
        var repsArrayF =
            [
                // Mandatory
                ["1",
                 "1"],
                // Foam/Ball Roll
                ["10-20",
                "5-10",
                "5-10",
                "5-10",
                "30-60s"],
                // Lower Back
                ["5-10",
                "5-10",
                "5-10",
                "5-10",
                "5-10",
                "15-20"],
                // Shoulder
                ["10-20",
                "5-10",
                "15",
                "10"],
                // Band/Bar/Machine Assisted
                ["10-15",
                "5-15",
                "5-10",
                "5-10",
                "10-15",
                "10-20",],
                // Accessory
                ["15-30s",
                NSLocalizedString("asNecessary", comment: ""),
                NSLocalizedString("asNecessary", comment: "")
                ]
            ]
        var repsArray: [String] = []
        // Demonstration Array
        var demonstrationArrayF: [[UIImage]] = [[]]
        var demonstrationArray: [UIImage] = []
        // Target Area Array
        var targetAreaArrayF: [[UIImage]] = [[]]
        var targetAreaArray: [UIImage] = []
        // Explanation Array
        var explanationArrayF: [[String]] = [[]]
        var explanationArray: [String] = []
        // Extra Information Array
        var extraInformationArrayF: [[String]] = [[]]
        var extraInformationArray: [String] = []

    
    
    // Populate Arrays
    func populateArrays() {
        
        // Warmup Array
        warmupArray = zip(warmupMovementsArray.flatMap{$0},warmupMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
    
        // Sets Array
        setsArray = zip(setsArrayF.flatMap{$0},warmupMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        
        // Reps Array
        repsArray = zip(repsArrayF.flatMap{$0},warmupMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        
        // Demonstration Array
        demonstrationArray = zip(demonstrationArrayF.flatMap{$0},warmupMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        
        // Target Area Array
        targetAreaArray = zip(targetAreaArrayF.flatMap{$0},warmupMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        
        // Explanation Array
        explanationArray = zip(explanationArrayF.flatMap{$0},warmupMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        // Extra Information Array
        extraInformationArray = zip(extraInformationArray.flatMap{$0},warmupMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
    }
    
    
    
    //
    
    // Outlets
    //
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
        // Buttons
        @IBOutlet weak var nextButton: UIBarButtonItem!
        @IBOutlet weak var backButton: UIBarButtonItem!
    
    
    
    // Set Rep
    @IBOutlet weak var setRepView: UIView!
        // Buttons
        var setButton1 = UIButton()
        var setButton2 = UIButton()
        var setButton3 = UIButton()
    
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
        // Target Area Label
        @IBOutlet weak var targetAreaLabel: UILabel!
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
        populateArrays()
        
        
        // Background Gradient
        //
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        // Navigation Bar
        //
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        
        
        
        
        
        
        
        
        
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
        
        
        // Set Buttons
        switch setsArray[warmupScreenIndex] {
    
        case 1:
            setButton1.frame = CGRect(x: 0, y: self.setRepView.frame.size.height / 2 - 24.5, width: 49, height: 49)
            setButton1.center.x = self.setRepView.center.x
            setButton1.layer.borderWidth = 10
            setButton1.layer.borderColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0).cgColor
            setButton1.layer.cornerRadius = 24.5
            setButton1.addTarget(self, action: #selector(setButtonAction1), for: .touchUpInside)
            setButton1.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            setButton1.isEnabled = true
            
            self.setRepView.addSubview(setButton1)
            
            
        case 2:
           setButton1.frame = CGRect(x: (self.view.frame.size.width * (1/3) - 24.5), y: self.setRepView.frame.size.height / 2 - 24.5, width: 49, height: 49)
            setButton1.layer.borderWidth = 10
            setButton1.layer.borderColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0).cgColor
            setButton1.layer.cornerRadius = 24.5
            setButton1.addTarget(self, action: #selector(setButtonAction2), for: .touchUpInside)
            setButton1.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            setButton1.isEnabled = true
            
            self.setRepView.addSubview(setButton1)
            
            
            
            setButton2.frame = CGRect(x: (self.view.frame.size.width * (2/3) - 24.5), y: self.setRepView.frame.size.height / 2 - 24.5, width: 49, height: 49)
            setButton2.center.y = self.setRepView.center.y
            setButton2.layer.borderWidth = 10
            setButton2.layer.borderColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0).cgColor
            setButton2.layer.cornerRadius = 24.5
            setButton1.addTarget(self, action: #selector(setButtonAction2), for: .touchUpInside)
            setButton2.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            setButton2.isEnabled = true
            
            self.setRepView.addSubview(setButton2)
            
        
        case 3:
            setButton1.frame = CGRect(x: 0, y: self.setRepView.frame.size.height / 2 - 24.5, width: 49, height: 49)
            setButton1.center = self.setRepView.center
            setButton1.layer.borderWidth = 10
            setButton1.layer.borderColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0).cgColor
            setButton1.layer.cornerRadius = 24.5
            setButton1.addTarget(self, action: #selector(setButtonAction1), for: .touchUpInside)
            setButton1.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            setButton1.isEnabled = true
            
            self.setRepView.addSubview(setButton1)
            
            
            setButton2.frame = CGRect(x: 0, y: self.setRepView.frame.size.height / 2 - 24.5, width: 49, height: 49)
            setButton2.center = self.setRepView.center
            setButton2.layer.borderWidth = 10
            setButton2.layer.borderColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0).cgColor
            setButton2.layer.cornerRadius = 24.5
            setButton1.addTarget(self, action: #selector(setButtonAction1), for: .touchUpInside)
            setButton2.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            setButton2.isEnabled = true
            
            self.setRepView.addSubview(setButton2)
            
            
            
            setButton3.frame = CGRect(x: 0, y: self.setRepView.frame.size.height / 2 - 24.5, width: 49, height: 49)
            setButton3.center = self.setRepView.center
            setButton3.layer.borderWidth = 10
            setButton3.layer.borderColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0).cgColor
            setButton3.layer.cornerRadius = 24.5
            setButton1.addTarget(self, action: #selector(setButtonAction1), for: .touchUpInside)
            setButton3.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            setButton3.isEnabled = true
            
            self.setRepView.addSubview(setButton3)
            
        default:
            setButton1.removeFromSuperview()
            setButton2.removeFromSuperview()
            setButton3.removeFromSuperview()
        }
        
        
        
    
        // Body Image
        bodyImage.image = #imageLiteral(resourceName: "BodyImage")
        //bodyImage.image = targetAreaArray[warmupScreenIndex]
        
        
        
        
        // Explanation Label
        
        
        
        
        
        
        // Demonstration Image
        
        
        
        
        
        
        // Extra Information Label
        
        
        
        
        // Title Labels
            // Sets Reps
            self.setsRepsLabel.text = (String(setsArray[warmupScreenIndex]) + " x " + repsArray[warmupScreenIndex])
            // Demonstration
            self.demonstrationLabel.text = NSLocalizedString("demonstration", comment: "")
            // Target Area
            self.targetAreaLabel.text = NSLocalizedString("targetArea", comment: "")
            // Explanation
            self.explanationLabel.text = NSLocalizedString("explanation", comment: "")
            // Progress
            self.progressLabel.text = (String(warmupScreenIndex + 1)+"/"+String(warmupArray.count))
       
        
        
        // Progress Bar
        let warmupIndexP = Float(warmupScreenIndex)
        let warmupArrayP = Float(self.warmupArray.count)

        let fractionalProgress = warmupIndexP/warmupArrayP
    
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

    
    
    
    
    
    @IBAction func setButtonAction1() {
    
        self.setButton1.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
        self.setButton1.isEnabled = false
        
        
    }
    
    
    @IBAction func setButtonAction2(){
        
        
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
            setButton1.removeFromSuperview()
            setButton2.removeFromSuperview()
            setButton3.removeFromSuperview()
            displayContent()
        }
        
        flashScreen()
        
        
       
    }

    
    
    // Back Button
    @IBAction func backButton(_ sender: Any) {
        
        if warmupScreenIndex == 0 {
            
        } else {
            warmupScreenIndex = warmupScreenIndex - 1
            
            setButton1.removeFromSuperview()
            setButton2.removeFromSuperview()
            setButton3.removeFromSuperview()
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
