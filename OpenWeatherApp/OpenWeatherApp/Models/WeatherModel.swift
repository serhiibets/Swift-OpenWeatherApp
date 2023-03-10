//  WeatherModel.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//
import Foundation

struct WeatherModel: Decodable{
    let lat, lon: Double
    let current: Current
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct Current: Decodable {
    let dt: Double
    let temp: Double
    let humidity: Double
    let windSpeed: Double
    let weather: [WeatherInfo]
}

struct WeatherInfo: Decodable {
    let description, icon: String
}

struct HourlyWeather: Decodable{
    let dt, temp: Double
    let weather: [HourlyWeatherInfo]
}

struct HourlyWeatherInfo: Decodable{
    let description, icon: String
}

struct DailyWeather: Decodable{
    let dt: Double
    let temp: DailyTemp
    let weather: [DailyWeatherInfo]
}

struct DailyTemp: Decodable{
    let min, max: Double
}

struct DailyWeatherInfo: Decodable{
    let icon: String
}


