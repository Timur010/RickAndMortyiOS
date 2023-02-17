//
//  PhotoCollectionCellViewModel.swift
//  RickAndMorty
//
//  Created by timur on 16.02.2023.
//

import Foundation

final class PhotoCollectionCellViewModel {
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
