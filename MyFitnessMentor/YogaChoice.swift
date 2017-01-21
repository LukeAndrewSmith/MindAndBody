//
//  YogaChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class YogaChoice: UIViewController  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    // Information View
    @IBOutlet weak var informationViewYogaC: UIView!
    
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    
    
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colours
        self.view.applyGradient(colours: [colour1, colour2])
        questionMark.tintColor = colour1
        
        
        
        // Titles
        navigationBar.title = (NSLocalizedString("yoga", comment: ""))
        
        // Button Titles
//        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
//        fullBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
//        fullBody.titleLabel!.textColor = .white
//        fullBody.layer.borderWidth = 10
//        fullBody.layer.borderColor = UIColor.white.cgColor
//        fullBody.layer.cornerRadius = self.fullBody.frame.size.height / 2
        
        
        // Information
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipesYogaC))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        self.informationViewYogaC.addGestureRecognizer(downSwipe)
        
        self.informationViewYogaC.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height), width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        
        view.bringSubview(toFront: informationViewYogaC)
    }
    
    
    @IBAction func informationButtonActionYogaC(_ sender: Any) {
        
        if self.informationViewYogaC.frame.maxY == (self.view.frame.maxY + ((self.view.frame.size.height))) {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewYogaC.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
                
            }, completion: nil)
            
        } else if self.informationViewYogaC.frame.maxY == self.view.frame.maxY {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewYogaC.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
        }

    }
    
    @IBAction func handleSwipesYogaC(extraSwipe:UISwipeGestureRecognizer) {
        
        if (extraSwipe.direction == .down){
            
            if self.informationViewYogaC.frame.maxY == self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewYogaC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
            } else {
                
            }
            
            
        }
        
    }

    // Remove Back Bar Text
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
