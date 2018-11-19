//
//  LocalWeatherViewModel.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/18/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation
import UIKit

class LocalWeatherViewModel {

    var forecastWeather: [ListFor16Days] = []
    var forecastWeatherIcons:[CurrentWeatherFor16Days]!
    var currentCityWeather: CurrentCityWeather!
    var currentWeather: [CurrentWeather]!
    
    init(city: String,complition: @escaping () -> ()) {
        NetworkService.getWeather(city: city) { (json) in
            self.currentCityWeather = CurrentCityWeather.deserialize(from: json)
            self.currentWeather = self.currentCityWeather.weather
            self.forecastWeatherRequest(city: self.currentCityWeather.name, complition: {
                complition()
            })
            
        }
    }
    
    init(coordinate: [String: Any],complition: @escaping () -> ()) {
        NetworkService.getWeatherByCoordiantes(cooridinate: coordinate) { (json) in
            print(json)
            self.currentCityWeather = CurrentCityWeather.deserialize(from: json)
            self.currentWeather = self.currentCityWeather.weather
            self.forecastWeatherRequest(city: self.currentCityWeather.name, complition: {
                complition()
            })
            
        }
    }
}

extension LocalWeatherViewModel {

    //MARK: - city Request
    func forecastWeatherRequest(city: String,complition: @escaping () -> ()) {
        NetworkService.getWeatherInterval16Days(city: city) { (json) in
            let weather = WeatherModel.deserialize(from: json)
            var icon = [[CurrentWeatherFor16Days]]()
            self.forecastWeather = weather!.list.map({$0})
            for i in self.forecastWeather {
                icon.append(i.weather)
            }
            self.forecastWeatherIcons = icon.flatMap { $0 }
            
            complition()
        }
    }
}

extension LocalWeatherViewModel {
    
    /// Configure City TableViewCell
    func configurCell(cell: CityLabelTableViewCell, indexPath: IndexPath) {

        if let currentWeather = currentCityWeather {
            if let image = currentWeather.weather[indexPath.row].main {
                cell.weatherIMage.image = UIImage(named: image)
            }
            cell.weatherDegrees.text = DegreesService.convertCelvitToC(celvin: currentWeather.main.temp)
        }
    }

    /// Configure CollectionViewCell
    func configurCell(cell: CollectionViewCell, indexPath: IndexPath) {
        
        let weatherTemp = forecastWeather[indexPath.row]
        cell.weatherIcon.image = UIImage(named: forecastWeatherIcons[indexPath.row].main)
        cell.weatherDegrees.text = DegreesService.convertCelvitToC(celvin: (weatherTemp.temp.max)!)
        cell.weatherDate.text = DataService.timeStamp(unixTimestamp: weatherTemp.dt, timeFormat: DataService.KindTime.monthDay)
    }
}
