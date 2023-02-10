//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by timur on 10.02.2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
    
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
        return characterStatus.rawValue
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        //MARK: получение изображения
        guard let url = characterImage else {
            completion(.failure(URLError(.badURL)))
            return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
