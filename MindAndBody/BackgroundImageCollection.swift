//
//  BackgroundImageCollection.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 25.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Custom Collection Cell -----------------------------------------------------------------------------------------------------------------------
//

class CollectionImageCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    //
    @IBOutlet weak var selectionLabel: UILabel!
    
    // Ensure image view is cleared
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Clear Gradient
        if backgroundImage.layer.sublayers?.count != 0 {
            backgroundImage.layer.sublayers?.remove(at: 0)
        }
        // Set image to nil
        backgroundImage.image = nil
    }
}


//
// Collection Class ---------------------------------------------------------------------------------------------------------------------------
//

class BackgroundImageCollection: UICollectionViewController {
    
    // Outlets
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    //
    // View Did Load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Navigation Bar Title
        navigationBar.title = NSLocalizedString("homeScreenImage", comment: "")
        
        
        // Collection view background colour
        collectionView?.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        
    }


// 
// Collection View -----------------------------------------------------------------------------------------------------------------------------
//
    
    // Number of Section
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // Number of items in section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        switch section {
            // Image Section
            case 0: return backgroundImageArray.count
            // Colour Section
            case 1: return 1
            //
            default: break
        }
        return 0
    }

    
    // Cell customization
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue reusable cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionImageCell", for: indexPath) as! CollectionImageCell
    
        //
        cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)

        
        // Image View
        //
        // Image view size
        let screenHeight = UIScreen.main.bounds.height - (navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height - (tabBarController?.tabBar.frame.size.height)!
        let screenWidth = UIScreen.main.bounds.width
        let ratio = screenHeight / screenWidth
        //
        let width = cell.frame.size.width - 40
        let height = width * ratio
        
        // Image view position
        if indexPath.item % 2 == 0 {
            cell.backgroundImage.frame = CGRect(x: 25, y: (cell.frame.size.height - height) / 2, width: width, height: height)
        } else {
            cell.backgroundImage.frame = CGRect(x: 15, y: (cell.frame.size.height - height) / 2, width: width, height: height)
        }
        
        // Image view final customization
        cell.backgroundImage.layer.cornerRadius = 5
        cell.backgroundImage.layer.masksToBounds = true
        cell.backgroundImage.contentMode = .scaleAspectFill
    
        
        // Selection Indicator
        //
        // Frame
        let spaceHeight = ((cell.frame.size.height - height) / 2)
        cell.selectionLabel.frame = CGRect(x: cell.backgroundImage.center.x - 8, y: spaceHeight + height + ((spaceHeight / 2) - 8), width: 16, height: 16)
        cell.selectionLabel.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        //
        cell.selectionLabel.layer.cornerRadius = cell.selectionLabel.frame.size.height / 2
        cell.selectionLabel.layer.masksToBounds = true
        //
        cell.selectionLabel.layer.borderWidth = 1
        cell.selectionLabel.layer.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0).cgColor
        
        
        // Index
        //
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
    
        
        //
        // Section
        //
        switch indexPath.section {
        //
        // Images
        case 0:
        //
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
        
        // Colours
        case 1:
        //
            // Colour
            //
            // Grey
            //
            cell.backgroundImage.image = nil
            cell.backgroundImage.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            
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
    

    // Selection handler
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Deselect previous selection
        let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
        //
        var deselectIndex = NSIndexPath()
        // Image
        if backgroundIndex < backgroundImageArray.count {
            deselectIndex = NSIndexPath(item: backgroundIndex, section: 0)
        // Colour
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
}


//
// Collection Layout ------------------------------------------------------------------------------------------------------------------------
//

extension BackgroundImageCollection : UICollectionViewDelegateFlowLayout {
    // Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        let width = collectionView.frame.size.width / 2
        //
        let screenHeight = UIScreen.main.bounds.height - (navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height - (tabBarController?.tabBar.frame.size.height)!
        let screenWidth = UIScreen.main.bounds.width
        let ratio = screenHeight / screenWidth
        //
        let height = width * ratio
        //
        return CGSize(width: width, height: height)
    }
    
    // insets
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        //
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    

    // Minimum line spacing
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //
        return 0
    }
    
    // Minimum column spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //
        return 0
    }
}
