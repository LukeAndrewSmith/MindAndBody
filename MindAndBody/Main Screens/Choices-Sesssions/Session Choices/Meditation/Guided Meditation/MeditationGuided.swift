//
//  MeditationGuided.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 24.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

//
// Meditation Guided Class ------------------------------------------------------------------------------------
//
class MeditationGuided: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    // Image
    @IBOutlet weak var bellTitle: UILabel!
    @IBOutlet weak var bellImage: UIImageView!
    @IBOutlet weak var bellFrequency: UIButton!
    let tableViewBells = UITableView()
    let selectionView = UIView()
    let okButton = UIButton()
    var selectedBell = Int()
    var choosingBells = false
    //
    let pickerViewDuration = UIPickerView()
    let minutesLabel = UILabel()
    let secondsLabel = UILabel()
    
    // Time
    @IBOutlet weak var durationTitle: UILabel!
    @IBOutlet weak var durationIndicator: UILabel!
    @IBOutlet weak var durationDecrease: UIButton!
    @IBOutlet weak var durationIncrease: UIButton!
    
    
    // Detail
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailViewHeight: NSLayoutConstraint!
    @IBOutlet weak var separator: UIView!
    
    // Discussion
    @IBOutlet weak var discussionScroll: UIScrollView!
    var discussionElements: [UIView] = []
    var discussionHeight: CGFloat = 0
    var discussionsLabel = UILabel()
    
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
        // General introduction
        [
            ["title": "introductionG",
             "discussion": "introductionGE",
             "duration": 60,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
        ],
        // Introduction
        [
            // Intro 1
            ["title": "introduction1",
             "discussion": "introduction1E",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 2
            ["title": "introduction2",
             "discussion": "introduction2E",
             "duration": 300,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 3
            ["title": "introduction3",
             "discussion": "introduction3E",
             "duration": 300,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 4
            ["title": "introduction4",
             "discussion": "introduction4E",
             "duration": 300,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
        ],
        // Breathing
        [
            // Intro 1
            ["title": "squareBreathing",
             "discussion": "squareBreathingE",
             "duration": 180,
             "bell": "tibetanBowlL",
             "bellFrequency": 00,
             ],
            // Intro 1
            ["title": "breathCounting",
             "discussion": "breathCountingE",
             "duration": 300,
             "bell": "tibetanBowlL",
             "bellFrequency": 0,
             ],
            // Intro 1
            ["title": "purging",
             "discussion": "purgingE",
             "duration": 180,
             "bell": "tibetanBowlL",
             "bellFrequency": 0,
             ],
            // Intro 1
            ["title": "nostrilBreathing",
             "discussion": "nostrilBreathingE",
             "duration": 300,
             "bell": "tibetanBowlL",
             "bellFrequency": 0,
             ],
        ],
        // Visualisation
        [
            // Intro 1
            ["title": "bodyScan",
             "discussion": "bodyScanE",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
        ],
//            // Intro 1
//            ["title": "tummoInnerFire",
//             "discussion": "tummoInnerFireE",
//             "duration": 120,
//             "bell": "tibetanBowlL",
//             "bellFrequency": 30,
//             ],
//            // Intro 1
//            ["title": "self",
//             "discussion": "selfE",
//             "duration": 120,
//             "bell": "tibetanBowlL",
//             "bellFrequency": 30,
//             ],
//            // Intro 1
//            ["title": "earth",
//             "discussion": "earthE",
//             "duration": 120,
//             "bell": "tibetanBowlL",
//             "bellFrequency": 30,
//             ],
        ],
    ]
    
    let bellsArray = BellsFunctions.shared.bellsArray
    
    let frequencyArray = ["noBells", "30", "60", "90", "120", "180", "240"]
    
    //
    // View did load -------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.light
        
        // Begin Button Title
        beginButton.setTitle(NSLocalizedString("begin", comment: ""), for: .normal)
        beginButton.backgroundColor = Colors.green
        beginButton.setTitleColor(Colors.dark, for: .normal)
       
        // Navigation Bar Title
        navigationBar.title = NSLocalizedString(practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["title"] as! String, comment: "")
        
        // Setup
        setupView()
    
        // Discussion Scroll
        discussionScroll.backgroundColor = Colors.light
        
        if selectedSessionMeditation[0] == 0 {
            detailView.alpha = 0
            detailView.isUserInteractionEnabled = false
            detailViewHeight.constant = 0
            beginButton.setTitle(NSLocalizedString("back", comment: ""), for: .normal)
        }
    }
    
    func setupView() {
        // View
        detailView.addShadow()
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
        durationIndicator.text = timeFormatted(totalSeconds: practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["duration"] as! Int)
        // Buttons
        durationIncrease.tintColor = Colors.light
        durationDecrease.tintColor = Colors.light
        // Bells Table
        let tableViewBackground = UIView()
        tableViewBackground.backgroundColor = Colors.dark
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableViewBells.frame.size.width, height: self.tableViewBells.frame.size.height)
        tableViewBells.backgroundView = tableViewBackground
        tableViewBells.tableFooterView = UIView()
        tableViewBells.backgroundColor = Colors.dark
        tableViewBells.delegate = self
        tableViewBells.dataSource = self
        tableViewBells.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewBells.layer.cornerRadius = 15
        tableViewBells.layer.masksToBounds = true
        // Bell selection elements
        selectionView.backgroundColor = Colors.dark
        selectionView.layer.cornerRadius = 15
        selectionView.layer.masksToBounds = true
        //
        okButton.backgroundColor = Colors.light
        okButton.setTitleColor(Colors.green, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        //
        selectionView.addSubview(okButton)
        // Picker view
        // Frequency Picker
        pickerViewDuration.backgroundColor = Colors.dark
        pickerViewDuration.delegate = self
        pickerViewDuration.dataSource = self
        
        // Bells
        // Title
        bellTitle.isUserInteractionEnabled = false
        bellTitle.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        bellTitle.textColor = Colors.light
        bellTitle.text = NSLocalizedString("bell", comment: "")
        // Image
        bellImage.isUserInteractionEnabled = false
        bellImage.backgroundColor = Colors.dark
        bellImage.layer.cornerRadius = 3
        bellImage.layer.masksToBounds = true
        bellImage.image = BellsFunctions.shared.bellToImage(name: practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bell"] as! String)
        // Frequency
        bellFrequency.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)
        bellFrequency.setTitleColor(Colors.light, for: .normal)
        // No bells
        if practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] as! Int == 0 {
            practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] = 0
            bellFrequency.setTitle(NSLocalizedString(frequencyArray[0], comment: ""), for: .normal)
        // Bells
        } else {
            let frequencyTitle = NSLocalizedString("every:", comment: "") + " " + String(practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] as! Int) + "s"
            bellFrequency.setTitle(frequencyTitle, for: .normal)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Picker Label
        secondsLabel.textAlignment = .center
        secondsLabel.textColor = Colors.light
        secondsLabel.text = "s"
        secondsLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        secondsLabel.numberOfLines = 1
        secondsLabel.sizeToFit()
        secondsLabel.center.y = pickerViewDuration.center.y
        secondsLabel.center.x = pickerViewDuration.frame.minX + (pickerViewDuration.frame.size.width * (4.65/6))
        pickerViewDuration.addSubview(secondsLabel)
        
        // Discussion
        let discussion = practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["discussion"] as! String
        setupDiscussion(discussion: discussion)
    }
    
    // Timer CountDown Title
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    // --------------------------------------------------------------------
    // MARK: Setup Discussion
    func setupDiscussion(discussion: String) {
        
        // Ensure Clear
        for element in discussionElements {
            element.removeFromSuperview()
        }
        discussionHeight = 0
        
        switch discussion {
        // Effort
        case "introductionGE":
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "introductionGEIntro")
            
            // Independence Title
            let independenceTitle = UILabel()
            setupSubtitle(titleLabel: independenceTitle, title: "introductionGEIndependenceTitle", previous: intro, gap: 24)
            // Independence text
            let independenceText = UILabel()
            setupText(label: independenceText, text: "introductionGEIndependenceText", previous: independenceTitle, gap: 8)
            
            // Techniques Title
            let techniquesTitle = UILabel()
            setupSubtitle(titleLabel: techniquesTitle, title: "introductionGETechniquesTitle", previous: independenceText, gap: 24)
            // Independence text
            let techniquesBullets = UILabel()
            setupBulletPoints(label: techniquesBullets, text: "introductionGETechniquesBullets", style: "numbers",  previous: techniquesTitle, gap: 8)
            // Relax note title
            let relaxTitle = UILabel()
            setupSubtitle(titleLabel: relaxTitle, title: "introductionGERelaxNoteTitle", previous: techniquesBullets, gap: 8)
            // Relax note text
            let relaxText = UILabel()
            setupText(label: relaxText, text: "introductionGERelaxNoteText", previous: relaxTitle, gap: 8)
            
            // Posture Title
            let postureTitle = UILabel()
            setupSubtitle(titleLabel: postureTitle, title: "introductionGEPostureTitle", previous: relaxText, gap: 24)
            // Posture text
            let postureText = UILabel()
            setupText(label: postureText, text: "introductionGEPostureText", previous: postureTitle, gap: 8)
            
            
        // Introduction -------------------------------------------------------
        case "introduction1E":
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "introduction1EIntro")
            
            // Distraction Title
            let disctractionTitle = UILabel()
            setupSubtitle(titleLabel: disctractionTitle, title: "introduction1EDistractionTitle", previous: intro, gap: 24)
            // Distraction text
            let disctractionText = UILabel()
            setupText(label: disctractionText, text: "introduction1EDistractionText", previous: disctractionTitle, gap: 8)
            
            // Practice Title
            let practiceTitle = UILabel()
            setupSubtitle(titleLabel: practiceTitle, title: "introduction1EPracticeTitle", previous: disctractionText, gap: 24)
            // Practice Text
            let practiceText = UILabel()
            setupText(label: practiceText, text: "introduction1EPracticeText", previous: practiceTitle, gap: 8)
            // Practice title 2
            let practiceTitle2 = UILabel()
            setupSubtitle(titleLabel: practiceTitle2, title: "introduction1EPracticePracticeTitle", previous: practiceText, gap: 8)
            // Practice
            let practice = UILabel()
            setupBulletPoints(label: practice, text: "introduction1EPracticePracticeText", style: "dots", previous: practiceTitle2, gap: 8)
            
            
        case "introduction2E":
            
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "introduction2EIntro")
            
            // Difficulty Title
            let difficultyTitle = UILabel()
            setupSubtitle(titleLabel: difficultyTitle, title: "introduction2EDifficultyNoteTitle", previous: intro, gap: 24)
            // Difficulty Text
            let difficultyText = UILabel()
            setupText(label: difficultyText, text: "introduction2EDifficultyNoteText", previous: difficultyTitle, gap: 8)
            
            // Aim Title
            let aimTitle = UILabel()
            setupSubtitle(titleLabel: aimTitle, title: "introduction2EAimTitle", previous: difficultyText, gap: 24)
            // Aim text
            let aimText = UILabel()
            setupText(label: aimText, text: "introduction2EAimText", previous: aimTitle, gap: 8)
            
            // Breathing Title
            let breathingTitle = UILabel()
            setupSubtitle(titleLabel: breathingTitle, title: "introduction2EBreathingTitle", previous: aimText, gap: 24)
            // Breathing Text
            let breathingText = UILabel()
            setupText(label: breathingText, text: "introduction2EBreathingText", previous: breathingTitle, gap: 8)
            
            // Visualisation Title
            let visualisationTitle = UILabel()
            setupSubtitle(titleLabel: visualisationTitle, title: "introduction2EVisualisationTitle", previous: breathingText, gap: 16)
            // Visualisation Text
            let visualisationText = UILabel()
            setupText(label: visualisationText, text: "introduction2EVisualisationText", previous: visualisationTitle, gap: 8)
            
            // Observation Title
            let observationTitle = UILabel()
            setupSubtitle(titleLabel: observationTitle, title: "introduction2EObservationTitle", previous: visualisationText, gap: 16)
            // Observation Text
            let observationText = UILabel()
            setupText(label: observationText, text: "introduction2EObservationText", previous: observationTitle, gap: 8)
            
            // Practice title
            let practiceTitle = UILabel()
            setupSubtitle(titleLabel: practiceTitle, title: "introduction2EPracticeTitle", previous: observationText, gap: 24)
            // Practice note
            let practiceText = UILabel()
            setupText(label: practiceText, text: "introduction2EPracticeText", previous: practiceTitle, gap: 8)
            // Practice
            let practice = UILabel()
            setupBulletPoints(label: practice, text: "introduction2EPracticeBullets", style: "dots", previous: practiceText, gap: 8)
            
            
        case "introduction3E":
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "introduction3EIntro")
            
            // Breathing Title
            let breathingTitle = UILabel()
            setupSubtitle(titleLabel: breathingTitle, title: "introduction3EBreathingTitle", previous: intro, gap: 24)
            // Breathing Text
            let breathingText = UILabel()
            setupText(label: breathingText, text: "introduction3EBreathingText", previous: breathingTitle, gap: 8)
            
            // Aim Title
            let aimTitle = UILabel()
            setupSubtitle(titleLabel: aimTitle, title: "introduction3EIntroAimTitle", previous: breathingText, gap: 24)
            // Aim text
            let aimText = UILabel()
            setupText(label: aimText, text: "introduction3EIntroAimText", previous: aimTitle, gap: 8)
            
            // Practice title
            let practiceTitle = UILabel()
            setupSubtitle(titleLabel: practiceTitle, title: "introduction3EPracticeTitle", previous: aimText, gap: 24)
            // Practice note
            let practiceText = UILabel()
            setupText(label: practiceText, text: "introduction3EPracticeText", previous: practiceTitle, gap: 8)
            // Practice
            let practice = UILabel()
            setupBulletPoints(label: practice, text: "introduction3EPracticeBullets", style: "dots", previous: practiceText, gap: 8)
            
            
        case "introduction4E":
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "introduction4EIntro")
            
            // Breathing Title
            let breathingTitle = UILabel()
            setupSubtitle(titleLabel: breathingTitle, title: "introduction4EIntroBreathingTitle", previous: intro, gap: 24)
            // Breathing Text
            let breathingText = UILabel()
            setupText(label: breathingText, text: "introduction4EIntroBreathingText", previous: breathingTitle, gap: 8)
            // Present Title
            let presentTitle = UILabel()
            setupSubtitle(titleLabel: presentTitle, title: "introduction4EIntroPresentTitle", previous: breathingText, gap: 8)
            // Present text
            let presentText = UILabel()
            setupText(label: presentText, text: "introduction4EIntroPresentText", previous: presentTitle, gap: 8)
            
            // Mindfulness Title
            let mindfulnessTitle = UILabel()
            setupSubtitle(titleLabel: mindfulnessTitle, title: "introduction4EIntroMindfulnessTitle", previous: presentText, gap: 24)
            // Aim text
            let mindfulnessText = UILabel()
            setupText(label: mindfulnessText, text: "introduction4EIntroMindfulnessText", previous: mindfulnessTitle, gap: 8)
            
            // Practice title
            let practiceTitle = UILabel()
            setupSubtitle(titleLabel: practiceTitle, title: "introduction4EPracticeTitle", previous: mindfulnessText, gap: 24)
            // Practice note
            let practiceText = UILabel()
            setupText(label: practiceText, text: "introduction4EPracticeText", previous: practiceTitle, gap: 8)
            // Practice
            let practice = UILabel()
            setupBulletPoints(label: practice, text: "introduction4EPracticeBullets", style: "dots", previous: practiceText, gap: 8)
            
            
        // Breathing -------------------------------------------------------
        case "squareBreathingE":
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "squareBreathingEIntro")
        
            // Technique title
            let techniqueTitle = UILabel()
            setupSubtitle(titleLabel: techniqueTitle, title: "squareBreathingETechniqueTitle", previous: intro, gap: 24)
            // Technique Bullets
            let techniqueBullets = UILabel()
            setupBulletPoints(label: techniqueBullets, text: "squareBreathingETechniqueText", style: "dots", previous: techniqueTitle, gap: 8)
            // Notes title
            let notesTitle = UILabel()
            setupSubtitle(titleLabel: notesTitle, title: "squareBreathingETechniqueNotes", previous: techniqueBullets, gap: 16)
            // Technique Discussion
            let techniqueText = UILabel()
            setupText(label: techniqueText, text: "squareBreathingETechniqueDiscussion", previous: notesTitle, gap: 8)
            
            
        case "breathCountingE":
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "breathCountingEIntro")
            
            // Technique title
            let techniqueTitle = UILabel()
            setupSubtitle(titleLabel: techniqueTitle, title: "breathCountingETechniqueTitle", previous: intro, gap: 24)
            // Technique Bullets
            let techniqueBullets = UILabel()
            setupBulletPoints(label: techniqueBullets, text: "breathCountingETechniqueText", style: "dots", previous: techniqueTitle, gap: 8)
            // Notes title
            let notesTitle = UILabel()
            setupSubtitle(titleLabel: notesTitle, title: "breathCountingETechniqueNotesTitle", previous: techniqueBullets, gap: 16)
            // Technique Discussion
            let techniqueText = UILabel()
            setupText(label: techniqueText, text: "breathCountingETechniqueNotesText", previous: notesTitle, gap: 8)
            
            
        case "purgingE":
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "purgingEIntro")
            
            // Technique title
            let techniqueTitle = UILabel()
            setupSubtitle(titleLabel: techniqueTitle, title: "purgingETechniqueTitle", previous: intro, gap: 24)
            // Technique Bullets
            let techniqueBullets = UILabel()
            setupBulletPoints(label: techniqueBullets, text: "purgingETechniqueText", style: "dots", previous: techniqueTitle, gap: 8)
            // Notes title
            let notesTitle = UILabel()
            setupSubtitle(titleLabel: notesTitle, title: "purgingENotesTitle", previous: techniqueBullets, gap: 16)
            // Technique Discussion
            let techniqueText = UILabel()
            setupText(label: techniqueText, text: "purgingENotesText", previous: notesTitle, gap: 8)
            
            
        case "nostrilBreathingE":
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "nostrilBreathingEIntro")
            
            // Technique title
            let techniqueTitle = UILabel()
            setupSubtitle(titleLabel: techniqueTitle, title: "nostrilBreathingETechniqueTitle", previous: intro, gap: 24)
            // Technique Bullets 1
            let techniqueBullets = UILabel()
            setupBulletPoints(label: techniqueBullets, text: "nostrilBreathingETechniqueText", style: "dots", previous: techniqueTitle, gap: 8)
            // Variation title
            let techniqueVariationTitle = UILabel()
            setupSubtitle(titleLabel: techniqueVariationTitle, title: "nostrilBreathingETechniqueVariationTitle", previous: techniqueBullets, gap: 8)
            // Technique Note
            let techniqueNote = UILabel()
            setupText(label: techniqueNote, text: "nostrilBreathingETechniqueTextNote", previous: techniqueVariationTitle, gap: 8)
            // Technique Bullets 2
            let techniqueBullets2 = UILabel()
            setupBulletPoints(label: techniqueBullets2, text: "nostrilBreathingETechniqueText2", style: "dots", previous: techniqueNote, gap: 8)
            // Notes title
            let notesTitle = UILabel()
            setupSubtitle(titleLabel: notesTitle, title: "nostrilBreathingENotesTitle", previous: techniqueBullets2, gap: 16)
            // Technique Discussion
            let techniqueText = UILabel()
            setupText(label: techniqueText, text: "nostrilBreathingENotesText", previous: notesTitle, gap: 8)
            
        // Visualisation -------------------------------------------------------
        case "bodyScanE":
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "bodyScanEIntro")
            
            // Technique title
            let techniqueExplanationTitle = UILabel()
            setupSubtitle(titleLabel: techniqueExplanationTitle, title: "bodyScanETechnique", previous: intro, gap: 24)
            // Technique explanation
            let techniqueExplanation = UILabel()
            setupText(label: techniqueExplanation, text: "bodyScanETechniqueExplanation", previous: techniqueExplanationTitle, gap: 8)
            // Technique title example
            let techniqueTitle = UILabel()
            setupSubtitle(titleLabel: techniqueTitle, title: "bodyScanETechniqueTitle", previous: techniqueExplanation, gap: 8)
            // Technique Bullets 1
            let techniqueBullets = UILabel()
            setupBulletPoints(label: techniqueBullets, text: "bodyScanETechniqueText", style: "dots", previous: techniqueTitle, gap: 8)
            
            // Note title
            let notesTitle = UILabel()
            setupSubtitle(titleLabel: notesTitle, title: "bodyScanETechniqueNotesTitle", previous: techniqueBullets, gap: 16)
            // Technique Note
            let techniqueNote = UILabel()
            setupText(label: techniqueNote, text: "bodyScanETechniqueNotesText", previous: notesTitle, gap: 8)
            // Recap title
            let recapTitle = UILabel()
            setupSubtitle(titleLabel: recapTitle, title: "bodyScanETechniqueNotesRecapTitle", previous: techniqueNote, gap: 16)
            // Technique Bullets 2
            let techniqueBullets2 = UILabel()
            setupBulletPoints(label: techniqueBullets2, text: "bodyScanETechniqueNotesRecapText", style: "dots", previous: recapTitle, gap: 8)
            
            
        default: break
        }
        
        discussionScroll.contentSize = CGSize(width: discussionScroll.bounds.width, height: discussionHeight + 16)
    }
    
    func setupTitle(titleLabel: UILabel, title: String) {
        
        let gap: CGFloat = 16
        
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.text = NSLocalizedString(title, comment: "")
        titleLabel.textColor = Colors.dark
        titleLabel.font = Fonts.lessonSubtitle
        let size = titleLabel.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        titleLabel.frame = CGRect(x: 16, y: 16, width: view.bounds.width - 32, height: size.height)
        
        discussionScroll.addSubview(titleLabel)
        discussionElements.append(titleLabel)
        discussionHeight = discussionHeight + size.height + gap
    }
    
    func setupIntro(label: UILabel, text: String) {
        
        let gap: CGFloat = 16

        let plainString = NSLocalizedString(text, comment: "")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: Fonts.lessonText!,
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.foregroundColor: Colors.dark
        ]
        let attributedString = NSMutableAttributedString(string: plainString, attributes: attributes)
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.attributedText = attributedString
        let size = label.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        label.frame = CGRect(x: 16, y: 16, width: view.bounds.width - 32, height: size.height)
        
        discussionScroll.addSubview(label)
        discussionElements.append(label)
        discussionHeight = discussionHeight + size.height + gap
    }
    
    func setupSubtitle(titleLabel: UILabel, title: String, previous: UIView, gap: CGFloat) {
        
        let minY = previous.frame.maxY
        
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.text = NSLocalizedString(title, comment: "")
        titleLabel.textColor = Colors.dark
        titleLabel.font = Fonts.lessonSubtitle
        let size = titleLabel.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        titleLabel.frame = CGRect(x: 16, y: minY + gap, width: view.bounds.width - 32, height: size.height)
        
        discussionScroll.addSubview(titleLabel)
        discussionElements.append(titleLabel)
        discussionHeight = discussionHeight + size.height + gap
    }
    
    func setupText(label: UILabel, text: String, previous: UIView, gap: CGFloat) {
        
        let minY = previous.frame.maxY
        
        let plainString = NSLocalizedString(text, comment: "")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: Fonts.lessonText!,
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.foregroundColor: Colors.dark
        ]
        let attributedString = NSMutableAttributedString(string: plainString, attributes: attributes)
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.attributedText = attributedString
        let size = label.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        label.frame = CGRect(x: 16, y: minY + gap, width: view.bounds.width - 32, height: size.height)
        
        discussionScroll.addSubview(label)
        discussionElements.append(label)
        discussionHeight = discussionHeight + size.height + gap
    }
    
    func setupBulletPoints(label: UILabel, text: String, style: String, previous: UIView, gap: CGFloat) {
        
        let minY = previous.frame.maxY
        
        // Strings
        let orignalString = NSLocalizedString(text, comment: "")
        let bulletPoints = orignalString.components(separatedBy: .newlines)
        let bulletedString = NSMutableAttributedString(string: "")
        
        // Indent
        let paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: [:])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 15
        paragraphStyle.lineSpacing = 2
        // Attributes
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: Fonts.lessonText!,
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.foregroundColor: Colors.dark
        ]
        
        // Apply
        switch style {
        case "numbers":
            for i in 1...bulletPoints.count {
                let bulletPoint: String = String(i) + "."
                var enter = ""
                if i != bulletPoints.count {
                    enter = "\n"
                }
                let formattedString: String = "\(bulletPoint) \(bulletPoints[i-1])" + enter
                let attributedString = NSMutableAttributedString(string: formattedString, attributes: attributes)
                
                bulletedString.append(attributedString)
            }
        case "dots":
            for i in 1...bulletPoints.count {
                let bulletPoint: String = "\u{2022}"
                var enter = ""
                if i != bulletPoints.count {
                    enter = "\n"
                }
                let formattedString: String = "\(bulletPoint) \(bulletPoints[i-1])" + enter
                let attributedString = NSMutableAttributedString(string: formattedString, attributes: attributes)
                
                bulletedString.append(attributedString)
            }
        default: break
        }
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.attributedText = bulletedString
        label.sizeToFit()
        let size = label.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        label.frame = CGRect(x: 16, y: minY + gap, width: view.bounds.width - 32, height: size.height)
        
        discussionScroll.addSubview(label)
        discussionElements.append(label)
        discussionHeight = discussionHeight + size.height + gap
    }
    
    //
    // MARK: Button Functions
    // Increase duration
    @IBAction func increaseDurationAction(_ sender: Any) {
        //
        if (practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["duration"] as! Int) < (59*60) {
            practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["duration"] = practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["duration"] as! Int + 60
            durationIndicator.text = timeFormatted(totalSeconds: practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["duration"] as! Int)
        }
    }
    // Decrease Duration
    @IBAction func decreaseDurationAction(_ sender: Any) {
        //
        if practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["duration"] as! Int != 60 {
            practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["duration"] = practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["duration"] as! Int - 60
            durationIndicator.text = timeFormatted(totalSeconds: practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["duration"] as! Int)
        }
    }
    
    // Bell
    @IBAction func bellChoiceAction(_ sender: Any) {
        choosingBells = true
        //
        selectedBell = bellsArray.index(of: practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bell"] as! String)!
        //
        // View
        let selectionWidth = ActionSheet.shared.actionWidth
        let selectionHeight = ActionSheet.shared.actionTableHeight
        selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: selectionWidth, height: selectionHeight)
        // Tableview
        selectionView.addSubview(tableViewBells)
        self.tableViewBells.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: selectionHeight - 49)
        // ok
        self.okButton.frame = CGRect(x: 0, y: selectionHeight - 49, width: self.selectionView.frame.size.width, height: 49)
        selectionView.addSubview(okButton)
        //
        selectionView.frame = CGRect(x: 0, y: 0, width: selectionWidth, height: selectionHeight)
        //
        // Scroll to row
        let indexPath = IndexPath(row: selectedBell, section: 0)
        tableViewBells.scrollToRow(at: indexPath, at: .top, animated: true)
        //
        ActionSheet.shared.setupActionSheet()
        ActionSheet.shared.actionSheet.addSubview(selectionView)
        let heightToAdd = selectionView.bounds.height
        ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
        ActionSheet.shared.resetCancelFrame()
        ActionSheet.shared.animateActionSheetUp()
    }
    // Bell frequency
    @IBAction func bellFrequencyAction(_ sender: Any) {
        //
        choosingBells = false
        //
        // View
        let selectionWidth = ActionSheet.shared.actionWidth
        let selectionHeight = CGFloat(147 + 49)
        //
        UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
        selectionView.frame = CGRect(x: 10, y: view.frame.maxY, width: selectionWidth, height: selectionHeight)
        //
        // PickerView
        selectionView.addSubview(pickerViewDuration)
        self.pickerViewDuration.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height - 49)
        self.minutesLabel.center.y = self.pickerViewDuration.center.y
        self.secondsLabel.center.y = self.pickerViewDuration.center.y
        //
        self.secondsLabel.center.x = self.pickerViewDuration.frame.minX + (self.pickerViewDuration.frame.size.width * (4.65/6))
        self.minutesLabel.center.x = self.pickerViewDuration.frame.minX + (self.pickerViewDuration.frame.size.width * (3.55/6))
        //
        // Select Rows if duration already set
        let frequency = practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] as! Int
        var frequencyString = String()
        if frequency == 0 {
            frequencyString = frequencyArray[0]
        } else {
            frequencyString = String(frequency)
        }
        pickerViewDuration.selectRow(frequencyArray.index(of: frequencyString)!, inComponent: 0, animated: true)
        //
        // ok
        self.okButton.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
        selectionView.addSubview(okButton)
        //
        selectionView.frame = CGRect(x: 0, y: 0, width: selectionWidth, height: selectionHeight)
        //
        ActionSheet.shared.setupActionSheet()
        ActionSheet.shared.actionSheet.addSubview(selectionView)
        let heightToAdd = selectionView.bounds.height
        ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
        ActionSheet.shared.resetCancelFrame()
        ActionSheet.shared.animateActionSheetUp()
    }
    
    //
    @objc func okButtonAction(_ sender: Any) {
        // Bells
        if choosingBells {
            // Cancel bell if ringing
            if BellPlayer.shared.bellPlayer != nil {
                if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                    BellPlayer.shared.bellPlayer?.stop()
                }
            }
            // Change bell
            practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bell"] = bellsArray[selectedBell]
            // Update bell image
            bellImage.image = BellsFunctions.shared.bellToImage(name: practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bell"] as! String)

            // Remove View
            ActionSheet.shared.animateActionSheetDown()
            
        // Frequency
        } else {
            // No bells
            if pickerViewDuration.selectedRow(inComponent: 0) == 0 {
                // Change frequency
                practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] = 0
                // Update frequency button text
                bellFrequency.setTitle(NSLocalizedString(frequencyArray[0], comment: ""), for: .normal)

            // Bell frequency
            } else {
                let frequency = Int(frequencyArray[pickerViewDuration.selectedRow(inComponent: 0)])!
                let duration = practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["duration"] as! Int
                // If silly choice
                if duration <= frequency {
                    // Change frequency
                    practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] = 30
                    // Update frequency button text
                    let frequencyTitle = NSLocalizedString("every:", comment: "") + " " + String(practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] as! Int) + "s"
                    bellFrequency.setTitle(frequencyTitle, for: .normal)
                // Sensible choice
                } else {
                    // Change frequency
                    practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] = Int(frequencyArray[pickerViewDuration.selectedRow(inComponent: 0)])
                    // Update frequency button text
                    let frequencyTitle = NSLocalizedString("every:", comment: "") + " " + String(practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] as! Int) + "s"
                    bellFrequency.setTitle(frequencyTitle, for: .normal)
                }
            }
            
            // Remove View
            ActionSheet.shared.animateActionSheetDown()
        }
    }
    
    // MARK: TableView
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " " + NSLocalizedString("bells", comment: "")
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 17)!
        header.textLabel?.textColor = Colors.light
        header.contentView.backgroundColor = Colors.dark
        header.contentView.tintColor = Colors.light
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bellsArray.count
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        //
        cell.textLabel?.text = NSLocalizedString(bellsArray[indexPath.row], comment: "")
        cell.imageView?.image = BellsFunctions.shared.bellToImage(name: bellsArray[indexPath.row])
        //
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = Colors.dark
        cell.textLabel?.textColor = Colors.light
        cell.tintColor = Colors.light
        //
        if indexPath.row == selectedBell {
            cell.textLabel?.textColor = Colors.green
            cell.accessoryType = .checkmark
            cell.tintColor = Colors.green
        }
        //
        return cell
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    //
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let url = Bundle.main.url(forResource: bellsArray[indexPath.row], withExtension: "caf")!
        //
        do {
            let bell = try AVAudioPlayer(contentsOf: url)
            BellPlayer.shared.bellPlayer = bell
            bell.play()
        } catch {
            // couldn't load file :(
        }
        //
        selectedBell = indexPath.row
        //
        tableViewBells.deselectRow(at: indexPath, animated: false)
        tableViewBells.reloadData()
    }
    
    //
    // Picker View ----------------------------------------------------------------------------------------------------
    //
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //
        return frequencyArray.count
    }
    
    // Width for component
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return selectionView.frame.size.width / 6
//    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        let label = UILabel()
        if row == 0 {
            label.text = NSLocalizedString(frequencyArray[row], comment: "")
        } else {
            label.text = String(frequencyArray[row])
        }
        label.font = UIFont(name: "SFUIDisplay-light", size: 24)
        label.textColor = Colors.light
        //
        label.textAlignment = .center
        return label
        //
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    //
    // Begin Button ----------------------------------------------------------------------------------
    //
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        if selectedSessionMeditation[0] == 0 {
            _ = self.navigationController?.popViewController(animated: true)
        } else {
            // Perform segue
            self.performSegue(withIdentifier: "meditationGuidedTimerSegue", sender: self)
            //
            // Return to beginning
            let delayInSeconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                _ = self.navigationController?.popToRootViewController(animated: false)
            }
        }
    }
    
    
    //
    // Pass arrays to next View controller -------------------------------------------------------------------------------------------
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Info
        //
        if segue.identifier == "meditationGuidedTimerSegue" {
            //
            let destinationVC = segue.destination as! MeditationScreen
            //
            destinationVC.bellsArray = bellsArray
            // To indicate that were coming from Guided
            destinationVC.selectedPreset = -1
            //
            destinationVC.fromSchedule = fromSchedule
            
            // Practice details
            destinationVC.durationOfPractice = practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["duration"] as! Int
            destinationVC.bellChosen = practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bell"] as! String
            destinationVC.bellFrequency = practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] as! Int
        }
    }
    //
}

