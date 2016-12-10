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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        self.tableView.backgroundView = backView
        
    }
    
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
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 20)!
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        // Border
        let border = UIView(frame: CGRect(x: 15,y: header.frame.size.height ,width: self.view.frame.size.width,height: 1))
        border.backgroundColor = .black
        header.addSubview(border)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        return view
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
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
            return cell
            
        case 1:
            cell.textLabel?.text = NSLocalizedString("clearPreferences", comment: "")
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
            return cell
        default: return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        
        
        
        if section == 0 {
            
            //Localization.setLanguage
            
        } else if section == 1 {
            
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    
    
    
    
    
    
}
