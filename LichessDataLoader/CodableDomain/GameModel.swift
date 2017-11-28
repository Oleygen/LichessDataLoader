//
//  GameModel.swift
//  ChessCoreData
//
//  Created by Gennadii on 9/10/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

import Foundation
import CoreData

enum GameVariant : String, Codable {
    case standard, chess960, fromPosition, kingOfTheHill, threeCheck, atomic, horde, crazyhouse, racingKings, antichess
}

enum GameSpeed : String, Codable {
    case blitz, bullet, classical, unlimited, ultraBullet
}

enum GameWinner : String, Codable, CustomStringConvertible {
    case white, black
    
     var description: String {
        if self == .white {
            return "white"
        } else if self == .black {
            return "black"
        } else {
            return "no_winner"
        }
    }

}

class GameModelCodable : Codable {
    var createdAt : Date
    var id : String
    var moves : String
    var rated : Bool
    var speed : GameSpeed
    var url : String
    var variant: GameVariant
    var winner : GameWinner?
    var opening : OpeningModelCodable
    var black : UserModelCodable
    var white : UserModelCodable
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        
        white = try container.nestedContainer(keyedBy: PlayerKeys.self, forKey: .players).decode(UserModelCodable.self, forKey: .white)
        black = try container.nestedContainer(keyedBy: PlayerKeys.self, forKey: .players).decode(UserModelCodable.self, forKey: .black)
        
        
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        id = try container.decode(String.self, forKey: .id)
        moves = try container.decode(String.self, forKey:.moves)
        rated = try container.decode(Bool.self, forKey: .rated)
        speed = try container.decode(GameSpeed.self, forKey: .speed)
        url = try container.decode(String.self, forKey: .url)
        variant = try container.decode(GameVariant.self, forKey: .variant)
        winner = try container.decode(GameWinner.self, forKey: .winner)
        opening = try container.decode(OpeningModelCodable.self, forKey: .opening)
        
    }
    
    enum RootKeys : CodingKey {
        case players

        
        case createdAt
        case id
        case moves
        case rated
        case speed
        case url
        case variant
        case winner
        case opening
    }
    
    enum PlayerKeys : CodingKey {
        case white
        case black
    }
}

extension GameModelCodable : CustomStringConvertible {
    var description: String {
        get {
            let string = """
            createdAt : \(createdAt)
            id : \(id)
            moves : \(moves)
            rated : \(rated)
            speed : \(speed)
            url : \(url)
            variant : \(variant.rawValue)
            winner : \(String(describing: winner))
            opening : \(opening)
            """
            return string
        }
    }
}

class GameModel : NSManagedObject {
    static var anyGame : GameModel {
        let request : NSFetchRequest<GameModel> = GameModel.fetchRequest()
        let anyGame = try! CoreDataManager.context.fetch(request).first!
        return anyGame
        
    }
}
