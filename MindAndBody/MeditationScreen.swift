//
//  MeditationScreen.swift
//  MindAndBody
//
//  Created by Luke Smith on 13.04.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Meditation Screen Class -------------------------------------------------------------------------------------------
//
class MeditationScreen: UIViewController {
    
    // Timer Label
    @IBOutlet weak var timerLabel: UILabel!
    
    // Play/Pause
    @IBOutlet weak var playPause: UIButton!
    
    // Down Arrow
    @IBOutlet weak var checkMark: UIButton!
    
    // Background Image
    @IBOutlet weak var backgroundImage: UIImageView!
    
    // Hide Screen
    @IBOutlet weak var hideScreen: UIButton!
    
    
    // Blurs
    let blur = UIVisualEffectView()
    let blur1 = UIVisualEffectView()
    let blur2 = UIVisualEffectView()
    let blur3 = UIVisualEffectView()
    let blur4 = UIVisualEffectView()
    
    
    
    
//
// View will appear -----------------------------------------------------------------------------------------------
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        backgroundImage.frame = view.bounds
        
        // Background Index
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
        
        //
        // Background Image/Colour
        //
        if backgroundIndex < backgroundImageArray.count {
            //
            backgroundImage.image = backgroundImageArray[backgroundIndex]
        } else if backgroundIndex == backgroundImageArray.count {
            //
            backgroundImage.image = nil
            backgroundImage.backgroundColor = colour1
        }
    }
    
    
//
// View did load -------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CheckMark
        checkMark.tintColor = colour4
        
        // Play & Pause
        playPause.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
        
        
        // Blur
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        //
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurEffectView)
//        view.sendSubview(toBack: blurEffectView)
//        //
//        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
//        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
//        vibrancyEffectView.frame = view.bounds
//        vibrancyEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //view.addSubview(vibrancyEffectView)
        //view.sendSubview(toBack: vibrancyEffectView)
        
        
        // Blurs
        let blurE = UIBlurEffect(style: .dark)
        blur.effect = blurE
        let vibrancyE = UIVibrancyEffect(blurEffect: blurE)
        blur.effect = vibrancyE
        blur.frame = checkMark.bounds
        blur.isUserInteractionEnabled = false
        checkMark.insertSubview(blur, belowSubview: checkMark.imageView!)
        //
        let blurE1 = UIBlurEffect(style: .dark)
        blur1.effect = blurE1
        let vibrancyE1 = UIVibrancyEffect(blurEffect: blurE1)
        blur1.effect = vibrancyE1
        blur1.frame = CGRect(x: 0, y: 0, width: timerLabel.frame.size.width + 40, height: timerLabel.frame.size.height)
        blur1.isUserInteractionEnabled = false
        blur1.layer.cornerRadius = 30
        blur1.layer.masksToBounds = true
        view.insertSubview(blur1, belowSubview: timerLabel)
        //
        let blurE2 = UIBlurEffect(style: .dark)
        blur2.effect = blurE2
        let vibrancyE2 = UIVibrancyEffect(blurEffect: blurE2)
        blur2.effect = vibrancyE2
        blur2.frame = playPause.bounds
        blur2.isUserInteractionEnabled = false
        playPause.insertSubview(blur2, belowSubview: playPause.imageView!)
        //
        let blurE3 = UIBlurEffect(style: .dark)
        blur3.effect = blurE3
        let vibrancyE3 = UIVibrancyEffect(blurEffect: blurE3)
        blur3.effect = vibrancyE3
        blur3.frame = hideScreen.bounds
        blur3.isUserInteractionEnabled = false
        hideScreen.insertSubview(blur3, belowSubview: hideScreen.imageView!)
        //
        let blurE4 = UIBlurEffect(style: .dark)
        //let vibrancyE4 = UIVibrancyEffect(blurEffect: blurE4)
        //blur4.effect = vibrancyE4
        blur4.effect = blurE4
        blur4.frame = UIApplication.shared.statusBarFrame
        blur4.isUserInteractionEnabled = false
    }

    
//
// Buttons -------------------------------------------------------------------------------------------
//
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        blur.layer.cornerRadius = checkMark.frame.size.height / 2
        blur.layer.masksToBounds = true
        //
        blur1.center = timerLabel.center
        //
        blur2.layer.cornerRadius = playPause.frame.size.height / 2
        blur2.layer.masksToBounds = true
        //
        blur3.layer.cornerRadius = hideScreen.frame.size.height / 2
        blur3.layer.masksToBounds = true
        //
        view.addSubview(blur4)
    }
    
    
//
// Buttons -------------------------------------------------------------------------------------------
//
    // Play/Pause
    @IBAction func playPauseAction(_ sender: Any) {
        if playPause.image(for: .normal) == #imageLiteral(resourceName: "Pause"){
            playPause.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
        } else if playPause.image(for: .normal) == #imageLiteral(resourceName: "Play"){
            playPause.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)
        }
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
        UIView.animate(withDuration: 0.4, animations: {
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
