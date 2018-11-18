//
//  LocalWeatherViewModel.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/18/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation

class LocalWeatherViewModel {
    
    var cityInfo: WeatherModel!
    var weaterTemp: [CurrentWeather] = []
    
    init(complition: @escaping () -> ()) {
        networking {
            complition()
        }
    }
    
    func networking(complition: @escaping () -> ()) {
        
        NetworkService.getWeatherInterval16Days(city: "Kiev") { (json) in
            self.cityInfo = WeatherModel.deserialize(from: json)
            var current = [[CurrentWeather]]()
            
            if let temp = self.cityInfo?.list {
                
                for i in temp {
                    current.append(i.weather!)
                }
            }
            
            let currentWeathre = current.flatMap {$0}
            self.weaterTemp = currentWeathre
            complition()
        }
    }
}
