//
//  CardioChoiceHIIT.swift
//  MindAndBody
//
//  Created by Luke Smith on 31.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// HIIT Choice Class -------------------------------------------------------------------------------------------------------
//
class CardioChoiceHIIT: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var rowing: UIButton!
    //
    @IBOutlet weak var biking: UIButton!
    //
    @IBOutlet weak var running: UIButton!
    //
    
    //
    var cardioType = Int()
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
        navigationBar.title = (NSLocalizedString("hiit", comment: ""))
        
        // Button Titles
        rowing.setTitle(NSLocalizedString("rowing", comment: ""), for: UIControlState.normal)
        rowing.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        rowing.setTitleColor(colour2, for: .normal)
        rowing.layer.borderWidth = 6
        rowing.layer.borderColor = colour2.cgColor
        //
        biking.setTitle(NSLocalizedString("biking", comment: ""), for: UIControlState.normal)
        biking.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        biking.setTitleColor(colour2, for: .normal)
        biking.layer.borderWidth = 6
        biking.layer.borderColor = colour2.cgColor
        //
        running.setTitle(NSLocalizedString("running", comment: ""), for: UIControlState.normal)
        running.setTitleColor(colour2, for: .normal)
        running.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        running.layer.borderWidth = 6
        running.layer.borderColor = colour2.cgColor
        //
    }
    
    
    //
    // View did layout subviews ----------------------------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        rowing.layer.cornerRadius = rowing.frame.size.height / 2
        rowing.layer.masksToBounds = true
        rowing.titleLabel?.adjustsFontSizeToFitWidth = true
        rowing.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        rowing.titleLabel?.numberOfLines = 0
        rowing.titleLabel?.textAlignment = .center
        //
        biking.layer.cornerRadius = biking.frame.size.height / 2
        biking.layer.masksToBounds = true
        biking.titleLabel?.adjustsFontSizeToFitWidth = true
        biking.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        biking.titleLabel?.numberOfLines = 0
        biking.titleLabel?.textAlignment = .center
        //
        running.layer.cornerRadius = running.frame.size.height / 2
        running.layer.masksToBounds = true
        running.titleLabel?.adjustsFontSizeToFitWidth = true
        running.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        running.titleLabel?.numberOfLines = 0
        running.titleLabel?.textAlignment = .center
    }
    
    
    // Full
    @IBAction func full(_ sender: Any) {
        cardioType = 0
        performSegue(withIdentifier: "cardioSegue", sender: nil)
    }
    
    // Upper
    @IBAction func upper(_ sender: Any) {
        cardioType = 1
        performSegue(withIdentifier: "cardioSegue", sender: nil)
    }
    
    // Lower
    @IBAction func lower(_ sender: Any) {
        cardioType = 2
        performSegue(withIdentifier: "cardioSegue", sender: nil)
    }
    
    
    //
    // Remove back bar text
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Data
        if (segue.identifier == "cardioSegue") {
            //
            let destinationVC = segue.destination as! CardioChoiceFinal
            // Indicate to next screen which button was pressed
            destinationVC.cardioType = cardioType
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
