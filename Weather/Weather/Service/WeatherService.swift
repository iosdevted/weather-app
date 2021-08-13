//
//  WeatherService.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import Foundation

class WeatherService: WeatherServiceType {
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/forecast"
    private let API_KEY = "da69ade359c47e35161bf2e2dad374e8"
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<[WeatherModel], WeatherServiceError>) -> Void) {
        
        var urlComponent = URLComponents(string: baseURL)
        
        urlComponent?.queryItems = [
            URLQueryItem(name: "APPID", value: "\(API_KEY)"),
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        guard let url = urlComponent?.url else { return }
        handleRequest(url: url, completion: completion)
    }
    
    
    func fetchWeather(byCity city: String, completion: @escaping (Result<[WeatherModel], WeatherServiceError>) -> Void) {
        let cityName = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        
        var urlComponent = URLComponents(string: baseURL)
        
        urlComponent?.queryItems = [
            URLQueryItem(name: "q", value: "\(cityName)"),
            URLQueryItem(name: "APPID", value: "\(API_KEY)"),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        guard let url = urlComponent?.url else { return }
        handleRequest(url: url, completion: completion)
    }
    
    func handleRequest(url: URL, completion: @escaping (Result<[WeatherModel], WeatherServiceError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                return completion(.failure(.clientError))
            }
            
            guard let header = response as? HTTPURLResponse, (200..<300) ~= header.statusCode else {
                return completion(.failure(.invalidStatusCode))
            }
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let result = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(WeatherModel.getModelsWith(weatherResponse: result)))
            } catch {
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
}
