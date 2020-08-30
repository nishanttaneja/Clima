//
//  WeatherManager.swift
//  Clima
//
//  Created by Nishant Taneja on 30/08/20.
//  Copyright © 2020 Nishant Taneja. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didFetchWeather(_ weatherData: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    // Initialise
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = PrivateData.apiKey
    
    // Delegate
    var delegate: WeatherManagerDelegate?
    
    //MARK:- Networking
    // Creating URL
    func fetchWeather(forCityName cityName: String) {
        let urlString = "\(baseUrl)?q=\(cityName)&units=metric&appid=\(apiKey)"
        performRequest(with: urlString)
        
    }
    func fetchWeather(forLocation coordinates: CLLocationCoordinate2D) {
        let urlString = "\(baseUrl)?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&units=metric&appid=\(apiKey)"
        performRequest(with: urlString)
    }
    
    // Requesting Data
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            session.dataTask(with: url) { (data, response, error) in
                if let sessionError = error {self.delegate?.didFailWithError(sessionError); return}
                guard let sessionData = data else {fatalError("error reading session data")}
                if let weather = self.parseData(sessionData) {
                    self.delegate?.didFetchWeather(weather)
                }
            }.resume()
        }
    }
    
    // Parse Data
    private func parseData(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather = WeatherModel(decodedData.weather[0].id, decodedData.name, decodedData.main.temp)
            return weather
        }
        catch {delegate?.didFailWithError(error); return nil}
    }
}
