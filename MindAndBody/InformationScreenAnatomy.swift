//
//  InformationScreenA.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 28.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Anatomy Class ------------------------------------------------------------------------------------
//
class InformationScreenAnatomy: UIViewController {
  
    
//
// Outlets ------------------------------------------------------------------------------------
//
    // Navigation
    @IBOutlet weak var navigationBar: UINavigationItem!
    let navigationTitle = UILabel()
    
    // Image
    @IBOutlet weak var image: UIImageView!
    
    // Progress Bar
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    //
    @IBOutlet weak var progressLabel: UILabel!
    
    // Left Constraint
    @IBOutlet weak var progressLeft: NSLayoutConstraint!
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
    var bodyPartIndex = 0
    
    
//
// Arrays ------------------------------------------------------------------------------------
//
    // Body part array
    let bodyArray: [String] =
        [
            "traps",
            "rearDelts",
            "lateralDelts",
            "frontDelts",
            "biceps",
            "triceps",
            "forearms",
            "pecs2",
            "lats",
            "erectors",
            "core",
            "serratus",
            "obliques",
            "rectusAbdominis",
            "glutes",
            "hamstrings",
            "adductors",
            "quads",
            "gastrocnemius",
            "soleus"
        ]
    
    // Image Array
    let imageArray: [UIImage] =
        [
            #imageLiteral(resourceName: "Trap"),
            #imageLiteral(resourceName: "Rear Delt 2"),
            #imageLiteral(resourceName: "Lateral Delt"),
            #imageLiteral(resourceName: "Front Delt"),
            #imageLiteral(resourceName: "Bicep"),
            #imageLiteral(resourceName: "Tricep"),
            #imageLiteral(resourceName: "Forearm"),
            #imageLiteral(resourceName: "Pec"),
            #imageLiteral(resourceName: "Lat 2"),
            #imageLiteral(resourceName: "Erector"),
            #imageLiteral(resourceName: "Core"),
            #imageLiteral(resourceName: "Serratus"),
            #imageLiteral(resourceName: "Oblique"),
            #imageLiteral(resourceName: "Rectus"),
            #imageLiteral(resourceName: "Glute"),
            #imageLiteral(resourceName: "Hamstring"),
            #imageLiteral(resourceName: "Adductor"),
            #imageLiteral(resourceName: "Quad"),
            #imageLiteral(resourceName: "Gastrocnemius"),
            #imageLiteral(resourceName: "Soleus")
        ]
    
    
//
// View did load ------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title Colour
        //
        self.navigationController?.navigationBar.barTintColor = colour2
        self.navigationController?.navigationBar.tintColor = .white
        
        // Image Swipes
        //
        let imageSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        imageSwipeLeft.direction = UISwipeGestureRecognizerDirection.left
        image.addGestureRecognizer(imageSwipeLeft)
        image.isUserInteractionEnabled = true
        //
        let imageSwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        imageSwipeRight.direction = UISwipeGestureRecognizerDirection.right
        image.addGestureRecognizer(imageSwipeRight)
        image.isUserInteractionEnabled = true
    
        // Progress Bar
        //
        // Thickness
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 49, height: self.progressBarView.frame.size.height / 2)
        progressBar.center = progressBarView.center
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3)
        // Rounded Edges
        progressBar.layer.cornerRadius = self.progressBar.frame.size.height / 2
        progressBar.layer.masksToBounds = true
        // Initial state
        progressBar.setProgress(0, animated: true)
        // Left Constraint
        progressLeft.constant = 34 + progressLabel.frame.size.width
        
        // Display Content
        displayContent()
    }
    
    
//
// Display Content ------------------------------------------------------------------------------------
//
    // Display Content Function
    //
    func displayContent() {
        
        // Title
        //
        navigationTitle.text = (NSLocalizedString(bodyArray[bodyPartIndex], comment: ""))
        
        // Navigation Title
        //
        navigationTitle.frame = (navigationController?.navigationItem.accessibilityFrame)!
        navigationTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        navigationTitle.center.x = self.view.center.x
        navigationTitle.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        navigationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 22)
        navigationTitle.backgroundColor = .clear
        navigationTitle.textAlignment = .center
        navigationTitle.adjustsFontSizeToFitWidth = true
        //
        self.navigationBar.titleView = navigationTitle
        
        // Image
        //
        image.image = imageArray[bodyPartIndex]
        
        // Progress
        //
        // Title
        self.progressLabel.text = (String(bodyPartIndex + 1)+"/"+String(bodyArray.count))
        // Progress Bar
        let bodyIndexP = Float(bodyPartIndex)
        let bodyArrayP = Float(self.bodyArray.count)
        //
        let fractionalProgress = bodyIndexP/bodyArrayP
        //
        progressBar.setProgress(fractionalProgress, animated: true)
    }
   
    
//
// Button Actions ------------------------------------------------------------------------------------
//
    // Next Button
    @IBAction func nextButton(_ sender: Any) {
        //
        if bodyPartIndex == bodyArray.count - 1 {
            navigationTitle.removeFromSuperview()
            _ = self.navigationController?.popToRootViewController(animated: true)
        //
        } else {
            //
            bodyPartIndex = bodyPartIndex + 1
            displayContent()
        }
    }
    
    // Back Button
    @IBAction func backButton(_ sender: Any) {
        //
        if bodyPartIndex == 0 {
        } else {
            bodyPartIndex = bodyPartIndex - 1
            displayContent()
        }
    }
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        //
        if (extraSwipe.direction == .left){
            //
            if bodyPartIndex == bodyArray.count - 1 {
                //
                navigationTitle.removeFromSuperview()
                _ = self.navigationController?.popToRootViewController(animated: true)
            //
            } else {
                //
                bodyPartIndex = bodyPartIndex + 1
                displayContent()
            }
        //
        } else if extraSwipe.direction == .right {
            //
            if bodyPartIndex == 0 {
            } else {
                bodyPartIndex = bodyPartIndex - 1
                displayContent()
            }
        }
    }
//
}
