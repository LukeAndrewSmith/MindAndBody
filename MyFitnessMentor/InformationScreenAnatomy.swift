//
//  InformationScreenA.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 28.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit




class InformationScreenAnatomy: UIViewController {
    
    
    
    // Navigation
    @IBOutlet weak var navigationBar: UINavigationItem!
    let navigationTitle = UILabel()
    
    // Back Button
    let backButton = UIButton()

    
    
    
    
    // Image
    @IBOutlet weak var image: UIImageView!
    
    
    
    
    // Progress Bar
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    //
    @IBOutlet weak var progressLabel: UILabel!
    
    
    
    
    
    
    // Colours
    let colour1 = UserDefaults.standard.color(forKey: "colour1")
    let colour7 = UserDefaults.standard.color(forKey: "colour7")
    
    
    var bodyPartIndex = 0
    
    let bodyArray =
        [
            "traps",
            "rearDelts",
            "lateralDelts",
            "frontDelts",
            "biceps",
            "triceps",
            "forearms",
            "pecs2",
            "lats",
            "erectors",
            "core",
            "serratus",
            "obliques",
            "rectusAbdominis",
            "glutes",
            "hamstrings",
            "adductors",
            "quads",
            "gastrocnemius",
            "soleus"
        ]
    
    let imageArray =
        [
            #imageLiteral(resourceName: "Trap"),
            #imageLiteral(resourceName: "Rear Delt 2"),
            #imageLiteral(resourceName: "Lateral Delt"),
            #imageLiteral(resourceName: "Front Delt"),
            #imageLiteral(resourceName: "Bicep"),
            #imageLiteral(resourceName: "Tricep"),
            #imageLiteral(resourceName: "Forearm"),
            #imageLiteral(resourceName: "Pec"),
            #imageLiteral(resourceName: "Lat 2"),
            #imageLiteral(resourceName: "Erector"),
            #imageLiteral(resourceName: "Core"),
            #imageLiteral(resourceName: "Serratus"),
            #imageLiteral(resourceName: "Oblique"),
            #imageLiteral(resourceName: "Rectus"),
            #imageLiteral(resourceName: "Glute"),
            #imageLiteral(resourceName: "Hamstring"),
            #imageLiteral(resourceName: "Adductor"),
            #imageLiteral(resourceName: "Quad"),
            #imageLiteral(resourceName: "Gastrocnemius"),
            #imageLiteral(resourceName: "Soleus")
        ]
    
    
    
    
    
    
    // View Did Load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Walkthrough
        if UserDefaults.standard.bool(forKey: "mindBodyWalkthroughI") == false {
            let delayInSeconds = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.walkthroughMindBody()
            }
            UserDefaults.standard.set(true, forKey: "mindBodyWalkthroughI")
        }
        
        
        
        
        // Title Colour
        //
        self.navigationController?.navigationBar.barTintColor = colour7
        self.navigationController?.navigationBar.tintColor = .white
        
        
        
        // Hide Back Button
        self.navigationItem.setHidesBackButton(true, animated:true)
        //
        //backButton.tintColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        //backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        
        // Add Button
        backButton.setTitle("<", for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        backButton.tintColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        let leftItem = UIBarButtonItem()
        leftItem.customView = backButton
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        
        // Tap
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: #selector(tapAction))
        backButton.addGestureRecognizer(tap)
        
        // Double Tap
        let press = UILongPressGestureRecognizer()
        press.addTarget(self, action: #selector(longPress))
        backButton.addGestureRecognizer(press)
        

        
        
        
        
        // Progress Bar
        //

        // Thickness
        progressBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 49, height: self.progressBarView.frame.size.height / 2)
        progressBar.center = progressBarView.center
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3)
        
        // Rounded Edges
        progressBar.layer.cornerRadius = self.progressBar.frame.size.height / 2
        progressBar.layer.masksToBounds = true
        
        // Initial state
        progressBar.setProgress(0, animated: true)
        
        
        
        
        // Display Content
        displayContent()

    }
    
    
    // Display Content Function
    //
    func displayContent() {
        
        
        
        // Title
        //
        navigationTitle.text = (NSLocalizedString(bodyArray[bodyPartIndex], comment: ""))
        
        // Navigation Title
        //
        navigationTitle.frame = (navigationController?.navigationItem.accessibilityFrame)!
        navigationTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        navigationTitle.center.x = self.view.center.x
        navigationTitle.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        navigationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 22)
        navigationTitle.backgroundColor = .clear
        navigationTitle.textAlignment = .center
        navigationTitle.adjustsFontSizeToFitWidth = true
        
        //self.navigationController?.navigationBar.topItem?.titleView = navigationTitle
        self.navigationBar.titleView = navigationTitle
        
        
        
        
    
        
        // Image
        //
        image.image = imageArray[bodyPartIndex]
        
        
        
        // Progress
        //
        // Title
        self.progressLabel.text = (String(bodyPartIndex + 1)+"/"+String(bodyArray.count))
        // Progress Bar
        let bodyIndexP = Float(bodyPartIndex)
        let bodyArrayP = Float(self.bodyArray.count)

        let fractionalProgress = bodyIndexP/bodyArrayP
        
        progressBar.setProgress(fractionalProgress, animated: true)
    }
    
    
    
    
    // Flash Screen
    //
    func flashScreen() {
        
        let flash = UIView()
        
        flash.frame = CGRect(x: 0, y: -100, width: self.view.frame.size.width, height: self.view.frame.size.height + 100)
        flash.backgroundColor = colour1
        self.view.alpha = 1
        self.view.addSubview(flash)
        self.view.bringSubview(toFront: flash)
        
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [],animations: {
            
            flash.alpha = 0
            
        }, completion: {(finished: Bool) -> Void in
            flash.removeFromSuperview()
        })
        
    }
    
    
    
    
    
    
    //
    //
    @IBAction func nextButton(_ sender: Any) {
        
        
        if bodyPartIndex == bodyArray.count - 1 {
            navigationTitle.removeFromSuperview()
            _ = self.navigationController?.popToRootViewController(animated: true)
            
        } else {
            
            bodyPartIndex = bodyPartIndex + 1
            
            //flashScreen()
            displayContent()

        }
    }
    
    
    
    @IBAction func tapAction() {
        
        if bodyPartIndex == 0 {
            
        } else {
            bodyPartIndex = bodyPartIndex - 1
            
            //flashScreen()
            displayContent()
        }
    }
    
    
    
    
    
    
    // Press Handler
    //
    @IBAction func longPress() {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
    
    
    
    //---------------------------------------------------------------------------------------------------------------
    
    
    var  viewNumber = 0
    let walkthroughView = UIView()
    let label = UILabel()
    let nextButtonW = UIButton()
    
    
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
        nextButtonW.frame = screenSize
        nextButtonW.backgroundColor = .clear
        nextButtonW.addTarget(self, action: #selector(nextWalkthroughView(_:)), for: .touchUpInside)
        //
       
        
        
        switch viewNumber {
            
        case 0:
            //
           
            
            
            // Clear Section
            let path = CGMutablePath()
            path.addArc(center: CGPoint(x: backButton.center.x, y: (navigationBarHeight / 2) + UIApplication.shared.statusBarFrame.height - 1), radius: 20, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
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
            
            
            label.text = NSLocalizedString("anatomy1", comment: "")
            walkthroughView.addSubview(label)
            
            
            
            walkthroughView.addSubview(nextButtonW)
            self.view.addSubview(walkthroughView)
            UIApplication.shared.keyWindow?.insertSubview(walkthroughView, aboveSubview: view)
            walkthroughView.bringSubview(toFront: nextButtonW)
            
    
            
        default: break
            
            
        }
        
        
    }
    
    
    
    func nextWalkthroughView(_ sender: Any) {
        walkthroughView.removeFromSuperview()
        viewNumber = viewNumber + 1
        walkthroughMindBody()
    }
    
    
}
