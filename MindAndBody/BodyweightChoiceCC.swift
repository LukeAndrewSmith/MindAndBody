//
//  BodyweightChoiceCC.swift
//  MindAndBody
//
//  Created by Luke Smith on 23.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Gym Choice Class ----------------------------------------------------------------------------------------------------------
//
class BodyweightChoiceCC: UIViewController  {
    // Outlets
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    // classic
    @IBOutlet weak var classic: UIButton!
    // circuit
    @IBOutlet weak var circuit: UIButton!
    
    
    // Information View
    let informationView = UIScrollView()
    // Information Title
    let informationTitle = UILabel()
    
    // Stack View
    @IBOutlet weak var stackView: UIStackView!
    
    // Question Mark
    @IBOutlet weak var questionMark: UIBarButtonItem!
    
    //
    // Remove back button text on subsequent screens
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass Data 5x5
        if (segue.identifier == "bodyweightCircuit") {
            //
            let destinationVC = segue.destination as! BodyweightChoice
            // Indicate to next screen which button was pressed
            destinationVC.workoutType = 3
        } else if (segue.identifier == "bodyweightClassic") {
            //
            let destinationVC = segue.destination as! BodyweightChoice
            // Indicate to next screen which button was pressed
            destinationVC.workoutType = 2
        }
        //
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
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthroughc")
        }
        
        // Colours
        view.backgroundColor = colour1
        questionMark.tintColor = colour1
        
        // Titles
        navigationBar.title = (NSLocalizedString("bodyweight", comment: ""))
        
        // Button Titles
        classic.setTitle(NSLocalizedString("classic", comment: ""), for: UIControlState.normal)
        classic.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        classic.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        classic.layer.borderWidth = 6
        classic.layer.borderColor = colour2.cgColor
        classic.setTitleColor(colour2, for: .normal)
        //
        circuit.setTitle(NSLocalizedString("circuit", comment: ""), for: UIControlState.normal)
        circuit.titleLabel!.font = UIFont(name: "SFUIDisplay-light", size: 21)
        circuit.titleLabel!.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        circuit.layer.borderWidth = 6
        circuit.layer.borderColor = colour2.cgColor
        circuit.setTitleColor(colour2, for: .normal)
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
        self.informationView.contentSize = CGSize(width: self.view.frame.size.width, height: informationTextStretchingC.frame.size.height + informationTitle.frame.size.height + 20)
        
        
    }
    
    
    //
    // View did layout subview -----------------------------------------------------------------------------------------------
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        classic.layer.cornerRadius = ((self.stackView.frame.size.height) - 40) / 4
        classic.layer.masksToBounds = true
        classic.titleLabel?.adjustsFontSizeToFitWidth = true
        classic.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        classic.titleLabel?.numberOfLines = 0
        classic.titleLabel?.textAlignment = .center
        //
        circuit.layer.cornerRadius = (self.stackView.frame.size.height - 40) / 4
        circuit.layer.masksToBounds = true
        circuit.titleLabel?.adjustsFontSizeToFitWidth = true
        circuit.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        circuit.titleLabel?.numberOfLines = 0
        circuit.titleLabel?.textAlignment = .center
    }
    
    //
    // Information Actions ----------------------------------------------------------------------------------------------------------------
    //
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




}
