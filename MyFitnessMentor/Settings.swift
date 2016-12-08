//
//  Settings.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class Settings: UITableViewController{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return (NSLocalizedString("case10", comment: ""))
        case 1: return (NSLocalizedString("case11", comment: ""))
        default: return (NSLocalizedString("default", comment: ""))
        }
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 15)!
        header.textLabel?.textColor = .black
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = NSLocalizedString("language", comment: "")
            cell.textLabel?.textAlignment = NSTextAlignment.left
            return cell
            
        case 1:
            cell.textLabel?.text = NSLocalizedString("clearPreferences", comment: "")
            cell.textLabel?.textAlignment = NSTextAlignment.left
            return cell
        default: return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        
        
        
        if section == 0 {
            

            
        } else if section == 1 {
            
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
        }
    }
    
    
    
    
    
    
    
    
    
}
