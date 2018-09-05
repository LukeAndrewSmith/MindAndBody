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
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var lessonScroll: UIScrollView!
    var lessonElements: [UIView] = []
    var lessonHeight: CGFloat = 0
    var lessonsLabel = UILabel()
    
    // Title Array
    var lesson = ""
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.tintColor = Colors.dark
        closeButton.backgroundColor = Colors.red.withAlphaComponent(0.97)
        closeButton.layer.cornerRadius = closeButton.bounds.height / 2
        closeButton.clipsToBounds = true
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = Colors.light
        
        setupLesson(lesson: lesson)
//
//        // Label
//        let lessonTextString = lessonsArray[selectedLesson[0]][selectedLesson[1]] + "Lesson"
//        let lessonText = NSLocalizedString(lessonTextString, comment: "")
//        // Text
//        let attributedText = NSMutableAttributedString(string: NSLocalizedString(lessonText, comment: ""))
//        let paragraphStyleE = NSMutableParagraphStyle()
//        paragraphStyleE.alignment = .natural
//        paragraphStyleE.lineSpacing = 2
//        //
//        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyleE, range: NSMakeRange(0, attributedText.length))
//        //
//        lessonsLabel.attributedText = attributedText
//        //
//        lessonsLabel.font = UIFont(name: "SFUIDisplay-light", size: 20)
//        lessonsLabel.textColor = .black
//        lessonsLabel.textAlignment = .natural
//        lessonsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
//        lessonsLabel.numberOfLines = 0
//        //        lessonsLabel.frame = CGRect(x: 10, y: 20, width: lessonScroll.bounds.width - 20, height: 0)
//        lessonsLabel.frame.size = lessonsLabel.sizeThatFits(CGSize(width: lessonScroll.bounds.width - 20, height: CGFloat.greatestFiniteMagnitude))
//        lessonsLabel.frame = CGRect(x: 10, y: 20, width: lessonsLabel.bounds.width, height: lessonsLabel.bounds.height)
//
//        // Scroll
//        lessonScroll.addSubview(lessonsLabel)
//        lessonScroll.contentSize = CGSize(width: lessonsLabel.bounds.width, height: lessonsLabel.bounds.height + 40)
//        lessonScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    func setupLesson(lesson: String) {
        
        // Ensure Clear
        for element in lessonElements {
            element.removeFromSuperview()
        }
        lessonHeight = 0
        
        switch lesson {
        // Effort
        case "effort":
            
            // Title
            let title = UILabel()
            let titleImage = UIImageView()
            setupTopTitle(titleLabel: title, title: lesson, titleColor: Colors.light, titleImageView: titleImage, titleImage: #imageLiteral(resourceName: "Effort"))
            
            // Intro
            let intro = UILabel()
            setupText(label: intro, text: "effortIntro", previous: titleImage, gap: 16)
            // Intro Bullet points
            let introBullets = UILabel()
            setupBulletPoints(label: introBullets, text: "effortIntroBullet", style: "numbers",  previous: intro, gap: 0)
            
            // Goal title
            let goalTitle = UILabel()
            setupSubtitle(titleLabel: goalTitle, title: "effortGoalTitle", previous: introBullets, gap: 16)
            // Goal text
            let goalText = UILabel()
            setupText(label: goalText, text: "effortGoalText", previous: goalTitle, gap: 8)
            
            // Commit Title
            let commitTitle = UILabel()
            setupSubtitle(titleLabel: commitTitle, title: "effortCommitTitle", previous: goalText, gap: 16)
            // Commit text
            let commitText = UILabel()
            setupText(label: commitText, text: "effortCommitText", previous: commitTitle, gap: 8)
            
            // Acheive Title
            let acheiveTitle = UILabel()
            setupSubtitle(titleLabel: acheiveTitle, title: "effortWatchTitle", previous: commitText, gap: 16)
            // Acheive text
            let acheiveText = UILabel()
            setupText(label: acheiveText, text: "effortWatchText", previous: acheiveTitle, gap: 8)
            
            // Acheive Title
            let recapTitle = UILabel()
            setupSubtitle(titleLabel: recapTitle, title: "effortRecapTitle", previous: acheiveText, gap: 16)
            // Acheive text
            let recapBullets = UILabel()
            setupBulletPoints(label: recapBullets, text: "effortRecapText", style: "numbers", previous: recapTitle, gap: 8)
            
        // Breathing (Workout)
        case "breathingWorkout":
            // Title
            let title = UILabel()
            let titleImage = UIImageView()
            setupTopTitle(titleLabel: title, title: lesson, titleColor: Colors.light, titleImageView: titleImage, titleImage: #imageLiteral(resourceName: "BreathingWorkout"))
            
            // Intro
            let intro = UILabel()
            setupText(label: intro, text: "breathingWorkoutIntro", previous: titleImage, gap: 16)
            
            // Workout Title
            let workoutTitle = UILabel()
            setupSubtitle(titleLabel: workoutTitle, title: "breathingWorkoutWorkoutTitle", previous: intro, gap: 16)
            // Workout Text
            let workoutText = UILabel()
            setupText(label: workoutText, text: "breathingWorkoutWorkoutText", previous: workoutTitle, gap: 8)
            //
            // Rules Title
            let rulesTitle = UILabel()
            setupSubtitle(titleLabel: rulesTitle, title: "breathingWorkoutRulesTitle", previous: workoutText, gap: 8)
            // Rules Bullets
            let rulesBullets = UILabel()
            setupBulletPoints(label: rulesBullets, text: "breathingWorkoutRulesText", style: "numbers", previous: rulesTitle, gap: 8)
            // Rules Images
            let rulesImage1 = UIImageView()
            let rulesImage2 = UIImageView()
            let rulesLabel1 = UILabel()
            let rulesLabel2 = UILabel()
            let rulesArrow1 = ArrowViewDown()
            let rulesArrow2 = ArrowViewUp()
            setupDualImageArrows(imageView1: rulesImage1, image1: getUncachedImage(named: "squat1")!, titleLabel1: rulesLabel1, title1: "breathingWorkoutRuleImageTitle1", titleColor1: Colors.dark, arrow1: rulesArrow1, imageView2: rulesImage2, image2: getUncachedImage(named: "squat3")!, titleLabel2: rulesLabel2, title2: "breathingWorkoutRuleImageTitle2", titleColor2: Colors.dark, arrow2: rulesArrow2, previous: rulesBullets, gap: 0)
            var nextView = rulesLabel1
            if rulesLabel2.bounds.height > rulesLabel1.bounds.height {
                nextView = rulesLabel2
            }
            //
            // Rules Note title
            let rulesNoteTitle = UILabel()
            setupSubtitle(titleLabel: rulesNoteTitle, title: "breathingWorkoutRulesNoteTitle", previous: nextView, gap: 8)
            // Rules Note
            let rulesNoteText = UILabel()
            setupText(label: rulesNoteText, text: "breathingWorkoutRulesNoteText", previous: rulesNoteTitle, gap: 8)
            
            // Cardio/Endurance Title
            let cardioTitle = UILabel()
            setupSubtitle(titleLabel: cardioTitle, title: "breathingWorkoutCardioTitle", previous: rulesNoteText, gap: 16)
            // Cardio/Endurance Text
            let cardioText = UILabel()
            setupText(label: cardioText, text: "breathingWorkoutCardioText", previous: cardioTitle, gap: 8)
            
        case "breathingYoga":
            break
        case "coreActivation":
            break
        default: break
        }
        
        lessonScroll.contentSize = CGSize(width: lessonScroll.bounds.width, height: lessonHeight + 16)
    }
    
    func setupTopTitle(titleLabel: UILabel, title: String, titleColor: UIColor, titleImageView: UIImageView, titleImage: UIImage) {
        
        let imageHeight: CGFloat = 88 * 2.5
        titleImageView.frame = CGRect(x: 0, y: 0, width: lessonScroll.bounds.width, height: imageHeight)
        titleImageView.image = titleImage
        titleImageView.contentMode = .scaleAspectFill
        titleImageView.clipsToBounds = true
        
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.text = NSLocalizedString(title, comment: "")
        titleLabel.textColor = titleColor
        titleLabel.font = Fonts.lessonTitle
        let size = titleLabel.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        titleLabel.frame = CGRect(x: 16, y: titleImageView.frame.maxY - size.height - 8, width: view.bounds.width - 32, height: size.height)
        
        titleImageView.addSubview(titleLabel)
        lessonScroll.addSubview(titleImageView)
        lessonElements.append(titleImageView)
        lessonHeight = lessonHeight + imageHeight
    }
    
    func setupSubtitle(titleLabel: UILabel, title: String, previous: UIView, gap: CGFloat) {
        
        let minY = previous.frame.maxY
        
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.text = NSLocalizedString(title, comment: "")
        titleLabel.textColor = Colors.dark
        titleLabel.font = Fonts.lessonSubtitle
        let size = titleLabel.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        titleLabel.frame = CGRect(x: 16, y: minY + gap, width: view.bounds.width - 32, height: size.height)
        
        lessonScroll.addSubview(titleLabel)
        lessonElements.append(titleLabel)
        lessonHeight = lessonHeight + size.height + gap
    }
    
    func setupText(label: UILabel, text: String, previous: UIView, gap: CGFloat) {
        
        let minY = previous.frame.maxY
        
        let plainString = NSLocalizedString(text, comment: "")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: Fonts.lessonText!,
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.foregroundColor: Colors.dark
        ]
        let attributedString = NSMutableAttributedString(string: plainString, attributes: attributes)
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.attributedText = attributedString
        let size = label.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        label.frame = CGRect(x: 16, y: minY + gap, width: view.bounds.width - 32, height: size.height)
        
        lessonScroll.addSubview(label)
        lessonElements.append(label)
        lessonHeight = lessonHeight + size.height + gap
    }
    
    func setupBulletPoints(label: UILabel, text: String, style: String, previous: UIView, gap: CGFloat) {
       
        let minY = previous.frame.maxY
        
        // Strings
        let orignalString = NSLocalizedString(text, comment: "")
        let bulletPoints = orignalString.components(separatedBy: .newlines)
        let bulletedString = NSMutableAttributedString(string: "")
        
        // Indent
        let paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: [:])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 15
        paragraphStyle.lineSpacing = 2
        // Attributes
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: Fonts.lessonText!,
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.foregroundColor: Colors.dark
        ]
        
        // Apply
        switch style {
        case "numbers":
            for i in 1...bulletPoints.count {
                let bulletPoint: String = String(i) + "."
                var enter = ""
                if i != bulletPoints.count {
                    enter = "\n"
                }
                let formattedString: String = "\(bulletPoint) \(bulletPoints[i-1])" + enter
                let attributedString = NSMutableAttributedString(string: formattedString, attributes: attributes)
                
                bulletedString.append(attributedString)
            }
        case "dots":
            for i in 1...bulletPoints.count {
                let bulletPoint: String = "\u{2022}"
                var enter = ""
                if i != bulletPoints.count {
                    enter = "\n"
                }
                let formattedString: String = "\(bulletPoint) \(bulletPoints[i-1])" + enter
                let attributedString = NSMutableAttributedString(string: formattedString, attributes: attributes)
                
                bulletedString.append(attributedString)
            }
        default: break
        }

        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.attributedText = bulletedString
        label.sizeToFit()
        let size = label.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        label.frame = CGRect(x: 16, y: minY + gap, width: view.bounds.width - 32, height: size.height)
        
        lessonScroll.addSubview(label)
        lessonElements.append(label)
        lessonHeight = lessonHeight + size.height + gap
    }
    
    func setupImage(imageView: UIImageView, image: UIImage, previous: UIView, gap: CGFloat) {
        
        let minY = previous.frame.maxY
        
        imageView.frame = CGRect(x: 0, y: minY, width: lessonScroll.bounds.width, height: 88 * 2)
        imageView.image = image
        
        lessonScroll.addSubview(imageView)
    }
    
    func setupDualImageArrows(imageView1: UIImageView, image1: UIImage, titleLabel1: UILabel, title1: String, titleColor1: UIColor, arrow1: UIView, imageView2: UIImageView, image2: UIImage, titleLabel2: UILabel, title2: String, titleColor2: UIColor, arrow2: UIView, previous: UIView, gap: CGFloat) {
        
        let minY = previous.frame.maxY
        let halfWidth = view.bounds.width / 2
        let height: CGFloat = 88 * 2
        let arrowHeight: CGFloat = 33

        imageView1.frame = CGRect(x: 0, y: minY, width: halfWidth, height: height)
        imageView1.contentMode = .scaleAspectFit
        imageView1.image = image1
        //
        titleLabel1.text = NSLocalizedString(title1, comment: "")
        titleLabel1.font = Fonts.lessonsImageTitle
        titleLabel1.textColor = Colors.dark
        let size1 = titleLabel1.sizeThatFits(CGSize(width: halfWidth - 32, height: .greatestFiniteMagnitude))
        titleLabel1.frame = CGRect(x: 16, y: imageView1.frame.maxY, width: halfWidth - 32, height: size1.height)
        //
        arrow1.frame = CGRect(x: halfWidth - arrowHeight - 8, y: height - arrowHeight - 8, width: arrowHeight, height: arrowHeight)
        arrow1.backgroundColor = .clear
        imageView1.addSubview(arrow1)
        
        imageView2.frame = CGRect(x: halfWidth, y: minY, width: halfWidth, height: height)
        imageView2.contentMode = .scaleAspectFit
        imageView2.image = image2
        titleLabel2.text = NSLocalizedString(title2, comment: "")
        titleLabel2.font = Fonts.lessonsImageTitle
        titleLabel2.textColor = Colors.dark
        let size2 = titleLabel2.sizeThatFits(CGSize(width: halfWidth - 32, height: .greatestFiniteMagnitude))
        titleLabel2.frame = CGRect(x: halfWidth + 16, y: imageView2.frame.maxY, width: halfWidth - 32, height: size2.height)
        //
        arrow2.frame = CGRect(x: halfWidth - arrowHeight - 8, y: height - arrowHeight - 8, width: arrowHeight, height: arrowHeight)
        arrow2.backgroundColor = .clear
        imageView2.addSubview(arrow2)
        
        lessonScroll.addSubview(imageView1)
        lessonScroll.addSubview(imageView2)
        lessonScroll.addSubview(titleLabel1)
        lessonScroll.addSubview(titleLabel2)
        lessonElements.append(imageView1)
        lessonElements.append(imageView2)
        lessonElements.append(titleLabel1)
        lessonElements.append(titleLabel2)
        
        lessonHeight = lessonHeight + height + max(titleLabel1.bounds.height, titleLabel2.bounds.height) + gap
    }
    
    // MARK: Close action
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
