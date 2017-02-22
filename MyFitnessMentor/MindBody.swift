//
//  SecondViewController.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



//---------------------------------------------------------------------------------------------------------------


extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}

//extension UserDefaults {
//    func color(forKey defaultName: String) -> UIColor? {
//        var color: UIColor?
//        if let colorData = data(forKey: defaultName) {
//            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
//        }
//        return color
//    }
//    
//    func setColor(_ value: UIColor?, forKey defaultName: String) {
//        var colorData: NSData?
//        if let color = value {
//            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
//        }
//        set(colorData, forKey: defaultName)
//    }
//}


//---------------------------------------------------------------------------------------------------------------



class MindBody: UIViewController {

    // Button Outlets
    
    // Warmup
    @IBOutlet weak var Warmup: UIButton!
    
    // Workout
    @IBOutlet weak var Workout: UIButton!
    
    // Stretching
    @IBOutlet weak var Stretching: UIButton!
    
    // Cardio
    @IBOutlet weak var Cardio: UIButton!
    
    // Yoga
    @IBOutlet weak var Yoga: UIButton!
    
    // Mindfullness
    @IBOutlet weak var Meditation: UIButton!
    
    // Calendar
    @IBOutlet weak var calendar: UIBarButtonItem!
    
    // Stack Views
    @IBOutlet weak var stackView1: UIStackView!
    
    @IBOutlet weak var stackView2: UIStackView!
    
    @IBOutlet weak var stackView3: UIStackView!
    
    
    // Mind Connection Label
    @IBOutlet weak var connectionLabel: UILabel!
    
    // StackView 1 bottom Constraint
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // Mind Body Constraints
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var positionConstraint: NSLayoutConstraint!
    
    // Body Constraints
    @IBOutlet weak var bodyTop: NSLayoutConstraint!
    
    @IBOutlet weak var bodyBottom: NSLayoutConstraint!
    
    // Mind Constraints
    @IBOutlet weak var mindTop: NSLayoutConstraint!
    
    @IBOutlet weak var mindBottom: NSLayoutConstraint!
    
    
    // Bottom StackView 3 Bottom Constraint
    @IBOutlet weak var stack3Bottom: NSLayoutConstraint!
    
    
    // Labels
    
//---------------------------------------------------------------------------------------------------------------
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = (NSLocalizedString("mind&body", comment: ""))


    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status Bar
        UserDefaults.standard.register(defaults: ["blacknWhite" : false])
        if UserDefaults.standard.bool(forKey: "blacknWhite") == true {
                UIApplication.shared.statusBarStyle = .lightContent
            } else {
                UIApplication.shared.statusBarStyle = .default
            }
        
        
        // Walkthrough
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough" : false])

        
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthrough") == false {
        walkthroughMindBody()
        UserDefaults.standard.set(true, forKey: "mindBodyWalkthrough")
        }
        
        
        
        // Register Walkthroughs
        //
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough1" : false])
        //
        UserDefaults.standard.register(defaults: ["mindBodyWalkthroughc" : false])
        //
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough2" : false])
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough2y" : false])
        //
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough3" : false])
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough3y" : false])
        UserDefaults.standard.register(defaults: ["mindBodyWalkthrough4y" : false])
        //
        UserDefaults.standard.register(defaults: ["profileWalkthrough" : false])
        //
        UserDefaults.standard.register(defaults: ["informationWalkthrough" : false])
        
        
        
        
        // Retrieve Colours
        let colour1 = UserDefaults.standard.color(forKey: "colour1")!
        let colour2 = UserDefaults.standard.color(forKey: "colour2")!
        let colour3 = UserDefaults.standard.color(forKey: "colour3")!
        let colour5 = UserDefaults.standard.color(forKey: "colour5")!
        
        

        self.view.applyGradient(colours: [colour1, colour2])
        
        
        self.navigationController?.navigationBar.tintColor = colour1
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: colour1, NSFontAttributeName: UIFont(name: "SFUIDisplay-heavy", size: 23)!]
        self.navigationController?.navigationBar.barTintColor = colour5
        self.tabBarController?.tabBar.barTintColor = colour5
        UITabBar.appearance().barTintColor = colour5
        tabBarController?.tabBar.barStyle = .default
        self.tabBarController?.tabBar.barTintColor = colour5
        
        
        
        
        
        
        calendar.tintColor = colour1
        
        self.tabBarController?.tabBar.tintColor = colour2
        
        
        
        
      
       // Title
        
        // Button Titles
        Warmup.setTitle(NSLocalizedString("warmup", comment: ""), for: UIControlState.normal)
        Warmup.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Warmup.titleLabel!.textColor = .white
        Warmup.layer.borderWidth = 8
        Warmup.layer.borderColor = colour3.cgColor
        Warmup.titleLabel?.adjustsFontSizeToFitWidth = true
        Warmup.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Warmup.titleLabel?.textAlignment = .center
        Warmup.setTitleColor(colour3, for: .normal)
        
        
        Workout.setTitle(NSLocalizedString("workout", comment: ""), for: UIControlState.normal)
        Workout.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Workout.titleLabel!.textColor = .white
        Workout.layer.borderWidth = 8
        Workout.layer.borderColor = colour3.cgColor
        Workout.titleLabel?.adjustsFontSizeToFitWidth = true
        Workout.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Workout.titleLabel?.textAlignment = .center
        Workout.setTitleColor(colour3, for: .normal)

        
        
        Stretching.setTitle(NSLocalizedString("stretching", comment: ""), for: UIControlState.normal)
        Stretching.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Stretching.titleLabel!.textColor = .white
        Stretching.layer.borderWidth = 8
        Stretching.layer.borderColor = colour3.cgColor
        Stretching.titleLabel?.adjustsFontSizeToFitWidth = true
        Stretching.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Stretching.titleLabel?.textAlignment = .center
        Stretching.setTitleColor(colour3, for: .normal)

        
        
        
        Cardio.setTitle(NSLocalizedString("cardio", comment: ""), for: UIControlState.normal)
        Cardio.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Cardio.titleLabel!.textColor = .white
        Cardio.layer.borderWidth = 8
        Cardio.layer.borderColor = colour3.cgColor
        Cardio.titleLabel?.adjustsFontSizeToFitWidth = true
        Cardio.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Cardio.titleLabel?.textAlignment = .center
        Cardio.setTitleColor(colour3, for: .normal)

        
        
        
        Yoga.setTitle(NSLocalizedString("yoga", comment: ""), for: UIControlState.normal)
        Yoga.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Yoga.titleLabel!.textColor = .white
        Yoga.titleLabel!.adjustsFontSizeToFitWidth = true
        Yoga.layer.borderWidth = 8
        Yoga.layer.borderColor = colour3.cgColor
        Yoga.titleLabel?.adjustsFontSizeToFitWidth = true
        Yoga.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Yoga.titleLabel?.textAlignment = .center
        Yoga.setTitleColor(colour3, for: .normal)

        
        
        
        Meditation.setTitle(NSLocalizedString("meditation", comment: ""), for: UIControlState.normal)
        Meditation.titleLabel!.font = UIFont(name: "SFUIDisplay-medium", size: 20)
        Meditation.titleLabel!.textColor = .white
        Meditation.layer.borderWidth = 8
        Meditation.layer.borderColor = colour3.cgColor
        Meditation.titleLabel?.adjustsFontSizeToFitWidth = true
        Meditation.titleEdgeInsets = UIEdgeInsetsMake(0,8,0,8)
        Meditation.titleLabel?.textAlignment = .center
        Meditation.setTitleColor(colour3, for: .normal)

        
        
        
        
        // Iphone 5/SE
        
        if UIScreen.main.nativeBounds.height < 1334 {
            bottomConstraint.constant = 15
            stackView3.spacing = 15
            
            heightConstraint.constant = 15
            positionConstraint.constant = -15
            
            
            bodyTop.constant = 5
            bodyBottom.constant = 2
            mindTop.constant = 5
            mindBottom.constant = 3
            
            stack3Bottom.constant = 15
        }
        
        
        //
        // Instructions Popup View
        //
//        let defaults = UserDefaults.standard
//        defaults.register(defaults: ["alertInfo1" : false])
//        
//        if UserDefaults.standard.bool(forKey: "alertInfo1") == false {
//            
//            UserDefaults.standard.set(true, forKey: "alertInfo1")
//            
//            let alertInformation = UIAlertController(title: (NSLocalizedString("alertTitle1", comment: "")), message: (NSLocalizedString("alertMessage1", comment: "")), preferredStyle: UIAlertControllerStyle.alert)
//            
//            alertInformation.view.tintColor = .black
//            
//            alertInformation.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
//            
//            self.present(alertInformation, animated: true, completion: nil)
//            
//            
//            UITabBar.appearance().shadowImage = UIImage(named: "ShadowImageN")
//            
//        }
        
        
        viewDidLayoutSubviews()
        
    }
        
        override func viewDidLayoutSubviews() {
            
            super.viewDidLayoutSubviews()
            
            
           
            
            // Button Rounded Edges
            
            Warmup.layer.cornerRadius = stackView1.frame.size.height / 2
            Warmup.layer.masksToBounds = true
            
            Workout.layer.cornerRadius = stackView1.frame.size.height / 2
            Workout.layer.masksToBounds = true
            
            Stretching.layer.cornerRadius = stackView2.frame.size.height / 2
            Stretching.layer.masksToBounds = true
            
            Cardio.layer.cornerRadius = stackView2.frame.size.height / 2
            Cardio.layer.masksToBounds = true
            
            Yoga.layer.cornerRadius =
                (stackView3.frame.size.height - 20) / 4
            Yoga.layer.masksToBounds = true
            
            Meditation.layer.cornerRadius = (stackView3.frame.size.height - 20) / 4
            Meditation.layer.masksToBounds = true
            
            
        }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
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
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height

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
            path.addEllipse(in: CGRect(x: view.frame.size.width/2 - 80, y: UIApplication.shared.statusBarFrame.height, width: 160, height: 40))
            path.addRect(walkthroughView.frame)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            
            
            label.text = NSLocalizedString("mindBody1", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)


            
//
        case 1:
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
            //
            
            label.text = NSLocalizedString("mindBody2", comment: "")
            
            
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)

            
            
//
        case 2:
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: stackView1.center.x - 10 - (Warmup.frame.size.width / 2), y: stackView1.center.y + navigationBarHeight + UIApplication.shared.statusBarFrame.height), radius: Warmup.frame.width / 2, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(walkthroughView.frame)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            //
            
            label.text = NSLocalizedString("mindBody3", comment: "")
            
            label.center = stackView3.center
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)

            
  
            
//
        case 3:
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: (view.frame.width / 4) - ((view.frame.width / 4) * 1/3 ), y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + view.frame.size.height + (tabBarHeight! / 2)), radius: 23, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(walkthroughView.frame)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            //
            
            label.text = NSLocalizedString("mindBody4", comment: "")
            
            label.center = view.center
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)

            
            
            
//
        case 4:
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: view.center.x, y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + view.frame.size.height + (tabBarHeight! / 2)), radius: 23, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(walkthroughView.frame)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            //
            
            label.text = NSLocalizedString("mindBody5", comment: "")
            
            label.center = view.center
            
            
            walkthroughView.addSubview(backButton)
            walkthroughView.addSubview(nextButton)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButton)
            walkthroughView.bringSubview(toFront: backButton)
            

            
            
            
        //
        case 5:
          
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: ((view.frame.width / 4) * 3) + ((view.frame.width / 4) * 1/3 ), y: navigationBarHeight + UIApplication.shared.statusBarFrame.height + view.frame.size.height + (tabBarHeight! / 2)), radius: 23, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            path.addRect(walkthroughView.frame)
            //
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path
            maskLayer.fillRule = kCAFillRuleEvenOdd
            //
            walkthroughView.layer.mask = maskLayer
            walkthroughView.clipsToBounds = true
            //
            //
            
            label.text = NSLocalizedString("mindBody6", comment: "")
            
            label.center = view.center
            
            
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
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber - 1
        walkthroughMindBody()
        }
        
    }
    
    
}
