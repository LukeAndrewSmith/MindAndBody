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
    @IBOutlet weak var tableView: UITableView!
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
//        tableView.addGestureRecognizer(swipeLeft)
        //
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
//        tableView.addGestureRecognizer(swipeRight)
        
        
        
        
        //
        // TableView
        tableView.backgroundView = UIView()
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        // Tableview top view
        let topView = UIVisualEffectView()
        let topViewE = UIBlurEffect(style: .dark)
        topView.effect = topViewE
        topView.isUserInteractionEnabled = false
        //
        topView.frame = CGRect(x: 0, y: tableView.frame.minY - tableView.bounds.height, width: tableView.bounds.width, height: tableView.bounds.height)
        //
        tableView.addSubview(topView)
        
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
//        pageStack.addGestureRecognizer(swipeLeft)
//        pageStack.addGestureRecognizer(swipeRight)
        
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
        return NSLocalizedString(dayArray[selectedDay], comment: "")
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
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
        seperator.backgroundColor = colour1.cgColor
        seperator.opacity = 0.5
        seperator.frame = CGRect(x: 27, y: header.frame.maxY - 1, width: view.bounds.width - 54, height: 1)
        header.layer.addSublayer(seperator)
    }
    
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (view.bounds.height - 49) / 4
    }
    
    // Rows
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return 1 // +1
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        // If cell is last
        let plusImage = UIImageView()
        plusImage.image = #imageLiteral(resourceName: "Plus")
        plusImage.tintColor = colour1
        cell.layoutIfNeeded()
        plusImage.sizeToFit()
        plusImage.frame = CGRect(x: (view.bounds.width / 2) - (plusImage.bounds.width / 2), y: (cell.bounds.height / 2) - (plusImage.bounds.height / 2), width: plusImage.bounds.width, height: plusImage.bounds.height)
        cell.addSubview(plusImage)
        //
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        return cell
    }
    
    // Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 47
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Mask cells under clear header
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
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
            tableView.reloadData()
            let snapShot1 = tableView.snapshotView(afterScreenUpdates: false)
            let snapShot2 = tableView.snapshotView(afterScreenUpdates: true)
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x + self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            tableView.alpha = 0
            //
            UIView.animate(withDuration: animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x - self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.tableView.alpha = 1
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
            tableView.reloadData()
            let snapShot1 = tableView.snapshotView(afterScreenUpdates: false)
            let snapShot2 = tableView.snapshotView(afterScreenUpdates: true)
            //
            view.addSubview(snapShot1!)
            view.bringSubview(toFront: snapShot1!)
            //
            snapShot2?.center.x = view.center.x - self.view.frame.size.width
            view.addSubview(snapShot2!)
            view.bringSubview(toFront: snapShot2!)
            //
            tableView.alpha = 0
            //
            UIView.animate(withDuration: animationTime1, animations: {
                snapShot1?.center.x = self.view.center.x + self.view.frame.size.width
                snapShot2?.center.x = self.view.center.x
            }, completion: { finish in
                self.tableView.alpha = 1
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
        tableView.reloadData()
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
