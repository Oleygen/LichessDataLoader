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
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: "UserEntity", into: CoreDataManager.context)
        managedObject.setValue(self.id, forKey: "id")
        managedObject.setValue(self.name, forKey: "name")
        managedObject.setValue(self.rating, forKey: "rating")
        return managedObject
    }
}
