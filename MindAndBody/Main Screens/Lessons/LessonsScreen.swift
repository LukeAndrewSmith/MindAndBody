//
//  InformationScreen1.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 27.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Lessons Screen Class -----------------------------------------------------------------------------
//
class LessonsScreen: UIViewController {
    
    // Navigation
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var lessonScroll: UIScrollView!
    var lessonsLabel = UILabel()
    
    // Title Array
    var lessonsArray: [[String]] = []
    //
    var selectedLesson = [0,0]
    
//
// View did load ------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Title
        navigationBar.title = NSLocalizedString(lessonsArray[selectedLesson[0]][selectedLesson[1]], comment: "")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = Colors.light
        
        // Label
        let lessonTextString = lessonsArray[selectedLesson[0]][selectedLesson[1]] + "Lesson"
        let lessonText = NSLocalizedString(lessonTextString, comment: "")
        // Text
        let attributedText = NSMutableAttributedString(string: NSLocalizedString(lessonText, comment: ""))
        let paragraphStyleE = NSMutableParagraphStyle()
        paragraphStyleE.alignment = .natural
        paragraphStyleE.lineSpacing = 2
        //
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyleE, range: NSMakeRange(0, attributedText.length))
        //
        lessonsLabel.attributedText = attributedText
        //
        lessonsLabel.font = UIFont(name: "SFUIDisplay-light", size: 20)
        lessonsLabel.textColor = .black
        lessonsLabel.textAlignment = .natural
        lessonsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        lessonsLabel.numberOfLines = 0
        //        lessonsLabel.frame = CGRect(x: 10, y: 20, width: lessonScroll.bounds.width - 20, height: 0)
        lessonsLabel.frame.size = lessonsLabel.sizeThatFits(CGSize(width: lessonScroll.bounds.width - 20, height: CGFloat.greatestFiniteMagnitude))
        lessonsLabel.frame = CGRect(x: 10, y: 20, width: lessonsLabel.bounds.width, height: lessonsLabel.bounds.height)
        
        // Scroll
        lessonScroll.addSubview(lessonsLabel)
        lessonScroll.contentSize = CGSize(width: lessonsLabel.bounds.width, height: lessonsLabel.bounds.height + 40)
        lessonScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
}
