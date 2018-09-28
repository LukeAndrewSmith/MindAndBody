//
//  SessionChoice.swift
//  MindAndBody
//
//  Created by Luke Smith on 25.09.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class SessionChoice: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var choiceTable: UITableView!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var sessionChoiceTable: UITableView!
    
    var cellHeight: CGFloat = 72 // 110 // 88 // 72
    let tableSpacing: CGFloat = 27
    let foregroundColor = Colors.dark
    var scheduleStyle = 0
    
    // Passed to finalChoiceChoice
    // 0 == warmup, 1 == session, 2 == stretching
    var selectedComponent = 0
    
    // Very silly variable used in choices of 'endurance' group - steady state, as there is a 'time choice' after 'warmup/stretching' choice, variable indicating which one was selected
    // 'warmup/stretching' choice usually last choice
    var steadyStateChoice = Int()
    
    // Walkthrough
    var walkthroughProgress = 0
    var walkthroughView = UIView()
    var walkthroughHighlight = UIView()
    var walkthroughLabelView = UIView()
    var walkthroughLabelTitle = UILabel()
    var walkthroughLabelSeparator = UIView()
    var walkthroughLabel = UILabel()
    var walkthroughNextButton = UIButton()
    var walkthroughBackButton = UIButton()
    var didSetWalkthrough = false
    //
    // Components
    var walkthroughTexts = ["schedule0", "schedule1", "schedule2", "schedule3", "schedule4", "schedule5", "schedule6"]
    var highlightSize: CGSize? = nil
    var highlightCenter: CGPoint? = nil
    // Corner radius, 0 = height / 2 && 1 = width / 2
    var highlightCornerRadius = 0
    var labelFrame = 0
    //
    var walkthroughBackgroundColor = UIColor()
    var walkthroughTextColor = UIColor()
    
    //
    var lessonsView = UIView()
    var lessonsBackground = UIButton()
    var isLessonsShowing = false // indicates if lessons view is presented
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupGroupImage()
        
    }
    
    func setupGroupImage() {

        let groupString: String = {
            if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.day.rawValue {
                return ScheduleVariables.shared.selectedSchedule!["schedule"]![ScheduleVariables.shared.selectedDay][ScheduleVariables.shared.selectedRows.initial]["group"] as! String
            } else {
                return ScheduleVariables.shared.weekArray[ScheduleVariables.shared.selectedRows.initial]["group"] as! String
            }
        }()
        // Image
        groupImage.image = groupString.groupImageFromString()
        groupImage.contentMode = .scaleAspectFill
        groupImage.clipsToBounds = true
    }
    
    
    // MARK: Schedule TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        calculateCellHeight()
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView()
        
        let title = sessionData.sortedGroups[ScheduleVariables.shared.selectedGroup]![ScheduleVariables.shared.choiceProgress][0]
        let titleLabel = UILabel()
        titleLabel.font = Fonts.scheduleTitle
        titleLabel.textColor = foregroundColor
        titleLabel.text = NSLocalizedString(title, comment: "")
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: cellHeight)
        
        // Title Underline
        let separator = CALayer()
        separator.frame = CGRect(x: view.bounds.width / 4, y: cellHeight - 1, width: view.bounds.width / 2, height: 1)
        separator.backgroundColor = foregroundColor.cgColor
        separator.opacity = 0.25
        header.layer.addSublayer(separator)
        
        // Question mark - explanation of choice
        if needsExplanation() {
            
            let explanationButton = UIButton()
            explanationButton.frame = CGRect(x: view.bounds.width * (3/4), y: 0, width: view.bounds.width / 4, height: cellHeight)
            explanationButton.setImage(#imageLiteral(resourceName: "QuestionMarkMenu"), for: .normal)
            explanationButton.tintColor = foregroundColor
            explanationButton.addTarget(self, action: #selector(presentExplanation), for: .touchUpInside)
            header.addSubview(explanationButton)
            
            let border = UIView()
            border.layer.borderWidth = 1
            border.layer.borderColor = foregroundColor.withAlphaComponent(0.13).cgColor
            border.layer.cornerRadius = 11
            border.frame.size = CGSize(width: 44, height: 44)
            border.center = explanationButton.center
            border.isUserInteractionEnabled = false
            header.addSubview(border)
        }
        
        return header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sessionData.sortedGroups[ScheduleVariables.shared.selectedGroup]![ScheduleVariables.shared.choiceProgress].count - 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        calculateCellHeight()
        return cellHeight
    }
    
    func calculateCellHeight() {
        // If too many choices, reduce size of cell
        if CGFloat((sessionData.sortedGroups[ScheduleVariables.shared.selectedGroup]![ScheduleVariables.shared.choiceProgress].count) * 72) > (sessionChoiceTable.bounds.height - groupImage.bounds.height) {
            let height = (sessionChoiceTable.bounds.height - groupImage.bounds.height) / CGFloat((sessionData.sortedGroups[ScheduleVariables.shared.selectedGroup]![ScheduleVariables.shared.choiceProgress]).count)
            cellHeight = height
            
        // Height 72
        } else {
            cellHeight = 72
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        calculateCellHeight()
        
        cell.tag = indexPath.row

        let choiceLabel = UILabel()
        choiceLabel.font = Fonts.scheduleCell
        choiceLabel.textColor = foregroundColor
        
        // indexPath.row + 1  as title included in array
        let groupString = sessionData.sortedGroups[ScheduleVariables.shared.selectedGroup]![ScheduleVariables.shared.choiceProgress][indexPath.row + 1]
        choiceLabel.text = NSLocalizedString(groupString, comment: "")
        choiceLabel.numberOfLines = 2
        choiceLabel.sizeToFit()
        choiceLabel.frame = CGRect(x: tableSpacing, y: 0, width: view.bounds.width - 54, height: cellHeight)
        cell.addSubview(choiceLabel)
        
        if isLastChoice() {
            
            // Checkmark box
            let checkBox = UIButton()
            checkBox.tag = indexPath.row
            // Use layer as not affected by cell highlight
            checkBox.layer.backgroundColor = UIColor.clear.cgColor
            checkBox.backgroundColor = .clear
            checkBox.layer.borderWidth = 1
            checkBox.layer.borderColor = foregroundColor.cgColor
            checkBox.layer.cornerRadius = 4
            checkBox.frame = CGRect(x: view.bounds.width - tableSpacing - 24.5, y: 0, width: 24.5, height: 24.5)
            checkBox.center.y = choiceLabel.center.y
            checkBox.addTarget(self, action: #selector(markAsCompleted(_:)), for: .touchUpInside)
            cell.addSubview(checkBox)
            
            // To make sure its easy to press the button
            let checkBoxExtraButton = UIButton()
            checkBoxExtraButton.tag = indexPath.row
            var height = 72
            if ScheduleVariables.shared.scheduleStyle == ScheduleStyle.week.rawValue && ScheduleVariables.shared.selectedGroup == .none {
                height = 49
            }
            checkBoxExtraButton.frame = CGRect(x: 0, y: 0, width: height, height: height)
            checkBoxExtraButton.center.x = checkBox.center.x
            checkBoxExtraButton.addTarget(self, action: #selector(markAsCompleted(_:)), for: .touchUpInside)
            cell.addSubview(checkBoxExtraButton)
            
            // CheckMark if completed
            if ScheduleVariables.shared.isComponentCompleted(row: indexPath.row) {
                checkButton(button: checkBox)
            }
        }

        cell.backgroundColor = .clear
        cell.backgroundView = UIView()

        return cell
    }
    
    // MARK: Helper
    func checkButton(button: UIButton) {
        button.setImage(#imageLiteral(resourceName: "CheckMark"), for: .normal)
        button.imageView?.tintColor = foregroundColor
        // Use layer as not affected by cell highlight
        button.layer.backgroundColor = Colors.green.cgColor
        button.backgroundColor = Colors.green
        button.layer.borderColor = Colors.green.cgColor
    }
    
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Silly highlighting issue
        // Highlight affects checkBox background colors, therefore find the button through the image, and set the background color to green if the border is green as implies that it is selected
        let cell = tableView.cellForRow(at: indexPath)
        for view in (cell?.subviews)! {
            if view is UIButton {
                if let image = (view as! UIButton).imageView?.image, image == #imageLiteral(resourceName: "CheckMark") {
                    view.backgroundColor = Colors.green
                }
            }
        }
    
        // Normal
        if !isLastChoice() {
            didSelectRowHandler(row: indexPath.row)
            
        // If last choice and not completed, do something
        } else if isLastChoice() && !ScheduleVariables.shared.isComponentCompleted(row: indexPath.row) {
            didSelectRowHandler(row: indexPath.row)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
