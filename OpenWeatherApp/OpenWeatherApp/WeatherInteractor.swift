//
//  WeatherInteractor.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//

import UIKit
import CoreLocation

protocol WeatherBusinessLogic {
    func makeRequest(request: WeatherEnumModel.Request.RequestType)
}

class WeatherInteractor: NSObject, WeatherBusinessLogic, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var presenter: WeatherPresentationLogic?
    var networkManager = NetworkService()
    
    //MARK: - makeRequest
    func makeRequest(request: WeatherEnumModel.Request.RequestType) {
       
        switch request {
        case .getWeather:
            getLocation()
        }
    }
    
    private func getLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    //MARK: - locationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //get coordinates
        guard let location = locations.last else { return }
        self.locationManager.stopUpdatingLocation()
        let coordinates = "lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)"
        guard let currentLocation = locationManager.location else { return }
        
        //get location name
        geocoder.reverseGeocodeLocation(currentLocation, preferredLocale: Locale.init(identifier: "uk_UA")) { placemarks, error in
            let locality = placemarks?[0].locality ?? (placemarks?[0].name ?? "Error of Location")
            
                //getWeather
                self.networkManager.getWeather(coordinates: coordinates) { weatherResponse in
                    guard let weatherResponse = weatherResponse else { return }
                    self.presenter?.presentData(response: .presentWeather(weather: weatherResponse, locality: locality))
                }
        }
    }
}
