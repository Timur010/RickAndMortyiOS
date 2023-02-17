//
//  InfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by timur on 16.02.2023.
//

import UIKit

final class InfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "InfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public  func configure(with viewModel: InfoCollectionCellViewModel) {
        
    }
    
}
