//
//  CardioChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class CardioChoice: UIViewController  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Hiit
    @IBOutlet weak var hiit: UIButton!
    
    // Liss
    @IBOutlet weak var liss: UIButton!
    
    // Information Screen
    @IBOutlet weak var informationViewCardioC: UIView!
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.walkthroughMindBody()
        }
        
        // Colours
        self.view.applyGradient(colours: [colour1, colour2])
        questionMark.tintColor = colour1
        
        
        
        // Titles
        navigationBar.title = (NSLocalizedString("type", comment: ""))
        
        // Button Titles
        hiit.setTitle(NSLocalizedString("hiit", comment: ""), for: UIControlState.normal)
        hiit.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        hiit.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        hiit.layer.borderWidth = 10
        hiit.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        hiit.titleLabel?.adjustsFontSizeToFitWidth = true
        hiit.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        hiit.titleLabel?.textAlignment = .center
        
        
        
        liss.setTitle(NSLocalizedString("liss", comment: ""), for: UIControlState.normal)
        liss.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        liss.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        liss.layer.borderWidth = 10
        liss.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        liss.titleLabel?.adjustsFontSizeToFitWidth = true
        liss.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        liss.titleLabel?.textAlignment = .center
        
        
        
        // Information
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipesCardioC))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        self.informationViewCardioC.addGestureRecognizer(downSwipe)
        
        self.informationViewCardioC.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height), width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        
        view.bringSubview(toFront: informationViewCardioC)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        hiit.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        hiit.layer.masksToBounds = true
        hiit.titleLabel?.adjustsFontSizeToFitWidth = true
        hiit.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        hiit.titleLabel?.numberOfLines = 0
        hiit.titleLabel?.textAlignment = .center
        
        liss.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        liss.layer.masksToBounds = true
        liss.titleLabel?.adjustsFontSizeToFitWidth = true
        liss.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        liss.titleLabel?.numberOfLines = 0
        liss.titleLabel?.textAlignment = .center

    }
    
    
    @IBAction func informationButtonActionCardioC(_ sender: Any) {
        if self.informationViewCardioC.frame.maxY == (self.view.frame.maxY + ((self.view.frame.size.height))) {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewCardioC.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
                
            }, completion: nil)
            
        } else if self.informationViewCardioC.frame.maxY == self.view.frame.maxY {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewCardioC.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
        }

    }
    
    @IBAction func handleSwipesCardioC(extraSwipe:UISwipeGestureRecognizer) {
        
        if (extraSwipe.direction == .down){
            
            if self.informationViewCardioC.frame.maxY == self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewCardioC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
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
        label.font = UIFont(name: "SFUIDisplay-light", size: 23)
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
            path.addArc(center: CGPoint(x: view.frame.size.width - 31, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
