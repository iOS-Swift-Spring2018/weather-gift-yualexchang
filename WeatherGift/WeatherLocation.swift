//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Yu Chang on 4/10/18.
//  Copyright © 2018 ISclass. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    var name = ""
    var coordinates = ""
    init(name: String, coordinates: String) {
        self.name = name
        self.coordinates = coordinates
    }
}

