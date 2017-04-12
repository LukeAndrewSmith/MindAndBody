//
//  MeditationScreenGuided.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 26.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Meditation Screen Class -------------------------------------------------------------------------------------------
//
class MeditationScreenGuided: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Timer Label
    @IBOutlet weak var timerLabel: UILabel!
    
    // Play
    @IBOutlet weak var play: UIButton!
    
    // Pause
    @IBOutlet weak var pause: UIButton!
    
    // Selected Session
    var selectedSession = [0, 0]
    
    // Sessions Titles
    let guidedSessions =
        [
            ["introduction", "breathing"],
            ["scale", "perspective"],
            ["lettingGo", "acceptance", "wandering", "oneness", "duality"],
            ["bodyScan", "unwind"]
    ]

    // Retrieve Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    

//
// View did load -------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Navigation Controller
        navigationController?.navigationBar.barTintColor = colour2
    
        // Navigation Title
        //
        let navigationTitle = UILabel()
        navigationTitle.text = NSLocalizedString(guidedSessions[selectedSession[0]][selectedSession[1]], comment: "")
        navigationTitle.frame = (navigationController?.navigationItem.accessibilityFrame)!
        navigationTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        navigationTitle.center.x = self.view.center.x
        navigationTitle.textColor = colour1
        navigationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 22)
        navigationTitle.backgroundColor = .clear
        navigationTitle.textAlignment = .center
        navigationTitle.adjustsFontSizeToFitWidth = true
        //
        self.navigationController?.navigationBar.topItem?.titleView = navigationTitle
        
        // Play & Pause
        pause.alpha = 0
        view.bringSubview(toFront: play)

        // Background Image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "TestG")!)
    
        // Blur
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        //
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.sendSubview(toBack: blurEffectView)
        //
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = view.bounds
        vibrancyEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //view.addSubview(vibrancyEffectView)
        //view.sendSubview(toBack: vibrancyEffectView)
    }
    
    
//
// Buttons -------------------------------------------------------------------------------------------
//
    // Play
    @IBAction func play(_ sender: Any) {
        //
        play.alpha = 0
        pause.alpha = 1
        view.bringSubview(toFront: pause)
    }
    
    // Pause
    @IBAction func pause(_ sender: Any) {
        
        
        //
        pause.alpha = 0
        play.alpha = 1
        view.bringSubview(toFront: play)
    }

    // Hide Screen
    let hideScreenView = UIView()
    let blurEffectView = UIVisualEffectView()
    let hideLabel = UILabel()
    //
    var brightness = UIScreen.main.brightness
    //
    @IBAction func hideScreen(_ sender: Any) {
        // Hide Screen view
        let screenSize = UIScreen.main.bounds
        hideScreenView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        hideScreenView.backgroundColor = .black
        hideScreenView.clipsToBounds = true
        hideScreenView.alpha = 0
        // single Tap
        let singleTap = UITapGestureRecognizer()
        singleTap.addTarget(self, action: #selector(handleTap))
        hideScreenView.isUserInteractionEnabled = true
        hideScreenView.addGestureRecognizer(singleTap)
        //
        UIApplication.shared.keyWindow?.insertSubview(self.hideScreenView, aboveSubview: view)
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            UIApplication.shared.isStatusBarHidden = true
            self.hideScreenView.alpha = 1
            UIScreen.main.brightness = CGFloat(0)
        }, completion: nil)
    }
    // Remove Hide Screen
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
    //
        UIApplication.shared.isStatusBarHidden = false
        hideScreenView.removeFromSuperview()
        UIScreen.main.brightness = brightness
    }
    
    // Dismiss View
    @IBAction func dismissView(_ sender: Any) {
        // Alert View
        let title = NSLocalizedString("finishEarly", comment: "")
        let message = NSLocalizedString("finishEarlyMessage", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = colour2
        alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
        // Action
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        //
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        //
        self.present(alert, animated: true, completion: nil)
    }
//
}
