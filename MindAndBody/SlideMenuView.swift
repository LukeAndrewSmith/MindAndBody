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
            "profile",
            "settings"
        ]
    
    var rowIconArray: [UIImage] =
        [
            #imageLiteral(resourceName: "Mind&Body"),
            #imageLiteral(resourceName: "Calendar"),
            #imageLiteral(resourceName: "Graph"),
            #imageLiteral(resourceName: "QuestionMarkMenu"),
            #imageLiteral(resourceName: "Profile"),
            #imageLiteral(resourceName: "Settings")
        ]
    
//
// View Did Load ----------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
               
        //
        view.backgroundColor = colour1
        //
        menuTable.tableFooterView = UIView()
        menuTable.backgroundColor = colour1

    }
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        // Automatic Selection
        if automaticSelectionIsHappening == true {
            let indexPath = NSIndexPath(row: 0, section: 0)
            menuTable.selectRow(at: indexPath as IndexPath, animated: true, scrollPosition: .none)
            menuTable.delegate?.tableView!(menuTable, didSelectRowAt: indexPath as IndexPath)
        }
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
        cell.backgroundColor = colour1
        cell.textLabel?.textColor = colour2
        cell.tintColor = colour2
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
        if indexPath.row != tabBarIndex {
            new = true
            tabBarIndex = indexPath.row
        }
        
        //
        self.dismiss(animated: true, completion: { finished in
            var toVC = UIViewController()
                let viewNamesArray: [String] = ["view0", "view1", "view2", "view3", "view4", "view5"]
                //
                switch tabBarIndex {
                case 0:
                    toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! MindBodyNavigation
                //
                case 1:
                    toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! ScheduleNavigation
                //
                case 2:
                    toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! TrackingNavigation
                //
                case 3:
                    toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! LessonsNavigation
                //
                case 4:
                    toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! ProfileNavigation
                //
                case 5:
                    toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! SettingsNavigation
                //
                default: break
                }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = toVC
        })

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
        self.dismiss(animated: true)
    }
    
    
    @IBAction func closeMenu(_ sender: Any) {
        UIApplication.shared.statusBarStyle = .lightContent
        self.dismiss(animated: true)
    }
    
}
