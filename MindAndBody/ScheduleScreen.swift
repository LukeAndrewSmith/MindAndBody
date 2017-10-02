//
//  CalendarScreen.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 27.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Schedule Class -----------------------------------------------------------------------------------------------------------------------------
//
class ScheduleScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
//
// View Will Appear ---------------------------------------------------------------------------------
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
    }
    
    //
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // TableView
    @IBOutlet weak var scheduleTable: UITableView!
    // Background Image
    @IBOutlet weak var backgroundImage: UIImageView!
    let backgroundBlur = UIVisualEffectView()

    // Content Arrays
    var daySessionsArray: [[Int]] =
    [
        // Monday
        [0,1,2,3,4,5],
        // Tuesday
        [0,1,2],
        // Wednesday
        [2],
        // Thursday
        [5],
        // Firday
        [0,4],
        // Saturday
        [2],
        // Sunday
        [5]
    ]
    
    
    // choiceProgress Indicated progress through the choices to select a session
    // choiceProgress[0] = -1 if first screen, i.e choices being displayed
    var choiceProgress = [-1,0]
    
    
    //
    // Variables
    // Days array
    let dayArray: [String] =
        ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday",]
    let dayArrayChar = ["mondayLetter","tuesdayLetter","wednesdayLetter","thursdayLetter","fridayLetter","saturdayLetter","sundayLetter"]
    // StackView
    var stackArray: [UILabel] = []
    
    //
    var selectedDay = Int()
    
    // Time Scale Action Sheet
    let scheduleChoiceTable = UITableView()
    let backgroundViewExpanded = UIButton()
    //
    var selectedSchedule = 0
    
    //
    // Main arrays tests
    
    
    
//
// View did load --------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check Mask Views
        checkMaskView()
        
        // Set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
        
        //
        // Present walkthrough 2
        if UserDefaults.standard.bool(forKey: "scheduleWalkthrough") == false {
            walkthroughSchedule()
        }

        
        //
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthroughC") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthroughC")
        }
        
        //
        // Schedule choice
        scheduleChoiceTable.backgroundColor = colour2
        scheduleChoiceTable.delegate = self
        scheduleChoiceTable.dataSource = self
        scheduleChoiceTable.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 20, height: 147 + 49)
        scheduleChoiceTable.tableFooterView = UIView()
        scheduleChoiceTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scheduleChoiceTable.layer.cornerRadius = 15
        scheduleChoiceTable.clipsToBounds = true
        scheduleChoiceTable.layer.borderWidth = 1
        scheduleChoiceTable.layer.borderColor = colour1.cgColor
        // Background View
        backgroundViewExpanded.backgroundColor = .black    
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //

        
        //
        // Background Image
        backgroundImage.frame = view.bounds
        
        //
        let test = UserDefaults.standard.string(forKey: "defaultImage")
        
        // Background Index
        let backgroundIndex = UserDefaults.standard.integer(forKey: "backgroundImage")
        
        //
        // Background Image/Colour
        //
        if backgroundIndex < backgroundImageArray.count {
            //
            backgroundImage.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImage.image = nil
            backgroundImage.backgroundColor = colour1
        }

        //
        // BackgroundBlur/Vibrancy
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        //
        backgroundBlur.frame = backgroundImage.bounds
        //
        if backgroundIndex > backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
        }
        
        //
        // Navigation Bar
        self.navigationController?.navigationBar.barTintColor = colour2
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        // Navigation Title
        navigationBar.title = NSLocalizedString("schedule", comment: "")
        
        //
        // View
        view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        
        //
        // TableView
        scheduleTable.backgroundView = UIView()
        scheduleTable.backgroundColor = .clear
        scheduleTable.tableFooterView = UIView()
        scheduleTable.separatorStyle = .none
        // Tableview top view
        let topView = UIVisualEffectView()
        let topViewE = UIBlurEffect(style: .dark)
        topView.effect = topViewE
        topView.isUserInteractionEnabled = false
        //
        topView.frame = CGRect(x: 0, y: scheduleTable.frame.minY - scheduleTable.bounds.height, width: scheduleTable.bounds.width, height: scheduleTable.bounds.height)
        //
        scheduleTable.addSubview(topView)
        
        //
        // Custom 'Page Control' m,t,w,t,f,s,s for bottom
        for i in 0...(dayArray.count - 1) {
            var dayLabel = UILabel()
            dayLabel.textColor = colour1
            dayLabel.textAlignment = .center
            dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 15)
            dayLabel.text = NSLocalizedString(dayArrayChar[i], comment: "")
            dayLabel.sizeToFit()
            dayLabel.alpha = 0.5
            dayLabel.tag = i
            //
            let dayTap = UITapGestureRecognizer()
            dayTap.numberOfTapsRequired = 1
            dayTap.addTarget(self, action: #selector(dayTapHandler))
            dayLabel.isUserInteractionEnabled = true
            dayLabel.addGestureRecognizer(dayTap)
            stackArray.append(dayLabel)
        }
        let pageStack = UIStackView(arrangedSubviews: stackArray)
        pageStack.frame = CGRect(x: 0, y:  view.frame.maxY - 24.5 - TopBarHeights.combinedHeight, width: view.bounds.width, height: 24.5)
        pageStack.distribution = .fillEqually
        pageStack.alignment = .center
        pageStack.isUserInteractionEnabled = true
        //
        // Day Swipes
        let stackSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        stackSwipeLeft.direction = UISwipeGestureRecognizerDirection.left
        pageStack.addGestureRecognizer(stackSwipeLeft)
        //
        let stackSwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        stackSwipeRight.direction = UISwipeGestureRecognizerDirection.right
        pageStack.addGestureRecognizer(stackSwipeRight)
        //
        view.addSubview(pageStack)
        
        //
        // Swipe
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.direction = .right
        rightSwipe.addTarget(self, action: #selector(swipeGestureRight))
        scheduleTable.addGestureRecognizer(rightSwipe)
        
        //
        // Select Today
        // Get current day as index, currentWeekDay - 1 as week starts at 0 in array
        selectedDay = Date().currentWeekDayFromMonday - 1
        stackArray[selectedDay].alpha = 1
    }
    
    //
    // Schedule TableView --------------------------------------------------------------------------------------------------------------------------
    //
    // Sections
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Section Titles
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        switch tableView {
        case scheduleTable:
            return NSLocalizedString(dayArray[selectedDay], comment: "")
        case scheduleChoiceTable:
            return ""
        default:
            return ""
        }
    }
    
    // Header Customization
    let seperator = CALayer()
    let headerLabel = UILabel()
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        switch tableView {
        case scheduleTable:
            // Header
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)!
            header.textLabel?.textAlignment = .center
            header.textLabel?.textColor = colour1
            
            //
            header.backgroundColor = .clear
            header.backgroundView = UIView()
            
            //
            // Seperator
            seperator.frame = CGRect(x: 27, y: header.bounds.height - 1, width: view.bounds.width - 54, height: 1)
            seperator.backgroundColor = colour1.cgColor
            seperator.opacity = 0.5
            header.layer.addSublayer(seperator)
            
            //
            // Day Swipes
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            swipeLeft.direction = UISwipeGestureRecognizerDirection.left
            view.addGestureRecognizer(swipeLeft)
            //
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            swipeRight.direction = UISwipeGestureRecognizerDirection.right
            view.addGestureRecognizer(swipeRight)

        case scheduleChoiceTable:
            break
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        seperator.removeFromSuperlayer()
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //
        switch tableView {
        case scheduleTable:
            return (view.bounds.height - 24.5) / 4
        case scheduleChoiceTable:
            return 0
        default:
            return 0
        }
    }
    
    // Rows
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        switch tableView {
        case scheduleTable:
            // First Screen, showing groups
            if choiceProgress[0] == -1 {
                return daySessionsArray[selectedDay].count + 1
            // Selecting a session
            } else {
                return sessionData.sortedGroups[choiceProgress[0]]![choiceProgress[1]].count
            }
        case scheduleChoiceTable:
            return 1 + 1
        default:
            return 0
        }
        //
    }
    
    // Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case scheduleTable:
            return 72
        case scheduleChoiceTable:
            return 47
        default:
            return 0
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //
        switch tableView {
        case scheduleTable:
            // First Screen, showing groups
            if choiceProgress[0] == -1 {
                switch indexPath.row {
                case daySessionsArray[selectedDay].count:
                    let editButton = UILabel()
                    editButton.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
                    editButton.textColor = colour1
                    editButton.text = NSLocalizedString("edit", comment: "")
                    editButton.alpha = 0.72
                    editButton.sizeToFit()
                    editButton.frame = CGRect(x: 27, y: 0, width: (view.bounds.width - 54) / 2, height: 72)
                    // action
                    editButton.isUserInteractionEnabled = true
                    let tap = UITapGestureRecognizer(target: self, action: #selector(editButtonTap))
                    tap.numberOfTapsRequired = 1
                    editButton.addGestureRecognizer(tap)
                    cell.addSubview(editButton)
                    //
    //                let plusImage = UIImageView()
    //                plusImage.image = #imageLiteral(resourceName: "Plus")
    //                plusImage.tintColor = colour1
    //                plusImage.alpha = 0.72
    //                plusImage.sizeToFit()
    //                plusImage.frame = CGRect(x: view.bounds.width - 27 - plusImage.bounds.width, y: (72 / 2) - (plusImage.bounds.height / 2), width: plusImage.bounds.width, height: plusImage.bounds.height)
    //                cell.addSubview(plusImage)
                    //
                    let seperator = CALayer()
                    seperator.frame = CGRect(x: 27, y: 0, width: (view.bounds.width - 54) / 3, height: 1)
                    seperator.backgroundColor = colour1.cgColor
                    seperator.opacity = 0.25
                    cell.layer.addSublayer(seperator)
                    
                // All other cells
                default:
                    let dayLabel = UILabel()
                    dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
                    dayLabel.textColor = colour1
                    //
                    let text = sessionData.sortedGroups[daySessionsArray[selectedDay][indexPath.row]]![0][0]
                    dayLabel.text = NSLocalizedString(text, comment: "")
                    dayLabel.numberOfLines = 2
                    dayLabel.sizeToFit()
                    dayLabel.frame = CGRect(x: 27, y: 0, width: view.bounds.width - 54, height: 72)
                    cell.addSubview(dayLabel)
                }
                
            // Currently selecting a session, i.e not first screen
            } else {
                // If title
                if indexPath.row == 0 {
                    let title = sessionData.sortedGroups[choiceProgress[0]]![choiceProgress[1]][0]
                    cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
                    cell.textLabel?.textColor = colour1
                    cell.textLabel?.text = NSLocalizedString(title, comment: "")
                    cell.textLabel?.textAlignment = .center
//                    cell.textLabel?.numberOfLines = 2
//                    cell.textLabel?.sizeToFit()
                    cell.textLabel?.frame = CGRect(x: view.bounds.width / 2, y: 0, width: view.bounds.width / 2, height: 72)
                    //
                    cell.selectionStyle = .none
                    //
                    // Title Underline
                    let seperator = CALayer()
                    seperator.frame = CGRect(x: view.bounds.width / 4, y: 72 - 1, width: view.bounds.width / 2, height: 1)
                    seperator.backgroundColor = colour1.cgColor
                    seperator.opacity = 0.25
                    cell.layer.addSublayer(seperator)
                // Else if selection
                } else {
                    //
                    let choiceLabel = UILabel()
                    choiceLabel.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
                    choiceLabel.textColor = colour1
                    //
                    let text = sessionData.sortedGroups[choiceProgress[0]]![choiceProgress[1]][indexPath.row]
                    choiceLabel.text = NSLocalizedString(text, comment: "")
                    choiceLabel.numberOfLines = 2
                    choiceLabel.sizeToFit()
                    choiceLabel.frame = CGRect(x: 27, y: 0, width: view.bounds.width - 54, height: 72)
                    cell.addSubview(choiceLabel)
                }
            }

            //
        case scheduleChoiceTable:
            //
            switch indexPath.row {
            case 1:
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                cell.tintColor = colour1
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1)
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1)
            default:
                
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
                cell.textLabel?.textAlignment = .left
                cell.textLabel?.textColor = colour1
                cell.accessoryType = .checkmark
                cell.tintColor = colour3
                cell.textLabel?.text = NSLocalizedString("App Schedule", comment: "")
            }
            
            
            //
        default:
            break
        }
        //
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        //
        return cell
    }

    // Did select row
    //
    let maskView1 = UIButton()
    let maskView2 = UIButton()
    let maskViewBackButton = UIImageView()
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch tableView {
        case scheduleTable:
            //
            switch indexPath.row {
            case daySessionsArray[selectedDay].count:
                break
            default:
                // Next Choice Function
                if choiceProgress[0] == -1 {
                    choiceProgress[0] = daySessionsArray[selectedDay][indexPath.row]
                    choiceProgress[1] += 1
                    maskView()
                    // Next Table info
                    slideLeft()
                
                //
                } else {
                
                    // Present next choice or present session
                    switch choiceProgress[0] {
                    // Mind
                    case 0:
                        if choiceProgress[1] == 4 {
                            // Test
                            selectedSession = [5,0,0]
                            performSegue(withIdentifier: "scheduleMeditationSegue", sender: self)
                            
                            } else {
                            choiceProgress[1] += 1
                        }
                        
                    // Flexibility
                    case 1:
                        if choiceProgress[1] == 4 {
                            // Test
                            selectedSession = [1,0,0]
                            performSegue(withIdentifier: "scheduleMeditationSegue", sender: self)
                        } else {
                            choiceProgress[1] += 1
                        }
                        
                    // Endurance
                    case 2:
                        switch choiceProgress[1] {
                        case 4:
                            // Test
                            selectedSession = [1,0,0]
                            performSegue(withIdentifier: "scheduleMeditationSegue", sender: self)
                        case 5:
                            if indexPath.row == 2 {
                                
                            } else {
                                choiceProgress[1] += 1
                            }
                        case 6:
                            // Test
                            selectedSession = [1,0,0]
                            performSegue(withIdentifier: "scheduleMeditationSegue", sender: self)
                        default:
                            choiceProgress[1] += 1
                        }
                        
                    // Fat Loss
                    case 3:
                        if choiceProgress[1] == 4 {
                            // Test
                            selectedSession = [1,0,0]
                            performSegue(withIdentifier: "scheduleMeditationSegue", sender: self)
                        } else {
                            choiceProgress[1] += 1
                        }
                        
                    // Muscle Gain
                    case 4:
                        if choiceProgress[1] == 4 {
                            // Test
                            selectedSession = [1,0,0]
                            performSegue(withIdentifier: "scheduleMeditationSegue", sender: self)
                        } else {
                            choiceProgress[1] += 1
                        }
                        
                    // Strength
                    case 5:
                        if choiceProgress[1] == 4 {
                            // Test
                            selectedSession = [1,0,0]
                            performSegue(withIdentifier: "scheduleMeditationSegue", sender: self)
                        } else {
                            choiceProgress[1] += 1
                        }
                    default:
                        break
                    }
                }
                
                nextChoice()
            }

            //
            tableView.deselectRow(at: indexPath, animated: true)

        case scheduleChoiceTable:
            tableView.deselectRow(at: indexPath, animated: true)

        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
//
// MARK: Helper Functions
//
    //
    // MARK: Mask Views
    // Mask view func
    func maskView() {
        // Animate mask view if group selected and mask doesnt already exist
        if choiceProgress[0] != -1 && view.subviews.contains(maskView1) == false {
            createMaskView(alpha: 0)
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                self.maskView1.alpha = 0.72
                self.maskView2.alpha = 0.72
            })
        }
    }
    // Session selection mask
    func maskAction() {
        // Table Counter
        // Return to choice 1 (sessions)
        if choiceProgress[1] > 1 {
            // Cardio has two choice paths
            if choiceProgress[0] == 2 && choiceProgress[1] == 5 {
                choiceProgress[1] = 1
            } else {
                choiceProgress[1] -= 1
            }
            slideRight()
        // Return to choice 0 (groups)
        } else if choiceProgress[1] == 1 {
            choiceProgress[0] = -1
            choiceProgress[1] = 0
            // Enable table scroll & schedule choice button & remove mask view
            scheduleTable.isScrollEnabled = true
            navigationBar.rightBarButtonItem?.isEnabled = true
            removeMaskView()
            slideRight()
        }
    }
    // Open Schedule, check if mask views necessary
    func checkMaskView() {
        if tableCounter[0] != -1 {
            createMaskView(alpha: 0.5)
        }
    }
    // Mask Views -----------------------------------
    // Create Mask Views
    func createMaskView(alpha: CGFloat) {
        // Disable table scroll & schedule choice button
        scheduleTable.isScrollEnabled = false
        navigationBar.rightBarButtonItem?.isEnabled = false
        //
        let screenFrame = UIScreen.main.bounds
        //
        maskView1.addTarget(self, action: #selector(maskAction), for: .touchUpInside)
        maskView2.addTarget(self, action: #selector(maskAction), for: .touchUpInside)
        //
        maskView1.frame = CGRect(x: 0, y: 0, width: screenFrame.width, height: (screenFrame.height - TopBarHeights.combinedHeight - 24.5) / 4)
        maskView2.frame = CGRect(x: 0, y: scheduleTable.frame.maxY, width: screenFrame.width, height: 24.5)
        //
        maskView1.backgroundColor = .black
        maskView1.alpha = alpha
        maskView2.backgroundColor = .black
        maskView2.alpha = alpha
        //
        view.addSubview(maskView1)
        view.addSubview(maskView2)
        //
        maskViewBackButton.image = #imageLiteral(resourceName: "Back Arrow")
        maskViewBackButton.tintColor = colour1
        maskViewBackButton.sizeToFit()
        maskViewBackButton.frame = CGRect(x: 5, y: maskView1.bounds.height - maskViewBackButton.bounds.height - 11, width: maskViewBackButton.bounds.width, height: maskViewBackButton.bounds.height)
        maskView1.addSubview(maskViewBackButton)
    }
    // Remove Mask Views
    func removeMaskView() {
        //
        UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
            self.maskView1.alpha = 0
            self.maskView2.alpha = 0
        }, completion: { finished in
            self.maskView1.removeFromSuperview()
            self.maskView2.removeFromSuperview()
        })
    }
    // Table View ------------------------------------
    // Tableview slide left (next table)
    func slideLeft() {
        //
        view.isUserInteractionEnabled = false
        //
        let screenFrame = UIScreen.main.bounds
        let tableHeaderHeight = (screenFrame.height - TopBarHeights.combinedHeight - 24.5) / 4
        //
        // Mask hides table header so add screenshot
        let tableHeaderFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: tableHeaderHeight)
        let snapShotHeader = scheduleTable.resizableSnapshotView(from: tableHeaderFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        view.insertSubview(snapShotHeader, belowSubview: maskView1)
        //
        // Slide across table
        let snapShotFrame = CGRect(x: 0, y: tableHeaderHeight, width: view.bounds.width, height: view.bounds.height - tableHeaderHeight - 24.5)
        let snapShotY = TopBarHeights.combinedHeight + tableHeaderHeight + ((view.bounds.height - tableHeaderHeight - 24.5) / 2)
        // Snapshots
        let snapShot1 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: false, withCapInsets: .zero)
        //
        scheduleTable.reloadData()
        //
        let snapShot2 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: true, withCapInsets: .zero)
        //
        snapShot1?.center = CGPoint(x: view.center.x, y: snapShotY)
        snapShot2?.center = CGPoint(x: view.center.x + view.frame.size.width, y: snapShotY)
        //
        maskTable()
        UIApplication.shared.keyWindow?.insertSubview((snapShot1)!, aboveSubview: self.view)
        UIApplication.shared.keyWindow?.insertSubview((snapShot2)!, aboveSubview: self.view)
        // Animate new and old image to left
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
            snapShot2?.center.x = self.view.center.x
            //
        }, completion: { finished in
            snapShot1?.removeFromSuperview()
            snapShot2?.removeFromSuperview()
            snapShotHeader.removeFromSuperview()
            self.removeMaskTable()
            self.view.isUserInteractionEnabled = true
        })
    }
    // Tableview slide Right (previous table)
    func slideRight() {
        //
        view.isUserInteractionEnabled = false
        //
        let screenFrame = UIScreen.main.bounds
        let tableHeaderHeight = (screenFrame.height - TopBarHeights.combinedHeight - 24.5) / 4
        //
        // Mask hides table header so add screenshot
        let tableHeaderFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: tableHeaderHeight)
        let snapShotHeader = scheduleTable.resizableSnapshotView(from: tableHeaderFrame, afterScreenUpdates: false, withCapInsets: .zero)!
        view.insertSubview(snapShotHeader, belowSubview: maskView1)
        //
        // Slide table
        let snapShotFrame = CGRect(x: 0, y: tableHeaderHeight, width: view.bounds.width, height: view.bounds.height - tableHeaderHeight - 24.5)
        let snapShotY = TopBarHeights.combinedHeight + tableHeaderHeight + ((view.bounds.height - tableHeaderHeight - 24.5) / 2)
        // Snapshots
        let snapShot1 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: false, withCapInsets: .zero)
        //
        scheduleTable.reloadData()
        //
        let snapShot2 = scheduleTable.resizableSnapshotView(from: snapShotFrame, afterScreenUpdates: true, withCapInsets: .zero)
        //
        snapShot1?.center = CGPoint(x: view.center.x, y: snapShotY)
        snapShot2?.center = CGPoint(x: view.center.x - view.frame.size.width, y: snapShotY)
        //
        maskTable()
        UIApplication.shared.keyWindow?.insertSubview((snapShot1)!, aboveSubview: self.view)
        UIApplication.shared.keyWindow?.insertSubview((snapShot2)!, aboveSubview: self.view)
        //
        // Animate new and old image to left
        UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            //
            snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
            snapShot2?.center.x = self.view.center.x
            //
        }, completion: { finished in
            snapShot1?.removeFromSuperview()
            snapShot2?.removeFromSuperview()
            snapShotHeader.removeFromSuperview()
            self.removeMaskTable()
            self.view.isUserInteractionEnabled = true
        })
    }
    // Mask Table
    let mask = CAGradientLayer()
//    var snapShotHeader = UIView()
    func maskTable() {
        let screenFrame = UIScreen.main.bounds
        //
        mask.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: view.bounds.height)
        let test = mask.frame.minY
        
        //TopBarHeights.combinedHeight + tableHeaderHeight
        mask.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        //
        // Snapshot Header - mask layer covers header so show it
        // SHOULD FIND A BETTER WAY, MASKING ONLY THE NECESSARY CELLS AND NOT THE WHOLE TABLEVIEW WITH HEADER
            // ISSUE: MASK.FRAME DOESNT SEE TO LISTEN TO Y VALUE or y value means something else
        
        //
        scheduleTable.layer.mask = mask
        //
        // MASK LAYER Y = 0 INSTEAD OF TABLEVIEWHEIGHT !!!!
    }
    func removeMaskTable() {
        mask.removeFromSuperlayer()
    }
    
    
    //
    // Mask cells under clear header (unrelated to above functions)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in scheduleTable.visibleCells {
            let hiddenFrameHeight = scrollView.contentOffset.y - cell.frame.origin.y + (view.bounds.height - 24.5) / 4
            if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
                maskCell(cell: cell, margin: Float(hiddenFrameHeight))
            }
        }
    }
    func maskCell(cell: UITableViewCell, margin: Float) {
        cell.layer.mask = visibilityMaskForCell(cell: cell, location: (margin / Float(cell.frame.size.height) ))
        cell.layer.masksToBounds = true
    }
    func visibilityMaskForCell(cell: UITableViewCell, location: Float) -> CAGradientLayer {
        let mask = CAGradientLayer()
        mask.frame = cell.bounds
        mask.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        mask.locations = [NSNumber(value: location), NSNumber(value: location)]
        return mask;
    }
    
    
    
    //
    // MARK: Choice Functions
    func nextChoice() {
        //
        
        
        //
        // Mask View
        maskView()
        // Next Table info
        slideLeft()
    }
    

    
    //
    // Navigation through days ---------------------------------------------------------------------------------------------------------------------
    //
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        //
        // Forward 1 day
        if (extraSwipe.direction == .left){
            // Update selected day
            switch selectedDay {
            case 6: selectedDay = 0
            default: selectedDay += 1
            }
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[selectedDay].alpha = 1

            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x + self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            scheduleTable.alpha = 0
            //
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.scheduleTable.alpha = 1
                snapShot1?.removeFromSuperview()
                snapShot2?.removeFromSuperview()
            })
            
            //
        // Back 1 day
        } else if extraSwipe.direction == .right {
            // Update selected day
            switch selectedDay {
            case 0: selectedDay = 6
            default: selectedDay -= 1
            }
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[selectedDay].alpha = 1
            selectDay(day: selectedDay)
            
            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x - self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            scheduleTable.alpha = 0
            //
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.scheduleTable.alpha = 1
                snapShot1?.removeFromSuperview()
                snapShot2?.removeFromSuperview()
            })
            
        }
    }
    
    //
    // Day Tap
    func dayTapHandler(sender: UITapGestureRecognizer) {
        let dayLabel = sender.view as! UILabel
        let index = dayLabel.tag
        //
        // Forward
        if index > selectedDay {
            // Update selected day
            selectedDay = index
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[selectedDay].alpha = 1
            
            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x + self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            scheduleTable.alpha = 0
            //
            view.isUserInteractionEnabled = false
            //
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.scheduleTable.alpha = 1
                snapShot1?.removeFromSuperview()
                snapShot2?.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
            })
            
            //
        // Back
        } else if index < selectedDay {
            // Update selected day
            selectedDay = index
            
            // Deselect all indicators
            for i in 0...(stackArray.count - 1) {
                stackArray[i].alpha = 0.5
            }
            // Select indicator
            stackArray[selectedDay].alpha = 1
            selectDay(day: selectedDay)
            
            // Animate
            scheduleTable.reloadData()
            let snapShot1 = scheduleTable.snapshotView(afterScreenUpdates: false)
            let snapShot2 = scheduleTable.snapshotView(afterScreenUpdates: true)
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x - self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            scheduleTable.alpha = 0
            //
            view.isUserInteractionEnabled = false
            //
            UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.scheduleTable.alpha = 1
                snapShot1?.removeFromSuperview()
                snapShot2?.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
            })
            
        }
    }
    
    
    // Slide menu swipe
    func swipeGestureRight() {
        performSegue(withIdentifier: "openMenu", sender: self)
    }
    //
    
    
    //
    func selectDay(day: Int) {
        
        
        // Select indicator
        stackArray[day].alpha = 1
        
        // Reload table
        scheduleTable.reloadData()
    }
    
    
    //
    // Edit tap
    func editButtonTap() {
        //
    }
    
    // 
    // Schedule Selection ---------------------------------------------------------------------------------------------------------------------

    // 
    //
    // Ok button action
    func okButtonAction(_ sender: Any) {
        // If data is available
//        if weekTrackingDictionary.count != 0 {
//            //
//            currentPositionLabels.forEach{$0.removeFromSuperview()}
//            //
//            selectedTimeScale = timeScalePickerView.selectedRow(inComponent: 0)
//            //
//            animateActionSheetDown(actionSheet: actionSheet, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
//            //
//            chart?.view.removeFromSuperview()
//            drawGraph()
//            // No data to display
//        } else {
//            selectedTimeScale = timeScalePickerView.selectedRow(inComponent: 0)
            animateActionSheetDown(actionSheet: scheduleChoiceTable, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
//        }
    }
    
    //
    @IBAction func scheduleButton(_ sender: Any) {
        //
//        timeScalePickerView.selectRow(selectedTimeScale, inComponent: 0, animated: true)
        //
        UIApplication.shared.keyWindow?.insertSubview(scheduleChoiceTable, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: scheduleChoiceTable)
        //
        animateActionSheetUp(actionSheet: scheduleChoiceTable, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
    }
    
    // Dismiss presets table
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        animateActionSheetDown(actionSheet: scheduleChoiceTable, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
    }
    

    //
    // Slide Menu ---------------------------------------------------------------------------------------------------------------------
    //
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "openMenu" {
            // Remove Mask View
//            removeMaskView()
            //
            UIApplication.shared.statusBarStyle = .default
            //
            if let destinationViewController = segue.destination as? SlideMenuView {
                destinationViewController.transitioningDelegate = self
            }
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
    var walkthroughTexts = ["schedule0", "schedule1", "schedule2", "schedule3"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    // Walkthrough
    func walkthroughSchedule() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughSchedule), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
        // First has to be done differently
        // Schedules
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = colour2
            walkthroughLabel.backgroundColor = colour1
            walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: 172, height: 33)
            walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: 40)
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
         
            
        // Pasth
        case 1:
            //
            highlightSize = CGSize(width: 172, height: 33)
            highlightCenter = CGPoint(x: view.frame.size.width / 2, y: 40)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
            
        // Custom Schedules
        case 2:
            //
            highlightSize = CGSize(width: 36, height: 36)
            let barButtonItem = self.navigationItem.rightBarButtonItem!
            let buttonItemView = barButtonItem.value(forKey: "view") as? UIView
            highlightCenter = CGPoint(x: (buttonItemView?.center.x)!, y: (buttonItemView?.center.y)! + TopBarHeights.statusBarHeight)
            highlightCornerRadius = 1
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
        
            
        // Swipe
        case 3:
            //
            highlightSize = CGSize(width: view.bounds.width - 30, height: 10)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: ((view.bounds.height) / 3.3) + TopBarHeights.statusBarHeight)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
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
                UserDefaults.standard.set(true, forKey: "scheduleWalkthrough")
            })
        }
    }
    
}

//
// Slide Menu Extension
extension ScheduleScreen: UIViewControllerTransitioningDelegate {
    // Present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    // Dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
}


//
class ScheduleNavigation: UINavigationController {
}
