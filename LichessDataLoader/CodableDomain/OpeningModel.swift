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
//
//    enum CodingKeys : String, CodingKey {
//        case code
//        case name
//    }
//
//
//    required init(from decoder: Decoder) throws {
//        guard let context = decoder.userInfo[.context!] as? NSManagedObjectContext else {
//            fatalError()
//        }
//
//        guard let entity = NSEntityDescription.entity(forEntityName: "OpeningEntity", in: context) else {
//            fatalError()
//        }
//
//        let container = decoder.container(keyedBy: CodingKeys.self)
//        code = try container.decode(String?.self, forKey: .code)
//        name = try container.decode(String?.self, forKey: .name)
//    }

}
