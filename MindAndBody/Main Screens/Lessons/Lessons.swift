
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
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add here incase image changed in settings
        addBackgroundImage(withBlur: true, fullScreen: false)
    }
    
    //
    override func viewDidLayoutSubviews() {
        // Tableview top view
        let topView = UIVisualEffectView()
        let topViewE = UIBlurEffect(style: .dark)
        topView.effect = topViewE
        topView.isUserInteractionEnabled = false
        topView.frame = CGRect(x: 0, y: tableView.frame.minY - tableView.bounds.height, width: tableView.bounds.width, height: tableView.bounds.height)
        //
        tableView.addSubview(topView)
    }
    
    
    //
    // TableView ------------------------------------------------------------------------------------
    //
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return rowArray.count
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        return NSLocalizedString(sectionArray[section], comment: "")
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 22)!
        header.textLabel?.textColor = Colors.light
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        //
        header.backgroundColor = .clear
        header.backgroundView = UIView()
        
        let separator = CALayer()
        separator.frame = CGRect(x: 15, y: header.frame.size.height - 1, width: view.frame.size.width, height: 1)
        separator.backgroundColor = Colors.light.cgColor
        separator.opacity = 0.5
        header.layer.addSublayer(separator)
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return rowArray[section].count
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        return 47
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
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
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
    
    // Mask cells under clear header
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in tableView.visibleCells {
            let hiddenFrameHeight = scrollView.contentOffset.y + navigationController!.navigationBar.frame.size.height - cell.frame.origin.y + 2
            if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
                maskCell(cell: cell, margin: Float(hiddenFrameHeight))
            }
        }
    }
    
    func maskCell(cell: UITableViewCell, margin: Float) {
        cell.layer.mask = visibilityMaskForCell(cell: cell, location: (margin / Float(cell.frame.size.height) ))
        cell.layer.masksToBounds = true
    }
    
    func visibilityMaskForCell(cell: UITableViewCell, location: Float) -> CAGradientLayer {
        let mask = CAGradientLayer()
        mask.frame = cell.bounds
        mask.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        mask.locations = [NSNumber(value: location), NSNumber(value: location)]
        return mask
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

