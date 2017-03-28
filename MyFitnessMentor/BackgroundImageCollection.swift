//
//  BackgroundImageCollection.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 25.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


class CollectionImageCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var selectionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if backgroundImage.layer.sublayers?.count != 0 {
            backgroundImage.layer.sublayers?.remove(at: 0)
        }
        
        backgroundImage.image = nil
    }
}


class BackgroundImageCollection: UICollectionViewController {
    
    
    
    //
    let backgroundImageArray = [#imageLiteral(resourceName: "Background 0"), #imageLiteral(resourceName: "Background 1"), #imageLiteral(resourceName: "Background 2"), #imageLiteral(resourceName: "Background 3"), #imageLiteral(resourceName: "Background 4")]
    
    
    
    
    // Outlets
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    
    
    //
    // View Did Load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Navigation Bar
        navigationBar.title = NSLocalizedString("homeScreenImage", comment: "")
        
        
        
        
        collectionView?.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        
    }

    
    
    
    // Collection View
    //
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return backgroundImageArray.count
        case 1: return 2
        default: break
        }
        return 0
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionImageCell", for: indexPath) as! CollectionImageCell
        
        
//        let gradientLabel = UILabel()
//
//        // Remove Gradient
//        if cell.subviews.contains(gradientLabel) {
//            gradientLabel.removeFromSuperview()
//        }
        
        
        
        
        //
        cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)

        
        // Image
        //
        //
        let screenHeight = UIScreen.main.bounds.height - (navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height - (tabBarController?.tabBar.frame.size.height)!
        let screenWidth = UIScreen.main.bounds.width
        let ratio = screenHeight / screenWidth
        
        let width = cell.frame.size.width - 40
        let height = width * ratio
        //
        if indexPath.item % 2 == 0 {
            cell.backgroundImage.frame = CGRect(x: 25, y: (cell.frame.size.height - height) / 2, width: width, height: height)
        } else {
            cell.backgroundImage.frame = CGRect(x: 15, y: (cell.frame.size.height - height) / 2, width: width, height: height)
        }
        //
        cell.backgroundImage.layer.cornerRadius = 5
        cell.backgroundImage.layer.masksToBounds = true
        cell.backgroundImage.contentMode = .scaleAspectFill
        
    
        
        
        // Selection Indicator
        //
        //
        let spaceHeight = ((cell.frame.size.height - height) / 2)
        cell.selectionLabel.frame = CGRect(x: cell.backgroundImage.center.x - 8, y: spaceHeight + height + ((spaceHeight / 2) - 8), width: 16, height: 16)
        cell.selectionLabel.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        //
        cell.selectionLabel.layer.cornerRadius = cell.selectionLabel.frame.size.height / 2
        cell.selectionLabel.layer.masksToBounds = true
        //
        cell.selectionLabel.layer.borderWidth = 1
        cell.selectionLabel.layer.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0).cgColor
        
        
        // Selected
        //
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
        
        cell.backgroundImage.image = backgroundImageArray[indexPath.item]

        
        //
        // Section
        //
        switch indexPath.section {
        //
        case 0:
            // Image
            cell.backgroundImage.image = backgroundImageArray[indexPath.item]
            
            // Selection Label
            //
            if indexPath.item == backgroundIndex {
                cell.selectionLabel.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
                cell.isSelected = true
            }
            //
            if cell.isSelected == false {
                cell.selectionLabel.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            }
        
        case 1:
            // Colour
            //
            if indexPath.item == 0 {
                //
                cell.backgroundImage.image = nil
                cell.backgroundImage.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
                
            } else {
                //
                cell.backgroundImage.image = nil
//                gradientLabel.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
//                gradientLabel.frame = cell.backgroundImage.frame
//                
//                cell.addSubview(gradientLabel)
//                cell.bringSubview(toFront: gradientLabel)
                
                cell.backgroundImage.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
                //
            }
            
            // Selection Label
            //
            if indexPath.item == backgroundIndex - backgroundImageArray.count {
                cell.selectionLabel.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
                cell.isSelected = true
            }
            //
            if cell.isSelected == false {
                cell.selectionLabel.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            }
            //
        default: break
        }
        
        
        return cell
    }
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Deselect
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
        
        var deselectIndex = NSIndexPath()
        //
        if backgroundIndex < backgroundImageArray.count {
            deselectIndex = NSIndexPath(item: backgroundIndex, section: 0)
        } else {
            deselectIndex = NSIndexPath(item: backgroundIndex - backgroundImageArray.count, section: 1)
        }
        //
        collectionView.deselectItem(at: deselectIndex as IndexPath, animated: false)
    
        
        
        // Set New Selection
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionImageCell
        cell.selectionLabel.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        cell.isSelected = true

        
        // Store Selection Index
        if indexPath.section == 0 {
            // Section 1
            UserDefaults.standard.set(indexPath.item, forKey: "homeScreenBackground")
            //
        } else if indexPath.section == 1 {
            // Section 2
            UserDefaults.standard.set(backgroundImageArray.count + indexPath.item, forKey: "homeScreenBackground")
            //
        }
        
        collectionView.reloadData()
        
        
        

        
    }
    
    
//    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        
//        //
//        let cell = collectionView.cellForItem(at: indexPath) as! CollectionImageCell
//        cell.selectionLabel.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
//    }
    
    
    
    
}



extension BackgroundImageCollection : UICollectionViewDelegateFlowLayout {
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width / 2
        
        let screenHeight = UIScreen.main.bounds.height - (navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height - (tabBarController?.tabBar.frame.size.height)!
        let screenWidth = UIScreen.main.bounds.width
        let ratio = screenHeight / screenWidth
        let height = width * ratio
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
