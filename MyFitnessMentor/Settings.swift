//
//  Settings.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class Settings: UITableViewController{
    
    
    
    
    
    let colour7 = UserDefaults.standard.color(forKey: "colour7")!
    
    override func viewWillAppear(_ animated: Bool) {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        self.tableView.backgroundView = backView
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.tintColor = .black
        
        // Checked UserDefaults
        let checked = [1,0,0,0,0]
        UserDefaults.standard.register(defaults: ["colourChecked" : checked])
        //UserDefaults.standard.set(checked, forKey: "colourChecked")
        
        UserDefaults.standard.synchronize()
    }
    
    
    // Default Backgroud Colour
    //
    let colourSets =
        [
            [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)],
            [UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)],
            //[UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)],
            //[UIColor(red:0.54, green:0.15, blue:0.24, alpha:1.0), UIColor(red:0.23, green:0.38, blue:0.53, alpha:1.0)],
            //[UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.0), UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0)]
    ]
    

    
    let colour =
        [
            [0, 1, 2, 3, 4]
    ]
    
    // Set
    func setDefaultColour() {
        
        let checked = UserDefaults.standard.object(forKey: "colourChecked") as! [Int]
        let newColour = zip(colour.flatMap{$0},checked.flatMap{$0}).filter{$1==1}.map{$0.0}
        let index = newColour[0]
        
        let newColourSet = colourSets[index]
        
        UserDefaults.standard.setColor(newColourSet[0], forKey: "colour1")
        UserDefaults.standard.setColor(newColourSet[1], forKey: "colour2")
    
        
        if checked[0] == 1 {
            
            UserDefaults.standard.setColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour3")
            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour4")
            UserDefaults.standard.setColor(UIColor.white, forKey: "colour5")
            UserDefaults.standard.setColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour6")
            UserDefaults.standard.setColor(newColourSet[0], forKey: "colour7")
            UserDefaults.standard.setColor(newColourSet[1], forKey: "colour8")
            UserDefaults.standard.set(false, forKey: "blacknWhite")
            
        } else if checked[1] == 1 {
            
            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour3")
            UserDefaults.standard.setColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour4")
            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour5")
            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour6")
            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour7")
            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour8")
            UserDefaults.standard.set(true, forKey: "blacknWhite")
            
            
        } //else if checked[2] == 1 {
//        
//            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour3")
//            UserDefaults.standard.setColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour4")
//            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour5")
//            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour6")
//            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour7")
//            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour8")
//            UserDefaults.standard.set(false, forKey: "blacknWhite")
//            
//            
//        } //else {
//
//            UserDefaults.standard.setColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour3")
//            UserDefaults.standard.setColor(UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), forKey: "colour4")
//            UserDefaults.standard.setColor(UIColor.white, forKey: "colour5")
//            UserDefaults.standard.setColor(UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0), forKey: "colour6")
//            UserDefaults.standard.setColor(newColourSet[0], forKey: "colour7")
//            UserDefaults.standard.setColor(newColourSet[1], forKey: "colour8")
//            UserDefaults.standard.set(false, forKey: "blacknWhite")
//
//        }

        
        UserDefaults.standard.synchronize()
        
        
        // Set Colours
        let colour1 = UserDefaults.standard.color(forKey: "colour1")!
        let colour2 = UserDefaults.standard.color(forKey: "colour2")!
        
        self.navigationController?.navigationBar.barTintColor = colour1
        self.navigationController?.navigationBar.tintColor = .white
        
        
        self.tabBarController?.tabBar.tintColor = colour2
        
    }
    
    
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return (NSLocalizedString("colour", comment: ""))
        case 1: return (NSLocalizedString("units", comment: ""))
        case 2: return (NSLocalizedString("reset", comment: ""))
        default: return (NSLocalizedString("default", comment: ""))
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 21)!
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        // Border
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x: 15, y: header.frame.size.height-1, width: self.view.frame.size.height, height: 1)
        
        
        header.layer.addSublayer(border)
        header.layer.masksToBounds = true
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        } else{
            return 2
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let gradientLabel = UILabel()
        let checked = UserDefaults.standard.object(forKey: "colourChecked") as! [Int]
        
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                
                // Gradient Label
                gradientLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
                gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 15, height: cell.frame.size.height/2)
                if UIScreen.main.nativeBounds.height < 1334 {
                    gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 70, height: cell.frame.size.height/2)
                }
                gradientLabel.center.y = cell.center.y
                gradientLabel.applyGradient(colours: [colourSets[0][0], colourSets[0][1]])
                
                
                cell.addSubview(gradientLabel)
                
                // Checked
                if checked[indexPath.row] == 1 {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
                
                cell.selectionStyle = .none
                return cell
                
                
                
            } else if indexPath.row == 1 {
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)

                // Gradient Label
                gradientLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
                gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 15, height: cell.frame.size.height/2)
                if UIScreen.main.nativeBounds.height < 1334 {
                    gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 70, height: cell.frame.size.height/2)
                }
                gradientLabel.center.y = cell.center.y
                gradientLabel.applyGradient(colours: [UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), colourSets[1][1]])
                
                cell.addSubview(gradientLabel)
                
                // Checked
                if checked[indexPath.row] == 1 {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
                
                cell.selectionStyle = .none
                
                return cell

            } //else if indexPath.row == 2 {
//                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//
//                // Gradient Label
//                gradientLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
//                gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 15, height: cell.frame.size.height/2)
//                if UIScreen.main.nativeBounds.height < 1334 {
//                    gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 70, height: cell.frame.size.height/2)
//                }
//                gradientLabel.center.y = cell.center.y
//                gradientLabel.applyGradient(colours: [UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0), colourSets[2][0]])
//                
//                cell.addSubview(gradientLabel)
//                
//                
//                // Checked
//                if checked[indexPath.row] == 1 {
//                    cell.accessoryType = .checkmark
//                } else {
//                    cell.accessoryType = .none
//                }
//                
//                cell.selectionStyle = .none
//                
//                return cell
//
//            } else if indexPath.row == 3 {
//                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//
//                // Gradient Label
//                gradientLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
//                gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 15, height: cell.frame.size.height/2)
//                if UIScreen.main.nativeBounds.height < 1334 {
//                    gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 70, height: cell.frame.size.height/2)
//                }
//                gradientLabel.center.y = cell.center.y
//                //gradientLabel.applyGradient(colours: [colourSets[3][0], colourSets[3][1]])
//                gradientLabel.applyGradient(colours: [colourSets[3][0], colourSets[3][1]])
//                
//                cell.addSubview(gradientLabel)
//                
//                
//                
//                // Checked
//                if checked[indexPath.row] == 1 {
//                    cell.accessoryType = .checkmark
//                } else {
//                    cell.accessoryType = .none
//                }
//                
//                cell.selectionStyle = .none
//                
//                return cell
//
//            }  else if indexPath.row == 4 {
//                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
//                
//                // Gradient Label
//                gradientLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
//                gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 15, height: cell.frame.size.height/2)
//                if UIScreen.main.nativeBounds.height < 1334 {
//                    gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 70, height: cell.frame.size.height/2)
//                }
//                gradientLabel.center.y = cell.center.y
//                gradientLabel.applyGradient(colours: [colourSets[4][0], colourSets[4][1]])
//                
//                cell.addSubview(gradientLabel)
//                
//                
//                // Checked
//                if checked[indexPath.row] == 1 {
//                    cell.accessoryType = .checkmark
//                } else {
//                    cell.accessoryType = .none
//                }
//
//                cell.selectionStyle = .none
//                
//                return cell
//            }
        case 1:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.text = UserDefaults.standard.string(forKey: "units")
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
//            cell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "units")
//            cell.detailTextLabel?.textColor = .gray
//            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
            return cell

        case 2:
            if indexPath.row == 0 {
                cell.textLabel?.text = NSLocalizedString("resetWalkthrough", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
                return cell
            }
            else if indexPath.row == 1 {
                cell.textLabel?.text = NSLocalizedString("resetApp", comment: "")
                cell.textLabel?.textAlignment = NSTextAlignment.left
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
                return cell
            }

        default: return cell
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let cell = tableView.cellForRow(at: indexPath)
        var checked = UserDefaults.standard.object(forKey: "colourChecked") as! [Int]
        let colour1 = UserDefaults.standard.color(forKey: "colour1")
        
        
        switch section {
            
        case 0:
            
            if checked[indexPath.row] == 0 {
                
                checked = [0,0,0,0,0]
                cell?.accessoryType = .checkmark
                checked[indexPath.row] = 1
                
                UserDefaults.standard.set(checked, forKey: "colourChecked")
                
                setDefaultColour()
                
                UserDefaults.standard.synchronize()
                
            } else {
                
                
            }
            
            tableView.reloadData()
            
            
            // Alert View
            let title = NSLocalizedString("colourTitle", comment: "")
            let message = NSLocalizedString("colourMessage", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = colour1
            alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
            
            //alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        case 1:
            if cell?.textLabel?.text == "kg" {
                cell?.textLabel?.text = "lb"
                UserDefaults.standard.set("lb", forKey: "units")
            } else if cell?.textLabel?.text == "lb" {
                cell?.textLabel?.text = "kg"
                UserDefaults.standard.set("kg", forKey: "units")
            }
            tableView.deselectRow(at: indexPath, animated: true)
        case 2:
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
                // Alert View
                let title = NSLocalizedString("resetTitle", comment: "")
                let message = NSLocalizedString("resetMessage", comment: "")
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.view.tintColor = colour1
                alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .justified
                alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
                
                
                
            self.present(alert, animated: true, completion: nil)
                
                tableView.deselectRow(at: indexPath, animated: true)
                
            } else if indexPath.row == 1 {
                
            
            
            // Alert View
            let title = NSLocalizedString("resetWarning", comment: "")
            let message = NSLocalizedString("resetWarningMessage", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = colour7
            alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
           
                
            // Action
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    UserDefaults.standard.synchronize()
                    
                    // Alert View
                    let title = NSLocalizedString("resetTitle", comment: "")
                    let message = NSLocalizedString("resetMessage", comment: "")
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alert.view.tintColor = self.colour7
                    alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.alignment = .justified
                    alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
                    
                    self.present(alert, animated: true, completion: nil)

                    
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
                    UIAlertAction in

                }
                
            alert.addAction(okAction)
            alert.addAction(cancelAction)
                
            self.present(alert, animated: true, completion: nil)
            
                tableView.deselectRow(at: indexPath, animated: true)
            }

        
            
            
        default:
            break
        
            
        }
        
    
    }
    
    
    
    
}
