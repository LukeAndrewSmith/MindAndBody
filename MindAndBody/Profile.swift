//
//  Profile.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Custom Profile Cells -------------------------------------------------------------------------------------------------------------------------
//

// Title Cell
class headerCell: UITableViewCell {
    //
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var logoView: UIImageView!
    
    @IBOutlet weak var gradientView: UIView!
}

// Navigation Cell
class profileNavigationCell: UITableViewCell {
    
    @IBOutlet weak var me: UIButton!
    
    @IBOutlet weak var goals: UIButton!
    
    @IBOutlet weak var body: UIButton!
    
    @IBOutlet weak var mind: UIButton!
}

//
class profileMeCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

//
class profileGoalsCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

//
class profileBodyCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

//
class profileMindCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}


//
// Profile Class --------------------------------------------------------------------------------------------------------------------------------
//
class Profile: UITableViewController{
    
    //Outlets
    @IBOutlet weak var MyPreferencesNavigationBar: UINavigationItem!
    
    // Background Colour View
    let backView = UIView()
    
    //
    let scrollUpButton = UIButton()
    
    // Arrays
    let sectionArray: [String] =
        ["", "me", "goals", "workout", "cardio", "stretching", "yoga", "meditation"]
    
   
//    let rowArray =
//        [
//            ["gender", "experience"],
//            ["split", "emphasis", "freeWeightPreference", "nSessions", "prefferedWorkoutLength"]
//    ]
//    
//    let selectionArray =
//        [
//            ["male", "female"],
//            ["beginner", "average", "expert"],
//            ["fullBody", "upperLower", "legsPullPush", "emphasis"],
//            ["aesthetics", "strength"],
//            ["barbell", "dumbell", "machineUsage", "low", "moderate", "medium"],
//            ["2", "3", "4", "5", "6"],
//            ["<60", "60", "90", "120"]
//        ]
    
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
    
    //
    var meGroup = [Group]()
    var goalsGroup = [Group]()
    var workoutGroup = [Group]()
    var cardioGroup = [Group]()
    var stretchingGroup = [Group]()
    var yogaGroup = [Group]()
    var meditationGroup = [Group]()
 
    
//
// View will appear --------------------------------------------------------------------------------------------------------
//
    override func viewWillAppear(_ animated: Bool) {
        //
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    
//
// View will dissapear --------------------------------------------------------------------------------------------------------
//
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        UIApplication.shared.statusBarStyle = .lightContent
        //
        scrollUpButton.removeFromSuperview()
    }
    
    
//
// View did load --------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "profileWalkthrough") == false {
            self.walkthroughMindBody()
            UserDefaults.standard.set(true, forKey: "profileWalkthrough")
        }
        
        //
        self.navigationController?.navigationBar.barTintColor = colour2
        //
        self.tabBarController?.tabBar.tintColor = colour1
        
        // Initial Content Offset
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        // Title
        //
        self.navigationController?.navigationBar.topItem?.title = (NSLocalizedString("profile", comment: ""))
        
        // Background Coolour
        backView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        //
        self.tableView.backgroundView = backView
        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        //
        
        // Scroll Up Button
        scrollUpButton.frame = CGRect(x: view.frame.size.width - 59, y: view.frame.size.height - UIApplication.shared.statusBarFrame.height - 88.5, width: 44, height: 44)
        //
        scrollUpButton.layer.borderWidth = 2
        scrollUpButton.layer.borderColor = colour2.cgColor
        scrollUpButton.layer.cornerRadius = 22
        //
        scrollUpButton.backgroundColor = colour1
        //
        scrollUpButton.setImage(#imageLiteral(resourceName: "Up Arrow"), for: .normal)
        scrollUpButton.tintColor = colour2
        //
        scrollUpButton.addTarget(self, action: #selector(scrollUpButtonAction(_:)), for: .touchUpInside)

        // Initialize the sections array
        meGroup = [
            Group(name: "gender", items: ["male", "female"]),
            Group(name: "experience", items: ["beginner", "average", "expert"])
        ]
        //
        goalsGroup = [
            Group(name: "split", items: ["fullBody", "upperLower", "legsPullPush"]),
            Group(name: "emphasis", items: ["aesthetics", "strength"]),
            Group(name: "freeWeightPreference", items: ["barbell", "dumbell"]),
            Group(name: "machineUsage", items: ["low", "moderate", "medium"]),
        ]
        //
        workoutGroup = [
            Group(name: "nSessions", items: ["2", "3", "4", "5", "6"]),
            Group(name: "prefferedWorkoutLength", items: ["<60", "60", "90", "120", ">120"])
        ]
        //
        cardioGroup = [
            Group(name: "nSessions", items: ["2", "3", "4", "5", "6"]),
            Group(name: "prefferedWorkoutLength", items: ["<60", "60", "90", "120", ">120"])
        ]
        //
        stretchingGroup = [
            Group(name: "nSessions", items: ["2", "3", "4", "5", "6"]),
            Group(name: "prefferedWorkoutLength", items: ["<60", "60", "90", "120", ">120"])
        ]
        //
        yogaGroup = [
            Group(name: "nSessions", items: ["2", "3", "4", "5", "6"]),
            Group(name: "prefferedWorkoutLength", items: ["<60", "60", "90", "120", ">120"])
        ]
        //
        meditationGroup = [
            Group(name: "nSessions", items: ["2", "3", "4", "5", "6"]),
            Group(name: "prefferedWorkoutLength", items: ["<60", "60", "90", "120", ">120"])
        ]
    }
    
    
//
// Watch scroll view --------------------------------------------------------------------------------------------------------
//
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
        if scrollView == tableView {
            //
            if tableView.contentOffset.y > 186 {
                //
                UIApplication.shared.keyWindow?.insertSubview(scrollUpButton, aboveSubview: self.tableView)
                //
                backView.backgroundColor = colour1
                UIApplication.shared.statusBarStyle = .default
            //
            } else {
                //
                self.scrollUpButton.removeFromSuperview()
                //
                backView.backgroundColor = colour2
                UIApplication.shared.statusBarStyle = .lightContent
            }
        }
    }
    
    
//
// Table View --------------------------------------------------------------------------------------------------------
//
    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionArray[section]
//    }
//    
//    
//    
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//    {
//        // Header
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 21)!
//        header.textLabel?.textColor = .black
//        header.textLabel?.text = header.textLabel?.text?.capitalized
//        
//        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//     
//        
//        
//        // Border
//        let border = CALayer()
//        border.backgroundColor = UIColor.black.cgColor
//        border.frame = CGRect(x: 15, y: header.frame.size.height-1, width: self.view.frame.size.height, height: 1)
//        
//        
//        header.layer.addSublayer(border)
//        header.layer.masksToBounds = true
//        
//    }
//    
//    
//    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        //if section == 0 {
//            return 0
////        } else {
////        return 47
////        }
//    }
//    
    
    // Number of row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //

//        switch section{
//        case 0:
            return 6
        //
//        case 1:
//            var count = meGroup.count
//            for row in meGroup {
//                print (row)
//                count += row.items.count
//            }
//            
//            return count
//        //
//        case 2:
//            var count = goalsGroup.count
//        
//            for row in goalsGroup {
//                count += row.items.count
//            }
//        
//            return count
//        //
//        case 3:
//            var count = workoutGroup.count
//            
//            for row in workoutGroup {
//                count += row.items.count
//            }
//            
//            return count
//        //
//        case 4:
//            var count = cardioGroup.count
//            for row in cardioGroup {
//                print (row)
//                count += row.items.count
//            }
//            
//            return count
//        //
//        case 5:
//            var count = stretchingGroup.count
//            for row in stretchingGroup {
//                print (row)
//                count += row.items.count
//            }
//            
//            return count
//        //
//        case 6:
//            var count = yogaGroup.count
//            for row in yogaGroup {
//                print (row)
//                count += row.items.count
//            }
//            
//            return count
//        //
//        case 7:
//            var count = meditationGroup.count
//            for row in meditationGroup {
//                print (row)
//                count += row.items.count
//            }
//            
//            return count
        //
//        default: return 0
//    }
        
}
    
    // Height for row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch indexPath.row {
        case 0:
            return 152
        case 1:
            return 44
        case 2,3,4,5:
            return 200
        default: break
        }
        return 0
        
        // Calculate the real section index
//        let cellIndex = getSubSectionIndex(section: indexPath.section, row: indexPath.row)
//        let rowIndex = getRowIndex(section: indexPath.section, row: indexPath.row)

        
//        switch indexPath.section {
//        case 0:
        
        //
//        case 1:
//            if rowIndex == 0 {
//                return 47.0
//            } else {
//            return meGroup[cellIndex].collapsed! ? 0.0 : 47.0
//            }
//        //
//        case 2:
//            if rowIndex == 0{
//                return 47.0
//            } else {
//            return goalsGroup[cellIndex].collapsed! ? 0.0 : 47.0
//            }
//        //
//        case 3:
//            if rowIndex == 0 {
//                return 47.0
//            } else {
//            return workoutGroup[cellIndex].collapsed! ? 0.0 : 47.0
//            }
//        //
//        case 4:
//            if rowIndex == 0{
//                return 47.0
//            } else {
//            return cardioGroup[cellIndex].collapsed! ? 0.0 : 47.0
//            }
//        //
//        case 5:
//            if rowIndex == 0{
//                return 47.0
//            } else {
//            return stretchingGroup[cellIndex].collapsed! ? 0.0 : 47.0
//            }
//        //
//        case 6:
//            if rowIndex == 0{
//                return 47.0
//            } else {
//            return yogaGroup[cellIndex].collapsed! ? 0.0 : 47.0
//            }
//        //
//        case 7:
//            if rowIndex == 0{
//                return 47.0
//            } else {
//            return meditationGroup[cellIndex].collapsed! ? 0.0 : 47.0
//            }
        //
//        default: return 47.0
//        }
}
    
    // Cell for row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        switch indexPath.row {
        //
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! headerCell
            //
            cell.settingButton.addTarget(self, action: #selector(settingsButtonAction(_:)), for: .touchUpInside)
            //
            cell.gradientView.frame = cell.bounds
            //
            cell.titleLabel.text = NSLocalizedString("profile", comment: "")
            cell.titleLabel.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            //
            cell.gradientView.applyGradient(colours: [UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0), UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0)])
            //
            cell.logoView.tintColor = colour1
            //
            cell.selectionStyle = .none
            //
            return cell
        //
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileNavigationCell", for: indexPath) as! profileNavigationCell
            //cell.profileTitle.text = NSLocalizedString("profile", comment: "")
            //cell.settingButton.tintColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            //cell.selectionStyle = .none
            //
            cell.me.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.me.tag = 1
            cell.me.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)
            //
            cell.goals.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.goals.tag = 2
            cell.goals.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)
            //
            cell.body.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.body.tag = 3
            cell.body.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)
            //
            cell.mind.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.mind.tag = 4
            cell.mind.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)
            //
            return cell
        //
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileMeCell", for: indexPath) as! profileMeCell
            // Border
            let border = CALayer()
            border.backgroundColor = UIColor.black.cgColor
            border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
            //
            cell.layer.addSublayer(border)
            cell.layer.masksToBounds = true
            //
            cell.backgroundColor = colour1
            //
            return cell
        //
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileGoalsCell", for: indexPath) as! profileGoalsCell
            // Border
            let border = CALayer()
            border.backgroundColor = UIColor.black.cgColor
            border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
            //
            cell.layer.addSublayer(border)
            cell.layer.masksToBounds = true
            //
            cell.backgroundColor = colour1
            //
            return cell
        //
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileBodyCell", for: indexPath) as! profileBodyCell
            // Border
            let border = CALayer()
            border.backgroundColor = UIColor.black.cgColor
            border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
            //
            cell.layer.addSublayer(border)
            cell.layer.masksToBounds = true
            //
            cell.backgroundColor = colour1
            //
            return cell
        //
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileMindCell", for: indexPath) as! profileMindCell
            // Border
            let border = CALayer()
            border.backgroundColor = UIColor.black.cgColor
            border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
            //
            cell.layer.addSublayer(border)
            cell.layer.masksToBounds = true
            //
            cell.backgroundColor = colour1
            //
            return cell
        //
        default: break
        }
        //
        return UITableViewCell()
        
        
        // Calculate the real sub-section index and row index
//        let subSection = getSubSectionIndex(section: indexPath.section, row: indexPath.row)
//        let row = getRowIndex(section: indexPath.section, row: indexPath.row)
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//        let subcell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        
        
//        switch indexPath.section{
//        case 0:
                    //
//        case 1:
//            if row == 0 {
//                cell.textLabel?.text = NSLocalizedString(meGroup[subSection].name, comment: "")
//                cell.textLabel?.textAlignment = NSTextAlignment.left
//                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//                // UserDefaults
//                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "\(meGroup[subSection].name)")
//                cell.detailTextLabel?.textAlignment = NSTextAlignment.right
//                cell.detailTextLabel?.textColor = UIColor.gray
//                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                //
//                return cell
//            } else {
//                subcell.textLabel?.text = NSLocalizedString(meGroup[subSection].items[row - 1], comment: "")
//                subcell.textLabel?.textAlignment = NSTextAlignment.center
//                subcell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                subcell.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
//                let collapsedMe = meGroup[subSection].collapsed
//                if collapsedMe == true{
//                    subcell.textLabel?.alpha = 0
//                }
//                return subcell
//            }
//            
//        //
//        case 2:
//            if row == 0 {
//                cell.textLabel?.text = NSLocalizedString(goalsGroup[subSection].name, comment: "")
//                cell.textLabel?.textAlignment = NSTextAlignment.left
//                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//                // UserDefaults
//                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "\(goalsGroup[subSection].name)")
//                cell.detailTextLabel?.textAlignment = NSTextAlignment.right
//                cell.detailTextLabel?.textColor = UIColor.gray
//                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//
//                //
//                return cell
//            } else {
//                subcell.textLabel?.text = NSLocalizedString(goalsGroup[subSection].items[row - 1], comment: "")
//                subcell.textLabel?.textAlignment = NSTextAlignment.center
//                subcell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                subcell.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
//                let collapsedMo = goalsGroup[subSection].collapsed
//                if collapsedMo == true{
//                    subcell.textLabel?.alpha = 0
//                }
//                return subcell
//                
//            }
//           
//        //
//        case 3:
//            if row == 0 {
//                cell.textLabel?.text = NSLocalizedString(workoutGroup[subSection].name, comment: "")
//                cell.textLabel?.textAlignment = NSTextAlignment.left
//                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//                // UserDefaults
//                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "\(workoutGroup[subSection].name)")
//                cell.detailTextLabel?.textAlignment = NSTextAlignment.right
//                cell.detailTextLabel?.textColor = UIColor.gray
//                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//
//                //
//                return cell
//            } else {
//                subcell.textLabel?.text = NSLocalizedString(workoutGroup[subSection].items[row - 1], comment: "")
//                subcell.textLabel?.textAlignment = NSTextAlignment.center
//                subcell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                subcell.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
//                let collapsedVo = workoutGroup[subSection].collapsed
//                if collapsedVo == true{
//                    subcell.textLabel?.alpha = 0
//                }
//                return subcell
//                
//            }
//            
//        //
//        case 4:
//            if row == 0 {
//                cell.textLabel?.text = NSLocalizedString(cardioGroup[subSection].name, comment: "")
//                cell.textLabel?.textAlignment = NSTextAlignment.left
//                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//                // UserDefaults
//                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "\(cardioGroup[subSection].name)")
//                cell.detailTextLabel?.textAlignment = NSTextAlignment.right
//                cell.detailTextLabel?.textColor = UIColor.gray
//                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                
//                //
//                return cell
//            } else {
//                subcell.textLabel?.text = NSLocalizedString(cardioGroup[subSection].items[row - 1], comment: "")
//                subcell.textLabel?.textAlignment = NSTextAlignment.center
//                subcell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                subcell.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
//                let collapsedVo = cardioGroup[subSection].collapsed
//                if collapsedVo == true{
//                    subcell.textLabel?.alpha = 0
//                }
//                return subcell
//                
//            }
//            
//        //
//        case 5:
//            if row == 0 {
//                cell.textLabel?.text = NSLocalizedString(stretchingGroup[subSection].name, comment: "")
//                cell.textLabel?.textAlignment = NSTextAlignment.left
//                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//                // UserDefaults
//                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "\(stretchingGroup[subSection].name)")
//                cell.detailTextLabel?.textAlignment = NSTextAlignment.right
//                cell.detailTextLabel?.textColor = UIColor.gray
//                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                
//                //
//                return cell
//            } else {
//                subcell.textLabel?.text = NSLocalizedString(stretchingGroup[subSection].items[row - 1], comment: "")
//                subcell.textLabel?.textAlignment = NSTextAlignment.center
//                subcell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                subcell.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
//                let collapsedVo = stretchingGroup[subSection].collapsed
//                if collapsedVo == true{
//                    subcell.textLabel?.alpha = 0
//                }
//                return subcell
//                
//            }
//            
//        //
//        case 6:
//            if row == 0 {
//                cell.textLabel?.text = NSLocalizedString(yogaGroup[subSection].name, comment: "")
//                cell.textLabel?.textAlignment = NSTextAlignment.left
//                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//                // UserDefaults
//                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "\(yogaGroup[subSection].name)")
//                cell.detailTextLabel?.textAlignment = NSTextAlignment.right
//                cell.detailTextLabel?.textColor = UIColor.gray
//                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                
//                //
//                return cell
//            } else {
//                subcell.textLabel?.text = NSLocalizedString(yogaGroup[subSection].items[row - 1], comment: "")
//                subcell.textLabel?.textAlignment = NSTextAlignment.center
//                subcell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                subcell.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
//                let collapsedVo = yogaGroup[subSection].collapsed
//                if collapsedVo == true{
//                    subcell.textLabel?.alpha = 0
//                }
//                return subcell
//                
//            }
//            
//        //
//        case 7:
//            if row == 0 {
//                cell.textLabel?.text = NSLocalizedString(meditationGroup[subSection].name, comment: "")
//                cell.textLabel?.textAlignment = NSTextAlignment.left
//                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//                // UserDefaults
//                cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "\(workoutGroup[subSection].name)")
//                cell.detailTextLabel?.textAlignment = NSTextAlignment.right
//                cell.detailTextLabel?.textColor = UIColor.gray
//                cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                
//                //
//                return cell
//            } else {
//                subcell.textLabel?.text = NSLocalizedString(meditationGroup[subSection].items[row - 1], comment: "")
//                subcell.textLabel?.textAlignment = NSTextAlignment.center
//                subcell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//                subcell.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
//                let collapsedVo = workoutGroup[subSection].collapsed
//                if collapsedVo == true{
//                    subcell.textLabel?.alpha = 0
//                }
//                return subcell
//                
//            }
            
        //
//        default: return cell
//    }
//    return cell

}
   
    
//
// Button Actions --------------------------------------------------------------------------------------------------------
//
    // Navigation Button Action
    func navigationButtonAction(_ sender: Any) {
    //
        //
//        let row0 = NSIndexPath(row: 2, section: 0)
//        let row0Height = (tableView.cellForRow(at: row0 as IndexPath)?.frame.size.height)!
//        //
//        let row1 = NSIndexPath(row: 3, section: 0)
//        let row1Height = (tableView.cellForRow(at: row1 as IndexPath)?.frame.size.height)!
//        //
//        let row2 = NSIndexPath(row: 4, section: 0)
//        let row2Height = (tableView.cellForRow(at: row2 as IndexPath)?.frame.size.height)!
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
        case 4:
            let height = CGFloat(200 + 200 + 200)
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
    
    
    // Settings Button Actions
    func settingsButtonAction(_ sender: Any) {
        //
        performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    
    
    // Scroll Up Button Action
    func scrollUpButtonAction(_ sender: Any) {
        //
        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    

//
// Event Handlers --------------------------------------------------------------------------------------------------------
//
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        // Calculate the real sub-section index and row index
        let section = indexPath.section
        let subSection = getSubSectionIndex(section: indexPath.section, row: indexPath.row)
        let row = getRowIndex(section: indexPath.section, row: indexPath.row)
        // UserDefaults
        let cell = tableView.cellForRow(at: indexPath)
        let str = cell?.textLabel?.text
        
//        switch section {
//        //
//        case 0:
//            break
//        case 1:
//            
//            // UserDefaults
//            if row != 0 {
//                UserDefaults.standard.set("\(str!)", forKey: "\(meGroup[subSection].name)")
//                UserDefaults.standard.synchronize()
//            }
//            
//            
//            let collapsed = meGroup[subSection].collapsed
//            
//            // Toggle collapse
//            meGroup[subSection].collapsed = !collapsed!
//            
//            var indices = getHeaderIndices(section: 0)
//            
//            let start = indices[subSection]
//            let end = start + meGroup[subSection].items.count
//            
//            tableView.beginUpdates()
//            for i in start ..< end + 1 {
//                tableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
//            }
//            tableView.endUpdates()
//            
//          
//            //
//            //
//        case 2:
//            let collapsed = goalsGroup[subSection].collapsed
//            
//            // UserDefaults
//            if row != 0 {
//                UserDefaults.standard.set("\(str!)", forKey: "\(goalsGroup[subSection].name)")
//                UserDefaults.standard.synchronize()
//            }
//            
//            
//            // Toggle collapse
//            goalsGroup[subSection].collapsed = !collapsed!
//            
//            let indices = getHeaderIndices(section: 1)
//            
//            let start = indices[subSection]
//            let end = start + goalsGroup[subSection].items.count
//            
//            tableView.beginUpdates()
//            for i in start ..< end + 1 {
//                tableView.reloadRows(at: [IndexPath(row: i, section: 1)], with: .automatic)
//            }
//            tableView.endUpdates()
//            
//                
//            
//            //
//            //
//        case 3:
//            let collapsed = workoutGroup[subSection].collapsed
//            
//            // UserDefaults
//            if row != 0 {
//                UserDefaults.standard.set("\(str!)", forKey: "\(workoutGroup[subSection].name)")
//                UserDefaults.standard.synchronize()
//            }
//            
//            // Toggle collapse
//            workoutGroup[subSection].collapsed = !collapsed!
//            
//            let indices = getHeaderIndices(section: 2)
//            
//            let start = indices[subSection]
//            let end = start + workoutGroup[subSection].items.count
//            
//            
//            tableView.beginUpdates()
//            for i in start ..< end + 1 {
//                tableView.reloadRows(at: [IndexPath(row: i, section: 2)], with: .automatic)
//            
//            }
//            tableView.endUpdates()
//            
//            //
//            //
//        case 4:
//            let collapsed = cardioGroup[subSection].collapsed
//            
//            // UserDefaults
//            if row != 0 {
//                UserDefaults.standard.set("\(str!)", forKey: "\(cardioGroup[subSection].name)")
//                UserDefaults.standard.synchronize()
//            }
//            
//            // Toggle collapse
//            cardioGroup[subSection].collapsed = !collapsed!
//            
//            let indices = getHeaderIndices(section: 3)
//            
//            let start = indices[subSection]
//            let end = start + cardioGroup[subSection].items.count
//            
//            
//            tableView.beginUpdates()
//            for i in start ..< end + 1 {
//                tableView.reloadRows(at: [IndexPath(row: i, section: 3)], with: .automatic)
//                
//            }
//            tableView.endUpdates()
//            
//            //
//            //
//        case 5:
//            let collapsed = stretchingGroup[subSection].collapsed
//            
//            // UserDefaults
//            if row != 0 {
//                UserDefaults.standard.set("\(str!)", forKey: "\(stretchingGroup[subSection].name)")
//                UserDefaults.standard.synchronize()
//            }
//            
//            // Toggle collapse
//            stretchingGroup[subSection].collapsed = !collapsed!
//            
//            let indices = getHeaderIndices(section: 4)
//            
//            let start = indices[subSection]
//            let end = start + stretchingGroup[subSection].items.count
//            
//            
//            tableView.beginUpdates()
//            for i in start ..< end + 1 {
//                tableView.reloadRows(at: [IndexPath(row: i, section: 4)], with: .automatic)
//                
//            }
//            tableView.endUpdates()
//            
//            //
//            //
//        case 6:
//            let collapsed = yogaGroup[subSection].collapsed
//            
//            // UserDefaults
//            if row != 0 {
//                UserDefaults.standard.set("\(str!)", forKey: "\(yogaGroup[subSection].name)")
//                UserDefaults.standard.synchronize()
//            }
//            
//            // Toggle collapse
//            yogaGroup[subSection].collapsed = !collapsed!
//            
//            let indices = getHeaderIndices(section: 5)
//            
//            let start = indices[subSection]
//            let end = start + yogaGroup[subSection].items.count
//            
//            
//            tableView.beginUpdates()
//            for i in start ..< end + 1 {
//                tableView.reloadRows(at: [IndexPath(row: i, section: 5)], with: .automatic)
//                
//            }
//            tableView.endUpdates()
//            
//            //
//            //
//        case 7:
//            let collapsed = meditationGroup[subSection].collapsed
//            
//            // UserDefaults
//            if row != 0 {
//                UserDefaults.standard.set("\(str!)", forKey: "\(meditationGroup[subSection].name)")
//                UserDefaults.standard.synchronize()
//            }
//            
//            // Toggle collapse
//            meditationGroup[subSection].collapsed = !collapsed!
//            
//            let indices = getHeaderIndices(section: 6)
//            
//            let start = indices[subSection]
//            let end = start + meditationGroup[subSection].items.count
//            
//            
//            tableView.beginUpdates()
//            for i in start ..< end + 1 {
//                tableView.reloadRows(at: [IndexPath(row: i, section: 6)], with: .automatic)
//                
//            }
//            tableView.endUpdates()
//            
//            //
//            //
//        default: break
//        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
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
        
        //
        case 1:
            for row in goalsGroup {
                indices.append(index)
                index += row.items.count + 1
            }
                return indices
        
        //
        case 2:
            for row in workoutGroup {
                indices.append(index)
                index += row.items.count + 1
            }
            return indices
        
        //
        case 3:
            for row in cardioGroup {
                indices.append(index)
                index += row.items.count + 1
            }
            return indices
            
        //
        case 4:
            for row in stretchingGroup {
                indices.append(index)
                index += row.items.count + 1
            }
            return indices
            
        //
        case 5:
            for row in yogaGroup {
                indices.append(index)
                index += row.items.count + 1
            }
            return indices
            
        //
        case 6:
            for row in meditationGroup {
                indices.append(index)
                index += row.items.count + 1
            }
            return indices
            
        //
        default: return [0]
        
    }
}

    
//  
// Walkthrough ----------------------------------------------------------------------------------------------------------------------------------
//
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
        label.font = UIFont(name: "SFUIDisplay-light", size: 22)
        label.textColor = .white
        label.alpha = 0.9
        
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
        
        //
        switch viewNumber {
        //
        case 0:
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: view.frame.size.width/2 - 50
                , y: 94, width: 100, height: 40))
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
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            //
            label.text = NSLocalizedString("profile1", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
        //
        case 1:
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width - 22, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 18, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)

            //
            label.text = NSLocalizedString("profile2", comment: "")
            UIApplication.shared.keyWindow?.insertSubview(label, aboveSubview: walkthroughView)
        //
        default: break
        }
    }

    //
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        label.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }

    //
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            label.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
    }
//
}
