//
//  TimeInterval_format.swift
//  WeatherGift
//
//  Created by Yu Chang on 4/2/18.
//  Copyright © 2018 ISclass. All rights reserved.
//

import Foundation


extension TimeInterval {
    func format(timeZone: String, dateFormatter: DateFormatter) -> String {
        let usableDate = Date(timeIntervalSince1970: self)
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usableDate)
        return dateString
    }
}
