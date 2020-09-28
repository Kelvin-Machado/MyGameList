//
//  Parents.swift
//  MyGameList
//
//  Created by Kelvin Batista Machado on 28/09/20.
//  Copyright © 2020 Kelvin Batista Machado. All rights reserved.
//

import Foundation

// MARK: - ParentsList
struct ParentsList: Decodable {
    let count: Int
    let next, previous: String?
    let results: [Results]
}

// MARK: - Result
struct Results: Decodable {
    let id: Int
    let name, slug: String
    let platforms: [Platform]
}

// MARK: - Platform
struct Platform: Decodable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String?
    let image: String?
    let yearStart: Int?
    let yearEnd: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case image
        case yearStart = "year_start"
        case yearEnd = "year_end"
    }
}
