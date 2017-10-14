//
//  YogaAutomatic.swift
//  MindAndBody
//
//  Created by Luke Smith on 29.05.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation



//
// Global Arrays
//
// Time Array
let timeArray: [Double] = [2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 3.0, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 4.0, 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9, 5.0, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8, 5.9, 6.0, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 6.9, 7.0]

//
let transitionArray: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]



//
// Yoga Automatic Class --------------------------------------------------------------------------------------------------
//
class YogaAutomatic: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
//
// Outlets --------------------------------------------------------------------------------------------------
//
    //
    @IBOutlet weak var tableViewAutomatic: UITableView!
   
    //
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    //
    var offView = UIView()
    
    var soundPlayer: AVAudioPlayer!
//
// Arrays --------------------------------------------------------------------------------------------------
//
    // Section Headers
    var sectionHeaderArray: [String] = ["off/on", "averageBreathLength", "transitionTime", "transitionIndicator"]

    
    // Bells Arrays
    let bellsArray: [String] =
        ["Tibetan Chimes", "Tibetan Singing Bowl (Low)", "Tibetan Singing Bowl (Low)(x4)", "Tibetan Singing Bowl (Low)(Singing)", "Tibetan Singing Bowl (High)", "Tibetan Singing Bowl (High)(x4)", "Tibetan Singing Bowl (High)(Singing)", "Australian Rain Stick", "Australian Rain Stick (x2)", "Australian Rain Stick (2 sticks)", "Wind Chimes", "Gambang (Wood)(Up)", "Gambang (Wood)(Down)", "Gambang (Metal)", "Indonesian Frog", "Cow Bell (Small)", "Cow Bell (Big)"]
    let bellsImages: [UIImage] =
        [#imageLiteral(resourceName: "Tibetan Chimes"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Wind Chimes"), #imageLiteral(resourceName: "Indonesian Xylophone Big"), #imageLiteral(resourceName: "Indonesian Xylophone Big"), #imageLiteral(resourceName: "Indonesian Xylophone Small"), #imageLiteral(resourceName: "Indonesian Frog"), #imageLiteral(resourceName: "Cow Bell"), #imageLiteral(resourceName: "Cow Bell Big")]
    
    //
    // Selection Items
    let selectionView = UIView()
    let okButton = UIButton()
    let backgroundViewSelection = UIButton()
    //
    // Lengths
    let pickerView = UIPickerView()
        let indicatorLabel = UILabel()
    //
    // Bells
    let tableViewBells = UITableView()
        var didChangeTransitionIndicator = false
        var selectedTransitionIndicator = Int()
    
    //
    var selectedItem = Int()
    
    // NOTE:
    // settings[3] = settings[3]
    
//
// View did load --------------------------------------------------------------------------------------------------
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        // Set TableView Background Colour
        //
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        //
        self.tableViewAutomatic.backgroundView = backView
        //
    }

    
//
// View did load --------------------------------------------------------------------------------------------------
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar
        navigationBar.title = NSLocalizedString("automaticYoga", comment: "")
        
        // Table View
        tableViewAutomatic.tableFooterView = UIView()
        
        
        // Bells Table
        let tableViewBackground2 = UIView()
        //
        tableViewBackground2.backgroundColor = colour2
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.tableViewBells.frame.size.width, height: self.tableViewBells.frame.size.height)
        //
        tableViewBells.backgroundView = tableViewBackground2
        tableViewBells.tableFooterView = UIView()
        // TableView Cell action items
        //
        tableViewBells.backgroundColor = colour2
        tableViewBells.delegate = self
        tableViewBells.dataSource = self
        tableViewBells.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewBells.layer.cornerRadius = 5
        tableViewBells.clipsToBounds = true
        //
        
        // Selection Items
        // view
        selectionView.backgroundColor = colour2
        selectionView.layer.cornerRadius = 15
        selectionView.layer.masksToBounds = true
        
        // Background View
        backgroundViewSelection.backgroundColor = .black
        backgroundViewSelection.addTarget(self, action: #selector(backgroundViewSelectionAction(_:)), for: .touchUpInside)
        //
        okButton.backgroundColor = colour1
        okButton.setTitleColor(colour3, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        //
        
        // Picker
        pickerView.backgroundColor = colour2
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // indicator Label
        indicatorLabel.textAlignment = .center
        indicatorLabel.textColor = colour1
        indicatorLabel.text = "s"
        indicatorLabel.font = UIFont(name: "SFUIDisplay-thin", size: 22)
        indicatorLabel.numberOfLines = 1
        indicatorLabel.sizeToFit()
        indicatorLabel.center.y = pickerView.center.y
        indicatorLabel.center.x = pickerView.frame.minX + (pickerView.frame.size.width * (3.55/6))
        pickerView.addSubview(indicatorLabel)
        
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Off View
        offView.backgroundColor = colour2
        offView.alpha = 0.5
        let yPosition = CGFloat(91)
        offView.frame = CGRect(x: 0, y: yPosition, width: self.view.frame.size.width, height: view.frame.size.height - yPosition)
        
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        // Retreive Presentation Style
        if settings[3][0] == 0 {
            view.insertSubview(offView, aboveSubview: tableViewAutomatic)
            tableViewAutomatic.isScrollEnabled = false
        }
    }
    
    
//
// Table View --------------------------------------------------------------------------------------------------
//
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case tableViewAutomatic: return 4
        case tableViewBells: return 1
        default: return 0
        }
    }
    
    // Title for header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case tableViewAutomatic:
            return NSLocalizedString(sectionHeaderArray[section], comment: "")
        case tableViewBells:
            return " "
        default: return " "
        }
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        switch tableView {
        case tableViewAutomatic:
            // Header
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 22)!
            header.textLabel?.textColor = .black
            header.textLabel?.text = header.textLabel?.text?.capitalized
            
            //
            header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
            // Border
            let border = CALayer()
            border.backgroundColor = colour2.cgColor
            border.frame = CGRect(x: 15, y: header.frame.size.height-1, width: self.view.frame.size.height, height: 1)
            //
            header.layer.addSublayer(border)
            header.layer.masksToBounds = true
        case tableViewBells:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 17)!
            header.textLabel?.textColor = colour1
            header.contentView.backgroundColor = colour2
            header.contentView.tintColor = colour1
        default: break
        }
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView {
        case tableViewAutomatic:
            return 47
        case tableViewBells:
            return 20
        default: break
        }
        return 0
    }
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tableViewAutomatic:
            return 1
        case tableViewBells:
            return bellsArray.count
        default: break
        }
        return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //
        switch tableView {
        case tableViewAutomatic:
            //
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            //
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]

            //
            switch indexPath.section {
            case 0:
                // Retreive Presentation Style
                if settings[3][0] == 0 {
                    cell.textLabel?.text = NSLocalizedString("off", comment: "")
                } else {
                    cell.textLabel?.text = NSLocalizedString("on", comment: "")
                }
            case 1:
                //
                if settings[3][1] == -1 {
                    cell.textLabel?.text = "-"
                } else {
                    cell.textLabel?.text = String(timeArray[settings[3][1]]) + "s"
                }
            case 2:
                //
                if settings[3][2] == -1 {
                    cell.textLabel?.text = "-"
                } else {
                    cell.textLabel?.text = String(transitionArray[settings[3][2]]) + "s"
                }
            case 3:
                //
                if settings[3][3] == -1 {
                    cell.textLabel?.text = "-"
                } else {
                    cell.textLabel?.text = NSLocalizedString(bellsArray[settings[3][3]], comment: "")
                }
            default: break
            }
        
            //
            return cell
            
        //
        case tableViewBells:
            //
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 20)
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
            //
            //
            cell.textLabel?.text = NSLocalizedString(bellsArray[indexPath.row], comment: "")
            cell.imageView?.image = bellsImages[indexPath.row]
            //
            cell.textLabel?.textAlignment = .left
            cell.backgroundColor = colour2
            cell.textLabel?.textColor = colour1
            cell.tintColor = colour1
            
            //
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            if didChangeTransitionIndicator == false {
                if settings[3][3] != -1 {
                    selectedTransitionIndicator = settings[3][3]
                }
            }
            //
            if indexPath.row == selectedTransitionIndicator {
                cell.textLabel?.textColor = colour3
                cell.accessoryType = .checkmark
                cell.tintColor = colour3
            }
            //
            if selectedTransitionIndicator != -1 {
                okButton.isEnabled = true
            }
            return cell
        //
        default: break
        }
        return UITableViewCell()
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case tableViewAutomatic:
            return 44
        case tableViewBells:
            return 88
        default: return 0
        }
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let cell = tableView.cellForRow(at: indexPath)
        //
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        
        //
        switch tableView {
        case tableViewAutomatic:
            //
            switch indexPath.section {
            // On/Off
            case 0:
                // off -> on
                if settings[3][0] == 0 {
                    //
                    cell?.textLabel?.text = NSLocalizedString("on", comment: "")
                    settings[3][0] = 1
                
                    if settings[3][1] == -1 && settings[3][2] == -1 {
                        navigationItem.hidesBackButton = true
                    }
                    //
                    // Off view
                    UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.offView.alpha = 0
                    }, completion: { finished in
                        self.offView.removeFromSuperview()
                        tableView.isScrollEnabled = true
                    })
                    //
                    // Present walkthrough
                    let walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
                    if walkthroughs[12] == false {
                        walkthroughAutomaticYoga()
                    }
                    // on -> off
                } else {
                    //
                    cell?.textLabel?.text = NSLocalizedString("off", comment: "")
                    settings[3][0] = 0
                    //
                    navigationItem.hidesBackButton = false
                
                    //
                    //
                    offView.alpha = 0
                    view.insertSubview(offView, aboveSubview: tableView)
                    //
                    // Off view
                    UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.offView.alpha = 0.5
                    }, completion: { finished in
                        tableView.isScrollEnabled = false
                    })
                }
                //
                UserDefaults.standard.set(settings, forKey: "userSettings")
                
            // Breath Length
            case 1:
                //
                okButton.isEnabled = true
                //
                selectedItem = 0
                pickerView.reloadAllComponents()
                // View
                //
                let selectionWidth = UIScreen.main.bounds.width - 20
                let selectionHeight = CGFloat(147 + 49)
                //
                UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
                selectionView.frame = CGRect(x: 10, y: view.frame.maxY, width: selectionWidth, height: selectionHeight)
                self.pickerView.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height - 49)
                                //
                // PickerView
                selectionView.addSubview(pickerView)
                pickerView.frame = CGRect(x: 0, y: 0, width: selectionView.frame.size.width, height: selectionView.frame.size.height - 49)
                // Select Rows
                if settings[3][1] == -1 {
                    pickerView.selectRow(0, inComponent: 0, animated: true)
                } else {
                    pickerView.selectRow(settings[3][1], inComponent: 0, animated: true)
                }
                //
                selectionView.addSubview(indicatorLabel)
                indicatorLabel.textAlignment = .left
                self.indicatorLabel.center.y = self.pickerView.center.y
                self.indicatorLabel.center.x = self.pickerView.frame.minX + (self.pickerView.frame.size.width * (3.55/6))
                // ok
                self.okButton.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
                selectionView.addSubview(okButton)
                //
                backgroundViewSelection.alpha = 0
                UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: selectionView)
                backgroundViewSelection.frame = UIScreen.main.bounds
                // Animate fade and size
                // Position
                UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    //
                    self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
                    //
                    self.backgroundViewSelection.alpha = 0.5
                }, completion: nil)
                
            // Transition Time
            case 2:
                //
                okButton.isEnabled = true
                //
                selectedItem = 1
                pickerView.reloadAllComponents()
                // View
                //
                let selectionWidth = UIScreen.main.bounds.width - 20
                let selectionHeight = CGFloat(147 + 49)
                //
                UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
                selectionView.frame = CGRect(x: 10, y: view.frame.maxY, width: selectionWidth, height: selectionHeight)
                self.pickerView.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height - 49)
                //
                // PickerView
                selectionView.addSubview(pickerView)
                pickerView.frame = CGRect(x: 0, y: 0, width: selectionView.frame.size.width, height: selectionView.frame.size.height - 49)
                // Select Rows
                if settings[3][1] == -1 {
                    pickerView.selectRow(0, inComponent: 0, animated: true)
                } else {
                    pickerView.selectRow(settings[3][2], inComponent: 0, animated: true)
                }
                //
                selectionView.addSubview(indicatorLabel)
                indicatorLabel.textAlignment = .left
                self.indicatorLabel.center.y = self.pickerView.center.y
                self.indicatorLabel.center.x = self.pickerView.frame.minX + (self.pickerView.frame.size.width * (3.55/6))
                // ok
                self.okButton.frame = CGRect(x: 0, y: 147, width: self.selectionView.frame.size.width, height: 49)
                selectionView.addSubview(okButton)
                //
                backgroundViewSelection.alpha = 0
                UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: selectionView)
                backgroundViewSelection.frame = UIScreen.main.bounds
                // Animate fade and size
                // Position
                UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    //
                    self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
                    //
                    self.backgroundViewSelection.alpha = 0.5
                }, completion: nil)
                
                
            // Transition Indicator
            case 3:
                //
                okButton.isEnabled = false
                //
                selectedItem = 2
                //
                selectedTransitionIndicator = -1
                didChangeTransitionIndicator = false
                tableViewBells.reloadData()
                // View
                //
                let selectionWidth = UIScreen.main.bounds.width - 20
                let selectionHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 47 - 88
                //
                UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
                selectionView.frame = CGRect(x: 10, y: view.frame.maxY, width: selectionWidth, height: selectionHeight)
                self.pickerView.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: self.selectionView.frame.size.height - 49)
                
                // Tableview
                selectionView.addSubview(tableViewBells)
                self.tableViewBells.frame = CGRect(x: 0, y: 0, width: self.selectionView.frame.size.width, height: selectionHeight - 49)
                // ok
                self.okButton.frame = CGRect(x: 0, y: self.tableViewBells.frame.maxY, width: self.selectionView.frame.size.width, height: 49)
                selectionView.addSubview(okButton)
                if selectedTransitionIndicator != -1 {
                    okButton.isEnabled = true
                }
                //
                backgroundViewSelection.alpha = 0
                backgroundViewSelection.frame = UIScreen.main.bounds
                //
                UIApplication.shared.keyWindow?.insertSubview(selectionView, aboveSubview: view)
                UIApplication.shared.keyWindow?.insertSubview(backgroundViewSelection, belowSubview: selectionView)
                // Animate fade and size
                // Position
                UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    //
                    self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY - selectionHeight - 10, width: selectionWidth, height: selectionHeight)
                    //
                    self.backgroundViewSelection.alpha = 0.5
                    //
                }, completion: nil)
            //
            default: break
            }
            
        //
        case tableViewBells:
            //
            okButton.isEnabled = true
            //
            let url = Bundle.main.url(forResource: bellsArray[indexPath.row], withExtension: "caf")!
            //
            do {
                let bell = try AVAudioPlayer(contentsOf: url)
                soundPlayer = bell
                bell.play()
            } catch {
                // couldn't load file :(
            }
            //
            selectedTransitionIndicator = indexPath.row
            didChangeTransitionIndicator = true
            //
            tableViewBells.reloadData()
            tableViewBells.deselectRow(at: indexPath, animated: true)
            //
        //
        default: break
        }
        
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    //
    // Picker View ----------------------------------------------------------------------------------------------------
    //
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch selectedItem {
        case 0:
            return timeArray.count
        case 1:
            return transitionArray.count
        default: break
        }
        return 0
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        let secondsLabel = UILabel()
        secondsLabel.font = UIFont(name: "SFUIDisplay-light", size: 24)
        secondsLabel.textColor = colour1
        //
        switch selectedItem {
        case 0:
            secondsLabel.text = String(timeArray[row])
        case 1:
            secondsLabel.text = String(transitionArray[row])
        default: break
        }
        //
        secondsLabel.textAlignment = .center
        return secondsLabel
        //
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
    
    
    
    
    //
    // Selection Related actions ------------------------------------------------------------------------------------------------
    //
    // Add movement table background (dismiss table)
    func backgroundViewSelectionAction(_ sender: Any) {
        //
        //
        // Remove View
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            //
            if self.selectedItem == 0 || self.selectedItem == 2 {
                self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.view.frame.size.width - 20, height: 147 + 49)
            } else {
                self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.view.frame.size.width - 20, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 47 - 88)
            }
            //
            self.backgroundViewSelection.alpha = 0
            //
        }, completion: { finished in
            for i in self.selectionView.subviews {
                i.removeFromSuperview()
            }
            //
            self.selectionView.removeFromSuperview()
            self.backgroundViewSelection.removeFromSuperview()
        })
        //
            
        // Extra
        if selectedItem == 2 {
            if soundPlayer != nil {
                if soundPlayer.isPlaying {
                    soundPlayer.stop()
                }
            }
        }
    }
    
    // Ok button action
    func okButtonAction(_ sender: Any) {
        //
        let defaults = UserDefaults.standard
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        //
        switch selectedItem {
        //
        // Breath Length
        case 0:
            //
            settings[3][1] = pickerView.selectedRow(inComponent: 0)
            defaults.set(settings, forKey: "userSettings")
            //
            let indexPath = NSIndexPath(row: 0, section: 1)
            let cell = tableViewAutomatic.cellForRow(at: indexPath as IndexPath)
            cell?.textLabel?.text = String(timeArray[settings[3][1]]) + "s"
        //
        // Transition time
        case 1:
            //
            settings[3][2] = pickerView.selectedRow(inComponent: 0)
            defaults.set(settings, forKey: "userSettings")
            //
            let indexPath = NSIndexPath(row: 0, section: 2)
            let cell = tableViewAutomatic.cellForRow(at: indexPath as IndexPath)
            cell?.textLabel?.text = String(transitionArray[settings[3][2]]) + "s"
        //
        // Transition Indicator
        case 2:
            //
            if soundPlayer != nil {
                if soundPlayer.isPlaying == true {
                    soundPlayer.stop()
                }
            }
            //
            settings[3][3] = selectedTransitionIndicator
            //
            let indexPath = NSIndexPath(row: 0, section: 3)
            let cell = tableViewAutomatic.cellForRow(at: indexPath as IndexPath)
            cell?.textLabel?.text = NSLocalizedString(bellsArray[selectedTransitionIndicator], comment: "")
            //
            defaults.set(settings, forKey: "userSettings")
            //
            selectedTransitionIndicator = -1
            //
        default: break
        }
        //
        if settings[3][1] != -1 && settings[3][2] != -1 {
            navigationItem.hidesBackButton = false
        }
        
        //
        // Remove View
        UIView.animate(withDuration: AnimationTimes.animationTime2, animations: {
            //
            if self.selectedItem == 0 || self.selectedItem == 2 {
                self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.view.frame.size.width - 20, height: 147 + 49)
            } else {
                self.selectionView.frame = CGRect(x: 10, y: self.view.frame.maxY, width: self.view.frame.size.width - 20, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.size.height)! - 47 - 88)
            }
            //
            self.backgroundViewSelection.alpha = 0
            //
        }, completion: { finished in
            for i in self.selectionView.subviews {
                i.removeFromSuperview()
            }
            //
            self.selectionView.removeFromSuperview()
            self.backgroundViewSelection.removeFromSuperview()
        })
        //
    }
    
    //
    // MARK: Walkthrough ------------------------------------------------------------------------------------------------------------------
    //
    //
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabel = UILabel()
    var nextButton = UIButton()
    
    var didSetWalkthrough = false
    
    //
    // Components
    var walkthroughTexts = ["automaticYoga0", "automaticYoga1", "automaticYoga2"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    // Walkthrough
    func walkthroughAutomaticYoga() {
        
        //
        if didSetWalkthrough == false {
            //
            nextButton.addTarget(self, action: #selector(walkthroughAutomaticYoga), for: .touchUpInside)
            walkthroughView = setWalkthrough(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, nextButton: nextButton)
            didSetWalkthrough = true
        }
        
        //
        switch walkthroughProgress {
            // First has to be done differently
        // Walkthrough explanation
        case 0:
            //
            walkthroughLabel.text = NSLocalizedString(walkthroughTexts[walkthroughProgress], comment: "")
            walkthroughLabel.sizeToFit()
            walkthroughLabel.frame = CGRect(x: 13, y: view.frame.maxY - walkthroughLabel.frame.size.height - 13, width: view.frame.size.width - 26, height: walkthroughLabel.frame.size.height)
            
            // Colour
            walkthroughLabel.textColor = colour1
            walkthroughLabel.backgroundColor = colour2
            walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = colour2.cgColor
            // Highlight
            walkthroughHighlight.frame.size = CGSize(width: 225, height: 47 * 2)
            let homepageMaxY = TopBarHeights.combinedHeight + (47 * 2) + 44
            walkthroughHighlight.center = CGPoint(x: (225 / 2) + 7.5, y: homepageMaxY)
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 4
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = colour2.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Transition time
        case 1:
            //
            highlightSize = CGSize(width: 175, height: 47 * 2)
            let homepageMaxY = TopBarHeights.combinedHeight + (47 * 3) + (44 * 2)
            highlightCenter = CGPoint(x: (175 / 2) + 7.5, y: homepageMaxY)
            highlightCornerRadius = 2
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = colour2
            walkthroughTextColor = colour1
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Transition indicator
        case 2:
            //
            highlightSize = CGSize(width: 200, height: 47 * 2)
            let homepageMaxY = TopBarHeights.combinedHeight + (47 * 4) + (44 * 3)
            highlightCenter = CGPoint(x: (200 / 2) + 7.5, y: homepageMaxY)
            highlightCornerRadius = 2
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = colour2
            walkthroughTextColor = colour1
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1

            
        //
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.walkthroughView.alpha = 0
            }, completion: { finished in
                self.walkthroughView.removeFromSuperview()
                var walkthroughs = UserDefaults.standard.array(forKey: "walkthroughs") as! [Bool]
                walkthroughs[12] = true
                UserDefaults.standard.set(walkthroughs, forKey: "walkthroughs")
            })
        }
    }
    

}
