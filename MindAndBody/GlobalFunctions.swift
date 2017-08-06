//
//  GlobalFunctions.swift
//  MindAndBody
//
//  Created by Luke Smith on 05.08.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Mark: - Global Function as extensions
//

//
// View Controller
extension UIViewController {
    
    //
    // Animate Action Sheet Up
    func animateActionSheetUp(actionSheet:UIView, actionSheetHeight:CGFloat, backgroundView:UIView) {
        //
        let actionSheetWidth = UIScreen.main.bounds.width - 20
        //
        // Initial Conditions
        backgroundView.alpha = 0
        backgroundView.frame = UIScreen.main.bounds
        actionSheet.frame = CGRect(x: 10, y: self.view.frame.maxY, width: actionSheetWidth, height: actionSheetHeight)
        //
        // Animate
        UIView.animate(withDuration: animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: {
            //
            actionSheet.frame = CGRect(x: 10, y: self.view.frame.maxY - actionSheetHeight - 10, width: actionSheetWidth, height: actionSheetHeight)
            //
            backgroundView.alpha = 0.5
        }, completion: nil)
    }
    
    
    //
    // Animate Action Sheet Down
    func animateActionSheetDown(actionSheet:UIView, actionSheetHeight:CGFloat, backgroundView:UIView) {
        //
        let actionSheetWidth = UIScreen.main.bounds.width - 20
        //
        // Animate
        UIView.animate(withDuration: animationTime2, animations: {
            //
            actionSheet.frame = CGRect(x: 10, y: self.view.frame.maxY, width: actionSheetWidth, height: actionSheetHeight)
            backgroundView.alpha = 0
            //
        }, completion: { finished in
            //
            actionSheet.removeFromSuperview()
            backgroundView.removeFromSuperview()
        })
    }
    
    
    //
    // Animate Photo/Explanation Up
    func animateViewUp(animationView:UIImageView, backgroundView:UIButton) {
        //
        // Initial Conditions
        self.navigationItem.setHidesBackButton(true, animated: true)
        //
        let animationViewHeight = UIScreen.main.bounds.height / 2
        let animationViewWidth = UIScreen.main.bounds.width
        //
        // View
        animationView.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.size.width, height: animationViewHeight)
        //
        animationView.backgroundColor = colour2
        animationView.contentMode = .scaleAspectFit
        animationView.isUserInteractionEnabled = true
        //
        // Background View
        backgroundView.frame = UIScreen.main.bounds
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        
        //
        // Animate
        UIView.animate(withDuration: animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            animationView.frame = CGRect(x: 0, y: animationViewHeight, width: animationViewWidth, height: animationViewHeight)
            backgroundView.alpha = 0.5
        }, completion: nil)
    }
    
    
    //
    // Animate Photo/Explanation Down
    func animateViewDown(animationView:UIImageView, backgroundView:UIButton) {
        //
        // Initial Conditions
        let animationViewHeight = UIScreen.main.bounds.height / 2
        let animationViewWidth = UIScreen.main.bounds.width
        //
        // Animate
        UIView.animate(withDuration: animationTime2, animations: {
            animationView.frame = CGRect(x: 0, y: self.view.frame.maxY, width: animationViewWidth, height: animationViewHeight)
            backgroundView.alpha = 0
        }, completion: { finished in
            //
            animationView.removeFromSuperview()
            backgroundView.removeFromSuperview()
            self.navigationItem.setHidesBackButton(false, animated: true)
        })
    }
    
    
    //
    //
    //
    // Format Explanation Text
    func formatExplanationText(title:String, howTo:String, toAvoid:String) -> NSAttributedString {
        //
        // Title
        let titleString = NSMutableAttributedString(string: title)
        titleString.addAttribute(NSFontAttributeName, value: UIFont(name: "SFUIDisplay-light", size: 22)!, range: NSMakeRange(0, titleString.length))
        titleString.addAttribute(NSParagraphStyleAttributeName, value: NSTextAlignment.center, range: NSMakeRange(0, titleString.length))
        
        //
        // Title Attributes
        let subTitleFont = [NSFontAttributeName : UIFont(name: "SFUIDisplay-light", size: 22)]
        let subTitleAlignment = [NSParagraphStyleAttributeName : NSTextAlignment.left]
        //
        // Bullet Point Attributes
        let bulletPointFont = [NSFontAttributeName : UIFont(name: "SFUIDisplay-thin", size: 22)]
        //
        let paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [String : AnyObject])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 15
        
        //
        // How To
        let howToTitle = NSMutableAttributedString(string: NSLocalizedString("howTo", comment: ""))
        howToTitle.addAttributes(subTitleFont, range: NSMakeRange(0, howToTitle.length))
        howToTitle.addAttributes(subTitleAlignment, range: NSMakeRange(0, howToTitle.length))
        //
        //
        let howToString = NSMutableAttributedString(string: "")
        //
        let howToPoints = howTo.components(separatedBy: .newlines)
        for string in howToPoints {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
            howToString.append(attributedString)
        }
        //
        howToString.addAttributes(bulletPointFont, range: NSMakeRange(0, howToString.length))
        
        //
        // To Avoid
        let toAvoidTitle = NSMutableAttributedString(string: NSLocalizedString("toAvoid", comment: ""))
        toAvoidTitle.addAttributes(subTitleFont, range: NSMakeRange(0, toAvoidTitle.length))
        toAvoidTitle.addAttributes(subTitleAlignment, range: NSMakeRange(0, toAvoidTitle.length))
        //
        //
        let toAvoidString = NSMutableAttributedString(string: "")
        //
        let toAvoidPoints = toAvoid.components(separatedBy: .newlines)
        for string in toAvoidPoints {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
            toAvoidString.append(attributedString)
        }
        //
        toAvoidString.addAttributes(bulletPointFont, range: NSMakeRange(0, toAvoidString.length))
        
        //
        // Return
        let returnString = NSMutableAttributedString(string: "\n")
        let returnString2 = NSMutableAttributedString(string: "\n\n")
        //
        //let return1 = titleString + returnString2 + howToTitle + returnString + howToString
        //let return2 = returnString2 + toAvoidTitle + returnString + toAvoidString + returnString
        
        let returnS = titleString + "\n\n" + howToTitle + "\n" + howToString + "\n\n" + toAvoidTitle + "\n" + toAvoidString + "\n"
        return returnS
    }

    
}

//
// Mark: - Label Extensions
//

extension UILabel {
    
    }




