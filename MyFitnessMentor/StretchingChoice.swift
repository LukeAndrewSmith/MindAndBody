//
//  StretchingChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class StretchingChoice: UIViewController  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    // Information View
    @IBOutlet weak var informationViewStretchingC: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        // Titles
        navigationBar.title = (NSLocalizedString("stretching", comment: ""))
        
        // Button Titles
//        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
//        fullBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
//        fullBody.titleLabel!.textColor = .white
//        fullBody.layer.borderWidth = 10
//        fullBody.layer.borderColor = UIColor.white.cgColor
//        fullBody.layer.cornerRadius = self.fullBody.frame.size.height / 2
        
        
        // Information
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipesStretchingC))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        self.informationViewStretchingC.addGestureRecognizer(downSwipe)
        
        self.informationViewStretchingC.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height), width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        
        view.bringSubview(toFront: informationViewStretchingC)
        
    }
    
    
    @IBAction func informationButtonActionStretchingC(_ sender: Any) {
        
        if self.informationViewStretchingC.frame.maxY == (self.view.frame.maxY + ((self.view.frame.size.height))) {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewStretchingC.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
                
            }, completion: nil)
            
        } else if self.informationViewStretchingC.frame.maxY == self.view.frame.maxY {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewStretchingC.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
        }

    }
    
    @IBAction func handleSwipesStretchingC(extraSwipe:UISwipeGestureRecognizer) {
        
        if (extraSwipe.direction == .down){
            
            if self.informationViewStretchingC.frame.maxY == self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewStretchingC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
            } else {
                
            }
            
            
        }
        
    }

    
    
}
