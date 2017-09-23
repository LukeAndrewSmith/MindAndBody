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
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    //
    let backgroundIndex = UserDefaults.standard.integer(forKey: "backgroundImage")
    let backgroundBlur = UIVisualEffectView()
    
    //
    // Arrays
    let sectionArray: [String] = ["me", "goals", "numberSessions"]
    
    // selected section
    var selectedSection = Int()
    
    
//
// View did load --------------------------------------------------------------------------------------------------------
//
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Present walkthrough 2
        if UserDefaults.standard.bool(forKey: "profileWalkthrough") == false {
            walkthroughProfile()
        }
        
        //
        // Background Image
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
        case 3: return 49
        default: return (view.bounds.height - 49) / 3
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
        case 3:
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
            centeredTextLabel.center = CGPoint(x: view.bounds.width/2, y: (view.bounds.height - 49)/6)
            cell.addSubview(centeredTextLabel)
            //
            cell.accessoryType = .disclosureIndicator
            // Border
            let seperator = CALayer()
            seperator.frame = CGRect(x: 0, y: (view.bounds.height - 49) / 3, width: view.frame.size.width, height: 1)
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
        case 3:
            
            
            performSegue(withIdentifier: "scheduleCreation", sender: self)
        default:
            // Selected section
            selectedSection = indexPath.row
            
            performSegue(withIdentifier: "profileDetail", sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
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
        //
        } else if (segue.identifier == "profileDetail") {
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = NSLocalizedString("done", comment: "")
            navigationItem.backBarButtonItem = backItem
            
            //
            let destinationVC = segue.destination as! ProfileDetail
            //
            destinationVC.selectedSection = selectedSection
        }
    }
    
    
    
    //
    // MARK: Walkthrough ------------------------------------------------------------------------------------------------------------------
    //
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabel = UILabel()
    var nextButton = UIButton()
    
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["profile0", "profile1"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    // Walkthrough
    func walkthroughProfile() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughProfile), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Walkthrough explanation
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = colour2
            walkthroughLabel.backgroundColor = colour1
            walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = colour1.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: view.bounds.width / 2, height: 36)
            walkthroughHighlight.center = CGPoint(x: view.frame.size.width / 2, y: ((view.bounds.height - 49) / 8) + CGFloat(TopBarHeights.navigationBarHeight) + 10)
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 2
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = colour1.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Menu
        case 1:
            //
            highlightSize = CGSize(width: view.bounds.width / 2, height: 36)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: TopBarHeights.combinedHeight + view.bounds.height - 24.5)
            highlightCornerRadius = 0
            //
            labelFrame = 1
            //
            walkthroughBackgroundColor = colour1
            walkthroughTextColor = colour2
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                UserDefaults.standard.set(true, forKey: "profileWalkthrough")
            })
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
