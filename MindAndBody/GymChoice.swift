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
    
    // Custom
    @IBOutlet weak var custom: UIButton!
    
    // Information View
    let informationView = UIScrollView()
    // Information Title
    let informationTitle = UILabel()
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    // Constraints
    @IBOutlet weak var classicTop: NSLayoutConstraint!
    
    @IBOutlet weak var classicBottom: NSLayoutConstraint!
    
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
    
//
// Remove back button text on subsequent screens
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        self.view.applyGradient(colours: [colour1, colour1])
        questionMark.tintColor = colour1
        
        // Titles
        navigationBar.title = (NSLocalizedString("workoutType", comment: ""))
        
        // Button Titles
        classic.setTitle(NSLocalizedString("classic", comment: ""), for: UIControlState.normal)
        classic.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        classic.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        classic.layer.borderWidth = 8
        classic.layer.borderColor = colour2.cgColor
        classic.setTitleColor(colour2, for: .normal)
        //
        circuit.setTitle(NSLocalizedString("circuit", comment: ""), for: UIControlState.normal)
        circuit.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        circuit.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        circuit.layer.borderWidth = 8
        circuit.layer.borderColor = colour2.cgColor
        circuit.setTitleColor(colour2, for: .normal)
        //
        fiveByFive.setTitle(NSLocalizedString("5x5", comment: ""), for: UIControlState.normal)
        fiveByFive.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        fiveByFive.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        fiveByFive.layer.borderWidth = 8
        fiveByFive.layer.borderColor = colour2.cgColor
        fiveByFive.setTitleColor(colour2, for: .normal)
        //
        custom.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        custom.layer.borderWidth = 7
        custom.layer.borderColor = colour2.cgColor
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleEdgeInsets = UIEdgeInsetsMake(0,7,0,7)
        custom.titleLabel?.textAlignment = .center
        custom.setTitleColor(colour2, for: .normal)
        custom.layer.cornerRadius = 49/2
        custom.layer.masksToBounds = true
        custom.titleLabel?.adjustsFontSizeToFitWidth = true
        custom.titleLabel?.numberOfLines = 0
        custom.titleLabel?.textAlignment = .center
        //
        
        // Information
        //
        // Scroll View Frame
        informationView.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
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
        let informationTextStretchingC = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationView.frame.size.width - 40, height: 0))
        // Information Text and Attributes
        //
        // String
        let informationLabelString = (
            (NSLocalizedString("classic", comment: ""))+"\n"+(NSLocalizedString("workoutTypeClassic", comment: ""))+"\n"+"\n"+(NSLocalizedString("circuit", comment: ""))+"\n"+(NSLocalizedString("workoutTypeCircuit", comment: ""))+"\n"+"\n"+(NSLocalizedString("5x5", comment: ""))+"\n"+(NSLocalizedString("workoutType5x5", comment: "")))
        // Range of String
        let textRangeString = (NSLocalizedString("classic", comment: ""))+"\n"+(NSLocalizedString("workoutTypeClassic", comment: ""))+"\n"+"\n"+(NSLocalizedString("circuit", comment: ""))+"\n"+(NSLocalizedString("workoutTypeCircuit", comment: ""))+"\n"+"\n"+(NSLocalizedString("5x5", comment: ""))+"\n"+(NSLocalizedString("workoutType5x5", comment: ""))
        let textRange = (informationLabelString as NSString).range(of: textRangeString)
        // Range of Titles
        let titleRangeString1 = (NSLocalizedString("classic", comment: ""))
        let titleRangeString2 = (NSLocalizedString("circuit", comment: ""))
        let titleRangeString3 = (NSLocalizedString("5x5", comment: ""))
        //
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
        informationTextStretchingC.attributedText = informationLabelText
        informationTextStretchingC.textAlignment = .justified
        informationTextStretchingC.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationTextStretchingC.numberOfLines = 0
        informationTextStretchingC.sizeToFit()
        self.informationView.addSubview(informationTextStretchingC)
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationTextStretchingC.frame.size.height + informationTitle.frame.size.height + 20)
    
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
// Information Actions ----------------------------------------------------------------------------------------------------------------
//
    @IBAction func informationButtonActionWorkoutC(_ sender: Any) {
        // Slide information down
        if self.informationView.frame.minY < self.view.frame.maxY {
            // Animate slide
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            //
            self.informationView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            // Remove after animation
            let delayInSeconds = 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.informationView.removeFromSuperview()
                self.informationTitle.removeFromSuperview()
            }
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
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
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
    
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        // Information Swipe Down
        if (extraSwipe.direction == .down){
            // Animate slide
            if self.informationView.frame.minY < self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    self.informationView.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.informationTitle.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
                // Navigation buttons
                questionMark.image = #imageLiteral(resourceName: "QuestionMarkN")
                navigationBar.setHidesBackButton(false, animated: true)
            }
        }
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
            path.addArc(center: CGPoint(x: custom.center.x, y: custom.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.height), radius: 24.5, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
