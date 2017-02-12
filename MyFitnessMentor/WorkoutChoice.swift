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
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough1") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough1")
        }
        
        
        
        // Colours
        self.view.applyGradient(colours: [colour1, colour2])
        questionMark.tintColor = colour1
        
        
        
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
        informationTitleWorkoutC.backgroundColor = colour2
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
        gym.titleLabel?.adjustsFontSizeToFitWidth = true
        gym.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        gym.titleLabel?.numberOfLines = 0
        gym.titleLabel?.textAlignment = .center
        
        home.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        home.layer.masksToBounds = true
        home.titleLabel?.adjustsFontSizeToFitWidth = true
        home.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        home.titleLabel?.numberOfLines = 0
        home.titleLabel?.textAlignment = .center

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
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
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
        
        
        switch viewNumber {
        case 0:
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
            
            
            label.text = NSLocalizedString("choiceScreen1", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
            
            
        //
        default: break
            
            
        }
        
        
    }
    
    
    
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    

    
    
}
