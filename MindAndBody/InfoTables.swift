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
        tableView.tableFooterView = UIView()
        tableView.layer.cornerRadius = 15
        tableView.clipsToBounds = true
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    // Setup Image Cell
    func setupImageCell(cell: UITableViewCell, image: UIImage, infoWidth: CGFloat, rowHeight: CGFloat) {
        cell.backgroundColor = Colours.colour2
        cell.selectionStyle = .none
        //
        let cellImage = UIImageView()
        cellImage.frame = CGRect(x: 0, y: 0, width: infoWidth, height: rowHeight)
        cellImage.contentMode = .scaleAspectFit
        cellImage.image = image
        cellImage.backgroundColor = Colours.colour2
        cell.addSubview(cellImage)
    }
    
    // Setup Title Cell
    func setupTitleCell(cell: UITableViewCell, title: String, infoWidth: CGFloat) {
        cell.backgroundColor = Colours.colour1
        cell.selectionStyle = .none
        //
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 30)
        cell.textLabel?.text = title
        //
        let separator = UIView()
        separator.backgroundColor = Colours.colour2.withAlphaComponent(0.27)
        separator.frame = CGRect(x: 8, y: 43, width: infoWidth - 16, height: 1)
        cell.addSubview(separator)
    }
}

//
// MARK: Info Table 1
class InfoTable1: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoTable: UITableView!
    
    //
    var row0Height = CGFloat()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        view.backgroundColor = .clear
        InfoTables.shared.setupTable(tableView: infoTable)
        infoTable.layer.borderWidth = 1
        infoTable.layer.borderColor = Colours.colour1.withAlphaComponent(0.27).cgColor
        //
        row0Height = infoTable.bounds.height * (1/3)
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
        case 3: return (infoTable.bounds.height * (2/3)) - 44
        default: return 0
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            //
            let aThirdRowHeight = row0Height * (1/3)
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            // Image
            let titleImage = UIImageView()
            titleImage.frame.size = CGSize(width: aThirdRowHeight, height: aThirdRowHeight)
            titleImage.image = #imageLiteral(resourceName: "Loading").withRenderingMode(.alwaysTemplate)
            titleImage.tintColor = Colours.colour1
            titleImage.alpha = 0.72
            titleImage.contentMode = .scaleAspectFit
            titleImage.center = CGPoint(x: cell.center.x, y: aThirdRowHeight * (7/8))
            cell.addSubview(titleImage)
            // Title
            let titleLabel = UILabel()
            titleLabel.frame.size = CGSize(width: infoTable.bounds.width, height: row0Height * (2/3))
            titleLabel.center = CGPoint(x: cell.center.x, y: ((aThirdRowHeight * 2) / 2) + aThirdRowHeight)
            titleLabel.text = "Mind & Body"
            titleLabel.font = UIFont(name: "SFUIDisplay-thin", size: 43)
            titleLabel.textColor = Colours.colour1
            titleLabel.textAlignment = .center
            cell.addSubview(titleLabel)
            //
            cell.backgroundColor = Colours.colour2
            return cell
        case 2:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 27)
            cell.textLabel?.text = "Fitness | Yoga | Meditation"
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = Colours.colour1
            //
            let separator = UIView()
            separator.backgroundColor = Colours.colour2.withAlphaComponent(0.27)
            separator.frame = CGRect(x: 8, y: 43, width: infoTable.bounds.width - 16, height: 1)
            cell.addSubview(separator)
            return cell
        case 3:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.backgroundColor = Colours.colour1
//            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
//            cell.textLabel?.text = NSLocalizedString("infoTable1", comment: "")
            let label = UILabel()
            label.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.text = NSLocalizedString("infoTable1", comment: "")
            label.frame.size = CGSize(width: infoTable.bounds.width - 32, height: 0)
            label.sizeToFit()
            label.frame = CGRect(x: 16, y: 8, width: label.bounds.width, height: label.bounds.height)
            cell.addSubview(label)
            return cell
        default:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.backgroundColor = Colours.colour1
            cell.selectionStyle = .none
            //
            return cell
        }
    }
}

//
// MARK: Info Table 2
class InfoTable2: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoTable: UITableView!
    
    //
    var row0Height = CGFloat()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        view.backgroundColor = .clear
        InfoTables.shared.setupTable(tableView: infoTable)
        infoTable.layer.borderColor = Colours.colour1.withAlphaComponent(0.27).cgColor
        infoTable.layer.borderWidth = 1
        infoTable.layer.borderWidth = 1
        infoTable.layer.borderColor = Colours.colour1.withAlphaComponent(0.27).cgColor
        //
        row0Height = infoTable.bounds.height * (1/3)
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
        case 3: return (infoTable.bounds.height * (2/3)) - 44
        default: return 0
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell()
            cell.backgroundColor = Colours.colour2
            cell.selectionStyle = .none
            cell.clipsToBounds = true
            //
            let imageWidth = infoTable.bounds.width * (4/9)
            let imageHeight = imageWidth * (16/9)
            //
            let rightImage = UIImageView()
            let imageWidth2 = infoTable.bounds.width * (1/3)
            //
            let imageCenter = infoTable.bounds.width / 2
            //
            let middleImage = UIImageView()
            middleImage.frame = CGRect(x: imageCenter - (imageWidth / 2), y: row0Height * (1/8), width: imageWidth, height: imageHeight)
            middleImage.contentMode = .scaleAspectFit
            middleImage.image = #imageLiteral(resourceName: "DayView")
            middleImage.backgroundColor = Colours.colour2
            middleImage.layer.shadowColor = UIColor.black.cgColor
            middleImage.layer.shadowRadius = 8
            middleImage.layer.shadowOffset = CGSize.zero
            middleImage.layer.shadowOpacity = 0.72
            //
            let imageHeight2 = imageWidth2 * (16/9)
            rightImage.frame = CGRect(x: middleImage.frame.maxX - (imageWidth2 * (1/3)), y: row0Height * (2/8), width: imageWidth2, height: imageHeight2)
            rightImage.contentMode = .scaleAspectFit
            rightImage.image = #imageLiteral(resourceName: "ScheduleFinalChoice")
            rightImage.backgroundColor = Colours.colour2
            rightImage.layer.shadowColor = UIColor.black.cgColor
            rightImage.layer.shadowRadius = 8
            rightImage.layer.shadowOffset = CGSize.zero
            rightImage.layer.shadowOpacity = 0.72
            //
            let leftImage = UIImageView()
            leftImage.frame = CGRect(x: middleImage.frame.minX - (imageWidth2 * (2/3)), y: row0Height * (2/8), width: imageWidth2, height: imageHeight2)
            leftImage.contentMode = .scaleAspectFit
            leftImage.image = #imageLiteral(resourceName: "ScheduleChoice")
            leftImage.backgroundColor = Colours.colour2
            leftImage.layer.shadowColor = UIColor.black.cgColor
            leftImage.layer.shadowRadius = 8
            leftImage.layer.shadowOffset = CGSize.zero
            leftImage.layer.shadowOpacity = 0.72
            //
            cell.addSubview(leftImage)
            cell.addSubview(rightImage)
            cell.addSubview(middleImage)
            //
            return cell
        case 2:
            let cell = UITableViewCell()
            InfoTables.shared.setupTitleCell(cell: cell, title: NSLocalizedString("schedule", comment: ""), infoWidth: infoTable.bounds.width)
            return cell
        case 3:
            let cell = UITableViewCell()
            cell.backgroundColor = Colours.colour1
            let label = UILabel()
            label.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.text = NSLocalizedString("infoTable2", comment: "")
            label.frame.size = CGSize(width: infoTable.bounds.width - 32, height: 0)
            label.sizeToFit()
            label.frame = CGRect(x: 16, y: 8, width: label.bounds.width, height: label.bounds.height)
            cell.addSubview(label)
            cell.selectionStyle = .none
            //
            return cell
        default:
            let cell = UITableViewCell()
            cell.backgroundColor = Colours.colour1
            cell.selectionStyle = .none
            //
            return cell
        }
    }
}

//
// MARK: Info Table 3
class InfoTable3: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoTable: UITableView!
    //
    var row0Height = CGFloat()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        view.backgroundColor = .clear
        InfoTables.shared.setupTable(tableView: infoTable)
        infoTable.backgroundColor = Colours.colour1
        infoTable.layer.borderWidth = 1
        infoTable.layer.borderColor = Colours.colour1.withAlphaComponent(0.27).cgColor
        //
        row0Height = infoTable.bounds.height * (1/3)
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
        case 3: return (infoTable.bounds.height * (2/3)) - 44
        default: return 0
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell()
            cell.backgroundColor = Colours.colour2
            cell.selectionStyle = .none
            //
            let cellImage = UIImageView()
            cellImage.frame = CGRect(x: 0, y: 0, width: infoTable.bounds.width, height: row0Height)
            cellImage.contentMode = .scaleAspectFit
            cellImage.image = #imageLiteral(resourceName: "upwardDog.png")
            cell.addSubview(cellImage)
            return cell
        case 2:
            let cell = UITableViewCell()
            InfoTables.shared.setupTitleCell(cell: cell, title: NSLocalizedString("plans", comment: ""), infoWidth: infoTable.bounds.width)
            return cell
        case 3:
            let cell = UITableViewCell()
            cell.backgroundColor = Colours.colour1
            let label = UILabel()
            label.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.text = NSLocalizedString("infoTable3", comment: "")
            label.frame.size = CGSize(width: infoTable.bounds.width - 32, height: 0)
            label.sizeToFit()
            label.frame = CGRect(x: 16, y: 8, width: label.bounds.width, height: label.bounds.height)
            cell.addSubview(label)
            cell.selectionStyle = .none
            //
            return cell
        default:
            let cell = UITableViewCell()
            cell.backgroundColor = Colours.colour1
            cell.selectionStyle = .none
            //
            return cell
        }
    }
}

//
// MARK: Info Table 4
class InfoTable4: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoTable: UITableView!
    //
    var row0Height = CGFloat()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        view.backgroundColor = .clear
        InfoTables.shared.setupTable(tableView: infoTable)
        infoTable.backgroundColor = Colours.colour1
        infoTable.layer.borderWidth = 1
        infoTable.layer.borderColor = Colours.colour1.withAlphaComponent(0.27).cgColor
        //
        row0Height = infoTable.bounds.height * (1/3)
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
        case 3: return (infoTable.bounds.height * (2/3)) - 44
        default: return 0
        }
    }
    
    // Row cell customization
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell()
            cell.backgroundColor = Colours.colour2
            let cellImage = UIImageView()
            cellImage.frame = CGRect(x: 0, y: 0, width: infoTable.bounds.width, height: row0Height)
            cellImage.contentMode = .scaleAspectFit
            cellImage.image = #imageLiteral(resourceName: "upwardDog.png")
            cell.addSubview(cellImage)
            return cell
        case 2:
            let cell = UITableViewCell()
            InfoTables.shared.setupTitleCell(cell: cell, title: NSLocalizedString("fitness", comment: ""), infoWidth: infoTable.bounds.width)
            return cell
        case 3:
            let cell = UITableViewCell()
            cell.backgroundColor = Colours.colour1
            let label = UILabel()
            label.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.text = NSLocalizedString("infoTable4", comment: "")
            label.frame.size = CGSize(width: infoTable.bounds.width - 32, height: 0)
            label.sizeToFit()
            label.frame = CGRect(x: 16, y: 8, width: label.bounds.width, height: label.bounds.height)
            cell.addSubview(label)
            cell.selectionStyle = .none
            //
            return cell
        default:
            let cell = UITableViewCell()
            cell.backgroundColor = Colours.colour1
            cell.selectionStyle = .none
            //
            return cell
        }
    }
}
