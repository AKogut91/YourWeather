//
//  RestAPI.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/17/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation

class RestAPI {
    
   private let baseUrl = "http://api.openweathermap.org/data/2.5/"
    
    enum Methods: String {
        case locationWeather
        case cityWeather
        case weatherOf16day

        var description: String {
            switch self {
            case .locationWeather:   return "\(RestAPI.init().baseUrl)weather"
            case .cityWeather:   return "\(RestAPI.init().baseUrl)weather"
            case .weatherOf16day: return "\(RestAPI.init().baseUrl)forecast/daily"
            }
        }
    }
}
