//  LocationService.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 8/1/23.
//
import UIKit
import CoreLocation
import MapKit

protocol LocationServiceProtocol {
    func makeRequest(request: WeatherRouter.Request.RequestType)
}

class LocationService: NSObject, LocationServiceProtocol {
    //MARK: - Variables
    let locationService = CLLocationManager()
    var networkService = NetworkService()
    let geocoder = CLGeocoder()
    
    public var presenter: WeatherPresenterProtocol?
    
    private func getCurrentLocation() {
        self.locationService.requestAlwaysAuthorization()
        self.locationService.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationService.delegate = self
            locationService.desiredAccuracy = kCLLocationAccuracyBest
            locationService.requestWhenInUseAuthorization()
            locationService.startUpdatingLocation()
        }
    }
    
    //MARK: - makeRequest
    func makeRequest(request: WeatherRouter.Request.RequestType) {
        switch request {
            case .getWeather:
                getCurrentLocation()
        }
    }
}

//MARK: - Extension CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //get coordinates
        guard let location = locations.last else { return }
        guard let currentLocation = locationService.location else { return }
        self.locationService.stopUpdatingLocation()
        let coordinates = "lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)"
        
        //get location name
        geocoder.reverseGeocodeLocation(currentLocation, preferredLocale: Locale.init(identifier: "uk_UA")) { placemarks, error in
            let locality = placemarks?[0].locality ?? (placemarks?[0].name ?? "Error of Location")
            
            //getWeather
            self.networkService.getWeather(coordinates: coordinates) { weatherResponse in
                guard let weatherResponse = weatherResponse else { return }
                self.presenter?.presentData(response: .presentWeather(weather: weatherResponse, locality: locality))
            }
        }
    }
}
