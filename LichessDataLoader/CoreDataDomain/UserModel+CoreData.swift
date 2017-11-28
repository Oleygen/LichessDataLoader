//
//  UserModel+CoreData.swift
//  LichessDataLoader
//
//  Created by Gennadii on 11/19/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

import Foundation
import CoreData

extension UserModelCodable {
    var cd : NSManagedObject {
        
        let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: CoreDataManager.context)
        let predicate = NSPredicate(format: "id=%@", id)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        request.entity = entity
        request.predicate = predicate
        let count = try! CoreDataManager.context.count(for: request)
        
        if count > 0 {
            return try! CoreDataManager.context.fetch(request).first as! UserModel
        }
        
        
        
        
        
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: "UserEntity", into: CoreDataManager.context)
        managedObject.setValue(self.id, forKey: "id")
        managedObject.setValue(self.name, forKey: "name")
        managedObject.setValue(self.rating, forKey: "rating")
        
        
        return managedObject
    }
}
