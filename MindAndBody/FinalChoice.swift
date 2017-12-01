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
    
    // Cardio - time or distance
    var cardioType = 0
    
    // Coming from schedule, if coming from menu, hide presets button
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
    
    //
    // MARK: View did load ------------------------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colour
        view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        
        // Navigation Bar Title
        if comingFromSchedule == false {
            navigationBar.title = (NSLocalizedString(sessionData.navigationTitles[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]] , comment: ""))
        } else {
            let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[[[Any]]]]
            // App chooses session
            if schedules[ScheduleVariables.shared.selectedSchedule][1][2][0] as! Int == 0 {
                presetsButton.alpha = 0
                let sessionTypeString = NSLocalizedString(scheduleTitleArray[SelectedSession.shared.selectedSession[0]], comment: "")
                navigationBar.title = sessionTypeString + " - " + NSLocalizedString("overview", comment: "")
            // User chooses sessions
            } else {
                navigationBar.title = (NSLocalizedString(sessionData.navigationTitles[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]] , comment: ""))
                // Select nothing, user wants to select somthing
                SelectedSession.shared.selectedSession[2] = -1
            }
        }
        navigationController?.navigationBar.tintColor = Colours.colour1
        
        //
        presetsButton.backgroundColor = Colours.colour2
        presetsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //
        movementsTableView.tableFooterView = UIView()
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = Colours.colour3
        beginButton.setTitleColor(Colours.colour2, for: .normal)
        
        //
        // Initial Element Positions
        if SelectedSession.shared.selectedSession[2] == -1 {
            
            setConstraints(showingViews: false, animated: false)
            //
            // Selected Automatically from schedule
        } else {
            // Cardio Type
            // If cardio
            if SelectedSession.shared.selectedSession[0] == 2 {
                // If time based (if section 0 in presetDictionaries (section 0 being time based sessions), contains the selected session)
                if (sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][1][1]?[0] as! [Int]).contains(SelectedSession.shared.selectedSession[2]) {
                    cardioType = 0
                    // Else if distance based
                } else {
                    cardioType = 1
                }
            }
            
            // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [sessionKey] = session, [0] titles, [0] title
            presetsButton.setTitle("- " + NSLocalizedString(sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[0][0] as! String, comment: "") + " -", for: .normal)
            
            //
            self.movementsTableView.reloadData()
            let indexPath2 = NSIndexPath(row: 0, section: 0)
            self.movementsTableView.scrollToRow(at: indexPath2 as IndexPath, at: .top, animated: true)
            //
            setConstraints(showingViews: true, animated: true)
        }
        
        
        //
        // TableView Backgrounds
        //
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = Colours.colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.movementsTableView.frame.size.width, height: self.movementsTableView.frame.size.height)
        //
        movementsTableView.backgroundView = tableViewBackground
        
        //
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = Colours.colour1
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        
        presetsTableView.tableFooterView = UIView()
        
        
        // Presets TableView
        //
        // Movement tabl
        presetsTableView.backgroundColor = Colours.colour2
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        presetsTableView.layer.cornerRadius = 15
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        presetsTableView.layer.borderColor = Colours.colour1.cgColor
        presetsTableView.layer.borderWidth = 1
        //
        let tableHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 49 - 88 - 49 - 20
        let tableWidth = UIScreen.main.bounds.width - 20
        self.presetsTableView.frame = CGRect(x: 0, y: 0, width: tableWidth, height: tableHeight)
        //
        ActionSheet.shared.setupActionSheet()
        ActionSheet.shared.actionSheet.addSubview(presetsTableView)
        let heightToAdd = presetsTableView.bounds.height
        ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
        ActionSheet.shared.resetCancelFrame()
        //
    }
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Select
        if SelectedSession.shared.selectedSession[2] == -1 {
            self.presetsButton.sendActions(for: .touchUpInside)
        }
    }
    
    //
    func setConstraints(showingViews: Bool, animated: Bool) {
        
        // Set constraints
        if showingViews {
            //
            self.tableConstraint.constant = 49.75
            // Show presets button
            if self.comingFromSchedule == false {
                self.tableConstraint1.constant = 73.75
                self.presetsConstraint.constant = self.view.frame.size.height - 73.25
            // Hide presets button
            } else {
                let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[[[Any]]]]
                // App chooses session
                if schedules[ScheduleVariables.shared.selectedSchedule][1][2][0] as! Int == 0 {
                    self.tableConstraint1.constant = 0
                    self.presetsConstraint.constant = self.view.frame.size.height
                // User chooses sessions
                } else {
                    self.tableConstraint1.constant = 73.75
                    self.presetsConstraint.constant = self.view.frame.size.height - 73.25
                }
            }
            //
            self.beginConstraint.constant = 0

        } else {
            if IPhoneType.shared.iPhoneType() == 2 {
                self.presetsConstraint.constant = -34
            } else {
                self.presetsConstraint.constant = 0
            }
            //
            tableConstraint1.constant = view.frame.size.height
            tableConstraint.constant = -49 - 34
            //
            beginConstraint.constant = -49 - 34
        }
        
        // Animate / Set
        if animated {
            UIView.animate(withDuration: AnimationTimes.animationTime3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            self.view.layoutIfNeeded()
        }
    }
    
    //
    // MARK: TableView -----------------------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case movementsTableView:
            if SelectedSession.shared.selectedSession[2] == -1 {
                return 0
            } else {
                return numberOfSectionsMovements()
            }
            
        case presetsTableView:
            // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [1] = sessions in sections, [0] section titles array
            let numberOfSections = (sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][1][0] as! [[String]]).count
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
            // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [1] = sessions in sections, [0] section titles array, [section] = section title, [0] = section title (has to be in array for data structure, only ever one string in array)
            return "    " + NSLocalizedString(sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][1][0]![section][0] as! String, comment: "")
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
            header.textLabel?.textColor = Colours.colour1
            header.contentView.backgroundColor = Colours.colour2
            header.contentView.tintColor = Colours.colour1
        case presetsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
            header.textLabel?.textAlignment = .left
            header.textLabel?.textColor = Colours.colour1
            header.contentView.backgroundColor = Colours.colour2
            header.contentView.tintColor = Colours.colour1
        default: break
        }
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case movementsTableView:
            return numberOfRowsInSectionMovements(section: section)
            
        case presetsTableView:
            // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [1] = sessions in sections, [0] section titles array
            let numberOfRows = (sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][1][0]?[section] as! [String]).count
            return numberOfRows
        default: break
        }
        return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        // timed schedule sessions
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let timedSession = settings["TimeBasedSessions"]![0]
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
            cell.textLabel?.textColor = Colours.colour2
            cell.tintColor = Colours.colour2
            
            //
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 18)
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.textAlignment = .left
            cell.detailTextLabel?.textColor = Colours.colour2
            
            cell.imageView?.isUserInteractionEnabled = true
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleTap))
            cell.imageView?.addGestureRecognizer(imageTap)
            
            //
            // Fill Data
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup
            case 0:
                let key = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1][indexPath.row] as! Int
                cell.imageView?.tag = key
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc...
                cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[SelectedSession.shared.selectedSession[0]][key]! as String, comment: "")
                //
                // Get index of element
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2]] = selected session, [1] = keys
                let indexSetsReps = (sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1] as! [Int]).index(of: key)
                //
                // Cell Image
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]?[0])!)
                
                // SetsxReps or Length
                // Timed session off
                if timedSession == 0 {
                    // Sets x Reps
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] sets array and [3] for reps
                    cell.detailTextLabel?.text = String(sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[2][indexSetsReps!] as! Int) + " x " + (sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[3][indexSetsReps!] as! String)
                    // On
                } else {
                    // Length [4]
                    cell.detailTextLabel?.text = String(sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[4][indexSetsReps!] as! Int) + NSLocalizedString("s", comment: "")
                }
                
            // Workout
            case 1:
                switch SelectedSession.shared.selectedSession[1] {
                // Circuit Session
                case 7,8,9:
                    let key = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1][indexPath.row] as! Int
                    cell.imageView?.tag = key
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc...
                    cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[SelectedSession.shared.selectedSession[0]][key]! as String, comment: "")
                    //
                    // Cell Image
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                    cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]?[0])!)
                    //
                    // Reps
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] sets array and [3] for reps
                    // Find n movements in round, * round to find the index for the reps (if round to, nMovements = 3, indexPAth.row == 1 then index = 1 + 3 = 4)
                    let nMovementsInRound = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1].count
                    let index = indexPath.row + (indexPath.section * nMovementsInRound!)
                    cell.detailTextLabel?.text = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[3][index] as? String
                    
                // Bodyweight Circuit Session (possibility of timed session)
                case 13,14,15:
                    let key = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1][indexPath.row] as! Int
                    cell.imageView?.tag = key
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc...
                    cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[SelectedSession.shared.selectedSession[0]][key]! as String, comment: "")
                    //
                    // Cell Image
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                    cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]?[0])!)
                    //
                    // Reps or Length
                    // Timed session off
                    if timedSession == 0 {
                        // Reps
                        // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] sets array and [3] for reps
                        // Find n movements in round, * round to find the index for the reps (if round to, nMovements = 3, indexPAth.row == 1 then index = 1 + 3 = 4)
                        let nMovementsInRound = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1].count
                        let index = indexPath.row + (indexPath.section * nMovementsInRound!)
                        cell.detailTextLabel?.text = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[3][index] as? String
                    } else {
                        // [4] = Length
                        // Find n movements in round, * round to find the index for the reps (if round to, nMovements = 3, indexPAth.row == 1 then index = 1 + 3 = 4)
                        let nMovementsInRound = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1].count
                        let index = indexPath.row + (indexPath.section * nMovementsInRound!)
                        cell.detailTextLabel?.text = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[4][index] as? String
                    }
                    
                // Normal Session
                default:
                    let key = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1][indexPath.row] as! Int
                    cell.imageView?.tag = key
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc...
                    cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[SelectedSession.shared.selectedSession[0]][key]! as String, comment: "")
                    //
                    // Get index of element
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2]] = selected session, [1] = keys
                    let indexSetsReps = (sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1] as! [Int]).index(of: key)
                    //
                    // Sets x Reps
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] sets array and [3] for reps
                    cell.detailTextLabel?.text = String(sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[2][indexSetsReps!] as! Int) + " x " + (sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[3][indexSetsReps!] as! String)
                    //
                    // Cell Image
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                    cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]?[0])!)
                }
                
            // Cardio
            case 2:
                let key = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1][indexPath.row] as! Int
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc...
                cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[SelectedSession.shared.selectedSession[0]][key]! as String, comment: "")
                //
                // Time
                if cardioType == 0 {
                    cell.detailTextLabel?.text = timeToString(totalSeconds: sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[2][indexPath.row] as! Int)
                } else {
                    // Even IndexPath.rows (movement)
                    if indexPath.row % 2 == 0 {
                        // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] sets array
                        cell.detailTextLabel?.text = String(sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[2][indexPath.row] as! Int) + "m"
                        
                        // Odd IndexPath.rows (pauses)
                    } else {
                        cell.detailTextLabel?.text = timeToString(totalSeconds: sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[2][indexPath.row] as! Int)
                    }
                }
                //
                // Cell Image
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]?[0])!)
                
            // Stretching
            case 3:
                let key = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1][indexPath.row] as! Int
                cell.imageView?.tag = key
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc...
                cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[SelectedSession.shared.selectedSession[0]][key]! as String, comment: "")
                //
                // Get index of element
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2]] = selected session, [1] = keys
                let indexSetsReps = (sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1] as! [Int]).index(of: key)
                //
                // Cell Image
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                cell.imageView?.image = getUncachedImage(named: (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]?[0])!)
                //
                // Breaths or Length
                // Timed session off
                if timedSession == 0 {
                    // Breaths
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] breaths array
                    cell.detailTextLabel?.text = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[2][indexSetsReps!] as? String
                } else {
                    // Length = [3]
                    cell.detailTextLabel?.text = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[3][indexSetsReps!] as? String
                }
                
            // Yoga
            case 4:
                let key = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[1][indexPath.row] as! Int
                cell.imageView?.tag = key
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc...
                cell.textLabel?.text = NSLocalizedString(sessionData.movementsDictionaries[SelectedSession.shared.selectedSession[0]][key]! as String, comment: "")
                //
                // Breaths
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = selected session, [2] breaths array
                cell.detailTextLabel?.text = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[2][indexPath.row] as? String
                //
                // Cell Image
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                //
                // Image
                // [key] = key, [0] = first image
                let image = getUncachedImage(named: (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]?[0])!)
                // If asymmetric array contains image, flip imageview
                if sessionData.asymmetricMovements[SelectedSession.shared.selectedSession[0]].contains(key) {
                    let flippedImage = UIImage(cgImage: (image?.cgImage!)!, scale: (image?.scale)!, orientation: .upMirrored)
                    cell.imageView?.image =  flippedImage
                } else {
                    cell.imageView?.image =  image
                }
                
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
            // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [1] = session sections, [1] keys
            let sessionKey = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][1][1]?[indexPath.section][indexPath.row] as! Int
            
            // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [sessionKey] = session, [0] titles, [0] title
            cell.textLabel?.text = "- " + NSLocalizedString(sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][sessionKey]?[0][0] as! String, comment: "") + " -"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.backgroundColor = Colours.colour1
            cell.textLabel?.textColor = Colours.colour2
            cell.tintColor = Colours.colour2
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
            // Set SelectedSession.shared.selectedSession[2] to selected session
            //
            // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [1] = sessions in sections, [1] session key array
            let selectedSessionKey: Int = sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][1][1]?[indexPath.section][indexPath.row] as! Int
            //
            SelectedSession.shared.selectedSession[2] = selectedSessionKey
            
            // Cardio Type
            if SelectedSession.shared.selectedSession[0] == 2 {
                cardioType = indexPath.section
            }
            
            // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [sessionKey] = session, [0] titles, [0] title
            presetsButton.setTitle("- " + NSLocalizedString(sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]?[0][0] as! String, comment: "") + " -", for: .normal)
            
            //
            presetsTableView.deselectRow(at: indexPath, animated: true)
            
            //
            // Dismiss Action Sheet
            ActionSheet.shared.animateActionSheetDown()

            //
            self.movementsTableView.reloadData()
            let indexPath2 = NSIndexPath(row: 0, section: 0)
            self.movementsTableView.scrollToRow(at: indexPath2 as IndexPath, at: .top, animated: true)
            //
            setConstraints(showingViews: true, animated: true)
            
        default: break
        }
        
        //
        // MARK: Walkthrough
        let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
        if walkthroughs["FinalChoice"] == false {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + AnimationTimes.animationTime3, execute: {
                self.walkthroughFinalChoice()
            })
        }
    }
    
    
    //
    // MARK: TableView Helpers -----------------------------------------------------------------------------------------------------------------
    //
    // Number of sections in movements tableview
    func numberOfSectionsMovements() -> Int {
        //
        switch SelectedSession.shared.selectedSession[0] {
        // Warmup, Cardio, Stretching, Yoga
        case 0,2,3,4:
            return 1
            
        // Workout
        case 1:
            switch SelectedSession.shared.selectedSession[1] {
            // Circuit Session
            case 7,8,9,13,14,15:
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = session, [2] = number of rounds array, [0] = number of rounds
                return sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]![2][0] as! Int
            // Normal Session
            default:
                return 1
            }
        //
        default:
            return 0
        }
    }
    
    // Title for header in movements tableview
    func titleForHeaderMovements(section: Int) -> String {
        //
        switch SelectedSession.shared.selectedSession[0] {
        // Warmup, Stretching
        case 0,3:
            return ""
            
        // Workout
        case 1:
            switch SelectedSession.shared.selectedSession[1] {
            // Circuit Session
            case 7,8,9,13,14,15:
                return NSLocalizedString("round", comment: "") + String(section + 1)  + NSLocalizedString("of", comment: "") + String(sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]![2][0] as! Int)
            // Normal Session
            default:
                return ""
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
        switch SelectedSession.shared.selectedSession[0] {
        // Warmup, Cardio, Stretching, Yoga
        case 0,2,3,4:
            return sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]![1].count
            
        // Workout
        case 1:
            switch SelectedSession.shared.selectedSession[1] {
            // Circuit Session
            case 7,8,9,13,14,15:
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = session, [1] = key array
                return (sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]![1] as! [Int]).count
            // Normal Session
            default:
                return sessionData.presetsDictionaries[SelectedSession.shared.selectedSession[0]][SelectedSession.shared.selectedSession[1]][0][SelectedSession.shared.selectedSession[2]]![1].count
            }
        //
        default:
            return 0
        }
    }
    
    
    //
    // MARK: Presets Button Action -----------------------------------------------------------------------------------------------------------------
    //
    @IBAction func presetsButtonAction(_ sender: Any) {
        ActionSheet.shared.animateActionSheetUp()
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
        let imageCount = (sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]!).count
        //
        // Image Array
        if imageCount != 1 && sender.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.demonstrationDictionaries[SelectedSession.shared.selectedSession[0]][key]![i])!)
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
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let timedSession = settings["TimeBasedSessions"]![0]
        //
        // Segue
        switch SelectedSession.shared.selectedSession[0] {
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
            switch SelectedSession.shared.selectedSession[1] {
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
    @objc func popToRootView() {
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
        switch segue.identifier {
        // Warmup / Stretching
        case "sessionSegueStretching"?:
            //
            let destinationVC = segue.destination as! StretchingScreen
            //
            destinationVC.fromSchedule = comingFromSchedule
        // Cardio
        case "sessionSegueCardio"?:
            //
            let destinationVC = segue.destination as! CardioScreen
            //
            destinationVC.sessionType = cardioType
            destinationVC.fromSchedule = comingFromSchedule
        // Workout
        case "sessionSegue"?:
            //
            let destinationVC = segue.destination as! SessionScreen
            //
            destinationVC.fromSchedule = comingFromSchedule
        // Yoga
        case "sessionSegueYoga"?:
            //
            let destinationVC = segue.destination as! YogaScreen
            //
            destinationVC.fromSchedule = comingFromSchedule
        default: break
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
    @objc func walkthroughFinalChoice() {
        
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
            walkthroughLabel.textColor = Colours.colour1
            walkthroughLabel.backgroundColor = Colours.colour2
            walkthroughHighlight.backgroundColor = Colours.colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colours.colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width / 2, height: 36)
            walkthroughHighlight.center = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.combinedHeight + (73.5 / 2))
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
            
            
        // Overview
        case 1:
            //
            highlightSize = CGSize(width: view.bounds.width, height: (view.bounds.height - 73.5 - 49))
            highlightCenter = CGPoint(x: (view.bounds.width / 2), y: TopBarHeights.combinedHeight + 73.5 + ((view.bounds.height - 73.5 - 49) / 2))
            highlightCornerRadius = 3
            //
            labelFrame = 1
            //
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
            highlightColor = Colours.colour2
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
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
            highlightColor = Colours.colour2
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
                var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                walkthroughs["FinalChoice"] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["walkthroughs"])
            })
        }
    }
    
    //
}

