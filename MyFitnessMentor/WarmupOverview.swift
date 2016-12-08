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
    @IBOutlet weak var beginButton: UIButton!
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    //
    @IBOutlet weak var tableView: UITableView!
    
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Titles
        navigationBar.title = (NSLocalizedString("overview", comment: ""))
        
        beginButton.setTitle((NSLocalizedString("begin", comment: "")), for: .normal)
        beginButton.setTitleColor(.white, for: .normal)
        beginButton.titleLabel!.font = UIFont(name: "SFUIText-bemibold", size: 17)
        
        
        
        
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
    
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return self.warmupFull.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.textLabel?.text = self.warmupFull[indexPath.row]
        cell.isUserInteractionEnabled = false
            return cell
        
        }
        
    
    
    
    
}
