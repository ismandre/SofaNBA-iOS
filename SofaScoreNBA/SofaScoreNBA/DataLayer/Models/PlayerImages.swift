//
//  PlayerImage.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 05.06.2022..
//

import Foundation

struct PlayerImages: Decodable {
    let data: [PlayerImage]
    
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct PlayerImage: Decodable {
    let playerId: Int
    let imageUrl: String
    let imageCaption: String
    let id: Int
}

