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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customTable.reloadData()
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation
        setupNavigationBar(navBar: navigationBar, title: NSLocalizedString("meditationTimer", comment: ""), separator: true, tintColor: Colors.dark, textColor: Colors.light, font: Fonts.navigationBar!, shadow: true)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMeditationChoiceCell", for: indexPath) as! CustomMeditationChoiceCell
        cell.backgroundColor = Colors.light
        
        // Retreive Preset Sessions
        let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
        cell.nameLabel?.text = meditationArray[indexPath.row]["Name"]![0][0] as? String
        
        // Duration
        let hmsArray = convertToHMS(row: indexPath.row)
        let nameArray = ["h ", "m ", "s "]
        var duration = ""
        for i in 0..<hmsArray.count {
            if hmsArray[i] != 0 {
                duration += String(hmsArray[i]) + nameArray[i]
            }
        }
        cell.durationLabel.text = duration
//            String(hmsArray[0]) + "h " + String(hmsArray[1]) + "m " + String(hmsArray[2]) + "s"
//        cell.durationLabel.sizeToFit()
        
        //
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        
        let height = cell.backgroundSoundImageView.frame.height
        
        // Background Sound
        let chosenBackgroundSound = meditationArray[indexPath.row]["BackgroundSound"]?[0][0] as! Int
        // No background sound
        if chosenBackgroundSound == -1 {
            addNothingChosenSymbol(view: cell.backgroundSoundImageView, height: height)
        // Background sound
        } else {
            removeNothingChosenSymbol(view: cell.backgroundSoundImageView)
            cell.backgroundSoundImageView.image = backgroundSoundsImages[chosenBackgroundSound]
        }
        
        // Starting Bell
        let startingBell = meditationArray[indexPath.row]["Bells"]?.first![0] as! Int
        // No starting bell
        if startingBell == -1 {
            addNothingChosenSymbol(view: cell.startingImage, height: height)
        // Starting bell
        } else {
            removeNothingChosenSymbol(view: cell.startingImage)
            cell.startingImage.image = bellsImages[startingBell]
        }
        
//        // Interval Bells
//        var intervalBells = meditationArray[indexPath.row]["Bells"]
//        intervalBells?.removeFirst() // Remove starting bell
//        intervalBells?.removeLast() // Remove ending bell
//        let imageViewArray = [cell.intervalImage1]
////            , cell.intervalImage2, cell.intervalImage3]
//        let count = intervalBells?.count
//        // Bells
//        for i in 0..<imageViewArray.count {
//            if i < count! {
//                if let intervalBell = intervalBells?[i][0] as? Int, intervalBell != -1 {
//                    removeNothingChosenSymbol(view: imageViewArray[i]!)
//                    imageViewArray[i]?.image = bellsImages[intervalBell]
//                } else {
//                    addNothingChosenSymbol(view: imageViewArray[i]!, height: height)
//                }
//            } else {
//                addNothingChosenSymbol(view: imageViewArray[i]!, height: height)
//            }
//        }
        
        // Ending Bell
        let endingBell = meditationArray[indexPath.row]["Bells"]?.last![0] as! Int
        // No ending bell
        if endingBell == -1 {
            addNothingChosenSymbol(view: cell.endingImage, height: height)
        // Ending bell
        } else {
            removeNothingChosenSymbol(view: cell.endingImage)
            cell.endingImage.image = bellsImages[endingBell]
        }
        
        if indexPath.row != 0 {
            cell.startTitle.alpha = 0
            cell.endTitle.alpha = 0
            cell.backgroundTitle.alpha = 0
        }
 
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteSession), for: .touchUpInside)
        
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editSession), for: .touchUpInside)
        cell.editButtonBig.tag = indexPath.row
        cell.editButtonBig.addTarget(self, action: #selector(editSession), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: Cell helpers
    func convertToHMS(row: Int) -> [Int] {
        
        let meditationArray = UserDefaults.standard.object(forKey: "meditationTimer") as! [[String: [[Any]]]]
        var hmsArray: [Int] = []

        // Time in seconds (duration)
        // [1] = duration array
        let timeInSeconds = meditationArray[row]["Duration"]?[0][0] as! Int
        //
        let hours = Int(timeInSeconds / 3600)
        hmsArray.append(hours)
        //
        let minutes = Int((timeInSeconds % 3600) / 60)
        hmsArray.append(minutes)
        //
        let seconds = Int(timeInSeconds % 60)
        hmsArray.append(seconds)
        
        return hmsArray
    }
    
    func addNothingChosenSymbol(view: UIImageView, height: CGFloat) {
        
        removeNothingChosenSymbol(view: view)
        let imageHeight = view.frame.height
        
        let slash = UIView()
        slash.tag = 43
        slash.backgroundColor = Colors.dark
        let slashHeight = pow( ((pow(height,2) + pow(height,2))), (1/2)) * (1/3)
        slash.frame.size = CGSize(width: 1, height: slashHeight)
        slash.center = CGPoint(x: imageHeight/2, y: imageHeight/2)
        slash.transform = slash.transform.rotated(by: .pi/4)
        slash.alpha = 0.72
        view.addSubview(slash)
        
        let circle = UIView()
        circle.tag = 72
        circle.frame.size = CGSize(width: height/4, height: height/4)
        circle.center = CGPoint(x: imageHeight/2, y: imageHeight/2)
        circle.layer.borderWidth = 1
        circle.layer.borderColor = Colors.dark.cgColor
        circle.layer.cornerRadius = height/8
        circle.alpha = 0.72
        view.addSubview(circle)
    }
    
    func removeNothingChosenSymbol(view: UIImageView) {
        
        for sub in view.subviews {
            if sub.tag == 43 || sub.tag == 72 {
                sub.removeFromSuperview()
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
        okAction = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: { UIAlertAction in
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
            newSession["Name"]![0][0] = (textField?.text)!
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
//            let destinationNC = segue.destination as? MeditationTimerNavigation
//            let destinationVC = destinationNC?.viewControllers.first as? MeditationTimerEditing
//            destinationVC?.creatingMeditation = creatingMeditation
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
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var backgroundSoundImageView: UIImageView!
    @IBOutlet weak var startingImage: UIImageView!
//    @IBOutlet weak var intervalImage1: UIImageView!
    @IBOutlet weak var endingImage: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var editButtonBig: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteImage: UIImageView!
//
//    @IBOutlet weak var constraint1: NSLayoutConstraint!
//    @IBOutlet weak var constraint2: NSLayoutConstraint!
////    @IBOutlet weak var constraint3: NSLayoutConstraint!
////    @IBOutlet weak var constraint4: NSLayoutConstraint!
    @IBOutlet weak var startTitle: UILabel!
    @IBOutlet weak var endTitle: UILabel!
    @IBOutlet weak var backgroundTitle: UILabel!
    //
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
        
        durationLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        durationLabel.textColor = Colors.dark
        
//        // Iphone 5/SE layout, smaller text for endurance
//        if IPhoneType.shared.iPhoneType() == 0 {
//            constraint1.constant = 12
//            constraint2.constant = 12
//            constraint3.constant = 6
//            constraint4.constant = 6
//        }
    }
}
