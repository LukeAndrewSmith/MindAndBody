//
//  MindfulnessChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class MeditationChoice: UIViewController, UIScrollViewDelegate  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var guided: UIButton!
    
    @IBOutlet weak var meditationTimer: UIButton!
    
    
    // Information View
    @IBOutlet weak var informationViewMeditationC: UIScrollView!
    
    // Information Title
    @IBOutlet weak var informationTitleMeditationC: UILabel!
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
  
    
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colours
        self.view.applyGradient(colours: [colour1, colour2])
        questionMark.tintColor = colour1
        
        
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("meditation", comment: ""))
        
        
        // Button Titles
        //
        guided.setTitle(NSLocalizedString("guided", comment: ""), for: UIControlState.normal)
        guided.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        guided.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        guided.layer.borderWidth = 10
        guided.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        
        meditationTimer.setTitle(NSLocalizedString("meditationTimer", comment: ""), for: UIControlState.normal)
        meditationTimer.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        meditationTimer.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        meditationTimer.layer.borderWidth = 10
        meditationTimer.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        //
        
        
        
        
        
        
        // Scroll View Frame
        self.informationViewMeditationC.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        
        view.bringSubview(toFront: informationViewMeditationC)
        
        
        
        
        
        
        
        // Information Title
        //
        // Information Title Frame
        self.informationTitleMeditationC.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 49)
        informationTitleMeditationC.text = (NSLocalizedString("information", comment: ""))
        informationTitleMeditationC.textAlignment = .center
        informationTitleMeditationC.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitleMeditationC.textColor = .white
        informationTitleMeditationC.backgroundColor = colour2
        
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationTitleMeditationC.addGestureRecognizer(downSwipe)
        informationTitleMeditationC.isUserInteractionEnabled = true
        
        
        
        self.view.addSubview(informationTitleMeditationC)
        self.view.bringSubview(toFront: informationTitleMeditationC)
        
        
        
        // Information Text
        //
        // Information Text Frame
        let informationTextMeditationC = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationViewMeditationC.frame.size.width - 40, height: 0))
        
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
        lineSpacing.hyphenationFactor = 1
        
        
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Light", size: 19)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange1)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange2)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 19)!, range: titleRange3)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        
        
        
        // Final Text Editing
        informationTextMeditationC.attributedText = informationLabelText
        informationTextMeditationC.textAlignment = .justified
        informationTextMeditationC.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationTextMeditationC.numberOfLines = 0
        informationTextMeditationC.sizeToFit()
        self.informationViewMeditationC.addSubview(informationTextMeditationC)
        
        
        self.informationViewMeditationC.contentSize = CGSize(width: self.view.frame.size.width, height: informationTextMeditationC.frame.size.height + informationTitleMeditationC.frame.size.height + 20)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guided.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        guided.layer.masksToBounds = true
        
        meditationTimer.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        meditationTimer.layer.masksToBounds = true
        
        
    }
    
    
    
    
    // Information Button Action
    @IBAction func informationButtonActionMeditationC(_ sender: Any) {
        
        
        if self.informationViewMeditationC.frame.minY < self.view.frame.maxY {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewMeditationC.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitleMeditationC.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            self.informationViewMeditationC.contentOffset.y = 0
            
            
        } else {
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewMeditationC.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitleMeditationC.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            self.informationViewMeditationC.contentOffset.y = 0
            
            
            
        }
        
        
        
    }
    
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.informationViewMeditationC.frame.minY < self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewMeditationC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
                UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationTitleMeditationC.transform = CGAffineTransform(translationX: 0, y: 0)
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


