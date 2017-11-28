//
//  CoreDataManager.swift
//  LichessDataLoader
//
//  Created by Gennadii on 11/7/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

//-com.apple.CoreData.SQLDebug 1

import Foundation
import CoreData

class CoreDataManager {
    
    static var persistanceContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameDomainModel")
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    
    static var context : NSManagedObjectContext {
        
        return persistanceContainer.viewContext
    }
    
    
    func loadData(_ array:[GameModelCodable]) {
        
        print("start load data")
        
        array.forEach { (gmc:GameModelCodable) in
            
            let white = gmc.white.cd
            let black = gmc.black.cd
            let opening = gmc.opening.cd
            let game = gmc.cd
            
            game.setValue(white, forKey: "whitePlayer")
            game.setValue(black, forKey: "blackPlayer")
            game.setValue(opening, forKey: "opening")
            
            
            CoreDataManager.context.insert(game)
            
        }
        
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
