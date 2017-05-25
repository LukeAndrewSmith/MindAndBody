//
//  WorkoutChoice1.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Workout Choice Class -----------------------------------------------------------------------------------------------------------
//
class WorkoutChoice: UIViewController  {
    
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // Gym
    @IBOutlet weak var gym: UIButton!
    // Home
    @IBOutlet weak var home: UIButton!
    
    //
    @IBOutlet weak var custom: UIButton!
    

    // Information View
    let informationView = UIScrollView()
    // Information Title
    let informationTitle = UILabel()
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    
//
// Prepare for segue ----------------------------------------------------------------------------------------------------------------
//
    // Remove back bar text from next views
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
        
        // Titles
        navigationBar.title = (NSLocalizedString("workout", comment: ""))
        
        //
        
        // Button Titles
        //
        gym.setTitle(NSLocalizedString("gym", comment: ""), for: UIControlState.normal)
        gym.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        gym.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        gym.layer.borderWidth = 6
        gym.layer.borderColor = colour2.cgColor
        gym.setTitleColor(colour2, for: .normal)
        //
        home.setTitle(NSLocalizedString("bodyweight", comment: ""), for: UIControlState.normal)
        home.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        home.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        home.layer.borderWidth = 6
        home.layer.borderColor = colour2.cgColor
        home.setTitleColor(colour2, for: .normal)
        
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

     
        // Information
        //
        // Scroll View Frame
        informationView.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        informationView.backgroundColor = colour1
        // Information Title
        //
        // Information Title Frame
        informationTitle.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 49)
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
            (NSLocalizedString("purpose", comment: ""))+"\n"+(NSLocalizedString("purposeTextWorkout", comment: ""))+"\n"+"\n"+(NSLocalizedString("body", comment: ""))+"\n"+(NSLocalizedString("bodyTextWorkout", comment: ""))+"\n"+"\n"+(NSLocalizedString("mind", comment: ""))+"\n"+(NSLocalizedString("mindTextWorkout", comment: "")))
        // Range of String
        let textRangeString = (NSLocalizedString("purpose", comment: ""))+"\n"+(NSLocalizedString("purposeTextWorkout", comment: ""))+"\n"+"\n"+(NSLocalizedString("body", comment: ""))+"\n"+(NSLocalizedString("bodyTextWorkout", comment: ""))+"\n"+"\n"+(NSLocalizedString("mind", comment: ""))+"\n"+(NSLocalizedString("mindTextWorkout", comment: ""))
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
        informationTextStretchingC.attributedText = informationLabelText
        informationTextStretchingC.textAlignment = .natural
        informationTextStretchingC.lineBreakMode = NSLineBreakMode.byWordWrapping
        informationTextStretchingC.numberOfLines = 0
        informationTextStretchingC.sizeToFit()
        self.informationView.addSubview(informationTextStretchingC)
        //
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationTextStretchingC.frame.size.height + informationTitle.frame.size.height + 20)
    }
    
    
//
// View did layout subview ------------------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        gym.layer.cornerRadius = ((self.stackView.frame.size.height) - 40) / 4
        gym.layer.masksToBounds = true
        gym.titleLabel?.adjustsFontSizeToFitWidth = true
        gym.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        gym.titleLabel?.numberOfLines = 0
        gym.titleLabel?.textAlignment = .center
        //
        home.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        home.layer.masksToBounds = true
        home.titleLabel?.adjustsFontSizeToFitWidth = true
        home.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        home.titleLabel?.numberOfLines = 0
        home.titleLabel?.textAlignment = .center
    }
    
    
//
// Information Actions ----------------------------------------------------------------------------------------------------------------
//
    // Information Button
    @IBAction func informationButtonActionWorkoutC(_ sender: Any) {
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
    
    //
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }

}
