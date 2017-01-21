//
//  WarmupScreenLower.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 20.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import UserNotifications



class WarmupScreenLower: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
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
            ["2-5",
             "5-10",
             "5-10",
             "30-60s",
             "30-60s"],
            // Lower Back
            ["5-10",
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
             "15-30s",
             NSLocalizedString("asNecessary", comment: ""),
             NSLocalizedString("asNecessary", comment: "")
            ]
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
            // Foam/Ball Roll
            [#imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Thoracic"),
             #imageLiteral(resourceName: "Lat and Delt"),
             #imageLiteral(resourceName: "Pec and Front Delt"),
             #imageLiteral(resourceName: "Rear Delt")],
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
            // Accessory
            [#imageLiteral(resourceName: "Wrist and Ankle"),
             #imageLiteral(resourceName: "Lat"),
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
            // Foam/Ball Roll
            ["backfE",
             "thoracicSpineE",
             "latE",
             "pecDeltE",
             "rearDeltE"],
            // Lower Back
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
            // Accessory
            ["wristAnkleRotationE",
             "latStretchE",
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
    // Demonstration Image
    // Image View Position
    @IBOutlet weak var imageViewPosition: UIView!
    let leftDot = UILabel()
    let rightDot = UILabel()
    // Image Views
    let demonstrationImage1 = UIImageView()
    let demonstrationImage2 = UIImageView()
    
    
    
    
    // Explanation
    @IBOutlet weak var explanationExpand: UIButton!
    @IBOutlet weak var explanationRetract: UIButton!
    
    
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
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    
    
    
    
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
        self.view.applyGradient(colours: [colour1, colour2])
        
        backButton.tintColor = colour1
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colour1, NSFontAttributeName: UIFont(name: "SFUIDisplay-heavy", size: 23)!]
        
        
        //
        // Demonstration Image
        //
        
        // Demonstration Image Scroll View
        scrollViewDemonstration.contentSize = CGSize(width: scrollViewDemonstration.frame.size.width * 2, height: self.scrollViewDemonstration.frame.size.height)
        scrollViewDemonstration.isScrollEnabled = false
        
        
        // Demonstration Image Views
        
        demonstrationImage1.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        demonstrationImage1.addGestureRecognizer(leftSwipe)
        demonstrationImage1.isUserInteractionEnabled = true
        
        scrollViewDemonstration.addSubview(demonstrationImage1)
        
        
        
        demonstrationImage2.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        demonstrationImage2.addGestureRecognizer(rightSwipe)
        demonstrationImage2.isUserInteractionEnabled = true
        
        scrollViewDemonstration.addSubview(demonstrationImage2)
        
        
        
        
        
        // Image View Position
        imageViewPosition.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        
        // Timer View Left Indicator
        leftDot.layer.cornerRadius = 5
        leftDot.layer.masksToBounds = true
        
        imageViewPosition.addSubview(leftDot)
        
        
        // Timer View Right Indicator
        rightDot.layer.cornerRadius = 5
        rightDot.layer.masksToBounds = true
        
        imageViewPosition.addSubview(rightDot)
        
        
        leftDot.backgroundColor = colour2
        rightDot.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        
        
        
        
        
        
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
        
        
        
        
        // Retract Button
        let origImage2 = UIImage(named: "Minus")
        let tintedImage2 = origImage2?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        // Set Image
        explanationRetract.setImage(tintedImage2, for: .normal)
        
        //Image Tint
        explanationRetract.tintColor = colour1
        
        
        
        
        
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
        timerButton.tintColor = colour1
        timerButton2.tintColor = colour1
        
        
        
        
        // Timer View
        timerView.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        
        // Timer Elements
        //
        // Picker View Timer
        //
        pickerViewTimer.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        view.addSubview(pickerViewTimer)
        
        
        // Pick Minutes
        //
        minutePicker.dataSource = self
        minutePicker.delegate = self
        minutePicker.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        pickerViewTimer.addSubview(minutePicker)
        
        
        
        minuteLabel.text = NSLocalizedString("minutes", comment: "")
        minuteLabel.font = UIFont(name: "SFUIDisplay-light", size: 17)
        minuteLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        minuteLabel.textAlignment = .left
        
        pickerViewTimer.addSubview(minuteLabel)
        
        
        // Pick Seconds
        //
        secondPicker.dataSource = self
        secondPicker.delegate = self
        secondPicker.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        pickerViewTimer.addSubview(secondPicker)
        
        
        secondLabel.text = NSLocalizedString("seconds", comment: "")
        secondLabel.font = UIFont(name: "SFUIDisplay-light", size: 17)
        secondLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
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
        timerStart.titleLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        timerStart.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)
        timerStart.titleLabel?.textAlignment = .center
        
        timerStart.addTarget(self, action: #selector(startTimer(_:)), for: .touchUpInside)
        
        pickerViewTimer.addSubview(timerStart)
        
        
        
        // Cancel Button Timer
        //
        timerCancel.backgroundColor = colour1
        timerCancel.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        timerCancel.titleLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        timerCancel.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 18)
        timerCancel.titleLabel?.textAlignment = .center
        
        timerCancel.addTarget(self, action: #selector(cancelTimer(_:)), for: .touchUpInside)
        
        pickerViewTimer.addSubview(timerCancel)
        
        pickerViewTimer.bringSubview(toFront: timerStart)
        
        
        
        // Countdown Label
        countDownLabel.textAlignment = .center
        countDownLabel.font = UIFont(name: "SFUIDisplay-Light", size: 27)
        countDownLabel.text = "00:00"
        countDownLabel.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        
        self.timerView.addSubview(countDownLabel)
        
        
        //self.view.addSubview(timerView)
        //self.view.sendSubview(toBack: timerView)
        
        
        // App Moved To Background
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        
        
        
        
        
        
        
        
        
        
        // Explanation
        self.view.bringSubview(toFront: explanationExpand)
        self.explanationRetract.alpha = 0
        
        
        
        
        
        
        
        
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
        
        // Demonstration images
        demonstrationImage1.frame = CGRect(x: 0, y: 0, width: scrollViewDemonstration.frame.size.width, height: scrollViewDemonstration.frame.size.height)
        demonstrationImage2.frame = CGRect(x: scrollViewDemonstration.frame.size.width, y: 0, width: scrollViewDemonstration.frame.size.width, height: scrollViewDemonstration.frame.size.height)
        
        
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
        timerStart.layer.borderColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0).cgColor
        //
        timerCancel.frame = CGRect(x: 0, y: self.timerView.frame.size.height * (2/3), width: self.pickerViewTimer.frame.size.width, height: (self.timerView.frame.size.height*(1/3)))
        timerCancel.layer.borderWidth = timerCancel.frame.size.height/4
        timerCancel.layer.borderColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0).cgColor
        //
        countDownLabel.frame = CGRect(x: self.scrollViewExplanation.frame.size.width/2, y: 0, width: self.scrollViewExplanation.frame.size.width/2, height: self.timerView.frame.size.height)
        
        
        //
        leftDot.frame = CGRect(x: (self.imageViewPosition.frame.size.width * (4/10)) - 5, y: 1.25, width: 10, height: 10)
        rightDot.frame = CGRect(x: (self.imageViewPosition.frame.size.width * (6/10)) - 5, y: 1.25, width: 10, height: 10)
        
        
        
        
        
        
        
    }
    
    
    //
    // Generate Buttons
    //
    
    
    
    func createButton() -> UIButton {
        let setButton = UIButton()
        let widthHeight = NSLayoutConstraint(item: setButton, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: setButton, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        setButton.addConstraints([widthHeight])
        setButton.frame = CGRect(x: 0, y: 0, width: 49, height: 49)
        setButton.layer.borderWidth = 10
        setButton.layer.borderColor = colour1.cgColor
        setButton.layer.cornerRadius = 24.5
        setButton.addTarget(self, action: #selector(setButtonAction), for: .touchUpInside)
        setButton.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
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
            stackView.frame = CGRect(x: (self.view.frame.size.width / 2) - 24.5, y: 12.25, width: 49, height: 49)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            setRepView.addSubview(stackView)
            
            buttonArray[0].isEnabled = true
            
            
        } else if setsArray[warmupScreenIndex] == 2 {
            
            let stackView = UIStackView(arrangedSubviews: buttonArray)
            stackView.frame = CGRect(x: ((self.view.frame.size.width - 98) / 3), y: 12.25, width: ((self.view.frame.size.width - 98) / 3) + 98, height: 49)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            setRepView.addSubview(stackView)
            
            buttonArray[0].isEnabled = true
            
            
        } else if setsArray[warmupScreenIndex] == 3 {
            
            let stackView = UIStackView(arrangedSubviews: buttonArray)
            stackView.frame = CGRect(x: ((self.view.frame.size.width - 147) / 4), y: 12.25, width: ((2 * (self.view.frame.size.width - 147)) / 4) + 147, height: 49)
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            setRepView.addSubview(stackView)
            
            buttonArray[0].isEnabled = true
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    // Display Content Function
    func displayContent() {
        
        
        // Navigation Bar
        self.navigationItem.title = NSLocalizedString(warmupArray[warmupScreenIndex], comment: "")
        
        
        // Set Buttons
        let setRepSubViews = self.setRepView.subviews
        for subview in setRepSubViews{
            subview.removeFromSuperview()
        }
        buttonArray = []
        createButtonArray()
        
        
        // Demonstration Image
        scrollViewDemonstration.contentOffset.x = 0
        leftDot.backgroundColor = colour2
        rightDot.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        //demonstrationImage1.image = #imageLiteral(resourceName: "BodyImage")
        
        
        
        
        // Body Image
        bodyImage.image = targetAreaArray[warmupScreenIndex]
        
        
        
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
        
        if isExpanded == true {
            retractExplanation()
            self.explanationRetract.alpha = 0
            self.explanationExpand.alpha = 1
        }
        
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
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 23)!,NSForegroundColorAttributeName:UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)])
            rowLabel.attributedText = myTitle
            rowLabel.textAlignment = .center
            return rowLabel
            
        } else if pickerView == secondPicker {
            
            let rowLabel = UILabel()
            let titleData = String(secondData[row])
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "SFUIDisplay-light", size: 23)!,NSForegroundColorAttributeName:UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)])
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
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "restTimer", content: content, trigger: trigger)
            
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            
        } else {
            // Fallback on earlier versions
        }
        
        
        
        if setsArray[warmupScreenIndex] == 1 {
            
            
        } else if setsArray[warmupScreenIndex] == 2 {
            
            buttonArray[1].isEnabled = true
            
        } else if setsArray[warmupScreenIndex] == 3 {
            
            if buttonArray[1].isEnabled == false {
                
                buttonArray[1].isEnabled = true
                
            } else if buttonArray[0].isEnabled == false {
                buttonArray[2].isEnabled = true
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
        self.explanationRetract.alpha = 0
        self.explanationExpand.alpha = 1
        
        
        
    }
    
    
    
    // Expand and Retract Explanation
    
    
    var isExpanded = false
    
    func expandExplanation() {
        self.scrollViewExplanation.frame.size.height = self.scrollViewExplanation.frame.size.height + 73.5
        
        isExpanded = true
    }
    
    
    func retractExplanation() {
        self.scrollViewExplanation.frame.size.height = self.scrollViewExplanation.frame.size.height - 73.5
        
        isExpanded = false
    }
    
    
    
    @IBAction func explanationExpandAction(_ sender: Any) {
        
        expandExplanation()
        
        self.explanationExpand.alpha = 0
        self.explanationRetract.alpha = 1
        
    }
    
    @IBAction func explanationRetractAction(_ sender: Any) {
        
        retractExplanation()
        
        self.explanationRetract.alpha = 0
        self.explanationExpand.alpha = 1
    }
    
    
    
    
    
    
    
    // Handle Swipe
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .left) {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                self.scrollViewDemonstration.contentOffset.x = self.scrollViewDemonstration.frame.size.width
            }, completion: nil)
            
            
            leftDot.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            rightDot.backgroundColor = colour2
            
            
        } else if (extraSwipe.direction == .right) {
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                self.scrollViewDemonstration.contentOffset.x = 0
                
            }, completion: nil)
            
            
            leftDot.backgroundColor = colour2
            rightDot.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            
            
        }
        
        
        
        
        
    }
    
    
}
