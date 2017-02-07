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
    
    
    
    // Arrays
    let sectionArray =
        ["me", "movements", "volume"  ]
    
    
    let rowArray =
        [
            ["gender", "experience"],
            ["split", "emphasis", "freeWeightPreference", "nSessions", "prefferedWorkoutLength"]
    ]
    
    let selectionArray =
        [
            ["male", "female"],
            ["beginner", "average", "expert"],
            ["fullBody", "upperLower", "legsPullPush", "emphasis"],
            ["aesthetics", "strength"],
            ["barbell", "dumbell", "machineUsage", "low", "moderate", "medium"],
            ["2", "3", "4", "5", "6"],
            ["<60", "60", "90", "120"]
        ]
    
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
        
        walkthroughMindBody()
        
        // Set Colours
        let colour1 = UserDefaults.standard.color(forKey: "colour1")!
        let colour2 = UserDefaults.standard.color(forKey: "colour2")!
        
        self.navigationController?.navigationBar.barTintColor = colour1
        self.navigationController?.navigationBar.tintColor = .white
        
        self.tabBarController?.tabBar.tintColor = colour2
        
        
        
        
        
        
        // Initial Content Offset
        tableView.contentOffset.y = 0
        
        
        //
        // Title
        //
        self.navigationController?.navigationBar.topItem?.title = (NSLocalizedString("profile", comment: ""))
        
        
        
        
        // Initialize the sections array
        meGroup = [
            Group(name: "gender", items: ["male", "female"]),
            Group(name: "experience", items: ["beginner", "average", "expert"])
        ]
        
        
        movementsGroup = [
            Group(name: "split", items: ["fullBody", "upperLower", "legsPullPush"]),
            Group(name: "emphasis", items: ["aesthetics", "strength"]),
            Group(name: "freeWeightPreference", items: ["barbell", "dumbell"]),
            Group(name: "machineUsage", items: ["low", "moderate", "medium"]),
        ]
        
        
        volumeGroup = [
            Group(name: "nSessions", items: ["2", "3", "4", "5", "6"]),
            Group(name: "prefferedWorkoutLength", items: ["<60", "60", "90", "120", ">120"])
        ]

        
      
        
    }
    
    
    
    
    //
    // Table view delegates
    //
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section]
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
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
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
                cell.textLabel?.text = NSLocalizedString(meGroup[subSection].name, comment: "")
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
                subcell.textLabel?.text = NSLocalizedString(meGroup[subSection].items[row - 1], comment: "")
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
                cell.textLabel?.text = NSLocalizedString(movementsGroup[subSection].name, comment: "")
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
                subcell.textLabel?.text = NSLocalizedString(movementsGroup[subSection].items[row - 1], comment: "")
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
                cell.textLabel?.text = NSLocalizedString(volumeGroup[subSection].name, comment: "")
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
                subcell.textLabel?.text = NSLocalizedString(volumeGroup[subSection].items[row - 1], comment: "")
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

    
    
    
//---------------------------------------------------------------------------------------------------------------
    
    
    var  viewNumber = 0
    let walkthroughView = UIView()
    let label = UILabel()
    let nextButton = UIButton()
    let backButton = UIButton()
    
    
    
    // Walkthrough
    func walkthroughMindBody() {
        
        //
        let screenSize = UIScreen.main.bounds
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        
        //
        walkthroughView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        walkthroughView.backgroundColor = .black
        walkthroughView.alpha = 0.72
        walkthroughView.clipsToBounds = true
        //
        
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        label.center = view.center
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "SFUIDisplay-light", size: 23)
        label.textColor = .white
        
        //
        nextButton.frame = screenSize
        nextButton.backgroundColor = .clear
        nextButton.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
        //
        backButton.frame = CGRect(x: 3, y: UIApplication.shared.statusBarFrame.height, width: 50, height: navigationBarHeight)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.textAlignment = .left
        backButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        backButton.titleLabel?.textColor = .white
        backButton.addTarget(self, action: #selector(backWalkthroughView(_:)), for: .touchUpInside)
        
        
        
        switch viewNumber {
        case 0:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: view.frame.size.width/2 - 80, y: UIApplication.shared.statusBarFrame.height, width: 160, height: 40))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("profile1", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            
            
        //
        case 1:
            //
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width - 31, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            //
            
            label.text = NSLocalizedString("profile2", comment: "")
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)

            
            
            
        //
        default: break
            
            
        }
        
        
    }
    
    
    
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }

    
    
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
        
    }

    
    
    
    
}
