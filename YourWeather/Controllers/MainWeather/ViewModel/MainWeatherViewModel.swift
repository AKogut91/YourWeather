//
//  MainWeatherViewModel.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/21/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MainWeatherViewModel {
    
    var citys: [City] = []
    init() {}

}

//MARK: - Data Base
extension MainWeatherViewModel {
    /// load from Data Base
    func loadFromDataBase() {
        DataBaseService.shered.load(entity: DataBaseService.entity.City) { (fetch) in
            do {
                self.citys = try DataBaseService.shered.context.fetch(fetch) as! [City]
                print("fetch works")
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    /// remove from data base
    func remove(index: Int) {
        DataBaseService.shered.remove(entity: DataBaseService.entity.City, index: index) { (managetObj) in
            
            DataBaseService.shered.context.delete(self.citys[index] as City)
            
            do {
                try DataBaseService.shered.context.save()
            } catch {
                
            }
        }
    }
}

