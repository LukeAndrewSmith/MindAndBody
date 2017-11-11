//
//  InitialInfoScreen.swift
//  MindAndBody
//
//  Created by Luke Smith on 15.10.17.
//  Copyright © 2017 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class InitialInfoScreen: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //
    // Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    //
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var topSeparator: UIView!
    @IBOutlet weak var infoTable: UITableView!
    
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var appButton: UIButton!
    
    
    //
    // MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        //
        // Background Image/Colour
        let settings = UserDefaults.standard.array(forKey: "userSettings") as! [[Int]]
        let backgroundIndex = settings[0][0]
        if backgroundIndex < BackgroundImages.backgroundImageArray.count {
            backgroundImageView.image = getUncachedImage(named: BackgroundImages.backgroundImageArray[backgroundIndex])
        } else if backgroundIndex == BackgroundImages.backgroundImageArray.count {
            //
            backgroundImageView.image = nil
            backgroundImageView.backgroundColor = Colours.colour1
        }
        // Blur
        // BackgroundBlur/Vibrancy
        let backgroundBlur = UIVisualEffectView()
        let backgroundBlurE = UIBlurEffect(style: .dark)
        backgroundBlur.effect = backgroundBlurE
        backgroundBlur.isUserInteractionEnabled = false
        backgroundBlur.frame = backgroundImageView.bounds
        if backgroundIndex > BackgroundImages.backgroundImageArray.count {
        } else {
            view.insertSubview(backgroundBlur, aboveSubview: backgroundImageView)
        }
        
        //
        // Subtitle
        subtitleLabel.text = NSLocalizedString("initialInfoSubtitle", comment: "")
        
        //
        // Info Table
        infoTable.tableFooterView = UIView()
        infoTable.delegate = self
        infoTable.dataSource = self
        infoTable.separatorStyle = .none
        infoTable.isScrollEnabled = false
        
        //
        // Buttons
        // Profile
        profileButton.setTitle(NSLocalizedString("initialProfileOption", comment: ""), for: .normal)
        profileButton.layer.cornerRadius = profileButton.bounds.height / 2
        profileButton.layer.masksToBounds = true
        profileButton.backgroundColor = Colours.colour3.withAlphaComponent(0.25)
//        let profileBlur = UIBlurEffect(style: .regular)
//        let profileBlurView = UIVisualEffectView(effect: profileBlur)
//        let profileVibrancy = UIVibrancyEffect(blurEffect: profileBlur)
//        let profileVibrancyView = UIVisualEffectView(effect: profileVibrancy)
//        profileBlurView.addSubview(profileVibrancyView)
//        //
//        profileBlurView.frame = profileButton.bounds
//        profileBlurView.layer.cornerRadius = 15
//        profileBlurView.layer.masksToBounds = true
//        profileBlurView.center = profileButton.center
//        view.insertSubview(profileBlurView, belowSubview: profileButton)
        // App
        appButton.setTitle(NSLocalizedString("initialAppOption", comment: ""), for: .normal)
        appButton.layer.cornerRadius = appButton.bounds.height / 2
        appButton.layer.masksToBounds = true
        appButton.backgroundColor = Colours.colour1.withAlphaComponent(0.25)
//        let appBlur = UIVisualEffectView


    }
    
    //
    // MARK: Info table
    var infoSections: [String] =
        [" ", "features", ""]
    var infoBulletPoints: [[String]] =
        [
            // Overview
            ["initialInfo1", "initialInfo2", "initialInfo3", "initialInfo4", "moreInfo"],
            // Features
            ["scheduleI", "trackingI", "lessonsI", "explanationsI", "warmupI", "stretchingI", "stretchingI2", "workoutsI", "gymI", "bodyweightI", "timedSessionsI", "cardioI", "cardioI2", "yogaI", "timedYogaI", "meditationTimeI", "guidedMeditationI", "customSessionsI"],
            // More info.
            ["initialMoreInfo"],
    ]

    //
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return infoSections.count
    }

    // Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString(infoSections[section], comment: "")
    }

    // Header Customization
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //
        // Header
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)!
        header.textLabel?.textColor = Colours.colour1
        //
        header.backgroundColor = .clear
        header.backgroundView = UIView()
        //
        if section == 1 {
            // Create seperator
            let seperator = CALayer()
            seperator.frame = CGRect(x: 15, y: header.frame.size.height - 1, width: topSeparator.bounds.width, height: 1)
            seperator.backgroundColor = Colours.colour1.cgColor
            seperator.opacity = 0.15
            header.layer.addSublayer(seperator)
        }
    }

    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //
        if section != 2 {
            return 37
        } else {
            return 37 / 2
        }
    }


    // Number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return infoBulletPoints[section].count
    }

    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Initial
        if indexPath.section == 0 {
            // Overview
            return (tableView.bounds.height - 47) / 5
        // Features
        } else if indexPath.section == 1 {
            let label = UILabel()
            label.frame = CGRect(x: 0, y: 0, width: infoTable.bounds.width, height: 0)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            label.text = NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: "")
            label.sizeToFit()
            //
            if label.bounds.height > 37 {
                return 37 * 2
            } else {
                return 37
            }
        // Overview cell
        } else if indexPath.section == 2 {
            let label = UILabel()
            label.frame = CGRect(x: 0, y: 0, width: infoTable.bounds.width, height: 0)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = UIFont(name: "SFUIDisplay-thin", size: 21)
            label.text = NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: "")
            label.sizeToFit()
            return label.bounds.height
        }
        return 0
    }

    // Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.text = NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: "")
        cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 21)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cell.textLabel?.textColor = Colours.colour1
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        //
        // More info. cell
        if indexPath.section == 0 && indexPath.row == 4 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-thin", size: 15)
            cell.textLabel?.textAlignment = .right
        //
        // Bullet points
            // Long text cell (more information text) has nothing done to it (hence if section != 2)
        } else if indexPath.section != 2 {
            //
            // Keep indentation constant
            let paragraphStyle: NSMutableParagraphStyle
            paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: [:])]
            paragraphStyle.defaultTabInterval = 15
            paragraphStyle.firstLineHeadIndent = 0
            paragraphStyle.headIndent = 15
            // Font
            let bulletPointFont = UIFont(name: "SFUIDisplay-thin", size: 21)
            //
            let attributedString = NSMutableAttributedString(string: NSLocalizedString(infoBulletPoints[indexPath.section][indexPath.row], comment: ""))
            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            attributedString.addAttributes([NSAttributedStringKey.font: bulletPointFont!], range: NSMakeRange(0, attributedString.length))
            cell.textLabel?.attributedText = attributedString
            //
            // Indent if not overview (if features cells)
            if indexPath.section > 0 {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
            }
        }
        return cell
    }
    
    //
    // Did select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 4 {
            let indexPath = NSIndexPath(row: 0, section: 1)
            infoTable.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.top, animated: true)
            infoTable.isScrollEnabled = true
        }
    }
    
    // Mask cells under clear header
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleIndex = infoTable.indexPathsForVisibleRows
        if visibleIndex!.first?.section == 1 {
            for cell in infoTable.visibleCells {
                let hiddenFrameHeight = scrollView.contentOffset.y + 37 - cell.frame.origin.y
                if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
                    maskCell(cell: cell, margin: Float(hiddenFrameHeight))
                }
            }
        }
    }
    func maskCell(cell: UITableViewCell, margin: Float) {
        cell.layer.mask = visibilityMaskForCell(cell: cell, location: (margin / Float(cell.frame.size.height) ))
        cell.layer.masksToBounds = true
    }
    func visibilityMaskForCell(cell: UITableViewCell, location: Float) -> CAGradientLayer {
        let mask = CAGradientLayer()
        mask.frame = cell.bounds
        mask.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor(white: 1, alpha: 1).cgColor]
        mask.locations = [NSNumber(value: location), NSNumber(value: location)]
        return mask;
    }
    
    //
    // Ensure didCreateNewSchedule == false
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if segue.identifier == "openInitialCreateScheduleSegueMenu" {
            ScheduleVariables.shared.didCreateNewSchedule = false
        }
    }
    
    //
    // Look around app button
    @IBAction func appButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

// Initial info navigation
class InitialInfoNavigation: UINavigationController {
    
}
