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
    var onOffSwitch = UISwitch()
    
    //
    // Arrays --------------------------------------------------------------------------------------------------
    //
    // Section Headers
    var sectionHeaderArray: [String] = [" ", "personalisation"]
    var personalisationArray: [String] = ["averageBreathLength", "transitionTime", "transitionIndicator"]
    
    
    // Bells Arrays
    let bellsArray: [String] =
        ["Tibetan Chimes", "Tibetan Singing Bowl (Low)", "Tibetan Singing Bowl (Low)(x4)", "Tibetan Singing Bowl (Low)(Singing)", "Tibetan Singing Bowl (High)", "Tibetan Singing Bowl (High)(x4)", "Tibetan Singing Bowl (High)(Singing)", "Australian Rain Stick", "Australian Rain Stick (x2)", "Australian Rain Stick (2 sticks)", "Wind Chimes", "Gambang (Wood)(Up)", "Gambang (Wood)(Down)", "Gambang (Metal)", "Indonesian Frog", "Cow Bell (Small)", "Cow Bell (Big)"]
    let bellsImages: [UIImage] =
        [#imageLiteral(resourceName: "Tibetan Chimes"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Wind Chimes"), #imageLiteral(resourceName: "Indonesian Xylophone Big"), #imageLiteral(resourceName: "Indonesian Xylophone Big"), #imageLiteral(resourceName: "Indonesian Xylophone Small"), #imageLiteral(resourceName: "Indonesian Frog"), #imageLiteral(resourceName: "Cow Bell"), #imageLiteral(resourceName: "Cow Bell Big")]
    
    //
    // Selection Items
    let selectionView = UIView()
    let okButton = UIButton()
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
        // Switch
        onOffSwitch.onTintColor = Colours.colour3
        onOffSwitch.tintColor = Colours.colour4
        onOffSwitch.backgroundColor = Colours.colour4
        onOffSwitch.layer.cornerRadius = onOffSwitch.bounds.height / 2
        onOffSwitch.clipsToBounds = true
        onOffSwitch.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
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
        tableViewBackground2.backgroundColor = Colours.colour2
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.tableViewBells.frame.size.width, height: self.tableViewBells.frame.size.height)
        //
        tableViewBells.backgroundView = tableViewBackground2
        tableViewBells.tableFooterView = UIView()
        // TableView Cell action items
        //
        tableViewBells.backgroundColor = Colours.colour2
        tableViewBells.delegate = self
        tableViewBells.dataSource = self
        tableViewBells.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewBells.layer.cornerRadius = 5
        tableViewBells.clipsToBounds = true
        //
        
        // Selection Items
        // view
        selectionView.backgroundColor = Colours.colour2
        selectionView.layer.cornerRadius = 15
        selectionView.layer.masksToBounds = true
        
        //
        okButton.backgroundColor = Colours.colour1
        okButton.setTitleColor(Colours.colour3, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        //
        
        // Picker
        pickerView.backgroundColor = Colours.colour2
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // indicator Label
        indicatorLabel.textAlignment = .center
        indicatorLabel.textColor = Colours.colour1
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
        offView.backgroundColor = Colours.colour2
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
        case tableViewAutomatic: return 2
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
            header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 17)!
            //
            header.contentView.backgroundColor = Colours.colour1
            
        case tableViewBells:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 17)!
            header.textLabel?.textColor = Colours.colour1
            header.contentView.backgroundColor = Colours.colour2
            header.contentView.tintColor = Colours.colour1
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
            if section == 0 {
                return 1
            } else {
                return personalisationArray.count
            }
        case tableViewBells:
            return bellsArray.count
        default: break
        }
        return 0
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        //
        switch tableView {
        case tableViewAutomatic:
            //
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
            //
            cell.detailTextLabel?.font = UIFont(name: "SFUIDisplay-light", size: 21)
            //
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            
            //
            switch indexPath.section {
            case 0:
                cell.textLabel?.text = NSLocalizedString("on/off", comment: "")
                cell.selectionStyle = .none
                // Retreive Presentation Style
                if settings[3][0] == 0 {
                    onOffSwitch.isOn = false
                } else {
                    onOffSwitch.isOn = true
                }
                // on off
                cell.addSubview(onOffSwitch)
                onOffSwitch.center = CGPoint(x: view.bounds.width - 16 - (onOffSwitch.bounds.width / 2), y: cell.bounds.height / 2)
                
            case 1:
                cell.textLabel?.text = NSLocalizedString(personalisationArray[indexPath.row], comment: "")
                switch indexPath.row {
                case 0:
                    //
                    if settings[3][1] == -1 {
                        cell.detailTextLabel?.text = "-"
                    } else {
                        cell.detailTextLabel?.text = String(timeArray[settings[3][1]]) + "s"
                    }
                case 1:
                    //
                    if settings[3][2] == -1 {
                        cell.detailTextLabel?.text = "-"
                    } else {
                        cell.detailTextLabel?.text = String(transitionArray[settings[3][2]]) + "s"
                    }
                case 2:
                    //
                    if settings[3][3] == -1 {
                        cell.detailTextLabel?.text = "-"
                    } else {
                        cell.detailTextLabel?.text = NSLocalizedString(bellsArray[settings[3][3]], comment: "")
                    }
                default: break
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
            cell.backgroundColor = Colours.colour2
            cell.textLabel?.textColor = Colours.colour1
            cell.tintColor = Colours.colour1
            
            //
            var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
            if didChangeTransitionIndicator == false {
                if settings[3][3] != -1 {
                    selectedTransitionIndicator = settings[3][3]
                }
            }
            //
            if indexPath.row == selectedTransitionIndicator {
                cell.textLabel?.textColor = Colours.colour3
                cell.accessoryType = .checkmark
                cell.tintColor = Colours.colour3
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
        //
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        
        //
        switch tableView {
        case tableViewAutomatic:
            //
            if indexPath.section == 1 {
                switch indexPath.row {
                // Breath Length
                case 0:
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
                    self.selectionView.frame = CGRect(x: 0, y: 0, width: selectionWidth, height: selectionHeight)
                    //
                    
                    ActionSheet.shared.setupActionSheet()
                    ActionSheet.shared.actionSheet.addSubview(selectionView)
                    let heightToAdd = selectionView.bounds.height
                    ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
                    ActionSheet.shared.resetCancelFrame()
                    ActionSheet.shared.animateActionSheetUp()
                    
                // Transition Time
                case 1:
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
                    //
                    self.selectionView.frame = CGRect(x: 0, y: 0, width: selectionWidth, height: selectionHeight)
                    //
                    
                    ActionSheet.shared.setupActionSheet()
                    ActionSheet.shared.actionSheet.addSubview(selectionView)
                    let heightToAdd = selectionView.bounds.height
                    ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
                    ActionSheet.shared.resetCancelFrame()
                    ActionSheet.shared.animateActionSheetUp()
                    
                    
                // Transition Indicator
                case 2:
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
                    self.selectionView.frame = CGRect(x: 0, y: 0, width: selectionWidth, height: selectionHeight)
                    //
                    // Scroll to row
                    var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
                    if settings[3][3] != -1 {
                        let indexPath = IndexPath(row: settings[3][3], section: 0)
                        tableViewBells.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                    //
                    
                    //
                    ActionSheet.shared.setupActionSheet()
                    ActionSheet.shared.actionSheet.addSubview(selectionView)
                    let heightToAdd = selectionView.bounds.height
                    ActionSheet.shared.actionSheet.frame.size = CGSize(width: ActionSheet.shared.actionSheet.bounds.width, height: ActionSheet.shared.actionSheet.bounds.height + heightToAdd)
                    ActionSheet.shared.resetCancelFrame()
                    ActionSheet.shared.animateActionSheetUp()
                
                //
                default: break
                }
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
                BellPlayer.shared.bellPlayer = bell
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
        secondsLabel.textColor = Colours.colour1
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
    
    // Ok button action
    @objc func okButtonAction(_ sender: Any) {
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
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            //
            let indexPath = NSIndexPath(row: 0, section: 1)
            let cell = tableViewAutomatic.cellForRow(at: indexPath as IndexPath)
            cell?.detailTextLabel?.text = String(timeArray[settings[3][1]]) + "s"
            //
        // Transition time
        case 1:
            //
            settings[3][2] = pickerView.selectedRow(inComponent: 0)
            defaults.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            //
            let indexPath = NSIndexPath(row: 1, section: 1)
            let cell = tableViewAutomatic.cellForRow(at: indexPath as IndexPath)
            cell?.detailTextLabel?.text = String(transitionArray[settings[3][2]]) + "s"
            //
        // Transition Indicator
        case 2:
            //
            if BellPlayer.shared.bellPlayer != nil {
                if BellPlayer.shared.bellPlayer.isPlaying == true {
                    BellPlayer.shared.bellPlayer.stop()
                }
            }
            //
            settings[3][3] = selectedTransitionIndicator
            //
            let indexPath = NSIndexPath(row: 2, section: 1)
            let cell = tableViewAutomatic.cellForRow(at: indexPath as IndexPath)
            cell?.detailTextLabel?.text = NSLocalizedString(bellsArray[selectedTransitionIndicator], comment: "")
            //
            defaults.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            //
            selectedTransitionIndicator = -1
        //
        default: break
        }
        //
        if settings[3][1] != -1 && settings[3][2] != -1 {
            navigationItem.hidesBackButton = false
        }
        
        ActionSheet.shared.animateActionSheetDown()
        //
    }
    
    //
    // MARK: Switch handlers
    @objc func valueChanged(_ sender: UISwitch) {
        // Timed sessions
        var settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        // off -> on
        if sender.isOn == true {
            //
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
                self.tableViewAutomatic.isScrollEnabled = true
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
            settings[3][0] = 0
            //
            navigationItem.hidesBackButton = false
            
            //
            //
            offView.alpha = 0
            view.insertSubview(offView, aboveSubview: tableViewAutomatic)
            //
            // Off view
            UIView.animate(withDuration: AnimationTimes.animationTime1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.offView.alpha = 0.5
            }, completion: { finished in
                self.tableViewAutomatic.isScrollEnabled = false
            })
        }
        //
        UserDefaults.standard.set(settings, forKey: "userSettings")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
        if sender.isOn == true {
            settings[2][0] = 0
        } else {
            settings[2][0] = 1
        }
        //
        UserDefaults.standard.set(settings, forKey: "userSettings")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
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
    @objc func walkthroughAutomaticYoga() {
        
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
            walkthroughLabel.textColor = Colours.colour1
            walkthroughLabel.backgroundColor = Colours.colour2
            walkthroughHighlight.backgroundColor = Colours.colour2.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colours.colour2.cgColor
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
                self.walkthroughHighlight.backgroundColor = Colours.colour2.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colours.colour2.withAlphaComponent(0.5)
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
            walkthroughBackgroundColor = Colours.colour2
            walkthroughTextColor = Colours.colour1
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
            walkthroughBackgroundColor = Colours.colour2
            walkthroughTextColor = Colours.colour1
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
                // Sync
                ICloudFunctions.shared.pushToICloud(toSync: ["walkthroughs"])
            })
        }
    }
    
    // QuestionMark, information needed, show walkthrough
    @IBAction func questionMarkButtonAciton(_ sender: Any) {
        walkthroughView.alpha = 1
        didSetWalkthrough = false
        walkthroughProgress = 0
        walkthroughAutomaticYoga()
    }
    
}

