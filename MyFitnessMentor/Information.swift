//
//  MyTheory.swift
//  MyFitnessMentor
//
//  Created by Luke Smith on 05/10/16.
//  Copyright © 2016 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class Information: UITableViewController{
    
    
    
    struct Group2 {
        var name: String!
        
        init(name: String) {
            self.name = name
        }
    }
    
    var informationGroup = [Group2]()
    

    
    override func viewWillAppear(_ animated: Bool) {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
        self.tableView.backgroundView = backView
        
    }
    
    //
    // viewDidLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Alert
        let defaults = UserDefaults.standard
        defaults.register(defaults: ["alertInfo3" : false])
        
        if UserDefaults.standard.bool(forKey: "alertInfo3") == false {
            
            UserDefaults.standard.set(true, forKey: "alertInfo3")
            
            let alertInformation = UIAlertController(title: (NSLocalizedString("alertTitle3", comment: "")), message: (NSLocalizedString("alertMessage3", comment: "")), preferredStyle: UIAlertControllerStyle.alert)
            
            alertInformation.view.tintColor = .black
            
            alertInformation.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertInformation, animated: true, completion: nil)
        }

        
        
        //
        // Title
        self.navigationController?.navigationBar.topItem?.title = (NSLocalizedString("information", comment: ""))
        
    
        // Initialize the sections array
        informationGroup = [
            Group2(name: NSLocalizedString("myPreferencesHelp", comment: "")),
            Group2(name: NSLocalizedString("coreActivation", comment: "")),
            Group2(name: NSLocalizedString("trainingPhilosophy", comment: "")),
            Group2(name: NSLocalizedString("appFeatures", comment: ""))
            ]
            
            
        
}
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return " "
    }

    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
        return view
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return informationGroup.count
        default: return 0
        }
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // Calculate the real sub-section index and row index
        let row = getRowIndex(row: indexPath.row)
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
            cell.textLabel?.text = informationGroup[row].name
            cell.textLabel?.textAlignment = NSTextAlignment.left
            cell.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1.0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 19)
            return cell
       
}
    








//
// Helper Functions
//

func getRowIndex(row: NSInteger) -> Int {
    var index = row
    let indices = getHeaderIndices()
    
    for i in 0..<indices.count {
        if i == indices.count - 1 || row < indices[i + 1] {
            index -= indices[i]
            break
        }
    }
    
    return index
}

    
    func getHeaderIndices() -> [Int] {
        var index = 0
        var indices: [Int] = []
    
        indices.append(index)
        index += informationGroup.count + 1
        return indices

}








}
