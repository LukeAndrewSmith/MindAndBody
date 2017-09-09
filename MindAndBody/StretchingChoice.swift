//
//  StretchingChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Stretching choice class -----------------------------------------------------------------------------------------------------
//
class StretchingChoice: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var postWorkout: UIButton!
    //
    @IBOutlet weak var postCardio: UIButton!
    //
    @IBOutlet weak var general: UIButton!
    //
    @IBOutlet weak var custom: UIButton!
    
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    
    // Constraints
    @IBOutlet weak var generalTop: NSLayoutConstraint!
    //
    @IBOutlet weak var generalBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var connectionWidth: NSLayoutConstraint!
    //
    @IBOutlet weak var connectionTrailing: NSLayoutConstraint!
    
    
//
// View did load -------------------------------------------------------------------------------------------------------
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
        navigationBar.title = (NSLocalizedString("stretching", comment: ""))
        
        // Button Titles
        general.setTitle(NSLocalizedString("general", comment: ""), for: UIControlState.normal)
        general.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        general.setTitleColor(colour2, for: .normal)
        general.layer.borderWidth = 5
        general.layer.borderColor = colour2.cgColor
        //
        postWorkout.setTitle(NSLocalizedString("postWorkout", comment: ""), for: UIControlState.normal)
        postWorkout.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        postWorkout.setTitleColor(colour2, for: .normal)
        postWorkout.layer.borderWidth = 5
        postWorkout.layer.borderColor = colour2.cgColor
        //
        postCardio.setTitle(NSLocalizedString("postCardio", comment: ""), for: UIControlState.normal)
        postCardio.setTitleColor(colour2, for: .normal)
        postCardio.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        postCardio.layer.borderWidth = 5
        postCardio.layer.borderColor = colour2.cgColor
        //
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        custom.layer.borderWidth = 5
        custom.layer.borderColor = colour2.cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,7,0,7)
        custom.titleLabel?.textAlignment = .center
        custom.setTitleColor(colour2, for: .normal)
        custom.layer.cornerRadius = 49/2
        custom.layer.masksToBounds = true
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleLabel?.numberOfLines = 0
        custom.titleLabel?.textAlignment = .center
        //
        
        // Iphone 5/SE
        if UIScreen.main.nativeBounds.height < 1334 {
            //
            generalTop.constant = 52
            generalBottom.constant = 52
            stackBottom.constant = 52
            //
            stackView.spacing = 15
            connectionWidth.constant = 15
            connectionTrailing.constant = 15
        }
    }
    
    // Layout Subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        general.layer.cornerRadius = ((self.stackView.frame.size.height) * 3/2) / 2
        general.layer.masksToBounds = true
        general.titleLabel?.adjustsFontSizeToFitWidth = true
        general.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        general.titleLabel?.numberOfLines = 0
        general.titleLabel?.textAlignment = .center
        //
        postWorkout.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        postWorkout.layer.masksToBounds = true
        postWorkout.titleLabel?.adjustsFontSizeToFitWidth = true
        postWorkout.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        postWorkout.titleLabel?.numberOfLines = 0
        postWorkout.titleLabel?.textAlignment = .center
        //
        postCardio.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        postCardio.layer.masksToBounds = true
        postCardio.titleLabel?.adjustsFontSizeToFitWidth = true
        postCardio.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        postCardio.titleLabel?.numberOfLines = 0
        postCardio.titleLabel?.textAlignment = .center
    }

    
//
// Stretching type segues ---------------------------------------------------------------------------------------------------------
//
    // Indicate to next screen which button pressed
    var stretchingType = Int()
    // General
    @IBAction func general(_ sender: Any) {
        stretchingType = 0
        performSegue(withIdentifier: "stretchingSegue", sender: nil)
    }
    // Post-Workout
    @IBAction func postWorkout(_ sender: Any) {
        stretchingType = 1
        performSegue(withIdentifier: "stretchingSegue", sender: nil)
    }
    // Post-Cardio
    @IBAction func postCardio(_ sender: Any) {
        stretchingType = 2
        performSegue(withIdentifier: "stretchingSegue", sender: nil)
    }
    
    
//
// Remove Back Bar Text
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if (segue.identifier == "stretchingSegue") {
            // Pass data to next screen
            let destinationVC = segue.destination as! StretchingChoiceFinal
            // indicate which button pressed
            destinationVC.stretchingType = stretchingType
        }
        
        // Remove Back Bar Text
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
    
