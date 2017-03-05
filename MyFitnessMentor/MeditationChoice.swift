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
    let colour3 = UserDefaults.standard.color(forKey: "colour3")!
    let colour4 = UserDefaults.standard.color(forKey: "colour4")!
    let colour7 = UserDefaults.standard.color(forKey: "colour7")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough1" : false])
        
        
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough1") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough1")
        }
        
        
        
        // Colours
        self.view.applyGradient(colours: [colour1, colour2])
        questionMark.tintColor = colour1
        
        
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("meditation", comment: ""))
        
        
        // Button Titles
        //
        guided.setTitle(NSLocalizedString("guided", comment: ""), for: UIControlState.normal)
        guided.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        guided.setTitleColor(colour3, for: .normal)
        guided.layer.borderWidth = 8
        guided.layer.borderColor = colour3.cgColor
        guided.titleLabel?.adjustsFontSizeToFitWidth = true
        guided.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        guided.titleLabel?.textAlignment = .center
        
        meditationTimer.setTitle(NSLocalizedString("meditationTimer", comment: ""), for: UIControlState.normal)
        meditationTimer.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        meditationTimer.setTitleColor(colour3, for: .normal)
        meditationTimer.layer.borderWidth = 8
        meditationTimer.layer.borderColor = colour3.cgColor
        meditationTimer.titleLabel?.adjustsFontSizeToFitWidth = true
        meditationTimer.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        meditationTimer.titleLabel?.textAlignment = .center
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
        informationTitleMeditationC.textColor = colour2
        informationTitleMeditationC.backgroundColor = colour7
        
        
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
            (NSLocalizedString("purpose", comment: ""))+"\n"+(NSLocalizedString("meditationPurposeText", comment: ""))+"\n"+"\n"+(NSLocalizedString("body", comment: ""))+"\n"+(NSLocalizedString("meditationBodyText", comment: ""))+"\n"+"\n"+(NSLocalizedString("mind", comment: ""))+"\n"+(NSLocalizedString("meditationMindText", comment: "")))
        
        // Range of String
        let textRangeString = (NSLocalizedString("purpose", comment: ""))+"\n"+(NSLocalizedString("meditationPurposeText", comment: ""))+"\n"+"\n"+(NSLocalizedString("body", comment: ""))+"\n"+(NSLocalizedString("meditationBodyText", comment: ""))+"\n"+"\n"+(NSLocalizedString("mind", comment: ""))+"\n"+(NSLocalizedString("meditationMindText", comment: ""))
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
        lineSpacing.lineSpacing = 1.6
        lineSpacing.hyphenationFactor = 1
        
        
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-thin", size: 21)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 21)!, range: titleRange1)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 21)!, range: titleRange2)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 21)!, range: titleRange3)
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
    
    
    @IBAction func timerButtonAction(_ sender: Any) {
        
            let delayInSeconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                
                _ = self.navigationController?.popToRootViewController(animated: false)
                
        }
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
        label.font = UIFont(name: "SFUIDisplay-light", size: 22)
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
        default: break
            
            
        }
        
        
    }
    
    
    
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    

    
}


