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
    let bellsArray: [String] = BellsFunctions.shared.bellsArray
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
    // settings["AutomaticYoga"]! = settings["AutomaticYoga"]!
    
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
        onOffSwitch.onTintColor = Colors.green
        onOffSwitch.tintColor = Colors.red
        onOffSwitch.backgroundColor = Colors.red
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
        tableViewBackground2.backgroundColor = Colors.dark
        tableViewBackground2.frame = CGRect(x: 0, y: 0, width: self.tableViewBells.frame.size.width, height: self.tableViewBells.frame.size.height)
        //
        tableViewBells.backgroundView = tableViewBackground2
        tableViewBells.tableFooterView = UIView()
        // TableView Cell action items
        //
        tableViewBells.backgroundColor = Colors.dark
        tableViewBells.delegate = self
        tableViewBells.dataSource = self
        tableViewBells.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        tableViewBells.layer.cornerRadius = 5
        tableViewBells.clipsToBounds = true
        //
        
        // Selection Items
        // view
        selectionView.backgroundColor = Colors.dark
        selectionView.layer.cornerRadius = 15
        selectionView.layer.masksToBounds = true
        
        //
        okButton.backgroundColor = Colors.light
        okButton.setTitleColor(Colors.green, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        //
        
        // Picker
        pickerView.backgroundColor = Colors.dark
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // indicator Label
        indicatorLabel.textAlignment = .center
        indicatorLabel.textColor = Colors.light
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
        offView.backgroundColor = Colors.dark
        offView.alpha = 0.5
        let yPosition = CGFloat(91)
        offView.frame = CGRect(x: 0, y: yPosition, width: self.view.frame.size.width, height: view.frame.size.height - yPosition)
        
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        // Retreive Presentation Style
        if settings["AutomaticYoga"]![0] == 0 {
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
            header.contentView.backgroundColor = Colors.light
            
        case tableViewBells:
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 17)!
            header.textLabel?.textColor = Colors.light
            header.contentView.backgroundColor = Colors.dark
            header.contentView.tintColor = Colors.light
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
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            
            //
            switch indexPath.section {
            case 0:
                cell.textLabel?.text = NSLocalizedString("on/off", comment: "")
                cell.selectionStyle = .none
                // Retreive Presentation Style
                if settings["AutomaticYoga"]![0] == 0 {
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
                    cell.detailTextLabel?.text = String(Double(settings["AutomaticYoga"]![1]) / 10) + "s"
                case 1:
                    //
                    cell.detailTextLabel?.text = String(settings["AutomaticYoga"]![2]) + "s"
                case 2:
                    //
                    if settings["AutomaticYoga"]![3] == -1 {
                        cell.detailTextLabel?.text = "-"
                    } else {
                        cell.detailTextLabel?.text = NSLocalizedString(bellsArray[settings["AutomaticYoga"]![3]], comment: "")
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
            cell.backgroundColor = Colors.dark
            cell.textLabel?.textColor = Colors.light
            cell.tintColor = Colors.light
            
            //
            var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
            if didChangeTransitionIndicator == false {
                if settings["AutomaticYoga"]![3] != -1 {
                    selectedTransitionIndicator = settings["AutomaticYoga"]![3]
                }
            }
            //
            if indexPath.row == selectedTransitionIndicator {
                cell.textLabel?.textColor = Colors.green
                cell.accessoryType = .checkmark
                cell.tintColor = Colors.green
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
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        
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
                    let selectionWidth = ActionSheet.shared.actionWidth
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
                    // Time saved as time as double with 1 dp * 10 as saved as int, so divide by 10 to find the time stored
                    if let indexOfRow = timeArray.index(of: Double(settings["AutomaticYoga"]![1]) / 10) {
                        pickerView.selectRow(indexOfRow, inComponent: 0, animated: true)
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
                    let selectionWidth = ActionSheet.shared.actionWidth
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
                    // Select Rows
                    if let indexOfRow = transitionArray.index(of: settings["AutomaticYoga"]![2]) {
                        pickerView.selectRow(indexOfRow, inComponent: 0, animated: true)
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
                    let selectionWidth = ActionSheet.shared.actionWidth
                    let selectionHeight = ActionSheet.shared.actionTableHeight
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
                    var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
                    if settings["AutomaticYoga"]![3] != -1 {
                        let indexPath = IndexPath(row: settings["AutomaticYoga"]![3], section: 0)
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
        secondsLabel.textColor = Colors.light
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
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        //
        switch selectedItem {
            //
        // Breath Length
        case 0:
            //
            settings["AutomaticYoga"]![1] = Int(timeArray[pickerView.selectedRow(inComponent: 0)] * 10)
            defaults.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            //
            let indexPath = NSIndexPath(row: 0, section: 1)
            let cell = tableViewAutomatic.cellForRow(at: indexPath as IndexPath)
            cell?.detailTextLabel?.text = String(Double(settings["AutomaticYoga"]![1]) / 10) + "s"
            //
        // Transition time
        case 1:
            //
            settings["AutomaticYoga"]![2] = transitionArray[pickerView.selectedRow(inComponent: 0)]
            defaults.set(settings, forKey: "userSettings")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["userSettings"])
            //
            let indexPath = NSIndexPath(row: 1, section: 1)
            let cell = tableViewAutomatic.cellForRow(at: indexPath as IndexPath)
            cell?.detailTextLabel?.text = String(settings["AutomaticYoga"]![2]) + "s"
            //
        // Transition Indicator
        case 2:
            //
            if BellPlayer.shared.bellPlayer != nil {
                if (BellPlayer.shared.bellPlayer?.isPlaying)! {
                    BellPlayer.shared.bellPlayer?.stop()
                }
            }
            //
            settings["AutomaticYoga"]![3] = selectedTransitionIndicator
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
        
        ActionSheet.shared.animateActionSheetDown()
        //
    }
    
    //
    // MARK: Switch handlers
    @objc func valueChanged(_ sender: UISwitch) {
        // Timed sessions
        var settings = UserDefaults.standard.object(forKey: "userSettings") as! [String: [Int]]
        // off -> on
        if sender.isOn {
            //
            settings["AutomaticYoga"]![0] = 1
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
            let walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
            if walkthroughs["AutomaticYoga"] == false {
                walkthroughAutomaticYoga()
            }
            // on -> off
        } else {
            //
            settings["AutomaticYoga"]![0] = 0
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
            walkthroughLabel.textColor = Colors.light
            walkthroughLabel.backgroundColor = Colors.dark
            walkthroughHighlight.backgroundColor = Colors.dark.withAlphaComponent(0.5)
            walkthroughHighlight.layer.borderColor = Colors.dark.cgColor
            // Highlight
            let section = tableViewAutomatic.rect(forSection: 1)
            walkthroughHighlight.frame = CGRect(x: 8, y: section.minY + 47, width: view.bounds.width - 16, height: 44)
            walkthroughHighlight.center.y += TopBarHeights.combinedHeight
            walkthroughHighlight.layer.cornerRadius = walkthroughHighlight.bounds.height / 4
            
            //
            // Flash
            //
            UIView.animate(withDuration: 0.2, delay: 0.2, animations: {
                //
                self.walkthroughHighlight.backgroundColor = Colors.dark.withAlphaComponent(1)
            }, completion: {(finished: Bool) -> Void in
                UIView.animate(withDuration: 0.2, animations: {
                    //
                    self.walkthroughHighlight.backgroundColor = Colors.dark.withAlphaComponent(0.5)
                }, completion: nil)
            })
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Transition time
        case 1:
            //
            let section = tableViewAutomatic.rect(forSection: 1)
            highlightSize = CGSize(width: view.bounds.width - 22, height: 44)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: section.minY + 47 + 44 + 22)
            highlightCenter?.y += TopBarHeights.combinedHeight
            //
            highlightCornerRadius = 2
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
            //
            nextWalkthroughView(walkthroughView: walkthroughView, walkthroughLabel: walkthroughLabel, walkthroughHighlight: walkthroughHighlight, walkthroughTexts: walkthroughTexts, walkthroughLabelFrame: labelFrame, highlightSize: highlightSize!, highlightCenter: highlightCenter!, highlightCornerRadius: highlightCornerRadius, backgroundColor: walkthroughBackgroundColor, textColor: walkthroughTextColor, highlightColor: walkthroughBackgroundColor, animationTime: 0.4, walkthroughProgress: walkthroughProgress)
            
            //
            walkthroughProgress = self.walkthroughProgress + 1
            
            
        // Transition indicator
        case 2:
            //
            let section = tableViewAutomatic.rect(forSection: 1)
            highlightSize = CGSize(width: view.bounds.width - 22, height: 44)
            highlightCenter = CGPoint(x: view.bounds.width / 2, y: section.minY + 47 + 44 + 44 + 22)
            highlightCenter?.y += TopBarHeights.combinedHeight
            //
            highlightCornerRadius = 2
            //
            labelFrame = 0
            //
            walkthroughBackgroundColor = Colors.dark
            walkthroughTextColor = Colors.light
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
                var walkthroughs = UserDefaults.standard.object(forKey: "walkthroughs") as! [String: Bool]
                walkthroughs["AutomaticYoga"] = true
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

