//
//  InfoCells.swift
//  MindAndBody
//
//  Created by Luke Smith on 20.11.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit


//
// Initial Title Cell
class InitialTitleCell: UITableViewCell {
    //
    @IBOutlet weak var subtitle: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        subtitle.text = NSLocalizedString("initialInfoSubtitle", comment: "")
    }
}

//
// Image Title Cell
class ImageTitleCell: UITableViewCell {
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var shadowView: UIView!
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        titleImage.contentMode = .scaleAspectFit
        //
        title.backgroundColor = Colours.colour1
        //
        shadowView.backgroundColor = Colours.colour1
        shadowView.layer.shadowColor = Colours.colour1.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 10
    }
}
