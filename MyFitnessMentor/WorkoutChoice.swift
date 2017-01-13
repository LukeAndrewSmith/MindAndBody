//
//  WorkoutChoice1.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class WorkoutChoice: UIViewController  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Gym
    @IBOutlet weak var gym: UIButton!
    
    // Home
    @IBOutlet weak var home: UIButton!

    // Information View
    @IBOutlet weak var informationViewWorkoutC: UIView!

    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        // Titles
        navigationBar.title = (NSLocalizedString("location", comment: ""))
        
        // Button Titles
        gym.setTitle(NSLocalizedString("gym", comment: ""), for: UIControlState.normal)
        gym.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        gym.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        gym.layer.borderWidth = 10
        gym.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        
        
        home.setTitle(NSLocalizedString("home", comment: ""), for: UIControlState.normal)
        home.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        home.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        home.layer.borderWidth = 10
        home.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        
     
        // informationViewWorkoutC
        //
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipesWorkoutC))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        self.informationViewWorkoutC.addGestureRecognizer(downSwipe)
        
        self.informationViewWorkoutC.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height), width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        
        view.bringSubview(toFront: informationViewWorkoutC)
       
        
        // Information
        let informationTitleWorkoutC = UILabel(frame: CGRect(x: 0, y: 0, width: self.informationViewWorkoutC.frame.size.width, height: 49))
        informationTitleWorkoutC.text = "Information"
        informationTitleWorkoutC.textAlignment = .center
        informationTitleWorkoutC.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitleWorkoutC.textColor = .white
        informationTitleWorkoutC.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
        self.informationViewWorkoutC.addSubview(informationTitleWorkoutC)
        
        
        let informationLabelWorkoutC = UILabel(frame: CGRect(x: 10, y: 59, width: self.informationViewWorkoutC.frame.size.width - 20, height: 49))
        informationLabelWorkoutC.text = "Noice"
        informationLabelWorkoutC.font = UIFont(name: "SFUIDisplay-light", size: 19)
        self.informationViewWorkoutC.addSubview(informationLabelWorkoutC)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gym.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        gym.layer.masksToBounds = true
        
        home.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        home.layer.masksToBounds = true

    }
    
   
 
    @IBAction func informationButtonActionWorkoutC(_ sender: Any) {
        
        if self.informationViewWorkoutC.frame.maxY == (self.view.frame.maxY + ((self.view.frame.size.height))) {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewWorkoutC.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
                
            }, completion: nil)
            
        } else if self.informationViewWorkoutC.frame.maxY == self.view.frame.maxY {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewWorkoutC.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
        }

    }


    @IBAction func handleSwipesWorkoutC(extraSwipe:UISwipeGestureRecognizer) {
        
        if (extraSwipe.direction == .down){
            
            if self.informationViewWorkoutC.frame.maxY == self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewWorkoutC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
            } else {
                
            }
            
            
        }
        
    }

    
    
    
}
