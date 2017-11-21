
//
//  Lessons.swift
//  MindAndBody
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Session Screen Overview Class ------------------------------------------------------------------------------------
//
class Lessons: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    //
    @IBOutlet weak var tableView: UITableView!
    
    
    //
    let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
    var backgroundIndex = Int()
    let backgroundBlur = UIVisualEffectView()
    
    
    // Selected Topic
    var selectedTopic = [0,0]
    
    // Arrays
    let sectionArray: [String] =
        ["mind", "body", "other"]
    //
    let rowArray: [[String]] =
        [
            ["mindfulness", "meditation", "yoga", "mindMuscle"],
            ["breathing", "coreActivation", "equipment", "posture"],
            ["anatomy", "nutrition", "appUsage"],
            
            ]
    
    //
    // Blurs
    let blur = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur3 = UIVisualEffectView()
    
    
    //
    // View did load ------------------------------------------------------------------------------------
    //
    
    
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundIndex = settings["BackgroundImage"]![0]
        
        //
        tableView.backgroundColor = .clear
        tableView.backgroundView = UIView()
        
        
        //
        // BackgroundImage
        addBackgroundImage(withBlur: true, fullScreen: false)
        
        // Tableview top view
        let topView = UIVisualEffectView()
        let topViewE = UIBlurEffect(style: .dark)
        topView.effect = topViewE
        topView.isUserInteractionEnabled = false
        //
        topView.frame = CGRect(x: 0, y: tableView.frame.minY - tableView.bounds.height, width: tableView.bounds.width, height: tableView.bounds.height)
        //
        tableView.addSubview(topView)
        
        // Swipe
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.direction = .right
        rightSwipe.addTarget(self, action: #selector(swipeGesture))
        view.addGestureRecognizer(rightSwipe)
        
        //
        //  Navigation Bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        navigationBar.title = NSLocalizedString("lessons", comment: "")
        self.navigationController?.navigationBar.barTintColor = Colours.colour2
        self.navigationController?.navigationBar.tintColor = Colours.colour1
    }
    
    
    //
    // TableView ------------------------------------------------------------------------------------
    //
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 3
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        switch section {
        case 0: return NSLocalizedString(sectionArray[0], comment: "")
        case 1: return NSLocalizedString(sectionArray[1], comment: "")
        case 2: return NSLocalizedString(sectionArray[2], comment: "")
        default: break
        }
        return " "
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 22)!
        header.textLabel?.textColor = Colours.colour1
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        //
        header.backgroundColor = .clear
        header.backgroundView = UIView()
        
        let seperator = CALayer()
        seperator.frame = CGRect(x: 15, y: header.frame.size.height - 1, width: view.frame.size.width, height: 1)
        seperator.backgroundColor = Colours.colour1.cgColor
        seperator.opacity = 0.5
        header.layer.addSublayer(seperator)
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        switch section {
        case 0: return rowArray[0].count
        case 1: return rowArray[1].count
        case 2: return rowArray[2].count
        default: break
        }
        return 0
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        return 47
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        //default:
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        //
        cell.textLabel?.text = NSLocalizedString(rowArray[indexPath.section][indexPath.row], comment: "")
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        cell.textLabel?.textColor = Colours.colour1
        //
        // Indicator
        cell.accessoryType = .disclosureIndicator
        //
        return cell
        
        //        }
        //        //
        //        return UITableViewCell()
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        tableView.deselectRow(at: indexPath, animated: true)
        //
        //        // Selected Topic
        //        selectedTopic[0] = indexPath.section
        //        selectedTopic[1] = indexPath.row
        //
        //
        //        // Perform Segue
        //        //
        //        // Anatomy
        //        if (indexPath.section, indexPath.row) == (0, 3) {
        //            performSegue(withIdentifier: "anatomy", sender: nil)
        //        } else if (indexPath.section, indexPath.row) == (1, 0) {
        //            performSegue(withIdentifier: "music", sender: nil)
        //        } else {
        //            performSegue(withIdentifier: "informationSegue", sender: nil)
        //        }
        
    }
    
    // Mask cells under clear header
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            let hiddenFrameHeight = scrollView.contentOffset.y + navigationController!.navigationBar.frame.size.height - cell.frame.origin.y + 2
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
        return mask
    }
    
    //
    // Button Actions ------------------------------------------------------------------------------------
    //
    // Button Actions
    func navigationButtonAction(_ sender: Any) {
        //
        //
        switch (sender as AnyObject).tag {
        //
        case 1:
            self.tableView.setContentOffset(CGPoint(x: 0, y: 132), animated: true)
        //
        case 2:
            let height = CGFloat(186 + 200)
            //
            if tableView.frame.maxY > height - tableView.frame.size.height {
                //
                self.tableView.setContentOffset(CGPoint(x: 0, y: 186 + 200), animated: true)
                //
            } else {
                //
                self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height), animated: true)
            }
        //
        case 3:
            let height = CGFloat(186 + 200 + 200)
            //
            if tableView.frame.maxY > height - tableView.frame.size.height {
                //
                self.tableView.setContentOffset(CGPoint(x: 0, y: 186 + 200), animated: true)
            } else {
                //
                self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height), animated: true)
            }
        //
        default: break
        }
    }
    
    
    //
    // Slide Menu ---------------------------------------------------------------------------------------------------------------------
    //
    
    // Elements
    //
    @IBAction func swipeGesture(sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    @IBAction func slideMenuAction(_ sender: Any) {
        self.performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
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
        } else {
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
            // Pass Info
            if (segue.identifier == "lessonsSegue") {
                
                let destinationVC = segue.destination as! LessonsScreen1
                destinationVC.selectedTopic = selectedTopic
                
                //destinationVC.SelectedSession.shared.selectedSession = SelectedSession.shared.selectedSession
                
                //destinationVC.guidedTitle = guidedTitleText
                //destinationVC.keyArray = selectedArray
                //destinationVC.poses = posesDictionary
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    //
    // Walkthrough ------------------------------------------------------------------------------------
    //
    var  viewNumber = 0
    let walkthroughView = UIView()
    let label = UILabel()
    let nextButton = UIButton()
    let backButton = UIButton()
    
    
    // Walkthrough
    func walkthroughMindBody() {
        
        //
        let screenSize = UIScreen.main.bounds
        //
        walkthroughView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        walkthroughView.backgroundColor = .black
        walkthroughView.alpha = 0.72
        walkthroughView.clipsToBounds = true
        //
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        label.center = view.center
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "SFUIDisplay-light", size: 22)
        label.textColor = .white
        label.alpha = 0.9
        //
        nextButton.frame = screenSize
        nextButton.backgroundColor = .clear
        nextButton.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
        
        //
        switch viewNumber {
        //
        case 0:
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: 196, width: view.frame.size.width, height: 44))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            
            //
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            //
            label.text = NSLocalizedString("information1", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
            label.center.y = view.center.y + 50
        //
        default: break
        }
    }
    
    //
    @objc func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        label.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    //
}


//
// Slide Menu Extension
extension Lessons: UIViewControllerTransitioningDelegate {
    // Present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    // Dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
}


class LessonsNavigation: UINavigationController {
    
}

