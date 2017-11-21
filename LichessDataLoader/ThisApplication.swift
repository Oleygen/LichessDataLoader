//
//  ThisApplication.swift
//  LichessDataLoader
//
//  Created by Gennadii on 11/7/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

import Foundation

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
    
    
    
    
    static func start() {
        // entry point
        
        let array = ThisApplication.fetchGames(fromUrl: getUrl(withPage: ThisApplication.page))
        let coreDataManager = CoreDataManager()
        coreDataManager.loadData(array)
        
        
        print("wtf")
        group.enter()
        group.wait()
        
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
                            print("before sleep")
                            sleep(120)
                           
                            print("after sleep")
                        } else {
                            print("error is nil")
                            if let _data = data {
                                
                                do {
                                    print("vse idet norm, bro")
                                    let decoder = JSONDecoder()
                                    let decoded = try decoder.decode(ChessResponse.self, from: _data)
                                    
                                    if decoded.nextPage == nil {
                                        cycleFlag = false
                                        return
                                    }
                                    
                                    print("real page number:\(decoded.currentPage)")
                                    gamesBatch = NSMutableOrderedSet(array: decoded.currentPageResults)
                                    game.union(gamesBatch)
                                    gamesBatch = []
                                    
                                    // lenivo zhdat
                                    
                                    if decoded.currentPage >= 2 {
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
    
    
    
    
}

