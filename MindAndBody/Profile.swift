//
//  Profile.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Custom Profile Cells -------------------------------------------------------------------------------------------------------------------------
//

// Title Cell
class headerCell: UITableViewCell {
    //
    @IBOutlet weak var titleLabel: UILabel!
        
    @IBOutlet weak var logoView: UIImageView!
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var stackViewTitle: UIStackView!
}


//
// Profile Class --------------------------------------------------------------------------------------------------------------------------------
//
class Profile: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var MyPreferencesNavigationBar: UINavigationItem!
    
    //
    @IBOutlet weak var tableView: UITableView!
    
    
    // Background Colour View
    let backView = UIView()
    
    
    //
    // Arrays
    let sectionArray: [String] = ["Goals", "Me", "Time", "Preferences"]
    
    
//
// View will appear --------------------------------------------------------------------------------------------------------
//
    let blur4 = UIVisualEffectView()
    var addedToApplication = false
    override func viewWillAppear(_ animated: Bool) {
        //
        tableView.setContentOffset(CGPoint(x: 0, y: -20), animated: false)
        
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
// View will dissapear --------------------------------------------------------------------------------------------------------
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
// View did load --------------------------------------------------------------------------------------------------------
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
            backgroundImageView.image = getUncachedImage(named: backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = colour1
        }
        //
        self.tableView.backgroundView = backgroundImageView

        
        // Initial TableView Position
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        // Swipe to Menu
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.direction = .right
        rightSwipe.addTarget(self, action: #selector(swipeGesture(sender:)))
        tableView.addGestureRecognizer(rightSwipe)
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "profileWalkthrough") == false {
            self.walkthroughMindBody()
            UserDefaults.standard.set(true, forKey: "profileWalkthrough")
        }
        
        //  Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //
        self.navigationController?.navigationBar.barTintColor = colour2
        self.navigationController?.navigationBar.tintColor = colour1
        
    }
    
    
//
// Table View --------------------------------------------------------------------------------------------------------
//
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //
            return sectionArray.count + 1
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch indexPath.row {
        case 0:
            return view.bounds.height / 3
        case 1,2,3:
            return (view.bounds.height * (2/3)) / 3
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
        //
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! headerCell
            //
            cell.titleLabel.text = NSLocalizedString("profile", comment: "")
            //
            cell.contentView.backgroundColor = .clear
            //
            cell.selectionStyle = .none
            
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
        case 1,2,3:
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            //
            // Border
            cell.backgroundColor = colour1
            //
            cell.textLabel?.text = sectionArray[indexPath.row - 1]
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .disclosureIndicator
            //
            return cell
        //
        default: break
        }
        //
        return UITableViewCell()
    }

    // didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // UserDefaults
        let cell = tableView.cellForRow(at: indexPath)
        
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
//
// Walkthrough ----------------------------------------------------------------------------------------------------------------------------------
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
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        
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
        backButton.frame = CGRect(x: 3, y: UIApplication.shared.statusBarFrame.height, width: 50, height: navigationBarHeight)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.textAlignment = .left
        backButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        backButton.titleLabel?.textColor = .white
        backButton.addTarget(self, action: #selector(backWalkthroughView(_:)), for: .touchUpInside)
        
        //
        switch viewNumber {
        //
        case 0:
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: view.frame.size.width/2 - 50
                , y: 94, width: 100, height: 40))
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
            label.text = NSLocalizedString("profile1", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
        //
        case 1:
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width - 22, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 18, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)

            //
            label.text = NSLocalizedString("profile2", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
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
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            label.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
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
        }
    }
//
}



//
// Slide Menu Extension
extension Profile: UIViewControllerTransitioningDelegate {
    // Present
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    // Dismiss
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
}



class ProfileNavigation: UINavigationController {
    
}
