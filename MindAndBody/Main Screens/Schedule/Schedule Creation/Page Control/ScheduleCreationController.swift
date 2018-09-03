//
//  ScheduleCreationController.swift
//  MindAndBody
//
//  Created by Luke Smith on 01.09.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class ScheduleCreationController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var leftItem: UIBarButtonItem!
    @IBOutlet weak var rightItem: UIBarButtonItem!
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressIndicator: UIView!
    @IBOutlet weak var progressIndicatorWidth: NSLayoutConstraint!
    @IBOutlet weak var progressIndicator2: UIView!
    @IBOutlet weak var progressIndicatorWidth2: NSLayoutConstraint!
    @IBOutlet weak var currentIndicator: UIView!
    @IBOutlet weak var currentIndicatorWidth: NSLayoutConstraint!
    @IBOutlet weak var currentIndicator2: UIView!
    @IBOutlet weak var currentIndicatorWidth2: NSLayoutConstraint!
    
    @IBOutlet weak var explanationView: UIView!
    @IBOutlet weak var explanationLabel: UILabel!
    
    var appChoosesSessions = true
    var appHelpsCreateSchedule = true
    var isProfileCompleted = false
    
    var currentPage = 0
    var pages = [String]()
    var tabs = [UIView]()
    
    override func viewDidLoad() {
        
        view.backgroundColor = Colors.light
        
        leftItem.title = NSLocalizedString("back", comment: "")
        leftItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBarButton!], for: .normal)
        leftItem.tintColor = Colors.light
        
        rightItem.tintColor = Colors.dark

        self.navigationController?.navigationBar.barTintColor = Colors.dark
        self.navigationController?.navigationBar.shadowImage = UIImage() // Remove separator
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBar!]
        enableBackButton()
        // Pass information to child
        if let childVC = self.childViewControllers.first as? ScheduleCreationPageController {
            childVC.appChoosesSessions = appChoosesSessions
            childVC.appHelpsCreateSchedule = appHelpsCreateSchedule
            childVC.isProfileCompleted = isProfileCompleted
            childVC.setupPages()
            childVC.updatePagesOfParent()
        }
        // Setup
        setupExplanationView()
        setupProgressView()
    }
    
    func setupExplanationView() {
        
        explanationView.backgroundColor = Colors.dark
        
        explanationLabel.textColor = Colors.light
        explanationLabel.font = UIFont(name: "SFUIDisplay-regular", size: 13)
        explanationLabel.numberOfLines = 0
        explanationLabel.lineBreakMode = .byWordWrapping
    }
    
    func setupProgressView() {
        
        progressView.backgroundColor = Colors.light
        progressIndicator.backgroundColor = Colors.green
        progressIndicator2.backgroundColor = Colors.green
        currentIndicator.backgroundColor = Colors.red
        currentIndicator2.backgroundColor = Colors.red
        
        let viewWidth = view.bounds.width / CGFloat(pages.count)
        
        if pages.count != 0 {
            for i in 0..<pages.count {
                switch i {
                case 0:
                    let backgroundView = TriangleLabel()
                    backgroundView.frame = CGRect(x: 0, y: 0, width: viewWidth + 21 - 9, height: 44)
                    backgroundView.backgroundColor = .clear
                    backgroundView.triangleColor = Colors.dark
                    progressView.addSubview(backgroundView)
                    let label = UILabel()
                    label.text = NSLocalizedString(pages[i], comment: "")
                    label.font = UIFont(name: "SFUIDisplay-light", size: 13)
                    label.textColor = Colors.light
                    label.textAlignment = .center
                    label.sizeToFit()
                    label.center = backgroundView.center
                    label.center.x -= 5
                    view.addSubview(label)
                    
                    tabs.append(backgroundView)
                    
                case pages.count - 1:
                    let backgroundView = TriangleLabel3()
                    backgroundView.frame = CGRect(x: tabs[i - 1].frame.maxX - 21, y: 0, width: viewWidth + 21 - 9, height: 44)
                    backgroundView.backgroundColor = .clear
                    backgroundView.triangleColor = Colors.dark
                    progressView.addSubview(backgroundView)
                    let label = UILabel()
                    label.text = NSLocalizedString(pages[i], comment: "")
                    label.font = UIFont(name: "SFUIDisplay-light", size: 13)
                    label.textColor = Colors.light
                    label.textAlignment = .center
                    label.sizeToFit()
                    label.center = backgroundView.center
                    label.center.x += 5
                    view.addSubview(label)
                    
                    tabs.append(backgroundView)
                    
                default:
                    let backgroundView = TriangleLabel2()
                    backgroundView.frame = CGRect(x: tabs[i - 1].frame.maxX - 21, y: 0, width: viewWidth + 21, height: 44)
                    backgroundView.backgroundColor = .clear
                    backgroundView.triangleColor = Colors.dark
                    progressView.addSubview(backgroundView)
                    let label = UILabel()
                    label.text = NSLocalizedString(pages[i], comment: "")
                    label.font = UIFont(name: "SFUIDisplay-light", size: 13)
                    label.textColor = Colors.light
                    label.textAlignment = .center
                    label.sizeToFit()
                    label.center = backgroundView.center
                    view.addSubview(label)
                    
                    tabs.append(backgroundView)
                }
            }
        }
        
        updateIndicator()
        updateTitleAndExplanation()
    }
    
    func updateIndicator() {
        
        // Update pages if needed
        if let childVC = self.childViewControllers.first as? ScheduleCreationPageController {
            childVC.updatePagesOfParent()
        }
        
        var indicatorWidth: CGFloat = 0
        if pages.count != 0 {
            if self.currentPage < self.pages.count - 1 {
                
                let indicatorWidth1 = self.tabs[self.currentPage].bounds.width - 21
                self.currentIndicatorWidth.constant = indicatorWidth1
                self.currentIndicatorWidth2.constant = indicatorWidth1

                let indicatorWidth2 = self.tabs[self.currentPage].frame.minX
                self.progressIndicatorWidth.constant = indicatorWidth2
                self.progressIndicatorWidth2.constant = indicatorWidth2

            } else if self.currentPage == self.pages.count - 1 {
                
                let indicatorWidth1 = self.tabs[self.currentPage].bounds.width
                self.currentIndicatorWidth.constant = indicatorWidth1
                self.currentIndicatorWidth2.constant = indicatorWidth1
                
                let indicatorWidth2 = self.tabs[self.currentPage].frame.minX
                self.progressIndicatorWidth.constant = indicatorWidth2
                self.progressIndicatorWidth2.constant = indicatorWidth2
            }
            
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
            
        } else {
            indicatorWidth = view.bounds.width / 5
            progressIndicatorWidth.constant = indicatorWidth
            progressIndicatorWidth2.constant = indicatorWidth
        }
    }
    
    func updateTitleAndExplanation() {
        if pages.count != 0 {
            navigationBar.title = NSLocalizedString(pages[currentPage] + "T", comment: "")
            explanationLabel.text = NSLocalizedString(pages[currentPage] + "E", comment: "")
        }
    }
    
    func enableBackButton() {
        if currentPage == 0 {
            self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = true
        } else {
            self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if let childVC = self.childViewControllers.first as? ScheduleCreationPageController {
            childVC.updatePagesOfParent()
            if currentPage < (pages.count - 1) {
                childVC.nextViewController()
            }
        }
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        if currentPage == 0 {
            // popup saying going back will delete newly created schedule
            self.navigationController?.popToRootViewController(animated: true)
        } else if let childVC = self.childViewControllers.first as? ScheduleCreationPageController {
            childVC.updatePagesOfParent()
            childVC.previousViewController()
        }
    }
    
}
