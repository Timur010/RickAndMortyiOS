//
//  InfoCollectionCellViewModel.swift
//  RickAndMorty
//
//  Created by timur on 16.02.2023.
//

import Foundation

final class InfoCollectionCellViewModel {
    public let value: String
    public let title: String
    
    init(value: String, title: String) {
        self.value = value
        self.title = title
    }
}
