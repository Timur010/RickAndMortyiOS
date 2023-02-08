//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by timur on 15.01.2023.
//

import Foundation

struct RMCharacter: Codable {
        let id: Int
        let name, species, type: String
        let status : String
        let gender: String
        let origin, location: RMSingleLocation
        let image: String
        let episode: [String]
        let url: String
        let created: String
}
