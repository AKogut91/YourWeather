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
    func removeFromDataBase(title: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: DataBaseService.entity.City.rawValue)
        let predicate = NSPredicate(format: "cityName == %@", title)
        request.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            // Executes batch
            try DataBaseService.shered.context.execute(deleteRequest) as? NSBatchDeleteResult
        } catch {
            fatalError("Failed to execute request: \(error)")
        }
    }
    
}

