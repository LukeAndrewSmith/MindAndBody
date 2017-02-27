//
//  Calendar.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05.01.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class CalendarScreen: UITableViewController {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // CheckMark
    @IBOutlet weak var checkMark: UIBarButtonItem!
    
    // Table View
    
    
    
    // Arrays
    let daysArray =
    ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    
    let routineArray =
    [
        // Monday
        [
        ],
        // Tuesday
        [
        ],
        // Wednesday
        [
        ],
        // Thursday
        [
        ],
        // Friday
        [
        ],
        // Saturday
        [
        ],
        // Sunday
        [
        ]
    ]
    
    
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour3 = UserDefaults.standard.color(forKey: "colour3")!
    let colour4 = UserDefaults.standard.color(forKey: "colour4")!
    let colour5 = UserDefaults.standard.color(forKey: "colour5")!
    let colour6 = UserDefaults.standard.color(forKey: "colour6")!
    let colour7 = UserDefaults.standard.color(forKey: "colour7")!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        self.tableView.backgroundView = backView
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthroughC") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthroughC")
        }
        
        
        // Colours
        
        self.tableView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        checkMark.tintColor = .white
        
        
        self.navigationController?.navigationBar.tintColor = .white
     
        
        self.navigationController?.navigationBar.barTintColor = colour7
        
        
        
        // Title
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 22)!]
        
        
    
        // Navigation Title
        navigationBar.title = NSLocalizedString("calendar", comment: "")
        
        
        // Table View
        tableView.backgroundColor = .clear
        
    }
    
    
    
    
    
    // Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
            //daysArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(daysArray[section], comment: "")
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-medium", size: 21)!
        header.textLabel?.textColor = .black
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        header.contentView.tintColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        
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
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        
        //NSLocalizedString(warmupUpperArray[indexPath.section][indexPath.row], comment: "")
        
//        cell.textLabel?.textColor = .black
//        cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
//        cell.textLabel?.textAlignment = .left
//        cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//        cell.tintColor = .black
//        

        
        
        
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.tintColor = .black
            
            cell.imageView?.image = #imageLiteral(resourceName: "Plus")
        
            cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
            cell.imageView?.transform = CGAffineTransform(scaleX: -1,y: 1);
            
            return cell
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 47
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
    
    }
    
    
    
    
    
    @IBAction func checkMarkAction(_ sender: Any) {
    
        self.performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        
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
        backButton.frame = CGRect(x: 3, y: UIApplication.shared.statusBarFrame.height, width: 50, height: navigationBarHeight)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.textAlignment = .left
        backButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        backButton.titleLabel?.textColor = .white
        backButton.addTarget(self, action: #selector(backWalkthroughView(_:)), for: .touchUpInside)
        
        
        
        
        switch viewNumber {
        case 0:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addEllipse(in: CGRect(x: view.frame.size.width/2 - 80, y: UIApplication.shared.statusBarFrame.height, width: 160, height: 40))
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
            
            
            label.text = NSLocalizedString("mindBodyC1", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            
            
        //
        case 1:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight, width: self.view.frame.size.width, height: 47))
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
            
            
            label.text = NSLocalizedString("mindBodyC2", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        case 2:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBarHeight + 47, width: self.view.frame.size.width, height: 47))
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
            
//            label.center = pickerView.center
//            label.center.y = 24.5 + (UIApplication.shared.statusBarFrame.height/2) + pickerView.frame.size.height
            label.text = NSLocalizedString("mindBodyC3", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        case 3:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.frame.size.width * 0.917, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
            
            
            label.text = NSLocalizedString("mindBodyC4", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            
            
            
        //
        default: break
            
            
        }
        
        
    }
    
    
    
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    
    
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
        
    }

    

    
    
}
