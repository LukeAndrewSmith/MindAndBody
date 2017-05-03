//
//  WorkoutChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Classic Choice Class -------------------------------------------------------------------------------------------------------
//
class ClassicChoiceG: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Full Body
    @IBOutlet weak var fullBody: UIButton!

    // Upper Lower
    @IBOutlet weak var upperBody: UIButton!
    @IBOutlet weak var lowerBody: UIButton!
    
    // Legs Pull Push
    @IBOutlet weak var legs: UIButton!
    @IBOutlet weak var pull: UIButton!
    @IBOutlet weak var push: UIButton!
    
    // Information View
    let informationView = UIScrollView()
    // Information Title
    let informationTitle = UILabel()
    
    // Stack Views
    @IBOutlet weak var stackView1: UIStackView!
    //
    @IBOutlet weak var stackView2: UIStackView!
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    // Constraints
    @IBOutlet weak var fullTop: NSLayoutConstraint!
    //
    @IBOutlet weak var fullBottom: NSLayoutConstraint!
    //
    @IBOutlet weak var stack1Bottom: NSLayoutConstraint!
    //
    @IBOutlet weak var stack2Bottom: NSLayoutConstraint!
        //
    @IBOutlet weak var connection1Width: NSLayoutConstraint!
    //
    @IBOutlet weak var connection2Width: NSLayoutConstraint!
    //
    @IBOutlet weak var connection2Trailing: NSLayoutConstraint!
    //
    @IBOutlet weak var connection3Width: NSLayoutConstraint!
    //
    @IBOutlet weak var connection3Trailing: NSLayoutConstraint!
   
    //
    var workoutType2 = Int()
//
// View did load ----------------------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colours
        view.backgroundColor = colour1
        questionMark.tintColor = colour1
        
        // Titles
        navigationBar.title = (NSLocalizedString("classic", comment: ""))
        
        // Button Titles
        fullBody.setTitle(NSLocalizedString("fullBody", comment: ""), for: UIControlState.normal)
        fullBody.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        fullBody.setTitleColor(colour2, for: .normal)
        fullBody.layer.borderWidth = 8
        fullBody.layer.borderColor = colour2.cgColor
        fullBody.titleLabel?.adjustsFontSizeToFitWidth = true
        fullBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        fullBody.titleLabel?.textAlignment = .center
        // Change title if iPhone SE/5
        if UIScreen.main.nativeBounds.height < 1334 {
            upperBody.setTitle(NSLocalizedString("upper", comment: ""), for: UIControlState.normal)
            lowerBody.setTitle(NSLocalizedString("lower", comment: ""), for: UIControlState.normal)
        } else {
            upperBody.setTitle(NSLocalizedString("upperBody", comment: ""), for: UIControlState.normal)
            lowerBody.setTitle(NSLocalizedString("lowerBody", comment: ""), for: UIControlState.normal)
        }
        //
        upperBody.setTitle(NSLocalizedString("upper", comment: ""), for: UIControlState.normal)
        upperBody.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        upperBody.setTitleColor(colour2, for: .normal)
        upperBody.layer.borderWidth = 8
        upperBody.layer.borderColor = colour2.cgColor
        upperBody.titleLabel?.adjustsFontSizeToFitWidth = true
        upperBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        upperBody.titleLabel?.textAlignment = .center
        //
        lowerBody.setTitle(NSLocalizedString("lower", comment: ""), for: UIControlState.normal)
        lowerBody.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        lowerBody.setTitleColor(colour2, for: .normal)
        lowerBody.layer.borderWidth = 8
        lowerBody.layer.borderColor = colour2.cgColor
        lowerBody.titleLabel?.adjustsFontSizeToFitWidth = true
        lowerBody.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        lowerBody.titleLabel?.textAlignment = .center
        //
        legs.setTitle(NSLocalizedString("legs", comment: ""), for: UIControlState.normal)
        legs.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        legs.setTitleColor(colour2, for: .normal)
        legs.layer.borderWidth = 8
        legs.layer.borderColor = colour2.cgColor
        legs.titleLabel?.adjustsFontSizeToFitWidth = true
        legs.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        legs.titleLabel?.textAlignment = .center
        //
        pull.setTitle(NSLocalizedString("pull", comment: ""), for: UIControlState.normal)
        pull.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        pull.setTitleColor(colour2, for: .normal)
        pull.layer.borderWidth = 8
        pull.layer.borderColor = colour2.cgColor
        pull.titleLabel?.adjustsFontSizeToFitWidth = true
        pull.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        pull.titleLabel?.textAlignment = .center
        //
        push.setTitle(NSLocalizedString("push", comment: ""), for: UIControlState.normal)
        push.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        push.setTitleColor(colour2, for: .normal)
        push.layer.borderWidth = 8
        push.layer.borderColor = colour2.cgColor
        push.titleLabel?.adjustsFontSizeToFitWidth = true
        push.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        push.titleLabel?.textAlignment = .center
        
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
            (NSLocalizedString("fullBody", comment: ""))+"\n"+(NSLocalizedString("fullBodyInformation", comment: ""))+"\n"+"\n"+(NSLocalizedString("upperLower", comment: ""))+"\n"+(NSLocalizedString("upperLowerInformation", comment: ""))+"\n"+"\n"+(NSLocalizedString("legsPullPush", comment: ""))+"\n"+(NSLocalizedString("legsPullPushInformation", comment: "")))
        // Range of String
        let textRangeString = (NSLocalizedString("fullBody", comment: ""))+"\n"+(NSLocalizedString("fullBodyInformation", comment: ""))+"\n"+"\n"+(NSLocalizedString("upperLower", comment: ""))+"\n"+(NSLocalizedString("upperLowerInformation", comment: ""))+"\n"+"\n"+(NSLocalizedString("legsPullPush", comment: ""))+"\n"+(NSLocalizedString("legsPullPushInformation", comment: ""))
        let textRange = (informationLabelString as NSString).range(of: textRangeString)
        // Range of Titles
        let titleRangeString1 = (NSLocalizedString("fullBody", comment: ""))
        let titleRangeString2 = (NSLocalizedString("upperLower", comment: ""))
        let titleRangeString3 = (NSLocalizedString("legsPullPush", comment: ""))
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
        
        // Iphone 5/SE
        if UIScreen.main.nativeBounds.height < 1334 {
            //
            fullTop.constant = 20
            fullBottom.constant = 20
            stack1Bottom.constant = 20
            stack2Bottom.constant = 20
            //
            stackView1.spacing = 15
            connection1Width.constant = 15
            //
            stackView2.spacing = 10
            connection2Width.constant = 10
            connection2Trailing.constant = 10
            connection3Width.constant = 10
            connection3Trailing.constant = 10
        }
    }
    
//
// View did layout subviews ---------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        fullBody.layer.cornerRadius = fullBody.frame.size.height / 2
        fullBody.layer.masksToBounds = true
        //
        upperBody.layer.cornerRadius = stackView1.frame.size.height / 2
        upperBody.layer.masksToBounds = true
        //
        lowerBody.layer.cornerRadius = stackView1.frame.size.height / 2
        lowerBody.layer.masksToBounds = true
        //
        legs.layer.cornerRadius = stackView2.frame.size.height / 2
        legs.layer.masksToBounds = true
        //
        pull.layer.cornerRadius = stackView2.frame.size.height / 2
        pull.layer.masksToBounds = true
        //
        push.layer.cornerRadius = stackView2.frame.size.height / 2
        push.layer.masksToBounds = true
    }

    
//
// Information Actions ----------------------------------------------------------------------------------------------------------------
//
    @IBAction func informationButtonAction(_ sender: Any) {
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
    
    
    // Full
    @IBAction func full(_ sender: Any) {
        workoutType2 = 0
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Upper
    @IBAction func upper(_ sender: Any) {
        workoutType2 = 1
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Lower
    @IBAction func lower(_ sender: Any) {
        workoutType2 = 2
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Legs
    @IBAction func legs(_ sender: Any) {
        workoutType2 = 3
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Pull
    @IBAction func pull(_ sender: Any) {
        workoutType2 = 4
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    // Push
    @IBAction func push(_ sender: Any) {
        workoutType2 = 5
        performSegue(withIdentifier: "classicSegue", sender: nil)
    }
    
    
//
// Remove back button text
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Data
        if (segue.identifier == "warmupSegue") {
            //
            let destinationVC = segue.destination as! WorkoutChoiceFinal
            // Indicate to next screen which button was pressed
            destinationVC.workoutType = 0
            destinationVC.workoutType2 = workoutType2
        }
        //
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
//
}
