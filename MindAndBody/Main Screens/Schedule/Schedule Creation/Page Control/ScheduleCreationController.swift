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
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressStack: UIStackView!
    @IBOutlet weak var progressIndicator: UIView!
    @IBOutlet weak var progressIndicatorLeading: NSLayoutConstraint!
    @IBOutlet weak var progressIndicatorWidth: NSLayoutConstraint!
    
    var appChoosesSessions = true
    var appHelpsCreateSchedule = true
    var isProfileCompleted = false
    
    var currentPage = 0
    var pages = [String]()
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.barTintColor = Colors.dark
        self.navigationController?.navigationBar.shadowImage = UIImage() // Remove separator
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBar!]
        navigationBar.title = NSLocalizedString("schedule", comment: "")
        enableBackButton()
        setupProgressView()

        if let childVC = self.childViewControllers.first as? ScheduleCreationPageController {
            childVC.appChoosesSessions = appChoosesSessions
            childVC.appHelpsCreateSchedule = appHelpsCreateSchedule
            childVC.isProfileCompleted = isProfileCompleted
        }
    }
    
    func setupProgressView() {
        
        progressView.backgroundColor = Colors.dark
        
        let titles = ["profile", "equipment", "help", "view", "content"]
        for i in 0..<titles.count {
            let label = UILabel()
            label.font = UIFont(name: "SFUIDisplay-thin", size: 13)
            label.text = titles[i]
            label.textColor = Colors.light
            label.textAlignment = .center
            progressStack.addArrangedSubview(label)
        }
        
        progressIndicatorWidth.constant = view.bounds.width / CGFloat(titles.count)
    }
    
    func updateIndicator() {
        
        // Update pages if needed
        if let childVC = self.childViewControllers.first as? ScheduleCreationPageController {
            childVC.updatePagesOfParent()
        }
        
        var indicatorWidth: CGFloat = 0
        if pages.count != 0 {
            indicatorWidth = view.bounds.width / CGFloat(pages.count)
            progressIndicatorWidth.constant = indicatorWidth
        } else {
            indicatorWidth = view.bounds.width / 5
            progressIndicatorWidth.constant = indicatorWidth
        }
        
        let leadingPosition = indicatorWidth * CGFloat(currentPage)
        progressIndicatorLeading.constant = leadingPosition
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
