//
//  MyWarmupOverview.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 28/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class WarmupOverview: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    //
    @IBOutlet weak var tableView: UITableView!
    
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        // Titles
        navigationBar.title = (NSLocalizedString("overview", comment: ""))
        
       
        
        
    }
    
    // Warmup Array
    let warmupFull : [String] =
        [
            "movement1",
            "movement2",
            "movement3",
            "movement4",
            "movement5",
            "movement6",
            ]
    
    
    // Aesthetic
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return " "
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 15)!
        
        
        //        let border = UIView(frame: CGRect(x: 0,y: header.frame.size.height ,width: self.view.frame.size.width,height: 1))
        //        border.backgroundColor = .black
        //        header.addSubview(border)
    }

    
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return self.warmupFull.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 47.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = self.warmupFull[indexPath.row]
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)!
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(red:0.09, green:0.09, blue:0.10, alpha:1.0)
        cell.isUserInteractionEnabled = false
            return cell
        
        }
        
    
    
    
    
}
