//
//  ProfileDetail.swift
//  MindAndBody
//
//  Created by Luke Smith on 10.09.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class ProfileDetail: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //
    // Outlets --------------------------------------------------------------------------------------------------------
    //
    @IBOutlet weak var navigationBar: UINavigationItem!
    //
    @IBOutlet weak var questionsTable: UITableView!
    //
    var answerTable = UITableView()
    //
    // Answer elements
    var selectedQuestion = Int()
    var answerView = UIView()
    var answerPicker = UIPickerView()
    var okButton = UIButton()
    var backgroundViewExpanded = UIButton()
    
    // Selected section (Goal/Me/Time/Preferences)
    var selectedSection = Int()
    
    // Arrays
    var titleArray: [String] = ["me", "goals", "time", "preferences"]
    //
    var questionArray: [[String]] =
        [
            // Me
            ["This is a question about me", "This also is a question", "Hmm, tricky question", "Obvious question"],
            // Goals
            ["This is a question about goals", "This also is a question", "Hmm, tricky question", "Obvious question"],
            // Time
            ["This is a question about time", "This also is a question", "Hmm, tricky question", "Obvious question"],
            // Preferences
            ["This is a question about goals", "This also is a question", "Hmm, tricky question", "Obvious question"]
        ]
    // 
    var answerArray: [[[String]]] =
        [
            // Me
            [
                // Q1
                ["Possible Answer", "Also a possible answer", "Could be", "Definitely not"],
                // Q2
                ["Possible Answer2", "Also a possible answer", "Could be", "Definitely not"],
                // Q3
                ["Possible Answer3", "Also a possible answer", "Could be", "Definitely not"],
                // Q4
                ["Possible Answer4", "Also a possible answer", "Could be", "Definitely not"]
            ],
            // Goals
            [
                // Q1
                ["Possible Answer", "Also a possible answer", "Could be", "Definitely not"],
                // Q2
                ["Possible Answer2", "Also a possible answer", "Could be", "Definitely not"],
                // Q3
                ["Possible Answer3", "Also a possible answer", "Could be", "Definitely not"],
                // Q4
                ["Possible Answer4", "Also a possible answer", "Could be", "Definitely not"]
            ],
            // Time
            [
                // Q1
                ["Possible Answer", "Also a possible answer", "Could be", "Definitely not"],
                // Q2
                ["Possible Answer2", "Also a possible answer", "Could be", "Definitely not"],
                // Q3
                ["Possible Answer3", "Also a possible answer", "Could be", "Definitely not"],
                // Q4
                ["Possible Answer4", "Also a possible answer", "Could be", "Definitely not"]
            ],
            // Preferences
            [
                // Q1
                ["Possible Answer", "Also a possible answer", "Could be", "Definitely not"],
                // Q2
                ["Possible Answer2", "Also a possible answer", "Could be", "Definitely not"],
                // Q3
                ["Possible Answer3", "Also a possible answer", "Could be", "Definitely not"],
                // Q4
                ["Possible Answer4", "Also a possible answer", "Could be", "Definitely not"]
            ],
    ]
    //
    var selectedAnswerArray: [[Int]] =
        [
            // Me
            [-1, -1, -1, -1],
            // Goals
            [-1, -1, -1, -1],
            // Time
            [-1, -1, -1, -1],
            // Preferences
            [-1, -1, -1, -1]
    ]

    
    //
    // Viewdidload --------------------------------------------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        
        // Navigation Bar Title
        navigationBar.title = (NSLocalizedString(titleArray[selectedSection], comment: ""))
        
        // Table View
        questionsTable.tableFooterView = UIView()
        questionsTable.separatorStyle = .none
        
        // Answer Elements
        // view
        answerView.backgroundColor = colour2
        answerView.layer.cornerRadius = 15
        answerView.layer.masksToBounds = true
        answerView.frame.size = CGSize(width: view.bounds.width - 20, height: 147 + 49)
        // picker
        answerPicker.backgroundColor = colour2
        answerPicker.delegate = self
        answerPicker.dataSource = self
        answerPicker.frame = CGRect(x: 0, y: 0, width: answerView.bounds.width, height: 147)
        // ok
        okButton.backgroundColor = colour1
        okButton.setTitleColor(colour3, for: .normal)
        okButton.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        okButton.titleLabel?.font = UIFont(name: "SFUIDisplay-light", size: 23)
        okButton.addTarget(self, action: #selector(okButtonAction(_:)), for: .touchUpInside)
        okButton.frame = CGRect(x: 0, y: 147, width: answerView.bounds.width, height: 49)
        //
        answerView.addSubview(answerPicker)
        answerView.addSubview(okButton)
        //
        // Background View
        backgroundViewExpanded.backgroundColor = .black
        backgroundViewExpanded.addTarget(self, action: #selector(backgroundViewExpandedAction(_:)), for: .touchUpInside)
        //

        
    }
    
    
    
    
    //
    // Table View --------------------------------------------------------------------------------------------------------
    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionArray.count
    }
    
    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //
        return NSLocalizedString(questionArray[selectedSection][section], comment: "")
    }
    
    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-light", size: 22)!
        header.textLabel?.textColor = colour2
        header.textLabel?.text = header.textLabel?.text?.capitalized
        
        //
        header.backgroundColor = .clear
        header.backgroundView = UIView()
        
        let seperator = CALayer()
        seperator.frame = CGRect(x: 15, y: header.frame.size.height - 1, width: view.frame.size.width, height: 1)
        seperator.backgroundColor = colour2.cgColor
        seperator.opacity = 0.5
        header.layer.addSublayer(seperator)
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }

    
    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return 1
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        return 47
    }
    
    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //
//        switch indexPath.row {
        //
//        default:
            //
            cell.backgroundColor = .clear
            cell.backgroundView = UIView()
            //
        if selectedAnswerArray[selectedSection][indexPath.section] == -1 {
            cell.textLabel?.text = "Answer"
        } else {
            cell.textLabel?.text = answerArray[selectedSection][indexPath.row][selectedAnswerArray[selectedSection][indexPath.section]]
        }
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            cell.textLabel?.textAlignment = .left
            cell.textLabel? .textColor = colour2
            //
            // Border
//        }
        //
        return cell
    }
    
    
    // didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        switch indexPath.row {
//        case 4:
//            break
//        default:
//            // Selected section
//        }
        //
        selectedQuestion = indexPath.section
        switch selectedAnswerArray[selectedSection][selectedQuestion] {
        case -1:
            answerPicker.selectRow(0, inComponent: 0, animated: true)
        default:
            answerPicker.selectRow(selectedAnswerArray[selectedSection][selectedQuestion], inComponent: 0, animated: true)
            
        }
        //
        UIApplication.shared.keyWindow?.insertSubview(answerView, aboveSubview: view)
        UIApplication.shared.keyWindow?.insertSubview(backgroundViewExpanded, belowSubview: answerView)
        animateActionSheetUp(actionSheet: answerView, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
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
        return answerArray[selectedSection][selectedQuestion].count
    }
    
    // View for row
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //
        let answerLabel = UILabel()
        answerLabel.text = NSLocalizedString(answerArray[selectedSection][selectedQuestion][row], comment: "")
        answerLabel.font = UIFont(name: "SFUIDisplay-light", size: 23)
        answerLabel.textColor = colour1
        //
        answerLabel.textAlignment = .center
        return answerLabel
        //
    }
    
    // Row height
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 37
    }
    
    // Did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
    
    
    // Background view expanded action
    // Add movement table background (dismiss table)
    func backgroundViewExpandedAction(_ sender: Any) {
        //
        animateActionSheetDown(actionSheet: answerView, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
    }

    // OK Button
    //
    // Ok button action
    func okButtonAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        //
//        var restTimes = UserDefaults.standard.object(forKey: "restTimes") as! [Int]
        //
//        restTimes[selectedRow] = restTimesArray[restTimePicker.selectedRow(inComponent: 0)]
//        defaults.set(restTimes, forKey: "restTimes")
        //
//        defaults.synchronize()
        selectedAnswerArray[selectedSection][selectedQuestion] = answerPicker.selectedRow(inComponent: 0)
        //
        animateActionSheetDown(actionSheet: answerView, actionSheetHeight: 147 + 49, backgroundView: backgroundViewExpanded)
        //
        questionsTable.reloadData()
    }

    
    
}
