//
//  meditationTimerPresets.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 13.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class MeditationTimerPresets: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    // TableView
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
    
    
    //
    // View Did Load
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Background Gradient and Colours
        //
        self.view.applyGradient(colours: [colour1, colour1])
        
        navigationBar.title = NSLocalizedString("presetTimerTitle", comment: "")
        
        self.navigationController?.navigationBar.tintColor = colour1
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colour1, NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 22)!]
        self.navigationController?.navigationBar.barTintColor = colour2
        self.tabBarController?.tabBar.barTintColor = colour2
        
        
        
        
        // TableView
        // TableView Footer
        let footerView = UIView(frame: .zero)
        footerView.backgroundColor = .clear
        tableView.tableFooterView = footerView
        
    }
    
    
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    
    // TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)!
        header.textLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        header.contentView.backgroundColor = colour2
        //
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        //cell.textLabel?.text = NSLocalizedString(tableViewRows[indexPath.section][indexPath.row], comment: "")
        
        
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        cell.textLabel?.textColor = .black
        cell.tintColor = .black
        //
        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 72
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
