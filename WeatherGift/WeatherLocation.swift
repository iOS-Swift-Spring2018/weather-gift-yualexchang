//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Yu Chang on 3/23/18.
//  Copyright © 2018 ISclass. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    var currentWeather = ""
    
    func getWeather(completed: @escaping () -> ()) {
        let weatherURL = urlBase + urlAPIKey + coordinates + "?units=si"
        print(weatherURL)
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                }
                if let weather = json["currently"]["summary"].string {
                    self.currentWeather = weather
                    print("\(weather)")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
