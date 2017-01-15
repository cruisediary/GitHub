//
//  DateHelper.swift
//  GitHub
//
//  Created by CruzDiary on 15/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import UIKit

import SwiftDate

extension Date {
    
    var relativeTime: String {
        let timeInterval = Date().timeIntervalSince(self)
        if timeInterval < 60 {
            return "\(Int(timeInterval)) seconds ago"
        } else if timeInterval < 3600 {
            return "\(Int(timeInterval/60)) minutes ago"
        } else if timeInterval < 24 * 3600 {
            return "\(Int(timeInterval/3600)) hours ago"
        } else {
            return "\(Int(timeInterval/(24 * 3600))) days ago"
        }
    }
}
