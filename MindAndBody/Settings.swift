//
//  Settings.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Settings Class -------------------------------------------------------------------------------------------------------------------------------
//

class Settings: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //
    // Outlets
    //
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    // Sets and Reps Choice
    var restTimeView = UIView()
    var restTimePicker = UIPickerView()
    var okButton = UIButton()
    //
    let secondIndicatorLabel = UILabel()
    //
    var backgroundViewExpanded = UIButton()
    //
    var selectedRow = Int()
    
    //
    let restTimesArray: [Int] = [1, 5, 10, 15, 20, 30, 45, 60, 90, 120]
    
    
    
    // View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        //
        // Set TableView Background Colour
        //
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        //
        self.tableView.backgroundView = backView
        //
        tableView.reloadData()
    }
    

//
// Rest Time Related -------------------------------------------------------------------------------------------------------------------------
//
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Swipe
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.direction = .right
        rightSwipe.addTarget(self, action: #selector(swipeGesture(sender:)))
        tableView.addGestureRecognizer(rightSwipe)
        
        // Navigation Bar
        //
        self.navigationController?.navigationBar.barTintColor = colour2
        self.navigationController?.navigationBar.tintColor = colour1
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 23)!]
        // Navigation Title
        navigationBar.title = NSLocalizedString("settings", comment: "")
        // View
        view.backgroundColor = colour1

        //
        // Sets Reps Selection
        // view
        restTimeView.backgroundColor = colour2
        restTimeView.layer.cornerRadius = 15
        restTimeView.layer.masksToBounds = true
        // picker
        restTimePicker.backgroundColor = colour2
        restTimePicker.delegate = self
        restTimePicker.dataSource = self
        // ok
        okButton.backgroundColor = colour1
        okButton.setTitleColor(colour3, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        // sets
        secondIndicatorLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        secondIndicatorLabel.textColor = colour1
        secondIndicatorLabel.text = "s"
        //
        restTimeView.addSubview(restTimePicker)
        restTimeView.addSubview(okButton)
        restTimeView.addSubview(secondIndicatorLabel)
        restTimeView.bringSubview(toFront: secondIndicatorLabel)
        //
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //
    }
    // Add movement table background (dismiss table)
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        UIView.animate(withDuration: animationTime2, animations: {
            self.restTimeView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.view.frame.size.width - 20, height: 147 + 49)

            //
            self.backgroundViewExpanded.alpha = 0
        }, completion: { finished in
            self.restTimeView.removeFromSuperview()
            //
            self.backgroundViewExpanded.removeFromSuperview()
        })
    }
    //
    // Ok button action
    func okButtonAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        //
        var restTimes = UserDefaults.standard.object(forKey: "restTimes") as! [Int]
        //
        restTimes[selectedRow] = restTimesArray[restTimePicker.selectedRow(inComponent: 0)]
        defaults.set(restTimes, forKey: "restTimes")
        //
        defaults.synchronize()
        //
        UIView.animate(withDuration: animationTime2, animations: {
            self.restTimeView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.view.frame.size.width - 20, height: 147 + 49)
            //
            self.backgroundViewExpanded.alpha = 0
        }, completion: { finished in
            self.restTimeView.removeFromSuperview()
            //
            self.backgroundViewExpanded.removeFromSuperview()
        })
        //
        tableView.reloadData()
    }
    

//
// Settings TableView --------------------------------------------------------------------------------------------------------------------------
//
    
// Sections
    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    // Section Titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return NSLocalizedString("homeScreenImage", comment: "")
        case 1: return NSLocalizedString("defaultImage", comment: "")
        case 2: return NSLocalizedString("units", comment: "")
        case 3: return NSLocalizedString("restTime", comment: "")
        case 4: return NSLocalizedString("automaticYoga", comment: "")
        case 5: return NSLocalizedString("reset", comment: "")
        default: return ""
        }
    }
    
    // Header Customization
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 22)!
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        //
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        // Border
        let border = CALayer()
        border.backgroundColor = colour2.cgColor
        border.frame = CGRect(x: 15, y: header.frame.size.height-1, width: self.view.frame.size.height, height: 1)
        //
        header.layer.addSublayer(border)
        header.layer.masksToBounds = true
    }
    
    // Header Height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    
    
// Rows
    // Number of rows per section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        switch section {
        case 0,1,2,4: return 1
        case 3: return 3
        case 5: return 2
        default: break
        }
        return 0
    }
    
    // Row cell customization
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        // Image View for background images
        let backgroundImageView = UIImageView()
    
        // Settings sections
        switch indexPath.section {
        // Homescreen Background
        case 0:
        //
            //
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            
            // Background ImageView frame
            backgroundImageView.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 15, height: cell.frame.size.height/2)
            backgroundImageView.center.y = cell.center.y
            
            // Retreive background index
            let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
            
            // Set image background based on index
            if backgroundIndex < backgroundImageArray.count {
                backgroundImageView.image = backgroundImageArray[backgroundIndex]

            // If grey background
            } else if backgroundIndex == backgroundImageArray.count {
                //
                backgroundImageView.layer.borderWidth = 1
                backgroundImageView.layer.borderColor = colour2.cgColor
                //
                backgroundImageView.backgroundColor = colour1
            
            // If red-orange background
            }            
            // Final background image view customization
            backgroundImageView.contentMode = .scaleToFill
            cell.addSubview(backgroundImageView)
            cell.accessoryType = .disclosureIndicator
                
            // Background image frame if iPhone 5
            if UIScreen.main.nativeBounds.height < 1334 {
                backgroundImageView.frame = CGRect(x: 15, y: (cell.frame.size.height / 2) - (backgroundImageView.frame.size.height / 2), width: cell.frame.size.width - 70, height: cell.frame.size.height/2)
            }
            //
            return cell
            
            
        // Default Image
        case 1:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            // Retreive Presentation Style
            cell.textLabel?.text = NSLocalizedString(UserDefaults.standard.string(forKey: "defaultImage")!, comment: "")
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            return cell
            
 
        // Units
        case 2:
        //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            // Retreive Units
            cell.textLabel?.text = UserDefaults.standard.string(forKey: "units")
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            return cell

            
        // Rest Time
        case 3:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            let row = indexPath.row
            // Titles
            let restTimeTitles = ["warmup", "workout", "stretching"]
            cell.textLabel?.text = NSLocalizedString(restTimeTitles[indexPath.row], comment: "")
            //
            // Retreive Rest Time
            let restTimes = UserDefaults.standard.object(forKey: "restTimes") as! [Int]
            cell.detailTextLabel?.text = String(restTimes[indexPath.row]) + " s"
            //
            //
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            //cell.detailTextLabel?.textAlignment = NSTextAlignment
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)
            cell.detailTextLabel?.textColor = colour2
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            //
            return cell
          
            
        // Yoga Automatic
        case 4:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            let automaticYogaArray = UserDefaults.standard.object(forKey: "automaticYoga") as! [Int]
            // Retreive Presentation Style
            if automaticYogaArray[0] == 0 {
                cell.textLabel?.text = NSLocalizedString("off", comment: "")
            } else {
                cell.textLabel?.text = NSLocalizedString("on", comment: "")

            }
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            //
            cell.accessoryType = .disclosureIndicator
            //
            return cell
            
            
        // Reset
        case 5:
        //
            // Reset Walkthrough
            if indexPath.row == 0 {
                cell.textLabel?.text = NSLocalizedString("resetWalkthrough", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
                return cell
            }
            // Reset App
            else if indexPath.row == 1 {
                cell.textLabel?.text = NSLocalizedString("resetApp", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
                return cell
            }
        //
        default: return cell
        }
        return cell
    }
    
    // Selection handler
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let cell = tableView.cellForRow(at: indexPath)
        //
        switch section {
        
        // Homescreen Image
        case 0:
            // Segue to homescreen choice
            performSegue(withIdentifier: "BackgroundImageSegue", sender: nil)
            //
            tableView.deselectRow(at: indexPath, animated: true)

            
        // Default Image
        case 1:
            // demonstration --> targetArea
            if cell?.textLabel?.text == NSLocalizedString("demonstration", comment: "") {
                cell?.textLabel?.text = NSLocalizedString("targetArea", comment: "")
                UserDefaults.standard.set("targetArea", forKey: "defaultImage")
                // targetArea --> demonstration
            } else if cell?.textLabel?.text == NSLocalizedString("targetArea", comment: "") {
                cell?.textLabel?.text = NSLocalizedString("demonstration", comment: "")
                UserDefaults.standard.set("demonstration", forKey: "defaultImage")
            }
            tableView.deselectRow(at: indexPath, animated: true)
            

        // Units
        case 2:
        //  
            // kg --> lb
            if cell?.textLabel?.text == "kg" {
                cell?.textLabel?.text = "lb"
                UserDefaults.standard.set("lb", forKey: "units")
            // lb --> kg
            } else if cell?.textLabel?.text == "lb" {
                cell?.textLabel?.text = "kg"
                UserDefaults.standard.set("kg", forKey: "units")
            }
            tableView.deselectRow(at: indexPath, animated: true)
            
            
        // Rest Time
        case 3:
            //
            selectedRow = indexPath.row
            //
            let restTimes = UserDefaults.standard.object(forKey: "restTimes") as! [Int]
            // View
            let restWidth = UIScreen.main.bounds.width - 20
            let restHeight = CGFloat(147 + 49)
            restTimeView.frame = CGRect(x: 10, y: view.frame.maxY, width: restWidth, height: restHeight)
            UIApplication.shared.keyWindow?.insertSubview(restTimeView, aboveSubview: tableView)
            // selected row
            let rowIndex = restTimesArray.index(of: restTimes[selectedRow])
            restTimePicker.selectRow(rowIndex!, inComponent: 0, animated: false)
            //
            // picker
            restTimePicker.frame = CGRect(x: 0, y: 0, width: restTimeView.frame.size.width, height: 147)
            // ok
            okButton.frame = CGRect(x: 0, y: 147, width: restTimeView.frame.size.width, height: 49)
            //
            self.secondIndicatorLabel.frame = CGRect(x: (restTimeView.frame.size.width / 2 + 30), y: (self.restTimePicker.frame.size.height / 2) - 15, width: 50, height: 30)
            //
            backgroundViewExpanded.alpha = 0
            UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: restTimeView)
            backgroundViewExpanded.frame = UIScreen.main.bounds
            //
            // Position
            UIView.animate(withDuration: animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.restTimeView.frame = CGRect(x: 10, y: self.view.frame.maxY - restHeight - 10, width: restWidth, height: restHeight)

                // picker
                self.restTimePicker.frame = CGRect(x: 0, y: 0, width: self.restTimeView.frame.size.width, height: 147)
                // ok
                self.okButton.frame = CGRect(x: 0, y: 147, width: self.restTimeView.frame.size.width, height: 49)
                // Sets Indicator Label
                self.secondIndicatorLabel.frame = CGRect(x: (self.restTimeView.frame.size.width / 2 + 30), y: (self.restTimePicker.frame.size.height / 2) - 15, width: 50, height: 30)
                //
                //
                self.backgroundViewExpanded.alpha = 0.5
                
            }, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
            
            
        // Yoga Automatic
        case 4:
        //
            //
            // Segue to homescreen choice
            performSegue(withIdentifier: "YogaAutomaticSegue", sender: nil)
            //
            tableView.deselectRow(at: indexPath, animated: true)
            
        
        // Reset
        case 5:
        //
            // Reset Walkthrough
            if indexPath.row == 0 {
                //
                // Alert View indicating meaning of resetting the app
                let title = NSLocalizedString("resetWarning", comment: "")
                let message = NSLocalizedString("resetWalkthroughWarningMessage", comment: "")
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.view.tintColor = colour2
                alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .natural
                alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 19)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
                
                
                // Reset app action
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                    UIAlertAction in

                // Walkthrough
                    // Mind Body
                        // Home Screen
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough")
                        // Calendar
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthroughC")
                
                        // Choice Screen 1
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough1")
                        // c
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthroughc")
                
                        // w
                        UserDefaults.standard.set(true, forKey: "mindBodyWalkthroughw")
                
                        // Choice Screen 2
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough2")
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough2y")
                
                        // Movement Screen
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough3")
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough3y")
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough4y")
                
                        // Session Screen
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthroughw")
                
                        // Information
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthroughI")
                
                    //Profile
                    UserDefaults.standard.set(false, forKey: "profileWalkthrough")
                    // Information
                    UserDefaults.standard.set(false, forKey: "informationWalkthrough")
                    //
                    UserDefaults.standard.set(false, forKey: "informationWalkthroughm")
                
                //
                // Alert View indicating need for app reset
                let title = NSLocalizedString("resetTitle", comment: "")
                let message = NSLocalizedString("resetMessage", comment: "")
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.view.tintColor = colour1
                alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .natural
                alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 19)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")

                // Present alert
                self.present(alert, animated: true, completion: nil)
            }
            // Cancel reset action
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            // Add Actions
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            // Present Alert
            self.present(alert, animated: true, completion: nil)
                //
            tableView.deselectRow(at: indexPath, animated: true)
               
            // Reset App
            } else if indexPath.row == 1 {
                
            // Alert View indicating meaning of resetting the app
            let title = NSLocalizedString("resetWarning", comment: "")
            let message = NSLocalizedString("resetWarningMessage", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = colour2
            alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 19)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
           
                
            // Reset app action
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    UserDefaults.standard.synchronize()
                    
                    // Alert View
                    let title = NSLocalizedString("resetTitle", comment: "")
                    let message = NSLocalizedString("resetMessage", comment: "")
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alert.view.tintColor = colour2
                    alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.alignment = .natural
                    alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 19)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
                    
                    self.present(alert, animated: true, completion: nil)
                }
            // Cancel reset action
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                }
            // Add Actions
            alert.addAction(okAction)
            alert.addAction(cancelAction)
               
            // Present Alert
            self.present(alert, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
            }
        //
        default:
            break
        }
    }
    
    
//
// Picker View ----------------------------------------------------------------------------------------------------
//
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == restTimePicker {
            return 1
        }
        return 0
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == restTimePicker {
            return restTimesArray.count
        }
        return 0
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == restTimePicker {
            //
            let secondsLabel = UILabel()
            secondsLabel.text = String(restTimesArray[row])
            secondsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
            secondsLabel.textColor = colour1
            //
            secondsLabel.textAlignment = .center
            return secondsLabel
            //
        }
        return UIView()
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if pickerView == restTimePicker {
            return 30
        }
        return 0
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == restTimePicker {
        }
        //
    }
    

    
    
//
// Slide Menu ---------------------------------------------------------------------------------------------------------------------
//
    @IBAction func slideMenuPresent() {
        self.performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    // Elements
    //
    @IBAction func swipeGesture(sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "openMenu" {
            //
            UIApplication.shared.statusBarStyle = .default
            //
            if let destinationViewController = segue.destination as? SlideMenuView {
                destinationViewController.transitioningDelegate = self
            }
        } else {
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
//
}



//
// Slide Menu Extension
extension Settings: UIViewControllerTransitioningDelegate {
    // Present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    // Dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
}



class SettingsNavigation: UINavigationController {
    
}
