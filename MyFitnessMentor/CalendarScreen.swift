//
//  Calendar.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class CalendarScreen: UITableViewController {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // CheckMark
    @IBOutlet weak var checkMark: UIBarButtonItem!
    
    // Table View
    
    
    
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        self.tableView.backgroundView = backView
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Colours
        
        self.tableView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        checkMark.tintColor = .white
        
        
        self.navigationController?.navigationBar.tintColor = .white
     
        
        self.navigationController?.navigationBar.barTintColor = colour1
        
        
        
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 22)!]
        
        
    
        // Navigation Title
        navigationBar.title = NSLocalizedString("calendar", comment: "")
        
        
        // Table View
        tableView.backgroundColor = .clear
        
    }
    
    
    
    
    
    // Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
            //daysArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(daysArray[section], comment: "")
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-medium", size: 20)!
        header.textLabel?.textColor = .black
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        header.contentView.tintColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        
        // Border
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x: 15, y: header.frame.size.height-1, width: self.view.frame.size.height, height: 1)
        
        
        header.layer.addSublayer(border)
        header.layer.masksToBounds = true
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        
        //NSLocalizedString(warmupUpperArray[indexPath.section][indexPath.row], comment: "")
        
//        cell.textLabel?.textColor = .black
//        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//        cell.textLabel?.textAlignment = .left
//        cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//        cell.tintColor = .black
//        

        
        
        
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.tintColor = .black
            
            cell.imageView?.image = #imageLiteral(resourceName: "Plus")
        
            cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
            cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
            
            return cell
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 47
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
    
    }
    
    
    
    
    
    @IBAction func checkMarkAction(_ sender: Any) {
    
        self.performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        
    }
    
    
    
}
