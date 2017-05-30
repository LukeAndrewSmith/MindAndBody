//
//  OxygenOverloadChoice.swift
//  MindAndBody
//
//  Created by Luke Smith on 30.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class OxygenOverloadChoice: UIViewController {
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Begin Button
    @IBOutlet weak var beginButton: UIButton!
    
    // Detail
    @IBOutlet weak var detailView: UIView!
    
    // Discussion
    @IBOutlet weak var discussionScrollView: UIScrollView!
    @IBOutlet weak var discussionTitle: UILabel!
    
    
    
    //
    // View did load -------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = colour1
        
        // Begin Button Title
        beginButton.titleLabel?.text = NSLocalizedString("begin", comment: "")
        beginButton.backgroundColor = colour3
        beginButton.setTitleColor(colour2, for: .normal)
        
        // View Elements
        //
        // Description
        detailView.backgroundColor = colour2
        //
        
        
        // Content
        //
        
        // Navigation Bar Title
        navigationBar.title = NSLocalizedString("oxygenOverload", comment: "")
        
        
        
        // Discussion
        //
        // Scroll
        discussionScrollView.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        //
        discussionTitle.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        discussionTitle.textColor = colour2
        discussionTitle.text = NSLocalizedString("discussion", comment: "")
        
        // Text
        let discussionLabel = UILabel()
        let attributedText = NSMutableAttributedString(string: NSLocalizedString("oxygenOverload", comment: ""))
        let paragraphStyleE = NSMutableParagraphStyle()
        paragraphStyleE.alignment = .natural
        //
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyleE, range: NSMakeRange(0, attributedText.length))
        //
        discussionLabel.attributedText = attributedText
        //
        discussionLabel.font = UIFont(name: "SFUIDisplay-light", size: 19)
        discussionLabel.textColor = .black
        discussionLabel.textAlignment = .natural
        discussionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        discussionLabel.numberOfLines = 0
        discussionLabel.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 0)
        discussionLabel.sizeToFit()
        // Scroll View
        discussionScrollView.addSubview(discussionLabel)
        discussionScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: discussionLabel.frame.size.height + 20)
        //
        self.discussionScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    
    //
    // Begin Button ----------------------------------------------------------------------------------
    //
    // Begin Button
    @IBAction func beginButton(_ sender: Any) {
        //
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            _ = self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    
    //
    // Pass arrays to next View controller -------------------------------------------------------------------------------------------
    //
}
