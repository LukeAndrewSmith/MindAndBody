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
// Time Based TableView Cell
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
    
    var imageState = 0 // 0 == left image, 1 == right image
}

//
// Stretching Screen Class ------------------------------------------------------------------------------------
//
class TimeBasedScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //
    // Variables
    var selectedRow = 0
    
    // Variable indicating if movement can swipe:
        // During movement flow, the user is told to 'Prepare'/'Begin' etc.. these instructions are displayed for 1.5s, and afterwards startTimer() etc. are called, the wait is made with a dispatchQueue.main.async and a swipe during this pause confuses
        // Same issue found in endRound/endSession so used there as well
    // BETTER FIX:
        // Use dispatchWorkItems' for the delay so it can be cancelled if swipe/end round button activated
    var canSwipeMovement = true
    
    // Circuit Elements
    var sessionScreenRoundIndex = 0
    let restTitle = NSLocalizedString("rest", comment: "")
    var restTime = Int()
    var restMessage = String()
    var restAlert = UIAlertController()
    // Timer
    // Variables
    var didSetEndTime = false
    var startTime = Double()
    var endTime = Double()
    
    //
    var fromSchedule = false
    
    //
    // Is paused
    var isPaused = false
    
    var isCircuit = false
    
    //
    // MARK: Variables from Session Data
    //
    // Key Array
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [1] Keys Array
    var keyArray: [String] = []
    
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
    // nRounds
    var nRounds = 0
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
        
        self.indicateMovementProgress()
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
        case "warmup", "workout":
            // Loop session
            for i in 0..<(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?.count)! {
                keyArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["movement"] as! String)
                lengthArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["time"] as! Int)
            }
        // Stretching
        case "stretching":
            // Loop session
            for i in 0..<(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?.count)! {
                keyArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["movement"] as! String)
                lengthArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["time"] as! Int)
            }
        default:
            break
        }
        
        
        
        //
        // Special case for circuit workout
            // Add the movements to the key array x(number of rounds) more times
        switch SelectedSession.shared.selectedSession[1] {
        case "circuitBodyweightFull", "circuitBodyweightUpper", "circuitBodyweightLower":
            // Number of rounds kept in first movement dict
            nRounds = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[0]["rounds"] as! Int
            //
            nMovementsInRound = keyArray.count / nRounds
            
            //
            isCircuit = true
            
        default:
            break
        }
        
        // Device Scale for @2x and @3x of Target Area Images
        switch UIScreen.main.scale {
        case 1,2:
            toAdd = "@2x"
        case 3:
            toAdd = "@3x"
        default:
            toAdd = "@3x"
        }
        
        //
        view.backgroundColor = Colors.dark
        
        //
        finishEarly.tintColor = Colors.red
                
        // Progress Bar
        // Thickness
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
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
        case 0:
            if isCircuit {
                return nMovementsInRound
            } else {
                return keyArray.count
            }
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
            cell.backgroundColor = Colors.dark
            cell.tintColor = Colors.dark
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.selectionStyle = .none
            
            // New image to display
            // Demonstration on left
            // [key] = key, [0] = first image
            cell.imageViewCell.image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
            // Indicator
            if ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"])?.count)! > 1 {
                cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
            } else {
                cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
            }
            cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
            
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
            // Next Swipe
            let nextSwipe = UISwipeGestureRecognizer()
            nextSwipe.direction = .up
            nextSwipe.addTarget(self, action: #selector(nextMovement))
            cell.addGestureRecognizer(nextSwipe)
            
            // Back Swipe
            let backSwipe = UISwipeGestureRecognizer()
            backSwipe.direction = .down
            backSwipe.addTarget(self, action: #selector(previousMovement))
            cell.addGestureRecognizer(backSwipe)
            
            //
            // Movement
            cell.movementLabel.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0] , comment: "")
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 33)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = Colors.light
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.timeLabel.alpha = 1
            cell.timeLabel?.adjustsFontSizeToFitWidth = true
            
            //
            cell.indicatorLabel.alpha = 1
            cell.indicatorLabel.text = " "
            
            //
            // Explanation
            cell.explanationButton.tintColor = Colors.light
            
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
            
            // Reset image state
            cell.imageState = 0
            
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
            cell.layer.borderColor = Colors.light.cgColor
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 33)
            cell.textLabel?.textColor = Colors.light
            cell.textLabel?.textAlignment = .center
            // Text
            if isCircuit {
                // If last round, end
                if sessionScreenRoundIndex == nRounds - 1 {
                    cell.textLabel?.text = NSLocalizedString("end", comment: "")
                } else {
                    cell.textLabel?.text = NSLocalizedString("endRound", comment: "") + " " + String(sessionScreenRoundIndex + 1)                }
            } else {
                cell.textLabel?.text = NSLocalizedString("end", comment: "")
            }

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
            let toMinus: CGFloat = ElementHeights.statusBarHeight + 2 + ElementHeights.bottomSafeAreaInset
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
            
            if isCircuit {
                //
                if sessionScreenRoundIndex < nRounds - 1 {
                    if canSwipeMovement {
                        removeCircle()
                        lengthTimer.invalidate()
                        selectedRow = 0
                        endRound()
                    }

                } else {
                    if canSwipeMovement {
                        // Schedule Tracking
                        ScheduleVariables.shared.shouldReloadScheduleTracking()
                        dismissView()
                    }
                }
            } else {
                if canSwipeMovement {
                    // Schedule Tracking
                    ScheduleVariables.shared.shouldReloadScheduleTracking()
                    dismissView()
                }
            }
            tableView.deselectRow(at: indexPath, animated: true)
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
        let imageCount = ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"])?.count)!
        //
        // Image Array
        if imageCount > 1 && cell.imageViewCell.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![i])!)
            }
            //
            cell.imageViewCell.animationImages = animationArray
            cell.imageViewCell.animationDuration = Double(imageCount - 1) * 0.5
            cell.imageViewCell.animationRepeatCount = 1
            //
            sender.startAnimating()
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
        let imageCount = ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"])?.count)!
        //
        // Image Array
        if imageCount > 1 && cell.imageViewCell.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![i])!)
            }
            //
            cell.imageViewCell.animationImages = animationArray
            cell.imageViewCell.animationDuration = Double(imageCount - 1) * 0.5
            cell.imageViewCell.animationRepeatCount = 1
            //
            cell.imageViewCell.startAnimating()
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
        let image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
        // If asymmetric array contains image, flip imageview
        if (sessionData.asymmetricMovements[SelectedSession.shared.selectedSession[0]]?.contains(key))! {
            let flippedImage = UIImage(cgImage: (image?.cgImage!)!, scale: (image?.scale)!, orientation: .upMirrored)
            cell.imageViewCell.image =  flippedImage
        }
        //
        let imageCount = ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"])?.count)!
        //
        // Image Array
        if imageCount > 1 && cell.imageViewCell.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![i])!)
            }
            //
            cell.imageViewCell.animationImages = animationArray
            cell.imageViewCell.animationDuration = Double(imageCount - 1) * 0.5
            cell.imageViewCell.animationRepeatCount = 1
            //
            cell.imageViewCell.startAnimating()
        }
    }
    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        if !isCircuit && selectedRow < keyArray.count - 1 || isCircuit && selectedRow < nMovementsInRound - 1 {
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
            if !isCircuit && selectedRow < keyArray.count - 1 || isCircuit && selectedRow < nMovementsInRound - 1 {
                tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableViewRowAnimation.none)
            }
            
            // Next Round
            if selectedRow == nMovementsInRound - 1 {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                //
                UIView.animate(withDuration: 0.6, animations: {
                    let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
                    self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
                })
            }
            //
            indicateMovementProgress()
        }
    }
    
    // MARK: Next/Previous movement skip
    @IBAction func nextMovement() {
        if canSwipeMovement {
            lengthTimer.invalidate()
            removeCircle()
            timerValue = 0
            movementProgress = 3
            indicateMovementProgress()
        }
    }
    @IBAction func previousMovement() {
        if selectedRow != 0 && canSwipeMovement {
            lengthTimer.invalidate()
            removeCircle()
            timerValue = 0
            movementProgress = 1
            //
            selectedRow = selectedRow - 1
            updateProgress()
            //
            let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
            let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
            let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)
            //
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! TimeBasedTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                // As progress bar is contained in the table view header, scrolling back to row 0 jumps the progress bar off the screen
                // Silly fix below seems to work
                if self.selectedRow == 0 {
                    self.tableView.beginUpdates()
                    self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
                    self.tableView.endUpdates()
                } else {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                    self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
                }
                
                // 1
                cell.indicatorStack.alpha = 1
                cell.movementLabel.alpha = 1
                cell.timeLabel.alpha = 1
                cell.indicatorLabel.alpha = 1
                // - 1
                if self.selectedRow > 0 {
                    cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! TimeBasedTableViewCell
                    cell.indicatorStack.alpha = 0
                    cell.movementLabel.alpha = 0
                    cell.explanationButton.alpha = 0
                }
                // + 1
                cell = self.tableView.cellForRow(at: indexPath3 as IndexPath) as! TimeBasedTableViewCell
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.indicatorStack.alpha = 0
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 0
                cell.timeLabel.alpha = 0
                cell.indicatorLabel.alpha = 0
                //
            })
            
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
        let imageCount = ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"])?.count)!
        //
        if cell.imageViewCell.isAnimating == false {
            //
            switch extraSwipe.direction {
            //
            case UISwipeGestureRecognizerDirection.left:
                //
                // Check left image is displayed
                if cell.imageState == 0 {
                    cell.imageState = 1
                    // Screenshot of current image
                    let snapshot1 = cell.imageViewCell.snapshotView(afterScreenUpdates: false)
                    snapshot1?.bounds = cell.imageViewCell.bounds
                    snapshot1?.center.x = cell.center.x
                    snapshot1?.center.y = cell.imageViewCell.center.y
                    cell.addSubview(snapshot1!)
                    
                    // New image to display
                    // Demonstration on left
                    cell.imageViewCell.image = getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["targetArea"]![0] + toAdd)
                    // Indicator
                    if imageCount > 1 {
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlayDeselected")
                    } else {
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                    }
                    cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                    
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
                if cell.imageState == 1 {
                    cell.imageState = 0
                    //
                    let snapshot1 = cell.imageViewCell.snapshotView(afterScreenUpdates: false)
                    snapshot1?.bounds = cell.imageViewCell.bounds
                    snapshot1?.center.x = cell.center.x
                    snapshot1?.center.y = cell.imageViewCell.center.y
                    cell.addSubview(snapshot1!)
                    
                    // New image to display
                    // Demonstration on left
                    cell.imageViewCell.image = getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![0])
                    // Indicator
                    if imageCount > 1 {
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                    } else {
                        cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                    }
                    cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                    
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
        // Circuit
        if isCircuit {
            // Current Pose
            // ((sessionScreenRoundIndex * 3) + sessionScreenRoundIndex) accounts for the current round
            let currentPose = Float((sessionScreenRoundIndex * 3) + sessionScreenRoundIndex + selectedRow)
            // Total Number Poses
            let totalPoses = Float(keyArray.count - 1)
            
            //
            let currentProgress = currentPose / totalPoses
            progressBar.setProgress(currentProgress, animated: true)
            
        // Normal
        } else {
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
            finishEarly.tintColor = Colors.green
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
            
            // Alert View
            let title = NSLocalizedString("pauseYoga", comment: "")
            let message = NSLocalizedString("pauseMessageSession", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = Colors.dark
            alert.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            //
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            alert.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 18)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]), forKey: "attributedMessage")
            // Actions
            // Dismiss
            let finishEarlyAction = UIAlertAction(title: NSLocalizedString("finishEarly", comment: ""), style: .default) { _ in
                self.dismissView()
            }
            // Dismiss alert
            let pauseAction = UIAlertAction(title: NSLocalizedString("pause", comment: ""), style: .default) { _ in }
            // Continue
            let continuePracticeAction = UIAlertAction(title: NSLocalizedString("continueSession", comment: ""), style: .default) { _ in
                // Cell Detail
                cell.indicatorStack.alpha = 0
                cell.explanationButton.alpha = 0
                self.continueSession()
                
            }
            
            // Add actions
            alert.addAction(finishEarlyAction)
            alert.addAction(pauseAction)
            alert.addAction(continuePracticeAction)
            //
            self.present(alert, animated: true, completion: nil)
            
        // Play
        } else {
            // Cell Detail
            cell.indicatorStack.alpha = 0
            cell.explanationButton.alpha = 0
            continueSession()
        }
    }
    
    //
    func continueSession() {
        // Return to initial image
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.direction = .right
        handleSwipes(extraSwipe: rightSwipe)
        //
        isPaused = false
        finishEarly.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
        finishEarly.tintColor = Colors.red
        indicateMovementProgress()
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
            let url = Bundle.main.url(forResource: "tibetanBowlL", withExtension: "caf")!
            //
            do {
                soundPlayer = try AVAudioPlayer(contentsOf: url)
                soundPlayer.play()
            } catch {
                // couldn't load file :(
            }
        } else {
            let url = Bundle.main.url(forResource: "tibetanBowlH", withExtension: "caf")!
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

