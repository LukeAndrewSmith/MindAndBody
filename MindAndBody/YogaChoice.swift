//
//  YogaChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Yoga choice class ---------------------------------------------------------------------------------------------------
//
class YogaChoice: UIViewController, UIScrollViewDelegate  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var custom: UIButton!
    //
    @IBOutlet weak var practices: UIButton!
    
    
//
// View did load -----------------------------------------------------------------------------------------------------
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
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("yoga", comment: ""))
        
        // Button Titles
        //
        practices.setTitle(NSLocalizedString("practices", comment: ""), for: UIControlState.normal)
        practices.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        practices.setTitleColor(colour2, for: .normal)
        practices.layer.borderWidth = 5
        practices.layer.borderColor = colour2.cgColor
        practices.titleLabel?.adjustsFontSizeToFitWidth = true
        practices.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        practices.titleLabel?.textAlignment = .center
        //
        custom.setTitle("C", for: UIControlState.normal)
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        custom.setTitleColor(colour2, for: .normal)
        custom.layer.borderWidth = 5
        custom.layer.borderColor = colour2.cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        custom.titleLabel?.textAlignment = .center
        custom.layer.cornerRadius = 49/2
        custom.layer.masksToBounds = true
        custom.titleLabel?.numberOfLines = 0
        //

    }
    

//
// View did layout subviews ----------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        //
        super.viewDidLayoutSubviews()
        //
        practices.layer.cornerRadius = practices.frame.size.height / 2
        practices.layer.masksToBounds = true
        practices.titleLabel?.adjustsFontSizeToFitWidth = true
        practices.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        practices.titleLabel?.numberOfLines = 0
        practices.titleLabel?.textAlignment = .center
    }
  
    
//
// Segues
//
    //
    @IBAction func practicesAction(_ sender: Any) {
        performSegue(withIdentifier: "yogaSegue", sender: nil)
    }
    
    
//
// Remove Back Bar Text
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Data
        if (segue.identifier == "yogaSegue") {
            //
            let destinationVC = segue.destination as! YogaChoiceFinal
            // Indicate to next screen which button was pressed
        }
        // Remove back bar text
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
 
    
//
// Walkthrough ------------------------------------------------------------------------------------------------------------
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
            
            
            label.text = NSLocalizedString("choiceScreen122", comment: "")
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
