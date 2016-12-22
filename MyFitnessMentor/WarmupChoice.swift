//
//  MyWarmupOverview.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 28/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class WarmupChoice: UIViewController  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Full Body
    @IBOutlet weak var fullBody: UIButton!
    
    // Upper Lower
    @IBOutlet weak var upperBody: UIButton!
    
    // Legs Pull Push
    @IBOutlet weak var lowerBody: UIButton!
    
    // Cardio
    @IBOutlet weak var cardio: UIButton!
    
    // Information View
    @IBOutlet weak var informationViewWarmupC: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        // Titles
        navigationBar.title = (NSLocalizedString("warmup", comment: ""))
        
        // Button Titles
        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
        fullBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        fullBody.titleLabel!.textColor = .white
        fullBody.layer.borderWidth = 10
        fullBody.layer.borderColor = UIColor.white.cgColor
        fullBody.layer.cornerRadius = self.fullBody.frame.size.height / 2
        
        
        upperBody.setTitle(NSLocalizedString("upperBody", comment: ""), for: UIControlState.normal)
        upperBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        upperBody.titleLabel!.textColor = .white
        upperBody.layer.borderWidth = 10
        upperBody.layer.borderColor = UIColor.white.cgColor
        upperBody.layer.cornerRadius = self.upperBody.frame.size.height / 2
       
        
        lowerBody.setTitle(NSLocalizedString("lowerBody", comment: ""), for: UIControlState.normal)
        lowerBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        lowerBody.titleLabel!.textColor = .white
        lowerBody.layer.borderWidth = 10
        lowerBody.layer.borderColor = UIColor.white.cgColor
        lowerBody.layer.cornerRadius = self.lowerBody.frame.size.height / 2
        
        
        cardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        cardio.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        cardio.titleLabel!.textColor = .white
        cardio.layer.borderWidth = 10
        cardio.layer.borderColor = UIColor.white.cgColor
        cardio.layer.cornerRadius = self.cardio.frame.size.height / 2
        
        
        // Information
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipesWarmupC))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        self.informationViewWarmupC.addGestureRecognizer(downSwipe)
        
        self.informationViewWarmupC.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height), width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        
        view.bringSubview(toFront: informationViewWarmupC)
    }
    
    
    @IBAction func informationButtonActionWarmupC(_ sender: Any) {
        
        if self.informationViewWarmupC.frame.maxY == (self.view.frame.maxY + ((self.view.frame.size.height))) {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewWarmupC.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
                
            }, completion: nil)
            
        } else if self.informationViewWarmupC.frame.maxY == self.view.frame.maxY {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewWarmupC.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
        }

    }
    
    
    @IBAction func handleSwipesWarmupC(extraSwipe:UISwipeGestureRecognizer) {
        
        if (extraSwipe.direction == .down){
            
            if self.informationViewWarmupC.frame.maxY == self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewWarmupC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
            } else {
                
            }
            
            
        }
        
    }

    
    
}
