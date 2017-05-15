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
    // Next Button
    @IBOutlet weak var nextButton: UIButton!
    // Back Button
    @IBOutlet weak var backButton: UIButton!
}


//
// Session Screen Overview Class ------------------------------------------------------------------------------------
//
class YogaScreenOverview: UITableViewController {
    
    
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
    var breathsArray: [String] = []
    
    // Demonstration Array
    var demonstrationArray: [[UIImage]] = []
    var animationDurationArray: [Double] = []
    
    // Explanation Array
    var explanationArray: [String] = []
    
    
    //
    // Variables
    var selectedRow = 0
    
    
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
        navigationTitle.textColor = colour1
        navigationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 22)
        navigationTitle.backgroundColor = .clear
        navigationTitle.textAlignment = .center
        navigationTitle.adjustsFontSizeToFitWidth = true
        navigationTitle.center.x = self.view.center.x
        self.navigationController?.navigationBar.barTintColor = colour2
        //
        self.navigationController?.navigationBar.topItem?.titleView = navigationTitle
        
        // Hide Screen
        hideScreen.tintColor = colour1
        
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

    }
    
    
    //
    // Complete Button -----------------------------------------------------------------------------------------------
    //
    var buttonArray = [[UIButton]]()
    
    //
    // Set Button Action
    var buttonNumber = [Int]()
    
    //
    // Generate Buttons
    //
    
    
    
    // Update Progress
    func updateProgress() {
        // Progress Bar
        // Current Button
        let currentButton = Float(buttonNumber.reduce(0, +))
        // Total Buttons
        //let totalButtons = Float(setsArray.reduce(0, +))
        
        //
        if currentButton > 0 {
            // Current Progress
            let currentProgress = currentButton
            //totalButtons
            progressBar.setProgress(currentProgress
                , animated: true)
        } else {
            // Initial state
            progressBar.setProgress(0, animated: true)
        }
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
            if header.subviews.contains(progressBar) {
            } else {
                header.addSubview(progressBar)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 2
        case 1: return 0
        default: break
        }
        return 0
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "YogaOverviewTableViewCell", for: indexPath) as! YogaOverviewTableViewCell
            
            // Cell
            //
            cell.backgroundColor = colour2
            cell.tintColor = colour2
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
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
            cell.breathsLabel?.text = breathsArray[indexPath.row] + " " + NSLocalizedString("breathsC", comment: "")
            cell.breathsLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.breathsLabel?.textAlignment = .right
            cell.breathsLabel?.textColor = colour1
            cell.breathsLabel.adjustsFontSizeToFitWidth = true
            
            //
            if indexPath.row == selectedRow {
                // Next button
                cell.nextButton.tintColor = colour3
                cell.nextButton.isEnabled = true
                // Back Button
                cell.backButton.tintColor = colour4
                cell.backButton.isEnabled = true
                //
                cell.demonstrationImageView.isUserInteractionEnabled = true
            } else {
                cell.nextButton.tintColor = .clear
                cell.nextButton.isEnabled = false
                //
                cell.backButton.tintColor = .clear
                cell.backButton.isEnabled = false
                
            }
            
            //
            if indexPath.row == selectedRow + 1 {
                cell.selectionStyle = .none
                cell.demonstrationImageView.isUserInteractionEnabled = false
            }

            
            // Image
            //
            cell.demonstrationImageView.image = demonstrationArray[indexPath.row][0]
            // Animation
            cell.demonstrationImageView.animationImages = demonstrationArray[indexPath.row]
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
            
            // Button Tap
            let buttonTap = UITapGestureRecognizer()
            buttonTap.numberOfTapsRequired = 1
            buttonTap.addTarget(self, action: #selector(completedButtonAction))
            cell.nextButton.addGestureRecognizer(buttonTap)
            //
            
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch indexPath.section {
        case 0:
            if indexPath.row == selectedRow {
                return (UIScreen.main.bounds.height - 2) * 2/3
            } else {
                return (UIScreen.main.bounds.height - 2) * 1/3
            }
        case 1: return 49
        default: return 0
        }
    }
    
    // Did select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch indexPath.section {
        case 0:
            
            if indexPath.row == selectedRow {
//                let cell = tableView.cellForRow(at: indexPath)
//                //
//                performSegue(withIdentifier: "SessionDetailSegue", sender: nil)
//                //
//                tableView.deselectRow(at: indexPath, animated: true)
            //
            } else if indexPath.row == selectedRow + 1 {
                //
                selectedRow = selectedRow + 1
                //
                let delayInSeconds = 0.5
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    //
                    let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
                    //
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                    //
                    self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
                    //
                    
                }
            //
            }
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
        }, completion: { finished in
            self.hideLabel.alpha = 1
        })
    }
    
    // Exit pocket mode
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        //
        self.hideLabel.alpha = 0
        
        //
        UIView.animate(withDuration: 0.4, animations: {
            self.blurEffectView.alpha = 0
        }, completion: { finished in
            //
            self.blurEffectView.removeFromSuperview()
            self.hideLabel.removeFromSuperview()
        })
    }
    
    
    //
    // Image -------------------------------------------------------------------------------------------------------
    //
    @IBAction func completedButtonAction(extraTap:UITapGestureRecognizer) {
        //
        let sender = extraTap.view as! UIButton
        
        //
        selectedRow = selectedRow + 1
        
        //
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            //
            let indexPath = NSIndexPath(row: self.selectedRow, section: 0)
            //
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            //
            self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
            //
            
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
        //
        // Get Image
        let sender = extraTap.view as! UIImageView
        let tag = sender.tag
        //
        if demonstrationArray[tag].count != 1 {
            sender.startAnimating()
        }
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
//        if (segue.identifier == "YogaSessionDetailSegue") {
//            //
//            let destinationVC = segue.destination as! YogaScreenOverviewDetail
//            //
//            let indexPath = tableView.indexPathForSelectedRow
//            let indexPathInt = Int((indexPath?.row)!)
//            destinationVC.selectedMovement = indexPathInt
//            //
//            destinationVC.sessionArray = sessionArray
//            destinationVC.breaths = breathsArray
//            //
//            destinationVC.demonstrationArray = demonstrationArray
//            //destinationVC.targetAreaArray = targetAreaArray
//            destinationVC.explanationArray = explanationArray
//            //
//            destinationVC.sessionType = sessionType
//            
//            // Set Button
//            destinationVC.buttonNumber = buttonNumber
//            
//            // Hide Back Button Text
//            let backItem = UIBarButtonItem()
//            backItem.title = ""
//            navigationItem.backBarButtonItem = backItem
//        }
    }
    //
}
