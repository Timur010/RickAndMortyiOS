//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by timur on 19.01.2023.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}