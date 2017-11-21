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
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: "OpeningEntity", into: CoreDataManager.context)
        managedObject.setValue(self.eco, forKey: "eco")
        managedObject.setValue(self.name, forKey: "name")
        return managedObject
    }
}
