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
            "home",
            "schedule",
            "tracking",
            "information",
            "profile",
            "settings"
        ]
    
    var rowIconArray: [UIImage] =
        [
            #imageLiteral(resourceName: "Mind&Body"),
            #imageLiteral(resourceName: "Calendar"),
            #imageLiteral(resourceName: "Graph"),
            #imageLiteral(resourceName: "QuestionMarkM"),
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
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
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
        
        let parent = presentingViewController
            
        self.dismiss(animated: true, completion:  { finished in
            //
            if indexPath.row != tabBarIndex {
                
            //
            tabBarIndex = indexPath.row
            //
            let viewNamesArray: [String] = ["view0", "view1", "view2", "view3", "view4", "view5"]
            //
            switch tabBarIndex {
            case 0:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! MindBodyNavigation
                //
                parent?.present(vc, animated: false, completion: nil)
            //
            case 1:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! CalendarNavigation
                //
                parent?.present(vc, animated: false, completion: nil)
            //
            case 2:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! TrackingNavigation
                //
                parent?.present(vc, animated: false, completion: nil)
            //
            case 3:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! InformationNavigation
                //
                parent?.present(vc, animated: false, completion: nil)
            //
            case 4:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! ProfileNavigation
                //
                parent?.present(vc, animated: false, completion: nil)
            //
            case 5:
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewNamesArray[tabBarIndex]) as! SettingsNavigation
                //
                parent?.present(vc, animated: false, completion: nil)
            //
            default: break
            }
            }
            
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
