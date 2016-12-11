//
//  WarmupScreen.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 26/11/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class WarmupScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout    {
    

    
    // Outlets
    
    
    // Body Image
    @IBOutlet weak var bodyImage: UIImageView!
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Description Label
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Extra Information
    //@IBOutlet weak var extraInformation: UIButton!
    @IBOutlet weak var extraInformationView: UIView!
    
    
    // Collection View Controller
    @IBOutlet weak var collectionView: UICollectionView!
 
    
   

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Navigation Controller
        self.navigationItem.prompt = (NSLocalizedString("movement", comment: ""))
        
        self.navigationItem.title = "5 minutes light cardio"
        
     
        
        // Labels
    //extraInformation.setTitle((NSLocalizedString("extraInformation", comment: "")), for: .normal)
      
        
        collectionView.backgroundColor = .black
    
        
        
        
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture))
        self.extraInformationView.addGestureRecognizer(gestureRecognizer)
        
        view.bringSubview(toFront: extraInformationView)
        self.extraInformationView.center = CGPoint(x: view.center.x, y: (2 * view.center.y) + 73.5)

        
        
        view.bringSubview(toFront: collectionView)
    }
    
    @IBAction func panGesture(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == UIGestureRecognizerState.changed {
            
            let translation = gestureRecognizer.translation(in: self.view)
            
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if gestureRecognizer.state == .ended {
//            if (extraInformationView.center.y < 2 * view.center.y) {
//                extraInformationView.center = CGPoint(x: gestureRecognizer.view!.center.x, y: view.center.y - 73.5)
//                    gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
//            } else if (extraInformationView.center.y > 2 * view.center.y) {
//                extraInformationView.center = CGPoint(x: view.center.x, y: self.view.center.y)
//                gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
//            }
            
            extraInformationView.center = CGPoint(x: view.center.x, y: view.center.y)
            //gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)

        }
    }

    

    
    
//    // Warmup Array
//    let warmupFull : [String] =
//        [
//            "movement1",
//            "movement2",
//            "movement3",
//            "movement4",
//            "movement5",
//            "movement6",
//            ]
//    

    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let titleCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
       
        if indexPath.row == 0 {
            titleCell.textLabel?.text = "Sets & Reps"
            titleCell.textLabel?.textAlignment = .center
            titleCell.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)
            
            return titleCell
        } else {
            cell.textLabel?.text = "Hi"
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 17)
            return cell
            
        }
        
        
        
    }


    
    // Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
        
        cell.backgroundColor = .red
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.view.frame.size.width-3)/6
        return CGSize(width: width, height: 24.5)
    }
    
}
