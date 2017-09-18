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
    @IBOutlet weak var imageIndicator: UIImageView!
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
    // Variables
    var selectedRow = 0
    
    //
    // MARK: Variables from Session Data
    //
    // Key Array
    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [1] Keys Array
    var keyArray = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[1] as! [Int]
    
    // Sets
    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [2] breaths array
    var breathsArray = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[2] as! [Int]
    
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
    @IBOutlet weak var finishEarly: UIButton!
    
    
    
    //
    // View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        view.backgroundColor = colour2
        
        //
        automaticYogaArray = UserDefaults.standard.object(forKey: "automaticYoga") as! [Int]
        // Progress Bar
        // Thickness
        switch automaticYogaArray[0] {
        // Auto off
        case 0:
            progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
            progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
            //
            finishEarly.tintColor = colour4
        // Auto on
        case 1:
            progressBar.frame = CGRect(x: 44, y: 0, width: self.view.frame.size.width - 44, height: 2)
            progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 43)
            //
            finishEarly.removeFromSuperview()
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
        let title = NSLocalizedString("practiceStarted", comment: "")
        //let message = NSLocalizedString("resetMessage", comment: "")
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.tintColor = colour1
        alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
        self.present(alert, animated: true, completion: {
            //
            let delayInSeconds = 0.7
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                alert.dismiss(animated: true, completion: nil)
                //
                // MARK: Walkthrough
                if UserDefaults.standard.bool(forKey: "sessionWalkthrough2") == false {
                    self.walkthroughSession()
                }
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
        case 0: return keyArray.count
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
            //
            let key = keyArray[indexPath.row]
            
            // Cell
            //
            cell.backgroundColor = colour2
            cell.tintColor = colour2
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //
            cell.selectionStyle = .none
            
            //
            // Movement
            cell.poseLabel.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][key]!, comment: "")
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
            
            //
            cell.explanationButton.tintColor = colour1
            
            // Image
            //
            // [key] = key, [0] = first image
            cell.demonstrationImageView.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[selectedSession[0]][key]?[0])!)
            
            //
            if (sessionData.demonstrationDictionaries[selectedSession[0]][key]!).count > 1 {
                cell.imageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
            } else {
                cell.imageIndicator.image = nil
            }
            
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
            
            
            switch indexPath.row {
            case selectedRow - 1:
                cell.imageIndicator.alpha = 0
                cell.breathsLabel.alpha = 0
                cell.poseLabel.alpha = 0
            //
            case selectedRow:
                cell.imageIndicator.alpha = 1
                cell.breathsLabel.alpha = 1
                cell.poseLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.explanationButton.isEnabled = true
                cell.demonstrationImageView.isUserInteractionEnabled = true
            //
            case selectedRow + 1:
                //
                cell.imageIndicator.alpha = 0
                cell.breathsLabel.alpha = 0
                cell.poseLabel.alpha = 1
                cell.explanationButton.alpha = 0
                cell.explanationButton.isEnabled = false
                cell.demonstrationImageView.isUserInteractionEnabled = false
            //
            default:
                //
                cell.imageIndicator.alpha = 1
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
                    return (UIScreen.main.bounds.height - TopBarHeights.combinedHeight) * 3/4
                case selectedRow + 1:
                    return (UIScreen.main.bounds.height - TopBarHeights.combinedHeight) * 1/4
                default:
                    return (UIScreen.main.bounds.height - TopBarHeights.combinedHeight) * 1/4
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
            
            //
            // Tracking
            updateWeekProgress()
            updateMonthProgress()
            // Dismiss
            self.dismiss(animated: true)
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
        // Get Cell
        let sender = imageTap.view as! UIImageView
        let tag = sender.tag
        let indexPath = NSIndexPath(row: tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! YogaOverviewTableViewCell
        //
        let key = keyArray[indexPath.row]
        //
        let imageCount = (sessionData.demonstrationDictionaries[selectedSession[0]][key]!).count
        //
        // Image Array
        if imageCount > 1 && cell.demonstrationImageView.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.demonstrationDictionaries[selectedSession[0]][key]![i])!)
            }
            //
            cell.demonstrationImageView.animationImages = animationArray
            cell.demonstrationImageView.animationDuration = Double(imageCount - 1) * 0.5
            cell.demonstrationImageView.animationRepeatCount = 1
            //
            sender.startAnimating()
        }
    }

    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        //
        if selectedRow < keyArray.count - 1 {
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
                cell.imageIndicator.alpha = 1
                cell.breathsLabel.alpha = 1
                cell.poseLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.explanationButton.isEnabled = true
                cell.demonstrationImageView.isUserInteractionEnabled = true
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
            })
                // + 1
                if selectedRow < keyArray.count - 1 {
                    tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableViewRowAnimation.none)
                }
        } else {
            //
            if automaticYogaArray[0] == 1 {
                UIApplication.shared.isIdleTimerDisabled = false
                // Tracking
                updateWeekProgress()
                updateMonthProgress()
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
                cell.imageIndicator.alpha = 1
                cell.breathsLabel.alpha = 1
                cell.poseLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.explanationButton.isEnabled = true
                cell.demonstrationImageView.isUserInteractionEnabled = true
                // - 1
                if self.selectedRow > 0 {
                    cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! YogaOverviewTableViewCell
                    cell.imageIndicator.alpha = 0
                    cell.breathsLabel.alpha = 0
                    cell.poseLabel.alpha = 0
                }
                // + 1
                cell = self.tableView.cellForRow(at: indexPath3 as IndexPath) as! YogaOverviewTableViewCell
                cell.imageIndicator.alpha = 0
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
        
        //
        // Contents
        explanationLabel.textAlignment = .natural
        explanationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        explanationLabel.numberOfLines = 0
        //
        let key = keyArray[selectedRow]
        explanationLabel.attributedText = formatExplanationText(title: NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][key]!, comment: ""), howTo: NSLocalizedString("howToTest", comment: ""), toAvoid: NSLocalizedString("toAvoidTest", comment: ""))
        explanationLabel.frame = CGRect(x: 10, y: 10, width: scrollViewExplanation.frame.size.width - 10, height: 0)
        //
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
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.scrollViewExplanation.center.y = (((bounds.height - 20)/2) * 1.5) + 20
            self.backgroundViewExplanation.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract Explanation
    @IBAction func retractExplanation(_ sender: Any) {
        let bounds = UIScreen.main.bounds
        //
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
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
        let totalPoses = Float(keyArray.count - 1)
        
        
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
                
//                // Play Ending Bell
//                let url = Bundle.main.url(forResource: self.bellsArray[self.automaticYogaArray[3]], withExtension: "caf")!
//                //
//                do {
//                    let bell = try AVAudioPlayer(contentsOf: url)
//                    self.soundPlayer = bell
//                    bell.play()
//                } catch {
//                    // couldn't load file :(
//                }
//                //
//                UIApplication.shared.isIdleTimerDisabled = false
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
    @IBAction func finishEarlyAction(_ sender: Any) {
        // Invalidate
        
        //
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
        
        //
        // Action
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            //
            //
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
    }
    
    
    //
    // MARK: Walkthrough ------------------------------------------------------------------------------------------------------------------
    //
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabel = UILabel()
    var nextButton = UIButton()
    
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["session03", "session12", "session32", "session7", "session8", "session9", "session10", "session11"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    var highlightColor = UIColor()
    //
    
    // Walkthrough
    func walkthroughSession() {
        //
        var cellHeight = (UIScreen.main.bounds.height - 22) * 3/4
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughSession), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Movement
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = colour2
            walkthroughLabel.backgroundColor = colour1
            walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width / 2, height: 36)
            walkthroughHighlight.center = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight / 2) * (13/8)) + 2)
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Sets x Reps
        case 1:
            //
            highlightSize = CGSize(width: view.bounds.width / 2, height: 33)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight / 2) * (11/6)) + 2)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour1
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Demonstration
        case 2:
            //
            highlightSize = CGSize(width: view.bounds.width * (7/8), height: (cellHeight * (3/4)))
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight * (3/4)) / 2) + 2)
            highlightCornerRadius = 3
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour1
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
      
            
        // Return to demonstration and Explanation
        case 3:
           
            //
            self.highlightSize = CGSize(width: 45, height: 45)
            self.highlightCenter = CGPoint(x: self.view.bounds.width - 25 - 7.5, y: TopBarHeights.statusBarHeight + cellHeight - 25 - 7.5)
            self.highlightCornerRadius = 0
            //
            self.labelFrame = 0
            //
            self.walkthroughBackgroundColor = colour1
            self.walkthroughTextColor = colour2
            self.highlightColor = colour1
            //
            self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.highlightColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                    
            //
            self.walkthroughProgress = self.walkthroughProgress + 1
            
        // Explanation open and Next Movement
        case 4:
            expandExplanation()
            //
            highlightSize = CGSize(width: 45, height: 45)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + (view.bounds.height / 2))
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = .clear
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            //
            self.walkthroughProgress = self.walkthroughProgress + 1
            //
            // Next Movement
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2, execute: {
                self.retractExplanation(self)
                
                //
                self.highlightSize = CGSize(width: self.view.bounds.width, height: 4)
                self.highlightCenter = CGPoint(x: self.view.bounds.width / 2, y: TopBarHeights.statusBarHeight + 1)
                self.highlightCornerRadius = 0
                //
                self.labelFrame = 0
                //
                self.walkthroughBackgroundColor = colour1
                self.walkthroughTextColor = colour2
                self.highlightColor = .clear
                //
                self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.highlightColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                //
                self.walkthroughProgress = self.walkthroughProgress + 1
            })
            
            
            // Progress
        // Case 6 not 5 as + 1 to walkthroughprogress twice in case 4 for label reasons (need an empty label)
        case 6:
            //
            walkthroughLabel.alpha = 0
            //
            // Swipe demonstration
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                //
                let upSwipe = UIView()
                upSwipe.frame.size = CGSize(width: 50, height: 50)
                upSwipe.backgroundColor = colour1
                upSwipe.layer.cornerRadius = 25
                upSwipe.clipsToBounds = true
                upSwipe.center.y = TopBarHeights.statusBarHeight + (cellHeight * (7/8)) + 2
                upSwipe.center.x = self.view.bounds.width / 2
                UIApplication.shared.keyWindow?.insertSubview(upSwipe, aboveSubview: self.walkthroughView)
                // Perform swipe action
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                    self.nextButtonAction()
                })
                // Animate swipe demonstration
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    //
                    upSwipe.center.y = TopBarHeights.statusBarHeight + (cellHeight * (1/8)) + 2
                    //
                }, completion: { finished in
                    //
                    upSwipe.removeFromSuperview()
                    //
                    self.walkthroughLabel.alpha = 1
                    //
                    self.highlightSize = CGSize(width: self.view.bounds.width, height: 8)
                    self.highlightCenter = CGPoint(x: self.view.bounds.width / 2, y: TopBarHeights.statusBarHeight + 1)
                    self.highlightCornerRadius = 0
                    //
                    self.labelFrame = 0
                    //
                    self.walkthroughBackgroundColor = colour1
                    self.walkthroughTextColor = colour2
                    self.highlightColor = colour1
                    //
                    self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.highlightColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                    //
                    self.walkthroughProgress = self.walkthroughProgress + 1
                    
                })
            })
            
            
        // Finish Early
        case 7:
            //
            highlightSize = CGSize(width: 36, height: 36)
            highlightCenter = CGPoint(x: 27, y: TopBarHeights.statusBarHeight + 2 + 5 + 22)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour1
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            //
            
            
        //
        default:
            //
            backButtonAction()
            //
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                UserDefaults.standard.set(true, forKey: "sessionWalkthrough2")
            })
        }
    }

    
//
}
