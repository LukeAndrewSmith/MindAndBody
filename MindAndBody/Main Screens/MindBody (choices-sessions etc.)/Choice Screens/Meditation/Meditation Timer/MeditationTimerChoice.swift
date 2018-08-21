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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
