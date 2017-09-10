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
    
    var selectedSchedule = 0
    
    //
    // Main arrays tests
    
    
    
//
// View did load --------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // Background Index
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
        //
        // Background Image/Colour
        if backgroundIndex < backgroundImageArray.count {
            //
            backgroundImage.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImage.image = nil
            backgroundImage.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
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
        // Day Swipes
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeLeft)
        //
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
        
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
            dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            dayLabel.text = NSLocalizedString(dayArrayChar[i], comment: "")
            dayLabel.sizeToFit()
            dayLabel.alpha = 0.5
            stackArray.append(dayLabel)
        }
        let pageStack = UIStackView(arrangedSubviews: stackArray)
        pageStack.frame = CGRect(x: 0, y: view.frame.maxY - 49 - 64, width: view.bounds.width, height: 49)
        pageStack.distribution = .fillEqually
        pageStack.alignment = .center
        view.addSubview(pageStack)
        
        // Seperator
        let indicatorSeperator = UIView()
        indicatorSeperator.backgroundColor = colour1
        indicatorSeperator.alpha = 0.5
        indicatorSeperator.frame = CGRect(x: 0, y: pageStack.frame.minY - 1, width: view.bounds.width, height: 1)
//        view.addSubview(indicatorSeperator)
        
        //
        // Select Today
        let dfDay = DateFormatter()
        dfDay.dateFormat = "dd"
        // Get Monday
        var mondaysDate: Date {
            return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        var currentMondayDate = Int(dfDay.string(from: mondaysDate))!
        // Get Today
        var currentDay = Int(dfDay.string(from: NSDate() as Date))
    
        // Select todays indicator
        selectedDay = currentDay! - currentMondayDate
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
            let seperator = CALayer()
            seperator.frame = CGRect(x: 27, y: header.bounds.height - 1, width: view.bounds.width - 54, height: 1)
            seperator.backgroundColor = colour1.cgColor
            seperator.opacity = 0.5
            header.layer.addSublayer(seperator)

        case scheduleChoiceTable:
            break
        default: break
        }
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //
        switch tableView {
        case scheduleTable:
            return (view.bounds.height - 49) / 4
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
            return 3 // +1
        case scheduleChoiceTable:
            return 2 // +1
        default:
            return 0
        }
        //
    }
    
    // Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //
        switch tableView {
        case scheduleTable:
            switch indexPath.row {
            case 2:
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
                let plusImage = UIImageView()
                plusImage.image = #imageLiteral(resourceName: "Plus")
                plusImage.tintColor = colour1
                plusImage.alpha = 0.72
                plusImage.sizeToFit()
                plusImage.frame = CGRect(x: view.bounds.width - 27 - plusImage.bounds.width, y: (72 / 2) - (plusImage.bounds.height / 2), width: plusImage.bounds.width, height: plusImage.bounds.height)
                cell.addSubview(plusImage)
                //
                let seperator = CALayer()
                seperator.frame = CGRect(x: 27, y: 0, width: (view.bounds.width - 54) / 4, height: 1)
                seperator.backgroundColor = colour1.cgColor
                seperator.opacity = 0.25
                cell.layer.addSublayer(seperator)
            default:
                let dayLabel = UILabel()
                dayLabel.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
                dayLabel.textColor = colour1
                dayLabel.text = NSLocalizedString("Group 1 (sport)", comment: "")
                dayLabel.sizeToFit()
                dayLabel.frame = CGRect(x: 27, y: 0, width: view.bounds.width - 54, height: 72)
                cell.addSubview(dayLabel)
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
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch tableView {
        case scheduleTable:
            //
            switch indexPath.row {
            case 2:
                break
            default:
                tableView.deselectRow(at: indexPath, animated: true)
                //
                let screenFrame = UIScreen.main.bounds
                //
                maskView1.addTarget(self, action: #selector(maskAction), for: .touchUpInside)
                maskView2.addTarget(self, action: #selector(maskAction), for: .touchUpInside)
                //
                maskView1.frame = CGRect(x: 0, y: 0, width: screenFrame.width, height: UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height)! + (tableView.bounds.height / 4))
                maskView2.frame = CGRect(x: 0, y: screenFrame.height - 49, width: screenFrame.width, height: 49)
                //
                maskView1.backgroundColor = .black
                maskView1.alpha = 0
                maskView2.backgroundColor = .black
                maskView2.alpha = 0
                //
                UIApplication.shared.keyWindow?.insertSubview(self.maskView1, aboveSubview: self.view)
                UIApplication.shared.keyWindow?.insertSubview(self.maskView2, aboveSubview: self.view)
                //
                UIView.animate(withDuration: animationTime1, animations: {
                    self.maskView1.alpha = 0.5
                    self.maskView2.alpha = 0.5
                })

                // Incriment table counter
                
                // Select session
            }


        case scheduleChoiceTable:
            tableView.deselectRow(at: indexPath, animated: true)

        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //
    // Helper Functions
    //
    // Session selection mask
    func maskAction() {
        //
        UIView.animate(withDuration: animationTime1, animations: {
            self.maskView1.alpha = 0
            self.maskView2.alpha = 0
        }, completion: { finished in
            self.maskView1.removeFromSuperview()
            self.maskView2.removeFromSuperview()
        })
    }
    
    
    
    
    //
    // Mask cells under clear header
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in scheduleTable.visibleCells {
            let hiddenFrameHeight = scrollView.contentOffset.y - cell.frame.origin.y + (view.bounds.height - 49) / 4
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
            UIView.animate(withDuration: animationTime1, animations: {
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
            UIView.animate(withDuration: animationTime1, animations: {
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
            //
            UIApplication.shared.statusBarStyle = .default
            //
            if let destinationViewController = segue.destination as? SlideMenuView {
                destinationViewController.transitioningDelegate = self
            }
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
