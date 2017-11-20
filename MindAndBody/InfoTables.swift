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
    }
    
    // Setup Title Cell
    func setupTitleCell(cell: UITableViewCell, image: UIImage, title: String) {
        //
        cell.backgroundColor = Colours.colour1
        //
        let imageView = UIImageView()
        imageView.frame = cell.bounds
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        cell.addSubview(imageView)
        //
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "SFUIDisplay-bold", size: 27)
        titleLabel.sizeToFit()
        titleLabel.center = imageView.center
        cell.addSubview(titleLabel)
        //
    }
}

//
// MARK: Info Table 1
class InfoTable1: UITableViewController {
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        InfoTables.shared.setupTable(tableView: tableView)
        tableView.layer.borderWidth = 8
        tableView.layer.borderColor = Colours.colour1.cgColor
    }
    
    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // Header Height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    // Rows
    // Number of rows per section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return tableView.bounds.height * (4/9)
        case 1: return 100
        default: return 0
        }
        return 0
    }
    
    // Row cell customization
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InitialTitleCell", for: indexPath) as! InitialTitleCell
            cell.backgroundColor = .clear
            cell.backgroundView = UIView()
//            cell.backgroundColor = Colours.colour2
            return cell
        case 1:
            let cell = UITableViewCell()
            cell.backgroundColor = Colours.colour2
            return cell
        default: return UITableViewCell()
        }
    
    }

}

//
// MARK: Info Table 2
class InfoTable2: UITableViewController {
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        InfoTables.shared.setupTable(tableView: tableView)
        tableView.backgroundColor = Colours.colour1
        tableView.layer.borderColor = Colours.colour1.cgColor
        tableView.layer.borderWidth = 4
    }
    
    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // Header Height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    // Rows
    // Number of rows per section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return tableView.bounds.height * (5/12)
        case 1: return 100
        default: return 0
        }
        return 0
    }
    
    // Row cell customization
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTitleCell", for: indexPath) as! ImageTitleCell
            cell.backgroundColor = .clear
            //
            cell.titleImage.image = #imageLiteral(resourceName: "upwardDog.png")
            cell.titleImage.backgroundColor = Colours.colour2
            //
            cell.title.text = "Yoga"
            //
            cell.backgroundView = UIView()
            return cell
        case 1:
            let cell = UITableViewCell()
            cell.backgroundColor = Colours.colour1
            return cell
        default: return UITableViewCell()
        }
        
    }
    
}
