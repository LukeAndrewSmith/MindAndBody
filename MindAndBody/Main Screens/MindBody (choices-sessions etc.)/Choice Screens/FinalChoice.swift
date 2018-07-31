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
    let scheduleTitleArray: [String: String] = [
        "warmup": "warmup",
        "workout": "workout",
        "cardio": "cardio",
        "stretching": "stretching",
        "yoga": "yoga"]
    
    let presetsButtonTitleDict = [
        "warmup": "selectWarmup",
        "workout": "selectWorkout",
        "cardio": "selectCardio",
        "stretching": "selectStretching",
        "yoga": "selectPractice"]
    
    
    
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
            navigationBar.title = (NSLocalizedString(sessionData.navigationTitles[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]! , comment: ""))
        } else {
            let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
            // App chooses session
            if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] as! Int == 0 {
                presetsButton.alpha = 0
                let sessionTypeString = NSLocalizedString(scheduleTitleArray[SelectedSession.shared.selectedSession[0]]!, comment: "")
                navigationBar.title = sessionTypeString + " - " + NSLocalizedString("overview", comment: "")
            // User chooses sessions
            } else {
                navigationBar.title = (NSLocalizedString(sessionData.navigationTitles[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]! , comment: ""))
                // Select nothing, user wants to select somthing
                SelectedSession.shared.selectedSession[2] = ""
            }
        }
        navigationController?.navigationBar.tintColor = Colors.light
        
        //
        presetsButton.backgroundColor = Colors.dark
        presetsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //
        movementsTableView.tableFooterView = UIView()
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = Colors.green
        beginButton.setTitleColor(Colors.dark, for: .normal)
        
        //
        // Initial Element Positions
        if SelectedSession.shared.selectedSession[2] == "" {
            setConstraints(showingViews: false, animated: false)
            presetsButton.setTitle("- " + NSLocalizedString("select", comment: "") + " " + NSLocalizedString(SelectedSession.shared.selectedSession[0], comment: "") + " -", for: .normal)
        //
        // Selected Automatically from schedule
        } else {
            // Cardio Type
            // If cardio
            if SelectedSession.shared.selectedSession[0] == "cardio" {
                // Time base (used to be an option for distance based, leaving in that option through this variable)
                cardioType = 0
            }

            // Set title
            presetsButton.setTitle("- " + NSLocalizedString(SelectedSession.shared.selectedSession[2], comment: "") + " -", for: .normal)

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
        tableViewBackground.backgroundColor = Colors.dark
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.movementsTableView.frame.size.width, height: self.movementsTableView.frame.size.height)
        //
        movementsTableView.backgroundView = tableViewBackground
        
        //
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = Colors.light
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.presetsTableView.frame.size.width, height: self.presetsTableView.frame.size.height)
        //
        presetsTableView.backgroundView = tableViewBackground2
        
        presetsTableView.tableFooterView = UIView()
        
        
        // Presets TableView
        //
        // Movement tabl
        presetsTableView.backgroundColor = Colors.dark
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        presetsTableView.layer.cornerRadius = 15
        presetsTableView.layer.masksToBounds = true
        presetsTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //
        presetsTableView.layer.borderColor = Colors.light.cgColor
        presetsTableView.layer.borderWidth = 1
        //
        let tableHeight = ActionSheet.shared.actionTableHeight - 49 - 20
        let tableWidth = ActionSheet.shared.actionWidth
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
        if SelectedSession.shared.selectedSession[2] == "" {
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
                let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
                // App chooses session
                if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] as! Int == 0 {
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
                self.presetsConstraint.constant = -ControlBarHeights.homeIndicatorHeight
            } else {
                self.presetsConstraint.constant = 0
            }
            //
            tableConstraint1.constant = view.frame.size.height
            tableConstraint.constant = -49 - ControlBarHeights.homeIndicatorHeight
            //
            beginConstraint.constant = -49 - ControlBarHeights.homeIndicatorHeight
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
            if SelectedSession.shared.selectedSession[0] == "" {
                return 0
            } else {
                return numberOfSectionsMovements()
            }
            
        case presetsTableView:
            // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [1] = sessions in sections, [0] section titles array
            let numberOfSections = (sessionData.sortedSessionsForFinalChoice[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]!).count
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
            return "  " + NSLocalizedString(sessionData.headerTitles[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![section], comment: "")
            
        default: break
        }
        return ""
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        switch tableView {
        case movementsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
            header.textLabel?.textColor = Colors.light
            header.contentView.backgroundColor = Colors.dark
            header.contentView.tintColor = Colors.light
        case presetsTableView:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
            header.textLabel?.textAlignment = .left
            header.textLabel?.textColor = Colors.light
            header.contentView.backgroundColor = Colors.dark
            header.contentView.tintColor = Colors.light
        default: break
        }
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case movementsTableView:
            return numberOfRowsInSectionMovements(section: section)
            
        case presetsTableView:
            return (sessionData.sortedSessionsForFinalChoice[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![section]).count
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
            cell.textLabel?.textColor = Colors.dark
            cell.tintColor = Colors.dark
            
            //
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 18)
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.textAlignment = .left
            cell.detailTextLabel?.textColor = Colors.dark
            
            cell.imageView?.isUserInteractionEnabled = true
            // Image Tap
            let imageTap = UITapGestureRecognizer()
            imageTap.numberOfTapsRequired = 1
            imageTap.addTarget(self, action: #selector(handleTap))
            cell.imageView?.addGestureRecognizer(imageTap)
            
            //
            // Fill Data
            switch SelectedSession.shared.selectedSession[0] {
            case "warmup":
                // Get key of movement
                let key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["movement"] as! String
                
                // Title
                cell.textLabel?.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0], comment: "")
                
                // Cell Image
                cell.imageView?.image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
                cell.imageView?.tag = indexPath.row
                
                // SetsxReps or Length of time
                // Timed session off
                if timedSession == 0 {
                    // Sets x Reps
                    cell.detailTextLabel?.text = String(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["sets"] as! Int) + " x " + (sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["reps"] as! String)
                // On
                } else {
                    // Length of time
                    cell.detailTextLabel?.text = String(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["time"] as! Int) + NSLocalizedString("s", comment: "")
                }
                
            case "workout":
                switch SelectedSession.shared.selectedSession[1] {
                // Circuit Session
                case "circuitGymFull", "circuitGymUpper", "circuitGymLower":
                    // Movement key
                    let key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["movement"] as! String
                    
                    // Title
                    cell.textLabel?.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0], comment: "")
                    
                    // Cell Image
                    cell.imageView?.image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
                    cell.imageView?.tag = indexPath.row
                    
                    // Reps
                    // Find n movements in round, * round to find the index for the reps (if round to, nMovements = 3, indexPAth.row == 1 then index = 1 + 3 = 4)
                    let numberOfRounds = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[0]["rounds"] as! Int
                    let totalMovements = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?.count
                    let nMovementsInRound = totalMovements! / numberOfRounds
                    let index = indexPath.row + (indexPath.section * nMovementsInRound)
                    cell.detailTextLabel?.text = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[index]["reps"] as? String
                    
                // Bodyweight Circuit Session (possibility of timed session)
                case "circuitBodyweightFull", "circuitBodyweightUpper", "circuitBodyweightLower":
                    // Movement key
                    let key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["movement"] as! String
                    
                    // Title
                    cell.textLabel?.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0], comment: "")
                    //
                    // Cell Image
                    cell.imageView?.image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
                    cell.imageView?.tag = indexPath.row

                    // Reps or Length
                    // Timed session off
                    if timedSession == 0 {
                        // Sets x Reps
                        cell.detailTextLabel?.text = String(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["reps"] as! String)
                        // On
                    } else {
                        // Length of time
                        cell.detailTextLabel?.text = String(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["time"] as! Int) + NSLocalizedString("s", comment: "")
                    }
                    
                // Normal Session
                default:
                    // Movement key
                    let key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["movement"] as! String
                    
                    // Title
                    cell.textLabel?.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0], comment: "")
                    
                    // Sets x Reps
                    cell.detailTextLabel?.text = String(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["sets"] as! Int) + " x " + (sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["reps"] as! String)
                    
                    // Cell Image
                    cell.imageView?.image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
                    cell.imageView?.tag = indexPath.row
                }
                
            case "cardio":
                // Bodyweight workouts for cardio are stored in cardio in sessions, but the movements are not duplicated into cardio in movements, therefore we need to access the workouts movements array
                if SelectedSession.shared.selectedSession[1] == "bodyweight" {
                    // Movement key
                    let key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["movement"] as! String
                    
                    // Title
                    cell.textLabel?.text = NSLocalizedString(sessionData.movements["workout"]![key]!["name"]![0], comment: "")
                    //
                    // Cell Image
                    cell.imageView?.image = getUncachedImage(named: (sessionData.movements["workout"]![key]?["demonstration"]![0])!)
                    cell.imageView?.tag = indexPath.row
                    
                    // Reps or Length
                    // Timed session off
                    if timedSession == 0 {
                        // Sets x Reps
                        cell.detailTextLabel?.text = String(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["reps"] as! String)
                        // On
                    } else {
                        // Length of time
                        cell.detailTextLabel?.text = String(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["time"] as! Int) + NSLocalizedString("s", comment: "")
                    }
                    
                // Timed HIIT Workout
                } else {
                    // Movement key
                    let key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["movement"] as! String
                    
                    // Title
                    cell.textLabel?.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0], comment: "")
                    
                    // Time
                    cell.detailTextLabel?.text = timeToString(totalSeconds: sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["time"] as! Int)

                    // Cell Image
                    cell.imageView?.image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
                }
                
            case "stretching":
                // Movement key
                let key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["movement"] as! String
                
                // Title
                cell.textLabel?.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0], comment: "")
                
                // Cell Image
                cell.imageView?.image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
                cell.imageView?.tag = indexPath.row
                
                // Breaths or Length
                // Timed session off
                if timedSession == 0 {
                    // Breaths
                    let breaths = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["breaths"] as? Int
                    cell.detailTextLabel?.text = String(breaths!) + " " + NSLocalizedString("breaths", comment: "")
                } else {
                    // Length = [3]
                    let breaths = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["time"] as? Int
                    cell.detailTextLabel?.text = String(breaths!) + " " + NSLocalizedString("breaths", comment: "")
                }
                
            case "yoga":
                // Movement key
                let key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["pose"] as! String
                cell.imageView?.tag = indexPath.row
                
                // Title
                print(SelectedSession.shared.selectedSession[0])
                cell.textLabel?.text = NSLocalizedString(sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["name"]![0], comment: "")
                
                // Breaths
                let breaths = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[indexPath.row]["breaths"] as? Int
                cell.detailTextLabel?.text = String(breaths!) + " " + NSLocalizedString("breaths", comment: "")
                
                //
                // Cell Image
                // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [overviewarray[indexPath.section][indexpath.row]] = key, [0] for the first image
                //
                // Image
                cell.imageView?.tag = indexPath.row
                let image = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]?["demonstration"]![0])!)
                // If asymmetric array contains image, flip imageview
                if (sessionData.asymmetricMovements[SelectedSession.shared.selectedSession[0]]?.contains(key))! {
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
            
            cell.textLabel?.text = NSLocalizedString(sessionData.sortedSessionsForFinalChoice[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![indexPath.section][indexPath.row], comment: "")
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.backgroundColor = Colors.light
            cell.textLabel?.textColor = Colors.dark
            cell.tintColor = Colors.dark
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
            let selectedSessionKey: String = sessionData.sortedSessionsForFinalChoice[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![indexPath.section][indexPath.row]
            //
            SelectedSession.shared.selectedSession[2] = selectedSessionKey
            
            // Cardio Type
            if SelectedSession.shared.selectedSession[0] == "cardio" {
                cardioType = indexPath.section
            }
            
            // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [sessionKey] = session, [0] titles, [0] title
            presetsButton.setTitle("- " + NSLocalizedString(SelectedSession.shared.selectedSession[2], comment: "") + " -", for: .normal)

            
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
    }
    
    
    //
    // MARK: TableView Helpers -----------------------------------------------------------------------------------------------------------------
    //
    // Number of sections in movements tableview
    func numberOfSectionsMovements() -> Int {
        //
        if SelectedSession.shared.selectedSession[2] == "" {
            return 0
        } else {
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup, Cardio, Stretching, Yoga
            case "warmup", "cardio", "stretching", "yoga":
                // Cardio - Bodyweight workout
                if SelectedSession.shared.selectedSession[1] == "bodyweight" {
                    return sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]![0]["rounds"] as! Int
                } else {
                    return 1
                }
                
            // Workout
            case "workout":
                switch SelectedSession.shared.selectedSession[1] {
                // Circuit Session
                case "circuitGymFull", "circuitGymUpper", "circuitGymLower","circuitBodyweightFull", "circuitBodyweightUpper", "circuitBodyweightLower", "bodyweight":
                    // Number of rounds
                    return sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]![0]["rounds"] as! Int
                // Normal Session
                default:
                    return 1
                }
            //
            default:
                return 0
            }
        }
    }
    
    // Title for header in movements tableview
    func titleForHeaderMovements(section: Int) -> String {
        //
        switch SelectedSession.shared.selectedSession[0] {
        // Warmup, Stretching
        case "warmup", "stretching":
            return ""
            
        // Workout
        case "workout":
            switch SelectedSession.shared.selectedSession[1] {
            // Circuit Session
            case "circuitGymFull", "circuitGymUpper", "circuitGymLower","circuitBodyweightFull", "circuitBodyweightUpper", "circuitBodyweightLower":
                return NSLocalizedString("round", comment: "") + String(section + 1)  + NSLocalizedString("of", comment: "") + String(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]![0]["rounds"] as! Int)
            // Normal Session
            default:
                return ""
            }
            
        // Cardio, Yoga
        case "cardio", "yoga":
            if SelectedSession.shared.selectedSession[1] == "bodyweight" {
                return NSLocalizedString("round", comment: "") + String(section + 1)  + NSLocalizedString("of", comment: "") + String(sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]![0]["rounds"] as! Int)
            } else {
                return ""
            }
            
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
        case "warmup", "cardio", "stretching", "yoga":
            // Rows
            if SelectedSession.shared.selectedSession[2] == "" {
                return 0
            } else {
                if SelectedSession.shared.selectedSession[1] == "bodyweight" {
                    let numberOfMovementsPerRound = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]!.count / (sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]![0]["rounds"] as! Int)
                    return numberOfMovementsPerRound
                } else {
                    return sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]!.count
                }
            }
            
        // Workout
        case "workout":
            // Rows
            if SelectedSession.shared.selectedSession[2] == "" {
                return 0
            //
            } else {
                switch SelectedSession.shared.selectedSession[1] {
                // Circuit Session
                case "circuitGymFull", "circuitGymUpper", "circuitGymLower","circuitBodyweightFull", "circuitBodyweightUpper", "circuitBodyweightLower":
                    // [SelectedSession.shared.selectedSession[0]] = warmup/workout/cardio etc..., [SelectedSession.shared.selectedSession[1]] = fullbody/upperbody etc..., [0] = sessions, [SelectedSession.shared.selectedSession[2] = session, [1] = key array
                    let numberOfMovementsPerRound = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]!.count / (sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]![0]["rounds"] as! Int)
                    return numberOfMovementsPerRound
                // Normal Session
                default:
                    return sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]!.count
                }
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
        // indexing with sender.tag == indexPath.row
        // MARK: NINA
        print(SelectedSession.shared.selectedSession[0])
        var key = String()
        // Movement == pose in yoga
        if SelectedSession.shared.selectedSession[0] == "yoga" {
            key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[sender.tag]["pose"] as! String
        // Movement = movement
        } else {
            key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]?[sender.tag]["movement"] as! String
        }
        //
        let imageCount = ((sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"])?.count)!
        //
        // Image Array
        if imageCount != 1 && sender.isAnimating == false {
            var animationArray: [UIImage] = []
            for i in 1...imageCount - 1 {
                animationArray.append(getUncachedImage(named: sessionData.movements[SelectedSession.shared.selectedSession[0]]![key]!["demonstration"]![i])!)
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
        case "warmup":
            // Timed Session off
            if timedSession == 0 {
                // Warmup uses stretching Screen
                performSegue(withIdentifier: "sessionSegueStretching", sender: self)
                // Timed Session on
            } else {
                performSegue(withIdentifier: "sessionSegueTimeBased", sender: self)
            }
        // Workout
        case "workout":
            switch SelectedSession.shared.selectedSession[1] {
            // Circuit Session
            case "circuitGymFull", "circuitGymUpper", "circuitGymLower":
                performSegue(withIdentifier: "sessionSegueCircuit", sender: self)
            // Bodyweight Circuit Session
            case "circuitBodyweightFull", "circuitBodyweightUpper", "circuitBodyweightLower":
                // Timed Session off
                if timedSession == 0 {
                    performSegue(withIdentifier: "sessionSegueCircuit", sender: self)
                    // Timed Session On
                } else {
                    performSegue(withIdentifier: "sessionSegueTimeBased", sender: self)
                }
            // Bodyweight classic (has option for timed sessions)
            case "classicBodyweightFull", "classicBodyweightUpper", "classicBodyweightLower":
                // Timed Session off
                if timedSession == 0 {
                    performSegue(withIdentifier: "sessionSegue", sender: self)
                    // Timed Session On
                } else {
                    performSegue(withIdentifier: "sessionSegueTimeBased", sender: self)
                }
            // Normal Session (classic gym, not timed sessions)
            default:
                performSegue(withIdentifier: "sessionSegue", sender: self)
            }
        // Cardio
        case "cardio":
            // Bodyweight circuit workout
            if SelectedSession.shared.selectedSession[1] == "bodyweight" {
                // Timed Session off
                if timedSession == 0 {
                    performSegue(withIdentifier: "sessionSegueCircuit", sender: self)
                    // Timed Session On
                } else {
                    performSegue(withIdentifier: "sessionSegueTimeBased", sender: self)
                }
                
            // HIIT Cardio
            } else {
                performSegue(withIdentifier: "sessionSegueCardio", sender: self)
            }
        // Stretching
        case "stretching":
            // Timed Session off
            if timedSession == 0 {
                performSegue(withIdentifier: "sessionSegueStretching", sender: self)
                // Timed Session on
            } else {
                performSegue(withIdentifier: "sessionSegueTimeBased", sender: self)
            }
        // Yoga
        case "yoga":
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
        // Circuit
        case "sessionSegueCircuit"?:
            //
            let destinationVC = segue.destination as! CircuitWorkoutScreen
            //
            destinationVC.fromSchedule = comingFromSchedule
        // Time based
        case "sessionSegueTimeBased"?:
            //
            let destinationVC = segue.destination as! TimeBasedScreen
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
}

