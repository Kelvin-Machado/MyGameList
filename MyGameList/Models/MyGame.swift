//
//  MyGame.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 22/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import Foundation
import RealmSwift

class MyGame: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var nameOriginal: String = ""
    @objc dynamic var slug : String = ""
    @objc dynamic var gameDescription: String = ""
    @objc dynamic var released: Date = Date()
    @objc dynamic var metacritic: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var parentConta = LinkingObjects(fromType: GamePlatform.self, property: "myGames")
}
