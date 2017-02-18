//
//  MeditationTimer.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 12.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class MeditationTimer: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // Arrays
    let tableViewSections =
    ["start", "during", "end"
    ]
    
    let tableViewRows =
    [
    ["",],
    ["", ""],
    [""]
    ]
    
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // TableView
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour3 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour4 = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
    
    
    
    
    //
    // View Did Load
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Background Gradient and Colours
        //
        self.view.applyGradient(colours: [colour1, colour2])
        
        navigationBar.title = NSLocalizedString("meditationTimerTitle", comment: "")
        
        
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
        return NSLocalizedString(tableViewSections[section], comment: "")
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)!
        header.textLabel?.textColor = colour3
        header.contentView.backgroundColor = colour1
        header.contentView.tintColor = colour1
        //
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewRows[section].count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.textLabel?.text = NSLocalizedString(tableViewRows[indexPath.section][indexPath.row], comment: "")
        
        
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = colour3
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
