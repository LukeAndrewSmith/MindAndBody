//
//  WarmupChoiceUpper.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 04.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class WarmupChoiceUpper: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    
    // Information View
    @IBOutlet weak var informationView: UIScrollView!
    
    // Information Title Label
    @IBOutlet weak var informationTitle: UILabel!
    
    
    // Gym Button
    @IBOutlet weak var gymButton: UIButton!
    
    
    // Home Button
    @IBOutlet weak var homeButton: UIButton!
    
    
    
    
    
    
    
    
    // Warmup Upper Array
    var warmupUpperArray =
        [
            // Mandatory
            ["5minCardio"],
            // Lower Back
            ["sideLegDrop",
            "sideLegKick",
            "ScorpionKick",
            "UpwardsDog",
            "catCow"],
            // Shoulders
            ["superManShoulder",
            "scapula",
            "shoulderRotation",
            "facePull",
            "externalRotation",
            "internalRotation",
            "rearDeltFly",
            "wallSlides"],
            // Pull
            ["latPullover",
            "pullUp",
            "pullDown",
            "curl"],
            // Push
            ["pushUp",
            "trianglePushUp",
            "tricepPushDown",
            "shoulderPress"]

            ]
    
    // Warmup Selected Array
    var warmupSelectedArray =
        [
            // Mandatory
            [1],
            // Lower Back
            [1,
             0,
             1,
             0,
             0],
            // Shoulders
            [0,
             1,
             0,
             1,
             0,
             1,
             0,
             0],
            // Pull
            [0,
             1,
             0,
             1],
            // Push
            [1,
             0,
             0,
             1]
    ]

    
    
    @IBAction func gymAction(_ sender: Any) {
        warmupUpperArray =
            [
                // Mandatory
                ["5minCardio"],
                // Lower Back
                ["sideLegDrop",
                 "sideLegKick",
                 "ScorpionKick",
                 "UpwardsDog",
                 "catCow"],
                // Shoulders
                ["superManShoulder",
                 "scapula",
                 "shoulderRotation",
                 "facePull",
                 "externalRotation",
                 "internalRotation",
                 "rearDeltFly",
                 "wallSlides"],
                // Pull
                ["latPullover",
                 "pullUp",
                 "pullDown",
                 "curl"],
                // Push
                ["pushUp",
                 "trianglePushUp",
                 "tricepPushDown",
                 "shoulderPress"]
                
        ]

        warmupSelectedArray =
            [
                // Mandatory
                [1],
                // Lower Back
                [1,
                 0,
                 1,
                 0,
                 0],
                // Shoulders
                [0,
                 1,
                 0,
                 1,
                 0,
                 1,
                 0,
                 0],
                // Pull
                [0,
                 1,
                 0,
                 1],
                // Push
                [1,
                 0,
                 0,
                 1]
            ]

        
        gymButton.titleLabel?.textColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
        
        
        homeButton.titleLabel?.textColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0)
        
        
        
                
        self.tableView.reloadData()
        
        
    }
    
    
        
    @IBAction func homeAction(_ sender: Any) {

        warmupUpperArray =
            [
                // Mandatory
                ["5minCardio"],
                // Lower Back
                ["sideLegDrop",
                 "sideLegKick",
                 "ScorpionKick",
                 "UpwardsDog",
                 "catCow"],
                // Shoulders
                ["externalRotation",
                 "internalRotation",
                 "rearDeltFly",
                 "wallSlides"],
                // Pull
                ["latPullover",
                 "pullUp",
                 "curl"],
                // Push
                ["pushUp",
                 "trianglePushUp",
                 ]
                
        ]
        
        
        warmupSelectedArray =
        [
            // Mandatory
            [1],
            // Lower Back
            [1,
             0,
             1,
             0,
             0],
            // Shoulders
            [0,
             1,
             0,
             1,
             0],
            // Pull
            [0,
             1,
             0,
             1],
            // Push
            [1,
             0,
             0,
             1]
        ]
        
    
        gymButton.titleLabel?.textColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0)
        
        
        homeButton.titleLabel?.textColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
        
        
        self.tableView.reloadData()
    }
    
    
   
    
    
    //
    // ViewDidLoad
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        

        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("upperBody", comment: ""))
        
        
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        
        
        
        
        
        // Gym Button
        gymButton.titleLabel?.text = NSLocalizedString("gym", comment: "")
        
        // Home Button
        homeButton.titleLabel?.text = NSLocalizedString("home", comment: "")
        
        
        
        // Information
        // Scroll View Frame
        self.informationView.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height + 49), width: self.view.frame.size.width, height: (self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height - 49)
        
        
        view.bringSubview(toFront: informationView)
        
        
        // Information Text
        //
        // Information Title Frame
        let informationText = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationView.frame.size.width - 40, height: 0))
        
        
        
        
        
        // Information Text Frame
        self.informationTitle.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height), width: self.informationView.frame.size.width, height: 49)
        informationTitle.text = (NSLocalizedString("information", comment: ""))
        informationTitle.textAlignment = .center
        informationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitle.textColor = .white
        informationTitle.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
        
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationTitle.addGestureRecognizer(downSwipe)
        informationTitle.isUserInteractionEnabled = true
        
        
        
        self.view.addSubview(informationTitle)
        

        
        // Information Text and Attributes
        //
        // String
        let informationLabelString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("warmupChoiceUpperText", comment: "")))
        
        // Range of String
        let textRangeString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("warmupChoiceUpperText", comment: "")))
        let textRange = (informationLabelString as NSString).range(of: textRangeString)
        
        
        // Range of Titles
        let titleRangeString = (NSLocalizedString("movements", comment: ""))
        let titleRange1 = (informationLabelString as NSString).range(of: titleRangeString)
        
        
        // Line Spacing
        let lineSpacing = NSMutableParagraphStyle()
        lineSpacing.lineSpacing = 1.4
        
        
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Light", size: 19)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange1)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        
        
        
        // Final Text Editing
        informationText.attributedText = informationLabelText
        informationText.textAlignment = .justified
        informationText.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationText.numberOfLines = 0
        informationText.sizeToFit()
        self.informationView.addSubview(informationText)
        
        
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationText.frame.size.height + informationTitle.frame.size.height + 20)
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return warmupUpperArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return (NSLocalizedString("mandatory", comment: ""))
        case 1: return (NSLocalizedString("lowerBack", comment: ""))
        case 2: return (NSLocalizedString("shoulders", comment: ""))
        case 3: return (NSLocalizedString("pull", comment: ""))
        case 4: return (NSLocalizedString("push", comment: ""))
        default: return ""
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
      
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)!
        header.textLabel?.textColor = .black
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return warmupUpperArray[section].count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            
        cell.textLabel?.text = warmupUpperArray[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = .clear
        cell.tintColor = .black
        
        
        if warmupSelectedArray[indexPath.section][indexPath.row] == 1 {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        
        return cell

            
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 47
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            warmupSelectedArray[indexPath.section][indexPath.row] = 0
        } else {
            cell?.accessoryType = .checkmark
            warmupSelectedArray[indexPath.section][indexPath.row] = 1
        }
    }
    
    
   
    
    
    
    
    
    
    
    // QuestionMark Button Action
    @IBAction func informationButtonAction(_ sender: Any) {
        
        if self.informationView.frame.maxY == (self.view.frame.maxY + ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height)) {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
            }, completion: nil)
            self.informationView.contentOffset.y = 0
            
        } else if self.informationView.frame.maxY == (self.view.frame.maxY - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height) {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            self.informationView.contentOffset.y = 0
        }

    }
    
    
    
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.informationView.frame.maxY == (self.view.frame.maxY - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height) {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
                UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
                
            }
        }
    }
    
    
    
    
    
    
    
    // Warmup Array
    var warmupArray: [String] = []
    
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        
        
        warmupArray = zip(warmupUpperArray.flatMap{$0},warmupSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        performSegue(withIdentifier: "warmupUpper", sender: sender)
    }
    
    // Pass Array to next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "warmupUpper") {

            
            var destinationNC = segue.destination as! UINavigationController
            
            var destinationVC = destinationNC.viewControllers.first as! WarmupScreenUpper
            
            destinationVC.warmupMovementsArray = warmupArray
            
        }
    }
    
    
//    override func viewWillDisappear(_ animated : Bool) {
//        super.viewWillDisappear(animated)
//        
//        if (self.isMovingFromParentViewController){
//            navigationController?.popToRootViewController(animated: true)
//        }
//    }
    
    
}
