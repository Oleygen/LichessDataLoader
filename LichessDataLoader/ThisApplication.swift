//
//  ThisApplication.swift
//  LichessDataLoader
//
//  Created by Gennadii on 11/7/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

import Foundation
import CoreData

class ChessResponse : Decodable {
    var currentPageResults : [GameModelCodable]
    var currentPage : Int
    var nextPage : Int?

}

class ThisApplication {
    static let group = DispatchGroup()
    static let appQueue = OperationQueue()
    static let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: ThisApplication.appQueue)
    static let firstPartOfString = "https://lichess.org"
    static let username = "Oleygen"
    static let secondPartOfString = "/api/user/\(username)/games"
    static let url = firstPartOfString + secondPartOfString
    static var page = 0
    static let maxPages = 50
    
    
    
    
    static func start() {
        // entry point
        
        print("Start loading persistent store")
        group.enter()
        
        CoreDataManager.persistanceContainer.loadPersistentStores { (storeDescription, error) in
            if error != nil {
                print("ERROR WHEN LOAD PERSISTENT STORE: \(error!.localizedDescription)")
                abort()
            } else {
                print("Container load succeed")
            }
            print("Finish loading persistent store")
            group.leave()
        }
        group.wait()
        
        
        fetchAndSaveData()
//         fetchAllGamesForUser(for : "oleygen")
        fetchOpeningsAndCounts()
  
        
        
        print("Application finish run and waiting now...")
        group.enter()
        group.wait()
        
    }
    

    
    static func fetchAndSaveData() {
        print("Start fetching games")
        let array = ThisApplication.fetchGames(fromUrl: getUrl(withPage: ThisApplication.page))
        let coreDataManager = CoreDataManager()
        coreDataManager.loadData(array)
        print("Finish fetching and saving")
    }
    static func getUrl(withPage:Int) -> URL {
        print(ThisApplication.url + "?nb=10&with_moves=1&with_opening=1&page=\(withPage)")
        return URL(string: ThisApplication.url + "?nb=10&with_moves=1&with_opening=1&page=\(withPage)")!
    }
    
    static func fetchGames(fromUrl:URL) -> [GameModelCodable] {
        let game = NSMutableOrderedSet(array: [])
        var gamesBatch = NSMutableOrderedSet(array: [])
        
        var cycleFlag = true
        while (cycleFlag) {
          
            _ = ThisApplication.urlSession.dataTask(with:getUrl(withPage:page)) { (data, response, error) in
                let beginTime = Date().timeIntervalSince1970
                
                
                if let _error = error {
                    print(_error.localizedDescription)
                } else {
                    if let _response = response as? HTTPURLResponse {
                        if _response.statusCode  == 429 {
                            cycleFlag = false
                            print("enter sleep in order to respect API rules")
                            sleep(120)
                           
                            print("sleep has been finished")
                        } else {
                            print("no error, keep fetching")
                            if let _data = data {
                                
                                do {
                                    let decoder = JSONDecoder()
                                    let decoded = try decoder.decode(ChessResponse.self, from: _data)
                                    
                                    if decoded.nextPage == nil {
                                        cycleFlag = false
                                        return
                                    }
                                    
                                    gamesBatch = NSMutableOrderedSet(array: decoded.currentPageResults)
                                    game.union(gamesBatch)
                                    gamesBatch = []
                                    
                                    // lenivo zhdat
                                    
                                    if decoded.currentPage >= maxPages {
                                        cycleFlag = false
                                    }
                                    
                                    
                                } catch  {
                                    print("Error info: \(error)")
                                }
                            } else {
                                print("data is nil")
                            }
                        }
                    }                   
                }
                
                let endTime = Date().timeIntervalSince1970
                let processMSTime = (endTime-beginTime) * 1000
                
                let delayTime = 2000 - processMSTime
                if delayTime > 0 {
                    let delay = UInt32(delayTime * 1000)
                    print(delay)
                    usleep(delay)
                }
                
                
                
                group.leave()
            }.resume()
            ThisApplication.group.enter()
            ThisApplication.group.wait()
            ThisApplication.page = ThisApplication.page + 1
            print("End Of Iteration")
        }
        
        return game.array as! [GameModelCodable]
    }
    
    static func fetchAllGamesForUser(for id: String) {
        let predicate = NSPredicate(format: "id=%@", id)
        let request : NSFetchRequest<UserModel> = UserModel.fetchRequest()
        request.predicate = predicate
        let gennady = try! CoreDataManager.context.fetch(request).first!
        let allGames = gennady.value(forKey: "allGamesFetch")
        
        print("All games")
        print(allGames)
    
    }
    
    static func fetchOpeningsAndCounts() {
        let request: NSFetchRequest<OpeningModel> = OpeningModel.fetchRequest()
        var dictionary : [String : Int] = [:]
        let openings = try! CoreDataManager.context.fetch(request)
        openings.forEach { opening in
            if let name = opening.name {
                dictionary[name] = opening.countInGames
            }
            
        }
        let result = dictionary.sorted { clos1, clos2 -> Bool in
            clos2.value < clos1.value
        }
        
        
        print("Count for openings")
        dump(result)
    }
}

