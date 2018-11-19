//
//  WetherModel.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/17/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation
import HandyJSON

class CityJSON: HandyJSON {
    var id: Int!
    var name: String!
    var coord: CityCoordinate!
    var country: String!
    var population: Int!

    required init() {}
}

class CityCoordinate: HandyJSON {
    var lon: Double!
    var lat: Double!
    
    required init() {}
}

class ListFor16Days: HandyJSON {
    var dt:Int!
    var humidity: Int!
    var temp: DayTemperatureFor16Days!
    var weather: [CurrentWeatherFor16Days]!
    
    required init() {}
}

class DayTemperatureFor16Days: HandyJSON {
    var day: Double!
    var eve: Double!
    var max: Double!
    var min: Double!
    var morn: Double!
    var night: Double!
    required init() {}
}

class CurrentWeatherFor16Days: HandyJSON {
    var main: String!
    var description: String!
    var icon: String!
    
    required init() {}
}

class WeatherModel: HandyJSON {
   
    var list: [ListFor16Days]!
    
    required init() {}
}
