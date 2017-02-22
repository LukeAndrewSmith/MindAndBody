//
//  ClassicChoiceH.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class HomeChoice: UIViewController  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    // Buttons
    @IBOutlet weak var fullBody: UIButton!
   
    @IBOutlet weak var upperBody: UIButton!
    
    @IBOutlet weak var lowerBody: UIButton!
    
    
    @IBOutlet weak var custom: UIButton!
    
    
    
    // Information View
    @IBOutlet weak var informationView: UIScrollView!
    
    // Information Title
    @IBOutlet weak var informationVTitle: UILabel!
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    
    // Constraints
    @IBOutlet weak var fullBodyTop: NSLayoutConstraint!
    
    @IBOutlet weak var fullBodyBottom: NSLayoutConstraint!
    
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    
    @IBOutlet weak var connectionWidth: NSLayoutConstraint!
    
    @IBOutlet weak var connectionTrailing: NSLayoutConstraint!
    
    
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour3 = UserDefaults.standard.color(forKey: "colour3")!
    let colour4 = UserDefaults.standard.color(forKey: "colour4")!
    let colour7 = UserDefaults.standard.color(forKey: "colour7")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Colours
        self.view.applyGradient(colours: [colour1, colour2])
        questionMark.tintColor = colour1
        
        
        
        // Titles
        navigationBar.title = (NSLocalizedString("homeWorkout", comment: ""))
        
        // Button Titles
        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
        fullBody.titleLabel?.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        fullBody.setTitleColor(colour3, for: .normal)
        fullBody.layer.borderWidth = 8
        fullBody.layer.borderColor = colour3.cgColor
        
        upperBody.setTitle(NSLocalizedString("upperBody", comment: ""), for: UIControlState.normal)
        upperBody.titleLabel?.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        upperBody.setTitleColor(colour3, for: .normal)
        upperBody.layer.borderWidth = 8
        upperBody.layer.borderColor = colour3.cgColor
        
        lowerBody.setTitle(NSLocalizedString("lowerBody", comment: ""), for: UIControlState.normal)
        lowerBody.setTitleColor(colour3, for: .normal)
        lowerBody.titleLabel?.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        lowerBody.layer.borderWidth = 8
        lowerBody.layer.borderColor = colour3.cgColor
        
        
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        custom.layer.borderWidth = 8
        custom.layer.borderColor = colour3.cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        custom.titleLabel?.textAlignment = .center
        custom.setTitleColor(colour3, for: .normal)
        custom.layer.cornerRadius = 49/2
        custom.layer.masksToBounds = true
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        custom.titleLabel?.numberOfLines = 0
        custom.titleLabel?.textAlignment = .center
        //
        
        
        
        // Scroll View Frame
        self.informationView.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        
        view.bringSubview(toFront: informationView)
        
        
        // Information Title
        //
        // Information Title Frame
        self.informationVTitle.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 49)
        informationVTitle.text = (NSLocalizedString("information", comment: ""))
        informationVTitle.textAlignment = .center
        informationVTitle.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationVTitle.textColor = colour2
        informationVTitle.backgroundColor = colour7
        
        
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationVTitle.addGestureRecognizer(downSwipe)
        informationVTitle.isUserInteractionEnabled = true
        
        
        
        self.view.addSubview(informationVTitle)
        self.view.bringSubview(toFront: informationVTitle)
        
        
        
        // Information Text
        //
        // Information Text Frame
        let informationTextStretchingC = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationView.frame.size.width - 40, height: 0))
        
        // Information Text and Attributes
        //
        // String
        let informationLabelString = (
            (NSLocalizedString("purpose", comment: ""))+"\n"+(NSLocalizedString("purposeTextStretching", comment: ""))+"\n"+"\n"+(NSLocalizedString("body", comment: ""))+"\n"+(NSLocalizedString("bodyTextStretching", comment: ""))+"\n"+"\n"+(NSLocalizedString("mind", comment: ""))+"\n"+(NSLocalizedString("mindTextStretching", comment: "")))
        
        // Range of String
        let textRangeString = (NSLocalizedString("purpose", comment: ""))+"\n"+(NSLocalizedString("purposeTextStretching", comment: ""))+"\n"+"\n"+(NSLocalizedString("body", comment: ""))+"\n"+(NSLocalizedString("bodyTextStretching", comment: ""))+"\n"+"\n"+(NSLocalizedString("mind", comment: ""))+"\n"+(NSLocalizedString("mindTextStretching", comment: ""))
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
        lineSpacing.hyphenationFactor = 1
        
        
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Light", size: 19)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange1)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange2)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange3)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        
        
        
        // Final Text Editing
        informationTextStretchingC.attributedText = informationLabelText
        informationTextStretchingC.textAlignment = .justified
        informationTextStretchingC.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationTextStretchingC.numberOfLines = 0
        informationTextStretchingC.sizeToFit()
        self.informationView.addSubview(informationTextStretchingC)
        
        
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationTextStretchingC.frame.size.height + informationVTitle.frame.size.height + 20)
        
        
        
        // Iphone 5/SE
        
        if UIScreen.main.nativeBounds.height < 1334 {
            
            fullBodyTop.constant = 52
            fullBodyBottom.constant = 52
            stackBottom.constant = 52
            
            
            stackView.spacing = 15
            connectionWidth.constant = 15
            connectionTrailing.constant = 15
            
            
        }
    }
    
    // Layout Subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        fullBody.layer.cornerRadius = ((self.stackView.frame.size.height) * 3/2) / 2
        fullBody.layer.masksToBounds = true
        fullBody.titleLabel?.adjustsFontSizeToFitWidth = true
        fullBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        fullBody.titleLabel?.numberOfLines = 0
        fullBody.titleLabel?.textAlignment = .center
        
        upperBody.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        upperBody.layer.masksToBounds = true
        upperBody.titleLabel?.adjustsFontSizeToFitWidth = true
        upperBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        upperBody.titleLabel?.numberOfLines = 0
        upperBody.titleLabel?.textAlignment = .center
        
        
        lowerBody.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        lowerBody.layer.masksToBounds = true
        lowerBody.titleLabel?.adjustsFontSizeToFitWidth = true
        lowerBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        lowerBody.titleLabel?.numberOfLines = 0
        lowerBody.titleLabel?.textAlignment = .center
        
        
        
    }
    
    
    
    
    
    
    
    // Information Button Action
    @IBAction func informationButtonActionStretchingC(_ sender: Any) {
        
        
        if self.informationView.frame.minY < self.view.frame.maxY {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationVTitle.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            self.informationView.contentOffset.y = 0
            
            
        } else {
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationView.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationVTitle.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            self.informationView.contentOffset.y = 0
            
            
            
        }
        
        
        
    }
    
    
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.informationView.frame.minY < self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
                UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationVTitle.transform = CGAffineTransform(translationX: 0, y: 0)
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
