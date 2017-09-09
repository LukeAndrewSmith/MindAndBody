//
//  BodyweightChoice.swift
//  MindAndBody
//
//  Created by Luke Smith on 03.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Bodyweight Choice Class -------------------------------------------------------------------------------------------------------
//
class BodyweightChoice: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var fullBody: UIButton!
    //
    @IBOutlet weak var upperBody: UIButton!
    //
    @IBOutlet weak var lowerBody: UIButton!
    //
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    // Constraints
    @IBOutlet weak var fullBodyTop: NSLayoutConstraint!
    //
    @IBOutlet weak var fullBodyBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var connectionWidth: NSLayoutConstraint!
    //
    @IBOutlet weak var connectionTrailing: NSLayoutConstraint!
    
    
    //
    var workoutType = Int()
    var workoutType2 = Int()
//
// View did load ----------------------------------------------------------------------------------------------------------------
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
        if workoutType == 2 {
            navigationBar.title = (NSLocalizedString("classic", comment: ""))
        } else if workoutType == 3 {
            navigationBar.title = (NSLocalizedString("circuit", comment: ""))
        }
        
        // Button Titles
        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
        fullBody.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        fullBody.setTitleColor(colour2, for: .normal)
        fullBody.layer.borderWidth = 5
        fullBody.layer.borderColor = colour2.cgColor
        //
        upperBody.setTitle(NSLocalizedString("upperBody", comment: ""), for: UIControlState.normal)
        upperBody.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        upperBody.setTitleColor(colour2, for: .normal)
        upperBody.layer.borderWidth = 5
        upperBody.layer.borderColor = colour2.cgColor
        //
        lowerBody.setTitle(NSLocalizedString("lowerBody", comment: ""), for: UIControlState.normal)
        lowerBody.setTitleColor(colour2, for: .normal)
        lowerBody.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        lowerBody.layer.borderWidth = 5
        lowerBody.layer.borderColor = colour2.cgColor
        //
        
        
        // Iphone 5/SE
        if UIScreen.main.nativeBounds.height < 1334 {
            //
            fullBodyTop.constant = 52
            fullBodyBottom.constant = 52
            stackBottom.constant = 52
            //
            stackView.spacing = 15
            connectionWidth.constant = 15
            connectionTrailing.constant = 15
        }
    }
    
    
//
// View did layout subviews ----------------------------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        fullBody.layer.cornerRadius = ((self.stackView.frame.size.height) * 3/2) / 2
        fullBody.layer.masksToBounds = true
        fullBody.titleLabel?.adjustsFontSizeToFitWidth = true
        fullBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        fullBody.titleLabel?.numberOfLines = 0
        fullBody.titleLabel?.textAlignment = .center
        //
        upperBody.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        upperBody.layer.masksToBounds = true
        upperBody.titleLabel?.adjustsFontSizeToFitWidth = true
        upperBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        upperBody.titleLabel?.numberOfLines = 0
        upperBody.titleLabel?.textAlignment = .center
        //
        lowerBody.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        lowerBody.layer.masksToBounds = true
        lowerBody.titleLabel?.adjustsFontSizeToFitWidth = true
        lowerBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        lowerBody.titleLabel?.numberOfLines = 0
        lowerBody.titleLabel?.textAlignment = .center
    }
    
    
    // Full
    @IBAction func full(_ sender: Any) {
        workoutType2 = 0
        performSegue(withIdentifier: "bodyweightSegue", sender: nil)
    }
    
    // Upper
    @IBAction func upper(_ sender: Any) {
        workoutType2 = 1
        performSegue(withIdentifier: "bodyweightSegue", sender: nil)
    }
    
    // Lower
    @IBAction func lower(_ sender: Any) {
        workoutType2 = 2
        performSegue(withIdentifier: "bodyweightSegue", sender: nil)
    }
    
    
//
// Remove back bar text
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Data
        if (segue.identifier == "bodyweightSegue") {
            //
            let destinationVC = segue.destination as! WorkoutChoiceFinal
            // Indicate to next screen which button was pressed
            destinationVC.workoutType = workoutType
            destinationVC.workoutType2 = 2
        }
        //
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
            
            //
            label.text = NSLocalizedString("choiceScreen1", comment: "")
            walkthroughView.addSubview(label)
            
            //
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            
        //
        case 1:
            //
            // Clear Section
            let path = CGMutablePath()
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
            
            //
            label.text = NSLocalizedString("choiceScreen12", comment: "")
            walkthroughView.addSubview(label)
            
            //
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
    
    //
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }

    //
    func backWalkthroughView(_ sender: Any) {
        if viewNumber > 0 {
            backButton.removeFromSuperview()
            walkthroughView.removeFromSuperview()
            viewNumber = viewNumber - 1
            walkthroughMindBody()
        }
    }
    
}
