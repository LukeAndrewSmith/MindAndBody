//
//  MindfulnessChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Meditation Choice Class --------------------------------------------------------------------------------------------------
//
class MeditationChoice: UIViewController, UIScrollViewDelegate  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var guided: UIButton!
    @IBOutlet weak var meditationTimer: UIButton!
    
    // Stack
    @IBOutlet weak var stackView: UIStackView!
    
    // Constraints
    @IBOutlet weak var timerTop: NSLayoutConstraint!
    @IBOutlet weak var timerBottom: NSLayoutConstraint!
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    
    
//
// View did load -------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough1" : false])
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough1") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough1")
        }
        
        // Colours
        view.backgroundColor = colour1
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("meditation", comment: ""))
    
        // Button Titles
        //
        guided.setTitle(NSLocalizedString("guided", comment: ""), for: UIControlState.normal)
        guided.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        guided.setTitleColor(colour2, for: .normal)
        guided.layer.borderWidth = 6
        guided.layer.borderColor = colour2.cgColor
        guided.titleLabel?.adjustsFontSizeToFitWidth = true
        guided.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        guided.titleLabel?.textAlignment = .center
        //
        meditationTimer.setTitle(NSLocalizedString("meditationTimer", comment: ""), for: UIControlState.normal)
        meditationTimer.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        meditationTimer.setTitleColor(colour2, for: .normal)
        meditationTimer.layer.borderWidth = 6
        meditationTimer.layer.borderColor = colour2.cgColor
        meditationTimer.titleLabel?.adjustsFontSizeToFitWidth = true
        meditationTimer.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        meditationTimer.titleLabel?.textAlignment = .center
      
        
    }
    
    
//
// View did layout subviews -------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        meditationTimer.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        meditationTimer.layer.masksToBounds = true
        //
        guided.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        guided.layer.masksToBounds = true
        //
        
    }

    
//
// Remove Back Bar Text
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
    }
  
    
//
// Walkthrogh -------------------------------------------------------------------------------------------------------
//
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


