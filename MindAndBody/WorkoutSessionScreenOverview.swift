//
//  WorkoutSessionScreenOverview.swift
//  MindAndBody
//
//  Created by Luke Smith on 20.04.17.
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
    // Demonstration Image View
    @IBOutlet weak var demonstrationImageView: UIImageView!
    // Title Label
    @IBOutlet weak var movementLabel: UILabel!
    // Sets x Reps label
    @IBOutlet weak var setsRepsLabel: UILabel!
    // Button View
    @IBOutlet weak var buttonView: UIView!
}

// Overview End Cell
class EndTableViewCell: UITableViewCell {
    // Title Label
    @IBOutlet weak var titleLabel: UILabel!
}


//
// Session Screen Overview Class ------------------------------------------------------------------------------------
//
class WorkoutSessionScreenOverview: UITableViewController {
    
    
    //
    // Retreive Arrays ---------------------------------------------------------------------------------------------------
    //
    //
    var sessionType = Int()
    
    //
    var numberOfRounds = Int()
    
    // Title
    var sessionTitle = String()
    
    // Movement Array
    var sessionArray: [String] = []
    
    // Sets Array
    var setsArray: [Int] = []
    
    // Sets Array
    var repsArray: [String] = []
    
    // Demonstration Array
    var demonstrationArray: [UIImage] = []
    
    // Target Area Array
    var targetAreaArray: [UIImage] = []
    
    // Explanation Array
    var explanationArray: [String] = []
    
    
    //
    // Outlets -----------------------------------------------------------------------------------------------------------
    //
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Navigation Title
    let navigationTitle = UILabel()
    
    // Hide Screen
    @IBOutlet weak var hideScreen: UIBarButtonItem!
    
    // Progress Bar
    let progressBar = UIProgressView()
    
    
    //
    // View did load -----------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // self.present(alert, animated: true, completion: (() -> Void)?)
        
        
        // Navigation Title
        navigationTitle.text = NSLocalizedString(sessionTitle, comment: "")
        
        // Navigation Title
        //
        navigationTitle.frame = (navigationController?.navigationItem.accessibilityFrame)!
        navigationTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        navigationTitle.center.x = self.view.center.x
        navigationTitle.textColor = colour1
        navigationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 22)
        navigationTitle.backgroundColor = .clear
        navigationTitle.textAlignment = .center
        navigationTitle.adjustsFontSizeToFitWidth = true
        self.navigationController?.navigationBar.barTintColor = colour2
        //
        self.navigationController?.navigationBar.topItem?.titleView = navigationTitle
        
        // Hide Screen
        hideScreen.tintColor = colour1
        
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
        tableView.reloadData()
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Title for header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    // Will Display Header
    var didSetFrame = false
    //
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = colour1
        
        //
        if section == 0 {
            //
            progressBar.removeFromSuperview()
            
            //
            if didSetFrame == false {
                // Thickness
                progressBar.frame = CGRect(x: 27, y: 0, width: self.view.frame.size.width - 54, height: header.frame.size.height / 2)
                progressBar.center = header.center
                progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3)
                // Rounded Edges
                progressBar.layer.cornerRadius = self.progressBar.frame.size.height / 2
                progressBar.clipsToBounds = true
                // Colour
                progressBar.trackTintColor = colour2
                progressBar.progressTintColor = colour3
                //
                didSetFrame = true
            }
            //
            header.addSubview(progressBar)
            
            // Progress Bar
            // Current Button
            let currentButton = Float(buttonNumber.reduce(0, +))
            // Total Buttons
            let totalButtons = Float(setsArray.reduce(0, +))
            
            //
            if currentButton > 0 {
                // Current Progress
                let currentProgress = currentButton/totalButtons
                progressBar.setProgress(currentProgress
                    , animated: true)
            } else {
                // Initial state
                progressBar.setProgress(0, animated: true)
            }
        }
    }
    
    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        switch section {
        case 0: return sessionArray.count
        case 1: return 1
        default: return 0
        }
    }
    
    // Cell for row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as! OverviewTableViewCell
            
            // Clean Cell
            //
            for v in cell.buttonView.subviews {
                v.removeFromSuperview()
            }
            
            // Cell
            //
            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            cell.tintColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            tableView.separatorInset = UIEdgeInsets(top: 0, left: (10 + cell.demonstrationImageView.frame.size.width), bottom: 0, right: 0)
            
            
            // Movement
            //
            cell.movementLabel.text = NSLocalizedString(sessionArray[indexPath.row], comment: "")
            //
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 21)
            cell.movementLabel?.textAlignment = .left
            cell.movementLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
            
            // Set and Reps
            //
            cell.setsRepsLabel?.text = repsArray[indexPath.row]
            cell.setsRepsLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
            cell.setsRepsLabel?.textAlignment = .right
            cell.setsRepsLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.setsRepsLabel.adjustsFontSizeToFitWidth = true
            
            // Image
            //
            if UserDefaults.standard.string(forKey: "defaultImage") == "demonstration" {
                cell.demonstrationImageView.image = demonstrationArray[indexPath.row]
            } else {
                cell.demonstrationImageView.image = targetAreaArray[indexPath.row]
            }
            

            //
            // Button Stuff
            //
            // Button Tag
            for b in buttonArray[indexPath.row] {
                b.tag = indexPath.row
            }
            
            // Set Button View
            //
            cell.buttonView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            
            // Stack View
            //
            let stackView = UIStackView(arrangedSubviews: buttonArray[indexPath.row])
            
            // Layout
            //
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
            
            // Set Buttons
            //
            // Disable pressed buttons
            let indexOfUnpressedButton = buttonNumber[indexPath.row]
            if indexOfUnpressedButton > 0 {
                for s in 0...indexOfUnpressedButton - 1 {
                    //
                    buttonArray[indexPath.row][s].isEnabled = false
                    buttonArray[indexPath.row][s].backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                }
            }
            
            // Enable next unpressed button
            if indexOfUnpressedButton == setsArray[indexPath.row] {
            } else {
                buttonArray[indexPath.row][indexOfUnpressedButton].isEnabled = true
            }
            
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleImageTap))
            cell.demonstrationImageView.addGestureRecognizer(imageTap)
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch indexPath.section {
        case 0: return 108
        case 1: return 49
        default: return 0
        }
    }
    
    // Did select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch indexPath.section {
        case 0:
            let cell = tableView.cellForRow(at: indexPath)
            //
            performSegue(withIdentifier: "SessionDetailSegue", sender: nil)
            //
            tableView.deselectRow(at: indexPath, animated: true)
        //
        case 1:
            //
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
    // Pocket Mode ------------------------------------------------------------------------------------------------------
    //
    let blurEffectView = UIVisualEffectView()
    let hideLabel = UILabel()
    //
    @IBAction func hideScreen(_ sender: Any) {
        // Blur
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let screenSize = UIScreen.main.bounds
        blurEffectView.effect = blurEffect
        blurEffectView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        
        // Triple Tap
        let tripleTap = UITapGestureRecognizer()
        tripleTap.numberOfTapsRequired = 3
        tripleTap.addTarget(self, action: #selector(handleTap))
        blurEffectView.isUserInteractionEnabled = true
        blurEffectView.addGestureRecognizer(tripleTap)
        
        // Text
        hideLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        hideLabel.center = blurEffectView.center
        hideLabel.textAlignment = .center
        hideLabel.numberOfLines = 0
        hideLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        hideLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        hideLabel.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        hideLabel.alpha = 0
        hideLabel.text = NSLocalizedString("hideScreen", comment: "")
        
        //
        blurEffectView.addSubview(hideLabel)
        UIApplication.shared.keyWindow?.insertSubview(blurEffectView, aboveSubview: view)
        //
        UIView.animate(withDuration: 0.4, animations: {
            self.blurEffectView.alpha = 1
        }, completion: nil)
        //
        let delayInSeconds = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.hideLabel.alpha = 1
        }
    }
    
    // Exit pocket mode
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        //
        self.hideLabel.alpha = 0
        
        //
        UIView.animate(withDuration: 0.4, animations: {
            self.blurEffectView.alpha = 0
        }, completion: nil)
        //
        let delayInSeconds = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            //
            self.blurEffectView.removeFromSuperview()
            self.hideLabel.removeFromSuperview()
        }
    }
    
    
    //
    // Image -------------------------------------------------------------------------------------------------------
    //
    // Expand Image
    let expandedImage = UIImageView()
    let backgroundViewImage = UIButton()
    
    //
    @IBAction func handleImageTap(extraTap:UITapGestureRecognizer) {
        // Get Image
        let sender = extraTap.view as! UIImageView
        let image = sender.image
        // Get Image
        // let index = demonstrationImage.indexWhere
        
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
        // Expanded Image
        //
        expandedImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: height/2)
        expandedImage.center.x = self.view.frame.size.width/2
        expandedImage.center.y = (height/2) * 2.5
        //
        expandedImage.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        expandedImage.contentMode = .scaleAspectFit
        expandedImage.isUserInteractionEnabled = true
        
        expandedImage.image = image
        
        // Background View
        //
        backgroundViewImage.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        backgroundViewImage.backgroundColor = .black
        backgroundViewImage.alpha = 0
        //
        backgroundViewImage.addTarget(self, action: #selector(retractImage(_:)), for: .touchUpInside)
        
        //
        tableView.isScrollEnabled = false
        hideScreen.isEnabled = false
        
        //
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewImage, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(expandedImage, aboveSubview: backgroundViewImage)
        
        //
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandedImage.center.y = (height/2) * 1.5
            self.backgroundViewImage.alpha = 0.5
        }, completion: nil)
    }
    
    // Retract Image
    @IBAction func retractImage(_ sender: Any) {
        //
        let height = self.view.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        //
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandedImage.center.y = (height/2) * 2.5
            self.backgroundViewImage.alpha = 0
        }, completion: { finished in
            //
            self.expandedImage.removeFromSuperview()
            self.backgroundViewImage.removeFromSuperview()
        })
        
        //
        tableView.isScrollEnabled = true
        hideScreen.isEnabled = true
    }
    
    
    //
    // Pass data to next view controller --------------------------------------------------------------------------------
    //
    // Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SessionDetailSegue") {
            //
            let destinationVC = segue.destination as! WorkoutSessionScreenOverviewDetail
            //
            let indexPath = tableView.indexPathForSelectedRow
            let indexPathInt = Int((indexPath?.row)!)
            destinationVC.selectedMovement = indexPathInt
            //
            destinationVC.sessionArray = sessionArray
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            //
            destinationVC.demonstrationArray = demonstrationArray
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            //
            destinationVC.sessionType = sessionType
            
            // Set Button
            destinationVC.buttonNumber = buttonNumber
            
            // Hide Back Button Text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
    //
}
