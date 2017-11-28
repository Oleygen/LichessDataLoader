//
//  GameModel+CoreData.swift
//  LichessDataLoader
//
//  Created by Gennadii on 11/19/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

import Foundation
import CoreData


extension GameModelCodable {
    var cd : NSManagedObject {
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: "GameEntity", into: CoreDataManager.context)
        managedObject.setValue(self.createdAt, forKey: "createAt")
        managedObject.setValue(self.id, forKey: "id")
        managedObject.setValue(self.moves, forKey: "moves")
        managedObject.setValue(self.rated, forKey: "rated")
        managedObject.setValue(self.speed.rawValue, forKey: "speed")
        managedObject.setValue(self.url, forKey: "url")
        managedObject.setValue(self.variant.rawValue, forKey: "variant")
        managedObject.setValue(self.winner.debugDescription, forKey: "winner")
        
        return managedObject
    }
}
