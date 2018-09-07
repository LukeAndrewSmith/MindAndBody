//
//  FinalChoiceChoice.swift
//  MindAndBody
//
//  Created by Luke Smith on 21.08.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

class FinalChoiceChoice: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //scheduleSegueFinalChoice
    //finalChoiceDetailSegue
    
    // Navigation bar titles
    let navigationBarTitles: [String: String] = [
        "warmup": "warmup",
        "workout": "workout",
        "cardio": "cardio",
        "stretching": "stretching",
        "yoga": "yoga"]
    
    // Cardio - time or distance - currently unused
    var cardioType = 0
    
    // Passed to finalChoiceChoice
    // 0 == warmup, 1 == session, 2 == stretching
    var selectedComponent = 0
    
    let cellHeight: CGFloat = 88
    
    // Load
    // Images of sessions
    var imageArray: [[[UIImage]]] = []
    // Names of sessions
    var sessionsArray: [String: [String]] = [:]
    // Keys to sorted sessions (set as the array which will never crash as all have at least average)
    var keys: [String] = sessionData.indexArray1
    
    // Outlets
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var finalChoiceTable: UITableView!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillImageArray()
        
        // Navigation
        var navTitle = String()
        switch selectedComponent {
        // Warmup
        case 0:
            navTitle = NSLocalizedString(ScheduleVariables.shared.selectedChoiceWarmup[0], comment: "") + ": " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceWarmup[1], comment: "") + ", " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceWarmup[2], comment: "")

        // Session
        case 1:
            navTitle = NSLocalizedString(ScheduleVariables.shared.selectedChoiceSession[0], comment: "") + ": " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceSession[1], comment: "") + ", " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceSession[2], comment: "")

            print(ScheduleVariables.shared.selectedChoiceSession)
        // Stretching
        case 2:
            navTitle = NSLocalizedString(ScheduleVariables.shared.selectedChoiceStretching[0], comment: "") + ": " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceStretching[1], comment: "") + ", " + NSLocalizedString(ScheduleVariables.shared.selectedChoiceStretching[2], comment: "")

        default: break
        }
        navigationBar.title = navTitle
        print(navTitle)
        navigationBar.rightBarButtonItem?.tintColor = Colors.light
        
        
        // Table View
        finalChoiceTable.tableFooterView = UIView()
        finalChoiceTable.dataSource = self
        finalChoiceTable.delegate = self
    }
    
    // MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return imageArray.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // If only on section => 1 difficulty which is "average"
            // see 'Session Data' -> 'SortedSessionsSchedule'
        var keys = ["level1", "level2", "level3"]
        if imageArray.count == 1 {
            return NSLocalizedString(keys[1], comment: "")
        } else {
            return NSLocalizedString(keys[section], comment: "")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "SFUIDisplay-regular", size: 17)!
        header.textLabel?.textAlignment = .left
        header.textLabel?.textColor = Colors.light
        header.contentView.backgroundColor = Colors.dark
        header.contentView.tintColor = Colors.light
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "FinalChoiceChoiceCell", for: indexPath) as! FinalChoiceChoiceCell
        cell.backgroundColor = Colors.light
        
        // Retreive Preset Sessions
        cell.nameLabel?.text = NSLocalizedString(sessionsArray[keys[indexPath.section]]![indexPath.row], comment: "")
        
        cell.layoutSubviews()
        
        // Images
        // Remove any images
        cell.imageStack.subviews.forEach({ $0.removeFromSuperview() })
        
        // Sizes
        let height = cell.imageStack.bounds.height
        let gap = CGFloat(4)
        let numberOfImages = imageArray[indexPath.section][indexPath.row].count
        
        // Add images
        for i in 0..<numberOfImages {
            let imageView = UIImageView()
            
            imageView.image = imageArray[indexPath.section][indexPath.row][i]
            
            imageView.contentMode = .scaleAspectFit
            imageView.frame.size = CGSize(width: height, height: height)
            imageView.widthAnchor.constraint(equalToConstant: height).isActive = true
            cell.imageStack.addArrangedSubview(imageView)
        }
        
        var width2 = CGFloat()
        width2 = (CGFloat(numberOfImages) * height) + (CGFloat(numberOfImages - 1) * gap)
        cell.imageStack.spacing = gap
        cell.imageStack.frame = CGRect(x: 0, y: 0, width: width2, height: height)
        cell.imageScroll.contentSize = CGSize(width: width2, height: height)
        
        cell.imageStack.tag = indexPath.row
        cell.stackTap.addTarget(self, action: #selector(stackTapAction))
        cell.stackPress.addTarget(self, action: #selector(stackPressAction))
        cell.imageScroll.tag = indexPath.row
        cell.scrollTap.addTarget(self, action: #selector(stackTapAction))
        cell.scrollPress.addTarget(self, action: #selector(stackPressAction))
        
        cell.imageStack.tag = indexPath.row
        cell.imageScroll.tag = indexPath.row
        
        return cell
    }
    
    @objc func stackTapAction(sender: UITapGestureRecognizer) {
        let index = IndexPath(row: (sender.view?.tag)!, section: 0)
        finalChoiceTable.selectRow(at: index, animated: false, scrollPosition: .none)
        finalChoiceTable.delegate?.tableView!(finalChoiceTable, didSelectRowAt: index)
    }
    @objc func stackPressAction(sender: UILongPressGestureRecognizer) {
        let index = IndexPath(row: (sender.view?.tag)!, section: 0)
        let cell = finalChoiceTable.cellForRow(at: index)
        if sender.state == .began {
            finalChoiceTable.selectRow(at: index, animated: false, scrollPosition: .none)
        } else if sender.state == .changed {
            if !(cell?.frame.contains(sender.location(in: self.view)))! {
                finalChoiceTable.deselectRow(at: index, animated: false)
            } else {
                finalChoiceTable.selectRow(at: index, animated: false, scrollPosition: .none)
            }
        } else if sender.state == .ended {
            if (cell?.frame.contains(sender.location(in: self.finalChoiceTable)))! {
                finalChoiceTable.delegate?.tableView!(finalChoiceTable, didSelectRowAt: index)
            }
        }
    }
    
    // Height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24.5
    }
    
    var okAction = UIAlertAction()
    // Did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Select session
        let selectedSessionKey: String = sessionsArray[keys[indexPath.section]]![indexPath.row]
        SelectedSession.shared.selectedSession[2] = selectedSessionKey
        
        // Cardio Type
        if SelectedSession.shared.selectedSession[0] == "cardio" {
            cardioType = indexPath.section
        }

        performSegue(withIdentifier: "finalChoiceDetailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK:
    func fillImageArray() {
        
        imageArray = []
        sessionsArray = [:]
        
        // Yoga indexed differently
        var  movementIndex = "movement"
        if SelectedSession.shared.selectedSession[0] == "yoga" {
            movementIndex = "pose"
        }

        switch selectedComponent {
        // Warmup
        case 0:
            sessionsArray = sessionData.sortedSessions[ScheduleVariables.shared.selectedChoiceWarmup[0]]![ScheduleVariables.shared.selectedChoiceWarmup[1]]![ScheduleVariables.shared.selectedChoiceWarmup[2]]!
        // Session
        case 1:
            sessionsArray = sessionData.sortedSessions[ScheduleVariables.shared.selectedChoiceSession[0]]![ScheduleVariables.shared.selectedChoiceSession[1]]![ScheduleVariables.shared.selectedChoiceSession[2]]!
        // Stretching
        case 2:
            sessionsArray = sessionData.sortedSessions[ScheduleVariables.shared.selectedChoiceStretching[0]]![ScheduleVariables.shared.selectedChoiceStretching[1]]![ScheduleVariables.shared.selectedChoiceStretching[2]]!
        default: break
        }
        
        let numberOfSections = sessionsArray.count
        
        // If only on section => 1 difficulty which is indexed by "average"
            // see 'Session Data' -> 'SortedSessionsSchedule'
        if numberOfSections == 3 {
            keys = sessionData.indexArray3
        } else if numberOfSections == 1 {
            keys = sessionData.indexArray1
        }
        
        // If cardio, uses workout images, so need to change for cardio
        var selectedSession0 = SelectedSession.shared.selectedSession[0]
        // Only weights if gym workout
        if SelectedSession.shared.selectedSession[0] == "cardio" && SelectedSession.shared.selectedSession[0].contains("Gym") {
            selectedSession0 = "workout"
        }
        
        // Loop sections (= difficulty levels)
        for i in 0..<numberOfSections {
            imageArray.append([])
            // Loop number of sessions per section
            if let numberOfSessions = sessionsArray[keys[i]]?.count {
                // Loop sessions
                for j in 0..<numberOfSessions {
                    imageArray[i].append([])
                    
                    // Find number of movements
                    let sessionIndex = sessionsArray[keys[i]]?[j]
                    var numberOfMovements = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![sessionIndex!]!.count
                    
                    // If circuit, only show one round of images
                    if sessionData.circuitChoices.contains(SelectedSession.shared.selectedSession[1]) {
                        let numberOfRounds = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![SelectedSession.shared.selectedSession[2]]![0]["rounds"] as! Int
                        // Number of movements per round
                        numberOfMovements = numberOfMovements/numberOfRounds
                    }
                    
                    // Add images
                    for k in 0..<numberOfMovements  {
                        let key = sessionData.sessions[SelectedSession.shared.selectedSession[0]]![SelectedSession.shared.selectedSession[1]]![sessionIndex!]?[k][movementIndex] as! String
                        let movementImage = getUncachedImage(named: (sessionData.movements[selectedSession0]![key]?["demonstration"]![0])!)!
                        
                        // Flip asymmetric images for yoga
                        if SelectedSession.shared.selectedSession[0] == "yoga" {
                            // If asymmetric array contains image, flip image
                            if (sessionData.asymmetricMovements[SelectedSession.shared.selectedSession[0]]?.contains(key))! {
                                let flippedImage = UIImage(cgImage: movementImage.cgImage!, scale: movementImage.scale, orientation: .upMirrored)
                                imageArray[i][j].append(flippedImage)
                            } else {
                                imageArray[i][j].append(movementImage)
                            }
                            
                        // Normal append
                        } else {
                            imageArray[i][j].append(movementImage)
                        }
                        
                    }
                }
            }
        }
    }
    
    //
    // MARK: Pass Arrays
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finalChoiceDetailSegue" {
            let destinationVC = segue.destination as? FinalChoiceDetail
            destinationVC?.cardioType = cardioType
            destinationVC?.comingFromSchedule = true
            // Remove back button text
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
}

// MARK: Custom Cell
class FinalChoiceChoiceCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageScroll: UIScrollView!
    @IBOutlet weak var imageStack: UIStackView!

    let stackTap = UITapGestureRecognizer()
    let stackPress = UILongPressGestureRecognizer()
    let scrollTap = UITapGestureRecognizer()
    let scrollPress = UILongPressGestureRecognizer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
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
