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
            "calendar",
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    
    
    
//
// Dismiss ----------------------------------------------------------------------------------
//
    // 1
    var interactor:Interactor? = nil
    // 2
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        // 3
        let translation = sender.translation(in: view)
        // 4
        let progress = MenuHelper.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .Left
        )
        // 5
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor){
                // 6
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeMenu(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
