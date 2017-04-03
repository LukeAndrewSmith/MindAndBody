//
//  ClassicScreenFull2.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 09.03.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications



// Custom Cell
//
class OverviewTableViewCell: UITableViewCell {
    
    // Demonstration Image View
    @IBOutlet weak var demonstrationImageView: UIImageView!
    
    // Title Label
    @IBOutlet weak var movementLabel: UILabel!
    
    //
    @IBOutlet weak var setsRepsLabel: UILabel!
    
    
    // Button View
    @IBOutlet weak var buttonView: UIView!
    
}

class EndTableViewCell: UITableViewCell {
    
    // Title Label
    @IBOutlet weak var titleLabel: UILabel!
    
}


// View Controller
//
class ClassicScreenFull2: UITableViewController {
    
    
    // Initialize Arrays
    
    // Title
    var workoutTitle = String()
    
    // Workout Choice Movement Array
    var workoutMovementsArray: [[String]] = [[]]
    var workoutArray: [String] = []
    // Workout Choice Selected Array
    var workoutMovementsSelectedArray: [[Int]] = [[]]
    
    // Sets Array
    var setsArrayF: [[Int]] = []
    var setsArray: [Int] = []
    // Reps Array
    var repsArrayF: [[String]] = [[]]
    var repsArray: [String] = []
    // Weight Array
    var weightArrayF: [[Int]] = []
    var weightArray: [Int] = []
    // Demonstration Array
    var demonstrationArrayF: [[UIImage]] = [[]]
    var demonstrationArray: [UIImage] = []
    // Target Area Array
    var targetAreaArrayF =
        [
            // Legs (Quads)
            [#imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Quad")],
            // Legs (Hamstrings/Glutes)
            [#imageLiteral(resourceName: "Deadlift"),
             #imageLiteral(resourceName: "Deadlift"),
             #imageLiteral(resourceName: "Deadlift"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Rear Thigh"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Glute")],
            // Legs (General)
            [#imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat"),
             #imageLiteral(resourceName: "Squat")],
            
            // Pull (Back)
            [#imageLiteral(resourceName: "Back and Bicep"),
             #imageLiteral(resourceName: "Back and Bicep"),
             #imageLiteral(resourceName: "Back and Bicep"),
             #imageLiteral(resourceName: "Back and Bicep"),
             #imageLiteral(resourceName: "Back and Bicep"),
             #imageLiteral(resourceName: "Back, Bicep and Erector"),
             #imageLiteral(resourceName: "Back, Bicep and Erector"),
             #imageLiteral(resourceName: "Back, Bicep and Erector"),
             #imageLiteral(resourceName: "Back and Bicep"),
             #imageLiteral(resourceName: "Back and Bicep")],
            // Pull (Upper Back)
            [#imageLiteral(resourceName: "Upper Back and Shoulder"),
             #imageLiteral(resourceName: "Upper Back and Shoulder"),
             #imageLiteral(resourceName: "Upper Back and Shoulder"),
             #imageLiteral(resourceName: "Upper Back and Shoulder")],
            // Pull (Rear Delts)
            [#imageLiteral(resourceName: "Rear Delt")],
            // Pull (Traps)
            [#imageLiteral(resourceName: "Trap"),
             #imageLiteral(resourceName: "Trap")],
            // Pull (Biceps)
            [#imageLiteral(resourceName: "Bicep"),
             #imageLiteral(resourceName: "Bicep"),
             #imageLiteral(resourceName: "Bicep"),
             #imageLiteral(resourceName: "Bicep")],
            // Pull (Forearms)
            [#imageLiteral(resourceName: "Forearm"),
             #imageLiteral(resourceName: "Forearm"),
             #imageLiteral(resourceName: "Forearm")],
            
            // Push (Chest)
            [#imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
             #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
             #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
             #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
             #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
             #imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
             #imageLiteral(resourceName: "Pec and Front Delt"),
             #imageLiteral(resourceName: "Pec and Front Delt"),
             #imageLiteral(resourceName: "Pec and Front Delt")],
            // Push (Shoulders)
            [#imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Shoulder"),
             #imageLiteral(resourceName: "Shoulder")],
            // Push (Triceps)
            [#imageLiteral(resourceName: "Chest, Front Delt and Tricep"),
             #imageLiteral(resourceName: "Tricep"),
             #imageLiteral(resourceName: "Tricep"),
             #imageLiteral(resourceName: "Tricep"),
             #imageLiteral(resourceName: "Tricep")],
            
            // Calves
            [#imageLiteral(resourceName: "Calf"),
             #imageLiteral(resourceName: "Calf")],
            // Abs/Core
            [#imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core"),
             #imageLiteral(resourceName: "Core")]
    ]
    
    var targetAreaArray: [UIImage] = []
    // Explanation Array
    var explanationArrayF =
        [
            // Legs (Quads)
            ["squatE",
             "frontSquatE",
             "hackSquatE",
             "legPressE",
             "dumbellFrontSquatE",
             "legExtensionsE"],
            // Legs (Hamstrings/Glutes)
            ["deadliftE",
             "romanianDeadliftE",
             "dumbellRomanianDeadliftE",
             "weightedHipThrustE",
             "legCurlE",
             "oneLeggedDeadliftE",
             "gluteIsolationMachineE"],
            // Legs (General)
            ["lungeBarbellE",
             "lungeDumbellE",
             "bulgarianSplitSquatE",
             "stepUpE"],
            
            // Pull (Back)
            ["pullUpE",
             "pullDownE",
             "pullDownMachineE",
             "hammerStrengthPullDownE",
             "kneelingPullDownE",
             "bentOverRowBarbellE",
             "bentOverRowDumbellE",
             "tBarRowE",
             "rowMachineE",
             "hammerStrengthRowE"],
            // Pull (Upper Back)
            ["facePullE",
             "smithMachinePullUpE",
             "leaningBackPullDownE",
             "seatedMachineRowE"],
            // Pull (Rear Delts)
            ["bentOverBarbellRowE"],
            // Pull (Traps)
            ["shrugBarbellE",
             "shrugDumbellE"],
            // Pull (Biceps)
            ["hamerCurlE",
             "hammerCurlCableE",
             "cableCurlE",
             "curlE"],
            // Pull (Forearms)
            ["farmersCarryE",
             "reverseBarbellCurlE",
             "forearmCurlE"],
            
            // Push (Chest)
            ["pushUpE",
             "benchPressE",
             "benchPressDumbellE",
             "semiInclineDumbellPressE",
             "hammerStrengthPressE",
             "chestPressE",
             "platePressE",
             "barbellKneelingPressE",
             "cableFlyE"],
            // Push (Shoulders)
            ["standingShoulderPressBarbellE",
             "standingShoulderPressDumbellE",
             "lateralRaiseE",
             "frontRaiseE"],
            // Push (Triceps)
            ["ballPushUpE",
             "trianglePushUpE",
             "closeGripBenchE",
             "cableExtensionE",
             "ropeExtensionE"],
            
            // Calves
            ["standingCalfRaiseE",
             "seatedCalfRaiseE"],
            // Abs/Core
            ["hangingLegRaiseE",
             "hangingLegTwistE",
             "plankE",
             "sideLegDropE",
             "abRolloutE"]
    ]
    var explanationArray: [String] = []
    

    
    
    
    // Populate Arrays
    func populateArrays() {
        
        // Workout Array
        workoutArray = zip(workoutMovementsArray.flatMap{$0},workoutMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        // Sets Array
        setsArray = zip(setsArrayF.flatMap{$0},workoutMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        
        // Reps Array
        repsArray = zip(repsArrayF.flatMap{$0},workoutMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        // Weight Array
        weightArray = zip(weightArrayF.flatMap{$0},workoutMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        // Demonstration Array
        demonstrationArray = zip(demonstrationArrayF.flatMap{$0},workoutMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        
        // Target Area Array
        targetAreaArray = zip(targetAreaArrayF.flatMap{$0},workoutMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
        
        // Explanation Array
        explanationArray = zip(explanationArrayF.flatMap{$0},workoutMovementsSelectedArray.flatMap{$0}).filter{$1==1}.map{$0.0}
        
    }
    
    
    
    
    
    
    //
    // Outlets
    //
    
    // Navigation Bar
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    // Navigation Title
    let navigationTitle = UILabel()
    
    // Hide Screen
    @IBOutlet weak var hideScreen: UIBarButtonItem!
    
    
    
    
    
    
    // Colours
    let colour1 = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
    let colour2 = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    
        
    
    
    //
    // ViewDidLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Navigation Title
        navigationTitle.text = NSLocalizedString(workoutTitle, comment: "")
        
        // Navigation Title
        //
        navigationTitle.frame = (navigationController?.navigationItem.accessibilityFrame)!
        navigationTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 44)
        navigationTitle.center.x = self.view.center.x
        navigationTitle.textColor = colour1
        navigationTitle.font = UIFont(name: "SFUIDisplay-medium", size: 22)
        navigationTitle.backgroundColor = .clear
        navigationTitle.textAlignment = .center
        navigationTitle.adjustsFontSizeToFitWidth = true
        self.navigationController?.navigationBar.barTintColor = colour2
        
        self.navigationController?.navigationBar.topItem?.titleView = navigationTitle
        
        
        
        
        // Hide Screen
        hideScreen.tintColor = colour1
        
        
        
        
    
        // TableView Background
        let tableViewBackground = UIView()
            
        tableViewBackground.backgroundColor = colour2
        tableViewBackground.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height)
            
        tableView.backgroundView = tableViewBackground
        
        tableView.tableFooterView = UIView()

        
        
        
        
        
        
        
        
        
        
        // Create Arrays
        //
        populateArrays()
        
        
        
        
        
        
        // Buttons
        //
        fillButtonArray()

        
    }
    
    
    
    
    
    
    
//-----------------------------------------------------------------------------------------------------------------------------------------------------
    // Buttons
    
    
    // Button Array
    //
    var buttonArray = [[UIButton]]()
    
    //
    // Set Button Action
    var buttonNumber = [Int]()
    
    //
    // Generate Buttons
    //
    func createButton() -> UIButton {
        
        let setButton = UIButton()
        let widthHeight = NSLayoutConstraint(item: setButton, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: setButton, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        setButton.addConstraints([widthHeight])
        setButton.frame = CGRect(x: 0, y: 0, width: 42.875, height: 42.875)
        setButton.layer.borderWidth = 3
        setButton.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0).cgColor
        setButton.layer.cornerRadius = 21.4375
        setButton.addTarget(self, action: #selector(setButtonAction), for: .touchUpInside)
        setButton.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        setButton.isEnabled = false
        
        return setButton
    }
   
    
    
    
    // Set Button
    @IBAction func setButtonAction(sender: UIButton) {
        
        //
        // Rest Timer Notification
        //
        if #available(iOS 10.0, *) {
            
            let content = UNMutableNotificationContent()
            content.title = NSLocalizedString("restOver", comment: "")
            content.body = NSLocalizedString("nextSet", comment: "")
            content.sound = UNNotificationSound.default()
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
            let request = UNNotificationRequest(identifier: "restTimer", content: content, trigger: trigger)
            
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
        
        
        // indexPath.row
        let buttonRow = sender.tag
        
        buttonArray[buttonRow][buttonNumber[buttonRow]].isEnabled = false

        
        // Increase Button Number
        if self.setsArray[buttonRow] == 0 {
        } else {
            if self.buttonNumber[buttonRow] < self.setsArray[buttonRow] {
                self.buttonNumber[buttonRow] = self.buttonNumber[buttonRow] + 1

            }
        }
        
        // Enable After Delay
        let delayInSeconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            if self.setsArray[buttonRow] == 0 {
            } else {
                if self.buttonNumber[buttonRow] < self.setsArray[buttonRow] {
                    self.buttonArray[buttonRow][self.buttonNumber[buttonRow]].isEnabled = true
                }
            }
        }
        
        sender.isEnabled = false
        sender.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)

        
    }
    
  
    
    // Generate an Array of Arrays of Buttons
    //
    func fillButtonArray() {
        for i in 0...(setsArray.count - 1){
            //
            var buttonArray2 = [UIButton]()
            //
            for _ in 1...setsArray[i]{
                buttonArray2 += [createButton()]
                }
            //
            buttonArray += [buttonArray2]
            buttonNumber.append(0)
        }
        buttonArray[0][0].isEnabled = true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //
    // Table View
    //
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = colour1
        //
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return workoutArray.count
        case 1: return 1
        default: return 0
        }
       // return workoutArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as! OverviewTableViewCell

            
            
            // Clean
            //
            for v in cell.buttonView.subviews {
                v.removeFromSuperview()
            }
        
            // Cell
            //
            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            cell.tintColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            tableView.separatorInset = UIEdgeInsets(top: 0, left: (10 + cell.demonstrationImageView.frame.size.width), bottom: 0, right: 0)

        
        
            // Movement
            //
            cell.movementLabel.text = NSLocalizedString(workoutArray[indexPath.row], comment: "")
        
            cell.movementLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 21)
            cell.movementLabel?.textAlignment = .left
            cell.movementLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.movementLabel?.adjustsFontSizeToFitWidth = true
        
        
            // Set and Reps
            //
            cell.setsRepsLabel?.text = repsArray[indexPath.row]
            cell.setsRepsLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
            cell.setsRepsLabel?.textAlignment = .right
            cell.setsRepsLabel?.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
            cell.setsRepsLabel.adjustsFontSizeToFitWidth = true
            
            
            // Image
            //
            cell.demonstrationImageView.image = #imageLiteral(resourceName: "Test")
        
        
            
            
            
            
            //
            // Button Stuff
            //
            
            // Button Tag
            for b in buttonArray[indexPath.row] {
                b.tag = indexPath.row
            }
        
            // Set Button View
            //
            cell.buttonView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            
            // Stack View
            //
            let stackView = UIStackView(arrangedSubviews: buttonArray[indexPath.row])
        
        
            // Layout
            //
            let numberOfButtons = CGFloat(setsArray[indexPath.row])
            let xValue = ((cell.buttonView.frame.size.width - (numberOfButtons * 42.875)) / (numberOfButtons + 1))
            let yValue = (cell.buttonView.frame.size.height - 42.875) / 2
            let widthValue1 =
                (numberOfButtons - 1) * (cell.buttonView.frame.size.width - (numberOfButtons * 42.875))
            let widthValue2 = (widthValue1 / (numberOfButtons + 1)) + (numberOfButtons * 42.875)
            //
            stackView.frame = CGRect(x: xValue, y: yValue, width: widthValue2, height: 42.875)
            
            //
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            
            cell.buttonView.addSubview(stackView)
            
            
            
            
            // Set Buttons
            //
            // Disable pressed buttons
            let indexOfUnpressedButton = buttonNumber[indexPath.row]
            if indexOfUnpressedButton > 0 {
                for s in 0...indexOfUnpressedButton - 1 {
                    
                    buttonArray[indexPath.row][s].isEnabled = false
                    buttonArray[indexPath.row][s].backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
                    
                }
            }
            
            // Enable next unpressed button
            if indexOfUnpressedButton == setsArray[indexPath.row] {
                
            } else {
                buttonArray[indexPath.row][indexOfUnpressedButton].isEnabled = true
            }
            
            
            
            //
            //buttonArray[indexPath.row][0].isEnabled = true
            
            
            
            return cell
            
        //
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EndTableViewCell", for: indexPath) as! EndTableViewCell
            
            
            
            cell.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
            
            cell.separatorInset =  UIEdgeInsetsMake(0.0, 0.0, 0.0, -cell.bounds.size.width)
            
            cell.layer.borderWidth = 2
            cell.layer.borderColor = colour1.cgColor
            
            cell.titleLabel?.text = NSLocalizedString("end", comment: "")
            cell.titleLabel?.textColor = colour1
            cell.titleLabel?.textAlignment = .center
            
            return cell
            
        default: return UITableViewCell(style: .value1, reuseIdentifier: nil)

        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 108
        case 1: return 49
        default: return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.cellForRow(at: indexPath)
            
            performSegue(withIdentifier: "detailSegue", sender: nil)
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            
            
        //
        case 1:
            
            self.dismiss(animated: true)
            
//            // Alert View
//            let title = NSLocalizedString("resetWarning", comment: "")
//            let message = NSLocalizedString("resetWarningMessage", comment: "")
//            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            alert.view.tintColor = colour2
//            alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
//            
//            let paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.alignment = .justified
//            alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
//            
//            
//            // Action
//            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
//                UIAlertAction in
//                
//                UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
//                UserDefaults.standard.synchronize()
//                
//                // Alert View
//                let title = NSLocalizedString("resetTitle", comment: "")
//                let message = NSLocalizedString("resetMessage", comment: "")
//                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//                alert.view.tintColor = self.colour2
//                alert.setValue(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-medium", size: 20)!]), forKey: "attributedTitle")
//                
//                let paragraphStyle = NSMutableParagraphStyle()
//                paragraphStyle.alignment = .justified
//                alert.setValue(NSAttributedString(string: message, attributes: [NSFontAttributeName: UIFont(name: "SFUIDisplay-light", size: 18)!, NSParagraphStyleAttributeName: paragraphStyle]), forKey: "attributedMessage")
//                
//                self.present(alert, animated: true, completion: nil)
//                
//                
//            }
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) {
//                UIAlertAction in
//                
//            }
//            
//            alert.addAction(okAction)
//            alert.addAction(cancelAction)
//            
//            self.present(alert, animated: true, completion: nil)
//            
//            tableView.deselectRow(at: indexPath, animated: true)
            
        //
        default: break
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    //
    // Hide Screen
    //
    let hideScreenView = UIView()
    let blurEffectView = UIVisualEffectView()
    let hideLabel = UILabel()
    
    
    
    @IBAction func hideScreen(_ sender: Any) {
    
        
        // Hide Screen view
        let screenSize = UIScreen.main.bounds
        hideScreenView.frame.size = CGSize(width: screenSize.width, height: screenSize.height)
        hideScreenView.backgroundColor = .clear
        hideScreenView.clipsToBounds = true
        hideScreenView.alpha = 0
        
        // Blur
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView.effect = blurEffect
        blurEffectView.frame = hideScreenView.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hideScreenView.addSubview(blurEffectView)
        blurEffectView.alpha = 0
        
        
        
        
        
        // Double Tap
        let doubleTap = UITapGestureRecognizer()
        doubleTap.numberOfTapsRequired = 2
        doubleTap.addTarget(self, action: #selector(handleTap))
        hideScreenView.isUserInteractionEnabled = true
        hideScreenView.addGestureRecognizer(doubleTap)
        
        
        // Text
        hideLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width * 3/4, height: view.frame.size.height)
        hideLabel.center = hideScreenView.center
        hideLabel.textAlignment = .center
        hideLabel.numberOfLines = 0
        hideLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        hideLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        hideLabel.textColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.0)
        
        hideLabel.text = NSLocalizedString("hideScreen", comment: "")
        
        
        //
        hideScreenView.addSubview(hideLabel)
        UIApplication.shared.keyWindow?.insertSubview(hideScreenView, aboveSubview: view)
        //
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
            self.blurEffectView.alpha = 1
            self.hideScreenView.alpha = 1
        }, completion: nil)
    }
    
    
    
    @IBAction func handleTap(extraTap:UITapGestureRecognizer) {
        
        blurEffectView.removeFromSuperview()
        hideLabel.removeFromSuperview()
        
        hideScreenView.removeFromSuperview()
        
    }
    
    
    
    
    // Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            
            let destinationVC = segue.destination as! ClassicScreenFullDetail
    
            let indexPath = tableView.indexPathForSelectedRow
            let indexPathInt = Int((indexPath?.row)!)
            destinationVC.selectedMovement = indexPathInt
            
            
            destinationVC.workoutArray = workoutArray
            destinationVC.workoutMovementsSelectedArray = workoutMovementsSelectedArray
            destinationVC.setsArray = setsArray
            destinationVC.repsArray = repsArray
            destinationVC.weightArray = weightArray
            
            destinationVC.targetAreaArray = targetAreaArray
            destinationVC.explanationArray = explanationArray
            
            // Set Button
            destinationVC.buttonNumber = buttonNumber
            
            
            // Hide Back Button Text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
    
}
