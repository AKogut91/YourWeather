//
//  SelectCityWeatherViewModel.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/18/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation
import UIKit


class SelectCityWeatherViewModel {
    
    var allCities: [String] = []
    
    init(complition: @escaping () -> ()) {
        
        getAllCities()
        complition()
    }
    
   private func getAllCities() {
        
        let timeZoneIdentifiers = TimeZone.knownTimeZoneIdentifiers
        for identifier in timeZoneIdentifiers {
            if let cityName = identifier.split(separator: "/").last {
                let new = cityName.replacingOccurrences(of: "_", with: " ", options:.literal, range: nil)
                allCities.append("\(new)")
            }
        }
    }
}
