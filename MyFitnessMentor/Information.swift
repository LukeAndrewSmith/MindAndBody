
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
    
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    

    
    
    // Selected Topic
    var selectedTopic = [0,0]
    
    
    
    
    // Arrays
    
    let sectionArray =
        ["important", "music", "app"]
    
    
    let rowArray =
        [
            ["breathing", "coreActivation", "mindMuscle", "anatomy", "equipment", "posture", "commonTerms", "routineBuilding", "trainingPhilosophy", "nutrition"],
            ["suggestions"],
            ["vision", "usage"],
            
        ]

    
    override func viewWillAppear(_ animated: Bool) {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        self.tableView.backgroundView = backView
        self.tableView.contentOffset.y = 0
    }
    
    //
    // ViewDidLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "informationWalkthrough") == false {
            self.walkthroughMindBody()
            UserDefaults.standard.set(true, forKey: "informationWalkthrough")
        }
        
        
        // Colours
        let colour4 = UserDefaults.standard.color(forKey: "colour4")!
        let colour7 = UserDefaults.standard.color(forKey: "colour7")!
        
        
        
        //
        self.navigationController?.navigationBar.barTintColor = colour7
        self.navigationController?.navigationBar.tintColor = .white
        
        
        //
        // Title
        //self.navigationController?.navigationBar.topItem?.title = (NSLocalizedString("information", comment: ""))
        navigationBar.title = NSLocalizedString("information", comment: "")
        
        
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
        let colour4 = UserDefaults.standard.color(forKey: "colour4")!
        
        // View
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 21)!
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        
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
            let colour4 = UserDefaults.standard.color(forKey: "colour4")!
        
            cell.textLabel?.text = NSLocalizedString(rowArray[indexPath.section][indexPath.row], comment: "")
        
        
        
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.textAlignment = .left
        
            cell.tintColor = colour4
            cell.accessoryType = .disclosureIndicator

        
            return cell
       
}
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        // Selected Topic
        selectedTopic[0] = indexPath.section
        selectedTopic[1] = indexPath.row
        
        
        // Perform Segue
        //
        // Anatomy
        if (indexPath.section, indexPath.row) == (0, 3) {
            performSegue(withIdentifier: "anatomy", sender: nil)
        } else if (indexPath.section, indexPath.row) == (1, 0) {
            performSegue(withIdentifier: "music", sender: nil)
        } else {
            performSegue(withIdentifier: "informationSegue", sender: nil)
        }

    }
    
    
    
    // Pass Array to next ViewController
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass Info
        if (segue.identifier == "informationSegue") {
            
            let destinationVC = segue.destination as! InformationScreen1
            
            destinationVC.selectedTopic = selectedTopic
            
            
            //destinationVC.selectedSession = selectedSession
            
            //destinationVC.guidedTitle = guidedTitleText
            //destinationVC.keyArray = selectedArray
            //destinationVC.poses = posesDictionary
            
        }
        
        
        
        // Remove Back Button Text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
    
    
    
    
    
    
    


//---------------------------------------------------------------------------------------------------------------
    
    
    var  viewNumber = 0
    let walkthroughView = UIView()
    let label = UILabel()
    let nextButton = UIButton()
    let backButton = UIButton()
    
    
    // Walkthrough
    func walkthroughMindBody() {
        
        //
        let screenSize = UIScreen.main.bounds
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        //
        walkthroughView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        walkthroughView.backgroundColor = .black
        walkthroughView.alpha = 0.72
        walkthroughView.clipsToBounds = true
        //
        label.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        label.center = view.center
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "SFUIDisplay-light", size: 22)
        label.textColor = .white
        //
        nextButton.frame = screenSize
        nextButton.backgroundColor = .clear
        nextButton.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
        //
        
        
        switch viewNumber {
        case 0:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height, width: view.frame.size.width, height: 47))
            path.addRect(screenSize)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("information1", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            
            
        //
        default: break
            
            
        }
        
        
    }
    
    
    
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }


}
