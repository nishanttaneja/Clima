//
//  WeatherModel.swift
//  Clima
//
//  Created by Nishant Taneja on 30/08/20.
//  Copyright © 2020 Nishant Taneja. All rights reserved.
//

import Foundation

struct WeatherModel {
    let id: Int
    let name: String
    let temperature: Double
    
    var temperatureString: String {return String(format: "%.1f", temperature)}
    var condition: String {
        switch id {
        case 200...232: return "cloud.bolt"
        case 300...321: return "cloud.drizzle"
        case 500...531: return "cloud.rain"
        case 600...622: return "cloud.snow"
        case 701...781: return "cloud.fog"
        case 800: return "sun.max"
        case 801...804: return "cloud.bolt"
        default: return "cloud"
        }
    }
    
    init(_ conditionId: Int, _ cityName: String, _ temperature: Double) {
        id = conditionId
        name = cityName
        self.temperature = temperature
    }
}
