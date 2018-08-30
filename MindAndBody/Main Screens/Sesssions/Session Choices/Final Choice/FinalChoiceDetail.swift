//
//  FinalChoiceDetail.swift
//  MindAndBody
//
//  Created by Luke Smith on 17.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


// Warmup Choice Class
class FinalChoiceDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Section Numbers (representing tableview section arrray, used to remove arrays with the arrays of arrays of keys, and to determine which sections are left)
    var sectionNumbers: [Int] = []
    
    // Cardio - time or distance
    var cardioType = 0
    
    // Coming from schedule, if coming from menu, hide presets button
    // && set title to presets title
    var comingFromSchedule = false    
    var selectedComponent = 0
    
    // MARK: Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    // Movements Table View
    @IBOutlet weak var movementsTableView: UITableView!
    
    // Navigation bar titles
    let navigationBarTitles: [String: String] = [
        "warmup": "warmup",
        "workout": "workout",
        "cardio": "cardio",
        "stretching": "stretching",
        "yoga": "yoga"]
    
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colour
        view.backgroundColor = UIColor(red:0.08, green:0.08, blue:0.08, alpha:1.0)
        
        // Navigation Bar Title
        // App chooses sessions - choice title
        let schedules = UserDefaults.standard.object(forKey: "schedules") as! [[String: [[[String: Any]]]]]
        // App chooses session
        if schedules[ScheduleVariables.shared.selectedSchedule]["scheduleInformation"]![0][0]["customSessionChoice"] as! Int == 0 {
            // Navigation
            var navTitle = String()
            switch selectedComponent {
            // Warmup
            case 0:
                navTitle = NSLocalizedString(ScheduleVariables.shared.selectedChoiceWarmup[0], comment: "") + ": " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceWarmup[1], comment: "") + ", " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceWarmup[2], comment: "")
                
            // Session
            case 1:
                navTitle = NSLocalizedString(ScheduleVariables.shared.selectedChoiceSession[0], comment: "") + ": " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceSession[1], comment: "") + ", " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceSession[2], comment: "")
                
                print(ScheduleVariables.shared.selectedChoiceSession)
            // Stretching
            case 2:
                navTitle = NSLocalizedString(ScheduleVariables.shared.selectedChoiceStretching[0], comment: "") + ": " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceStretching[1], comment: "") + ", " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceStretching[2], comment: "")
                
            default: break
            }
            navigationBar.title = navTitle
        // User chooses session - session title
        } else {
            navigationBar.title =
                NSLocalizedString(SelectedSession.shared.selectedSession[2], comment: "")
        }
        navigationController?.navigationBar.tintColor = Colors.light
        
        //
        movementsTableView.tableFooterView = UIView()
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = Colors.green
        beginButton.setTitleColor(Colors.dark, for: .normal)
        
        // TableView Backgrounds
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = Colors.light
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.movementsTableView.frame.size.width, height: self.movementsTableView.frame.size.height)
        //
        movementsTableView.backgroundView = tableViewBackground
    }
    
    // MARK: TableView -----------------------------------------------------------------------------------------------------------------------
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        if SelectedSession.shared.selectedSession[0] == "" {
            return 0
        } else {
            return numberOfSectionsMovements()
        }
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleForHeaderMovements(section: section)
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 19)!
        header.textLabel?.textColor = Colors.light
        header.contentView.backgroundColor = Colors.dark
        header.contentView.tintColor = Colors.light
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberOfRowsInSectionMovements(section: section)
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        // timed schedule sessions
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        let timedSession = settings["TimeBasedSessions"]![0]

        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        //
        cell.selectionStyle = .none
        
        //
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 20)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = Colors.light
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
        cell.layoutIfNeeded()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.widthAnchor.constraint(equalToConstant: 20)
        //
        return cell
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    // MARK: TableView Helpers
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
        // Rows
        if SelectedSession.shared.selectedSession[2] == "" {
            return 0
        } else {
            switch SelectedSession.shared.selectedSession[1] {
            case "bodyweight", "circuitGymFull", "circuitGymUpper", "circuitGymLower","circuitBodyweightFull", "circuitBodyweightUpper", "circuitBodyweightLower":
                let numberOfMovementsPerRound = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]!.count / (sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]![0]["rounds"] as! Int)
                return numberOfMovementsPerRound
            default:
                return sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]!.count
            }
        }
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
    
    // MARK: Begin Button
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
    
    
    // MARK: Cardio helpers
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

