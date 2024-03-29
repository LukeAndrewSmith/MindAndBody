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
    
    // Timer
    var poseTimer = Timer()
    var timerValue = 0
    
    //
    // MARK: Variables from Session Data
    var fromCustom = false
    var fromSchedule = false
    //
    // Key Array
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [1] Keys Array
    var keyArray: [String] = []
    
    // Sets
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] breaths array
    var breathsArray: [Int] = []
    
    //
    var automaticYogaArray: [Int] = []

    // Bells Arrays
    let bellsArray: [String] = MeditationSounds.shared.bellsArray
    
    
    //
    // Outlets -----------------------------------------------------------------------------------------------------------
    // Progress Bar
    let progressBar = UIProgressView()
    
    // Table view
    @IBOutlet weak var tableView: UITableView!
    
    var soundPlayer: AVAudioPlayer?

    @IBOutlet weak var finishEarly: UIButton!
    
    var canSwipe = true
    
    
    //
    // View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create key/ breaths arrays
        if fromCustom == false {
            // Loop session
            for i in 0..<(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?.count)! {
                keyArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["pose"] as! String)
                breathsArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["breaths"] as! Int)
            }
        }
        
        //
        view.backgroundColor = Colors.dark
        
        //
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        automaticYogaArray = settings["AutomaticYoga"]!
        // Progress Bar
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        //
        finishEarly.tintColor = Colors.red
        
        // Rounded Edges
        // Colour
        progressBar.trackTintColor = Colors.light
        progressBar.progressTintColor = Colors.green
        //
        progressBar.setProgress(0, animated: true)
        
        // TableView Background
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = Colors.dark
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        //
        tableView.backgroundView = tableViewBackground
        //
        tableView.tableFooterView = UIView()
        
        // Play/Pause
        if automaticYogaArray[0] == 1 {
            finishEarly.backgroundColor = Colors.dark
            finishEarly.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
            finishEarly.tintColor = Colors.red
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Perform the action only once
        if self.isBeingPresented || self.isMovingToParent {
            // MARK: Walkthrough
            let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
            // Walkthrough if not automatic yoga
            if walkthroughs["Session2"] == false {
                walkthroughSession()
            } else {
                if automaticYogaArray[0] == 1 {
                    automaticYoga()
                }
            }
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
        header.contentView.backgroundColor = Colors.light
        
        //
        if section == 0 {
            //
            if header.subviews.contains(progressBar) {
            } else {
                header.addSubview(progressBar)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 2
        case 1:
            return 0
        default:
            break
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
            let cell: YogaOverviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "YogaOverviewTableViewCell", for: indexPath) as! YogaOverviewTableViewCell
            //
            let key = keyArray[indexPath.row]
            
            // Cell
            //
            cell.backgroundColor = Colors.dark
            cell.tintColor = Colors.dark
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            //
            cell.selectionStyle = .none
            
            //
            // Movement
            cell.poseLabel.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0] , comment: "")
            //
            cell.poseLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 33)
            cell.poseLabel?.textAlignment = .center
            cell.poseLabel?.textColor = Colors.light
            cell.poseLabel?.numberOfLines = 0
            cell.poseLabel?.lineBreakMode = .byWordWrapping
            cell.poseLabel?.adjustsFontSizeToFitWidth = true
            
            //
            // Breaths
            cell.breathsLabel?.text = String(breathsArray[indexPath.row]) + " " + NSLocalizedString("breathsC", comment: "")
            cell.breathsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 30)
            cell.breathsLabel?.textAlignment = .right
            cell.breathsLabel?.textColor = Colors.light
            cell.breathsLabel.adjustsFontSizeToFitWidth = true
            
            //
            cell.explanationButton.tintColor = Colors.light
            
            //
            // Image
            // [key] = key, [0] = first image
            let image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
            // If asymmetric movement i.e attributes contains "a", flip image
            if sessionData.movements[SelectedSession.shared.selectedSession[0]]?[key]?["attributes"]?[0].contains("a") ?? false {
                let flippedImage = UIImage(cgImage: (image?.cgImage!)!, scale: (image?.scale)!, orientation: .upMirrored)
                cell.demonstrationImageView.image =  flippedImage
            } else {
                cell.demonstrationImageView.image =  image
            }


            // Indicator
            if ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"])?.count)! > 1 {
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
            // Next Swipe
            let nextSwipe = UISwipeGestureRecognizer()
            nextSwipe.direction = .up
            nextSwipe.addTarget(self, action: #selector(upSwipeAction))
            cell.addGestureRecognizer(nextSwipe)
        
            // Back Swipe
            let backSwipe = UISwipeGestureRecognizer()
            backSwipe.direction = .down
            backSwipe.addTarget(self, action: #selector(downSwipeAction))
            cell.addGestureRecognizer(backSwipe)
            
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
                cell.poseLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)
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
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            //
            cell.separatorInset =  UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            //
            cell.layer.borderWidth = 2
            cell.layer.borderColor = Colors.light.cgColor
            //
            cell.textLabel?.text = NSLocalizedString("end", comment: "")
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)
            cell.textLabel?.textColor = Colors.light
            cell.textLabel?.textAlignment = .center
            //
            return cell
        default:
            return UITableViewCell(style: .value1, reuseIdentifier: nil)
        }
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch indexPath.section {
        case 0:
            let toMinus: CGFloat = ElementHeights.statusBarHeight + 2 + ElementHeights.bottomSafeAreaInset
            switch indexPath.row {
            case selectedRow - 1, selectedRow:
                return (UIScreen.main.bounds.height - toMinus) * 7/8
            case selectedRow + 1:
                return (UIScreen.main.bounds.height - toMinus) * 1/8
            default:
                return (UIScreen.main.bounds.height - toMinus) * 1/8
            }
        //
        case 1: return 49
        default:
            break
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
                
                // Cancel Dispatch
                cancelTimer()
                //
                UIApplication.shared.isIdleTimerDisabled = false
            }
            
            //
            // Schedule Tracking
            ScheduleManager.shared.shouldReloadScheduleTracking()
            // Dismiss
            self.dismissPractice()
            //
        default: break
        }
    }
    
    
    //
    // Tap Handlers -------------------------------------------------------------------------------------------------------
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
        let imageCount = ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"])?.count)!
        //
        // Image Array
        if imageCount > 1 && cell.demonstrationImageView.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![i])!)
            }
            //
            cell.demonstrationImageView.animationImages = animationArray
            cell.demonstrationImageView.animationDuration = Double(imageCount - 1) * 0.5
            cell.demonstrationImageView.animationRepeatCount = 1
            //
            sender.startAnimating()
        }
    }
    
    // Play Image
    func playAnimation(row: Int) {
        //
        // Get Cell
        let indexPath = NSIndexPath(row: row, section: 0)
        let cell: YogaOverviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "YogaOverviewTableViewCell", for: indexPath as IndexPath) as! YogaOverviewTableViewCell
        //
        let key = keyArray[indexPath.row]
        //
        let imageCount = ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"])?.count)!
        //
        // Image Array
        if imageCount > 1 && cell.demonstrationImageView.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![i])!)
            }
            //
            cell.demonstrationImageView.animationImages = animationArray
            cell.demonstrationImageView.animationDuration = Double(imageCount - 1) * 0.5
            cell.demonstrationImageView.animationRepeatCount = 1
            //
            cell.demonstrationImageView.startAnimating()
        }
    }

    //
    @IBAction func upSwipeAction() {
        // Cancel Dispatch
        if canSwipe && selectedRow != keyArray.count-1 && automaticYogaArray[0] == 1 {
            cancelTimer()
        }
        nextButtonAction()
    }
    
    @IBAction func downSwipeAction() {
        // Cancel Dispatch
        if canSwipe && selectedRow != 0 && automaticYogaArray[0] == 1 {
            cancelTimer()
        }
        backButtonAction()
    }
    
    // Next Button
    @IBAction func nextButtonAction() {
        
        if canSwipe {
            if selectedRow < keyArray.count - 1 {
                
                selectedRow = selectedRow + 1
                updateProgress()

                // Play bell and start next timer
                if self.automaticYogaArray[3] != -1 && automaticYogaArray[0] == 1 {
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
                startTimer()
                //
                let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
                let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)
                //
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as! YogaOverviewTableViewCell
                //
                UIView.animate(withDuration: 0.6, animations: {
                    //
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                    // 1
                    cell.poseLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 33)
                    cell.imageIndicator.alpha = 1
                    cell.breathsLabel.alpha = 1
                    cell.poseLabel.alpha = 1
                    cell.explanationButton.alpha = 1
                    cell.explanationButton.isEnabled = true
                    cell.demonstrationImageView.isUserInteractionEnabled = true
                    //
                    self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: false)
                }, completion: {finished in
    //                self.playAnimation(row: self.selectedRow)
                })
                    // + 1
                    if selectedRow < keyArray.count - 1 {
                        tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableView.RowAnimation.none)
                    }
            } else {
                //
                if automaticYogaArray[0] == 1 {
                    UIApplication.shared.isIdleTimerDisabled = false
                    // Tracking
                    ScheduleManager.shared.shouldReloadScheduleTracking()
                    
                    // Play bell and start next timer
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
                    self.dismissPractice()
                }
            }
        }
    }
    
    // Back Button
    @IBAction func backButtonAction() {
        
        if canSwipe {
            if selectedRow != 0 {
                
                selectedRow = selectedRow - 1
                updateProgress()
                
                // Play bell and start next timer
                if self.automaticYogaArray[3] != -1 && automaticYogaArray[0] == 1 {
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
                startTimer()
                
                //
                let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
                let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
                let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)
                //
                var cell = tableView.cellForRow(at: indexPath as IndexPath) as! YogaOverviewTableViewCell
                //
                UIView.animate(withDuration: 0.6, animations: {
                    //
                    // As progress bar is contained in the table view header, scrolling back to row 0 jumps the progress bar off the screen
                    // Silly fix below seems to work
                    if self.selectedRow == 0 {
                        self.tableView.beginUpdates()
                        self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: false)
                        self.tableView.endUpdates()
                    } else {
                        self.tableView.beginUpdates()
                        self.tableView.endUpdates()
                        self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: false)
                    }

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
                    cell.poseLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)
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
        // Pause running if automatic yoga and not already paused (i.e can still swipe)
        if automaticYogaArray[0] == 1 && canSwipe {
            pauseButtonAction(presentAlert: false)
        }

        //
        let bounds = UIScreen.main.bounds
        // View
        scrollViewExplanation.frame = CGRect(x: 0, y: 0, width: bounds.width, height: (bounds.height - 20) / 2)
        scrollViewExplanation.center.x = bounds.width/2
        scrollViewExplanation.center.y = (((bounds.height - 20)/2) * 2.5) + 20
        //
        scrollViewExplanation.backgroundColor = Colors.light
        
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
        explanationLabel.attributedText = formatExplanationText(title: NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0], comment: ""), howTo: NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["explanation"]![0], comment: ""), toAvoid: NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["explanation"]![1], comment: ""), focusOn: NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["explanation"]![2], comment: ""))
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
        // Continue running
        if automaticYogaArray[0] == 1 {
            continuePracticeFunc()
        }
        
        //
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
    // MARK: Automatic Yoga Functions ---------------------------------------------------------
    //
    
    func startTimer() {
        // Check
        if poseTimer.isValid {
            poseTimer.invalidate()
        }
        
        let transitionTime = automaticYogaArray[2]
        let breathLength = Double(automaticYogaArray[1]) / 10
        let poseTime = Double(transitionTime) + (breathLength * Double(breathsArray[selectedRow]))
        timerValue = Int(poseTime)
        
        poseTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if timerValue <= 0 {
            nextButtonAction()
        } else {
            timerValue -= 1
        }
    }
    
    func cancelTimer() {
        if poseTimer.isValid {
            poseTimer.invalidate()
        }
    }
    
    // Play Pause
    func pauseButtonAction(presentAlert: Bool) {
        //
        if finishEarly.image(for: .normal) == #imageLiteral(resourceName: "Pause") {
            //
            canSwipe = false
            finishEarly.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
            finishEarly.tintColor = Colors.green
            //
            if soundPlayer != nil {
                if (soundPlayer?.isPlaying)! {
                    soundPlayer?.stop()
                }
            }
            //
            // Cancel Dispatch
            cancelTimer()
            
            // Alert View
            let title = NSLocalizedString("pauseYoga", comment: "")
            let message = NSLocalizedString("pauseMessageYoga", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = Colors.dark
            alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
            // Actions
            // Dismiss
            let finishEarlyAction = UIAlertAction(title: NSLocalizedString("finishEarly", comment: ""), style: .default) { _ in
                self.dismissPractice()
            }
            // Dismiss alert
            let pauseAction = UIAlertAction(title: NSLocalizedString("pause", comment: ""), style: .default) { _ in }
            // Continue
            let continuePracticeAction = UIAlertAction(title: NSLocalizedString("continuePractice", comment: ""), style: .default) { _ in
                self.continuePracticeFunc()
            }

            // Add actions
            alert.addAction(finishEarlyAction)
            alert.addAction(pauseAction)
            alert.addAction(continuePracticeAction)
            //
            if presentAlert {
                self.present(alert, animated: true, completion: nil)
            }
            
        // Play / Continue Practice
        } else {
            continuePracticeFunc()
        }
    }
    
    // Continue practice
    func continuePracticeFunc() {
        //
        canSwipe = true
        finishEarly.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
        finishEarly.tintColor = Colors.red
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
        startTimer()
    }
    
    //
    func automaticYoga() {
        
        if selectedRow == 0 {
            // App needs to stay on even when nothing is being touched (users watch the screen and follow the yoga poses)
            UIApplication.shared.isIdleTimerDisabled = true

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
        
        startTimer()
    }
    
    //
    @IBAction func finishEarlyAction(_ sender: Any) {
        // Invalidate
        
        if automaticYogaArray[0] == 0 {
            //
            // Alert View
            let title = NSLocalizedString("finishEarly", comment: "")
            let message = NSLocalizedString("finishEarlyMessage", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = Colors.dark
            alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedString.Key.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
            
            //
            // Action
            let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                UIAlertAction in
                //
                self.dismissPractice()
            }
            let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default) {
                UIAlertAction in
            }
            //
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            //
            self.present(alert, animated: true, completion: nil)
        } else {
            pauseButtonAction(presentAlert: true)
        }
    }
    
    func dismissPractice() {
        cancelTimer()
        self.dismiss(animated: true)
    }
    
    //
    // MARK: Walkthrough ------------------------------------------------------------------------------------------------------------------
    //
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabelView = UIView()
    var walkthroughLabelTitle = UILabel()
    var walkthroughLabelSeparator = UIView()
    var walkthroughLabel = UILabel()
    var walkthroughNextButton = UIButton()
    var walkthroughBackButton = UIButton()
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["yogaPractice0", "yogaPractice1", "yogaPractice2", "yogaPractice3"]
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
    
    @objc func backActionWalkthrough() {
        if walkthroughProgress != 0 && walkthroughProgress != 1 {
            walkthroughProgress -= 2
            walkthroughSession()
        }
    }
    
    // Walkthrough
    @objc func walkthroughSession() {
        
        /// To speed up compile times
        var x = CGFloat()
        var y = CGFloat()
        var width = CGFloat()
        var height = CGFloat()
        
        //
        let toAdd: CGFloat = ElementHeights.statusBarHeight + 2
        let toMinus: CGFloat = ElementHeights.statusBarHeight + 2 + ElementHeights.bottomSafeAreaInset
        let cellHeight: CGFloat = (UIScreen.main.bounds.height - toMinus) * 3/4
        
        let delayShort = 0.6
        
        //
        if didSetWalkthrough == false {
            //
            walkthroughNextButton.addTarget(self, action: #selector(walkthroughSession), for: .touchUpInside)
            walkthroughBackButton.addTarget(self, action: #selector(backActionWalkthrough), for: .touchUpInside)

            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, separator: walkthroughLabelSeparator, nextButton: walkthroughNextButton, backButton: walkthroughBackButton, highlight: walkthroughHighlight, simplePopup: false)
            didSetWalkthrough = true
        }

        //
        switch walkthroughProgress {
            // First has to be done differently
        // Sets x Reps
        case 0:

            //
            walkthroughLabelTitle.text = NSLocalizedString(walkthroughTexts[walkthroughProgress] + "T", comment: "")

            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.frame.size = walkthroughLabel.sizeThatFits(CGSize(width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding, height: .greatestFiniteMagnitude))

            x = WalkthroughVariables.padding
            y = WalkthroughVariables.topHeight + WalkthroughVariables.padding
            width = walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding
            height = walkthroughLabel.frame.size.height
            walkthroughLabel.frame = CGRect(x: x, y: y, width: width, height: height)

            x = 13
            y = 13 + ElementHeights.combinedHeight
            width = view.frame.size.width - WalkthroughVariables.twiceViewPadding
            height = WalkthroughVariables.topHeight + walkthroughLabel.frame.size.height + WalkthroughVariables.twicePadding
            walkthroughLabelView.frame = CGRect(x: x, y: y, width: width, height: height)

            // Colour
            walkthroughLabelView.backgroundColor = Colors.light
            walkthroughLabel.textColor = Colors.dark
            walkthroughLabelTitle.textColor = Colors.dark
            walkthroughLabelSeparator.backgroundColor = Colors.dark
            walkthroughNextButton.setTitleColor(Colors.dark, for: .normal)
            walkthroughBackButton.setTitleColor(Colors.dark, for: .normal)
            walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.light.cgColor

            // Flash
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! YogaOverviewTableViewCell
                width = cell.breathsLabel.frame.width + 16
                height = cell.breathsLabel.frame.height + 4
                self.walkthroughHighlight.frame.size = CGSize(width: width, height: height)
                self.walkthroughHighlight.center = cell.breathsLabel.center
                self.walkthroughHighlight.center.y += toAdd
                self.walkthroughHighlight.layer.cornerRadius = self.walkthroughHighlight.bounds.height / 2

                self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colors.light.withAlphaComponent(0.5)
                }, completion: nil)
            })

            walkthroughProgress = self.walkthroughProgress + 1
//
//        // Explanation
//        case 1:
//            //
//            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! YogaOverviewTableViewCell
//            highlightSize = cell.explanationButton.frame.size
//            highlightCenter = cell.explanationButton.center
//            highlightCenter?.y += toAdd
//            //
//            highlightCornerRadius = 0
//            // Top
//            labelFrame = 1
//            //
//            walkthroughBackgroundColor = Colors.light
//            walkthroughTextColor = Colors.dark
//            highlightColor = Colors.light
//            walkthroughHighlight.alpha = 1
//            //
//            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
//
//            //
//            walkthroughProgress = self.walkthroughProgress + 1
//
//        // Next Movement
//        case 2:
//            //
//            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! YogaOverviewTableViewCell
//            highlightSize = cell.explanationButton.frame.size
//            highlightCenter = cell.explanationButton.center
//            highlightCenter?.y += toAdd
//            //
//            highlightCornerRadius = 0
//            // Top
//            labelFrame = 1
//            //
//            walkthroughBackgroundColor = Colors.light
//            walkthroughTextColor = Colors.dark
//            highlightColor = Colors.light
//            walkthroughHighlight.alpha = 0
//            //
//            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
//
//            //
//            walkthroughProgress = self.walkthroughProgress + 1
//
//        // Next movement demonstration and then go to finish early
//        case 3:
//            //
//            walkthroughLabelView.alpha = 0
//            //
//            // Swipe demonstration
//            walkthroughNextButton.isEnabled = false
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayShort, execute: {
//                //
//                let upSwipe = UIView()
//                upSwipe.frame.size = CGSize(width: 50, height: 50)
//                upSwipe.backgroundColor = Colors.light
//                upSwipe.layer.cornerRadius = 25
//                upSwipe.clipsToBounds = true
//                upSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (7/8)) + 2
//                upSwipe.center.x = self.view.bounds.width / 2
//                UIApplication.shared.keyWindow?.insertSubview(upSwipe, aboveSubview: self.walkthroughView)
//                // Perform swipe action
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
//                    self.nextButtonAction()
//                })
//                // Animate swipe demonstration
//                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                    //
//                    upSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (1/8)) + 2
//                    //
//                }, completion: { finished in
//                    upSwipe.removeFromSuperview()
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayShort, execute: {
//                        //
//                        let downSwipe = UIView()
//                        downSwipe.frame.size = CGSize(width: 50, height: 50)
//                        downSwipe.backgroundColor = Colors.light
//                        downSwipe.layer.cornerRadius = 25
//                        downSwipe.clipsToBounds = true
//                        downSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (1/8)) + 2
//                        downSwipe.center.x = self.view.bounds.width / 2
//                        UIApplication.shared.keyWindow?.insertSubview(downSwipe, aboveSubview: self.walkthroughView)
//                        // Perform swipe action
//                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
//                            self.backButtonAction()
//                        })
//                        // Animate swipe demonstration
//                        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                            //
//                            downSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (7/8)) + 2
//                            //
//                        }, completion: { finished in
//                            self.walkthroughNextButton.isEnabled = true
//                            //
//                            downSwipe.removeFromSuperview()
//                            //
//                            self.walkthroughLabelView.alpha = 1
//                            //
//                            self.highlightSize = CGSize(width: 36, height: 36)
//                            self.highlightCenter = CGPoint(x: 27, y: ElementHeights.statusBarHeight + 2 + 5 + 22)
//                            self.highlightCornerRadius = 0
//                            self.walkthroughHighlight.alpha = 1
//                            //
//                            self.labelFrame = 0
//                            //
//                            self.walkthroughBackgroundColor = Colors.light
//                            self.walkthroughTextColor = Colors.dark
//                            self.highlightColor = Colors.light
//                            //
//                            self.nextWalkthroughViewTest(walkthroughView: self.walkthroughView, labelView: self.walkthroughLabelView, label: self.walkthroughLabel, title: self.walkthroughLabelTitle, highlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
//                            //
//                            self.walkthroughProgress = self.walkthroughProgress + 1
//
//                        })
//                    })
//                })
//            })
        
        //
        default:
            break
//            UIView.animate(withDuration: 0.4, animations: {
//                self.walkthroughView.alpha = 0
//            }, completion: { finished in
//                self.didSetWalkthrough = false
//                self.walkthroughView.removeFromSuperview()
//                var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
//                walkthroughs["Session2"] = true
//                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
//                // Start automatic yoga
//                if self.automaticYogaArray[0] == 1 {
//                    self.automaticYoga()
//                }
//            })
        }
    }

    
//
}

