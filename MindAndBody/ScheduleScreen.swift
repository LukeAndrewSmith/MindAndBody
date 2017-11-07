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
    // Variablesclass
    //
    // Schedule Animation Helpers
    let mask = CAGradientLayer()
    let maskView1 = UIButton() // top
    let maskView2 = UIButton() // bottom
    let maskView3 = UIView() // Middle (rounded corners
    let maskViewBackButton = UIImageView()
    
    var daySwipeLeft = UISwipeGestureRecognizer()
    var daySwipeRight = UISwipeGestureRecognizer()
    
    //
    // Schedule
    
    //
    // Selected Choices
    // Selected choices corrensponds to an array in 'sortedSession' containing (easy, medium, hard) of relevant selection to be chosen by the app based on the profile (arrays containing difficulty level for each group to select)
    // 3 seperate arrays because arrays do not quite correspond in terms of accessing relevant sessions for a number of reasons; not a mistake
    // check sortedSessions array in dataStructures to understand indexing, each session has the corresponding index written above it
    var selectedChoiceWarmup = [0,0,0,0,0,0]
    var selectedChoiceSession = [0,0,0,0,0,0]
    var selectedChoiceStretching = [0,0,0,0,0,0]
    
    //
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // TableView
    @IBOutlet weak var scheduleTable: UITableView!
    @IBOutlet weak var scheduleTableBottom: NSLayoutConstraint!
    @IBOutlet weak var pageStack: UIStackView!
    // Background Image
    @IBOutlet weak var backgroundImage: UIImageView!
    let backgroundBlur = UIVisualEffectView()
    
    
    // MARK: -
    //
    // Variables
    // Days array
    let dayArray: [String] =
        ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday",]
    let dayArrayChar = ["mondayLetter","tuesdayLetter","wednesdayLetter","thursdayLetter","fridayLetter","saturdayLetter","sundayLetter"]
    // StackView
    var stackArray: [UILabel] = []
    
    // Schedule creation and choices ACTION SHEET
    let actionSheet = UIView()
    let scheduleChoiceTable = UITableView()
    let editScheduleButton = UIButton()
    let editProfileButton = UIButton()
    let backgroundViewExpanded = UIButton()
    //
    var selectedSchedule = 0
    
    //
    // Very silly variable used in choices of endurance, steady state, as 'time choice' after 'warmup/stretching' choice, variable tell which one was selected
    var steadyStateChoice = Int()
    
    // IMPORTANT VARIABLE
    // Variable saying which presentation style is wanted by the user, either
    // 0 - presenting each day on the day
    // 0 - presenting the whole week each week
    var scheduleStyle = 0
    
    //
    // View Will Appear ---------------------------------------------------------------------------------
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // RELOAD VIEW
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        if ScheduleVariables.shared.shouldReloadSchedule == true {
            ScheduleVariables.shared.shouldReloadSchedule = false
            let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            if schedules.count != 0 {
                scheduleStyle = schedules[selectedSchedule][9][0] as! Int
            } else {
                scheduleStyle = 0
            }
            selectedSchedule = settings[7][0]
            layoutViews()
            // If day view enable swipes
            if schedules.count != 0 {
                if schedules[selectedSchedule][9][0] as! Int == 0 {
                    daySwipeLeft.isEnabled = true
                    daySwipeRight.isEnabled = true
                    // Else if week view disable swipes
                } else if schedules[selectedSchedule][9][0] as! Int == 1 {
                    daySwipeLeft.isEnabled = false
                    daySwipeRight.isEnabled = false
                }
            }
            
            scheduleTable.reloadData()
            scheduleChoiceTable.reloadData()
            //
            scheduleTableScrollCheck()
        }
    }
    
    
    //
    // MARK: View did appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Reload choice
        // MARK AS COMPLETED
        if ScheduleVariables.shared.shouldReloadChoice == true && ScheduleVariables.shared.selectedRows[1] != 72 {
            var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
            scheduleTracking[self.selectedSchedule][ScheduleVariables.shared.selectedDay][ScheduleVariables.shared.selectedRows[0]][0][0] = true
            UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
            //
            DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                let indexPathToReload = NSIndexPath(row: ScheduleVariables.shared.selectedRows[1] + 1, section: 0)
                self.scheduleTable.reloadRows(at: [indexPathToReload as IndexPath], with: .automatic)
                self.scheduleTable.selectRow(at: indexPathToReload as IndexPath, animated: true, scrollPosition: .none)
                self.scheduleTable.deselectRow(at: indexPathToReload as IndexPath, animated: true)
                //
                // Check if group is completed for the day
                if self.isGroupCompleted() == true {
                    UIView.animate(withDuration: AnimationTimes.animationTime1, animations: {
                        self.maskView3.backgroundColor = Colours.colour3
                        // Slide back to initial choice when completed
                    }, completion: { finished in
                        DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTimes.animationTime2, execute: {
                            ScheduleVariables.shared.choiceProgress[1] = 1
                            self.maskAction()
                            // Set to false here so the tick doesn;t get loaded before the view has appeared
                            ScheduleVariables.shared.shouldReloadChoice = false
                            // Animate initial choice group completion after slideRight() animation finished
                            let toAdd = AnimationTimes.animationTime1 + AnimationTimes.animationTime2
                            DispatchQueue.main.asyncAfter(deadline: .now() + toAdd, execute: {
                                let indexPathToReload2 = NSIndexPath(row: ScheduleVariables.shared.selectedRows[0], section: 0)
                                self.scheduleTable.reloadRows(at: [indexPathToReload2 as IndexPath], with: .automatic)
                                self.scheduleTable.selectRow(at: indexPathToReload2 as IndexPath, animated: true, scrollPosition: .none)
                                self.scheduleTable.deselectRow(at: indexPathToReload2 as IndexPath, animated: true)
                            })
                        })
                    })
                }
            })
            //
            updateDayIndicatorColours()
            // Meditation/Walk
        } else if ScheduleVariables.shared.shouldReloadChoice == true && ScheduleVariables.shared.selectedRows[1] == 72 {
            //
            // Go to initial choice
            ScheduleVariables.shared.choiceProgress[1] = 1
            maskAction()
            //
            // Update
            var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
            scheduleTracking[self.selectedSchedule][ScheduleVariables.shared.selectedDay][ScheduleVariables.shared.selectedRows[0]][0][0] = true
            UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
            // Set to false here so the tick doesn't get loaded before the view has appeared
            ScheduleVariables.shared.shouldReloadChoice = false
            // Animate initial choice group completion after slideRight() animation finished
            let toAdd = AnimationTimes.animationTime1 + AnimationTimes.animationTime2
            DispatchQueue.main.asyncAfter(deadline: .now() + toAdd, execute: {
                let indexPathToReload2 = NSIndexPath(row: ScheduleVariables.shared.selectedRows[0], section: 0)
                self.scheduleTable.reloadRows(at: [indexPathToReload2 as IndexPath], with: .automatic)
                self.scheduleTable.selectRow(at: indexPathToReload2 as IndexPath, animated: true, scrollPosition: .none)
                self.scheduleTable.deselectRow(at: indexPathToReload2 as IndexPath, animated: true)
            })
            updateDayIndicatorColours()
        }
    }
    
    
    //
    // View did load --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        layoutViews()
        
        //
        // Initial info screen
        // if initialInfoHasBeenPresented == false {
        // initialInfoHasBeenPresented == true
        // Save initialInfoHasBeenPresented to userDefaults
        self.performSegue(withIdentifier: "InitialInfoSegue", sender: self)
        // }
        
        // Set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
        
        //
        // Present schedule walkthrough
        let walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
        if walkthroughs[5] == false {
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
        
        
        // ACTION SHEET
        actionSheet.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        actionSheet.layer.cornerRadius = 15
        actionSheet.clipsToBounds = true
        let height = CGFloat((147 + 49) + 49 + 49 + (20 * 2))
        // table    // buttons // spaces
        actionSheet.frame.size = CGSize(width: view.bounds.width - 20, height: height)
        // Schedule choice
        scheduleChoiceTable.backgroundColor = Colours.colour2
        scheduleChoiceTable.delegate = self
        scheduleChoiceTable.dataSource = self
        scheduleChoiceTable.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 20, height: 147 + 49)
        scheduleChoiceTable.tableFooterView = UIView()
        scheduleChoiceTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scheduleChoiceTable.layer.cornerRadius = 15
        scheduleChoiceTable.clipsToBounds = true
        scheduleChoiceTable.layer.borderWidth = 1
        scheduleChoiceTable.layer.borderColor = Colours.colour1.cgColor
        // Edit schedule
        editScheduleButton.addTarget(self, action: #selector(editScheduleAction), for: .touchUpInside)
        editScheduleButton.setTitle(NSLocalizedString("editSchedule", comment: ""), for: .normal)
        editScheduleButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        editScheduleButton.frame = CGRect(x: 0, y: (147 + 49) + 20, width: view.bounds.width - 20, height: 49)
        editScheduleButton.layer.cornerRadius = 49 / 2
        editScheduleButton.clipsToBounds = true
        editScheduleButton.setTitleColor(Colours.colour2, for: .normal)
        editScheduleButton.backgroundColor = Colours.colour1
        editScheduleButton.setImage(#imageLiteral(resourceName: "Calendar"), for: .normal)
        editScheduleButton.tintColor = Colours.colour2
        // Edit profile
        editProfileButton.addTarget(self, action: #selector(editProfileAction), for: .touchUpInside)
        editProfileButton.setTitle(NSLocalizedString("editProfile", comment: ""), for: .normal)
        editProfileButton.titleLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)
        editProfileButton.frame = CGRect(x: 0, y: (147 + 49) + 20 + 49 + 20, width: view.bounds.width - 20, height: 49)
        editProfileButton.layer.cornerRadius = 49 / 2
        editProfileButton.clipsToBounds = true
        editProfileButton.setTitleColor(Colours.colour2, for: .normal)
        editProfileButton.backgroundColor = Colours.colour1
        editProfileButton.setImage(#imageLiteral(resourceName: "Profile"), for: .normal)
        editProfileButton.tintColor = Colours.colour2
        //
        actionSheet.addSubview(scheduleChoiceTable)
        actionSheet.addSubview(editScheduleButton)
        actionSheet.addSubview(editProfileButton)
        //
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //
        
        
        //
        // Background Image
        backgroundImage.frame = view.bounds
        
        // Background Index
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        //
        // Background Image/Colour
        //
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            //
            backgroundImage.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
            //
            backgroundImage.image = nil
            backgroundImage.backgroundColor = Colours.colour1
        }
        
        //
        // BackgroundBlur/Vibrancy
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        //
        backgroundBlur.frame = backgroundImage.bounds
        //
        if backgroundIndex > BackgroundImages.backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImage)
        }
        
        //
        // Navigation Bar
        self.navigationController?.navigationBar.barTintColor = Colours.colour2
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        // Navigation Title
        navigationBar.title = NSLocalizedString("Mind & Body", comment: "")
        
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
        
        // Swipe
        let rightSwipe = UIScreenEdgePanGestureRecognizer()
        rightSwipe.edges = .left
        rightSwipe.addTarget(self, action: #selector(edgeGestureRight))
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    func layoutViews() {
        // Check wether to present the schedule as :
        // Days
        // The whole week
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        selectedSchedule = settings[7][0]
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        if schedules.count != 0 {
            scheduleStyle = schedules[selectedSchedule][9][0] as! Int
        } else {
            scheduleStyle = 0
        }
        //
        // Present as days or as week
        // days
        if scheduleStyle == 0 {
            scheduleTableBottom.constant = 24.5
            pageStack.isUserInteractionEnabled = true
            // week
        } else if scheduleStyle == 1 {
            scheduleTableBottom.constant = 0
            pageStack.isUserInteractionEnabled = false
        }
        
        // Set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
        
        //
        // Custom 'Page Control' m,t,w,t,f,s,s for bottom
        // If week is being presented as days, style 1
        if scheduleStyle == 0 && pageStack.arrangedSubviews.count == 0 {
            
            for i in 0...(dayArray.count - 1) {
                let dayLabel = UILabel()
                dayLabel.textColor = Colours.colour1
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
            for i in 0...stackArray.count - 1 {
                pageStack.addArrangedSubview(stackArray[i])
            }
            pageStack.isUserInteractionEnabled = true
            //
            
            //
            // Day Swipes
            daySwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            daySwipeLeft.direction = UISwipeGestureRecognizerDirection.left
            view.addGestureRecognizer(daySwipeLeft)
            //
            daySwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            daySwipeRight.direction = UISwipeGestureRecognizerDirection.right
            view.addGestureRecognizer(daySwipeRight)
        }
        
        //
        // Select Today
        // Get current day as index, currentWeekDay - 1 as week starts at 0 in array
        if scheduleStyle == 0 {
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                ScheduleVariables.shared.selectedDay = Date().currentWeekDayFromMonday - 1
                stackArray[ScheduleVariables.shared.selectedDay].alpha = 1
            } else {
                stackArray[ScheduleVariables.shared.selectedDay].alpha = 1
                maskView()
            }
        } else {
            // 7 is the full week array
            ScheduleVariables.shared.selectedDay = 7
        }
        
        //
        updateDayIndicatorColours()
        
        //
        scheduleTableScrollCheck()
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
            // day
            if scheduleStyle == 0 {
                return NSLocalizedString(dayArray[ScheduleVariables.shared.selectedDay], comment: "")
                // week
            } else {
                let weekOfThe = NSLocalizedString("weekOfThe", comment: "")
                // Date formatters
                let df = DateFormatter()
                df.dateFormat = "dd"
                let firstMonday = df.string(from: Date().firstMondayInCurrentWeek)
                let firstMondayInt = Int(firstMonday)
                //
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .ordinal
                let firstMondayWithOrdinal = numberFormatter.string(from: firstMondayInt! as NSNumber)
                //
                return weekOfThe + firstMondayWithOrdinal!
            }
        case scheduleChoiceTable:
            return NSLocalizedString("chooseCreateSchedule", comment: "")
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
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 30)!
            header.textLabel?.textAlignment = .center
            header.textLabel?.textColor = Colours.colour1
            
            //
            header.backgroundColor = .clear
            header.backgroundView = UIView()
            
            //
            // Seperator
            seperator.frame = CGRect(x: 27, y: header.bounds.height - 1, width: view.bounds.width - 54, height: 1)
            seperator.backgroundColor = Colours.colour1.cgColor
            seperator.opacity = 0.5
            header.layer.addSublayer(seperator)
        case scheduleChoiceTable:
            // Header
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
            header.textLabel?.textAlignment = .center
            header.textLabel?.textColor = Colours.colour2
            //
            let background = UIView()
            background.frame = header.bounds
            background.backgroundColor = Colours.colour1
            header.backgroundView = background
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
            // day
            //            if scheduleStyle == 0 {
            return (view.bounds.height - 24.5) / 4
            // week
            //            } else if scheduleStyle == 1 {
            //                return view.bounds.height / 4
        //            }
        case scheduleChoiceTable:
            return 47
        default:
            return 0
        }
    }
    
    // Rows
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        //
        switch tableView {
        case scheduleTable:
            // First Screen, showing groups
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                if schedules.count != 0 {
                    return schedules[selectedSchedule][ScheduleVariables.shared.selectedDay].count
                } else {
                    return 0
                }
                // TODO: return schedules[selectedSchedule][ScheduleVariables.shared.selectedDay].count
                // TODO: replay schedules[selectedSchedule] ([0]) with variable selectedSchedule indicating the selected schedule
                // Selecting a session
            } else {
                return sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]].count
            }
        case scheduleChoiceTable:
            return schedules.count + 1
        default:
            return 0
        }
        //
    }
    
    // Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case scheduleTable:
            if scheduleStyle == 1 && ScheduleVariables.shared.choiceProgress[0] == -1 {
                return 49
            } else {
                return 72
            }
        case scheduleChoiceTable:
            return 47
        default:
            return 0
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Note: accessing title so cast as any
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        
        // Get cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //
        switch tableView {
        case scheduleTable:
            // Long tap; ability to mark session as complete
            let markAsCompletedGesture = UILongPressGestureRecognizer()
            cell.tag = indexPath.row
            markAsCompletedGesture.addTarget(self, action: #selector(markAsCompleted))
            cell.addGestureRecognizer(markAsCompletedGesture)
            
            
            // First Screen, showing groups
            if ScheduleVariables.shared.choiceProgress[0] == -1 {
                // Groups
                let dayLabel = UILabel()
                dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
                dayLabel.textColor = Colours.colour1
                //
                // TODO: SCHEDULES NOT schedules[selectedSchedule]
                let text = sessionData.sortedGroups[schedules[selectedSchedule][ScheduleVariables.shared.selectedDay][indexPath.row] as! Int]![0][0]
                
                dayLabel.text = NSLocalizedString(text, comment: "")
                dayLabel.numberOfLines = 2
                dayLabel.sizeToFit()
                if scheduleStyle == 1 && ScheduleVariables.shared.choiceProgress[0] == -1 {
                    dayLabel.frame = CGRect(x: 27, y: 0, width: view.bounds.width - 54, height: 49)
                } else {
                    dayLabel.frame = CGRect(x: 27, y: 0, width: view.bounds.width - 54, height: 72)
                }
                cell.addSubview(dayLabel)
                //
                // CheckMark if completed
                if ScheduleVariables.shared.shouldReloadChoice == true {
                    if indexPath.row != ScheduleVariables.shared.selectedRows[0] {
                        if isCompleted(row: indexPath.row) == true {
                            dayLabel.textColor = Colours.colour3
                            cell.tintColor = Colours.colour3
                            cell.accessoryType = .checkmark
                        }
                    }
                } else if isCompleted(row: indexPath.row) == true {
                    dayLabel.textColor = Colours.colour3
                    cell.tintColor = Colours.colour3
                    cell.accessoryType = .checkmark
                }
                
            // Currently selecting a session, i.e not first screen
            } else {
                // If title
                if indexPath.row == 0 {
                    let title = sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]][0]
                    cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 24)!
                    cell.textLabel?.textColor = Colours.colour1
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
                    seperator.backgroundColor = Colours.colour1.cgColor
                    seperator.opacity = 0.25
                    cell.layer.addSublayer(seperator)
                    //
                    // Color if last choice
                    if isLastChoice() == true {
                        cell.textLabel?.textColor = Colours.colour3
                        seperator.backgroundColor = Colours.colour3.cgColor
                    }
                    // Else if selection
                } else {
                    //
                    let choiceLabel = UILabel()
                    choiceLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)!
                    choiceLabel.textColor = Colours.colour1
                    //
                    // Normal
                    //
                    // BORDER TEST
                    //                    if isLastChoice() == false {
                    let text = sessionData.sortedGroups[ScheduleVariables.shared.choiceProgress[0]]![ScheduleVariables.shared.choiceProgress[1]][indexPath.row]
                    choiceLabel.text = NSLocalizedString(text, comment: "")
                    // Last Choice, indicator by color border round the outside, red when incomplete, green when complete
                    //                    } else {
                    // insert border
                    // PROBABLY SHOULDN'T BE DONE HERE, BUT IN NEXT CHOICE FUNCTION
                    //                    }
                    //
                    choiceLabel.numberOfLines = 2
                    choiceLabel.sizeToFit()
                    choiceLabel.frame = CGRect(x: 27, y: 0, width: view.bounds.width - 54, height: 72)
                    cell.addSubview(choiceLabel)
                    
                    //
                    if isLastChoice() == true {
                        //
                        // CheckMark if completed
                        // - 1 as title included, so rows offset by 1
                        if indexPath.row != 0 {
                            if isCompleted(row: indexPath.row - 1) == true {
                                choiceLabel.textColor = Colours.colour3
                                cell.tintColor = Colours.colour3
                                cell.accessoryType = .checkmark
                            }
                        }
                    }
                }
            }
            
        //
        case scheduleChoiceTable:
            let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            //
            switch indexPath.row {
            case schedules.count:
                cell.imageView?.image = #imageLiteral(resourceName: "Plus")
                cell.tintColor = Colours.colour1
                //
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1)
                cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1)
            default:
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
                cell.textLabel?.textAlignment = .left
                cell.textLabel?.textColor = Colours.colour1
                if indexPath.row == settings[7][0] {
                    cell.accessoryType = .checkmark
                    cell.tintColor = Colours.colour3
                }
                cell.textLabel?.text = NSLocalizedString(schedules[indexPath.row][8][0] as! String, comment: "")
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
    
    //
    var okAction = UIAlertAction()
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        //
        switch tableView {
        case scheduleTable:
            //
            // If ScheduleVariables.shared.choiceProgress[0] = -1
            if ScheduleVariables.shared.choiceProgress[0] != -1 && indexPath.row == 0 {
                
            } else {
                //
                // If completed, do nothing
                if isLastChoice() == false && isCompleted(row: indexPath.row) == false {
                    didSelectRowHandler(row: indexPath.row)
                } else if isLastChoice() == true && isCompleted(row: indexPath.row - 1) == false {
                    didSelectRowHandler(row: indexPath.row)
                }
                //
                tableView.deselectRow(at: indexPath, animated: true)
            }
            
        case scheduleChoiceTable:
            var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
            var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
            // Creat new schedule
            if indexPath.row == schedules.count {
                // Present title option
                let snapShot1 = actionSheet.snapshotView(afterScreenUpdates: false)
                snapShot1?.center.x = view.center.x
                snapShot1?.center.y = actionSheet.center.y - UIApplication.shared.statusBarFrame.height - (navigationController?.navigationBar.frame.size.height)!
                view.addSubview(snapShot1!)
                self.actionSheet.isHidden = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundViewExpanded.alpha = 0
                }, completion: { finished in
                    self.backgroundViewExpanded.isHidden = true
                })
                
                // Alert and Functions
                //
                let inputTitle = NSLocalizedString("scheduleInputTitle", comment: "")
                //
                let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
                alert.view.tintColor = Colours.colour2
                alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-light", size: 22)!]), forKey: "attributedTitle")
                //2. Add the text field
                alert.addTextField { (textField: UITextField) in
                    textField.text = " "
                    textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
                    textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
                }
                // 3. Get the value from the text field, and perform actions upon OK press
                okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    //
                    // Append new schedule array to schedules
                    schedules.append(scheduleDataStructures.emptyWeek)
                    scheduleTracking.append(scheduleDataStructures.emptyTrackingWeek)
                    //
                    // Update Title
                    let textField = alert?.textFields![0]
                    let lastIndex = schedules.count - 1
                    schedules[lastIndex][8][0] = textField?.text!
                    //
                    // SET NEW ARRAY
                    UserDefaults.standard.set(schedules, forKey: "schedules")
                    UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
                    //
                    // Select new session and dismiss
                    let selectedIndexPath = NSIndexPath(row: lastIndex, section: 0)
                    self.scheduleChoiceTable.selectRow(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
                    settings[7][0] = lastIndex
                    self.selectedSchedule = lastIndex
                    self.scheduleStyle = schedules[self.selectedSchedule][9][0] as! Int
                    UserDefaults.standard.set(settings, forKey: "userSettings")
                    //
                    self.actionSheet.isHidden = false
                    snapShot1?.removeFromSuperview()
                    self.backgroundViewExpanded.isHidden = false
                    //
                    UIView.animate(withDuration: 0.1, animations: {
                        self.backgroundViewExpanded.alpha = 0.5
                        self.scheduleChoiceTable.reloadData()
                        self.scheduleTable.reloadData()
                        // Dismiss and select new row
                    }, completion: { finished in
                        // Dismiss action sheet
                        let height = CGFloat((147 + 49) + 49 + 49 + (20 * 2))
                        self.animateActionSheetDown(actionSheet: self.actionSheet, actionSheetHeight: height, backgroundView: self.backgroundViewExpanded)
                        //
                        self.performSegue(withIdentifier: "ScheduleCreationSegue", sender: self)
                    })
                })
                okAction.isEnabled = false
                alert.addAction(okAction)
                // Cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    //
                    self.backgroundViewExpanded.isHidden = false
                    UIView.animate(withDuration: 0.1, animations: {
                        self.backgroundViewExpanded.alpha = 0.5
                    })
                    //
                    self.actionSheet.isHidden = false
                    snapShot1?.removeFromSuperview()
                }
                alert.addAction(cancelAction)
                // 4. Present the alert.
                self.present(alert, animated: true, completion: nil)
                //
                // Select schedule
            } else {
                // Select new schedule in user settings
                settings[7][0] = indexPath.row
                selectedSchedule = indexPath.row
                scheduleStyle = schedules[selectedSchedule][9][0] as! Int
                UserDefaults.standard.set(settings, forKey: "userSettings")
                // Reload table
                layoutViews()
                scheduleChoiceTable.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                    self.scheduleTable.reloadData()
                    // Dismiss action sheet
                    let height = CGFloat((147 + 49) + 49 + 49 + (20 * 2))
                    self.animateActionSheetDown(actionSheet: self.actionSheet, actionSheetHeight: height, backgroundView: self.backgroundViewExpanded)
                    //
                })
            }
            tableView.deselectRow(at: indexPath, animated: true)
            
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // Enable ok alert action func
    @objc func textChanged(_ sender: UITextField) {
        if sender.text == "" {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    
    // Delete
    //
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        if tableView == scheduleTable {
            return false
        } else if tableView == scheduleChoiceTable {
            if indexPath.row != schedules.count {
                return true
            }
        }
        return false
    }
    
    // Commit editing style
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        var scheduleTracking = UserDefaults.standard.array(forKey: "scheduleTracking") as! [[[[[Bool]]]]]
        //
        // Delete if not plus row
        if editingStyle == UITableViewCellEditingStyle.delete {
            // Update arrays
            schedules.remove(at: indexPath.row)
            scheduleTracking.remove(at: indexPath.row)
            UserDefaults.standard.set(schedules, forKey: "schedules")
            UserDefaults.standard.set(scheduleTracking, forKey: "scheduleTracking")
            
            // Select app schedule
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            settings[7][0] = 0
            selectedSchedule = 0
            UserDefaults.standard.set(settings, forKey: "userSettings")
            scheduleTable.reloadData()
            
            //
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    
    
    //
    // Schedule Selection ---------------------------------------------------------------------------------------------------------------------
    
    // Edit Schedule
    @objc func editScheduleAction() {
        let schedules = UserDefaults.standard.array(forKey: "schedules") as! [[[Any]]]
        //
        let height = CGFloat((147 + 49) + 49 + 49 + (20 * 2))
        animateActionSheetDown(actionSheet: actionSheet, actionSheetHeight: height, backgroundView: backgroundViewExpanded)
        //
        if schedules.count != 0 {
            self.performSegue(withIdentifier: "EditScheduleSegue", sender: self)
        }
    }
    
    // Edit Profile
    @objc func editProfileAction() {
        //
        let height = CGFloat((147 + 49) + 49 + 49 + (20 * 2))
        animateActionSheetDown(actionSheet: actionSheet, actionSheetHeight: height, backgroundView: backgroundViewExpanded)
        //
        // AND indicate to profile segue that coming from schedule so that the 'skip to goals section' button can be presented
        self.performSegue(withIdentifier: "EditProfileSegue", sender: self)
        
    }
    
    //
    @IBAction func scheduleButton(_ sender: Any) {
        //
        UIApplication.shared.keyWindow?.insertSubview(actionSheet, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: actionSheet)
        //
        let height = CGFloat((147 + 49) + 49 + 49 + (20 * 2))
        animateActionSheetUp(actionSheet: actionSheet, actionSheetHeight: height, backgroundView: backgroundViewExpanded)
        
        //
        
    }
    
    // Dismiss presets table
    @objc func backgroundViewExpandedAction(_ sender: Any) {
        //
        let height = CGFloat((147 + 49) + 49 + 49 + (20 * 2))
        animateActionSheetDown(actionSheet: actionSheet, actionSheetHeight: height, backgroundView: backgroundViewExpanded)
        
    }
    
    
    //
    // MARK: Prepare for segue
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
        } else if segue.identifier == "scheduleSegueOverview" {
            let destinationVC = segue.destination as? FinalChoice
            destinationVC?.comingFromSchedule = true
            //
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        } else if segue.identifier == "EditProfileSegue" {
            let destinationVC = segue.destination as! Profile
            destinationVC.comingFromSchedule = true
        } else if segue.identifier == "EditScheduleSegue" {
            let destinationNC = segue.destination as! ScheduleEditingNavigation
            let destinationVC = destinationNC.viewControllers.first as! ScheduleEditing
//            destinationVC.comingFromSchedule = true
        } else if segue.identifier == "scheduleMeditationSegueTimer" {
            let destinationVC = segue.destination as? MeditationTimer
            destinationVC?.comingFromSchedule = true
            //
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        } else if segue.identifier == "scheduleMeditationSegueGuided" {
            let destinationVC = segue.destination as? MeditationChoiceGuided
            destinationVC?.comingFromSchedule = true
            //
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
    @objc func walkthroughSchedule() {
        
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
            walkthroughLabel.textColor = Colours.colour2
            walkthroughLabel.backgroundColor = Colours.colour1
            walkthroughHighlight.backgroundColor = Colours.colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colours.colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: 172, height: 33)
            walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: 40)
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
            
            
        // Pasth
        case 1:
            //
            highlightSize = CGSize(width: 172, height: 33)
            highlightCenter = CGPoint(x: view.frame.size.width / 2, y: 40)
            highlightCornerRadius = 0
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
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
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
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
            walkthroughBackgroundColor = Colours.colour1
            walkthroughTextColor = Colours.colour2
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
                var walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
                walkthroughs[5] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
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

