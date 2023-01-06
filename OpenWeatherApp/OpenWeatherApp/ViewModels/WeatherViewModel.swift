//
//  WeatherViewModel.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//

struct CurrentWeatherViewModel {
    let locality: String
    let temp: String
    let weatherDescription: String
    let icon: String
    let hourlyWeather: [Hourly]
    let maxMinTemp: String
    let dailyWeather: [Daily]
    
    struct Hourly{
        var dt: String
        let temp: String
        let description: String
        let icon: String
    }
    
    struct Daily{
        var dt: String
        let minTemp: String
        let maxTemp: String
        let icon: String
    }
}