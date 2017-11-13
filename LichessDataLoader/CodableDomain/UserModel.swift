//
//  User.swift
//  ChessCoreData
//
//  Created by Gennadii on 9/10/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

import Foundation
import CoreData

class UserModelCodable : Codable {
    var id : String
    var name : String
    var rating : Int
}

class UserModel : NSManagedObject {
    
}
