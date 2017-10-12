//
//  FinalChoice.swift
//  MindAndBody
//
//  Created by Luke Smith on 17.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Warmup Choice Class -------------------------------------------------------------------------------------------------------------
//
class FinalChoice: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    // Section Numbers (representing tableview section arrray, used to remove arrays with the arrays of arrays of keys, and to determine which sections are left)
    //
    var sectionNumbers: [Int] = []
    
    // Array of movements in sections for final choice overview table
    var overviewArray: [[Int]] = []
    
    // Cardio - time or distance
    var cardioType = 0
    
    // Coming from schedule, if coming from menu == true, hide presets button
    // && set title to presets title
    var comingFromSchedule = false
    // Title Array for if schedule
    let scheduleTitleArray = ["warmup", "workout", "cardio", "stretching", "yoga"]

    
    //
    // MARK: Outlets ------------------------------------------------------------------------------------------------------------------------------
    //
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    // Movements Table View
    @IBOutlet weak var movementsTableView: UITableView!
    
    
    // Presets Button
    @IBOutlet weak var presetsButton: UIButton!
    
    
    //
    @IBOutlet weak var presetsConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableConstraint1: NSLayoutConstraint!
    
    @IBOutlet weak var tableConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var beginConstraint: NSLayoutConstraint!
    
    
    
    let emptyString = ""
    
    // Presets Table
    //
    // Select Prest
    var presetsTableView = UITableView()
    var backgroundViewExpanded = UIButton()
    
    //
    // MARK: View did load ------------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colour
        view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        
        // Navigation Bar Title
        if comingFromSchedule == false {
            navigationBar.title = (NSLocalizedString(sessionData.navigationTitles[selectedSession[0]][selectedSession[1]] as! String, comment: ""))
        } else {
            presetsButton.alpha = 0
            let sessionTypeString = NSLocalizedString(scheduleTitleArray[selectedSession[0]], comment: "")
            navigationBar.title = sessionTypeString + " - " + NSLocalizedString("overview", comment: "")
        }
        navigationController?.navigationBar.tintColor = colour1
        
        //
        presetsButton.backgroundColor = colour2
        presetsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //
        movementsTableView.tableFooterView = UIView()
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = colour3
        beginButton.setTitleColor(colour2, for: .normal)
        
        //
        // Initial Element Positions
        if selectedSession[2] == -1 {
            presetsConstraint.constant = 0
            //
            tableConstraint1.constant = view.frame.size.height
            tableConstraint.constant = -49
            //
            beginConstraint.constant = -49
        //
        // Selected Automatically from schedule
        } else {
            //
            // Perform relevant func
            switch selectedSession[0] {
            // Warmup
            case 0:
                session()
            // Workout
            case 1:
                switch selectedSession[1] {
                // Circuit Session
                case 7,8,9,13,14,15:
                    break
                // Normal Session
                default:
                    session()
                }
            // Stretching
            case 3:
                session()
            // Cardio,Yoga
            default:
                break
            }
            
            // Cardio Type
            // If cardio
            if selectedSession[0] == 2 {
                // If time based (if section 0 in presetDictionaries (section 0 being time based sessions), contains the selected session)
                if (sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][1][1]?[0] as! [Int]).contains(selectedSession[2]) {
                    cardioType = 0
                // Else if distance based
                } else {
                    cardioType = 1
                }
            }
            
            // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [sessionKey] = session, [0] titles, [0] title
            presetsButton.setTitle("- " + NSLocalizedString(sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[0][0] as! String, comment: "") + " -", for: .normal)
            
            //
            // Animate new elements into page
            UIView.animate(withDuration: AnimationTimes.animationTime3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.movementsTableView.reloadData()
                let indexPath2 = NSIndexPath(row: 0, section: 0)
                self.movementsTableView.scrollToRow(at: indexPath2 as IndexPath, at: .top, animated: true)
                //
                self.tableConstraint.constant = 49.75
                //
                // Show presets button
                if self.comingFromSchedule == false {
                    self.tableConstraint1.constant = 73.75
                    self.presetsConstraint.constant = self.view.frame.size.height - 73.25 - TopBarHeights.combinedHeight
                // Hide presets button
                } else {
                    self.tableConstraint1.constant = 0
                    self.presetsConstraint.constant = self.view.frame.size.height - TopBarHeights.combinedHeight
                }
                //
                self.beginConstraint.constant = 0
            })
        }
        
        
        //
        // TableView Backgrounds
        //
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.movementsTableView.frame.size.width, height: self.movementsTableView.frame.size.height)
        //
        movementsTableView.backgroundView = tableViewBackground
        
        //
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = colour1
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        
        presetsTableView.tableFooterView = UIView()
        
        
        // Presets TableView
        //
        // Movement tabl
        presetsTableView.backgroundColor = colour2
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        presetsTableView.layer.cornerRadius = 15
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        presetsTableView.layer.borderColor = colour1.cgColor
        presetsTableView.layer.borderWidth = 1
        //
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //
        
    }
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Select
        if selectedSession[2] == -1 {
            self.presetsButton.sendActions(for: .touchUpInside)
        }
    }
    
    
    //
    // MARK: TableView -----------------------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case movementsTableView:
            if selectedSession[2] == -1 {
                return 0
            } else {
                return numberOfSectionsMovements()
            }
            
        case presetsTableView:
            // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [1] = sessions in sections, [0] section titles array
            let numberOfSections = (sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][1][0] as! [[String]]).count
            return numberOfSections
        default: break
        }
        return 0
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case movementsTableView:
            return titleForHeaderMovements(section: section)
            
        case presetsTableView:
            // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [1] = sessions in sections, [0] section titles array, [section] = section title, [0] = section title (has to be in array for data structure, only ever one string in array)
            return "    " + NSLocalizedString(sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][1][0]![section][0] as! String, comment: "")
        default:
            break
        }
        return ""
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        switch tableView {
        case movementsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        case presetsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
            header.textLabel?.textAlignment = .left
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        default: break
        }
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case movementsTableView:
            return numberOfRowsInSectionMovements(section: section)

        case presetsTableView:
            // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [1] = sessions in sections, [0] section titles array
            let numberOfRows = (sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][1][0]?[section] as! [String]).count
            return numberOfRows
        default: break
        }
        return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        // timed schedule sessions
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let timedSession = settings[2][0]
        //
        switch tableView {
        //
        case movementsTableView:
            //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            //
            cell.selectionStyle = .none
            
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2

            //
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 18)
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.textAlignment = .left
            cell.detailTextLabel?.textColor = colour2
            
            cell.imageView?.isUserInteractionEnabled = true
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleTap))
            cell.imageView?.addGestureRecognizer(imageTap)
            
            //
            // Fill Data
            switch selectedSession[0] {
            // Warmup
            case 0:
                let key = overviewArray[indexPath.section][indexPath.row]
                cell.imageView?.tag = key
                // [selectedSession[0]] = warmup/workout/cardio etc...
                cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][overviewArray[indexPath.section][indexPath.row]]! as String, comment: "")
                //
                // Get index of element
                // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2]] = selected session, [1] = keys
                let indexSetsReps = (sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[1] as! [Int]).index(of: overviewArray[indexPath.section][indexPath.row])
                //
                // Cell Image
                // [selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[selectedSession[0]][overviewArray[indexPath.section][indexPath.row]]?[0])!)
                
                // SetsxReps or Length
                // Timed session off
                if timedSession == 0 {
                    // Sets x Reps
                    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [2] sets array and [3] for reps
                    cell.detailTextLabel?.text = String(sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[2][indexSetsReps!] as! Int) + " x " + (sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[3][indexSetsReps!] as! String)
                // On
                } else {
                    // Length [4]
                    cell.detailTextLabel?.text = String(sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[4][indexSetsReps!] as! Int) + NSLocalizedString("s", comment: "")
                }
                
            // Workout
            case 1:
                switch selectedSession[1] {
                // Circuit Session
                case 7,8,9:
                    let key = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[1][indexPath.row] as! Int
                    cell.imageView?.tag = key
                    // [selectedSession[0]] = warmup/workout/cardio etc...
                    cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][key]! as String, comment: "")
                    //
                    // Cell Image
                    // [selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                    cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[selectedSession[0]][indexPath.row]?[0])!)
                    //
                    // Reps
                    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [2] sets array and [3] for reps
                    cell.detailTextLabel?.text = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[3][indexPath.row] as? String
                    
                // Bodyweight Circuit Session (possibility of timed session)
                case 13,14,15:
                    let key = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[1][indexPath.row] as! Int
                    cell.imageView?.tag = key
                    // [selectedSession[0]] = warmup/workout/cardio etc...
                    cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][key]! as String, comment: "")
                    //
                    // Cell Image
                    // [selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                    cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[selectedSession[0]][indexPath.row]?[0])!)
                    //
                    // Reps or Length
                    // Timed session off
                    if timedSession == 0 {
                        // Reps
                        // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [2] sets array and [3] for reps
                        cell.detailTextLabel?.text = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[3][indexPath.row] as? String
                    } else {
                        // [4] = Length
                        cell.detailTextLabel?.text = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[4][indexPath.row] as? String
                    }
                   
                // Normal Session
                default:
                    let key = overviewArray[indexPath.section][indexPath.row]
                    cell.imageView?.tag = key
                    // [selectedSession[0]] = warmup/workout/cardio etc...
                    cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][overviewArray[indexPath.section][indexPath.row]]! as String, comment: "")
                    //
                    // Get index of element
                    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2]] = selected session, [1] = keys
                    let indexSetsReps = (sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[1] as! [Int]).index(of: overviewArray[indexPath.section][indexPath.row])
                    //
                    // Sets x Reps
                    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [2] sets array and [3] for reps
                    cell.detailTextLabel?.text = String(sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[2][indexSetsReps!] as! Int) + " x " + (sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[3][indexSetsReps!] as! String)
                    //
                    // Cell Image
                    // [selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                    cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[selectedSession[0]][overviewArray[indexPath.section][indexPath.row]]?[0])!)
                }
                
            // Cardio
            case 2:
                let key = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[1][indexPath.row] as! Int
                // [selectedSession[0]] = warmup/workout/cardio etc...
                cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][key]! as String, comment: "")
                //
                // Time
                if cardioType == 0 {
                    cell.detailTextLabel?.text = timeToString(totalSeconds: sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[2][indexPath.row] as! Int)
                } else {
                    // Even IndexPath.rows (movement)
                    if indexPath.row % 2 == 0 {
                        // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [2] sets array
                        cell.detailTextLabel?.text = String(sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[2][indexPath.row] as! Int) + "m"
                        
                    // Odd IndexPath.rows (pauses)
                    } else {
                        cell.detailTextLabel?.text = timeToString(totalSeconds: sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[2][indexPath.row] as! Int)
                    }
                }
                //
                // Cell Image
                // [selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[selectedSession[0]][key]?[0])!)
                
            // Stretching
            case 3:
                let key = overviewArray[indexPath.section][indexPath.row]
                cell.imageView?.tag = key
                // [selectedSession[0]] = warmup/workout/cardio etc...
                cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][overviewArray[indexPath.section][indexPath.row]]! as String, comment: "")
                //
                // Get index of element
                // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2]] = selected session, [1] = keys
                let indexSetsReps = (sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[1] as! [Int]).index(of: overviewArray[indexPath.section][indexPath.row])
                //
                // Cell Image
                // [selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[selectedSession[0]][overviewArray[indexPath.section][indexPath.row]]?[0])!)
                //
                // Breaths or Length
                // Timed session off
                if timedSession == 0 {
                    // Breaths
                    // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [2] breaths array
                    cell.detailTextLabel?.text = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[2][indexSetsReps!] as? String
                } else {
                    // Length = [3]
                    cell.detailTextLabel?.text = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[3][indexSetsReps!] as? String
                }
                
            // Yoga
            case 4:
                let key = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[1][indexPath.row] as! Int
                cell.imageView?.tag = key
                // [selectedSession[0]] = warmup/workout/cardio etc...
                cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[selectedSession[0]][key]! as String, comment: "")
                //
                // Breaths
                // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = selected session, [2] breaths array
                cell.detailTextLabel?.text = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[2][indexPath.row] as? String
                //
                // Cell Image
                // [selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[selectedSession[0]][indexPath.row]?[0])!)
                
            default:
                break
            }
            //
            
            //
            return cell
        //
        case presetsTableView:
            //
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [1] = session sections, [1] keys
            let sessionKey = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][1][1]?[indexPath.section][indexPath.row] as! Int

            // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [sessionKey] = session, [0] titles, [0] title
            cell.textLabel?.text = "- " + NSLocalizedString(sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][sessionKey]?[0][0] as! String, comment: "") + " -"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.backgroundColor = colour1
            cell.textLabel?.textColor = colour2
            cell.tintColor = colour2
            //
            return cell
        default: break
        }
        return UITableViewCell()
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case movementsTableView:
            return 72
        case presetsTableView:
            return 44
        default: break
        }
        return 0
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        //
        case movementsTableView:
            break
        //
        case presetsTableView:
            //
            // Set selectedSession[2] to selected session
            //
            // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [1] = sessions in sections, [1] session key array
            let selectedSessionKey: Int = sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][1][1]?[indexPath.section][indexPath.row] as! Int
            //
            selectedSession[2] = selectedSessionKey
            
            //
            // Perform relevant func
            switch selectedSession[0] {
            // Warmup
            case 0:
                session()
            // Workout
            case 1:
                switch selectedSession[1] {
                // Circuit Session
                case 7,8,9,13,14,15:
                    break
                // Normal Session
                default:
                    session()
                }
            // Stretching
            case 3:
                session()
            // Cardio, Yoga
            default:
                break
            }
            
            // Cardio Type
            if selectedSession[0] == 2 {
                cardioType = indexPath.section
            }
            
            
            // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [sessionKey] = session, [0] titles, [0] title
            presetsButton.setTitle("- " + NSLocalizedString(sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[0][0] as! String, comment: "") + " -", for: .normal)
            
            //
            presetsTableView.deselectRow(at: indexPath, animated: true)
            
            //
            let tableHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88
            let tableWidth = UIScreen.main.bounds.width - 20
            
            //
            // Dismiss Action Sheet
            UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
                self.presetsTableView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: tableWidth, height: tableHeight)
                self.backgroundViewExpanded.alpha = 0
            }, completion: { finished in
                //
                self.presetsTableView.removeFromSuperview()
                self.backgroundViewExpanded.removeFromSuperview()
            })
            //
            // Animate new elements into page
            UIView.animate(withDuration: AnimationTimes.animationTime3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //
                self.movementsTableView.reloadData()
                let indexPath2 = NSIndexPath(row: 0, section: 0)
                self.movementsTableView.scrollToRow(at: indexPath2 as IndexPath, at: .top, animated: true)
                //
                self.tableConstraint.constant = 49.75
                //
                // Show presets button
                self.tableConstraint1.constant = 73.75
                if self.comingFromSchedule == false {
                    self.presetsConstraint.constant = self.view.frame.size.height - 73.25
                // Hide presets button
                } else {
                    self.tableConstraint1.constant = 0
                    self.presetsConstraint.constant = self.view.frame.size.height
                }
                //
                self.beginConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
            
        default: break
        }
        
        //
        // MARK: Walkthrough
        let walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
        if walkthroughs[2] == false {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + AnimationTimes.animationTime3, execute: {
                self.walkthroughFinalChoice()
            })
        }
    }
    
    
    //
    // MARK: TableView Helpers -----------------------------------------------------------------------------------------------------------------
    //
    // Normal Session
    // Create overviewArray for warmup/workout/stretching, overview array being array of movements sorted in groups so section headers can be presented
    func session() {
        //
        switch selectedSession[0] {
        // Warmup
        case 0:
            sectionNumbers = [0,1,2,3,4,5,6,7,8,9,10,11]
        // Workout
        case 1:
            sectionNumbers = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33]
        // Stretching
        case 3:
            sectionNumbers = [0,1,2,3,4,5,6,7,8,9,10,11,12,13]
        default:
            break
        }
        
        // Compress to new array
        overviewArray = sessionData.fullKeyArrays[selectedSession[0]] as [[Int]]
        
        //
        for i in (0...(overviewArray.count - 1)).reversed() {
            // Reduce Array to session
            for j in (0...(overviewArray[i].count - 1)).reversed() {
                // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSessionKey] = session, [1] = session movements
                if (sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]?[1] as! [Int]).contains(overviewArray[i][j]) == false {
                    overviewArray[i].remove(at: j)
                }
            }
            // Remove empty arrays
            if overviewArray[i] == [] {
                overviewArray.remove(at: i)
                sectionNumbers.remove(at: i)
            }
        }
    }
    
    // Number of sections in movements tableview
    func numberOfSectionsMovements() -> Int {
        //
        switch selectedSession[0] {
        // Warmup, Stretching
        case 0,3:
            return overviewArray.count
            
        // Workout
        case 1:
            switch selectedSession[1] {
            // Circuit Session
            case 7,8,9,13,14,15:
                // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = session, [2] = number of rounds array, [0] = number of rounds
                return sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]![2][0] as! Int
            // Normal Session
            default:
                return overviewArray.count
            }
            
        // Cardio, Yoga
        case 2,4:
            return 1
            
        //
        default:
            return 0
        }
    }
    
    // Title for header in movements tableview
    func titleForHeaderMovements(section: Int) -> String {
        //
        switch selectedSession[0] {
        // Warmup, Stretching
        case 0,3:
            // [selectedSession[0]] = warmup/workout/cardio etc..., [section] = section title
            return NSLocalizedString(sessionData.tableViewSectionArrays[selectedSession[0]][section] as String, comment: "")
            
        // Workout
        case 1:
            switch selectedSession[1] {
            // Circuit Session
            case 7,8,9,13,14,15:
                return NSLocalizedString("round", comment: "") + String(section + 1)  + NSLocalizedString("of", comment: "") + String(sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]![2][0] as! Int)
            // Normal Session
            default:
                // [selectedSession[0]] = warmup/workout/cardio etc..., [section] = section title
                return NSLocalizedString(sessionData.tableViewSectionArrays[selectedSession[0]][section] as String, comment: "")
            }
        
        // Cardio, Yoga
        case 2,4:
            return ""
            
        //
        default:
            return ""
        }
    }
    
    // Number of rows in section of movements tableview
    func numberOfRowsInSectionMovements(section: Int) -> Int {
        //
        switch selectedSession[0] {
        // Warmup, Stretching
        case 0,3:
            return overviewArray[section].count
            
        // Workout
        case 1:
            switch selectedSession[1] {
            // Circuit Session
            case 7,8,9,13,14,15:
                // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2] = session, [1] = key array
                return (sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]![1] as! [Int]).count
            default:
                return overviewArray[section].count
            }
            
        // Cardio, Yoga
        case 2,4:
            // [selectedSession[0]] = warmup/workout/cardio etc..., [selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [selectedSession[2]] = session, [1] = key array
            return (sessionData.presetsDictionaries[selectedSession[0]][selectedSession[1]][0][selectedSession[2]]![1] as! [Int]).count
            
        //
        default:
            return 0
        }
    }
    
    
    //
    // MARK: Presets Button Action -----------------------------------------------------------------------------------------------------------------
    //
    @IBAction func presetsButtonAction(_ sender: Any) {
        //
        UIApplication.shared.keyWindow?.insertSubview(presetsTableView, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: presetsTableView)
        //
        animateActionSheetUp(actionSheet: presetsTableView, actionSheetHeight: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88, backgroundView: backgroundViewExpanded)
    }
    
    
    // Dismiss presets table
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        animateActionSheetDown(actionSheet: presetsTableView, actionSheetHeight: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88, backgroundView: backgroundViewExpanded)
    }
    
    
    //
    // MARK: Expand image actions ----------------------------------------------------------------------------------------------------------------
    //
    // Handle Tap
    let expandedImage = UIImageView()
    let backgroundViewImage = UIButton()
    //
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        // Get Image
        let sender = extraTap.view as! UIImageView
        let image = sender.image
        expandedImage.image = image
        expandedImage.tag = sender.tag
        //
        // Add tap gesture for animation
        let animationTap = UITapGestureRecognizer()
        animationTap.numberOfTapsRequired = 1
        animationTap.addTarget(self, action: #selector(handleAnimationTap))
        expandedImage.addGestureRecognizer(animationTap)
        //
        backgroundViewImage.addTarget(self, action: #selector(retractImage(_:)), for: .touchUpInside)
        //
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewImage, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(expandedImage, aboveSubview: backgroundViewImage)
        //
        animateViewUp(animationView: expandedImage, backgroundView: backgroundViewImage)
    }
    
    // Retract image
    @IBAction func retractImage(_ sender: Any) {
        //
        animateViewDown(animationView: expandedImage, backgroundView: backgroundViewImage)
    }
    
    //
    @IBAction func handleAnimationTap(extraTap:UITapGestureRecognizer) {
        //
        // Get Cell
        let sender = extraTap.view as! UIImageView
        let key = sender.tag
        //
        let imageCount = (sessionData.demonstrationDictionaries[selectedSession[0]][key]!).count
        //
        // Image Array
        if imageCount != 1 && sender.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.demonstrationDictionaries[selectedSession[0]][key]![i])!)
            }
            sender.animationImages = animationArray
            sender.animationDuration = Double(imageCount - 1) * 0.5
            sender.animationRepeatCount = 1
            sender.startAnimating()
        }
    }
    
    
    //
    // MARK: Begin Button ---------------------------------------------------------------------------------------------------------------------------
    //
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        // timed schedule sessions
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let timedSession = settings[2][0]
        //
        // Segue
        switch selectedSession[0] {
        // Warmup
        case 0:
            // Timed Session off
            if timedSession == 0 {
                // Warmup uses stretching Screen
                performSegue(withIdentifier: "sessionSegueStretching", sender: self)
            // Timed Session on
            } else {
                performSegue(withIdentifier: "sessionSegueTimeBased", sender: self)
            }
        // Workout
        case 1:
            switch selectedSession[1] {
            // Circuit Session
            case 7,8,9:
                performSegue(withIdentifier: "sessionSegueCircuit", sender: self)
            // Bodyweight Circuit Session
            case 13,14,15:
                // Timed Session off
                if timedSession == 0 {
                    performSegue(withIdentifier: "sessionSegueCircuit", sender: self)
                // Timed Session On
                } else {
                    performSegue(withIdentifier: "sessionSegueTimeBased", sender: self)
                }
            // Normal Session
            default:
                performSegue(withIdentifier: "sessionSegue", sender: self)
            }
        // Cardio
        case 2:
            performSegue(withIdentifier: "sessionSegueCardio", sender: self)
        // Stretching
        case 3:
            // Timed Session off
            if timedSession == 0 {
                performSegue(withIdentifier: "sessionSegueStretching", sender: self)
            // Timed Session on
            } else {
                performSegue(withIdentifier: "sessionSegueTimeBased", sender: self)
            }
        // Yoga
        case 4:
            performSegue(withIdentifier: "sessionSegueYoga", sender: self)
        default:
            break
        }
        
        //
        // Return background to homescreen
        perform(#selector(popToRootView), with: Any?.self, afterDelay: 0.5)
    }
    
    // Pop to root view
    func popToRootView() {
        _ = self.navigationController?.popToRootViewController(animated: false)
    }
    
    
    
    //
    // MARK: Cardio helpers
    //
    // Time
    func timeToString(totalSeconds: Int) -> String {
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
    
    //
    // Prepare for segue Cardio
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sessionSegueCardio" {
            //
            let destinationVC = segue.destination as! CardioScreen
            //
            destinationVC.sessionType = cardioType
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
    var walkthroughTexts = ["finalChoice0", "finalChoice1", "finalChoice2"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    var highlightColor = UIColor()
    
    // Walkthrough
    func walkthroughFinalChoice() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughFinalChoice), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Preset Session
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = colour1
            walkthroughLabel.backgroundColor = colour2
            walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width / 2, height: 36)
            walkthroughHighlight.center = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.combinedHeight + (73.5 / 2))
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
            
            
        // Overview
        case 1:
            //
            highlightSize = CGSize(width: view.bounds.width, height: (view.bounds.height - 73.5 - 49))
            highlightCenter = CGPoint(x: (view.bounds.width / 2), y: TopBarHeights.combinedHeight + 73.5 + ((view.bounds.height - 73.5 - 49) / 2))
            highlightCornerRadius = 3
            //
            labelFrame = 1
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour2
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
            
        // Begin
        case 2:
            //
            highlightSize = CGSize(width: view.bounds.width / 3, height: 36)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y:  view.frame.maxY - 24.5)
            highlightCornerRadius = 0
            //
            labelFrame = 1
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            highlightColor = colour2
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: highlightColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                var walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
                walkthroughs[2] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            })
        }
    }

    //
}
