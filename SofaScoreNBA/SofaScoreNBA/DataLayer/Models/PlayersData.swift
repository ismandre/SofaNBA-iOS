//
//  PlayersData.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 05.06.2022..
//

import Foundation

struct PlayersData: Decodable {
    let data: [Player]
}

struct Player: Decodable {
    let id: Int?
    let firstName: String?
    let heightFeet: Int?
    let heightInches: Int?
    let lastName: String?
    let position: String?
    let team: Team?
    let weightPounds: Double?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
        case lastName = "last_name"
        case position, team
        case weightPounds = "weight_pounds"
    }
}
