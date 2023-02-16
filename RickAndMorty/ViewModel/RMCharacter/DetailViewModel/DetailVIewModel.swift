//
//  RMCharacterDetailViewVIewModel.swift
//  RickAndMorty
//
//  Created by timur on 13.02.2023.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    enum SectionType {
        case photo(viewModel: PhotoCollectionCellViewModel)
        case information(viewModels: [InfoCollectionCellViewModel])
        case episodes(viewModels: [EpisodeCollectionCellViewModel])
    }
    
    public var section: [SectionType] = []
    
    init (character: RMCharacter) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections() {
        section = [
            .photo(viewModel: .init()),
            .information(viewModels: [.init(), .init(), .init(), .init()]),
            .episodes(viewModels: [.init(), .init(), .init(), .init()])
        ]
    }
    
    private var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    //MARK: - layouts
    
    //MARK: - Photo
    public func createPhotoSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)) , subitems: [item])
        let selection = NSCollectionLayoutSection(group: group)

        return selection
    }
    //MARK: - infoSection
    public func createInformationSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)) , subitems: [item, item])
        let selection = NSCollectionLayoutSection(group: group)
        return selection
    }
    //MARK: - episodes
    public func createEpisodesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(150)) , subitems: [item])
        let selection = NSCollectionLayoutSection(group: group)
        selection.orthogonalScrollingBehavior = .groupPaging
        return selection
    }
}
