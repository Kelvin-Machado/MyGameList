//
//  Game.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 22/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import Foundation


// MARK: - Game
struct Game: Decodable {
    let id: Int
    let slug, name, nameOriginal, gameDescription, released: String
    let metacritic: Int
    let platforms: [PlatformElement]
}

// MARK: - PlatformElement
struct PlatformElement: Decodable {
    let platform: PlatformPlatform
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Decodable {
    let id: Int
    let name, slug: String
}
