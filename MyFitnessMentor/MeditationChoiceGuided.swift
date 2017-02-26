//
//  MeditationChoiceGuided.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 24.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class MeditationChoiceGuided: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    
    // Information View
    @IBOutlet weak var informationView: UIScrollView!
    
    // Information Title Label
    @IBOutlet weak var informationTitle: UILabel!
    
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    
    // Selected Session
    var selectedSession = [0, 0]
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour3 = UserDefaults.standard.color(forKey: "colour3")!
    let colour4 = UserDefaults.standard.color(forKey: "colour4")!
    let colour5 = UserDefaults.standard.color(forKey: "colour5")!
    let colour6 = UserDefaults.standard.color(forKey: "colour6")!
    let colour7 = UserDefaults.standard.color(forKey: "colour7")!
    let colour8 = UserDefaults.standard.color(forKey: "colour8")!
    
    
    
    
    // Guided Sessions
    let guidedSessions =
        [
            ["introduction", "breathing"],
            ["scale", "perspective"],
            ["lettingGo", "acceptance", "wandering", "oneness", "duality"],
            ["bodyScan", "unwind"]
    
        ]
    
    
    
    //
    // ViewDidLoad
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Colour
        self.view.applyGradient(colours: [colour1, colour2])
        questionMark.tintColor = colour1
        
        
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("guidedSessions", comment: ""))
        

        
        
        
        
        // Information
        // Scroll View Frame
        self.informationView.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        
        
        view.bringSubview(toFront: informationView)
        
        
        // Information Text
        //
        // Information Text Frame
        let informationText = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationView.frame.size.width - 40, height: 0))
        
        
        
        
        
        // Information Text Frame
        self.informationTitle.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 49)
        informationTitle.text = (NSLocalizedString("information", comment: ""))
        informationTitle.textAlignment = .center
        informationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitle.textColor = colour2
        informationTitle.backgroundColor = colour7
        
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationTitle.addGestureRecognizer(downSwipe)
        informationTitle.isUserInteractionEnabled = true
        
        
        
        self.view.addSubview(informationTitle)
        
        
        
        // Information Text and Attributes
        //
        // String
        let informationLabelString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("warmupChoiceText", comment: "")))
        
        // Range of String
        let textRangeString = ((NSLocalizedString("movements", comment: ""))+"\n"+(NSLocalizedString("warmupChoiceText", comment: "")))
        let textRange = (informationLabelString as NSString).range(of: textRangeString)
        
        
        // Range of Titles
        let titleRangeString = (NSLocalizedString("movements", comment: ""))
        let titleRange1 = (informationLabelString as NSString).range(of: titleRangeString)
        
        
        // Line Spacing
        let lineSpacing = NSMutableParagraphStyle()
        lineSpacing.lineSpacing = 1.4
        lineSpacing.hyphenationFactor = 1
        
        
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
        
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        
        
            let tableViewBackground = UIView()
            
            tableViewBackground.backgroundColor = colour7
            tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
            
            tableView.backgroundView = tableViewBackground
        
    }
    
    
    
    
    
    // Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            
        case 0: return NSLocalizedString("introduction", comment: "")
        case 1: return NSLocalizedString("view", comment: "")
        case 2: return NSLocalizedString("self", comment: "")
        case 3: return NSLocalizedString("sleep", comment: "")
        default: break
        }
        return ""
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return guidedSessions[section].count
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
                let header = view as! UITableViewHeaderFooterView
                header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)!
                header.textLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
                header.contentView.backgroundColor = colour7
                //
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        
        let itemSize = CGSize(width: 76, height: 76)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale)
        let imageRect = CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height)
        cell.imageView?.image!.draw(in: imageRect)
        cell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        cell.imageView?.layer.cornerRadius = 3
        cell.imageView?.layer.masksToBounds = true
        
        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 96
        
    }
    
    
    var guidedTitleText = String()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Selected Session
        selectedSession[0] = indexPath.section
        selectedSession[1] = indexPath.row
        
        // Title
//        let currentCell = tableView.cellForRow(at: indexPath) as UITableViewCell!
//        guidedTitleText = (currentCell?.textLabel!.text)!
        
        //
        performSegue(withIdentifier: "meditationGuided", sender: nil)
    }
    
    
    
    
    
    
    
    
    
    // QuestionMark Button Action
    @IBAction func informationButtonAction(_ sender: Any) {
        
        if self.informationView.frame.minY < self.view.frame.maxY {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            self.informationView.contentOffset.y = 0
            
            
        } else {
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            self.informationView.contentOffset.y = 0
            
            
        }
        
    }
    
    
    
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.informationView.frame.minY < self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
                UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
                
            }
        }
    }
    
    
    
    
    
    // Pass Array to next ViewController
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        // Pass Info
        if (segue.identifier == "meditationGuided") {
            
            let destinationVC = segue.destination as! MeditationGuided
            
            
            destinationVC.selectedSession = selectedSession
            
            //destinationVC.guidedTitle = guidedTitleText
            //destinationVC.keyArray = selectedArray
            //destinationVC.poses = posesDictionary
            
        }
        
        
        
        // Remove Back Button Text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
}
