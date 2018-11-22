//
//  CurrentCityWeatherRespods.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/18/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation

import HandyJSON

class CurrentWeather: HandyJSON {
    var main: String!
    var description: String!
    required init() {}
}

class CurrentMain: HandyJSON {
    
    var temp: Double!
    var pressure: Double!
    var humidity: Double!
    var temp_min: Double!
    var temp_max: Double!
    required init() {}
}

class CurrentWind: HandyJSON {
    
    var speed: Int!
    var deg: Int!
    required init() {}
}

class CurrentSys: HandyJSON {
    
    var type: Int!
    var id: Int!
    var message: Double!
    var country: String!
    var sunrise: Int!
    var sunset: Int!
    
    required init() {}
}

class CurrentCityWeather: HandyJSON {
    
    var weather: [CurrentWeather]!
    var main: CurrentMain!
    var cod: Int!
    var sys: CurrentSys!
    var wind: CurrentWind!
    var dt: Int!
    var name: String!

    required init() {}
}
