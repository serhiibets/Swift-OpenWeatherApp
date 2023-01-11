//  WeatherPresenter.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//
import UIKit

protocol WeatherPresenterProtocol {
    func presentData(response: WeatherRouter.Response.ResponseType)
}

class WeatherPresenter: WeatherPresenterProtocol {
    weak var viewController: WeatherDisplayLogic?
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "uk_UA")
        return dt
    }()
    
    
    //MARK: - presentData
    func presentData(response: WeatherRouter.Response.ResponseType) {
        switch response {
            case .presentWeather(let weather, let locality):
                var hourlyWeather: [CurrentWeatherViewModel.Hourly] = []
                var dailyWeather: [CurrentWeatherViewModel.Daily] = []
                var hourlyWeatherCell = hourlyWeather.first
                var dailyWeatherCell = dailyWeather.first

                // create data for hour cells
                weather.hourly.forEach { hourly in
                    hourlyWeather.append(CurrentWeatherViewModel.Hourly.init(dt: formattedDate(dateFormat: "HH", date: hourly.dt),
                                                                             temp: setSign(temp: Int(hourly.temp)),
                                                                             description: hourly.weather.first?.description ?? "No description",
                                                                             icon: hourly.weather.first?.icon ?? "No icon"))
                }
                hourlyWeather.removeLast(24)
                hourlyWeatherCell?.dt = "Зараз"
                
                //create data for daily cells
                weather.daily.forEach { daily in
                    dailyWeather.append(CurrentWeatherViewModel.Daily.init(dt: formattedDate(dateFormat: "EEEE", date: daily.dt),
                                                                           minTemp: setSign(temp: Int(daily.temp.min)),
                                                                           maxTemp: setSign(temp: Int(daily.temp.max)),
                                                                           icon: daily.weather.first?.icon ?? "No icon"))
                }
                dailyWeatherCell?.dt = "Сьогодні"
                
                // create data to minMaxLabel
                let maxMinTemp = "\(dailyWeather.first?.minTemp ?? "") / \(dailyWeather.first?.maxTemp ?? "")"
                
                let currentWeather = headerViewModel(weatherModel: weather, hourlyWeather: hourlyWeather, maxMinTemp: maxMinTemp, dailyWeather: dailyWeather, locality: locality)
                
                // send display data to viewController
                DispatchQueue.main.async {
                    self.viewController?.displayData(viewModel: .displayWeather(currentWeatherViewModel: currentWeather))
                }
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
    private func headerViewModel(weatherModel: WeatherModel, hourlyWeather: [CurrentWeatherViewModel.Hourly], maxMinTemp: String, dailyWeather: [CurrentWeatherViewModel.Daily], locality: String) -> CurrentWeatherViewModel {
        return CurrentWeatherViewModel(locality: locality,
                                       temp: setSign(temp: Int(weatherModel.current.temp)),
                                       humidity: String(weatherModel.current.humidity),
                                       wind: String("\(weatherModel.current.windSpeed)  м/cек"),
                                       weatherDescription: weatherModel.current.weather.first?.description ?? "null",
                                       icon: weatherModel.current.weather.first?.icon ?? "unknown",
                                       hourlyWeather: hourlyWeather,
                                       maxMinTemp: maxMinTemp,
                                       dailyWeather: dailyWeather)
    }
}
