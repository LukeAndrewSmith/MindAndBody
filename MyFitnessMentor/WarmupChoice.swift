//
//  MyWarmupOverview.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 28/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class WarmupChoice: UIViewController, UIScrollViewDelegate  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Full Body
    @IBOutlet weak var fullBody: UIButton!
    
    // Upper Lower
    @IBOutlet weak var upperBody: UIButton!
    
    // Legs Pull Push
    @IBOutlet weak var lowerBody: UIButton!
    
    // Cardio
    @IBOutlet weak var cardio: UIButton!
    
    // Information View
    @IBOutlet weak var informationViewWarmupC: UIScrollView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        // Titles
        navigationBar.title = (NSLocalizedString("warmup", comment: ""))
        
        // Button Titles
        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
        fullBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        fullBody.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            //.white
        fullBody.layer.borderWidth = 10
        fullBody.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        fullBody.layer.cornerRadius = self.fullBody.frame.size.height / 2
        
        
        upperBody.setTitle(NSLocalizedString("upperBody", comment: ""), for: UIControlState.normal)
        upperBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        upperBody.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            //.white
        upperBody.layer.borderWidth = 10
        upperBody.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        upperBody.layer.cornerRadius = self.upperBody.frame.size.height / 2
       
        
        lowerBody.setTitle(NSLocalizedString("lowerBody", comment: ""), for: UIControlState.normal)
        lowerBody.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        lowerBody.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            //.white
        lowerBody.layer.borderWidth = 10
        lowerBody.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        lowerBody.layer.cornerRadius = self.lowerBody.frame.size.height / 2
        
        
        cardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        cardio.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        cardio.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            //.white
        cardio.layer.borderWidth = 10
        cardio.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        cardio.layer.cornerRadius = self.cardio.frame.size.height / 2
        
        
        // Information
//        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipesWarmupC))
//        downSwipe.direction = UISwipeGestureRecognizerDirection.down
//        self.informationViewWarmupC.addGestureRecognizer(downSwipe)
        
        self.informationViewWarmupC.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height), width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        
        
        view.bringSubview(toFront: informationViewWarmupC)
        
        
        
        
        // Information
        let informationTitleWarmupC = UILabel(frame: CGRect(x: 0, y: 0, width: self.informationViewWarmupC.frame.size.width, height: 49))
        informationTitleWarmupC.text = (NSLocalizedString("information", comment: ""))
        informationTitleWarmupC.textAlignment = .center
        informationTitleWarmupC.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitleWarmupC.textColor = .white
        informationTitleWarmupC.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
        self.informationViewWarmupC.addSubview(informationTitleWarmupC)
        
        
        let informationTextWarmupC = UILabel(frame: CGRect(x: 20, y: 69, width: self.informationViewWarmupC.frame.size.width - 40, height: 0))
        informationTextWarmupC.text = (
            (NSLocalizedString("purpose", comment: ""))+"\n"+(NSLocalizedString("purposeText", comment: ""))+"\n"+"\n"+(NSLocalizedString("body", comment: ""))+"\n"+(NSLocalizedString("bodyText", comment: ""))+"\n"+"\n"+(NSLocalizedString("mind", comment: ""))+"\n"+(NSLocalizedString("mindText", comment: ""))
            )
        informationTextWarmupC.textAlignment = .justified
        informationTextWarmupC.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationTextWarmupC.numberOfLines = 0
        informationTextWarmupC.sizeToFit()
        informationTextWarmupC.font = UIFont(name: "SFUIDisplay-light", size: 19)
        self.informationViewWarmupC.addSubview(informationTextWarmupC)

    }
    
    
    @IBAction func informationButtonActionWarmupC(_ sender: Any) {
        
        if self.informationViewWarmupC.frame.maxY == (self.view.frame.maxY + ((self.view.frame.size.height))) {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewWarmupC.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
                
            }, completion: nil)
            
        } else if self.informationViewWarmupC.frame.maxY == self.view.frame.maxY {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewWarmupC.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
        }

    }
    
    
    @IBAction func handleSwipesWarmupC(extraSwipe:UISwipeGestureRecognizer) {
        
        if (extraSwipe.direction == .down){
            
            if self.informationViewWarmupC.frame.maxY == self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewWarmupC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
            } else {
                
            }
            
            
        }
        
    }

    
    
}
