//
//  WarmupScreen.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 26/11/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

var warmupScreenIndex = 0


class WarmupScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout    {
    

    
    // Outlets
    
    // Scroll Views
    @IBOutlet weak var scrollViewBodyImage: UIScrollView!
    @IBOutlet weak var scrollViewExplanation: UIScrollView!
    @IBOutlet weak var scrollViewDemonstrationImage: UIScrollView!
    
    
    
    // Body Image
    @IBOutlet weak var bodyImage: UIImageView!
    
    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    // Description Label
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Extra Information
    @IBOutlet weak var extraInformation: UIButton!
    
    //
    
    //@IBOutlet weak var extraInformation: UIButton!
    @IBOutlet weak var extraInformationView: UIView!
    
    // Collection View Controller
    @IBOutlet weak var collectionView: UICollectionView!
 
    // Back Button Item
    @IBOutlet weak var warmupScreenBackButton: UIBarButtonItem!
    

    // Arrays
    let titleArray : [String] =
        [
            "5 min Light Cardio",
            "title2",
            "title3",
            "title4",
            "title5",
            "title6",
            ]
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Background Gradient
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        
        // Navigation Controller
        
        self.navigationItem.prompt = (NSLocalizedString("movement", comment: ""))
        
        collectionView.backgroundColor = .black

        
        displayThings()
        
        
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
    
    
    func displayThings() {
        
        
        // Navigation Controller

        self.navigationItem.title = titleArray[warmupScreenIndex]
        
        
        self.descriptionLabel.text = titleArray[warmupScreenIndex]
        
        extraInformation.titleLabel?.text = NSLocalizedString("extraInformation", comment: "")
        
        // Back Button
        if warmupScreenIndex == 0 {
            warmupScreenBackButton.title = ""
        } else if warmupScreenIndex != 0 {
            warmupScreenBackButton.title = "<"
            
        }

    }
    
 
    @IBAction func warmupScreenNextButton(_ sender: Any) {

        
            if warmupScreenIndex == 5 {
                self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
                warmupScreenIndex = 0
                
            } else {
                warmupScreenIndex = warmupScreenIndex + 1
                displayThings()
            }
        
       
        
    }
    
    @IBAction func warmupScreenBackButton(_ sender: Any) {
        
        warmupScreenIndex = warmupScreenIndex - 1
        
        
        displayThings()
        
        
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

    

    
    //
    // Table View
    //
    

    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let titleCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
       
        if indexPath.row == 0 {
            titleCell.textLabel?.text = "Sets & Reps"
            titleCell.textLabel?.textAlignment = .center
            titleCell.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)
            titleCell.isUserInteractionEnabled = false
            
            
            return titleCell
        } else {
            cell.textLabel?.text = "Hi"
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 17)
            cell.tintColor = UIColor.black
            return cell
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
   

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        

        
            if cell?.accessoryType == .checkmark {
                cell?.accessoryType = .none
            } else {
                cell?.accessoryType = .checkmark
        }
    }

    
    // Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
        
        cell.backgroundColor = UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0)
        
        //Green colour: UIColor(red:0.41, green:0.97, blue:0.63, alpha:1.0)
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.view.frame.size.width-3)/6
        return CGSize(width: width, height: 24.5)
    }
    
}
