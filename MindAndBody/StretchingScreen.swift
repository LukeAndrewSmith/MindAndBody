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
    var keyArray: [Int] = []
    
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
                //
                // MARK: Walkthrough
                let walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
                if walkthroughs[4] == false {
                    self.walkthroughSession()
                }
            }
        })
    }
    
    //
    // View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // Set Arrays
        if fromCustom == false {
            keyArray = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1] as! [Int]
            // Warmup
            if SelectedSession.shared.selectedSession[0] == 0 {
                setsArray = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[2] as! [Int]
                repsArray = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[3] as! [String]
                // Stretching
            } else {
                breathsArray = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[2] as! [Int]
            }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "StretchingTableViewCell", for: indexPath) as! StretchingTableViewCell
            
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
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let defaultImage = settings[5][0]
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
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 27)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            //
            // Sets x Reps
            // String
            var setsRepsString = String()
            // Stretching
            if SelectedSession.shared.selectedSession[0] != 0 {
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
            if sessionData.asymmetricMovements[SelectedSession.shared.selectedSession[0]].contains(keyArray[indexPath.row]) {
                // Append indicator
                let length = setsRepsString.count
                let stringToAdd = NSLocalizedString(") per side", comment: "")
                let length2 = stringToAdd.count
                setsRepsString = "(" + setsRepsString + stringToAdd
                let attributedString = NSMutableAttributedString(string: setsRepsString, attributes: [NSAttributedStringKey.font:UIFont(name: "SFUIDisplay-thin", size: 23.0)!])
                // Change indicator to red
                let range = NSRange(location:0,length:1) // specific location. This means "range" handle 1 character at location 2
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: Colours.colour4, range: range)
                let range2 = NSRange(location: 1 + length,length: length2)
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: Colours.colour4, range: range2)
                cell.setsRepsLabel?.textColor = Colours.colour1
                cell.setsRepsLabel?.attributedText = attributedString
            } else {
                cell.setsRepsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.setsRepsLabel?.textColor = Colours.colour1
                cell.setsRepsLabel?.text = setsRepsString
            }
            
            cell.setsRepsLabel?.textAlignment = .center
            cell.setsRepsLabel.adjustsFontSizeToFitWidth = true
            //
            
            
            //
            // Explanation
            cell.explanationButton.tintColor = Colours.colour1
            
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
            //
            case selectedRow:
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                //cell.demonstrationImageView.isUserInteractionEnabled = true
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
                //cell.demonstrationImageView.isUserInteractionEnabled = false
            //
            default:
                //
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
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
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)
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
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let defaultImage = settings[5][0]
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
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! StretchingTableViewCell
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
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let defaultImage = settings[5][0]
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
                //
                // -1
                cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! StretchingTableViewCell
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 0
                cell.explanationButton.alpha = 0
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
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
                
                // 1
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 1
                // - 1
                if self.selectedRow > 0 {
                    cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! StretchingTableViewCell
                    cell.indicatorStack.alpha = 0
                    cell.setsRepsLabel.alpha = 0
                    cell.movementLabel.alpha = 0
                    cell.explanationButton.alpha = 0
                }
                // + 1
                cell = self.tableView.cellForRow(at: indexPath3 as IndexPath) as! StretchingTableViewCell
                cell.movementLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.explanationButton.alpha = 0
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
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! StretchingTableViewCell
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
                    cell.addSubview(snapshot1!)
                    
                    // New image to display
                    // Demonstration on left
                    var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                    let defaultImage = settings[5][0]
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
                    cell.addSubview(snapshot1!)
                    
                    // New image to display
                    // Demonstration on left
                    var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                    let defaultImage = settings[5][0]
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
        // Invalidate
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
    var walkthroughTexts = ["session02", "session1", "session3", "session4", "session5", "session6", "session7", "session8", "session9", "session10", "session11"]
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
    @objc func walkthroughSession() {
        //
        var toMinus = CGFloat()
        if IPhoneType.shared.iPhoneType() == 2 {
            toMinus = TopBarHeights.statusBarHeight + 2 + 34
        } else {
            toMinus = TopBarHeights.statusBarHeight + 2
        }
        let cellHeight = (UIScreen.main.bounds.height - toMinus) * 7/8
        
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
            walkthroughLabel.textColor = Colours.colour2
            walkthroughLabel.backgroundColor = Colours.colour1
            walkthroughHighlight.backgroundColor = Colours.colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colours.colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width / 2, height: 36)
            walkthroughHighlight.center = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight / 2) * (13/8)) + 2)
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = Colours.colour1.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colours.colour1.withAlphaComponent(0.5)
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
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
            highlightColor = Colours.colour1
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Demonstration
        case 2:
            //
            highlightSize = CGSize(width: view.bounds.width * (7/8), height: (cellHeight * (7/8)))
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight * (7/8)) / 2) + 2)
            highlightCornerRadius = 3
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
            highlightColor = Colours.colour1
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Indicator
        case 3:
            //
            highlightSize = CGSize(width: 30, height: 15)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + 2 + ((cellHeight * (7/8))) - (15 / 2))
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
            highlightColor = Colours.colour1
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
            
        // Target Area
        case 4:
            // Swipe demonstration
            let leftSwipe = UIView()
            leftSwipe.frame.size = CGSize(width: 50, height: 50)
            leftSwipe.backgroundColor = Colours.colour1
            leftSwipe.layer.cornerRadius = 25
            leftSwipe.clipsToBounds = true
            leftSwipe.center.y = TopBarHeights.statusBarHeight + ((cellHeight * (7/8)) / 2) + 2
            leftSwipe.center.x = view.bounds.width * (7/8)
            UIApplication.shared.keyWindow?.insertSubview(leftSwipe, aboveSubview: walkthroughView)
            // Perform swipe action
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                let leftSwipeSimulate = UISwipeGestureRecognizer()
                leftSwipeSimulate.direction = .left
                self.handleSwipes(extraSwipe: leftSwipeSimulate)
            })
            // Animate swipe demonstration
            nextButton.isEnabled = false
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                leftSwipe.center.x = self.view.bounds.width * (1/8)
                //
            }, completion: { finished in
                self.nextButton.isEnabled = true
                //
                leftSwipe.removeFromSuperview()
                
                //
                self.highlightSize = CGSize(width: self.view.bounds.width * (7/8), height: (cellHeight * (7/8)))
                self.highlightCenter = CGPoint(x: self.view.bounds.width / 2, y: TopBarHeights.statusBarHeight + ((cellHeight * (7/8)) / 2) + 2)
                self.highlightCornerRadius = 3
                //
                self.labelFrame = 0
                //
                self.walkthroughBackgroundColor = Colours.colour1
                self.walkthroughTextColor = Colours.colour2
                self.highlightColor = Colours.colour1
                //
                self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.highlightColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                
                //
                self.walkthroughProgress = self.walkthroughProgress + 1
            })
            
            
        // Return to demonstration and Explanation
        case 5:
            //
            highlightSize = CGSize(width: 30, height: 15)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + 2 + ((cellHeight * (7/8))) - (15 / 2))
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
            highlightColor = Colours.colour1
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            //
            self.walkthroughProgress = self.walkthroughProgress + 1
            
            //
            // Swipe demonstration
            nextButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                //
                let rightSwipe = UIView()
                rightSwipe.frame.size = CGSize(width: 50, height: 50)
                rightSwipe.backgroundColor = Colours.colour1
                rightSwipe.layer.cornerRadius = 25
                rightSwipe.clipsToBounds = true
                rightSwipe.center.y = TopBarHeights.statusBarHeight + ((cellHeight * (7/8)) / 2) + 2
                rightSwipe.center.x = self.view.bounds.width * (1/8)
                UIApplication.shared.keyWindow?.insertSubview(rightSwipe, aboveSubview: self.walkthroughView)
                // Perform swipe action
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                    let rightSwipeSimulate = UISwipeGestureRecognizer()
                    rightSwipeSimulate.direction = .right
                    self.handleSwipes(extraSwipe: rightSwipeSimulate)
                })
                // Animate swipe demonstration
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    //
                    rightSwipe.center.x = self.view.bounds.width * (7/8)
                    //
                }, completion: { finished in
                    self.nextButton.isEnabled = true
                    //
                    rightSwipe.removeFromSuperview()
                    
                    //
                    self.highlightSize = CGSize(width: 45, height: 45)
                    self.highlightCenter = CGPoint(x: self.view.bounds.width - 25 - 2.5, y: TopBarHeights.statusBarHeight + cellHeight - 25 - 2.5)
                    self.highlightCornerRadius = 0
                    //
                    self.labelFrame = 0
                    //
                    self.walkthroughBackgroundColor = Colours.colour1
                    self.walkthroughTextColor = Colours.colour2
                    self.highlightColor = Colours.colour1
                    //
                    self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.highlightColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                    
                    //
                    self.walkthroughProgress = self.walkthroughProgress + 1
                })
            })
            
            
            // Explanation open and Next Movement
        // Case 7 not 6 as + 1 to walkthroughprogress twice in case 5 for label reasons (need an empty label)
        case 7:
            backgroundViewExplanation.isEnabled = false
            expandExplanation()
            //
            highlightSize = CGSize(width: 45, height: 45)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.statusBarHeight + (view.bounds.height / 2))
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
            highlightColor = .clear
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            //
            self.walkthroughProgress = self.walkthroughProgress + 1
            //
            // Next Movement
            nextButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2, execute: {
                //
                self.nextButton.isEnabled = true
                self.backgroundViewExplanation.isEnabled = true
                //
                self.retractExplanation(self)
                
                //
                self.highlightSize = CGSize(width: self.view.bounds.width, height: 4)
                self.highlightCenter = CGPoint(x: self.view.bounds.width / 2, y: TopBarHeights.statusBarHeight + 1)
                self.highlightCornerRadius = 0
                //
                self.labelFrame = 0
                //
                self.walkthroughBackgroundColor = Colours.colour1
                self.walkthroughTextColor = Colours.colour2
                self.highlightColor = .clear
                //
                self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.highlightColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                //
                self.walkthroughProgress = self.walkthroughProgress + 1
            })
            
            
            // Progress
        // Case 9 not 8 as + 1 to walkthroughprogress twice in case 7 for label reasons (need an empty label)
        case 9:
            //
            walkthroughLabel.alpha = 0
            //
            // Swipe demonstration
            nextButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                //
                let upSwipe = UIView()
                upSwipe.frame.size = CGSize(width: 50, height: 50)
                upSwipe.backgroundColor = Colours.colour1
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
                    self.nextButton.isEnabled = true
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
                    self.walkthroughBackgroundColor = Colours.colour1
                    self.walkthroughTextColor = Colours.colour2
                    self.highlightColor = Colours.colour1
                    //
                    self.nextWalkthroughView(walkthroughView: self.walkthroughView, walkthroughLabel: self.walkthroughLabel, walkthroughHighlight: self.walkthroughHighlight, walkthroughTexts: self.walkthroughTexts, walkthroughLabelFrame: self.labelFrame, highlightSize: self.highlightSize!, highlightCenter: self.highlightCenter!, highlightCornerRadius: self.highlightCornerRadius, backgroundColor: self.walkthroughBackgroundColor, textColor: self.walkthroughTextColor, highlightColor: self.highlightColor, animationTime: 0.4, walkthroughProgress: self.walkthroughProgress)
                    //
                    self.walkthroughProgress = self.walkthroughProgress + 1
                    
                })
            })
            
            
        // Finish Early
        case 10:
            //
            highlightSize = CGSize(width: 36, height: 36)
            highlightCenter = CGPoint(x: 27, y: TopBarHeights.statusBarHeight + 2 + 5 + 22)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
            highlightColor = Colours.colour1
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
                var walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
                walkthroughs[4] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["walkthroughs"])
            })
        }
    }
    
}

