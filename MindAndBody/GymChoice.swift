//
//  classicChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Gym Choice Class ----------------------------------------------------------------------------------------------------------
//
class GymChoice: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // classic
    @IBOutlet weak var classic: UIButton!
    // circuit
    @IBOutlet weak var circuit: UIButton!
    //
    @IBOutlet weak var fiveByFive: UIButton!
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    // Constraints
    @IBOutlet weak var classicTop: NSLayoutConstraint!
    
    @IBOutlet weak var classicBottom: NSLayoutConstraint!
    
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    
  
//
// Remove back button text on subsequent screens
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Data 5x5
        if (segue.identifier == "fiveSegue") {
            //
            let destinationVC = segue.destination as! WorkoutChoiceFinal
            // Indicate to next screen which button was pressed
            destinationVC.workoutType = 0
            destinationVC.workoutType2 = 5
        }
        //
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
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
        navigationBar.title = (NSLocalizedString("gym", comment: ""))
        
        // Button Titles
        classic.setTitle(NSLocalizedString("classic", comment: ""), for: UIControlState.normal)
        classic.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        classic.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        classic.layer.borderWidth = 5
        classic.layer.borderColor = colour2.cgColor
        classic.setTitleColor(colour2, for: .normal)
        //
        circuit.setTitle(NSLocalizedString("circuit", comment: ""), for: UIControlState.normal)
        circuit.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        circuit.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        circuit.layer.borderWidth = 5
        circuit.layer.borderColor = colour2.cgColor
        circuit.setTitleColor(colour2, for: .normal)
        //
        fiveByFive.setTitle(NSLocalizedString("5x5", comment: ""), for: UIControlState.normal)
        fiveByFive.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        fiveByFive.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        fiveByFive.layer.borderWidth = 5
        fiveByFive.layer.borderColor = colour2.cgColor
        fiveByFive.setTitleColor(colour2, for: .normal)
        //
        
        // Iphone 5/SE
        if UIScreen.main.nativeBounds.height < 1334 {
            //
            classicTop.constant = 52
            classicBottom.constant = 52
            stackBottom.constant = 52
            //
            stackView.spacing = 15
        }
    }
    
    
//
// View did layout subview -----------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        classic.layer.cornerRadius = ((self.stackView.frame.size.height) * 3/2) / 2
        classic.layer.masksToBounds = true
        classic.titleLabel?.adjustsFontSizeToFitWidth = true
        classic.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        classic.titleLabel?.numberOfLines = 0
        classic.titleLabel?.textAlignment = .center
        //
        circuit.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        circuit.layer.masksToBounds = true
        circuit.titleLabel?.adjustsFontSizeToFitWidth = true
        circuit.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        circuit.titleLabel?.numberOfLines = 0
        circuit.titleLabel?.textAlignment = .center
        //
        fiveByFive.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        fiveByFive.layer.masksToBounds = true
        fiveByFive.titleLabel?.adjustsFontSizeToFitWidth = true
        fiveByFive.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        fiveByFive.titleLabel?.numberOfLines = 0
        fiveByFive.titleLabel?.textAlignment = .center
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
            //path.addArc(center: CGPoint(x: custom.center.x, y: custom.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.height), radius: 24.5, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
