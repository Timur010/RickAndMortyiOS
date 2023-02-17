//
//  EpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by timur on 16.02.2023.
//

import UIKit

final class EpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "EpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public  func configure(with viewModel: EpisodeCollectionCellViewModel) {
        
    }
}
