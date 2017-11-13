//
//  CoreDataManager.swift
//  LichessDataLoader
//
//  Created by Gennadii on 11/7/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    func loadData(_ array:[GameModelCodable]) {
        
        
        array.forEach { gmc in
            print(gmc.description)
        }
        
        
//        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//        context.perform {
//            array.forEach({ gameModel in
//                let newModel = NSEntityDescription.insertNewObject(forEntityName: "GameModel", into: context) as! GameModel
//            })
//        }
//
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameModel")
//
//        print(try? context.fetch(request))
        
    }
}
