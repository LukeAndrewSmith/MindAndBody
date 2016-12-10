//
//  EmphasisSelection.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 19/11/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class EmphasisSelection: UITableViewController{
    
   
    //
    // Sections
    //
    struct Group3 {
        var name: [String]!
        
        init(name: [String]) {
            self.name = name
        }
    }
    
    var emphasisGroup1 = [Group3]()
    var emphasisGroup2 = [Group3]()
    var emphasisGroup3 = [Group3]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        self.tableView.backgroundView = backView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emphasisGroup1 = [
            Group3(name: [(NSLocalizedString("quads", comment: "")), (NSLocalizedString("hamstrings", comment: "")), (NSLocalizedString("calves", comment: ""))])
            ]
        emphasisGroup2 = [
            Group3(name: [(NSLocalizedString("back", comment: "")), (NSLocalizedString("upperBack", comment: "")), (NSLocalizedString("lowerBack", comment: "")), (NSLocalizedString("traps", comment: "")), (NSLocalizedString("biceps", comment: "")), (NSLocalizedString("delts", comment: ""))])
            ]
        emphasisGroup3 = [
            Group3(name: [(NSLocalizedString("chest", comment: "")), (NSLocalizedString("triceps", comment: "")), (NSLocalizedString("delts", comment: ""))])
        ]
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 : return (NSLocalizedString("legs", comment: ""))
        case 1 : return (NSLocalizedString("pull", comment: ""))
        case 2 : return (NSLocalizedString("push", comment: ""))
        case 3 : return (NSLocalizedString("default", comment: ""))
        default: return (NSLocalizedString("default", comment: ""))
        }
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 20)!
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        //if section == 0 {
            let border = UIView(frame: CGRect(x: 15,y: header.frame.size.height ,width: self.view.frame.size.width,height: 1))
            border.backgroundColor = .black
            header.addSubview(border)
//        } else {
//            let border = UIView(frame: CGRect(x: 0,y: header.frame.size.height ,width: self.view.frame.size.width,height: 1))
//            border.backgroundColor = .black
//            header.addSubview(border)
//        }

    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        return view
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 :
            return 3
        case 1 :
            return 6
        case 2 :
            return 3
        case 3 : return 1
        default: return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Calculate the real sub-section index and row index
        let subSection = getSubSectionIndex(section: indexPath.section, row: indexPath.row)
        let row = getRowIndex(section: indexPath.section, row: indexPath.row)
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let subcell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        
        switch indexPath.section {
        case 0 :
            cell.textLabel?.text = emphasisGroup1[subSection].name[row]
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.tintColor = UIColor.black
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
            return cell
        case 1 :
            cell.textLabel?.text = emphasisGroup2[subSection].name[row]
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.tintColor = UIColor.black
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 18)
            return cell
        case 2 :
            cell.textLabel?.text = emphasisGroup3[subSection].name[row]
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.tintColor = UIColor.black
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 18)
            return cell
        case 3 :
            subcell.textLabel?.text = NSLocalizedString("ok", comment: "")
            subcell.textLabel?.textAlignment = NSTextAlignment.center
            subcell.backgroundColor = UIColor(red:0.53, green:1.00, blue:0.50, alpha:1.0)
            subcell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 18)
            return subcell
        default : return cell
        }
    }
    
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let cell = tableView.cellForRow(at: indexPath)
        let str = cell?.textLabel?.text
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if section != 3 {
            if cell?.accessoryType == .checkmark {
                cell?.accessoryType = .none
            } else {
                cell?.accessoryType = .checkmark
                
            }
        } else if section == 3 {
            
//            if cell?.accessoryType == .checkmark {
//                let musclesArray = [str]
//                UserDefaults.standard.array(forKey: "emphasisMuscles") as? musclesArray
//            }
            
            
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
            for row in emphasisGroup1 {
                indices.append(index)
                index += row.name.count + 1
            }
            return indices
            
        case 1:
            for row in emphasisGroup2 {
                indices.append(index)
                index += row.name.count + 1
            }
            return indices
            
            
        case 2:
            for row in emphasisGroup3 {
                indices.append(index)
                index += row.name.count + 1
            }
            return indices
            
        default: return [0]
            
        }
    }

    
}
