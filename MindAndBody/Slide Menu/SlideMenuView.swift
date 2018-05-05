//
//  SlideMenuView.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



//
// Slide Menu Class ----------------------------------------------------------------------------------
//
class SlideMenuView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //
    // Outlets ----------------------------------------------------------------------------------
    //
    @IBOutlet weak var menuTable: UITableView!
    
    
    //
    // Arrays ----------------------------------------------------------------------------------
    //
    var rowTitleArray: [String] =
        [
            "sessions",
            "schedule",
            "tracking",
            "lessons",
            //            "profile",
            "settings"
    ]
    
    var rowIconArray: [UIImage] =
        [
            #imageLiteral(resourceName: "Mind&Body"),
            #imageLiteral(resourceName: "Calendar"),
            #imageLiteral(resourceName: "Graph"),
            #imageLiteral(resourceName: "QuestionMarkMenu"),
            //            #imageLiteral(resourceName: "Profile"),
            #imageLiteral(resourceName: "Settings")
    ]
    
    //
    // View Did Load ----------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        view.backgroundColor = Colors.light
        //
        menuTable.tableFooterView = UIView()
        menuTable.backgroundColor = Colors.light
        
    }
    
    //
    // TableView ----------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowTitleArray.count
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        // Cell
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        //
        cell.textLabel?.text = NSLocalizedString(rowTitleArray[indexPath.row], comment: "")
        //
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = Colors.light
        cell.textLabel?.textColor = Colors.dark
        cell.tintColor = Colors.dark
        //
        // Cell Image
        cell.imageView?.image = rowIconArray[indexPath.row]
        //
        return cell
        //
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //
//        if indexPath.row != MenuVariables.shared.menuIndex {
            MenuVariables.shared.isNewView = true
            MenuVariables.shared.menuIndex = indexPath.row
//        } else {
//            MenuVariables.shared.isNewView = false
//        }
        
        //
        self.dismiss(animated: true) {
            var toVC = UIViewController()
            let viewNamesArray: [String] = ["view0", "view1", "view2", "view3", "view4"]
            //
            switch MenuVariables.shared.menuIndex {
            case 0:
                toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! MindBodyNavigation
            //
            case 1:
                toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! ScheduleNavigation
            //
            case 2:
                toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! TrackingNavigation
            //
            case 3:
                toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! LessonsNavigation
            //
            case 4:
                toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[MenuVariables.shared.menuIndex]) as! SettingsNavigation
            //
            default: break
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = toVC
        }
        
        //
        UIApplication.shared.statusBarStyle = .lightContent
        //
        tableView.deselectRow(at: indexPath, animated: true)
        
        //
    }
    
    
    
    
    //
    // Dismiss ----------------------------------------------------------------------------------
    //
    @IBAction func swipeCloseGesture(_ sender: Any) {
        //
        UIApplication.shared.statusBarStyle = .lightContent
        MenuVariables.shared.isNewView = false
        self.dismiss(animated: true)
    }
    
    // Button close menu
    @IBAction func closeMenu(_ sender: Any) {
        MenuVariables.shared.menuInteractionType = 0
        UIApplication.shared.statusBarStyle = .lightContent
        MenuVariables.shared.isNewView = false
        self.dismiss(animated: true)
    }
    
}

