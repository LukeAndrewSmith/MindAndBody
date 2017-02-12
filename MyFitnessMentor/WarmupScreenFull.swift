//
//  WarmupScreenFull.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 20.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import UserNotifications



class WarmupScreenFull: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    // Warmup Screen Index
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
            // Joint Rotations
            [1,
             1,
             1,
             1,
             1,
             1,
             1,
             1],
            // Foam/Ball Roll
            [1,
             3,
             1,
             1,
             1,
             1,
             1,
             1,
             1,
             1],
            // Lower Back
            [1,
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
            // General Mobility
            [1,
             1,
             1,
             1,
             1,
             2,
             1,
             1,
             2,
             1,
             1,
             2,
             2],
            // Accessory
            [1,
             1,
             1,
             1]
    ]
    var setsArray: [Int] = []
    // Sets Array
    var repsArrayF =
        [
            // Mandatory
            ["5min",
             "5min"],
            // Joint Rotations
            ["10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s",
             "10-30s"],
            // Foam/Ball Roll
            ["2-7 reps",
             "5-10 reps",
             "2-7 reps",
             "15-30s",
             "15-30s",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps",
             "2-7 reps"],
            // Lower Back
            ["5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "15-20 reps"],
            // Shoulder
            ["10-20 reps",
             "5-10 reps",
             "15 reps",
             "10 reps"],
            // Band/Bar/Machine Assisted
            ["10-15 reps",
             "5-15 reps",
             "5-10 reps",
             "5-10 reps",
             "10-15 reps",
             "10-20 reps"],
            // General Mobility
            ["10-15 reps",
             "5-10 reps",
             "5-10 reps",
             "5-10 reps",
             "10-15 reps",
             "15-30s",
             "15-30s",
             "5-10 reps",
             "10-20 reps",
             "10-20 reps",
             "10-20 reps",
             "5-15 reps",
             "10-15 reps"],
            // Accessory
            ["15-30s",
             "15-30s",
             NSLocalizedString("asNecessary", comment: ""),
             NSLocalizedString("asNecessary", comment: "")]
    ]
    var repsArray: [String] = []
    // Demonstration Array
    var demonstrationArrayF: [[UIImage]] = [[]]
    var demonstrationArray: [UIImage] = []
    // Target Area Array
    var targetAreaArrayF =
        [
            // Mandatory
            [#imageLiteral(resourceName: "Heart"),
             #imageLiteral(resourceName: "Heart")],
            // Joint Rotations
            [#imageLiteral(resourceName: "Wrist Joint"),
             #imageLiteral(resourceName: "Elbow Joint"),
             #imageLiteral(resourceName: "Shoulder Joint"),
             #imageLiteral(resourceName: "Neck Joint"),
             #imageLiteral(resourceName: "Waist Joint"),
             #imageLiteral(resourceName: "Hip Joint"),
             #imageLiteral(resourceName: "Knee Joint"),
             #imageLiteral(resourceName: "Ankle Joint")],
            // Foam/Ball Roll
            [#imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Lat and Delt"),
             #imageLiteral(resourceName: "Pec and Front Delt"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Quad"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hamstring"),
             #imageLiteral(resourceName: "Glute"),
             #imageLiteral(resourceName: "Calf")],
            // Lower Back
            [#imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Spine")],
            // Shoulder
            [#imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Back and Shoulder"),
             #imageLiteral(resourceName: "Serratus"),
             #imageLiteral(resourceName: "Shoulder")],
            // Band/Bar/Machine Assisted
            [#imageLiteral(resourceName: "Upper Back and Shoulder"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Rear Delt"),
             #imageLiteral(resourceName: "Back")],
            // General Mobility
            [#imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Hip Area"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Hamstring and Lower Back"),
             #imageLiteral(resourceName: "Piriformis"),
             #imageLiteral(resourceName: "Adductor"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Hamstring and Glute"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Quad, Hamstring and Glute Stretch"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat")],
            // Accessory
            [#imageLiteral(resourceName: "Lat"),
             #imageLiteral(resourceName: "Calf"),
             #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
             #imageLiteral(resourceName: "Back and Bicep")]
    ]
    
    var targetAreaArray: [UIImage] = []
    // Explanation Array
    var explanationArrayF =
        [
            // Mandatory
            ["5minCardioLE",
             "5minCardioIE"],
            // Joint Rotations
            ["wristE",
             "elbowE",
             "shoulderE",
             "neckE",
             "waistE",
             "hipE",
             "kneesE",
             "anklesE"],
            // Foam/Ball Roll
            ["backfE",
             "thoracicSpineE",
             "latE",
             "pecDeltE",
             "rearDeltE",
             "quadfE",
             "adductorfE",
             "hamstringfE",
             "glutefE",
             "calvefE"],
            // Back
            ["sideLegDropE",
             "sideLegKickE",
             "scorpionKickE",
             "sideBendE",
             "catCowE"],
            // Shoulder
            ["wallSlidesE",
             "superManShoulderE",
             "scapulaE",
             "shoulderRotationE"],
            // Band/Bar/Machine Assisted
            ["facePullE",
             "externalRotationE",
             "internalRotationE",
             "shoulderDislocationE",
             "rearDeltFlyE",
             "latPulloverE"],
            // General Mobility
            ["rollBackE",
             "hipCirclesE",
             "mountainClimberE",
             "groinStretchE",
             "gluteBridgeE",
             "threadTheNeedleE",
             "butterflyPoseE",
             "cossakSquatE",
             "hipHingesE",
             "sideLegSwingsE",
             "frontLegSwingsE",
             "jumpSquatE",
             "lungeE"],
            // Accessory
            ["latStretchE",
             "calveStretchE",
             "pushUpE",
             "pullUpE"]
    ]
    var explanationArray: [String] = []
    
    
    
    
    
    
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
        
    }
    
    
    
    //
    // Outlets
    //
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Navigation Title
    let navigationTitle = UILabel()
    
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
    
    // Explanation
    @IBOutlet weak var scrollViewExplanation: UIScrollView!
    
    
    // Image View
    @IBOutlet weak var bodyImage: UIImageView!
    
    // Demonstration Image
    @IBOutlet weak var demonstrationImage: UIImageView!
   
    
    
    @IBOutlet weak var imageExpand: UIButton!
    
    
    
    
    
    // Explanation
    @IBOutlet weak var explanationExpand: UIButton!
    
    
    // Timer
    // Timer View
    var timerView = UIView()
    // Timer Elements
    // Timer Countdown Label
    let countDownLabel = UILabel()
    // Timer Countdown
    var timerCountDown = Timer()
    // Timer Value
    var timerValue = 0
    // Timer Start
    var timerStart = UIButton()
    // Timer Cancel
    var timerCancel = UIButton()
    // Picker View
    // Picker Data
    var minuteData = [Int]()
    var secondData = [Int]()
    // Picker Views
    let minutePicker = UIPickerView()
    let secondPicker = UIPickerView()
    let minuteLabel = UILabel()
    let secondLabel = UILabel()
    var pickerViewTimer = UIView()
    // Timer Show Buttons
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timerButton2: UIButton!
    
    
    
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
    
    
    
    // Constraints
    @IBOutlet weak var setTop: NSLayoutConstraint!
    @IBOutlet weak var setBottom: NSLayoutConstraint!
    @IBOutlet weak var imageBottom: NSLayoutConstraint!
    @IBOutlet weak var explanationBottom: NSLayoutConstraint!
    
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour3 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour4 = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
    
    
    
    
    //
    // View Did Load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough3") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough3")
        }
        
        //Iphone 5/SE layout
        //
        if UIScreen.main.nativeBounds.height < 1334 {
           
            setTop.constant = 36.75
            setBottom.constant = 36.75
            imageBottom.constant = 36.75
            explanationBottom.constant = 36.75
        }
        
        
        
        
        
        
        // Create Arrays
        //
        populateArrays()
        
        
        // Background Gradient and Colours
        //
        self.view.applyGradient(colours: [colour1, colour2])
        
        backButton.tintColor = colour1
        
        //
        // Demonstration Image
        //
        demonstrationImage.backgroundColor = colour4
        
        
        demonstrationImage.image = #imageLiteral(resourceName: "Test 2")
        demonstrationImage.contentMode = .scaleAspectFit
        
        
        
        
        // Body Image View
        bodyImage.backgroundColor = colour4
        
        
        
        // Image Expand
        let origImageImage = UIImage(named: "Plus")
        let tintedImageImage = origImageImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        imageExpand.setImage(tintedImageImage, for: .normal)
        
        //Image Tint
        imageExpand.tintColor = colour4
        
        

        
        
        
        
        
        
        
        
        
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
        explanationExpand.tintColor = colour3
        
        
        
                //
        // Timer
        //
        // Timer Button
        self.view.bringSubview(toFront: timerButton)
        // Image With Tint
        let origImage3 = UIImage(named: "Timer")
        let tintedImage3 = origImage3?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        timerButton.setImage(tintedImage3, for: .normal)
        timerButton2.setImage(tintedImage3, for: .normal)
        
        //Image Tint
        timerButton.tintColor = colour4
        timerButton2.tintColor = colour3
        
        
        
        
        // Timer View
        timerView.backgroundColor = colour4
        
        
        // Timer Elements
        //
        // Picker View Timer
        //
        pickerViewTimer.backgroundColor = colour4
        view.addSubview(pickerViewTimer)
        
        
        // Pick Minutes
        //
        minutePicker.dataSource = self
        minutePicker.delegate = self
        minutePicker.backgroundColor = colour4
        
        pickerViewTimer.addSubview(minutePicker)
        
        
        
        minuteLabel.text = NSLocalizedString("minutes", comment: "")
        minuteLabel.font = UIFont(name: "SFUIDisplay-light", size: 17)
        minuteLabel.textColor = colour3
        minuteLabel.textAlignment = .left
        
        pickerViewTimer.addSubview(minuteLabel)
        
        
        // Pick Seconds
        //
        secondPicker.dataSource = self
        secondPicker.delegate = self
        secondPicker.backgroundColor = colour4
        
        pickerViewTimer.addSubview(secondPicker)
        
        
        secondLabel.text = NSLocalizedString("seconds", comment: "")
        secondLabel.font = UIFont(name: "SFUIDisplay-light", size: 17)
        secondLabel.textColor = colour3
        secondLabel.textAlignment = .left
        
        pickerViewTimer.addSubview(secondLabel)
        
        timerView.addSubview(pickerViewTimer)
        
        
        // Picker View Data
        //
        minuteData = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 30]
        secondData = [0, 15, 30, 45]
        
        
        // Start Button Timer
        //
        timerStart.backgroundColor = colour2
        timerStart.setTitle(NSLocalizedString("start", comment: ""), for: .normal)
        timerStart.titleLabel?.textColor = colour3
        timerStart.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)
        timerStart.titleLabel?.textAlignment = .center
        
        timerStart.addTarget(self, action: #selector(startTimer(_:)), for: .touchUpInside)
        
        pickerViewTimer.addSubview(timerStart)
        
        
        
        // Cancel Button Timer
        //
        timerCancel.backgroundColor = colour1
        timerCancel.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        timerCancel.titleLabel?.textColor = colour3
        timerCancel.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)
        timerCancel.titleLabel?.textAlignment = .center
        
        timerCancel.addTarget(self, action: #selector(cancelTimer(_:)), for: .touchUpInside)
        
        pickerViewTimer.addSubview(timerCancel)
        
        pickerViewTimer.bringSubview(toFront: timerStart)
        
        
        
        // Countdown Label
        countDownLabel.textAlignment = .center
        countDownLabel.font = UIFont(name: "SFUIDisplay-Light", size: 27)
        countDownLabel.text = "00:00"
        countDownLabel.textColor = colour3
        
        
        self.timerView.addSubview(countDownLabel)
        
        
        //self.view.addSubview(timerView)
        //self.view.sendSubview(toBack: timerView)
        
        
        // App Moved To Background
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        
        
        
        
        
        
        
        
        // Progress Bar
        //
        
        // Thickness
        
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 49, height: self.progressBarView.frame.size.height / 2)
        progressBar.center = progressBarView.center
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3)
        
        // Rounded Edges
        progressBar.layer.cornerRadius = self.progressBar.frame.size.height / 2
        progressBar.layer.masksToBounds = true
        
        // Initial state
        progressBar.setProgress(0, animated: true)
        
        
        
        // Display Content
        displayContent()
        
        
        
    }
    
    
    
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        //
        // Timer View
        //
        // Timer View
        //
        if UIScreen.main.nativeBounds.height < 1334 {
            timerView.frame = CGRect(x: 0, y: 0, width: self.scrollViewExplanation.frame.size.width, height: self.scrollViewExplanation.frame.size.height + 73.5)
            timerView.center.x = scrollViewExplanation.center.x
            timerView.center.y = scrollViewExplanation.center.y + 36.75
        } else {
            timerView.frame = CGRect(x: 0, y: 0, width: self.scrollViewExplanation.frame.size.width, height: self.scrollViewExplanation.frame.size.height)
            timerView.center.x = scrollViewExplanation.center.x
            timerView.center.y = scrollViewExplanation.center.y
        }
        // Timer View Elements
        //
        pickerViewTimer.frame = CGRect(x: 0, y: 0, width: self.scrollViewExplanation.frame.size.width/2, height: self.timerView.frame.size.height)
        //
        
        
        
        minutePicker.frame = CGRect(x: 10, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        minuteLabel.frame = CGRect(x: 10 + minutePicker.frame.size.width, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        
        //
        secondPicker.frame = CGRect(x: 10 + minutePicker.frame.size.width + minuteLabel.frame.size.width, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        secondLabel.frame = CGRect(x: 10 + minutePicker.frame.size.width + minuteLabel.frame.size.width + secondPicker.frame.size.width, y: 0, width: (pickerViewTimer.frame.size.width - 20) / 4, height: pickerViewTimer.frame.size.height*(2/3))
        
        //
        timerStart.frame = CGRect(x: 0, y: self.timerView.frame.size.height * (2/3), width: self.pickerViewTimer.frame.size.width, height: (self.timerView.frame.size.height*(1/3)))
        timerStart.layer.borderWidth = timerStart.frame.size.height/4
        timerStart.layer.borderColor = colour4.cgColor
        //
        timerCancel.frame = CGRect(x: 0, y: self.timerView.frame.size.height * (2/3), width: self.pickerViewTimer.frame.size.width, height: (self.timerView.frame.size.height*(1/3)))
        timerCancel.layer.borderWidth = timerCancel.frame.size.height/4
        timerCancel.layer.borderColor = colour4.cgColor
        //
        countDownLabel.frame = CGRect(x: self.scrollViewExplanation.frame.size.width/2, y: 0, width: self.scrollViewExplanation.frame.size.width/2, height: self.timerView.frame.size.height)
        
        
    }
    
    
    //
    // Generate Buttons
    //
    
    
    
    func createButton() -> UIButton {
        let setButton = UIButton()
        let widthHeight = NSLayoutConstraint(item: setButton, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: setButton, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        setButton.addConstraints([widthHeight])
        setButton.frame = CGRect(x: 0, y: 0, width: 42.875, height: 42.875)
        setButton.layer.borderWidth = 4
        setButton.layer.borderColor = colour1.cgColor
        setButton.layer.cornerRadius = 21.4375
        setButton.addTarget(self, action: #selector(setButtonAction), for: .touchUpInside)
        setButton.backgroundColor = colour3
        setButton.isEnabled = false
        
        
        
        setRepView.addSubview(setButton)
        
        return setButton
    }
    
    
    var buttonArray = [UIButton]()
    
    func createButtonArray(){
        //generate an array of buttons
        
        
        let numberOfButtons = setsArray[warmupScreenIndex]
        
        for _ in 1...numberOfButtons{
            buttonArray += [createButton()]
            
        }
        
        
        if setsArray[warmupScreenIndex] == 1 {
            
            let stackView = UIStackView(arrangedSubviews: buttonArray)
            stackView.frame = CGRect(x: (self.view.frame.size.width / 2) - 24.5, y: 9.1875, width: 42.875, height: 42.875)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            setRepView.addSubview(stackView)
            
            buttonArray[0].isEnabled = true
            
            
        } else if setsArray[warmupScreenIndex] == 2 {
            
            let stackView = UIStackView(arrangedSubviews: buttonArray)
            stackView.frame = CGRect(x: ((self.view.frame.size.width - 85.75) / 3), y: 9.1875, width: ((self.view.frame.size.width - 85.75) / 3) + 85.75, height: 42.875)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            setRepView.addSubview(stackView)
            
            buttonArray[0].isEnabled = true
            
            
        } else if setsArray[warmupScreenIndex] == 3 {
            
            let stackView = UIStackView(arrangedSubviews: buttonArray)
            stackView.frame = CGRect(x: ((self.view.frame.size.width - 128.625) / 4), y: 9.1875, width: ((2 * (self.view.frame.size.width - 128.625)) / 4) + 128.625, height: 42.875)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            setRepView.addSubview(stackView)
            
            buttonArray[0].isEnabled = true
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    // Display Content Function
    func displayContent() {
        
        
        // Navigation Bar
        self.navigationTitle.text = NSLocalizedString(warmupArray[warmupScreenIndex], comment: "")
        
        
        // Navigation Title
        //
        navigationTitle.frame = (navigationController?.navigationItem.accessibilityFrame)!
        navigationTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        navigationTitle.center.x = self.view.center.x
        navigationTitle.textColor = colour1
        navigationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 22)
        navigationTitle.backgroundColor = .clear
        navigationTitle.textAlignment = .center
        navigationTitle.adjustsFontSizeToFitWidth = true
        
        self.navigationController?.navigationBar.topItem?.titleView = navigationTitle
        
        

        
        
        // Set Buttons
        let setRepSubViews = self.setRepView.subviews
        for subview in setRepSubViews{
            subview.removeFromSuperview()
        }
        buttonArray = []
        createButtonArray()
        
        
        
        
        // Body Image
        bodyImage.image = targetAreaArray[warmupScreenIndex]
        bodyImage.contentMode = .scaleAspectFit
        
        
        
        // Explanation Text and Scroll View
        let attributedExplanation = NSMutableAttributedString(string: NSLocalizedString(explanationArray[warmupScreenIndex], comment: ""))
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
        
        
        
        
        // Timer to Back
        self.scrollViewExplanation.alpha = 1
        timerView.removeFromSuperview()
        //self.view.bringSubview(toFront: scrollViewExplanation)
        self.view.bringSubview(toFront: timerButton)
        cancelTimer(Any.self)
        
        
        
        
        // Explanation
    
        self.scrollViewExplanation.contentOffset.y = 0
        
        
        self.view.bringSubview(toFront: scrollViewExplanation)
        
        
        
        
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //
    // Count Down Timer
    //
    
    
    // Timer CountDown Value
    func setTimerValue() {
        
        let minutesSelectedRow = minutePicker.selectedRow(inComponent: 0)
        let minutes = minuteData[minutesSelectedRow]
        
        let secondsSelectedRow = secondPicker.selectedRow(inComponent: 0)
        let seconds = secondData[secondsSelectedRow]
        
        self.timerValue = (minutes * 60) + seconds
        
    }
    
    
    // Timer CountDown Title
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    
    // Update Timer
    func updateTimer() {
        
        
        if timerValue == 0{
            self.timerCountDown.invalidate()
            removeCircle()
            self.pickerViewTimer.bringSubview(toFront: timerStart)
            
        } else if timerValue == 1 {
            
            timerValue -= 1
            countDownLabel.text = timeFormatted(totalSeconds: timerValue)
            
        } else {
            timerValue -= 1
            countDownLabel.text = timeFormatted(totalSeconds: timerValue)
            
        }
        
    }
    
    
    let timerShapeLayer = CAShapeLayer()
    
    // Funcs
    func addCircle() {
        let circlePath = UIBezierPath(arcCenter: countDownLabel.center, radius: CGFloat((timerView.frame.size.height-10)/2), startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(2*M_PI-M_PI_2), clockwise: true)
        timerShapeLayer.path = circlePath.cgPath
        timerShapeLayer.fillColor = UIColor.clear.cgColor
        timerShapeLayer.strokeColor = colour1.cgColor
        timerShapeLayer.lineWidth = 1.0
        
        timerView.layer.addSublayer(timerShapeLayer)
        
    }
    
    func removeCircle() {
        
        timerShapeLayer.removeFromSuperlayer()
        
    }
    
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double(timerValue)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        timerShapeLayer.add(animation, forKey: "circleAnimation")
        
        
    }
    
    
    @IBAction func startTimer(_ sender: Any) {
        
        setTimerValue()
        
        
        if timerValue == 0 {
            
        } else {
            
            
            self.pickerViewTimer.bringSubview(toFront: timerCancel)
            
            self.countDownLabel.text = timeFormatted(totalSeconds: timerValue)
            
            let delayInSeconds = 0.1
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                
                self.addCircle()
                self.startAnimation()
                self.timerCountDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
                
                
                
                if #available(iOS 10.0, *) {
                    
                    let content = UNMutableNotificationContent()
                    content.title = NSLocalizedString("timerEnd", comment: "")
                    content.body = " "
                    content.sound = UNNotificationSound.default()
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(self.timerValue), repeats: false)
                    let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
                    
                    
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                    
                    
                } else {
                    // Fallback on earlier versions
                }
                
                
                
            }
            
        }
        
    }
    
    
    
    @IBAction func cancelTimer(_ sender: Any) {
        
        
        self.timerCountDown.invalidate()
        self.timerValue = 0
        self.countDownLabel.text = "00:00"
        removeCircle()
        self.pickerViewTimer.bringSubview(toFront: timerStart)
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timer"])
        
    }
    
    
    
    // Picker Views
    //
    
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        
        if pickerView == minutePicker {
            return 14
        } else if pickerView == secondPicker {
            return 4
        }
        
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == minutePicker {
            
            let rowLabel = UILabel()
            let titleData = String(minuteData[row])
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 23)!,NSForegroundColorAttributeName:colour3])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
        } else if pickerView == secondPicker {
            
            let rowLabel = UILabel()
            let titleData = String(secondData[row])
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 23)!,NSForegroundColorAttributeName:colour3])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
        }
        
        return UIView()
    }
    
    
    // Background
    func appMovedToBackground() {
        
        self.timerCountDown.invalidate()
        self.timerValue = 0
        removeCircle()
        self.countDownLabel.text = "00:00"
        self.pickerViewTimer.bringSubview(toFront: timerStart)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //
    // Button Actions
    //
    
    
    var buttonNumber = 0
    
    // Set Button
    @IBAction func setButtonAction(sender: UIButton) {
        
        //
        // Rest Timer Notification
        //
        if #available(iOS 10.0, *) {
            
            let content = UNMutableNotificationContent()
            content.title = NSLocalizedString("restOver", comment: "")
            content.body = NSLocalizedString("nextSet", comment: "")
            content.sound = UNNotificationSound.default()
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
            let request = UNNotificationRequest(identifier: "restTimer", content: content, trigger: trigger)
            
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            
        }
        
        
        buttonArray[buttonNumber].isEnabled = false
        
        let delayInSeconds = 30.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            
            if self.buttonNumber < 2 {
                self.buttonNumber = self.buttonNumber + 1
                self.buttonArray[self.buttonNumber].isEnabled = true
            }
        }
        
        sender.backgroundColor = colour2
        sender.isEnabled = false
        
    }
    
    
    
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
    
    
    
    // Display TimerView
    @IBAction func timerViewButton(_ sender: Any) {
        
        self.view.addSubview(timerView)
        self.view.bringSubview(toFront: timerView)
        
        
        self.view.bringSubview(toFront: timerButton2)
        self.explanationLabel.text = NSLocalizedString("timer", comment: "")
        
        
        
        
        // Ensure Explanation Hidden
        self.scrollViewExplanation.alpha = 0
        
        
        
    }
    
    
    @IBAction func timerViewButton2(_ sender: Any) {
        
        
        timerView.removeFromSuperview()
        
        self.view.bringSubview(toFront: timerButton)
        self.explanationLabel.text = NSLocalizedString("explanation", comment: "")
        
        
        
        // Ensure Explanation Hidden
        self.scrollViewExplanation.alpha = 1
        self.explanationExpand.alpha = 1
        
        
        
    }
    
    
    
    
    
    
    // Expand and Retract Images
    //
    
    
    let imageViewExpanded = UIView()
    let backgroundViewExpanded = UIButton()
    let cancelButtonImage = UIButton()
    
    let bodyImageExpanded = UIImageView()
    let demonstrationImageExpanded = UIImageView()
    
    let targetButton = UIButton()
    let demonstrationButton = UIButton()


    
    @IBAction func expandImage(_ sender: Any) {
        
        //Screen Size
        //
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        
        // View
        //
        imageViewExpanded.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: (view.frame.size.height * (2/3) + 36.75))
        imageViewExpanded.center.x = width/2
        imageViewExpanded.center.y = height/2
        imageViewExpanded.isUserInteractionEnabled = true
        
        imageViewExpanded.backgroundColor = colour4
        
        
        
        // Background View
        //
        backgroundViewExpanded.frame = CGRect(x: 0, y: 0, width: width, height: height)
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.alpha = 0.5
        
        backgroundViewExpanded.addTarget(self, action: #selector(retractImage), for: .touchUpInside)
        
        
        
        
        // Cancel Button
        //
        cancelButtonImage.frame = CGRect(x: 0, y: 0, width: 36.75, height: 36.75)
        cancelButtonImage.center.y = imageViewExpanded.frame.minY/2
        cancelButtonImage.center.x = imageViewExpanded.frame.maxX - (imageViewExpanded.frame.minY/2)
        
        cancelButtonImage.addTarget(self, action: #selector(retractImage), for: .touchUpInside)
        cancelButtonImage.layer.cornerRadius = 18.375
        cancelButtonImage.layer.masksToBounds = true
        
        
        cancelButtonImage.backgroundColor = colour3
        
        let origImage = UIImage(named: "Minus")
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        cancelButtonImage.setImage(tintedImage, for: .normal)
        //Image Tint
        cancelButtonImage.tintColor = colour4
        
        
        
        
        
        
        
        // Demonstration or Body Image
        //
        // Demonstration
        demonstrationButton.isEnabled = true
        demonstrationButton.frame = CGRect(x: 0, y: 0, width: imageViewExpanded.frame.size.width/2, height: 36.75)
        demonstrationButton.setTitle(NSLocalizedString("demonstration", comment: ""), for: .normal)
        demonstrationButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 20)
        demonstrationButton.addTarget(self, action: #selector(demonstrationImageButton(_:)), for: .touchUpInside)
        
        imageViewExpanded.addSubview(demonstrationButton)
        
        
        demonstrationButton.backgroundColor = .white
        demonstrationButton.setTitleColor(colour2, for: .normal)
        
        // Target
        targetButton.frame = CGRect(x: imageViewExpanded.frame.size.width/2, y: 0, width: imageViewExpanded.frame.size.width/2, height: 36.75)
        
        targetButton.setTitle(NSLocalizedString("targetArea", comment: ""), for: .normal)
        targetButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 20)
        targetButton.addTarget(self, action: #selector(bodyImageButton(_:)), for: .touchUpInside)
        
        targetButton.backgroundColor = .white
        targetButton.setTitleColor(colour2, for: .normal)
        
        imageViewExpanded.addSubview(targetButton)
        
        
        
        
        // Seperator
        let seperator = UILabel()
        seperator.frame = CGRect(x: 0, y: 0, width: 1, height: 36.75)
        seperator.center.x = imageViewExpanded.center.x
        seperator.backgroundColor = colour4
        
        imageViewExpanded.addSubview(seperator)
        
        
        
        
        // Order
        imageViewExpanded.bringSubview(toFront: demonstrationImageExpanded)
        demonstrationImageExpanded.alpha = 1
        bodyImageExpanded.alpha = 0
        demonstrationButton.backgroundColor = colour3
        
        
        
        
        
        
        
        
        
        // View Contents
        //
        // Body Image
        bodyImageExpanded.frame = CGRect(x: 0, y: 36.75, width: imageViewExpanded.frame.size.width, height: imageViewExpanded.frame.size.height - 36.75)
        bodyImageExpanded.image = targetAreaArray[warmupScreenIndex]
        bodyImageExpanded.contentMode = .scaleAspectFit
        
        imageViewExpanded.addSubview(bodyImageExpanded)
        
        
        
        // Demonstration Image
        demonstrationImageExpanded.frame = CGRect(x: 0, y: 36.75, width: imageViewExpanded.frame.size.width, height: imageViewExpanded.frame.size.height - 36.75)
        demonstrationImageExpanded.backgroundColor = colour4
        
        
        demonstrationImageExpanded.image = #imageLiteral(resourceName: "Test 2")
        demonstrationImageExpanded.contentMode = .scaleAspectFit
        
        imageViewExpanded.addSubview(demonstrationImageExpanded)
        
        
        
        
        // Add Subviews
        //
        view.addSubview(backgroundViewExpanded)
        view.addSubview(imageViewExpanded)
        view.addSubview(cancelButtonImage)
        
        
        view.bringSubview(toFront: backgroundViewExpanded)
        view.bringSubview(toFront: imageViewExpanded)
        view.bringSubview(toFront: cancelButtonImage)
        
        view.bringSubview(toFront: seperator)
        
        nextButton.isEnabled = false
        backButton.isEnabled = false
        
    }
    
    @IBAction func demonstrationImageButton(_ sender: Any) {
        
        imageViewExpanded.bringSubview(toFront: demonstrationImageExpanded)
        demonstrationImageExpanded.alpha = 1
        bodyImageExpanded.alpha = 0
        
        demonstrationButton.backgroundColor = colour3
        targetButton.backgroundColor = .white
        
    }
    
    @IBAction func bodyImageButton(_ sender: Any) {
        
        imageViewExpanded.bringSubview(toFront: bodyImageExpanded)
        bodyImageExpanded.alpha = 1
        demonstrationImageExpanded.alpha = 0
        
        targetButton.backgroundColor = colour3
        demonstrationButton.backgroundColor = .white
    }
    
    
    @IBAction func retractImage(_ sender: Any) {
        
        imageViewExpanded.bringSubview(toFront: demonstrationImageExpanded)
        
        imageViewExpanded.removeFromSuperview()
        backgroundViewExpanded.removeFromSuperview()
        cancelButtonImage.removeFromSuperview()
        
        
        nextButton.isEnabled = true
        backButton.isEnabled = true
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
        
        scrollViewExplanationE.backgroundColor = colour3
        
        
        
        // Background View
        //
        backgroundViewExplanationE.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        backgroundViewExplanationE.backgroundColor = .black
        backgroundViewExplanationE.alpha = 0.5
        
        backgroundViewExplanationE.addTarget(self, action: #selector(retractExplanation(_:)), for: .touchUpInside)
        
        
        
        
        // Cancel Button
        //
        cancelButtonExplanationE.frame = CGRect(x: 0, y: 0, width: 36.75, height: 36.75)
        cancelButtonExplanationE.center.y = scrollViewExplanationE.frame.minY/2
        cancelButtonExplanationE.center.x = scrollViewExplanationE.frame.maxX - (scrollViewExplanationE.frame.minY/2)
        
        cancelButtonExplanationE.addTarget(self, action: #selector(retractExplanation(_:)), for: .touchUpInside)
        cancelButtonExplanationE.layer.cornerRadius = 18.375
        cancelButtonExplanationE.layer.masksToBounds = true
        
        
        cancelButtonExplanationE.backgroundColor = colour3
        
        let origImage = UIImage(named: "Minus")
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        cancelButtonExplanationE.setImage(tintedImage, for: .normal)
        //Image Tint
        cancelButtonExplanationE.tintColor = colour4
        
        
        
        
        // Contents
        //
        explanationLabelE.font = UIFont(name: "SFUIDisplay-light", size: 19)
        explanationLabelE.textColor = .black
        explanationLabelE.textAlignment = .justified
        explanationLabelE.lineBreakMode = NSLineBreakMode.byWordWrapping
        explanationLabelE.numberOfLines = 0
        
        
        let attributedStringE = NSMutableAttributedString(string: NSLocalizedString(explanationArray[warmupScreenIndex], comment: ""))
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
    
    
//---------------------------------------------------------------------------------------------------------------
    
    
    var  viewNumber = 0
    let walkthroughView = UIView()
    let label = UILabel()
    let nextButtonW = UIButton()
    let backButtonW = UIButton()
    
    
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
        nextButtonW.frame = screenSize
        nextButtonW.backgroundColor = .clear
        nextButtonW.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
        //
        backButtonW.frame = CGRect(x: 3, y: UIApplication.shared.statusBarFrame.height, width: 50, height: navigationBarHeight)
        backButtonW.setTitle("Back", for: .normal)
        backButtonW.titleLabel?.textAlignment = .left
        backButtonW.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        backButtonW.titleLabel?.textColor = .white
        backButtonW.addTarget(self, action: #selector(backWalkthroughView(_:)), for: .touchUpInside)
        
        
        
        
        switch viewNumber {
            
        case 0:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: view.frame.size.width/2 - ((navigationTitle.frame.size.width + 50) / 2), y: UIApplication.shared.statusBarFrame.height, width: navigationTitle.frame.size.width + 50, height: 40))
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
            
            
            label.text = NSLocalizedString("movementScreen1", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            
            
            

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
            
            
            label.text = NSLocalizedString("movementScreen2", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
        case 2:
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width * 0.083, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
            
            
            label.text = NSLocalizedString("movementScreen3", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            backButtonW.setTitle("", for: .normal)
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
        case 3:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + (setTop.constant / 2), width: setsRepsLabel.frame.size.width + 6, height: setTop.constant/2))
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
            
            
            label.text = NSLocalizedString("movementScreen4", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
        case 4:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + setTop.constant, width: setRepView.frame.size.width, height: setRepView.frame.size.height))
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
            
            
            label.text = NSLocalizedString("movementScreen5", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
        case 5:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + (setTop.constant * 2) + setRepView.frame.size.height , width: demonstrationImage.frame.size.width, height: demonstrationImage.frame.size.height))
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
            
            label.center.y = scrollViewExplanation.frame.maxY
            label.text = NSLocalizedString("movementScreen6", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
        case 6:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: demonstrationImage.frame.size.width + 1, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + (setTop.constant * 2) + setRepView.frame.size.height , width: demonstrationImage.frame.size.width, height: demonstrationImage.frame.size.height))
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
            
            label.center.y = scrollViewExplanation.frame.maxY
            label.text = NSLocalizedString("movementScreen7", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
            
        case 7:
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: imageExpand.center.x, y: imageExpand.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.size.height), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
            
            
            label.text = NSLocalizedString("movementScreen8", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            

            
        case 8:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + (setTop.constant * 3) + setRepView.frame.size.height + demonstrationImage.frame.size.height, width: scrollViewExplanation.frame.size.width, height: scrollViewExplanation.frame.size.height))
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
            
            label.center.y = demonstrationImage.frame.maxY + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.text = NSLocalizedString("movementScreen9", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
        case 9:
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: explanationExpand.center.x, y: explanationExpand.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.size.height), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
            
            
            label.center.y = demonstrationImage.frame.maxY + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.text = NSLocalizedString("movementScreen10", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            
            
        case 10:
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: timerButton.center.x, y: timerButton.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.size.height), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
            
            label.center.y = demonstrationImage.frame.maxY + navigationBarHeight + UIApplication.shared.statusBarFrame.height
            label.text = NSLocalizedString("movementScreen11", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            

        case 11:
            // Clear Section
            let path = CGMutablePath()
            let y = navigationBarHeight + UIApplication.shared.statusBarFrame.height + (setTop.constant * 3.5)
            let yValue = y + scrollViewExplanation.frame.size.height + setRepView.frame.size.height + demonstrationImage.frame.size.height
            path.addRect(CGRect(x: 0, y: yValue, width: progressLabel.frame.size.width + 6, height: progressLabel.frame.size.height))
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
            
            
            label.text = NSLocalizedString("movementScreen12", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            

            
        case 12:
            // Clear Section
            let path = CGMutablePath()
            let y = navigationBarHeight + UIApplication.shared.statusBarFrame.height + (setTop.constant * 4)
            let yValue = y + scrollViewExplanation.frame.size.height + setRepView.frame.size.height + demonstrationImage.frame.size.height
            path.addRect(CGRect(x: 0, y: yValue, width: view.frame.size.width, height: progressBarView.frame.size.height))
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
            
            
            label.text = NSLocalizedString("movementScreen13", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButtonW)
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            walkthroughView.bringSubview(toFront: backButtonW)
            


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
            backButtonW.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
        
    }
    
    
    
    
}
