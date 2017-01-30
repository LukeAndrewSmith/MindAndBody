//
//  Calendar.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class CalendarScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // CheckMark
    @IBOutlet weak var checkMark: UIBarButtonItem!
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // Arrays
    let daysArray =
    ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    
    let routineArray =
    [
        // Monday
        [
        ],
        // Tuesday
        [
        ],
        // Wednesday
        [
        ],
        // Thursday
        [
        ],
        // Friday
        [
        ],
        // Saturday
        [
        ],
        // Sunday
        [
        ]
    ]
    
    
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Background Gradient and Colour
        self.view.applyGradient(colours: [colour1, colour2])
        
        checkMark.tintColor = colour1
        
        self.navigationController?.navigationBar.tintColor = colour1
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colour1, NSFontAttributeName: UIFont(name: "SFUIDisplay-heavy", size: 23)!]
        
        
        // Navigation Title
        navigationBar.title = NSLocalizedString("calendar", comment: "")
        
        
        // Table View
        tableView.backgroundColor = .clear
        
    }
    
    
    
    
    
    // Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
            //daysArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(daysArray[section], comment: "")
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 19)!
        header.textLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        header.contentView.backgroundColor = .clear
        header.contentView.tintColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.textLabel?.text = "Test"
        
        //NSLocalizedString(warmupUpperArray[indexPath.section][indexPath.row], comment: "")
        
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        cell.tintColor = .black
        

        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 47
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
    
    }
    
    
    
    
    
    
    @IBAction func checkMarkAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        
    }
    
    
    
}
