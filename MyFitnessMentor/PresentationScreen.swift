//
//  PresentationScreen.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 29/12/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class PresentationScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    
    // Warmup Screen Index
    //
    var warmupScreenIndex = 0
    
    
    //Outlets
    //
    
    // Scroll Views
    @IBOutlet weak var scrollViewBody: UIScrollView!
    @IBOutlet weak var scrollViewExplanation: UIScrollView!
    @IBOutlet weak var scrollViewDemonstration: UIScrollView!
    @IBOutlet weak var scrollViewClock: UIScrollView!
    
    
    // TableView
    @IBOutlet weak var tableView: UITableView!
    
    
    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // Extra Information View
    @IBOutlet weak var extraInformationView: UIView!


    // Explanation Title Label
    @IBOutlet weak var explanationTitle: UILabel!
    
    
    
    //
    // Initialize Arrays
    //
    let titleArray : [String] =
        [
            "5 min Light Cardio",
            "title2",
            "title3",
            "title4",
            "title5",
            "title6",
            ]

    
    
    //
    // Initialize View Elements
    //
    
        // Explanation Label
        let explanationLabel = UILabel()
    
    
    
        // Clock View
        let timerView = UIView()
        let clockView = UIView()
    
    
    
    
    
    
    
    // Hide Back Button
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    
    
    
    
    //
    // ViewDidLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Background Gradient
        //
        self.view.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
        
        
        //
        // Scroll View Body Image
        //
        
        scrollViewBody.frame = CGRect(x: 0, y: 0, width: scrollViewBody.frame.size.width, height: scrollViewBody.frame.size.height)
        scrollViewBody.contentSize = CGSize(width: scrollViewBody.frame.size.width, height: scrollViewBody.frame.size.height)
        
            // Image
            let image = #imageLiteral(resourceName: "MyPreferences Selected")
            let imageView = UIImageView()
            imageView.frame = CGRect(x: 0, y: 0, width: scrollViewBody.frame.size.width, height: scrollViewBody.frame.size.height)
            imageView.image = image
        
        scrollViewBody.addSubview(imageView)
        
        
        //
        // Scroll View Explanation Label
        //
        
        explanationTitle.text = NSLocalizedString("explanationTitle", comment: "")
        
        scrollViewExplanation.frame = CGRect(x: 0, y: 0, width: scrollViewExplanation.frame.size.width, height: scrollViewExplanation.frame.size.height)
        scrollViewExplanation.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        
            // Explanation Label
            explanationLabel.frame = CGRect(x: 10, y: 10, width: scrollViewExplanation.frame.size.width - 20, height: scrollViewExplanation.frame.size.height)
            explanationLabel.text = NSLocalizedString("purposeText", comment: "")
        
        
            explanationLabel.font = UIFont(name: "SFUIDisplay-light", size: 19)
            explanationLabel.textAlignment = .justified
            explanationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            explanationLabel.numberOfLines = 0
            explanationLabel.sizeToFit()

        
        scrollViewExplanation.addSubview(explanationLabel)
        scrollViewExplanation.contentSize = CGSize(width: scrollViewExplanation.frame.size.width, height: explanationLabel.frame.size.height + 20)
        
        
        
        //
        // Scroll  View Clock
        //
        
        scrollViewClock.frame = CGRect(x: 0, y: scrollViewClock.frame.maxY, width: scrollViewClock.frame.size.width, height: scrollViewClock.frame.size.height)
        scrollViewClock.contentSize = CGSize(width: scrollViewClock.frame.size.width * 2, height: scrollViewClock.frame.size.height)
        scrollViewClock.isScrollEnabled = false
        
        
        
            // CountDown Timer
        
            timerView.frame = CGRect(x: 0, y: 0, width: scrollViewClock.frame.size.width, height: scrollViewClock.frame.size.height)
            timerView.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        
        
            let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleClockSwipes))
            leftSwipe.direction = UISwipeGestureRecognizerDirection.left
            timerView.addGestureRecognizer(leftSwipe)
            timerView.isUserInteractionEnabled = true
        
        
            let labelTest = UILabel(frame: CGRect(x: timerView.frame.size.width / 2, y: timerView.frame.size.height / 2, width: 50, height: 50))
            labelTest.text = "00:00"
            labelTest.textColor = .white
            labelTest.textAlignment = .center
            timerView.addSubview(labelTest)
        
        
        scrollViewClock.addSubview(timerView)
        
        
        
        
        
        
        
        clockView.frame = CGRect(x: scrollViewClock.frame.maxX, y: 0, width: scrollViewClock.frame.size.width, height: scrollViewClock.frame.size.height)
        clockView.backgroundColor = .black
        
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleClockSwipes))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        clockView.addGestureRecognizer(rightSwipe)
        clockView.isUserInteractionEnabled = true
        
        
        
        scrollViewClock.addSubview(clockView)
        
        
        
        
        
        
        
        
        
        
        
        // Extra Information View
        //
        self.extraInformationView.frame = CGRect(x: 0, y: self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.height, height: self.view.frame.size.height)
        self.extraInformationView.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
        
        
            // Extra Information Label
            let extraInformationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 49))
            extraInformationLabel.text = "Information"
            extraInformationLabel.textAlignment = .center
            extraInformationLabel.font = UIFont(name: "SFUIDisplay-medium", size: 20)
            extraInformationLabel.textColor = .white
            extraInformationLabel.backgroundColor = UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)
        
            // Swipe Down
            //
            let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
            downSwipe.direction = UISwipeGestureRecognizerDirection.down
            extraInformationLabel.addGestureRecognizer(downSwipe)
            extraInformationLabel.isUserInteractionEnabled = true
    
        extraInformationView.addSubview(extraInformationLabel)

        
        
        
        
        
        
        collectionView.backgroundColor = .black
        
        
        
        // View Order
        //
        view.bringSubview(toFront: extraInformationView)
        view.bringSubview(toFront: collectionView)
        
        
        
        
        // Display Content
        //
        displayContent()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    // Display Content Function
    func displayContent() {
        
        
        // Navigation Controller
        
        self.navigationItem.title = titleArray[warmupScreenIndex]
        
        
        //descriptionLabel.text = NSLocalizedString("purposeText", comment: "")
        
        // Back Button
//        if warmupScreenIndex == 0 {
//            warmupScreenBackButton.title = ""
//        } else if warmupScreenIndex != 0 {
//            warmupScreenBackButton.title = "<"
//            
//        }
        
    }

    
    
    //
    // Top Bar Button Actions
    //
    // Back button
    
        @IBAction func backButton(_ sender: Any) {
    
            if warmupScreenIndex == 0 {
            
            } else {
                warmupScreenIndex = warmupScreenIndex - 1
        
                displayContent()
            }
        
        
            // Swipe Down on Press
            if self.extraInformationView.frame.maxY == self.view.frame.maxY + 24.5 {
            
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                    self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            
            
            }

        }
    
        // Next Button
        @IBAction func nextButton(_ sender: Any) {
    
            if warmupScreenIndex == 5 {
                self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
                warmupScreenIndex = 0
            
            } else {
                warmupScreenIndex = warmupScreenIndex + 1
                displayContent()
            }
    
            // Swipe Down on Press
            if self.extraInformationView.frame.maxY == self.view.frame.maxY + 24.5 {
            
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                    self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            }
        }
    
    
        // Extra Information Button
        @IBAction func extraInformationButton(_ sender: Any) {
        
        
            if self.extraInformationView.frame.maxY == self.view.frame.maxY + self.view.frame.size.height {
                
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                    self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.size.height - 24.5))
                }, completion: nil)
        
            } else if self.extraInformationView.frame.maxY == self.view.frame.maxY + 24.5 {
            
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                    self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            }
        }
    
    
    
    //
    // Swipe Handlers
    //
    
    
    // Extra InformationLabel Downswipe
    //
    
    @IBAction func handleSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .down){
            
            if self.extraInformationView.frame.maxY == self.view.frame.maxY + 24.5 {
                
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                    
                    self.extraInformationView.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            }
        }
    }

    
    // Horizontal Clock Swipe
    @IBAction func handleClockSwipes(extraSwipe:UISwipeGestureRecognizer) {
        if (extraSwipe.direction == .left){
            
          
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                    
                self.scrollViewClock.contentOffset.x = self.scrollViewClock.frame.size.width
            }, completion: nil)
        } else if (extraSwipe.direction == .right){
            
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [],animations: {
                
                self.scrollViewClock.contentOffset.x = 0
            }, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //
    // Table View and Collection View
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
            titleCell.backgroundColor = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
            titleCell.textLabel?.textColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            titleCell.isUserInteractionEnabled = false
            
            
            return titleCell
        } else {
            cell.textLabel?.text = "Hi"
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 17)
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.tintColor = UIColor.black
            return cell
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 35.0
        } else if indexPath.row != 0{
            
            
            let height = self.view.frame.size.height
            return ((height * (1/3)) - 35) / 5
            
            
        }
        
        
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
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
