//
//  ScheduleCreationPageController.swift
//  MindAndBody
//
//  Created by Luke Smith on 01.09.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class ScheduleCreationPageController: UIPageViewController, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    var pagesString = [String]()
    
    var currentIndex = 0
    
    var appChoosesSessions = true
    var appHelpsCreateSchedule = true
    var isProfileCompleted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
//        self.dataSource = self
        
        setupPages(appChoosesSessions: appChoosesSessions, appHelpsCreateSchedule: appHelpsCreateSchedule, isProfileCompleted: isProfileCompleted)
        
        InfoPageControl.shared.pageControl.numberOfPages = pages.count
    }
    
    func setupPages(appChoosesSessions: Bool, appHelpsCreateSchedule: Bool, isProfileCompleted: Bool) {
        
        // Possible choices
        // appChoosesSessions && appHelpsCreateSchedule
            // profile -> equipment -> creation help -> schedule style -> schedule creator
        // !appChoosesSessions && appHelpsCreateSchedule
            // creation help -> schedule style -> schedule creator
        // appChoosesSessions && !appHelpsCreateSchedule
            // profile -> equipment -> schedule style -> schedule creator
        // !appChoosesSessions && !appHelpsCreateSchedule
            // schedule style -> schedule creator
        
        // Profile only shown if not complete, hence isProfileCompleted
        
        // Thus appChoosesSessions => profile && equipment
        // and appHelpsCreateSchedule => creation help

        pages = []
        pagesString = []
        
        let profile: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "Profile"))! as! Profile
        let scheduleEquipment: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "ScheduleEquipment"))! as! ScheduleEquipment
        let scheduleCreationHelp: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "ScheduleCreationHelp"))! as! ScheduleCreationHelp
        let scheduleViewQuestion: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "ScheduleViewQuestion"))! as! ScheduleViewQuestion
        let scheduleCreator: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "ScheduleCreator"))! as! ScheduleCreator
        //        let scheduleCreatioWeek: UIViewController! = (storyboard?.instantiateViewController(withIdentifier: "ScheduleCreatorWeek"))! as! ScheduleCreatorWeek
        
        if appChoosesSessions && !isProfileCompleted {
            pages.append(profile)
            pages.append(scheduleEquipment)
            pagesString.append("profile")
            pagesString.append("scheduleEquipment")

        } else if appChoosesSessions && isProfileCompleted {
            pages.append(scheduleEquipment)
            pagesString.append("scheduleEquipment")
        }
        
        if appHelpsCreateSchedule {
            pages.append(scheduleCreationHelp)
            pagesString.append("scheduleCreationHelp")
        }
        
        pages.append(scheduleViewQuestion)
        pagesString.append("scheduleViewQuestion")

        // Two possible schedule creation screens depending on style
            // Assume day view, change if not
        pages.append(scheduleCreator)
        pagesString.append("scheduleCreator")
        
        // Set initial view controller
        if appChoosesSessions {
            if !isProfileCompleted {
                setViewControllers([profile], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
            } else {
                setViewControllers([scheduleEquipment], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
            }

        } else if !appChoosesSessions && appHelpsCreateSchedule {
            setViewControllers([scheduleCreationHelp], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)

        } else if !appChoosesSessions && !appHelpsCreateSchedule {
            setViewControllers([scheduleViewQuestion], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        }
        
        // Pass string array to parent
            // Doesnt get the parent vc for some reason
        if let parentVC = self.parent as? ScheduleCreationController {
            parentVC.pages = pagesString
            parentVC.updateIndicator()
        }
    }
    
    func updatePagesOfParent() {
        if let parentVC = self.parent as? ScheduleCreationController {
            if parentVC.pages.count == 0 {
                parentVC.pages = pagesString
            }
        }
    }
    
    func nextViewController() {
        if currentIndex != pages.count - 1 {
            currentIndex += 1
            setViewControllers([pages[currentIndex]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            if let parentVC = self.parent as? ScheduleCreationController {
                parentVC.currentPage = currentIndex
                parentVC.updateIndicator()
                parentVC.enableBackButton()
            }
        }
    }
    
    func previousViewController() {
        if currentIndex > 0 {
            currentIndex -= 1
            setViewControllers([pages[currentIndex]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
            if let parentVC = self.parent as? ScheduleCreationController {
                parentVC.currentPage = currentIndex
                parentVC.updateIndicator()
                parentVC.enableBackButton()
            }
        }
    }
    
}
