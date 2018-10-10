//
//  InfoTables.swift
//  MindAndBody
//
//  Created by Luke Smith on 20.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

//
// MARK: Info Tables
class InfoTables {
    static var shared = InfoTables()
    private init () {}
    
    // Setup Table Func
    func setupTable(tableView: UITableView) {
        //
        tableView.backgroundColor = .clear
        tableView.backgroundView = UIView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    // Setup Image Cell
    // imageB: UIImage
    func setupImageCell3(cell: UITableViewCell, imageL: UIImage, imageM: UIImage, imageR: UIImage, infoWidth: CGFloat, rowHeight: CGFloat) {
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.clipsToBounds = true
        //
        let imageHeight = rowHeight - 16
        let imageWidth = imageHeight * (9/16)
        //
        let imageHeight2 = rowHeight - (16*2 + 8)
        let imageWidth2 = imageHeight2 * (9/16)
        //
        let imageCenter = infoWidth / 2
        //
        let middleImage = UIImageView()
        middleImage.frame = CGRect(x: imageCenter - (imageWidth / 2), y: rowHeight - imageHeight, width: imageWidth, height: imageHeight)
        middleImage.contentMode = .scaleAspectFit
        middleImage.image = imageM
        middleImage.backgroundColor = Colors.dark
        middleImage.layer.shadowColor = UIColor.black.cgColor
        middleImage.layer.shadowRadius = 8
        middleImage.layer.shadowOffset = CGSize.zero
        middleImage.layer.shadowOpacity = 0.72
        //
        let rightImage = UIImageView()
        rightImage.frame = CGRect(x: middleImage.frame.maxX - (imageWidth2 * (1/18)), y: rowHeight - imageHeight2, width: imageWidth2, height: imageHeight2)
        rightImage.contentMode = .scaleAspectFit
        rightImage.image = imageR
        rightImage.backgroundColor = Colors.dark
        rightImage.layer.shadowColor = UIColor.black.cgColor
        rightImage.layer.shadowRadius = 8
        rightImage.layer.shadowOffset = CGSize.zero
        rightImage.layer.shadowOpacity = 0.72
        //
        let leftImage = UIImageView()
        leftImage.frame = CGRect(x: middleImage.frame.minX - (imageWidth2 * (17/18)), y: rowHeight - imageHeight2, width: imageWidth2, height: imageHeight2)
        leftImage.contentMode = .scaleAspectFit
        leftImage.image = imageL
        leftImage.backgroundColor = Colors.dark
        leftImage.layer.shadowColor = UIColor.black.cgColor
        leftImage.layer.shadowRadius = 8
        leftImage.layer.shadowOffset = CGSize.zero
        leftImage.layer.shadowOpacity = 0.72
        //
        cell.addSubview(leftImage)
        cell.addSubview(rightImage)
        cell.addSubview(middleImage)
    }
    
    // Setup Image Cell
    func setupImageCell2(cell: UITableViewCell, imageL: UIImage, imageR: UIImage, infoWidth: CGFloat, rowHeight: CGFloat) {
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.clipsToBounds = true
        
        let imageHeight = rowHeight - 16
        let imageWidth = imageHeight * (9/16)
        //
        let imageHeight2 = rowHeight - (16*2 + 8)
        let imageWidth2 = imageHeight2 * (9/16)
        //
        let totalWidth = imageWidth + (imageWidth2 * (17/18))
        let leftGap = (infoWidth - totalWidth) / 2
        
        //
        let rightImage = UIImageView()
        rightImage.frame = CGRect(x: leftGap + (imageWidth2 * (17/18)), y: rowHeight - imageHeight, width: imageWidth, height: imageHeight)
        rightImage.contentMode = .scaleAspectFit
        rightImage.image = imageR
        rightImage.backgroundColor = Colors.dark
        rightImage.layer.shadowColor = UIColor.black.cgColor
        rightImage.layer.shadowRadius = 8
        rightImage.layer.shadowOffset = CGSize.zero
        rightImage.layer.shadowOpacity = 0.72
        //
        let leftImage = UIImageView()
        leftImage.frame = CGRect(x: leftGap, y: rowHeight - imageHeight2, width: imageWidth2, height: imageHeight2)
        leftImage.contentMode = .scaleAspectFit
        leftImage.image = imageL
        leftImage.backgroundColor = Colors.dark
        leftImage.layer.shadowColor = UIColor.black.cgColor
        leftImage.layer.shadowRadius = 8
        leftImage.layer.shadowOffset = CGSize.zero
        leftImage.layer.shadowOpacity = 0.72
        //
        cell.addSubview(leftImage)
        cell.addSubview(rightImage)
    }
    
    // Setup Title Cell
    func setupTitleCell(cell: UITableViewCell, title: String, infoWidth: CGFloat) {
        cell.backgroundColor = Colors.light
        cell.selectionStyle = .none
        //
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-regular", size: 30)
        cell.textLabel?.text = title
        //
        let separator = UIView()
        separator.backgroundColor = Colors.dark.withAlphaComponent(0.27)
        separator.frame = CGRect(x: 8, y: 43, width: infoWidth - 16, height: 1)
        cell.addSubview(separator)
    }
    
    // Setup Title Cell
    func setupTitleCellCentered(cell: UITableViewCell, title: String, infoWidth: CGFloat) {
        cell.backgroundColor = Colors.light
        cell.selectionStyle = .none
        //
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-regular", size: 30)
        cell.textLabel?.text = title
        cell.textLabel?.textAlignment = .center
        //
        let separator = UIView()
        separator.backgroundColor = Colors.dark.withAlphaComponent(0.27)
        separator.frame = CGRect(x: 8, y: 43, width: infoWidth - 16, height: 1)
        cell.addSubview(separator)
    }
    
    // Setup explanation cell
    func setupExplanationCell(cell: UITableViewCell, explanation: String, infoWidth: CGFloat, cellHeight: CGFloat) {
        //
        cell.backgroundColor = Colors.light
        cell.selectionStyle = .none
        
        let explanationLabel = UILabel()
        explanationLabel.font = UIFont(name: "SFUIDisplay-light", size: 19)
        explanationLabel.numberOfLines = 0
        explanationLabel.lineBreakMode = .byWordWrapping
        explanationLabel.frame.size = CGSize(width: infoWidth - 32, height: 0)
        explanationLabel.text = explanation
        explanationLabel.sizeToFit()
        
        //
        let infoScroll = UIScrollView()
        infoScroll.frame = CGRect(x: 16, y: 8, width: infoWidth - 32, height: cellHeight - 16)
        infoScroll.backgroundColor = Colors.light
        infoScroll.addSubview(explanationLabel)
        infoScroll.contentSize = CGSize(width: infoWidth - 32, height: explanationLabel.bounds.height)
        infoScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        cell.addSubview(infoScroll)
    }
    
    // Setup explanation cell
    func setupExplanationCellBullets(cell: UITableViewCell, explanation: String, infoWidth: CGFloat, cellHeight: CGFloat) {
        //
        cell.backgroundColor = Colors.light
        cell.selectionStyle = .none
        
        let explanationLabel = UILabel()
        explanationLabel.font = UIFont(name: "SFUIDisplay-light", size: 19)
        explanationLabel.numberOfLines = 0
        explanationLabel.lineBreakMode = .byWordWrapping
        explanationLabel.frame.size = CGSize(width: infoWidth - 32, height: 0)
        explanationLabel.text = explanation
        explanationLabel.sizeToFit()
        
        //
        let infoScroll = UIScrollView()
        infoScroll.frame = CGRect(x: 16, y: 8, width: infoWidth - 32, height: cellHeight - 16)
        infoScroll.backgroundColor = Colors.light
        infoScroll.addSubview(explanationLabel)
        infoScroll.contentSize = CGSize(width: infoWidth - 32, height: explanationLabel.bounds.height)
        infoScroll.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        cell.addSubview(infoScroll)
    }
}

//
// MARK: Info Table 0 - Idea
class InfoTable0: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var infoTable: UITableView!
    
    //
    var row0Height = CGFloat()
    var explanationRowHeight = CGFloat()
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        view.backgroundColor = .clear
        InfoTables.shared.setupTable(tableView: infoTable)
        
        //
        row0Height = infoTable.bounds.height * (4/9)
        explanationRowHeight = infoTable.bounds.height - 8 - 44 - row0Height
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    // Rows
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return row0Height
        // Spcing cell
        case 1: return 8
        case 2: return 44
        case 3: return explanationRowHeight
        default: return 0
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.clipsToBounds = true
            // Image
            let titleImage = UIImageView()
            titleImage.frame.size = CGSize(width: infoTable.bounds.height / 3, height: infoTable.bounds.height * (1/3))
            titleImage.image = #imageLiteral(resourceName: "Loading").withRenderingMode(.alwaysTemplate)
            titleImage.tintColor = Colors.light
            titleImage.alpha = 0.72
            titleImage.contentMode = .scaleAspectFit
            titleImage.center = CGPoint(x: infoTable.bounds.width / 2, y: row0Height * (1/2))
//            cell.addSubview(titleImage)
            return cell
        case 2:
            let cell = UITableViewCell()
            InfoTables.shared.setupTitleCell(cell: cell, title: NSLocalizedString("Mind & Body", comment: ""), infoWidth: infoTable.bounds.width)
            return cell
        case 3:
            let cell = UITableViewCell()
            InfoTables.shared.setupExplanationCell(cell: cell, explanation: NSLocalizedString("infoTable1", comment: ""), infoWidth: infoTable.bounds.width, cellHeight: explanationRowHeight)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

//
// MARK: Info Table 1 - Schedule
class InfoTable1: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoTable: UITableView!
    
    //
    var row0Height = CGFloat()
    var explanationRowHeight = CGFloat()
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        view.backgroundColor = .clear
        InfoTables.shared.setupTable(tableView: infoTable)
        
        //
        row0Height = infoTable.bounds.height * (4/9)
        explanationRowHeight = infoTable.bounds.height - 8 - 44 - row0Height
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    // Rows
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return row0Height
        // Spcing cell
        case 1: return 8
        case 2: return 44
        case 3: return explanationRowHeight
        default: return 0
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell()
            InfoTables.shared.setupImageCell3(cell: cell, imageL: #imageLiteral(resourceName: "ScheduleCreator"), imageM: #imageLiteral(resourceName: "DayView"), imageR: #imageLiteral(resourceName: "ScheduleFinalChoice"), infoWidth: infoTable.bounds.width, rowHeight: row0Height)
            return cell
        case 2:
            let cell = UITableViewCell()
            InfoTables.shared.setupTitleCell(cell: cell, title: NSLocalizedString("schedule", comment: ""), infoWidth: infoTable.bounds.width)
            return cell
        case 3:
            let cell = UITableViewCell()
            InfoTables.shared.setupExplanationCell(cell: cell, explanation: NSLocalizedString("infoTable2", comment: ""), infoWidth: infoTable.bounds.width, cellHeight: explanationRowHeight)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

//
// MARK: Info Table 2 - Fitness
class InfoTable2: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoTable: UITableView!
    //
    var row0Height = CGFloat()
    var explanationRowHeight = CGFloat()
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        view.backgroundColor = .clear
        InfoTables.shared.setupTable(tableView: infoTable)
        
        
        //
        row0Height = infoTable.bounds.height * (4/9)
        explanationRowHeight = infoTable.bounds.height - 8 - 44 - row0Height
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    // Rows
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return row0Height
        case 1: return 8
        case 2: return 44
        case 3: return explanationRowHeight
        default: return 0
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell()
            InfoTables.shared.setupImageCell3(cell: cell, imageL: #imageLiteral(resourceName: "BodyweightWorkout"), imageM: #imageLiteral(resourceName: "ClassicWorkout"), imageR: #imageLiteral(resourceName: "EnduranceSession"), infoWidth: infoTable.bounds.width, rowHeight: row0Height)
            return cell
        case 2:
            let cell = UITableViewCell()
            InfoTables.shared.setupTitleCell(cell: cell, title: NSLocalizedString("fitness", comment: ""), infoWidth: infoTable.bounds.width)
            return cell
        case 3:
            let cell = UITableViewCell()
            InfoTables.shared.setupExplanationCell(cell: cell, explanation: NSLocalizedString("infoTable3", comment: ""), infoWidth: infoTable.bounds.width, cellHeight: explanationRowHeight)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

//
// MARK: Info Table 3 - Yoga
class InfoTable3: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoTable: UITableView!
    //
    var row0Height = CGFloat()
    var explanationRowHeight = CGFloat()
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //
        view.backgroundColor = .clear
        InfoTables.shared.setupTable(tableView: infoTable)
        
        
        //
        row0Height = infoTable.bounds.height * (4/9)
        explanationRowHeight = infoTable.bounds.height - 8 - 44 - row0Height
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    // Rows
    // Number of rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return row0Height
        case 1: return 8
        case 2: return 44
        case 3: return explanationRowHeight
        default: return 0
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell()
            InfoTables.shared.setupImageCell2(cell: cell, imageL: #imageLiteral(resourceName: "TimedYogaPractice"), imageR: #imageLiteral(resourceName: "YogaPractice"), infoWidth: infoTable.bounds.width, rowHeight: row0Height)
            return cell
        case 2:
            let cell = UITableViewCell()
            InfoTables.shared.setupTitleCell(cell: cell, title: NSLocalizedString("yoga", comment: ""), infoWidth: infoTable.bounds.width)
            return cell
        case 3:
            let cell = UITableViewCell()
            InfoTables.shared.setupExplanationCell(cell: cell, explanation: NSLocalizedString("infoTable4", comment: ""), infoWidth: infoTable.bounds.width, cellHeight: explanationRowHeight)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
    
    //
    // MARK: Info Table 4 - Meditation
    class InfoTable4: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        @IBOutlet weak var infoTable: UITableView!
        //
        var row0Height = CGFloat()
        var explanationRowHeight = CGFloat()
        //
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            //
            view.backgroundColor = .clear
            InfoTables.shared.setupTable(tableView: infoTable)
            //
            row0Height = infoTable.bounds.height * (4/9)
            explanationRowHeight = infoTable.bounds.height - 8 - 44 - row0Height
        }
        
        // Number of sections
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        // Header Height
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0
        }
        
        // Rows
        // Number of rows per section
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.row {
            case 0: return row0Height
            case 1: return 8
            case 2: return 44
            case 3: return explanationRowHeight
            default: return 0
            }
        }
        
        // Row cell customization
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.row {
            case 0:
                let cell = UITableViewCell()
                InfoTables.shared.setupImageCell3(cell: cell, imageL: #imageLiteral(resourceName: "GuidedMeditation"), imageM: #imageLiteral(resourceName: "MeditationTimer"), imageR: #imageLiteral(resourceName: "MeditationScreen"), infoWidth: infoTable.bounds.width, rowHeight: row0Height)
                return cell
            case 2:
                let cell = UITableViewCell()
                InfoTables.shared.setupTitleCell(cell: cell, title: NSLocalizedString("meditation", comment: ""), infoWidth: infoTable.bounds.width)
                return cell
            case 3:
                let cell = UITableViewCell()
                InfoTables.shared.setupExplanationCell(cell: cell, explanation: NSLocalizedString("infoTable5", comment: ""), infoWidth: infoTable.bounds.width, cellHeight: explanationRowHeight)
                return cell
            default:
                let cell = UITableViewCell()
                cell.backgroundColor = Colors.light
                cell.selectionStyle = .none
                //
                return cell
            }
        }
}
    
    //
    // MARK: Info Table 5 - Tracking
    class InfoTable5: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        @IBOutlet weak var infoTable: UITableView!
        //
        var row0Height = CGFloat()
        var explanationRowHeight = CGFloat()
        //
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            //
            view.backgroundColor = .clear
            InfoTables.shared.setupTable(tableView: infoTable)
            
            //
            row0Height = infoTable.bounds.height * (4/9)
            explanationRowHeight = infoTable.bounds.height - 8 - 44 - row0Height
        }
        
        // Number of sections
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        // Header Height
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0
        }
        
        // Rows
        // Number of rows per section
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.row {
            case 0: return row0Height
            case 1: return 8
            case 2: return 44
            case 3: return explanationRowHeight
            default: return 0
            }
        }
        
        // Row cell customization
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.row {
            case 0:
                let cell = UITableViewCell()
                InfoTables.shared.setupImageCell3(cell: cell, imageL: #imageLiteral(resourceName: "TrackingTimeScales"), imageM: #imageLiteral(resourceName: "MonthTracking"), imageR: #imageLiteral(resourceName: "WeekTracking"), infoWidth: infoTable.bounds.width, rowHeight: row0Height)
                return cell
            case 2:
                let cell = UITableViewCell()
                InfoTables.shared.setupTitleCell(cell: cell, title: NSLocalizedString("tracking", comment: ""), infoWidth: infoTable.bounds.width)
                return cell
            case 3:
                let cell = UITableViewCell()
                InfoTables.shared.setupExplanationCell(cell: cell, explanation: NSLocalizedString("infoTable6", comment: ""), infoWidth: infoTable.bounds.width, cellHeight: explanationRowHeight)
                return cell
            default:
                let cell = UITableViewCell()
                cell.backgroundColor = Colors.light
                cell.selectionStyle = .none
                //
                return cell
            }
        }
}
