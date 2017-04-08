//
//  Settings.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit



//
// Settings Class -------------------------------------------------------------------------------------------------------------------------------
//

class Settings: UITableViewController {
    
    // Background Image Array
    let backgroundImageArray: [UIImage] =
        [#imageLiteral(resourceName: "Background 0"), #imageLiteral(resourceName: "Background 1"), #imageLiteral(resourceName: "Background 2"), #imageLiteral(resourceName: "Background 3"), #imageLiteral(resourceName: "Background 4")]
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
    
    // View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        // Set TableView Background Colour
        //
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        //
        self.tableView.backgroundView = backView
        //
        tableView.reloadData()
        
        // Show Navigation Bar
        //
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//
// Settings TableView --------------------------------------------------------------------------------------------------------------------------
//
    
    
// Sections
    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    // Section Titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return (NSLocalizedString("homeScreenImage", comment: ""))
        case 1: return (NSLocalizedString("units", comment: ""))
        case 2: return (NSLocalizedString("presentationStyle", comment: ""))
        case 3: return (NSLocalizedString("reset", comment: ""))
        default: return (NSLocalizedString("default", comment: ""))
        }
    }
    
    // Header Customization
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 21)!
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        //
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        // Border
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x: 15, y: header.frame.size.height-1, width: self.view.frame.size.height, height: 1)
        //
        header.layer.addSublayer(border)
        header.layer.masksToBounds = true
        
    }
    
    // Header Height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    
    
// Rows
    // Number of rows per section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 2
        }
        return 0
    }
    
    // Row cell customization
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get cell
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        // Image View for background images
        let backgroundImageView = UIImageView()
    
        // Settings sections
        switch indexPath.section {
        // Homescreen Background
        case 0:
        //
            //
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            
            // Background ImageView frame
            backgroundImageView.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 15, height: cell.frame.size.height/2)
            backgroundImageView.center.y = cell.center.y
            
            // Retreive background index
            let backgroundIndex = UserDefaults.standard.integer(forKey: "homeScreenBackground")
            
            // Set image background based on index
            if backgroundIndex < backgroundImageArray.count {
                backgroundImageView.image = backgroundImageArray[backgroundIndex]

            // If grey background
            } else if backgroundIndex == backgroundImageArray.count {
                //
                backgroundImageView.layer.borderWidth = 1
                backgroundImageView.layer.borderColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0).cgColor
                //
                backgroundImageView.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            
            // If red-orange background
            } else if backgroundIndex == backgroundImageArray.count + 1 {
                // Rotate Gradient Label
                backgroundImageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
                backgroundImageView.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 15, height: cell.frame.size.height/2)
                backgroundImageView.center.y = cell.center.y
                //
                backgroundImageView.applyGradient(colours: [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)])
                //
                }
            
            // Final background image view customization
            backgroundImageView.contentMode = .scaleToFill
            cell.addSubview(backgroundImageView)
            cell.accessoryType = .disclosureIndicator
                
            // Background image frame if iPhone 5
            if UIScreen.main.nativeBounds.height < 1334 {
                backgroundImageView.frame = CGRect(x: 15, y: (cell.frame.size.height / 2) - (backgroundImageView.frame.size.height / 2), width: cell.frame.size.width - 70, height: cell.frame.size.height/2)
            }
            //
            return cell
            
        // Units
        case 1:
        //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            // Retreive Units
            cell.textLabel?.text = UserDefaults.standard.string(forKey: "units")
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            return cell

        // Presentation Style
        case 2:
        //
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            // Retreive Presentation Style
            cell.textLabel?.text = NSLocalizedString(UserDefaults.standard.string(forKey: "presentationStyle")!, comment: "")
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            return cell
            
        // Reset
        case 3:
        //
            // Reset Walkthrough
            if indexPath.row == 0 {
                cell.textLabel?.text = NSLocalizedString("resetWalkthrough", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
                return cell
            }
            // Reset App
            else if indexPath.row == 1 {
                cell.textLabel?.text = NSLocalizedString("resetApp", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
                return cell
            }
        //
        default: return cell
        }
        return cell
    }
    
    // Selection handler
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let cell = tableView.cellForRow(at: indexPath)
        //
        switch section {
        
        // Homescreen Image
        case 0:
            // Segue to homescreen choice
            performSegue(withIdentifier: "BackgroundImageSegue", sender: nil)
            //
            tableView.deselectRow(at: indexPath, animated: true)

         // Units
        case 1:
        //  
            // kg --> lb
            if cell?.textLabel?.text == "kg" {
                cell?.textLabel?.text = "lb"
                UserDefaults.standard.set("lb", forKey: "units")
            // lb --> kg
            } else if cell?.textLabel?.text == "lb" {
                cell?.textLabel?.text = "kg"
                UserDefaults.standard.set("kg", forKey: "units")
            }
            tableView.deselectRow(at: indexPath, animated: true)
            
        // Presentation Style
        case 2:
        //
            // detailed --> overview
            if cell?.textLabel?.text == NSLocalizedString("detailed", comment: "") {
                cell?.textLabel?.text = NSLocalizedString("overview", comment: "")
                UserDefaults.standard.set("overview", forKey: "presentationStyle")
            // overview --> detailed
            } else if cell?.textLabel?.text == NSLocalizedString("overview", comment: "") {
                cell?.textLabel?.text = NSLocalizedString("detailed", comment: "")
                UserDefaults.standard.set("detailed", forKey: "presentationStyle")
            }
            tableView.deselectRow(at: indexPath, animated: true)
            
        // Reset
        case 3:
        //
            // Reset Walkthrough
            if indexPath.row == 0 {
                
                // Walkthrough
                    // Mind Body
                        // Home Screen
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough")
                        // Calendar
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthroughC")
                
                        // Choice Screen 1
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough1")
                        // c
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthroughc")
                
                        // w
                        UserDefaults.standard.set(true, forKey: "mindBodyWalkthroughw")
                
                        // Choice Screen 2
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough2")
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough2y")
                
                        // Movement Screen
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough3")
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough3y")
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthrough4y")
                
                        // Session Screen
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthroughw")
                
                        // Information
                        UserDefaults.standard.set(false, forKey: "mindBodyWalkthroughI")
                
                    //Profile
                    UserDefaults.standard.set(false, forKey: "profileWalkthrough")
                    // Information
                    UserDefaults.standard.set(false, forKey: "informationWalkthrough")
                    //
                    UserDefaults.standard.set(false, forKey: "informationWalkthroughm")
                
                //
                // Alert View indicating need for app reset
                let title = NSLocalizedString("resetTitle", comment: "")
                let message = NSLocalizedString("resetMessage", comment: "")
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.view.tintColor = colour1
                alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .justified
                alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")

                // Present alert
                self.present(alert, animated: true, completion: nil)
                
                //
                tableView.deselectRow(at: indexPath, animated: true)
               
            // Reset App
            } else if indexPath.row == 1 {
                
            // Alert View indicating meaning of resetting the app
            let title = NSLocalizedString("resetWarning", comment: "")
            let message = NSLocalizedString("resetWarningMessage", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = colour2
            alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
           
                
            // Reset app action
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    UserDefaults.standard.synchronize()
                    
                    // Alert View
                    let title = NSLocalizedString("resetTitle", comment: "")
                    let message = NSLocalizedString("resetMessage", comment: "")
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alert.view.tintColor = self.colour2
                    alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.alignment = .justified
                    alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
                    
                    self.present(alert, animated: true, completion: nil)
                }
            // Cancel reset action
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                }
            // Add Actions
            alert.addAction(okAction)
            alert.addAction(cancelAction)
               
            // Present Alert
            self.present(alert, animated: true, completion: nil)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        //
        default:
            break
        }
    }
    
    
//   
// Settings TableView ---------------------------------------------------------------------------------------------------------------------------
//
    
    // Remove Back Button for next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
    }
//
}
