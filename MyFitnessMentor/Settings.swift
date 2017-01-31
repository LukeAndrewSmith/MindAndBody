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
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        self.tableView.backgroundView = backView
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.tintColor = .black
        
        // Checked UserDefaults
        let checked = [1,0,0,0]
        UserDefaults.standard.register(defaults: ["colourChecked" : checked])
        //UserDefaults.standard.set(checked, forKey: "colourChecked")
        
        UserDefaults.standard.synchronize()
    }
    
    
    // Default Backgroud Colour
    //
    let colourSets =
        [
            [UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0)],
            [UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.0), UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0)],
            [UIColor(red:0.54, green:0.15, blue:0.24, alpha:1.0), UIColor(red:0.23, green:0.38, blue:0.53, alpha:1.0)],
            [UIColor(red:0.04, green:0.19, blue:0.16, alpha:1.0), UIColor(red:0.14, green:0.48, blue:0.34, alpha:1.0)]
    ]
    

    
    let colour =
        [
            [0, 1, 2, 3]
    ]
    
    // Set
    func setDefaultColour() {
        
        let checked = UserDefaults.standard.object(forKey: "colourChecked") as! [Int]
        let newColour = zip(colour.flatMap{$0},checked.flatMap{$0}).filter{$1==1}.map{$0.0}
        let index = newColour[0]
        
        let newColourSet = colourSets[index]
        
        UserDefaults.standard.setColor(newColourSet[0], forKey: "colour1")
        UserDefaults.standard.setColor(newColourSet[1], forKey: "colour2")

        
        UserDefaults.standard.synchronize()
        
        
        // Set Colours
        let colour1 = UserDefaults.standard.color(forKey: "colour1")!
        let colour2 = UserDefaults.standard.color(forKey: "colour2")!
        
        self.navigationController?.navigationBar.barTintColor = colour1
        self.navigationController?.navigationBar.tintColor = .white
        
        
        self.tabBarController?.tabBar.tintColor = colour2
        
    }
    
    
    
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return (NSLocalizedString("case11", comment: ""))
        case 1: return (NSLocalizedString("colour", comment: ""))
        default: return (NSLocalizedString("default", comment: ""))
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 20)!
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
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < 1 {
            return 1
        } else {
            return 4
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let gradientLabel = UILabel()
        let checked = UserDefaults.standard.object(forKey: "colourChecked") as! [Int]
        
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = NSLocalizedString("clearPreferences", comment: "")
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
            return cell
        case 1:
            if indexPath.row == 0 {
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                
                // Gradient Label
                gradientLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
                gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 20, height: cell.frame.size.height/2)
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
                gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 20, height: cell.frame.size.height/2)
                gradientLabel.center.y = cell.center.y
                gradientLabel.applyGradient(colours: [colourSets[1][0], colourSets[1][1]])
                
                cell.addSubview(gradientLabel)
                
                // Checked
                if checked[indexPath.row] == 1 {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
                
                cell.selectionStyle = .none
                
                return cell

            } else if indexPath.row == 2 {
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)

                // Gradient Label
                gradientLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
                gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 20, height: cell.frame.size.height/2)
                gradientLabel.center.y = cell.center.y
                gradientLabel.applyGradient(colours: [colourSets[2][0], colourSets[2][1]])
                
                cell.addSubview(gradientLabel)
                
                
                // Checked
                if checked[indexPath.row] == 1 {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
                
                cell.selectionStyle = .none
                
                return cell

            } else if indexPath.row == 3 {
                cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)

                // Gradient Label
                gradientLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
                gradientLabel.frame = CGRect(x: 15, y: 0, width: cell.frame.size.width - 20, height: cell.frame.size.height/2)
                gradientLabel.center.y = cell.center.y
                gradientLabel.applyGradient(colours: [colourSets[3][0], colourSets[3][1]])
                
                cell.addSubview(gradientLabel)
                
                
                
                // Checked
                if checked[indexPath.row] == 1 {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
                
                cell.selectionStyle = .none
                
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
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            UserDefaults.standard.synchronize()
            
            // Alert View
            let title = NSLocalizedString("resetTitle", comment: "")
            let message = NSLocalizedString("resetMessage", comment: "")
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = colour1
            alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            // Reset Colour Defaults
            UserDefaults.standard.setColor(UIColor(red:0.67, green:0.13, blue:0.26, alpha:1.0), forKey: "colour1")
            UserDefaults.standard.setColor(UIColor(red:0.91, green:0.44, blue:0.25, alpha:1.0), forKey: "colour2")
            
        case 1:
            
            if checked[indexPath.row] == 0 {
                
                checked = [0,0,0,0]
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
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                
            self.present(alert, animated: true, completion: nil)
            
            
            
            
            
        default:
            break
        
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    
    
    
    
    
    
}
