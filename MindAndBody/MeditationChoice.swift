//
//  MindfulnessChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Meditation Choice Class --------------------------------------------------------------------------------------------------
//
class MeditationChoice: UIViewController, UIScrollViewDelegate  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Buttons
    @IBOutlet weak var guided: UIButton!
    @IBOutlet weak var meditationTimer: UIButton!
    @IBOutlet weak var breathing: UIButton!
    
    // Stack
    @IBOutlet weak var stackView: UIStackView!
    
    
    // Information View
    let informationView = UIScrollView()
    // Information Title
    let informationTitle = UILabel()
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
   
    
    // Constraints
    @IBOutlet weak var timerTop: NSLayoutConstraint!
    @IBOutlet weak var timerBottom: NSLayoutConstraint!
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    
    
//
// View did load -------------------------------------------------------------------------------------------------------
//
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
        view.backgroundColor = colour1
        questionMark.tintColor = colour1
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString("meditation", comment: ""))
    
        // Button Titles
        //
        guided.setTitle(NSLocalizedString("guided", comment: ""), for: UIControlState.normal)
        guided.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        guided.setTitleColor(colour2, for: .normal)
        guided.layer.borderWidth = 6
        guided.layer.borderColor = colour2.cgColor
        guided.titleLabel?.adjustsFontSizeToFitWidth = true
        guided.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        guided.titleLabel?.textAlignment = .center
        //
        meditationTimer.setTitle(NSLocalizedString("meditationTimer", comment: ""), for: UIControlState.normal)
        meditationTimer.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        meditationTimer.setTitleColor(colour2, for: .normal)
        meditationTimer.layer.borderWidth = 6
        meditationTimer.layer.borderColor = colour2.cgColor
        meditationTimer.titleLabel?.adjustsFontSizeToFitWidth = true
        meditationTimer.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        meditationTimer.titleLabel?.textAlignment = .center
        //
        breathing.setTitle(NSLocalizedString("breathing", comment: ""), for: UIControlState.normal)
        breathing.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        breathing.setTitleColor(colour2, for: .normal)
        breathing.layer.borderWidth = 6
        breathing.layer.borderColor = colour2.cgColor
        breathing.titleLabel?.adjustsFontSizeToFitWidth = true
        breathing.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        breathing.titleLabel?.textAlignment = .center
        
        //Information
        //
        // Scroll View Frame
        self.informationView.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        informationView.backgroundColor = colour1
        // Information Title
        //
        // Information Title Frame
        self.informationTitle.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 49)
        informationTitle.text = (NSLocalizedString("information", comment: ""))
        informationTitle.textAlignment = .center
        informationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitle.textColor = colour1
        informationTitle.backgroundColor = colour2
        //
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationTitle.addGestureRecognizer(downSwipe)
        informationTitle.isUserInteractionEnabled = true
        // Information Text
        //
        // Information Text Frame
        let informationTextMeditationC = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationView.frame.size.width - 40, height: 0))
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
        //
        let titleRange1 = (informationLabelString as NSString).range(of: titleRangeString1)
        let titleRange2 = (informationLabelString as NSString).range(of: titleRangeString2)
        let titleRange3 = (informationLabelString as NSString).range(of: titleRangeString3)
        // Line Spacing
        let lineSpacing = NSMutableParagraphStyle()
        lineSpacing.lineSpacing = 1.6
        // Add Attributes
        let informationLabelText = NSMutableAttributedString(string: informationLabelString)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-thin", size: 21)!, range: textRange)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 21)!, range: titleRange1)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 21)!, range: titleRange2)
        informationLabelText.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-Medium", size: 21)!, range: titleRange3)
        informationLabelText.addAttribute(NSParagraphStyleAttributeName, value: lineSpacing, range: textRange)
        // Final Text Editing
        informationTextMeditationC.attributedText = informationLabelText
        informationTextMeditationC.textAlignment = .natural
        informationTextMeditationC.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationTextMeditationC.numberOfLines = 0
        informationTextMeditationC.sizeToFit()
        self.informationView.addSubview(informationTextMeditationC)
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationTextMeditationC.frame.size.height + informationTitle.frame.size.height + 20)
        
        
        // Iphone 5/SE
        if UIScreen.main.nativeBounds.height < 1334 {
            //
            timerTop.constant = 52
            timerBottom.constant = 52
            stackBottom.constant = 52
            //
            stackView.spacing = 15
        }
    }
    
    
//
// View did layout subviews -------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        meditationTimer.layer.cornerRadius = ((self.stackView.frame.size.height) * 3/2) / 2
        meditationTimer.layer.masksToBounds = true
        //
        guided.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        guided.layer.masksToBounds = true
        //
        breathing.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        breathing.layer.masksToBounds = true
        
    }
    
    
//
// Information Actions ----------------------------------------------------------------------------------------------------------------
//
    @IBAction func informationButtonActionMeditationC(_ sender: Any) {
        // Slide information down
        if self.informationView.frame.minY < self.view.frame.maxY {
            // Animate slide
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: { finished in
            // Remove after animation
                self.informationView.removeFromSuperview()
                self.informationTitle.removeFromSuperview()
            })
            // Navigation buttons
            questionMark.image = #imageLiteral(resourceName: "QuestionMarkN")
            navigationBar.setHidesBackButton(false, animated: true)
            
            // Slide information up
        } else {
            //
            view.addSubview(informationView)
            view.addSubview(informationTitle)
            //
            view.bringSubview(toFront: informationView)
            view.bringSubview(toFront: informationTitle)
            // Animate slide
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.informationView.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
            }, completion: nil)
            //
            self.informationView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            // Navigation buttons
            questionMark.image = #imageLiteral(resourceName: "Down")
            navigationBar.setHidesBackButton(true, animated: true)
        }
    }
    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        // Information Swipe Down
        if (extraSwipe.direction == .down){
            // Animate slide
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: { finished in
                // Remove after animation
                self.informationView.removeFromSuperview()
                self.informationTitle.removeFromSuperview()
            })
            // Navigation buttons
            questionMark.image = #imageLiteral(resourceName: "QuestionMarkN")
            navigationBar.setHidesBackButton(false, animated: true)
        }
    }

    
//
// Remove Back Bar Text
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
    }
  
    
//
// Walkthrogh -------------------------------------------------------------------------------------------------------
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


