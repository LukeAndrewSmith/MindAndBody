
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
    @IBOutlet weak var tableView: UITableView!
    
    //
    @IBOutlet weak var menuButton: UIButton!
    //
    @IBOutlet weak var stackViewTitle: UIStackView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //
    @IBOutlet weak var mind: UIButton!
    @IBOutlet weak var body: UIButton!
    @IBOutlet weak var other: UIButton!
    

    // Background Colour View
    let backView = UIView()

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
// View will appear ------------------------------------------------------------------------------------
//
    let blur4 = UIVisualEffectView()
    var addedToApplication = false
    override func viewWillAppear(_ animated: Bool) {
        //
        //
        if addedToApplication == false {
            let blurE4 = UIBlurEffect(style: .dark)
            self.blur4.effect = blurE4
            self.blur4.frame = UIApplication.shared.statusBarFrame
            self.blur4.isUserInteractionEnabled = false
            //
            view.insertSubview(blur4, aboveSubview: tableView)
            //
        }
    }
    

//
// View will dissappear ------------------------------------------------------------------------------------
//
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //
        if addedToApplication == true {
            //
            blur4.removeFromSuperview()
        }
    }
  
    
//
// View did load ------------------------------------------------------------------------------------
//
    //
    let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
    let backgroundImageView = UIImageView()

   //
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Blurs
        let blurE = UIBlurEffect(style: .dark)
        blur.effect = blurE
        let vibrancyE = UIVibrancyEffect(blurEffect: blurE)
        blur.effect = vibrancyE
        blur.frame = CGRect(x: 0, y: 0, width: titleLabel.frame.size.width * 1.1, height: titleLabel.frame.size.height * 0.8)
        blur.center.x = stackViewTitle.center.x
        blur.center.y = stackViewTitle.center.y + (stackViewTitle.frame.size.height / 4)
        blur.layer.cornerRadius = titleLabel.frame.size.height / 3
        blur.clipsToBounds = true
        blur.isUserInteractionEnabled = false
        view.addSubview(blur)
        view.sendSubview(toBack: blur)
        //
        let blurE2 = UIBlurEffect(style: .dark)
        blur2.effect = blurE2
        let vibrancyE2 = UIVibrancyEffect(blurEffect: blurE2)
        blur2.effect = vibrancyE2
        blur2.frame = CGRect(x: 0, y: 0, width: logoView!.frame.size.width * 1.1, height: logoView!.frame.size.height * 1.1)
        blur2.center.x = stackViewTitle.center.x
        blur2.center.y = stackViewTitle.center.y - (stackViewTitle.frame.size.height / 4)
        blur2.layer.cornerRadius = logoView.frame.size.height / 2
        blur2.clipsToBounds = true
        blur2.isUserInteractionEnabled = false
        view.addSubview(blur2)
        view.sendSubview(toBack: blur2)
        //
        //
        let blurE3 = UIBlurEffect(style: .dark)
        blur3.effect = blurE3
        let vibrancyE3 = UIVibrancyEffect(blurEffect: blurE3)
        blur3.effect = vibrancyE3
        blur3.frame = CGRect(x: 0, y: 0, width: menuButton.bounds.width * 0.7, height: menuButton.bounds.height * 0.7)
        blur3.center = menuButton.center
        blur3.layer.cornerRadius = menuButton.frame.size.height * 0.35
        blur3.clipsToBounds = true
        blur3.isUserInteractionEnabled = false
        view.addSubview(blur3)
        view.sendSubview(toBack: blur3)
        
        
        // Colours
        //
        switch backgroundIndex {
        // All Black
        case 1,3,backgroundImageArray.count:
            titleLabel.textColor = colour2
            logoView.tintColor = colour2
            menuButton.tintColor = colour2
        // All White
        case 0,2,3,4,5,6:
            titleLabel.textColor = colour1
            logoView.tintColor = colour1
            menuButton.tintColor = colour1
        //
        default: break
        }

        //
        mind.backgroundColor = colour2
        body.backgroundColor = colour2
        other.backgroundColor = colour2
        
        //
        tableView.backgroundColor = colour1


        // Background Image
        backgroundImageView.frame = UIScreen.main.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        //
        if backgroundIndex < backgroundImageArray.count {
            backgroundImageView.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = colour1
        }
        //
        self.view.addSubview(backgroundImageView)
        self.view.sendSubview(toBack: backgroundImageView)
        
        
        // Swipe
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.direction = .right
        rightSwipe.addTarget(self, action: #selector(swipeGesture))
        view.addGestureRecognizer(rightSwipe)
        
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "informationWalkthrough") == false {
            self.walkthroughMindBody()
            UserDefaults.standard.set(true, forKey: "informationWalkthrough")
        }

        //  Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //
        self.navigationController?.navigationBar.barTintColor = colour2
        self.navigationController?.navigationBar.tintColor = colour1
    }
  
    
//
// Mind, Body Other button functions ---------------------------------------------------
//
    // Mind
    @IBAction func mindAction(_ sender: Any) {
        let indexPathScroll = NSIndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPathScroll as IndexPath, at: .top, animated: true)
    }
    // Body
    @IBAction func bodyAction(_ sender: Any) {
        let indexPathScroll = NSIndexPath(row: 0, section: 1)
        tableView.scrollToRow(at: indexPathScroll as IndexPath, at: .top, animated: true)
    }
    // Other
    @IBAction func otherAction(_ sender: Any) {
        let indexPathScroll = NSIndexPath(row: 0, section: 2)
        tableView.scrollToRow(at: indexPathScroll as IndexPath, at: .top, animated: true)
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
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        //
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        // Border
        let border = CALayer()
        border.backgroundColor = colour2.cgColor
        border.frame = CGRect(x: 15, y: header.frame.size.height-1, width: self.view.frame.size.height, height: 1)
        //
        header.layer.addSublayer(border)
        header.layer.masksToBounds = true
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
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
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
    
    @IBAction func menuButtonAction(_ sender: Any) {
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
                
                //destinationVC.selectedSession = selectedSession
                
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
    func nextWalkthroughView(_ sender: Any) {
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
