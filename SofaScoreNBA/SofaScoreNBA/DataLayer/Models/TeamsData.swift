//
//  TeamsData.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 05.06.2022..
//

import Foundation

struct TeamsData: Decodable {
    let data: [Team]
}

struct Team: Decodable {
    
    let id: Int?
    let abbreviation: String
    let city: String?
    let conference: String?
    let fullname: String?
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, abbreviation, city, conference, name
        case fullname = "full_name"
    }
}
