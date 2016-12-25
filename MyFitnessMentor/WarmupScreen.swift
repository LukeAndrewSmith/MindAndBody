//
//  WarmupScreen.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 26/11/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

private var warmupScreenIndex = 0


class WarmupScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout    {
    

    
    // Outlets
    
    
    // Body Image
    @IBOutlet weak var bodyImage: UIImageView!
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Description Label
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Extra Information
    @IBOutlet weak var extraInformation: UILabel!
    //@IBOutlet weak var extraInformation: UIButton!
    @IBOutlet weak var extraInformationView: UIView!
    
    // Collection View Controller
    @IBOutlet weak var collectionView: UICollectionView!
 
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title Array
        let titleArray : [String] =
            [
                "title1",
                "title2",
                "title3",
                "title4",
                "title5",
                "title6",
                ]
        
        
        // Navigation Controller
        self.navigationItem.prompt = (NSLocalizedString("movement", comment: ""))
        
        
        self.navigationItem.title = titleArray[warmupScreenIndex]
        
     
        self.descriptionLabel.text = titleArray[warmupScreenIndex]
        
        // Labels
    
      
        
        collectionView.backgroundColor = .black
    
        // ExtraInformationContents
        
        
        
        
        extraInformation.text = NSLocalizedString("extraInformation", comment: "")
        
        
        
        
        extraInformation.sizeToFit()
        
        extraInformation.center.x = extraInformationView.center.x
        
        extraInformation.frame.size.height = 49
        
        // ExtraInformationView
        //
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        upSwipe.direction = UISwipeGestureRecognizerDirection.up
        self.extraInformationView.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        downSwipe.direction = UISwipeGestureRecognizerDirection.down
        self.extraInformationView.addGestureRecognizer(downSwipe)
        
        self.extraInformationView.frame = CGRect(x: 0, y: ((self.view.frame.size.height) - 73.5 - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height), width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        
        
        
        
        
        view.bringSubview(toFront: extraInformationView)
        view.bringSubview(toFront: collectionView)
    }
    
    
    
 
    @IBAction func warmupScreenNextButton(_ sender: Any) {
        
        warmupScreenIndex = warmupScreenIndex + 1
        
        self.view.setNeedsDisplay()

        
    }

    
    
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .up){
            
            
 
            
            
            if self.extraInformationView.frame.maxY == (self.view.frame.maxY + ((self.view.frame.size.height) - 73.5)) {
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
          self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: -((self.view.frame.size.height) - 73.5))
            
            }, completion: nil)
            } else {
                
            }
            

        } else if (extraSwipe.direction == .down){
            
            if self.extraInformationView.frame.maxY == self.view.frame.maxY {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                
            self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: 0)
                
            }, completion: nil)
            } else {
                
            }
            
            
        }
        
    }

    

    
    
    // Warmup Array
//    let warmupFull : [String] =
//        [
//            "",
//            "movement1",
//            "movement2",
//            "movement3",
//            "movement4",
//            "movement5",
//            "movement6",
//            ]
    

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
        
        cell.backgroundColor = UIColor(red:0.89, green:0.20, blue:0.25, alpha:1.0)
        
        //Green colour: UIColor(red:0.41, green:0.97, blue:0.63, alpha:1.0)
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.view.frame.size.width-3)/6
        return CGSize(width: width, height: 24.5)
    }
    
}
