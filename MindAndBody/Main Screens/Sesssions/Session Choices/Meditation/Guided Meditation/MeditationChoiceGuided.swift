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
            ["bodyScan",],
            //"tummoInnerFire", "self", "earth"],
    ]
    
    let guidedTitles = ["introductionG", "introduction", "techniquesB", "techniquesV"]
    
    let backgroundImages = ["mountains", "purpleTree", "sunWater", "mountainsRedBlue"]
    var images: [UIImageView] = []
    
    let cellHeight: CGFloat = 88
    //
    // View did load --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colour
        view.backgroundColor = Colors.light
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("guidedMeditation", comment: ""))
        
        // TableView
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        // Add background images
//        addBackgroundImages()
//        // Ensure table loaded and images behind
//        tableView.reloadData()
        
        addBackgroundImage(withBlur: true, fullScreen: true, image: "mountains")
        // mountainsRedBlue purpleTree mountains
        
        view.backgroundColor = Colors.light
//        tableView.separatorInset = UIEdgeInsets(top: 0, left: 88, bottom: 0, right: 0)
    }
    
    func addBackgroundImages() {
        
        // Add behind cell
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        for i in 0..<backgroundImages.count {
            
            let imageView = UIImageView()
            imageView.image = getUncachedImage(named: backgroundImages[i])
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = tableView.rect(forSection: i)
            imageView.frame.size = CGSize(width: 88, height: imageView.bounds.height)
            tableView.insertSubview(imageView, belowSubview: cell!)
            images.append(imageView)
        }
    }
    
    
    //
    // TableView --------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return guidedSessions.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  22
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = Colors.dark
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Medium", size: 17)!
        label.textColor = Colors.light
        label.text = NSLocalizedString(guidedTitles[section], comment: "")
        label.frame = CGRect(x: 16, y: 0, width: view.bounds.width, height: 22)
        header.addSubview(label)
        return header
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guidedSessions[section].count
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        //
        cell.backgroundColor = .clear
        //
        let title = UILabel()
        title.text = NSLocalizedString(guidedSessions[indexPath.section][indexPath.row], comment: "")
        title.font = Fonts.meditationTitle
        title.textColor = Colors.light
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        let size = title.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        title.frame = CGRect(x: 16, y: 0, width: view.bounds.width - 32, height: size.height)
        title.center.y = (cellHeight / 2)
        cell.addSubview(title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if images.count != 0 {
            tableView.sendSubview(toBack: images[indexPath.section])
        }
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
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
        navigationItem.backBarButtonItem?.tintColor = Colors.light
    }
    
    //
}

