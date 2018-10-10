//
//  StretchingScreen.swift
//  MindAndBody
//
//  Created by Luke Smith on 24.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


//
// Custom StretchingTableViewCell ---------------------------------------------------------------------------
//
// Stretching TableView Cell
class StretchingTableViewCell: UITableViewCell {
    // Image View
    @IBOutlet weak var imageViewCell: UIImageView!
    //
    @IBOutlet weak var indicatorStack: UIStackView!
    @IBOutlet weak var leftImageIndicator: UIImageView!
    @IBOutlet weak var rightImageIndicator: UIImageView!
    // Title Label
    @IBOutlet weak var movementLabel: UILabel!
    // Sets x Reps label
    @IBOutlet weak var setsRepsLabel: UILabel!
    // Explanation
    @IBOutlet weak var explanationButton: UIButton!
    // Timer
    @IBOutlet weak var timerButton: UIButton!
    
    var imageState = 0 // 0 == left image, 1 == right image
}

//
// Stretching Screen Class ------------------------------------------------------------------------------------
//
class StretchingScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //
    // Custom?
    var fromCustom = false
    var fromSchedule = false
    
    //
    // Variables
    var selectedRow = 0
    
    //
    // MARK: Variables from Session Data
    //
    // Key Array
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [1] Keys Array
    var keyArray: [String] = []
    
    // STRETCHING
    // Breat
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] breaths array
    var breathsArray: [Int] = []
    
    // WARMUP
    // Sets
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] sets array
    var setsArray: [Int] = []
    
    // Reps
    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [3] reps array
    var repsArray: [String] = []
    
    
    // To Add (@2x or @3x) for demonstration images
    var toAdd = String()
    
    
    //
    // Outlets -----------------------------------------------------------------------------------------------------------
    //
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Progress Bar
    let progressBar = UIProgressView()
    
    //
    @IBOutlet weak var finishEarly: UIButton!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // MARK: Walkthrough
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["Session2"] == false {
            self.walkthroughSession()
        }
    }
    
    //
    // View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // Set Arrays
        if fromCustom == false {
            // Loop session
            for i in 0..<(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?.count)! {
                //
                keyArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["movement"] as! String)
                // Warmup
                if SelectedSession.shared.selectedSession[0] == "warmup" {
                    setsArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["sets"] as! Int)
                    repsArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["reps"] as! String)
                    // Stretching
                } else {
                    breathsArray.append(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[i]["breaths"] as! Int)
                }
            }
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
        
        // self.present(alert, animated: true, completion: (() -> Void)?)
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "StretchingTableViewCell", for: indexPath) as! StretchingTableViewCell
            
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
            // Movement
            cell.movementLabel.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0] , comment: "")
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 27)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = Colors.light
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            //
            // Sets x Reps
            // String
            var setsRepsString = String()
            // Stretching
            if SelectedSession.shared.selectedSession[0] != "warmup" {
                setsRepsString = String(breathsArray[indexPath.row]) + " " + NSLocalizedString("breathsC", comment: "")
                // Warmup
            } else {
                // If 1 set only put reps
                if setsArray[indexPath.row] == 0 || setsArray[indexPath.row] == 1 {
                    setsRepsString = repsArray[indexPath.row]
                } else {
                    let setsString = String(setsArray[indexPath.row])
                    setsRepsString = setsString + " x " + repsArray[indexPath.row]
                }
            }
            //
            // Indicate asymmetric exercises to the user
            // If asymmetric movement array contains the current movement
            if (sessionData.asymmetricMovements[SelectedSession.shared.selectedSession[0]]?.contains(keyArray[indexPath.row]))! {
                // Append indicator
                let length = setsRepsString.count
                let stringToAdd = NSLocalizedString(") per side", comment: "")
                let length2 = stringToAdd.count
                setsRepsString = "(" + setsRepsString + stringToAdd
                let attributedString = NSMutableAttributedString(string: setsRepsString, attributes: [NSAttributedStringKey.font:UIFont(name: "SFUIDisplay-thin", size: 23.0)!])
                // Change indicator to red
                let range = NSRange(location:0,length:1) // specific location. This means "range" handle 1 character at location 2
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: Colors.red, range: range)
                let range2 = NSRange(location: 1 + length,length: length2)
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: Colors.red, range: range2)
                cell.setsRepsLabel?.textColor = Colors.light
                cell.setsRepsLabel?.attributedText = attributedString
            } else {
                cell.setsRepsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.setsRepsLabel?.textColor = Colors.light
                cell.setsRepsLabel?.text = setsRepsString
            }
            
            cell.setsRepsLabel?.textAlignment = .center
            cell.setsRepsLabel.adjustsFontSizeToFitWidth = true
            //
            
            //
            // Explanation
            cell.explanationButton.tintColor = Colors.light
            // Timer
            cell.timerButton.tintColor = Colors.light
            
            //
            // Gestures
            //
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
            
            // Explanation
            let explanationTap = UITapGestureRecognizer()
            explanationTap.numberOfTapsRequired = 1
            explanationTap.addTarget(self, action: #selector(expandExplanation))
            cell.explanationButton.addGestureRecognizer(explanationTap)
            
            // Timer
            let timerTap = UITapGestureRecognizer()
            timerTap.numberOfTapsRequired = 1
            timerTap.addTarget(self, action: #selector(timerAction))
            cell.timerButton.addGestureRecognizer(timerTap)
            
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
                cell.setsRepsLabel.alpha = 0
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
            //
            case selectedRow:
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                if isTimedMovement() {
                    cell.timerButton.alpha = 1
                } else {
                    cell.timerButton.alpha = 0
                }
            //
            case selectedRow + 1:
                //
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.selectionStyle = .none
                //
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
                
            //
            case selectedRow + 2:
                //
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.selectionStyle = .none
                //
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
            //
            default:
                //
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                if isTimedMovement() {
                    cell.timerButton.alpha = 1
                }
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
            cell.textLabel?.text = NSLocalizedString("end", comment: "")
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)
            cell.textLabel?.textColor = Colors.light
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
            let toMinus: CGFloat = ElementHeights.statusBarHeight + 2 + ElementHeights.bottomSafeAreaInset
            switch indexPath.row {
            case selectedRow - 1, selectedRow:
                return (UIScreen.main.bounds.height - toMinus) * 7/8
            case selectedRow + 1:
                return (UIScreen.main.bounds.height - toMinus) * 1/8
            default:
                return (UIScreen.main.bounds.height - toMinus) * 1/8
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
            // Schedule Tracking
            ScheduleVariables.shared.shouldReloadScheduleTracking()
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
    // Image
    @IBAction func handleImageTap(imageTap:UITapGestureRecognizer) {
        //
        // Get Cell
        let sender = imageTap.view as! UIImageView
        let tag = sender.tag
        let indexPath = NSIndexPath(row: tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! StretchingTableViewCell
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
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! StretchingTableViewCell
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
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! StretchingTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                // 1
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-light", size: 27)
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                if self.isTimedMovement() {
                    cell.timerButton.alpha = 1
                }
                //
                // -1
                cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! StretchingTableViewCell
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 0
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
            }, completion: { finished in
                //                self.playAnimation(row: self.selectedRow)
            })
            // + 1
            if selectedRow < keyArray.count - 1 {
                tableView.reloadRows(at: [indexPath3 as IndexPath], with: UITableViewRowAnimation.none)
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
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! StretchingTableViewCell
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
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                if self.isTimedMovement() {
                    cell.timerButton.alpha = 1
                }
                // - 1
                if self.selectedRow > 0 {
                    cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! StretchingTableViewCell
                    cell.indicatorStack.alpha = 0
                    cell.setsRepsLabel.alpha = 0
                    cell.movementLabel.alpha = 0
                    cell.explanationButton.alpha = 0
                    cell.timerButton.alpha = 0
                }
                // + 1
                cell = self.tableView.cellForRow(at: indexPath3 as IndexPath) as! StretchingTableViewCell
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 0
                cell.timerButton.alpha = 0
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
    
    @IBAction func timerAction(_ sender: Any) {
        //
        if isTimedMovement() {
            // Warmup & Stretching
            let time = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[selectedRow]["time"] as! Int
            StopClock.shared.setupStopClock(time: time)
            StopClock.shared.resetOptionFrames()
            StopClock.shared.animatestopClockUp()
        }
    }
    
    //
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        //
        let indexPath = NSIndexPath(row: selectedRow, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! StretchingTableViewCell
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
    
    // Check whether timed movement
    func isTimedMovement() -> Bool {
        // Warmup
        if SelectedSession.shared.selectedSession[0] == "warmup" {
            let setsRepsString = repsArray[selectedRow]
            if setsRepsString.hasSuffix("s") {
                return true
            } else {
                return false
            }
        // Stretching
        } else {
            return true
        }
    }
    
    //
    @IBAction func finishEarlyAction(_ sender: Any) {
        // Invalidate
        //
        // Alert View
        let title = NSLocalizedString("finishEarly", comment: "")
        let message = NSLocalizedString("finishEarlyMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
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
    var walkthroughTexts = ["session0S", "session2", "session3", "session4", "session5"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    var highlightColor = UIColor()
    
    @objc func backActionWalkthrough() {
        if walkthroughProgress != 0 && walkthroughProgress != 1 {
            walkthroughProgress -= 2
            walkthroughSession()
        }
    }
    
    // Walkthrough
    @objc func walkthroughSession() {
        //
        let toAdd = ElementHeights.statusBarHeight + 2
        let toMinus: CGFloat = ElementHeights.statusBarHeight + 2 + ElementHeights.bottomSafeAreaInset
        let cellHeight = (UIScreen.main.bounds.height - toMinus) * 3/4
        
        let delayShort = 0.6
        
        //
        if didSetWalkthrough == false {
            if setsArray.count != 0 {
                walkthroughTexts = ["session0", "session2", "session3", "session4", "session5"]
            }
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
            
            walkthroughLabel.frame = CGRect(
                x: WalkthroughVariables.padding,
                y: WalkthroughVariables.topHeight + WalkthroughVariables.padding,
                width: walkthroughLabelView.bounds.width - WalkthroughVariables.twicePadding,
                height: walkthroughLabel.frame.size.height)
            walkthroughLabelView.frame = CGRect(
                x: 13,
                y: 13 + ElementHeights.combinedHeight,
                width: view.frame.size.width - WalkthroughVariables.twiceViewPadding,
                height: WalkthroughVariables.topHeight + walkthroughLabel.frame.size.height + WalkthroughVariables.twicePadding)
            
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
                let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! StretchingTableViewCell
                self.walkthroughHighlight.frame.size = CGSize(width: cell.setsRepsLabel.frame.width + 16, height: cell.setsRepsLabel.frame.height + 4)
                self.walkthroughHighlight.center = cell.setsRepsLabel.center
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
            
        // Demonstration (+ target area)
        case 1:
            //
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! StretchingTableViewCell
            highlightSize = cell.indicatorStack.frame.size
            highlightCenter = cell.indicatorStack.center
            highlightCenter?.y += toAdd
            //
            highlightCornerRadius = 0
            // Top of view
            labelFrame = 1
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Explanation
        case 2:
            //
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! StretchingTableViewCell
            highlightSize = cell.explanationButton.frame.size
            highlightCenter = cell.explanationButton.center
            highlightCenter?.y += toAdd
            //
            highlightCornerRadius = 0
            // Top
            labelFrame = 1
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            walkthroughHighlight.alpha = 1
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        // Next Movement
        case 3:
            //
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! StretchingTableViewCell
            highlightSize = cell.explanationButton.frame.size
            highlightCenter = cell.explanationButton.center
            highlightCenter?.y += toAdd
            //
            highlightCornerRadius = 0
            // Top
            labelFrame = 1
            //
            walkthroughBackgroundColor = Colors.light
            walkthroughTextColor = Colors.dark
            highlightColor = Colors.light
            walkthroughHighlight.alpha = 0
            //
            nextWalkthroughViewTest(walkthroughView: walkthroughView, labelView: walkthroughLabelView, label: walkthroughLabel, title: walkthroughLabelTitle, highlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        // Next movement demonstration and then go to finish early
        case 4:
            //
            walkthroughLabelView.alpha = 0
            //
            // Swipe demonstration
            walkthroughNextButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayShort, execute: {
                //
                let upSwipe = UIView()
                upSwipe.frame.size = CGSize(width: 50, height: 50)
                upSwipe.backgroundColor = Colors.light
                upSwipe.layer.cornerRadius = 25
                upSwipe.clipsToBounds = true
                upSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (7/8)) + 2
                upSwipe.center.x = self.view.bounds.width / 2
                UIApplication.shared.keyWindow?.insertSubview(upSwipe, aboveSubview: self.walkthroughView)
                // Perform swipe action
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                    self.nextButtonAction()
                })
                // Animate swipe demonstration
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    //
                    upSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (1/8)) + 2
                    //
                }, completion: { finished in
                    upSwipe.removeFromSuperview()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayShort, execute: {
                        //
                        let downSwipe = UIView()
                        downSwipe.frame.size = CGSize(width: 50, height: 50)
                        downSwipe.backgroundColor = Colors.light
                        downSwipe.layer.cornerRadius = 25
                        downSwipe.clipsToBounds = true
                        downSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (1/8)) + 2
                        downSwipe.center.x = self.view.bounds.width / 2
                        UIApplication.shared.keyWindow?.insertSubview(downSwipe, aboveSubview: self.walkthroughView)
                        // Perform swipe action
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                            self.backButtonAction()
                        })
                        // Animate swipe demonstration
                        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            //
                            downSwipe.center.y = ElementHeights.statusBarHeight + (cellHeight * (7/8)) + 2
                            //
                        }, completion: { finished in
                            self.walkthroughNextButton.isEnabled = true
                            //
                            downSwipe.removeFromSuperview()
                            //
                            self.walkthroughLabelView.alpha = 1
                            //
                            self.highlightSize = CGSize(width: 36, height: 36)
                            self.highlightCenter = CGPoint(x: 27, y: ElementHeights.statusBarHeight + 2 + 5 + 22)
                            self.highlightCornerRadius = 0
                            self.walkthroughHighlight.alpha = 1
                            //
                            self.labelFrame = 0
                            //
                            self.walkthroughBackgroundColor = Colors.light
                            self.walkthroughTextColor = Colors.dark
                            self.highlightColor = Colors.light
                            //
                            self.nextWalkthroughViewTest(walkthroughView: self.walkthroughView, labelView: self.walkthroughLabelView, label: self.walkthroughLabel, title: self.walkthroughLabelTitle, highlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                            //
                            self.walkthroughProgress = self.walkthroughProgress + 1
                            
                        })
                    })
                })
            })
            
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.didSetWalkthrough = false
                self.walkthroughView.removeFromSuperview()
                var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                walkthroughs["Session2"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            })
        }
    }
    
}

