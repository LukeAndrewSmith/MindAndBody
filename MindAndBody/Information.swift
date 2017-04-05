
//
//  MyTheory.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



//
class informationNavigationCell: UITableViewCell {
    //
    @IBOutlet weak var important: UIButton!
    //
    @IBOutlet weak var app: UIButton!
    //
    @IBOutlet weak var discussions: UIButton!
    //
    @IBOutlet weak var music: UIButton!
    
}


//
class informationImportantCell: UITableViewCell {
    //
    @IBOutlet weak var titleLabel: UILabel!
}

//
class informationMusicCell: UITableViewCell {
   //
    @IBOutlet weak var titleLabel: UILabel!
    
}

//
class informationAppCell: UITableViewCell {
    //
    @IBOutlet weak var titleLabel: UILabel!
    
}

//
class informationDiscussionsCell: UITableViewCell {
    //
    @IBOutlet weak var titleLabel: UILabel!
    
}


class Information: UITableViewController{
    
    


    // Background Colour View
    let backView = UIView()

    //
    let scrollUpButton = UIButton()

    
    
    
    // Selected Topic
    var selectedTopic = [0,0]
    
    
    
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
    
    // Arrays
    
    let sectionArray: [String] =
        ["important", "music", "app"]
    
    
    let rowArray: [[String]] =
        [
            ["breathing", "coreActivation", "mindMuscle", "anatomy", "equipment", "posture", "commonTerms", "routineBuilding", "trainingPhilosophy", "nutrition"],
            ["suggestions"],
            ["vision", "usage"],
            
        ]

    
    override func viewWillAppear(_ animated: Bool) {
        //
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        UIApplication.shared.statusBarStyle = .lightContent
        //
        scrollUpButton.removeFromSuperview()

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
        
       

        // Background Coolour
        backView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        //
        self.tableView.backgroundView = backView
        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        //
        
        //
        self.navigationController?.navigationBar.barTintColor = colour2
        self.navigationController?.navigationBar.tintColor = colour1
        
        
        
        // Scroll Up Button
        scrollUpButton.frame = CGRect(x: view.frame.size.width - 59, y: view.frame.size.height - UIApplication.shared.statusBarFrame.height - 88.5, width: 44, height: 44)
        //
        scrollUpButton.layer.borderWidth = 2
        scrollUpButton.layer.borderColor = colour2.cgColor
        scrollUpButton.layer.cornerRadius = 22
        //
        scrollUpButton.backgroundColor = colour1
        //
        scrollUpButton.setImage(#imageLiteral(resourceName: "Up Arrow"), for: .normal)
        scrollUpButton.tintColor = colour2
        //
        scrollUpButton.addTarget(self, action: #selector(scrollUpButtonAction(_:)), for: .touchUpInside)
        
}
    
    
    //
    //
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            if tableView.contentOffset.y > 186 {
                //
                backView.backgroundColor = colour1
                UIApplication.shared.statusBarStyle = .default
                //
                UIApplication.shared.keyWindow?.insertSubview(scrollUpButton, aboveSubview: self.tableView)
            //
            } else {
                self.scrollUpButton.removeFromSuperview()
                //
                backView.backgroundColor = colour2
                UIApplication.shared.statusBarStyle = .lightContent
            }
        }
    }
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
            //sectionArray.count
    }
    
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        //
//        return sectionArray[section]
//    }

//    
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//    {
//        let header = view as! UITableViewHeaderFooterView
//        let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//        
//        
//        
//        // View
//        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 21)!
//        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//        header.textLabel?.textColor = .black
//        header.textLabel?.text = header.textLabel?.text?.capitalized
//        
//        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//        
//        
//        // Border
//        let border = CALayer()
//        border.backgroundColor = UIColor.black.cgColor
//        border.frame = CGRect(x: 15, y: header.frame.size.height-1, width: self.view.frame.size.height, height: 1)
//        
//        
//        header.layer.addSublayer(border)
//        header.layer.masksToBounds = true
//        
//        }
//    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 47
//    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return 6
        //return rowArray[section].count
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        switch indexPath.row {
        case 0: return 152
        case 1: return 44
        case 2,3,4,5: return 200
        default: break
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! headerCell
        
            cell.settingButton.alpha = 0
            cell.settingButton.isEnabled = false
        
            cell.gradientView.frame = cell.bounds
            
            cell.titleLabel.text = NSLocalizedString("information", comment: "")
            cell.titleLabel.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            
            cell.gradientView.applyGradient(colours: [UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0), UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0)])
            
            
            
            cell.logoView.tintColor = colour1
            
            
            cell.selectionStyle = .none
            
            return cell
            
            
        //
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "informationNavigationCell", for: indexPath) as! informationNavigationCell
            
            //
            cell.important.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.important.tag = 1
            cell.important.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)

            //
            cell.app.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.app.tag = 2
            cell.app.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)

            //
            cell.discussions.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.discussions.tag = 3
            cell.discussions.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)

            //
            cell.music.titleLabel?.adjustsFontSizeToFitWidth = true
            //
            cell.music.tag = 4
            cell.music.addTarget(self, action: #selector(navigationButtonAction(_:)), for: .touchUpInside)


            
            return cell
            
        //
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "informationImportantCell", for: indexPath) as! informationImportantCell
            
            //
            // Border
            let border = CALayer()
            border.backgroundColor = UIColor.black.cgColor
            border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
            //
            cell.layer.addSublayer(border)
            cell.layer.masksToBounds = true
            
            //
            cell.backgroundColor = colour1
            
            return cell
        // 
        case 3:
             let cell = tableView.dequeueReusableCell(withIdentifier: "informationAppCell", for: indexPath) as! informationAppCell
             
             //
             // Border
             let border = CALayer()
             border.backgroundColor = UIColor.black.cgColor
             border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
             //
             cell.layer.addSublayer(border)
             cell.layer.masksToBounds = true
             
             //
             cell.backgroundColor = colour1
             
            return cell
        //
        case 4:
             let cell = tableView.dequeueReusableCell(withIdentifier: "informationMusicCell", for: indexPath) as! informationMusicCell
             
             //
             // Border
             let border = CALayer()
             border.backgroundColor = UIColor.black.cgColor
             border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
             //
             cell.layer.addSublayer(border)
             cell.layer.masksToBounds = true
             
             //
             cell.backgroundColor = colour1
             
            return cell
        //
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "informationDiscussionsCell", for: indexPath) as! informationDiscussionsCell
            
            //
            // Border
            let border = CALayer()
            border.backgroundColor = UIColor.black.cgColor
            border.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY, width: cell.frame.size.width - 15, height: 1)
            //
            cell.layer.addSublayer(border)
            cell.layer.masksToBounds = true
            
            //
            cell.backgroundColor = colour1
            
            return cell
        //
        default: break
        }
        
        return UITableViewCell()
        
//        
//            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//            let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//        
//        
//        
//            cell.textLabel?.text = NSLocalizedString(rowArray[indexPath.section][indexPath.row], comment: "")
//        
//        
//        
//            cell.textLabel?.textAlignment = NSTextAlignment.left
//            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//            cell.textLabel?.textAlignment = .left
//        
//            cell.tintColor = colour1
//            cell.accessoryType = .disclosureIndicator
//
//        
//            return cell
       
}
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        tableView.deselectRow(at: indexPath, animated: true)
        
//        
//        // Selected Topic
//        selectedTopic[0] = indexPath.section
//        selectedTopic[1] = indexPath.row
//        
//        
//        // Perform Segue
//        //
//        // Anatomy
//        if (indexPath.section, indexPath.row) == (0, 3) {
//            performSegue(withIdentifier: "anatomy", sender: nil)
//        } else if (indexPath.section, indexPath.row) == (1, 0) {
//            performSegue(withIdentifier: "music", sender: nil)
//        } else {
//            performSegue(withIdentifier: "informationSegue", sender: nil)
//        }

    }
    
    
    
    //
    // Button Actions
    //
    
    // Button Actions
    func navigationButtonAction(_ sender: Any) {
        //
        //
        let row0 = NSIndexPath(row: 2, section: 0)
        let row0Height = (tableView.cellForRow(at: row0 as IndexPath)?.frame.size.height)!
        //
        let row1 = NSIndexPath(row: 3, section: 0)
        let row1Height = (tableView.cellForRow(at: row1 as IndexPath)?.frame.size.height)!
        //
        let row2 = NSIndexPath(row: 4, section: 0)
        let row2Height = (tableView.cellForRow(at: row2 as IndexPath)?.frame.size.height)!
        
        //
        switch (sender as AnyObject).tag {
        //
        case 1:
            self.tableView.setContentOffset(CGPoint(x: 0, y: 132), animated: true)
        //
        case 2:
            let height = 186 + row0Height
            //
            if tableView.frame.maxY > height - tableView.frame.size.height {
                //
                self.tableView.setContentOffset(CGPoint(x: 0, y: 186 + row0Height), animated: true)
            //
            } else {
                //
                self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height), animated: true)
            }
        //
        case 3:
            let height = 186 + row0Height + row1Height
            //
            if tableView.frame.maxY > height - tableView.frame.size.height {
                //
                self.tableView.setContentOffset(CGPoint(x: 0, y: 186 + row0Height), animated: true)
            } else {
                //
                self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height), animated: true)
            }
        //
        case 4:
            let height = row0Height + row1Height + row2Height
            //
            if tableView.frame.maxY > height - tableView.frame.size.height {
                //
                self.tableView.setContentOffset(CGPoint(x: 0, y: 186 + row0Height), animated: true)
            } else {
                //
                self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height), animated: true)
            }
        //
        default: break
        }
    }
    

    // Scroll Up Button Action
    func scrollUpButtonAction(_ sender: Any) {
        //
        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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
