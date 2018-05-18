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
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 2
            ["title": "introduction2",
             "discussion": "introduction2E",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 3
            ["title": "introduction3",
             "discussion": "introduction3E",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 4
            ["title": "introduction4",
             "discussion": "introduction4E",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
        ],
        // Breathing
        [
            // Intro 1
            ["title": "squareBreathing",
             "discussion": "squareBreathingE",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 1
            ["title": "breathCounting",
             "discussion": "breathCountingE",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 1
            ["title": "oxygenPurge",
             "discussion": "oxygenPurgeE",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 1
            ["title": "breathRetention",
             "discussion": "breathRetentionE",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 1
            ["title": "nostrilBreathing",
             "discussion": "nostrilBreathingE",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
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
            // Intro 1
            ["title": "tummoInnerFire",
             "discussion": "tummoInnerFireE",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 1
            ["title": "self",
             "discussion": "selfE",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
            // Intro 1
            ["title": "earth",
             "discussion": "earthE",
             "duration": 120,
             "bell": "tibetanBowlL",
             "bellFrequency": 30,
             ],
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
        let frequencyTitle = NSLocalizedString("every:", comment: "") + " " + String(practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] as! Int) + "s"
        bellFrequency.setTitle(frequencyTitle, for: .normal)
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
    }
    
    // Timer CountDown Title
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
        let selectionWidth = self.view.frame.size.width - 20
        let selectionHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
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
        let selectionWidth = self.view.frame.size.width - 20
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
        var frequency = practiceDict[selectedSessionMeditation[0]][selectedSessionMeditation[1]]["bellFrequency"] as! Int
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
        // Perform segue
        self.performSegue(withIdentifier: "meditationGuidedTimerSegue", sender: self)
        //
        // Return to beginning
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

