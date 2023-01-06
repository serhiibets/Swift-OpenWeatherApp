//
//  WeatherPresenter.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//

import UIKit

protocol WeatherPresentationLogic {
    func presentData(response: WeatherEnumModel.Response.ResponseType)
}

class WeatherPresenter: WeatherPresentationLogic {
    weak var viewController: WeatherDisplayLogic?
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "uk_UA")
        return dt
    }()
    
    
    //MARK: - presentData
    func presentData(response: WeatherEnumModel.Response.ResponseType) {
        
        switch response {
        
        case .presentWeather(let weather, let locality):
            var hourlyCells: [CurrentWeatherViewModel.Hourly] = []
            var dailyCells: [CurrentWeatherViewModel.Daily] = []
            
            // create data for hour cells
            weather.hourly.forEach { hourly in
                hourlyCells.append(CurrentWeatherViewModel.Hourly.init(dt: formattedDate(dateFormat: "HH",
                                                                                         date: hourly.dt),
                                                                       temp: setSign(temp: Int(hourly.temp)),
                                                                       description: hourly.weather.first!.description,
                                                                       icon: hourly.weather.first!.icon))
            }
            hourlyCells.removeLast(24)
            hourlyCells[0].dt = "Зараз"
            
            //create data for daily cells
            weather.daily.forEach { daily in
                dailyCells.append(CurrentWeatherViewModel.Daily.init(dt: formattedDate(dateFormat: "EEEE",
                                                                                       date: daily.dt),
                                                                     minTemp: setSign(temp: Int(daily.temp.min)),
                                                                     maxTemp: setSign(temp: Int(daily.temp.max)),
                                                                     icon: daily.weather.first!.icon))
            }
            dailyCells[0].dt = "Сьогодні"
            
            // create data to minMaxLabel
            let maxMinTemp = "\(dailyCells[0].maxTemp) / \(dailyCells[0].minTemp)"
            
            let currentWeather = headerViewModel(weatherModel: weather, hourlyCells: hourlyCells, maxMinTemp: maxMinTemp, dailyCells: dailyCells, locality: locality)
            
            // send display data to viewController
            viewController?.displayData(viewModel: .displayWeather(currentWeatherViewModel: currentWeather))
        }
    }
    
    // formatting the data for the specified format
    private func formattedDate(dateFormat: String, date: Double) -> String{
        dateFormatter.dateFormat = dateFormat
        let currentDate = Date(timeIntervalSince1970: date)
        let dateTitle = dateFormatter.string(from: currentDate).capitalizingFirstLetter()
        return dateTitle
    }
    
    // add the necessary symbols to the temperature
    private func setSign(temp: Int) -> String{
        var currentTemp: String = ""
        guard temp >= 1 else { currentTemp = "\(temp)º"; return currentTemp }
        currentTemp = "+\(temp)º"
        return currentTemp
    }
    
    // convert data to CurrentWeatherViewModel
    private func headerViewModel(weatherModel: WeatherModel, hourlyCells: [CurrentWeatherViewModel.Hourly], maxMinTemp: String, dailyCells: [CurrentWeatherViewModel.Daily], locality: String) -> CurrentWeatherViewModel{
        return CurrentWeatherViewModel.init(locality: locality,
                                            temp: setSign(temp: Int(weatherModel.current.temp)),
                                            humidity: String(weatherModel.current.humidity),
                                            wind: String(weatherModel.current.windSpeed),
                                            weatherDescription: weatherModel.current.weather.first?.description ?? "null",
                                            icon: weatherModel.current.weather.first?.icon ?? "unknown",
                                            hourlyWeather: hourlyCells,
                                            maxMinTemp: maxMinTemp,
                                            dailyWeather: dailyCells)
    }
    
}
