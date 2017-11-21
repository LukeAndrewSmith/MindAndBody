//
//  TimeBasedSession.swift
//  MindAndBody
//
//  Created by Luke Smith on 08.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import AVFoundation

//
// Custom TimeBasedTableViewCell ---------------------------------------------------------------------------
//
// Stretching TableView Cell
class TimeBasedTableViewCell: UITableViewCell {
    // Image View
    @IBOutlet weak var imageViewCell: UIImageView!
    //
    @IBOutlet weak var indicatorStack: UIStackView!
    @IBOutlet weak var leftImageIndicator: UIImageView!
    @IBOutlet weak var rightImageIndicator: UIImageView!
    // Title Label
    @IBOutlet weak var movementLabel: UILabel!
    // Explanation
    @IBOutlet weak var explanationButton: UIButton!
    // Time Label
    @IBOutlet weak var timeLabel: UILabel!
    // Indicator Label
    @IBOutlet weak var indicatorLabel: UILabel!
}

//
// Stretching Screen Class ------------------------------------------------------------------------------------
//
class TimeBasedScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //
    // Variables
    var selectedRow = 0
    
    //
    var fromSchedule = false
    
    //
    // Is paused
    var isPaused = false
    
    //
    // MARK: Variables from Session Data
    //
    // Key Array
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [1] Keys Array
    var keyArray = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1] as! [Int]
    
    // Length
    var lengthArray: [Int] = []
    
    // To Add (@2x or @3x) for demonstration images
    var toAdd = String()
    
    var soundPlayer = AVAudioPlayer()
    //
    // Timer Elements
    //
    var sessionLength = Int()
    var timerShapeLayer: CAShapeLayer!
    var lengthTimer = Timer()
    var animationAdded = false
    // Movement progresss indicates wether to display, rest, 5 second prepare for movement, or time to perform movement
    // Starts on 1 as no need for rest before first movement
        // 0 == rest, 1 == prepare, 2 == perform
    var movementProgress = 1
    // Timer value
    var timerValue = 0
    // Variable for circuit workout, indicating number of movements in one round
    var nMovementsInRound = 0
    // If asymmetric movement, time both sides, this variable indicates which side is being timed
    var asymmetricProgress = 0
    
    //
    // Outlets -----------------------------------------------------------------------------------------------------------
    //
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Progress Bar
    let progressBar = UIProgressView()
    
    //
    @IBOutlet weak var finishEarly: UIButton!
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Session Started
        //
        // Alert View
        let title = NSLocalizedString("sessionStarted", comment: "")
        //let message = NSLocalizedString("resetMessage", comment: "")
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.tintColor = Colours.colour1
        alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 23)!]), forKey: "attributedTitle")
        self.present(alert, animated: true, completion: {
            //
            let delayInSeconds = 0.7
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                alert.dismiss(animated: true, completion: nil)
                self.indicateMovementProgress()
            }
        })
    }
    
    //
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Reenable Idle Timer
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    //
    // View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // User doesn't interact with the phone but it is still in use
        UIApplication.shared.isIdleTimerDisabled = true
        
        //
        switch SelectedSession.shared.selectedSession[0] {
        // Warmup/Bodyweight Circuit Wokrout
        case 0,1:
            lengthArray = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[4] as! [Int]
        // Stretching
        case 3:
            lengthArray = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[3] as! [Int]
        default:
            break
        }
        //
        // Special case for circuit workout
            // Add the movements to the key array x(number of rounds) more times
        switch SelectedSession.shared.selectedSession[1] {
        case 13,14,15:
            nMovementsInRound = keyArray.count
            var enlargedKeyArray = keyArray
            let nRounds = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[2][0] as! Int
            // nRounds is always greater than 1, so if 2, then 1...1 adds 1 set of keys, therefore there are two rounds
            for _ in 1...nRounds - 1 {
                enlargedKeyArray += keyArray
            }
            keyArray = enlargedKeyArray
            
        default:
            break
        }
        
        
        // Device Scale for @2x and @3x of Target Area Images
        switch UIScreen.main.scale {
        case 1,2:
            toAdd = "@2x"
        case 3:
            toAdd = "@3x"
        default: break
        }
        
        
        //
        view.backgroundColor = Colours.colour2
        
        
        //
        finishEarly.tintColor = Colours.colour4
        
        // self.present(alert, animated: true, completion: (() -> Void)?)
        
        // Progress Bar
        // Thickness
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        // Rounded Edges
        // Colour
        progressBar.trackTintColor = Colours.colour1
        progressBar.progressTintColor = Colours.colour3
        //
        progressBar.setProgress(0, animated: true)
        
        // TableView Background
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = Colours.colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        //
        tableView.backgroundView = tableViewBackground
        //
        tableView.tableFooterView = UIView()
        
    }
    
    
    //
    // MARK: TableView ---------------------------------------------------------------------------------------------------------------------
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
        header.contentView.backgroundColor = Colours.colour1
        
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
        case 0: return 2
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeBasedTableViewCell", for: indexPath) as! TimeBasedTableViewCell
            
            //
            let key = keyArray[indexPath.row]
            
            //
            // Cell
            cell.backgroundColor = Colours.colour2
            cell.tintColor = Colours.colour2
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.selectionStyle = .none
            
            // New image to display
            // Demonstration on left
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let defaultImage = settings["DefaultImage"]![0]
            if defaultImage == 0 {
                // [key] = key, [0] = first image
                cell.imageViewCell.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]?[0])!)
                // Indicator
                if (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]!).count > 1 {
                    cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                } else {
                    cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                }
                cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                // Target Area on left
            } else {
                // [key] = key
                cell.imageViewCell.image = getUncachedImage(named: (sessionData.targetAreaDictionaries[SelectedSession.shared.selectedSession[0]][key])! + toAdd)
                // Indicator
                if (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]!).count > 1 {
                    cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImagePlayDeselected")
                } else {
                    cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                }
                cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
            }
            
            //
            cell.imageViewCell.tag = indexPath.row
            //
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleImageTap))
            cell.imageViewCell.addGestureRecognizer(imageTap)
            //
            
            //
            // Movement
            cell.movementLabel.text = NSLocalizedString(sessionData.movementsDictionaries[SelectedSession.shared.selectedSession[0]][key]!, comment: "")
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 33)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.timeLabel?.adjustsFontSizeToFitWidth = true
            
            //
            cell.indicatorLabel.text = " "
            
            //
            // Explanation
            cell.explanationButton.tintColor = Colours.colour1
            
            //
            // Gestures
            // Explanation
            let explanationTap = UITapGestureRecognizer()
            explanationTap.numberOfTapsRequired = 1
            explanationTap.addTarget(self, action: #selector(expandExplanation))
            cell.explanationButton.addGestureRecognizer(explanationTap)
            
            // Left Image Swift
            let imageSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            imageSwipeLeft.direction = UISwipeGestureRecognizerDirection.left
            cell.imageViewCell.addGestureRecognizer(imageSwipeLeft)
            cell.imageViewCell.isUserInteractionEnabled = true
            
            // Right Image Swipe
            let imageSwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            imageSwipeRight.direction = UISwipeGestureRecognizerDirection.right
            cell.imageViewCell.addGestureRecognizer(imageSwipeRight)
            cell.imageViewCell.isUserInteractionEnabled = true
            
            // Alphas
            switch indexPath.row {
            case selectedRow - 1:
                cell.indicatorStack.alpha = 0
                cell.movementLabel.alpha = 0
                cell.explanationButton.alpha = 0
                cell.timeLabel.alpha = 0
            //
            case selectedRow:
                cell.indicatorStack.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.timeLabel.alpha = 1
            //
            case selectedRow + 1:
                //
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.selectionStyle = .none
                //
                cell.indicatorStack.alpha = 0
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 0
                cell.timeLabel.alpha = 0
                cell.imageViewCell.alpha = 1
            //
            default:
                //
                cell.indicatorStack.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                cell.timeLabel.alpha = 1
            }
            
            //
            // Hide question mark and image indicators if not paused
            if isPaused == false {
                cell.indicatorStack.alpha = 0
                cell.explanationButton.alpha = 0
            }
            
            //
            return cell
        //
        case 1:
            //
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            //
            cell.separatorInset =  UIEdgeInsetsMake(0, 0, 0, 0)
            //
            cell.layer.borderWidth = 2
            cell.layer.borderColor = Colours.colour1.cgColor
            //
            cell.textLabel?.text = NSLocalizedString("end", comment: "")
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 33)
            cell.textLabel?.textColor = Colours.colour1
            cell.textLabel?.textAlignment = .center
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
            var toMinus = CGFloat()
            if IPhoneType.shared.iPhoneType() == 2 {
                toMinus = TopBarHeights.statusBarHeight + 2 + 34
            } else {
                toMinus = TopBarHeights.statusBarHeight + 2
            }
            switch indexPath.row {
            case selectedRow - 1, selectedRow:
                return (UIScreen.main.bounds.height - toMinus) * 9/10
            case selectedRow + 1:
                return (UIScreen.main.bounds.height - toMinus) * 1/10
            default:
                return (UIScreen.main.bounds.height - toMinus) * 1/10
            }
        case 1: return 49
        default: return 0
        }
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch indexPath.section {
        case 0: break
        //
        case 1:
            //
            // Tracking
            updateWeekProgress()
            // Schedule Tracking
            updateScheduleTracking(fromSchedule: fromSchedule)
            //
            self.dismiss(animated: true)
        //
        default: break
        }
    }
    
    //
    // MARK: Tap Handlers, buttons and funcs -------------------------------------------------------------------------------------------------------
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
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
        //
        let key = keyArray[indexPath.row]
        //
        let imageCount = (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]!).count
        //
        // Image Array
        if imageCount > 1 && cell.imageViewCell.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]![i])!)
            }
            //
            cell.imageViewCell.animationImages = animationArray
            cell.imageViewCell.animationDuration = Double(imageCount - 1) * 0.5
            cell.imageViewCell.animationRepeatCount = 1
            //
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let defaultImage = settings["DefaultImage"]![0]
            if defaultImage == 0 && cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") || UserDefaults.standard.string(forKey: "targetArea") == "demonstration" && cell.rightImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") {
                if imageCount != 1 {
                    sender.startAnimating()
                }
            }
        }
    }
    
    // Play Image
    func playAnimation(row: Int) {
        //
        // Get Cell
        let indexPath = NSIndexPath(row: row, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
        //
        let key = keyArray[indexPath.row]
        //
        let imageCount = (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]!).count
        //
        // Image Array
        if imageCount > 1 && cell.imageViewCell.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]![i])!)
            }
            //
            cell.imageViewCell.animationImages = animationArray
            cell.imageViewCell.animationDuration = Double(imageCount - 1) * 0.5
            cell.imageViewCell.animationRepeatCount = 1
            //
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let defaultImage = settings["DefaultImage"]![0]
            if defaultImage == 0 && cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") || UserDefaults.standard.string(forKey: "targetArea") == "demonstration" && cell.rightImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") {
                if imageCount != 1 {
                    cell.imageViewCell.startAnimating()
                }
            }
        }
    }
    
    // Play Image
    func playAnimationReversed(row: Int) {
        //
        // Get Cell
        let indexPath = NSIndexPath(row: row, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
        let key = keyArray[indexPath.row]
        // Reverse image
        //
        // Image
        // [key] = key, [0] = first image
        let image = getUncachedImage(named: (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]?[0])!)
        // If asymmetric array contains image, flip imageview
        if sessionData.asymmetricMovements[SelectedSession.shared.selectedSession[0]].contains(key) {
            let flippedImage = UIImage(cgImage: (image?.cgImage!)!, scale: (image?.scale)!, orientation: .upMirrored)
            cell.imageViewCell.image =  flippedImage
        }
        //
        let imageCount = (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]!).count
        //
        // Image Array
        if imageCount > 1 && cell.imageViewCell.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]![i])!)
            }
            //
            cell.imageViewCell.animationImages = animationArray
            cell.imageViewCell.animationDuration = Double(imageCount - 1) * 0.5
            cell.imageViewCell.animationRepeatCount = 1
            //
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            let defaultImage = settings["DefaultImage"]![0]
            if defaultImage == 0 && cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") || UserDefaults.standard.string(forKey: "targetArea") == "demonstration" && cell.rightImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") {
                if imageCount != 1 {
                    cell.imageViewCell.startAnimating()
                }
            }
        }
    }
    
    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        if selectedRow < keyArray.count - 1 {
            //
            selectedRow = selectedRow + 1
            updateProgress()
            //
            //
            let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
            let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
            let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)
            //
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                // 1
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-light", size: 33)
                cell.movementLabel.alpha = 1
                cell.imageViewCell.alpha = 1
                cell.timeLabel.alpha = 1
                //
                // -1
                cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! TimeBasedTableViewCell
                cell.indicatorStack.alpha = 0
                cell.movementLabel.alpha = 0
                cell.explanationButton.alpha = 0
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
            })
            // + 1
            if selectedRow < keyArray.count - 1 {
                tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableViewRowAnimation.none)
            }
            //
            indicateMovementProgress()
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
        explanationLabel.attributedText = formatExplanationText(title: NSLocalizedString(sessionData.movementsDictionaries[SelectedSession.shared.selectedSession[0]][key]!, comment: ""), howTo: NSLocalizedString(sessionData.explanationDictionaries[SelectedSession.shared.selectedSession[0]][key]![0], comment: ""), toAvoid: NSLocalizedString(sessionData.explanationDictionaries[SelectedSession.shared.selectedSession[0]][key]![1], comment: ""), focusOn: NSLocalizedString(sessionData.explanationDictionaries[SelectedSession.shared.selectedSession[0]][key]![2], comment: ""))
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
    
    
    //
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
        //
        let key = keyArray[indexPath.row]
        let imageCount = (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]!).count
        //
        if cell.imageViewCell.isAnimating == false {
            //
            switch extraSwipe.direction {
            //
            case UISwipeGestureRecognizerDirection.left:
                //
                // Check left image is displayed
                if cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImageDot") || cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") {
                    // Screenshot of current image
                    let snapshot1 = cell.imageViewCell.snapshotView(afterScreenUpdates: false)
                    snapshot1?.bounds = cell.imageViewCell.bounds
                    snapshot1?.center.x = cell.center.x
                    snapshot1?.center.y = cell.imageViewCell.center.y
                    cell.addSubview(snapshot1!)
                    
                    // New image to display
                    // Demonstration on left
                    var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                    let defaultImage = settings["DefaultImage"]![0]
                    if defaultImage == 0 {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.targetAreaDictionaries[SelectedSession.shared.selectedSession[0]][key]! + toAdd)
                        // Indicator
                        if imageCount > 1 {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlayDeselected")
                        } else {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                        }
                        cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                        // Target Area on left
                    } else {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]![0])
                        // Indicator
                        if imageCount > 1 {
                            cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                        } else {
                            cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                        }
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                    }
                    
                    // Move new image to right of screen
                    cell.imageViewCell.center.x = cell.center.x + cell.frame.size.width
                    cell.imageViewCell.reloadInputViews()
                    
                    // Animate new and old image
                    UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        //
                        snapshot1?.center.x = cell.center.x - cell.frame.size.width
                        cell.imageViewCell.center.x = cell.center.x
                        //
                    }, completion: { finished in
                        snapshot1?.removeFromSuperview()
                    })
                    //
                }
            //
            case UISwipeGestureRecognizerDirection.right:
                //
                if cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImageDotDeselected") || cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlayDeselected") {
                    //
                    let snapshot1 = cell.imageViewCell.snapshotView(afterScreenUpdates: false)
                    snapshot1?.bounds = cell.imageViewCell.bounds
                    snapshot1?.center.x = cell.center.x
                    snapshot1?.center.y = cell.imageViewCell.center.y
                    cell.addSubview(snapshot1!)
                    
                    // New image to display
                    // Demonstration on left
                    var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                    let defaultImage = settings["DefaultImage"]![0]
                    if defaultImage == 0 {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]![0])
                        // Indicator
                        if imageCount > 1 {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                        } else {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                        }
                        cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                        // Target Area on left
                    } else {
                        cell.imageViewCell.image = getUncachedImage(named: sessionData.targetAreaDictionaries[SelectedSession.shared.selectedSession[0]][key]! + toAdd)
                        // Indicator
                        if imageCount > 1 {
                            cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImagePlayDeselected")
                        } else {
                            cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                        }
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                    }
                    
                    //
                    cell.imageViewCell.center.x = cell.center.x - cell.frame.size.width
                    cell.imageViewCell.reloadInputViews()
                    
                    //
                    UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        snapshot1?.center.x = cell.center.x + cell.frame.size.width
                        cell.imageViewCell.center.x = cell.center.x
                        //
                    }, completion: { finished in
                        snapshot1?.removeFromSuperview()
                    })
                    //
                }
            default: break
            }
        }
    }
    
    
    //
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
    @IBAction func finishEarlyAction(_ sender: Any) {
        // Cell Detail
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
        // Pause
        if isPaused == false {
            // Invalidate
            lengthTimer.invalidate()
            removeCircle()
            isPaused = true
            finishEarly.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
            finishEarly.tintColor = Colours.colour3
            switch movementProgress {
            case 0:
                cell.indicatorLabel.text = " "
                cell.timeLabel.text = NSLocalizedString("rest", comment: "")
            case 1:
                cell.indicatorLabel.text = " "
                cell.timeLabel.text = NSLocalizedString("prepare", comment: "")
            case 2:
                cell.indicatorLabel.text = " "
                cell.timeLabel.text = NSLocalizedString("beginMovement", comment: "")
            default:
                break
            }
            //
            cell.indicatorStack.alpha = 1
            cell.explanationButton.alpha = 1
            
            //
            // Alert View
            let title = NSLocalizedString("finishEarly", comment: "")
            let message = NSLocalizedString("finishEarlyMessageYoga", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = Colours.colour2
            alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
        
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
            
        // Play
        } else {
            // Cell Detail
            cell.indicatorStack.alpha = 0
            cell.explanationButton.alpha = 0
            // Return to initial image
            let rightSwipe = UISwipeGestureRecognizer()
            rightSwipe.direction = .right
            handleSwipes(extraSwipe: rightSwipe)
            //
            isPaused = false
            finishEarly.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
            finishEarly.tintColor = Colours.colour4
            indicateMovementProgress()
        }
    }
    
    
    //
    // Helpers
    //
    // Time Formatted
    func timeFormattedNicely(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        if minutes < 1 {
            if seconds < 10 {
                return String(format: "%01ds", seconds)
            } else {
                return String(format: "%02ds", seconds)
            }
        } else {
            if minutes < 10 {
                if seconds == 0 {
                    return String(format: "%01dmin", minutes)
                } else if seconds < 10 {
                    return String(format: "%01dmin %01ds", minutes, seconds)
                } else {
                    return String(format: "%01dmin %02ds", minutes, seconds)
                }
            } else {
                if seconds == 0 {
                    return String(format: "%02dmin", minutes)
                } else if seconds < 10 {
                    return String(format: "%02dmin %01ds", minutes, seconds)
                } else {
                    return String(format: "%02dmin %02ds", minutes, seconds)
                }
            }
        }
    }
    // Timer CountDown Title
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    // 0 for low bell, 1 for high bell
    func playBell(bell: Int) {
        if bell == 0 {
            let url = Bundle.main.url(forResource: "Tibetan Singing Bowl (Low)", withExtension: "caf")!
            //
            do {
                soundPlayer = try AVAudioPlayer(contentsOf: url)
                soundPlayer.play()
            } catch {
                // couldn't load file :(
            }
        } else {
            let url = Bundle.main.url(forResource: "Tibetan Singing Bowl (High)", withExtension: "caf")!
            //
            do {
                soundPlayer = try AVAudioPlayer(contentsOf: url)
                soundPlayer.play()
            } catch {
                // couldn't load file :(
            }
        }
    }
    
}

