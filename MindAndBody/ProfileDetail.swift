//
//  ProfileDetail.swift
//  MindAndBody
//
//  Created by Luke Smith on 10.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class ProfileDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //
    // Outlets --------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var navigationBar: UINavigationItem!
    //
    @IBOutlet weak var questionsTable: UITableView!
    
    // Selected section
    var selectedSection = Int()
    // Arrays
    var titleArray: [String] = ["goals", "me", "time", "preferences"]
    
    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString(titleArray[selectedSection], comment: ""))
        
    }
    
    
    
    
    //
    // Table View --------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
//        return sectionArray.count + 1
        return 0
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch indexPath.row {
        case 4: return 49
        default: return (view.bounds.height - 49) / 4
        }
    }
    
    
    // Blurs
    let blur = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur3 = UIVisualEffectView()
    
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //
        switch indexPath.row {
        case 4:
            //
            cell.textLabel?.text = "Update Schedule"
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = colour1
            //
            // BackgroundBlur/Vibrancy
            let backgroundBlur = UIVisualEffectView()
            let backgroundBlurE = UIBlurEffect(style: .dark)
            backgroundBlur.effect = backgroundBlurE
            backgroundBlur.isUserInteractionEnabled = false
            //
            backgroundBlur.frame = cell.bounds
            //
            cell.backgroundColor = colour3
            cell.backgroundView = backgroundBlur
            
        //
        default:
            //
            cell.backgroundColor = .clear
            cell.backgroundView = UIView()
            //
            let centeredTextLabel = UILabel()
//            centeredTextLabel.text = sectionArray[indexPath.row]
            centeredTextLabel.font = UIFont(name: "SFUIDisplay-thin", size: 23)
            centeredTextLabel.textAlignment = .center
            centeredTextLabel.sizeToFit()
            centeredTextLabel.textColor = colour1
            centeredTextLabel.center = CGPoint(x: view.bounds.width/2, y: (view.bounds.height - 49)/8)
            cell.addSubview(centeredTextLabel)
            //
            cell.accessoryType = .disclosureIndicator
            // Border
            let seperator = CALayer()
            seperator.frame = CGRect(x: 0, y: (view.bounds.height - 49) / 4, width: view.frame.size.width, height: 1)
            seperator.backgroundColor = colour1.cgColor
            seperator.opacity = 0.5
            cell.layer.addSublayer(seperator)
        }
        //
        return cell
    }
    
    
    // didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 4:
            break
        default:
            // Selected section
            performSegue(withIdentifier: "profileDetail", sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
