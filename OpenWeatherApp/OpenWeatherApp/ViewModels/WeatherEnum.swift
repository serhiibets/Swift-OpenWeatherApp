//
//  WeatherEnum.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//

import UIKit

enum WeatherEnumModel {
    struct Request {
        enum RequestType {
            case getWeather
        }
    }
    struct Response {
        enum ResponseType {
            case presentWeather(weather: WeatherModel, locality: String)
        }
    }
    struct ViewModel {
        enum ViewModelData {
            case displayWeather(currentWeatherViewModel: CurrentWeatherViewModel)
        }
    }
}
