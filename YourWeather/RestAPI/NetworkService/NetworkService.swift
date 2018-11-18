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
    
    /// Get weather data for 5 days with interval 3 hours
    static func getWeatherInterval5Days(city: String, complition: @escaping (JSONDictionary) -> ()) {
        
        let params = Request.params(params: ["q": city])
        
        Request.apiRequest(link: RestAPI.Methods.weatherOf5day, urlParams: params) { (json) in
            complition(json)
        }
    }
    
    /// Get weather data by coordiantes
    static func getWeatherByCoordiantes(lon: Double, lat: Double, complition: @escaping (JSONDictionary) -> ()) {
        
        let params = Request.params(params: ["lon": lon, "lat": lon])
        
        Request.apiRequest(link: RestAPI.Methods.locationWeather, urlParams: params) { (json) in
            complition(json)
        }
    }
}
