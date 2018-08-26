//
//  FinalChoiceCustom.swift
//  MindAndBody
//
//  Created by Luke Smith on 18.08.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class CustomChoice: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var comingFromSchedule = false
    var creatingSession = false
    var selectedSession = 0
    
    let cellHeight: CGFloat = 88
    
    // Load
    var imageArray: [[UIImage]] = []
    
    // Outlets
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var customTable: UITableView!
    
    
    // Navigation bar titles
    let navigationBarTitles: [String: String] = [
        "warmup": "customWarmup",
        "workout": "customWorkout",
        "cardio": "customHIITCardioSession",
        "stretching": "customStretchingSession",
        "yoga": "customYogaPractice"
    ]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fillImageArray()
        customTable.reloadData()
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation
        navigationBar.title = NSLocalizedString(navigationBarTitles[SelectedSession.shared.selectedSession[0]]!, comment: "")
        navigationBar.rightBarButtonItem?.tintColor = Colors.light
        self.navigationController?.navigationBar.barTintColor = Colors.dark


        // Table View
        customTable.tableFooterView = UIView()
        customTable.dataSource = self
        customTable.delegate = self
        
    }
    
    // MARK: Table View
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        return customSessionsArray[SelectedSession.shared.selectedSession[0]]!.count
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSessionsChoiceCell", for: indexPath) as! CustomSessionsChoiceCell
        cell.backgroundColor = Colors.light

        // Retreive Preset Sessions
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        cell.nameLabel?.text = customSessionsArray[SelectedSession.shared.selectedSession[0]]![indexPath.row]["name"]![0] as? String
        //
        cell.layoutSubviews()
        
        // Images
        // Remove any images
        cell.imageStack.subviews.forEach({ $0.removeFromSuperview() })

        // Sizes
        let height = cell.imageStack.bounds.height
        let gap = CGFloat(4)
        //
        let numberOfImages = imageArray[indexPath.row].count

        // Add images
        for i in 0..<numberOfImages {
            let imageView = UIImageView()

            imageView.image = imageArray[indexPath.row][i]

            imageView.contentMode = .scaleAspectFit
            imageView.frame.size = CGSize(width: height, height: height)
            imageView.widthAnchor.constraint(equalToConstant: height).isActive = true
            cell.imageStack.addArrangedSubview(imageView)
        }

        var width2 = CGFloat()
        width2 = (CGFloat(numberOfImages) * height) + (CGFloat(numberOfImages - 1) * gap)
        cell.imageStack.spacing = gap
        cell.imageStack.frame = CGRect(x: 0, y: 0, width: width2, height: height)
        cell.imageScroll.contentSize = CGSize(width: width2, height: height)
        
        cell.imageStack.tag = indexPath.row
        cell.stackTap.addTarget(self, action: #selector(stackTapAction))
        cell.stackPress.addTarget(self, action: #selector(stackPressAction))
        cell.imageScroll.tag = indexPath.row
        cell.scrollTap.addTarget(self, action: #selector(stackTapAction))
        cell.scrollPress.addTarget(self, action: #selector(stackPressAction))
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteSession), for: .touchUpInside)
        
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editSession), for: .touchUpInside)
        cell.editButtonBig.tag = indexPath.row
        cell.editButtonBig.addTarget(self, action: #selector(editSession), for: .touchUpInside)
        
        return cell
    }
    
    @objc func stackTapAction(sender: UITapGestureRecognizer) {
        let index = IndexPath(row: (sender.view?.tag)!, section: 0)
        customTable.selectRow(at: index, animated: false, scrollPosition: .none)
        customTable.delegate?.tableView!(customTable, didSelectRowAt: index)
    }
    @objc func stackPressAction(sender: UILongPressGestureRecognizer) {
        let index = IndexPath(row: (sender.view?.tag)!, section: 0)
        let cell = customTable.cellForRow(at: index)
        if sender.state == .began {
            customTable.selectRow(at: index, animated: false, scrollPosition: .none)
        } else if sender.state == .changed {
            if !(cell?.frame.contains(sender.location(in: self.customTable)))! {
                customTable.deselectRow(at: index, animated: false)
            } else {
                customTable.selectRow(at: index, animated: false, scrollPosition: .none)
            }
        } else if sender.state == .ended {
            if (cell?.frame.contains(sender.location(in: self.customTable)))! {
                customTable.delegate?.tableView!(customTable, didSelectRowAt: index)
            }
        }
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        return cellHeight
    }
    
    //
    var okAction = UIAlertAction()
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        
        // If something in the session, go to session
        selectedSession = indexPath.row
        if customSessionsArray[SelectedSession.shared.selectedSession[0]]?[selectedSession]["movements"]?.count != 0 {
            // Segue
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup
            case "warmup":
                // Warmup uses stretching Screen
                performSegue(withIdentifier: "customSessionSegueStretching", sender: self)
            // Workout
            case "workout":
                // If circuit session
                if customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]!.count == 2 && customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![1] as! Int == -1 {
                    performSegue(withIdentifier: "customSessionSegueCircuit", sender: self)
                    // Normal session
                } else {
                    performSegue(withIdentifier: "customSessionSegue", sender: self)
                }
            // Cardio
            case "cardio":
                performSegue(withIdentifier: "customSessionSegueCardio", sender: self)
            // Stretching
            case "stretching":
                performSegue(withIdentifier: "customSessionSegueStretching", sender: self)
            // Yoga
            case "yoga":
                performSegue(withIdentifier: "customSessionSegueYoga", sender: self)
            default:
                break
            }

            // Return background to homescreen
            perform(#selector(popToRootView), with: Any?.self, afterDelay: 0.5)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // Pop to root view
    @objc func popToRootView() {
        _ = self.navigationController?.popToRootViewController(animated: false)
    }
    
    
    // Enable ok alert action func
    @objc func textChanged(_ sender: UITextField) {
        if sender.text == "" {
            okAction.isEnabled = false
        } else {
            okAction.isEnabled = true
        }
    }
    
    //
    // MARK: TableView Editing
    //
    // Can edit row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //
        return true
    }
    
    // Delete button title
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        //
        return NSLocalizedString("delete", comment: "")
    }
    
    // Commit editing style
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            deleteSessionAction(session: indexPath.row)
        }
    }
    
    @objc func deleteSession(sender: UIButton) {
        // Get session index
        let session = sender.tag
        
        // Alert
        let inputTitle = NSLocalizedString("areYouSureDelete", comment: "")
        let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 17)!]), forKey: "attributedTitle")
        
        // Ok action
        okAction = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { [weak alert] (_) in
            self.deleteSessionAction(session: session)
        })
        alert.addAction(okAction)
        
        // Cancel  action
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default) {UIAlertAction in}
        alert.addAction(cancelAction)
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }
    func deleteSessionAction(session: Int) {
        
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]

        // New array
        customSessionsArray[SelectedSession.shared.selectedSession[0]]!.remove(at: session)
        UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
        //
        fillImageArray()
        customTable.reloadData()
    }
    
    @objc func editSession(sender: UIButton) {
        // Get session index
        let session = sender.tag
        
        selectedSession = session
        creatingSession = false
        
        performSegue(withIdentifier: "sessionEditingSegue", sender: self)
    }
    
    // MARK:
    func fillImageArray() {

        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        
        let numberOfRows = customSessionsArray[SelectedSession.shared.selectedSession[0]]!.count
        
        imageArray = []
        for i in 0..<numberOfRows {
            imageArray.append([])
            for imageName in (customSessionsArray[SelectedSession.shared.selectedSession[0]]![i]["movements"]! as! [String]) {
                
                let movementImage = getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![imageName]!["demonstration"]![0]))!
                
                // Flip asymmetric images for yoga
                if SelectedSession.shared.selectedSession[0] == "yoga" {
                    // If asymmetric array contains image, flip image
                    if (sessionData.asymmetricMovements[SelectedSession.shared.selectedSession[0]]?.contains(imageName))! {
                        let flippedImage = UIImage(cgImage: movementImage.cgImage!, scale: movementImage.scale, orientation: .upMirrored)
                        imageArray[i].append(flippedImage)
                    } else {
                        imageArray[i].append(movementImage)
                    }
                    
                // Normal append
                } else {
                    imageArray[i].append(movementImage)
                }
            }
        }
    }
    
    // MARK: Create Session
    @IBAction func createSessionAction(_ sender: Any) {
        
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]

        // Alert for title and Functions
        let inputTitle = NSLocalizedString("sessionInputName", comment: "")
        //
        let alert = UIAlertController(title: inputTitle, message: "", preferredStyle: .alert)
        alert.view.tintColor = Colors.dark
        alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
        //2. Add the text field
        alert.addTextField { (textField: UITextField) in
            textField.text = ""
            textField.font = UIFont(name: "SFUIDisplay-light", size: 17)
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        }
        // 3. Get the value from the text field, and perform actions upon OK press
        okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, handler: { [weak alert] (_) in
            //
            // Append relevant (to SelectedSession.shared.selectedSession[0]) new array to customSessionsArray
            switch SelectedSession.shared.selectedSession[0] {
            // Warmup, Workout,
            case "warmup", "workout":
                customSessionsArray[SelectedSession.shared.selectedSession[0]]!.append(Register.emptySessionFour)
            case "cardio", "stretching", "yoga":
                customSessionsArray[SelectedSession.shared.selectedSession[0]]!.append(Register.emptySessionThree)
            //
            default:
                break
            }
            //
            // Update Title
            let textField = alert?.textFields![0]
            let lastIndex = (customSessionsArray[SelectedSession.shared.selectedSession[0]]?.count)! - 1
            let title = textField?.text!
            customSessionsArray[SelectedSession.shared.selectedSession[0]]![lastIndex]["name"]![0] = title as Any
            
            // Set
            UserDefaults.standard.set(customSessionsArray, forKey: "customSessions")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["customSessions"])
            
            // Select new session
            self.selectedSession = lastIndex

            // Reload
            self.fillImageArray()
            self.customTable.reloadData()
            
            // Segue
            self.creatingSession = true
            self.performSegue(withIdentifier: "sessionEditingSegue", sender: self)
        })
        okAction.isEnabled = false
        alert.addAction(okAction)
        // Cancel reset action
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
        }
        alert.addAction(cancelAction)
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    //
    // MARK: Pass Arrays
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        switch segue.identifier {
        // Creating/Editing
        case "sessionEditingSegue":
            let destinationNC = segue.destination as? CustomSessionEditingNavigation
            let destinationVC = destinationNC?.viewControllers.first as? EditingCustom
            // Indicate if creating or editing
            destinationVC?.creatingSession = creatingSession
            destinationVC?.selectedSession = selectedSession
        // Warmup / Stretching
        case "customSessionSegueStretching"?:
            // Warmup
            let destinationVC = segue.destination as! StretchingScreen
            destinationVC.fromCustom = true
            destinationVC.keyArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]! as! [String]
            if SelectedSession.shared.selectedSession[0] == "warmup" {
                destinationVC.setsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! as! [Int]
                destinationVC.repsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]! as! [String]
                // Stretching
            } else if SelectedSession.shared.selectedSession[0] == "stretching" {
                destinationVC.breathsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! as! [Int]
            }
            
            //
            destinationVC.fromSchedule = comingFromSchedule
            
        // Circuit Workout
        case "customSessionSegueCircuit"?:
            let destinationVC = segue.destination as! CircuitWorkoutScreen
            destinationVC.fromCustom = true
            //
            let numberOfRounds = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]![0] as! Int
            //
            // Key array needs to include n times the movements of a round
            let keyArray =  customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]! as! [String]
            var fullKeyArray: [String] = []
            for _ in 1...numberOfRounds {
                for i in 0..<keyArray.count {
                    fullKeyArray.append(keyArray[i])
                }
            }
            destinationVC.keyArray = fullKeyArray
            destinationVC.numberOfRounds = numberOfRounds
            destinationVC.repsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]! as! [String]
            //
            destinationVC.fromSchedule = comingFromSchedule
            
        // Normal Workout
        case "customSessionSegue"?:
            let destinationVC = segue.destination as! SessionScreen
            destinationVC.fromCustom = true
            destinationVC.keyArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]! as! [String]
            destinationVC.setsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! as! [Int]
            destinationVC.repsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["reps"]! as! [String]
            //
            destinationVC.fromSchedule = comingFromSchedule
            
        // Cardio
        case "customSessionSegueCardio"?:
            let destinationVC = segue.destination as! CardioScreen
            destinationVC.fromCustom = true
            destinationVC.keyArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]! as! [String]
            destinationVC.lengthArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! as! [Int]
            //
            destinationVC.fromSchedule = comingFromSchedule
            
        // Yoga
        case "customSessionSegueYoga"?:
            let destinationVC = segue.destination as! YogaScreen
            destinationVC.fromCustom = true
            destinationVC.keyArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["movements"]! as! [String]
            destinationVC.breathsArray = customSessionsArray[SelectedSession.shared.selectedSession[0]]![selectedSession]["setsBreathsTime"]! as! [Int]
            //
            destinationVC.fromSchedule = comingFromSchedule
            
        default:
            break
        }
    }
    
}

// MARK: Custom Cell
class CustomSessionsChoiceCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var editButtonBig: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var imageStack: UIStackView!
    @IBOutlet weak var imageScroll: UIScrollView!
    
    let stackTap = UITapGestureRecognizer()
    let stackPress = UILongPressGestureRecognizer()
    let scrollTap = UITapGestureRecognizer()
    let scrollPress = UILongPressGestureRecognizer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        editButton.setTitle(NSLocalizedString("edit", comment: ""), for: .normal)
        editButton.setTitleColor(Colors.dark, for: .normal)
        editButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 17)
        
        deleteButton.tintColor = Colors.red
        deleteImage.tintColor = Colors.red
        
        nameLabel.font = UIFont(name: "SFUIDisplay-regular", size: 27)
        nameLabel.textColor = Colors.dark
        nameLabel.adjustsFontSizeToFitWidth = true
        
        stackPress.minimumPressDuration = 0.1
        imageStack.addGestureRecognizer(stackTap)
        imageStack.addGestureRecognizer(stackPress)
        
        scrollPress.minimumPressDuration = 0.1
        imageScroll.addGestureRecognizer(scrollTap)
        imageScroll.addGestureRecognizer(scrollPress)
    }
}
