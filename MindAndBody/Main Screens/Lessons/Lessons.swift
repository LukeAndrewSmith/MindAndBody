
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
// Session Screen Overview Class ------------------------------------------------------------------------------------
//
class Lessons: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    //
    @IBOutlet weak var tableView: UITableView!
    
    //
    var backgroundIndex = Int()
    let backgroundBlur = UIVisualEffectView()
    
    
    // Selected Topic
    var selectedTopic = [0,0]
    
    // Arrays
    let sectionArray: [String] =
        ["mind", "body"]
    //
    let rowArray: [[String]] =
        [
            ["effort"],
            ["breathingWorkout", "breathingYoga", "coreActivation"],
        ]
    
    //
    // Blurs
    let blur = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur3 = UIVisualEffectView()
    
    //
    // View did load ------------------------------------------------------------------------------------
    //
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
            
        //
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        backgroundIndex = settings["BackgroundImage"]![0]
        
        //
        tableView.backgroundColor = .clear
        tableView.backgroundView = UIView()
        
        //
        //  Navigation Bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBar!]
        navigationBar.title = NSLocalizedString("lessons", comment: "")
        self.navigationController?.navigationBar.barTintColor = Colors.dark
        self.navigationController?.navigationBar.tintColor = Colors.light
        
        // Table View
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 24.5)
        headerView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: tableView.sectionFooterHeight)
        footerView.backgroundColor = .clear
        tableView.tableFooterView = footerView
        
        tableView.separatorColor = Colors.light.withAlphaComponent(0.43)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add here incase image changed in settings
        addBackgroundImage(withBlur: true, fullScreen: false)
    }
    
    //
    // TableView ------------------------------------------------------------------------------------
    //
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return rowArray.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Header
        let header = UIView()
        let headerHeight = CGFloat(24.5)
        header.backgroundColor = .clear
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = Fonts.tinyElementLight!
        label.textColor = Colors.light
        label.text = NSLocalizedString(sectionArray[section], comment: "").uppercased()
        label.sizeToFit()
        label.frame = CGRect(x: 16, y: 0, width: label.bounds.width, height: headerHeight)
        header.addSubview(label)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.frame = CGRect.zero
        footer.backgroundColor = .clear
        return footer
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24.5
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return rowArray[section].count
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        return 44
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        //
        cell.textLabel?.text = NSLocalizedString(rowArray[indexPath.section][indexPath.row], comment: "")
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.backgroundColor = .clear
        cell.backgroundView = UIView()
        cell.textLabel?.font = Fonts.regularCell
        cell.textLabel?.textColor = Colors.light
        //
        // Indicator
        cell.accessoryType = .disclosureIndicator
        //
        return cell
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        tableView.deselectRow(at: indexPath, animated: true)
        //
        // Selected Topic
        selectedTopic[0] = indexPath.section
        selectedTopic[1] = indexPath.row
        //
        // Perform Segue
        performSegue(withIdentifier: "lessonsSegue", sender: nil)
    }
    
    //
    // Button Actions ------------------------------------------------------------------------------------
    //
    // Button Actions
    func navigationButtonAction(_ sender: Any) {
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
        default: break
        }
    }
    
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Remove back button text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        // Pass Info
        if (segue.identifier == "lessonsSegue") {
            
            let destinationVC = segue.destination as! LessonsScreen
            destinationVC.selectedLesson = selectedTopic
            destinationVC.lessonsArray = rowArray
        }
    }
}

class LessonsNavigation: UINavigationController {
    
}

