//
//  Player.swift
//  Created by Ali Hassan on 16/12/2018.
//

import Foundation
import Foundation

struct Player: Decodable, Equatable {
    let firstName: String
    let lastName: String
    let fppg: Double?
    let id: String
    let playerImage: Image
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case playerImage = "images"
        case fppg
        case id
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
}

struct Image: Decodable {
    let image: Default
    
    enum CodingKeys: String, CodingKey {
        case image = "default"
    }
}

struct Default: Codable {
    let url: URL
}
