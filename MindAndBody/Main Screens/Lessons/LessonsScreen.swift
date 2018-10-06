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
class LessonsScreen: UIViewController, UIScrollViewDelegate {
    
    // Navigation
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var lessonScroll: UIScrollView!
    var lessonElements: [UIView] = []
    var lessonHeight: CGFloat = 0
    var lessonsLabel = UILabel()
    
    // Title Array
    var lesson = ""
    let titleLabel = UILabel()
    let titleImage = UIImageView()
    let imageHeight: CGFloat = {
        if IPhoneType.shared.iPhoneType() == IPhone.big {
            return 88 * 3.5
        } else {
            return 88 * 2.5
        }
    }()
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessonScroll.delegate = self

        closeButton.tintColor = Colors.dark
        closeButton.backgroundColor = Colors.red.withAlphaComponent(0.97)
        closeButton.layer.cornerRadius = closeButton.bounds.height / 2
        closeButton.clipsToBounds = true
        
        lessonScroll.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = Colors.light
        
        setupLesson(lesson: lesson)
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
            setupTopTitle(titleLabel: titleLabel, title: lesson, titleColor: Colors.light, titleImageView: titleImage, titleImage: #imageLiteral(resourceName: "LessonEffort"))
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "effortIntro", gap: 16)
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
            
            // Achieve Title
            let achieveTitle = UILabel()
            setupSubtitle(titleLabel: achieveTitle, title: "effortWatchTitle", previous: commitText, gap: 16)
            // Achieve text
            let achieveText = UILabel()
            setupText(label: achieveText, text: "effortWatchText", previous: achieveTitle, gap: 8)
            
            // Achieve Title
            let recapTitle = UILabel()
            setupSubtitle(titleLabel: recapTitle, title: "effortRecapTitle", previous: achieveText, gap: 24)
            // Achieve text
            let recapBullets = UILabel()
            setupBulletPoints(label: recapBullets, text: "effortRecapText", style: "numbers", previous: recapTitle, gap: 8)
            
            
        // Breathing (Workout)
        case "breathingWorkout":
            // Title
            setupTopTitle(titleLabel: titleLabel, title: lesson, titleColor: Colors.light, titleImageView: titleImage, titleImage: #imageLiteral(resourceName: "LessonWorkout"))
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "breathingWorkoutIntro", gap: 16)
            
            // Workout Title
            let workoutTitle = UILabel()
            setupSubtitle(titleLabel: workoutTitle, title: "breathingWorkoutWorkoutTitle", previous: intro, gap: 24)
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
            setupSubtitle(titleLabel: cardioTitle, title: "breathingWorkoutCardioTitle", previous: rulesNoteText, gap: 24)
            // Cardio/Endurance Text
            let cardioText = UILabel()
            setupText(label: cardioText, text: "breathingWorkoutCardioText", previous: cardioTitle, gap: 8)
            
        // Breathing (Yoga)
        case "breathingYoga":
            
            // Title
            setupTopTitle(titleLabel: titleLabel, title: lesson, titleColor: Colors.light, titleImageView: titleImage, titleImage: #imageLiteral(resourceName: "LessonYoga"))
            
            // Intro
            let intro = UILabel()
            setupIntro(label: intro, text: "breathingYogaIntro", gap: 16)
            
            // Mindfulness Title
            let mindfulTitle = UILabel()
            setupSubtitle(titleLabel: mindfulTitle, title: "breathingYogaMindfulnessTitle", previous: intro, gap: 24)
            // Mindfulness Text
            let mindfulText = UILabel()
            setupText(label: mindfulText, text: "breathingYogaMindfulnessText", previous: mindfulTitle, gap: 8)
            
            // Rules
            // How to breathe Title
            let breatheTitle = UILabel()
            setupSubtitle(titleLabel: breatheTitle, title: "breathingYogaBreathingTitle", previous: mindfulText, gap: 24)
            // How to breathe text
            let breatheText = UILabel()
            setupText(label: breatheText, text: "breathingYogaBreathingNote", previous: breatheTitle, gap: 8)
            // Rules title
            let rulesTitle = UILabel()
            setupSubtitle(titleLabel: rulesTitle, title: "breathingYogaBreathingRulesTitle", previous: breatheText, gap: 8)
            // Rules Bullets
            let rulesBullet1 = UILabel()
            setupBulletPoints(label: rulesBullet1, text: "breathingYogaBreathingRules1", style: "dots", previous: rulesTitle, gap: 8)
            let rulesImage1 = UIImageView()
            setupImage(imageView: rulesImage1, image: getUncachedImage(named: "wideLeggedForwardBend")!, previous: rulesBullet1, height: 88 * 2, gap: 0)
            //
            let rulesBullet2 = UILabel()
            setupBulletPoints(label: rulesBullet2, text: "breathingYogaBreathingRules2", style: "dots", previous: rulesImage1, gap: 0)
            let rulesImage2 = UIImageView()
            setupImage(imageView: rulesImage2, image: getUncachedImage(named: "upwardsDogY")!, previous: rulesBullet2, height: 88 * 2, gap: 0)
            //
            let rulesBullet3 = UILabel()
            setupBulletPoints(label: rulesBullet3, text: "breathingYogaBreathingRules3", style: "dots", previous: rulesImage2, gap: 0)
            let rulesImage3 = UIImageView()
            setupImage(imageView: rulesImage3, image: getUncachedImage(named: "marichi1")!, previous: rulesBullet3, height: 88 * 2, gap: 0)
            //
            let rulesBullet4 = UILabel()
            setupBulletPoints(label: rulesBullet4, text: "breathingYogaBreathingRules4", style: "dots", previous: rulesImage3, gap: 0)
            
        // Core Activation
        case "coreActivation":
            
            // Title
            setupTopTitle(titleLabel: titleLabel, title: lesson, titleColor: Colors.light, titleImageView: titleImage, titleImage: #imageLiteral(resourceName: "LessonCore"))
            
            // Intro
            let intro1 = UILabel()
            setupIntro(label: intro1, text: "coreActivationIntro1", gap: 16)
            // Core muscles image
            let coreImage = UIImageView()
            setupImage(imageView: coreImage, image: getUncachedImage(named: "core@2x")!, previous: intro1, height: 88 * 2, gap: 0)
            // Intro cont.
            let intro2 = UILabel()
            setupText(label: intro2, text: "coreActivationIntro2", previous: coreImage, gap: 0)
            
            // Breathing Title
            let breathingTitle = UILabel()
            setupSubtitle(titleLabel: breathingTitle, title: "coreActivationBreathingTitle", previous: intro2, gap: 24)
            // Breathing Text
            let breathingText = UILabel()
            setupText(label: breathingText, text: "coreActivationBreathingText", previous: breathingTitle, gap: 8)
            // Breathing Plank Title
            let plankTitle = UILabel()
            setupSubtitle(titleLabel: plankTitle, title: "coreActivationBreathingPlankTitle", previous: breathingText, gap: 8)
            // Breathing Plank Image
            let plankImage = UIImageView()
            setupImage(imageView: plankImage, image: getUncachedImage(named: "plank")!, previous: plankTitle, height: 88 * 2, gap: 0)
            // Breathing Plank Bullets
            let plankBullets = UILabel()
            setupBulletPoints(label: plankBullets, text: "coreActivationBreathingPlankText", style: "numbers", previous: plankImage, gap: 0)
            
            // Core activation title
            let activationTitle = UILabel()
            setupSubtitle(titleLabel: activationTitle, title: "coreActivationActivationTitle", previous: plankBullets, gap: 24)
            // Core activation note
            let activationNote = UILabel()
            setupText(label: activationNote, text: "coreActivationActivationNote", previous: activationTitle, gap: 8)
            // Core activation exercise title
            let activationTitle2 = UILabel()
            setupSubtitle(titleLabel: activationTitle2, title: "coreActivationActivationPracticeTitle", previous: activationNote, gap: 8)
            // Core activation exercise image
            let activationImage = UIImageView()
            setupImage(imageView: activationImage, image: getUncachedImage(named: "mountain")!, previous: activationTitle2, height: 88 * 2, gap: 0)
            // Core activation exercise
            let activationBullets = UILabel()
            setupBulletPoints(label: activationBullets, text: "coreActivationActivationPracticeText", style: "numbers", previous: activationImage, gap: 0)
            // Core activation notw 2
            let activationNote2 = UILabel()
            setupText(label: activationNote2, text: "coreActivationActivationNote2", previous: activationBullets, gap: 8)
            
            // Posture Title
            let postureTitle = UILabel()
            setupSubtitle(titleLabel: postureTitle, title: "coreActivationPostureTitle", previous: activationNote2, gap: 24)
            // Posture Text
            let postureText = UILabel()
            setupText(label: postureText, text: "coreActivationPostureText", previous: postureTitle, gap: 8)

            
        default: break
        }
        
        lessonScroll.contentSize = CGSize(width: lessonScroll.bounds.width, height: lessonHeight + 16)
    }
    
    func setupTopTitle(titleLabel: UILabel, title: String, titleColor: UIColor, titleImageView: UIImageView, titleImage: UIImage) {
        
        titleImageView.frame = CGRect(x: 0, y: 0, width: lessonScroll.bounds.width, height: imageHeight)
        titleImageView.contentMode = .scaleAspectFill
        titleImageView.layer.masksToBounds = true
        titleImageView.clipsToBounds = true
//        titleImageView.image = titleImage
        
        let ratio1 = imageHeight / view.bounds.width
        let ratio2 = view.bounds.width / imageHeight
        let size = titleImage.size
        let height = min(ratio1 * size.width, ratio2 * size.height)
        let width = height * ratio2
        let cropRect = CGRect(x: (size.width - width) / 2, y: (size.height - height) / 2, width: width, height: height)
        
        if let cgImage = titleImage.cgImage?.cropping(to: cropRect) {
            let imageCropped = UIImage(cgImage: cgImage)
            titleImageView.image = imageCropped
        } else {
            titleImageView.image = titleImage
        }
        
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.text = NSLocalizedString(title, comment: "")
        titleLabel.textColor = titleColor
        titleLabel.font = Fonts.lessonTitle
        let labelSize = titleLabel.sizeThatFits(CGSize(width: view.bounds.width - 32, height: .greatestFiniteMagnitude))
        titleLabel.frame = CGRect(x: 16, y: titleImageView.frame.maxY - labelSize.height - 8, width: view.bounds.width - 32, height: labelSize.height)
        
        titleImageView.addSubview(titleLabel)
        view.insertSubview(titleImageView, belowSubview: closeButton)
        lessonElements.append(titleImageView)
//        lessonHeight = lessonHeight + imageHeight
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
    
    func setupIntro(label: UILabel, text: String, gap: CGFloat) {
        
        let minY = gap
        
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
        label.frame = CGRect(x: 16, y: minY, width: view.bounds.width - 32, height: size.height)
        
        lessonScroll.addSubview(label)
        lessonElements.append(label)
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
    
    func setupImage(imageView: UIImageView, image: UIImage, previous: UIView, height: CGFloat, gap: CGFloat) {
        
        let minY = previous.frame.maxY
        
        imageView.frame = CGRect(x: 0, y: minY + gap, width: view.bounds.width, height: height)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = image
        
        lessonScroll.addSubview(imageView)
        lessonElements.append(imageView)
        lessonHeight = lessonHeight + height + gap
    }
    
    func setupDualImageArrows(imageView1: UIImageView, image1: UIImage, titleLabel1: UILabel, title1: String, titleColor1: UIColor, arrow1: UIView, imageView2: UIImageView, image2: UIImage, titleLabel2: UILabel, title2: String, titleColor2: UIColor, arrow2: UIView, previous: UIView, gap: CGFloat) {
        
        let minY = previous.frame.maxY
        let halfWidth = view.bounds.width / 2
        let height: CGFloat = 88 * 2
        let arrowHeight: CGFloat = 33

        imageView1.frame = CGRect(x: 0, y: minY + gap, width: halfWidth, height: height)
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
        
        imageView2.frame = CGRect(x: halfWidth, y: minY + gap, width: halfWidth, height: height)
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
    
    // MARK: Did scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = scrollView.frame.minY + scrollView.contentOffset.y + imageHeight - ElementHeights.topSafeAreaInset
        let labelCenter = imageHeight - (titleLabel.bounds.height / 2) - 8
        if y < 0 {
            titleImage.frame = CGRect(x: 0, y: 0, width: lessonScroll.bounds.width, height: imageHeight - y)
            titleLabel.center.y = labelCenter - y
        } else if y > 0 {
            titleImage.frame = CGRect(x: 0, y: 0, width: lessonScroll.bounds.width, height: imageHeight)
            titleImage.center.y = (imageHeight / 2) - y
            titleLabel.center.y = labelCenter

        } else if y == 0 {
            titleImage.frame = CGRect(x: 0, y: 0, width: lessonScroll.bounds.width, height: imageHeight)
            titleLabel.center.y = labelCenter
        }
        
        // Hide image if off screen to avoid strange appearing of image when dismissing
        if y > imageHeight {
            titleImage.alpha = 0
        } else {
            titleImage.alpha = 1
        }
    }
    
    // MARK: Close action
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
