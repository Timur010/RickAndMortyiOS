//
//  GetCharacters.swift
//  RickAndMorty
//
//  Created by timur on 08.02.2023.
//

import Foundation

struct RMGetAllCharacterResponse: Codable {
    
    let info: Info
    let results: [RMCharacter]
    
    // MARK: - Info
    struct Info: Codable {
        let count, pages: Int
        let next: String
        let prev: String?
    }
}
