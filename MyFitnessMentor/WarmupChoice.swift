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
    
    // Information Title
    @IBOutlet weak var informationTitleWarmupC: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("warmup", comment: ""))
        
        
        // Button Titles
        //
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
        //
        
        
        
        
        
        
        
        // Scroll View Frame
        self.informationViewWarmupC.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height + 49), width: self.view.frame.size.width, height: (self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height - 49)
        
        view.bringSubview(toFront: informationViewWarmupC)
        
        
        
        
       
        
       
        // Information Title
        //
        // Information Title Frame
        self.informationTitleWarmupC.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height), width: self.informationViewWarmupC.frame.size.width, height: 49)
        informationTitleWarmupC.text = (NSLocalizedString("information", comment: ""))
        informationTitleWarmupC.textAlignment = .center
        informationTitleWarmupC.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitleWarmupC.textColor = .white
        informationTitleWarmupC.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
        
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationTitleWarmupC.addGestureRecognizer(downSwipe)
        informationTitleWarmupC.isUserInteractionEnabled = true
        
        
        
        self.view.addSubview(informationTitleWarmupC)
        
        
        
        // Information Text
        //
        // Information Text Frame
        let informationTextWarmupC = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationViewWarmupC.frame.size.width - 40, height: 0))
        
        // Information Text and Attributes
        //
        // String
        let informationLabelString = (
            (NSLocalizedString("purpose", comment: ""))+"\n"+(NSLocalizedString("purposeText", comment: ""))+"\n"+"\n"+(NSLocalizedString("body", comment: ""))+"\n"+(NSLocalizedString("bodyText", comment: ""))+"\n"+"\n"+(NSLocalizedString("mind", comment: ""))+"\n"+(NSLocalizedString("mindText", comment: "")))
        
        // Range of String
        let textRangeString = (NSLocalizedString("purpose", comment: ""))+"\n"+(NSLocalizedString("purposeText", comment: ""))+"\n"+"\n"+(NSLocalizedString("body", comment: ""))+"\n"+(NSLocalizedString("bodyText", comment: ""))+"\n"+"\n"+(NSLocalizedString("mind", comment: ""))+"\n"+(NSLocalizedString("mindText", comment: ""))
        let textRange = (informationLabelString as NSString).range(of: textRangeString)
        
        
        // Range of Titles
        let titleRangeString1 = (NSLocalizedString("purpose", comment: ""))
        let titleRangeString2 = (NSLocalizedString("body", comment: ""))
        let titleRangeString3 = (NSLocalizedString("mind", comment: ""))
        
        let titleRange1 = (informationLabelString as NSString).range(of: titleRangeString1)
        let titleRange2 = (informationLabelString as NSString).range(of: titleRangeString2)
        let titleRange3 = (informationLabelString as NSString).range(of: titleRangeString3)
        
        
        // Line Spacing
        let lineSpacing = NSMutableParagraphStyle()
        lineSpacing.lineSpacing = 1.4
        
        
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Light", size: 19)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange1)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange2)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange3)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        
        
        
        // Final Text Editing
        informationTextWarmupC.attributedText = informationLabelText
        informationTextWarmupC.textAlignment = .justified
        informationTextWarmupC.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationTextWarmupC.numberOfLines = 0
        informationTextWarmupC.sizeToFit()
        self.informationViewWarmupC.addSubview(informationTextWarmupC)
        
        
        self.informationViewWarmupC.contentSize = CGSize(width: self.view.frame.size.width, height: informationTextWarmupC.frame.size.height + informationTitleWarmupC.frame.size.height + 20)
        
    }
    
    
    @IBAction func informationButtonActionWarmupC(_ sender: Any) {
        
        if self.informationViewWarmupC.frame.maxY == (self.view.frame.maxY + ((self.view.frame.size.height) - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height)) {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewWarmupC.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            
                self.informationTitleWarmupC.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height)))
            }, completion: nil)
            self.informationViewWarmupC.contentOffset.y = 0
            
        } else if self.informationViewWarmupC.frame.maxY == (self.view.frame.maxY - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height) {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewWarmupC.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitleWarmupC.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            self.informationViewWarmupC.contentOffset.y = 0
        }

    }
    
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.informationViewWarmupC.frame.maxY == (self.view.frame.maxY - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height) {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewWarmupC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
                UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationTitleWarmupC.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)

            }
        }
    }
    
    
    
    // Remove Back Bar Text
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
}
