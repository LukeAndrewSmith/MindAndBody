//
//  StretchingChoice.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 21/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class StretchingChoice: UIViewController  {
    
    // Outlets
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    // Buttons
    @IBOutlet weak var postWorkout: UIButton!
    
    
    @IBOutlet weak var postCardio: UIButton!
    
    
    @IBOutlet weak var general: UIButton!
    
    
    @IBOutlet weak var custom: UIButton!
    
    
    // Information View
    @IBOutlet weak var informationViewStretchingC: UIScrollView!
    
    // Information Title
    @IBOutlet weak var informationTitleStretchingC: UILabel!
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    
    // Constraints
    @IBOutlet weak var generalTop: NSLayoutConstraint!
    
    @IBOutlet weak var generalBottom: NSLayoutConstraint!
    
    @IBOutlet weak var stackBottom: NSLayoutConstraint!
    
    @IBOutlet weak var connectionWidth: NSLayoutConstraint!
    
    @IBOutlet weak var connectionTrailing: NSLayoutConstraint!
    
    
    
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
    
    
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
        navigationBar.title = (NSLocalizedString("stretching", comment: ""))
        
        // Button Titles
        general.setTitle(NSLocalizedString("general", comment: ""), for: UIControlState.normal)
        general.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        general.setTitleColor(colour2, for: .normal)
        general.layer.borderWidth = 8
        general.layer.borderColor = colour2.cgColor
        
        postWorkout.setTitle(NSLocalizedString("postWorkout", comment: ""), for: UIControlState.normal)
        postWorkout.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        postWorkout.setTitleColor(colour2, for: .normal)
        postWorkout.layer.borderWidth = 8
        postWorkout.layer.borderColor = colour2.cgColor
        
        postCardio.setTitle(NSLocalizedString("postCardio", comment: ""), for: UIControlState.normal)
        postCardio.setTitleColor(colour2, for: .normal)
        postCardio.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
        postCardio.layer.borderWidth = 8
        postCardio.layer.borderColor = colour2.cgColor
        
        
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
        
        
        
        // Scroll View Frame
        self.informationViewStretchingC.frame = CGRect(x: 0, y: self.view.frame.maxY + 49, width: self.view.frame.size.width, height: self.view.frame.size.height - 73.5 - UIApplication.shared.statusBarFrame.height)
        
        view.bringSubview(toFront: informationViewStretchingC)
        
        
        // Information Title
        //
        // Information Title Frame
        self.informationTitleStretchingC.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: 49)
        informationTitleStretchingC.text = (NSLocalizedString("information", comment: ""))
        informationTitleStretchingC.textAlignment = .center
        informationTitleStretchingC.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        informationTitleStretchingC.textColor = colour1
        informationTitleStretchingC.backgroundColor = colour2
        
        
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        informationTitleStretchingC.addGestureRecognizer(downSwipe)
        informationTitleStretchingC.isUserInteractionEnabled = true
        
        
        
        self.view.addSubview(informationTitleStretchingC)
        self.view.bringSubview(toFront: informationTitleStretchingC)
        
        
        
        // Information Text
        //
        // Information Text Frame
        let informationTextStretchingC = UILabel(frame: CGRect(x: 20, y: 20, width: self.informationViewStretchingC.frame.size.width - 40, height: 0))
        
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
        self.informationViewStretchingC.addSubview(informationTextStretchingC)
        
        
        self.informationViewStretchingC.contentSize = CGSize(width: self.view.frame.size.width, height: informationTextStretchingC.frame.size.height + informationTitleStretchingC.frame.size.height + 20)
        
        
        
        // Iphone 5/SE
        
        if UIScreen.main.nativeBounds.height < 1334 {
            
            generalTop.constant = 52
            generalBottom.constant = 52
            stackBottom.constant = 52
            
            
            stackView.spacing = 15
            connectionWidth.constant = 15
            connectionTrailing.constant = 15
            
            
        }
    }
    
    // Layout Subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        general.layer.cornerRadius = ((self.stackView.frame.size.height) * 3/2) / 2
        general.layer.masksToBounds = true
        general.titleLabel?.adjustsFontSizeToFitWidth = true
        general.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        general.titleLabel?.numberOfLines = 0
        general.titleLabel?.textAlignment = .center
        
        postWorkout.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        postWorkout.layer.masksToBounds = true
        postWorkout.titleLabel?.adjustsFontSizeToFitWidth = true
        postWorkout.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        postWorkout.titleLabel?.numberOfLines = 0
        postWorkout.titleLabel?.textAlignment = .center

        
        postCardio.layer.cornerRadius = (self.stackView.frame.size.height) / 2
        postCardio.layer.masksToBounds = true
        postCardio.titleLabel?.adjustsFontSizeToFitWidth = true
        postCardio.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        postCardio.titleLabel?.numberOfLines = 0
        postCardio.titleLabel?.textAlignment = .center


        
    }

    
    
    
    
    
    
    // Information Button Action
    @IBAction func informationButtonActionStretchingC(_ sender: Any) {
        
        
        if self.informationViewStretchingC.frame.minY < self.view.frame.maxY {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewStretchingC.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitleStretchingC.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            self.informationViewStretchingC.contentOffset.y = 0
            
            
            // Buttons
            questionMark.image = #imageLiteral(resourceName: "QuestionMarkN")
            navigationBar.setHidesBackButton(false, animated: true)
            

        } else {
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationViewStretchingC.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
                self.informationTitleStretchingC.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.maxY))
                
            }, completion: nil)
            self.informationViewStretchingC.contentOffset.y = 0
            
            
            // Buttons
            questionMark.image = #imageLiteral(resourceName: "Down")
            navigationBar.setHidesBackButton(true, animated: true)
            
            
        }
        
        
        
    }
    

    
    // Handle Swipes
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.informationViewStretchingC.frame.minY < self.view.frame.maxY {
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationViewStretchingC.transform = CGAffineTransform(translationX: 0, y: 0)
                    
                }, completion: nil)
                UILabel.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                    
                    self.informationTitleStretchingC.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
                
                
                // Buttons
                questionMark.image = #imageLiteral(resourceName: "QuestionMarkN")
                navigationBar.setHidesBackButton(false, animated: true)
                
            }
        }
    }

   
    
    
    //
    // Stretching Type Segue
    //
    var stretchingType = Int()
    // General
    @IBAction func general(_ sender: Any) {
        stretchingType = 0
        performSegue(withIdentifier: "stretchingSegue", sender: nil)
    }
    
    
    // Post-Workout
    @IBAction func postWorkout(_ sender: Any) {
        stretchingType = 1
        performSegue(withIdentifier: "stretchingSegue", sender: nil)
    }
    
    
    // Post-Cardio
    @IBAction func postCardio(_ sender: Any) {
        stretchingType = 2
        performSegue(withIdentifier: "stretchingSegue", sender: nil)
    }
    
    

    
    // Remove Back Bar Text
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stretchingSegue") {
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
            
            let destinationVC = segue.destination as! StretchingChoiceFinal
            
            destinationVC.stretchingType = stretchingType
            
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
    
