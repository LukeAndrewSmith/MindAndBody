//
//  MeditationTimerChoice.swift
//  MindAndBody
//
//  Created by Luke Smith on 21.08.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class MeditationTimerChoice: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // scheduleMeditationSegueTimer
    // editMeditationSegue
    // meditationSegue
    
    var comingFromSchedule = false
    var creatingMeditation = false
    var selectedMeditation = 0
    
    let cellHeight: CGFloat = 88
    
    // Load
    var imageArray: [[UIImage]] = []
    
    // Outlets
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var customTable: UITableView!
    
    // Bells Arrays
    let bellsArray = BellsFunctions.shared.bellsArray
    let bellsImages: [UIImage] =
        [#imageLiteral(resourceName: "Tibetan Chimes"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Big"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Tibetan Bowl Small"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Australian Rain Stick"), #imageLiteral(resourceName: "Wind Chimes"), #imageLiteral(resourceName: "Indonesian Xylophone Big"), #imageLiteral(resourceName: "Indonesian Xylophone Big"), #imageLiteral(resourceName: "Indonesian Xylophone Small"), #imageLiteral(resourceName: "Indonesian Frog"), #imageLiteral(resourceName: "Cow Bell"), #imageLiteral(resourceName: "Cow Bell Big")]
    
    // Duration Array
    let durationTimeArray: [[Int]] =
        [
            [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
            [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 58, 59],
            [00, 10, 20, 30, 40, 50]
    ]
    
    
    // Background Sounds Array
    let backgroundSoundsArray: [String] =
        ["TestBackground"]
    let backgroundSoundsImages: [UIImage] =
        [#imageLiteral(resourceName: "water.png")]
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation
        navigationBar.title = NSLocalizedString("meditationTimer", comment: "")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.light, NSAttributedStringKey.font: Fonts.navigationBar]
        self.navigationController?.navigationBar.barTintColor = Colors.dark
        navigationBar.rightBarButtonItem?.tintColor = Colors.light
        
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
        let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
        return meditationArray.count
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMeditationChoiceCell", for: indexPath) as! CustomMeditationChoiceCell
        cell.backgroundColor = Colors.light
        
        // Retreive Preset Sessions
        let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
        cell.nameLabel?.text = meditationArray[indexPath.row]["Name"]![0][0] as? String
        //
        cell.layoutSubviews()
        
        // Images
        // Remove any images
        cell.imageStack.subviews.forEach({ $0.removeFromSuperview() })
        
        // Sizes
        let height = cell.imageStack.bounds.height
        let gap = CGFloat(4)
        //
//        let numberOfImages = imageArray[indexPath.row].count
//
//        // Add images
//        for i in 0..<numberOfImages {
//            let imageView = UIImageView()
//
//            imageView.image = imageArray[indexPath.row][i]
//
//            imageView.contentMode = .scaleAspectFit
//            imageView.frame.size = CGSize(width: height, height: height)
//            imageView.widthAnchor.constraint(equalToConstant: height).isActive = true
//            cell.imageStack.addArrangedSubview(imageView)
//        }
        
        var width2 = CGFloat()
//        width2 = (CGFloat(numberOfImages) * height) + (CGFloat(numberOfImages - 1) * gap)
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
        
        let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]

        selectedMeditation = indexPath.row
        // If something in the session, go to session
        if meditationArray[selectedMeditation]["Duration"]?[0].count != 0 && meditationArray[selectedMeditation]["Duration"]?[0][0] as! Int != 0 {
            self.performSegue(withIdentifier: "meditationSegue", sender: self)
            // Pop
            let delayInSeconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.perform(#selector(self.popToRootView), with: Any?.self, afterDelay: 0.5)
            }
        } else {
            //
            // Alert
            let inputTitle = NSLocalizedString("meditationBegin", comment: "")
            let inputMessage = NSLocalizedString("meditationBeginMessage", comment: "")
            //
            let alert = UIAlertController(title: inputTitle, message: inputMessage, preferredStyle: .alert)
            alert.view.tintColor = Colors.dark
            alert.setValue(NSAttributedString(string: inputTitle, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-Light", size: 20)!]), forKey: "attributedTitle")
            alert.setValue(NSAttributedString(string: inputMessage, attributes: [NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-thin", size: 17)!]), forKey: "attributedMessage")
            
            //
            okAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) {
                UIAlertAction in
            }
            alert.addAction(okAction)
            //
            self.present(alert, animated: true, completion: nil)
            //
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
        var meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]

        // Remove session
        meditationArray.remove(at: session)
        UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
        // Sync
        ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
        //
        customTable.reloadData()
    }
    
    @objc func editSession(sender: UIButton) {
        // Get session index
        let session = sender.tag
        
        selectedMeditation = session
        creatingMeditation = false
        
        performSegue(withIdentifier: "editMeditationSegue", sender: self)
    }
    
    // MARK:
    func fillImageArray() {
        
        var customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        
        let numberOfRows = customSessionsArray[SelectedSession.shared.selectedSession[0]]!.count
        
        imageArray = []
        for i in 0..<numberOfRows {
            imageArray.append([])
            for imageName in (customSessionsArray[SelectedSession.shared.selectedSession[0]]![i]["movements"]! as! [String]) {
                imageArray[i].append(getUncachedImage(named: (sessionData.movements[SelectedSession.shared.selectedSession[0]]![imageName]!["demonstration"]![0]))!)
            }
        }
    }
    
    // MARK: Create Session
    @IBAction func createSessionAction(_ sender: Any) {
        
        var meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]

        // Alert for title and Functions
        let inputTitle = NSLocalizedString("meditationInputTitle", comment: "")
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
            let textField = alert?.textFields![0]
            //
            // New empty session array
            var newSession = Register.meditationEmptySession
            // Update name
            newSession["Name"]![0].append((textField?.text)!)
            meditationArray.append(newSession)
            //
            UserDefaults.standard.set(meditationArray, forKey: "meditationTimer")
            // Sync
            ICloudFunctions.shared.pushToICloud(toSync: ["meditationTimer"])
            
            // Select new session
            let lastIndex = meditationArray.count - 1
            self.selectedMeditation = lastIndex
            
            // Reload
            self.customTable.reloadData()
            
            // Segue
            self.creatingMeditation = true
            self.performSegue(withIdentifier: "editMeditationSegue", sender: self)
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
    
    // MARK: Pass Arrays
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        let customSessionsArray = UserDefaults.standard.object(forKey: "customSessions") as! [String: [[String: [Any]]]]
        //
        switch segue.identifier {
        // Creating/Editing
        case "editMeditationSegue":
            let destinationNC = segue.destination as? MeditationTimerEditingNavigation
            let destinationVC = destinationNC?.viewControllers.first as? MeditationTimer
            // Indicate if creating or editing
            destinationVC?.creatingSession = creatingMeditation
            destinationVC?.selectedPreset = selectedMeditation
            // PAss arrays so only one instance is hardcoded
            destinationVC?.bellsArray = bellsArray
            destinationVC?.bellsImages = bellsImages
            destinationVC?.backgroundSoundsArray = backgroundSoundsArray
            destinationVC?.backgroundSoundsImages = backgroundSoundsImages
            destinationVC?.durationTimeArray = durationTimeArray
        // Session
        case "meditationSegue"?:
            //
            let destinationVC = segue.destination as! MeditationScreen
            //
            destinationVC.bellsArray = bellsArray
            destinationVC.backgroundSoundsArray = backgroundSoundsArray
            //
            destinationVC.selectedPreset = selectedMeditation
            //
            destinationVC.fromSchedule = comingFromSchedule
            
        default:
            break
        }
    }
    
}



// MARK: Custom Cell
class CustomMeditationChoiceCell: UITableViewCell {
    
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
