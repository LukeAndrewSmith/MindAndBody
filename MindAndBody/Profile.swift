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
// Profile Class --------------------------------------------------------------------------------------------------------------------------------
//
class Profile: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var navigationBar: UINavigationItem!
    //
    @IBOutlet weak var tableView: UITableView!
    
    //
    let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
    let backgroundImageView = UIImageView()
    let backgroundBlur = UIVisualEffectView()
    
    //
    // Arrays
    let sectionArray: [String] = ["goals", "me", "time", "preferences"]
    
    // selected section
    var selectedSection = Int()
    
    
//
// View did load --------------------------------------------------------------------------------------------------------
//
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
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
        //
        // BackgroundBlur/Vibrancy
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        //
        backgroundBlur.frame = backgroundImageView.bounds
        //
        view.insertSubview(backgroundBlur, aboveSubview: backgroundImageView)

        // Tableview top view
        let topView = UIVisualEffectView()
        let topViewE = UIBlurEffect(style: .dark)
        topView.effect = topViewE
        topView.isUserInteractionEnabled = false
        //
        topView.frame = CGRect(x: 0, y: tableView.frame.minY - tableView.bounds.height, width: tableView.bounds.width, height: tableView.bounds.height)
        //
        tableView.addSubview(topView)
        
        // TableView Background
        tableView.backgroundColor = .clear
        tableView.backgroundView = UIView()
        tableView.separatorStyle = .none
        
        // Swipe to Menu
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.direction = .right
        rightSwipe.addTarget(self, action: #selector(swipeGesture(sender:)))
        tableView.addGestureRecognizer(rightSwipe)
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "profileWalkthrough") == false {
            UserDefaults.standard.set(true, forKey: "profileWalkthrough")
        }
        
        //  Navigation Bar
        //
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "SFUIDisplay-thin", size: 23)!]
        navigationBar.title = NSLocalizedString("profile", comment: "")
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
        case 4: return 49
        default: return (view.bounds.height - 49) / 4
        }
    }
        
    
    // Blurs
    let blur = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur3 = UIVisualEffectView()

    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        
        switch indexPath.row {
        case 4:
            //
            cell.textLabel?.text = "Update Schedule"
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = colour1
            //
            // BackgroundBlur/Vibrancy
            let backgroundBlur = UIVisualEffectView()
            let backgroundBlurE = UIBlurEffect(style: .dark)
            backgroundBlur.effect = backgroundBlurE
            backgroundBlur.isUserInteractionEnabled = false
            //
            backgroundBlur.frame = cell.bounds
            //
            cell.backgroundColor = colour3
            cell.backgroundView = backgroundBlur
            

        default:
            //
            cell.backgroundColor = .clear
            cell.backgroundView = UIView()
            //
            let centeredTextLabel = UILabel()
            centeredTextLabel.text = NSLocalizedString(sectionArray[indexPath.row], comment: "")
            centeredTextLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            centeredTextLabel.textAlignment = .center
            centeredTextLabel.sizeToFit()
            centeredTextLabel.textColor = colour1
            centeredTextLabel.center = CGPoint(x: view.bounds.width/2, y: (view.bounds.height - 49)/8)
            cell.addSubview(centeredTextLabel)
            //
            cell.accessoryType = .disclosureIndicator
            // Border
            let seperator = CALayer()
            seperator.frame = CGRect(x: 0, y: (view.bounds.height - 49) / 4, width: view.frame.size.width, height: 1)
            seperator.backgroundColor = colour1.cgColor
            seperator.opacity = 0.5
            cell.layer.addSublayer(seperator)
        }
        //
        return cell
    }
    

    // didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 4:
            break
        default:
            // Selected section
            selectedSection = indexPath.row
            
            performSegue(withIdentifier: "profileDetail", sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
//
// Walkthrough ----------------------------------------------------------------------------------------------------------------------------------
//
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
        //
        } else if (segue.identifier == "profileDetail") {
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
            //
            let destinationVC = segue.destination as! ProfileDetail
            //
            destinationVC.selectedSection = selectedSection
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
