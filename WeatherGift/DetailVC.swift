//
//  DetailVC.swift
//  WeatherGift
//
//  Created by Yu Chang on 3/13/18.
//  Copyright © 2018 ISclass. All rights reserved.

import UIKit
import CoreLocation

class DetailVC: UIViewController {

    var currentPage = 0
    var locationsArray = [WeatherLocation]()
    var locationManager : CLLocationManager!
    var currentLocation : CLLocation!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentPage != 0 {
            self.locationsArray[currentPage].getWeather {
                self.updateUserInterface()
            }
        }
        else {
            getLocation()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentPage == 0 {
            getLocation()
        }
    }
    
    func updateUserInterface() {
        locationLabel.text = locationsArray[currentPage].name
        dateLabel.text = locationsArray[currentPage].coordinates
        temperatureLabel.text = locationsArray[currentPage].currentTemp
        summaryLabel.text = locationsArray[currentPage].currentWeather
    }
}

extension DetailVC: CLLocationManagerDelegate {
    
    func getLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        let status  = CLLocationManager.authorizationStatus()
        handleLocationAuthorizationStatus(status: status)
    }
    
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            print("denied")
        case.restricted:
            print("restricted")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geoCoder = CLGeocoder()
        var place = ""
        currentLocation = locations.last
        let currentLatitude = String(format: "%0.6f", currentLocation.coordinate.latitude)
        let currentLongitude = String(format: "%0.6f", currentLocation.coordinate.longitude)
        let currentCoordinates = "\(currentLatitude),\(currentLongitude)"
        dateLabel.text = currentCoordinates
        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            placemarks, error in
            if placemarks != nil {
                let placemark = placemarks?.last
                place = (placemark?.name)!
            } else {
                print("Error: \(error!)")
            }
            self.locationsArray[0].name = place
            self.locationsArray[0].coordinates = currentCoordinates
            self.locationsArray[0].getWeather {
                self.updateUserInterface()
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location.")
    }
}
