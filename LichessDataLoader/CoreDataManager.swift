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
    
    static var persistanceContainer = NSPersistentContainer(name: "GameDomainModel")
    static var context : NSManagedObjectContext {
        return persistanceContainer.viewContext
    }
    
    
    func loadData(_ array:[GameModelCodable]) {
        
        print("load data")
        
        array.forEach { (gmc:GameModelCodable) in
            print("forEach")
            
            let white = gmc.white.cd
            let black = gmc.black.cd
            let opening = gmc.opening.cd
            let game = gmc.cd
            
            game.setValue(white, forKey: "whitePlayer")
            game.setValue(black, forKey: "blackPlayer")
            game.setValue(opening, forKey: "opening")
            
            
            CoreDataManager.context.insert(game)
            
        }
        print("after array")
        
        do{
            
            try CoreDataManager.context.save()
            print("saved")
        } catch {
            
            print("error \(error)")
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
