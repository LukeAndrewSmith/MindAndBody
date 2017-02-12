//
//  YogaChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class YogaChoice: UIViewController, UIScrollViewDelegate  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var guided: UIButton!
    
    @IBOutlet weak var custom: UIButton!
    
    @IBOutlet weak var practices: UIButton!
    
    // Information View
    @IBOutlet weak var informationViewYogaC: UIScrollView!
    
    // Information Title
    @IBOutlet weak var informationTitleYogaC: UILabel!
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    
    // Constraints
    @IBOutlet weak var practicesTop: NSLayoutConstraint!
    
    @IBOutlet weak var practicesBottom: NSLayoutConstraint!
    
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    
    
    
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Walkthrough
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
        navigationBar.title = (NSLocalizedString("yoga", comment: ""))
        
        
        // Button Titles
        //
        guided.setTitle(NSLocalizedString("guided", comment: ""), for: UIControlState.normal)
        guided.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        guided.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        guided.layer.borderWidth = 10
        guided.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        guided.titleLabel?.adjustsFontSizeToFitWidth = true
        guided.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        guided.titleLabel?.textAlignment = .center
        
        
        
        
        custom.setTitle(NSLocalizedString("custom", comment: ""), for: UIControlState.normal)
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        custom.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        custom.layer.borderWidth = 10
        custom.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        custom.titleLabel?.textAlignment = .center
        

    
        practices.setTitle(NSLocalizedString("practices", comment: ""), for: UIControlState.normal)
        practices.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        practices.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        practices.layer.borderWidth = 10
        practices.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        practices.titleLabel?.adjustsFontSizeToFitWidth = true
        practices.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        practices.titleLabel?.textAlignment = .center
        //
        
        
        
        
        
        
        
        // Scroll View Frame
        self.informationViewYogaC.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        
        view.bringSubview(toFront: informationViewYogaC)
        
        
        
        
        
        
        
        // Information Title
        //
        // Information Title Frame
        self.informationTitleYogaC.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 49)
        informationTitleYogaC.text = (NSLocalizedString("information", comment: ""))
        informationTitleYogaC.textAlignment = .center
        informationTitleYogaC.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitleYogaC.textColor = .white
        informationTitleYogaC.backgroundColor = colour2
        
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationTitleYogaC.addGestureRecognizer(downSwipe)
        informationTitleYogaC.isUserInteractionEnabled = true
        
        
        
        self.view.addSubview(informationTitleYogaC)
        self.view.bringSubview(toFront: informationTitleYogaC)
        
        
        
        // Information Text
        //
        // Information Text Frame
        let informationTextYogaC = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationViewYogaC.frame.size.width - 40, height: 0))
        
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
        informationTextYogaC.attributedText = informationLabelText
        informationTextYogaC.textAlignment = .justified
        informationTextYogaC.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationTextYogaC.numberOfLines = 0
        informationTextYogaC.sizeToFit()
        self.informationViewYogaC.addSubview(informationTextYogaC)
        
        
        self.informationViewYogaC.contentSize = CGSize(width: self.view.frame.size.width, height: informationTextYogaC.frame.size.height + informationTitleYogaC.frame.size.height + 20)
        
        
        // Iphone 5/SE
        
        if UIScreen.main.nativeBounds.height < 1334 {
            
            practicesTop.constant = 52
            practicesBottom.constant = 52
            stackBottom.constant = 52
        
            stackView.spacing = 15
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guided.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        guided.layer.masksToBounds = true
        guided.titleLabel?.adjustsFontSizeToFitWidth = true
        guided.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        guided.titleLabel?.numberOfLines = 0
        guided.titleLabel?.textAlignment = .center
        
        custom.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        custom.layer.masksToBounds = true
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        custom.titleLabel?.numberOfLines = 0
        custom.titleLabel?.textAlignment = .center
        
        practices.layer.cornerRadius = (self.stackView.frame.size.height * 3/2) / 2
        practices.layer.masksToBounds = true
        practices.titleLabel?.adjustsFontSizeToFitWidth = true
        practices.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,10)
        practices.titleLabel?.numberOfLines = 0
        practices.titleLabel?.textAlignment = .center
        
        
        
        
    }
    
    
    
    
    // Information Button Action
    @IBAction func informationButtonActionYogaC(_ sender: Any) {
        
        
        if self.informationViewYogaC.frame.minY < self.view.frame.maxY {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewYogaC.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitleYogaC.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            self.informationViewYogaC.contentOffset.y = 0
            
            
        } else {
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewYogaC.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitleYogaC.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            self.informationViewYogaC.contentOffset.y = 0
            
            
            
        }
        
        
        
    }
    
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.informationViewYogaC.frame.minY < self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewYogaC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
                UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationTitleYogaC.transform = CGAffineTransform(translationX: 0, y: 0)
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
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
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
