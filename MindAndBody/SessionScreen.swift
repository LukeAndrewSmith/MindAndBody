//
//  SessionScreenOverview.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 16.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


//
// Custom Overview Tableview Cells ---------------------------------------------------------------------------
//
// Overview TableView Cell
class OverviewTableViewCell: UITableViewCell {
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
    // Button View
    @IBOutlet weak var buttonView: UIView!
    // Explanation
    @IBOutlet weak var explanationButton: UIButton!
}

// Overview End Cell
class EndTableViewCell: UITableViewCell {
    // Title Label
    @IBOutlet weak var titleLabel: UILabel!
}


//
// Session Screen Overview Class ------------------------------------------------------------------------------------
//
class SessionScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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
    var setsArray: [Int] = []
    
    // Sets Array
    var repsArray: [String] = []
    
    // Demonstration Array
    var demonstrationArray: [[String]] = []
    
    // Target Area Array
    var targetAreaArray: [String] = []
    
    // Explanation Array
    var explanationArray: [String] = []
    
    
    //
    // Variables
    var selectedRow = 0
   
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
    var didEnterBackground = false
    
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
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        didEnterBackground = true
    }

    
//
// View did load -----------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        view.backgroundColor = colour2
        
        
        //
        finishEarly.tintColor = colour4
        
        
        // Progress Bar
        // Thickness
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
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
        
        // Buttons
        //
        fillButtonArray()
        //
    }
    

//
// Set Buttons -----------------------------------------------------------------------------------------------
//
    // Button Array
    //
    var buttonArray = [[UIButton]]()
    
    //
    // Set Button Action
    var buttonNumber = [Int]()
    
    //
    // Generate Buttons
    //
    func createButton() -> UIButton {
        //
        let setButton = UIButton()
        let widthHeight = NSLayoutConstraint(item: setButton, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: setButton, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        setButton.addConstraints([widthHeight])
        setButton.frame = CGRect(x: 0, y: 0, width: 42.875, height: 42.875)
        setButton.layer.borderWidth = 3
        setButton.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        setButton.layer.cornerRadius = 21.4375
        setButton.addTarget(self, action: #selector(setButtonAction), for: .touchUpInside)
        setButton.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        setButton.isEnabled = false
        //
        return setButton
    }
    
    // Set Button
    @IBAction func setButtonAction(sender: UIButton) {
        //
        // Rest Timer Notification
        //
        //
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("restOver", comment: "")
        content.body = NSLocalizedString("nextSet", comment: "")
        content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
        content.sound = UNNotificationSound.default()
        //
        let restTimes = UserDefaults.standard.object(forKey: "restTimes") as! [Int]
        //
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(restTimes[sessionType]), repeats: false)
        let request = UNNotificationRequest(identifier: "restTimer", content: content, trigger: trigger)
        //
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

        
        //
        let buttonRow = sender.tag
        //
        buttonArray[buttonRow][buttonNumber[buttonRow]].isEnabled = false
        
        // Increase Button Number
        if self.setsArray[buttonRow] == 0 {
        } else {
            if self.buttonNumber[buttonRow] < self.setsArray[buttonRow] {
                self.buttonNumber[buttonRow] = self.buttonNumber[buttonRow] + 1
            }
        }
        
        // Enable After Delay
        let delayInSeconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            if self.setsArray[buttonRow] == 0 {
            } else {
                if self.buttonNumber[buttonRow] < self.setsArray[buttonRow] {
                    self.buttonArray[buttonRow][self.buttonNumber[buttonRow]].isEnabled = true
                }
            }
        }
        
        //
        sender.isEnabled = false
        sender.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        //
        updateProgress()
    }
    
    // Generate an Array of Arrays of Buttons
    //
    func fillButtonArray() {
        for i in 0...(setsArray.count - 1){
            //
            var buttonArray2 = [UIButton]()
            //
            for _ in 1...setsArray[i]{
                buttonArray2 += [createButton()]
            }
            //
            buttonArray += [buttonArray2]
            buttonNumber.append(0)
        }
        buttonArray[0][0].isEnabled = true
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as! OverviewTableViewCell
            
            //
            cell.buttonView.layoutIfNeeded()
            //
            // Clean Cell
            for v in cell.buttonView.subviews {
                v.removeFromSuperview()
            }
    
            //
            // Cell
            cell.backgroundColor = colour2
            cell.tintColor = colour2
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.selectionStyle = .none
            

            // New image to display
            // Demonstration on left
            if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                cell.imageViewCell.image = getUncachedImage(named: demonstrationArray[indexPath.row][0])
                // Indicator
                if demonstrationArray[indexPath.row].count > 1 {
                    cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                } else {
                    cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                }
                cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
            // Target Area on left
            } else {
                cell.imageViewCell.image = getUncachedImage(named: targetAreaArray[indexPath.row])
                // Indicator
                if demonstrationArray[indexPath.row].count > 1 {
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
            cell.movementLabel.text = NSLocalizedString(sessionArray[indexPath.row], comment: "")
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 23)
            cell.movementLabel?.textAlignment = .center
            cell.movementLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            //
            // Set and Reps
            cell.setsRepsLabel?.text = String(setsArray[indexPath.row]) + " x " + repsArray[indexPath.row]
            cell.setsRepsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.setsRepsLabel?.textAlignment = .right
            cell.setsRepsLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.setsRepsLabel.adjustsFontSizeToFitWidth = true
            
            //
            // Explanation
            cell.explanationButton.tintColor = colour1
            

            //
            // Button Stuff
            //
            // Button Tag
            for b in buttonArray[indexPath.row] {
                b.tag = indexPath.row
            }
            //
            // Set Button View
            cell.buttonView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            //
            // Stack View
            let stackView = UIStackView(arrangedSubviews: buttonArray[indexPath.row])
            //
            // Layout
            let numberOfButtons = CGFloat(setsArray[indexPath.row])
            let xValue = ((cell.buttonView.frame.size.width - (numberOfButtons * 42.875)) / (numberOfButtons + 1))
            let yValue = (cell.buttonView.frame.size.height - 42.875) / 2
            let widthValue1 =
                (numberOfButtons - 1) * (cell.buttonView.frame.size.width - (numberOfButtons * 42.875))
            let widthValue2 = (widthValue1 / (numberOfButtons + 1)) + (numberOfButtons * 42.875)
            // Layout formula
            stackView.frame = CGRect(x: xValue, y: yValue, width: widthValue2, height: 42.875)
            //
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            //
            cell.buttonView.addSubview(stackView)
            //
            // Set Buttons
            // Disable pressed buttons
            let indexOfUnpressedButton = buttonNumber[indexPath.row]
            if indexOfUnpressedButton > 0 {
                for s in 0...indexOfUnpressedButton - 1 {
                    //
                    buttonArray[indexPath.row][s].isEnabled = false
                    buttonArray[indexPath.row][s].backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                }
            }
            //
            // Enable next unpressed button
            if indexOfUnpressedButton == setsArray[indexPath.row] {
            } else {
                buttonArray[indexPath.row][indexOfUnpressedButton].isEnabled = true
            }
            
           
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
                cell.buttonView.alpha = 0
                cell.explanationButton.alpha = 0
            //
            case selectedRow:
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
                //cell.demonstrationImageView.isUserInteractionEnabled = true
            //
            case selectedRow + 1:
                //
                cell.selectionStyle = .none
                //
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 0
                cell.explanationButton.alpha = 0
                //cell.demonstrationImageView.isUserInteractionEnabled = false
            //
            default:
                //
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
            }
            
            //
            return cell
        //
        case 1:
            //
            let cell = tableView.dequeueReusableCell(withIdentifier: "EndTableViewCell", for: indexPath) as! EndTableViewCell
            //
            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            //
            cell.separatorInset =  UIEdgeInsetsMake(0.0, 0.0, 0.0, -cell.bounds.size.width)
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
            switch indexPath.row {
            case selectedRow - 1, selectedRow:
                return (UIScreen.main.bounds.height - 22) * 3/4
            case selectedRow + 1:
                return (UIScreen.main.bounds.height - 22) * 1/4
            default:
                return (UIScreen.main.bounds.height - 22) * 1/4
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
            // Tracking (Do you want to track)
            
           
            self.dismiss(animated: true)

        //
        default: break
        }
    }
    
    
//
// Tap Handlers, buttons and funcs -------------------------------------------------------------------------------------------------------
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
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! OverviewTableViewCell
        //
        // Image Array
        if demonstrationArray[indexPath.row].count > 1 && cell.imageViewCell.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...demonstrationArray[indexPath.row].count - 1 {
                animationArray.append(getUncachedImage(named: demonstrationArray[indexPath.row][i])!)
            }
            //
            cell.imageViewCell.animationImages = animationArray
            cell.imageViewCell.animationDuration = Double(demonstrationArray[indexPath.row].count - 1) * 0.5
            cell.imageViewCell.animationRepeatCount = 1
            //
            if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" && cell.leftImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") || UserDefaults.standard.string(forKey: "targetArea") == "demonstration" && cell.rightImageIndicator.image == #imageLiteral(resourceName: "ImagePlay") {
                if demonstrationArray[tag].count != 1 {
                    sender.startAnimating()
                }
            }
        }
    }
    
    
    // Next Button
    @IBAction func nextButtonAction() {
        //
        if selectedRow < sessionArray.count - 1 {
            //
            selectedRow += 1
            updateProgress()
            //
            //
            let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
            let indexPath2 = NSIndexPath(row: selectedRow - 1, section: 0)
            let indexPath3 = NSIndexPath(row: selectedRow + 1, section: 0)
            //
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! OverviewTableViewCell
            //
            UIView.animate(withDuration: 0.6, animations: {
                //
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                // 1
                cell.indicatorStack.alpha = 1
                cell.setsRepsLabel.alpha = 1
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
                //
                // -1
                cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! OverviewTableViewCell
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 0
                cell.buttonView.alpha = 0
                cell.explanationButton.alpha = 0
                //
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: false)
            })
            // + 1
            if selectedRow < sessionArray.count - 1 {
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
            var cell = tableView.cellForRow(at: indexPath as IndexPath) as! OverviewTableViewCell
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
                cell.buttonView.alpha = 1
                cell.explanationButton.alpha = 1
                // - 1
                if self.selectedRow > 0 {
                    cell = self.tableView.cellForRow(at: indexPath2 as IndexPath) as! OverviewTableViewCell
                    cell.indicatorStack.alpha = 0
                    cell.setsRepsLabel.alpha = 0
                    cell.movementLabel.alpha = 0
                    cell.buttonView.alpha = 0
                    cell.explanationButton.alpha = 0
                }
                // + 1
                cell = self.tableView.cellForRow(at: indexPath3 as IndexPath) as! OverviewTableViewCell
                cell.indicatorStack.alpha = 0
                cell.setsRepsLabel.alpha = 0
                cell.movementLabel.alpha = 1
                cell.buttonView.alpha = 0
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
        explanationLabel.attributedText = formatExplanationText(title: NSLocalizedString(sessionArray[selectedRow], comment: ""), howTo: NSLocalizedString("howToTest", comment: ""), toAvoid: NSLocalizedString("toAvoidTest", comment: ""))
        explanationLabel.frame = CGRect(x: 10, y: 10, width: scrollViewExplanation.frame.size.width - 10, height: 0)
        //
        explanationLabel.sizeToFit()
        
        //
        // Scroll View
        scrollViewExplanation.addSubview(explanationLabel)
        scrollViewExplanation.contentSize = CGSize(width: bounds.width, height: explanationLabel.frame.size.height + 20)
        //
        scrollViewExplanation.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        //
        // Add Views
        UIApplication.shared.keyWindow?.addSubview(backgroundViewExplanation)
        UIApplication.shared.keyWindow?.addSubview(scrollViewExplanation)
        
        //
        // Animate
        UIView.animate(withDuration: animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.scrollViewExplanation.center.y = (((bounds.height - 20)/2) * 1.5) + 20
            self.backgroundViewExplanation.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract Explanation
    @IBAction func retractExplanation(_ sender: Any) {
        let bounds = UIScreen.main.bounds
        //
        UIView.animate(withDuration: animationTime2, animations: {
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
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! OverviewTableViewCell
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
                    if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                        cell.imageViewCell.image = getUncachedImage(named: targetAreaArray[indexPath.row])
                            // Indicator
                            if demonstrationArray[indexPath.row].count > 1 {
                                cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlayDeselected")
                            } else {
                                cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                            }
                            cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                    // Target Area on left
                    } else {
                        cell.imageViewCell.image = getUncachedImage(named: demonstrationArray[indexPath.row][0])
                            // Indicator
                            if demonstrationArray[indexPath.row].count > 1 {
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
                    UIView.animate(withDuration: animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
                    if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                        cell.imageViewCell.image = getUncachedImage(named: demonstrationArray[indexPath.row][0])
                        // Indicator
                        if demonstrationArray[indexPath.row].count > 1 {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImagePlay")
                        } else {
                            cell.leftImageIndicator.image = #imageLiteral(resourceName: "ImageDot")
                        }
                        cell.rightImageIndicator.image = #imageLiteral(resourceName: "ImageDotDeselected")
                        // Target Area on left
                    } else {
                        cell.imageViewCell.image = getUncachedImage(named: targetAreaArray[indexPath.row])
                        // Indicator
                        if demonstrationArray[indexPath.row].count > 1 {
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
                    UIView.animate(withDuration: animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
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
    @IBAction func finishEarlyAction(_ sender: Any) {        
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
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["restTimer"])
            
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
}
