//
//  MeditationChoiceGuided.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 24.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Meditation Choice Class -------------------------------------------------------------------------------------------
//
class MeditationChoiceGuided: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Selected Session
    var selectedSessionMeditation = [0, 0]
    //
    var comingFromSchedule = false
    
    // Guided Sessions
    let guidedSessions =
        [
            ["introductionG"],
            ["introduction1", "introduction2", "introduction3", "introduction4"],
            ["squareBreathing", "breathCounting", "purging", "nostrilBreathing"],
            ["bodyScan", "tummoInnerFire", "self", "earth"],
    ]
    
    let guidedTitles = ["introductionG", "introduction", "techniquesB", "techniquesV"]
    
    
    //
    // View did load --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colour
        view.backgroundColor = Colors.light
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("guidedSessions", comment: ""))
        
        // TableView
        //
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        //
        let tableViewBackground = UIView()
        //
        tableViewBackground.backgroundColor = Colors.dark
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        //
        tableView.backgroundView = tableViewBackground
    }
    
    
    //
    // TableView --------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return guidedSessions.count
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(guidedTitles[section], comment: "")
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guidedSessions[section].count
    }
    
    // Will display header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)!
        header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        header.contentView.backgroundColor = Colors.dark
        //
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        //
        cell.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        cell.tintColor = .black
        //
        cell.textLabel?.text = NSLocalizedString(guidedSessions[indexPath.section][indexPath.row], comment: "")
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.textColor = .black
        //
        cell.imageView?.image = #imageLiteral(resourceName: "TestG")
        //
        let itemSize = CGSize(width: 76, height: 76)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale)
        let imageRect = CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height)
        cell.imageView?.image!.draw(in: imageRect)
        cell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //
        cell.imageView?.layer.cornerRadius = 3
        cell.imageView?.layer.masksToBounds = true
        //
        return cell
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    // Did select row
    var guidedTitleText = String()
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        tableView.deselectRow(at: indexPath, animated: true)
        // Selected Session
        selectedSessionMeditation[0] = indexPath.section
        selectedSessionMeditation[1] = indexPath.row
        // Title
        //        let currentCell = tableView.cellForRow(at: indexPath) as UITableViewCell!
        //        guidedTitleText = (currentCell?.textLabel!.text)!
        //
        performSegue(withIdentifier: "meditationGuidedChoice2", sender: nil)
    }
    
    
    //
    // Pass Array to next Viewcontroller --------------------------------------------------------------------------------------------------------
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Info
        if (segue.identifier == "meditationGuidedChoice2") {
            //
            let destinationVC = segue.destination as! MeditationGuided
            destinationVC.selectedSessionMeditation = selectedSessionMeditation
            //destinationVC.guidedTitle = guidedTitleText
            //destinationVC.keyArray = selectedArray
            //destinationVC.poses = posesDictionary
            destinationVC.fromSchedule = comingFromSchedule
        }
        
        // Remove Back Button Text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    //
}

