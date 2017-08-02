
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
// Custom Lessons Cells ------------------------------------------------------------------------------------
//
// Navigation Cell
class lessonsNavigationCell: UITableViewCell {
    //
    @IBOutlet weak var important: UIButton!
    //
    @IBOutlet weak var app: UIButton!
    //
    @IBOutlet weak var discussions: UIButton!
    //
    @IBOutlet weak var music: UIButton!
    
}

//
class lessonsImportantCell: UITableViewCell {
    //
    @IBOutlet weak var titleLabel: UILabel!
}

//
class lessonsMusicCell: UITableViewCell {
   //
    @IBOutlet weak var titleLabel: UILabel!
}

//
class lessonsAppCell: UITableViewCell {
    //
    @IBOutlet weak var titleLabel: UILabel!
}

//
class lessonsDiscussionsCell: UITableViewCell {
    //
    @IBOutlet weak var titleLabel: UILabel!
}


//
// Session Screen Overview Class ------------------------------------------------------------------------------------
//
class Lessons: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //
    @IBOutlet weak var tableView: UITableView!
    

    // Background Colour View
    let backView = UIView()

    //
    let scrollUpButton = UIButton()

    // Selected Topic
    var selectedTopic = [0,0]
    
    // Arrays
    let sectionArray: [String] =
        ["important", "music", "app"]
    //
    let rowArray: [[String]] =
        [
            ["breathing", "coreActivation", "mindMuscle", "anatomy", "equipment", "posture", "commonTerms", "routineBuilding", "trainingPhilosophy", "nutrition"],
            ["suggestions"],
            ["vision", "usage"],
            
        ]

//
// View will appear ------------------------------------------------------------------------------------
//
    let blur4 = UIVisualEffectView()
    var addedToApplication = false
    override func viewWillAppear(_ animated: Bool) {
        //
        tableView.setContentOffset(CGPoint(x: 0, y: -20), animated: false)
        
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
        scrollUpButton.removeFromSuperview()

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
        
        
        // Background Image
        backgroundImageView.frame = UIScreen.main.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        //
        if backgroundIndex < backgroundImageArray.count {
            backgroundImageView.image = backgroundImageArray[backgroundIndex]
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = colour1
        }
        //
        self.tableView.backgroundView = backgroundImageView
        
        // Initial TableView Position
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        // Swipe
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.direction = .right
        rightSwipe.addTarget(self, action: #selector(swipeGesture(sender:)))
        tableView.addGestureRecognizer(rightSwipe)
        
        
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
        
        // Scroll Up Button
        scrollUpButton.frame = CGRect(x: view.frame.size.width - 59, y: view.frame.size.height - UIApplication.shared.statusBarFrame.height - 88.5, width: 44, height: 44)
        //
        scrollUpButton.layer.borderWidth = 2
        scrollUpButton.layer.borderColor = colour2.cgColor
        scrollUpButton.layer.cornerRadius = 22
        //
        scrollUpButton.backgroundColor = colour1
        //
        scrollUpButton.setImage(#imageLiteral(resourceName: "Up Arrow"), for: .normal)
        scrollUpButton.tintColor = colour2
        //
        scrollUpButton.addTarget(self, action: #selector(scrollUpButtonAction(_:)), for: .touchUpInside)
}
    
   
//
// Watch scroll View ------------------------------------------------------------------------------------
//
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            if tableView.contentOffset.y > 186 {
                //
                backgroundImageView.image = nil
                backgroundImageView.backgroundColor = colour1
                //
                UIApplication.shared.statusBarStyle = .default
                //
                UIApplication.shared.keyWindow?.insertSubview(scrollUpButton, aboveSubview: self.tableView)
            //
            } else {
                self.scrollUpButton.removeFromSuperview()
                //
                //
                if backgroundIndex < backgroundImageArray.count {
                    backgroundImageView.image = backgroundImageArray[backgroundIndex]
                } else if backgroundIndex == backgroundImageArray.count {
                    //
                    backgroundImageView.image = nil
                    backgroundImageView.backgroundColor = colour1
                }
                //
                UIApplication.shared.statusBarStyle = .lightContent
            }
        }
    }
    
    
//
// TableView ------------------------------------------------------------------------------------
//
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
            //sectionArray.count
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return 6
        //return rowArray[section].count
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch indexPath.row {
        case 0: return 152
        case 1: return 44
        case 2,3,4,5: return 200
        default: break
        }
        return 0
    }
    
    
    
    // Blurs
    let blur = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur3 = UIVisualEffectView()
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        switch indexPath.row {
        case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! headerCell
            //
            cell.titleLabel.text = NSLocalizedString("lessons", comment: "")
            //
            cell.contentView.backgroundColor = .clear
            //
            cell.selectionStyle = .none
            //
            cell.layoutIfNeeded()
            //
            // Blurs
            blur.removeFromSuperview()
            let blurE = UIBlurEffect(style: .dark)
            blur.effect = blurE
            let vibrancyE = UIVibrancyEffect(blurEffect: blurE)
            blur.effect = vibrancyE
            blur.frame = CGRect(x: 0, y: 0, width: cell.titleLabel!.frame.size.width * 1.1, height: cell.titleLabel!.frame.size.height * 0.8)
            blur.center.x = cell.stackViewTitle.center.x
            blur.center.y = cell.stackViewTitle.center.y + (cell.stackViewTitle.frame.size.height / 4)
            blur.layer.cornerRadius = cell.titleLabel.frame.size.height / 3
            blur.clipsToBounds = true
            blur.isUserInteractionEnabled = false
            cell.addSubview(blur)
            cell.sendSubview(toBack: blur)
            //
            blur2.removeFromSuperview()
            let blurE2 = UIBlurEffect(style: .dark)
            blur2.effect = blurE2
            let vibrancyE2 = UIVibrancyEffect(blurEffect: blurE2)
            blur2.effect = vibrancyE2
            blur2.frame = CGRect(x: 0, y: 0, width: cell.logoView!.frame.size.width * 1.1, height: cell.logoView!.frame.size.height * 1.1)
            blur2.center.x = cell.stackViewTitle.center.x
            blur2.center.y = cell.stackViewTitle.center.y - (cell.stackViewTitle.frame.size.height / 4)
            blur2.layer.cornerRadius = cell.logoView.frame.size.height / 2
            blur2.clipsToBounds = true
            blur2.isUserInteractionEnabled = false
            cell.addSubview(blur2)
            cell.sendSubview(toBack: blur2)
        
            //
            blur3.removeFromSuperview()
            let blurE3 = UIBlurEffect(style: .dark)
            blur3.effect = blurE3
            let vibrancyE3 = UIVibrancyEffect(blurEffect: blurE3)
            blur3.effect = vibrancyE3
            blur3.frame = CGRect(x: 0, y: 0, width: cell.menuButton.bounds.width * 0.7, height: cell.menuButton.bounds.height * 0.7)
            blur3.center = cell.menuButton.center
            blur3.layer.cornerRadius = cell.menuButton.frame.size.height * 0.35
            blur3.clipsToBounds = true
            blur3.isUserInteractionEnabled = false
            cell.addSubview(blur3)
            cell.sendSubview(toBack: blur3)
            //
            // Colours
            //
            switch backgroundIndex {
            // All Black
            case 1,3,backgroundImageArray.count:
                cell.titleLabel.textColor = colour2
                cell.logoView.tintColor = colour2
                cell.menuButton.tintColor = colour2
            // All White
            case 0,2,3,4,5,6:
                cell.titleLabel.textColor = colour1
                cell.logoView.tintColor = colour1
                cell.menuButton.tintColor = colour1
            //
            default: break
            }
            //
            return cell
        //
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "lessonsNavigationCell", for: indexPath) as! lessonsNavigationCell
            //
            cell.important.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.important.tag = 1
            cell.important.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)
            //
            cell.app.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.app.tag = 2
            cell.app.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)
            //
            cell.discussions.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.discussions.tag = 3
            cell.discussions.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)
            //
            cell.music.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.music.tag = 4
            cell.music.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)
            //
            return cell
        //
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "lessonsImportantCell", for: indexPath) as! lessonsImportantCell
            //
            // Border
            let border = CALayer()
            border.backgroundColor = UIColor.black.cgColor
            border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
            //
            cell.layer.addSublayer(border)
            cell.layer.masksToBounds = true
            //
            cell.backgroundColor = colour1
            //
            return cell
        // 
        case 3:
             let cell = tableView.dequeueReusableCell(withIdentifier: "lessonsAppCell", for: indexPath) as! lessonsAppCell
             //
             // Border
             let border = CALayer()
             border.backgroundColor = UIColor.black.cgColor
             border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
             //
             cell.layer.addSublayer(border)
             cell.layer.masksToBounds = true
             //
             cell.backgroundColor = colour1
             //
            return cell
        //
        case 4:
             let cell = tableView.dequeueReusableCell(withIdentifier: "lessonsMusicCell", for: indexPath) as! lessonsMusicCell
             //
             // Border
             let border = CALayer()
             border.backgroundColor = UIColor.black.cgColor
             border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
             //
             cell.layer.addSublayer(border)
             cell.layer.masksToBounds = true
             //
             cell.backgroundColor = colour1
             //
            return cell
        //
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "lessonsDiscussionsCell", for: indexPath) as! lessonsDiscussionsCell
            //
            // Border
            let border = CALayer()
            border.backgroundColor = UIColor.black.cgColor
            border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
            //
            cell.layer.addSublayer(border)
            cell.layer.masksToBounds = true
            //
            cell.backgroundColor = colour1
            //
            return cell
        //
        default: break
        }
        //
        return UITableViewCell()
        
//        
//            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//            let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//        
//        
//        
//            cell.textLabel?.text = NSLocalizedString(rowArray[indexPath.section][indexPath.row], comment: "")
//        
//        
//        
//            cell.textLabel?.textAlignment = NSTextAlignment.left
//            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//            cell.textLabel?.textAlignment = .left
//        
//            cell.tintColor = colour1
//            cell.accessoryType = .disclosureIndicator
//
//        
//            return cell
       
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
        //        let row0 = NSIndexPath(row: 2, section: 0)
        //        let row0Height = (tableView.cellForRow(at: row0 as IndexPath)?.frame.size.height)!
        //        //
        //        let row1 = NSIndexPath(row: 3, section: 0)
        //        let row1Height = (tableView.cellForRow(at: row1 as IndexPath)?.frame.size.height)!
        //        //
        //        let row2 = NSIndexPath(row: 4, section: 0)
        //        let row2Height = (tableView.cellForRow(at: row2 as IndexPath)?.frame.size.height)!
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
        case 4:
            let height = CGFloat(200 + 200 + 200)
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
    
    // Scroll Up Button Action
    func scrollUpButtonAction(_ sender: Any) {
        //
        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }

    
    
    
//
// Slide Menu ---------------------------------------------------------------------------------------------------------------------
//
    
    // Elements
    //
    @IBAction func swipeGesture(sender: UISwipeGestureRecognizer) {
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
