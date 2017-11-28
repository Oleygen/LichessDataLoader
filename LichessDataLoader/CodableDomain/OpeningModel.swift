//
//  Opening.swift
//  ChessCoreData
//
//  Created by Gennadii on 9/10/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

import Foundation
import CoreData



class OpeningModelCodable : Codable {
    var eco : String
    var name : String
}


class OpeningModel : NSManagedObject {
    
    var openedGames : Array<GameModel> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEntity")
        let predicate = NSPredicate(format: "opening == %@", self)
        request.predicate = predicate
        let result = try! CoreDataManager.context.fetch(request)
        return result as! Array<GameModel>
    }

    var countInGames : Int {
        let request : NSFetchRequest<GameModel> = GameModel.fetchRequest()
        let predicate = NSPredicate(format: "opening == %@", self)
        request.predicate = predicate
        let count = try! CoreDataManager.context.count(for: request)
        return count
    }
}
