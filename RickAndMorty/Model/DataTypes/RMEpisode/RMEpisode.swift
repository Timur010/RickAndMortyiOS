//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by timur on 15.01.2023.
//

import Foundation

struct RMEpisode {
    let id: Int
        let name, airDate, episode: String
        let characters: [String]
        let url: String
        let created: String

        enum CodingKeys: String, CodingKey {
            case id, name
            case airDate = "air_date"
            case episode, characters, url, created
        }
}
