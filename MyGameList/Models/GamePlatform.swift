//
//  GamePlatform.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 22/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import Foundation
import RealmSwift

class GamePlatform: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var namePlatform: Int = 0
    @objc dynamic var slugPlatform: Date?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    let myGames = List<MyGame>()

}
