//
//  CardioChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Cardio Choice Class ---------------------------------------------------------------------------------------------------------
//
class CardioChoice: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Hiit
    @IBOutlet weak var hiit: UIButton!
    // Custom
    @IBOutlet weak var custom: UIButton!
    
//
// View did load -----------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthroughc") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthroughc")
        }
        
        // Colours
        view.backgroundColor = colour1
        
        // Titles
        navigationBar.title = (NSLocalizedString("cardio", comment: ""))
        
        // Button Titles
        hiit.setTitle(NSLocalizedString("hiit", comment: ""), for: UIControlState.normal)
        hiit.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        hiit.setTitleColor(colour2, for: .normal)
        hiit.layer.borderWidth = 5
        hiit.layer.borderColor = colour2.cgColor
        hiit.titleLabel?.adjustsFontSizeToFitWidth = true
        hiit.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        hiit.titleLabel?.textAlignment = .center
        //
        custom.setTitle("C", for: .normal)
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        custom.layer.borderWidth = 5
        custom.layer.borderColor = colour2.cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        custom.titleLabel?.textAlignment = .center
        custom.setTitleColor(colour2, for: .normal)
        custom.layer.cornerRadius = 49/2
        custom.layer.masksToBounds = true
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        custom.titleLabel?.numberOfLines = 0
        custom.titleLabel?.textAlignment = .center
        //
        
            }
    
    
//
// View did layout subviews  ---------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        hiit.layer.cornerRadius = self.hiit.frame.size.height / 2
        hiit.layer.masksToBounds = true
        hiit.titleLabel?.adjustsFontSizeToFitWidth = true
        hiit.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        hiit.titleLabel?.numberOfLines = 0
        hiit.titleLabel?.textAlignment = .center
        //
    }
    
    
//
// Remove back bar text
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
  
    
//
// Walkthrough ----------------------------------------------------------------------------------------------------------------
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
        case 1:
            //
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: custom.center.x, y: custom.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.height), radius: 24.5, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
            
            
            label.text = NSLocalizedString("choiceScreen12", comment: "")
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
