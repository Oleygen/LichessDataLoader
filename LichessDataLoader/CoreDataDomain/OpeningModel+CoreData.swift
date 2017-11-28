//
//  OpeningModel.swift
//  LichessDataLoader
//
//  Created by Gennadii on 11/19/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

import Foundation
import CoreData

extension OpeningModelCodable {
    var cd : NSManagedObject {
        
        let entity = NSEntityDescription.entity(forEntityName: "OpeningEntity", in: CoreDataManager.context)
        let predicate = NSPredicate(format: "code=%@",eco)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "OpeningEntity")
        request.entity = entity
        request.predicate = predicate
        let count = try! CoreDataManager.context.count(for: request)
        
        if count > 0 {
            return try! CoreDataManager.context.fetch(request).first as! OpeningModel
        }
        
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: "OpeningEntity", into: CoreDataManager.context)
        managedObject.setValue(self.eco, forKey: "code")
        managedObject.setValue(self.name, forKey: "name")
        return managedObject
    }
    
    
}
