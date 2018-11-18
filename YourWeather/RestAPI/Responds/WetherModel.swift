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

class List: HandyJSON {
    
    var dt:Int!
    var temp: DayTemperature!
    var weather: [CurrentWeather]?
    
    required init() {}
    
}

class DayTemperature: HandyJSON {
    var day: Double!
    var min: Double!
    var max: Double!
    var night: Double!
    var eve: Double!
    var morn: Double!
    
    required init() {}
}

class CurrentWeather: HandyJSON {
    var main: String!
    var description: String!
    var icon: String!
    
    required init() {}
}

class WeatherModel: HandyJSON {
    var city: CityJSON!
    var list: [List]!
    
    required init() {}
}
