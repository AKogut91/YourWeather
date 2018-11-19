//
//  NetworkService.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/18/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation

class NetworkService {
    
    /// Get weather data interval 16 days
    static func getWeatherInterval16Days(city: String, complition: @escaping (JSONDictionary) -> ()) {
        
        let params = Request.params(params: ["q": city, "cnt": 16])
        
        Request.apiRequest(link: RestAPI.Methods.weatherOf16day, urlParams: params) { (json) in
            complition(json)
        }
    }
    
    /// Get current weather data
    static func getWeather(city: String, complition: @escaping (JSONDictionary) -> ()) {
        
        let params = Request.params(params: ["q": city])
        
        
        Request.apiRequest(link: RestAPI.Methods.cityWeather, urlParams: params) { (json) in
            complition(json)
        }
    }
    
    /// Get weather data by coordiantes
    static func getWeatherByCoordiantes(cooridinate: [String: Any], complition: @escaping (JSONDictionary) -> ()) {
        let params = Request.params(params: cooridinate)
        Request.apiRequest(link: RestAPI.Methods.locationWeather, urlParams: params) { (json) in
            complition(json)
        }
    }
}
