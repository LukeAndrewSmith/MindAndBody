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
    let maskView1 = UIButton()
    let maskView2 = UIButton()
    let maskViewBackButton = UIImageView()
    
    
    //
    // Schedule
    // choiceProgress Indicated progress through the choices to select a session
        // Note: choiceProgress[0] = -1 if first screen, i.e choices being displayed
    var choiceProgress = [-1,0]
    
    //
    // Selected Choices
    // Selected choices corrensponds to an array in 'sortedSession' containing (easy, medium, hard) of relevant selection to be chosen by the app based on the profile (arrays containing difficulty level for each group to select)
    // 3 because arrays do not quite correspond in terms of accessing relevant sessions for a number of reasons; not a mistake
    var selectedChoiceWarmup = [0,0,0,0,0,0]
    var selectedChoiceSession = [0,0,0,0,0,0]
    var selectedChoiceStretching = [0,0,0,0,0,0]

    
//
// View Will Appear ---------------------------------------------------------------------------------
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        //
        // Select Today
        // Get current day as index, currentWeekDay - 1 as week starts at 0 in array
        selectedDay = Date().currentWeekDayFromMonday - 1
        stackArray[selectedDay].alpha = 1
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

    
    // MARK: - Tests
    // Content Arrays Test
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
    
    //
    // MARK: Schedule Tracking, tracking what youve done each week, putting a tick next to what you've done in schedule if true
    var scheduleTrackingArray: [[Int:[[Bool]]]] =
    [
        // Monday
        [
                // MARK: Mind
                0:
                    [
                        // 0
                        [false],
                        // Yoga, Meditation Walk
                        [
                            false,
                            false,
                            false
                        ],
                        // 4 | To Do Yoga - Warmup, Practice
                        [
                            false,
                            false
                        ]
                ],
                
                // Note: Choice = ["title","contents","contents"...]
                // MARK: Flexibility
                1:
                    [
                        // 0
                        [false],
                        // 4 | To Do Flexibility - Warmup, Session
                        [
                            false,
                            false
                        ]
                ],
                
                // MARK: Endurance
                2:
                    [
                        // 0
                        [false],
                        // Type - High Intesnsity, Steady State
                        [
                            false,
                            false
                        ],
                        // --------------
                        // 4 | High Intensity To Do - warmup, cardio, stretching
                        [
                            false,
                            false,
                            false
                        ],
                        // ------------
                        // Steady State
                        // 5 | Steady State To Do 2 - 2 - To Do
                        [
                            false,
                            false,
                            false,
                            ]
                ],
                // MARK: Toning
                3:
                    [
                        // 0
                        [false],
                        // 3 | Toning To Do, warmup, session, stretching
                        [
                            false,
                            false,
                            false
                        ]
                ],
                
                // MARK: Muscle Gain
                4:
                    [
                        // 0
                        [false],
                        // 4 | Muscle Gain To Do - Warmup, session, stretching
                        [
                            false,
                            false,
                            false
                        ]
                ],
                
                // MARK: Strength
                5:
                    [
                        // 0
                        [false],
                        // 4 | Strength To Do, Warmup, Session, Stretching
                        [
                            false,
                            false,
                            false
                        ]
                ]
        ],
        // Tuesday
        [
                // MARK: Mind
                0:
                    [
                        // 0
                        [false],
                        // Yoga, Meditation Walk
                        [
                            false,
                            false,
                            false
                        ],
                        // 4 | To Do Yoga - Warmup, Practice
                        [
                            false,
                            false
                        ]
                ],
                
                // Note: Choice = ["title","contents","contents"...]
                // MARK: Flexibility
                1:
                    [
                        // 0
                        [false],
                        // 4 | To Do Flexibility - Warmup, Session
                        [
                            false,
                            false
                        ]
                ],
                
                // MARK: Endurance
                2:
                    [
                        // 0
                        [false],
                        // Type - High Intesnsity, Steady State
                        [
                            false,
                            false
                        ],
                        // --------------
                        // 4 | High Intensity To Do - warmup, cardio, stretching
                        [
                            false,
                            false,
                            false
                        ],
                        // ------------
                        // Steady State
                        // 5 | Steady State To Do 2 - 2 - To Do
                        [
                            false,
                            false,
                            false,
                            ]
                ]
        ],
        // Wednesday
        [
            // MARK: Endurance
            2:
                [
                    // 0
                    [false],
                    // Type - High Intesnsity, Steady State
                    [
                        false,
                        false
                    ],
                    // --------------
                    // 4 | High Intensity To Do - warmup, cardio, stretching
                    [
                        false,
                        false,
                        false
                    ],
                    // ------------
                    // Steady State
                    // 5 | Steady State To Do 2 - 2 - To Do
                    [
                        false,
                        false,
                        false,
                        ]
            ]
        ],
        // Thursday
        [
            // MARK: Strength
            5:
                [
                    // 0
                    [false],
                    // 4 | Strength To Do, Warmup, Session, Stretching
                    [
                        false,
                        false,
                        false
                    ]
            ]
        ],
        // Friday
        [
            // MARK: Mind
            0:
                [
                    // 0
                    [false],
                    // Yoga, Meditation Walk
                    [
                        false,
                        false,
                        false
                    ],
                    // 4 | To Do Yoga - Warmup, Practice
                    [
                        false,
                        false
                    ]
            ],
            
            // MARK: Muscle Gain
            4:
                [
                    // 0
                    [false],
                    // 4 | Muscle Gain To Do - Warmup, session, stretching
                    [
                        false,
                        false,
                        false
                    ]
            ],
        ],
        // Saturday
        [
            // MARK: Endurance
            2:
                [
                    // 0
                    [false],
                    // Type - High Intesnsity, Steady State
                    [
                        false,
                        false
                    ],
                    // --------------
                    // 4 | High Intensity To Do - warmup, cardio, stretching
                    [
                        false,
                        false,
                        false
                    ],
                    // ------------
                    // Steady State
                    // 5 | Steady State To Do 2 - 2 - To Do
                    [
                        false,
                        false,
                        false,
                        ]
            ],
        ],
        // Sunday
        [
            // MARK: Strength
            5:
                [
                    // 0
                    [false],
                    // 4 | Strength To Do, Warmup, Session, Stretching
                    [
                        false,
                        false,
                        false
                    ]
            ]
        ],
    ]
    // MARK: -
    
    
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
                return daySessionsArray[selectedDay].count
                    // + 1 incase edit button to reorder is wanted
                    //+ 1
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
            // Long tap; ability to mark session as complete
            let markAsCompletedGesture = UILongPressGestureRecognizer()
            cell.tag = indexPath.row
            markAsCompletedGesture.addTarget(self, action: #selector(markAsCompleted))
            cell.addGestureRecognizer(markAsCompletedGesture)
            
            
            // First Screen, showing groups
            if choiceProgress[0] == -1 {
                switch indexPath.row {
                // Edit/Reorder button, currently unused
                case daySessionsArray[selectedDay].count:
                    let editButton = UILabel()
                    editButton.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
                    editButton.textColor = colour1
                    editButton.text = NSLocalizedString("edit", comment: "")
                    editButton.alpha = 0.72
                    editButton.sizeToFit()
                    editButton.frame = CGRect(x: 27, y: 0, width: (view.bounds.width - 54) / 2, height: 72)
                    // action
//                    editButton.isUserInteractionEnabled = true
////                    let tap = UITapGestureRecognizer(target: self, action: #selector(editButtonTap))
//                    tap.numberOfTapsRequired = 1
//                    editButton.addGestureRecognizer(tap)
//                    cell.addSubview(editButton)
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
                    
                // Groups
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
                    //
                    // CheckMark if completed
                    if isCompleted(row: indexPath.row) == true {
                        dayLabel.textColor = colour3
                        
                        cell.tintColor = colour3
                        cell.accessoryType = .checkmark
                    }
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
                    //
                    // Color if last choice
                    if isLastChoice() == true {
                        cell.textLabel?.textColor = colour3
                        seperator.backgroundColor = colour3.cgColor
                    }
                    //
                    // CheckMark if completed
                    if isCompleted(row: indexPath.row) == true {
                        cell.tintColor = colour3
                        cell.accessoryType = .checkmark
                    }
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
    
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch tableView {
        case scheduleTable:
            //
            // If choiceProgress[0] = -1
            didSelectRowHandler(row: indexPath.row)

            //
            tableView.deselectRow(at: indexPath, animated: true)

        case scheduleChoiceTable:
            tableView.deselectRow(at: indexPath, animated: true)

        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
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
        } else if segue.identifier == "scheduleSegueOverview" {
            let destinationVC = segue.destination as? FinalChoice
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
