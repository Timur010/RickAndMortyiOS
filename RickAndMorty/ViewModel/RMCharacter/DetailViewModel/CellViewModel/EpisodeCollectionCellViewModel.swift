//
//  EpisodeCollectionCellViewModel.swift
//  RickAndMorty
//
//  Created by timur on 16.02.2023.
//

import Foundation

final class EpisodeCollectionCellViewModel {
    private let episodeDataUrl: URL?
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
}
