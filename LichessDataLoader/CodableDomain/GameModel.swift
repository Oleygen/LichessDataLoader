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

enum GameWinner : String, Codable {
    case white, black

}

class GameModelCodable : Codable {
    var createdAt : Date
    var id : String
    var moves : String
    var rated : Bool
    var speed : String
    var turnsCount : Int
    var url : String
    var variant: GameVariant
    var winner : GameWinner
    var opening : OpeningModelCodable
    
}

class GameModel : NSManagedObject {

}