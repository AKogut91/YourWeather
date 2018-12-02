//
//  DataBaseService.swift
//  YourWeather
//
//  Created by AlexanderKogut on 11/21/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension DataBaseService {
    
    enum entity: String {
        case City
    }
    
    enum classPredicate :String  {
        case cityName
    }
}

class DataBaseService {
   
    private init() {}
    
    static let shered = DataBaseService()
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    ///LoadFrom DataBase
    func load(entity: entity, complition: @escaping (NSFetchRequest<NSManagedObject>) -> ()) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity.rawValue)
        complition(fetchRequest)
    }
    
    
    /// Save object to DataBase
    func save(entity: entity, complition: @escaping (NSManagedObject) -> ()) {
        let entity = NSEntityDescription.entity(forEntityName: entity.rawValue, in: context)
        let newCity = NSManagedObject(entity: entity!, insertInto: context)
        complition(newCity)
    }
    
    /// Remove object by predicate in DataBase
    func removeWithPredicate(title: String, predicate: classPredicate) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: DataBaseService.entity.City.rawValue)
        let predicate = NSPredicate(format: "\(predicate.rawValue) == %@", title)
        request.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            // Executes batch
            try! DataBaseService.shered.context.execute(deleteRequest) as? NSBatchDeleteResult
        } catch {
            fatalError("Failed to execute request: \(error)")
    
    }
    }
}
