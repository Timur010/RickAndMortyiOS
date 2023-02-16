//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by timur on 10.02.2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImage: URL?
    
    //MARK: - Init
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImage: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImage = characterImage
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    //MARK: получение изображения
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImage else {
            completion(.failure(URLError(.badURL)))
            return }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImage)
    }
}
