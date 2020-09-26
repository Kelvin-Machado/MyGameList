//
//  GameParentPlatform.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 25/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import Foundation
import RealmSwift

class GameParentPlatform: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var nameParentPlatform: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    let childPlatforms = List<GamePlatform>()
}
