//
//  YogaScreenOverview.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 29.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import AVFoundation


//
// Custom Overview Tableview Cells ---------------------------------------------------------------------------
//
// Overview TableView Cell
class YogaOverviewTableViewCell: UITableViewCell {
    // Demonstration Image View
    @IBOutlet weak var demonstrationImageView: UIImageView!
    // Title Label
    @IBOutlet weak var poseLabel: UILabel!
    // Breaths Label
    @IBOutlet weak var breathsLabel: UILabel!
    // Explanation Button
    @IBOutlet weak var explanationButton: UIButton!
    
}


//
// Session Screen Overview Class ------------------------------------------------------------------------------------
//
class YogaScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //
    // Retreive Arrays ---------------------------------------------------------------------------------------------------
    //
    //
    var sessionType = Int()
    
    // Title
    var sessionTitle = String()
    
    // Movement Array
    var sessionArray: [String] = []
    
    // Sets Array
    var breathsArray: [Int] = []
    
    // Demonstration Array
    var demonstrationArray: [[UIImage]] = []
    var animationDurationArray: [Double] = []
    
    // Explanation Array
    var explanationArray: [String] = []
    
    //
    // Variables
    var selectedRow = 0
    
    //
    var automaticYogaArray: [Int] = []

    // Bells Arrays
    let bellsArray: [String] =
        ["Tibetan Chimes", "Tibetan Singing Bowl (Low)", "Tibetan Singing Bowl (Low)(x4)", "Tibetan Singing Bowl (Low)(Singing)", "Tibetan Singing Bowl (High)", "Tibetan Singing Bowl (High)(x4)", "Tibetan Singing Bowl (High)(Singing)", "Australian Rain Stick", "Australian Rain Stick (x2)", "Australian Rain Stick (2 sticks)", "Wind Chimes", "Gambang (Wood)(Up)", "Gambang (Wood)(Down)", "Gambang (Metal)", "Indonesian Frog", "Cow Bell (Small)", "Cow Bell (Big)"]
    
    
    //
    // Outlets -----------------------------------------------------------------------------------------------------------
    // Progress Bar
    let progressBar = UIProgressView()
    
    // Table view
    @IBOutlet weak var tableView: UITableView!
    
    // Pause/Play
    var playPause = UIButton()
    
    //
    var updateTimer = Timer()
    var soundPlayer: AVAudioPlayer!
    

    
    
    
    //
    // View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        automaticYogaArray = UserDefaults.standard.object(forKey: "automaticYoga") as! [Int]
        
        //
        view.backgroundColor = colour2
        
        
        
        
        // Progress Bar
        // Thickness
        switch automaticYogaArray[0] {
        case 0:
            progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
            progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        case 1:
            progressBar.frame = CGRect(x: 44, y: 0, width: self.view.frame.size.width - 44, height: 2)
            progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 43)
        default: break
        }
        
        // Rounded Edges
        // Colour
        progressBar.trackTintColor = colour1
        progressBar.progressTintColor = colour3
        //
        progressBar.setProgress(0, animated: true)
        
        // TableView Background
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        //
        tableView.backgroundView = tableViewBackground
        //
        tableView.tableFooterView = UIView()
        
        // Play/Pause
        playPause.backgroundColor = colour2
        playPause.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        playPause.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
        playPause.tintColor = colour1
        playPause.addTarget(self, action: #selector(pauseButtonAction), for: .touchUpInside)
        
    }
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Session Started
        //
        // Alert View
        let title = NSLocalizedString("sessionStarted", comment: "")
        //let message = NSLocalizedString("resetMessage", comment: "")
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.tintColor = colour1
        alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
        self.present(alert, animated: true, completion: {
            //
            let delayInSeconds = 0.7
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                alert.dismiss(animated: true, completion: nil)
            }
        })
        //
        if automaticYogaArray[0] == 1 {
            automaticYoga()
        }
    }
    
    //
    // TableView ---------------------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    // Will Display Header
    var didSetFrame = false
    //
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = colour1
        
        //
        if section == 0 {
            //
            if header.subviews.contains(progressBar) {
            } else {
                header.addSubview(progressBar)
            }
        }
        
        //
        if automaticYogaArray[0] == 1 {
            header.addSubview(playPause)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            switch automaticYogaArray[0] {
            case 0:
                return 2
            case 1:
                return 44
            default: break
            }
            return 0
        case 1: return 0
        default: break
        }
        return 0
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        switch section {
        case 0: return sessionArray.count
        case 1: return 1
        default: return 0
        }
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "YogaOverviewTableViewCell", for: indexPath) as! YogaOverviewTableViewCell
            
            // Cell
            //
            cell.backgroundColor = colour2
            cell.tintColor = colour2
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //
            cell.selectionStyle = .none
            
            // Movement
            //
            cell.poseLabel.text = NSLocalizedString(sessionArray[indexPath.row], comment: "")
            //
            cell.poseLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 23)
            cell.poseLabel?.textAlignment = .center
            cell.poseLabel?.textColor = colour1
            cell.poseLabel?.numberOfLines = 0
            cell.poseLabel?.lineBreakMode = .byWordWrapping
            cell.poseLabel?.adjustsFontSizeToFitWidth = true
            
            // Set and Reps
            //
            cell.breathsLabel?.text = String(breathsArray[indexPath.row]) + " " + NSLocalizedString("breathsC", comment: "")
            cell.breathsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.breathsLabel?.textAlignment = .right
            cell.breathsLabel?.textColor = colour1
            cell.breathsLabel.adjustsFontSizeToFitWidth = true
            
            // Buttons
//            cell.nextButton.tintColor = colour3
//            cell.backButton.tintColor = colour4
            //cell.nextButton.alpha = 0
            //cell.backButton.alpha = 0
            cell.explanationButton.tintColor = colour1
            
            // Image
            //
            cell.demonstrationImageView.image = demonstrationArray[indexPath.row][0]
            // Animation
            cell.demonstrationImageView.animationImages = demonstrationArray[indexPath.row]
            cell.demonstrationImageView.animationImages?.removeFirst()
            cell.demonstrationImageView.animationDuration = animationDurationArray[indexPath.row]
            cell.demonstrationImageView.animationRepeatCount = 1
            //
            cell.demonstrationImageView.tag = indexPath.row
        
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleImageTap))
            cell.demonstrationImageView.addGestureRecognizer(imageTap)
            //
            
            //
            if automaticYogaArray[0] == 0 {
                // Next Swipe
                let nextSwipe = UISwipeGestureRecognizer()
                nextSwipe.direction = .up
                nextSwipe.addTarget(self, action: #selector(nextButtonAction))
                cell.addGestureRecognizer(nextSwipe)
            
                // Back Swipe
                let backSwipe = UISwipeGestureRecognizer()
                backSwipe.direction = .down
                backSwipe.addTarget(self, action: #selector(backButtonAction))
                cell.addGestureRecognizer(backSwipe)
            }
            
            // Explanation
            let explanationTap = UITapGestureRecognizer()
            explanationTap.numberOfTapsRequired = 1
            explanationTap.addTarget(self, action: #selector(expandExplanation))
            cell.explanationButton.addGestureRecognizer(explanationTap)
            
//            // Next Tap
//            let nextTap = UITapGestureRecognizer()
//            nextTap.numberOfTapsRequired = 1
//            nextTap.addTarget(self, action: #selector(nextButtonAction))
//            cell.nextButton.addGestureRecognizer(nextTap)
//            //
//            
//            // Back Button
//            let backTap = UITapGestureRecognizer()
//            backTap.numberOfTapsRequired = 1
//            backTap.addTarget(self, action: #selector(backButtonAction))
//            cell.backButton.addGestureRecognizer(backTap)
//            //
        
            switch indexPath.row {
            case selectedRow - 1:
                cell.breathsLabel.alpha = 0
                cell.poseLabel.alpha = 0
            //
            case selectedRow:
                cell.breathsLabel.alpha = 1
                cell.poseLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.explanationButton.isEnabled = true
                cell.demonstrationImageView.isUserInteractionEnabled = true
            //
            case selectedRow + 1:
                //
                cell.breathsLabel.alpha = 0
                cell.poseLabel.alpha = 1
                cell.explanationButton.alpha = 0
                cell.explanationButton.isEnabled = false
                cell.demonstrationImageView.isUserInteractionEnabled = false
            //
            default:
                //
                cell.breathsLabel.alpha = 1
                cell.poseLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.explanationButton.isEnabled = true
            }
            
            return cell
        //
        case 1:
            //
            let cell = tableView.dequeueReusableCell(withIdentifier: "EndTableViewCell", for: indexPath) as! EndTableViewCell
            //
            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            //
            cell.separatorInset =  UIEdgeInsetsMake(0, 0, 0, 0)
            //
            cell.layer.borderWidth = 2
            cell.layer.borderColor = colour1.cgColor
            //
            cell.titleLabel?.text = NSLocalizedString("end", comment: "")
            cell.titleLabel?.textColor = colour1
            cell.titleLabel?.textAlignment = .center
            //
            return cell
        default: return UITableViewCell(style: .value1, reuseIdentifier: nil)
        }
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch indexPath.section {
        case 0:
            switch automaticYogaArray[0] {
            case 0:
                switch indexPath.row {
                case selectedRow - 1, selectedRow:
                    return (UIScreen.main.bounds.height - 22) * 3/4
                case selectedRow + 1:
                    return (UIScreen.main.bounds.height - 22) * 1/4
                default:
                    return (UIScreen.main.bounds.height - 22) * 1/4
                }
            case 1:
                switch indexPath.row {
                case selectedRow - 1, selectedRow:
                    return (UIScreen.main.bounds.height - 64) * 3/4
                case selectedRow + 1:
                    return (UIScreen.main.bounds.height - 64) * 1/4
                default:
                    return (UIScreen.main.bounds.height - 64) * 1/4
                }
            default: break
            }
        //
        case 1: return 49
        default: return 0
        }
        return 0
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch indexPath.section {
        case 0: break
        //
        case 1:
            if automaticYogaArray[0] == 1 {
                // Play Ending Bell
                let url = Bundle.main.url(forResource: bellsArray[automaticYogaArray[3]], withExtension: "caf")!
                //
                do {
                    let bell = try AVAudioPlayer(contentsOf: url)
                    soundPlayer = bell
                    bell.play()
                } catch {
                    // couldn't load file :(
                }
                
                // 
                task?.cancel()
                //
                UIApplication.shared.isIdleTimerDisabled = false
            }
            
            // Dismiss
            self.dismiss(animated: true)
            
            //            // Alert View
            //            let title = NSLocalizedString("resetWarning", comment: "")
            //            let message = NSLocalizedString("resetWarningMessage", comment: "")
            //            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            //            alert.view.tintColor = colour2
            //            alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            //            let paragraphStyle = NSMutableParagraphStyle()
            //            paragraphStyle.alignment = .justified
            //            alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
            //
            //
            //            // Action
            //            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
            //                UIAlertAction in
            //
            //                UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            //                UserDefaults.standard.synchronize()
            //
            //                // Alert View
            //                let title = NSLocalizedString("resetTitle", comment: "")
            //                let message = NSLocalizedString("resetMessage", comment: "")
            //                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            //                alert.view.tintColor = self.colour2
            //                alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            //                let paragraphStyle = NSMutableParagraphStyle()
            //                paragraphStyle.alignment = .justified
            //                alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
            //
            //                self.present(alert, animated: true, completion: nil)
            //
            //
            //            }
            //            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
            //                UIAlertAction in
            //
            //            }
            //
            //            alert.addAction(okAction)
            //            alert.addAction(cancelAction)
            //
            //            self.present(alert, animated: true, completion: nil)
            //
            //            tableView.deselectRow(at: indexPath, animated: true)
            
        //
        default: break
        }
    }
    
    
    //
    // Tap Handlers -------------------------------------------------------------------------------------------------------
    //
    //
    //
    // Image
    @IBAction func handleImageTap(imageTap:UITapGestureRecognizer) {
        //
        // Get Image
        let sender = imageTap.view as! UIImageView
        let tag = sender.tag
        //
        if demonstrationArray[tag].count != 1 {
            sender.startAnimating()
        }
    }

    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        //
        if selectedRow < sessionArray.count - 1 {
            //
            selectedRow = selectedRow + 1
            //
            if automaticYogaArray[0] == 1 {
                automaticYoga()
            }
            
            updateProgress()
            //
            //
            let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
            let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
            let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)
            //
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! YogaOverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                // 1
                cell.breathsLabel.alpha = 1
                cell.poseLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.explanationButton.isEnabled = true
                cell.demonstrationImageView.isUserInteractionEnabled = true
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
            })
                // + 1
                if selectedRow < sessionArray.count - 1 {
                    tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableViewRowAnimation.none)
                }
        } else {
            //
            if automaticYogaArray[0] == 1 {
                UIApplication.shared.isIdleTimerDisabled = false
                self.dismiss(animated: true)
            }
        }
    }
    
    // Back Button
    @IBAction func backButtonAction() {
        
        if selectedRow != 0 {
            //
            selectedRow = selectedRow - 1
            updateProgress()
            //
            let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
            let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
            let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)
            //
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! YogaOverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
                
                // 1
                cell.breathsLabel.alpha = 1
                cell.poseLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.explanationButton.isEnabled = true
                cell.demonstrationImageView.isUserInteractionEnabled = true
                // - 1
                if self.selectedRow > 0 {
                    cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! YogaOverviewTableViewCell
                    cell.breathsLabel.alpha = 0
                    cell.poseLabel.alpha = 0
                }
                // + 1
                cell = self.tableView.cellForRow(at: indexPath3 as IndexPath) as! YogaOverviewTableViewCell
                cell.breathsLabel.alpha = 0
                cell.poseLabel.alpha = 1
                cell.explanationButton.alpha = 0
                cell.explanationButton.isEnabled = false
                cell.demonstrationImageView.isUserInteractionEnabled = false
            //
            })
        }
    }
    
    //
    // Explanation
    //
    let scrollViewExplanation = UIScrollView()
    let backgroundViewExplanation = UIButton()
    //
    let explanationLabel = UILabel()
    // Expand
    @IBAction func expandExplanation() {
        let bounds = UIScreen.main.bounds
        // View
        //
        scrollViewExplanation.frame = CGRect(x: 0, y: 0, width: bounds.width, height: (bounds.height - 20) / 2)
        scrollViewExplanation.center.x = bounds.width/2
        scrollViewExplanation.center.y = (((bounds.height - 20)/2) * 2.5) + 20
        //
        scrollViewExplanation.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        // Background View
        //
        backgroundViewExplanation.frame = CGRect(x: 0, y: 0, width: bounds.width, height: (bounds.height - 20))
        backgroundViewExplanation.backgroundColor = .black
        backgroundViewExplanation.alpha = 0
        //
        backgroundViewExplanation.addTarget(self, action: #selector(retractExplanation(_:)), for: .touchUpInside)
        
        // Contents
        //
        explanationLabel.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        explanationLabel.textColor = .black
        explanationLabel.textAlignment = .natural
        explanationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        explanationLabel.numberOfLines = 0
        //
        let attributedStringE = NSMutableAttributedString(string: NSLocalizedString(explanationArray[selectedRow], comment: ""))
        let paragraphStyleEE = NSMutableParagraphStyle()
        paragraphStyleEE.alignment = .natural
        //
        attributedStringE.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyleEE, range: NSMakeRange(0, attributedStringE.length))
        //
        explanationLabel.attributedText = attributedStringE
        //
        explanationLabel.frame = CGRect(x: 10, y: 10, width: bounds.width - 20, height: 0)
        explanationLabel.sizeToFit()
        
        // Scroll View
        scrollViewExplanation.addSubview(explanationLabel)
        scrollViewExplanation.contentSize = CGSize(width: bounds.width, height: explanationLabel.frame.size.height + 20)
        //
        scrollViewExplanation.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        // Add Views
        UIApplication.shared.keyWindow?.addSubview(backgroundViewExplanation)
        UIApplication.shared.keyWindow?.addSubview(scrollViewExplanation)
    
        //
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.scrollViewExplanation.center.y = (((bounds.height - 20)/2) * 1.5) + 20
            self.backgroundViewExplanation.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract Explanation
    @IBAction func retractExplanation(_ sender: Any) {
        let bounds = UIScreen.main.bounds
        //
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.scrollViewExplanation.center.y = ((bounds.height - 20)/2) * 2.5 + 20
            self.backgroundViewExplanation.alpha = 0
        }, completion: { finished in
            //
            self.scrollViewExplanation.removeFromSuperview()
            self.backgroundViewExplanation.removeFromSuperview()
            //
            self.explanationLabel.removeFromSuperview()
            //
        })
    }

    
    // Update Progress
    func updateProgress() {
        // Current Pose
        let currentPose = Float(selectedRow)
        // Total Number Poses
        let totalPoses = Float(sessionArray.count - 1)
        
        
        //
        if selectedRow > 0 {
            //
            let currentProgress = currentPose / totalPoses
            progressBar.setProgress(currentProgress, animated: true)
        } else {
            // Initial state
            progressBar.setProgress(0, animated: true)
        }
    }
    //
    
    
    //
    // Automatic Yoga Functions ---------------------------------------------------------
    //
    //
    var task: DispatchWorkItem?
    
    func createDispatch() {

        task = DispatchWorkItem {
            //
            if self.automaticYogaArray[3] != -1 {
                let url = Bundle.main.url(forResource: self.bellsArray[self.automaticYogaArray[3]], withExtension: "caf")!
                //
                do {
                    let bell = try AVAudioPlayer(contentsOf: url)
                    self.soundPlayer = bell
                    bell.play()
                } catch {
                    // couldn't load file :(
                }
            }
            //
            self.nextButtonAction()
        }
        
        //
        let poseTime = Double(transitionArray[automaticYogaArray[2]]) + (timeArray[automaticYogaArray[1]] * Double(breathsArray[selectedRow]))
        // Play sound and repeat func
        let dispatchTime = DispatchTime.now() + poseTime
        //
        DispatchQueue.main.asyncAfter(deadline:  dispatchTime, execute: task!)
        
    }
    
    
    // Play Pause
    func pauseButtonAction() {
        //
        if playPause.image(for: .normal) == #imageLiteral(resourceName: "Pause") {
            //
            playPause.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
            //
            if soundPlayer != nil {
                if soundPlayer.isPlaying == true {
                    soundPlayer.stop()
                }
            }
            //
            // Cancel Dispatch
            if task != nil {
                task?.cancel()
            }
            
            // Alert View
            let title = NSLocalizedString("finishEarly", comment: "")
            let message = NSLocalizedString("finishEarlyMessageYoga", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = colour2
            alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
            // Action
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                // Play Ending Bell
                let url = Bundle.main.url(forResource: self.bellsArray[self.automaticYogaArray[3]], withExtension: "caf")!
                //
                do {
                    let bell = try AVAudioPlayer(contentsOf: url)
                    self.soundPlayer = bell
                    bell.play()
                } catch {
                    // couldn't load file :(
                }
                //
                UIApplication.shared.isIdleTimerDisabled = false
                self.dismiss(animated: true)
            }
            let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            //
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            //
            self.present(alert, animated: true, completion: nil)
        
            
        // Play / Continue Practice
        } else {
            //
            playPause.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
            //
            //
            if automaticYogaArray[3] != -1 {
                // Play Initial Bell
                let url = Bundle.main.url(forResource: bellsArray[automaticYogaArray[3]], withExtension: "caf")!
                //
                do {
                    let bell = try AVAudioPlayer(contentsOf: url)
                    soundPlayer = bell
                    bell.play()
                } catch {
                    // couldn't load file :(
                }
            }
            //
            // Creat Dispatch
            createDispatch()
        }
    }
    
    
    //
    func automaticYoga() {
        
        if selectedRow == 0 {
            // App needs to stay on even when nothing is being touched (users watch the screen and follow the yoga poses)
            UIApplication.shared.isIdleTimerDisabled = true

            //
            if automaticYogaArray[3] != -1 {
                // Play Initial Bell
                let url = Bundle.main.url(forResource: bellsArray[automaticYogaArray[3]], withExtension: "caf")!
                //
                do {
                    let bell = try AVAudioPlayer(contentsOf: url)
                    soundPlayer = bell
                    bell.play()
                } catch {
                    // couldn't load file :(
                }
            }
        }
        
        //
        createDispatch()
        //
    }
    
//
}
