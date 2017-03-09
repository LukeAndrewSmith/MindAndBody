//
//  ClassicScreenFull2.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 09.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



// Custom Cell
//
class OverviewTableViewCell: UITableViewCell {
    
    // Image View
    @IBOutlet weak var demonstrationImageView: UIImageView!
    
    // Title Label
    @IBOutlet weak var titleLabel: UILabel!
    
    // Button View
    @IBOutlet weak var buttonView: UIView!
    
    
}



// View Controller
//
class ClassicScreenFull2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    
    
    //
    // ViewDidLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    
    
    
    
    
    
    //
    // Table View
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as! OverviewTableViewCell

        
        //cell.titleLabel?.text = NSLocalizedString(warmupFullArray[indexPath.section][indexPath.row], comment: "")
        
        // Cell
        //
        cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        cell.tintColor = .black
        
        
        
        // Title
        //
        cell.titleLabel.text = "Test"
        
        cell.titleLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 21)
        cell.titleLabel?.textAlignment = .left
        cell.titleLabel?.textColor = .black
        
        
        
        // Image
        //
        cell.demonstrationImageView.image = #imageLiteral(resourceName: "Test")
        
        
        
        
        // Set Buttons
        //
        
        
        
        
        
        
        
        return cell
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    //
    // Hide Screen
    //
    let hideScreenView = UIView()
    let blurEffectView = UIVisualEffectView()
    let hideLabel = UILabel()
    
    
    
    @IBAction func hideScreen(_ sender: Any) {
        
        
        // Hide Screen view
        let screenSize = UIScreen.main.bounds
        hideScreenView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        hideScreenView.backgroundColor = .clear
        hideScreenView.clipsToBounds = true
        hideScreenView.alpha = 0
        
        // Blur
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView.effect = blurEffect
        blurEffectView.frame = hideScreenView.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hideScreenView.addSubview(blurEffectView)
        blurEffectView.alpha = 0
        
        
        
        
        
        // Double Tap
        let doubleTap = UITapGestureRecognizer()
        doubleTap.numberOfTapsRequired = 2
        doubleTap.addTarget(self, action: #selector(handleTap))
        hideScreenView.isUserInteractionEnabled = true
        hideScreenView.addGestureRecognizer(doubleTap)
        
        
        // Text
        hideLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        hideLabel.center = hideScreenView.center
        hideLabel.textAlignment = .center
        hideLabel.numberOfLines = 0
        hideLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        hideLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        hideLabel.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        hideLabel.text = NSLocalizedString("hideScreen", comment: "")
        
        
        //
        hideScreenView.addSubview(hideLabel)
        UIApplication.shared.keyWindow?.insertSubview(hideScreenView, aboveSubview: view)
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.blurEffectView.alpha = 1
            self.hideScreenView.alpha = 1
        }, completion: nil)
    }
    
    
    
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        
        blurEffectView.removeFromSuperview()
        hideLabel.removeFromSuperview()
        
        hideScreenView.removeFromSuperview()
        
    }
    
    
    
    
    
    
}
