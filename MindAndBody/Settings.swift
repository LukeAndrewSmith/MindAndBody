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
    // MARK: Outlets ------------------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    // Sets and Reps Choice
    var actionSheetView = UIView()
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
    
    // Home screen Array
    var homeScreenArray: [String] = ["sessions", "schedule", "menu"]
    var homeScreenPicker = UIPickerView()
    // Use actionSheetView and okButton from above for home screen action sheet
    
    
    
    // View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        //
        // Set TableView Background Colour
        //
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = colour1
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
        
        //
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "settingsWalkthrough") == false {
            walkthroughSettings()
        }
        
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
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        // Navigation Title
        navigationBar.title = NSLocalizedString("settings", comment: "")
        // View
        view.backgroundColor = colour1

        //
        // Sets Reps Selection (Action Sheet)
        // view
        actionSheetView.backgroundColor = colour2
        actionSheetView.layer.cornerRadius = 15
        actionSheetView.layer.masksToBounds = true
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
        actionSheetView.addSubview(okButton)
        // sets
        secondIndicatorLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        secondIndicatorLabel.textColor = colour1
        secondIndicatorLabel.text = "s"
        //
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //
        //
        // Home Screen Action Sheet
        // picker
        homeScreenPicker.backgroundColor = colour2
        homeScreenPicker.delegate = self
        homeScreenPicker.dataSource = self
    }
    // Add movement table background (dismiss table)
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            self.actionSheetView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.view.frame.size.width - 20, height: 147 + 49)

            //
            self.backgroundViewExpanded.alpha = 0
        }, completion: { finished in
            self.actionSheetView.removeFromSuperview()
            //
            self.backgroundViewExpanded.removeFromSuperview()
        })
    }
    //
    // Ok button action
    func okButtonAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        // Rest time
        if actionSheetView.subviews.contains(restTimePicker) {
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let restTimes = settings[4]
            //
            settings[4][selectedRow] = restTimesArray[restTimePicker.selectedRow(inComponent: 0)]
            defaults.set(settings, forKey: "userSettings")
            //
        // Home Screen
        } else if actionSheetView.subviews.contains(homeScreenPicker) {
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            //
            settings[1][0] = homeScreenPicker.selectedRow(inComponent: 0)
            //
            defaults.set(settings, forKey: "userSettings")
        }
            
            
            
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            self.actionSheetView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.view.frame.size.width - 20, height: 147 + 49)
            //
            self.backgroundViewExpanded.alpha = 0
        }, completion: { finished in
            self.actionSheetView.removeFromSuperview()
            //
            self.backgroundViewExpanded.removeFromSuperview()
        })
        //
        tableView.reloadData()
    }
    

//
// MARK: Settings TableView --------------------------------------------------------------------------------------------------------------------------
//
    
// Sections
    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    // Section Titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return NSLocalizedString("backgroundImage", comment: "")
        case 1: return NSLocalizedString("homePage", comment: "")
        case 2: return NSLocalizedString("timedSession", comment: "")
        case 3: return NSLocalizedString("automaticYoga", comment: "")
        case 4: return NSLocalizedString("restTime", comment: "")
        case 5: return NSLocalizedString("defaultImage", comment: "")
        case 6: return NSLocalizedString("units", comment: "")
        case 7: return NSLocalizedString("reset", comment: "")
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
        header.contentView.backgroundColor = colour1
        
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
        case 0,1,2,3,5,6: return 1
        case 4: return 3
        case 7: return 2
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
            cell.backgroundColor = colour1
            
            // Background ImageView frame
            backgroundImageView.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 15, height: cell.frame.size.height/2)
            backgroundImageView.center.y = cell.center.y
            
            // Retreive background index
            let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let backgroundIndex = settings[0][0]
            // Set image background based on index
            if backgroundIndex < backgroundImageArray.count {
                backgroundImageView.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])

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
           
            
        // Yoga Automatic
        case 3:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let automaticYogaArray = settings[3]
            // Retreive Presentation Style
            if automaticYogaArray[0] == 0 {
                cell.textLabel?.text = NSLocalizedString("off", comment: "")
            } else {
                cell.textLabel?.text = NSLocalizedString("on", comment: "")
                
            }
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = colour1
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            //
            cell.accessoryType = .disclosureIndicator
            //
            return cell
            
            
            
        // Rest Time
        case 4:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            let row = indexPath.row
            // Titles
            let restTimeTitles = ["warmup", "workout", "stretching"]
            cell.textLabel?.text = NSLocalizedString(restTimeTitles[indexPath.row], comment: "")
            //
            // Retreive Rest Time
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let restTimes = settings[4]
            cell.detailTextLabel?.text = String(restTimes[indexPath.row]) + " s"
            //
            //
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            //cell.detailTextLabel?.textAlignment = NSTextAlignment
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)
            cell.detailTextLabel?.textColor = colour2
            cell.backgroundColor = colour1
            //
            return cell
            
            
            
        // Home Screen, Timed Session, Default Image, Units
        case 1,2,5,6:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            // Retreive Presentation Style
            switch indexPath.section {
            case 1:
                var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                let homeScreen = settings[1][0]
                cell.textLabel?.text = NSLocalizedString(homeScreenArray[homeScreen], comment: "")
            case 2:
                // timed schedule sessions
                var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                let timedSession = settings[2][0]
                if timedSession == 0 {
                    cell.textLabel?.text = NSLocalizedString("on", comment: "")
                } else {
                    cell.textLabel?.text = NSLocalizedString("off", comment: "")
                }
            case 5:
                var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                let defaultImage = settings[5][0]
                if defaultImage == 0 {
                    cell.textLabel?.text = NSLocalizedString("demonstration", comment: "")
                } else {
                    cell.textLabel?.text = NSLocalizedString("targetArea", comment: "")
                }
            case 6:
                var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                let units = settings[6][0]
                if units == 0 {
                    cell.textLabel?.text = NSLocalizedString("metric", comment: "")
                } else {
                    cell.textLabel?.text = NSLocalizedString("imperial", comment: "")
                }
            default: break
            }
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = colour1
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            return cell
            
            
            
        // Reset
        case 7:
        //
            // Reset Walkthrough
            if indexPath.row == 0 {
                cell.textLabel?.text = NSLocalizedString("resetWalkthrough", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = colour1
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
                return cell
            }
            // Reset App
            else if indexPath.row == 1 {
                cell.textLabel?.text = NSLocalizedString("resetApp", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = colour1
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

            
            
        // Home Screen
        case 1:
            //
            if actionSheetView.subviews.contains(restTimePicker) {
                let i = actionSheetView.subviews.index(of: restTimePicker)
                actionSheetView.subviews[i!].removeFromSuperview()
                let j = actionSheetView.subviews.index(of: secondIndicatorLabel)
                actionSheetView.subviews[j!].removeFromSuperview()
            }
            actionSheetView.addSubview(homeScreenPicker)
            
            //
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let homeScreen = settings[1][0]
            // View
            let homeWidth = UIScreen.main.bounds.width - 20
            let homeHeight = CGFloat(147 + 49)
            actionSheetView.frame = CGRect(x: 10, y: view.frame.maxY, width: homeWidth, height: homeHeight)
            UIApplication.shared.keyWindow?.insertSubview(actionSheetView, aboveSubview: tableView)
            // selected row
            homeScreenPicker.selectRow(homeScreen, inComponent: 0, animated: false)
            //
            // picker
            homeScreenPicker.frame = CGRect(x: 0, y: 0, width: actionSheetView.frame.size.width, height: 147)
            // ok
            okButton.frame = CGRect(x: 0, y: 147, width: actionSheetView.frame.size.width, height: 49)
            //
            backgroundViewExpanded.alpha = 0
            UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: actionSheetView)
            backgroundViewExpanded.frame = UIScreen.main.bounds
            //
            // Position
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.actionSheetView.frame = CGRect(x: 10, y: self.view.frame.maxY - homeHeight - 10, width: homeWidth, height: homeHeight)
                
                // picker
                self.homeScreenPicker.frame = CGRect(x: 0, y: 0, width: self.actionSheetView.frame.size.width, height: 147)
                // ok
                self.okButton.frame = CGRect(x: 0, y: 147, width: self.actionSheetView.frame.size.width, height: 49)
                //
                self.backgroundViewExpanded.alpha = 0.5
                
            }, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
            
            
            
        // Yoga Automatic
        case 3:
            //
            //
            // Segue to homescreen choice
            performSegue(withIdentifier: "YogaAutomaticSegue", sender: nil)
            //
            tableView.deselectRow(at: indexPath, animated: true)
            

            
        // Rest Time
        case 4:
            //
            if actionSheetView.subviews.contains(homeScreenPicker) {
                let i = actionSheetView.subviews.index(of: homeScreenPicker)
                actionSheetView.subviews[i!].removeFromSuperview()
            }
            actionSheetView.addSubview(restTimePicker)
            actionSheetView.addSubview(secondIndicatorLabel)
            actionSheetView.bringSubview(toFront: secondIndicatorLabel)
            //
            selectedRow = indexPath.row
            //
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let restTimes = settings[4]
            // View
            let restWidth = UIScreen.main.bounds.width - 20
            let restHeight = CGFloat(147 + 49)
            actionSheetView.frame = CGRect(x: 10, y: view.frame.maxY, width: restWidth, height: restHeight)
            UIApplication.shared.keyWindow?.insertSubview(actionSheetView, aboveSubview: tableView)
            // selected row
            let rowIndex = restTimesArray.index(of: restTimes[selectedRow])
            restTimePicker.selectRow(rowIndex!, inComponent: 0, animated: false)
            //
            // picker
            restTimePicker.frame = CGRect(x: 0, y: 0, width: actionSheetView.frame.size.width, height: 147)
            // ok
            okButton.frame = CGRect(x: 0, y: 147, width: actionSheetView.frame.size.width, height: 49)
            //
            self.secondIndicatorLabel.frame = CGRect(x: (actionSheetView.frame.size.width / 2 + 30), y: (self.restTimePicker.frame.size.height / 2) - 15, width: 50, height: 30)
            //
            backgroundViewExpanded.alpha = 0
            UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: actionSheetView)
            backgroundViewExpanded.frame = UIScreen.main.bounds
            //
            // Position
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.actionSheetView.frame = CGRect(x: 10, y: self.view.frame.maxY - restHeight - 10, width: restWidth, height: restHeight)
                
                // picker
                self.restTimePicker.frame = CGRect(x: 0, y: 0, width: self.actionSheetView.frame.size.width, height: 147)
                // ok
                self.okButton.frame = CGRect(x: 0, y: 147, width: self.actionSheetView.frame.size.width, height: 49)
                // Sets Indicator Label
                self.secondIndicatorLabel.frame = CGRect(x: (self.actionSheetView.frame.size.width / 2 + 30), y: (self.restTimePicker.frame.size.height / 2) - 15, width: 50, height: 30)
                //
                //
                self.backgroundViewExpanded.alpha = 0.5
                
            }, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
            
            
            
            
        // Default Image
        case 5:
            // demonstration --> targetArea
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let defaultImage = settings[5][0]
            if defaultImage == 0 {
                cell?.textLabel?.text = NSLocalizedString("targetArea", comment: "")
                settings[5][0] = 1
                UserDefaults.standard.set(settings, forKey: "userSettings")
            // targetArea --> demonstration
            } else if defaultImage == 1 {
                cell?.textLabel?.text = NSLocalizedString("demonstration", comment: "")
                settings[5][0] = 0
                UserDefaults.standard.set(settings, forKey: "userSettings")
            }
            tableView.deselectRow(at: indexPath, animated: true)
            //
            UserDefaults.standard.synchronize()
            

            
        // Units
        case 6:
        //  
            // kg --> lb
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            let units = settings[6][0]
            if units == 0 {
                cell?.textLabel?.text = NSLocalizedString("imperial", comment: "")
                settings[6][0] = 1
                UserDefaults.standard.set(settings, forKey: "userSettings")
            // lb --> kg
            } else if units == 1 {
                cell?.textLabel?.text = NSLocalizedString("metric", comment: "")
                settings[6][0] = 0
                UserDefaults.standard.set(settings, forKey: "userSettings")
            }
            tableView.deselectRow(at: indexPath, animated: true)
            //
            UserDefaults.standard.synchronize()
            
            
        
        // Reset
        case 7:
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
                    // Reset Walkthroughs
                    var walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
                    // not including notifications popup
                    for i in 1...(walkthroughs.count - 1) {
                        walkthroughs[i] = false
                    }
                    UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                
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
// MARK: Picker View ----------------------------------------------------------------------------------------------------
//
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case restTimePicker:
            return restTimesArray.count
        case homeScreenPicker:
            return homeScreenArray.count
        default:
            return 0
        }
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        switch pickerView {
        case restTimePicker:
            //
            let secondsLabel = UILabel()
            secondsLabel.text = String(restTimesArray[row])
            secondsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
            secondsLabel.textColor = colour1
            //
            secondsLabel.textAlignment = .center
            return secondsLabel
        //
        case homeScreenPicker:
            //
            let screenLabel = UILabel()
            screenLabel.text = NSLocalizedString(homeScreenArray[row], comment: "")
            screenLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
            screenLabel.textColor = colour1
            //
            screenLabel.textAlignment = .center
            return screenLabel
        //
        default:
            return UIView()
        }
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
    

    
    
//
// MARK: Slide Menu ---------------------------------------------------------------------------------------------------------------------
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
    var walkthroughTexts = ["settings0", "settings1"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    // Walkthrough
    func walkthroughSettings() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughSettings), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        let screenSize = UIScreen.main.bounds
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        //
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Walkthrough explanation
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = colour1
            walkthroughLabel.backgroundColor = colour2
            walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = colour2.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: 125, height: 47 * 2)
            let homepageMaxY = TopBarHeights.combinedHeight + (47 * 2) + 44
            walkthroughHighlight.center = CGPoint(x: (125 / 2) + 7.5, y: homepageMaxY)
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 4
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Menu
        case 1:
            //
            highlightSize = CGSize(width: 175, height: 47 * 2)
            let homepageMaxY = TopBarHeights.combinedHeight + (47 * 3) + (44 * 2)
            highlightCenter = CGPoint(x: (175 / 2) + 7.5, y: homepageMaxY)
            highlightCornerRadius = 2
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = colour2
            walkthroughTextColor = colour1
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                UserDefaults.standard.set(true, forKey: "settingsWalkthrough")
            })
        }
    }
    
//
}


//
// MARK: Slide Menu Extension ------------------------------------------------------------------------------------------------------------------
//

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
