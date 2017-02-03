
//
//  MyTheory.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class Information: UITableViewController{
    
    
    
    
    // Arrays
    
    let sectionArray =
        ["important", "app", "music"]
    
    
    let rowArray =
        [
            ["breathing", "coreActivation", "posture", "commonTerms", "trainingPhilosophy"],
            ["vision", "usage"],
            ["role", "suggestions"]
    
        ]

    
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
        
        self.navigationController?.navigationBar.barTintColor = colour1
        self.navigationController?.navigationBar.tintColor = .white
        
        
        //
        // Title
        self.navigationController?.navigationBar.topItem?.title = (NSLocalizedString("information", comment: ""))
        
        
}
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return sectionArray[section]
    }

    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        
        // View
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 20)!
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        // Text
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 20)!
        
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
        return rowArray[section].count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
            cell.textLabel?.text = NSLocalizedString(rowArray[indexPath.section][indexPath.row], comment: "")
        
        
        
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
            cell.textLabel?.textAlignment = .left
        
            cell.accessoryType = .disclosureIndicator

            return cell
       
}
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)

    }



}
