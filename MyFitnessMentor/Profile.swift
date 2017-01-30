//
//  Profile.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class Profile: UITableViewController{
    
    //Outlets
    @IBOutlet weak var MyPreferencesNavigationBar: UINavigationItem!

    
    // Label Outlets
    
    
    
    
    //
    // Sections
    //
    struct Group {
        var name: String!
        var items: [String]!
        var collapsed: Bool!
        
        init(name: String, items: [String], collapsed: Bool = true) {
            self.name = name
            self.items = items
            self.collapsed = collapsed
        }
    }
    
    var meGroup = [Group]()
    var movementsGroup = [Group]()
    var volumeGroup = [Group]()
 

    override func viewWillAppear(_ animated: Bool) {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        self.tableView.backgroundView = backView
        
    }
    
    
    //
    // viewDidLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Colours
        let colour1 = UserDefaults.standard.color(forKey: "colour1")!
        let colour2 = UserDefaults.standard.color(forKey: "colour2")!
        
        self.navigationController?.navigationBar.barTintColor = colour1
        self.navigationController?.navigationBar.tintColor = .white
        
        self.tabBarController?.tabBar.tintColor = colour2
        
        
        
        
        
        
        // Initial Content Offset
        tableView.contentOffset.y = 0
        
        
        
        //
        // Initial Alert Suggesting reading the info
        //
//        let defaults = UserDefaults.standard
//        defaults.register(defaults: ["alertInfo2" : false])
//        
//        
//        if UserDefaults.standard.bool(forKey: "alertInfo2") == false {
//            
//            UserDefaults.standard.set(true, forKey: "alertInfo2")
//            
//            let alertInformation = UIAlertController(title: (NSLocalizedString("alertTitle2", comment: "")), message: (NSLocalizedString("alertMessage2", comment: "")), preferredStyle: UIAlertControllerStyle.alert)
//            
//            alertInformation.view.tintColor = .black
//            
//            alertInformation.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
//            
//            self.present(alertInformation, animated: true, completion: nil)
//            
//  
//       
//            self.tableView.setContentOffset(CGPoint.zero, animated: true)
//        }

        
        
        //
        // Title
        //
        
        self.navigationController?.navigationBar.topItem?.title = (NSLocalizedString("profile", comment: ""))
        
        
        
        
        // Initialize the sections array
        meGroup = [
            Group(name: (NSLocalizedString("gender", comment: "")),
                  items: [(NSLocalizedString("male", comment: "")), (NSLocalizedString("female", comment: ""))]),
            Group(name: (NSLocalizedString("experience", comment: "")),
                  items: [(NSLocalizedString("beginner", comment: "")), (NSLocalizedString("average", comment: "")), (NSLocalizedString("expert", comment: ""))]),
            
        ]
        
        
        movementsGroup = [
            Group(name: (NSLocalizedString("split", comment: "")),
                  items: [(NSLocalizedString("fullBody", comment: "")), (NSLocalizedString("upperLower", comment: "")), (NSLocalizedString("legsPullPush", comment: ""))]),
            Group(name: (NSLocalizedString("emphasis1", comment: "")),
                  items: [(NSLocalizedString("aesthetics", comment: "")), (NSLocalizedString("strength", comment: ""))]),
            Group(name: (NSLocalizedString("emphasis2", comment: "")),
                  items: [(NSLocalizedString("upper", comment: "")), (NSLocalizedString("lower", comment: ""))]),
            Group(name: (NSLocalizedString("freeWeightPreference", comment: "")),
                  items: [(NSLocalizedString("barbell", comment: "")), (NSLocalizedString("dumbell", comment: ""))]),
            Group(name: (NSLocalizedString("machineUsage", comment: "")),
                  items: [(NSLocalizedString("low", comment: "")), (NSLocalizedString("moderate", comment: "")), (NSLocalizedString("medium", comment: ""))]),
            
            
        ]
        
        
        volumeGroup = [
            Group(name: (NSLocalizedString("nSessions", comment: "")),
                  items: [(NSLocalizedString("2", comment: "")), (NSLocalizedString("3", comment: "")), (NSLocalizedString("4", comment: "")), (NSLocalizedString("5", comment: "")), (NSLocalizedString("6", comment: ""))]),
            Group(name: (NSLocalizedString("prefferedWorkoutLength", comment: "")),
                  items: [(NSLocalizedString("<60", comment: "")), (NSLocalizedString("60", comment: "")), (NSLocalizedString("90", comment: "")), (NSLocalizedString("120", comment: "")), (NSLocalizedString(">120", comment: ""))]),
            
        ]

        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    //
    // Table view delegates
    //
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:  return (NSLocalizedString("case0", comment: ""))
        case 1:  return (NSLocalizedString("case1", comment: ""))
        case 2:  return (NSLocalizedString("case2", comment: ""))
        default: return (NSLocalizedString("default", comment: ""))
        }
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 20)!
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
     
        
        
        // Border
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x: 15, y: header.frame.size.height-1, width: self.view.frame.size.height, height: 1)
        
        
        header.layer.addSublayer(border)
        header.layer.masksToBounds = true
        

    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //

        switch section{
        case 0:
            var count = meGroup.count
            for row in meGroup {
                print (row)
                count += row.items.count
            }
            
            return count
        case 1:
            var count = movementsGroup.count
        
            for row in movementsGroup {
                count += row.items.count
            }
        
            return count
        case 2:
            var count = volumeGroup.count
            
            for row in volumeGroup {
                count += row.items.count
            }
            
            return count
        default: return 0
    }
        
}
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Calculate the real section index
        let cellIndex = getSubSectionIndex(section: indexPath.section, row: indexPath.row)
        let rowIndex = getRowIndex(section: indexPath.section, row: indexPath.row)

        
        switch indexPath.section {
        case 0:
            if rowIndex == 0 {
                return 47.0
            } else {
            return meGroup[cellIndex].collapsed! ? 0.0 : 47.0
            }
        case 1:
            if rowIndex == 0{
                return 47.0
            } else {
            return movementsGroup[cellIndex].collapsed! ? 0.0 : 47.0
            }
        case 2:
            if rowIndex == 0 {
                return 47.0
            } else {
            return volumeGroup[cellIndex].collapsed! ? 0.0 : 47.0
            }
        default: return 47.0
        }
}
    
    
    
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // Calculate the real sub-section index and row index
        let subSection = getSubSectionIndex(section: indexPath.section, row: indexPath.row)
        let row = getRowIndex(section: indexPath.section, row: indexPath.row)
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let subcell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        
        switch indexPath.section{
        case 0:
            if row == 0 {
                cell.textLabel?.text = meGroup[subSection].name
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
                // UserDefaults
                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "\(meGroup[subSection].name)")
                cell.detailTextLabel?.textAlignment = NSTextAlignment.right
                cell.detailTextLabel?.textColor = UIColor.gray
                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 18)
                //
                return cell
            } else {
                subcell.textLabel?.text = meGroup[subSection].items[row - 1]
                subcell.textLabel?.textAlignment = NSTextAlignment.center
                subcell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 18)
                subcell.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
                let collapsedMe = meGroup[subSection].collapsed
                if collapsedMe == true{
                    subcell.textLabel?.alpha = 0
                }
                return subcell
            }
            
        case 1:
            if row == 0 {
                cell.textLabel?.text = movementsGroup[subSection].name
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
                // UserDefaults
                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "\(movementsGroup[subSection].name)")
                cell.detailTextLabel?.textAlignment = NSTextAlignment.right
                cell.detailTextLabel?.textColor = UIColor.gray
                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 18)

                //
                return cell
            } else {
                subcell.textLabel?.text = movementsGroup[subSection].items[row - 1]
                subcell.textLabel?.textAlignment = NSTextAlignment.center
                subcell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 18)
                subcell.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
                let collapsedMo = movementsGroup[subSection].collapsed
                if collapsedMo == true{
                    subcell.textLabel?.alpha = 0
                }
                return subcell
                
            }
            
        case 2:
            if row == 0 {
                cell.textLabel?.text = volumeGroup[subSection].name
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
                // UserDefaults
                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "\(volumeGroup[subSection].name)")
                cell.detailTextLabel?.textAlignment = NSTextAlignment.right
                cell.detailTextLabel?.textColor = UIColor.gray
                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 18)

                //
                return cell
            } else {
                subcell.textLabel?.text = volumeGroup[subSection].items[row - 1]
                subcell.textLabel?.textAlignment = NSTextAlignment.center
                subcell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 18)
                subcell.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
                let collapsedVo = volumeGroup[subSection].collapsed
                if collapsedVo == true{
                    subcell.textLabel?.alpha = 0
                }
                return subcell
                
            }
        default: return cell
    }

}
    
    
    
    //
    // Event Handlers
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Calculate the real sub-section index and row index
        let section = indexPath.section
        let subSection = getSubSectionIndex(section: indexPath.section, row: indexPath.row)
        let row = getRowIndex(section: indexPath.section, row: indexPath.row)
        // UserDefaults
        let cell = tableView.cellForRow(at: indexPath)
        let str = cell?.textLabel?.text
        
        if section == 0 {
            
            // UserDefaults
            if row != 0 {
                UserDefaults.standard.set("\(str!)", forKey: "\(meGroup[subSection].name)")
                UserDefaults.standard.synchronize()
            }
            
            
            let collapsed = meGroup[subSection].collapsed
            
            // Toggle collapse
            meGroup[subSection].collapsed = !collapsed!
            
            var indices = getHeaderIndices(section: 0)
            
            let start = indices[subSection]
            let end = start + meGroup[subSection].items.count
            
            tableView.beginUpdates()
            for i in start ..< end + 1 {
                tableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
            }
            tableView.endUpdates()
            
          
            //
            //
        } else if section == 1 {
            let collapsed = movementsGroup[subSection].collapsed
            
            // UserDefaults
            if row != 0 {
                UserDefaults.standard.set("\(str!)", forKey: "\(movementsGroup[subSection].name)")
                UserDefaults.standard.synchronize()
            }
            
            if subSection != 2 {
                
            
            // Toggle collapse
            movementsGroup[subSection].collapsed = !collapsed!
            
            let indices = getHeaderIndices(section: 1)
            
            let start = indices[subSection]
            let end = start + movementsGroup[subSection].items.count
            
            tableView.beginUpdates()
            for i in start ..< end + 1 {
                tableView.reloadRows(at: [IndexPath(row: i, section: 1)], with: .automatic)
            }
            tableView.endUpdates()
            
            } else {
                
                tableView.deselectRow(at: indexPath, animated: true)
                performSegue(withIdentifier: "emphasisSegue", sender: self)
                
            }
                
            
            //
            //
        } else if section == 2 {
            let collapsed = volumeGroup[subSection].collapsed
            
            // UserDefaults
            if row != 0 {
                UserDefaults.standard.set("\(str!)", forKey: "\(volumeGroup[subSection].name)")
                UserDefaults.standard.synchronize()
            }
            
            // Toggle collapse
            volumeGroup[subSection].collapsed = !collapsed!
            
            let indices = getHeaderIndices(section: 2)
            
            let start = indices[subSection]
            let end = start + volumeGroup[subSection].items.count
            
            
            tableView.beginUpdates()
            for i in start ..< end + 1 {
                tableView.reloadRows(at: [IndexPath(row: i, section: 2)], with: .automatic)
            
            }
            tableView.endUpdates()
            
            
            
            
        }
        
        
        
        
    }
  
    
    
    
    //
    // Helper Functions
    //
    func getSubSectionIndex(section: Int, row: NSInteger) -> Int {
        let indices = getHeaderIndices(section: section)
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                return i
            }
        }
        
        return -1
    }
    
    
    func getRowIndex(section: Int, row: NSInteger) -> Int {
        var index = row
        let indices = getHeaderIndices(section: section)
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                index -= indices[i]
                break
            }
        }
        
        return index
    }
    
    
    func getHeaderIndices(section: Int) -> [Int] {
        var index = 0
        var indices: [Int] = []
        
        
        switch section {
        case 0:
            for row in meGroup {
                indices.append(index)
                index += row.items.count + 1
            }
                return indices
        
        case 1:
            for row in movementsGroup {
                indices.append(index)
                index += row.items.count + 1
            }
                return indices
        
        
        case 2:
            for row in volumeGroup {
                indices.append(index)
                index += row.items.count + 1
            }
            return indices
        
        default: return [0]
        
    }
}

    
    

    
    
    
    
    
}
