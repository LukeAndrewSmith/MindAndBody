
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
    var selectedTopic = 0
    
    // NOTE: Tableview section for each cell to create spacing between cells
    //
    let sectionArray: [String] =
        ["mind", "body", "", ""]
    //
    let rowArray: [String] =
            ["effort", "breathingWorkout", "breathingYoga", "coreActivation"]
    //
    var backgroundImages: [UIImage] = []
    
    
    let cellHeight: CGFloat = 88
    
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
        
        backgroundImages = [#imageLiteral(resourceName: "Effort"), #imageLiteral(resourceName: "BreathingWorkout"), getUncachedImage(named: "upwardsDogY")!, getUncachedImage(named: "plank")!]
            
        //
        let settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        backgroundIndex = settings["BackgroundImage"]![0]
        
        //
        tableView.backgroundColor = Colors.gray
        
        //  Navigation Bar
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("lessons", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)
        
        // Table View
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 24.5)
        headerView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: tableView.sectionFooterHeight)
        footerView.backgroundColor = .clear
        tableView.tableFooterView = footerView
        
        tableView.separatorStyle = .none
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Show status bar
        UIApplication.shared.isStatusBarHidden = false
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
        label.font = Fonts.verySmallElementRegular!
        label.textColor = Colors.dark
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
        if sectionArray[section] != "" {
            return 24.5
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 22
        } else {
            return 4
        }
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return 1
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        return cellHeight
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)

        let backgroundImage = UIImageView()
        backgroundImage.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: cellHeight)
        backgroundImage.image = backgroundImages[indexPath.section]
        backgroundImage.contentMode = .scaleAspectFill
        if indexPath.section == 0 {
            backgroundImage.center.y -= 36
        } else if indexPath.section > 1 {
            backgroundImage.contentMode = .scaleAspectFit
        }
        cell.addSubview(backgroundImage)
        
        let title = UILabel()
        title.text = NSLocalizedString(rowArray[indexPath.section], comment: "")
        title.font = Fonts.lessonSubtitle
        title.textColor = Colors.light
        if indexPath.section > 1 {
            title.textColor = Colors.dark
            cell.backgroundColor = Colors.darkGray
        }
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        let size = title.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        title.frame = CGRect(x: 16, y: cellHeight - size.height - 8, width: view.bounds.width - 32, height: size.height)
        cell.addSubview(title)
        
        cell.clipsToBounds = true
        
        return cell
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Selected Topic
        selectedTopic = indexPath.section
        
        // Hide status bar
        UIView.animate(withDuration: 0.25) {
            UIApplication.shared.isStatusBarHidden = true
        }
        
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
            destinationVC.lesson = rowArray[selectedTopic]
        }
    }
}

class LessonsNavigation: UINavigationController {
    
}

