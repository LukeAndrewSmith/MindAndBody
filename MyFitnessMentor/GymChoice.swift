//
//  WorkoutChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class GymChoice: UIViewController  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Full Body
    @IBOutlet weak var fullBody: UIButton!
    
    
    // Upper Lower
    @IBOutlet weak var upperBody: UIButton!
    @IBOutlet weak var lowerBody: UIButton!
    
    
    // Legs Pull Push
    @IBOutlet weak var legs: UIButton!
    @IBOutlet weak var pull: UIButton!
    @IBOutlet weak var push: UIButton!
    
    // Information View
    @IBOutlet weak var informationViewGymC: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        
        // Titles
        navigationBar.title = (NSLocalizedString("workout", comment: ""))
        
        // Button Titles
        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
        fullBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        fullBody.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        fullBody.layer.borderWidth = 10
        fullBody.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        fullBody.layer.cornerRadius = self.fullBody.frame.size.height / 2
        
        
        upperBody.setTitle(NSLocalizedString("upperBody", comment: ""), for: UIControlState.normal)
        upperBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        upperBody.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        upperBody.layer.borderWidth = 10
        upperBody.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        upperBody.layer.cornerRadius = self.upperBody.frame.size.height / 2
        
        
        lowerBody.setTitle(NSLocalizedString("lowerBody", comment: ""), for: UIControlState.normal)
        lowerBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        lowerBody.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        lowerBody.layer.borderWidth = 10
        lowerBody.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        lowerBody.layer.cornerRadius = self.lowerBody.frame.size.height / 2
        
        
        legs.setTitle(NSLocalizedString("legs", comment: ""), for: UIControlState.normal)
        legs.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        legs.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        legs.layer.borderWidth = 10
        legs.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        legs.layer.cornerRadius = self.legs.frame.size.height / 2
        
        
        pull.setTitle(NSLocalizedString("pull", comment: ""), for: UIControlState.normal)
        pull.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        pull.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        pull.layer.borderWidth = 10
        pull.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        pull.layer.cornerRadius = self.pull.frame.size.height / 2
        
        
        push.setTitle(NSLocalizedString("push", comment: ""), for: UIControlState.normal)
        push.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        push.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        push.layer.borderWidth = 10
        push.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        push.layer.cornerRadius = self.push.frame.size.height / 2
        
        
        
        
        // Information
//        extraInformation.text = NSLocalizedString("extraInformation", comment: "")
//        
//        extraInformation.sizeToFit()
//        
//        extraInformation.center.x = extrainformationViewGymC.center.x
//        
//        extraInformation.frame.size.height = 49
//        
        
        // ExtrainformationViewGymC
        //
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipesGymC))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        self.informationViewGymC.addGestureRecognizer(downSwipe)
        
        self.informationViewGymC.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height), width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        
        view.bringSubview(toFront: informationViewGymC)
            }
    
    
    

    @IBAction func informationButtonActionGymC(_ sender: Any) {
        if self.informationViewGymC.frame.maxY == (self.view.frame.maxY + ((self.view.frame.size.height))) {
                
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                self.informationViewGymC.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
                    
                }, completion: nil)
            
        } else if self.informationViewGymC.frame.maxY == self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewGymC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
        }

    }

    
    
    @IBAction func handleSwipesGymC(extraSwipe:UISwipeGestureRecognizer) {
        
        if (extraSwipe.direction == .down){
            
            if self.informationViewGymC.frame.maxY == self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewGymC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
            } else {
                
            }
            
            
        }
        
    }
    
    
    
}
