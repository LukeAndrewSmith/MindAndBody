//
//  MeditationScreenGuided.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 26.02.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



class MeditationScreenGuided: UIViewController {
    
    
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    
    
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
    let colour1 = UserDefaults.standard.color(forKey: "colour1")!
    let colour2 = UserDefaults.standard.color(forKey: "colour2")!
    let colour5 = UserDefaults.standard.color(forKey: "colour5")!
    let colour7 = UserDefaults.standard.color(forKey: "colour7")!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Navigation Controller
        navigationController?.navigationBar.barTintColor = colour5
        
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
        
        self.navigationController?.navigationBar.topItem?.titleView = navigationTitle
        

        
        
        
        
        
        
        // Background Image
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "TestG")!)
        
        
        // Blur
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        
        
    }
    
    
    
    
    
        
        
    
    
    
    
    // Dismiss View
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    
    
}
