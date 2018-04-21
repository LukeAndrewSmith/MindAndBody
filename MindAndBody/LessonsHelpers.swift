//
//  LessonsHelpers.swift
//  MindAndBody
//
//  Created by Luke Smith on 21.04.18.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import Foundation
import UIKit

// Lessons Helpers
extension ScheduleScreen {
    
    // Check and remove/display lessons button if necessary
    func displayLessons() {
        // Show
        if ScheduleVariables.shared.choiceProgress[0] == -1 {
            lessonsButton.isEnabled = true
            lessonsButton.alpha = 1
            lessonsIndicator.isEnabled = true
            lessonsIndicator.alpha = 1
        // Hide
        } else {
            lessonsButton.isEnabled = false
            lessonsButton.alpha = 0
            lessonsIndicator.isEnabled = false
            lessonsIndicator.alpha = 0
        }
    }
    
}
