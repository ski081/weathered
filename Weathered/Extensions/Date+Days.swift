//
//  Date+Days.swift
//  Weathered
//
//  Created by Mark Struzinski on 2/24/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import Foundation

extension Date {
    func dayOfTheWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}
