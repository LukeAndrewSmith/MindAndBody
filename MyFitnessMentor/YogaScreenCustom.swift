//
//  YogaScreenCustom.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 31.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import UserNotifications



class YogaScreenCustom: UIViewController, UIScrollViewDelegate {
    
    
    
    
    // Warmup Screen Index
    //
    var warmupScreenIndex = 0
    
    
    
    // Initialize Arrays
    // Key Array
    var keyArray = [Int]()
    // Poses Dictrionary
    var poses = [Int: String]()
    
    let posesSanscrit =
        [
            // Standing
            0: "Urdhva Hastasana",
            1: "Tāḍāsana",
            2: "Vṛkṣāsana",
            3: "Hasta Pādāṅguṣṭhāsana",
            4: "Garuḍāsana",
            5: "Utkaṭāsana",
            6: "Naṭarājāsana",
            7: "Vīrabhadrāsana I",
            8: "Vīrabhadrāsana II",
            9: "Vīrabhadrāsana III",
            10: "Ardha Chandrāsana",
            11: "Trikoṇāsana",
            12: "Utthita Pārśvakoṇāsana",
            13: "Parivrtta Parsvakonasana",
            14: "Parivrtta Trikoṇāsana",
            15: "Ardha Uttānāsana",
            16: "Uttānāsana",
            17: "Prasāritapādottānāsana",
            18: "Parsvottanasana",
            19: "Parighasana",
            20: "Utthita Ashwa Sanchalanasana",
            21: "Anjaneyasana",
            22: "Malasana",
            // Hand/Elbows and Feet/Knees
            23: "Ardha Pincha Mayurasana",
            24: "Adho mukha śvānāsana",
            25: "Eka Pāda Adho Mukha Śvānāsana",
            26: "Phalakasana",
            27: "Makara Adho Mukha Svanasana",
            28: "Chaturanga Dandasana",
            29: "Vasisthasana",
            30: "Mārjāryāsana",
            31: "Bitilasana",
            32: "Kowtow",
            33: "Utthita Cakravākāsana",
            34: "Vyagrasana",
            35: "Ardha Hanumanasana",
            36: "Bālāsana",            //
            37: "Camatkarasana",
            38: "Urdhva Dhanurasana",
            39: "Setubandha Sarvāṅgāsana",
            40: "Purvottanasana",
            41: "Uttana Shishosana",
            42: "Urdhva Mukha Svanasana",
            43: "Kneeling Bridge",
            // Seated
            44: "Sukhasana",
            45: "Padmāsana",
            46: "Agnistambhasana",
            47: "Navasana",
            48: "Gomukhasana",
            49: "Virasana",
            50: "Krāuñcāsana",
            51: "Baddha Koṇāsana",            //
            52: "Dandasana",
            53: "Ākarṇa dhanurāsana",
            54: "Paschimottanasana",
            55: "Upavistha Konasana",
            56: "Janu Sirsasana",
            57: "PARIVRTTA JANU SIRSASANA",
            58: "Marichyasana I",
            59: "maMarichyasana IIIrichi3",
            60: "Bharadvajasana I",
            61: "Ardha Matsyendrāsana",
            62: "Hanumanasana",
            63: "Upaviṣṭha Koṇāsana",
            // Lying
            64: "Shavasana",
            65: "Supta Tadasana",
            66: "Matsyasana",
            67: "Supta Baddha Konasana",
            68: "Leg Raise Toe Grab",
            69: "threadTheNeedle",
            70: "Salamba Sarvangasana",
            71: "Halasana",
            72: "Bhekasana",
            73: "Bhujangasana",
            74: "Salamba Bhujangasana",
            75: "Kapotasana",
            76: "Spine Rolling",
            // Hand Stands
            77: "Adho Mukha Vrksasana",
            78: "Sirsasana",
            79: "Salamba Sirsasana",
            80: "Pincha Mayūrāsana"
            
    ]
    
    
    
    let explanationDictionary =
        [
            // Standing
            0: "upwardsSaluteE",
            1: "mountainE",
            2: "treeE",
            3: "extendedHandToeE",
            4: "eagleE",
            5: "chairE",
            6: "lordOfDanceE",
            7: "warrior1E",
            8: "warrior2E",
            9: "warrior3E",
            10: "halfMoonE",
            11: "extendedTriangleE",
            12: "extendedSideAngleYE",
            13: "revolvedSideAngleE",
            14: "revolvedTriangleE",
            15: "halfForwardBendE",
            16: "forwardBendE",
            17: "wideLeggedForwardBendE",
            18: "intenseSideE",
            19: "gateE",
            20: "highLungeE",
            21: "lungeYE",
            22: "deepSquatE",
            // Hand/Elbows and Feet/Knees
            23: "dolphinE",
            24: "downwardDogE",
            25: "halfDownwardDogE",
            26: "plankE",
            27: "dolphinPlankE",
            28: "fourLimbedStaffE",
            29: "sidePlankE",
            30: "catE",
            31: "cowE",
            32: "kowtowE",
            33: "catBalanceE",
            34: "dynamicTigerE",
            35: "halfMonkeyE",
            36: "childPoseE",            //
            37: "wildThingE",
            38: "upwardBowE",
            39: "bridgeE",
            40: "upwardPlankE",
            41: "extendedPuppyE",
            42: "upwardDogE",
            43: "kneelingBridgeE",
            // Seated
            44: "crossLegE",
            45: "lotusE",
            46: "fireLogE",
            47: "boatE",
            48: "cowFaceE",
            49: "heroE",
            50: "heronE",
            51: "butterflyE",            //
            52: "staffPoseE",
            53: "archerE",
            54: "forwardBendE",
            55: "vForwardBendE",
            56: "halfVForwardPoseE",
            57: "halfVSideBendE",
            58: "marichi1E",
            59: "marichi3E",
            60: "bharadvajaTwistE",
            61: "halfLordFishE",
            62: "frontSplitE",
            63: "sideSplitE",
            // Lying
            64: "corpseE",
            65: "lyingMountainE",
            66: "fishE",
            67: "lyingButterflyE",
            68: "legRaiseToeE",
            69: "threadTheNeedleE",
            70: "shoulderStandE",
            71: "plowE",
            72: "frogE",
            73: "cobraE",
            74: "sphinxE",
            75: "pigeonE",
            76: "spineRollingE",
            // Hand Stands
            77: "handstandE",
            78: "headstandE",
            79: "flatHandHandstandE",
            80: "forearmStandE"
            
    ]
    
    
    //
    
    // Outlets
    //
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    let navigationTitle = UILabel()
    // Buttons
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    
    // Image View
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    // Scroll Views
    // Explanation
    @IBOutlet weak var scrollViewExplanation: UIScrollView!
    
    
    
    // Explanation Expand
    @IBOutlet weak var explanationExpand: UIButton!
    
    
    // Progress Bar
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    // Title Labels
    // Sets and Reps
    @IBOutlet weak var setsRepsLabel: UILabel!
    // Explanation Label
    @IBOutlet weak var explanationLabel: UILabel!
    let explanationText = UILabel()
    // Progress Label
    @IBOutlet weak var progressLabel: UILabel!
    
    // Constraints
    @IBOutlet weak var breathTop: NSLayoutConstraint!
    @IBOutlet weak var imageTop: NSLayoutConstraint!
    @IBOutlet weak var imageBottom: NSLayoutConstraint!
    @IBOutlet weak var explanationBottom: NSLayoutConstraint!
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour3 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour4 = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
    
    
    // View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        
        // Poses Names Array
        //UserDefaults.standard.register(defaults: ["posesNames": poses])
        
        
    }
    
    
    //
    // View Did Load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Iphone 5/SE layout
        //
        if UIScreen.main.nativeBounds.height < 1334 {
            breathTop.constant = 6.125
            imageTop.constant = 36.75
            imageBottom.constant = 36.75
            explanationBottom.constant = 36.75
        }
        
        
        
        // Background Gradient
        //
        self.view.applyGradient(colours: [colour1, colour2])
        
        backButton.tintColor = colour1
        
        
        
        // Image View
        imageView.backgroundColor = colour4
        
        
        
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
        
        
        
        
        
        
        // Progress Bar
        //
        
        // Thickness
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 49, height: self.progressBarView.frame.size.height / 2)
        progressBar.center = progressBarView.center
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3)
        
        // Rounded Edges
        progressBar.layer.cornerRadius = self.progressBar.frame.size.height / 2
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
        
        //let poses = UserDefaults.standard.object(forKey: "posesNames") as! [Int: String]
        
        
        // Navigation Bar
        navigationTitle.text = NSLocalizedString(poses[keyArray[warmupScreenIndex]]!, comment: "")
        
        // Navigation Title
        navigationTitle.frame = (navigationController?.navigationItem.accessibilityFrame)!
        navigationTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        navigationTitle.center.x = self.view.center.x
        navigationTitle.textColor = colour1
        navigationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 22)
        navigationTitle.backgroundColor = .clear
        navigationTitle.textAlignment = .center
        navigationTitle.adjustsFontSizeToFitWidth = true
        
        self.navigationController?.navigationBar.topItem?.titleView = navigationTitle
        
        
        // Explanation Text and Scroll View
        let attributedExplanation = NSMutableAttributedString(string: NSLocalizedString(explanationDictionary[keyArray[warmupScreenIndex]]!, comment: ""))
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
        
        //let poses = UserDefaults.standard.object(forKey: "posesNames") as! [Int: String]
        
        
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
        
        
        let attributedStringE = NSMutableAttributedString(string: NSLocalizedString(explanationDictionary[keyArray[warmupScreenIndex]]!, comment: ""))
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
