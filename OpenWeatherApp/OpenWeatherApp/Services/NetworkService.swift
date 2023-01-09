//  NetworkService.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//
import Foundation
import Alamofire

protocol NetworkServiceProtocol{
    func getWeather(coordinates: String, completion: @escaping (WeatherModel?) -> Void)
}

struct NetworkService: NetworkServiceProtocol{    
    func getWeather(coordinates: String, completion: @escaping (WeatherModel?) -> Void) {
        let fullUrl = "\(API.url)\(API.apiKey)&\(coordinates)"
        guard let url = URL(string: fullUrl) else { return }
        let _ = AF.request(url, method: .get).validate().response { response in
            guard let data = response.data else { return }
            let decoded = self.decodeJSON(type: WeatherModel.self, from: data)
            completion(decoded)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T?{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
